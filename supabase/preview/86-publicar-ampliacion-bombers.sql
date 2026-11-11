-- Publica en la PREVIEW la ampliación de Bombers de la Generalitat cargada con 85-: 680 preguntas nuevas de los
-- 34 temas (de 20 a 40 por tema) y 53 nuevas de la réplica 81/25 (de 20 a 73). Encargo de joel del 11/11/2026
-- («al final tenemos el contenido, solo tenemos que generar preguntas y simulacros nosotros. dale adelante»).
-- * Las preguntas con nota de revisión NO se publican (no hay ninguna en este lote).
-- * El simulacro réplica 81/25 pasa a sacar todas sus preguntas publicadas y se actualiza su descripción.
-- * Las preguntas nuevas entran en el pack «bomb-temari-2026».
-- Idempotente. Requiere 85-. Equivale a «Aprobar lote» + «Publicar» como titular.
begin;

do $$
declare
  v_owner uuid;
  v_slug text;
  v_q int := 0;
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
                 where slug like 'bomb-t%' or slug = 'bombexamen-2025'
                 order by slug loop
    perform public.review_topic_batch(v_slug, 'approved', false);
    v_q := v_q + public.review_topic_batch(v_slug, 'published', false);
  end loop;
  perform public.log_admin_action('content.publish_exam', 'exam_bodies', 'bombers-generalitat',
    jsonb_build_object('questions', v_q,
                       'motivo', 'Ampliación del banco de Bombers pedida por joel en el proyecto (11/11/2026)'));
  perform set_config('request.jwt.claims', '', true);
  raise notice 'Bombers: % preguntas publicadas', v_q;
end $$;

-- Simulacro réplica 81/25: todas las preguntas publicadas del examen (mismo cálculo de tiempo que 56-)
update public.products set config = jsonb_build_object('topic_prefix', 'bombexamen-2025', 'locale', 'ca',
       'questions', (select count(*)::int from public.mock_prefix_pool('bombexamen-2025', 'ca', false)), 'minutes', greatest(10, ceil(1.15 * (select count(*)::int from public.mock_prefix_pool('bombexamen-2025', 'ca', false)))::int), 'penalty', 0.25,
       'max_mark', 8, 'pass_mark', 4,
       'quotas', jsonb_build_array(jsonb_build_object('topic_prefix', 'bombexamen-2025', 'questions', (select count(*)::int from public.mock_prefix_pool('bombexamen-2025', 'ca', false))))),
       title = 'Bombers de la Generalitat · Examen 81/25 (réplica)',
       title_ca = 'Bombers de la Generalitat · Examen 81/25 (rèplica)',
       description = 'Una pregunta propia por cada pregunta oficial de la prueba de conocimientos 81/25 (model A) que sigue en el temario de 2026 y tiene fuente oficial: mismo punto y mismo tipo (definición, situación, artículo o cálculo), con redacción y cifras nuevas. Se dejan fuera la geografía, la meteorología y las anuladas. 4 opciones, cada error resta 1/4; nota de 0 a 8 y mínimo 4. Examen oficial: https://interior.gencat.cat/web/.content/home/030_arees_dactuacio/bombers/acces_al_cos_de_bombers/convocatories/convocatories_de_bombers/ACCES-81_25/PLANTILLES/QUESTIONARI_MODEL_A_81-25.pdf',
       description_ca = 'Una pregunta pròpia per cada pregunta oficial de la prova de coneixements 81/25 (model A) que segueix al temari de 2026 i té font oficial: mateix punt i mateix tipus (definició, situació, article o càlcul), amb redacció i xifres noves. Queden fora la geografia, la meteorologia i les anul·lades. 4 opcions, cada error resta 1/4; nota de 0 a 8 i mínim 4. Examen oficial: https://interior.gencat.cat/web/.content/home/030_arees_dactuacio/bombers/acces_al_cos_de_bombers/convocatories/convocatories_de_bombers/ACCES-81_25/PLANTILLES/QUESTIONARI_MODEL_A_81-25.pdf'
 where slug = 'bomb-simulacre-examen-2025' and (select count(*)::int from public.mock_prefix_pool('bombexamen-2025', 'ca', false)) > 0;

-- Pack de test del temario: añade las preguntas nuevas publicadas detrás de las que ya tenía
insert into public.product_items (product_id, position, question_id)
select p.id,
       coalesce((select max(i.position) from public.product_items i where i.product_id = p.id), 0)
         + row_number() over (partition by p.id order by t.slug, q.created_at),
       q.id
  from public.products p
  join public.topics t on t.slug like (p.config->>'topic_prefix') || '%'
  join public.questions q on q.topic_id = t.id and q.is_test = false and q.status = 'published'
 where p.type = 'question_pack' and p.slug = 'bomb-temari-2026'
   and not exists (select 1 from public.product_items i where i.product_id = p.id and i.question_id = q.id)
on conflict do nothing;

commit;
