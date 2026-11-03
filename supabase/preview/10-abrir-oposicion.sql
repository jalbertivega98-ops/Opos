-- Mossos pasa a «disponible» al publicar su temario y quien la seguía ve su plan.
-- Ejecutar después de 9. Idempotente. Si ya pulsaste «Aprobar y publicar todo», se aplica al momento.
begin;
-- Al publicar el temario, la oposición pasa de «próximamente» a «disponible»
-- y los alumnos que la seguían pasan a prepararla (ven su plan).

-- security definer: actualiza los objetivos de otros alumnos (la RLS solo deja
-- tocar los propios). Solo lo ejecuta la titular o el propio servidor.
create or replace function public.open_exams_with_content()
returns integer
language plpgsql security definer set search_path = '' as $$
declare
  v_n integer;
begin
  if auth.uid() is not null and not public.is_owner() then
    raise exception 'Solo la persona titular' using errcode = '42501';
  end if;
  with opened as (
    update public.exam_bodies b set availability = 'available'
     where b.availability = 'coming_soon'
       and exists (select 1 from public.exam_body_topics e
                     join public.questions q on q.topic_id = e.topic_id
                    where e.exam_body_id = b.id and q.status = 'published' and q.is_test = false)
    returning b.id)
  select count(*) into v_n from opened;
  update public.user_exam_targets u set follow_only = false
    from public.exam_bodies b
   where u.exam_body_id = b.id and u.follow_only and b.availability <> 'coming_soon'
     and exists (select 1 from public.exam_body_topics e
                   join public.questions q on q.topic_id = e.topic_id
                  where e.exam_body_id = b.id and q.status = 'published' and q.is_test = false);
  return v_n;
end $$;
revoke execute on function public.open_exams_with_content() from public, anon;
grant execute on function public.open_exams_with_content() to authenticated;

create or replace function public.review_all_batch(p_include_flagged boolean default false)
returns jsonb
language plpgsql security invoker set search_path = '' as $$
declare
  v_slug text;
  v_published int := 0;
  v_products int := 0;
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

  -- productos que salen junto al contenido (sin preguntas propias)
  with pub as (
    update public.products set status = 'published'
     where status = 'draft' and is_test = false and config->>'publish_with_content' = 'true'
    returning 1)
  select v_products + count(*) into v_products from pub;

  -- oposiciones con temario publicado dejan de estar «próximamente» y quien
  -- las seguía pasa a prepararlas (así ve su plan y su contenido)
  perform public.open_exams_with_content();

  perform public.log_admin_action('content.publish_all', 'questions', null,
    jsonb_build_object('questions', v_published, 'products', v_products,
                       'include_flagged', p_include_flagged));
  return jsonb_build_object('questions', v_published, 'products', v_products);
end $$;


-- Aplicar ya a lo que esté publicado
select public.open_exams_with_content();
commit;
