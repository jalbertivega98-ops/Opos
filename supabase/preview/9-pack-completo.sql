-- Pack completo de Mossos (migraciones 20261103000500, 0600 y 0700).
-- Ejecutar después de 8. Idempotente.
--  * Simulacro de psicotécnicos: 80 ítems generados, 35 min, sin penalización, mínimo 5.
--  * Plan de estudio semanal (fecha objetivo del alumno y progreso por tema).
--  * «Mossos 2026 · Pack completo»: los 3 packs y los 2 simulacros en un solo producto.
--  * Ficha pública con lo que incluye (recuentos reales).
-- Todo queda en BORRADOR: sale publicado al pulsar «Aprobar y publicar todo».
begin;
-- =====================================================================
-- 1400 · Simulacro de psicotécnicos y pack completo
--
--  * Un mock_exam con config.kind = 'psycho' no sale del banco: el servidor
--    genera los ítems (generadores deterministas por semilla, ADR-012) y los
--    entrega a mock_start_generated junto con su solución.
--  * La solución se guarda en mock_attempt_keys, tabla SIN permisos para el
--    alumno (ni siquiera de lectura): solo la usa mock_submit al corregir y
--    copia la solución al ítem en ese momento.
--  * Formato Mossos 46/26 (aptitudes): 80 ítems, 35 min, sin penalización,
--    nota sobre 10, mínimo 5.
-- =====================================================================

alter table public.mock_attempt_items
  add column if not exists item_type text check (item_type ~ '^[a-z_]{2,40}$'),
  add column if not exists difficulty smallint check (difficulty between 1 and 5),
  add column if not exists seed bigint check (seed between 0 and 4294967295),
  add column if not exists generator_version smallint;

create table if not exists public.mock_attempt_keys (
  attempt_id uuid not null,
  position smallint not null,
  answer_index smallint not null check (answer_index between 0 and 5),
  explanation jsonb,
  primary key (attempt_id, position),
  foreign key (attempt_id, position)
    references public.mock_attempt_items (attempt_id, position) on delete cascade
);
alter table public.mock_attempt_keys enable row level security;
revoke all on public.mock_attempt_keys from anon, authenticated, public;

-- El formato incluye ahora el tipo de simulacro
create or replace function public.mock_config(p_config jsonb)
returns jsonb
language sql immutable set search_path = '' as $$
  select jsonb_build_object(
    'kind', case when p_config->>'kind' = 'psycho' then 'psycho' else 'questions' end,
    'questions', least(greatest(coalesce((p_config->>'questions')::int, 30), 1), 120),
    'minutes', least(greatest(coalesce((p_config->>'minutes')::int, 35), 1), 300),
    'penalty', least(greatest(coalesce((p_config->>'penalty')::numeric, 0.25), 0), 1),
    'pass_mark', coalesce((p_config->>'pass_mark')::numeric, 4),
    'max_mark', coalesce((p_config->>'max_mark')::numeric, 10),
    'topic_prefix', coalesce(p_config->>'topic_prefix', ''),
    'locale', p_config->>'locale')
$$;

-- Simulacro con ítems generados por el servidor (solo service_role).
-- p_items: [{item_type, difficulty, seed, generator_version, presented, answer_index, explanation}]
create or replace function public.mock_start_generated(p_user uuid, p_product uuid, p_items jsonb)
returns uuid
language plpgsql security definer set search_path = '' as $$
declare
  v_p public.products%rowtype;
  v_c jsonb;
  v_id uuid;
  v_status public.account_status;
