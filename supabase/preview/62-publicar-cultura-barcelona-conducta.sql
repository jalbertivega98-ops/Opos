-- Lo que antes no se podía practicar (joel, 06/11/2026: «para lo que no se puede practicar mira de buscar y preparar
-- algo similar o muy parecido»): cultura general y actualidad (Guardia Urbana y policía local), conocimiento de
-- Barcelona, bloque D de Ayudantes IIPP (conducta humana) y supuestos. Requiere 59- a 61-.
-- * Publica las preguntas nuevas sin nota de revisión (las dudosas quedan en borrador).
-- * Simulacros completos: Guardia Urbana 1.ª prueba entera (54 de temario + 18 de cultura + 18 de actualidad,
--   105 min, 0-21); policía local con las dos partes de Terrassa (50 + 50, 120 min, 0-24); IIPP con el bloque D
--   (37/31/48/4) y un simulacro de supuestos de 40.
-- * Packs nuevos de cultura general y actualidad. Las réplicas se recalculan con todas sus preguntas publicadas.
-- Idempotente.
begin;

do $$
declare
  v_owner uuid;
  v_slug text;
  v_q int := 0;
  v_n int := 0;
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
                 where slug like 'gub%' or slug like 'plcat%' or slug like 'iipp%'
                    or slug like 'cultcat-%' or slug like 'actcat-%'
                 order by slug loop
    perform public.review_topic_batch(v_slug, 'approved', false);
    v_q := v_q + public.review_topic_batch(v_slug, 'published', false);
    perform public.review_topic_notes(v_slug, 'approved');
    v_n := v_n + public.review_topic_notes(v_slug, 'published');
  end loop;
  perform public.log_admin_action('content.publish_exam', 'exam_bodies',
    'guardia-urbana-barcelona,policia-local,ayudantes-instituciones-penitenciarias',
    jsonb_build_object('questions', v_q, 'notes', v_n,
                       'motivo', 'Petición expresa de joel en el hilo del proyecto (06/11/2026)'));
  perform set_config('request.jwt.claims', '', true);
  raise notice 'Ampliación: % preguntas y % fichas publicadas', v_q, v_n;
end $$;

-- Packs nuevos
insert into public.products (slug, type, status, title, title_ca, description, description_ca,
                             exam_body_id, is_free, included_in_premium, config, published_at)
