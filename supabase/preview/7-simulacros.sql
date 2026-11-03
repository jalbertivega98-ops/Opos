-- Simulacros con formato oficial (migración 20261103000300) + simulacro de Mossos en BORRADOR.
-- Ejecutar después de 4, 5a, 5b, 5c y 6. Idempotente.
--
-- El simulacro saca 30 preguntas PUBLICADAS en catalán de los temas mossos-*
-- (primero una por tema, el resto al azar), 35 min, error −1/4, nota sobre 10,
-- mínimo 4. Para que funcione: publicar al menos 30 preguntas desde
-- /admin/revision/fuentes y después publicar el producto en /admin/productos.

begin;
-- =====================================================================
-- 1200 · Simulacros con formato oficial (MOC-001)
--
--  * Un producto mock_exam guarda su formato en config:
--      {"questions":30,"minutes":35,"penalty":0.25,"pass_mark":4,"max_mark":10,
--       "topic_prefix":"mossos-","locale":"ca"}
--  * Selección: preguntas PUBLICADAS de los temas cuyo slug empieza por
--    topic_prefix. Primero una por tema (al azar) y, si faltan, más de
--    cualquier tema; el orden final se baraja. Prueba y real no se mezclan.
--  * Como en el examen real: se puede cambiar o dejar en blanco cualquier
--    respuesta hasta entregar; no hay corrección hasta el final.
--  * El tiempo lo controla la base de datos (deadline). Pasado el límite
--    no se aceptan respuestas y el intento se corrige con lo guardado.
--  * Nota = max(0, aciertos − fallos·penalty) · max_mark / preguntas válidas.
--  * Igual que la práctica (ADR-014): el alumno solo lee sus filas y las
--    escrituras pasan por funciones de service_role. La solución no existe
--    en la fila hasta la corrección.
-- =====================================================================

do $$ begin
  create type public.mock_status as enum ('active', 'submitted', 'expired');
exception when duplicate_object then null;
end $$;

create table if not exists public.mock_attempts (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users (id) on delete cascade,
  product_id uuid references public.products (id) on delete set null,
  title text not null,
  title_ca text,
  config jsonb not null,
  item_count smallint not null check (item_count between 1 and 120),
  status public.mock_status not null default 'active',
  started_at timestamptz not null default now(),
  deadline timestamptz not null,
  submitted_at timestamptz,
  correct_count smallint,
  wrong_count smallint,
  blank_count smallint,
  void_count smallint,
  score numeric(6, 2),
  mark numeric(5, 2),
  passed boolean,
  check ((status = 'active') = (submitted_at is null))
);
create index if not exists mock_attempts_user_idx on public.mock_attempts (user_id, started_at desc);

create table if not exists public.mock_attempt_items (
  attempt_id uuid not null references public.mock_attempts (id) on delete cascade,
  position smallint not null check (position >= 0),
  user_id uuid not null references auth.users (id) on delete cascade,
  question_id uuid references public.questions (id) on delete set null,
  topic_slug text,
  presented jsonb not null,
  chosen_index smallint check (chosen_index between 0 and 5),
  answered_at timestamptz,
  -- solo tras la corrección
  is_correct boolean,
  answer_index smallint check (answer_index between 0 and 5),
  explanation jsonb,
  primary key (attempt_id, position)
);

alter table public.mock_attempts enable row level security;
alter table public.mock_attempt_items enable row level security;
drop policy if exists "mock_attempts: propios" on public.mock_attempts;
create policy "mock_attempts: propios" on public.mock_attempts for select to authenticated
  using (user_id = (select auth.uid()));
drop policy if exists "mock_attempt_items: propios" on public.mock_attempt_items;
create policy "mock_attempt_items: propios" on public.mock_attempt_items for select to authenticated
  using (user_id = (select auth.uid()));
revoke all on public.mock_attempts, public.mock_attempt_items from anon;
revoke insert, update, delete, truncate on public.mock_attempts, public.mock_attempt_items
  from authenticated;
grant select on public.mock_attempts, public.mock_attempt_items to authenticated;

-- ---------------------------------------------------------------------
-- Formato efectivo de un simulacro (valores por defecto = Mossos 46/26)
-- ---------------------------------------------------------------------
create or replace function public.mock_config(p_config jsonb)
returns jsonb
language sql immutable set search_path = '' as $$
  select jsonb_build_object(
    'questions', least(greatest(coalesce((p_config->>'questions')::int, 30), 1), 120),
    'minutes', least(greatest(coalesce((p_config->>'minutes')::int, 35), 1), 300),
    'penalty', least(greatest(coalesce((p_config->>'penalty')::numeric, 0.25), 0), 1),
    'pass_mark', coalesce((p_config->>'pass_mark')::numeric, 4),
    'max_mark', coalesce((p_config->>'max_mark')::numeric, 10),
    'topic_prefix', coalesce(p_config->>'topic_prefix', ''),
    'locale', p_config->>'locale')
$$;

