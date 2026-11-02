-- =====================================================================
-- 0100 · Identidad: perfiles, roles, auditoría y actividad
-- =====================================================================

create type public.app_role as enum ('student', 'editor', 'admin', 'owner');
create type public.account_status as enum ('active', 'suspended', 'pending_deletion');
create type public.locale_code as enum ('es', 'ca');

-- ---------------------------------------------------------------------
-- Perfiles (1:1 con auth.users). Solo datos imprescindibles (minimización RGPD).
-- ---------------------------------------------------------------------
create table public.profiles (
  id uuid primary key references auth.users (id) on delete cascade,
  display_name text check (char_length(display_name) between 1 and 80),
  locale public.locale_code not null default 'es',
  role public.app_role not null default 'student',
  status public.account_status not null default 'active',
  onboarding_completed_at timestamptz,
  last_active_at timestamptz,
  marketing_consent boolean not null default false,
  marketing_consent_at timestamptz,
  deletion_requested_at timestamptz,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);
comment on table public.profiles is 'Perfil del alumno o del personal. El email vive en auth.users.';

create index profiles_role_idx on public.profiles (role) where role <> 'student';
create index profiles_created_at_idx on public.profiles (created_at desc);
create index profiles_last_active_idx on public.profiles (last_active_at desc);

-- updated_at genérico
create or replace function public.tg_set_updated_at()
returns trigger language plpgsql as $$
begin
  new.updated_at := now();
  return new;
end $$;

create trigger profiles_updated_at before update on public.profiles
  for each row execute function public.tg_set_updated_at();

-- Alta automática del perfil cuando se crea el usuario en Auth.
create or replace function public.handle_new_user()
returns trigger
language plpgsql
security definer
set search_path = ''
as $$
declare
  v_locale text := coalesce(new.raw_user_meta_data ->> 'locale', 'es');
  v_name text := nullif(trim(new.raw_user_meta_data ->> 'display_name'), '');
begin
  if v_locale not in ('es', 'ca') then
    v_locale := 'es';
  end if;
  insert into public.profiles (id, display_name, locale)
  values (new.id, left(v_name, 80), v_locale::public.locale_code);
  return new;
end $$;

create trigger on_auth_user_created
  after insert on auth.users
  for each row execute function public.handle_new_user();

-- ---------------------------------------------------------------------
-- Helpers de autorización (SECURITY DEFINER para evitar recursión de RLS)
-- ---------------------------------------------------------------------
create or replace function public.current_role_rank()
returns int
language sql
stable
security definer
set search_path = ''
as $$
  select case p.role
           when 'owner' then 4
           when 'admin' then 3
           when 'editor' then 2
           else 1
         end
  from public.profiles p
  where p.id = auth.uid() and p.status = 'active'
$$;

create or replace function public.is_staff()
returns boolean language sql stable security definer set search_path = '' as $$
  select coalesce(public.current_role_rank() >= 2, false)
$$;

create or replace function public.is_admin()
returns boolean language sql stable security definer set search_path = '' as $$
  select coalesce(public.current_role_rank() >= 3, false)
$$;

-- Impide que un usuario se autoasigne rol o cambie su estado.
-- SECURITY INVOKER a propósito: current_user refleja el rol de la petición
-- (anon/authenticated vía API; service_role/postgres en backend o migraciones).
create or replace function public.tg_protect_profile_columns()
returns trigger
language plpgsql
set search_path = ''
as $$
declare
  via_api boolean := current_user in ('anon', 'authenticated');
begin
  if via_api
     and (new.role is distinct from old.role or new.status is distinct from old.status)
     and not public.is_admin() then
    raise exception 'No autorizado a modificar rol o estado' using errcode = '42501';
  end if;
  -- Solo el owner puede crear o retirar owners/admins.
  if via_api
     and new.role is distinct from old.role
     and (new.role in ('owner', 'admin') or old.role in ('owner', 'admin'))
     and coalesce(public.current_role_rank(), 0) < 4 then
    raise exception 'Solo el propietario puede gestionar administradores' using errcode = '42501';
  end if;
  if new.marketing_consent is distinct from old.marketing_consent then
    new.marketing_consent_at := now();
  end if;
  return new;