select v.slug, v.type::public.product_type, 'published', v.title, v.title_ca, v.descr, v.descr_ca,
       b.id, false, true, v.config::jsonb, now()
  from (values
    ('guardia-urbana-barcelona', 'gub-cultura-actualitat-2026', 'question_pack', 'Guardia Urbana de Barcelona · Cultura general y actualidad (en catalán)', 'Guardia Urbana de Barcelona · Cultura general i actualitat', 'Preguntas de 4 opciones de la parte cultural del examen: historia, geografía, arte, literatura, lengua catalana, ciencias, matemáticas, instituciones y economía, y actualidad de los últimos 12 meses (Cataluña, Barcelona, España, UE y mundo), todo con la cita literal de una fuente oficial. Repartidas como en los exámenes publicados.', 'Preguntes de 4 opcions de la part cultural de l''examen: història, geografia, art, literatura, llengua, ciències, matemàtiques, institucions i actualitat dels últims 12 mesos, amb la cita literal d''una font oficial.', '{"topic_slugs": ["cultcat-01-historia-catalunya", "cultcat-02-historia-espanya-mon", "cultcat-03-geografia", "cultcat-04-art-patrimoni", "cultcat-05-literatura", "cultcat-06-llengua-catalana", "cultcat-07-ciencies", "cultcat-08-matematiques", "cultcat-09-institucions-economia", "actcat-01-actualitat"], "locale": "ca"}'),
    ('policia-local', 'plcat-cultura-actualitat-2026', 'question_pack', 'Policía local de Cataluña · Cultura general y actualidad (en catalán)', 'Policia local de Catalunya · Cultura general i actualitat', 'Preguntas de 4 opciones de la parte cultural del examen: historia, geografía, arte, literatura, lengua catalana, ciencias, matemáticas, instituciones y economía, y actualidad de los últimos 12 meses (Cataluña, Barcelona, España, UE y mundo), todo con la cita literal de una fuente oficial. Repartidas como en los exámenes publicados.', 'Preguntes de 4 opcions de la part cultural de l''examen: història, geografia, art, literatura, llengua, ciències, matemàtiques, institucions i actualitat dels últims 12 mesos, amb la cita literal d''una font oficial.', '{"topic_slugs": ["cultcat-01-historia-catalunya", "cultcat-02-historia-espanya-mon", "cultcat-03-geografia", "cultcat-04-art-patrimoni", "cultcat-05-literatura", "cultcat-06-llengua-catalana", "cultcat-07-ciencies", "cultcat-08-matematiques", "cultcat-09-institucions-economia", "actcat-01-actualitat"], "locale": "ca"}'),
    ('ayudantes-instituciones-penitenciarias', 'iippsup-simulacro-supuestos-2026', 'mock_exam', 'Ayudantes de Instituciones Penitenciarias · Simulacro de supuestos (40 preguntas)', 'Ajudants d''Institucions Penitenciàries · Simulacre de supòsits (40 preguntes)', 'Como la segunda parte del examen: 40 preguntas de supuestos de un centro penitenciario (régimen y seguridad, tratamiento y permisos, disciplina y gestión), cada una con el dato del caso que necesita. 1 h 20 min, cada error resta 1/3. La nota son los puntos directos; para aprobar pide 26,67, el corte real de 2026.', 'Com la segona part de l''examen: 40 preguntes de supòsits. 1 h 20 min, cada error resta 1/3. Aprovat a 26,67 punts directes, el tall real del 2026.', '{"questions": 40, "minutes": 80, "penalty": 0.3333, "pass_mark": 26.67, "max_mark": 40, "topic_prefix": "iippsup-", "locale": "es"}')
  ) as v(exam, slug, type, title, title_ca, descr, descr_ca, config)
  join public.exam_bodies b on b.slug = v.exam
on conflict (slug) do nothing;

