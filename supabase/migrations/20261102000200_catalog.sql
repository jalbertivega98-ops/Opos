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
