-- Publica en la PREVIEW la ampliación del temario de Guardia Civil (todo lo que puede entrar en examen),
-- sus fichas y los productos de lengua. Lo pidió joel (05/11/2026): «No dejes fuera nada que pueda entrar en
-- examen», dentro del flujo ya autorizado de publicar Guardia Civil. Equivale a «Aprobar lote» + «Publicar».
-- * Las preguntas DUDOSAS (con nota de revisión) NO se publican: quedan en borrador.
-- * Solo toca temas y productos gc-* y gcl-*. Idempotente. Requiere 34- y 35-.
begin;

do $$
declare
  v_owner uuid;
  v_slug text;
  v_q int := 0;
  v_n int := 0;
  v_p int := 0;
begin
  select id into v_owner from public.profiles
   where role = 'owner' and status = 'active' order by created_at limit 1;
  if v_owner is null then
    raise notice 'No hay persona titular: no se publica nada.';
    return;
  end if;
  perform set_config('request.jwt.claims',
    json_build_object('sub', v_owner, 'role', 'authenticated')::text, true);

  for v_slug in select slug from public.topics
                 where (slug like 'gc-%' or slug like 'gcl-%')
                 order by slug loop
    perform public.review_topic_batch(v_slug, 'approved', false);
    v_q := v_q + public.review_topic_batch(v_slug, 'published', false);
    perform public.review_topic_notes(v_slug, 'approved');
    v_n := v_n + public.review_topic_notes(v_slug, 'published');
  end loop;

  with pub as (
    update public.products p set status = 'published'
     where p.status = 'draft' and p.is_test = false
       and (p.slug like 'gc-%' or p.slug like 'gcl-%')
       and p.type <> 'bundle'
       and (p.type <> 'question_pack'
            or exists (select 1 from public.product_items i join public.questions q on q.id = i.question_id
                        where i.product_id = p.id and q.status = 'published'))
       and (p.type <> 'mock_exam'
            or (p.config->>'kind' = 'sections' and public.mock_sections_ready(p.id))
            or (coalesce(p.config->>'kind', '') <> 'sections'
                and (select count(*) from public.mock_pool(p.id)) >= (public.mock_config(p.config)->>'questions')::int))
    returning 1)
  select count(*) into v_p from pub;

  -- Los packs completos solo se publican si ya tienen algún producto publicado dentro
  with pub as (
    update public.products p set status = 'published'
     where p.status = 'draft' and p.is_test = false and p.type = 'bundle'
       and (p.slug like 'gc-%' or p.slug like 'gcl-%')
       and exists (select 1 from public.product_items i join public.products c on c.id = i.child_product_id
                    where i.product_id = p.id and c.status = 'published')
    returning 1)
  select v_p + count(*) into v_p from pub;

  perform public.open_exams_with_content();
  perform public.log_admin_action('content.publish_exam', 'exam_bodies',
    'guardia-civil-cabos-guardias',
    jsonb_build_object('questions', v_q, 'notes', v_n, 'products', v_p,
                       'motivo', 'Petición expresa de joel en el hilo del proyecto (05/11/2026: «No dejes fuera nada que pueda entrar en examen»)'));
  perform set_config('request.jwt.claims', '', true);
  raise notice 'Guardia Civil: % preguntas, % fichas y % productos publicados', v_q, v_n, v_p;
end $$;

commit;