-- Simulacros con el examen completo
update public.products set config = '{"questions": 90, "minutes": 105, "penalty": 0.25, "pass_mark": 10, "max_mark": 21, "topic_prefix": "gub-", "locale": "ca", "quotas": [{"topic_prefix": "gub-t01-", "questions": 2}, {"topic_prefix": "gub-t02-", "questions": 2}, {"topic_prefix": "gub-t03-", "questions": 2}, {"topic_prefix": "gub-t04-", "questions": 2}, {"topic_prefix": "gub-t05-", "questions": 1}, {"topic_prefix": "gub-t06-", "questions": 1}, {"topic_prefix": "gub-t07-", "questions": 1}, {"topic_prefix": "gub-t08-", "questions": 1}, {"topic_prefix": "gub-t09-", "questions": 2}, {"topic_prefix": "gub-t10-", "questions": 2}, {"topic_prefix": "gub-t11-", "questions": 2}, {"topic_prefix": "gub-t12-", "questions": 2}, {"topic_prefix": "gub-t13-", "questions": 2}, {"topic_prefix": "gub-t14-", "questions": 2}, {"topic_prefix": "gub-t15-", "questions": 2}, {"topic_prefix": "gub-t16-", "questions": 2}, {"topic_prefix": "gub-t17-", "questions": 1}, {"topic_prefix": "gub-t18-", "questions": 1}, {"topic_prefix": "gub-t19-", "questions": 1}, {"topic_prefix": "gub-t20-", "questions": 2}, {"topic_prefix": "gub-t21-", "questions": 2}, {"topic_prefix": "gub-t22-", "questions": 1}, {"topic_prefix": "gub-t23-", "questions": 1}, {"topic_prefix": "gub-t24-", "questions": 1}, {"topic_prefix": "gub-t25-", "questions": 1}, {"topic_prefix": "gub-t26-", "questions": 1}, {"topic_prefix": "gub-t27-", "questions": 1}, {"topic_prefix": "gub-t28-", "questions": 2}, {"topic_prefix": "gub-t29-", "questions": 1}, {"topic_prefix": "gub-t30-", "questions": 1}, {"topic_prefix": "gub-t31-", "questions": 1}, {"topic_prefix": "gub-t32-", "questions": 1}, {"topic_prefix": "gub-t33-", "questions": 1}, {"topic_prefix": "gub-t34-", "questions": 2}, {"topic_prefix": "gub-t35-", "questions": 1}, {"topic_prefix": "gub-t36-", "questions": 1}, {"topic_prefix": "gub-t37-", "questions": 1}, {"topic_prefix": "gub-t38-", "questions": 1}, {"topic_prefix": "cultcat-07-", "questions": 6}, {"topic_prefix": "cultcat-01-", "questions": 2}, {"topic_prefix": "cultcat-02-", "questions": 2}, {"topic_prefix": "cultcat-03-", "questions": 2}, {"topic_prefix": "cultcat-04-", "questions": 2}, {"topic_prefix": "cultcat-05-", "questions": 2}, {"topic_prefix": "cultcat-06-", "questions": 1}, {"topic_prefix": "cultcat-09-", "questions": 1}, {"topic_prefix": "actcat-01-", "questions": 18}]}',
       title = 'Guardia Urbana de Barcelona · Simulacro de la primera prueba (90 preguntas)',
       title_ca = 'Guàrdia Urbana de Barcelona · Simulacre de la primera prova (90 preguntes)',
       description = 'Como la primera prueba: 90 preguntas de 4 opciones, 54 del temario (60 %), 18 de cultura general (20 %) y 18 de actualidad (20 %), repartidas como en los exámenes de 2022 a 2025. 105 minutos, cada error resta 1/4. Nota de 0 a 21 y mínimo 10.',
       description_ca = 'Com la primera prova: 90 preguntes de 4 opcions, 54 del temari, 18 de cultura general i 18 d''actualitat. 105 minuts, cada error resta 1/4. Nota de 0 a 21 i mínim 10.'
 where slug = 'gub-simulacre-temari-2026';

update public.products set config = '{"questions": 100, "minutes": 120, "penalty": 0.25, "pass_mark": 12, "max_mark": 24, "topic_prefix": "plcat-t", "locale": "ca", "quotas": [{"topic_prefix": "plcat-t06-", "questions": 4}, {"topic_prefix": "plcat-t07-", "questions": 3}, {"topic_prefix": "plcat-t08-", "questions": 2}, {"topic_prefix": "plcat-t09-", "questions": 5}, {"topic_prefix": "plcat-t01-", "questions": 2}, {"topic_prefix": "plcat-t02-", "questions": 2}, {"topic_prefix": "plcat-t03-", "questions": 3}, {"topic_prefix": "plcat-t04-", "questions": 2}, {"topic_prefix": "plcat-t05-", "questions": 2}, {"topic_prefix": "plcat-t11-", "questions": 2}, {"topic_prefix": "plcat-t12-", "questions": 2}, {"topic_prefix": "plcat-t13-", "questions": 3}, {"topic_prefix": "plcat-t14-", "questions": 2}, {"topic_prefix": "plcat-t15-", "questions": 3}, {"topic_prefix": "plcat-t16-", "questions": 2}, {"topic_prefix": "plcat-t17-", "questions": 2}, {"topic_prefix": "plcat-t18-", "questions": 2}, {"topic_prefix": "plcat-t19-", "questions": 2}, {"topic_prefix": "plcat-t20-", "questions": 2}, {"topic_prefix": "plcat-t21-", "questions": 1}, {"topic_prefix": "plcat-t10-", "questions": 1}, {"topic_prefix": "plcat-t22-", "questions": 1}, {"topic_prefix": "actcat-01-", "questions": 28}, {"topic_prefix": "cultcat-08-", "questions": 5}, {"topic_prefix": "cultcat-06-", "questions": 5}, {"topic_prefix": "cultcat-07-", "questions": 4}, {"topic_prefix": "cultcat-01-", "questions": 2}, {"topic_prefix": "cultcat-02-", "questions": 2}, {"topic_prefix": "cultcat-03-", "questions": 2}, {"topic_prefix": "cultcat-05-", "questions": 2}]}',
       title = 'Policía local de Cataluña · Simulacro del examen (100 preguntas)',
       title_ca = 'Policia local de Catalunya · Simulacre de l''examen (100 preguntes)',
       description = 'Como el examen de Terrassa (el modelo más habitual): 50 preguntas de la parte cultural (cultura general y actualidad) y 50 de la teórica, de 4 opciones, en 120 minutos. Cada error resta 1/4. Cada parte vale 12 puntos; aquí se suma todo y se aprueba con 12 de 24 (en el examen real, además, hay que sacar 4 en cada parte).',
       description_ca = 'Com l''examen de Terrassa: 50 preguntes de la part cultural i 50 de la teòrica, de 4 opcions, en 120 minuts. Cada error resta 1/4. Aprovat a 12 de 24.'
 where slug = 'plcat-simulacre-teoric-2026';

