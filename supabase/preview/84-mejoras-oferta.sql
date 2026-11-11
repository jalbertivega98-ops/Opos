-- Copia de supabase/migrations/20261111000200_offer_improvements.sql (ADR-048) + datos:
-- simulacros de psicotécnicos de PN, GC, Guardia Urbana y Policía Local con su pack,
-- plan anual de Premium y packs de 10 simulacros sin réplicas fijas. Idempotente.
begin;
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

-- ---------------------------------------------------------------------
-- Simulacros de psicotécnicos (joel, 11/11/2026). Los ítems los genera el
-- servidor (generadores verificables): cada intento es distinto.
--  * Guardia Civil: formato oficial de la prueba de aptitudes intelectuales
--    (BOE-A-2026-9982, bases 7.3 y 7.6): 80 preguntas, 55 min, 4 opciones,
--    nota de 0 a 30, mínimo 12; los errores restan (A − E/(N−1)).
--  * Policía Nacional, Guardia Urbana y Policía Local: sus bases piden test de
--    aptitudes (verbal, numérica, espacial, abstracta) pero no publican ni el
--    número de preguntas ni el tiempo. Formato ORIENTATIVO, y así se dice:
--    60 ejercicios en 30 minutos, sin penalización. Guardia Urbana puntúa de 0
--    a 21 con mínimo 10,50 (base 4.2); el resto, de 0 a 10 con mínimo 5.
-- ---------------------------------------------------------------------
insert into public.products (slug, type, status, title, title_ca, description, description_ca,
                             exam_body_id, is_free, included_in_premium, config, published_at)
select v.slug, 'mock_exam', 'published', v.title, v.title_ca, v.descr, v.descr_ca,
       b.id, false, true, v.config::jsonb, now()
  from (values
    ('guardia-civil-cabos-guardias', 'gc-simulacro-aptitudes-2026',
     'Guardia Civil · Simulacro de aptitudes intelectuales (formato 2026)',
     'Guàrdia Civil · Simulacre d''aptituds intel·lectuals (format 2026)',
     '80 ejercicios de razonamiento verbal, numérico, abstracto y espacial y de atención en 55 minutos, como la prueba oficial. Cada error resta 1/3. Nota de 0 a 30; mínimo 12. Cada simulacro es distinto.',
     '80 exercicis de raonament verbal, numèric, abstracte i espacial i d''atenció en 55 minuts, com la prova oficial. Cada error resta 1/3. Nota de 0 a 30; mínim 12. Cada simulacre és diferent.',
     '{"kind":"psycho","questions":80,"minutes":55,"penalty":0.3333,"pass_mark":12,"max_mark":30,"locale":"es"}'),
    ('policia-nacional-basica', 'pn-simulacro-aptitudes-2026',
     'Policía Nacional · Simulacro de psicotécnicos (formato orientativo)',
     'Policia Nacional · Simulacre de psicotècnics (format orientatiu)',
     '60 ejercicios de razonamiento verbal, numérico, abstracto y espacial y de atención en 30 minutos, sin penalización. La convocatoria no publica el número de preguntas ni el tiempo: es un formato orientativo para entrenar. Nota sobre 10. Cada simulacro es distinto.',
     '60 exercicis de raonament verbal, numèric, abstracte i espacial i d''atenció en 30 minuts, sense penalització. La convocatòria no publica el nombre de preguntes ni el temps: és un format orientatiu per entrenar. Nota sobre 10. Cada simulacre és diferent.',
     '{"kind":"psycho","questions":60,"minutes":30,"penalty":0,"pass_mark":5,"max_mark":10,"locale":"es","orientative":true}'),
    ('guardia-urbana-barcelona', 'gub-simulacre-aptituds-2026',
     'Guardia Urbana · Simulacro de tests aptitudinales (formato orientativo)',
     'Guàrdia Urbana · Simulacre de tests aptitudinals (format orientatiu)',
     '60 ejercicios de razonamiento verbal, numérico, abstracto y espacial y de atención en 30 minutos, sin penalización. Las bases no publican el número de preguntas ni el tiempo: es un formato orientativo. Nota de 0 a 21 como la 2.ª prueba; mínimo 10,50. Cada simulacro es distinto.',
     '60 exercicis de raonament verbal, numèric, abstracte i espacial i d''atenció en 30 minuts, sense penalització. Les bases no publiquen el nombre de preguntes ni el temps: és un format orientatiu. Nota de 0 a 21 com la 2a prova; mínim 10,50. Cada simulacre és diferent.',
     '{"kind":"psycho","questions":60,"minutes":30,"penalty":0,"pass_mark":10.5,"max_mark":21,"locale":"ca","orientative":true}'),
    ('policia-local', 'plcat-simulacre-aptituds-2026',
     'Policía local · Simulacro de psicotécnicos (formato orientativo)',
     'Policia local · Simulacre de psicotècnics (format orientatiu)',
     '60 ejercicios de razonamiento verbal, numérico, abstracto y espacial y de atención en 30 minutos, sin penalización. Las bases de cada ayuntamiento no publican el número de preguntas ni el tiempo: es un formato orientativo. Nota sobre 10; mínimo 5. Cada simulacro es distinto.',
     '60 exercicis de raonament verbal, numèric, abstracte i espacial i d''atenció en 30 minuts, sense penalització. Les bases de cada ajuntament no publiquen el nombre de preguntes ni el temps: és un format orientatiu. Nota sobre 10; mínim 5. Cada simulacre és diferent.',
     '{"kind":"psycho","questions":60,"minutes":30,"penalty":0,"pass_mark":5,"max_mark":10,"locale":"ca","orientative":true}')
  ) v(exam, slug, title, title_ca, descr, descr_ca, config)
  join public.exam_bodies b on b.slug = v.exam
