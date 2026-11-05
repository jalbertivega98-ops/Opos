-- =====================================================================
-- 1700 · Premium por oposición, temas gratis y packs de intentos (ADR-035)
--
--  * Premium por oposición: una suscripción (products.type = 'subscription')
--    con exam_body_id da acceso solo a lo «incluido en Premium» de ESA
--    oposición. Una suscripción a un producto sin oposición (el Premium
--    global antiguo) sigue dando acceso a todo, para no quitárselo a nadie.
--  * Temas gratis: un pack de preguntas con is_free y config.topic_slugs
--    reparte las preguntas PUBLICADAS de esos temas, también las que se
--    publiquen después (no hace falta rellenar product_items).
--  * Packs de intentos: un bundle con config.attempts = N da N intentos de
--    sus simulacros (hijos). Cada intento empezado cuenta; agotados, el
--    alumno deja de tener acceso por esa vía. Un bundle así NO da acceso
--    ilimitado a sus hijos como un pack normal.
-- =====================================================================

-- Intentos de simulacro que le quedan al alumno para un simulacro por packs de
-- intentos (0 si no tiene ninguno). Cuenta los intentos empezados en
-- cualquier simulacro del pack desde la primera compra vigente.
create or replace function public.mock_credits_left(p_product uuid, p_user uuid)
returns integer
language sql stable security definer set search_path = '' as $$
  select coalesce(max(greatest(c.total - c.used, 0)), 0)::int
    from (
      select b.id,
             sum((b.config->>'attempts')::int) as total,
             (select count(*) from public.mock_attempts a
               where a.user_id = p_user
                 and a.product_id in (select i2.child_product_id from public.product_items i2
                                       where i2.product_id = b.id and i2.child_product_id is not null)
                 and a.started_at >= min(g.created_at)) as used
        from public.products b
        join public.product_items i on i.product_id = b.id and i.child_product_id = p_product
        join public.access_grants g on g.product_id = b.id
       where b.type = 'bundle' and b.config ? 'attempts'
         and g.user_id = p_user and g.revoked_at is null
         and g.starts_at <= now() and (g.ends_at is null or g.ends_at > now())
       group by b.id
    ) c
$$;
revoke execute on function public.mock_credits_left(uuid, uuid) from public, anon, authenticated;
grant execute on function public.mock_credits_left(uuid, uuid) to service_role;

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

-- Preguntas jugables: además, las publicadas de los temas de config.topic_slugs
create or replace function public.product_question_ids(p_product uuid)
returns setof uuid
language sql stable security definer set search_path = '' as $$
  select distinct q.id
    from public.product_items pi
    left join public.product_items ci on ci.product_id = pi.child_product_id
    join public.questions q on q.id = coalesce(pi.question_id, ci.question_id)
   where pi.product_id = p_product and q.status = 'published'
  union
  select m.question_id from public.mock_pool(p_product) m
  union
  select q.id
    from public.products p
    cross join lateral jsonb_array_elements_text(
      case when jsonb_typeof(p.config->'topic_slugs') = 'array' then p.config->'topic_slugs'
           else '[]'::jsonb end) s(slug)
    join public.topics t on t.slug = s.slug
    join public.questions q on q.topic_id = t.id
   where p.id = p_product and q.status = 'published' and q.is_test = p.is_test
$$;
revoke execute on function public.product_question_ids(uuid) from public, anon, authenticated;
grant execute on function public.product_question_ids(uuid) to service_role;

-- Biblioteca: añade los productos gratis de las oposiciones que prepara el
-- alumno y, en los packs de intentos, los intentos que le quedan.
drop function if exists public.my_library();
create or replace function public.my_library()
returns table (product_id uuid, slug text, type public.product_type, title text, title_ca text,
               source text, ends_at timestamptz, is_test boolean, question_count bigint,
               attempts_left integer)
language sql stable security definer set search_path = '' as $$
  with me as (select auth.uid() as id)
  select p.id, p.slug, p.type, p.title, p.title_ca,
         coalesce(g.source::text, case when bg.product_id is not null then 'bundle'
                                       when p.is_free then 'free' else 'subscription' end),
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
   where me.id is not null and p.status = 'published' and p.type <> 'subscription'
     and public.has_product_access(p.id, me.id)
     and (g.source is not null or bg.product_id is not null
          or (p.is_free and exists (select 1 from public.user_exam_targets t
                                     where t.user_id = me.id and t.exam_body_id = p.exam_body_id))
          or exists (select 1 from public.subscriptions s
                       join public.products sp on sp.id = s.product_id
                      where s.user_id = me.id and s.status in ('active', 'trialing')
                        and (s.current_period_end is null or s.current_period_end > now())
                        and (sp.exam_body_id is null or sp.exam_body_id = p.exam_body_id)))
   order by p.is_free desc, p.type = 'bundle' desc, p.type, p.title
$$;
revoke execute on function public.my_library() from anon, public;
grant execute on function public.my_library() to authenticated;

-- Oferta pública: añade el Premium de la oposición y los temas gratis
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
  price_of as (
    select pr.product_id, jsonb_build_object('amount_cents', pr.amount_cents, 'currency', pr.currency,
                                             'interval', pr.billing_interval) as price,
           row_number() over (partition by pr.product_id order by pr.created_at desc) as rn
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
           (select po.price from price_of po where po.product_id = p.id and po.rn = 1
              and po.price->>'interval' is not null) as price
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