update public.products set config = '{"questions": 120, "minutes": 105, "penalty": 0.3333, "pass_mark": 67, "max_mark": 120, "topic_prefix": "iipp-", "locale": "es", "quotas": [{"topic_prefix": "iipp-a", "questions": 37}, {"topic_prefix": "iipp-b", "questions": 31}, {"topic_prefix": "iipp-c", "questions": 48}, {"topic_prefix": "iipp-d", "questions": 4}]}',
       description = 'Como la primera parte del examen: 120 preguntas de 4 opciones repartidas como en 2026 (37 de organización del Estado y derecho administrativo, 31 de derecho penal, 48 de derecho penitenciario y 4 de conducta humana). 1 h 45 min; cada error resta 1/3. La nota son los puntos directos (aciertos menos errores entre tres); para aprobar pide 67, el corte real de 2026.'
 where slug = 'iipp-simulacro-test-2026';

update public.products
   set description = 'Preguntas tipo test de 4 opciones de los cuatro bloques del programa oficial (BOE-A-2026-13226): organización del Estado y derecho administrativo (A1-A17), derecho penal (B1-B10), derecho penitenciario (C1-C20) y conducta humana (D1-D3, con los documentos oficiales de Instituciones Penitenciarias), con la cita literal de la fuente.'
 where slug = 'iipp-temario-2026';

update public.products
   set description = 'Preguntas tipo test de 4 opciones, en catalán como el examen, de los 38 temas del temario oficial de agente (convocatoria 29/2025) y conocimiento de Barcelona: Constitución, Estatut, régimen local, Carta Municipal, ordenanzas, policía, seguridad, derecho penal y procesal, tráfico y primeros auxilios, con la cita literal de la fuente oficial.'
 where slug = 'gub-temari-2026';

-- Réplicas: ya incluyen la parte cultural y el conocimiento de Barcelona
update public.products set config = jsonb_build_object('topic_prefix', 'gubexamen-2025', 'locale', 'ca',
       'questions', (select count(*)::int from public.mock_prefix_pool('gubexamen-2025', 'ca', false)), 'minutes', greatest(10, ceil(1.17 * (select count(*)::int from public.mock_prefix_pool('gubexamen-2025', 'ca', false)))::int), 'penalty', 0.25,
       'max_mark', 21, 'pass_mark', 10,
       'quotas', jsonb_build_array(jsonb_build_object('topic_prefix', 'gubexamen-2025', 'questions', (select count(*)::int from public.mock_prefix_pool('gubexamen-2025', 'ca', false))))),
       description = 'Las preguntas del examen oficial de 2025 (convocatoria 29/2025: temario, cultura general y actualidad) repetidas una a una con redacción propia: misma norma o mismo concepto y mismo tipo de pregunta; la actualidad antigua se cambia por un hecho reciente del mismo tipo. 4 opciones, cada error resta 1/4, 105 minutos para 90 preguntas como en el examen real; nota de 0 a 21 y mínimo 10. Examen oficial: https://ajuntament.barcelona.cat/seuelectronica/estatics/files/convocatories/2025_29_OP_134pl_Agent_GUB_Questionari_Solucionari_Cultural.pdf', description_ca = 'Las preguntas del examen oficial de 2025 (convocatoria 29/2025: temario, cultura general y actualidad) repetidas una a una con redacción propia: misma norma o mismo concepto y mismo tipo de pregunta; la actualidad antigua se cambia por un hecho reciente del mismo tipo. 4 opciones, cada error resta 1/4, 105 minutos para 90 preguntas como en el examen real; nota de 0 a 21 y mínimo 10. Examen oficial: https://ajuntament.barcelona.cat/seuelectronica/estatics/files/convocatories/2025_29_OP_134pl_Agent_GUB_Questionari_Solucionari_Cultural.pdf'
 where slug = 'gub-simulacre-examen-2025' and (select count(*)::int from public.mock_prefix_pool('gubexamen-2025', 'ca', false)) > 0;