begin
  select status into v_status from public.profiles where id = p_user;
  if v_status is distinct from 'active' then
    raise exception 'Cuenta no activa' using errcode = '42501';
  end if;
  if not public.has_product_access(p_product, p_user) then
    raise exception 'Sin acceso a este producto' using errcode = '42501';
  end if;
  select * into v_p from public.products where id = p_product;
  v_c := public.mock_config(v_p.config);
  if v_p.type <> 'mock_exam' or v_c->>'kind' <> 'psycho' then
    raise exception 'El producto no es un simulacro de psicotécnicos' using errcode = '22023';
  end if;

  select id into v_id from public.mock_attempts
   where user_id = p_user and product_id = p_product and status = 'active' and deadline > now()
   order by started_at desc limit 1;
  if v_id is not null then
    return v_id;
  end if;

  if jsonb_array_length(p_items) <> (v_c->>'questions')::int then
    raise exception 'Número de ítems no válido' using errcode = '22023';
  end if;

  insert into public.mock_attempts (user_id, product_id, title, title_ca, config, item_count, deadline)
  values (p_user, p_product, v_p.title, v_p.title_ca, v_c, (v_c->>'questions')::int,
          now() + make_interval(mins => (v_c->>'minutes')::int))
  returning id into v_id;

  insert into public.mock_attempt_items (attempt_id, position, user_id, item_type, difficulty, seed,
                                         generator_version, presented)
  select v_id, (e.ord - 1)::smallint, p_user, e.it->>'item_type', (e.it->>'difficulty')::smallint,
         (e.it->>'seed')::bigint, (e.it->>'generator_version')::smallint, e.it->'presented'
    from jsonb_array_elements(p_items) with ordinality as e(it, ord);

  insert into public.mock_attempt_keys (attempt_id, position, answer_index, explanation)
  select v_id, (e.ord - 1)::smallint, (e.it->>'answer_index')::smallint, e.it->'explanation'
    from jsonb_array_elements(p_items) with ordinality as e(it, ord);

  insert into public.activity_events (user_id, kind, metadata)
  values (p_user, 'mock.started', jsonb_build_object('attempt', v_id, 'product', p_product));
  update public.profiles set last_active_at = now() where id = p_user;
  return v_id;
end $$;
revoke execute on function public.mock_start_generated(uuid, uuid, jsonb) from public, anon, authenticated;
grant execute on function public.mock_start_generated(uuid, uuid, jsonb) to service_role;

create or replace function public.mock_start(p_user uuid, p_product uuid)
returns uuid
language plpgsql security definer set search_path = '' as $$
declare
  v_p public.products%rowtype;
  v_c jsonb;
  v_n int;
  v_id uuid;
  v_status public.account_status;
begin
  select status into v_status from public.profiles where id = p_user;
  if v_status is distinct from 'active' then
    raise exception 'Cuenta no activa' using errcode = '42501';
  end if;
  if not public.has_product_access(p_product, p_user) then
    raise exception 'Sin acceso a este producto' using errcode = '42501';
  end if;
  select * into v_p from public.products where id = p_product;
  if v_p.type <> 'mock_exam' then
    raise exception 'El producto no es un simulacro' using errcode = '22023';
  end if;
  v_c := public.mock_config(v_p.config);
  if v_c->>'kind' = 'psycho' then
    raise exception 'Este simulacro se genera en el servidor' using errcode = '22023';
  end if;

  select id into v_id from public.mock_attempts
   where user_id = p_user and product_id = p_product and status = 'active' and deadline > now()
   order by started_at desc limit 1;
  if v_id is not null then
    return v_id;
  end if;

  v_n := (v_c->>'questions')::int;
  if (select count(*) from public.mock_pool(p_product)) < v_n then
    raise exception 'El simulacro aún no tiene suficientes preguntas publicadas' using errcode = '22023';
  end if;

  insert into public.mock_attempts (user_id, product_id, title, title_ca, config, item_count, deadline)
  values (p_user, p_product, v_p.title, v_p.title_ca, v_c, v_n,
          now() + make_interval(mins => (v_c->>'minutes')::int))
  returning id into v_id;

  insert into public.mock_attempt_items (attempt_id, position, user_id, question_id, topic_slug, presented)
  select v_id, (row_number() over (order by random()) - 1)::smallint, p_user, s.question_id,
         s.topic_slug, public.question_presented(s.question_id)
    from (select r.question_id, r.topic_slug
            from (select m.*, row_number() over (partition by m.topic_slug order by random()) as rn
                    from public.mock_pool(p_product) m) r
           order by r.rn, random()
           limit v_n) s;

  insert into public.activity_events (user_id, kind, metadata)
  values (p_user, 'mock.started', jsonb_build_object('attempt', v_id, 'product', p_product));
  update public.profiles set last_active_at = now() where id = p_user;
  return v_id;
end $$;

-- Corrección: preguntas del banco (con anulación si cambiaron) o ítems generados (clave guardada)
create or replace function public.mock_submit(p_user uuid, p_attempt uuid)
returns table (correct smallint, wrong smallint, blank smallint, void smallint,
               score numeric, mark numeric, passed boolean)
language plpgsql security definer set search_path = '' as $$
declare
  a public.mock_attempts%rowtype;
  it record;
  v_ans smallint;
  v_expl jsonb;
  v_c int := 0; v_w int := 0; v_b int := 0; v_v int := 0;
  v_valid int;
  v_score numeric;
  v_mark numeric;
