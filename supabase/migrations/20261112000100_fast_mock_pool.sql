-- =====================================================================
-- mock_pool rápido (12/11/2026, ADR-051)
-- La versión anterior calculaba mock_config(p.config) dentro del JOIN, y
-- Postgres la volvía a evaluar por cada tema y pregunta candidata (mock_config
-- llama varias veces a mock_parts y mock_quotas). Con ~13.000 preguntas un
-- simulacro de 920 preguntas tardaba 1,5 s, y exam_offer y my_library, que
-- cuentan las preguntas de cada producto, pasaban de 3 s: en producción la
-- consulta del visitante sin sesión se cortaba (statement_timeout) y la ficha
-- de 11 de las 12 oposiciones salía sin oferta ni precio.
-- Ahora la configuración se calcula una sola vez (CTE materializada). El
-- resultado es idéntico (comprobado producto a producto: 13.717 filas).
-- =====================================================================
create or replace function public.mock_pool(p_product uuid)
returns table (question_id uuid, topic_slug text)
language sql stable security definer set search_path = '' as $$
  with cfg as materialized (
    select p.is_test, public.mock_config(p.config) as c
      from public.products p
     where p.id = p_product and p.type = 'mock_exam'
  ),
  k as materialized (
    select is_test, c->>'topic_prefix' as prefix, c->>'locale' as loc from cfg
  )
  select q.id, t.slug
    from k
    join public.topics t on k.prefix <> '' and t.slug like k.prefix || '%'
    join public.questions q on q.topic_id = t.id
   where q.status = 'published' and q.is_test = k.is_test
     and (k.loc is null or q.locale::text = k.loc)
$$;
revoke execute on function public.mock_pool(uuid) from public, anon, authenticated;
grant execute on function public.mock_pool(uuid) to service_role;
