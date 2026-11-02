-- =====================================================================
-- 0500 · Gestión de alumnos para administración
-- El email vive en auth.users (no expuesto por la API): se accede solo
-- mediante funciones que exigen is_admin() y dejan rastro en audit_log.
-- =====================================================================

create or replace function public.admin_list_users(
  p_query text default null,
  p_status public.account_status default null,
  p_role public.app_role default null,
  p_exam text default null,
  p_onboarded boolean default null,
  p_limit int default 25,
  p_offset int default 0
)
returns table (
  id uuid, email text, display_name text, role public.app_role, status public.account_status,
  locale public.locale_code, created_at timestamptz, last_active_at timestamptz,
  onboarding_completed_at timestamptz, primary_exam text, total_count bigint
)
language plpgsql stable security definer set search_path = '' as $$
declare
  v_q text := nullif(trim(coalesce(p_query, '')), '');
begin
  if not public.is_admin() then
    raise exception 'No autorizado' using errcode = '42501';
  end if;
  if v_q is not null then
    v_q := '%' || replace(replace(replace(left(v_q, 80), '\', '\\'), '%', '\%'), '_', '\_') || '%';
  end if;
  return query
  select p.id, u.email::text, p.display_name, p.role, p.status, p.locale, p.created_at,
         p.last_active_at, p.onboarding_completed_at,
         (select b.name from public.user_exam_targets t
            join public.exam_bodies b on b.id = t.exam_body_id
           where t.user_id = p.id and t.is_primary limit 1),
         count(*) over ()
  from public.profiles p
  join auth.users u on u.id = p.id
  where (v_q is null or u.email ilike v_q or p.display_name ilike v_q)
    and (p_status is null or p.status = p_status)
    and (p_role is null or p.role = p_role)
    and (p_onboarded is null or (p.onboarding_completed_at is not null) = p_onboarded)
    and (p_exam is null or exists (
          select 1 from public.user_exam_targets t join public.exam_bodies b on b.id = t.exam_body_id
           where t.user_id = p.id and b.slug = p_exam))
  order by p.created_at desc
  limit least(greatest(coalesce(p_limit, 25), 1), 5000)
  offset greatest(coalesce(p_offset, 0), 0);
end $$;
revoke execute on function public.admin_list_users(text, public.account_status, public.app_role, text, boolean, int, int) from anon, public;
grant execute on function public.admin_list_users(text, public.account_status, public.app_role, text, boolean, int, int) to authenticated;

-- Ficha de un alumno. Registra la consulta en auditoría.
create or replace function public.admin_get_user(p_id uuid)
returns jsonb
language plpgsql security definer set search_path = '' as $$
declare
  v jsonb;
begin
  if not public.is_admin() then
    raise exception 'No autorizado' using errcode = '42501';
  end if;
  select jsonb_build_object(
    'id', p.id, 'email', u.email, 'email_confirmed_at', u.email_confirmed_at,
    'last_sign_in_at', u.last_sign_in_at, 'display_name', p.display_name, 'role', p.role,
    'status', p.status, 'locale', p.locale, 'created_at', p.created_at,
    'last_active_at', p.last_active_at, 'onboarding_completed_at', p.onboarding_completed_at,
    'marketing_consent', p.marketing_consent,
    'targets', coalesce((select jsonb_agg(jsonb_build_object('exam', b.slug, 'name', b.name,
                 'is_primary', t.is_primary, 'follow_only', t.follow_only, 'level', t.level,
                 'weekly_hours', t.weekly_hours, 'goals', t.goals) order by t.is_primary desc)
               from public.user_exam_targets t join public.exam_bodies b on b.id = t.exam_body_id
               where t.user_id = p.id), '[]'::jsonb),
    'activity', coalesce((select jsonb_agg(x order by x.created_at desc) from (
                 select a.kind, a.created_at from public.activity_events a
                  where a.user_id = p.id order by a.created_at desc limit 20) x), '[]'::jsonb)
  ) into v
  from public.profiles p join auth.users u on u.id = p.id
  where p.id = p_id;
  if v is not null then
    insert into public.audit_log (actor_id, action, target_type, target_id)
    values (auth.uid(), 'user.viewed', 'profile', p_id::text);
  end if;
  return v;
end $$;
revoke execute on function public.admin_get_user(uuid) from anon, public;
grant execute on function public.admin_get_user(uuid) to authenticated;

-- Suspender / reactivar (no aplica a staff salvo que lo haga el owner).
create or replace function public.admin_set_user_status(p_id uuid, p_status public.account_status)
returns void
language plpgsql security definer set search_path = '' as $$
declare
  v_target_role public.app_role;
begin
  if not public.is_admin() then
    raise exception 'No autorizado' using errcode = '42501';
  end if;
  if p_id = auth.uid() then
    raise exception 'No puedes cambiar el estado de tu propia cuenta' using errcode = '42501';
  end if;
  select role into v_target_role from public.profiles where id = p_id;
  if v_target_role is null then
    raise exception 'Usuario no encontrado' using errcode = 'P0002';
  end if;
  if v_target_role in ('admin', 'owner') and public.current_role_rank() < 4 then
    raise exception 'Solo el propietario puede suspender administradores' using errcode = '42501';
  end if;
  update public.profiles set status = p_status where id = p_id;
  insert into public.audit_log (actor_id, action, target_type, target_id, metadata)
  values (auth.uid(), 'user.status_changed', 'profile', p_id::text, jsonb_build_object('status', p_status));
end $$;
revoke execute on function public.admin_set_user_status(uuid, public.account_status) from anon, public;
grant execute on function public.admin_set_user_status(uuid, public.account_status) to authenticated;
