-- =====================================================================
-- 0600 · Práctica: sesiones, ítems/respuestas, estadísticas y repaso de fallos
--
-- Seguridad (ADR-014):
--  * El alumno solo LEE sus propias filas (RLS user_id = auth.uid()).
--  * Nadie escribe con su JWT: las escrituras pasan por funciones ejecutables
--    solo por service_role, invocadas desde Server Actions DESPUÉS de corregir
--    en el servidor (regenerando el ítem desde la semilla). Así un alumno no
--    puede falsear aciertos ni tiempos llamando a la API directamente.
--  * El tiempo de respuesta lo mide la base de datos, no el cliente.
--  * La solución (answer_index, explanation) solo se guarda al responder.
-- =====================================================================

create type public.practice_mode as enum ('psycho', 'questions', 'mock', 'review');
create type public.practice_status as enum ('active', 'finished', 'abandoned');

create table public.practice_sessions (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users (id) on delete cascade,
  mode public.practice_mode not null,
  -- tipo de ítem ('series', 'letters', … , 'mixed' o 'question')
  item_type text not null check (item_type ~ '^[a-z_]{2,40}$'),
  exam_body_id uuid references public.exam_bodies (id) on delete set null,
  status public.practice_status not null default 'active',
  item_count smallint not null check (item_count between 1 and 100),
  answered_count smallint not null default 0,
  correct_count smallint not null default 0,
  total_time_ms integer not null default 0,
  started_at timestamptz not null default now(),
  last_activity_at timestamptz not null default now(),
  finished_at timestamptz,
  check (answered_count <= item_count and correct_count <= answered_count)
);
create index practice_sessions_user_idx on public.practice_sessions (user_id, started_at desc);

create table public.practice_items (
  session_id uuid not null references public.practice_sessions (id) on delete cascade,
  position smallint not null check (position >= 0),
  user_id uuid not null references auth.users (id) on delete cascade,
  source text not null check (source in ('generator', 'question')),
  item_type text not null check (item_type ~ '^[a-z_]{2,40}$'),
  category text not null check (category ~ '^[a-z0-9_\-]{2,60}$'),
  difficulty smallint not null check (difficulty between 1 and 5),
  seed bigint check (seed between 0 and 4294967295),
  generator_version smallint,
  question_id uuid references public.questions (id) on delete set null,
  -- vista pública tal como se mostró (enunciado + opciones), sin solución
  presented jsonb not null,
  chosen_index smallint check (chosen_index between 0 and 5),
  is_correct boolean,
  answer_index smallint check (answer_index between 0 and 5),
  explanation jsonb,
  time_ms integer check (time_ms >= 0),
  answered_at timestamptz,
  -- repaso de fallos: ítem original que se repasa y cuándo se resolvió
  review_of_session uuid,
  review_of_position smallint,
  reviewed_at timestamptz,
  primary key (session_id, position),
  check ((source = 'generator') = (seed is not null and generator_version is not null)),
  check ((answered_at is null) = (is_correct is null)),
  foreign key (review_of_session, review_of_position)
    references public.practice_items (session_id, position) on delete set null
);
create index practice_items_user_idx on public.practice_items (user_id, answered_at desc);
create index practice_items_failed_idx on public.practice_items (user_id, answered_at desc)
  where is_correct = false and reviewed_at is null;

alter table public.practice_sessions enable row level security;
alter table public.practice_items enable row level security;

create policy "practice_sessions: propias" on public.practice_sessions for select to authenticated
  using (user_id = (select auth.uid()));
create policy "practice_items: propias" on public.practice_items for select to authenticated
  using (user_id = (select auth.uid()));

revoke all on public.practice_sessions, public.practice_items from anon;
revoke insert, update, delete, truncate on public.practice_sessions, public.practice_items
  from authenticated;
grant select on public.practice_sessions, public.practice_items to authenticated;

-- ---------------------------------------------------------------------
-- Escritura (solo service_role)
-- ---------------------------------------------------------------------

-- Crea una sesión con sus ítems. p_items: [{source,item_type,category,difficulty,seed,
--   generator_version,question_id,presented,review_of_session,review_of_position}]
create or replace function public.practice_start(
  p_user uuid,
  p_mode public.practice_mode,
  p_item_type text,
  p_items jsonb,
  p_exam_body uuid default null
) returns uuid
language plpgsql security definer set search_path = '' as $$
declare
  v_id uuid;
  v_n int := jsonb_array_length(p_items);
  v_status public.account_status;
