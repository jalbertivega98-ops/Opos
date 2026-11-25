-- Resumen del panel de administración (ADR-072): las cifras clave de un periodo
-- de N días (hora de Madrid, hoy incluido) y las del periodo anterior de la
-- misma duración, para que el panel diga si cada cifra sube o baja.
--   · visitas (traffic_daily), cuentas nuevas (auth.users), alumnos que practican
--     (practice_sessions), ventas de packs pagadas en Stripe real (orders) y
--     Premium nuevos de pago (subscriptions, provider 'stripe').
--   · foto de hoy: Premium de pago activos, Premium regalados activos e ingreso
--     mensual estimado (precio de lista de cada suscripción; anual = /12).
-- Las renovaciones de Premium no se guardan como pedido: el total exacto está en
-- Stripe. Solo agregados, SECURITY DEFINER y comprobación de is_admin().

create or replace function public.admin_overview(p_days integer default 30)
returns jsonb
language plpgsql stable security definer set search_path = '' as $$
declare
  v_days integer := least(greatest(coalesce(p_days, 30), 1), 90);
  v_end date := (now() at time zone 'Europe/Madrid')::date;
  v_cur_start date := v_end - (v_days - 1);
  v_prev_start date := v_cur_start - v_days;
  v_cur_from timestamptz := v_cur_start::timestamp at time zone 'Europe/Madrid';
  v_prev_from timestamptz := v_prev_start::timestamp at time zone 'Europe/Madrid';
  v_cur jsonb;
  v_prev jsonb;
begin
  if not public.is_admin() then
    raise exception 'Solo administradores' using errcode = '42501';
  end if;

  select jsonb_build_object(
           'visits', coalesce(sum(t.hits) filter (where t.day >= v_cur_start), 0),
           'prev_visits', coalesce(sum(t.hits) filter (where t.day < v_cur_start), 0))
    into v_cur
    from public.traffic_daily t
   where t.kind = 'visit' and t.day >= v_prev_start and t.day <= v_end;

  with w as (
    select 'cur' as k, v_cur_from as f, now() + interval '1 day' as t
    union all
    select 'prev', v_prev_from, v_cur_from
  ),
  agg as (
    select w.k,
      (select count(*) from auth.users u
        where u.created_at >= w.f and u.created_at < w.t) as signups,
      (select count(distinct s.user_id) from public.practice_sessions s
        where s.started_at >= w.f and s.started_at < w.t) as practicing,
      (select count(*) from public.orders o
        where o.status = 'paid' and o.provider = 'stripe'
          and coalesce(o.paid_at, o.created_at) >= w.f
          and coalesce(o.paid_at, o.created_at) < w.t) as pack_sales,
      (select coalesce(sum(o.total_cents), 0) from public.orders o
        where o.status = 'paid' and o.provider = 'stripe'
          and coalesce(o.paid_at, o.created_at) >= w.f
          and coalesce(o.paid_at, o.created_at) < w.t) as pack_revenue_cents,
      (select count(*) from public.subscriptions s
        where s.provider = 'stripe' and s.created_at >= w.f and s.created_at < w.t) as new_premium,
      (select coalesce(sum(p.amount_cents), 0) from public.subscriptions s
         left join public.product_prices p on p.id = s.price_id
        where s.provider = 'stripe' and s.created_at >= w.f and s.created_at < w.t)
        as new_premium_cents
    from w
  )
  select jsonb_build_object(
           'current', (select jsonb_build_object(
               'visits', (v_cur->>'visits')::bigint, 'signups', a.signups,
               'practicing', a.practicing, 'pack_sales', a.pack_sales,
               'pack_revenue_cents', a.pack_revenue_cents, 'new_premium', a.new_premium,
               'new_premium_cents', a.new_premium_cents) from agg a where a.k = 'cur'),
           'previous', (select jsonb_build_object(
               'visits', (v_cur->>'prev_visits')::bigint, 'signups', a.signups,
               'practicing', a.practicing, 'pack_sales', a.pack_sales,
               'pack_revenue_cents', a.pack_revenue_cents, 'new_premium', a.new_premium,
               'new_premium_cents', a.new_premium_cents) from agg a where a.k = 'prev'))
    into v_prev;

  return v_prev || jsonb_build_object(
    'days', v_days,
    'from', v_cur_start,
    'to', v_end,
    'prev_from', v_prev_start,
    'premium_paid_active', (select count(*) from public.subscriptions s
                             where s.provider = 'stripe'
                               and s.status in ('active', 'trialing', 'past_due')),
    'premium_gift_active', (select count(*) from public.subscriptions s
                             where s.provider = 'none' and s.status in ('active', 'trialing')
                               and (s.current_period_end is null or s.current_period_end > now())),
    'mrr_cents', (select coalesce(sum(case when p.billing_interval = 'year'
                                           then p.amount_cents / 12.0
                                           else p.amount_cents end), 0)::bigint
                    from public.subscriptions s
                    join public.product_prices p on p.id = s.price_id
                   where s.provider = 'stripe' and s.status in ('active', 'trialing', 'past_due')
                     and not s.cancel_at_period_end)
  );