update public.products set config = jsonb_build_object('topic_prefix', 'gubexamen-2023', 'locale', 'ca',
       'questions', (select count(*)::int from public.mock_prefix_pool('gubexamen-2023', 'ca', false)), 'minutes', greatest(10, ceil(1.17 * (select count(*)::int from public.mock_prefix_pool('gubexamen-2023', 'ca', false)))::int), 'penalty', 0.25,
       'max_mark', 21, 'pass_mark', 10,
       'quotas', jsonb_build_array(jsonb_build_object('topic_prefix', 'gubexamen-2023', 'questions', (select count(*)::int from public.mock_prefix_pool('gubexamen-2023', 'ca', false))))),
       description = 'Las preguntas del examen oficial de 2023 (temario, cultura general, actualidad y conocimiento de Barcelona) repetidas una a una con redacción propia; la actualidad antigua se cambia por un hecho reciente del mismo tipo. 4 opciones, cada error resta 1/4; nota de 0 a 21 y mínimo 10. Examen oficial: https://ajuntament.barcelona.cat/seuelectronica/estatics/files/convocatories/2023_311_OP_128pl_Agent_GUB_Questionari_Solucionari_Cultural_i_Teorica.pdf', description_ca = 'Las preguntas del examen oficial de 2023 (temario, cultura general, actualidad y conocimiento de Barcelona) repetidas una a una con redacción propia; la actualidad antigua se cambia por un hecho reciente del mismo tipo. 4 opciones, cada error resta 1/4; nota de 0 a 21 y mínimo 10. Examen oficial: https://ajuntament.barcelona.cat/seuelectronica/estatics/files/convocatories/2023_311_OP_128pl_Agent_GUB_Questionari_Solucionari_Cultural_i_Teorica.pdf'
 where slug = 'gub-simulacre-examen-2023' and (select count(*)::int from public.mock_prefix_pool('gubexamen-2023', 'ca', false)) > 0;

update public.products set config = jsonb_build_object('topic_prefix', 'gubexamen-2022', 'locale', 'ca',
       'questions', (select count(*)::int from public.mock_prefix_pool('gubexamen-2022', 'ca', false)), 'minutes', greatest(10, ceil(1.13 * (select count(*)::int from public.mock_prefix_pool('gubexamen-2022', 'ca', false)))::int), 'penalty', 0.25,
       'max_mark', 24, 'pass_mark', 12,
       'quotas', jsonb_build_array(jsonb_build_object('topic_prefix', 'gubexamen-2022', 'questions', (select count(*)::int from public.mock_prefix_pool('gubexamen-2022', 'ca', false))))),
       description = 'Los dos ejercicios oficiales de 2022 (cultural y teórico) repetidos pregunta a pregunta con redacción propia; la actualidad antigua se cambia por un hecho reciente del mismo tipo. 4 opciones, cada error resta 1/4, 120 minutos para los dos; nota de 0 a 24 y aprobado con 12 (en el examen real, además, 4 en cada ejercicio). Examen oficial: https://ajuntament.barcelona.cat/seuelectronica/estatics/files/questionnaries_solutions/2022_7_OP_241pl_Agent_GUB_Questionari_Solucionari_Teorica.pdf', description_ca = 'Los dos ejercicios oficiales de 2022 (cultural y teórico) repetidos pregunta a pregunta con redacción propia; la actualidad antigua se cambia por un hecho reciente del mismo tipo. 4 opciones, cada error resta 1/4, 120 minutos para los dos; nota de 0 a 24 y aprobado con 12 (en el examen real, además, 4 en cada ejercicio). Examen oficial: https://ajuntament.barcelona.cat/seuelectronica/estatics/files/questionnaries_solutions/2022_7_OP_241pl_Agent_GUB_Questionari_Solucionari_Teorica.pdf'
 where slug = 'gub-simulacre-examen-2022' and (select count(*)::int from public.mock_prefix_pool('gubexamen-2022', 'ca', false)) > 0;

