-- =====================================================================
-- 1600 · Pack completo y oferta pública
--
--  * Biblioteca: los productos incluidos en un pack combinado (bundle)
--    concedido aparecen también, con origen «bundle». Así basta con dar
--    acceso al «Pack completo» para que el alumno vea packs y simulacros.
--  * exam_offer(): lo que incluye la preparación de una oposición, con
--    recuentos REALES (solo contenido publicado), para la ficha pública.
--    Solo devuelve agregados; nunca preguntas ni soluciones.
-- =====================================================================

drop function if exists public.my_library();
create or replace function public.my_library()
returns table (product_id uuid, slug text, type public.product_type, title text, title_ca text,
               source text, ends_at timestamptz, is_test boolean, question_count bigint)
language sql stable security definer set search_path = '' as $$
  with me as (select auth.uid() as id)
  select p.id, p.slug, p.type, p.title, p.title_ca,
         coalesce(g.source::text, case when bg.product_id is not null then 'bundle'
                                       when p.is_free then 'free' else 'subscription' end),
         coalesce(g.ends_at, bg.ends_at), p.is_test,
         (select count(*) from public.product_question_ids(p.id))
    from public.products p
    cross join me
    left join lateral (
      select g.source, g.ends_at from public.access_grants g
       where g.user_id = me.id and g.product_id = p.id and g.revoked_at is null
         and g.starts_at <= now() and (g.ends_at is null or g.ends_at > now())
       order by g.created_at desc limit 1) g on true
    left join lateral (
      select i.product_id, g2.ends_at from public.product_items i
        join public.access_grants g2 on g2.product_id = i.product_id
       where i.child_product_id = p.id and g2.user_id = me.id and g2.revoked_at is null
         and g2.starts_at <= now() and (g2.ends_at is null or g2.ends_at > now())
       limit 1) bg on true
   where me.id is not null and p.status = 'published' and p.type <> 'subscription'
     and public.has_product_access(p.id, me.id)
     and (g.source is not null or bg.product_id is not null
          or exists (select 1 from public.subscriptions s where s.user_id = me.id
                       and s.status in ('active', 'trialing')
                       and (s.current_period_end is null or s.current_period_end > now())))
   order by p.type = 'bundle' desc, p.type, p.title
$$;
revoke execute on function public.my_library() from anon, public;
grant execute on function public.my_library() to authenticated;

-- Oferta pública de una oposición (solo agregados de contenido publicado)
create or replace function public.exam_offer(p_exam_slug text)
returns jsonb
language sql stable security definer set search_path = '' as $$
  with b as (select id from public.exam_bodies where slug = p_exam_slug and is_published),
  t as (
    select t.id, t.slug, t.title,
           (select count(*) from public.questions q
             where q.topic_id = t.id and q.status = 'published' and q.is_test = false) as n
      from public.topics t join public.exam_body_topics e on e.topic_id = t.id
     where e.exam_body_id = (select id from b)
  ),
  p as (
    select p.id, p.slug, p.type, p.title, p.title_ca, p.description, p.description_ca,
           p.is_free, p.included_in_premium, p.config,
           (select count(*) from public.product_question_ids(p.id)) as questions,
           (select coalesce(jsonb_agg(c.slug order by c.type, c.title), '[]'::jsonb)
              from public.product_items i join public.products c on c.id = i.child_product_id
             where i.product_id = p.id and c.status = 'published') as includes,
           (select jsonb_build_object('amount_cents', pr.amount_cents, 'currency', pr.currency,
                                      'interval', pr.billing_interval)
              from public.product_prices pr where pr.product_id = p.id and pr.active
             order by pr.created_at desc limit 1) as price
      from public.products p
     where p.exam_body_id = (select id from b) and p.status = 'published' and p.is_test = false
       and p.type in ('question_pack', 'mock_exam', 'bundle', 'pdf')
  )
  select case when not exists (select 1 from b) then null else jsonb_build_object(
    'topics', (select count(*) from t where n > 0),
    'questions', (select coalesce(sum(n), 0) from t),
    'topic_list', (select coalesce(jsonb_agg(jsonb_build_object('slug', slug, 'title', title, 'questions', n)
                                             order by slug), '[]'::jsonb) from t where n > 0),
    'products', (select coalesce(jsonb_agg(to_jsonb(p) - 'id' order by p.type = 'bundle' desc, p.type, p.slug),
                                 '[]'::jsonb) from p)
  ) end
$$;
revoke execute on function public.exam_offer(text) from public;
grant execute on function public.exam_offer(text) to anon, authenticated;
