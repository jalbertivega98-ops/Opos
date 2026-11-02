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
