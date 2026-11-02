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
