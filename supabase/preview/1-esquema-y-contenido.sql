-- =====================================================================
-- Aprobia · PREVIEW PRIVADA · paso 1/2: esquema, catálogo y contenido
-- Pegar entero en Supabase › SQL Editor › New query › Run (proyecto vacío).
-- Generado desde supabase/migrations + seed.sql + content/ (no editar a mano).
-- Las 30 preguntas de Mossos quedan en BORRADOR; el pack de prueba, también
-- (se publica en el paso 2 con la cuenta titular de prueba).
-- =====================================================================
create extension if not exists pg_trgm with schema extensions;

-- >>> supabase/migrations/20261102000100_identity.sql
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

-- >>> supabase/migrations/20261102000200_catalog.sql
-- =====================================================================
-- 0200 · Catálogo multioposición
-- Ámbito territorial → Organismo → Cuerpo/especialidad (oposición)
--   → Convocatoria → Pruebas → Temario
-- =====================================================================

create type public.scope_level as enum ('estatal', 'autonomico', 'local');
create type public.exam_category as enum (
  'seguridad', 'emergencias', 'penitenciaria', 'administracion', 'justicia',
  'correos', 'sanidad', 'educacion', 'otros'
);
create type public.availability as enum ('available', 'partial', 'coming_soon');
create type public.call_status as enum ('expected', 'announced', 'open', 'closed', 'in_progress', 'finished');
create type public.test_kind as enum (
  'knowledge', 'psychotechnic', 'physical', 'language', 'personality', 'interview', 'medical', 'other'
);
create type public.source_kind as enum ('boe', 'diario_autonomico', 'bop', 'web_oficial', 'otro');

-- Fuentes oficiales verificables
create table public.sources (
  id uuid primary key default gen_random_uuid(),
  title text not null,
  url text not null check (url ~ '^https://'),
  kind public.source_kind not null default 'web_oficial',
  publisher text,
  published_on date,
  verified_at timestamptz,
  verified_by uuid references auth.users (id) on delete set null,
  notes text,
  created_at timestamptz not null default now(),
  unique (url)
);

create table public.regions (
  id uuid primary key default gen_random_uuid(),
  slug text not null unique check (slug ~ '^[a-z0-9-]{2,60}$'),
  name text not null,
  level public.scope_level not null,
  parent_id uuid references public.regions (id) on delete restrict
);

create table public.organizations (
  id uuid primary key default gen_random_uuid(),
  slug text not null unique check (slug ~ '^[a-z0-9-]{2,80}$'),
  name text not null,
  scope public.scope_level not null,
  region_id uuid references public.regions (id) on delete restrict,
  website_url text check (website_url is null or website_url ~ '^https://'),
  created_at timestamptz not null default now()
);

-- Oposición = cuerpo o especialidad convocada por un organismo
create table public.exam_bodies (
  id uuid primary key default gen_random_uuid(),
  slug text not null unique check (slug ~ '^[a-z0-9-]{2,80}$'),
  organization_id uuid not null references public.organizations (id) on delete restrict,
  name text not null,
  name_ca text,
  short_description text,
  short_description_ca text,
  category public.exam_category not null,
  availability public.availability not null default 'coming_soon',
  is_published boolean not null default false,
  sort_order int not null default 100,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);
create index exam_bodies_category_idx on public.exam_bodies (category) where is_published;
create index exam_bodies_name_trgm on public.exam_bodies using gin (name extensions.gin_trgm_ops);
create trigger exam_bodies_updated_at before update on public.exam_bodies
  for each row execute function public.tg_set_updated_at();

create table public.exam_body_sources (
  exam_body_id uuid not null references public.exam_bodies (id) on delete cascade,
  source_id uuid not null references public.sources (id) on delete restrict,
  primary key (exam_body_id, source_id)
);

-- Convocatorias
create table public.calls (
  id uuid primary key default gen_random_uuid(),
  exam_body_id uuid not null references public.exam_bodies (id) on delete cascade,
  year int not null check (year between 2000 and 2100),
  title text not null,
  status public.call_status not null default 'expected',
  vacancies int check (vacancies is null or vacancies >= 0),
  application_start date,
  application_end date,
  exam_date date,
  source_id uuid references public.sources (id) on delete set null,
  is_published boolean not null default false,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  check (application_end is null or application_start is null or application_end >= application_start)
);
create index calls_exam_body_idx on public.calls (exam_body_id, year desc);
create trigger calls_updated_at before update on public.calls
  for each row execute function public.tg_set_updated_at();

-- Pruebas (configuración de simulacros por convocatoria o por defecto de la oposición)
create table public.exam_tests (
  id uuid primary key default gen_random_uuid(),
  exam_body_id uuid not null references public.exam_bodies (id) on delete cascade,
  call_id uuid references public.calls (id) on delete cascade,
  name text not null,
  kind public.test_kind not null,
  order_index int not null default 0,
  is_eliminatory boolean not null default true,
  question_count int check (question_count is null or question_count > 0),
  duration_minutes int check (duration_minutes is null or duration_minutes > 0),
  -- {"correct": 1, "wrong": -0.33, "blank": 0, "pass_mark": 5, "max_score": 10}
  scoring jsonb not null default '{}'::jsonb,
  source_id uuid references public.sources (id) on delete set null,
  created_at timestamptz not null default now()
);
create index exam_tests_body_idx on public.exam_tests (exam_body_id, call_id, order_index);

create table public.requirements (
  id uuid primary key default gen_random_uuid(),
  exam_body_id uuid not null references public.exam_bodies (id) on delete cascade,
  call_id uuid references public.calls (id) on delete cascade,
  body text not null,
  order_index int not null default 0,
  source_id uuid references public.sources (id) on delete set null
);

-- Temas reutilizables entre oposiciones
create table public.topics (
  id uuid primary key default gen_random_uuid(),
  slug text not null unique check (slug ~ '^[a-z0-9-]{2,120}$'),
  title text not null,
  title_ca text,
  parent_id uuid references public.topics (id) on delete restrict,
  created_at timestamptz not null default now()
);

create table public.exam_body_topics (
  exam_body_id uuid not null references public.exam_bodies (id) on delete cascade,
  topic_id uuid not null references public.topics (id) on delete restrict,
  call_id uuid references public.calls (id) on delete cascade,
  order_index int not null default 0,
  label text, -- p.ej. "Tema 12"
  primary key (exam_body_id, topic_id)
);

-- Oposiciones que prepara/sigue cada alumno (+ datos de onboarding)
create type public.study_level as enum ('beginner', 'intermediate', 'advanced');

create table public.user_exam_targets (
  user_id uuid not null references auth.users (id) on delete cascade,
  exam_body_id uuid not null references public.exam_bodies (id) on delete cascade,
  call_id uuid references public.calls (id) on delete set null,
  is_primary boolean not null default false,
  follow_only boolean not null default false,
  notify_consent boolean not null default false,
  level public.study_level,
  weekly_hours int check (weekly_hours is null or weekly_hours between 1 and 80),
  goals text[] not null default '{}',
  created_at timestamptz not null default now(),
  primary key (user_id, exam_body_id)
);
create unique index user_exam_targets_one_primary on public.user_exam_targets (user_id) where is_primary;
create index user_exam_targets_body_idx on public.user_exam_targets (exam_body_id);

-- ---------------------------------------------------------------------
-- RLS: lectura pública de lo publicado, escritura solo staff
-- ---------------------------------------------------------------------
alter table public.sources enable row level security;
alter table public.regions enable row level security;
alter table public.organizations enable row level security;
alter table public.exam_bodies enable row level security;
alter table public.exam_body_sources enable row level security;
alter table public.calls enable row level security;
alter table public.exam_tests enable row level security;
alter table public.requirements enable row level security;
alter table public.topics enable row level security;
alter table public.exam_body_topics enable row level security;
alter table public.user_exam_targets enable row level security;

create policy "sources: lectura" on public.sources for select using (true);
create policy "regions: lectura" on public.regions for select using (true);
create policy "organizations: lectura" on public.organizations for select using (true);
create policy "exam_bodies: publicadas" on public.exam_bodies for select
  using (is_published or public.is_staff());
create policy "exam_body_sources: lectura" on public.exam_body_sources for select using (true);
create policy "calls: publicadas" on public.calls for select
  using (is_published or public.is_staff());
create policy "exam_tests: lectura" on public.exam_tests for select using (true);
create policy "requirements: lectura" on public.requirements for select using (true);
create policy "topics: lectura" on public.topics for select using (true);
create policy "exam_body_topics: lectura" on public.exam_body_topics for select using (true);

