-- Simulacros de examen de Guardia Civil y Policía Nacional (hilo «Crear simulacros reales de Policía Nacional y
-- Guardia Civil», 11/11/2026). joel lo pidió en el hilo de la oferta: «al final tenemos el contenido, solo tenemos que
-- generar preguntas y simulacros nosotros. dale adelante».
-- * Guardia Civil: 4 réplicas pregunta a pregunta de los cuestionarios OFICIALES que publica la Jefatura de Enseñanza
--   (2026 y los tres ejercicios de 2022). Temas gcexamen-*.
-- * Policía Nacional: no publica sus cuestionarios, así que son 2 exámenes tipo de 100 preguntas NUEVAS con su formato
--   y el reparto del temario. Temas pnexamen-tipo-*.
-- * Las preguntas DUDOSAS (con nota de revisión) NO se publican; el simulacro saca todas las publicadas de su tema.
-- * Los simulacros nuevos entran en el Premium de su oposición. No van al pack de 10 simulacros: son exámenes fijos
--   (siempre las mismas preguntas), como las demás réplicas (ADR-048, punto 4: slug con «-examen-»).
-- Idempotente. Requiere 87- (preguntas). Equivale a «Aprobar lote» + «Publicar» como titular.
begin;

-- Productos (borrador hasta tener preguntas publicadas)
insert into public.products (slug, type, status, title, title_ca, description, description_ca,
                             exam_body_id, is_free, included_in_premium, config)
select v.slug, 'mock_exam', 'draft', v.title, v.title_ca, v.descr, v.descr_ca, b.id, false, true, '{}'::jsonb
  from (values
    ('gc-simulacro-examen-2026', 'guardia-civil-cabos-guardias',
     'Guardia Civil · Examen 2026 (réplica)', 'Guàrdia Civil · Examen 2026 (rèplica)',
     'La prueba de conocimientos oficial del 11/07/2026 repetida pregunta a pregunta: cada pregunta replica la del mismo número (misma norma, mismo artículo y mismo tipo) con redacción propia; si la norma ha cambiado, pregunta por la versión vigente. 100 preguntas de 4 opciones, cada error resta 1/3, 90 minutos. Nota de 0 a 100; el aprobado oficial es 50 y la mediana de quienes pasaron en 2026 fue 60. Cuestionario oficial: https://web.guardiacivil.es/export/sites/guardiaCivil/documentos/pdfs/2026/Procesos_Selectivos_2026/INGRESO-GC-2026-TIPO-A.pdf',
     'La prova de coneixements oficial de l''11/07/2026 repetida pregunta a pregunta amb redacció pròpia (mateixa norma, mateix article i mateix tipus). 100 preguntes, cada error resta 1/3, 90 minuts. Nota de 0 a 100; aprovat a 50.'),
    ('gc-simulacro-examen-2022-1', 'guardia-civil-cabos-guardias',
     'Guardia Civil · Examen 2022, ejercicio 1 (réplica)', 'Guàrdia Civil · Examen 2022, exercici 1 (rèplica)',
     'El primer ejercicio de conocimientos oficial de 2022 repetido pregunta a pregunta con redacción propia (misma norma, mismo artículo y mismo tipo), con las normas vigentes hoy. Las preguntas de materias que ya no están en el temario (historia general, literatura, ciencias) se cambian por el punto más cercano del temario actual. 100 preguntas de 4 opciones, cada error resta 1/3, 90 minutos. Nota de 0 a 100; aprobado 50. Cuestionario oficial: https://web.guardiacivil.es/export/sites/guardiaCivil/documentos/pdfs/2022/IngresoGC2022/INGRESO_GC_2022_1A.PDF',
     'El primer exercici de coneixements oficial del 2022 repetit pregunta a pregunta amb redacció pròpia i les normes vigents. 100 preguntes, cada error resta 1/3, 90 minuts. Nota de 0 a 100; aprovat a 50.'),
    ('gc-simulacro-examen-2022-2', 'guardia-civil-cabos-guardias',
     'Guardia Civil · Examen 2022, ejercicio 2 (réplica)', 'Guàrdia Civil · Examen 2022, exercici 2 (rèplica)',
     'El segundo ejercicio de conocimientos oficial de 2022 repetido pregunta a pregunta con redacción propia (misma norma, mismo artículo y mismo tipo), con las normas vigentes hoy. Las preguntas de materias que ya no están en el temario se cambian por el punto más cercano del temario actual. 100 preguntas de 4 opciones, cada error resta 1/3, 90 minutos. Nota de 0 a 100; aprobado 50. Cuestionario oficial: https://web.guardiacivil.es/export/sites/guardiaCivil/documentos/pdfs/2022/IngresoGC2022/INGRESO_GC_2022_2A.PDF',
     'El segon exercici de coneixements oficial del 2022 repetit pregunta a pregunta amb redacció pròpia i les normes vigents. 100 preguntes, cada error resta 1/3, 90 minuts. Nota de 0 a 100; aprovat a 50.'),
    ('gc-simulacro-examen-2022-3', 'guardia-civil-cabos-guardias',
     'Guardia Civil · Examen 2022, ejercicio 3 (réplica)', 'Guàrdia Civil · Examen 2022, exercici 3 (rèplica)',
     'El tercer ejercicio de conocimientos oficial de 2022 repetido pregunta a pregunta con redacción propia (misma norma, mismo artículo y mismo tipo), con las normas vigentes hoy. Las preguntas de materias que ya no están en el temario se cambian por el punto más cercano del temario actual. 100 preguntas de 4 opciones, cada error resta 1/3, 90 minutos. Nota de 0 a 100; aprobado 50. Cuestionario oficial: https://web.guardiacivil.es/export/sites/guardiaCivil/documentos/pdfs/2022/IngresoGC2022/INGRESO_GC_2022_3A.PDF',
     'El tercer exercici de coneixements oficial del 2022 repetit pregunta a pregunta amb redacció pròpia i les normes vigents. 100 preguntes, cada error resta 1/3, 90 minuts. Nota de 0 a 100; aprovat a 50.'),
    ('pn-simulacro-examen-tipo-1', 'policia-nacional-basica',
     'Policía Nacional · Examen tipo 1', 'Policia Nacional · Examen tipus 1',
     'Un examen completo con preguntas que no están en el banco de test: 100 preguntas de los 45 temas (2 por tema y 3 en los de más peso), ordenadas por tema como en la prueba real. 3 opciones, cada error resta medio acierto, 50 minutos. Nota de 0 a 10; el aprobado se pone en 7, cerca de los cortes reales (7,05 en 2026 y ≈7,17 en 2025). La Policía Nacional no publica sus cuestionarios: no es un examen oficial, sino uno con su formato.',
     'Un examen complet amb preguntes que no són al banc de test: 100 preguntes dels 45 temes, 3 opcions, cada error resta mig encert, 50 minuts. Nota de 0 a 10; aprovat a 7. No és un examen oficial (la Policia Nacional no publica els qüestionaris).'),
    ('pn-simulacro-examen-tipo-2', 'policia-nacional-basica',
     'Policía Nacional · Examen tipo 2', 'Policia Nacional · Examen tipus 2',
     'Otro examen completo con preguntas distintas de las del banco y del examen tipo 1: 100 preguntas de los 45 temas (2 por tema y 3 en los de más peso), ordenadas por tema como en la prueba real. 3 opciones, cada error resta medio acierto, 50 minutos. Nota de 0 a 10; el aprobado se pone en 7, cerca de los cortes reales (7,05 en 2026 y ≈7,17 en 2025). La Policía Nacional no publica sus cuestionarios: no es un examen oficial, sino uno con su formato.',
     'Un altre examen complet amb preguntes diferents de les del banc i de l''examen tipus 1: 100 preguntes dels 45 temes, 3 opcions, cada error resta mig encert, 50 minuts. Nota de 0 a 10; aprovat a 7. No és un examen oficial.')
  ) as v(slug, exam, title, title_ca, descr, descr_ca)
  join public.exam_bodies b on b.slug = v.exam
