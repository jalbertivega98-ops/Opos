-- Plan de estudio (USR-004): fecha objetivo del alumno y progreso real por tema.

alter table public.user_exam_targets
  add column if not exists target_date date;

-- Temas de una oposición con preguntas publicadas y el progreso del alumno actual
-- (práctica y simulacros corregidos). security definer porque el alumno no puede
-- leer el banco de preguntas; solo devuelve recuentos y filtra por auth.uid().
create or replace function public.my_topic_progress(p_exam_slug text)
returns table (slug text, title text, published bigint, answered bigint, correct bigint)
language sql stable security definer set search_path = '' as $$
  with mine as (
    select i.question_id, i.is_correct from public.practice_items i
     where i.user_id = auth.uid() and i.question_id is not null and i.is_correct is not null
    union all
    select m.question_id, m.is_correct from public.mock_attempt_items m
     where m.user_id = auth.uid() and m.question_id is not null and m.is_correct is not null
  )
  select t.slug, t.title,
         (select count(*) from public.questions q where q.topic_id = t.id and q.status = 'published'
            and q.is_test = false),
         count(m.question_id), count(*) filter (where m.is_correct)
    from public.exam_bodies b
    join public.exam_body_topics ebt on ebt.exam_body_id = b.id
    join public.topics t on t.id = ebt.topic_id
    left join public.questions q on q.topic_id = t.id
    left join mine m on m.question_id = q.id
   where b.slug = p_exam_slug
   group by t.id, t.slug, t.title
  having (select count(*) from public.questions q where q.topic_id = t.id and q.status = 'published'
            and q.is_test = false) > 0
   order by t.slug
$$;
revoke execute on function public.my_topic_progress(text) from anon, public;
grant execute on function public.my_topic_progress(text) to authenticated;
