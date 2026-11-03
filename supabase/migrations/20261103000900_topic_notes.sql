-- Fichas de estudio por tema (CNT-011): índice, «Idees força» y «Glossari» copiados
-- literalmente de la fuente oficial (Guia d'estudi), con sus páginas y las esmenes
-- oficiales. Mismo flujo editorial que las preguntas (DEC-002 / DEC-006): entran en
-- borrador y solo la persona titular las aprueba y publica. El alumnado registrado
-- solo lee las publicadas.

create table public.topic_notes (
  id uuid primary key default gen_random_uuid(),
  topic_id uuid not null references public.topics (id) on delete cascade,
  locale public.locale_code not null default 'ca',
  -- [{ "n": "1.1", "title": "…" }]
  outline jsonb not null default '[]'::jsonb check (jsonb_typeof(outline) = 'array'),
  -- ["idea literal", …]
  key_ideas jsonb not null default '[]'::jsonb check (jsonb_typeof(key_ideas) = 'array'),
  -- ["terme", …]
  glossary jsonb not null default '[]'::jsonb check (jsonb_typeof(glossary) = 'array'),
  -- [{ "text": "…", "url": "https://…" }] (esmenes oficials)
  amendments jsonb not null default '[]'::jsonb check (jsonb_typeof(amendments) = 'array'),
  source_id uuid references public.sources (id) on delete set null,
  source_url text check (source_url ~ '^https://'),
  page_from int check (page_from > 0),
  page_to int check (page_to >= page_from),
  key_ideas_page int,
  status public.content_status not null default 'draft',
  review_note text,
  reviewed_by uuid references auth.users (id) on delete set null,
  reviewed_at timestamptz,
  published_at timestamptz,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  unique (topic_id, locale)
);
create trigger topic_notes_updated_at before update on public.topic_notes
  for each row execute function public.tg_set_updated_at();

-- Transiciones válidas y revisión humana obligatoria antes de publicar.
-- Cualquier cambio de contenido de una ficha aprobada/publicada la devuelve a revisión.
create or replace function public.tg_topic_note_guard()
returns trigger language plpgsql security definer set search_path = '' as $$
begin
  if (new.outline, new.key_ideas, new.glossary, new.amendments)
     is distinct from (old.outline, old.key_ideas, old.glossary, old.amendments)
     and old.status in ('approved', 'published') and new.status = old.status then
    new.status := 'needs_review';
    new.reviewed_by := null;
    new.reviewed_at := null;
    new.published_at := null;
    return new;
  end if;
  if new.status = old.status then
    return new;
  end if;
  if (old.status, new.status) not in (
    ('draft', 'needs_review'), ('needs_review', 'draft'), ('needs_review', 'approved'),
    ('approved', 'published'), ('approved', 'needs_review'), ('published', 'archived'),
    ('published', 'needs_review'), ('archived', 'needs_review')
  ) then
    raise exception 'Transición % -> % no permitida', old.status, new.status using errcode = '22023';
  end if;
  if new.status in ('approved', 'published') and jsonb_array_length(new.key_ideas) = 0 then
    raise exception 'La ficha necesita contenido antes de aprobarse' using errcode = '22023';
  end if;
  if new.status = 'approved' then
    if auth.uid() is null then
      raise exception 'Aprobar una ficha requiere a la persona titular' using errcode = '42501';
    end if;
    new.reviewed_by := auth.uid();
    new.reviewed_at := now();
  end if;
  if new.status = 'published' then
    if new.reviewed_by is null then
      raise exception 'No se puede publicar sin revisión humana' using errcode = '22023';
    end if;
    new.published_at := now();
  end if;
  if new.status in ('needs_review', 'draft') then
    new.reviewed_by := null;
    new.reviewed_at := null;
    new.published_at := null;
  end if;
  return new;
end $$;
create trigger topic_notes_guard before update on public.topic_notes
  for each row execute function public.tg_topic_note_guard();

alter table public.topic_notes enable row level security;
create policy "topic_notes: publicadas" on public.topic_notes for select to authenticated
  using (status = 'published');
create policy "topic_notes: staff lee" on public.topic_notes for select to authenticated
  using (public.is_staff());
revoke all on public.topic_notes from anon;
revoke insert, update, delete on public.topic_notes from authenticated;
grant select on public.topic_notes to authenticated;

-- Aprobar o publicar la ficha de un tema (o todas, con p_topic_slug null).
-- security definer: el alumnado y el staff no escriben la tabla directamente.
create or replace function public.review_topic_notes(
  p_topic_slug text,
  p_to public.content_status
)
returns integer
language plpgsql security definer set search_path = '' as $$
declare
  v_n record;
  v_done integer := 0;
begin
  if not public.is_owner() then
    raise exception 'Solo la persona titular puede aprobar o publicar fichas' using errcode = '42501';
  end if;
  if p_to not in ('approved', 'published') then
    raise exception 'Destino no permitido: %', p_to using errcode = '22023';
  end if;
  for v_n in
    select n.id, n.status, t.slug from public.topic_notes n
      join public.topics t on t.id = n.topic_id
     where (p_topic_slug is null or t.slug = p_topic_slug)
       and n.status = any (case when p_to = 'approved'
                                then array['draft', 'needs_review']::public.content_status[]
                                else array['approved']::public.content_status[] end)
     order by t.slug
     for update of n
  loop
    if v_n.status = 'draft' then
      update public.topic_notes set status = 'needs_review' where id = v_n.id;
    end if;
    update public.topic_notes set status = p_to where id = v_n.id;
    v_done := v_done + 1;
    perform public.log_admin_action('topic_notes.' || p_to::text, 'topic_notes', v_n.id::text,
      jsonb_build_object('topic', v_n.slug));
  end loop;
  return v_done;
end $$;
revoke execute on function public.review_topic_notes(text, public.content_status) from anon, public;
grant execute on function public.review_topic_notes(text, public.content_status) to authenticated;

-- «Aprobar y publicar todo» (review_all_batch) también publica las fichas pendientes.
create or replace function public.review_all_batch(p_include_flagged boolean default false)
returns jsonb
language plpgsql security invoker set search_path = '' as $$
declare
  v_slug text;
  v_published int := 0;
  v_products int := 0;
  v_notes int := 0;
  v_p record;
begin
  if not public.is_owner() then
    raise exception 'Solo la persona titular puede aprobar o publicar por lotes' using errcode = '42501';
  end if;

  for v_slug in
    select distinct t.slug from public.topics t
      join public.questions q on q.topic_id = t.id
     where q.is_test = false and q.status in ('draft', 'needs_review', 'approved')
     order by t.slug
  loop
    perform public.review_topic_batch(v_slug, 'approved', p_include_flagged);
    v_published := v_published + public.review_topic_batch(v_slug, 'published', p_include_flagged);
  end loop;

  -- fichas sin nota de revisión (las dudosas, solo si se piden)
  perform public.review_topic_notes(t.slug, 'approved')
     from public.topic_notes n join public.topics t on t.id = n.topic_id
    where n.status in ('draft', 'needs_review') and (p_include_flagged or n.review_note is null);
  v_notes := public.review_topic_notes(null, 'published');

  for v_p in
    select p.id, p.type, p.config from public.products p
     where p.status = 'draft' and p.is_test = false and p.config ? 'topic_prefix'
       and p.type in ('question_pack', 'mock_exam')
  loop
    if (v_p.type = 'question_pack'
          and exists (select 1 from public.product_items i
                        join public.questions q on q.id = i.question_id
                       where i.product_id = v_p.id and q.status = 'published'))
       or (v_p.type = 'mock_exam'
          and (select count(*) from public.questions q
                 join public.topics t on t.id = q.topic_id
                where q.status = 'published' and q.is_test = false
                  and t.slug like (v_p.config->>'topic_prefix') || '%'
                  and (v_p.config->>'locale' is null or q.locale::text = v_p.config->>'locale'))
              >= (public.mock_config(v_p.config)->>'questions')::int) then
      update public.products set status = 'published' where id = v_p.id;
      v_products := v_products + 1;
    end if;
  end loop;

  perform public.log_admin_action('content.publish_all', 'questions', null,
    jsonb_build_object('questions', v_published, 'products', v_products, 'notes', v_notes,
                       'include_flagged', p_include_flagged));
  return jsonb_build_object('questions', v_published, 'products', v_products, 'notes', v_notes);
end $$;
revoke execute on function public.review_all_batch(boolean) from anon, public;
grant execute on function public.review_all_batch(boolean) to authenticated;

-- Fichas publicadas de una oposición, en orden de temario (para /app/temario).
create or replace function public.exam_topic_notes(p_exam_slug text)
returns table (slug text, title text, title_ca text, page_from int, page_to int, key_ideas int)
language sql stable security invoker set search_path = '' as $$
  select t.slug, t.title, t.title_ca, n.page_from, n.page_to, jsonb_array_length(n.key_ideas)
    from public.exam_bodies b
    join public.exam_body_topics e on e.exam_body_id = b.id
    join public.topics t on t.id = e.topic_id
    join public.topic_notes n on n.topic_id = t.id and n.status = 'published'
   where b.slug = p_exam_slug
   order by e.order_index, t.slug
$$;
revoke execute on function public.exam_topic_notes(text) from anon, public;
grant execute on function public.exam_topic_notes(text) to authenticated;
