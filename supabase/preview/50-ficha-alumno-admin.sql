-- =====================================================================
-- 50 · Ficha completa del alumno en el panel (ADR-038)
-- Copia de supabase/migrations/20261106000100_admin_user_insights.sql (el
-- flujo de la preview no aplica migraciones). Idempotente.
-- =====================================================================

-- =====================================================================
-- ADR-038 · Ficha completa del alumno en el panel de administración
--
--  * user_presence_daily: minutos con la zona del alumno abierta y visible,
--    por día (sin páginas, sin IP, sin dispositivo). El navegador avisa cada
--    minuto con track_presence(); se guarda 12 meses y se borra con la cuenta.
--  * admin_user_insights(): accesos (Premium, packs, pedidos), códigos
--    promocionales, entradas y salidas (registro de Auth, sin IP), tiempo
--    dentro y tests/simulacros hechos. Solo administración; queda auditado.
--  * admin_grant_premium() / admin_end_premium(): Premium regalado a mano
--    (suscripción sin Stripe, provider = 'none'). No implica cobro.
--  * admin_promo_codes + admin_record_promo_code(): códigos de Stripe creados
--    para un alumno desde su ficha (el código vive en Stripe; aquí, el registro).
-- =====================================================================

-- ---------------------------------------------------------------------
-- Tiempo dentro (agregado por día)
-- ---------------------------------------------------------------------
create table if not exists public.user_presence_daily (
  user_id uuid not null references auth.users (id) on delete cascade,
  day date not null,
  seconds integer not null default 0 check (seconds between 0 and 86400),
  first_seen timestamptz not null default now(),
  last_seen timestamptz not null default now(),
  primary key (user_id, day)
);
alter table public.user_presence_daily enable row level security;
drop policy if exists "presence: ver la propia" on public.user_presence_daily;
create policy "presence: ver la propia" on public.user_presence_daily
  for select to authenticated using (user_id = (select auth.uid()));
revoke all on public.user_presence_daily from anon;
revoke insert, update, delete, truncate on public.user_presence_daily from authenticated;

-- Latido de la zona del alumno: suma un minuto como mucho por llamada. Si
-- llegan avisos más seguidos (varias pestañas), no suman de más.
create or replace function public.track_presence()
returns void
language plpgsql security definer set search_path = '' as $$
declare
  v_uid uuid := auth.uid();
  v_day date := (now() at time zone 'Europe/Madrid')::date;
begin
  if v_uid is null then
    return;
  end if;
  insert into public.user_presence_daily as d (user_id, day, seconds)
  values (v_uid, v_day, 60)
  on conflict (user_id, day) do update
     set seconds = least(d.seconds + 60, 86400), last_seen = now()
   where d.last_seen <= now() - interval '50 seconds';
  -- conservación: 12 meses
  delete from public.user_presence_daily
   where user_id = v_uid and day < v_day - 366;
end $$;
revoke execute on function public.track_presence() from public, anon;
grant execute on function public.track_presence() to authenticated;

-- ---------------------------------------------------------------------
-- Códigos promocionales creados desde el panel
-- ---------------------------------------------------------------------
create table if not exists public.admin_promo_codes (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users (id) on delete cascade,
  code text not null check (code ~ '^[A-Z0-9-]{3,40}$'),
  provider text not null check (provider in ('stripe_test', 'stripe')),
  coupon_ref text not null,
  promotion_code_ref text not null unique,
  percent_off numeric(5, 2) check (percent_off > 0 and percent_off <= 100),
  amount_off_cents integer check (amount_off_cents > 0),
  duration text not null check (duration in ('once', 'repeating', 'forever')),
  duration_in_months smallint check (duration_in_months between 1 and 36),
  expires_at timestamptz,
  note text check (char_length(note) <= 500),
  created_by uuid references auth.users (id) on delete set null,
  created_at timestamptz not null default now(),
  check ((percent_off is null) <> (amount_off_cents is null)),
  check ((duration = 'repeating') = (duration_in_months is not null))
);
create index if not exists admin_promo_codes_user_idx on public.admin_promo_codes (user_id, created_at desc);
alter table public.admin_promo_codes enable row level security;
drop policy if exists "promo_codes: admin" on public.admin_promo_codes;
create policy "promo_codes: admin" on public.admin_promo_codes
  for select to authenticated using (public.is_admin());