begin
  select * into a from public.mock_attempts where id = p_attempt for update;
  if not found or a.user_id <> p_user then
    raise exception 'Simulacro no encontrado' using errcode = '42501';
  end if;
  if a.status <> 'active' then
    return query select a.correct_count, a.wrong_count, a.blank_count, a.void_count,
                        a.score, a.mark, a.passed;
    return;
  end if;

  for it in select i.position, i.question_id, i.presented, i.chosen_index
              from public.mock_attempt_items i where i.attempt_id = p_attempt loop
    v_ans := null;
    v_expl := null;
    if it.question_id is null then
      select k.answer_index, k.explanation into v_ans, v_expl
        from public.mock_attempt_keys k where k.attempt_id = p_attempt and k.position = it.position;
    elsif exists (select 1 from public.questions q where q.id = it.question_id and q.status = 'published')
       and public.question_presented(it.question_id)->'options' is not distinct from it.presented->'options' then
      select (ascii(o.label) - 65)::smallint into v_ans
        from public.question_options o where o.question_id = it.question_id and o.is_correct;
      select jsonb_build_object('text', q.explanation, 'ref', q.source_ref) into v_expl
        from public.questions q where q.id = it.question_id;
    end if;
    if v_ans is null then
      v_v := v_v + 1;
    elsif it.chosen_index is null then
      v_b := v_b + 1;
    elsif it.chosen_index = v_ans then
      v_c := v_c + 1;
    else
      v_w := v_w + 1;
    end if;
    update public.mock_attempt_items i
       set answer_index = v_ans,
           is_correct = case when v_ans is null or it.chosen_index is null then null
                             else it.chosen_index = v_ans end,
           explanation = coalesce(v_expl, (select jsonb_build_object('text', q.explanation, 'ref', q.source_ref)
                                             from public.questions q where q.id = it.question_id))
     where i.attempt_id = p_attempt and i.position = it.position;
  end loop;

  v_valid := a.item_count - v_v;
  v_score := round(greatest(0, v_c - v_w * (a.config->>'penalty')::numeric), 2);
  v_mark := case when v_valid > 0
                 then round(v_score * (a.config->>'max_mark')::numeric / v_valid, 2) else 0 end;

  update public.mock_attempts
     set status = case when now() > a.deadline + interval '15 seconds'
                       then 'expired'::public.mock_status else 'submitted'::public.mock_status end,
         submitted_at = least(now(), a.deadline + interval '15 seconds'),
         correct_count = v_c, wrong_count = v_w, blank_count = v_b, void_count = v_v,
         score = v_score, mark = v_mark, passed = v_mark >= (a.config->>'pass_mark')::numeric
   where id = p_attempt;

  insert into public.activity_events (user_id, kind, metadata)
  values (p_user, 'mock.submitted', jsonb_build_object('attempt', p_attempt, 'mark', v_mark));
  update public.profiles set last_active_at = now() where id = p_user;

  return query select v_c::smallint, v_w::smallint, v_b::smallint, v_v::smallint, v_score, v_mark,
                      v_mark >= (a.config->>'pass_mark')::numeric;
end $$;

-- «Aprobar y publicar todo» publica también los productos marcados para salir
-- con el contenido (simulacro de psicotécnicos y pack completo).
create or replace function public.review_all_batch(p_include_flagged boolean default false)
returns jsonb
language plpgsql security invoker set search_path = '' as $$
declare
  v_slug text;
  v_published int := 0;
  v_products int := 0;
  v_p record;
