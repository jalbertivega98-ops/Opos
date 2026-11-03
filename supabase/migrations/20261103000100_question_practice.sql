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
