-- Copia de supabase/migrations/20261110000100_topic_practice_unseen_first.sql (ADR-045).
-- Test por tema: primero las preguntas no vistas, luego las falladas. Idempotente.
begin;
-- =====================================================================
-- Test por tema sin repeticiones (queja de una alumna de Prisiones de
-- Cataluña, 10/11/2026: «siempre salen las mismas»). Antes se sacaban
-- p_count preguntas al azar del tema; con unas 20 por tema, dos tests
-- seguidos compartían la mitad. Ahora el orden es:
--   1. preguntas del tema que el alumno nunca ha respondido (si dejó un
--      test a medias, las que no contestó siguen contando como nuevas);
--   2. las que falló la última vez que las respondió;
--   3. el resto, empezando por las que vio hace más tiempo.
-- Dentro de cada grupo, al azar. Así no se repite ninguna hasta agotar el
-- tema. Acceso y errores, igual que en 20261105000300.
-- =====================================================================

create index if not exists practice_items_user_question_idx
  on public.practice_items (user_id, question_id);

create or replace function public.practice_start_topic(p_user uuid, p_topic_slug text, p_count int)
returns uuid
language plpgsql security definer set search_path = '' as $$
declare
  v_topic uuid;
  v_exam uuid;
  v_items jsonb;
begin
  select t.id into v_topic from public.topics t where t.slug = p_topic_slug;
  if v_topic is null or not exists (
       select 1 from public.questions q
        where q.topic_id = v_topic and q.status = 'published' and q.is_test = false) then
    raise exception 'El tema no tiene preguntas publicadas' using errcode = '22023';
  end if;
  -- la oposición del alumno que incluye el tema (para sus estadísticas)
  select ut.exam_body_id into v_exam
    from public.user_exam_targets ut
    join public.exam_body_topics e on e.exam_body_id = ut.exam_body_id and e.topic_id = v_topic
   where ut.user_id = p_user
   order by ut.is_primary desc
   limit 1;
  select jsonb_agg(jsonb_build_object(
           'source', 'question', 'item_type', 'question', 'category', c.category,
           'difficulty', c.difficulty, 'question_id', c.id,
           'presented', public.question_presented(c.id)))
    into v_items
    from (select q.id, q.category, q.difficulty
            from public.questions q
            left join lateral (
              select max(i.answered_at) as last_seen,
                     (array_agg(i.is_correct order by i.answered_at desc))[1] as last_ok
                from public.practice_items i
               where i.user_id = p_user and i.question_id = q.id and i.answered_at is not null
            ) h on true
           where q.id in (select public.accessible_topic_questions(p_user, v_topic))
           order by case when h.last_seen is null then 0
                         when h.last_ok is false then 1
                         else 2 end,
                    h.last_seen nulls first,
                    random()
           limit least(greatest(coalesce(p_count, 10), 1), 50)) c;
  if v_items is null then
    raise exception 'Sin acceso a este tema' using errcode = '42501';
  end if;
  return public.practice_start(p_user, 'questions', 'question', v_items, v_exam);
end $$;
revoke execute on function public.practice_start_topic(uuid, text, int) from public, anon, authenticated;
grant execute on function public.practice_start_topic(uuid, text, int) to service_role;
commit;