begin
  select status into v_status from public.profiles where id = p_user;
  if v_status is distinct from 'active' then
    raise exception 'Cuenta no activa' using errcode = '42501';
  end if;
  if v_n < 1 or v_n > 100 then
    raise exception 'Número de ítems no válido' using errcode = '22023';
  end if;
  -- una sola sesión activa por usuario: las anteriores quedan abandonadas
  update public.practice_sessions set status = 'abandoned', finished_at = now()
   where user_id = p_user and status = 'active';

  insert into public.practice_sessions (user_id, mode, item_type, exam_body_id, item_count)
  values (p_user, p_mode, p_item_type, p_exam_body, v_n)
  returning id into v_id;

  insert into public.practice_items (session_id, position, user_id, source, item_type, category,
    difficulty, seed, generator_version, question_id, presented, review_of_session, review_of_position)
  select v_id, (e.ord - 1)::smallint, p_user, e.it->>'source', e.it->>'item_type', e.it->>'category',
         (e.it->>'difficulty')::smallint, (e.it->>'seed')::bigint,
         (e.it->>'generator_version')::smallint, (e.it->>'question_id')::uuid, e.it->'presented',
         (e.it->>'review_of_session')::uuid, (e.it->>'review_of_position')::smallint
    from jsonb_array_elements(p_items) with ordinality as e(it, ord);

  -- los ítems de repaso deben pertenecer al mismo usuario
  if exists (select 1 from public.practice_items i
               join public.practice_items o
                 on o.session_id = i.review_of_session and o.position = i.review_of_position
              where i.session_id = v_id and o.user_id <> p_user) then
    raise exception 'Ítem de repaso ajeno' using errcode = '42501';
  end if;

  insert into public.activity_events (user_id, kind, metadata)
  values (p_user, 'practice.started', jsonb_build_object('session', v_id, 'mode', p_mode, 'type', p_item_type));
  update public.profiles set last_active_at = now() where id = p_user;
  return v_id;
end $$;

-- Registra la respuesta (ya corregida por el servidor). Responde en orden,
-- una sola vez por ítem; el tiempo se mide aquí. Devuelve el estado de la sesión.
create or replace function public.practice_record_answer(
  p_user uuid,
  p_session uuid,
  p_position smallint,
  p_chosen smallint,
  p_correct boolean,
  p_answer_index smallint,
  p_explanation jsonb
) returns table (finished boolean, answered_count smallint, correct_count smallint, time_ms integer)
language plpgsql security definer set search_path = '' as $$
declare
  s public.practice_sessions%rowtype;
  v_last timestamptz;
  v_ms integer;
  v_item public.practice_items%rowtype;
begin
  select * into s from public.practice_sessions where id = p_session for update;
  if not found or s.user_id <> p_user then
    raise exception 'Sesión no encontrada' using errcode = '42501';
  end if;
  if s.status <> 'active' then
    raise exception 'La sesión ya no está activa' using errcode = '22023';
  end if;
  if p_position <> s.answered_count then
    raise exception 'Responde los ítems en orden' using errcode = '22023';
  end if;
  select * into v_item from public.practice_items
   where session_id = p_session and position = p_position for update;
  if not found or v_item.answered_at is not null then
    raise exception 'Ítem no disponible' using errcode = '22023';
  end if;

  select coalesce(max(i.answered_at), s.started_at) into v_last
    from public.practice_items i where i.session_id = p_session;
  -- tope de 10 minutos por ítem (pausas largas no distorsionan las medias)
  v_ms := least(600000, greatest(0, (extract(epoch from (now() - v_last)) * 1000)::integer));

  update public.practice_items
     set chosen_index = p_chosen, is_correct = p_correct, answer_index = p_answer_index,
         explanation = p_explanation, time_ms = v_ms, answered_at = now()
   where session_id = p_session and position = p_position;

  -- acertar un ítem de repaso resuelve el fallo original
  if p_correct and v_item.review_of_session is not null then
    update public.practice_items set reviewed_at = now()
     where session_id = v_item.review_of_session and position = v_item.review_of_position
       and user_id = p_user and reviewed_at is null;
  end if;

  update public.practice_sessions
     set answered_count = s.answered_count + 1,
         correct_count = s.correct_count + (case when p_correct then 1 else 0 end),
         total_time_ms = s.total_time_ms + v_ms,
         last_activity_at = now(),
         status = case when s.answered_count + 1 >= s.item_count then 'finished'::public.practice_status else status end,
         finished_at = case when s.answered_count + 1 >= s.item_count then now() else null end
   where id = p_session;

  if s.answered_count + 1 >= s.item_count then
    insert into public.activity_events (user_id, kind, metadata)
    values (p_user, 'practice.completed', jsonb_build_object('session', p_session,
            'correct', s.correct_count + (case when p_correct then 1 else 0 end), 'total', s.item_count));
  end if;
  update public.profiles set last_active_at = now() where id = p_user;

  return query select s.answered_count + 1 >= s.item_count,
                      (s.answered_count + 1)::smallint,
                      (s.correct_count + (case when p_correct then 1 else 0 end))::smallint,
                      v_ms;