on conflict (slug) do nothing;

-- Publicar las preguntas de los temas nuevos (las dudosas se quedan en borrador)
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
                 where slug like 'gcexamen-%' or slug like 'pnexamen-%' order by slug loop
    perform public.review_topic_batch(v_slug, 'approved', false);
    v_q := v_q + public.review_topic_batch(v_slug, 'published', false);
  end loop;
  perform public.log_admin_action('content.publish_exam', 'exam_bodies',
    'guardia-civil-cabos-guardias,policia-nacional-basica',
    jsonb_build_object('questions', v_q,
                       'motivo', 'Simulacros de examen pedidos por joel en el hilo del proyecto (11/11/2026)'));
  perform set_config('request.jwt.claims', '', true);
  raise notice 'Simulacros de examen GC/PN: % preguntas publicadas', v_q;
end $$;

-- Configuración: tantas preguntas como tenga publicadas cada examen
update public.products p set config = jsonb_build_object('topic_prefix', v.pfx, 'locale', 'es',
       'questions', n.cnt, 'minutes', greatest(10, ceil(v.min_per_q * n.cnt)::int), 'penalty', v.penalty,
       'max_mark', v.max_mark, 'pass_mark', v.pass_mark,
       'quotas', jsonb_build_array(jsonb_build_object('topic_prefix', v.pfx, 'questions', n.cnt)))
  from (values
    ('gc-simulacro-examen-2026', 'gcexamen-2026', 0.9, 0.3333, 100, 50),
    ('gc-simulacro-examen-2022-1', 'gcexamen-2022-1', 0.9, 0.3333, 100, 50),
    ('gc-simulacro-examen-2022-2', 'gcexamen-2022-2', 0.9, 0.3333, 100, 50),
    ('gc-simulacro-examen-2022-3', 'gcexamen-2022-3', 0.9, 0.3333, 100, 50),
    ('pn-simulacro-examen-tipo-1', 'pnexamen-tipo-1', 0.5, 0.5, 10, 7),
    ('pn-simulacro-examen-tipo-2', 'pnexamen-tipo-2', 0.5, 0.5, 10, 7)
  ) as v(slug, pfx, min_per_q, penalty, max_mark, pass_mark)
  cross join lateral (select count(*)::int as cnt from public.mock_prefix_pool(v.pfx, 'es', false)) n
 where p.slug = v.slug and n.cnt > 0;

update public.products p set status = 'published', published_at = coalesce(p.published_at, now())
 where p.status = 'draft' and p.is_test = false and p.type = 'mock_exam'
   and p.slug in ('gc-simulacro-examen-2026', 'gc-simulacro-examen-2022-1', 'gc-simulacro-examen-2022-2',
                  'gc-simulacro-examen-2022-3', 'pn-simulacro-examen-tipo-1', 'pn-simulacro-examen-tipo-2')
   and (p.config->>'questions')::int > 0 and public.mock_quotas_ready(p.id);

commit;