revoke all on public.admin_promo_codes from anon;
revoke insert, update, delete, truncate on public.admin_promo_codes from authenticated;

create or replace function public.admin_record_promo_code(
  p_user uuid, p_code text, p_provider text, p_coupon_ref text, p_promotion_code_ref text,
  p_percent_off numeric, p_amount_off_cents integer, p_duration text, p_duration_in_months int,
  p_expires_at timestamptz, p_note text)
returns uuid
language plpgsql security definer set search_path = '' as $$
declare
  v_id uuid;
begin
  if not public.is_admin() then
    raise exception 'Solo administradores' using errcode = '42501';
  end if;
  if not exists (select 1 from auth.users where id = p_user) then
    raise exception 'Usuario no encontrado' using errcode = '22023';
  end if;
  insert into public.admin_promo_codes (user_id, code, provider, coupon_ref, promotion_code_ref,
                                        percent_off, amount_off_cents, duration, duration_in_months,
                                        expires_at, note, created_by)
  values (p_user, p_code, p_provider, p_coupon_ref, p_promotion_code_ref, p_percent_off,
          p_amount_off_cents, p_duration, p_duration_in_months, p_expires_at,
          nullif(p_note, ''), auth.uid())
  returning id into v_id;
  perform public.log_admin_action('promo_code.created', 'profile', p_user::text,
          jsonb_build_object('code', p_code, 'percent_off', p_percent_off,
                             'amount_off_cents', p_amount_off_cents, 'duration', p_duration));
  return v_id;
end $$;
revoke execute on function public.admin_record_promo_code(uuid, text, text, text, text, numeric,
  integer, text, int, timestamptz, text) from public, anon;
grant execute on function public.admin_record_promo_code(uuid, text, text, text, text, numeric,
  integer, text, int, timestamptz, text) to authenticated;

-- ---------------------------------------------------------------------
-- Premium regalado (sin Stripe)
-- ---------------------------------------------------------------------
create or replace function public.admin_grant_premium(p_user uuid, p_product uuid,
                                                      p_days int default null,
                                                      p_note text default null)
returns uuid
language plpgsql security definer set search_path = '' as $$
declare
  v_id uuid;
begin
  if not public.is_admin() then
    raise exception 'Solo administradores' using errcode = '42501';
  end if;
  if p_days is not null and (p_days < 1 or p_days > 3650) then
    raise exception 'Días no válidos' using errcode = '22023';
  end if;
  if not exists (select 1 from public.products
                  where id = p_product and type = 'subscription' and status <> 'archived') then
    raise exception 'Producto no disponible' using errcode = '22023';
  end if;
  if not exists (select 1 from auth.users where id = p_user) then
    raise exception 'Usuario no encontrado' using errcode = '22023';
  end if;
  insert into public.subscriptions (user_id, product_id, status, current_period_end, provider)
  values (p_user, p_product, 'active',
          case when p_days is null then null else now() + make_interval(days => p_days) end,
          'none')
  returning id into v_id;
  perform public.log_admin_action('premium.granted', 'profile', p_user::text,
          jsonb_build_object('product', p_product, 'days', p_days, 'subscription', v_id,
                             'note', nullif(p_note, '')));
  return v_id;
end $$;

create or replace function public.admin_end_premium(p_subscription uuid)
returns void
language plpgsql security definer set search_path = '' as $$
declare
  v_user uuid;
begin
  if not public.is_admin() then
    raise exception 'Solo administradores' using errcode = '42501';
  end if;
  -- solo las regaladas: las de Stripe se cancelan en Stripe (y llega el webhook)
  update public.subscriptions
     set status = 'canceled', current_period_end = least(coalesce(current_period_end, now()), now())
   where id = p_subscription and provider = 'none' and status in ('active', 'trialing')
  returning user_id into v_user;
  if v_user is null then
    raise exception 'Suscripción no encontrada' using errcode = '22023';
  end if;
  perform public.log_admin_action('premium.ended', 'profile', v_user::text,
          jsonb_build_object('subscription', p_subscription));
