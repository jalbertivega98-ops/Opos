-- Aprobación por lotes (DEC-006): la persona titular aprueba o publica de una vez
-- las preguntas de un tema. Cada pregunta sigue pasando por el guardián de estados
-- (tg_question_status_guard), así que se validan opciones/explicación y queda
-- auditoría en question_reviews. Las preguntas con nota de revisión (dudosas) se
-- excluyen salvo que se pidan expresamente. Nada se publica sin esta llamada.

create or replace function public.review_topic_batch(
  p_topic_slug text,
  p_to public.content_status,
  p_include_flagged boolean default false
)
returns integer
language plpgsql security invoker set search_path = '' as $$
declare
  v_topic uuid;
  v_q record;
  v_done integer := 0;
begin
  if not public.is_owner() then
    raise exception 'Solo la persona titular puede aprobar o publicar por lotes' using errcode = '42501';
  end if;
  if p_to not in ('approved', 'published') then
    raise exception 'Destino de lote no permitido: %', p_to using errcode = '22023';
  end if;
  select id into v_topic from public.topics where slug = p_topic_slug;
  if v_topic is null then
    raise exception 'Tema no encontrado' using errcode = '22023';
  end if;

  perform set_config('app.review_comment', 'Lote: ' || p_topic_slug, true);
  for v_q in
    select id, status from public.questions
     where topic_id = v_topic
       and is_test = false
       and (p_include_flagged or review_note is null)
       and status = any (case when p_to = 'approved'
                              then array['draft', 'needs_review']::public.content_status[]
                              else array['approved']::public.content_status[] end)
     order by created_at
     for update
  loop
    if v_q.status = 'draft' then
      update public.questions set status = 'needs_review' where id = v_q.id;
    end if;
    update public.questions set status = p_to where id = v_q.id;
    v_done := v_done + 1;
  end loop;
  perform set_config('app.review_comment', '', true);

  if v_done > 0 then
    perform public.log_admin_action(
      'questions.batch_' || p_to::text, 'topics', v_topic::text,
      jsonb_build_object('topic', p_topic_slug, 'count', v_done, 'include_flagged', p_include_flagged)
    );
  end if;
  return v_done;
end $$;
revoke execute on function public.review_topic_batch(text, public.content_status, boolean) from anon, public;
grant execute on function public.review_topic_batch(text, public.content_status, boolean) to authenticated;

-- Recuento por estado de un tema (para el panel de lotes)
create or replace function public.topic_status_counts(p_topic_slug text)
returns table (status public.content_status, flagged boolean, total bigint)
language sql stable security invoker set search_path = '' as $$
  select q.status, q.review_note is not null, count(*)
    from public.questions q join public.topics t on t.id = q.topic_id
   where t.slug = p_topic_slug and q.is_test = false
   group by 1, 2
$$;
revoke execute on function public.topic_status_counts(text) from anon, public;
grant execute on function public.topic_status_counts(text) to authenticated;

-- Al publicar un lote, sus preguntas se añaden a los packs cuyo config.topic_prefix
-- encaja con el tema (p. ej. 'mossos-a' para el Àmbit A). Así el pack crece solo.
create or replace function public.tg_questions_autopack()
returns trigger language plpgsql security definer set search_path = '' as $$
declare
  v_slug text;
begin
  if new.status = 'published' and old.status is distinct from 'published' and new.topic_id is not null then
    select slug into v_slug from public.topics where id = new.topic_id;
    insert into public.product_items (product_id, position, question_id)
    select p.id,
           coalesce((select max(position) from public.product_items where product_id = p.id), 0) + 1,
           new.id
      from public.products p
     where p.type = 'question_pack' and p.config ? 'topic_prefix'
       and v_slug like (p.config->>'topic_prefix') || '%'
       and p.is_test = new.is_test
    on conflict do nothing;
  end if;
  return null;
end $$;
drop trigger if exists questions_autopack on public.questions;
create trigger questions_autopack after update of status on public.questions
  for each row execute function public.tg_questions_autopack();