update public.products set config = jsonb_build_object('topic_prefix', 'plcatexamen-2026-terrassa', 'locale', 'ca',
       'questions', (select count(*)::int from public.mock_prefix_pool('plcatexamen-2026-terrassa', 'ca', false)), 'minutes', greatest(10, ceil(1.2 * (select count(*)::int from public.mock_prefix_pool('plcatexamen-2026-terrassa', 'ca', false)))::int), 'penalty', 0.25,
       'max_mark', 24, 'pass_mark', 12,
       'quotas', jsonb_build_array(jsonb_build_object('topic_prefix', 'plcatexamen-2026-terrassa', 'questions', (select count(*)::int from public.mock_prefix_pool('plcatexamen-2026-terrassa', 'ca', false))))),
       description = 'El examen oficial de agente de policía local de Terrassa 2026 (parte cultural y parte teórica) repetido pregunta a pregunta con redacción propia; la actualidad local se cambia por hechos de Cataluña o Barcelona. 4 opciones, cada error resta 1/4, 120 minutos; nota de 0 a 24 y aprobado con 12 (en el examen real, además, 4 en cada parte). Examen oficial: https://aoberta.terrassa.cat/ocupacio/detallOferta.jsp?id=5266', description_ca = 'El examen oficial de agente de policía local de Terrassa 2026 (parte cultural y parte teórica) repetido pregunta a pregunta con redacción propia; la actualidad local se cambia por hechos de Cataluña o Barcelona. 4 opciones, cada error resta 1/4, 120 minutos; nota de 0 a 24 y aprobado con 12 (en el examen real, además, 4 en cada parte). Examen oficial: https://aoberta.terrassa.cat/ocupacio/detallOferta.jsp?id=5266'
 where slug = 'plcat-simulacre-examen-2026-terrassa' and (select count(*)::int from public.mock_prefix_pool('plcatexamen-2026-terrassa', 'ca', false)) > 0;

update public.products set config = jsonb_build_object('topic_prefix', 'plcatexamen-2025-terrassa', 'locale', 'ca',
       'questions', (select count(*)::int from public.mock_prefix_pool('plcatexamen-2025-terrassa', 'ca', false)), 'minutes', greatest(10, ceil(1.2 * (select count(*)::int from public.mock_prefix_pool('plcatexamen-2025-terrassa', 'ca', false)))::int), 'penalty', 0.25,
       'max_mark', 24, 'pass_mark', 12,
       'quotas', jsonb_build_array(jsonb_build_object('topic_prefix', 'plcatexamen-2025-terrassa', 'questions', (select count(*)::int from public.mock_prefix_pool('plcatexamen-2025-terrassa', 'ca', false))))),
       description = 'El examen oficial de agente de policía local de Terrassa 2025 (parte cultural y parte teórica) repetido pregunta a pregunta con redacción propia; la actualidad local se cambia por hechos de Cataluña o Barcelona. 4 opciones, cada error resta 1/4, 120 minutos; nota de 0 a 24 y aprobado con 12. Examen oficial: https://aoberta.terrassa.cat/ocupacio/detallOferta.jsp?id=4446', description_ca = 'El examen oficial de agente de policía local de Terrassa 2025 (parte cultural y parte teórica) repetido pregunta a pregunta con redacción propia; la actualidad local se cambia por hechos de Cataluña o Barcelona. 4 opciones, cada error resta 1/4, 120 minutos; nota de 0 a 24 y aprobado con 12. Examen oficial: https://aoberta.terrassa.cat/ocupacio/detallOferta.jsp?id=4446'
 where slug = 'plcat-simulacre-examen-2025-terrassa' and (select count(*)::int from public.mock_prefix_pool('plcatexamen-2025-terrassa', 'ca', false)) > 0;

