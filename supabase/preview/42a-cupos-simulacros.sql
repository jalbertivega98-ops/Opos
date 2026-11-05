-- Copia de la migración 20261105000100_mock_quotas.sql para la preview (el flujo de la preview no aplica
-- supabase/migrations). Tiene que ir antes de 43-. Idempotente (create or replace).
begin;
-- =====================================================================
-- 1600 · Simulacros calcados al examen real: cupos por tema
--
--  * config.quotas: [{topic_prefix, questions}, ...] en un simulacro normal
--    (kind 'questions'): el simulacro saca exactamente ese número de preguntas
--    de cada prefijo de temas, como el reparto de los exámenes oficiales
--    (docs/research/examenes-reales). Sin quotas, todo sigue igual (al azar
--    por topic_prefix, una por tema primero).
--  * config.parts (simulacro por partes) admite hasta 60 entradas (antes 9),
--    para repartir cada parte tema a tema. Los números de parte siguen siendo 1-9.
--  * Cada cupo debe tener preguntas publicadas suficientes para empezar.
-- =====================================================================

create or replace function public.mock_parts(p_config jsonb)
returns jsonb
language sql immutable set search_path = '' as $$
  select case
    when p_config->>'kind' = 'sections' and jsonb_typeof(p_config->'parts') = 'array'
     and jsonb_array_length(p_config->'parts') between 1 and 60 then (
      select jsonb_agg(jsonb_build_object(
               'part', least(greatest(coalesce((e->>'part')::int, 1), 1), 9),
               'questions', least(greatest(coalesce((e->>'questions')::int, 1), 1), 120),
               'psycho', coalesce((e->>'psycho')::boolean, false),
               'topic_prefix', coalesce(e->>'topic_prefix', ''))
             order by ord)
        from jsonb_array_elements(p_config->'parts') with ordinality as x(e, ord))
    else null end
$$;

-- Cupos saneados (o null si no hay)
create or replace function public.mock_quotas(p_config jsonb)
returns jsonb
language sql immutable set search_path = '' as $$
  select case
    when coalesce(p_config->>'kind', '') not in ('psycho', 'sections')
     and jsonb_typeof(p_config->'quotas') = 'array'
     and jsonb_array_length(p_config->'quotas') between 1 and 60 then (
      select jsonb_agg(jsonb_build_object(
               'questions', least(greatest(coalesce((e->>'questions')::int, 1), 1), 120),
               'topic_prefix', coalesce(e->>'topic_prefix', ''))
             order by ord)
        from jsonb_array_elements(p_config->'quotas') with ordinality as x(e, ord)
       where coalesce(e->>'topic_prefix', '') <> '')
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
                   (select sum((e->>'questions')::int)::int
                      from jsonb_array_elements(public.mock_quotas(p_config)) e),
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
  || case when public.mock_quotas(p_config) is not null
          then jsonb_build_object('quotas', public.mock_quotas(p_config))
          else '{}'::jsonb end
$$;

-- ¿Llega cada cupo con las preguntas publicadas? (true si no hay cupos)
create or replace function public.mock_quotas_ready(p_product uuid)
returns boolean
language sql stable security definer set search_path = '' as $$
  select coalesce(bool_and(
           (select count(*) from public.mock_prefix_pool(e->>'topic_prefix', c->>'locale', p.is_test))
             >= (e->>'questions')::int), true)
    from public.products p
    cross join lateral (select public.mock_config(p.config) as c) cfg
    cross join lateral jsonb_array_elements(coalesce(cfg.c->'quotas', '[]'::jsonb)) e
   where p.id = p_product
$$;
revoke execute on function public.mock_quotas_ready(uuid) from public, anon;
grant execute on function public.mock_quotas_ready(uuid) to authenticated;

-- Inicio de un simulacro de preguntas: con cupos, tema a tema; sin cupos, como antes
create or replace function public.mock_start(p_user uuid, p_product uuid)
returns uuid
language plpgsql security definer set search_path = '' as $$
declare
  v_p public.products%rowtype;
  v_c jsonb;
  v_n int;
  v_id uuid;
  v_status public.account_status;
  v_q jsonb;
  v_pos int := 0;
  v_k int;
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
  if v_c ? 'quotas' then
    if not public.mock_quotas_ready(p_product) then
      raise exception 'El simulacro aún no tiene suficientes preguntas publicadas' using errcode = '22023';
    end if;
  elsif (select count(*) from public.mock_pool(p_product)) < v_n then
    raise exception 'El simulacro aún no tiene suficientes preguntas publicadas' using errcode = '22023';
  end if;

  insert into public.mock_attempts (user_id, product_id, title, title_ca, config, item_count, deadline)
  values (p_user, p_product, v_p.title, v_p.title_ca, v_c, v_n,
          now() + make_interval(mins => (v_c->>'minutes')::int))
  returning id into v_id;

  if v_c ? 'quotas' then
    -- Cada cupo saca sus preguntas sin repetir las de cupos anteriores; el orden final se baraja
    for v_q in select e from jsonb_array_elements(v_c->'quotas') e loop
      insert into public.mock_attempt_items (attempt_id, position, user_id, question_id, topic_slug, presented)
      select v_id, (v_pos + row_number() over (order by random()) - 1)::smallint, p_user,
             s.question_id, s.topic_slug, public.question_presented(s.question_id)
        from (select r.question_id, r.topic_slug
                from (select m.*, row_number() over (partition by m.topic_slug order by random()) as rn
                        from public.mock_prefix_pool(v_q->>'topic_prefix', v_c->>'locale', v_p.is_test) m
                       where not exists (select 1 from public.mock_attempt_items x
                                          where x.attempt_id = v_id and x.question_id = m.question_id)) r
               order by r.rn, random()
               limit (v_q->>'questions')::int) s;
      get diagnostics v_k = row_count;
      v_pos := v_pos + v_k;
    end loop;
    -- Barajar las posiciones para que los temas no salgan en bloque
    with shuffled as (
      select position as old_pos, (row_number() over (order by random()) - 1)::smallint as new_pos
        from public.mock_attempt_items where attempt_id = v_id)
    update public.mock_attempt_items i
       set position = (s.new_pos + 1000)::smallint
      from shuffled s
     where i.attempt_id = v_id and i.position = s.old_pos;
    update public.mock_attempt_items set position = (position - 1000)::smallint
     where attempt_id = v_id;
    update public.mock_attempts set item_count = v_pos where id = v_id;
  else
    insert into public.mock_attempt_items (attempt_id, position, user_id, question_id, topic_slug, presented)
    select v_id, (row_number() over (order by random()) - 1)::smallint, p_user, s.question_id,
           s.topic_slug, public.question_presented(s.question_id)
      from (select r.question_id, r.topic_slug
              from (select m.*, row_number() over (partition by m.topic_slug order by random()) as rn
                      from public.mock_pool(p_product) m) r
             order by r.rn, random()
             limit v_n) s;
  end if;

  insert into public.activity_events (user_id, kind, metadata)
  values (p_user, 'mock.started', jsonb_build_object('attempt', v_id, 'product', p_product));
  update public.profiles set last_active_at = now() where id = p_user;
  return v_id;
end $$;
commit;