do $$
declare t text;
begin
  foreach t in array array['sources','regions','organizations','exam_bodies','exam_body_sources',
                           'calls','exam_tests','requirements','topics','exam_body_topics'] loop
    execute format('create policy "%1$s: staff escribe" on public.%1$I for all to authenticated
                    using (public.is_staff()) with check (public.is_staff())', t);
    execute format('revoke insert, update, delete on public.%I from anon', t);
  end loop;
end $$;

create policy "targets: los propios" on public.user_exam_targets for all to authenticated
  using (user_id = auth.uid()) with check (user_id = auth.uid());
create policy "targets: admin lee" on public.user_exam_targets for select to authenticated
  using (public.is_admin());
revoke all on public.user_exam_targets from anon;

-- >>> supabase/migrations/20261102000300_question_bank.sql
-- =====================================================================
-- 0300 · Banco centralizado de preguntas + flujo de revisión
-- Las respuestas correctas NO son legibles por alumnos: se corrigen vía RPC.
-- =====================================================================

create type public.content_status as enum ('draft', 'needs_review', 'approved', 'published', 'archived');

create table public.questions (
  id uuid primary key default gen_random_uuid(),
  stem text not null check (char_length(stem) between 5 and 4000),
  explanation text,
  category text not null check (category ~ '^[a-z0-9_\-]{2,60}$'),
  topic_id uuid references public.topics (id) on delete set null,
  difficulty smallint not null default 3 check (difficulty between 1 and 5),
  locale public.locale_code not null default 'es',
  status public.content_status not null default 'draft',
  version int not null default 1,
  is_free boolean not null default false,
  ai_generated boolean not null default false,
  source_id uuid references public.sources (id) on delete set null,
  -- hash normalizado de enunciado + opciones para detectar duplicados
  content_hash text not null,
  created_by uuid references auth.users (id) on delete set null,
  reviewed_by uuid references auth.users (id) on delete set null,
  reviewed_at timestamptz,
  published_at timestamptz,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  unique (locale, content_hash)
);
create index questions_status_idx on public.questions (status, category);
create index questions_topic_idx on public.questions (topic_id) where status = 'published';
create trigger questions_updated_at before update on public.questions
  for each row execute function public.tg_set_updated_at();

create table public.question_options (
  id uuid primary key default gen_random_uuid(),
  question_id uuid not null references public.questions (id) on delete cascade,
  label text not null check (label ~ '^[A-F]$'),
  body text not null check (char_length(body) between 1 and 1000),
  is_correct boolean not null default false,
  unique (question_id, label)
);
-- exactamente una opción correcta por pregunta (garantizado al publicar)
create unique index question_options_one_correct on public.question_options (question_id) where is_correct;

create table public.question_exam_bodies (
  question_id uuid not null references public.questions (id) on delete cascade,
  exam_body_id uuid not null references public.exam_bodies (id) on delete cascade,
  primary key (question_id, exam_body_id)
);
create index question_exam_bodies_body_idx on public.question_exam_bodies (exam_body_id);

create table public.question_calls (
  question_id uuid not null references public.questions (id) on delete cascade,
  call_id uuid not null references public.calls (id) on delete cascade,
  primary key (question_id, call_id)
);

create table public.question_reviews (
  id bigint generated always as identity primary key,
  question_id uuid not null references public.questions (id) on delete cascade,
  reviewer_id uuid references auth.users (id) on delete set null,
  from_status public.content_status not null,
  to_status public.content_status not null,
  comment text,
  created_at timestamptz not null default now()
);

-- Transiciones de estado válidas + reglas: la IA no puede saltarse la revisión humana.
create or replace function public.tg_question_status_guard()
returns trigger language plpgsql security definer set search_path = '' as $$
declare
  ok boolean;
  n_correct int;
  n_options int;
begin
  if new.status = old.status then
    return new;
  end if;
  ok := (old.status, new.status) in (
    ('draft', 'needs_review'), ('needs_review', 'draft'), ('needs_review', 'approved'),
    ('approved', 'published'), ('approved', 'needs_review'), ('published', 'archived'),
    ('published', 'needs_review'), ('archived', 'needs_review')
  );
  if not ok then
    raise exception 'Transición % -> % no permitida', old.status, new.status using errcode = '22023';
  end if;
  if new.status in ('approved', 'published') then
    select count(*) filter (where is_correct), count(*)
      into n_correct, n_options
      from public.question_options where question_id = new.id;
    if n_correct <> 1 or n_options < 2 then
      raise exception 'La pregunta necesita >= 2 opciones y exactamente 1 correcta' using errcode = '22023';
    end if;
    if new.explanation is null or char_length(new.explanation) < 10 then
      raise exception 'La pregunta necesita explicación antes de aprobarse' using errcode = '22023';
    end if;
  end if;
  if new.status = 'approved' then
    new.reviewed_by := auth.uid();
    new.reviewed_at := now();
  end if;
  if new.status = 'published' then
    if new.reviewed_by is null then
      raise exception 'No se puede publicar sin revisión humana' using errcode = '22023';
    end if;
    new.published_at := now();
  end if;
  insert into public.question_reviews (question_id, reviewer_id, from_status, to_status)
  values (new.id, auth.uid(), old.status, new.status);
  return new;
end $$;

create trigger questions_status_guard before update of status on public.questions
  for each row execute function public.tg_question_status_guard();

-- Cualquier edición de contenido publicado/aprobado incrementa versión y vuelve a revisión.
create or replace function public.tg_question_versioning()
returns trigger language plpgsql as $$
begin
  if (new.stem, coalesce(new.explanation, '')) is distinct from (old.stem, coalesce(old.explanation, '')) then
    new.version := old.version + 1;
    if old.status in ('approved', 'published') and new.status = old.status then
      raise exception 'Edita una pregunta aprobada/publicada devolviéndola antes a revisión' using errcode = '22023';
    end if;
  end if;
  return new;
end $$;
create trigger questions_versioning before update on public.questions
  for each row execute function public.tg_question_versioning();

alter table public.questions enable row level security;
alter table public.question_options enable row level security;
alter table public.question_exam_bodies enable row level security;
alter table public.question_calls enable row level security;
alter table public.question_reviews enable row level security;

-- Alumnos: nada directo. Todo el consumo pasa por funciones que ocultan is_correct.
create policy "questions: staff" on public.questions for all to authenticated
  using (public.is_staff()) with check (public.is_staff());
create policy "options: staff" on public.question_options for all to authenticated
  using (public.is_staff()) with check (public.is_staff());
create policy "q_bodies: staff" on public.question_exam_bodies for all to authenticated
  using (public.is_staff()) with check (public.is_staff());
create policy "q_calls: staff" on public.question_calls for all to authenticated
  using (public.is_staff()) with check (public.is_staff());
create policy "q_reviews: staff lee" on public.question_reviews for select to authenticated
  using (public.is_staff());

revoke all on public.questions, public.question_options, public.question_exam_bodies,
  public.question_calls, public.question_reviews from anon;
revoke insert, update, delete on public.question_reviews from authenticated;

-- Preguntas de demostración (gratuitas y publicadas) SIN la respuesta correcta.
create or replace function public.get_demo_questions(p_exam_body_slug text default null, p_limit int default 10)
returns table (id uuid, stem text, category text, difficulty smallint, options jsonb)
language sql stable security definer set search_path = '' as $$
  select q.id, q.stem, q.category, q.difficulty,
         (select jsonb_agg(jsonb_build_object('id', o.id, 'label', o.label, 'body', o.body) order by o.label)
            from public.question_options o where o.question_id = q.id) as options
  from public.questions q
  where q.status = 'published' and q.is_free
    and (p_exam_body_slug is null or exists (
      select 1 from public.question_exam_bodies qb
      join public.exam_bodies b on b.id = qb.exam_body_id
      where qb.question_id = q.id and b.slug = p_exam_body_slug))
  order by q.created_at
  limit least(greatest(p_limit, 1), 50)
$$;

-- Corrección de una respuesta de demostración (devuelve acierto + explicación).
create or replace function public.check_demo_answer(p_question_id uuid, p_option_id uuid)
returns table (is_correct boolean, correct_option_id uuid, explanation text)
language sql stable security definer set search_path = '' as $$
  select (o.id = p_option_id), o.id, q.explanation
  from public.questions q
  join public.question_options o on o.question_id = q.id and o.is_correct
  where q.id = p_question_id and q.status = 'published' and q.is_free
    and exists (select 1 from public.question_options x where x.id = p_option_id and x.question_id = q.id)
$$;

-- >>> supabase/migrations/20261102000400_account_rights.sql
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

-- >>> supabase/migrations/20261102000500_admin_users.sql
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

-- >>> supabase/migrations/20261102000600_practice.sql
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

-- >>> supabase/migrations/20261102000700_content_review.sql
-- =====================================================================
-- 0700 · Flujo de revisión de contenido (DEC-002)
--
--  * Solo la persona titular (rol owner) aprueba, rechaza, publica o archiva.
--    Editores y admins redactan, corrigen y envían a revisión.
--  * Cada transición queda en question_reviews con un comentario opcional.
--  * Las opciones de una pregunta aprobada/publicada/archivada no se pueden
--    tocar: hay que devolverla antes a revisión (nueva versión).
--  * Solo se borran borradores; lo demás se archiva.
-- =====================================================================

create or replace function public.is_owner()
returns boolean language sql stable security definer set search_path = '' as $$
  select coalesce(public.current_role_rank() >= 4, false)
$$;
revoke execute on function public.is_owner() from anon;

create or replace function public.tg_question_status_guard()
returns trigger language plpgsql security definer set search_path = '' as $$
declare
  ok boolean;
  n_correct int;
  n_options int;
  owner_only boolean;
begin
  if new.status = old.status then
    return new;
  end if;
  ok := (old.status, new.status) in (
    ('draft', 'needs_review'), ('needs_review', 'draft'), ('needs_review', 'approved'),
    ('approved', 'published'), ('approved', 'needs_review'), ('published', 'archived'),
    ('published', 'needs_review'), ('archived', 'needs_review')
  );
  if not ok then
    raise exception 'Transición % -> % no permitida', old.status, new.status using errcode = '22023';
  end if;
  -- decisiones de revisión: solo la persona titular (peticiones vía API con usuario)
  owner_only := (old.status, new.status) in (
    ('needs_review', 'approved'), ('needs_review', 'draft'), ('approved', 'published'),
    ('published', 'archived')
  );
  if owner_only and auth.uid() is not null and not public.is_owner() then
    raise exception 'Solo la persona titular puede aprobar, rechazar, publicar o archivar contenido'
      using errcode = '42501';
  end if;
  if new.status in ('approved', 'published') then
    select count(*) filter (where is_correct), count(*)
      into n_correct, n_options
      from public.question_options where question_id = new.id;
    if n_correct <> 1 or n_options < 2 then
      raise exception 'La pregunta necesita >= 2 opciones y exactamente 1 correcta' using errcode = '22023';
    end if;
    if new.explanation is null or char_length(new.explanation) < 10 then
      raise exception 'La pregunta necesita explicación antes de aprobarse' using errcode = '22023';
    end if;
  end if;
  if new.status = 'approved' then
    new.reviewed_by := auth.uid();
    new.reviewed_at := now();
  end if;
  if new.status = 'published' then
    if new.reviewed_by is null then
      raise exception 'No se puede publicar sin revisión humana' using errcode = '22023';
    end if;
    new.published_at := now();
  end if;
  if new.status in ('draft', 'needs_review') then
    new.reviewed_by := null;
    new.reviewed_at := null;
  end if;
  insert into public.question_reviews (question_id, reviewer_id, from_status, to_status, comment)
  values (new.id, auth.uid(), old.status, new.status,
          nullif(left(current_setting('app.review_comment', true), 2000), ''));
  return new;
end $$;

-- Transición con comentario (p. ej. motivo del rechazo). SECURITY INVOKER: RLS de staff.
create or replace function public.review_question(p_id uuid, p_to public.content_status, p_comment text default null)
returns public.content_status
language plpgsql security invoker set search_path = '' as $$
declare
  v_status public.content_status;
begin
  perform set_config('app.review_comment', coalesce(p_comment, ''), true);
  update public.questions set status = p_to where id = p_id returning status into v_status;
  if v_status is null then
    raise exception 'Pregunta no encontrada' using errcode = '42501';
  end if;
  perform set_config('app.review_comment', '', true);
  return v_status;
end $$;
revoke execute on function public.review_question(uuid, public.content_status, text) from anon, public;
grant execute on function public.review_question(uuid, public.content_status, text) to authenticated;

-- Opciones bloqueadas fuera de borrador/revisión
create or replace function public.tg_question_options_lock()
returns trigger language plpgsql security definer set search_path = '' as $$
declare
  v_status public.content_status;
begin
  select status into v_status from public.questions
   where id = coalesce(new.question_id, old.question_id);
  if v_status in ('approved', 'published', 'archived') then
    raise exception 'Devuelve la pregunta a revisión antes de cambiar sus opciones' using errcode = '22023';
  end if;
  return coalesce(new, old);
end $$;
create trigger question_options_lock before insert or update or delete on public.question_options
  for each row execute function public.tg_question_options_lock();

-- Solo se borran borradores
create or replace function public.tg_question_delete_guard()
returns trigger language plpgsql set search_path = '' as $$
begin
  if old.status <> 'draft' then
    raise exception 'Solo se pueden borrar borradores; archiva el resto' using errcode = '22023';
  end if;
  return old;
end $$;
create trigger questions_delete_guard before delete on public.questions
  for each row execute function public.tg_question_delete_guard();

-- Recuento por estado para el panel (staff)
create or replace function public.question_status_counts()
returns table (status public.content_status, total bigint)
language sql stable security invoker set search_path = '' as $$
  select status, count(*) from public.questions group by status
$$;
revoke execute on function public.question_status_counts() from anon, public;
grant execute on function public.question_status_counts() to authenticated;

-- >>> supabase/migrations/20261102000800_store.sql
-- =====================================================================
-- 0800 · Tienda de productos digitales (arquitectura, SIN pagos reales)
--
-- Un único banco de preguntas alimenta todos los productos:
--   question_pack  → test interactivos con preguntas del banco
--   mock_exam      → simulacro configurado (n.º de preguntas, tiempo, puntuación)
--   pdf            → archivo generado a partir de las mismas preguntas
--   bundle         → combinación de otros productos
--   subscription   → Premium (acceso a todo lo marcado included_in_premium)
--
-- Acceso: SIEMPRE por access_grants (concesiones). Una compra, una suscripción
-- o una concesión manual de administración crean concesiones; la app solo
-- consulta has_product_access(). Stripe (modo test) se conectará más adelante
-- rellenando orders/subscriptions desde el webhook; hoy solo existen las
-- columnas de referencia (DEC-003: no se conecta ninguna cuenta).
-- =====================================================================

create type public.product_type as enum ('pdf', 'question_pack', 'mock_exam', 'bundle', 'subscription');
create type public.product_status as enum ('draft', 'published', 'archived');
create type public.order_status as enum ('pending', 'paid', 'failed', 'refunded', 'cancelled');
create type public.subscription_status as enum ('trialing', 'active', 'past_due', 'canceled', 'expired');
create type public.grant_source as enum ('purchase', 'subscription', 'admin', 'free');

create table public.products (
  id uuid primary key default gen_random_uuid(),
  slug text not null unique check (slug ~ '^[a-z0-9]+(-[a-z0-9]+)*$' and char_length(slug) <= 80),
  type public.product_type not null,
  status public.product_status not null default 'draft',
  title text not null check (char_length(title) between 3 and 160),
  title_ca text check (char_length(title_ca) between 3 and 160),
  description text check (char_length(description) <= 4000),
  description_ca text check (char_length(description_ca) <= 4000),
  exam_body_id uuid references public.exam_bodies (id) on delete set null,
  is_free boolean not null default false,
  included_in_premium boolean not null default true,
  -- configuración específica (p. ej. simulacro: {"questions":100,"minutes":90,"penalty":0.33})
  config jsonb not null default '{}'::jsonb,
  stripe_product_id text, -- preparado; vacío hasta autorización (DEC-003)
  created_by uuid references auth.users (id) on delete set null,
  published_at timestamptz,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);
create trigger products_updated_at before update on public.products
  for each row execute function public.tg_set_updated_at();

create table public.product_prices (
  id uuid primary key default gen_random_uuid(),
  product_id uuid not null references public.products (id) on delete cascade,
  currency text not null default 'EUR' check (currency ~ '^[A-Z]{3}$'),
  amount_cents integer not null check (amount_cents >= 0 and amount_cents <= 100000),
  billing_interval text check (billing_interval in ('month', 'year')), -- null = pago único
  active boolean not null default true,
  stripe_price_id text,
  created_at timestamptz not null default now()
);
create unique index product_prices_one_active on public.product_prices (product_id, coalesce(billing_interval, 'once'))
  where active;

-- Contenido de cada producto (desde el banco común)
create table public.product_items (
  id bigint generated always as identity primary key,
  product_id uuid not null references public.products (id) on delete cascade,
  position int not null default 0,
  question_id uuid references public.questions (id) on delete restrict,
  child_product_id uuid references public.products (id) on delete restrict,
  check ((question_id is not null)::int + (child_product_id is not null)::int = 1),
  check (child_product_id is distinct from product_id)
);
create unique index product_items_question on public.product_items (product_id, question_id) where question_id is not null;
create unique index product_items_child on public.product_items (product_id, child_product_id) where child_product_id is not null;

-- Archivos descargables (PDF generados del banco). Ruta en Storage privado.
create table public.product_files (
  id uuid primary key default gen_random_uuid(),
  product_id uuid not null references public.products (id) on delete cascade,
  storage_path text not null unique,
  mime_type text not null default 'application/pdf',
  size_bytes integer check (size_bytes >= 0),
  version int not null default 1,
  -- huella de las preguntas usadas (para regenerar si cambian)
  source_hash text,
  created_at timestamptz not null default now()
);

-- Los pedidos se conservan (obligaciones contables) aunque la cuenta se borre:
-- quedan desvinculados de la persona (user_id null).
create table public.orders (
  id uuid primary key default gen_random_uuid(),
  user_id uuid references auth.users (id) on delete set null,
  status public.order_status not null default 'pending',
  currency text not null default 'EUR',
  total_cents integer not null check (total_cents >= 0),
  provider text not null default 'none' check (provider in ('none', 'stripe_test', 'stripe')),
  provider_ref text unique,
  created_at timestamptz not null default now(),
  paid_at timestamptz
);
create index orders_user_idx on public.orders (user_id, created_at desc);

create table public.order_items (
  id bigint generated always as identity primary key,
  order_id uuid not null references public.orders (id) on delete cascade,
  product_id uuid not null references public.products (id) on delete restrict,
  price_id uuid references public.product_prices (id) on delete set null,
  amount_cents integer not null check (amount_cents >= 0)
);

create table public.subscriptions (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users (id) on delete cascade,
  product_id uuid not null references public.products (id) on delete restrict,
  price_id uuid references public.product_prices (id) on delete set null,
  status public.subscription_status not null,
  current_period_end timestamptz,
  cancel_at_period_end boolean not null default false,
  provider text not null default 'none' check (provider in ('none', 'stripe_test', 'stripe')),
  provider_ref text unique,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);
create index subscriptions_user_idx on public.subscriptions (user_id);
create trigger subscriptions_updated_at before update on public.subscriptions
  for each row execute function public.tg_set_updated_at();

create table public.access_grants (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users (id) on delete cascade,
  product_id uuid not null references public.products (id) on delete cascade,
  source public.grant_source not null,
  order_id uuid references public.orders (id) on delete set null,
  subscription_id uuid references public.subscriptions (id) on delete cascade,
  granted_by uuid references auth.users (id) on delete set null,
  note text check (char_length(note) <= 500),
  starts_at timestamptz not null default now(),
  ends_at timestamptz,
  revoked_at timestamptz,
  created_at timestamptz not null default now()
);
create index access_grants_user_idx on public.access_grants (user_id, product_id);

-- ---------------------------------------------------------------------
-- RLS
-- ---------------------------------------------------------------------
alter table public.products enable row level security;
alter table public.product_prices enable row level security;
alter table public.product_items enable row level security;
alter table public.product_files enable row level security;
alter table public.orders enable row level security;
alter table public.order_items enable row level security;
alter table public.subscriptions enable row level security;
alter table public.access_grants enable row level security;

-- Catálogo: publicados para todos; staff ve todo y admin edita
create policy "products: publicados" on public.products for select to anon, authenticated
  using (status = 'published' or public.is_staff());
create policy "products: admin escribe" on public.products for all to authenticated
  using (public.is_admin()) with check (public.is_admin());
create policy "prices: de productos visibles" on public.product_prices for select to anon, authenticated
  using (exists (select 1 from public.products p where p.id = product_id
                 and (p.status = 'published' or public.is_staff())));
create policy "prices: admin escribe" on public.product_prices for all to authenticated
  using (public.is_admin()) with check (public.is_admin());
-- El contenido (qué preguntas incluye) no es público
create policy "items: staff" on public.product_items for select to authenticated using (public.is_staff());
create policy "items: admin escribe" on public.product_items for all to authenticated
  using (public.is_admin()) with check (public.is_admin());
create policy "files: staff" on public.product_files for select to authenticated using (public.is_staff());
create policy "files: admin escribe" on public.product_files for all to authenticated
  using (public.is_admin()) with check (public.is_admin());

-- Datos de compra: cada alumno los suyos; administración, todos. Nadie escribe con su JWT.
create policy "orders: propios o admin" on public.orders for select to authenticated
  using (user_id = (select auth.uid()) or public.is_admin());
create policy "order_items: propios o admin" on public.order_items for select to authenticated
  using (exists (select 1 from public.orders o where o.id = order_id
                 and (o.user_id = (select auth.uid()) or public.is_admin())));
create policy "subscriptions: propias o admin" on public.subscriptions for select to authenticated
  using (user_id = (select auth.uid()) or public.is_admin());
create policy "grants: propias o admin" on public.access_grants for select to authenticated
  using (user_id = (select auth.uid()) or public.is_admin());

revoke all on public.orders, public.order_items, public.subscriptions, public.access_grants,
  public.product_items, public.product_files from anon;
revoke insert, update, delete, truncate on public.orders, public.order_items, public.subscriptions,
  public.access_grants from authenticated;
revoke insert, update, delete, truncate on public.products, public.product_prices from anon;

-- ---------------------------------------------------------------------
-- Acceso
-- ---------------------------------------------------------------------
create or replace function public.has_product_access(p_product uuid, p_user uuid default null)
returns boolean
language sql stable security definer set search_path = '' as $$
  with u as (select coalesce(p_user, auth.uid()) as id)
  select exists (
    select 1 from public.products p, u
    where p.id = p_product and p.status = 'published'
      and u.id is not null
      and (
        p.is_free
        -- concesión directa vigente
        or exists (select 1 from public.access_grants g
                    where g.user_id = u.id and g.product_id = p.id and g.revoked_at is null
                      and g.starts_at <= now() and (g.ends_at is null or g.ends_at > now()))
        -- incluido en un pack (bundle) concedido
        or exists (select 1 from public.product_items i
                     join public.access_grants g on g.product_id = i.product_id
                    where i.child_product_id = p.id and g.user_id = u.id and g.revoked_at is null
                      and g.starts_at <= now() and (g.ends_at is null or g.ends_at > now()))
        -- Premium activo
        or (p.included_in_premium and exists (
              select 1 from public.subscriptions s
               where s.user_id = u.id and s.status in ('active', 'trialing')
                 and (s.current_period_end is null or s.current_period_end > now())))
      )
  )
$$;
-- solo la propia comprobación para usuarios (p_user lo usa el servidor con service_role)
revoke execute on function public.has_product_access(uuid, uuid) from anon, public;
grant execute on function public.has_product_access(uuid, uuid) to authenticated, service_role;

-- Impide consultar el acceso de otra persona desde la API
create or replace function public.my_product_access(p_product uuid)
returns boolean language sql stable security definer set search_path = '' as $$
  select public.has_product_access(p_product, auth.uid())
$$;
revoke execute on function public.my_product_access(uuid) from anon, public;
grant execute on function public.my_product_access(uuid) to authenticated;
revoke execute on function public.has_product_access(uuid, uuid) from authenticated;

-- Biblioteca «Mis productos»
create or replace function public.my_library()
returns table (product_id uuid, slug text, type public.product_type, title text, title_ca text,
               source text, ends_at timestamptz)
language sql stable security definer set search_path = '' as $$
  with me as (select auth.uid() as id)
  select p.id, p.slug, p.type, p.title, p.title_ca,
         coalesce(g.source::text, case when p.is_free then 'free' else 'subscription' end),
         g.ends_at
    from public.products p
    cross join me
    left join lateral (
      select g.source, g.ends_at from public.access_grants g
       where g.user_id = me.id and g.product_id = p.id and g.revoked_at is null
         and g.starts_at <= now() and (g.ends_at is null or g.ends_at > now())
       order by g.created_at desc limit 1) g on true
   where me.id is not null and p.status = 'published' and p.type <> 'subscription'
     and public.has_product_access(p.id, me.id)
     and (g.source is not null
          or exists (select 1 from public.subscriptions s where s.user_id = me.id
                       and s.status in ('active', 'trialing')
                       and (s.current_period_end is null or s.current_period_end > now())))
   order by p.title
$$;
revoke execute on function public.my_library() from anon, public;
grant execute on function public.my_library() to authenticated;

-- Concesión manual (administración, auditada). No implica cobro.
create or replace function public.admin_grant_access(p_user uuid, p_product uuid, p_days int default null,
                                                     p_note text default null)
returns uuid
language plpgsql security definer set search_path = '' as $$
declare
  v_id uuid;
begin
  if not public.is_admin() then
    raise exception 'Solo administradores' using errcode = '42501';
  end if;
  if not exists (select 1 from public.products where id = p_product and status <> 'archived') then
    raise exception 'Producto no disponible' using errcode = '22023';
  end if;
  insert into public.access_grants (user_id, product_id, source, granted_by, note, ends_at)
  values (p_user, p_product, 'admin', auth.uid(), p_note,
          case when p_days is null then null else now() + make_interval(days => p_days) end)
  returning id into v_id;
  perform public.log_admin_action('access.granted', 'profile', p_user::text,
          jsonb_build_object('product', p_product, 'days', p_days));
  return v_id;
end $$;

create or replace function public.admin_revoke_access(p_grant uuid)
returns void
language plpgsql security definer set search_path = '' as $$
declare
  v_user uuid;
begin
  if not public.is_admin() then
    raise exception 'Solo administradores' using errcode = '42501';
  end if;
  update public.access_grants set revoked_at = now()
   where id = p_grant and revoked_at is null returning user_id into v_user;
  if v_user is null then
    raise exception 'Concesión no encontrada' using errcode = '22023';
  end if;
  perform public.log_admin_action('access.revoked', 'profile', v_user::text,
          jsonb_build_object('grant', p_grant));
end $$;
revoke execute on function public.admin_grant_access(uuid, uuid, int, text) from anon, public;
revoke execute on function public.admin_revoke_access(uuid) from anon, public;
grant execute on function public.admin_grant_access(uuid, uuid, int, text) to authenticated;
grant execute on function public.admin_revoke_access(uuid) to authenticated;

-- Listado de compras/accesos para administración (con email, auditado como consulta)
create or replace function public.admin_list_purchases(p_limit int default 100, p_offset int default 0)
returns table (kind text, id uuid, user_id uuid, email text, product_title text, status text,
               amount_cents integer, source text, created_at timestamptz, ends_at timestamptz)
language plpgsql stable security definer set search_path = '' as $$
begin
  if not public.is_admin() then
    raise exception 'Solo administradores' using errcode = '42501';
  end if;
  return query
  select * from (
    select 'order'::text, o.id, o.user_id, u.email::text,
           (select string_agg(p.title, ', ') from public.order_items oi
              join public.products p on p.id = oi.product_id where oi.order_id = o.id),
           o.status::text, o.total_cents, o.provider, o.created_at, null::timestamptz
      from public.orders o left join auth.users u on u.id = o.user_id
    union all
    select 'grant', g.id, g.user_id, u.email::text, p.title,
           case when g.revoked_at is not null then 'revoked'
                when g.ends_at is not null and g.ends_at <= now() then 'expired' else 'active' end,
           null::integer, g.source::text, g.created_at, g.ends_at
      from public.access_grants g join auth.users u on u.id = g.user_id
      join public.products p on p.id = g.product_id
    union all
    select 'subscription', s.id, s.user_id, u.email::text, p.title, s.status::text, null::integer,
           s.provider, s.created_at, s.current_period_end
      from public.subscriptions s join auth.users u on u.id = s.user_id
      join public.products p on p.id = s.product_id
  ) x
  order by 9 desc
  limit least(greatest(p_limit, 1), 500) offset greatest(p_offset, 0);
end $$;
revoke execute on function public.admin_list_purchases(int, int) from anon, public;
grant execute on function public.admin_list_purchases(int, int) to authenticated;

-- Producto Premium inicial (borrador, precio configurable en el panel)
insert into public.products (slug, type, status, title, title_ca, description, description_ca, included_in_premium)
values ('premium', 'subscription', 'draft', 'Aprobia Premium', 'Aprobia Premium',
        'Acceso a todos los test, simulacros y psicotécnicos incluidos en Premium.',
        'Accés a tots els tests, simulacres i psicotècnics inclosos a Premium.', false);
insert into public.product_prices (product_id, amount_cents, billing_interval)
select id, 1499, 'month' from public.products where slug = 'premium';

-- Exportación RGPD: añadir compras, suscripciones y accesos
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

-- >>> supabase/migrations/20261102000900_question_editor.sql
-- =====================================================================
-- 0900 · Editor de preguntas (atómico) y reglas de contenido de productos
-- =====================================================================

-- Crea o actualiza una pregunta con sus opciones y oposiciones en una sola
-- transacción. SECURITY INVOKER: las políticas de staff deciden quién puede.
-- p: {stem, explanation, category, difficulty, locale, is_free, ai_generated,
--     content_hash, options: [text], correct: int, exam_body_ids: [uuid], source_id}
create or replace function public.upsert_question(p_id uuid, p jsonb)
returns uuid
language plpgsql security invoker set search_path = '' as $$
declare
  v_id uuid := p_id;
  v_status public.content_status;
  v_n int := jsonb_array_length(coalesce(p->'options', '[]'::jsonb));
  v_correct int := (p->>'correct')::int;
begin
  if not public.is_staff() then
    raise exception 'Solo el equipo de contenido' using errcode = '42501';
  end if;
  if v_n < 2 or v_n > 6 then
    raise exception 'Entre 2 y 6 opciones' using errcode = '22023';
  end if;
  if v_correct is null or v_correct < 0 or v_correct >= v_n then
    raise exception 'Marca la opción correcta' using errcode = '22023';
  end if;

  if v_id is null then
    insert into public.questions (stem, explanation, category, difficulty, locale, is_free,
                                  ai_generated, content_hash, source_id, created_by)
    values (p->>'stem', nullif(p->>'explanation', ''), p->>'category', (p->>'difficulty')::smallint,
            coalesce(p->>'locale', 'es')::public.locale_code, coalesce((p->>'is_free')::boolean, false),
            coalesce((p->>'ai_generated')::boolean, false), p->>'content_hash',
            nullif(p->>'source_id', '')::uuid, auth.uid())
    returning id into v_id;
  else
    select status into v_status from public.questions where id = v_id for update;
    if v_status is null then
      raise exception 'Pregunta no encontrada' using errcode = '42501';
    end if;
    if v_status not in ('draft', 'needs_review') then
      raise exception 'Devuelve la pregunta a revisión antes de editarla' using errcode = '22023';
    end if;
    update public.questions
       set stem = p->>'stem', explanation = nullif(p->>'explanation', ''), category = p->>'category',
           difficulty = (p->>'difficulty')::smallint,
           locale = coalesce(p->>'locale', 'es')::public.locale_code,
           is_free = coalesce((p->>'is_free')::boolean, false),
           ai_generated = coalesce((p->>'ai_generated')::boolean, false),
           content_hash = p->>'content_hash', source_id = nullif(p->>'source_id', '')::uuid
     where id = v_id;
    delete from public.question_options where question_id = v_id;
    delete from public.question_exam_bodies where question_id = v_id;
  end if;

  insert into public.question_options (question_id, label, body, is_correct)
  select v_id, chr(64 + o.ord::int), o.body, (o.ord - 1) = v_correct
    from jsonb_array_elements_text(p->'options') with ordinality as o(body, ord);

  insert into public.question_exam_bodies (question_id, exam_body_id)
  select v_id, x::uuid from jsonb_array_elements_text(coalesce(p->'exam_body_ids', '[]'::jsonb)) as x
  on conflict do nothing;

  return v_id;
end $$;
revoke execute on function public.upsert_question(uuid, jsonb) from anon, public;
grant execute on function public.upsert_question(uuid, jsonb) to authenticated;

-- Un producto solo incluye preguntas aprobadas o publicadas (nada sin revisar)
create or replace function public.tg_product_items_guard()
returns trigger language plpgsql security definer set search_path = '' as $$
begin
  if new.question_id is not null and not exists (
       select 1 from public.questions where id = new.question_id and status in ('approved', 'published')) then
    raise exception 'Solo se pueden incluir preguntas aprobadas o publicadas' using errcode = '22023';
  end if;
  if new.child_product_id is not null and not exists (
       select 1 from public.products where id = new.product_id and type = 'bundle') then
    raise exception 'Solo los packs combinados contienen otros productos' using errcode = '22023';
  end if;
  return new;
end $$;
create trigger product_items_guard before insert or update on public.product_items
  for each row execute function public.tg_product_items_guard();

-- Publicar un producto: fecha de publicación
create or replace function public.tg_products_publish()
returns trigger language plpgsql set search_path = '' as $$
begin
  if new.status = 'published' and old.status is distinct from 'published' then
    new.published_at := now();
  end if;
  return new;
end $$;
create trigger products_publish before update of status on public.products
  for each row execute function public.tg_products_publish();

-- >>> supabase/migrations/20261103000100_question_practice.sql
-- =====================================================================
-- 1000 · Sesión 3: fuente por pregunta, contenido de prueba separado y
--        práctica con preguntas del banco (STO-006 / LRN-003)
--
--  * Cada pregunta guarda la referencia concreta (artículo/apartado), el
--    extracto literal de la fuente y una nota para la revisión humana.
--  * is_test marca contenido de PRUEBA. Un producto de prueba solo contiene
--    preguntas de prueba y un producto real solo preguntas reales: nunca se
--    mezclan, y las preguntas reales siguen necesitando aprobación de la
--    titular (DEC-002).
--  * La práctica con preguntas corrige en SQL: el cliente nunca recibe la
--    respuesta antes de contestar. Solo service_role inicia y corrige, tras
--    comprobar has_product_access().
-- =====================================================================

alter table public.questions
  add column source_ref text check (char_length(source_ref) <= 200),
  add column source_excerpt text check (char_length(source_excerpt) <= 4000),
  add column review_note text check (char_length(review_note) <= 2000),
  add column is_test boolean not null default false;

alter table public.products
  add column is_test boolean not null default false;

comment on column public.questions.source_ref is 'Apartado o artículo concreto de la fuente (p. ej. «art. 8.3»)';
comment on column public.questions.source_excerpt is 'Fragmento literal de la fuente leído al redactar';
comment on column public.questions.is_test is 'Contenido de prueba: nunca se mezcla con productos reales';

-- ---------------------------------------------------------------------
-- upsert_question: admite los nuevos campos de fuente (no is_test: el
-- contenido de prueba solo se crea con el cargador de scripts/content)
-- ---------------------------------------------------------------------
create or replace function public.upsert_question(p_id uuid, p jsonb)
returns uuid
language plpgsql security invoker set search_path = '' as $$
declare
  v_id uuid := p_id;
  v_status public.content_status;
  v_n int := jsonb_array_length(coalesce(p->'options', '[]'::jsonb));
  v_correct int := (p->>'correct')::int;
begin
  if not public.is_staff() then
    raise exception 'Solo el equipo de contenido' using errcode = '42501';
  end if;
  if v_n < 2 or v_n > 6 then
    raise exception 'Entre 2 y 6 opciones' using errcode = '22023';
  end if;
  if v_correct is null or v_correct < 0 or v_correct >= v_n then
    raise exception 'Marca la opción correcta' using errcode = '22023';
  end if;

  if v_id is null then
    insert into public.questions (stem, explanation, category, difficulty, locale, is_free,
                                  ai_generated, content_hash, source_id, source_ref, source_excerpt,
                                  review_note, created_by)
    values (p->>'stem', nullif(p->>'explanation', ''), p->>'category', (p->>'difficulty')::smallint,
            coalesce(p->>'locale', 'es')::public.locale_code, coalesce((p->>'is_free')::boolean, false),
            coalesce((p->>'ai_generated')::boolean, false), p->>'content_hash',
            nullif(p->>'source_id', '')::uuid, nullif(p->>'source_ref', ''),
            nullif(p->>'source_excerpt', ''), nullif(p->>'review_note', ''), auth.uid())
    returning id into v_id;
  else
    select status into v_status from public.questions where id = v_id for update;
    if v_status is null then
      raise exception 'Pregunta no encontrada' using errcode = '42501';
    end if;
    if v_status not in ('draft', 'needs_review') then
      raise exception 'Devuelve la pregunta a revisión antes de editarla' using errcode = '22023';
    end if;
    update public.questions
       set stem = p->>'stem', explanation = nullif(p->>'explanation', ''), category = p->>'category',
           difficulty = (p->>'difficulty')::smallint,
           locale = coalesce(p->>'locale', 'es')::public.locale_code,
           is_free = coalesce((p->>'is_free')::boolean, false),
           ai_generated = coalesce((p->>'ai_generated')::boolean, false),
           content_hash = p->>'content_hash', source_id = nullif(p->>'source_id', '')::uuid,
           source_ref = case when p ? 'source_ref' then nullif(p->>'source_ref', '') else source_ref end,
           source_excerpt = case when p ? 'source_excerpt' then nullif(p->>'source_excerpt', '')
                                 else source_excerpt end,
           review_note = case when p ? 'review_note' then nullif(p->>'review_note', '') else review_note end
     where id = v_id;
    delete from public.question_options where question_id = v_id;
    delete from public.question_exam_bodies where question_id = v_id;
  end if;

  insert into public.question_options (question_id, label, body, is_correct)
  select v_id, chr(64 + o.ord::int), o.body, (o.ord - 1) = v_correct
    from jsonb_array_elements_text(p->'options') with ordinality as o(body, ord);

  insert into public.question_exam_bodies (question_id, exam_body_id)
  select v_id, x::uuid from jsonb_array_elements_text(coalesce(p->'exam_body_ids', '[]'::jsonb)) as x
  on conflict do nothing;

  return v_id;
end $$;

-- ---------------------------------------------------------------------
-- Productos: prueba y real nunca se mezclan
-- ---------------------------------------------------------------------
create or replace function public.tg_product_items_guard()
returns trigger language plpgsql security definer set search_path = '' as $$
declare
  v_product_test boolean;
begin
  select is_test into v_product_test from public.products where id = new.product_id;
  if new.question_id is not null then
    if not exists (select 1 from public.questions where id = new.question_id
                     and status in ('approved', 'published')) then
      raise exception 'Solo se pueden incluir preguntas aprobadas o publicadas' using errcode = '22023';
    end if;
    if exists (select 1 from public.questions where id = new.question_id
                 and is_test is distinct from v_product_test) then
      raise exception 'No se mezcla contenido de prueba con contenido real' using errcode = '22023';
    end if;
  end if;
  if new.child_product_id is not null then
    if not exists (select 1 from public.products where id = new.product_id and type = 'bundle') then
      raise exception 'Solo los packs combinados contienen otros productos' using errcode = '22023';
    end if;
    if exists (select 1 from public.products where id = new.child_product_id
                 and is_test is distinct from v_product_test) then
      raise exception 'No se mezcla contenido de prueba con contenido real' using errcode = '22023';
    end if;
  end if;
  return new;
end $$;

-- ---------------------------------------------------------------------
-- Práctica con preguntas de un producto
-- ---------------------------------------------------------------------

-- Preguntas jugables de un producto: publicadas, directas o de un pack hijo.
create or replace function public.product_question_ids(p_product uuid)
returns setof uuid
language sql stable security definer set search_path = '' as $$
  select distinct q.id
    from public.product_items pi
    left join public.product_items ci on ci.product_id = pi.child_product_id
    join public.questions q on q.id = coalesce(pi.question_id, ci.question_id)
   where pi.product_id = p_product and q.status = 'published'
$$;
revoke execute on function public.product_question_ids(uuid) from public, anon, authenticated;
grant execute on function public.product_question_ids(uuid) to service_role;

-- Vista pública de una pregunta (sin solución)
create or replace function public.question_presented(p_question uuid)
returns jsonb
language sql stable security definer set search_path = '' as $$
  select jsonb_build_object(
           'stem', q.stem,
           'options', (select jsonb_agg(o.body order by o.label)
                         from public.question_options o where o.question_id = q.id),
           'ref', q.source_ref)
    from public.questions q where q.id = p_question
$$;
revoke execute on function public.question_presented(uuid) from public, anon, authenticated;

-- Inicia una sesión con N preguntas al azar de un producto al que el alumno tiene acceso.
create or replace function public.practice_start_product(p_user uuid, p_product uuid, p_count int)
returns uuid
language plpgsql security definer set search_path = '' as $$
declare
  v_items jsonb;
  v_exam uuid;
begin
  if not public.has_product_access(p_product, p_user) then
    raise exception 'Sin acceso a este producto' using errcode = '42501';
  end if;
  select exam_body_id into v_exam from public.products where id = p_product;
  select jsonb_agg(jsonb_build_object(
           'source', 'question', 'item_type', 'question', 'category', q.category,
           'difficulty', q.difficulty, 'question_id', q.id,
           'presented', public.question_presented(q.id)))
    into v_items
    from (select q.* from public.questions q
           where q.id in (select public.product_question_ids(p_product))
           order by random()
           limit least(greatest(coalesce(p_count, 10), 1), 100)) q;
  if v_items is null then
    raise exception 'El producto no tiene preguntas publicadas' using errcode = '22023';
  end if;
  return public.practice_start(p_user, 'questions', 'question', v_items, v_exam);
end $$;
revoke execute on function public.practice_start_product(uuid, uuid, int) from public, anon, authenticated;
grant execute on function public.practice_start_product(uuid, uuid, int) to service_role;

-- Repaso: vuelve a plantear las preguntas falladas y sin resolver (máx. p_limit)
create or replace function public.practice_start_question_review(p_user uuid, p_limit int default 10)
returns uuid
language plpgsql security definer set search_path = '' as $$
declare
  v_items jsonb;
begin
  select jsonb_agg(jsonb_build_object(
           'source', 'question', 'item_type', 'question', 'category', f.category,
           'difficulty', f.difficulty, 'question_id', f.question_id,
           'presented', public.question_presented(f.question_id),
           'review_of_session', f.session_id, 'review_of_position', f.position))
    into v_items
    from (select distinct on (i.question_id) i.*
            from public.practice_items i
            join public.questions q on q.id = i.question_id and q.status = 'published'
           where i.user_id = p_user and i.source = 'question'
             and i.is_correct = false and i.reviewed_at is null
           order by i.question_id, i.answered_at desc) f
   limit least(greatest(coalesce(p_limit, 10), 1), 50);
  if v_items is null then
    return null;
  end if;
  return public.practice_start(p_user, 'review', 'question', v_items, null);
end $$;
revoke execute on function public.practice_start_question_review(uuid, int) from public, anon, authenticated;
grant execute on function public.practice_start_question_review(uuid, int) to service_role;

-- Corrige en SQL y registra. Devuelve acierto, índice correcto y explicación.
create or replace function public.practice_answer_question(
  p_user uuid, p_session uuid, p_position smallint, p_chosen smallint
) returns table (finished boolean, is_correct boolean, answer_index smallint, explanation jsonb)
language plpgsql security definer set search_path = '' as $$
declare
  v_item public.practice_items%rowtype;
  v_answer smallint;
  v_expl jsonb;
  v_n int;
  v_fin boolean;
begin
  select * into v_item from public.practice_items
   where session_id = p_session and position = p_position and user_id = p_user;
  if not found or v_item.source <> 'question' or v_item.question_id is null then
    raise exception 'Ítem no encontrado' using errcode = '42501';
  end if;
  -- la pregunta debe seguir publicada y con las mismas opciones que se mostraron
  if not exists (select 1 from public.questions where id = v_item.question_id and status = 'published')
     or public.question_presented(v_item.question_id)->'options' is distinct from v_item.presented->'options' then
    raise exception 'La pregunta ha cambiado' using errcode = '22023';
  end if;
  select count(*) into v_n from public.question_options where question_id = v_item.question_id;
  if p_chosen < 0 or p_chosen >= v_n then
    raise exception 'Opción no válida' using errcode = '22023';
  end if;
  select (ascii(o.label) - 65)::smallint into v_answer
    from public.question_options o where o.question_id = v_item.question_id and o.is_correct;
  select jsonb_build_object('text', q.explanation, 'ref', q.source_ref) into v_expl
    from public.questions q where q.id = v_item.question_id;

  select r.finished into v_fin
    from public.practice_record_answer(p_user, p_session, p_position, p_chosen,
                                       p_chosen = v_answer, v_answer, v_expl) r;
  return query select v_fin, p_chosen = v_answer, v_answer, v_expl;
end $$;
revoke execute on function public.practice_answer_question(uuid, uuid, smallint, smallint)
  from public, anon, authenticated;
grant execute on function public.practice_answer_question(uuid, uuid, smallint, smallint) to service_role;

-- my_library: indica cuántas preguntas jugables tiene cada producto
drop function if exists public.my_library();
create or replace function public.my_library()
returns table (product_id uuid, slug text, type public.product_type, title text, title_ca text,
               source text, ends_at timestamptz, is_test boolean, question_count bigint)
language sql stable security definer set search_path = '' as $$
  with me as (select auth.uid() as id)
  select p.id, p.slug, p.type, p.title, p.title_ca,
         coalesce(g.source::text, case when p.is_free then 'free' else 'subscription' end),
         g.ends_at, p.is_test,
         (select count(*) from public.product_question_ids(p.id))
    from public.products p
    cross join me
    left join lateral (
      select g.source, g.ends_at from public.access_grants g
       where g.user_id = me.id and g.product_id = p.id and g.revoked_at is null
         and g.starts_at <= now() and (g.ends_at is null or g.ends_at > now())
       order by g.created_at desc limit 1) g on true
   where me.id is not null and p.status = 'published' and p.type <> 'subscription'
     and public.has_product_access(p.id, me.id)
     and (g.source is not null
          or exists (select 1 from public.subscriptions s where s.user_id = me.id
                       and s.status in ('active', 'trialing')
                       and (s.current_period_end is null or s.current_period_end > now())))
   order by p.title
$$;
revoke execute on function public.my_library() from anon, public;
grant execute on function public.my_library() to authenticated;

-- >>> supabase/seed.sql
-- =====================================================================
-- Datos iniciales del catálogo (idempotente).
-- Solo nombres de organismos y cuerpos públicos. NO incluye convocatorias,
-- fechas, plazas, requisitos ni URLs: se añadirán desde administración
-- con fuentes oficiales verificadas (ver docs/CONTENT_POLICY.md).
-- Todas las oposiciones arrancan como 'coming_soon' (próxima incorporación).
-- =====================================================================

insert into public.regions (slug, name, level) values
  ('espana', 'España', 'estatal'),
  ('catalunya', 'Cataluña', 'autonomico'),
  ('comunidad-de-madrid', 'Comunidad de Madrid', 'autonomico')
on conflict (slug) do nothing;

insert into public.regions (slug, name, level, parent_id)
select 'barcelona', 'Barcelona', 'local', id from public.regions where slug = 'catalunya'
on conflict (slug) do nothing;

insert into public.organizations (slug, name, scope, region_id)
select v.slug, v.name, v.scope::public.scope_level, r.id
from (values
  ('direccion-general-policia', 'Dirección General de la Policía', 'estatal', 'espana'),
  ('direccion-general-guardia-civil', 'Dirección General de la Guardia Civil', 'estatal', 'espana'),
  ('instituciones-penitenciarias', 'Secretaría General de Instituciones Penitenciarias', 'estatal', 'espana'),
  ('administracion-general-estado', 'Administración General del Estado', 'estatal', 'espana'),
  ('administracion-justicia', 'Administración de Justicia', 'estatal', 'espana'),
  ('correos', 'Correos', 'estatal', 'espana'),
  ('generalitat-interior', 'Generalitat de Catalunya · Interior', 'autonomico', 'catalunya'),
  ('ajuntament-barcelona', 'Ajuntament de Barcelona', 'local', 'barcelona'),
  ('ayuntamientos', 'Ayuntamientos (varios)', 'local', 'espana')
) as v(slug, name, scope, region_slug)
join public.regions r on r.slug = v.region_slug
on conflict (slug) do nothing;

insert into public.exam_bodies
  (slug, organization_id, name, name_ca, short_description, short_description_ca, category, availability, is_published, sort_order)
select v.slug, o.id, v.name, v.name_ca, v.descr, v.descr_ca, v.category::public.exam_category,
       'coming_soon', true, v.sort_order
from (values
  ('mossos-esquadra', 'generalitat-interior', 'Mossos d''Esquadra', 'Mossos d''Esquadra',
   'Policía de Cataluña. Escala básica.', 'Policia de Catalunya. Escala bàsica.', 'seguridad', 10),
  ('policia-nacional-basica', 'direccion-general-policia', 'Policía Nacional · Escala Básica', 'Policia Nacional · Escala Bàsica',
   'Acceso a la categoría de policía.', 'Accés a la categoria de policia.', 'seguridad', 20),
  ('guardia-civil-cabos-guardias', 'direccion-general-guardia-civil', 'Guardia Civil · Cabos y Guardias', 'Guàrdia Civil · Cabos i Guàrdies',
   'Acceso a la escala de cabos y guardias.', 'Accés a l''escala de caporals i guàrdies.', 'seguridad', 30),
  ('guardia-urbana-barcelona', 'ajuntament-barcelona', 'Guardia Urbana de Barcelona', 'Guàrdia Urbana de Barcelona',
   'Policía local de Barcelona.', 'Policia local de Barcelona.', 'seguridad', 40),
  ('policia-local', 'ayuntamientos', 'Policías locales', 'Policies locals',
   'Convocatorias municipales de policía local.', 'Convocatòries municipals de policia local.', 'seguridad', 50),
  ('bombers-generalitat', 'generalitat-interior', 'Bombers de la Generalitat', 'Bombers de la Generalitat',
   'Bomberos de Cataluña.', 'Bombers de Catalunya.', 'emergencias', 60),
  ('ayudantes-instituciones-penitenciarias', 'instituciones-penitenciarias', 'Ayudantes de Instituciones Penitenciarias', 'Ajudants d''Institucions Penitenciàries',
   'Cuerpo de Ayudantes de IIPP.', 'Cos d''Ajudants d''IIPP.', 'penitenciaria', 70),
  ('auxiliar-administrativo-estado', 'administracion-general-estado', 'Auxiliar Administrativo del Estado', 'Auxiliar Administratiu de l''Estat',
   'Cuerpo General Auxiliar de la AGE.', 'Cos General Auxiliar de l''AGE.', 'administracion', 80),
  ('administrativo-estado', 'administracion-general-estado', 'Administrativo del Estado', 'Administratiu de l''Estat',
   'Cuerpo General Administrativo de la AGE.', 'Cos General Administratiu de l''AGE.', 'administracion', 90),
  ('tramitacion-procesal', 'administracion-justicia', 'Tramitación Procesal y Administrativa', 'Tramitació Processal i Administrativa',
   'Cuerpo de Justicia.', 'Cos de Justícia.', 'justicia', 100),
  ('auxilio-judicial', 'administracion-justicia', 'Auxilio Judicial', 'Auxili Judicial',
   'Cuerpo de Justicia.', 'Cos de Justícia.', 'justicia', 110),
  ('correos-personal-laboral', 'correos', 'Correos · Personal laboral', 'Correus · Personal laboral',
   'Ingreso de personal laboral fijo.', 'Ingrés de personal laboral fix.', 'correos', 120)
) as v(slug, org_slug, name, name_ca, descr, descr_ca, category, sort_order)
join public.organizations o on o.slug = v.org_slug
on conflict (slug) do nothing;

-- Lote mossos-b1-estatut-v1 (30 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Ley Orgánica 6/2006, de 19 de julio, de reforma del Estatuto de Autonomía de Cataluña (texto consolidado BOE, última actualización publicada el 28/12/2022)', 'https://www.boe.es/buscar/act.php?id=BOE-A-2006-13087', 'boe'::public.source_kind, 'Agencia Estatal Boletín Oficial del Estado', '2006-07-20') on conflict (url) do nothing;
insert into public.topics (slug, title) values ('mossos-b1-estatut', 'B.1 L''Estatut d''autonomia de Catalunya') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug = 'mossos-esquadra' and t.slug = 'mossos-b1-estatut' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 1 del Estatuto de Autonomía de Cataluña, ¿qué es el Estatuto para Cataluña?', 'El artículo 1 dice que Cataluña ejerce su autogobierno de acuerdo con la Constitución y con el Estatuto, «que es su norma institucional básica». No es una constitución soberana ni una ley del Parlamento catalán: se aprueba como ley orgánica de las Cortes Generales.', 'mossos_b1_estatut', (select id from public.topics where slug = 'mossos-b1-estatut'), 1, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2006-13087'), 'art. 1', 'Cataluña, como nacionalidad, ejerce su autogobierno constituida en Comunidad Autónoma de acuerdo con la Constitución y con el presente Estatuto, que es su norma institucional básica.', null, '349d55150a9a61159dd08fd773cfabb505a58840328a442e38319d84330b5a4d', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '349d55150a9a61159dd08fd773cfabb505a58840328a442e38319d84330b5a4d')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Su norma institucional básica', true), ('B', 'Su constitución soberana', false), ('C', 'Un reglamento de organización del Parlamento', false), ('D', 'Una ley ordinaria del Parlamento de Cataluña', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select '¿Cómo ejerce Cataluña su autogobierno según el artículo 1 del Estatuto?', 'El artículo 1 establece que «Cataluña, como nacionalidad, ejerce su autogobierno constituida en Comunidad Autónoma», de acuerdo con la Constitución y el Estatuto.', 'mossos_b1_estatut', (select id from public.topics where slug = 'mossos-b1-estatut'), 1, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2006-13087'), 'art. 1', 'Cataluña, como nacionalidad, ejerce su autogobierno constituida en Comunidad Autónoma de acuerdo con la Constitución', null, '24e8e454c6d7b58fa3bab60f3a78671f6038dcea2f6e120d8dd51b88b7454072', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '24e8e454c6d7b58fa3bab60f3a78671f6038dcea2f6e120d8dd51b88b7454072')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Como región foral con concierto económico', false), ('B', 'Como nacionalidad constituida en Comunidad Autónoma', true), ('C', 'Como Estado federado dentro de España', false), ('D', 'Como provincia con régimen especial', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'El artículo 2 del Estatuto define la Generalitat como:', 'Según el artículo 2.1, «la Generalitat es el sistema institucional en que se organiza políticamente el autogobierno de Cataluña». No es solo el Gobierno: el Gobierno es una de las instituciones que la integran.', 'mossos_b1_estatut', (select id from public.topics where slug = 'mossos-b1-estatut'), 1, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2006-13087'), 'art. 2.1', 'La Generalitat es el sistema institucional en que se organiza políticamente el autogobierno de Cataluña.', null, 'ad2e4f5d66682a035aa8d43d05349114ccbf42457769124cb52d7f66321586ba', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'ad2e4f5d66682a035aa8d43d05349114ccbf42457769124cb52d7f66321586ba')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El Gobierno de Cataluña y su Administración', false), ('B', 'La delegación del Gobierno del Estado en Cataluña', false), ('C', 'El sistema institucional en que se organiza políticamente el autogobierno de Cataluña', true), ('D', 'El conjunto de los ayuntamientos y consejos comarcales de Cataluña', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select '¿Cuál de las siguientes NO es una institución que integra la Generalitat según el artículo 2 del Estatuto?', 'El artículo 2.2 enumera el Parlamento, la Presidencia de la Generalitat, el Gobierno y las demás instituciones que establece el capítulo V del título II. El Tribunal Superior de Justicia de Cataluña forma parte del Poder Judicial, que es único para todo el Estado, y no es una institución de la Generalitat.', 'mossos_b1_estatut', (select id from public.topics where slug = 'mossos-b1-estatut'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2006-13087'), 'art. 2.2', 'La Generalitat es el sistema institucional en que se organiza políticamente el autogobierno de Cataluña.', 'EXTRACTO PARCIAL. El extracto leído es el 2.1. La enumeración del 2.2 (Parlamento, Presidencia, Gobierno y demás instituciones del cap. V del título II) debe contrastarse con el BOE.', '2622950636441b1b613ffb7ad4e2b4b9efb83e869285a58449fd339750841b32', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '2622950636441b1b613ffb7ad4e2b4b9efb83e869285a58449fd339750841b32')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El Parlamento', false), ('B', 'La Presidencia de la Generalitat', false), ('C', 'El Gobierno', false), ('D', 'El Tribunal Superior de Justicia de Cataluña', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 3 del Estatuto, las relaciones de la Generalitat con el Estado se fundamentan en el principio de:', 'El artículo 3.1 dice que esas relaciones «se fundamentan en el principio de la lealtad institucional mutua». La Generalitat no está subordinada jerárquicamente al Estado ni sometida a tutela administrativa.', 'mossos_b1_estatut', (select id from public.topics where slug = 'mossos-b1-estatut'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2006-13087'), 'art. 3.1', 'Las relaciones de la Generalitat con el Estado se fundamentan en el principio de la lealtad institucional mutua', null, 'b977cec1e4362672a28aae9d1bb5570b2c7775226b16cccd26f1950f51f831e3', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'b977cec1e4362672a28aae9d1bb5570b2c7775226b16cccd26f1950f51f831e3')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Lealtad institucional mutua', true), ('B', 'Subordinación jerárquica', false), ('C', 'Tutela administrativa', false), ('D', 'Reciprocidad fiscal', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select '¿Qué deben promover los poderes públicos de Cataluña según el artículo 4 del Estatuto?', 'El artículo 4.1 dispone que «los poderes públicos de Cataluña deben promover el pleno ejercicio de las libertades y los derechos» reconocidos en el Estatuto, la Constitución y los tratados internacionales.', 'mossos_b1_estatut', (select id from public.topics where slug = 'mossos-b1-estatut'), 1, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2006-13087'), 'art. 4.1', 'Los poderes públicos de Cataluña deben promover el pleno ejercicio de las libertades y los derechos', null, 'f3cfdea5cb802c2c0e58506e418d318acb9a88a7d138b248275b47ff83abb4de', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'f3cfdea5cb802c2c0e58506e418d318acb9a88a7d138b248275b47ff83abb4de')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'La unidad de mercado en todo el Estado', false), ('B', 'El pleno ejercicio de las libertades y los derechos', true), ('C', 'La recaudación de todos los tributos estatales', false), ('D', 'La reforma de la Constitución', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 5 del Estatuto, el autogobierno de Cataluña se fundamenta también en:', 'El artículo 5 establece que «el autogobierno de Cataluña se fundamenta también en los derechos históricos del pueblo catalán», además de en la Constitución.', 'mossos_b1_estatut', (select id from public.topics where slug = 'mossos-b1-estatut'), 1, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2006-13087'), 'art. 5', 'El autogobierno de Cataluña se fundamenta también en los derechos históricos del pueblo catalán', null, '3f07de2371b0051e93ccde5e24c564b6a20b189f636c3690f8ff5fed50988ba3', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '3f07de2371b0051e93ccde5e24c564b6a20b189f636c3690f8ff5fed50988ba3')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Los acuerdos del Consejo de Política Fiscal y Financiera', false), ('B', 'Las sentencias del Tribunal Supremo', false), ('C', 'Los derechos históricos del pueblo catalán', true), ('D', 'Los tratados de la Unión Europea', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select '¿Cuál es la lengua propia de Cataluña según el artículo 6 del Estatuto?', 'El artículo 6.1 dice literalmente: «La lengua propia de Cataluña es el catalán». El castellano es lengua oficial, pero el Estatuto no lo califica como lengua propia de Cataluña.', 'mossos_b1_estatut', (select id from public.topics where slug = 'mossos-b1-estatut'), 1, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2006-13087'), 'art. 6.1', 'La lengua propia de Cataluña es el catalán.', null, 'f2a9a8b24511b760f1140b7da8b8043851ce56abb1cd447d2f27cc390e162b08', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'f2a9a8b24511b760f1140b7da8b8043851ce56abb1cd447d2f27cc390e162b08')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El castellano', false), ('B', 'El occitano', false), ('C', 'El catalán y el castellano por igual', false), ('D', 'El catalán', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 6.2 del Estatuto, el catalán es la lengua oficial de Cataluña. ¿Qué otra lengua es también oficial según ese mismo apartado?', 'El artículo 6.2 dice: «El catalán es la lengua oficial de Cataluña. También lo es el castellano, que es la lengua oficial del Estado español». (El occitano, denominado aranés en Aran, se regula en el apartado 5, no en el 2.)', 'mossos_b1_estatut', (select id from public.topics where slug = 'mossos-b1-estatut'), 1, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2006-13087'), 'art. 6.2', 'El catalán es la lengua oficial de Cataluña. También lo es el castellano', null, 'd9ff9b26b55dba25488a95cecbbb5ec54e975092852e6aeccbbc97b678874303', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'd9ff9b26b55dba25488a95cecbbb5ec54e975092852e6aeccbbc97b678874303')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El castellano', true), ('B', 'El francés', false), ('C', 'Ninguna: solo el catalán es oficial', false), ('D', 'El inglés, como lengua de la Unión Europea', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 7 del Estatuto, ¿quiénes gozan de la condición política de catalanes?', 'El artículo 7.1 atribuye la condición política de catalanes o ciudadanos de Cataluña a los ciudadanos españoles que tienen vecindad administrativa en Cataluña. El lugar de nacimiento por sí solo no la da.', 'mossos_b1_estatut', (select id from public.topics where slug = 'mossos-b1-estatut'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2006-13087'), 'art. 7.1', 'Gozan de la condición política de catalanes o ciudadanos de Cataluña los ciudadanos españoles', 'EXTRACTO PARCIAL. El extracto leído se corta en «los ciudadanos españoles»; la continuación «que tienen vecindad administrativa en Cataluña» debe contrastarse con el BOE.', '37e085f0ec69abbd9ef5eb066073d22d07ec4090a60b73b5f55edbd7ae3d1801', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '37e085f0ec69abbd9ef5eb066073d22d07ec4090a60b73b5f55edbd7ae3d1801')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Todas las personas nacidas en Cataluña, sea cual sea su nacionalidad', false), ('B', 'Los ciudadanos españoles que tienen vecindad administrativa en Cataluña', true), ('C', 'Los residentes extranjeros con más de cinco años en Cataluña', false), ('D', 'Solo los descendientes de catalanes inscritos en el registro civil', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select '¿Cuáles son los símbolos nacionales de Cataluña según el artículo 8 del Estatuto?', 'El artículo 8.1 dice que Cataluña «tiene como símbolos nacionales la bandera, la fiesta y el himno». El escudo no aparece en esa enumeración.', 'mossos_b1_estatut', (select id from public.topics where slug = 'mossos-b1-estatut'), 1, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2006-13087'), 'art. 8.1', 'tiene como símbolos nacionales la bandera, la fiesta y el himno.', null, '16d467910f73ef915abd87918b572f48f3fcc66312fa75f15315a196e849cf04', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '16d467910f73ef915abd87918b572f48f3fcc66312fa75f15315a196e849cf04')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El escudo, la bandera y el himno', false), ('B', 'La bandera, la lengua y el territorio', false), ('C', 'La bandera, la fiesta y el himno', true), ('D', 'El himno, el escudo y la capital', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select '¿Qué día es la fiesta de Cataluña según el Estatuto?', 'El artículo 8.3 establece: «La fiesta de Cataluña es el Día Once de Septiembre».', 'mossos_b1_estatut', (select id from public.topics where slug = 'mossos-b1-estatut'), 1, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2006-13087'), 'art. 8.3', 'La fiesta de Cataluña es el Día Once de Septiembre.', null, '7e8c3fcba2a72a89bfd0bcbde9f5c80c2a1edd449cddeffdabdd5017f8e214ad', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '7e8c3fcba2a72a89bfd0bcbde9f5c80c2a1edd449cddeffdabdd5017f8e214ad')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El 23 de abril', false), ('B', 'El 24 de junio', false), ('C', 'El 6 de diciembre', false), ('D', 'El 11 de septiembre', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 8 del Estatuto, el himno de Cataluña es:', 'El artículo 8.4 dice: «El himno de Cataluña es Els segadors». Las demás son otras canciones, que el Estatuto no menciona.', 'mossos_b1_estatut', (select id from public.topics where slug = 'mossos-b1-estatut'), 1, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2006-13087'), 'art. 8.4', 'El himno de Cataluña es «Els segadors».', null, '9e8482832d4d3e31653b989acae644e8bbce291488490bcc123992c3f2d24a34', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '9e8482832d4d3e31653b989acae644e8bbce291488490bcc123992c3f2d24a34')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', '«Els segadors»', true), ('B', '«El cant de la senyera»', false), ('C', '«L''emigrant»', false), ('D', '«Cant del poble»', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 9 del Estatuto, el territorio de Cataluña es el que corresponde a:', 'El artículo 9 define el territorio de Cataluña como «el que corresponde a los límites geográficos y administrativos de la Generalitat» en el momento de la entrada en vigor del Estatuto. No se define por criterios lingüísticos, religiosos ni judiciales.', 'mossos_b1_estatut', (select id from public.topics where slug = 'mossos-b1-estatut'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2006-13087'), 'art. 9', 'El territorio de Cataluña es el que corresponde a los límites geográficos y administrativos de la Generalitat', null, '9827d7aacb426d1548bb40b854d5da8b691efe33b6c7f22b2504623e4a536edf', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '9827d7aacb426d1548bb40b854d5da8b691efe33b6c7f22b2504623e4a536edf')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Las cuatro diócesis históricas del antiguo Principado', false), ('B', 'Los límites geográficos y administrativos de la Generalitat', true), ('C', 'Los municipios de habla catalana', false), ('D', 'Los partidos judiciales del Tribunal Superior de Justicia', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select '¿Cuál es la capital de Cataluña según el artículo 10 del Estatuto?', 'El artículo 10 dice que «la capital de Cataluña es la ciudad de Barcelona», sede permanente del Parlamento, entre otras instituciones.', 'mossos_b1_estatut', (select id from public.topics where slug = 'mossos-b1-estatut'), 1, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2006-13087'), 'art. 10', 'La capital de Cataluña es la ciudad de Barcelona, que es la sede permanente del Parlamento', null, '0e73ca3123695703ce85bb0f51ebe3359e791ffff8038ac68178370a845646c9', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '0e73ca3123695703ce85bb0f51ebe3359e791ffff8038ac68178370a845646c9')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Tarragona', false), ('B', 'Girona', false), ('C', 'Barcelona', true), ('D', 'El Estatuto no fija una capital', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 10 del Estatuto, ¿de cuál de estas instituciones es Barcelona sede permanente?', 'El artículo 10 dice que Barcelona «es la sede permanente del Parlamento». El Tribunal Constitucional, el Senado y el Consejo General del Poder Judicial son instituciones del Estado con sede en Madrid.', 'mossos_b1_estatut', (select id from public.topics where slug = 'mossos-b1-estatut'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2006-13087'), 'art. 10', 'La capital de Cataluña es la ciudad de Barcelona, que es la sede permanente del Parlamento', null, 'c4efe22b4188ca4f351351e651050501acf7508b180311161444a378dfe1f846', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'c4efe22b4188ca4f351351e651050501acf7508b180311161444a378dfe1f846')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Del Tribunal Constitucional', false), ('B', 'Del Senado', false), ('C', 'Del Consejo General del Poder Judicial', false), ('D', 'Del Parlamento de Cataluña', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 11 del Estatuto, el pueblo aranés ejerce el autogobierno mediante el propio Estatuto y:', 'El artículo 11.1 dice que «el pueblo aranés ejerce el autogobierno mediante el presente Estatuto, el Conselh Generau de Aran» y las demás instituciones propias.', 'mossos_b1_estatut', (select id from public.topics where slug = 'mossos-b1-estatut'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2006-13087'), 'art. 11.1', 'El pueblo aranés ejerce el autogobierno mediante el presente Estatuto, el Conselh Generau de Aran', null, '1d3e9a97fbfca0a796e3dac9ba0cae419656f9bb69391bd94f3a973b8e1626c1', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '1d3e9a97fbfca0a796e3dac9ba0cae419656f9bb69391bd94f3a973b8e1626c1')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El Conselh Generau de Aran', true), ('B', 'La Diputación de Lleida', false), ('C', 'El Consejo Comarcal del Pallars Sobirà', false), ('D', 'El Síndic de Greuges', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select '¿Qué derecho reconoce el artículo 29.1 del Estatuto a los ciudadanos de Cataluña?', 'El artículo 29.1 reconoce que «los ciudadanos de Cataluña tienen derecho a participar en condiciones de igualdad en los asuntos públicos de Cataluña». Los otros derechos se regulan en otros preceptos (o en la Constitución).', 'mossos_b1_estatut', (select id from public.topics where slug = 'mossos-b1-estatut'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2006-13087'), 'art. 29.1', 'Los ciudadanos de Cataluña tienen derecho a participar en condiciones de igualdad en los asuntos públicos de Cataluña', null, 'c36cc2a306643b53df66692917fbb02a15b2a0a8a93775bf2c2604a04f23afa4', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'c36cc2a306643b53df66692917fbb02a15b2a0a8a93775bf2c2604a04f23afa4')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El derecho a una vivienda digna', false), ('B', 'El derecho a participar en condiciones de igualdad en los asuntos públicos de Cataluña', true), ('C', 'El derecho a la protección de datos personales', false), ('D', 'El derecho de huelga', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 55 del Estatuto, ¿a quién representa el Parlamento?', 'El artículo 55.1 dice: «El Parlamento representa al pueblo de Cataluña».', 'mossos_b1_estatut', (select id from public.topics where slug = 'mossos-b1-estatut'), 1, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2006-13087'), 'art. 55.1', 'El Parlamento representa al pueblo de Cataluña.', null, '4ae604f895abf4243bd2eda55b383381e158754f20fc7bffdd919ec4ba0786aa', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '4ae604f895abf4243bd2eda55b383381e158754f20fc7bffdd919ec4ba0786aa')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'A las provincias de Cataluña', false), ('B', 'A los partidos políticos con representación', false), ('C', 'Al pueblo de Cataluña', true), ('D', 'Al Gobierno de la Generalitat', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select '¿Qué institución aprueba los presupuestos de la Generalitat según el artículo 55 del Estatuto?', 'El artículo 55.2 atribuye al Parlamento la potestad legislativa y la aprobación de los presupuestos de la Generalitat. El Gobierno elabora el proyecto, pero quien lo aprueba es el Parlamento.', 'mossos_b1_estatut', (select id from public.topics where slug = 'mossos-b1-estatut'), 1, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2006-13087'), 'art. 55.2', 'El Parlamento ejerce la potestad legislativa, aprueba los presupuestos de la Generalitat', null, 'e43d003d795a390bbe8947bfe87ce826aa5b0fa52daddb08024bfbec9757781d', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'e43d003d795a390bbe8947bfe87ce826aa5b0fa52daddb08024bfbec9757781d')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El Gobierno', false), ('B', 'La Sindicatura de Cuentas', false), ('C', 'El Consejo de Garantías Estatutarias', false), ('D', 'El Parlamento', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 56 del Estatuto, ¿cuántos diputados puede tener el Parlamento de Cataluña?', 'El artículo 56.1 establece que el Parlamento «se compone de un mínimo de cien Diputados y un máximo de ciento cincuenta». La cifra concreta la fija la ley electoral; el Estatuto solo marca la horquilla.', 'mossos_b1_estatut', (select id from public.topics where slug = 'mossos-b1-estatut'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2006-13087'), 'art. 56.1', 'El Parlamento se compone de un mínimo de cien Diputados y un máximo de ciento cincuenta', null, 'f14377af85b549ae31ac146812172893e043da0aab0f654c20c9203a26d9f14b', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'f14377af85b549ae31ac146812172893e043da0aab0f654c20c9203a26d9f14b')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Entre 100 y 150', true), ('B', 'Exactamente 135', false), ('C', 'Entre 50 y 100', false), ('D', 'Entre 135 y 200', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 57 del Estatuto, los miembros del Parlamento son inviolables:', 'El artículo 57.1 dice que «los miembros del Parlamento son inviolables por los votos y las opiniones que emitan en el ejercicio de su cargo». La inviolabilidad no cubre cualquier acto, solo los votos y opiniones vinculados al ejercicio del cargo.', 'mossos_b1_estatut', (select id from public.topics where slug = 'mossos-b1-estatut'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2006-13087'), 'art. 57.1', 'Los miembros del Parlamento son inviolables por los votos y las opiniones que emitan en el ejercicio de su cargo.', null, '69f8e6666a0dfe65160a544f7b9bad045da60e55b465c52479b6f9de4f842476', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '69f8e6666a0dfe65160a544f7b9bad045da60e55b465c52479b6f9de4f842476')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Por cualquier acto realizado durante su mandato', false), ('B', 'Por los votos y las opiniones que emitan en el ejercicio de su cargo', true), ('C', 'Solo durante los periodos de sesiones', false), ('D', 'Por las declaraciones que hagan en los medios de comunicación', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select '¿Qué órgano designa a los senadores que representan a la Generalitat en el Senado?', 'El artículo 61 a) atribuye al Parlamento la función de «designar a los Senadores que representan a la Generalitat en el Senado».', 'mossos_b1_estatut', (select id from public.topics where slug = 'mossos-b1-estatut'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2006-13087'), 'art. 61 a)', 'a) Designar a los Senadores que representan a la Generalitat en el Senado.', null, '0c2715ef977290908bf4440ae01093da92cade7cfed14ba612b6c1735419ac42', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '0c2715ef977290908bf4440ae01093da92cade7cfed14ba612b6c1735419ac42')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El Presidente de la Generalitat', false), ('B', 'El Gobierno de la Generalitat', false), ('C', 'El Parlamento de Cataluña', true), ('D', 'Las Cortes Generales', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el primer inciso del artículo 62.1 del Estatuto, la iniciativa legislativa corresponde a:', 'El artículo 62.1 dice: «La iniciativa legislativa corresponde a los Diputados, a los grupos parlamentarios y al Gobierno». El mismo apartado la extiende después a la iniciativa popular y a determinados entes locales.', 'mossos_b1_estatut', (select id from public.topics where slug = 'mossos-b1-estatut'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2006-13087'), 'art. 62.1', 'La iniciativa legislativa corresponde a los Diputados, a los grupos parlamentarios y al Gobierno.', 'La explicación menciona la continuación del 62.1 (iniciativa popular y entes locales), que no está en el extracto leído.', '31d7a8d7528d159d5ce8f50f9ef77bfd7be5b6c93e57fce541a04110e9849e2b', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '31d7a8d7528d159d5ce8f50f9ef77bfd7be5b6c93e57fce541a04110e9849e2b')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Solo al Gobierno', false), ('B', 'Solo al Presidente de la Generalitat', false), ('C', 'Al Síndic de Greuges y al Gobierno', false), ('D', 'Los diputados, los grupos parlamentarios y el Gobierno', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select '¿En qué caso puede el Gobierno de la Generalitat dictar decretos-leyes según el artículo 64 del Estatuto?', 'El artículo 64.1 permite al Gobierno dictar disposiciones legislativas provisionales en forma de decreto-ley «en caso de una necesidad extraordinaria y urgente». La delegación del Parlamento da lugar a decretos legislativos, que son otra figura.', 'mossos_b1_estatut', (select id from public.topics where slug = 'mossos-b1-estatut'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2006-13087'), 'art. 64.1', 'En caso de una necesidad extraordinaria y urgente, el Gobierno puede dictar disposiciones legislativas provisionales', null, 'a5203d9d52cd333b2f00b44cc9f5f6acc0a77b439a592f3bee088f015d7ae6d5', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'a5203d9d52cd333b2f00b44cc9f5f6acc0a77b439a592f3bee088f015d7ae6d5')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'En caso de necesidad extraordinaria y urgente', true), ('B', 'Cuando el Parlamento delega en él la elaboración de un código', false), ('C', 'Siempre que el Parlamento esté disuelto, sin más requisitos', false), ('D', 'Para aprobar los presupuestos si no hay mayoría', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 64 del Estatuto, un decreto-ley queda derogado si no se convalida en un plazo improrrogable de:', 'El artículo 64.2 establece que los decretos-leyes quedan derogados si no se validan en el plazo improrrogable de treinta días subsiguientes a su promulgación.', 'mossos_b1_estatut', (select id from public.topics where slug = 'mossos-b1-estatut'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2006-13087'), 'art. 64.2', 'Los Decretos-leyes quedan derogados si en el plazo improrrogable de treinta días subsiguientes a la promulgación', null, 'c1db18d7f8f09a373a35fded7b10bea96188c929c26de72a854f654e573c8821', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'c1db18d7f8f09a373a35fded7b10bea96188c929c26de72a854f654e573c8821')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Quince días', false), ('B', 'Treinta días', true), ('C', 'Sesenta días', false), ('D', 'Noventa días', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 67 del Estatuto, ¿quién tiene la más alta representación de la Generalitat y dirige la acción del Gobierno?', 'El artículo 67.1 dice: «El Presidente o Presidenta tiene la más alta representación de la Generalitat y dirige la acción del Gobierno».', 'mossos_b1_estatut', (select id from public.topics where slug = 'mossos-b1-estatut'), 1, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2006-13087'), 'art. 67.1', 'El Presidente o Presidenta tiene la más alta representación de la Generalitat y dirige la acción del Gobierno.', null, '16ab182c78a2b550e29218d1c64e00f3154322ec6de670ad0af47cd3f0a5162d', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '16ab182c78a2b550e29218d1c64e00f3154322ec6de670ad0af47cd3f0a5162d')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El Presidente del Parlamento', false), ('B', 'El conseller primero', false), ('C', 'El Presidente o Presidenta de la Generalitat', true), ('D', 'El Delegado del Gobierno en Cataluña', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select '¿Cómo define el artículo 68 del Estatuto al Gobierno de la Generalitat?', 'El artículo 68.1 dice: «El Gobierno es el órgano superior colegiado que dirige la acción política y la Administración de la Generalitat».', 'mossos_b1_estatut', (select id from public.topics where slug = 'mossos-b1-estatut'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2006-13087'), 'art. 68.1', 'El Gobierno es el órgano superior colegiado que dirige la acción política y la Administración de la Generalitat.', null, '498bead04974ffae4d634f06184b7a5794f38ab69f4f91aa33711fbf74e97738', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '498bead04974ffae4d634f06184b7a5794f38ab69f4f91aa33711fbf74e97738')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Como órgano consultivo del Parlamento', false), ('B', 'Como órgano unipersonal de representación', false), ('C', 'Como órgano de control de la Administración local', false), ('D', 'Como órgano superior colegiado que dirige la acción política y la Administración de la Generalitat', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 70 del Estatuto, los miembros del Gobierno, por actos presuntamente delictivos cometidos en Cataluña durante su mandato, solo pueden ser detenidos o retenidos:', 'El artículo 70.1 establece que no pueden ser detenidos ni retenidos «salvo en el caso de delito flagrante».', 'mossos_b1_estatut', (select id from public.topics where slug = 'mossos-b1-estatut'), 3, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2006-13087'), 'art. 70.1', 'no pueden ser detenidos ni retenidos salvo en el caso de delito flagrante.', 'EXTRACTO PARCIAL. El extracto leído no incluye el sujeto del apartado. Contrastar con el BOE que el art. 70.1 se refiere al Presidente o Presidenta y a los consejeros (miembros del Gobierno).', '51ea3e6c177ba09b9371118bb5f595e982e4083ffc0f91d1e7fa4096c35fe3ad', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '51ea3e6c177ba09b9371118bb5f595e982e4083ffc0f91d1e7fa4096c35fe3ad')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'En caso de delito flagrante', true), ('B', 'Con autorización previa del Parlamento', false), ('C', 'Con autorización del Presidente de la Generalitat', false), ('D', 'Nunca mientras dure su mandato', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 71 del Estatuto, la Administración de la Generalitat:', 'El artículo 71.1 dice que «la Administración de la Generalitat sirve con objetividad los intereses generales» (y actúa con sometimiento pleno a la ley y al Derecho).', 'mossos_b1_estatut', (select id from public.topics where slug = 'mossos-b1-estatut'), 1, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2006-13087'), 'art. 71.1', 'La Administración de la Generalitat sirve con objetividad los intereses generales', null, 'fa4673eb4dc10568c53a8827578c115a09ef7b90e92208f84fef99a148196a2e', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'fa4673eb4dc10568c53a8827578c115a09ef7b90e92208f84fef99a148196a2e')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Sirve a los intereses del partido que gobierna', false), ('B', 'Sirve con objetividad los intereses generales', true), ('C', 'Depende orgánicamente de la Administración General del Estado', false), ('D', 'Solo actúa por delegación del Parlamento', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
-- Lote prueba-pack-demo-v1 (6 preguntas)
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select '[PRUEBA] ¿Cuánto es 2 + 3?', 'Pregunta de prueba: 2 + 3 = 5.', 'prueba', null, 1, 'es', false, null, 'prueba', null, null, '5f644279106d476c63303696d7b38f9c0675b424ce7d1964296fc9fa76a67f9f', true
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '5f644279106d476c63303696d7b38f9c0675b424ce7d1964296fc9fa76a67f9f')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', '4', false), ('B', '5', true), ('C', '6', false), ('D', '7', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select '[PRUEBA] ¿Qué color se obtiene al mezclar azul y amarillo?', 'Pregunta de prueba: azul + amarillo = verde.', 'prueba', null, 1, 'es', false, null, 'prueba', null, null, '69cc8629d93c58f2ae673ad53a850a87805ce30e18ee8d207884e07111de78af', true
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '69cc8629d93c58f2ae673ad53a850a87805ce30e18ee8d207884e07111de78af')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Verde', true), ('B', 'Morado', false), ('C', 'Naranja', false), ('D', 'Gris', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select '[PRUEBA] ¿Cuántos días tiene una semana?', 'Pregunta de prueba: una semana tiene 7 días.', 'prueba', null, 1, 'es', false, null, 'prueba', null, null, 'd25e8a797193f0c7c7c499799367730f9e0b8296a9db7cc52e6761259828646c', true
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'd25e8a797193f0c7c7c499799367730f9e0b8296a9db7cc52e6761259828646c')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', '5', false), ('B', '6', false), ('C', '8', false), ('D', '7', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select '[PRUEBA] ¿Cuál de estos animales es un mamífero?', 'Pregunta de prueba: el delfín es un mamífero.', 'prueba', null, 1, 'es', false, null, 'prueba', null, null, 'ef0ebcaef5083c91269e077949bd1a51e9966c983e13f6a4d1510e23d04bb043', true
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'ef0ebcaef5083c91269e077949bd1a51e9966c983e13f6a4d1510e23d04bb043')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Trucha', false), ('B', 'Gorrión', false), ('C', 'Delfín', true), ('D', 'Lagarto', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select '[PRUEBA] ¿Cuánto es 10 − 4?', 'Pregunta de prueba: 10 − 4 = 6.', 'prueba', null, 1, 'es', false, null, 'prueba', null, null, 'f758a826c9e330ff6aeb96809ac37545e7406f80986ae56ed788887753d1b3c6', true
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'f758a826c9e330ff6aeb96809ac37545e7406f80986ae56ed788887753d1b3c6')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', '6', true), ('B', '5', false), ('C', '7', false), ('D', '4', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select '[PRUEBA] ¿Qué mes va después de marzo?', 'Pregunta de prueba: después de marzo va abril.', 'prueba', null, 1, 'es', false, null, 'prueba', null, null, 'b6a45e45d0bcc3789c249be32b8d38d79c355b8ddae380e34ec06047afd51e94', true
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'b6a45e45d0bcc3789c249be32b8d38d79c355b8ddae380e34ec06047afd51e94')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Febrero', false), ('B', 'Abril', true), ('C', 'Mayo', false), ('D', 'Junio', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