end $$;

create trigger profiles_protect before update on public.profiles
  for each row execute function public.tg_protect_profile_columns();

alter table public.profiles enable row level security;

create policy "profiles: ver el propio" on public.profiles
  for select to authenticated using (id = auth.uid());
create policy "profiles: staff ve todos" on public.profiles
  for select to authenticated using (public.is_admin());
create policy "profiles: actualizar el propio" on public.profiles
  for update to authenticated using (id = auth.uid()) with check (id = auth.uid());
create policy "profiles: admin actualiza" on public.profiles
  for update to authenticated using (public.is_admin()) with check (public.is_admin());

revoke all on public.profiles from anon;

-- ---------------------------------------------------------------------
-- Auditoría de acciones sensibles (solo inserción mediante función)
-- ---------------------------------------------------------------------
create table public.audit_log (
  id bigint generated always as identity primary key,
  actor_id uuid references auth.users (id) on delete set null,
  action text not null check (char_length(action) between 3 and 80),
  target_type text,
  target_id text,
  metadata jsonb not null default '{}'::jsonb,
  created_at timestamptz not null default now()
);
create index audit_log_created_idx on public.audit_log (created_at desc);
create index audit_log_actor_idx on public.audit_log (actor_id, created_at desc);

alter table public.audit_log enable row level security;
create policy "audit: admin lee" on public.audit_log
  for select to authenticated using (public.is_admin());
revoke insert, update, delete on public.audit_log from anon, authenticated;

create or replace function public.log_admin_action(
  p_action text, p_target_type text default null, p_target_id text default null,
  p_metadata jsonb default '{}'::jsonb
) returns void
language plpgsql security definer set search_path = '' as $$
begin
  if not public.is_staff() then
    raise exception 'No autorizado' using errcode = '42501';
  end if;
  insert into public.audit_log (actor_id, action, target_type, target_id, metadata)
  values (auth.uid(), p_action, p_target_type, p_target_id, coalesce(p_metadata, '{}'::jsonb));
end $$;
revoke execute on function public.log_admin_action(text, text, text, jsonb) from anon;

-- ---------------------------------------------------------------------
-- Eventos de actividad del alumno (historial, estadísticas reales)
-- ---------------------------------------------------------------------
create table public.activity_events (
  id bigint generated always as identity primary key,
  user_id uuid not null references auth.users (id) on delete cascade,
  kind text not null check (kind ~ '^[a-z_\.]{3,60}$'),
  metadata jsonb not null default '{}'::jsonb,
  created_at timestamptz not null default now()
);
create index activity_events_user_idx on public.activity_events (user_id, created_at desc);
create index activity_events_kind_idx on public.activity_events (kind, created_at desc);

alter table public.activity_events enable row level security;
create policy "activity: ver la propia" on public.activity_events
  for select to authenticated using (user_id = auth.uid());
create policy "activity: admin ve todo" on public.activity_events
  for select to authenticated using (public.is_admin());
revoke insert, update, delete on public.activity_events from anon, authenticated;

-- Registro de actividad desde la app: valida tipo y actualiza last_active_at.
create or replace function public.track_activity(p_kind text, p_metadata jsonb default '{}'::jsonb)
returns void
language plpgsql security definer set search_path = '' as $$
begin
  if auth.uid() is null then
    raise exception 'Sesión requerida' using errcode = '42501';
  end if;
  if p_kind not in ('auth.sign_in', 'auth.sign_up', 'onboarding.completed', 'exam.followed',
                    'exam.unfollowed', 'profile.updated', 'practice.started', 'practice.completed') then
    raise exception 'Tipo de actividad no permitido' using errcode = '22023';
  end if;
  insert into public.activity_events (user_id, kind, metadata)
  values (auth.uid(), p_kind, coalesce(p_metadata, '{}'::jsonb));
  update public.profiles set last_active_at = now() where id = auth.uid();
end $$;
revoke execute on function public.track_activity(text, jsonb) from anon;