begin
  if not public.is_owner() then
    raise exception 'Solo la persona titular puede aprobar o publicar por lotes' using errcode = '42501';
  end if;

  for v_slug in
    select distinct t.slug from public.topics t
      join public.questions q on q.topic_id = t.id
     where q.is_test = false and q.status in ('draft', 'needs_review', 'approved')
     order by t.slug
  loop
    perform public.review_topic_batch(v_slug, 'approved', p_include_flagged);
    v_published := v_published + public.review_topic_batch(v_slug, 'published', p_include_flagged);
  end loop;

  for v_p in
    select p.id, p.type, p.config from public.products p
     where p.status = 'draft' and p.is_test = false and p.config ? 'topic_prefix'
       and p.type in ('question_pack', 'mock_exam')
  loop
    if (v_p.type = 'question_pack'
          and exists (select 1 from public.product_items i
                        join public.questions q on q.id = i.question_id
                       where i.product_id = v_p.id and q.status = 'published'))
       or (v_p.type = 'mock_exam'
          and (select count(*) from public.questions q
                 join public.topics t on t.id = q.topic_id
                where q.status = 'published' and q.is_test = false
                  and t.slug like (v_p.config->>'topic_prefix') || '%'
                  and (v_p.config->>'locale' is null or q.locale::text = v_p.config->>'locale'))
              >= (public.mock_config(v_p.config)->>'questions')::int) then
      update public.products set status = 'published' where id = v_p.id;
      v_products := v_products + 1;
    end if;
  end loop;

  -- productos que salen junto al contenido (sin preguntas propias)
  with pub as (
    update public.products set status = 'published'
     where status = 'draft' and is_test = false and config->>'publish_with_content' = 'true'
    returning 1)
  select v_products + count(*) into v_products from pub;

  perform public.log_admin_action('content.publish_all', 'questions', null,
    jsonb_build_object('questions', v_published, 'products', v_products,
                       'include_flagged', p_include_flagged));
  return jsonb_build_object('questions', v_published, 'products', v_products);
end $$;

-- Recuento de productos en borrador que publicaría el botón (para mostrarlo)
create or replace function public.draft_content_products()
returns bigint
language sql stable security invoker set search_path = '' as $$
  select count(*) from public.products
   where status = 'draft' and is_test = false
     and (config ? 'topic_prefix' or config->>'publish_with_content' = 'true')
$$;
revoke execute on function public.draft_content_products() from anon, public;
grant execute on function public.draft_content_products() to authenticated;

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


-- Simulacro de psicotécnicos (aptitudes) con el formato oficial 46/26
insert into public.products (slug, type, status, title, title_ca, description, description_ca,
                             exam_body_id, is_free, included_in_premium, config)
select 'mossos-simulacre-aptituds-2026', 'mock_exam', 'draft',
       'Mossos · Simulacro de psicotécnicos (formato 2026)',
       'Mossos · Simulacre d''aptituds (format 2026)',
       '80 ejercicios de razonamiento abstracto, espacial, verbal, numérico y perceptivo, 35 minutos, sin penalización. Nota sobre 10; mínimo 5. Cada simulacro es distinto.',
       '80 exercicis de raonament abstracte, espacial, verbal, numèric i perceptiu, 35 minuts, sense penalització. Nota sobre 10; mínim 5. Cada simulacre és diferent.',
       b.id, false, true,
       '{"kind":"psycho","questions":80,"minutes":35,"penalty":0,"pass_mark":5,"max_mark":10,"publish_with_content":"true"}'::jsonb
  from public.exam_bodies b where b.slug = 'mossos-esquadra'
on conflict (slug) do nothing;

-- Pack completo: todo lo de Mossos en un solo producto (incluido en Premium)
insert into public.products (slug, type, status, title, title_ca, description, description_ca,
                             exam_body_id, is_free, included_in_premium, config)
select 'mossos-pack-complet-2026', 'bundle', 'draft',
       'Mossos 2026 · Pack completo',
       'Mossos 2026 · Paquet complet',
       'Todo para la 1.ª prueba: el temario completo de la Guia d''estudi en preguntas (àmbits A, B y C), simulacros ilimitados de conocimientos y de psicotécnicos con el formato oficial, repaso de errores y plan de estudio semanal.',
       'Tot per a la 1a prova: el temari complet de la Guia d''estudi en preguntes (àmbits A, B i C), simulacres il·limitats de coneixements i d''aptituds amb el format oficial, repàs d''errors i pla d''estudi setmanal.',
       b.id, false, true, '{"publish_with_content":"true"}'::jsonb
  from public.exam_bodies b where b.slug = 'mossos-esquadra'
on conflict (slug) do nothing;

insert into public.product_items (product_id, position, child_product_id)
select pk.id, row_number() over (order by c.type, c.slug), c.id
  from public.products pk
  join public.products c on c.slug in ('mossos-ambit-a-guia-2026', 'mossos-ambit-b-guia-2026',
                                       'mossos-ambit-c-guia-2026', 'mossos-simulacre-coneixements-2026',
                                       'mossos-simulacre-aptituds-2026')
 where pk.slug = 'mossos-pack-complet-2026'
on conflict do nothing;

commit;
