-- Copia de supabase/migrations/20261109000100_admin_logins_presence.sql (ADR-044).
-- «Han entrado» del panel de administración con varias fuentes. Idempotente.
begin;
-- «Han entrado» en el panel de administración marcaba 0 en producción aunque
-- había alumnos activos: Supabase Cloud ya no siempre guarda el inicio de sesión
-- en auth.audit_log_entries. Ahora una persona «ha entrado» un día si consta en
-- cualquiera de estas fuentes (cada persona cuenta una vez por día):
--   · auth.audit_log_entries (login o sesión renovada), si las hay;
--   · auth.users.last_sign_in_at (último inicio de sesión);
--   · public.user_presence_daily (latido de la zona del alumno, ADR-038);
--   · public.activity_events (cualquier actividad registrada).
-- Solo agregados, SECURITY DEFINER y comprobación de is_admin() como antes.

create or replace function public.admin_login_days(p_from timestamptz)
returns table (user_id uuid, day date)
language sql stable security definer set search_path = '' as $$
  select distinct x.user_id, x.day
    from (
      select u.id as user_id, (a.created_at at time zone 'Europe/Madrid')::date as day
        from auth.audit_log_entries a
        join auth.users u on u.id::text = a.payload->>'actor_id'
       where a.created_at >= p_from
         and a.payload->>'action' in ('login', 'token_refreshed')
      union all
      select u.id, (u.last_sign_in_at at time zone 'Europe/Madrid')::date
        from auth.users u
       where u.last_sign_in_at >= p_from
      union all
      select p.user_id, p.day
        from public.user_presence_daily p
       where p.last_seen >= p_from
      union all
      select e.user_id, (e.created_at at time zone 'Europe/Madrid')::date
        from public.activity_events e
       where e.created_at >= p_from
    ) x
    join auth.users u2 on u2.id = x.user_id and u2.deleted_at is null;
$$;
revoke execute on function public.admin_login_days(timestamptz) from public, anon, authenticated;

create or replace function public.admin_distinct_logins(p_from timestamptz)
returns bigint
language sql stable security definer set search_path = '' as $$
  select count(distinct d.user_id) from public.admin_login_days(p_from) d;
$$;
revoke execute on function public.admin_distinct_logins(timestamptz) from public, anon, authenticated;

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
    select ld.day, count(distinct ld.user_id)::bigint as n
      from public.admin_login_days(v_from) ld
     group by ld.day
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
commit;
