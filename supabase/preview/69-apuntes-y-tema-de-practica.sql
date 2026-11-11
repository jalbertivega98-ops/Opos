-- Copia de supabase/migrations/20261110000200_topic_lessons_and_session_topic.sql (ADR-046).
-- Apuntes por tema (topic_notes.lessons, topic_lessons) y tema de una práctica (my_session_topic). Idempotente.
begin;
-- =====================================================================
-- Apuntes por tema y «otras 10 preguntas» al acabar un test (10/11/2026).
-- joel: el alumno que va directo a los tests no tiene temario; y el test de
-- un tema debería ser de 10 preguntas, con otras 10 hasta dominarlo.
--  * topic_notes.lessons: apuntes redactados a partir de la norma oficial,
--    [{n, title, blocks: [{text, refs: [{ref, law, url, quote}]}]}]. Cada
--    párrafo lleva su cita literal (build.py --check). Son contenido de pago:
--    la columna no se lee directamente; topic_lessons() la da solo a quien
--    puede practicar el tema (temas gratis, Premium o pack) o al personal.
--  * my_session_topic(): el tema de una práctica de un solo tema y el
--    progreso del alumno en él, para la pantalla de resultados.
-- =====================================================================

alter table public.topic_notes
  add column if not exists lessons jsonb not null default '[]'::jsonb
  check (jsonb_typeof(lessons) = 'array');

-- Cambiar los apuntes de una ficha publicada también la devuelve a revisión
create or replace function public.tg_topic_note_guard()
returns trigger language plpgsql security definer set search_path = '' as $$
begin
  if (new.outline, new.key_ideas, new.glossary, new.amendments, new.lessons)
     is distinct from (old.outline, old.key_ideas, old.glossary, old.amendments, old.lessons)
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

-- La columna de apuntes no se lee con un select directo
revoke select on public.topic_notes from authenticated;
grant select (id, topic_id, locale, outline, key_ideas, glossary, amendments, source_id, source_url,
              page_from, page_to, key_ideas_page, status, review_note, reviewed_by, reviewed_at,
              published_at, created_at, updated_at)
  on public.topic_notes to authenticated;

-- Apuntes de un tema: publicados y para quien puede practicarlo (o el personal)
create or replace function public.topic_lessons(p_topic_slug text)
returns jsonb
language sql stable security definer set search_path = '' as $$
  select n.lessons
    from public.topic_notes n
    join public.topics t on t.id = n.topic_id
   where t.slug = p_topic_slug
     and auth.uid() is not null
     and (public.is_staff()
          or (n.status = 'published'
              and exists (select 1 from public.accessible_topic_questions(auth.uid(), t.id))))
   order by n.locale = 'ca' desc
   limit 1
$$;
revoke execute on function public.topic_lessons(text) from public, anon;
grant execute on function public.topic_lessons(text) to authenticated;

-- Tema de una práctica (si todas sus preguntas son de un mismo tema) y progreso en él
create or replace function public.my_session_topic(p_session uuid)
returns table (slug text, title text, title_ca text, published bigint, answered bigint, correct bigint)
language sql stable security definer set search_path = '' as $$
  with me as (select auth.uid() as id),
  s as (
    select s.id from public.practice_sessions s, me
     where s.id = p_session and s.user_id = me.id and s.item_type = 'question'
  ),
  tp as (
    select q.topic_id from public.practice_items i
      join s on s.id = i.session_id
      join public.questions q on q.id = i.question_id
     group by q.topic_id
  ),
  one as (select topic_id from tp where (select count(*) from tp) = 1),
  mine as (
    select i.question_id, i.is_correct from public.practice_items i, me
     where i.user_id = me.id and i.question_id is not null and i.is_correct is not null
    union all
    select m.question_id, m.is_correct from public.mock_attempt_items m, me
     where m.user_id = me.id and m.question_id is not null and m.is_correct is not null
  )
  select t.slug, t.title, t.title_ca,
         (select count(*) from public.questions q
           where q.topic_id = t.id and q.status = 'published' and q.is_test = false),
         count(m.question_id), count(*) filter (where m.is_correct)
    from one
    join public.topics t on t.id = one.topic_id
    left join public.questions q on q.topic_id = t.id
    left join mine m on m.question_id = q.id
   group by t.id, t.slug, t.title, t.title_ca
$$;
revoke execute on function public.my_session_topic(uuid) from public, anon;
grant execute on function public.my_session_topic(uuid) to authenticated;
commit;
