-- =====================================================================
-- 1500 · Simulacro por partes (ejercicio único de la AGE)
--
--  * Un mock_exam con config.kind = 'sections' junta varias partes en un solo
--    examen con un único tiempo, como el ejercicio único de Auxiliar del Estado
--    (parte 1 = 30 de Bloque I + 30 psicotécnicas; parte 2 = 50 de Bloque II;
--    90 minutos; cada error resta 1/3).
--  * config.parts: [{part, questions, topic_prefix} | {part, questions, psycho: true,
--    item_types}] en el orden del cuadernillo. config.cutoffs: {"1": 29, "2": 21.33},
--    puntuación directa mínima de cada parte (la del último examen publicado).
--  * Corrección por partes: directa = aciertos − errores × penalización; la
--    calificación de cada parte va de 0 a 50 (25 en el corte, 50 con la máxima,
--    lineal entre medias, como la fórmula de transformación del INAP; por
--    debajo del corte, proporcional de 0 a 25). Nota = suma (0-100). Se supera
--    si todas las partes alcanzan su corte.
--  * Las preguntas del banco las elige la base de datos; los psicotécnicos los
--    genera el servidor (mismo esquema que mock_start_generated).
-- =====================================================================

alter table public.mock_attempt_items
  add column if not exists part smallint check (part between 1 and 9);

alter table public.mock_attempts
  add column if not exists part_results jsonb;

-- Partes saneadas (o null si el producto no es por partes)
create or replace function public.mock_parts(p_config jsonb)
returns jsonb
language sql immutable set search_path = '' as $$
  select case
    when p_config->>'kind' = 'sections' and jsonb_typeof(p_config->'parts') = 'array'
     and jsonb_array_length(p_config->'parts') between 1 and 9 then (
      select jsonb_agg(jsonb_build_object(
               'part', least(greatest(coalesce((e->>'part')::int, 1), 1), 9),
               'questions', least(greatest(coalesce((e->>'questions')::int, 1), 1), 120),
               'psycho', coalesce((e->>'psycho')::boolean, false),
               'topic_prefix', coalesce(e->>'topic_prefix', ''))
             order by ord)
        from jsonb_array_elements(p_config->'parts') with ordinality as x(e, ord))
    else null end
$$;

create or replace function public.mock_config(p_config jsonb)
returns jsonb
language sql immutable set search_path = '' as $$
  select jsonb_build_object(
    'kind', case when p_config->>'kind' = 'psycho' then 'psycho'
                 when public.mock_parts(p_config) is not null then 'sections'
                 else 'questions' end,
    'questions', least(greatest(coalesce(
                   (select sum((e->>'questions')::int)::int
                      from jsonb_array_elements(public.mock_parts(p_config)) e),
                   (p_config->>'questions')::int, 30), 1), 120),
    'minutes', least(greatest(coalesce((p_config->>'minutes')::int, 35), 1), 300),
    'penalty', least(greatest(coalesce((p_config->>'penalty')::numeric, 0.25), 0), 1),
    'pass_mark', coalesce((p_config->>'pass_mark')::numeric, 4),
    'max_mark', coalesce((p_config->>'max_mark')::numeric, 10),
    'topic_prefix', coalesce(p_config->>'topic_prefix', ''),
    'locale', p_config->>'locale')
  || case when public.mock_parts(p_config) is not null
          then jsonb_build_object('parts', public.mock_parts(p_config),
                                  'cutoffs', coalesce(p_config->'cutoffs', '{}'::jsonb))
          else '{}'::jsonb end
$$;

-- Preguntas publicadas de un prefijo de temas (para las partes del banco)
create or replace function public.mock_prefix_pool(p_prefix text, p_locale text, p_is_test boolean)
returns table (question_id uuid, topic_slug text)
language sql stable security definer set search_path = '' as $$
  select q.id, t.slug
    from public.topics t
    join public.questions q on q.topic_id = t.id
   where p_prefix <> '' and t.slug like p_prefix || '%'
     and q.status = 'published' and q.is_test = p_is_test
     and (p_locale is null or q.locale::text = p_locale)
