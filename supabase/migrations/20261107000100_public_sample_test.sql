-- =====================================================================
-- 20261107000100 · Test gratis sin registro de cada oposición (ADR-041)
-- Página pública /oposiciones/<slug>/test: unas preguntas ya publicadas de los
-- temas gratis de la oposición (los de su pack gratuito, config.topic_slugs).
-- Se muestran sin la solución; se corrigen de una en una y no se guarda nada.
-- =====================================================================

-- Preguntas publicadas de los temas gratis de una oposición publicada.
create or replace function public.exam_free_question_ids(p_exam_slug text)
returns setof uuid
language sql stable security definer set search_path = '' as $$
  select distinct pq.id
    from public.exam_bodies b
    join public.products p on p.exam_body_id = b.id
    cross join lateral public.product_question_ids(p.id) pq(id)
    join public.questions q on q.id = pq.id
   where b.slug = p_exam_slug and b.is_published
     and p.is_free and p.status = 'published' and p.is_test = false and p.type = 'question_pack'
     and q.status = 'published' and q.is_test = false
$$;
revoke execute on function public.exam_free_question_ids(text) from public, anon, authenticated;

-- Muestra del día (cambia cada día y es estable durante el día, para que la
-- página sea cacheable). Sin respuesta correcta ni explicación.
create or replace function public.exam_sample_questions(p_exam_slug text, p_limit int default 10)
returns table (id uuid, stem text, options jsonb, ref text, locale text, topic_title text, topic_title_ca text)
language sql stable security definer set search_path = '' as $$
  select q.id, q.stem,
         (select jsonb_agg(o.body order by o.label)
            from public.question_options o where o.question_id = q.id),
         q.source_ref, q.locale::text, t.title, t.title_ca
    from public.questions q
    left join public.topics t on t.id = q.topic_id
   where q.id in (select public.exam_free_question_ids(p_exam_slug))
   order by md5(q.id::text || (now() at time zone 'Europe/Madrid')::date::text)
   limit least(greatest(coalesce(p_limit, 10), 1), 20)
$$;
revoke execute on function public.exam_sample_questions(text, int) from public;
grant execute on function public.exam_sample_questions(text, int) to anon, authenticated, service_role;

-- Corrige una respuesta (índice de opción, 0 = A). Solo preguntas de los temas
-- gratis de esa oposición; devuelve vacío en cualquier otro caso.
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
     and p_choice between 0 and 5
     and exists (select 1 from opts where idx = p_choice)
$$;
revoke execute on function public.check_exam_sample_answer(text, uuid, int) from public;
grant execute on function public.check_exam_sample_answer(text, uuid, int) to anon, authenticated, service_role;
