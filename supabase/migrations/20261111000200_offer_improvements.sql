-- =====================================================================
-- Mejoras de la oferta por oposición (11/11/2026, ADR-048)
--  * Primer simulacro gratis: cada alumno puede hacer UN simulacro de cada
--    oposición sin pagar (mock_trial_available). Mientras ese intento siga
--    activo lo puede retomar; al acabarlo, los simulacros vuelven a ir con
--    Premium o con un pack de intentos. Sale en «Simulacros» con source 'trial'.
--  * Plan anual: exam_offer da el precio mensual (price) y el anual
--    (price_year) del Premium de cada oposición.
--  * exam_offer ya no cuenta como «temas» los exámenes réplica (temas cuyo
--    slug lleva «examen»): la ficha decía 58 temas en Administrativo (54 reales)
--    y 23 en Mossos (21).
-- =====================================================================

-- ¿Puede el alumno empezar (o retomar) su simulacro gratis en este producto?
create or replace function public.mock_trial_available(p_product uuid, p_user uuid)
returns boolean
language sql stable security definer set search_path = '' as $$
  select p_user is not null and exists (
    select 1 from public.products p
     where p.id = p_product and p.type = 'mock_exam' and p.status = 'published'
       and p.is_test = false and p.exam_body_id is not null
       and not exists (
         select 1 from public.mock_attempts a
           join public.products ap on ap.id = a.product_id
          where a.user_id = p_user and ap.exam_body_id = p.exam_body_id
            and not (a.product_id = p.id and a.status = 'active')))
$$;
revoke execute on function public.mock_trial_available(uuid, uuid) from public, anon, authenticated;
grant execute on function public.mock_trial_available(uuid, uuid) to service_role;

create or replace function public.has_product_access(p_product uuid, p_user uuid default null)
returns boolean
language sql stable security definer set search_path = '' as $$
  with u as (select coalesce(p_user, auth.uid()) as id)
  select exists (
    select 1 from public.products p, u
    where p.id = p_product and p.status = 'published'
      and u.id is not null
      and (
        p.is_free
        -- concesión directa vigente
        or exists (select 1 from public.access_grants g
                    where g.user_id = u.id and g.product_id = p.id and g.revoked_at is null
                      and g.starts_at <= now() and (g.ends_at is null or g.ends_at > now()))
        -- incluido en un pack (bundle) concedido, salvo los packs de intentos
        or exists (select 1 from public.product_items i
                     join public.products bp on bp.id = i.product_id
                     join public.access_grants g on g.product_id = i.product_id
                    where i.child_product_id = p.id and g.user_id = u.id and g.revoked_at is null
                      and not (bp.config ? 'attempts')
                      and g.starts_at <= now() and (g.ends_at is null or g.ends_at > now()))
        -- pack de intentos con intentos disponibles
        or (p.type = 'mock_exam' and public.mock_credits_left(p.id, u.id) > 0)
        -- primer simulacro de la oposición, gratis
        or (p.type = 'mock_exam' and public.mock_trial_available(p.id, u.id))
        -- Premium activo de su oposición (o el Premium global antiguo)
        or (p.included_in_premium and exists (
              select 1 from public.subscriptions s
                join public.products sp on sp.id = s.product_id
               where s.user_id = u.id and s.status in ('active', 'trialing')
                 and (s.current_period_end is null or s.current_period_end > now())
                 and (sp.exam_body_id is null or sp.exam_body_id = p.exam_body_id)))
      )
  )
$$;
revoke execute on function public.has_product_access(uuid, uuid) from anon, public, authenticated;
grant execute on function public.has_product_access(uuid, uuid) to service_role;

-- Biblioteca: además, los simulacros de prueba gratis de las oposiciones que
-- prepara el alumno (source 'trial') mientras no haya usado su intento gratis.
drop function if exists public.my_library();
create or replace function public.my_library()
returns table (product_id uuid, slug text, type public.product_type, title text, title_ca text,
               source text, ends_at timestamptz, is_test boolean, question_count bigint,
               attempts_left integer)