update public.products set config = jsonb_build_object('topic_prefix', 'iipp-examen-2026-test', 'locale', 'es',
       'questions', (select count(*)::int from public.mock_prefix_pool('iipp-examen-2026-test', 'es', false)), 'minutes', greatest(10, ceil(0.875 * (select count(*)::int from public.mock_prefix_pool('iipp-examen-2026-test', 'es', false)))::int), 'penalty', 0.3333,
       'max_mark', (select count(*)::int from public.mock_prefix_pool('iipp-examen-2026-test', 'es', false)), 'pass_mark', round(67::numeric * (select count(*)::int from public.mock_prefix_pool('iipp-examen-2026-test', 'es', false)) / 120, 2),
       'quotas', jsonb_build_array(jsonb_build_object('topic_prefix', 'iipp-examen-2026-test', 'questions', (select count(*)::int from public.mock_prefix_pool('iipp-examen-2026-test', 'es', false)))))
 where slug = 'iipp-simulacro-examen-2026' and (select count(*)::int from public.mock_prefix_pool('iipp-examen-2026-test', 'es', false)) > 0;

update public.products set config = jsonb_build_object('topic_prefix', 'iipp-examen-2026-casos', 'locale', 'es',
       'questions', (select count(*)::int from public.mock_prefix_pool('iipp-examen-2026-casos', 'es', false)), 'minutes', greatest(10, ceil(2.0 * (select count(*)::int from public.mock_prefix_pool('iipp-examen-2026-casos', 'es', false)))::int), 'penalty', 0.3333,
       'max_mark', (select count(*)::int from public.mock_prefix_pool('iipp-examen-2026-casos', 'es', false)), 'pass_mark', round(26.6667::numeric * (select count(*)::int from public.mock_prefix_pool('iipp-examen-2026-casos', 'es', false)) / 40, 2),
       'quotas', jsonb_build_array(jsonb_build_object('topic_prefix', 'iipp-examen-2026-casos', 'questions', (select count(*)::int from public.mock_prefix_pool('iipp-examen-2026-casos', 'es', false)))))
 where slug = 'iipp-simulacro-examen-2026-casos' and (select count(*)::int from public.mock_prefix_pool('iipp-examen-2026-casos', 'es', false)) > 0;

insert into public.product_items (product_id, position, question_id)
select p.id, row_number() over (partition by p.id order by t.slug, q.created_at), q.id
  from public.products p
  join public.topics t on t.slug like (p.config->>'topic_prefix') || '%'
  join public.questions q on q.topic_id = t.id and q.is_test = false and q.status = 'published'
 where p.type = 'question_pack' and p.slug in ('gub-temari-2026', 'iipp-temario-2026', 'iippsup-supuestos-2026')
   and not exists (select 1 from public.product_items x where x.product_id = p.id and x.question_id = q.id);

-- Los packs de 10 simulacros incluyen también el nuevo de supuestos
insert into public.product_items (product_id, position, child_product_id)
select pk.id, coalesce((select max(position) from public.product_items x where x.product_id = pk.id), 0) + 1, c.id
  from public.products pk join public.products c on c.slug = 'iippsup-simulacro-supuestos-2026'
 where pk.slug = 'iipp-10-simulacros' and public.mock_quotas_ready(c.id)
   and not exists (select 1 from public.product_items i where i.product_id = pk.id and i.child_product_id = c.id);

commit;
