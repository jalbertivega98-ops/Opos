-- =====================================================================
-- 0400 · Perfil editable y derechos RGPD (exportación y supresión)
-- =====================================================================

-- Columnas que un usuario autenticado puede actualizar vía API.
-- role/status siguen protegidos por el trigger profiles_protect (solo admin/owner).
-- last_active_at y deletion_requested_at solo los cambian funciones del sistema.
revoke update on public.profiles from authenticated;
grant update (display_name, locale, marketing_consent, onboarding_completed_at, role, status)
  on public.profiles to authenticated;

-- Nuevos tipos de actividad permitidos.
create or replace function public.track_activity(p_kind text, p_metadata jsonb default '{}'::jsonb)
returns void
language plpgsql security definer set search_path = '' as $$
begin
  if auth.uid() is null then
    raise exception 'Sesión requerida' using errcode = '42501';
  end if;
  if p_kind not in ('auth.sign_in', 'auth.sign_up', 'onboarding.completed', 'exam.followed',
                    'exam.unfollowed', 'profile.updated', 'practice.started', 'practice.completed',
                    'account.exported') then
    raise exception 'Tipo de actividad no permitido' using errcode = '22023';
  end if;
  insert into public.activity_events (user_id, kind, metadata)
  values (auth.uid(), p_kind, coalesce(p_metadata, '{}'::jsonb));
  update public.profiles set last_active_at = now() where id = auth.uid();
end $$;

-- Exportación de datos personales (derecho de acceso/portabilidad).
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
                          from public.activity_events a where a.user_id = v_uid), '[]'::jsonb)
  );
end $$;
revoke execute on function public.export_my_data() from anon, public;
grant execute on function public.export_my_data() to authenticated;

-- Supresión de la propia cuenta (derecho de supresión).
-- Borra auth.users => cascada a perfiles, objetivos y actividad. Deja rastro anónimo en auditoría.
create or replace function public.delete_my_account()
returns void
language plpgsql security definer set search_path = '' as $$
declare
  v_uid uuid := auth.uid();
  v_role public.app_role;
begin
  if v_uid is null then
    raise exception 'Sesión requerida' using errcode = '42501';
  end if;
  select role into v_role from public.profiles where id = v_uid;
  if v_role = 'owner' then
    raise exception 'El propietario no puede eliminar su cuenta desde la app' using errcode = '42501';
  end if;
  insert into public.audit_log (actor_id, action, target_type, target_id, metadata)
  values (null, 'account.deleted_by_user', 'profile', v_uid::text, '{}'::jsonb);
  delete from auth.users where id = v_uid;
end $$;
revoke execute on function public.delete_my_account() from anon, public;
grant execute on function public.delete_my_account() to authenticated;
