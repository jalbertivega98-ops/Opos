-- ADR-037: cifras de audiencia para el panel de administración.
-- Cuántas personas se han registrado, cuántas han entrado (inicio de sesión)
-- y cuántas visitas ha contado traffic_daily (ADR-025). Solo agregados: no
-- devuelve correos ni identificadores. auth.users solo es legible con
-- SECURITY DEFINER, y la función comprueba is_admin(). Las visitas usan el
-- mismo día que traffic_daily (current_date); las altas y entradas de «hoy»,
-- la medianoche de Madrid.

create or replace function public.admin_audience_metrics()
returns jsonb
language plpgsql stable security definer set search_path = '' as $$
declare
  v_today timestamptz := date_trunc('day', now() at time zone 'Europe/Madrid') at time zone 'Europe/Madrid';
begin
  if not public.is_admin() then
    raise exception 'Solo administradores' using errcode = '42501';
  end if;
  return jsonb_build_object(
    'users_total', (select count(*) from auth.users where deleted_at is null),
    'users_confirmed', (select count(*) from auth.users
                         where deleted_at is null and email_confirmed_at is not null),
    'signups_today', (select count(*) from auth.users where created_at >= v_today),
    'signups_7d', (select count(*) from auth.users where created_at >= now() - interval '7 days'),
    'signups_30d', (select count(*) from auth.users where created_at >= now() - interval '30 days'),
    'logins_today', (select count(*) from auth.users where last_sign_in_at >= v_today),
    'logins_7d', (select count(*) from auth.users where last_sign_in_at >= now() - interval '7 days'),
    'logins_30d', (select count(*) from auth.users where last_sign_in_at >= now() - interval '30 days'),
    'visits_today', (select coalesce(sum(hits), 0) from public.traffic_daily
                      where kind = 'visit' and day >= current_date),
    'visits_7d', (select coalesce(sum(hits), 0) from public.traffic_daily
                   where kind = 'visit' and day >= current_date - 6),
    'visits_30d', (select coalesce(sum(hits), 0) from public.traffic_daily
                    where kind = 'visit' and day >= current_date - 29)
  );
end $$;
revoke execute on function public.admin_audience_metrics() from public, anon;
grant execute on function public.admin_audience_metrics() to authenticated;
