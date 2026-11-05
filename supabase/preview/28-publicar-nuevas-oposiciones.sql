-- Publica en la PREVIEW el temario de Administrativo del Estado, Auxilio Judicial, Tramitación Procesal y
-- Policía Nacional (Escala Básica), con sus fichas y productos.
-- Lo pidió joel expresamente (hilo «Preparar temarios de nuevas oposiciones», 04/11/2026): «ves buscando
-- temarios de otras opos, para ir preparando, verificando y publicando» y «Revisa y rellenas todas las opos
-- posibles. Verifica la información en Fuentes». Se aplica al fusionar el PR (que hace joel).
-- Equivale a pulsar, como titular, «Aprobar lote» + «Publicar» en cada tema nuevo.
--
-- * Las preguntas DUDOSAS (con nota de revisión) NO se publican: quedan en borrador para que joel
--   las mire en /admin/revision/fuentes.
-- * Cada cambio pasa por el guardián de estados y queda en la auditoría a nombre de la titular.
-- * Solo toca temas age-adm-*, jus-*, justra-* y pn-* y los productos de este lote. Idempotente.
-- Requiere 23- a 27-.
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
                 where slug like 'age-adm-%' or slug like 'jus-%' or slug like 'justra-%' or slug like 'pn-%'
                 order by slug loop
    perform public.review_topic_batch(v_slug, 'approved', false);
    v_q := v_q + public.review_topic_batch(v_slug, 'published', false);
    perform public.review_topic_notes(v_slug, 'approved');
    v_n := v_n + public.review_topic_notes(v_slug, 'published');
  end loop;

  with pub as (
    update public.products p set status = 'published'
     where p.status = 'draft' and p.is_test = false
       and (p.slug like 'age-adm-%' or p.slug like 'jus-%' or p.slug like 'pn-%')
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
       and (p.slug like 'age-adm-%' or p.slug like 'jus-%' or p.slug like 'pn-%')
       and exists (select 1 from public.product_items i join public.products c on c.id = i.child_product_id
                    where i.product_id = p.id and c.status = 'published')
    returning 1)
  select v_p + count(*) into v_p from pub;

  perform public.open_exams_with_content();
  perform public.log_admin_action('content.publish_exam', 'exam_bodies',
    'administrativo-estado, auxilio-judicial, tramitacion-procesal, policia-nacional-basica',
    jsonb_build_object('questions', v_q, 'notes', v_n, 'products', v_p,
                       'motivo', 'Petición expresa de joel en el hilo del proyecto (04/11/2026)'));
  perform set_config('request.jwt.claims', '', true);
  raise notice 'Nuevas oposiciones: % preguntas, % fichas y % productos publicados', v_q, v_n, v_p;
end $$;

commit;