end $$;

revoke execute on function public.practice_start(uuid, public.practice_mode, text, jsonb, uuid)
  from public, anon, authenticated;
revoke execute on function public.practice_record_answer(uuid, uuid, smallint, smallint, boolean, smallint, jsonb)
  from public, anon, authenticated;
grant execute on function public.practice_start(uuid, public.practice_mode, text, jsonb, uuid) to service_role;
grant execute on function public.practice_record_answer(uuid, uuid, smallint, smallint, boolean, smallint, jsonb)
  to service_role;

-- ---------------------------------------------------------------------
-- Estadísticas personales (security invoker: RLS limita a las propias filas)
-- Días calculados en hora peninsular española.
-- ---------------------------------------------------------------------
create or replace function public.my_practice_stats(p_days int default 30)
returns jsonb
language plpgsql stable security invoker set search_path = '' as $$
declare
  v_uid uuid := auth.uid();
  v_today date := (now() at time zone 'Europe/Madrid')::date;
  v_days int := least(greatest(coalesce(p_days, 30), 7), 365);
  v_streak int := 0;
  d date;
begin
  if v_uid is null then
    raise exception 'Sesión requerida' using errcode = '42501';
  end if;

  -- racha: días consecutivos con al menos una respuesta, terminando hoy o ayer
  d := v_today;
  if not exists (select 1 from public.practice_items
                  where user_id = v_uid and answered_at is not null
                    and (answered_at at time zone 'Europe/Madrid')::date = d) then
    d := d - 1;
  end if;
  while exists (select 1 from public.practice_items
                 where user_id = v_uid and answered_at is not null
                   and (answered_at at time zone 'Europe/Madrid')::date = d) loop
    v_streak := v_streak + 1;
    d := d - 1;
  end loop;

  return jsonb_build_object(
    'totals', (select jsonb_build_object(
                 'answered', count(*),
                 'correct', count(*) filter (where is_correct),
                 'avg_time_ms', coalesce(round(avg(time_ms)), 0),
                 'pending_review', count(*) filter (where is_correct = false and reviewed_at is null))
                 from public.practice_items where user_id = v_uid and answered_at is not null),
    'sessions_finished', (select count(*) from public.practice_sessions
                           where user_id = v_uid and status = 'finished'),
    'streak', v_streak,
    'by_type', coalesce((select jsonb_agg(x order by x->>'item_type') from (
                 select jsonb_build_object('item_type', item_type, 'answered', count(*),
                          'correct', count(*) filter (where is_correct),
                          'avg_time_ms', round(avg(time_ms))) as x
                   from public.practice_items where user_id = v_uid and answered_at is not null
                  group by item_type) t), '[]'::jsonb),
    'by_difficulty', coalesce((select jsonb_agg(x order by (x->>'difficulty')::int) from (
                 select jsonb_build_object('difficulty', difficulty, 'answered', count(*),
                          'correct', count(*) filter (where is_correct)) as x
                   from public.practice_items where user_id = v_uid and answered_at is not null
                  group by difficulty) t), '[]'::jsonb),
    'daily', (select jsonb_agg(jsonb_build_object('day', g.day::date, 'answered', coalesce(a.answered, 0),
                                                  'correct', coalesce(a.correct, 0)) order by g.day)
                from generate_series(v_today - (v_days - 1), v_today, interval '1 day') as g(day)
                left join (select (answered_at at time zone 'Europe/Madrid')::date as day,
                                  count(*) as answered, count(*) filter (where is_correct) as correct
                             from public.practice_items
                            where user_id = v_uid and answered_at is not null
                              and answered_at >= (v_today - v_days)::timestamp at time zone 'Europe/Madrid'
                            group by 1) a on a.day = g.day::date)
  );
