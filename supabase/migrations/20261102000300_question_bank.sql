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