language sql stable security definer set search_path = '' as $$
  with me as (select auth.uid() as id)
  select p.id, p.slug, p.type, p.title, p.title_ca,
         coalesce(g.source::text, case when bg.product_id is not null then 'bundle'
                                       when p.is_free then 'free'
                                       when sub.ok then 'subscription'
                                       else 'trial' end),
         coalesce(g.ends_at, bg.ends_at), p.is_test,
         (select count(*) from public.product_question_ids(p.id)),
         case when p.type = 'bundle' and p.config ? 'attempts' then (
           select coalesce(max(public.mock_credits_left(i.child_product_id, me.id)), 0)
             from public.product_items i where i.product_id = p.id and i.child_product_id is not null)
         end
    from public.products p
    cross join me
    left join lateral (
      select g.source, g.ends_at from public.access_grants g
       where g.user_id = me.id and g.product_id = p.id and g.revoked_at is null
         and g.starts_at <= now() and (g.ends_at is null or g.ends_at > now())
       order by g.created_at desc limit 1) g on true
    left join lateral (
      select i.product_id, g2.ends_at from public.product_items i
        join public.products bp on bp.id = i.product_id
        join public.access_grants g2 on g2.product_id = i.product_id
       where i.child_product_id = p.id and g2.user_id = me.id and g2.revoked_at is null
         and g2.starts_at <= now() and (g2.ends_at is null or g2.ends_at > now())
       order by bp.config ? 'attempts'
       limit 1) bg on true
    cross join lateral (
      select exists (select 1 from public.subscriptions s
                       join public.products sp on sp.id = s.product_id
                      where s.user_id = me.id and s.status in ('active', 'trialing')
                        and (s.current_period_end is null or s.current_period_end > now())
                        and (sp.exam_body_id is null or sp.exam_body_id = p.exam_body_id)) as ok) sub
   where me.id is not null and p.status = 'published' and p.type <> 'subscription'
     and public.has_product_access(p.id, me.id)
     and (g.source is not null or bg.product_id is not null or sub.ok
          or ((p.is_free or public.mock_trial_available(p.id, me.id))
              and exists (select 1 from public.user_exam_targets t
                           where t.user_id = me.id and t.exam_body_id = p.exam_body_id)))
   order by p.is_free desc, p.type = 'bundle' desc, p.type, p.title
$$;
revoke execute on function public.my_library() from anon, public;
grant execute on function public.my_library() to authenticated;

-- Oferta pública: precio mensual y anual del Premium; los exámenes réplica no
-- cuentan como temas.
create or replace function public.exam_offer(p_exam_slug text)
returns jsonb
language sql stable security definer set search_path = '' as $$
  with b as (select id from public.exam_bodies where slug = p_exam_slug and is_published),
  t as (
    select t.id, t.slug, t.title,
           (select count(*) from public.questions q
             where q.topic_id = t.id and q.status = 'published' and q.is_test = false) as n
      from public.topics t join public.exam_body_topics e on e.topic_id = t.id
     where e.exam_body_id = (select id from b) and t.slug not like '%examen%'
  ),
  price_of as (
    select pr.product_id, pr.billing_interval,
           jsonb_build_object('amount_cents', pr.amount_cents, 'currency', pr.currency,
                              'interval', pr.billing_interval) as price,
           row_number() over (partition by pr.product_id order by pr.created_at desc) as rn,
           row_number() over (partition by pr.product_id, pr.billing_interval
                              order by pr.created_at desc) as rn_interval
      from public.product_prices pr where pr.active
  ),
  p as (
    select p.id, p.slug, p.type, p.title, p.title_ca, p.description, p.description_ca,
           p.is_free, p.included_in_premium, p.config,
           (select count(*) from public.product_question_ids(p.id)) as questions,
           (select coalesce(jsonb_agg(c.slug order by c.type, c.title), '[]'::jsonb)
              from public.product_items i join public.products c on c.id = i.child_product_id
             where i.product_id = p.id and c.status = 'published') as includes,
           (select po.price from price_of po where po.product_id = p.id and po.rn = 1) as price
      from public.products p
     where p.exam_body_id = (select id from b) and p.status = 'published' and p.is_test = false
       and p.type in ('question_pack', 'mock_exam', 'bundle', 'pdf')
  ),
  prem as (
    select p.slug, p.title, p.title_ca,
           (select po.price from price_of po where po.product_id = p.id and po.rn_interval = 1
              and po.billing_interval = 'month') as price,
           (select po.price from price_of po where po.product_id = p.id and po.rn_interval = 1
              and po.billing_interval = 'year') as price_year
      from public.products p
     where p.exam_body_id = (select id from b) and p.type = 'subscription'
       and p.status = 'published' and p.is_test = false
     order by p.created_at desc limit 1
  )
  select case when not exists (select 1 from b) then null else jsonb_build_object(
    'topics', (select count(*) from t where n > 0),
    'questions', (select coalesce(sum(n), 0) from t),
    'topic_list', (select coalesce(jsonb_agg(jsonb_build_object('slug', slug, 'title', title, 'questions', n)
                                             order by slug), '[]'::jsonb) from t where n > 0),
    'products', (select coalesce(jsonb_agg(to_jsonb(p) - 'id' order by p.type = 'bundle' desc, p.type, p.slug),
                                 '[]'::jsonb) from p),
    'premium', (select to_jsonb(prem) from prem),
    'free_topics', (select coalesce(jsonb_agg(jsonb_build_object('slug', t.slug, 'title', t.title,
                                                                 'questions', t.n) order by s.ord), '[]'::jsonb)
                      from p cross join lateral jsonb_array_elements_text(
                             case when jsonb_typeof(p.config->'topic_slugs') = 'array'
                                  then p.config->'topic_slugs' else '[]'::jsonb end)
                             with ordinality s(slug, ord)
                      join t on t.slug = s.slug
                     where p.is_free and p.type = 'question_pack')
  ) end
$$;
revoke execute on function public.exam_offer(text) from public;
grant execute on function public.exam_offer(text) to anon, authenticated;
