-- ADR-037: cifras de audiencia para el panel de administración.
-- Cuántas personas se han registrado, cuántas han entrado (inicio de sesión)
-- y cuántas visitas ha contado traffic_daily (ADR-025). Solo agregados: no
-- devuelve correos ni identificadores. auth.users solo es legible con
-- SECURITY DEFINER, y la función comprueba is_admin(). Las visitas usan el
-- mismo día que traffic_daily (current_date); las altas y entradas de «hoy»,
-- la medianoche de Madrid.

-- Personas distintas (cuentas que siguen existiendo) que han iniciado sesión o
-- renovado la sesión desde p_from, según el registro de auditoría de Auth.
create or replace function public.admin_distinct_logins(p_from timestamptz)
returns bigint
language sql stable security definer set search_path = '' as $$
  select count(distinct u.id)
    from auth.audit_log_entries a
    join auth.users u on u.id::text = a.payload->>'actor_id'
   where a.created_at >= p_from
     and a.payload->>'action' in ('login', 'token_refreshed');
$$;
revoke execute on function public.admin_distinct_logins(timestamptz) from public, anon, authenticated;

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
    'logins_today', public.admin_distinct_logins(v_today),
    'logins_7d', public.admin_distinct_logins(now() - interval '7 days'),
    'logins_30d', public.admin_distinct_logins(now() - interval '30 days'),
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

-- Serie diaria para la gráfica del panel: visitas, registros nuevos y personas
-- que han entrado cada día (inicio de sesión o sesión renovada, según el
-- registro de auditoría de Auth; cada persona cuenta una vez por día).
create or replace function public.admin_audience_daily(p_days integer default 30)
returns table (day date, visits bigint, signups bigint, logins bigint)
language plpgsql stable security definer set search_path = '' as $$
declare
  v_days integer := least(greatest(coalesce(p_days, 30), 1), 90);
  v_end date := (now() at time zone 'Europe/Madrid')::date;
  v_start date := v_end - (v_days - 1);
  v_from timestamptz := v_start::timestamp at time zone 'Europe/Madrid';
begin
  if not public.is_admin() then
    raise exception 'Solo administradores' using errcode = '42501';
  end if;
  return query
  with days as (
    select d::date as day from generate_series(v_start, v_end, interval '1 day') d
  ),
  v as (
    select t.day, sum(t.hits)::bigint as n from public.traffic_daily t
     where t.kind = 'visit' and t.day >= v_start group by t.day
  ),
  s as (
    select (u.created_at at time zone 'Europe/Madrid')::date as day, count(*)::bigint as n
      from auth.users u where u.created_at >= v_from group by 1
  ),
  l as (
    select (a.created_at at time zone 'Europe/Madrid')::date as day,
           count(distinct u.id)::bigint as n
      from auth.audit_log_entries a
      join auth.users u on u.id::text = a.payload->>'actor_id'
     where a.created_at >= v_from
       and a.payload->>'action' in ('login', 'token_refreshed')
     group by 1
  )
  select d.day, coalesce(v.n, 0), coalesce(s.n, 0), coalesce(l.n, 0)
    from days d
    left join v on v.day = d.day
    left join s on s.day = d.day
    left join l on l.day = d.day
   order by d.day;
end $$;
revoke execute on function public.admin_audience_daily(integer) from public, anon;
grant execute on function public.admin_audience_daily(integer) to authenticated;
