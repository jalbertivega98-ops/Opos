-- =====================================================================
-- 48 · Test por tema desde el plan y calendario de estudio (ADR-036)
-- Copia de supabase/migrations/20261105000300_topic_practice_calendar.sql (el
-- flujo de la preview no aplica migraciones). Solo funciones: idempotente.
-- =====================================================================
begin;
-- Preguntas publicadas de un tema que el usuario puede practicar
create or replace function public.accessible_topic_questions(p_user uuid, p_topic uuid)
returns setof uuid
language sql stable security definer set search_path = '' as $$
  select distinct q.id
    from public.products p
    cross join lateral public.product_question_ids(p.id) pq(id)
    join public.questions q on q.id = pq.id
   where p.status = 'published' and p.is_test = false and p.type = 'question_pack'
     and (p.exam_body_id is null
          or p.exam_body_id in (select e.exam_body_id from public.exam_body_topics e
                                 where e.topic_id = p_topic))
     and q.topic_id = p_topic and q.status = 'published' and q.is_test = false
     and public.has_product_access(p.id, p_user)
$$;
revoke execute on function public.accessible_topic_questions(uuid, uuid) from public, anon, authenticated;
grant execute on function public.accessible_topic_questions(uuid, uuid) to service_role;

-- Test de un tema: preguntas al azar de las que el alumno tiene acceso
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
           'source', 'question', 'item_type', 'question', 'category', q.category,
           'difficulty', q.difficulty, 'question_id', q.id,
           'presented', public.question_presented(q.id)))
    into v_items
    from (select q.* from public.questions q
           where q.id in (select public.accessible_topic_questions(p_user, v_topic))
           order by random()
           limit least(greatest(coalesce(p_count, 10), 1), 50)) q;
  if v_items is null then
    raise exception 'Sin acceso a este tema' using errcode = '42501';
  end if;
  return public.practice_start(p_user, 'questions', 'question', v_items, v_exam);
end $$;
revoke execute on function public.practice_start_topic(uuid, text, int) from public, anon, authenticated;
grant execute on function public.practice_start_topic(uuid, text, int) to service_role;

-- Temas de una oposición que el alumno actual puede practicar
create or replace function public.my_open_topics(p_exam_slug text)
returns setof text
language sql stable security definer set search_path = '' as $$
  with u as (select auth.uid() as id),
  b as (select id from public.exam_bodies where slug = p_exam_slug),
  prods as (
    select p.id from public.products p, u
     where u.id is not null and p.status = 'published' and p.is_test = false
       and p.type = 'question_pack'
       and (p.exam_body_id is null or p.exam_body_id = (select id from b))
       and public.has_product_access(p.id, u.id)
  ),
  qs as (select distinct pq.id from prods cross join lateral public.product_question_ids(prods.id) pq(id))
  select distinct t.slug
    from qs
    join public.questions q on q.id = qs.id and q.status = 'published' and q.is_test = false
    join public.topics t on t.id = q.topic_id
    join public.exam_body_topics e on e.topic_id = t.id and e.exam_body_id = (select id from b)
$$;
revoke execute on function public.my_open_topics(text) from public, anon;
grant execute on function public.my_open_topics(text) to authenticated;

-- Calendario: prácticas y simulacros del alumno actual entre dos instantes
-- (máximo 92 días). Una práctica con preguntas de un solo tema lleva su tema.
create or replace function public.my_study_log(p_from timestamptz, p_to timestamptz)
returns table (kind text, id uuid, started_at timestamptz, finished_at timestamptz, status text,
               mode text, item_type text, answered int, correct int, total int,
               topic_slug text, topic_title text, topic_title_ca text,
               title text, title_ca text, mark numeric, max_mark numeric, passed boolean,
               mock_kind text)
language sql stable security definer set search_path = '' as $$
  with me as (select auth.uid() as id),
  r as (select p_from as f, least(p_to, p_from + interval '92 days') as t)
  select 'practice', s.id, s.started_at, s.finished_at, s.status::text, s.mode::text, s.item_type,
         s.answered_count::int, s.correct_count::int, s.item_count::int,
         case when tp.n = 1 then tp.slug end, case when tp.n = 1 then tp.title end,
         case when tp.n = 1 then tp.title_ca end,
         null, null, null::numeric, null::numeric, null::boolean, null
    from public.practice_sessions s
    cross join me cross join r
    left join lateral (
      select count(distinct t.id) as n, min(t.slug) as slug, min(t.title) as title,
             min(t.title_ca) as title_ca
        from public.practice_items i
        join public.questions q on q.id = i.question_id
        join public.topics t on t.id = q.topic_id
       where i.session_id = s.id
    ) tp on true
   where me.id is not null and s.user_id = me.id
     and s.started_at >= r.f and s.started_at < r.t
     and (s.answered_count > 0 or s.status = 'active')
  union all
  select 'mock', a.id, a.started_at, a.submitted_at, a.status::text, 'mock', null,
         (coalesce(a.correct_count, 0) + coalesce(a.wrong_count, 0))::int,
         coalesce(a.correct_count, 0)::int, a.item_count::int,
         null, null, null, a.title, a.title_ca, a.mark,
         coalesce((a.config->>'max_mark')::numeric, 10), a.passed,
         case when a.config->>'kind' = 'psycho' then 'psycho' else 'knowledge' end
    from public.mock_attempts a
    cross join me cross join r
   where me.id is not null and a.user_id = me.id
     and a.started_at >= r.f and a.started_at < r.t
   order by 3
$$;
revoke execute on function public.my_study_log(timestamptz, timestamptz) from public, anon;
grant execute on function public.my_study_log(timestamptz, timestamptz) to authenticated;

commit;
