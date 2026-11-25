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
