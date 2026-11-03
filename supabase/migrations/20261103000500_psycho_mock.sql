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