end $$;
revoke execute on function public.admin_overview(integer) from public, anon;
grant execute on function public.admin_overview(integer) to authenticated;

-- Alumnos que más usan la web en el periodo y últimos en usarla (ADR-072).
-- Uso = tiempo con la zona del alumno abierta (user_presence_daily), preguntas
-- respondidas (practice_items) y días con actividad. Última vez = lo más
-- reciente entre latido, respuesta, inicio de sesión y actividad registrada.
-- Fuera las cuentas de administración. Solo administradores.
create or replace function public.admin_user_ranking(p_days integer default 30, p_limit integer default 10)
returns jsonb
language plpgsql stable security definer set search_path = '' as $$
declare
  v_days integer := least(greatest(coalesce(p_days, 30), 1), 90);
  v_limit integer := least(greatest(coalesce(p_limit, 10), 1), 50);
  v_start date := (now() at time zone 'Europe/Madrid')::date - (v_days - 1);
  v_from timestamptz := v_start::timestamp at time zone 'Europe/Madrid';
begin
  if not public.is_admin() then
    raise exception 'Solo administradores' using errcode = '42501';
  end if;
  return (
    with students as (
      select u.id, u.email::text as email, p.display_name, u.last_sign_in_at
        from auth.users u
        join public.profiles p on p.id = u.id
       where u.deleted_at is null and p.role not in ('admin', 'owner')
    ),
    pres as (
      select d.user_id,
             sum(d.seconds) filter (where d.day >= v_start) as seconds,
             count(*) filter (where d.day >= v_start and d.seconds > 0) as days,
             max(d.last_seen) as last_seen
        from public.user_presence_daily d group by d.user_id
    ),
    ans as (
      select i.user_id,
             count(*) filter (where i.answered_at >= v_from) as answers,
             max(i.answered_at) as last_answer
        from public.practice_items i
       where i.answered_at is not null group by i.user_id
    ),
    act as (
      select e.user_id, max(e.created_at) as last_event
        from public.activity_events e group by e.user_id
    ),
    prem as (
      select distinct s.user_id from public.subscriptions s
       where s.status in ('active', 'trialing', 'past_due')
         and (s.provider <> 'none' or s.current_period_end is null or s.current_period_end > now())
    ),
    rows as (
      select s.id, s.email, s.display_name,
             coalesce(pr.seconds, 0) as seconds,
             coalesce(pr.days, 0) as days,
             coalesce(a.answers, 0) as answers,
             nullif(greatest(coalesce(pr.last_seen, '-infinity'), coalesce(a.last_answer, '-infinity'),
                             coalesce(s.last_sign_in_at, '-infinity'), coalesce(ac.last_event, '-infinity')),
                    '-infinity'::timestamptz) as last_seen,
             (pm.user_id is not null) as premium
        from students s
        left join pres pr on pr.user_id = s.id
        left join ans a on a.user_id = s.id
        left join act ac on ac.user_id = s.id
        left join prem pm on pm.user_id = s.id
    ),
    to_json as (
      select r.*, jsonb_build_object(
               'id', r.id, 'email', r.email, 'name', r.display_name, 'seconds', r.seconds,
               'days', r.days, 'answers', r.answers, 'last_seen', r.last_seen,
               'premium', r.premium) as j
        from rows r
    )
    select jsonb_build_object(
      'days', v_days,
      'top', coalesce((select jsonb_agg(t.j order by t.seconds desc, t.answers desc, t.last_seen desc)
                         from (select * from to_json
                                where seconds > 0 or answers > 0
                                order by seconds desc, answers desc, last_seen desc
                                limit v_limit) t), '[]'::jsonb),
      'recent', coalesce((select jsonb_agg(t.j order by t.last_seen desc)
                            from (select * from to_json where last_seen is not null
                                   order by last_seen desc limit v_limit) t), '[]'::jsonb)
    )
  );
end $$;
revoke execute on function public.admin_user_ranking(integer, integer) from public, anon;
grant execute on function public.admin_user_ranking(integer, integer) to authenticated;