-- Preguntas candidatas de un simulacro (publicadas, mismo carácter de prueba/real)
create or replace function public.mock_pool(p_product uuid)
returns table (question_id uuid, topic_slug text)
language sql stable security definer set search_path = '' as $$
  select q.id, t.slug
    from public.products p
    cross join lateral (select public.mock_config(p.config) as c) cfg
    join public.topics t on cfg.c->>'topic_prefix' <> ''
                         and t.slug like (cfg.c->>'topic_prefix') || '%'
    join public.questions q on q.topic_id = t.id
   where p.id = p_product and p.type = 'mock_exam'
     and q.status = 'published' and q.is_test = p.is_test
     and (cfg.c->>'locale' is null or q.locale::text = cfg.c->>'locale')
$$;
revoke execute on function public.mock_pool(uuid) from public, anon, authenticated;
grant execute on function public.mock_pool(uuid) to service_role;

-- Un simulacro "tiene preguntas" para la biblioteca si su banco llega al formato
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
$$;
revoke execute on function public.product_question_ids(uuid) from public, anon, authenticated;
grant execute on function public.product_question_ids(uuid) to service_role;

-- ---------------------------------------------------------------------
-- Inicio: reanuda el intento activo del mismo simulacro o crea uno nuevo
-- ---------------------------------------------------------------------
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

  -- reanudar si hay uno en curso y dentro de plazo
  select id into v_id from public.mock_attempts
   where user_id = p_user and product_id = p_product and status = 'active' and deadline > now()
   order by started_at desc limit 1;
  if v_id is not null then
    return v_id;
  end if;

  v_c := public.mock_config(v_p.config);
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

-- ---------------------------------------------------------------------
-- Guardar (o borrar con null) una respuesta mientras dura el examen
-- ---------------------------------------------------------------------
create or replace function public.mock_save_answer(
  p_user uuid, p_attempt uuid, p_position smallint, p_chosen smallint
) returns void
language plpgsql security definer set search_path = '' as $$
declare
  a public.mock_attempts%rowtype;
  v_presented jsonb;
begin
  select * into a from public.mock_attempts where id = p_attempt for update;
  if not found or a.user_id <> p_user then
    raise exception 'Simulacro no encontrado' using errcode = '42501';
  end if;
  -- 15 s de margen para la latencia de red
  if a.status <> 'active' or now() > a.deadline + interval '15 seconds' then
    raise exception 'El simulacro ya ha terminado' using errcode = '22023';
  end if;
  select presented into v_presented from public.mock_attempt_items
   where attempt_id = p_attempt and position = p_position;
  if v_presented is null then
    raise exception 'Pregunta no encontrada' using errcode = '22023';
  end if;
  if p_chosen is not null and (p_chosen < 0 or p_chosen >= jsonb_array_length(v_presented->'options')) then
    raise exception 'Opción no válida' using errcode = '22023';
  end if;
  update public.mock_attempt_items
     set chosen_index = p_chosen, answered_at = case when p_chosen is null then null else now() end
   where attempt_id = p_attempt and position = p_position;
end $$;

-- ---------------------------------------------------------------------
-- Entrega y corrección (idempotente). Si la pregunta cambió o se retiró
-- después de empezar, se anula y no cuenta (como una pregunta anulada).
-- ---------------------------------------------------------------------
create or replace function public.mock_submit(p_user uuid, p_attempt uuid)
returns table (correct smallint, wrong smallint, blank smallint, void smallint,
               score numeric, mark numeric, passed boolean)
language plpgsql security definer set search_path = '' as $$
declare
  a public.mock_attempts%rowtype;
  it record;
  v_ans smallint;
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
    if exists (select 1 from public.questions q where q.id = it.question_id and q.status = 'published')
       and public.question_presented(it.question_id)->'options' is not distinct from it.presented->'options' then
      select (ascii(o.label) - 65)::smallint into v_ans
        from public.question_options o where o.question_id = it.question_id and o.is_correct;
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
           explanation = (select jsonb_build_object('text', q.explanation, 'ref', q.source_ref)
                            from public.questions q where q.id = it.question_id)
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

revoke execute on function public.mock_start(uuid, uuid) from public, anon, authenticated;
revoke execute on function public.mock_save_answer(uuid, uuid, smallint, smallint) from public, anon, authenticated;
revoke execute on function public.mock_submit(uuid, uuid) from public, anon, authenticated;
grant execute on function public.mock_start(uuid, uuid) to service_role;
grant execute on function public.mock_save_answer(uuid, uuid, smallint, smallint) to service_role;
grant execute on function public.mock_submit(uuid, uuid) to service_role;

-- Simulacro de conocimientos de Mossos (borrador; incluido en Premium)
insert into public.products (slug, type, status, title, title_ca, description, description_ca,
                             exam_body_id, is_free, included_in_premium, config)
select 'mossos-simulacre-coneixements-2026', 'mock_exam', 'draft',
       'Mossos · Simulacro de conocimientos (formato 2026)',
       'Mossos · Simulacre de coneixements (format 2026)',
       '30 preguntas en catalán de todo el temario de la Guia d''estudi, 35 minutos, cada error resta 1/4. Nota sobre 10; mínimo 4.',
       '30 preguntes de tot el temari de la Guia d''estudi, 35 minuts, cada error resta 1/4. Nota sobre 10; mínim 4.',
       b.id, false, true,
       '{"questions":30,"minutes":35,"penalty":0.25,"pass_mark":4,"max_mark":10,"topic_prefix":"mossos-","locale":"ca"}'::jsonb
  from public.exam_bodies b
 where b.slug = 'mossos-esquadra'
on conflict (slug) do nothing;
commit;