$$;
revoke execute on function public.mock_prefix_pool(text, text, boolean) from public, anon, authenticated;

-- ¿Tiene el simulacro por partes preguntas suficientes en cada parte del banco?
create or replace function public.mock_sections_ready(p_product uuid)
returns boolean
language sql stable security definer set search_path = '' as $$
  select coalesce(bool_and(
           (e->>'psycho')::boolean
           or (select count(*) from public.mock_prefix_pool(e->>'topic_prefix', c->>'locale', p.is_test))
              >= (e->>'questions')::int), false)
    from public.products p
    cross join lateral (select public.mock_config(p.config) as c) cfg
    cross join lateral jsonb_array_elements(cfg.c->'parts') e
   where p.id = p_product and cfg.c->>'kind' = 'sections'
$$;
revoke execute on function public.mock_sections_ready(uuid) from public, anon;
grant execute on function public.mock_sections_ready(uuid) to authenticated;

-- Empieza un simulacro por partes (solo service_role). p_items: psicotécnicos
-- generados por el servidor para las partes psycho, en orden.
create or replace function public.mock_start_sections(p_user uuid, p_product uuid, p_items jsonb)
returns uuid
language plpgsql security definer set search_path = '' as $$
declare
  v_p public.products%rowtype;
  v_c jsonb;
  v_id uuid;
  v_status public.account_status;
  v_part jsonb;
  v_pos int := 0;
  v_gen int := 0;
  v_n int;
  v_psycho int;
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
  if v_p.type <> 'mock_exam' or v_c->>'kind' <> 'sections' then
    raise exception 'El producto no es un simulacro por partes' using errcode = '22023';
  end if;

  select id into v_id from public.mock_attempts
   where user_id = p_user and product_id = p_product and status = 'active' and deadline > now()
   order by started_at desc limit 1;
  if v_id is not null then
    return v_id;
  end if;

  select coalesce(sum((e->>'questions')::int), 0) into v_psycho
    from jsonb_array_elements(v_c->'parts') e where (e->>'psycho')::boolean;
  if jsonb_typeof(p_items) <> 'array' or jsonb_array_length(p_items) <> v_psycho then
    raise exception 'Número de ítems no válido' using errcode = '22023';
  end if;
  if not public.mock_sections_ready(p_product) then
    raise exception 'El simulacro aún no tiene suficientes preguntas publicadas' using errcode = '22023';
  end if;

  insert into public.mock_attempts (user_id, product_id, title, title_ca, config, item_count, deadline)
  values (p_user, p_product, v_p.title, v_p.title_ca, v_c, (v_c->>'questions')::int,
          now() + make_interval(mins => (v_c->>'minutes')::int))
  returning id into v_id;

  for v_part in select e from jsonb_array_elements(v_c->'parts') e loop
    v_n := (v_part->>'questions')::int;
    if (v_part->>'psycho')::boolean then
      insert into public.mock_attempt_items (attempt_id, position, user_id, part, item_type, difficulty,
                                             seed, generator_version, presented)
      select v_id, (v_pos + e.ord - v_gen - 1)::smallint, p_user, (v_part->>'part')::smallint,
             e.it->>'item_type', (e.it->>'difficulty')::smallint, (e.it->>'seed')::bigint,
             (e.it->>'generator_version')::smallint, e.it->'presented'
        from jsonb_array_elements(p_items) with ordinality as e(it, ord)
       where e.ord > v_gen and e.ord <= v_gen + v_n;
      insert into public.mock_attempt_keys (attempt_id, position, answer_index, explanation)
      select v_id, (v_pos + e.ord - v_gen - 1)::smallint, (e.it->>'answer_index')::smallint, e.it->'explanation'
        from jsonb_array_elements(p_items) with ordinality as e(it, ord)
       where e.ord > v_gen and e.ord <= v_gen + v_n;
      v_gen := v_gen + v_n;
    else
      insert into public.mock_attempt_items (attempt_id, position, user_id, part, question_id,
                                             topic_slug, presented)
      select v_id, (v_pos + row_number() over (order by random()) - 1)::smallint, p_user,
             (v_part->>'part')::smallint, s.question_id, s.topic_slug,
             public.question_presented(s.question_id)
        from (select r.question_id, r.topic_slug
                from (select m.*, row_number() over (partition by m.topic_slug order by random()) as rn
                        from public.mock_prefix_pool(v_part->>'topic_prefix', v_c->>'locale',
                                                     v_p.is_test) m) r
               order by r.rn, random()
               limit v_n) s;
    end if;
    v_pos := v_pos + v_n;
  end loop;

  insert into public.activity_events (user_id, kind, metadata)
  values (p_user, 'mock.started', jsonb_build_object('attempt', v_id, 'product', p_product));
  update public.profiles set last_active_at = now() where id = p_user;
  return v_id;