end $$;
revoke execute on function public.admin_grant_premium(uuid, uuid, int, text) from public, anon;
revoke execute on function public.admin_end_premium(uuid) from public, anon;
grant execute on function public.admin_grant_premium(uuid, uuid, int, text) to authenticated;
grant execute on function public.admin_end_premium(uuid) to authenticated;

-- ---------------------------------------------------------------------
-- Ficha completa
-- ---------------------------------------------------------------------
create or replace function public.admin_user_insights(p_id uuid)
returns jsonb
language plpgsql security definer set search_path = '' as $$
declare
  v_today date := (now() at time zone 'Europe/Madrid')::date;
  v jsonb;
begin
  if not public.is_admin() then
    raise exception 'Solo administradores' using errcode = '42501';
  end if;
  if not exists (select 1 from auth.users where id = p_id) then
    return null;
  end if;
  select jsonb_build_object(
    'subscriptions', coalesce((select jsonb_agg(jsonb_build_object(
        'id', s.id, 'product', p.title, 'status', s.status, 'provider', s.provider,
        'current_period_end', s.current_period_end, 'cancel_at_period_end', s.cancel_at_period_end,
        'created_at', s.created_at,
        'active', s.status in ('active', 'trialing')
                  and (s.current_period_end is null or s.current_period_end > now()))
        order by s.created_at desc)
      from public.subscriptions s join public.products p on p.id = s.product_id
      where s.user_id = p_id), '[]'::jsonb),
    'grants', coalesce((select jsonb_agg(jsonb_build_object(
        'id', g.id, 'product', p.title, 'product_type', p.type, 'source', g.source,
        'note', g.note, 'starts_at', g.starts_at, 'ends_at', g.ends_at, 'created_at', g.created_at,
        'attempts', (p.config->>'attempts')::int,
        'status', case when g.revoked_at is not null then 'revoked'
                       when g.ends_at is not null and g.ends_at <= now() then 'expired'
                       else 'active' end)
        order by g.created_at desc)
      from public.access_grants g join public.products p on p.id = g.product_id
      where g.user_id = p_id), '[]'::jsonb),
    'orders', coalesce((select jsonb_agg(jsonb_build_object(
        'id', o.id, 'status', o.status, 'total_cents', o.total_cents, 'currency', o.currency,
        'provider', o.provider, 'created_at', o.created_at,
        'products', (select string_agg(p.title, ', ') from public.order_items oi
                       join public.products p on p.id = oi.product_id where oi.order_id = o.id))
        order by o.created_at desc)
      from public.orders o where o.user_id = p_id), '[]'::jsonb),
    'promo_codes', coalesce((select jsonb_agg(jsonb_build_object(
        'id', c.id, 'code', c.code, 'provider', c.provider, 'percent_off', c.percent_off,
        'amount_off_cents', c.amount_off_cents, 'duration', c.duration,
        'duration_in_months', c.duration_in_months, 'expires_at', c.expires_at,
        'note', c.note, 'created_at', c.created_at)
        order by c.created_at desc)
      from public.admin_promo_codes c where c.user_id = p_id), '[]'::jsonb),
    -- entradas y salidas según Auth (sin IP ni dispositivo)
    'sessions', coalesce((select jsonb_agg(x order by x.created_at desc) from (
        select a.payload->>'action' as action, a.created_at
          from auth.audit_log_entries a
         where a.payload->>'actor_id' = p_id::text
           and a.payload->>'action' in ('login', 'logout', 'user_signedup', 'user_confirmation_requested',
                                        'user_recovery_requested', 'user_updated_password')
         order by a.created_at desc limit 50) x), '[]'::jsonb),
    'presence', jsonb_build_object(
      'today_seconds', coalesce((select seconds from public.user_presence_daily
                                  where user_id = p_id and day = v_today), 0),
      'last7_seconds', coalesce((select sum(seconds) from public.user_presence_daily
                                  where user_id = p_id and day > v_today - 7), 0),
      'last30_seconds', coalesce((select sum(seconds) from public.user_presence_daily
                                   where user_id = p_id and day > v_today - 30), 0),
      'days', coalesce((select jsonb_agg(jsonb_build_object(
                 'day', d.day, 'seconds', d.seconds, 'first_seen', d.first_seen,
                 'last_seen', d.last_seen) order by d.day desc)
               from public.user_presence_daily d
               where d.user_id = p_id and d.day > v_today - 30), '[]'::jsonb)),
    'study', jsonb_build_object(
      'practice_count', (select count(*) from public.practice_sessions
                          where user_id = p_id and answered_count > 0),
      'answered', (select coalesce(sum(answered_count), 0) from public.practice_sessions
                    where user_id = p_id),
      'correct', (select coalesce(sum(correct_count), 0) from public.practice_sessions
                   where user_id = p_id),
      'answer_seconds', (select coalesce(sum(total_time_ms), 0) / 1000 from public.practice_sessions
                          where user_id = p_id),
      'mock_count', (select count(*) from public.mock_attempts where user_id = p_id),
      'recent', coalesce((select jsonb_agg(r order by r.started_at desc) from (
          select * from (
            select 'practice' as kind, s.started_at, s.finished_at, s.status::text as status,
                   s.mode::text as mode, s.item_type, s.answered_count::int as answered,
                   s.correct_count::int as correct, s.item_count::int as total,
                   (select min(t.title) from public.practice_items i
                      join public.questions q on q.id = i.question_id
                      join public.topics t on t.id = q.topic_id
                     where i.session_id = s.id
                    having count(distinct t.id) = 1) as title,
                   null::numeric as mark, null::numeric as max_mark, null::boolean as passed
              from public.practice_sessions s
             where s.user_id = p_id and (s.answered_count > 0 or s.status = 'active')
            union all
            select 'mock', a.started_at, a.submitted_at, a.status::text, 'mock', null,
                   (coalesce(a.correct_count, 0) + coalesce(a.wrong_count, 0))::int,
                   coalesce(a.correct_count, 0)::int, a.item_count::int, a.title, a.mark,
                   coalesce((a.config->>'max_mark')::numeric, 10), a.passed
              from public.mock_attempts a where a.user_id = p_id
          ) u order by u.started_at desc limit 40) r), '[]'::jsonb))
  ) into v;
  perform public.log_admin_action('user.insights_viewed', 'profile', p_id::text);
  return v;
