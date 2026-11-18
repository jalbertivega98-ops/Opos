-- Dejar preguntas en blanco en los tests de práctica y en el test gratis (ADR-066).
--
-- En la práctica (corrección inmediata) una pregunta en blanco se guarda con
-- chosen_index = null e is_correct = false: no suma acierto, se cuenta aparte
-- como «en blanco» en el resultado y entra en el repaso de fallos (no se supo).
-- La restricción (answered_at is null) = (is_correct is null) se mantiene.
-- En los simulacros ya se podía dejar en blanco (is_correct = null, no penaliza).

create or replace function public.practice_answer_question(
  p_user uuid, p_session uuid, p_position smallint, p_chosen smallint
) returns table (finished boolean, is_correct boolean, answer_index smallint, explanation jsonb)
language plpgsql security definer set search_path = '' as $$
declare
  v_item public.practice_items%rowtype;
  v_answer smallint;
  v_expl jsonb;
  v_n int;
  v_fin boolean;
  v_ok boolean;
begin
  select * into v_item from public.practice_items
   where session_id = p_session and position = p_position and user_id = p_user;
  if not found or v_item.source <> 'question' or v_item.question_id is null then
    raise exception 'Ítem no encontrado' using errcode = '42501';
  end if;
  -- la pregunta debe seguir publicada y con las mismas opciones que se mostraron
  if not exists (select 1 from public.questions where id = v_item.question_id and status = 'published')
     or public.question_presented(v_item.question_id)->'options' is distinct from v_item.presented->'options' then
    raise exception 'La pregunta ha cambiado' using errcode = '22023';
  end if;
  select count(*) into v_n from public.question_options where question_id = v_item.question_id;
  -- null = en blanco
  if p_chosen is not null and (p_chosen < 0 or p_chosen >= v_n) then
    raise exception 'Opción no válida' using errcode = '22023';
  end if;
  select (ascii(o.label) - 65)::smallint into v_answer
    from public.question_options o where o.question_id = v_item.question_id and o.is_correct;
  select jsonb_build_object('text', q.explanation, 'ref', q.source_ref) into v_expl
    from public.questions q where q.id = v_item.question_id;

  v_ok := coalesce(p_chosen = v_answer, false);
  select r.finished into v_fin
    from public.practice_record_answer(p_user, p_session, p_position, p_chosen,
                                       v_ok, v_answer, v_expl) r;
  return query select v_fin, v_ok, v_answer, v_expl;
end $$;
revoke execute on function public.practice_answer_question(uuid, uuid, smallint, smallint)
  from public, anon, authenticated;
grant execute on function public.practice_answer_question(uuid, uuid, smallint, smallint) to service_role;

-- Test gratis sin registro: p_choice = null devuelve la solución como «en blanco».
create or replace function public.check_exam_sample_answer(p_exam_slug text, p_question uuid, p_choice int)
returns table (is_correct boolean, answer_index int, explanation jsonb)
language sql stable security definer set search_path = '' as $$
  with opts as (
    select o.is_correct, (row_number() over (order by o.label) - 1)::int as idx
      from public.question_options o
     where o.question_id = p_question
  )
  select exists (select 1 from opts where idx = p_choice and opts.is_correct),
         (select idx from opts where opts.is_correct limit 1),
         jsonb_build_object('text', q.explanation, 'ref', q.source_ref)
    from public.questions q
   where q.id = p_question
     and q.id in (select public.exam_free_question_ids(p_exam_slug))
     and (p_choice is null
          or (p_choice between 0 and 5 and exists (select 1 from opts where idx = p_choice)))
$$;