end $$;
revoke execute on function public.mock_start_sections(uuid, uuid, jsonb) from public, anon, authenticated;
grant execute on function public.mock_start_sections(uuid, uuid, jsonb) to service_role;

-- mock_start no sirve para los simulacros por partes
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
  if v_c->>'kind' in ('psycho', 'sections') then
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

-- Corrección: igual que antes y, si es por partes, nota por partes
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
  v_passed boolean;
  v_parts jsonb;
  v_pen numeric;
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

  v_pen := (a.config->>'penalty')::numeric;
  v_valid := a.item_count - v_v;
  v_score := round(greatest(0, v_c - v_w * v_pen), 2);
  v_mark := case when v_valid > 0
                 then round(v_score * (a.config->>'max_mark')::numeric / v_valid, 2) else 0 end;
  v_passed := v_mark >= (a.config->>'pass_mark')::numeric;

  if a.config->>'kind' = 'sections' then
    with per as (
      select i.part,
             count(*) filter (where i.is_correct) as c,
             count(*) filter (where i.is_correct = false) as w,
             count(*) filter (where i.answer_index is not null and i.chosen_index is null) as b,
             count(*) filter (where i.answer_index is not null) as valid
        from public.mock_attempt_items i
       where i.attempt_id = p_attempt
       group by i.part),
    scored as (
      select per.*, round(per.c - per.w * v_pen, 2) as direct,
             least(coalesce((a.config->'cutoffs'->>per.part::text)::numeric, per.valid / 2.0),
                   per.valid) as cut
        from per),
    graded as (
      select scored.*,
             round(case when valid = 0 then 0
                        when direct >= cut and valid > cut then 25 + 25 * (direct - cut) / (valid - cut)
                        when direct >= cut then 50
                        when cut > 0 then greatest(0, 25 * direct / cut)
                        else 0 end, 2) as grade
        from scored)
    select jsonb_agg(jsonb_build_object('part', part, 'correct', c, 'wrong', w, 'blank', b,
                                        'valid', valid, 'direct', direct, 'cut', cut,
                                        'grade', grade, 'passed', direct >= cut)
                     order by part),
           round(sum(grade), 2),
           bool_and(direct >= cut)
      into v_parts, v_mark, v_passed
      from graded;
    v_score := round(v_c - v_w * v_pen, 2);
  end if;

  update public.mock_attempts
     set status = case when now() > a.deadline + interval '15 seconds'
                       then 'expired'::public.mock_status else 'submitted'::public.mock_status end,
         submitted_at = least(now(), a.deadline + interval '15 seconds'),
         correct_count = v_c, wrong_count = v_w, blank_count = v_b, void_count = v_v,
         score = v_score, mark = v_mark, passed = v_passed, part_results = v_parts
   where id = p_attempt;

  insert into public.activity_events (user_id, kind, metadata)
  values (p_user, 'mock.submitted', jsonb_build_object('attempt', p_attempt, 'mark', v_mark));
  update public.profiles set last_active_at = now() where id = p_user;

  return query select v_c::smallint, v_w::smallint, v_b::smallint, v_v::smallint, v_score, v_mark,
                      v_passed;
end $$;