end $$;
revoke execute on function public.admin_user_insights(uuid) from public, anon;
grant execute on function public.admin_user_insights(uuid) to authenticated;

-- ---------------------------------------------------------------------
-- Exportación RGPD: añade el tiempo dentro
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
    'time_in_app', coalesce((select jsonb_agg(jsonb_build_object('day', d.day, 'seconds', d.seconds,
                                                                 'first_seen', d.first_seen,
                                                                 'last_seen', d.last_seen) order by d.day)
                          from public.user_presence_daily d where d.user_id = v_uid), '[]'::jsonb),
    'practice_sessions', coalesce((select jsonb_agg(to_jsonb(s) - 'user_id' order by s.started_at)
                          from public.practice_sessions s where s.user_id = v_uid), '[]'::jsonb),
    'practice_answers', coalesce((select jsonb_agg(to_jsonb(i) - 'user_id' order by i.answered_at)
                          from public.practice_items i where i.user_id = v_uid and i.answered_at is not null),
                          '[]'::jsonb),
    'orders', coalesce((select jsonb_agg(to_jsonb(o) - 'user_id' order by o.created_at)
                          from public.orders o where o.user_id = v_uid), '[]'::jsonb),
    'subscriptions', coalesce((select jsonb_agg(to_jsonb(s) - 'user_id' order by s.created_at)
                          from public.subscriptions s where s.user_id = v_uid), '[]'::jsonb),
    'access_grants', coalesce((select jsonb_agg((to_jsonb(g) - 'user_id' - 'granted_by') order by g.created_at)
                          from public.access_grants g where g.user_id = v_uid), '[]'::jsonb)
  );
end $$;
revoke execute on function public.export_my_data() from anon, public;
grant execute on function public.export_my_data() to authenticated;