end $$;
revoke execute on function public.my_practice_stats(int) from public, anon;
grant execute on function public.my_practice_stats(int) to authenticated;

-- ---------------------------------------------------------------------
-- Métricas agregadas para el panel de administración (sin datos personales)
-- ---------------------------------------------------------------------
create or replace function public.admin_practice_metrics()
returns jsonb
language plpgsql stable security definer set search_path = '' as $$
begin
  if not public.is_admin() then
    raise exception 'Solo administradores' using errcode = '42501';
  end if;
  return jsonb_build_object(
    'sessions_total', (select count(*) from public.practice_sessions),
    'sessions_finished_7d', (select count(*) from public.practice_sessions
                              where status = 'finished' and finished_at >= now() - interval '7 days'),
    'answers_7d', (select count(*) from public.practice_items where answered_at >= now() - interval '7 days'),
    'practicing_users_7d', (select count(distinct user_id) from public.practice_items
                             where answered_at >= now() - interval '7 days'),
    'by_type', coalesce((select jsonb_agg(x order by x->>'item_type') from (
                 select jsonb_build_object('item_type', item_type, 'answered', count(*),
                          'correct', count(*) filter (where is_correct),
                          'avg_time_ms', round(avg(time_ms))) as x
                   from public.practice_items where answered_at is not null
                  group by item_type) t), '[]'::jsonb)
  );
end $$;
revoke execute on function public.admin_practice_metrics() from public, anon;
grant execute on function public.admin_practice_metrics() to authenticated;

-- ---------------------------------------------------------------------
-- Exportación RGPD: incluir la práctica
-- ---------------------------------------------------------------------
create or replace function public.export_my_data()
returns jsonb
language plpgsql stable security definer set search_path = '' as $$
declare
  v_uid uuid := auth.uid();
begin
  if v_uid is null then
    raise exception 'Sesión requerida' using errcode = '42501';
  end if;
  return jsonb_build_object(
    'generated_at', now(),
    'account', (select jsonb_build_object('id', u.id, 'email', u.email, 'created_at', u.created_at,
                                          'email_confirmed_at', u.email_confirmed_at,
                                          'last_sign_in_at', u.last_sign_in_at)
                from auth.users u where u.id = v_uid),
    'profile', (select to_jsonb(p) - 'id' from public.profiles p where p.id = v_uid),
    'exam_targets', coalesce((select jsonb_agg(jsonb_build_object(
                       'exam', b.slug, 'name', b.name, 'is_primary', t.is_primary,
                       'follow_only', t.follow_only, 'notify_consent', t.notify_consent,
                       'level', t.level, 'weekly_hours', t.weekly_hours, 'goals', t.goals,
                       'created_at', t.created_at))
                     from public.user_exam_targets t join public.exam_bodies b on b.id = t.exam_body_id
                     where t.user_id = v_uid), '[]'::jsonb),
    'activity', coalesce((select jsonb_agg(jsonb_build_object('kind', a.kind, 'metadata', a.metadata,
                                                              'created_at', a.created_at) order by a.created_at)
                          from public.activity_events a where a.user_id = v_uid), '[]'::jsonb),
    'practice_sessions', coalesce((select jsonb_agg(to_jsonb(s) - 'user_id' order by s.started_at)
                          from public.practice_sessions s where s.user_id = v_uid), '[]'::jsonb),
    'practice_answers', coalesce((select jsonb_agg(to_jsonb(i) - 'user_id' order by i.answered_at)
                          from public.practice_items i where i.user_id = v_uid and i.answered_at is not null),
                          '[]'::jsonb)
  );
end $$;
revoke execute on function public.export_my_data() from anon, public;
grant execute on function public.export_my_data() to authenticated;