on conflict (slug) do nothing;

-- Pack de 10 simulacros de psicotécnicos (6,99 €) de esas cuatro oposiciones
insert into public.products (slug, type, status, title, title_ca, description, description_ca,
                             exam_body_id, is_free, included_in_premium, config, published_at)
select v.pfx || '-10-psicotecnicos', 'bundle', 'published',
       b.name || ' · 10 simulacros de psicotécnicos',
       coalesce(b.name_ca, b.name) || ' · 10 simulacres de psicotècnics',
       '10 intentos del simulacro de psicotécnicos. Cada intento es distinto.',
       '10 intents del simulacre de psicotècnics. Cada intent és diferent.',
       b.id, false, false, '{"attempts":10}'::jsonb, now()
  from (values ('guardia-civil-cabos-guardias', 'gc'), ('policia-nacional-basica', 'pn'),
               ('guardia-urbana-barcelona', 'gub'), ('policia-local', 'plcat')) v(exam, pfx)
  join public.exam_bodies b on b.slug = v.exam
on conflict (slug) do nothing;

insert into public.product_items (product_id, position, child_product_id)
select p.id, 1, c.id
  from (values ('gc-10-psicotecnicos', 'gc-simulacro-aptitudes-2026'),
               ('pn-10-psicotecnicos', 'pn-simulacro-aptitudes-2026'),
               ('gub-10-psicotecnicos', 'gub-simulacre-aptituds-2026'),
               ('plcat-10-psicotecnicos', 'plcat-simulacre-aptituds-2026')) v(pack, mock)
  join public.products p on p.slug = v.pack
  join public.products c on c.slug = v.mock
on conflict do nothing;

-- Y en el pack completo de su oposición (lo que enseña la ficha como «Premium»)
insert into public.product_items (product_id, position, child_product_id)
select p.id, coalesce((select max(position) from public.product_items x where x.product_id = p.id), 0) + 1,
       c.id
  from (values ('gc-pack-completo-2026', 'gc-simulacro-aptitudes-2026'),
               ('pn-pack-completo-2026', 'pn-simulacro-aptitudes-2026')) v(pack, mock)
  join public.products p on p.slug = v.pack
  join public.products c on c.slug = v.mock
on conflict do nothing;

insert into public.product_prices (product_id, amount_cents, billing_interval)
select p.id, 699, null
  from public.products p
 where p.slug in ('gc-10-psicotecnicos', 'pn-10-psicotecnicos', 'gub-10-psicotecnicos',
                  'plcat-10-psicotecnicos')
   and not exists (select 1 from public.product_prices x where x.product_id = p.id and x.active)
on conflict do nothing;

-- ---------------------------------------------------------------------
-- Plan anual del Premium de cada oposición: 79,99 € al año (6,67 € al mes,
-- casi la mitad que 12 meses a 12,99 €). Se cobra desde aquí (price_data).
-- ---------------------------------------------------------------------
insert into public.product_prices (product_id, amount_cents, billing_interval)
select p.id, 7999, 'year'
  from public.products p
 where p.type = 'subscription' and p.status = 'published' and p.is_test = false
   and p.exam_body_id is not null
   and not exists (select 1 from public.product_prices x
                    where x.product_id = p.id and x.active and x.billing_interval = 'year')
on conflict do nothing;

-- ---------------------------------------------------------------------
-- Packs de 10 simulacros: solo simulacros que cambian de preguntas en cada
-- intento. Las réplicas de exámenes reales (slug con «-examen-») son siempre
-- las mismas preguntas: siguen en Premium. Solo se quitan si el pack conserva
-- al menos un simulacro que cambia.
-- ---------------------------------------------------------------------
delete from public.product_items i
 using public.products b, public.products c
 where i.product_id = b.id and i.child_product_id = c.id
   and b.slug like '%-10-simulacros' and c.slug like '%-examen-%'
   and exists (select 1 from public.product_items i2
                 join public.products c2 on c2.id = i2.child_product_id
                where i2.product_id = b.id and c2.slug not like '%-examen-%'
                  and c2.status = 'published');

update public.products
   set description = '10 intentos de simulacro con el formato oficial; cada intento saca preguntas distintas. Los exámenes réplica están en Premium.',
       description_ca = '10 intents de simulacre amb el format oficial; cada intent treu preguntes diferents. Els exàmens rèplica són a Premium.'
 where slug like '%-10-simulacros' and type = 'bundle' and config ? 'attempts';

commit;
