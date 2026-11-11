-- Ampliación de Auxiliar Administrativo del Estado: 40 preguntas por tema (480 nuevas): preguntas en BORRADOR con cita literal de la fuente oficial y fichas de estudio.
-- Generado: bash scripts/content/preview-sql.sh content/auxiliar-estado supabase/preview/85a-ampliacion-preguntas-auxiliar-estado.sql. Idempotente. Solo trae las preguntas nuevas (las de «// Ampliación 11/11/2026» en fuentes-oficiales); las ya cargadas no se tocan.
begin;
-- Lote age-aux-b1-01-constitucion-ce-v1 (20 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Constitución Española (texto consolidado, BOE)', 'https://www.boe.es/buscar/act.php?id=BOE-A-1978-31229', 'boe'::public.source_kind, 'Agencia Estatal Boletín Oficial del Estado', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('age-aux-b1-01-constitucion', 'I.1 La Constitución Española de 1978: principios, valores, derechos y deberes') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('auxiliar-administrativo-estado') and t.slug = 'age-aux-b1-01-constitucion' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 1.2 de la Constitución Española, la soberanía nacional reside en:', 'El art. 1.2 CE atribuye la soberanía nacional al pueblo español, del que emanan los poderes del Estado. La «Nación española, patria común e indivisible» aparece en el art. 2 como fundamento de la Constitución.', 'age_aux_b1_01_constitucion', (select id from public.topics where slug = 'age-aux-b1-01-constitucion'), 1, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1978-31229'), 'Art. 1.2 CE', 'La soberanía nacional reside en el pueblo español, del que emanan los poderes del Estado.', null, 'ede59b00a881485ea52e1f793fb8683d9fb7e6b1c91e6d711d1e83dde32d83ba', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'ede59b00a881485ea52e1f793fb8683d9fb7e6b1c91e6d711d1e83dde32d83ba')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El pueblo español, del que emanan los poderes del Estado.', true), ('B', 'Las Cortes Generales, que representan al pueblo español.', false), ('C', 'La Corona, como símbolo de la unidad y permanencia del Estado.', false), ('D', 'La Nación española, patria común e indivisible de todos los españoles.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 4.1 de la Constitución, en la bandera de España la franja amarilla es:', 'El art. 4.1 CE describe la bandera con tres franjas horizontales, roja, amarilla y roja, siendo la amarilla de doble anchura que cada una de las rojas.', 'age_aux_b1_01_constitucion', (select id from public.topics where slug = 'age-aux-b1-01-constitucion'), 1, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1978-31229'), 'Art. 4.1 CE', 'La bandera de España está formada por tres franjas horizontales, roja, amarilla y roja, siendo la amarilla de doble anchura que cada una de las rojas.', null, '5bf6d33ce7c6d94f2f1eb970b4a59af379f3791abcb1377e14c3585da4fc3a75', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '5bf6d33ce7c6d94f2f1eb970b4a59af379f3791abcb1377e14c3585da4fc3a75')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'De la misma anchura que cada una de las rojas.', false), ('B', 'De triple anchura que cada una de las rojas.', false), ('C', 'De la mitad de anchura que cada una de las rojas.', false), ('D', 'De doble anchura que cada una de las rojas.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 15 de la Constitución, respecto de la pena de muerte:', 'El art. 15 CE abole la pena de muerte con una única salvedad: lo que puedan disponer las leyes penales militares para tiempos de guerra.', 'age_aux_b1_01_constitucion', (select id from public.topics where slug = 'age-aux-b1-01-constitucion'), 1, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1978-31229'), 'Art. 15 CE', 'Queda abolida la pena de muerte, salvo lo que puedan disponer las leyes penales militares para tiempos de guerra.', null, '5377fdbcb5528c2b10c7e733fe84fbbb9d9b6f2249bd53c541e872bd6a9d4ea6', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '5377fdbcb5528c2b10c7e733fe84fbbb9d9b6f2249bd53c541e872bd6a9d4ea6')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Queda abolida en todo caso y sin excepción alguna.', false), ('B', 'Queda abolida, salvo lo que puedan disponer las leyes penales militares para tiempos de guerra.', true), ('C', 'Queda abolida, salvo lo que dispongan las leyes penales para los delitos de terrorismo.', false), ('D', 'Queda abolida, salvo durante la vigencia del estado de sitio.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'De acuerdo con el artículo 16.3 de la Constitución Española:', 'El art. 16.3 CE proclama la aconfesionalidad del Estado, aunque obliga a los poderes públicos a tener en cuenta las creencias religiosas y a mantener relaciones de cooperación con la Iglesia Católica y las demás confesiones.', 'age_aux_b1_01_constitucion', (select id from public.topics where slug = 'age-aux-b1-01-constitucion'), 1, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1978-31229'), 'Art. 16.3 CE', 'Ninguna confesión tendrá carácter estatal. Los poderes públicos tendrán en cuenta las creencias religiosas de la sociedad española y mantendrán las consiguientes relaciones de cooperación con la Iglesia Católica y las demás confesiones.', null, 'a0c0273b7115bff86c46fcd5e209f9003c3b36e0c9333ceb0d9e2d999c985361', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'a0c0273b7115bff86c46fcd5e209f9003c3b36e0c9333ceb0d9e2d999c985361')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'La religión católica es la confesión oficial del Estado.', false), ('B', 'Los poderes públicos no podrán mantener relaciones de cooperación con ninguna confesión.', false), ('C', 'Ninguna confesión tendrá carácter estatal.', true), ('D', 'Solo las confesiones inscritas tendrán carácter estatal.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select '¿Qué asociaciones prohíbe expresamente el artículo 22.5 de la Constitución?', 'El art. 22.5 CE prohíbe las asociaciones secretas y las paramilitares. La falta de inscripción no las hace ilegales: el registro es a los solos efectos de publicidad (art. 22.3).', 'age_aux_b1_01_constitucion', (select id from public.topics where slug = 'age-aux-b1-01-constitucion'), 1, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1978-31229'), 'Art. 22.5 CE', 'Se prohíben las asociaciones secretas y las de carácter paramilitar.', null, 'bebade6eb8f8b3c2914dbe2fb8a0dda9fcd7a8e947e6312b4fecd74464b83f2f', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'bebade6eb8f8b3c2914dbe2fb8a0dda9fcd7a8e947e6312b4fecd74464b83f2f')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Las asociaciones no inscritas en el registro y las de carácter paramilitar.', false), ('B', 'Las asociaciones secretas y las de carácter político.', false), ('C', 'Las asociaciones secretas y las de carácter paramilitar.', true), ('D', 'Las asociaciones de carácter religioso y las secretas.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 28.1 de la Constitución, en relación con la libertad sindical:', 'El art. 28.1 CE reconoce el derecho a sindicarse libremente, incluye el derecho de los sindicatos a afiliarse a organizaciones internacionales, prevé solo peculiaridades para los funcionarios y añade que nadie podrá ser obligado a afiliarse.', 'age_aux_b1_01_constitucion', (select id from public.topics where slug = 'age-aux-b1-01-constitucion'), 1, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1978-31229'), 'Art. 28.1 CE', 'Nadie podrá ser obligado a afiliarse a un sindicato.', null, '2f188cd339664af923fbce88c822f3d824d20ab0b77cef0d05915e9d1c93fddf', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '2f188cd339664af923fbce88c822f3d824d20ab0b77cef0d05915e9d1c93fddf')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Los funcionarios públicos tienen prohibido sindicarse.', false), ('B', 'Los sindicatos no podrán afiliarse a organizaciones sindicales internacionales.', false), ('C', 'La afiliación a un sindicato es obligatoria para negociar convenios colectivos.', false), ('D', 'Nadie podrá ser obligado a afiliarse a un sindicato.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 8.1 de la Constitución, ¿cuál de las siguientes se incluye en la misión de las Fuerzas Armadas?', 'El art. 8.1 CE asigna a las Fuerzas Armadas garantizar la soberanía e independencia de España, defender su integridad territorial y el ordenamiento constitucional. La seguridad ciudadana corresponde a las Fuerzas y Cuerpos de Seguridad (art. 104) y el arbitraje y moderación al Rey (art. 56).', 'age_aux_b1_01_constitucion', (select id from public.topics where slug = 'age-aux-b1-01-constitucion'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1978-31229'), 'Art. 8.1 CE', 'Las Fuerzas Armadas, constituidas por el Ejército de Tierra, la Armada y el Ejército del Aire, tienen como misión garantizar la soberanía e independencia de España, defender su integridad territorial y el ordenamiento constitucional.', null, '689ef54af91fa5484ec36746b6db984f702b693c3d00bb32634f933f8f2d6f4b', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '689ef54af91fa5484ec36746b6db984f702b693c3d00bb32634f933f8f2d6f4b')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Defender la integridad territorial de España y el ordenamiento constitucional.', true), ('B', 'Proteger el libre ejercicio de los derechos y libertades y garantizar la seguridad ciudadana.', false), ('C', 'Defender los derechos comprendidos en el Título I, supervisando la actividad de la Administración.', false), ('D', 'Arbitrar y moderar el funcionamiento regular de las instituciones.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select '¿Qué precepto de la Constitución encomienda a los poderes públicos promover las condiciones para que la libertad y la igualdad del individuo y de los grupos en que se integra sean reales y efectivas?', 'Es el art. 9.2 CE (igualdad material). El art. 1.1 enumera los valores superiores, el 9.3 los principios de legalidad, jerarquía normativa, etc., y el 14 la igualdad ante la ley.', 'age_aux_b1_01_constitucion', (select id from public.topics where slug = 'age-aux-b1-01-constitucion'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1978-31229'), 'Art. 9.2 CE', 'Corresponde a los poderes públicos promover las condiciones para que la libertad y la igualdad del individuo y de los grupos en que se integra sean reales y efectivas; remover los obstáculos que impidan o dificulten su plenitud y facilitar la participación de todos los ciudadanos en la vida política, económica, cultural y social.', null, '1191af13d1cc1c367b0206bacf3b346e6dcc73ce04772743e13be11fc73019cf', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '1191af13d1cc1c367b0206bacf3b346e6dcc73ce04772743e13be11fc73019cf')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El artículo 1.1.', false), ('B', 'El artículo 9.2.', true), ('C', 'El artículo 9.3.', false), ('D', 'El artículo 14.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 11.3 de la Constitución, el Estado podrá concertar tratados de doble nacionalidad con:', 'El art. 11.3 CE se refiere a los países iberoamericanos y a los que hayan tenido o tengan una particular vinculación con España; en ellos pueden naturalizarse los españoles sin perder su nacionalidad de origen aunque no haya reciprocidad.', 'age_aux_b1_01_constitucion', (select id from public.topics where slug = 'age-aux-b1-01-constitucion'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1978-31229'), 'Art. 11.3 CE', 'El Estado podrá concertar tratados de doble nacionalidad con los países iberoamericanos o con aquellos que hayan tenido o tengan una particular vinculación con España.', null, '212506cfc635ca4b8597877292059e8d177a078241e50ddb584e62c9e3a56afb', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '212506cfc635ca4b8597877292059e8d177a078241e50ddb584e62c9e3a56afb')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Los Estados miembros de la Unión Europea exclusivamente.', false), ('B', 'Cualquier país, siempre que reconozca a los españoles un derecho recíproco.', false), ('C', 'Los países iberoamericanos exclusivamente.', false), ('D', 'Los países iberoamericanos o aquellos que hayan tenido o tengan una particular vinculación con España.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 13.3 de la Constitución, en materia de extradición:', 'El art. 13.3 CE exige tratado o ley y el principio de reciprocidad, y excluye los delitos políticos, aclarando que los actos de terrorismo no se consideran delitos políticos.', 'age_aux_b1_01_constitucion', (select id from public.topics where slug = 'age-aux-b1-01-constitucion'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1978-31229'), 'Art. 13.3 CE', 'La extradición sólo se concederá en cumplimiento de un tratado o de la ley, atendiendo al principio de reciprocidad. Quedan excluidos de la extradición los delitos políticos, no considerándose como tales los actos de terrorismo.', null, '5456fe56fa07b31416a8f8a99243a3007be292b36017019884bd1215a5e51041', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '5456fe56fa07b31416a8f8a99243a3007be292b36017019884bd1215a5e51041')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Quedan excluidos los delitos políticos, sin que se consideren tales los actos de terrorismo.', true), ('B', 'Quedan excluidos los delitos políticos, incluidos los actos de terrorismo.', false), ('C', 'Solo podrá concederse en cumplimiento de una ley orgánica aprobada por las Cortes.', false), ('D', 'Solo podrá concederse a Estados miembros de la Unión Europea.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 17.4 de la Constitución, el procedimiento de «habeas corpus» tiene por objeto:', 'El art. 17.4 CE prevé el «habeas corpus» para la inmediata puesta a disposición judicial de toda persona detenida ilegalmente; el plazo máximo de la prisión provisional lo fija la ley (mismo apartado) y la asistencia letrada e información al detenido están en el art. 17.3.', 'age_aux_b1_01_constitucion', (select id from public.topics where slug = 'age-aux-b1-01-constitucion'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1978-31229'), 'Art. 17.4 CE', 'La ley regulará un procedimiento de «habeas corpus» para producir la inmediata puesta a disposición judicial de toda persona detenida ilegalmente.', null, 'c2814744a1a2e17ca1f5aac7dcbedb5143ebda084d932852f22275cd73c84c9e', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'c2814744a1a2e17ca1f5aac7dcbedb5143ebda084d932852f22275cd73c84c9e')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Fijar el plazo máximo de duración de la prisión provisional.', false), ('B', 'Producir la inmediata puesta a disposición judicial de toda persona detenida ilegalmente.', true), ('C', 'Garantizar la asistencia de abogado al detenido en las diligencias policiales.', false), ('D', 'Informar al detenido de sus derechos y de las razones de su detención.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 20 de la Constitución, el secuestro de publicaciones, grabaciones y otros medios de información:', 'El art. 20.5 CE reserva a la resolución judicial el secuestro de publicaciones, grabaciones y otros medios de información; además, el art. 20.2 prohíbe todo tipo de censura previa.', 'age_aux_b1_01_constitucion', (select id from public.topics where slug = 'age-aux-b1-01-constitucion'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1978-31229'), 'Art. 20.5 CE', 'Sólo podrá acordarse el secuestro de publicaciones, grabaciones y otros medios de información en virtud de resolución judicial.', null, '77171a84b8fb79bdec2cb78145947e9f6f7299d913736c6983ab0346ef793ab5', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '77171a84b8fb79bdec2cb78145947e9f6f7299d913736c6983ab0346ef793ab5')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Podrá acordarse por la autoridad gubernativa en caso de urgencia.', false), ('B', 'Podrá acordarse mediante censura previa cuando afecte a la protección de la infancia.', false), ('C', 'Solo podrá acordarse en virtud de resolución judicial.', true), ('D', 'Requiere autorización previa del Ministerio Fiscal.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 22.4 de la Constitución, las asociaciones solo podrán ser disueltas o suspendidas en sus actividades:', 'El art. 22.4 CE exige resolución judicial motivada para disolver o suspender asociaciones.', 'age_aux_b1_01_constitucion', (select id from public.topics where slug = 'age-aux-b1-01-constitucion'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1978-31229'), 'Art. 22.4 CE', 'Las asociaciones sólo podrán ser disueltas o suspendidas en sus actividades en virtud de resolución judicial motivada.', null, 'ebe32adda367a8b6180b5e2b2ba4fb5c036cdb184a3d0b7d1e1f654244a3b267', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'ebe32adda367a8b6180b5e2b2ba4fb5c036cdb184a3d0b7d1e1f654244a3b267')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Por resolución del Ministerio del Interior.', false), ('B', 'En virtud de resolución judicial motivada.', true), ('C', 'Por acuerdo del Consejo de Ministros, previo informe del Consejo de Estado.', false), ('D', 'Por cancelación de su inscripción en el registro.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 25.3 de la Constitución, la Administración civil:', 'El art. 25.3 CE prohíbe a la Administración civil imponer sanciones que impliquen privación de libertad, tanto directa como subsidiariamente.', 'age_aux_b1_01_constitucion', (select id from public.topics where slug = 'age-aux-b1-01-constitucion'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1978-31229'), 'Art. 25.3 CE', 'La Administración civil no podrá imponer sanciones que, directa o subsidiariamente, impliquen privación de libertad.', null, '68b8bd5165a8435af9bb9a88190a0f3ec8a37ad84909124469faebe9ed69e580', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '68b8bd5165a8435af9bb9a88190a0f3ec8a37ad84909124469faebe9ed69e580')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Podrá imponer sanciones privativas de libertad de hasta setenta y dos horas.', false), ('B', 'Solo podrá imponer sanciones privativas de libertad con autorización judicial.', false), ('C', 'Podrá imponer arresto subsidiario por impago de multas administrativas.', false), ('D', 'No podrá imponer sanciones que, directa o subsidiariamente, impliquen privación de libertad.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 53.1 de la Constitución, el ejercicio de los derechos y libertades reconocidos en el Capítulo segundo del Título I:', 'El art. 53.1 CE establece la reserva de ley y la garantía del contenido esencial; además, estos derechos vinculan a todos los poderes públicos.', 'age_aux_b1_01_constitucion', (select id from public.topics where slug = 'age-aux-b1-01-constitucion'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1978-31229'), 'Art. 53.1 CE', 'Los derechos y libertades reconocidos en el Capítulo segundo del presente Título vinculan a todos los poderes públicos. Sólo por ley, que en todo caso deberá respetar su contenido esencial, podrá regularse el ejercicio de tales derechos y libertades', null, '214283775f8da6b9e8ae37d5951c01d9d51af49379872e385d45c92e9df28bf4', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '214283775f8da6b9e8ae37d5951c01d9d51af49379872e385d45c92e9df28bf4')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Solo podrá regularse por ley, que deberá respetar en todo caso su contenido esencial.', true), ('B', 'Podrá regularse por real decreto-ley en casos de extraordinaria y urgente necesidad.', false), ('C', 'Solo podrá regularse por los Estatutos de Autonomía.', false), ('D', 'Podrá regularse por reglamento cuando así lo autorice una ley orgánica.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 26 de la Constitución, se prohíben los Tribunales de Honor en el ámbito de:', 'El art. 26 CE prohíbe los Tribunales de Honor en la Administración civil y en las organizaciones profesionales; no menciona el ámbito militar.', 'age_aux_b1_01_constitucion', (select id from public.topics where slug = 'age-aux-b1-01-constitucion'), 3, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1978-31229'), 'Art. 26 CE', 'Se prohíben los Tribunales de Honor en el ámbito de la Administración civil y de las organizaciones profesionales.', null, '3558efbf14cc60e7f9811e3433aecb00042fd42c27140712c2c716bd63aea1fd', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '3558efbf14cc60e7f9811e3433aecb00042fd42c27140712c2c716bd63aea1fd')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'La Administración civil y de las Fuerzas Armadas.', false), ('B', 'Las organizaciones profesionales y de los partidos políticos.', false), ('C', 'La Administración civil y de las organizaciones profesionales.', true), ('D', 'Toda la Administración, civil y militar.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 34 de la Constitución, rige también para las fundaciones lo dispuesto en:', 'El art. 34.2 CE extiende a las fundaciones los apartados 2 (ilegalidad por fines o medios delictivos) y 4 (disolución o suspensión solo por resolución judicial motivada) del art. 22.', 'age_aux_b1_01_constitucion', (select id from public.topics where slug = 'age-aux-b1-01-constitucion'), 3, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1978-31229'), 'Art. 34.2 CE', 'Regirá también para las fundaciones lo dispuesto en los apartados 2 y 4 del artículo 22.', null, 'a20e97e2bad237e94140767b742fcd5ad710a8dc26c62e032189616464e42bee', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'a20e97e2bad237e94140767b742fcd5ad710a8dc26c62e032189616464e42bee')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Los apartados 3 y 5 del artículo 22.', false), ('B', 'Los apartados 1 y 3 del artículo 22.', false), ('C', 'Los apartados 2 y 4 del artículo 22.', true), ('D', 'Los apartados 2 y 3 del artículo 33.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 31.2 de la Constitución, la programación y ejecución del gasto público responderán a los criterios de:', 'El art. 31.2 CE exige una asignación equitativa de los recursos públicos y que su programación y ejecución respondan a los criterios de eficiencia y economía. Igualdad y progresividad son los principios del sistema tributario (art. 31.1).', 'age_aux_b1_01_constitucion', (select id from public.topics where slug = 'age-aux-b1-01-constitucion'), 3, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1978-31229'), 'Art. 31.2 CE', 'El gasto público realizará una asignación equitativa de los recursos públicos, y su programación y ejecución responderán a los criterios de eficiencia y economía.', null, 'c9e41e5d219d2012aac94db829593a5a393a2d3823924c2831ea7504ecd99a5e', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'c9e41e5d219d2012aac94db829593a5a393a2d3823924c2831ea7504ecd99a5e')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Igualdad y progresividad.', false), ('B', 'Eficacia y jerarquía.', false), ('C', 'Estabilidad presupuestaria y sostenibilidad financiera.', false), ('D', 'Eficiencia y economía.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 47 de la Constitución, ¿quién participará en las plusvalías que genere la acción urbanística de los entes públicos?', 'El art. 47 CE, tras reconocer el derecho a una vivienda digna y adecuada y ordenar impedir la especulación, dispone que la comunidad participará en las plusvalías de la acción urbanística de los entes públicos.', 'age_aux_b1_01_constitucion', (select id from public.topics where slug = 'age-aux-b1-01-constitucion'), 3, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1978-31229'), 'Art. 47 CE', 'La comunidad participará en las plusvalías que genere la acción urbanística de los entes públicos.', null, 'f165a8bb1362c490e8f798b9470f220a1997dc3ff36d8f3ab5f0471a1f300a1c', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'f165a8bb1362c490e8f798b9470f220a1997dc3ff36d8f3ab5f0471a1f300a1c')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Los propietarios del suelo afectado.', false), ('B', 'La comunidad.', true), ('C', 'Los Ayuntamientos exclusivamente.', false), ('D', 'Las Comunidades Autónomas.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 49.2 de la Constitución, en la redacción dada por la reforma de 15 de febrero de 2024, se atenderán particularmente las necesidades específicas de:', 'El art. 49.2 CE, reformado en 2024, ordena impulsar políticas de plena autonomía personal e inclusión social en entornos universalmente accesibles y atender particularmente las necesidades de las mujeres y los menores con discapacidad.', 'age_aux_b1_01_constitucion', (select id from public.topics where slug = 'age-aux-b1-01-constitucion'), 3, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1978-31229'), 'Art. 49.2 CE', 'Se atenderán particularmente las necesidades específicas de las mujeres y los menores con discapacidad.', null, '997be6c6cda59b5eee6b7bf1a86da982d0c421905b4aeb8775945362cfaffcbf', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '997be6c6cda59b5eee6b7bf1a86da982d0c421905b4aeb8775945362cfaffcbf')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Las mujeres y los menores con discapacidad.', true), ('B', 'Las personas mayores y los menores con discapacidad.', false), ('C', 'Las personas con discapacidad intelectual.', false), ('D', 'Las mujeres con discapacidad en el ámbito rural.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
-- Lote age-aux-b1-02-tc-reforma-corona-ce-v1 (13 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Constitución Española (texto consolidado, BOE)', 'https://www.boe.es/buscar/act.php?id=BOE-A-1978-31229', 'boe'::public.source_kind, 'Agencia Estatal Boletín Oficial del Estado', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('age-aux-b1-02-tc-reforma-corona', 'I.2 El Tribunal Constitucional, la reforma de la Constitución y la Corona') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('auxiliar-administrativo-estado') and t.slug = 'age-aux-b1-02-tc-reforma-corona' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 56.1 de la Constitución, el Rey es el Jefe del Estado y:', 'El art. 56.1 CE define al Rey como Jefe del Estado, símbolo de su unidad y permanencia, que arbitra y modera el funcionamiento regular de las instituciones.', 'age_aux_b1_02_tc_reforma_corona', (select id from public.topics where slug = 'age-aux-b1-02-tc-reforma-corona'), 1, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1978-31229'), 'Art. 56.1 CE', 'El Rey es el Jefe del Estado, símbolo de su unidad y permanencia, arbitra y modera el funcionamiento regular de las instituciones', null, '20accbe6410a220e9eff0dec25e77df7643841a51cba3cb472438a42221614ad', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '20accbe6410a220e9eff0dec25e77df7643841a51cba3cb472438a42221614ad')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Símbolo de su unidad y permanencia.', true), ('B', 'Titular del poder ejecutivo.', false), ('C', 'Representante de la soberanía nacional.', false), ('D', 'Alto comisionado de las Cortes Generales.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 57.2 de la Constitución, el Príncipe heredero tendrá la dignidad de:', 'El art. 57.2 CE atribuye al Príncipe heredero la dignidad de Príncipe de Asturias y los demás títulos vinculados tradicionalmente al sucesor de la Corona.', 'age_aux_b1_02_tc_reforma_corona', (select id from public.topics where slug = 'age-aux-b1-02-tc-reforma-corona'), 1, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1978-31229'), 'Art. 57.2 CE', 'El Príncipe heredero, desde su nacimiento o desde que se produzca el hecho que origine el llamamiento, tendrá la dignidad de Príncipe de Asturias y los demás títulos vinculados tradicionalmente al sucesor de la Corona de España.', null, '0a0e12e1745b02e05363d85e3a232b61cbcc45e1e35af8772e617c0608986ad4', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '0a0e12e1745b02e05363d85e3a232b61cbcc45e1e35af8772e617c0608986ad4')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Príncipe de Gerona.', false), ('B', 'Infante de España.', false), ('C', 'Príncipe de Asturias.', true), ('D', 'Duque de Borbón.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 62 de la Constitución, ¿a quién corresponde el mando supremo de las Fuerzas Armadas?', 'El art. 62.h) CE atribuye al Rey el mando supremo de las Fuerzas Armadas; como todos sus actos, requiere refrendo (art. 64).', 'age_aux_b1_02_tc_reforma_corona', (select id from public.topics where slug = 'age-aux-b1-02-tc-reforma-corona'), 1, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1978-31229'), 'Art. 62.h) CE', 'h) El mando supremo de las Fuerzas Armadas.', null, '7bfa6ba24d531920817e91368ed80fe2b6e78857ccdd4e0944d669993c8067ea', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '7bfa6ba24d531920817e91368ed80fe2b6e78857ccdd4e0944d669993c8067ea')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Al Presidente del Gobierno.', false), ('B', 'Al Rey.', true), ('C', 'Al Ministro de Defensa.', false), ('D', 'A las Cortes Generales.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 169 de la Constitución, no podrá iniciarse la reforma constitucional:', 'El art. 169 CE impide iniciar la reforma en tiempo de guerra o durante los estados de alarma, excepción o sitio (art. 116).', 'age_aux_b1_02_tc_reforma_corona', (select id from public.topics where slug = 'age-aux-b1-02-tc-reforma-corona'), 1, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1978-31229'), 'Art. 169 CE', 'No podrá iniciarse la reforma constitucional en tiempo de guerra o de vigencia de alguno de los estados previstos en el artículo 116.', null, 'e6d96e22f4f7cb3625a0105a0353bdffb41930750c64b0e1580b115d87a4f74f', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'e6d96e22f4f7cb3625a0105a0353bdffb41930750c64b0e1580b115d87a4f74f')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Durante el último año de la legislatura.', false), ('B', 'Mientras el Gobierno esté en funciones.', false), ('C', 'Durante los períodos entre sesiones de las Cámaras.', false), ('D', 'En tiempo de guerra o de vigencia de alguno de los estados previstos en el artículo 116.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 164.1 de la Constitución, las sentencias del Tribunal Constitucional se publicarán:', 'El art. 164.1 CE ordena publicar las sentencias del TC en el BOE junto con los votos particulares; tienen valor de cosa juzgada desde el día siguiente a su publicación.', 'age_aux_b1_02_tc_reforma_corona', (select id from public.topics where slug = 'age-aux-b1-02-tc-reforma-corona'), 1, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1978-31229'), 'Art. 164.1 CE', 'Las sentencias del Tribunal Constitucional se publicarán en el boletín oficial del Estado con los votos particulares, si los hubiere.', null, '36c68ade4d300c9a80015be2d50752eb1d1874bae8d2545cdeccd00bfa44285b', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '36c68ade4d300c9a80015be2d50752eb1d1874bae8d2545cdeccd00bfa44285b')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'En el boletín oficial del Estado sin los votos particulares.', false), ('B', 'En el Diario de Sesiones del Congreso de los Diputados.', false), ('C', 'Solo en el boletín oficial de la Comunidad Autónoma afectada.', false), ('D', 'En el boletín oficial del Estado con los votos particulares, si los hubiere.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 159.4 de la Constitución, la condición de miembro del Tribunal Constitucional es incompatible, entre otros, con:', 'El art. 159.4 CE declara incompatible el cargo con todo mandato representativo, cargos políticos o administrativos, funciones directivas en partidos o sindicatos, el ejercicio de las carreras judicial y fiscal y cualquier actividad profesional o mercantil. La mera afiliación no figura: solo las funciones directivas.', 'age_aux_b1_02_tc_reforma_corona', (select id from public.topics where slug = 'age-aux-b1-02-tc-reforma-corona'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1978-31229'), 'Art. 159.4 CE', 'con el ejercicio de las carreras judicial y fiscal, y con cualquier actividad profesional o mercantil.', null, '38026967308aea5f9ad66475bbf18980a5345883f3627e3bb81bc3203cadc267', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '38026967308aea5f9ad66475bbf18980a5345883f3627e3bb81bc3203cadc267')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'La condición de Profesor de Universidad jubilado.', false), ('B', 'La afiliación a un partido político.', false), ('C', 'El ejercicio de las carreras judicial y fiscal.', true), ('D', 'La pertenencia a una Real Academia.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 161.1 de la Constitución, el Tribunal Constitucional es competente para conocer:', 'El art. 161.1 CE enumera el recurso de inconstitucionalidad, el de amparo, los conflictos de competencia entre el Estado y las CC. AA. o de éstas entre sí y las demás materias que le atribuyan la Constitución o las leyes orgánicas. La responsabilidad criminal del Gobierno corresponde a la Sala de lo Penal del Tribunal Supremo (art. 102.1).', 'age_aux_b1_02_tc_reforma_corona', (select id from public.topics where slug = 'age-aux-b1-02-tc-reforma-corona'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1978-31229'), 'Art. 161.1.c) CE', 'c) De los conflictos de competencia entre el Estado y las Comunidades Autónomas o de los de éstas entre sí.', null, '6d41a6e702c04b27205de83377f4944d7dea14fbe08a5186b65add8177fd1c6f', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '6d41a6e702c04b27205de83377f4944d7dea14fbe08a5186b65add8177fd1c6f')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'De los recursos contra los reglamentos del Gobierno.', false), ('B', 'De los conflictos de competencia entre el Estado y las Comunidades Autónomas o de los de éstas entre sí.', true), ('C', 'De la responsabilidad criminal del Presidente y los demás miembros del Gobierno.', false), ('D', 'De los recursos contra las resoluciones del Consejo General del Poder Judicial.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 166 de la Constitución, la iniciativa de reforma constitucional se ejercerá en los términos previstos en:', 'El art. 166 CE remite a los apartados 1 y 2 del art. 87 (Gobierno, Congreso, Senado y Asambleas de las CC. AA.); excluye, por tanto, la iniciativa popular del art. 87.3.', 'age_aux_b1_02_tc_reforma_corona', (select id from public.topics where slug = 'age-aux-b1-02-tc-reforma-corona'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1978-31229'), 'Art. 166 CE', 'La iniciativa de reforma constitucional se ejercerá en los términos previstos en los apartados 1 y 2 del artículo 87.', null, '57494fcbbfb6a5a33720f430d43a02003cf3c4aaf8c930a525a369f3dc67e4ea', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '57494fcbbfb6a5a33720f430d43a02003cf3c4aaf8c930a525a369f3dc67e4ea')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Los apartados 1, 2 y 3 del artículo 87.', false), ('B', 'Los apartados 1 y 2 del artículo 87.', true), ('C', 'El artículo 81.', false), ('D', 'El artículo 92.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 168.1 de la Constitución, cuando se propusiere la revisión total de la Constitución, se procederá a la aprobación del principio:', 'El procedimiento agravado del art. 168 CE exige aprobar el principio por dos tercios de cada Cámara y disolver de inmediato las Cortes; las nuevas Cámaras ratifican y aprueban el texto por dos tercios, y hay referéndum obligatorio.', 'age_aux_b1_02_tc_reforma_corona', (select id from public.topics where slug = 'age-aux-b1-02-tc-reforma-corona'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1978-31229'), 'Art. 168.1 CE', 'se procederá a la aprobación del principio por mayoría de dos tercios de cada Cámara, y a la disolución inmediata de las Cortes.', null, 'a1ee2a36d7f45125ea16ba8000abd6245890f86cc5ee46c7b4ee45c4303e7bf7', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'a1ee2a36d7f45125ea16ba8000abd6245890f86cc5ee46c7b4ee45c4303e7bf7')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Por mayoría de tres quintos de cada Cámara, y a la disolución inmediata de las Cortes.', false), ('B', 'Por mayoría absoluta de cada Cámara, y a la convocatoria de referéndum.', false), ('C', 'Por mayoría de dos tercios de cada Cámara, y a la disolución inmediata de las Cortes.', true), ('D', 'Por mayoría de dos tercios del Congreso, sin disolución de las Cortes.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 59.4 de la Constitución, para ejercer la Regencia es preciso:', 'El art. 59.4 CE solo exige ser español y mayor de edad; la Regencia se ejerce por mandato constitucional y siempre en nombre del Rey (art. 59.5).', 'age_aux_b1_02_tc_reforma_corona', (select id from public.topics where slug = 'age-aux-b1-02-tc-reforma-corona'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1978-31229'), 'Art. 59.4 CE', 'Para ejercer la Regencia es preciso ser español y mayor de edad.', null, 'eec8571893e629c55fc3c1ffd5001ceb6a66d56be2ea7ab8b6a05235300466d0', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'eec8571893e629c55fc3c1ffd5001ceb6a66d56be2ea7ab8b6a05235300466d0')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Ser español de origen y mayor de treinta años.', false), ('B', 'Ser miembro de la Familia Real y mayor de edad.', false), ('C', 'Ser español y haber sido designado en el testamento del Rey.', false), ('D', 'Ser español y mayor de edad.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 57.5 de la Constitución, las abdicaciones y renuncias y cualquier duda de hecho o de derecho en el orden de sucesión a la Corona se resolverán:', 'El art. 57.5 CE reserva a una ley orgánica la resolución de abdicaciones, renuncias y dudas en el orden sucesorio.', 'age_aux_b1_02_tc_reforma_corona', (select id from public.topics where slug = 'age-aux-b1-02-tc-reforma-corona'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1978-31229'), 'Art. 57.5 CE', 'Las abdicaciones y renuncias y cualquier duda de hecho o de derecho que ocurra en el orden de sucesión a la Corona se resolverán por una ley orgánica.', null, '6d6c543af51fdfd5be0786f97c5cd05afdcf22c451e8415530167b774d929b09', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '6d6c543af51fdfd5be0786f97c5cd05afdcf22c451e8415530167b774d929b09')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Por una ley orgánica.', true), ('B', 'Por acuerdo de las Cortes Generales en sesión conjunta.', false), ('C', 'Por real decreto acordado en Consejo de Ministros.', false), ('D', 'Por el Tribunal Constitucional.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 63.3 de la Constitución, al Rey corresponde declarar la guerra y hacer la paz:', 'El art. 63.3 CE exige autorización previa de las Cortes Generales para que el Rey declare la guerra y haga la paz.', 'age_aux_b1_02_tc_reforma_corona', (select id from public.topics where slug = 'age-aux-b1-02-tc-reforma-corona'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1978-31229'), 'Art. 63.3 CE', 'Al Rey corresponde, previa autorización de las Cortes Generales, declarar la guerra y hacer la paz.', null, '8946e74dbf50b36186a2baec8a15a00dcc2826e2ec85920639735336139860f4', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '8946e74dbf50b36186a2baec8a15a00dcc2826e2ec85920639735336139860f4')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'A propuesta del Consejo de Seguridad Nacional.', false), ('B', 'Previa autorización de las Cortes Generales.', true), ('C', 'Previa autorización del Congreso de los Diputados por mayoría absoluta.', false), ('D', 'Previo dictamen del Consejo de Estado.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 60.1 de la Constitución, los cargos de Regente y de tutor del Rey menor:', 'El art. 60.1 CE prohíbe acumular los cargos de Regente y tutor salvo en el padre, madre o ascendientes directos del Rey; la tutela es además incompatible con todo cargo o representación política (art. 60.2).', 'age_aux_b1_02_tc_reforma_corona', (select id from public.topics where slug = 'age-aux-b1-02-tc-reforma-corona'), 3, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1978-31229'), 'Art. 60.1 CE', 'pero no podrán acumularse los cargos de Regente y de tutor sino en el padre, madre o ascendientes directos del Rey.', null, '08c5f89899c2a6534deba41020d5a446d67c966d67d6e6038f5e594c1fe9d3fc', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '08c5f89899c2a6534deba41020d5a446d67c966d67d6e6038f5e594c1fe9d3fc')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Solo pueden acumularse en el padre, madre o ascendientes directos del Rey.', true), ('B', 'No pueden acumularse en ningún caso.', false), ('C', 'Pueden acumularse en cualquier persona nombrada por las Cortes Generales.', false), ('D', 'Solo pueden acumularse en el pariente mayor de edad más próximo a suceder en la Corona.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
-- Lote age-aux-b1-02-tc-reforma-corona-lotc-v1 (7 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Ley Orgánica 2/1979, de 3 de octubre, del Tribunal Constitucional (texto consolidado, BOE)', 'https://www.boe.es/buscar/act.php?id=BOE-A-1979-23709', 'boe'::public.source_kind, 'Agencia Estatal Boletín Oficial del Estado', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('age-aux-b1-02-tc-reforma-corona', 'I.2 El Tribunal Constitucional, la reforma de la Constitución y la Corona') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('auxiliar-administrativo-estado') and t.slug = 'age-aux-b1-02-tc-reforma-corona' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según la Ley Orgánica del Tribunal Constitucional, el Tribunal consta de:', 'El art. 7.1 LOTC establece dos Salas de seis Magistrados cada una, nombrados por el Tribunal en Pleno.', 'age_aux_b1_02_tc_reforma_corona', (select id from public.topics where slug = 'age-aux-b1-02-tc-reforma-corona'), 1, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1979-23709'), 'Art. 7.1 LOTC', 'El Tribunal Constitucional consta de dos Salas. Cada Sala está compuesta por seis Magistrados nombrados por el Tribunal en Pleno.', null, 'a51b251871e137a755a136761ce5623805297d14a38a890c0c1da5656255ffba', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'a51b251871e137a755a136761ce5623805297d14a38a890c0c1da5656255ffba')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Dos Salas, compuestas cada una por seis Magistrados.', true), ('B', 'Tres Salas, compuestas cada una por cuatro Magistrados.', false), ('C', 'Dos Salas, compuestas cada una por cuatro Magistrados.', false), ('D', 'Cuatro Salas, compuestas cada una por tres Magistrados.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 16 de la Ley Orgánica del Tribunal Constitucional, los Magistrados propuestos por el Senado serán elegidos entre las candidaturas presentadas por:', 'El art. 16.1 LOTC dispone que los Magistrados propuestos por el Senado se eligen entre las candidaturas de las Asambleas Legislativas autonómicas, en los términos del Reglamento de la Cámara.', 'age_aux_b1_02_tc_reforma_corona', (select id from public.topics where slug = 'age-aux-b1-02-tc-reforma-corona'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1979-23709'), 'Art. 16.1 LOTC', 'Los Magistrados y Magistradas propuestos por el Senado serán elegidos entre las candidaturas presentadas por las Asambleas Legislativas de las comunidades autónomas en los términos que determine el Reglamento de la Cámara.', null, '8da21aa5354bf413f660b45a3a47d92c8e97d06aa4baf0c875b35f763e03bc53', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '8da21aa5354bf413f660b45a3a47d92c8e97d06aa4baf0c875b35f763e03bc53')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Los Consejos de Gobierno de las comunidades autónomas.', false), ('B', 'Los grupos parlamentarios del Senado.', false), ('C', 'Las Asambleas Legislativas de las comunidades autónomas.', true), ('D', 'El Consejo General del Poder Judicial.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según la Ley Orgánica del Tribunal Constitucional, ¿puede un Magistrado ser propuesto al Rey para otro período inmediato?', 'El art. 16.4 LOTC prohíbe proponer a un Magistrado para otro período inmediato, salvo que haya ocupado el cargo por un plazo no superior a tres años.', 'age_aux_b1_02_tc_reforma_corona', (select id from public.topics where slug = 'age-aux-b1-02-tc-reforma-corona'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1979-23709'), 'Art. 16.4 LOTC', 'Ningún Magistrado podrá ser propuesto al Rey para otro período inmediato, salvo que hubiera ocupado el cargo por un plazo no superior a tres años.', null, 'd4643a02d9d7a204caaca13af86990368e8b4fec7bedf780cb5812a2eb39a90a', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'd4643a02d9d7a204caaca13af86990368e8b4fec7bedf780cb5812a2eb39a90a')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Sí, por una sola vez.', false), ('B', 'No, salvo que lo proponga el mismo órgano que lo designó.', false), ('C', 'Sí, siempre que lo apruebe el Pleno del Tribunal por mayoría absoluta.', false), ('D', 'No, salvo que hubiera ocupado el cargo por un plazo no superior a tres años.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según la Ley Orgánica del Tribunal Constitucional, si en quien fuere propuesto como Magistrado concurre causa de incompatibilidad y no cesa en el cargo o actividad incompatible, se entenderá que no acepta el cargo transcurrido el plazo de:', 'El art. 19.2 LOTC fija diez días siguientes a la propuesta para cesar en la actividad incompatible; la misma regla rige para la incompatibilidad sobrevenida.', 'age_aux_b1_02_tc_reforma_corona', (select id from public.topics where slug = 'age-aux-b1-02-tc-reforma-corona'), 3, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1979-23709'), 'Art. 19.2 LOTC', 'Si no lo hiciere en el plazo de diez días siguientes a la propuesta, se entenderá que no acepta el cargo de Magistrado del Tribunal Constitucional.', null, '45f6a8a9ce7d4ec173dc016f18488644e595cd8508e886eee9341d6a3127a57d', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '45f6a8a9ce7d4ec173dc016f18488644e595cd8508e886eee9341d6a3127a57d')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Diez días siguientes a la propuesta.', true), ('B', 'Quince días siguientes a la propuesta.', false), ('C', 'Un mes desde la propuesta.', false), ('D', 'Diez días desde su nombramiento por el Rey.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según la Ley Orgánica del Tribunal Constitucional, ¿cuándo debe el Presidente del Tribunal solicitar que se inicie el procedimiento para designar a los nuevos Magistrados?', 'El art. 17.1 LOTC fija la solicitud antes de los cuatro meses previos a la expiración; según el art. 17.2, los Magistrados siguen en funciones hasta que tomen posesión sus sucesores.', 'age_aux_b1_02_tc_reforma_corona', (select id from public.topics where slug = 'age-aux-b1-02-tc-reforma-corona'), 3, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1979-23709'), 'Art. 17.1 LOTC', 'Antes de los cuatro meses previos a la fecha de expiración de los nombramientos, el Presidente del Tribunal solicitará de los Presidentes de los órganos que han de hacer las propuestas para la designación de los nuevos Magistrados, que inicien el procedimiento para ello.', null, 'bffb385a9809a7cfa534398ebbb08a4a1ed16d8e13006be4212d7a4f92e7220c', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'bffb385a9809a7cfa534398ebbb08a4a1ed16d8e13006be4212d7a4f92e7220c')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Antes de los seis meses previos a la fecha de expiración de los nombramientos.', false), ('B', 'Dentro del mes siguiente a la expiración de los nombramientos.', false), ('C', 'Antes de los cuatro meses previos a la fecha de expiración de los nombramientos.', true), ('D', 'Antes de los tres meses previos a la fecha de expiración de los nombramientos.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según la Ley Orgánica del Tribunal Constitucional, las Secciones que constituyen el Pleno y las Salas están compuestas por:', 'El art. 8.1 LOTC compone las Secciones con el respectivo Presidente (o su sustituto) y dos Magistrados, para el despacho ordinario y la admisibilidad de los procesos.', 'age_aux_b1_02_tc_reforma_corona', (select id from public.topics where slug = 'age-aux-b1-02-tc-reforma-corona'), 3, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1979-23709'), 'Art. 8.1 LOTC', 'el Pleno y las Salas constituirán Secciones compuestas por el respectivo Presidente o quien le sustituya y dos Magistrados.', null, '4fdada27c092574e6ee408b23dcb7e1e7c777473d33fc5561c3ba43824343e5b', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '4fdada27c092574e6ee408b23dcb7e1e7c777473d33fc5561c3ba43824343e5b')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El respectivo Presidente y cuatro Magistrados.', false), ('B', 'El respectivo Presidente o quien le sustituya y dos Magistrados.', true), ('C', 'Tres Magistrados elegidos por sorteo.', false), ('D', 'El Presidente del Tribunal, el Vicepresidente y un Magistrado.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según la Ley Orgánica del Tribunal Constitucional, en la elección del Presidente del Tribunal por el Pleno, si en la primera votación no se alcanza la mayoría absoluta:', 'El art. 9.2 LOTC exige mayoría absoluta en primera votación; si no se alcanza, en segunda resulta elegido quien obtenga más votos. Solo ante empates repetidos se acude a la antigüedad y, en su caso, a la edad.', 'age_aux_b1_02_tc_reforma_corona', (select id from public.topics where slug = 'age-aux-b1-02-tc-reforma-corona'), 3, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1979-23709'), 'Art. 9.2 LOTC', 'En primera votación se requerirá la mayoría absoluta. Si ésta no se alcanzase se procederá a una segunda votación, en la que resultará elegido quien obtuviese mayor número de votos.', null, '3d1665df548657725e53ef0fe583c234f9e99c0d630f046bd5579faa362bfffb', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '3d1665df548657725e53ef0fe583c234f9e99c0d630f046bd5579faa362bfffb')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Se propone al Rey el Magistrado de mayor antigüedad en el cargo.', false), ('B', 'Se repite la votación hasta que algún candidato obtenga la mayoría absoluta.', false), ('C', 'Se procede a una segunda votación en la que se exige mayoría de tres quintos.', false), ('D', 'Se procede a una segunda votación, en la que resulta elegido quien obtenga mayor número de votos.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
-- Lote age-aux-b1-03-cortes-defensor-ce-v1 (15 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Constitución Española (texto consolidado, BOE)', 'https://www.boe.es/buscar/act.php?id=BOE-A-1978-31229', 'boe'::public.source_kind, 'Agencia Estatal Boletín Oficial del Estado', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('age-aux-b1-03-cortes-defensor', 'I.3 Las Cortes Generales y el Defensor del Pueblo') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('auxiliar-administrativo-estado') and t.slug = 'age-aux-b1-03-cortes-defensor' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 69.1 de la Constitución, el Senado es:', 'El art. 69.1 CE define al Senado como la Cámara de representación territorial; el control de la acción del Gobierno corresponde a las Cortes Generales (art. 66.2).', 'age_aux_b1_03_cortes_defensor', (select id from public.topics where slug = 'age-aux-b1-03-cortes-defensor'), 1, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1978-31229'), 'Art. 69.1 CE', 'El Senado es la Cámara de representación territorial.', null, 'd2990593f8ae80fe1e3f98c39e7cb1ab3df72d5ce80439e6332e93ac0e05725e', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'd2990593f8ae80fe1e3f98c39e7cb1ab3df72d5ce80439e6332e93ac0e05725e')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'La Cámara de representación territorial.', true), ('B', 'La Cámara de segunda lectura de las leyes orgánicas.', false), ('C', 'La Cámara de representación de las Comunidades Autónomas exclusivamente.', false), ('D', 'El órgano de control de la acción del Gobierno.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 68.2 de la Constitución, ¿cuántos Diputados representan a cada una de las poblaciones de Ceuta y Melilla?', 'El art. 68.2 CE fija la provincia como circunscripción y atribuye a Ceuta y a Melilla un Diputado cada una (en cambio, eligen dos Senadores cada una, art. 69.4).', 'age_aux_b1_03_cortes_defensor', (select id from public.topics where slug = 'age-aux-b1-03-cortes-defensor'), 1, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1978-31229'), 'Art. 68.2 CE', 'Las poblaciones de Ceuta y Melilla estarán representadas cada una de ellas por un Diputado.', null, '83eafde55ad5c2755eecced0bcbc88199cca7fb6ddb4d08eb481ef5a40c2d9b0', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '83eafde55ad5c2755eecced0bcbc88199cca7fb6ddb4d08eb481ef5a40c2d9b0')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Dos.', false), ('B', 'Uno.', true), ('C', 'Tres.', false), ('D', 'Cuatro.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 68.4 de la Constitución, el mandato de los Diputados termina:', 'El art. 68.4 CE dispone que el Congreso se elige por cuatro años y que el mandato termina a los cuatro años de la elección o el día de la disolución.', 'age_aux_b1_03_cortes_defensor', (select id from public.topics where slug = 'age-aux-b1-03-cortes-defensor'), 1, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1978-31229'), 'Art. 68.4 CE', 'El Congreso es elegido por cuatro años. El mandato de los Diputados termina cuatro años después de su elección o el día de la disolución de la Cámara.', null, '3bea0f335bcf9f2942927867e6c92508d0028467e17af3b468ff0a7cbafe2c31', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '3bea0f335bcf9f2942927867e6c92508d0028467e17af3b468ff0a7cbafe2c31')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Cinco años después de su elección o el día de la disolución de la Cámara.', false), ('B', 'Cuatro años después de la constitución de la Cámara, sin que quepa disolución anticipada.', false), ('C', 'Cuatro años después de su elección o el día de la disolución de la Cámara.', true), ('D', 'El día en que se celebren nuevas elecciones generales.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 79.3 de la Constitución, el voto de Senadores y Diputados es:', 'El art. 79.3 CE establece que el voto de los parlamentarios es personal e indelegable.', 'age_aux_b1_03_cortes_defensor', (select id from public.topics where slug = 'age-aux-b1-03-cortes-defensor'), 1, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1978-31229'), 'Art. 79.3 CE', 'El voto de Senadores y Diputados es personal e indelegable.', null, '802d07c42036dee775506b1be7cfab65abbd9ff789ba234ede6e3ac48a6d07cf', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '802d07c42036dee775506b1be7cfab65abbd9ff789ba234ede6e3ac48a6d07cf')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Personal y delegable en otro miembro del mismo grupo parlamentario.', false), ('B', 'Secreto en todo caso.', false), ('C', 'Delegable en el portavoz del grupo parlamentario.', false), ('D', 'Personal e indelegable.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 67.1 de la Constitución, ¿qué acumulación de actas está prohibida?', 'El art. 67.1 CE prohíbe ser miembro de las dos Cámaras a la vez y acumular el acta autonómica con la de Diputado al Congreso; no impide que el Senador designado por la Comunidad sea parlamentario autonómico.', 'age_aux_b1_03_cortes_defensor', (select id from public.topics where slug = 'age-aux-b1-03-cortes-defensor'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1978-31229'), 'Art. 67.1 CE', 'Nadie podrá ser miembro de las dos Cámaras simultáneamente, ni acumular el acta de una Asamblea de Comunidad Autónoma con la de Diputado al Congreso.', null, '9c42c57e72d7cf68c4a26fcd96362ccd3f42729e78713316b35cd6b1cd2b558a', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '9c42c57e72d7cf68c4a26fcd96362ccd3f42729e78713316b35cd6b1cd2b558a')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'La del acta de Senador con la de concejal de un Ayuntamiento.', false), ('B', 'La del acta de una Asamblea de Comunidad Autónoma con la de Diputado al Congreso.', true), ('C', 'La del acta de Diputado al Congreso con la condición de miembro del Gobierno.', false), ('D', 'La del acta de una Asamblea de Comunidad Autónoma con la de Senador designado por ella.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 69.4 de la Constitución, ¿cuántos Senadores eligen cada una de las poblaciones de Ceuta y Melilla?', 'El art. 69.4 CE atribuye dos Senadores a Ceuta y dos a Melilla, frente a los cuatro de cada provincia (art. 69.2).', 'age_aux_b1_03_cortes_defensor', (select id from public.topics where slug = 'age-aux-b1-03-cortes-defensor'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1978-31229'), 'Art. 69.4 CE', 'Las poblaciones de Ceuta y Melilla elegirán cada una de ellas dos Senadores.', null, 'b2beff190ad8fd60618f9a61b311e381a05f6c5e2361ce4a055b0a0668dc8d07', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'b2beff190ad8fd60618f9a61b311e381a05f6c5e2361ce4a055b0a0668dc8d07')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Uno.', false), ('B', 'Tres.', false), ('C', 'Dos.', true), ('D', 'Cuatro.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 70.1 de la Constitución, las causas de inelegibilidad e incompatibilidad de Diputados y Senadores comprenderán en todo caso a los altos cargos de la Administración del Estado que determine la ley, con la excepción de:', 'El art. 70.1.b) CE exceptúa a los miembros del Gobierno, que pueden ser parlamentarios.', 'age_aux_b1_03_cortes_defensor', (select id from public.topics where slug = 'age-aux-b1-03-cortes-defensor'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1978-31229'), 'Art. 70.1 CE', 'b) A los altos cargos de la Administración del Estado que determine la ley, con la excepción de los miembros del Gobierno.', null, 'd75b7bc2f59c93a8420bce4558c0db558a5dd417bc0be4236cb94e13af922691', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'd75b7bc2f59c93a8420bce4558c0db558a5dd417bc0be4236cb94e13af922691')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Los Delegados del Gobierno en las Comunidades Autónomas.', false), ('B', 'Los Secretarios de Estado.', false), ('C', 'Los Subsecretarios.', false), ('D', 'Los miembros del Gobierno.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 72.2 de la Constitución, las sesiones conjuntas de las Cámaras serán presididas por:', 'El art. 72.2 CE atribuye la presidencia de las sesiones conjuntas al Presidente del Congreso; se rigen por un Reglamento de las Cortes Generales aprobado por mayoría absoluta de cada Cámara.', 'age_aux_b1_03_cortes_defensor', (select id from public.topics where slug = 'age-aux-b1-03-cortes-defensor'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1978-31229'), 'Art. 72.2 CE', 'Las sesiones conjuntas serán presididas por el Presidente del Congreso y se regirán por un Reglamento de las Cortes Generales aprobado por mayoría absoluta de cada Cámara.', null, '3ae4602f96f7dfa0c7f29263ac81f6cc52a5121032789540d84d8fa486ffc66d', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '3ae4602f96f7dfa0c7f29263ac81f6cc52a5121032789540d84d8fa486ffc66d')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El Presidente del Senado.', false), ('B', 'El Presidente del Congreso y el del Senado, alternativamente.', false), ('C', 'El Presidente del Congreso.', true), ('D', 'El Rey.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 86.2 de la Constitución, los Decretos-leyes deberán ser sometidos a debate y votación de totalidad al Congreso de los Diputados en el plazo de:', 'El art. 86.2 CE fija treinta días desde la promulgación para que el Congreso (solo el Congreso) se pronuncie sobre su convalidación o derogación.', 'age_aux_b1_03_cortes_defensor', (select id from public.topics where slug = 'age-aux-b1-03-cortes-defensor'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1978-31229'), 'Art. 86.2 CE', 'Los Decretos-leyes deberán ser inmediatamente sometidos a debate y votación de totalidad al Congreso de los Diputados, convocado al efecto si no estuviere reunido, en el plazo de los treinta días siguientes a su promulgación.', null, 'a76ea95e9e091c8014e822e32daeb839c0c95072e69fce4974d43d6c2ef3bed7', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'a76ea95e9e091c8014e822e32daeb839c0c95072e69fce4974d43d6c2ef3bed7')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Los treinta días siguientes a su promulgación.', true), ('B', 'Los quince días siguientes a su promulgación.', false), ('C', 'Los treinta días siguientes a su publicación en el BOE, en ambas Cámaras.', false), ('D', 'Los dos meses siguientes a su promulgación.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 87.3 de la Constitución, para la iniciativa legislativa popular se exigirán en todo caso:', 'El art. 87.3 CE exige al menos 500.000 firmas y excluye las materias propias de ley orgánica, tributarias, de carácter internacional y la prerrogativa de gracia.', 'age_aux_b1_03_cortes_defensor', (select id from public.topics where slug = 'age-aux-b1-03-cortes-defensor'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1978-31229'), 'Art. 87.3 CE', 'En todo caso se exigirán no menos de 500.000 firmas acreditadas.', null, 'd56c0847265780ec9a4f0d5b245befedccba32bd21d7d08e62ce328e0be428b8', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'd56c0847265780ec9a4f0d5b245befedccba32bd21d7d08e62ce328e0be428b8')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'No menos de 250.000 firmas acreditadas.', false), ('B', 'No menos de 500.000 firmas acreditadas.', true), ('C', 'No menos de 750.000 firmas acreditadas.', false), ('D', 'No menos de 1.000.000 de firmas acreditadas.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 91 de la Constitución, ¿en qué plazo sancionará el Rey las leyes aprobadas por las Cortes Generales?', 'El art. 91 CE fija quince días para la sanción; el Rey las promulgará y ordenará su inmediata publicación.', 'age_aux_b1_03_cortes_defensor', (select id from public.topics where slug = 'age-aux-b1-03-cortes-defensor'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1978-31229'), 'Art. 91 CE', 'El Rey sancionará en el plazo de quince días las leyes aprobadas por las Cortes Generales, y las promulgará y ordenará su inmediata publicación.', null, 'f6c926c5e2cabe75195c63056fff2b5d1ea58d1904dbd0390821cf3bfbdc9e44', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'f6c926c5e2cabe75195c63056fff2b5d1ea58d1904dbd0390821cf3bfbdc9e44')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Quince días.', true), ('B', 'Diez días.', false), ('C', 'Veinte días.', false), ('D', 'Un mes.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 92.2 de la Constitución, el referéndum consultivo será convocado por el Rey:', 'El art. 92.2 CE exige propuesta del Presidente del Gobierno y autorización previa del Congreso de los Diputados.', 'age_aux_b1_03_cortes_defensor', (select id from public.topics where slug = 'age-aux-b1-03-cortes-defensor'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1978-31229'), 'Art. 92.2 CE', 'El referéndum será convocado por el Rey, mediante propuesta del Presidente del Gobierno, previamente autorizada por el Congreso de los Diputados.', null, '63c2b804679aa64609f4cab02a94c2942e2dbe3e49f443787ebc43b6231a6b6d', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '63c2b804679aa64609f4cab02a94c2942e2dbe3e49f443787ebc43b6231a6b6d')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Mediante propuesta del Consejo de Ministros, previamente autorizada por las Cortes Generales.', false), ('B', 'Mediante propuesta del Presidente del Congreso, previo acuerdo de la Mesa.', false), ('C', 'Mediante propuesta del Presidente del Gobierno, previamente autorizada por el Senado.', false), ('D', 'Mediante propuesta del Presidente del Gobierno, previamente autorizada por el Congreso de los Diputados.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 74.2 de la Constitución, de las decisiones de las Cortes Generales previstas en los artículos 94.1, 145.2 y 158.2, ¿cuál se inicia en el Congreso?', 'El art. 74.2 CE dispone que en el primer caso (art. 94.1) el procedimiento se inicia en el Congreso y en los otros dos (arts. 145.2 y 158.2) en el Senado; sin acuerdo, decide el Congreso por mayoría absoluta tras una Comisión Mixta.', 'age_aux_b1_03_cortes_defensor', (select id from public.topics where slug = 'age-aux-b1-03-cortes-defensor'), 3, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1978-31229'), 'Art. 74.2 CE', 'Las decisiones de las Cortes Generales previstas en los artículos 94, 1, 145, 2 y 158, 2, se adoptarán por mayoría de cada una de las Cámaras. En el primer caso, el procedimiento se iniciará por el Congreso, y en los otros dos, por el Senado.', null, '6265764ded2dcddc33fd69666a116401ca2a4ca1b8f23c08886f546bf085a8b2', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '6265764ded2dcddc33fd69666a116401ca2a4ca1b8f23c08886f546bf085a8b2')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'La prevista en el artículo 145.2 (acuerdos de cooperación entre Comunidades Autónomas).', false), ('B', 'La prevista en el artículo 158.2 (distribución del Fondo de Compensación).', false), ('C', 'La prevista en el artículo 94.1 (autorización de tratados).', true), ('D', 'Las previstas en los artículos 145.2 y 158.2, conjuntamente.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 82.2 de la Constitución, cuando la delegación legislativa tenga por objeto refundir varios textos legales en uno solo, deberá otorgarse mediante:', 'El art. 82.2 CE exige ley de bases para la formación de textos articulados y ley ordinaria para refundir varios textos legales en uno solo.', 'age_aux_b1_03_cortes_defensor', (select id from public.topics where slug = 'age-aux-b1-03-cortes-defensor'), 3, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1978-31229'), 'Art. 82.2 CE', 'La delegación legislativa deberá otorgarse mediante una ley de bases cuando su objeto sea la formación de textos articulados o por una ley ordinaria cuando se trate de refundir varios textos legales en uno solo.', null, 'eec3e131f5609fae741a8a9aad023d9748a8dd255e52ecc4221176981e0aefa9', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'eec3e131f5609fae741a8a9aad023d9748a8dd255e52ecc4221176981e0aefa9')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Una ley ordinaria.', true), ('B', 'Una ley de bases.', false), ('C', 'Una ley orgánica.', false), ('D', 'Un real decreto legislativo.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 83 de la Constitución, las leyes de bases no podrán en ningún caso:', 'El art. 83 CE prohíbe a las leyes de bases autorizar la modificación de la propia ley de bases y facultar para dictar normas retroactivas. Fijar plazo, prever controles adicionales y delimitar principios son contenidos previstos en el art. 82.', 'age_aux_b1_03_cortes_defensor', (select id from public.topics where slug = 'age-aux-b1-03-cortes-defensor'), 3, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1978-31229'), 'Art. 83 CE', 'Las leyes de bases no podrán en ningún caso: […] b) Facultar para dictar normas con carácter retroactivo.', null, '7b4d5da5efa7f2e76bdc37bbbd8b7448af49f3dbd73edb648a55f81c6057d069', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '7b4d5da5efa7f2e76bdc37bbbd8b7448af49f3dbd73edb648a55f81c6057d069')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Fijar el plazo para el ejercicio de la delegación.', false), ('B', 'Establecer fórmulas adicionales de control.', false), ('C', 'Delimitar los principios y criterios que han de seguirse en el ejercicio de la delegación.', false), ('D', 'Facultar para dictar normas con carácter retroactivo.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
-- Lote age-aux-b1-03-cortes-defensor-lodp-v1 (5 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Ley Orgánica 3/1981, de 6 de abril, del Defensor del Pueblo (texto consolidado, BOE)', 'https://www.boe.es/buscar/act.php?id=BOE-A-1981-10325', 'boe'::public.source_kind, 'Agencia Estatal Boletín Oficial del Estado', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('age-aux-b1-03-cortes-defensor', 'I.3 Las Cortes Generales y el Defensor del Pueblo') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('auxiliar-administrativo-estado') and t.slug = 'age-aux-b1-03-cortes-defensor' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según la Ley Orgánica 3/1981, ¿quién puede ser elegido Defensor del Pueblo?', 'El art. 3 LODP solo exige ser español, mayor de edad y estar en pleno disfrute de los derechos civiles y políticos.', 'age_aux_b1_03_cortes_defensor', (select id from public.topics where slug = 'age-aux-b1-03-cortes-defensor'), 1, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1981-10325'), 'Art. 3 LO 3/1981', 'Podrá ser elegido Defensor del Pueblo cualquier español mayor de edad que se encuentre en el pleno disfrute de sus derechos civiles y políticos.', null, '952082ed6274e745dbd5ad311c81a0d85cf0781e733cf1a2f269c9e94908a277', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '952082ed6274e745dbd5ad311c81a0d85cf0781e733cf1a2f269c9e94908a277')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Cualquier jurista español de reconocida competencia con más de quince años de ejercicio profesional.', false), ('B', 'Cualquier español mayor de edad que sea Diputado o Senador.', false), ('C', 'Cualquier funcionario de carrera del Estado con más de diez años de servicio.', false), ('D', 'Cualquier español mayor de edad que se encuentre en el pleno disfrute de sus derechos civiles y políticos.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según la Ley Orgánica del Defensor del Pueblo, el Defensor del Pueblo estará auxiliado por:', 'El art. 8.1 LODP prevé un Adjunto Primero y un Adjunto Segundo, en los que puede delegar funciones y que le sustituyen por su orden.', 'age_aux_b1_03_cortes_defensor', (select id from public.topics where slug = 'age-aux-b1-03-cortes-defensor'), 1, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1981-10325'), 'Art. 8.1 LO 3/1981', 'El Defensor del Pueblo estará auxiliado por un Adjunto Primero y un Adjunto Segundo, en los que podrá delegar sus funciones y que le sustituirán por su orden', null, '3acbce49441105a85c1854f47b9ed6970d908673b0399c41a245a32a2b99b583', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '3acbce49441105a85c1854f47b9ed6970d908673b0399c41a245a32a2b99b583')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Un Adjunto Primero y un Adjunto Segundo.', true), ('B', 'Un único Adjunto.', false), ('C', 'Tres Adjuntos, uno por cada área de actuación.', false), ('D', 'Un Adjunto por cada Comunidad Autónoma.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según la Ley Orgánica del Defensor del Pueblo, el Defensor del Pueblo deberá cesar en toda situación de incompatibilidad que pudiera afectarle:', 'El art. 7.2 LODP fija diez días desde el nombramiento y antes de la toma de posesión; si no cesa, se entiende que no acepta el nombramiento.', 'age_aux_b1_03_cortes_defensor', (select id from public.topics where slug = 'age-aux-b1-03-cortes-defensor'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1981-10325'), 'Art. 7.2 LO 3/1981', 'El Defensor del Pueblo deberá cesar, dentro de los diez días siguientes a su nombramiento y antes de tomar posesión, en toda situación de incompatibilidad que pudiera afectarle, entendiéndose en caso contrario que no acepta el nombramiento.', null, '6e254602cf9fe82fc087faf4acf60ee0c6482b601df83ea6da16a0eb7ab154d7', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '6e254602cf9fe82fc087faf4acf60ee0c6482b601df83ea6da16a0eb7ab154d7')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Dentro del mes siguiente a su toma de posesión.', false), ('B', 'Dentro de los diez días siguientes a su nombramiento y antes de tomar posesión.', true), ('C', 'Dentro de los quince días siguientes a su nombramiento.', false), ('D', 'Dentro de los veinte días siguientes a la ratificación por el Senado.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según la Ley Orgánica del Defensor del Pueblo, en caso de cese por actuar con notoria negligencia en el cumplimiento de las obligaciones del cargo, la vacante se decidirá:', 'El art. 5.2 LODP reserva al Presidente del Congreso la declaración de vacante por muerte, renuncia o expiración del mandato; en los demás casos decide cada Cámara por tres quintos, con debate y audiencia del interesado.', 'age_aux_b1_03_cortes_defensor', (select id from public.topics where slug = 'age-aux-b1-03-cortes-defensor'), 3, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1981-10325'), 'Art. 5.2 LO 3/1981', 'La vacante en el cargo se declarará por el Presidente del Congreso en los casos de muerte, renuncia y expiración del plazo del mandato. En los demás casos se decidirá, por mayoría de las tres quintas partes de los componentes de cada Cámara, mediante debate y previa audiencia del interesado.', null, '4927aed6f7a644dc360e186e38f06a4a860ae475d33be12907d7cadeae15c3b6', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '4927aed6f7a644dc360e186e38f06a4a860ae475d33be12907d7cadeae15c3b6')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Por el Presidente del Congreso, previa audiencia del interesado.', false), ('B', 'Por mayoría de las tres quintas partes de los componentes de cada Cámara, mediante debate y previa audiencia del interesado.', true), ('C', 'Por mayoría absoluta del Congreso y del Senado, sin necesidad de debate.', false), ('D', 'Por la Comisión Mixta Congreso-Senado, por mayoría simple.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según la Ley Orgánica del Defensor del Pueblo, admitida una queja, el Jefe del Organismo o Dependencia administrativa procedente deberá remitir informe escrito en el plazo máximo de:', 'El art. 18.1 LODP fija un plazo máximo de quince días para el informe escrito, ampliable a juicio del Defensor del Pueblo. El plazo de un mes es el de respuesta a advertencias y recomendaciones (art. 30.1).', 'age_aux_b1_03_cortes_defensor', (select id from public.topics where slug = 'age-aux-b1-03-cortes-defensor'), 3, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1981-10325'), 'Art. 18.1 LO 3/1981', 'En todo caso dará cuenta del contenido sustancial de la solicitud al Organismo o a la Dependencia administrativa procedente con el fin de que por su Jefe en el plazo máximo de quince días, se remita informe escrito. Tal plazo será ampliable cuando concurran circunstancias que lo aconsejen a juicio del Defensor del Pueblo.', null, 'c56b887ee5ebd9e1897203e1acbf6abe45cb563f5fd508e80c3e6e46d430104f', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'c56b887ee5ebd9e1897203e1acbf6abe45cb563f5fd508e80c3e6e46d430104f')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Diez días, improrrogables.', false), ('B', 'Un mes, ampliable a petición del Organismo.', false), ('C', 'Quince días, ampliable cuando concurran circunstancias que lo aconsejen.', true), ('D', 'Veinte días, improrrogables.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
-- Lote age-aux-b1-04-poder-judicial-ce-v1 (7 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Constitución Española (texto consolidado, BOE)', 'https://www.boe.es/buscar/act.php?id=BOE-A-1978-31229', 'boe'::public.source_kind, 'Agencia Estatal Boletín Oficial del Estado', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('age-aux-b1-04-poder-judicial', 'I.4 El Poder Judicial') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('auxiliar-administrativo-estado') and t.slug = 'age-aux-b1-04-poder-judicial' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 117.3 de la Constitución, el ejercicio de la potestad jurisdiccional, juzgando y haciendo ejecutar lo juzgado, corresponde exclusivamente a:', 'El art. 117.3 CE consagra el principio de exclusividad: la potestad jurisdiccional corresponde exclusivamente a los Juzgados y Tribunales determinados por las leyes.', 'age_aux_b1_04_poder_judicial', (select id from public.topics where slug = 'age-aux-b1-04-poder-judicial'), 1, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1978-31229'), 'Art. 117.3 CE', 'El ejercicio de la potestad jurisdiccional en todo tipo de procesos, juzgando y haciendo ejecutar lo juzgado, corresponde exclusivamente a los Juzgados y Tribunales determinados por las leyes', null, '6b97e84b5e663d2f707bd41be216977971e74818e5468352ea1aa4f5c927cc0c', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '6b97e84b5e663d2f707bd41be216977971e74818e5468352ea1aa4f5c927cc0c')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El Consejo General del Poder Judicial.', false), ('B', 'El Ministerio Fiscal y los Juzgados y Tribunales.', false), ('C', 'Los Juzgados y Tribunales determinados por las leyes.', true), ('D', 'El Tribunal Supremo y el Tribunal Constitucional.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 120.2 de la Constitución, el procedimiento será predominantemente oral, sobre todo en materia:', 'El art. 120.2 CE establece la oralidad predominante del procedimiento, sobre todo en materia criminal.', 'age_aux_b1_04_poder_judicial', (select id from public.topics where slug = 'age-aux-b1-04-poder-judicial'), 1, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1978-31229'), 'Art. 120.2 CE', 'El procedimiento será predominantemente oral, sobre todo en materia criminal.', null, 'b921c8338d13d5d334ba5b5af03556fe27d3fdc6283fbda704c7bfe7229ff707', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'b921c8338d13d5d334ba5b5af03556fe27d3fdc6283fbda704c7bfe7229ff707')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Civil.', false), ('B', 'Laboral.', false), ('C', 'Contencioso-administrativa.', false), ('D', 'Criminal.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 121 de la Constitución, los daños causados por error judicial darán derecho a una indemnización a cargo de:', 'El art. 121 CE pone a cargo del Estado la indemnización por error judicial y por funcionamiento anormal de la Administración de Justicia.', 'age_aux_b1_04_poder_judicial', (select id from public.topics where slug = 'age-aux-b1-04-poder-judicial'), 1, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1978-31229'), 'Art. 121 CE', 'Los daños causados por error judicial, así como los que sean consecuencia del funcionamiento anormal de la Administración de Justicia, darán derecho a una indemnización a cargo del Estado, conforme a la ley.', null, '7c2c976e4d030c2a4217192a426c4755318021def00f65edb02cd92400a0916d', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '7c2c976e4d030c2a4217192a426c4755318021def00f65edb02cd92400a0916d')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El Juez o Magistrado que hubiera incurrido en el error.', false), ('B', 'El Estado.', true), ('C', 'El Consejo General del Poder Judicial.', false), ('D', 'La Comunidad Autónoma con competencias en materia de justicia.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 125 de la Constitución, los ciudadanos podrán participar en la Administración de Justicia mediante la institución del Jurado:', 'El art. 125 CE reconoce la acción popular y la participación mediante el Jurado en los procesos penales que la ley determine, así como en los Tribunales consuetudinarios y tradicionales.', 'age_aux_b1_04_poder_judicial', (select id from public.topics where slug = 'age-aux-b1-04-poder-judicial'), 1, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1978-31229'), 'Art. 125 CE', 'Los ciudadanos podrán ejercer la acción popular y participar en la Administración de Justicia mediante la institución del Jurado, en la forma y con respecto a aquellos procesos penales que la ley determine, así como en los Tribunales consuetudinarios y tradicionales.', null, 'd00c44123c54be17a689101825ff7975b3eba5cb2d878033c51bd63b3bbaf4fb', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'd00c44123c54be17a689101825ff7975b3eba5cb2d878033c51bd63b3bbaf4fb')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'En la forma y con respecto a aquellos procesos penales que la ley determine.', true), ('B', 'En todos los procesos civiles y penales.', false), ('C', 'Solo en los procesos que se sigan ante el Tribunal Supremo.', false), ('D', 'En los procesos contencioso-administrativos que determine la ley.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 117.2 de la Constitución, los Jueces y Magistrados no podrán ser separados, suspendidos, trasladados ni jubilados:', 'El art. 117.2 CE garantiza la inamovilidad de Jueces y Magistrados, que solo pueden ser separados, suspendidos, trasladados o jubilados por las causas y con las garantías de la ley.', 'age_aux_b1_04_poder_judicial', (select id from public.topics where slug = 'age-aux-b1-04-poder-judicial'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1978-31229'), 'Art. 117.2 CE', 'Los Jueces y Magistrados no podrán ser separados, suspendidos, trasladados ni jubilados, sino por alguna de las causas y con las garantías previstas en la ley.', null, '1327cc3ecfb0761c38d47fd320d100c9cd241af643a5943abbd3dee444743214', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '1327cc3ecfb0761c38d47fd320d100c9cd241af643a5943abbd3dee444743214')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Sino por acuerdo del Consejo de Ministros, oído el Consejo General del Poder Judicial.', false), ('B', 'Sino por sentencia firme del Tribunal Supremo.', false), ('C', 'En ningún caso durante los cinco primeros años de ejercicio.', false), ('D', 'Sino por alguna de las causas y con las garantías previstas en la ley.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 124.2 de la Constitución, el Ministerio Fiscal ejerce sus funciones por medio de órganos propios conforme a los principios de:', 'El art. 124.2 CE enumera la unidad de actuación y la dependencia jerárquica, con sujeción en todo caso a la legalidad e imparcialidad.', 'age_aux_b1_04_poder_judicial', (select id from public.topics where slug = 'age-aux-b1-04-poder-judicial'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1978-31229'), 'Art. 124.2 CE', 'El Ministerio Fiscal ejerce sus funciones por medio de órganos propios conforme a los principios de unidad de actuación y dependencia jerárquica y con sujeción, en todo caso, a los de legalidad e imparcialidad.', null, 'f5a19044e3d74f94a86e32c3b01f88ceb20b816186befbbde42ec6c84c4e7a90', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'f5a19044e3d74f94a86e32c3b01f88ceb20b816186befbbde42ec6c84c4e7a90')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Independencia e inamovilidad, con sujeción al imperio de la ley.', false), ('B', 'Unidad de actuación y dependencia jerárquica, con sujeción a los de legalidad e imparcialidad.', true), ('C', 'Jerarquía, descentralización y coordinación, con sometimiento pleno a la ley.', false), ('D', 'Unidad jurisdiccional y exclusividad, con sujeción a los de legalidad e imparcialidad.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 126 de la Constitución, en sus funciones de averiguación del delito y descubrimiento y aseguramiento del delincuente, la policía judicial depende de:', 'El art. 126 CE hace depender a la policía judicial de los Jueces, de los Tribunales y del Ministerio Fiscal en esas funciones.', 'age_aux_b1_04_poder_judicial', (select id from public.topics where slug = 'age-aux-b1-04-poder-judicial'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1978-31229'), 'Art. 126 CE', 'La policía judicial depende de los Jueces, de los Tribunales y del Ministerio Fiscal en sus funciones de averiguación del delito y descubrimiento y aseguramiento del delincuente, en los términos que la ley establezca.', null, '512c9492257c6a5f36a6d32a0d60a18ea9be1c193b73e69f22eb054968c050be', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '512c9492257c6a5f36a6d32a0d60a18ea9be1c193b73e69f22eb054968c050be')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El Ministerio del Interior exclusivamente.', false), ('B', 'El Consejo General del Poder Judicial.', false), ('C', 'Los Jueces, de los Tribunales y del Ministerio Fiscal.', true), ('D', 'Los Jueces y Tribunales exclusivamente.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
-- Lote age-aux-b1-04-poder-judicial-lopj-v1 (13 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Ley Orgánica 6/1985, de 1 de julio, del Poder Judicial (texto consolidado, BOE)', 'https://www.boe.es/buscar/act.php?id=BOE-A-1985-12666', 'boe'::public.source_kind, 'Agencia Estatal Boletín Oficial del Estado', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('age-aux-b1-04-poder-judicial', 'I.4 El Poder Judicial') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('auxiliar-administrativo-estado') and t.slug = 'age-aux-b1-04-poder-judicial' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según la Ley Orgánica del Poder Judicial, la Audiencia Nacional:', 'El art. 62 LOPJ fija la sede de la Audiencia Nacional en la villa de Madrid con jurisdicción en toda España; el órgano superior en todos los órdenes es el Tribunal Supremo (art. 123.1 CE).', 'age_aux_b1_04_poder_judicial', (select id from public.topics where slug = 'age-aux-b1-04-poder-judicial'), 1, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1985-12666'), 'Art. 62 LOPJ', 'La Audiencia Nacional, con sede en la villa de Madrid, tiene jurisdicción en toda España.', null, 'f1ec67e19ff4844929b660f547f91e8a06e483ff81714a88fea55c7dbbe0284a', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'f1ec67e19ff4844929b660f547f91e8a06e483ff81714a88fea55c7dbbe0284a')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Tiene su sede en la villa de Madrid y jurisdicción en toda España.', true), ('B', 'Tiene su sede en Madrid y jurisdicción en la Comunidad de Madrid.', false), ('C', 'Tiene su sede en la capital de cada Comunidad Autónoma.', false), ('D', 'Es el órgano jurisdiccional superior en todos los órdenes.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según la Ley Orgánica del Poder Judicial, ¿cuál es el ámbito territorial de los Tribunales Superiores de Justicia?', 'El art. 34 LOPJ dispone que la Comunidad Autónoma será el ámbito territorial de los Tribunales Superiores de Justicia, que toman su nombre (art. 71).', 'age_aux_b1_04_poder_judicial', (select id from public.topics where slug = 'age-aux-b1-04-poder-judicial'), 1, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1985-12666'), 'Art. 34 LOPJ', 'La Comunidad Autónoma será el ámbito territorial de los Tribunales Superiores de Justicia.', null, '7f4e2ea9075575682db9b8abd2fe9c53cc7f495fdd3aa9d7d60c32570d22e769', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '7f4e2ea9075575682db9b8abd2fe9c53cc7f495fdd3aa9d7d60c32570d22e769')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'La provincia.', false), ('B', 'El partido judicial.', false), ('C', 'La Comunidad Autónoma.', true), ('D', 'Todo el territorio nacional.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 566 de la Ley Orgánica del Poder Judicial, de los veinte Vocales del Consejo General del Poder Judicial:', 'El art. 566 LOPJ reparte los veinte Vocales en doce del turno judicial y ocho juristas de reconocida competencia, además del Presidente del Tribunal Supremo, que preside el Consejo.', 'age_aux_b1_04_poder_judicial', (select id from public.topics where slug = 'age-aux-b1-04-poder-judicial'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1985-12666'), 'Art. 566 LOPJ', 'El Consejo General del Poder Judicial estará integrado por el Presidente del Tribunal Supremo, que lo presidirá, y por veinte Vocales, de los cuales doce serán Jueces o Magistrados en servicio activo en la carrera judicial y ocho juristas de reconocida competencia.', null, '40540c5aacf6ac00bea3dab60de474d0a7cf50b56b94d9f23ad6ec7438184750', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '40540c5aacf6ac00bea3dab60de474d0a7cf50b56b94d9f23ad6ec7438184750')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Diez serán Jueces o Magistrados y diez juristas de reconocida competencia.', false), ('B', 'Ocho serán Jueces o Magistrados y doce juristas de reconocida competencia.', false), ('C', 'Doce serán Jueces o Magistrados de cualquier situación y ocho Fiscales.', false), ('D', 'Doce serán Jueces o Magistrados en servicio activo en la carrera judicial y ocho juristas de reconocida competencia.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según la Ley Orgánica del Poder Judicial, el Consejo General del Poder Judicial se renovará:', 'El art. 568.1 LOPJ establece la renovación total cada cinco años desde su constitución; los Presidentes del Congreso y del Senado deben procurar que se produzca en plazo.', 'age_aux_b1_04_poder_judicial', (select id from public.topics where slug = 'age-aux-b1-04-poder-judicial'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1985-12666'), 'Art. 568.1 LOPJ', 'El Consejo General del Poder Judicial se renovará en su totalidad cada cinco años, contados desde la fecha de su constitución.', null, 'e371e0cb24796197f73539b8103416f328282d01c73f3b75b5e17e1c7defcf5d', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'e371e0cb24796197f73539b8103416f328282d01c73f3b75b5e17e1c7defcf5d')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Por mitades cada cinco años.', false), ('B', 'En su totalidad cada cinco años, contados desde la fecha de su constitución.', true), ('C', 'Por terceras partes cada tres años.', false), ('D', 'En su totalidad cada cuatro años, coincidiendo con la legislatura.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según la Ley Orgánica del Poder Judicial, el Presidente del Tribunal Supremo y del Consejo General del Poder Judicial:', 'El art. 587 LOPJ hace coincidir su mandato con el del Consejo que lo eligió y permite su reelección por una sola vez.', 'age_aux_b1_04_poder_judicial', (select id from public.topics where slug = 'age-aux-b1-04-poder-judicial'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1985-12666'), 'Art. 587.2 LOPJ', 'El Presidente del Tribunal Supremo y del Consejo General del Poder Judicial podrá ser reelegido y nombrado, por una sola vez, para un nuevo mandato.', null, 'a205506a6df93770d8fc884f183fc2ee32680e1ae8fd05a228a9a3513891bfb5', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'a205506a6df93770d8fc884f183fc2ee32680e1ae8fd05a228a9a3513891bfb5')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Podrá ser reelegido y nombrado, por una sola vez, para un nuevo mandato.', true), ('B', 'No podrá ser reelegido en ningún caso.', false), ('C', 'Podrá ser reelegido sin limitación de mandatos.', false), ('D', 'Podrá ser reelegido por una sola vez, siempre que haya ejercido el cargo menos de tres años.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según la Ley Orgánica del Poder Judicial, el partido judicial es:', 'El art. 32.1 LOPJ define el partido como uno o más municipios limítrofes de una misma provincia; puede coincidir con la demarcación provincial (art. 32.3).', 'age_aux_b1_04_poder_judicial', (select id from public.topics where slug = 'age-aux-b1-04-poder-judicial'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1985-12666'), 'Art. 32.1 LOPJ', 'El partido es la unidad territorial integrada por uno o más municipios limítrofes, pertenecientes a una misma provincia.', null, '7f9a8bc9d0ddf61a26944d92d08c71c6d89367011f3f391ded0cf4c0006680ad', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '7f9a8bc9d0ddf61a26944d92d08c71c6d89367011f3f391ded0cf4c0006680ad')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'La unidad territorial integrada por uno o más municipios limítrofes, pertenecientes a una misma provincia.', true), ('B', 'La unidad territorial integrada por varias provincias de una misma Comunidad Autónoma.', false), ('C', 'La demarcación que coincide siempre con la comarca natural.', false), ('D', 'La unidad territorial integrada por municipios de una o varias provincias limítrofes.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según la Ley Orgánica del Poder Judicial, las Audiencias Provinciales tendrán su sede:', 'El art. 80.1 LOPJ sitúa la sede en la capital de la provincia, con jurisdicción en toda ella; pueden crearse Secciones fuera de la capital (art. 80.2).', 'age_aux_b1_04_poder_judicial', (select id from public.topics where slug = 'age-aux-b1-04-poder-judicial'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1985-12666'), 'Art. 80.1 LOPJ', 'Las Audiencias Provinciales, que tendrán su sede en la capital de la provincia, de la que tomarán su nombre, extenderán su jurisdicción a toda ella', null, 'dfa08b9a77ff3ce2353cf2ff9f78a8ae83871d23092aecabb9f3fb22dfd3ee2a', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'dfa08b9a77ff3ce2353cf2ff9f78a8ae83871d23092aecabb9f3fb22dfd3ee2a')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'En el municipio más poblado de la provincia.', false), ('B', 'En la sede del Tribunal Superior de Justicia de la Comunidad Autónoma.', false), ('C', 'En la capital de la provincia, de la que tomarán su nombre.', true), ('D', 'En el municipio que determine la Diputación Provincial.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 102 de la Ley Orgánica del Poder Judicial, para ser nombrado Juez de Paz:', 'El art. 102 LOPJ permite nombrar Jueces de Paz a quienes, aun sin ser licenciados en Derecho, reúnan los requisitos de ingreso en la Carrera Judicial y no incurran en incapacidad o incompatibilidad (salvo actividades profesionales o mercantiles).', 'age_aux_b1_04_poder_judicial', (select id from public.topics where slug = 'age-aux-b1-04-poder-judicial'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1985-12666'), 'Art. 102 LOPJ', 'Podrán ser nombrados Jueces de Paz, tanto titular como sustituto, quienes, aun no siendo licenciados en Derecho, reúnan los requisitos establecidos en esta ley para el ingreso en la Carrera Judicial', null, '526d1431f63f020b4b78938b0ab29efe070a0a4360dd9ce3d1386cada75e4096', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '526d1431f63f020b4b78938b0ab29efe070a0a4360dd9ce3d1386cada75e4096')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Es necesario ser licenciado en Derecho y tener más de cinco años de ejercicio profesional.', false), ('B', 'Basta con estar empadronado en el municipio y ser mayor de edad.', false), ('C', 'Es necesario haber superado las pruebas de acceso a la Carrera Judicial.', false), ('D', 'No es necesario ser licenciado en Derecho, pero sí reunir los requisitos para el ingreso en la Carrera Judicial.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según la Ley Orgánica del Poder Judicial, un jurista que no sea Magistrado del Tribunal Supremo puede ser elegido Presidente del Tribunal Supremo y del Consejo General del Poder Judicial si es de reconocida competencia y tiene:', 'El art. 586.1 LOPJ exige ser Magistrado del Tribunal Supremo con las condiciones para ser Presidente de Sala, o jurista de reconocida competencia con más de veinticinco años de antigüedad profesional.', 'age_aux_b1_04_poder_judicial', (select id from public.topics where slug = 'age-aux-b1-04-poder-judicial'), 3, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1985-12666'), 'Art. 586.1 LOPJ', 'o bien ser un jurista de reconocida competencia con más de veinticinco años de antigüedad en el ejercicio de su profesión.', null, '9b7fe375dbd8da53c27773ebc720dae6a4c9a60d81bbfbf1fae178cbf7cbdbcb', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '9b7fe375dbd8da53c27773ebc720dae6a4c9a60d81bbfbf1fae178cbf7cbdbcb')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Más de quince años de antigüedad en el ejercicio de su profesión.', false), ('B', 'Más de veinticinco años de antigüedad en el ejercicio de su profesión.', true), ('C', 'Más de veinte años de antigüedad en el ejercicio de su profesión.', false), ('D', 'Más de treinta años de antigüedad en el ejercicio de su profesión.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según la Ley Orgánica del Poder Judicial, en la sesión en la que el Pleno del Consejo General del Poder Judicial deba elegir al Presidente del Tribunal Supremo y del Consejo, para su válida constitución será necesaria al menos la presencia de:', 'El art. 600.3 LOPJ exige al menos doce miembros en la sesión de elección del Presidente; en los demás casos, como mínimo diez Vocales y el Presidente (art. 600.4).', 'age_aux_b1_04_poder_judicial', (select id from public.topics where slug = 'age-aux-b1-04-poder-judicial'), 3, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1985-12666'), 'Art. 600.3 y 600.4 LOPJ', 'En la sesión en la que se tenga que proceder a la elección del Presidente del Tribunal Supremo y del Consejo General del Poder Judicial será necesaria, para la válida constitución del Pleno, al menos la presencia de doce de sus miembros.', null, '542267c43d9f0d23a97a2048cadf8e13ce9376f1b462bf5eae8aaaea447c1c7f', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '542267c43d9f0d23a97a2048cadf8e13ce9376f1b462bf5eae8aaaea447c1c7f')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Doce de sus miembros.', true), ('B', 'Diez Vocales y el Presidente.', false), ('C', 'Quince de sus miembros.', false), ('D', 'Las tres quintas partes de sus miembros.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 567 de la Ley Orgánica del Poder Judicial, respecto de los Vocales del Consejo saliente:', 'El art. 567.5 LOPJ prohíbe designar como Vocales a los del Consejo saliente. Las Cámaras designan, además, tres suplentes por cada turno (art. 567.4).', 'age_aux_b1_04_poder_judicial', (select id from public.topics where slug = 'age-aux-b1-04-poder-judicial'), 3, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1985-12666'), 'Art. 567.5 LOPJ', 'En ningún caso podrá recaer la designación de Vocales del Consejo General del Poder Judicial en Vocales del Consejo saliente.', null, '27dffe5cfe044024774e7efe45e912a9ae98ee9cf7dac1ce847385f6b4d66b82', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '27dffe5cfe044024774e7efe45e912a9ae98ee9cf7dac1ce847385f6b4d66b82')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Podrán ser designados de nuevo por una sola vez.', false), ('B', 'En ningún caso podrá recaer en ellos la designación de Vocales del nuevo Consejo.', true), ('C', 'Podrán ser designados de nuevo solo por el turno de juristas.', false), ('D', 'Continuarán como suplentes del nuevo Consejo.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según la Ley Orgánica del Poder Judicial, si el Ayuntamiento no efectúa la propuesta de Juez de Paz en el plazo previsto desde que se produjo la vacante, la Sala de Gobierno del Tribunal Superior de Justicia procederá a designarlo. ¿Cuál es ese plazo?', 'El art. 101.4 LOPJ da al Ayuntamiento tres meses desde la vacante; si no propone, designa la Sala de Gobierno del TSJ.', 'age_aux_b1_04_poder_judicial', (select id from public.topics where slug = 'age-aux-b1-04-poder-judicial'), 3, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1985-12666'), 'Art. 101.4 LOPJ', 'Si en el plazo de tres meses, a contar desde que se produjera la vacante en un Juzgado de Paz, el Ayuntamiento correspondiente no efectuase la propuesta prevenida en los apartados anteriores, la Sala de Gobierno del Tribunal Superior de Justicia procederá a designar al Juez de Paz.', null, 'c21283150d44952f2fe23c06f7f9db3f14f4c7e3bd38a236675e2e4c23b8f7ac', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'c21283150d44952f2fe23c06f7f9db3f14f4c7e3bd38a236675e2e4c23b8f7ac')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Un mes.', false), ('B', 'Dos meses.', false), ('C', 'Tres meses.', true), ('D', 'Seis meses.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según la Ley Orgánica del Poder Judicial, el Vicepresidente del Tribunal Supremo será nombrado:', 'El art. 589.2 LOPJ exige mayoría de tres quintos del Pleno del CGPJ, a propuesta del Presidente, entre Magistrados del Tribunal Supremo en servicio activo con requisitos para ser Presidente de Sala.', 'age_aux_b1_04_poder_judicial', (select id from public.topics where slug = 'age-aux-b1-04-poder-judicial'), 3, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1985-12666'), 'Art. 589.2 LOPJ', 'El Vicepresidente del Tribunal Supremo será nombrado, por mayoría de tres quintos del Pleno del Consejo General del Poder Judicial, a propuesta del Presidente.', null, 'b451e6afbd77ef0de2c9b3c3d9aacef9e074f89a307aaef26228c44a2971b1c8', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'b451e6afbd77ef0de2c9b3c3d9aacef9e074f89a307aaef26228c44a2971b1c8')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Por el Rey, a propuesta del Gobierno, oído el Consejo General del Poder Judicial.', false), ('B', 'Por mayoría absoluta de la Sala de Gobierno del Tribunal Supremo.', false), ('C', 'Por la Comisión Permanente del Consejo General del Poder Judicial, a propuesta del Presidente.', false), ('D', 'Por mayoría de tres quintos del Pleno del Consejo General del Poder Judicial, a propuesta del Presidente.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
-- Lote age-aux-b1-05-gobierno-ce-v1 (13 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Constitución Española (texto consolidado, BOE)', 'https://www.boe.es/buscar/act.php?id=BOE-A-1978-31229', 'boe'::public.source_kind, 'Agencia Estatal Boletín Oficial del Estado', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('age-aux-b1-05-gobierno', 'I.5 El Gobierno y la Administración') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('auxiliar-administrativo-estado') and t.slug = 'age-aux-b1-05-gobierno' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 98.3 de la Constitución, los miembros del Gobierno no podrán ejercer otras funciones representativas que:', 'El art. 98.3 CE solo admite las funciones representativas propias del mandato parlamentario y prohíbe cualquier otra función pública que no derive del cargo y toda actividad profesional o mercantil (en igual sentido, art. 14.1 LG).', 'age_aux_b1_05_gobierno', (select id from public.topics where slug = 'age-aux-b1-05-gobierno'), 1, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1978-31229'), 'Art. 98.3 CE', 'Los miembros del Gobierno no podrán ejercer otras funciones representativas que las propias del mandato parlamentario, ni cualquier otra función pública que no derive de su cargo, ni actividad profesional o mercantil alguna.', null, 'e0d88fc3d4e7d576af9b648d337ffad3f908efe1f8df341810b839282c2fa5f7', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'e0d88fc3d4e7d576af9b648d337ffad3f908efe1f8df341810b839282c2fa5f7')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Las propias de concejal o alcalde.', false), ('B', 'Las propias de parlamentario autonómico.', false), ('C', 'Las propias del mandato parlamentario.', true), ('D', 'Las que autorice el Consejo de Ministros.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 101.2 de la Constitución, el Gobierno cesante continuará en funciones:', 'El art. 101.2 CE mantiene en funciones al Gobierno cesante hasta la toma de posesión del nuevo Gobierno.', 'age_aux_b1_05_gobierno', (select id from public.topics where slug = 'age-aux-b1-05-gobierno'), 1, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1978-31229'), 'Art. 101.2 CE', 'El Gobierno cesante continuará en funciones hasta la toma de posesión del nuevo Gobierno.', null, 'ed564860e59d290e738f725387a990e04331867f5f867d80b614d6605ba11195', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'ed564860e59d290e738f725387a990e04331867f5f867d80b614d6605ba11195')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Hasta la celebración de las elecciones generales.', false), ('B', 'Hasta la votación de investidura del nuevo Presidente.', false), ('C', 'Durante un plazo máximo de dos meses.', false), ('D', 'Hasta la toma de posesión del nuevo Gobierno.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 107 de la Constitución, el supremo órgano consultivo del Gobierno es:', 'El art. 107 CE define al Consejo de Estado como supremo órgano consultivo del Gobierno; su composición y competencia las regula una ley orgánica.', 'age_aux_b1_05_gobierno', (select id from public.topics where slug = 'age-aux-b1-05-gobierno'), 1, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1978-31229'), 'Art. 107 CE', 'El Consejo de Estado es el supremo órgano consultivo del Gobierno.', null, 'f1ddd84ef4b124fadad3217229c9a3a4bcbf82e8a3a1108c933ac52d3c865fe8', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'f1ddd84ef4b124fadad3217229c9a3a4bcbf82e8a3a1108c933ac52d3c865fe8')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'La Comisión General de Secretarios de Estado y Subsecretarios.', false), ('B', 'El Consejo de Estado.', true), ('C', 'El Consejo de Ministros.', false), ('D', 'La Abogacía General del Estado.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 104.1 de la Constitución, las Fuerzas y Cuerpos de seguridad actúan bajo la dependencia de:', 'El art. 104.1 CE sitúa a las Fuerzas y Cuerpos de seguridad bajo la dependencia del Gobierno, con la misión de proteger el libre ejercicio de los derechos y libertades y garantizar la seguridad ciudadana.', 'age_aux_b1_05_gobierno', (select id from public.topics where slug = 'age-aux-b1-05-gobierno'), 1, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1978-31229'), 'Art. 104.1 CE', 'Las Fuerzas y Cuerpos de seguridad, bajo la dependencia del Gobierno, tendrán como misión proteger el libre ejercicio de los derechos y libertades y garantizar la seguridad ciudadana.', null, '3954d3b365b551a0f72b08b2d77f7671a11eb712d3cdb09838341adff160cc2b', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '3954d3b365b551a0f72b08b2d77f7671a11eb712d3cdb09838341adff160cc2b')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El Gobierno.', true), ('B', 'El Rey.', false), ('C', 'El Ministerio Fiscal.', false), ('D', 'Las Cortes Generales.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 113.1 de la Constitución, el Congreso de los Diputados puede exigir la responsabilidad política del Gobierno mediante la adopción de la moción de censura por:', 'El art. 113.1 CE exige mayoría absoluta del Congreso para aprobar la moción de censura (frente a la mayoría simple de la cuestión de confianza, art. 112).', 'age_aux_b1_05_gobierno', (select id from public.topics where slug = 'age-aux-b1-05-gobierno'), 1, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1978-31229'), 'Art. 113.1 CE', 'El Congreso de los Diputados puede exigir la responsabilidad política del Gobierno mediante la adopción por mayoría absoluta de la moción de censura.', null, '4e19571e89d441f6b8e19ffffe618ff732e1538166d842658311e73ad984b95e', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '4e19571e89d441f6b8e19ffffe618ff732e1538166d842658311e73ad984b95e')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Mayoría simple.', false), ('B', 'Mayoría de tres quintos.', false), ('C', 'Mayoría absoluta.', true), ('D', 'Mayoría de dos tercios.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 103.1 de la Constitución, la Administración Pública actúa de acuerdo con los principios de:', 'El art. 103.1 CE: la Administración sirve con objetividad los intereses generales y actúa con eficacia, jerarquía, descentralización, desconcentración y coordinación, con sometimiento pleno a la ley y al Derecho.', 'age_aux_b1_05_gobierno', (select id from public.topics where slug = 'age-aux-b1-05-gobierno'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1978-31229'), 'Art. 103.1 CE', 'La Administración Pública sirve con objetividad los intereses generales y actúa de acuerdo con los principios de eficacia, jerarquía, descentralización, desconcentración y coordinación, con sometimiento pleno a la ley y al Derecho.', null, 'eedd8b34fdd9ead499a5dd0f03b5ce6b079e9abcc1471a85444bad9ac2e284e3', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'eedd8b34fdd9ead499a5dd0f03b5ce6b079e9abcc1471a85444bad9ac2e284e3')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Eficacia, jerarquía, autonomía, desconcentración y cooperación.', false), ('B', 'Eficacia, jerarquía, descentralización, desconcentración y coordinación.', true), ('C', 'Eficiencia, economía, descentralización, desconcentración y coordinación.', false), ('D', 'Legalidad, jerarquía, descentralización, solidaridad y coordinación.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 99.1 de la Constitución, después de cada renovación del Congreso, el Rey propondrá un candidato a la Presidencia del Gobierno, previa consulta con los representantes de los Grupos políticos con representación parlamentaria, y:', 'El art. 99.1 CE dispone que el Rey propone el candidato a través del Presidente del Congreso, que es también quien refrenda la propuesta (art. 64.1).', 'age_aux_b1_05_gobierno', (select id from public.topics where slug = 'age-aux-b1-05-gobierno'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1978-31229'), 'Art. 99.1 CE', 'el Rey, previa consulta con los representantes designados por los Grupos políticos con representación parlamentaria, y a través del Presidente del Congreso, propondrá un candidato a la Presidencia del Gobierno.', null, '4cbd1ac8e58608488fbf7cefab3a9e5443e0bb8d30937387e0d21b34d014cc50', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '4cbd1ac8e58608488fbf7cefab3a9e5443e0bb8d30937387e0d21b34d014cc50')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'A través del Presidente del Congreso.', true), ('B', 'A propuesta del Consejo de Estado.', false), ('C', 'A través del Presidente del Gobierno en funciones.', false), ('D', 'Previo acuerdo de la Mesa del Congreso.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 102.3 de la Constitución, en los supuestos de responsabilidad criminal del Presidente y los demás miembros del Gobierno:', 'El art. 102.3 CE excluye la prerrogativa real de gracia en todos los supuestos del art. 102.', 'age_aux_b1_05_gobierno', (select id from public.topics where slug = 'age-aux-b1-05-gobierno'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1978-31229'), 'Art. 102.3 CE', 'La prerrogativa real de gracia no será aplicable a ninguno de los supuestos del presente artículo.', null, '9ce10c5279a428234d752bc4fcd5f619a9b73c89e6498889340c7abcf810a636', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '9ce10c5279a428234d752bc4fcd5f619a9b73c89e6498889340c7abcf810a636')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'La prerrogativa real de gracia no será aplicable.', true), ('B', 'La prerrogativa de gracia solo podrá ejercerse previa autorización del Congreso.', false), ('C', 'Solo cabe el indulto parcial.', false), ('D', 'La prerrogativa de gracia corresponde al Consejo de Ministros.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 113.4 de la Constitución, si la moción de censura no fuere aprobada por el Congreso, sus signatarios:', 'El art. 113.4 CE impide a los signatarios de una moción rechazada presentar otra durante el mismo período de sesiones.', 'age_aux_b1_05_gobierno', (select id from public.topics where slug = 'age-aux-b1-05-gobierno'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1978-31229'), 'Art. 113.4 CE', 'Si la moción de censura no fuere aprobada por el Congreso, sus signatarios no podrán presentar otra durante el mismo período de sesiones.', null, '7c3bf0f77500efc0892b9204007c07289d10f19438102554d7a9368f85161066', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '7c3bf0f77500efc0892b9204007c07289d10f19438102554d7a9368f85161066')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'No podrán presentar otra hasta transcurrido un año.', false), ('B', 'No podrán presentar otra durante la misma legislatura.', false), ('C', 'Podrán presentar otra transcurridos cinco días.', false), ('D', 'No podrán presentar otra durante el mismo período de sesiones.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 115.2 de la Constitución, la propuesta de disolución de las Cámaras no podrá presentarse:', 'El art. 115.2 CE prohíbe proponer la disolución mientras se tramita una moción de censura; el plazo de un año del art. 115.3 se cuenta desde la disolución anterior, no desde el inicio de la legislatura.', 'age_aux_b1_05_gobierno', (select id from public.topics where slug = 'age-aux-b1-05-gobierno'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1978-31229'), 'Art. 115.2 CE', 'La propuesta de disolución no podrá presentarse cuando esté en trámite una moción de censura.', null, '70026b6019531f5729ed65ee6430d7b8f5a88c45e3f70deb2378255ebd7834b7', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '70026b6019531f5729ed65ee6430d7b8f5a88c45e3f70deb2378255ebd7834b7')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Durante el primer año de la legislatura.', false), ('B', 'Cuando esté en trámite un proyecto de Ley de Presupuestos.', false), ('C', 'Cuando esté en trámite una moción de censura.', true), ('D', 'Mientras el Senado esté tramitando un veto.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 106.2 de la Constitución, los particulares tendrán derecho a ser indemnizados por toda lesión que sufran en sus bienes y derechos como consecuencia del funcionamiento de los servicios públicos, salvo en los casos de:', 'El art. 106.2 CE solo exceptúa la fuerza mayor; la responsabilidad patrimonial alcanza a las lesiones consecuencia del funcionamiento de los servicios públicos.', 'age_aux_b1_05_gobierno', (select id from public.topics where slug = 'age-aux-b1-05-gobierno'), 3, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1978-31229'), 'Art. 106.2 CE', 'Los particulares, en los términos establecidos por la ley, tendrán derecho a ser indemnizados por toda lesión que sufran en cualquiera de sus bienes y derechos, salvo en los casos de fuerza mayor, siempre que la lesión sea consecuencia del funcionamiento de los servicios públicos.', null, 'e149f9804a961354e6a988471552c267610fd962e413d6cae260efbbff2319b6', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'e149f9804a961354e6a988471552c267610fd962e413d6cae260efbbff2319b6')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Fuerza mayor.', true), ('B', 'Caso fortuito.', false), ('C', 'Funcionamiento normal del servicio.', false), ('D', 'Culpa concurrente de la Administración.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 105.b) de la Constitución, el acceso de los ciudadanos a los archivos y registros administrativos se exceptúa en lo que afecte a:', 'El art. 105.b) CE fija tres límites: seguridad y defensa del Estado, averiguación de los delitos e intimidad de las personas.', 'age_aux_b1_05_gobierno', (select id from public.topics where slug = 'age-aux-b1-05-gobierno'), 3, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1978-31229'), 'Art. 105.b) CE', 'b) El acceso de los ciudadanos a los archivos y registros administrativos, salvo en lo que afecte a la seguridad y defensa del Estado, la averiguación de los delitos y la intimidad de las personas.', null, '2a9d1902b876c9713e8980b1566cdbd97bb736d436a6a8723429be3bdf7afeac', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '2a9d1902b876c9713e8980b1566cdbd97bb736d436a6a8723429be3bdf7afeac')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'La seguridad y defensa del Estado, las relaciones exteriores y los intereses económicos.', false), ('B', 'La averiguación de los delitos, el secreto profesional y la propiedad intelectual.', false), ('C', 'La seguridad y defensa del Estado, la averiguación de los delitos y la intimidad de las personas.', true), ('D', 'La intimidad de las personas, la política monetaria y la protección del medio ambiente.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 111.1 de la Constitución, para el debate de las interpelaciones y preguntas que se formulen al Gobierno en las Cámaras, los Reglamentos establecerán:', 'El art. 111.1 CE somete al Gobierno y a cada uno de sus miembros a interpelaciones y preguntas y ordena a los Reglamentos fijar un tiempo mínimo semanal; toda interpelación puede dar lugar a una moción (art. 111.2).', 'age_aux_b1_05_gobierno', (select id from public.topics where slug = 'age-aux-b1-05-gobierno'), 3, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1978-31229'), 'Art. 111.1 CE', 'El Gobierno y cada uno de sus miembros están sometidos a las interpelaciones y preguntas que se le formulen en las Cámaras. Para esta clase de debate los Reglamentos establecerán un tiempo mínimo semanal.', null, '7df71a07c9d2e5ce7a2218856a54586c3df96c3b2831bd496ba9f6ffccaf7660', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '7df71a07c9d2e5ce7a2218856a54586c3df96c3b2831bd496ba9f6ffccaf7660')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Un tiempo máximo mensual.', false), ('B', 'Un tiempo mínimo semanal.', true), ('C', 'Una sesión obligatoria cada quince días.', false), ('D', 'Un tiempo mínimo por período de sesiones.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
-- Lote age-aux-b1-05-gobierno-lg-v1 (7 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Ley 50/1997, de 27 de noviembre, del Gobierno (texto consolidado, BOE)', 'https://www.boe.es/buscar/act.php?id=BOE-A-1997-25336', 'boe'::public.source_kind, 'Agencia Estatal Boletín Oficial del Estado', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('age-aux-b1-05-gobierno', 'I.5 El Gobierno y la Administración') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('auxiliar-administrativo-estado') and t.slug = 'age-aux-b1-05-gobierno' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según la Ley 50/1997, del Gobierno, las deliberaciones del Consejo de Ministros serán:', 'El art. 5.3 LG declara secretas las deliberaciones del Consejo de Ministros (también las de las Comisiones Delegadas, art. 6.5); las de la Comisión General de Secretarios de Estado y Subsecretarios son reservadas (art. 8.4).', 'age_aux_b1_05_gobierno', (select id from public.topics where slug = 'age-aux-b1-05-gobierno'), 1, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1997-25336'), 'Art. 5.3 LG', 'Las deliberaciones del Consejo de Ministros serán secretas.', null, 'ade739ea6e4002189feb32f1e5ece71b0ff6493edab90038d3661793108af5d5', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'ade739ea6e4002189feb32f1e5ece71b0ff6493edab90038d3661793108af5d5')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Reservadas.', false), ('B', 'Públicas.', false), ('C', 'Públicas, salvo acuerdo en contrario del propio Consejo.', false), ('D', 'Secretas.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según la Ley 50/1997, del Gobierno, ¿a quién corresponde crear, modificar y suprimir, por Real Decreto, los Departamentos Ministeriales y las Secretarías de Estado?', 'El art. 2.2.j) LG atribuye esta facultad al Presidente del Gobierno; al Consejo de Ministros le corresponde crear, modificar y suprimir los órganos directivos de los Departamentos (art. 5.1.i).', 'age_aux_b1_05_gobierno', (select id from public.topics where slug = 'age-aux-b1-05-gobierno'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1997-25336'), 'Art. 2.2.j) LG', 'j) Crear, modificar y suprimir, por Real Decreto, los Departamentos Ministeriales, así como las Secretarías de Estado', null, '765abfe768c4697699e61272fa338c06865951b1446384f0782987fcaf50ed1d', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '765abfe768c4697699e61272fa338c06865951b1446384f0782987fcaf50ed1d')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Al Consejo de Ministros.', false), ('B', 'Al Presidente del Gobierno.', true), ('C', 'A las Cortes Generales, mediante ley.', false), ('D', 'Al Ministro de la Presidencia.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según la Ley 50/1997, del Gobierno, en caso de que existan Ministros sin cartera:', 'El art. 4.2 LG prevé Ministros sin cartera con responsabilidad sobre funciones gubernamentales determinadas, cuyo ámbito, estructura y medios se fijan por Real Decreto.', 'age_aux_b1_05_gobierno', (select id from public.topics where slug = 'age-aux-b1-05-gobierno'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1997-25336'), 'Art. 4.2 LG', 'En caso de que existan Ministros sin cartera, por Real Decreto se determinará el ámbito de sus competencias, la estructura administrativa, así como los medios materiales y personales que queden adscritos al mismo.', null, 'a31233bc0cde31d93c5c631f3e451c4e9e1be6e4fd2f30eefd60046a4d8f5160', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'a31233bc0cde31d93c5c631f3e451c4e9e1be6e4fd2f30eefd60046a4d8f5160')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Sus competencias se determinarán por Orden del Ministro de la Presidencia.', false), ('B', 'No podrán formar parte del Consejo de Ministros.', false), ('C', 'Su nombramiento requerirá la autorización previa del Congreso.', false), ('D', 'Por Real Decreto se determinará el ámbito de sus competencias, la estructura administrativa y los medios que queden adscritos.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según la Ley 50/1997, del Gobierno, la creación, modificación y supresión de las Comisiones Delegadas del Gobierno será acordada:', 'El art. 6.1 LG atribuye la decisión al Consejo de Ministros, mediante Real Decreto y a propuesta del Presidente.', 'age_aux_b1_05_gobierno', (select id from public.topics where slug = 'age-aux-b1-05-gobierno'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1997-25336'), 'Art. 6.1 LG', 'La creación, modificación y supresión de las Comisiones Delegadas del Gobierno será acordada por el Consejo de Ministros mediante Real Decreto, a propuesta del Presidente del Gobierno.', null, '09b6c9a2635cdd445c738975614763e3978f419ad8c2b198e37cd1da7821b796', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '09b6c9a2635cdd445c738975614763e3978f419ad8c2b198e37cd1da7821b796')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Por el Presidente del Gobierno mediante Real Decreto, sin deliberación del Consejo.', false), ('B', 'Por el Consejo de Ministros mediante Real Decreto, a propuesta del Presidente del Gobierno.', true), ('C', 'Por el Consejo de Ministros mediante Orden, a propuesta del Ministro de la Presidencia.', false), ('D', 'Por las Cortes Generales, a propuesta del Gobierno.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según la Ley 50/1997, del Gobierno, los Secretarios de Estado son:', 'El art. 7.1 LG los define como órganos superiores de la AGE; no son miembros del Gobierno, aunque pueden asistir al Consejo de Ministros cuando sean convocados (art. 5.2). Los órganos de apoyo político y técnico son los Gabinetes (art. 10).', 'age_aux_b1_05_gobierno', (select id from public.topics where slug = 'age-aux-b1-05-gobierno'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1997-25336'), 'Art. 7.1 LG', 'Los Secretarios de Estado son órganos superiores de la Administración General del Estado, directamente responsables de la ejecución de la acción del Gobierno en un sector de actividad específica de un Departamento o de la Presidencia del Gobierno.', null, '885bc9664b292ef4288e17fee7f8ef6f60b796cf767fd644572182636e947d00', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '885bc9664b292ef4288e17fee7f8ef6f60b796cf767fd644572182636e947d00')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Miembros del Gobierno que asisten con voz y voto al Consejo de Ministros.', false), ('B', 'Órganos directivos de los Departamentos Ministeriales, dependientes del Subsecretario.', false), ('C', 'Órganos superiores de la Administración General del Estado, directamente responsables de la ejecución de la acción del Gobierno en un sector de actividad específica.', true), ('D', 'Órganos de apoyo político y técnico del Presidente del Gobierno.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según la Ley 50/1997, del Gobierno, la Secretaría de la Comisión General de Secretarios de Estado y Subsecretarios será ejercida por:', 'El art. 8.3 LG atribuye la Secretaría al Subsecretario de la Presidencia; en caso de ausencia, vacante o enfermedad actúa como Secretario el Director del Secretariado del Gobierno.', 'age_aux_b1_05_gobierno', (select id from public.topics where slug = 'age-aux-b1-05-gobierno'), 3, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1997-25336'), 'Art. 8.3 LG', 'La Secretaría de la Comisión General de Secretarios de Estado y Subsecretarios será ejercida por el Subsecretario de la Presidencia. En caso de ausencia, vacante o enfermedad, actuará como Secretario el Director del Secretariado del Gobierno.', null, '90e5089ae05a1914d29c221fde985c7559ea2cea7a4357cc50c2fe199b46a3aa', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '90e5089ae05a1914d29c221fde985c7559ea2cea7a4357cc50c2fe199b46a3aa')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El Subsecretario de la Presidencia.', true), ('B', 'El Director del Secretariado del Gobierno.', false), ('C', 'El Ministro de la Presidencia.', false), ('D', 'El Secretario de Estado de Relaciones con las Cortes.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 5 de la Ley 50/1997, del Gobierno, el Consejo de Ministros aprueba los reglamentos para el desarrollo y la ejecución de las leyes:', 'El art. 5.1.h) LG exige dictamen previo del Consejo de Estado para los reglamentos de desarrollo y ejecución de las leyes.', 'age_aux_b1_05_gobierno', (select id from public.topics where slug = 'age-aux-b1-05-gobierno'), 3, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1997-25336'), 'Art. 5.1.h) LG', 'h) Aprobar los reglamentos para el desarrollo y la ejecución de las leyes, previo dictamen del Consejo de Estado, así como las demás disposiciones reglamentarias que procedan.', null, '8effc8dde1818c5da32901ec9d62781fa618bda185e9a8b4ebfd899cb1db0a56', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '8effc8dde1818c5da32901ec9d62781fa618bda185e9a8b4ebfd899cb1db0a56')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Previo informe de la Comisión General de Codificación.', false), ('B', 'Previa autorización de las Cortes Generales.', false), ('C', 'Previo dictamen de la Comisión General de Secretarios de Estado y Subsecretarios.', false), ('D', 'Previo dictamen del Consejo de Estado.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
-- Lote age-aux-b1-06-gobierno-abierto-a2030-v1 (2 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Orden PCI/383/2019, de 2 de abril (refuerzo de la gobernanza para la Agenda 2030) (texto consolidado, BOE)', 'https://www.boe.es/buscar/act.php?id=BOE-A-2019-4905', 'boe'::public.source_kind, 'Agencia Estatal Boletín Oficial del Estado', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('age-aux-b1-06-gobierno-abierto', 'I.6 El Gobierno Abierto y la Agenda 2030') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('auxiliar-administrativo-estado') and t.slug = 'age-aux-b1-06-gobierno-abierto' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el Acuerdo publicado por la Orden PCI/383/2019, el Grupo de Alto Nivel para la Agenda 2030 se reunirá ordinariamente:', 'El apartado Uno del Acuerdo prevé reuniones ordinarias dos veces al año y extraordinarias a propuesta de la Comisión Delegada del Gobierno para Asuntos Económicos; los informes trimestrales son los del Grupo de Trabajo Interministerial.', 'age_aux_b1_06_gobierno_abierto', (select id from public.topics where slug = 'age-aux-b1-06-gobierno-abierto'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2019-4905'), 'Anexo, apartado Uno, Orden PCI/383/2019', 'el Grupo de Alto Nivel para la Agenda 2030 se reunirá ordinariamente dos veces al año y extraordinariamente cuando se considere necesario a propuesta de la Comisión Delegada del Gobierno para Asuntos Económicos.', 'La Orden PCI/383/2019 está en su versión original (estructura y cargos de 2019); comprobar si este régimen de gobernanza de la Agenda 2030 sigue vigente.', '811da3ef486fb988c47a154b4679da3bcad326ffa3473cc11f82c0cdeef95753', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '811da3ef486fb988c47a154b4679da3bcad326ffa3473cc11f82c0cdeef95753')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Una vez al año.', false), ('B', 'Dos veces al año.', true), ('C', 'Trimestralmente.', false), ('D', 'Una vez al mes.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el Acuerdo publicado por la Orden PCI/383/2019, el Grupo de Trabajo Interministerial para la Agenda 2030 tiene la finalidad de ser:', 'El apartado Tres del Acuerdo crea el Grupo de Trabajo Interministerial como foro técnico de colaboración y coordinación entre los Ministerios implicados, con un representante de cada Ministerio, entre otros miembros.', 'age_aux_b1_06_gobierno_abierto', (select id from public.topics where slug = 'age-aux-b1-06-gobierno-abierto'), 3, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2019-4905'), 'Anexo, apartado Tres, Orden PCI/383/2019', 'Se crea el Grupo de Trabajo Interministerial para la Agenda 2030, que tiene la finalidad de ser un foro técnico para procurar la colaboración y coordinación entre los Ministerios implicados, en la aplicación en España de la Agenda 2030 y el logro de los Objetivos de Desarrollo Sostenible.', 'La Orden PCI/383/2019 está en su versión original (estructura y cargos de 2019); comprobar si este Grupo de Trabajo sigue vigente con esta configuración.', 'eaede4cd9fa864b63b416baadf6c9f6f0b7db063ec07990ea2cee9b1146e493d', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'eaede4cd9fa864b63b416baadf6c9f6f0b7db063ec07990ea2cee9b1146e493d')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Un órgano de participación paritaria de la sociedad civil en el seguimiento de la Agenda 2030.', false), ('B', 'Un órgano político encargado de aprobar la Estrategia de Desarrollo Sostenible.', false), ('C', 'Un foro técnico de coordinación entre el Estado, las comunidades autónomas y las entidades locales.', false), ('D', 'Un foro técnico para procurar la colaboración y coordinación entre los Ministerios implicados en la aplicación en España de la Agenda 2030.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
-- Lote age-aux-b1-06-gobierno-abierto-gobab-v1 (20 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Real Decreto 371/2026, de 6 de mayo, por el que se crea y regula el Foro de Gobierno Abierto (texto consolidado, BOE)', 'https://www.boe.es/buscar/act.php?id=BOE-A-2026-9880', 'boe'::public.source_kind, 'Agencia Estatal Boletín Oficial del Estado', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('age-aux-b1-06-gobierno-abierto', 'I.6 El Gobierno Abierto y la Agenda 2030') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('auxiliar-administrativo-estado') and t.slug = 'age-aux-b1-06-gobierno-abierto' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 4 del Real Decreto 371/2026, para el cumplimiento de sus fines el Foro de Gobierno Abierto funcionará en:', 'El art. 4 del RD 371/2026 enumera su composición (Presidencia, vicepresidencias, vocalías y secretaría) y dispone que funcionará en Pleno, en Comisión Permanente y grupos de trabajo.', 'age_aux_b1_06_gobierno_abierto', (select id from public.topics where slug = 'age-aux-b1-06-gobierno-abierto'), 1, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2026-9880'), 'Art. 4 RD 371/2026', 'Para el cumplimiento de sus fines, el Foro funcionará en Pleno, en Comisión Permanente y grupos de trabajo.', null, '97bb3383f9469d88201f723aabbafaf066ff74caa3dd80d3141264c60a3e100d', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '97bb3383f9469d88201f723aabbafaf066ff74caa3dd80d3141264c60a3e100d')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Pleno, Comisión Ejecutiva y ponencias.', false), ('B', 'Pleno, Comisión Permanente y grupos de trabajo.', true), ('C', 'Pleno y Secciones territoriales.', false), ('D', 'Pleno, Comisión Permanente y Consejo Asesor.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el Real Decreto 371/2026, ¿a quién corresponde la Presidencia del Foro de Gobierno Abierto?', 'El art. 5.1 atribuye la Presidencia al titular de la Secretaría de Estado de Función Pública; la Vicepresidencia Primera corresponde a la Dirección General de Gobernanza Pública y la Secretaría a la Subdirección General de Gobierno Abierto.', 'age_aux_b1_06_gobierno_abierto', (select id from public.topics where slug = 'age-aux-b1-06-gobierno-abierto'), 1, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2026-9880'), 'Art. 5.1 RD 371/2026', 'Corresponde la Presidencia del Foro a la persona titular de la Secretaría de Estado de Función Pública, quien ostentará su representación y ejercerá las funciones establecidas en el artículo 19.2 de la Ley 40/2015, de 1 de octubre.', null, 'df53d4efabfc914ea2425c3286fda13d863d2d052fa63e432fe2903e9fad3e44', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'df53d4efabfc914ea2425c3286fda13d863d2d052fa63e432fe2903e9fad3e44')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'A la persona titular de la Dirección General de Gobernanza Pública.', false), ('B', 'A la persona titular del Ministerio para la Transformación Digital y de la Función Pública.', false), ('C', 'A la persona titular de la Secretaría de Estado de Función Pública.', true), ('D', 'A la persona titular de la Subdirección General de Gobierno Abierto.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 6.2 del Real Decreto 371/2026, ¿cuántas vocalías del Foro de Gobierno Abierto corresponden a la Federación Española de Municipios y Provincias (FEMP) en representación de las administraciones locales?', 'El art. 6.2.a).4.º reserva cuatro vocalías permanentes a la FEMP; la AGE tiene ocho vocalías designadas y cada comunidad autónoma una.', 'age_aux_b1_06_gobierno_abierto', (select id from public.topics where slug = 'age-aux-b1-06-gobierno-abierto'), 1, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2026-9880'), 'Art. 6.2.a) RD 371/2026', '4.º Cuatro vocalías para la Federación Española de Municipios y Provincias (FEMP) en representación de las administraciones locales.', null, '068f06ec9546762056359ce5097e24fe9a26a4f6691c9f004ec02db146ea410d', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '068f06ec9546762056359ce5097e24fe9a26a4f6691c9f004ec02db146ea410d')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Dos.', false), ('B', 'Cuatro.', true), ('C', 'Seis.', false), ('D', 'Ocho.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el Real Decreto 371/2026, las entidades observadoras del Foro de Gobierno Abierto:', 'El art. 6.5 permite a las entidades observadoras intervenir en las sesiones y colaborar en los grupos de trabajo, con voz pero sin voto, sin alterar la composición paritaria.', 'age_aux_b1_06_gobierno_abierto', (select id from public.topics where slug = 'age-aux-b1-06-gobierno-abierto'), 1, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2026-9880'), 'Art. 6.5 RD 371/2026', 'Las entidades observadoras tendrán voz, pero no voto, podrán intervenir en las sesiones del Foro y colaborar en sus grupos de trabajo.', null, '93200fc833e65cd16c685416f4ef4374cbb74788742f0fa11a9230f53721112a', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '93200fc833e65cd16c685416f4ef4374cbb74788742f0fa11a9230f53721112a')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Tendrán voz y voto.', false), ('B', 'No podrán intervenir en las sesiones del Foro.', false), ('C', 'Tendrán voto solo en los grupos de trabajo.', false), ('D', 'Tendrán voz, pero no voto.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el Real Decreto 371/2026, ¿qué es HazLab?', 'El art. 18.1 reconoce HazLab, Laboratorio de Innovación para la Participación dependiente de la Secretaría de Estado de Función Pública, como espacio técnico de referencia en que pueden trabajar los grupos del Foro.', 'age_aux_b1_06_gobierno_abierto', (select id from public.topics where slug = 'age-aux-b1-06-gobierno-abierto'), 1, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2026-9880'), 'Art. 18.1 RD 371/2026', 'Laboratorio de Innovación para la Participación, HazLab, dependiente de la Secretaría de Estado de Función Pública, que se reconoce como espacio técnico de referencia para la colaboración, el diseño participativo y la innovación en políticas de Gobierno Abierto.', null, '2aeda754f5230363af7744e222275bb2c7716f48d84997eebba7628e85d1643b', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '2aeda754f5230363af7744e222275bb2c7716f48d84997eebba7628e85d1643b')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El Laboratorio de Innovación para la Participación, dependiente de la Secretaría de Estado de Función Pública.', true), ('B', 'El portal web en el que se publican los Planes de Acción de Gobierno Abierto.', false), ('C', 'El grupo de trabajo encargado de evaluar el cumplimiento de los Planes de Acción.', false), ('D', 'El Laboratorio de datos abiertos del Consejo de Transparencia y Buen Gobierno.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 2.1 del Real Decreto 371/2026, el Foro de Gobierno Abierto se crea como:', 'El art. 2.1 configura el Foro como órgano colegiado del art. 22.2 de la Ley 40/2015 con participación paritaria de la sociedad civil; el preámbulo recuerda que el Foro anterior (Orden HFP/134/2018) era un grupo de trabajo del art. 22.3.', 'age_aux_b1_06_gobierno_abierto', (select id from public.topics where slug = 'age-aux-b1-06-gobierno-abierto'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2026-9880'), 'Art. 2.1 RD 371/2026', 'Se crea el Foro de Gobierno Abierto (en adelante, el Foro) como órgano colegiado de los previstos en el artículo 22.2 de la Ley 40/2015, de 1 de octubre, de Régimen Jurídico del Sector Público, para la participación, con carácter paritario, de la sociedad civil en materia de gobierno abierto', null, 'd5283fffbb55fd0e95c4e0cc9957d2f1d14f227809ee4e8681f397d9318139e9', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'd5283fffbb55fd0e95c4e0cc9957d2f1d14f227809ee4e8681f397d9318139e9')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Grupo de trabajo de los previstos en el artículo 22.3 de la Ley 40/2015, sin carácter paritario.', false), ('B', 'Organismo autónomo adscrito al Ministerio para la Transformación Digital y de la Función Pública.', false), ('C', 'Órgano colegiado de los previstos en el artículo 22.2 de la Ley 40/2015, para la participación, con carácter paritario, de la sociedad civil.', true), ('D', 'Comisión Delegada del Gobierno para el Gobierno Abierto.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 3.2 del Real Decreto 371/2026, ¿cuál de las siguientes es una función del Foro de Gobierno Abierto?', 'El art. 3.2.b) encomienda al Foro examinar los borradores de los Planes de Acción y proponer mejoras; no aprueba los Planes ni resuelve reclamaciones o sanciona.', 'age_aux_b1_06_gobierno_abierto', (select id from public.topics where slug = 'age-aux-b1-06-gobierno-abierto'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2026-9880'), 'Art. 3.2.b) RD 371/2026', 'b) Examinar los borradores de los Planes de Acción de Gobierno Abierto y formular propuestas de mejora dirigidas a reforzar la participación ciudadana, la transparencia y la rendición de cuentas.', null, '73669873f2698d74b4f83bddf56a5342582448a927b81028b35237199f1d12c7', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '73669873f2698d74b4f83bddf56a5342582448a927b81028b35237199f1d12c7')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Aprobar con carácter definitivo los Planes de Acción de Gobierno Abierto.', false), ('B', 'Examinar los borradores de los Planes de Acción de Gobierno Abierto y formular propuestas de mejora.', true), ('C', 'Resolver las reclamaciones en materia de acceso a la información pública.', false), ('D', 'Imponer sanciones por incumplimiento de las obligaciones de publicidad activa.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 6.2 del Real Decreto 371/2026, ¿cuántas vocalías designadas corresponden a la Administración General del Estado en el Foro de Gobierno Abierto?', 'El art. 6.2.b) prevé ocho vocalías designadas en representación de la AGE, que se suman a la vocalía permanente de la Dirección General de Gobernanza Pública.', 'age_aux_b1_06_gobierno_abierto', (select id from public.topics where slug = 'age-aux-b1-06-gobierno-abierto'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2026-9880'), 'Art. 6.2.b) RD 371/2026', 'b) Vocalías designadas: ocho vocalías en representación de la Administración General del Estado.', null, 'b8f5d9ffec190735a22c2f568c6e195a814c0754bb5e0ce7d95b7cd750e71899', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'b8f5d9ffec190735a22c2f568c6e195a814c0754bb5e0ce7d95b7cd750e71899')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Ocho.', true), ('B', 'Cuatro.', false), ('C', 'Doce.', false), ('D', 'Dieciséis.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 6.3 del Real Decreto 371/2026, ¿cuántas vocalías del Foro de Gobierno Abierto corresponden a personas en representación del Consejo de Consumidores y Usuarios?', 'Las 32 vocalías de la sociedad civil se reparten en seis del ámbito universitario, catorce de asociaciones, corporaciones y fundaciones, seis del Consejo de Consumidores y Usuarios y seis del Tercer Sector.', 'age_aux_b1_06_gobierno_abierto', (select id from public.topics where slug = 'age-aux-b1-06-gobierno-abierto'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2026-9880'), 'Art. 6.3.c) RD 371/2026', 'c) Seis personas en representación del Consejo de Consumidores y Usuarios.', null, '3508ee7b88306d165238676c32988ad72ea3992a144cbe5916ce5d91bd8d5291', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '3508ee7b88306d165238676c32988ad72ea3992a144cbe5916ce5d91bd8d5291')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Cuatro.', false), ('B', 'Seis.', true), ('C', 'Ocho.', false), ('D', 'Catorce.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 12.9 del Real Decreto 371/2026, el informe de seguimiento de las actividades del Foro de Gobierno Abierto:', 'El art. 12.9 exige un informe anual de seguimiento, elaborado con participación de los miembros y publicado en el Portal de la Transparencia en formato reutilizable y accesible.', 'age_aux_b1_06_gobierno_abierto', (select id from public.topics where slug = 'age-aux-b1-06-gobierno-abierto'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2026-9880'), 'Art. 12.9 RD 371/2026', 'El Foro elaborará, con carácter anual, un informe de seguimiento de sus actividades y del grado de implementación de sus recomendaciones y propuestas, con participación de los propios miembros en su elaboración. Dicho informe será publicado en el Portal de la Transparencia en formato reutilizable y accesible', null, '1aa40d6e7e507a22bbb9b4d5d11bf715fd5f0199a5ec7ae235d38bfc890558b5', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '1aa40d6e7e507a22bbb9b4d5d11bf715fd5f0199a5ec7ae235d38bfc890558b5')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Se elaborará con carácter semestral y se remitirá a las Cortes Generales.', false), ('B', 'Se elaborará al final de cada Plan de Acción y se publicará en el «Boletín Oficial del Estado».', false), ('C', 'Se elaborará con carácter anual y se publicará en el Portal de la Transparencia en formato reutilizable y accesible.', true), ('D', 'Se elaborará con carácter anual y se remitirá al Consejo de Transparencia y Buen Gobierno para su aprobación.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el Real Decreto 371/2026, ¿quién ejerce la Presidencia de la Comisión Permanente del Foro de Gobierno Abierto?', 'El art. 14.2 atribuye la Presidencia de la Comisión Permanente a la Vicepresidencia Primera; la Subdirección General de Gobierno Abierto ejerce su Secretaría.', 'age_aux_b1_06_gobierno_abierto', (select id from public.topics where slug = 'age-aux-b1-06-gobierno-abierto'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2026-9880'), 'Art. 14.2.a) RD 371/2026', 'a) La persona titular de la Vicepresidencia Primera del Foro, que ejercerá la Presidencia de la Comisión Permanente.', null, '791e997cbcd6657dde972a76b3c5df370505da289c5db33e83d315ddb0e8b6ea', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '791e997cbcd6657dde972a76b3c5df370505da289c5db33e83d315ddb0e8b6ea')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'La persona titular de la Presidencia del Foro.', false), ('B', 'La persona titular de la Vicepresidencia Segunda del Foro.', false), ('C', 'La persona titular de la Subdirección General de Gobierno Abierto.', false), ('D', 'La persona titular de la Vicepresidencia Primera del Foro.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el Real Decreto 371/2026, el Grupo Interministerial de Gobierno Abierto está conformado por:', 'El art. 17.1 integra el Grupo Interministerial con los responsables de las Unidades de Información de Transparencia de todos los ministerios y encomienda su coordinación a la Dirección General de Gobernanza Pública.', 'age_aux_b1_06_gobierno_abierto', (select id from public.topics where slug = 'age-aux-b1-06-gobierno-abierto'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2026-9880'), 'Art. 17.1 RD 371/2026', 'El Grupo Interministerial de Gobierno Abierto está conformado por los responsables de las Unidades de Información de Transparencia de todos los ministerios, correspondiendo su coordinación a la Dirección General de Gobernanza Pública.', null, '36ec745407f894ca9a0ae28fe819493a0670f622f51df9a88728f23db56157cc', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '36ec745407f894ca9a0ae28fe819493a0670f622f51df9a88728f23db56157cc')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Los responsables de las Unidades de Información de Transparencia de todos los ministerios, bajo la coordinación de la Dirección General de Gobernanza Pública.', true), ('B', 'Los Subsecretarios de todos los ministerios, bajo la presidencia de la Secretaría de Estado de Función Pública.', false), ('C', 'Los Secretarios de Estado de todos los ministerios, bajo la presidencia del Ministro para la Transformación Digital y de la Función Pública.', false), ('D', 'Los responsables de las Unidades de Información de Transparencia, bajo la coordinación del Consejo de Transparencia y Buen Gobierno.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el Real Decreto 371/2026, el Observatorio de Gobierno Abierto contará con un entorno propio dentro de:', 'El art. 19.2 sitúa el Observatorio en el Portal de la Transparencia; su diseño y mantenimiento corresponden al Ministerio para la Transformación Digital y de la Función Pública, a través de la Secretaría de Estado de Función Pública.', 'age_aux_b1_06_gobierno_abierto', (select id from public.topics where slug = 'age-aux-b1-06-gobierno-abierto'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2026-9880'), 'Art. 19.2 RD 371/2026', 'El Observatorio contará con un entorno propio dentro del Portal de la Transparencia, accesible, intuitivo y visualmente adaptado para facilitar la consulta, búsqueda y difusión de las buenas prácticas incorporadas.', null, 'dff880a246c057a463940f8fcc74b92d254d85e1f2c0e443c6e21d38a0b79cde', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'dff880a246c057a463940f8fcc74b92d254d85e1f2c0e443c6e21d38a0b79cde')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'La sede electrónica del Ministerio para la Transformación Digital y de la Función Pública.', false), ('B', 'El Punto de Acceso General electrónico.', false), ('C', 'El Portal de la Transparencia.', true), ('D', 'La plataforma de la Alianza para el Gobierno Abierto.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el preámbulo del Real Decreto 371/2026, ¿dónde y cuándo se celebró la IX Cumbre Global de la Alianza para el Gobierno Abierto?', 'El preámbulo menciona la IX Cumbre Global de la OGP, celebrada en Vitoria-Gasteiz en octubre de 2025, en cuyo marco España aprobó el V Plan de Gobierno Abierto 2025-2029.', 'age_aux_b1_06_gobierno_abierto', (select id from public.topics where slug = 'age-aux-b1-06-gobierno-abierto'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2026-9880'), 'Preámbulo RD 371/2026', 'la IX Cumbre Global de la Alianza para el Gobierno Abierto, celebrada en Vitoria-Gasteiz en octubre de 2025', null, '324988c7bd503b2dfdbc8af450e31986ad7717b1b1a50d042cc7a5628a707ce4', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '324988c7bd503b2dfdbc8af450e31986ad7717b1b1a50d042cc7a5628a707ce4')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'En Madrid, en octubre de 2025.', false), ('B', 'En Vitoria-Gasteiz, en octubre de 2025.', true), ('C', 'En Vitoria-Gasteiz, en mayo de 2026.', false), ('D', 'En Bilbao, en octubre de 2024.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el preámbulo del Real Decreto 371/2026, ¿qué Plan de Gobierno Abierto incorporó por primera vez la creación del Foro de Gobierno Abierto?', 'El preámbulo señala que el III Plan (2017-2019) incorporó por primera vez la creación del Foro, formalizada por la Orden HFP/134/2018; el IV Plan consolidó su despliegue.', 'age_aux_b1_06_gobierno_abierto', (select id from public.topics where slug = 'age-aux-b1-06-gobierno-abierto'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2026-9880'), 'Preámbulo RD 371/2026', 'El III Plan de Gobierno Abierto (2017-2019) supuso un hito en esta evolución, al incorporar por primera vez la creación del Foro de Gobierno Abierto como espacio de diálogo estructurado entre la Administración General del Estado y la sociedad civil.', null, 'd64e3a26ddd527a46d1239ddcad7b544f94192346b14fd17283cc624457b0813', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'd64e3a26ddd527a46d1239ddcad7b544f94192346b14fd17283cc624457b0813')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El II Plan de Gobierno Abierto (2014-2016).', false), ('B', 'El IV Plan de Gobierno Abierto (2020-2024).', false), ('C', 'El V Plan de Gobierno Abierto (2025-2029).', false), ('D', 'El III Plan de Gobierno Abierto (2017-2019).', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el Real Decreto 371/2026, en caso de ausencia, vacante o enfermedad, la Vicepresidencia Primera del Foro de Gobierno Abierto podrá ser suplida por:', 'El art. 5.2 dispone que la Vicepresidencia Primera sustituye a la Presidencia y que, a su vez, puede ser suplida por la persona titular de la Subdirección General de Gobierno Abierto.', 'age_aux_b1_06_gobierno_abierto', (select id from public.topics where slug = 'age-aux-b1-06-gobierno-abierto'), 3, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2026-9880'), 'Art. 5.2 RD 371/2026', 'A su vez, la Vicepresidencia Primera podrá ser suplida en caso de ausencia, vacante o enfermedad por la persona titular de la Subdirección General de Gobierno Abierto.', null, 'f9cb20319b9d1542d307c1d766db785c647a2f87cf4bd5ed4423bb5864a4a38b', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'f9cb20319b9d1542d307c1d766db785c647a2f87cf4bd5ed4423bb5864a4a38b')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'La persona titular de la Vicepresidencia Segunda.', false), ('B', 'La vocalía de mayor antigüedad de la Administración General del Estado.', false), ('C', 'La persona titular de la Secretaría de Estado de Función Pública.', false), ('D', 'La persona titular de la Subdirección General de Gobierno Abierto.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 6.3 del Real Decreto 371/2026, de las seis vocalías del Foro de Gobierno Abierto reservadas a profesorado de universidades españolas:', 'El art. 6.3.a) reparte las seis vocalías académicas: cuatro a propuesta de la Conferencia de Rectores y Rectoras (CRUE) y dos del CEPC.', 'age_aux_b1_06_gobierno_abierto', (select id from public.topics where slug = 'age-aux-b1-06-gobierno-abierto'), 3, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2026-9880'), 'Art. 6.3.a) RD 371/2026', 'a) Seis catedráticas o catedráticos o profesoras o profesores de universidades españolas, de las cuales cuatro serán a propuesta de la Conferencia de Rectores y Rectoras de Universidades Españolas (CRUE) y dos a propuesta del Centro de Estudios Políticos y Constitucionales (CEPC).', null, '429530c412eddbd1f61a0b2a11cd39256e0f8e8b2c3eda296d07b809d29773d3', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '429530c412eddbd1f61a0b2a11cd39256e0f8e8b2c3eda296d07b809d29773d3')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Cuatro serán a propuesta de la CRUE y dos a propuesta del Centro de Estudios Políticos y Constitucionales.', true), ('B', 'Tres serán a propuesta de la CRUE y tres a propuesta del Centro de Estudios Políticos y Constitucionales.', false), ('C', 'Cuatro serán a propuesta de la CRUE y dos a propuesta del Instituto Nacional de Administración Pública.', false), ('D', 'Las seis serán a propuesta de la CRUE.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el Real Decreto 371/2026, el procedimiento de designación y elección de las vocalías de la sociedad civil deberá concluir en un plazo máximo de:', 'El art. 8.2 ordena iniciar el procedimiento dentro del mes siguiente a la entrada en vigor (o a la aprobación de cada Plan en las renovaciones) y concluirlo en un máximo de cuatro meses desde su inicio.', 'age_aux_b1_06_gobierno_abierto', (select id from public.topics where slug = 'age-aux-b1-06-gobierno-abierto'), 3, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2026-9880'), 'Art. 8.2 RD 371/2026', 'En ambos casos, deberá concluir en un plazo máximo de cuatro meses desde la fecha de inicio.', null, 'aee685368f263bbce05b3270c2f81cd2417b90d945ba58ba7e3ab5409399ed80', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'aee685368f263bbce05b3270c2f81cd2417b90d945ba58ba7e3ab5409399ed80')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Cuatro meses desde la fecha de inicio.', true), ('B', 'Tres meses desde la fecha de inicio.', false), ('C', 'Seis meses desde la aprobación del Plan de Gobierno Abierto.', false), ('D', 'Un mes desde la entrada en vigor del real decreto.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el Real Decreto 371/2026, la persona coordinadora de cada grupo de trabajo del Foro de Gobierno Abierto será designada:', 'El art. 16.5 atribuye la designación a la Comisión Permanente entre los representantes de la sociedad civil; una persona funcionaria de la Subdirección General de Gobierno Abierto ejerce la secretaría del grupo. La mayoría simple del grupo se usa para designar su vocalía en la Comisión Permanente (art. 15.1).', 'age_aux_b1_06_gobierno_abierto', (select id from public.topics where slug = 'age-aux-b1-06-gobierno-abierto'), 3, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2026-9880'), 'Art. 16.5 RD 371/2026', 'Cada grupo de trabajo contará entre sus miembros con una persona coordinadora miembro del Foro, designada por la Comisión Permanente del Foro entre los miembros representantes de la sociedad civil.', null, '7bdf36aa9ff8043389899c2a6c41d78617a6ab1b7d37884d5559dc0be69de014', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '7bdf36aa9ff8043389899c2a6c41d78617a6ab1b7d37884d5559dc0be69de014')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Por la Presidencia del Foro, entre los miembros representantes de las administraciones públicas.', false), ('B', 'Por la Comisión Permanente, entre los miembros representantes de la sociedad civil.', true), ('C', 'Por el propio grupo de trabajo, por mayoría simple de sus miembros.', false), ('D', 'Por el Pleno, entre cualesquiera de sus miembros.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según la disposición transitoria única del Real Decreto 371/2026, la constitución del nuevo Foro de Gobierno Abierto deberá realizarse en el plazo máximo de:', 'La disposición transitoria única fija tres meses desde la entrada en vigor; hasta entonces siguen en funciones los miembros del Foro regulado por la Orden HFP/134/2018.', 'age_aux_b1_06_gobierno_abierto', (select id from public.topics where slug = 'age-aux-b1-06-gobierno-abierto'), 3, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2026-9880'), 'Disposición transitoria única RD 371/2026', 'La constitución del nuevo Foro deberá realizarse en el plazo máximo de tres meses desde la entrada en vigor de este real decreto.', null, '32361c4354d164cb4e741c0435bbfb708b5bfa9d71ea93965a484b15c1893b4c', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '32361c4354d164cb4e741c0435bbfb708b5bfa9d71ea93965a484b15c1893b4c')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Seis meses desde la entrada en vigor del real decreto.', false), ('B', 'Un mes desde la publicación del real decreto.', false), ('C', 'Tres meses desde la entrada en vigor del real decreto.', true), ('D', 'Cuatro meses desde la aprobación del V Plan de Gobierno Abierto.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
-- Lote age-aux-b1-06-gobierno-abierto-lt-v1 (1 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Ley 19/2013, de 9 de diciembre, de transparencia, acceso a la información pública y buen gobierno (texto consolidado, BOE)', 'https://www.boe.es/buscar/act.php?id=BOE-A-2013-12887', 'boe'::public.source_kind, 'Agencia Estatal Boletín Oficial del Estado', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('age-aux-b1-06-gobierno-abierto', 'I.6 El Gobierno Abierto y la Agenda 2030') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('auxiliar-administrativo-estado') and t.slug = 'age-aux-b1-06-gobierno-abierto' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 1 de la Ley 19/2013, de transparencia, acceso a la información pública y buen gobierno, ¿cuál de los siguientes forma parte de su objeto?', 'El art. 1 de la Ley 19/2013 tiene un triple objeto: ampliar y reforzar la transparencia de la actividad pública, regular y garantizar el derecho de acceso a la información y establecer las obligaciones de buen gobierno de los responsables públicos.', 'age_aux_b1_06_gobierno_abierto', (select id from public.topics where slug = 'age-aux-b1-06-gobierno-abierto'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2013-12887'), 'Art. 1 Ley 19/2013', 'Esta Ley tiene por objeto ampliar y reforzar la transparencia de la actividad pública, regular y garantizar el derecho de acceso a la información relativa a aquella actividad y establecer las obligaciones de buen gobierno que deben cumplir los responsables públicos así como las consecuencias derivadas de su incumplimiento.', null, 'cf3b346f226145df10d2c6b32f47bf6405ce955906f4f2a6ff34ee781703fe05', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'cf3b346f226145df10d2c6b32f47bf6405ce955906f4f2a6ff34ee781703fe05')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Regular el procedimiento administrativo común de las Administraciones Públicas.', false), ('B', 'Crear y regular el Foro de Gobierno Abierto.', false), ('C', 'Establecer las obligaciones de buen gobierno que deben cumplir los responsables públicos.', true), ('D', 'Establecer el régimen de incompatibilidades del personal al servicio de las Administraciones Públicas.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
-- Lote age-aux-b1-06-gobierno-abierto-un_ods-v1 (2 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Naciones Unidas · Objetivos de Desarrollo Sostenible', 'https://www.un.org/sustainabledevelopment/es/objetivos-de-desarrollo-sostenible/', 'web_oficial'::public.source_kind, 'Organización de las Naciones Unidas', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('age-aux-b1-06-gobierno-abierto', 'I.6 El Gobierno Abierto y la Agenda 2030') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('auxiliar-administrativo-estado') and t.slug = 'age-aux-b1-06-gobierno-abierto' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según la relación oficial de los Objetivos de Desarrollo Sostenible publicada por Naciones Unidas, ¿cuál es el último de los 17 Objetivos?', 'En la lista de la ONU el Objetivo 17 es «Alianzas»; Paz y justicia es el 16, Cambio climático el 13 y Ciudades el 11.', 'age_aux_b1_06_gobierno_abierto', (select id from public.topics where slug = 'age-aux-b1-06-gobierno-abierto'), 1, 'es', true, (select id from public.sources where url = 'https://www.un.org/sustainabledevelopment/es/objetivos-de-desarrollo-sostenible/'), 'ODS 17 (ONU)', 'Objetivo 17: Alianzas', null, '8126b9ae3cbaa298e604a6f5b0eb1f218efcc6373d44dbef4b558831711e5443', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '8126b9ae3cbaa298e604a6f5b0eb1f218efcc6373d44dbef4b558831711e5443')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Objetivo 17: Paz y justicia.', false), ('B', 'Objetivo 17: Cambio climático.', false), ('C', 'Objetivo 17: Ciudades.', false), ('D', 'Objetivo 17: Alianzas.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según la relación oficial de los Objetivos de Desarrollo Sostenible publicada por Naciones Unidas, el Objetivo 6 se refiere a:', 'En la lista de la ONU el Objetivo 6 es «Agua y saneamiento»; Energía es el 7, Educación el 4 y Océanos el 14.', 'age_aux_b1_06_gobierno_abierto', (select id from public.topics where slug = 'age-aux-b1-06-gobierno-abierto'), 1, 'es', true, (select id from public.sources where url = 'https://www.un.org/sustainabledevelopment/es/objetivos-de-desarrollo-sostenible/'), 'ODS 6 (ONU)', 'Objetivo 6: Agua y saneamiento', null, 'ae834097797932b5a11bc1c032e2ba5964e0f3918e1fe5f1b98f8cd59e66d79c', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'ae834097797932b5a11bc1c032e2ba5964e0f3918e1fe5f1b98f8cd59e66d79c')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Agua y saneamiento.', true), ('B', 'Energía.', false), ('C', 'Educación.', false), ('D', 'Océanos.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
-- Lote age-aux-b1-07-transparencia-lt-v1 (20 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Ley 19/2013, de 9 de diciembre, de transparencia, acceso a la información pública y buen gobierno (texto consolidado, BOE)', 'https://www.boe.es/buscar/act.php?id=BOE-A-2013-12887', 'boe'::public.source_kind, 'Agencia Estatal Boletín Oficial del Estado', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('age-aux-b1-07-transparencia', 'I.7 La Ley 19/2013 de transparencia, acceso a la información pública y buen gobierno') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('auxiliar-administrativo-estado') and t.slug = 'age-aux-b1-07-transparencia' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'A los efectos del título I de la Ley 19/2013, ¿qué se entiende por Administraciones Públicas según su artículo 2.2?', 'El art. 2.2 LT limita el concepto de Administraciones Públicas, a efectos del título I, a los organismos y entidades de las letras a) a d) del art. 2.1.', 'age_aux_b1_07_transparencia', (select id from public.topics where slug = 'age-aux-b1-07-transparencia'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2013-12887'), 'Art. 2.2 LT', '2. A los efectos de lo previsto en este título, se entiende por Administraciones Públicas los organismos y entidades incluidos en las letras a) a d) del apartado anterior.', null, 'f2d1f5a7e0632780bac51d76626f91fa8819c62d7c5d38569849c3037617833c', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'f2d1f5a7e0632780bac51d76626f91fa8819c62d7c5d38569849c3037617833c')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Los organismos y entidades incluidos en las letras a) a d) del apartado 1 del artículo 2.', true), ('B', 'Todos los sujetos enumerados en las letras a) a i) del apartado 1 del artículo 2.', false), ('C', 'Únicamente la Administración General del Estado y las Administraciones de las Comunidades Autónomas.', false), ('D', 'Los organismos y entidades incluidos en las letras a) a f) del apartado 1 del artículo 2.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 3.b) de la Ley 19/2013, una entidad privada que no supere los 100.000 euros de subvenciones anuales queda también sujeta a la publicidad activa cuando al menos el 40 % de sus ingresos anuales tengan carácter de ayuda o subvención pública, siempre que alcancen como mínimo:', 'El art. 3.b) LT añade al umbral de 100.000 euros el supuesto de que al menos el 40 % de los ingresos anuales sean ayudas o subvenciones públicas, con un mínimo de 5.000 euros.', 'age_aux_b1_07_transparencia', (select id from public.topics where slug = 'age-aux-b1-07-transparencia'), 3, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2013-12887'), 'Art. 3.b) LT', 'o cuando al menos el 40 % del total de sus ingresos anuales tengan carácter de ayuda o subvención pública, siempre que alcancen como mínimo la cantidad de 5.000 euros.', null, 'd39962a1bcf5cad55d1c0afc6d1038d9c362f9e2a18140757f0ccad05bcc3289', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'd39962a1bcf5cad55d1c0afc6d1038d9c362f9e2a18140757f0ccad05bcc3289')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', '10.000 euros.', false), ('B', '50.000 euros.', false), ('C', '5.000 euros.', true), ('D', '3.000 euros.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'De acuerdo con el artículo 5.4 de la Ley 19/2013, las entidades sin ánimo de lucro que persigan exclusivamente fines de interés social o cultural podrán cumplir sus obligaciones utilizando los medios electrónicos puestos a su disposición por la Administración de la que provenga la mayor parte de sus ayudas cuando su presupuesto sea inferior a:', 'El art. 5.4, párrafo segundo, LT prevé esa facilidad para las entidades sin ánimo de lucro de fines sociales o culturales con presupuesto inferior a 50.000 euros.', 'age_aux_b1_07_transparencia', (select id from public.topics where slug = 'age-aux-b1-07-transparencia'), 3, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2013-12887'), 'Art. 5.4 LT', 'Cuando se trate de entidades sin ánimo de lucro que persigan exclusivamente fines de interés social o cultural y cuyo presupuesto sea inferior a 50.000 euros, el cumplimiento de las obligaciones derivadas de esta Ley podrá realizarse utilizando los medios electrónicos puestos a su disposición por la Administración Pública de la que provenga la mayor parte de las ayudas o subvenciones públicas percibidas.', null, '2b2ee8f4a29ce3e3581049cb2a0fa5adac780178e597512aff3b1e0609c3d49b', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '2b2ee8f4a29ce3e3581049cb2a0fa5adac780178e597512aff3b1e0609c3d49b')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', '100.000 euros.', false), ('B', '50.000 euros.', true), ('C', '30.000 euros.', false), ('D', '5.000 euros.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 6.2 de la Ley 19/2013, en el ámbito de la Administración General del Estado, ¿a quién corresponde la evaluación del cumplimiento de los planes y programas anuales y plurianuales?', 'El art. 6.2, párrafo segundo, LT atribuye esa evaluación, en la AGE, a las inspecciones generales de servicios.', 'age_aux_b1_07_transparencia', (select id from public.topics where slug = 'age-aux-b1-07-transparencia'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2013-12887'), 'Art. 6.2 LT', 'En el ámbito de la Administración General del Estado corresponde a las inspecciones generales de servicios la evaluación del cumplimiento de estos planes y programas.', null, 'b3059db6fe5ad5b1df0d5ac40d6a5b3fdb2d14e74540228b96c2d42aa658dfc8', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'b3059db6fe5ad5b1df0d5ac40d6a5b3fdb2d14e74540228b96c2d42aa658dfc8')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Al Consejo de Transparencia y Buen Gobierno.', false), ('B', 'A la Intervención General de la Administración del Estado.', false), ('C', 'A las Secretarías Generales Técnicas de cada Departamento.', false), ('D', 'A las inspecciones generales de servicios.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'De acuerdo con el artículo 8.1.a) de la Ley 19/2013, la publicación de la información relativa a los contratos menores podrá realizarse:', 'El art. 8.1.a) LT permite publicar trimestralmente la información de los contratos menores.', 'age_aux_b1_07_transparencia', (select id from public.topics where slug = 'age-aux-b1-07-transparencia'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2013-12887'), 'Art. 8.1.a) LT', 'La publicación de la información relativa a los contratos menores podrá realizarse trimestralmente.', null, '624cc954fac296c11b35c76573928a55329a7183598c3fa88227fac7e39d82b3', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '624cc954fac296c11b35c76573928a55329a7183598c3fa88227fac7e39d82b3')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Mensualmente.', false), ('B', 'Semestralmente.', false), ('C', 'Trimestralmente.', true), ('D', 'Anualmente.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 9.3 de la Ley 19/2013, el incumplimiento reiterado de las obligaciones de publicidad activa tendrá la consideración, a efectos del régimen disciplinario de sus responsables, de:', 'El art. 9.3 LT califica el incumplimiento reiterado de la publicidad activa como infracción grave a efectos disciplinarios.', 'age_aux_b1_07_transparencia', (select id from public.topics where slug = 'age-aux-b1-07-transparencia'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2013-12887'), 'Art. 9.3 LT', '3. El incumplimiento reiterado de las obligaciones de publicidad activa reguladas en este capítulo tendrá la consideración de infracción grave', null, '6f9ba7304562899412bcec60477c58cab56ef4a192fd42e8942af8613fad9eac', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '6f9ba7304562899412bcec60477c58cab56ef4a192fd42e8942af8613fad9eac')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Infracción grave.', true), ('B', 'Infracción leve.', false), ('C', 'Infracción muy grave.', false), ('D', 'Falta administrativa sin sanción, que solo da lugar a un requerimiento.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select '¿Cuáles son los principios técnicos a los que debe adecuarse la información del Portal de la Transparencia según el artículo 11 de la Ley 19/2013?', 'El art. 11 LT enumera tres principios técnicos: accesibilidad (letra a), interoperabilidad (letra b) y reutilización (letra c).', 'age_aux_b1_07_transparencia', (select id from public.topics where slug = 'age-aux-b1-07-transparencia'), 1, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2013-12887'), 'Art. 11 LT', 'a) Accesibilidad: […] b) Interoperabilidad: […] c) Reutilización:', null, '91cad628dbc3fc769cb66dc197480d5f247a30a761d726a1ce83ef1c1bc948a1', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '91cad628dbc3fc769cb66dc197480d5f247a30a761d726a1ce83ef1c1bc948a1')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Publicidad, gratuidad y veracidad.', false), ('B', 'Accesibilidad, confidencialidad y disponibilidad.', false), ('C', 'Integridad, interoperabilidad y trazabilidad.', false), ('D', 'Accesibilidad, interoperabilidad y reutilización.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 13 de la Ley 19/2013, se entiende por información pública:', 'El art. 13 LT define la información pública con independencia del formato o soporte, siempre que obre en poder de un sujeto obligado y se haya elaborado o adquirido en el ejercicio de sus funciones.', 'age_aux_b1_07_transparencia', (select id from public.topics where slug = 'age-aux-b1-07-transparencia'), 1, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2013-12887'), 'Art. 13 LT', 'Se entiende por información pública los contenidos o documentos, cualquiera que sea su formato o soporte, que obren en poder de alguno de los sujetos incluidos en el ámbito de aplicación de este título y que hayan sido elaborados o adquiridos en el ejercicio de sus funciones.', null, '1e4aac36bb84573d4e8351ac07f98f6b1cce97766b8bea7e090e5cf54ecb0340', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '1e4aac36bb84573d4e8351ac07f98f6b1cce97766b8bea7e090e5cf54ecb0340')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Únicamente los documentos en soporte electrónico publicados en el Portal de la Transparencia.', false), ('B', 'Los contenidos o documentos, cualquiera que sea su formato o soporte, que obren en poder de los sujetos incluidos en el ámbito del título I y que hayan sido elaborados o adquiridos en el ejercicio de sus funciones.', true), ('C', 'Los contenidos o documentos elaborados por los sujetos obligados, siempre que estén en soporte papel y archivados.', false), ('D', 'Los documentos que formen parte de un procedimiento administrativo ya terminado.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'De acuerdo con el artículo 15.1 de la Ley 19/2013, si la información solicitada incluye datos personales relativos a la salud, el acceso solo se podrá autorizar:', 'El art. 15.1, párrafo segundo, LT exige para los datos de origen racial, salud, vida sexual, genéticos o biométricos el consentimiento expreso del afectado o el amparo de una norma con rango de ley (el consentimiento expreso y por escrito se reserva a ideología, afiliación sindical, religión o creencias).', 'age_aux_b1_07_transparencia', (select id from public.topics where slug = 'age-aux-b1-07-transparencia'), 3, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2013-12887'), 'Art. 15.1 LT', 'Si la información incluyese datos personales que hagan referencia al origen racial, a la salud o a la vida sexual, incluyese datos genéticos o biométricos o contuviera datos relativos a la comisión de infracciones penales o administrativas que no conllevasen la amonestación pública al infractor, el acceso solo se podrá autorizar en caso de que se cuente con el consentimiento expreso del afectado o si aquel estuviera amparado por una norma con rango de ley.', null, 'cdf82c01ceeb3a39b7ea918cde9b53e6985ab742e03895d56a3f18902cc38f44', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'cdf82c01ceeb3a39b7ea918cde9b53e6985ab742e03895d56a3f18902cc38f44')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Únicamente con el consentimiento expreso y por escrito del afectado.', false), ('B', 'Previa ponderación razonada del interés público, sin necesidad de consentimiento.', false), ('C', 'Con el consentimiento expreso del afectado o si estuviera amparado por una norma con rango de ley.', true), ('D', 'Con autorización previa de la Agencia Española de Protección de Datos.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 16 de la Ley 19/2013, cuando la aplicación de alguno de los límites del artículo 14 no afecte a la totalidad de la información solicitada:', 'El art. 16 LT prevé el acceso parcial, omitiendo la parte afectada por el límite, salvo que la información resultante quede distorsionada o sin sentido; debe indicarse al solicitante qué parte se ha omitido.', 'age_aux_b1_07_transparencia', (select id from public.topics where slug = 'age-aux-b1-07-transparencia'), 1, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2013-12887'), 'Art. 16 LT', 'se concederá el acceso parcial previa omisión de la información afectada por el límite salvo que de ello resulte una información distorsionada o que carezca de sentido.', null, '50888e245ad29ffdb39910291d8e291fe6f27ff8a8c9d12e20e1fc7bdfb8ff20', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '50888e245ad29ffdb39910291d8e291fe6f27ff8a8c9d12e20e1fc7bdfb8ff20')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Se denegará el acceso a toda la información solicitada.', false), ('B', 'Se inadmitirá la solicitud por requerir una acción previa de reelaboración.', false), ('C', 'Se remitirá la solicitud al Consejo de Transparencia y Buen Gobierno para que decida.', false), ('D', 'Se concederá el acceso parcial previa omisión de la información afectada por el límite, salvo que resulte una información distorsionada o que carezca de sentido.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 17.2 de la Ley 19/2013, la solicitud de acceso a la información podrá presentarse por cualquier medio que permita tener constancia, entre otros extremos, de:', 'El art. 17.2 LT exige constancia de la identidad del solicitante, la información solicitada, una dirección de contacto (preferentemente electrónica) y, en su caso, la modalidad preferida de acceso. La motivación no es obligatoria (art. 17.3).', 'age_aux_b1_07_transparencia', (select id from public.topics where slug = 'age-aux-b1-07-transparencia'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2013-12887'), 'Art. 17.2 LT', 'c) Una dirección de contacto, preferentemente electrónica, a efectos de comunicaciones.', null, '4cf62d57f0df1c7cec69851a54fd5424fa0454101b0afbf3d2bf22975f501458', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '4cf62d57f0df1c7cec69851a54fd5424fa0454101b0afbf3d2bf22975f501458')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Los motivos por los que se solicita la información.', false), ('B', 'Una dirección de contacto, preferentemente electrónica, a efectos de comunicaciones.', true), ('C', 'El uso que el solicitante dará a la información obtenida.', false), ('D', 'La condición de interesado del solicitante en un procedimiento en curso.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'De acuerdo con el artículo 18.2 de la Ley 19/2013, cuando se inadmita una solicitud por dirigirse a un órgano en cuyo poder no obre la información y se desconozca el competente, el órgano que acuerde la inadmisión deberá:', 'El art. 18.2 LT obliga, en la inadmisión por la causa de la letra d) del art. 18.1, a indicar en la resolución el órgano que se considere competente.', 'age_aux_b1_07_transparencia', (select id from public.topics where slug = 'age-aux-b1-07-transparencia'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2013-12887'), 'Art. 18.2 LT', '2. En el caso en que se inadmita la solicitud por concurrir la causa prevista en la letra d) del apartado anterior, el órgano que acuerde la inadmisión deberá indicar en la resolución el órgano que, a su juicio, es competente para conocer de la solicitud.', null, '90f01923ea5c9e95aef308cd7aab3e9d0e144975c8e4f25cc86d3260dafe775e', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '90f01923ea5c9e95aef308cd7aab3e9d0e144975c8e4f25cc86d3260dafe775e')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Indicar en la resolución el órgano que, a su juicio, es competente para conocer de la solicitud.', true), ('B', 'Remitir de oficio la solicitud al Consejo de Transparencia y Buen Gobierno.', false), ('C', 'Conceder al solicitante un plazo de diez días para que identifique el órgano competente.', false), ('D', 'Archivar la solicitud sin necesidad de resolución motivada.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 20.2 de la Ley 19/2013, ¿cuál de las siguientes resoluciones en materia de acceso a la información debe ser motivada?', 'El art. 20.2 LT exige motivación en las resoluciones que denieguen el acceso, las que concedan acceso parcial o por una modalidad distinta de la solicitada y las que permitan el acceso pese a la oposición de un tercero.', 'age_aux_b1_07_transparencia', (select id from public.topics where slug = 'age-aux-b1-07-transparencia'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2013-12887'), 'Art. 20.2 LT', '2. Serán motivadas las resoluciones que denieguen el acceso, las que concedan el acceso parcial o a través de una modalidad distinta a la solicitada y las que permitan el acceso cuando haya habido oposición de un tercero.', null, '90f73c443de01748f51776143e98e426e58d55e4fc3712745ceb6119d216907e', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '90f73c443de01748f51776143e98e426e58d55e4fc3712745ceb6119d216907e')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'La que conceda el acceso total en la modalidad solicitada sin oposición de terceros.', false), ('B', 'La que se limite a indicar cómo acceder a información ya publicada.', false), ('C', 'La que conceda el acceso parcial.', true), ('D', 'La que conceda el acceso total a un solicitante que haya expuesto los motivos de su solicitud.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'De acuerdo con el artículo 22.4 de la Ley 19/2013, el acceso a la información pública:', 'El art. 22.4 LT declara gratuito el acceso, pero la expedición de copias o el cambio de formato pueden dar lugar a exacciones según la Ley 8/1989 o la normativa autonómica o local.', 'age_aux_b1_07_transparencia', (select id from public.topics where slug = 'age-aux-b1-07-transparencia'), 1, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2013-12887'), 'Art. 22.4 LT', '4. El acceso a la información será gratuito. No obstante, la expedición de copias o la trasposición de la información a un formato diferente al original podrá dar lugar a la exigencia de exacciones', null, 'f5a6aaa379a6de1dfd823ba2afc8365b6813db212610dc10cca6ceaa2ed87649', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'f5a6aaa379a6de1dfd823ba2afc8365b6813db212610dc10cca6ceaa2ed87649')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Está sujeto en todo caso al pago de una tasa por cada solicitud presentada.', false), ('B', 'Es gratuito, aunque la expedición de copias o la trasposición a un formato diferente al original puede dar lugar a la exigencia de exacciones.', true), ('C', 'Es gratuito, incluida siempre la expedición de copias en cualquier formato.', false), ('D', 'Es gratuito solo para las personas físicas; las jurídicas abonan un precio público.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según los principios de actuación del artículo 26.2.b) de la Ley 19/2013, en el caso de obsequios de una mayor relevancia institucional recibidos por un alto cargo:', 'El art. 26.2.b) 6.º LT prohíbe aceptar regalos que superen los usos habituales, sociales o de cortesía y ordena incorporar los obsequios de mayor relevancia institucional al patrimonio de la Administración.', 'age_aux_b1_07_transparencia', (select id from public.topics where slug = 'age-aux-b1-07-transparencia'), 1, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2013-12887'), 'Art. 26.2.b) 6.º LT', 'En el caso de obsequios de una mayor relevancia institucional se procederá a su incorporación al patrimonio de la Administración Pública correspondiente.', null, 'db50fa456f29d2c08d8059b47a08296ae21466abaff2cad84461c78eb97343c7', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'db50fa456f29d2c08d8059b47a08296ae21466abaff2cad84461c78eb97343c7')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El alto cargo podrá conservarlos si los declara en el Registro de Actividades.', false), ('B', 'Deberán devolverse al remitente en el plazo de un mes.', false), ('C', 'Se subastarán y el importe se ingresará en el Tesoro Público.', false), ('D', 'Se procederá a su incorporación al patrimonio de la Administración Pública correspondiente.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'De acuerdo con el artículo 29 de la Ley 19/2013, el acoso laboral cometido por un alto cargo constituye una infracción disciplinaria:', 'El art. 29.1.k) LT incluye el acoso laboral entre las infracciones muy graves.', 'age_aux_b1_07_transparencia', (select id from public.topics where slug = 'age-aux-b1-07-transparencia'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2013-12887'), 'Art. 29.1.k) LT', '1. Son infracciones muy graves: […] k) El acoso laboral.', null, '1190ab3ed3d695efa8649d0fd71c709cb4fcbb2cb979d91e684cc41bd86356cc', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '1190ab3ed3d695efa8649d0fd71c709cb4fcbb2cb979d91e684cc41bd86356cc')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Muy grave.', true), ('B', 'Grave.', false), ('C', 'Leve.', false), ('D', 'Grave o muy grave según el perjuicio causado.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 31.3 de la Ley 19/2013, cuando el presunto responsable de una infracción de buen gobierno sea un miembro del Gobierno o un alto cargo de la Administración General del Estado, la instrucción del procedimiento sancionador corresponderá a:', 'El art. 31.3 LT atribuye la instrucción a la Oficina de Conflictos de Intereses en los supuestos de las letras a) y b) del art. 31.2 (miembros del Gobierno, Secretarios de Estado y demás personal de la AGE).', 'age_aux_b1_07_transparencia', (select id from public.topics where slug = 'age-aux-b1-07-transparencia'), 3, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2013-12887'), 'Art. 31.3 LT', '3. En los supuestos previstos en las letras a) y b) del apartado anterior, la instrucción de los correspondientes procedimientos corresponderá a la Oficina de Conflictos de Intereses.', null, '4f8f57af06cf62829bd16577022379e9cb48ba79da4e0c63d6342b68c8af1ead', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '4f8f57af06cf62829bd16577022379e9cb48ba79da4e0c63d6342b68c8af1ead')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El Consejo de Transparencia y Buen Gobierno.', false), ('B', 'La Inspección General de Servicios del Ministerio correspondiente.', false), ('C', 'El Tribunal de Cuentas.', false), ('D', 'La Oficina de Conflictos de Intereses.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'De acuerdo con el artículo 33.2 de la Ley 19/2013, el Consejo de Transparencia y Buen Gobierno:', 'El art. 33.2 LT reconoce al Consejo personalidad jurídica propia, plena capacidad de obrar, autonomía y plena independencia.', 'age_aux_b1_07_transparencia', (select id from public.topics where slug = 'age-aux-b1-07-transparencia'), 1, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2013-12887'), 'Art. 33.2 LT', '2. El Consejo de Transparencia y Buen Gobierno tiene personalidad jurídica propia y plena capacidad de obrar. Actúa con autonomía y plena independencia en el cumplimiento de sus fines.', null, 'c0456811262ff4c75ae3928a1344df12dc7409e348df0638184f1811e3660a5a', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'c0456811262ff4c75ae3928a1344df12dc7409e348df0638184f1811e3660a5a')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Es un órgano sin personalidad jurídica integrado en el Ministerio de la Presidencia.', false), ('B', 'Es un órgano de las Cortes Generales dependiente de la Comisión Constitucional del Congreso.', false), ('C', 'Tiene personalidad jurídica propia y plena capacidad de obrar, y actúa con autonomía y plena independencia en el cumplimiento de sus fines.', true), ('D', 'Tiene personalidad jurídica propia, pero actúa bajo las instrucciones del Ministerio al que está adscrito.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 36.2 de la Ley 19/2013, ¿cuál de los siguientes forma parte de la Comisión de Transparencia y Buen Gobierno?', 'El art. 36.2 LT compone la Comisión con el Presidente, un Diputado, un Senador y un representante de cada uno de estos: Tribunal de Cuentas, Defensor del Pueblo, AEPD, Secretaría de Estado de Administraciones Públicas y AIReF. La FEMP solo puede ser convocada a la reunión anual del art. 36.4.', 'age_aux_b1_07_transparencia', (select id from public.topics where slug = 'age-aux-b1-07-transparencia'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2013-12887'), 'Art. 36.2 LT', 'h) Un representante de la Autoridad Independiente de Responsabilidad Fiscal.', null, '1f477664f032633bda2da75cb421e416d0e139577ce09f747339bb32091e0349', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '1f477664f032633bda2da75cb421e416d0e139577ce09f747339bb32091e0349')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Un representante de la Autoridad Independiente de Responsabilidad Fiscal.', true), ('B', 'Un representante del Consejo General del Poder Judicial.', false), ('C', 'Un representante de la Federación Española de Municipios y Provincias.', false), ('D', 'Un representante del Consejo de Estado.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'De acuerdo con la disposición adicional sexta de la Ley 19/2013, ¿qué órgano es competente para tramitar el procedimiento en el que se solicite el acceso a la información que obre en poder de la Casa de Su Majestad el Rey?', 'La DA 6.ª LT encomienda a la Secretaría General de la Presidencia del Gobierno la tramitación de las solicitudes de acceso a información de la Casa de Su Majestad el Rey.', 'age_aux_b1_07_transparencia', (select id from public.topics where slug = 'age-aux-b1-07-transparencia'), 3, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2013-12887'), 'DA 6.ª LT', 'La Secretaría General de la Presidencia del Gobierno será el órgano competente para tramitar el procedimiento mediante en el que se solicite el acceso a la información que obre en poder de la Casa de Su Majestad el Rey', null, '969306e5cdde7064794878bbc6b8fb402bbccda8ace3ddd3c4cee1dd82083e47', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '969306e5cdde7064794878bbc6b8fb402bbccda8ace3ddd3c4cee1dd82083e47')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'La Jefatura de la Casa de Su Majestad el Rey.', false), ('B', 'La Secretaría General de la Presidencia del Gobierno.', true), ('C', 'El Consejo de Transparencia y Buen Gobierno.', false), ('D', 'La Subsecretaría del Ministerio de la Presidencia.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
-- Lote age-aux-b1-08-age-lrjsp-v1 (20 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Ley 40/2015, de 1 de octubre, de Régimen Jurídico del Sector Público (texto consolidado, BOE)', 'https://www.boe.es/buscar/act.php?id=BOE-A-2015-10566', 'boe'::public.source_kind, 'Agencia Estatal Boletín Oficial del Estado', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('age-aux-b1-08-age', 'I.8 La Administración General del Estado') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('auxiliar-administrativo-estado') and t.slug = 'age-aux-b1-08-age' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 54.1 de la Ley 40/2015, además de los principios generales del artículo 3, la Administración General del Estado actúa y se organiza de acuerdo con los principios de:', 'El art. 54.1 LRJSP añade a los principios del art. 3 los de descentralización funcional y desconcentración funcional y territorial.', 'age_aux_b1_08_age', (select id from public.topics where slug = 'age-aux-b1-08-age'), 3, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2015-10566'), 'Art. 54.1 LRJSP', 'La Administración General del Estado actúa y se organiza de acuerdo con los principios establecidos en el artículo 3, así como los de descentralización funcional y desconcentración funcional y territorial.', null, 'f3ba2ef38d9735d14e1cfbe152e99fcde973440ebe815fa1cb3f33b6b07c4c8e', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'f3ba2ef38d9735d14e1cfbe152e99fcde973440ebe815fa1cb3f33b6b07c4c8e')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Centralización funcional y desconcentración territorial.', false), ('B', 'Descentralización territorial y delegación de firma.', false), ('C', 'Autonomía funcional y coordinación territorial.', false), ('D', 'Descentralización funcional y desconcentración funcional y territorial.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'De acuerdo con el artículo 55.1 de la Ley 40/2015, la organización de la Administración General del Estado responde a los principios de:', 'El art. 55.1 LRJSP fija como principios organizativos la división funcional en Departamentos ministeriales y la gestión territorial integrada en Delegaciones del Gobierno en las CCAA.', 'age_aux_b1_08_age', (select id from public.topics where slug = 'age-aux-b1-08-age'), 1, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2015-10566'), 'Art. 55.1 LRJSP', '1. La organización de la Administración General del Estado responde a los principios de división funcional en Departamentos ministeriales y de gestión territorial integrada en Delegaciones del Gobierno en las Comunidades Autónomas', null, '3b8f6b67c4be78c27377035e07e7f9bcefa47706793020221507bc782df030d0', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '3b8f6b67c4be78c27377035e07e7f9bcefa47706793020221507bc782df030d0')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'División territorial en provincias y gestión funcional en Organismos públicos.', false), ('B', 'División funcional en Departamentos ministeriales y gestión territorial integrada en Delegaciones del Gobierno en las Comunidades Autónomas.', true), ('C', 'Jerarquía ministerial y gestión territorial a través de las Diputaciones Provinciales.', false), ('D', 'División funcional en Secretarías de Estado y gestión territorial en Subdelegaciones del Gobierno.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 55.9 de la Ley 40/2015, establecer los planes de actuación de la organización situada bajo su responsabilidad corresponde:', 'El art. 55.9 LRJSP reparte las funciones: los órganos superiores establecen los planes de actuación y los directivos los desarrollan y ejecutan.', 'age_aux_b1_08_age', (select id from public.topics where slug = 'age-aux-b1-08-age'), 1, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2015-10566'), 'Art. 55.9 LRJSP', '9. Corresponde a los órganos superiores establecer los planes de actuación de la organización situada bajo su responsabilidad y a los órganos directivos su desarrollo y ejecución.', null, '35fe2af13293ce9f136a3faed293ae9eb164b6ad70211c9b6e31a13e583e9ff4', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '35fe2af13293ce9f136a3faed293ae9eb164b6ad70211c9b6e31a13e583e9ff4')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'A los órganos superiores, y su desarrollo y ejecución, a los órganos directivos.', true), ('B', 'A los órganos directivos, y su aprobación, a los órganos superiores.', false), ('C', 'Al Consejo de Ministros, y su ejecución, a los Subsecretarios.', false), ('D', 'A los Subdirectores generales, bajo la supervisión del Director general.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'De acuerdo con el artículo 55 bis de la Ley 40/2015, en los nombramientos de titulares de Secretarías de Estado y órganos directivos de la Administración General del Estado, en el ámbito de cada departamento ministerial, las personas de cada sexo:', 'El art. 55 bis LRJSP impone la representación equilibrada: cada sexo entre el 40 % y el 60 % en cada departamento ministerial.', 'age_aux_b1_08_age', (select id from public.topics where slug = 'age-aux-b1-08-age'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2015-10566'), 'Art. 55 bis LRJSP', 'de tal manera que las personas de cada sexo no superen el sesenta por ciento ni sean menos del cuarenta por ciento en el ámbito de cada departamento ministerial.', null, '30584e7a03998da7596ecdc888ee6d3beadb62faeab0c5d97f4adaac1f284d87', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '30584e7a03998da7596ecdc888ee6d3beadb62faeab0c5d97f4adaac1f284d87')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'No superarán el setenta por ciento ni serán menos del treinta por ciento.', false), ('B', 'Deberán representar exactamente el cincuenta por ciento.', false), ('C', 'No superarán el sesenta por ciento ni serán menos del cuarenta por ciento.', true), ('D', 'No serán menos del veinticinco por ciento.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 56.1 de la Ley 40/2015, ¿qué son los elementos organizativos básicos de las estructuras orgánicas?', 'El art. 56.1 LRJSP define las unidades administrativas como los elementos organizativos básicos, que comprenden puestos de trabajo vinculados funcionalmente y orgánicamente por una jefatura común.', 'age_aux_b1_08_age', (select id from public.topics where slug = 'age-aux-b1-08-age'), 1, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2015-10566'), 'Art. 56.1 LRJSP', '1. Las unidades administrativas son los elementos organizativos básicos de las estructuras orgánicas.', null, '292bd375f43f13667a334bab4bb8542d5295246d291e54f6cd78ec47101972cc', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '292bd375f43f13667a334bab4bb8542d5295246d291e54f6cd78ec47101972cc')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Las Subdirecciones Generales.', false), ('B', 'Las unidades administrativas.', true), ('C', 'Los puestos de trabajo de libre designación.', false), ('D', 'Los órganos colegiados.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'De acuerdo con el artículo 59.3 de la Ley 40/2015, las unidades que no tengan la consideración de órganos se crean, modifican y suprimen:', 'El art. 59.3 LRJSP remite a las relaciones de puestos de trabajo para crear, modificar y suprimir las unidades que no son órganos (los órganos inferiores a Subdirección General van por orden ministerial, art. 59.2).', 'age_aux_b1_08_age', (select id from public.topics where slug = 'age-aux-b1-08-age'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2015-10566'), 'Art. 59.3 LRJSP', '3. Las unidades que no tengan la consideración de órganos se crean, modifican y suprimen a través de las relaciones de puestos de trabajo.', null, '35442cbae129bdec40bdacb893dc278a81d126f4ee40a6c4b06b1a8a7e1d20e1', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '35442cbae129bdec40bdacb893dc278a81d126f4ee40a6c4b06b1a8a7e1d20e1')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Por orden del Ministro respectivo.', false), ('B', 'Por Real Decreto del Consejo de Ministros.', false), ('C', 'A través de las relaciones de puestos de trabajo.', true), ('D', 'Por resolución del Subsecretario del Departamento.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 60.1 de la Ley 40/2015, los Ministros son los jefes superiores del Departamento y superiores jerárquicos directos de:', 'El art. 60.1 LRJSP declara a los Ministros superiores jerárquicos directos de los Secretarios de Estado y de los Subsecretarios.', 'age_aux_b1_08_age', (select id from public.topics where slug = 'age-aux-b1-08-age'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2015-10566'), 'Art. 60.1 LRJSP', '1. Los Ministros son los jefes superiores del Departamento y superiores jerárquicos directos de los Secretarios de Estado y Subsecretarios.', null, '11fe5593acfae3a428c749f8ff8d49870b4c9b8a1d28b77db9333e7a060f654b', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '11fe5593acfae3a428c749f8ff8d49870b4c9b8a1d28b77db9333e7a060f654b')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Los Secretarios de Estado y Directores generales.', false), ('B', 'Los Subsecretarios y Secretarios generales técnicos.', false), ('C', 'Todos los órganos directivos del Ministerio sin excepción.', false), ('D', 'Los Secretarios de Estado y Subsecretarios.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'De acuerdo con el artículo 61 de la Ley 40/2015, ¿a qué órgano corresponde ejercer la potestad reglamentaria en las materias propias de su Departamento?', 'El art. 61.a) LRJSP atribuye a los Ministros el ejercicio de la potestad reglamentaria en las materias propias de su Departamento.', 'age_aux_b1_08_age', (select id from public.topics where slug = 'age-aux-b1-08-age'), 1, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2015-10566'), 'Art. 61.a) LRJSP', 'a) Ejercer la potestad reglamentaria en las materias propias de su Departamento.', null, 'e86cdc152d77c8250f893a2dd6db1b1f7c236a6527db87a0f14fe92a8f5c79f6', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'e86cdc152d77c8250f893a2dd6db1b1f7c236a6527db87a0f14fe92a8f5c79f6')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Al Ministro.', true), ('B', 'Al Subsecretario.', false), ('C', 'Al Secretario general técnico.', false), ('D', 'Al Secretario de Estado.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 62.2 de la Ley 40/2015, corresponde a los Secretarios de Estado:', 'El art. 62.2.c) LRJSP atribuye a los Secretarios de Estado el nombramiento y separación de los Subdirectores Generales de su Secretaría de Estado; los Directores generales se nombran por Real Decreto del Consejo de Ministros (art. 66.2).', 'age_aux_b1_08_age', (select id from public.topics where slug = 'age-aux-b1-08-age'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2015-10566'), 'Art. 62.2.c) LRJSP', 'c) Nombrar y separar a los Subdirectores Generales de la Secretaría de Estado.', null, 'ef1da3336678095a2a08098b7832cbe245d5cc08f0edb2ac0347e481d235ae93', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'ef1da3336678095a2a08098b7832cbe245d5cc08f0edb2ac0347e481d235ae93')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Nombrar y separar a los Subdirectores Generales de la Secretaría de Estado.', true), ('B', 'Nombrar y separar a los Directores generales de la Secretaría de Estado.', false), ('C', 'Desempeñar la jefatura superior de todo el personal del Departamento.', false), ('D', 'Imponer la sanción de separación del servicio por faltas muy graves.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'De acuerdo con el artículo 63.1 de la Ley 40/2015, ¿qué órgano desempeña la jefatura superior de todo el personal del Departamento?', 'El art. 63.1.f) LRJSP atribuye al Subsecretario la jefatura superior de todo el personal del Departamento.', 'age_aux_b1_08_age', (select id from public.topics where slug = 'age-aux-b1-08-age'), 1, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2015-10566'), 'Art. 63.1.f) LRJSP', 'f) Desempeñar la jefatura superior de todo el personal del Departamento.', null, '7b9d428e473178d98a2ca3d410a6dd33a4232595948a838dee674eafcb38e24b', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '7b9d428e473178d98a2ca3d410a6dd33a4232595948a838dee674eafcb38e24b')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El Ministro.', false), ('B', 'El Secretario general técnico.', false), ('C', 'El Subsecretario.', true), ('D', 'El Director general de Personal del Ministerio.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 63.1 de la Ley 40/2015, el Subsecretario ejerce la potestad disciplinaria del personal del Departamento:', 'El art. 63.1.ñ) LRJSP le atribuye la potestad disciplinaria por faltas graves o muy graves, salvo la separación del servicio, que corresponde al Ministro (art. 61.s).', 'age_aux_b1_08_age', (select id from public.topics where slug = 'age-aux-b1-08-age'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2015-10566'), 'Art. 63.1.ñ) LRJSP', 'ñ) Ejercer la potestad disciplinaria del personal del Departamento por faltas graves o muy graves, salvo la separación del servicio.', null, '1b36d8dbedeaf36bb646d2beb510fb35510f9fb07af222154aff0657eb9c8268', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '1b36d8dbedeaf36bb646d2beb510fb35510f9fb07af222154aff0657eb9c8268')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Únicamente por faltas leves.', false), ('B', 'Por cualquier falta, incluida la separación del servicio.', false), ('C', 'Por faltas muy graves, siempre previa autorización del Ministro.', false), ('D', 'Por faltas graves o muy graves, salvo la separación del servicio.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'De acuerdo con el artículo 64.3 de la Ley 40/2015, los nombramientos de los Secretarios generales habrán de efectuarse:', 'El art. 64.3 LRJSP no exige la condición de funcionario a los Secretarios generales: basta la cualificación y experiencia en puestos de responsabilidad en la gestión pública o privada, más los requisitos de idoneidad de la Ley 3/2015.', 'age_aux_b1_08_age', (select id from public.topics where slug = 'age-aux-b1-08-age'), 3, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2015-10566'), 'Art. 64.3 LRJSP', 'Los nombramientos habrán de efectuarse entre personas con cualificación y experiencia en el desempeño de puestos de responsabilidad en la gestión pública o privada.', null, 'e0863bfa4825e30f461496af3795d1424ce17dcb9213c18ba27f5c0fc962d477', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'e0863bfa4825e30f461496af3795d1424ce17dcb9213c18ba27f5c0fc962d477')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Entre funcionarios de carrera pertenecientes al Subgrupo A1, sin excepción.', false), ('B', 'Entre personas con cualificación y experiencia en el desempeño de puestos de responsabilidad en la gestión pública o privada.', true), ('C', 'Entre funcionarios de carrera del Estado con al menos diez años de servicio.', false), ('D', 'Entre altos cargos que hayan desempeñado previamente el puesto de Director general.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 66.2 de la Ley 40/2015, el titular de una Dirección General podrá no reunir la condición de funcionario de carrera del Subgrupo A1 cuando:', 'El art. 66.2 LRJSP admite la excepción si el Real Decreto de estructura lo permite por las características específicas de las funciones, con memoria razonada que la justifique.', 'age_aux_b1_08_age', (select id from public.topics where slug = 'age-aux-b1-08-age'), 3, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2015-10566'), 'Art. 66.2 LRJSP', 'salvo que el Real Decreto de estructura permita que, en atención a las características específicas de las funciones de la Dirección General, su titular no reúna dicha condición de funcionario, debiendo motivarse mediante memoria razonada la concurrencia de las especiales características que justifiquen esa circunstancia excepcional.', null, '60bc575ec950ae59acae63a9017e9f9a222ccb2b42797e1d8549085928ab74e5', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '60bc575ec950ae59acae63a9017e9f9a222ccb2b42797e1d8549085928ab74e5')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Lo acuerde el Ministro mediante orden ministerial, previo informe de la Subsecretaría.', false), ('B', 'Se trate de una Dirección General con sede fuera de Madrid.', false), ('C', 'Lo autorice la Comisión correspondiente del Congreso de los Diputados.', false), ('D', 'El Real Decreto de estructura lo permita en atención a las características específicas de sus funciones, motivándolo mediante memoria razonada.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'De acuerdo con el artículo 69.4 de la Ley 40/2015, en las Comunidades Autónomas uniprovinciales:', 'El art. 69.4 LRJSP prevé Subdelegados en cada provincia de las CCAA pluriprovinciales y permite crear por Real Decreto Subdelegaciones en las uniprovinciales si las circunstancias lo justifican.', 'age_aux_b1_08_age', (select id from public.topics where slug = 'age-aux-b1-08-age'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2015-10566'), 'Art. 69.4 LRJSP', 'Podrán crearse por Real Decreto Subdelegaciones del Gobierno en las Comunidades Autónomas uniprovinciales, cuando circunstancias tales como la población del territorio, el volumen de gestión o sus singularidades geográficas, sociales o económicas así lo justifiquen.', null, '426b23a41e3413b505c1fabc151bea7213a51ac0ed26720a646d366c3c55030b', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '426b23a41e3413b505c1fabc151bea7213a51ac0ed26720a646d366c3c55030b')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Existirá siempre un Subdelegado del Gobierno, además del Delegado.', false), ('B', 'Podrán crearse por Real Decreto Subdelegaciones del Gobierno cuando lo justifiquen circunstancias como la población, el volumen de gestión o sus singularidades geográficas, sociales o económicas.', true), ('C', 'No podrán existir en ningún caso Subdelegaciones del Gobierno.', false), ('D', 'Las Subdelegaciones del Gobierno se crean por orden del Ministro del Interior.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 70 de la Ley 40/2015, los Directores Insulares de la Administración General del Estado son nombrados:', 'El art. 70 LRJSP atribuye su nombramiento al Delegado del Gobierno por libre designación entre funcionarios de carrera de cuerpos o escalas del Subgrupo A1.', 'age_aux_b1_08_age', (select id from public.topics where slug = 'age-aux-b1-08-age'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2015-10566'), 'Art. 70 LRJSP', 'Serán nombrados por el Delegado del Gobierno mediante el procedimiento de libre designación entre funcionarios de carrera del Estado, de las Comunidades Autónomas o de las Entidades Locales, pertenecientes a Cuerpos o Escalas clasificados como Subgrupo A1.', null, '3e4fb45131ec07ffb3bd72603d95c87312158b31abbb5170b3af39cb9c6f1cd3', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '3e4fb45131ec07ffb3bd72603d95c87312158b31abbb5170b3af39cb9c6f1cd3')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Por el Delegado del Gobierno, mediante libre designación entre funcionarios de carrera del Subgrupo A1.', true), ('B', 'Por el Subdelegado del Gobierno en la provincia, mediante concurso de méritos.', false), ('C', 'Por Real Decreto del Consejo de Ministros, a propuesta del Presidente del Gobierno.', false), ('D', 'Por el Cabildo o Consejo Insular correspondiente.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'De acuerdo con el artículo 72.5 de la Ley 40/2015, en caso de ausencia, vacante o enfermedad del Delegado del Gobierno en una Comunidad Autónoma uniprovincial en la que no exista Subdelegado, la suplencia corresponderá:', 'El art. 72.5 LRJSP establece que supla el Subdelegado que designe el Delegado (en su defecto, el de la provincia sede); en las uniprovinciales sin Subdelegado, el Secretario General.', 'age_aux_b1_08_age', (select id from public.topics where slug = 'age-aux-b1-08-age'), 3, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2015-10566'), 'Art. 72.5 LRJSP', 'En las Comunidades Autónomas uniprovinciales en las que no exista Subdelegado la suplencia corresponderá al Secretario General.', null, '6181d8fed169ccd5dcd6f9fa3e772fb607975b74d71b5371f9b5862c2aa8339b', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '6181d8fed169ccd5dcd6f9fa3e772fb607975b74d71b5371f9b5862c2aa8339b')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Al Delegado del Gobierno de la Comunidad Autónoma limítrofe.', false), ('B', 'Al Subsecretario del Ministerio al que está adscrita la Delegación.', false), ('C', 'Al Secretario General.', true), ('D', 'Al Jefe de las Fuerzas y Cuerpos de Seguridad del Estado en la Comunidad.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 73.3 de la Ley 40/2015, la jefatura de las Fuerzas y Cuerpos de Seguridad del Estado en la Comunidad Autónoma corresponde al Delegado del Gobierno, que ejercerá las competencias del Estado en esta materia:', 'El art. 73.3 LRJSP atribuye al Delegado la jefatura de las FCSE en su territorio, bajo la dependencia funcional del Ministerio del Interior.', 'age_aux_b1_08_age', (select id from public.topics where slug = 'age-aux-b1-08-age'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2015-10566'), 'Art. 73.3 LRJSP', 'cuya jefatura corresponderá al Delegado del Gobierno, quien ejercerá las competencias del Estado en esta materia bajo la dependencia funcional del Ministerio del Interior.', null, '27042333434ea80cc18aeb68fd94a973b8e37e2a5794b4129698a54fc1cc2702', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '27042333434ea80cc18aeb68fd94a973b8e37e2a5794b4129698a54fc1cc2702')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Bajo la dependencia funcional del Ministerio del Interior.', true), ('B', 'Bajo la dependencia orgánica del Ministerio de Defensa.', false), ('C', 'Con plena independencia de cualquier Ministerio.', false), ('D', 'Bajo la dependencia funcional del Consejo de Gobierno de la Comunidad Autónoma.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'De acuerdo con el artículo 75 de la Ley 40/2015, ¿a quién corresponde dirigir y coordinar la protección civil en el ámbito de la provincia?', 'El art. 75.c) LRJSP atribuye a los Subdelegados del Gobierno dirigir y coordinar la protección civil en la provincia.', 'age_aux_b1_08_age', (select id from public.topics where slug = 'age-aux-b1-08-age'), 1, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2015-10566'), 'Art. 75.c) LRJSP', 'c) Dirigir y coordinar la protección civil en el ámbito de la provincia.', null, 'd54de61d58d837cda347e24e20d4ee900b83b7d76acc492ca7a34d345d6e80c2', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'd54de61d58d837cda347e24e20d4ee900b83b7d76acc492ca7a34d345d6e80c2')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Al Delegado del Gobierno en la Comunidad Autónoma.', false), ('B', 'Al Subdelegado del Gobierno.', true), ('C', 'Al Director Insular.', false), ('D', 'Al Presidente de la Diputación Provincial.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 77 de la Ley 40/2015, la asistencia jurídica y las funciones de intervención y control económico financiero en relación con las Delegaciones y Subdelegaciones del Gobierno se ejercerán, respectivamente, por:', 'El art. 77 LRJSP encomienda la asistencia jurídica a la Abogacía del Estado y la intervención y control económico financiero a la IGAE.', 'age_aux_b1_08_age', (select id from public.topics where slug = 'age-aux-b1-08-age'), 3, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2015-10566'), 'Art. 77 LRJSP', 'se ejercerán por la Abogacía del Estado y la Intervención General de la Administración del Estado respectivamente, de acuerdo con su normativa específica.', null, 'd64b3b9cb620e85c2763299b2594086fee37484b3fc17e673361425003c24471', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'd64b3b9cb620e85c2763299b2594086fee37484b3fc17e673361425003c24471')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'La Secretaría General de la Delegación y el Tribunal de Cuentas.', false), ('B', 'La Secretaría General Técnica del Ministerio y la Intervención General de la Administración del Estado.', false), ('C', 'La Abogacía del Estado y la Intervención General de la Administración del Estado.', true), ('D', 'El Consejo de Estado y el Tribunal de Cuentas.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'De acuerdo con el artículo 79.1 de la Ley 40/2015, en cada Comunidad Autónoma pluriprovincial existirá una Comisión territorial de asistencia al Delegado del Gobierno:', 'El art. 79.1.a) LRJSP dispone que la Comisión territorial está presidida por el Delegado del Gobierno e integrada por los Subdelegados de las provincias de la Comunidad.', 'age_aux_b1_08_age', (select id from public.topics where slug = 'age-aux-b1-08-age'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2015-10566'), 'Art. 79.1 LRJSP', 'a) Estará presidida por el Delegado del Gobierno en la Comunidad Autónoma e integrada por los Subdelegados del Gobierno en las provincias comprendidas en el territorio de ésta.', null, 'e57c7f9ee47f7c55767b7711c76836667bf9b64ff729ab17511b78ed2c183edc', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'e57c7f9ee47f7c55767b7711c76836667bf9b64ff729ab17511b78ed2c183edc')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Presidida por el Presidente de la Comunidad Autónoma e integrada por los Delegados y Subdelegados del Gobierno.', false), ('B', 'Presidida por el Secretario General de la Delegación e integrada por los titulares de los servicios no integrados.', false), ('C', 'Presidida por el Ministro competente e integrada por los Delegados del Gobierno de todas las Comunidades.', false), ('D', 'Presidida por el Delegado del Gobierno e integrada por los Subdelegados del Gobierno en las provincias de su territorio.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
-- Lote age-aux-b1-09-organizacion-territorial-ce-v1 (13 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Constitución Española (texto consolidado, BOE)', 'https://www.boe.es/buscar/act.php?id=BOE-A-1978-31229', 'boe'::public.source_kind, 'Agencia Estatal Boletín Oficial del Estado', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('age-aux-b1-09-organizacion-territorial', 'I.9 La organización territorial del Estado') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('auxiliar-administrativo-estado') and t.slug = 'age-aux-b1-09-organizacion-territorial' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 138.2 de la Constitución Española, las diferencias entre los Estatutos de las distintas Comunidades Autónomas:', 'El art. 138.2 CE prohíbe que las diferencias estatutarias impliquen privilegios económicos o sociales.', 'age_aux_b1_09_organizacion_territorial', (select id from public.topics where slug = 'age-aux-b1-09-organizacion-territorial'), 1, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1978-31229'), 'Art. 138.2 CE', '2. Las diferencias entre los Estatutos de las distintas Comunidades Autónomas no podrán implicar, en ningún caso, privilegios económicos o sociales.', null, '519881b559b4ad099ae7feb1e3997de0ea7f1a1830c9b5e325013fc1a30689b8', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '519881b559b4ad099ae7feb1e3997de0ea7f1a1830c9b5e325013fc1a30689b8')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Podrán implicar privilegios económicos si los autorizan las Cortes Generales por ley orgánica.', false), ('B', 'Deberán ser aprobadas por el Senado por mayoría absoluta.', false), ('C', 'No podrán implicar, en ningún caso, privilegios económicos o sociales.', true), ('D', 'Solo podrán afectar a las competencias asumidas en virtud del artículo 148.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'De acuerdo con el artículo 140 de la Constitución, los Alcaldes serán elegidos:', 'El art. 140 CE dispone que los Concejales son elegidos por los vecinos y los Alcaldes por los Concejales o por los vecinos.', 'age_aux_b1_09_organizacion_territorial', (select id from public.topics where slug = 'age-aux-b1-09-organizacion-territorial'), 1, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1978-31229'), 'Art. 140 CE', 'Los Alcaldes serán elegidos por los Concejales o por los vecinos.', null, '35bf258a08455e3a1f70955a2956aa28d04f7d766a857b793adff588329f20be', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '35bf258a08455e3a1f70955a2956aa28d04f7d766a857b793adff588329f20be')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Únicamente por los vecinos, mediante sufragio universal directo.', false), ('B', 'Por los Concejales o por los vecinos.', true), ('C', 'Por el Pleno de la Diputación Provincial.', false), ('D', 'Por el Consejo de Gobierno de la Comunidad Autónoma, a propuesta de los Concejales.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 142 de la Constitución, las Haciendas locales se nutrirán fundamentalmente de:', 'El art. 142 CE exige medios suficientes a las Haciendas locales, que se nutrirán fundamentalmente de tributos propios y de la participación en los del Estado y las CCAA.', 'age_aux_b1_09_organizacion_territorial', (select id from public.topics where slug = 'age-aux-b1-09-organizacion-territorial'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1978-31229'), 'Art. 142 CE', 'y se nutrirán fundamentalmente de tributos propios y de participación en los del Estado y de las Comunidades Autónomas.', null, 'cfdb652d4e07b1c37c002517e7e69c41bf0fc9c624bd98ebc10802bc55bfd1d5', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'cfdb652d4e07b1c37c002517e7e69c41bf0fc9c624bd98ebc10802bc55bfd1d5')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Transferencias del Fondo de Compensación Interterritorial.', false), ('B', 'Las rentas de su patrimonio y del producto de operaciones de crédito.', false), ('C', 'Las asignaciones que fijen anualmente los Presupuestos de cada Comunidad Autónoma.', false), ('D', 'Tributos propios y de participación en los del Estado y de las Comunidades Autónomas.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'De acuerdo con el artículo 143.2 de la Constitución, los requisitos de la iniciativa del proceso autonómico deberán cumplirse en el plazo de:', 'El art. 143.2 CE fija un plazo de seis meses desde el primer acuerdo de alguna Corporación local interesada (el de cinco años del art. 143.3 es para reiterar la iniciativa fallida).', 'age_aux_b1_09_organizacion_territorial', (select id from public.topics where slug = 'age-aux-b1-09-organizacion-territorial'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1978-31229'), 'Art. 143.2 CE', 'Estos requisitos deberán ser cumplidos en el plazo de seis meses desde el primer acuerdo adoptado al respecto por alguna de las Corporaciones locales interesadas.', null, 'de5cafd715a9d82144cb0c955463b5bbc81c3d9e895b14d5f0536bbc8bbf368c', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'de5cafd715a9d82144cb0c955463b5bbc81c3d9e895b14d5f0536bbc8bbf368c')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Seis meses desde el primer acuerdo adoptado al respecto por alguna de las Corporaciones locales interesadas.', true), ('B', 'Un año desde el primer acuerdo adoptado por alguna de las Corporaciones locales interesadas.', false), ('C', 'Tres meses desde la publicación del primer acuerdo en el boletín oficial de la provincia.', false), ('D', 'Cinco años desde la entrada en vigor de la Constitución.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 144 de la Constitución, las Cortes Generales, mediante ley orgánica y por motivos de interés nacional, podrán:', 'El art. 144 CE permite a las Cortes, por ley orgánica y por interés nacional, autorizar una comunidad uniprovincial sin las condiciones del art. 143.1, autorizar o acordar Estatutos para territorios no integrados en la organización provincial y sustituir la iniciativa de las Corporaciones locales. La federación está prohibida (art. 145.1).', 'age_aux_b1_09_organizacion_territorial', (select id from public.topics where slug = 'age-aux-b1-09-organizacion-territorial'), 3, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1978-31229'), 'Art. 144.a) CE', 'a) Autorizar la constitución de una comunidad autónoma cuando su ámbito territorial no supere el de una provincia y no reúna las condiciones del apartado 1 del artículo 143.', null, '2b442faacc930938c931046789bfe718e04260218c0f4cf71516b06017780180', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '2b442faacc930938c931046789bfe718e04260218c0f4cf71516b06017780180')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Autorizar la federación de dos o más Comunidades Autónomas limítrofes.', false), ('B', 'Suprimir una Comunidad Autónoma que no haya ejercido sus competencias durante cinco años.', false), ('C', 'Modificar los Estatutos de Autonomía sin necesidad de seguir el procedimiento en ellos establecido.', false), ('D', 'Autorizar la constitución de una comunidad autónoma cuando su ámbito territorial no supere el de una provincia y no reúna las condiciones del apartado 1 del artículo 143.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'De acuerdo con el artículo 146 de la Constitución, el proyecto de Estatuto será elaborado por una asamblea compuesta por:', 'El art. 146 CE atribuye la elaboración del proyecto de Estatuto a una asamblea de miembros de la Diputación u órgano interinsular y de los Diputados y Senadores elegidos en esas provincias; después se eleva a las Cortes para su tramitación como ley.', 'age_aux_b1_09_organizacion_territorial', (select id from public.topics where slug = 'age-aux-b1-09-organizacion-territorial'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1978-31229'), 'Art. 146 CE', 'El proyecto de Estatuto será elaborado por una asamblea compuesta por los miembros de la Diputación u órgano interinsular de las provincias afectadas y por los Diputados y Senadores elegidos en ellas', null, 'e8f96cfee25532d70d376de88ecf6102cb44e33899235221d38f1206f3cf5183', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'e8f96cfee25532d70d376de88ecf6102cb44e33899235221d38f1206f3cf5183')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Los Alcaldes de todos los municipios de las provincias afectadas.', false), ('B', 'Los miembros de la Diputación u órgano interinsular de las provincias afectadas y por los Diputados y Senadores elegidos en ellas.', true), ('C', 'Los Diputados y Senadores elegidos en las provincias afectadas, exclusivamente.', false), ('D', 'Los miembros de la Comisión Constitucional del Congreso y una delegación de las Diputaciones afectadas.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 147.3 de la Constitución, la reforma de los Estatutos de Autonomía se ajustará al procedimiento establecido en los mismos y requerirá, en todo caso:', 'El art. 147.3 CE exige siempre la aprobación de la reforma estatutaria por las Cortes Generales mediante ley orgánica.', 'age_aux_b1_09_organizacion_territorial', (select id from public.topics where slug = 'age-aux-b1-09-organizacion-territorial'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1978-31229'), 'Art. 147.3 CE', '3. La reforma de los Estatutos se ajustará al procedimiento establecido en los mismos y requerirá, en todo caso, la aprobación por las Cortes Generales, mediante ley orgánica.', null, 'e3b5430f1c20bc313710879365a2cf6e28200c10243b393064147a0e3954e84e', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'e3b5430f1c20bc313710879365a2cf6e28200c10243b393064147a0e3954e84e')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'La aprobación por el Senado por mayoría de tres quintos.', false), ('B', 'El dictamen previo y vinculante del Tribunal Constitucional.', false), ('C', 'La aprobación por las Cortes Generales, mediante ley orgánica.', true), ('D', 'La ratificación por referéndum de ámbito nacional.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'De acuerdo con el artículo 151.1 de la Constitución, no será preciso dejar transcurrir el plazo de cinco años del artículo 148.2 cuando la iniciativa autonómica sea acordada, además de por las Diputaciones u órganos interinsulares, por:', 'La vía del art. 151.1 CE exige la iniciativa de las tres cuartas partes de los municipios de cada provincia (mayoría del censo de cada una) y su ratificación en referéndum por el voto afirmativo de la mayoría absoluta de los electores de cada provincia.', 'age_aux_b1_09_organizacion_territorial', (select id from public.topics where slug = 'age-aux-b1-09-organizacion-territorial'), 3, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1978-31229'), 'Art. 151.1 CE', 'por las tres cuartas partes de los municipios de cada una de las provincias afectadas que representen, al menos, la mayoría del censo electoral de cada una de ellas y dicha iniciativa sea ratificada mediante referéndum por el voto afirmativo de la mayoría absoluta de los electores de cada provincia', null, '59245b167d7cd3c4c556183055c9be0f5f9e779b5f8b9440b44d9df021abe53f', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '59245b167d7cd3c4c556183055c9be0f5f9e779b5f8b9440b44d9df021abe53f')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Las tres cuartas partes de los municipios de cada provincia afectada que representen al menos la mayoría del censo electoral de cada una, con ratificación en referéndum por la mayoría absoluta de los electores de cada provincia.', true), ('B', 'Las dos terceras partes de los municipios de cada provincia afectada, con ratificación en referéndum por la mayoría simple de los votos emitidos.', false), ('C', 'Las tres cuartas partes de los municipios de cada provincia afectada, sin necesidad de referéndum.', false), ('D', 'La mayoría absoluta de los municipios de cada provincia afectada, con ratificación por las Cortes Generales.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 151.2 de la Constitución, aprobado el proyecto de Estatuto por la Asamblea de Parlamentarios, se remitirá a la Comisión Constitucional del Congreso, que lo examinará con una delegación de la Asamblea proponente dentro del plazo de:', 'El art. 151.2.2.º CE fija un plazo de dos meses para que la Comisión Constitucional del Congreso examine el proyecto con la delegación de la Asamblea proponente.', 'age_aux_b1_09_organizacion_territorial', (select id from public.topics where slug = 'age-aux-b1-09-organizacion-territorial'), 3, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1978-31229'), 'Art. 151.2.2.º CE', 'se remitirá a la Comisión Constitucional del Congreso, la cual, dentro del plazo de dos meses, lo examinará con el concurso y asistencia de una delegación de la Asamblea proponente', null, 'a31d47a0b94582b2786ea4183a21512538c8e91e3a936cbd9e59694bc16bea7a', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'a31d47a0b94582b2786ea4183a21512538c8e91e3a936cbd9e59694bc16bea7a')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Un mes.', false), ('B', 'Tres meses.', false), ('C', 'Seis meses.', false), ('D', 'Dos meses.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'De acuerdo con el artículo 152.1 de la Constitución, ¿qué órgano culminará la organización judicial en el ámbito territorial de la Comunidad Autónoma, sin perjuicio de la jurisdicción del Tribunal Supremo?', 'El art. 152.1, párrafo segundo, CE atribuye a un Tribunal Superior de Justicia culminar la organización judicial en el territorio de la Comunidad Autónoma.', 'age_aux_b1_09_organizacion_territorial', (select id from public.topics where slug = 'age-aux-b1-09-organizacion-territorial'), 1, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1978-31229'), 'Art. 152.1 CE', 'Un Tribunal Superior de Justicia, sin perjuicio de la jurisdicción que corresponde al Tribunal Supremo, culminará la organización judicial en el ámbito territorial de la Comunidad Autónoma.', null, '2bfee1d3aeec52458903d062dae7197bbb3aad178458f9ab95724fafa5e899f1', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '2bfee1d3aeec52458903d062dae7197bbb3aad178458f9ab95724fafa5e899f1')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'La Audiencia Nacional.', false), ('B', 'Una Audiencia Provincial con sede en la capital de la Comunidad.', false), ('C', 'Un Tribunal Superior de Justicia.', true), ('D', 'El Consejo de Gobierno de la Comunidad Autónoma.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 153 de la Constitución, el control de la actividad de los órganos de las Comunidades Autónomas en el ejercicio de funciones delegadas conforme al artículo 150.2 se ejercerá:', 'El art. 153.b) CE atribuye ese control al Gobierno, previo dictamen del Consejo de Estado; el TC controla las normas con fuerza de ley, la jurisdicción contencioso-administrativa la administración autónoma y el Tribunal de Cuentas lo económico y presupuestario.', 'age_aux_b1_09_organizacion_territorial', (select id from public.topics where slug = 'age-aux-b1-09-organizacion-territorial'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1978-31229'), 'Art. 153.b) CE', 'b) Por el Gobierno, previo dictamen del Consejo de Estado, el del ejercicio de funciones delegadas a que se refiere el apartado 2 del artículo 150.', null, 'fe1dc5f003d8bb69ccf061be01adb3566ebded1696f0d02b09e6d351c908041b', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'fe1dc5f003d8bb69ccf061be01adb3566ebded1696f0d02b09e6d351c908041b')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Por el Gobierno, previo dictamen del Consejo de Estado.', true), ('B', 'Por el Tribunal Constitucional.', false), ('C', 'Por la jurisdicción contencioso-administrativa.', false), ('D', 'Por el Tribunal de Cuentas.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'De acuerdo con el artículo 154 de la Constitución, ¿quién dirigirá la Administración del Estado en el territorio de la Comunidad Autónoma?', 'El art. 154 CE prevé un Delegado nombrado por el Gobierno que dirige la Administración del Estado en el territorio de la Comunidad y la coordina, cuando proceda, con la administración autonómica.', 'age_aux_b1_09_organizacion_territorial', (select id from public.topics where slug = 'age-aux-b1-09-organizacion-territorial'), 1, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1978-31229'), 'Art. 154 CE', 'Un Delegado nombrado por el Gobierno dirigirá la Administración del Estado en el territorio de la Comunidad Autónoma', null, '723b428a1825f6aeaf8a6d496b035ae5cd83ae50e24306d488a23d73d568aed2', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '723b428a1825f6aeaf8a6d496b035ae5cd83ae50e24306d488a23d73d568aed2')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El Presidente de la Comunidad Autónoma, como representante ordinario del Estado.', false), ('B', 'Un Delegado nombrado por el Gobierno.', true), ('C', 'Un Delegado elegido por la Asamblea Legislativa de la Comunidad.', false), ('D', 'Un Subsecretario designado por el Ministro de la Presidencia.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 158.2 de la Constitución, el Fondo de Compensación, constituido para corregir desequilibrios económicos interterritoriales, tendrá como destino:', 'El art. 158.2 CE destina el Fondo de Compensación a gastos de inversión, con recursos distribuidos por las Cortes Generales entre CCAA y, en su caso, provincias.', 'age_aux_b1_09_organizacion_territorial', (select id from public.topics where slug = 'age-aux-b1-09-organizacion-territorial'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1978-31229'), 'Art. 158.2 CE', 'se constituirá un Fondo de Compensación con destino a gastos de inversión, cuyos recursos serán distribuidos por las Cortes Generales entre las Comunidades Autónomas y provincias, en su caso.', null, '53ed97788b04da1ce70aa0f12642c743ab2b6388ce986a284145ac7691d6f0ab', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '53ed97788b04da1ce70aa0f12642c743ab2b6388ce986a284145ac7691d6f0ab')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Gastos de inversión, y sus recursos serán distribuidos por las Cortes Generales entre las Comunidades Autónomas y provincias, en su caso.', true), ('B', 'Gastos corrientes, y sus recursos serán distribuidos por el Gobierno entre las Comunidades Autónomas.', false), ('C', 'Gastos de personal de las Comunidades Autónomas con menor renta por habitante.', false), ('D', 'Gastos de inversión, y sus recursos serán distribuidos por el Consejo de Política Fiscal y Financiera.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
-- Lote age-aux-b1-09-organizacion-territorial-lbrl-v1 (7 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Ley 7/1985, de 2 de abril, Reguladora de las Bases del Régimen Local (texto consolidado, BOE)', 'https://www.boe.es/buscar/act.php?id=BOE-A-1985-5392', 'boe'::public.source_kind, 'Agencia Estatal Boletín Oficial del Estado', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('age-aux-b1-09-organizacion-territorial', 'I.9 La organización territorial del Estado') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('auxiliar-administrativo-estado') and t.slug = 'age-aux-b1-09-organizacion-territorial' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'De acuerdo con el artículo 12.2 de la Ley 7/1985, Reguladora de las Bases del Régimen Local:', 'El art. 12.2 LBRL establece que cada municipio pertenecerá a una sola provincia.', 'age_aux_b1_09_organizacion_territorial', (select id from public.topics where slug = 'age-aux-b1-09-organizacion-territorial'), 1, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1985-5392'), 'Art. 12.2 LBRL', '2. Cada municipio pertenecerá a una sola provincia.', null, '9229f9bf1614e03af751151296b7fe41e6bbacd91851f0488faaede6dddb1a81', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '9229f9bf1614e03af751151296b7fe41e6bbacd91851f0488faaede6dddb1a81')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Un municipio podrá pertenecer a dos provincias limítrofes si así lo acuerda su Pleno.', false), ('B', 'Los municipios de más de 50.000 habitantes no se integran en ninguna provincia.', false), ('C', 'Cada municipio pertenecerá a una sola comarca.', false), ('D', 'Cada municipio pertenecerá a una sola provincia.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 15 de la Ley 7/1985, quien viva en varios municipios deberá inscribirse en el Padrón:', 'El art. 15 LBRL obliga a inscribirse en el Padrón del municipio de residencia habitual y, si se vive en varios, solo en el que se habite más tiempo al año. La condición de vecino se adquiere con la inscripción.', 'age_aux_b1_09_organizacion_territorial', (select id from public.topics where slug = 'age-aux-b1-09-organizacion-territorial'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1985-5392'), 'Art. 15 LBRL', 'Quien viva en varios municipios deberá inscribirse únicamente en el que habite durante más tiempo al año.', null, '0eee88b97df354576ed621ecf236430c6f645251493f8aa90e9a65f4048185d8', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '0eee88b97df354576ed621ecf236430c6f645251493f8aa90e9a65f4048185d8')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'De todos los municipios en los que resida.', false), ('B', 'Únicamente del municipio en el que habite durante más tiempo al año.', true), ('C', 'Del municipio en el que tenga su domicilio fiscal.', false), ('D', 'Del municipio de su elección, comunicándolo a los demás.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'De acuerdo con el artículo 21.1 de la Ley 7/1985, ¿a qué órgano municipal corresponde dictar bandos?', 'El art. 21.1.e) LBRL atribuye al Alcalde, como Presidente de la Corporación, la facultad de dictar bandos (atribución que, según el art. 21.3, no puede delegar).', 'age_aux_b1_09_organizacion_territorial', (select id from public.topics where slug = 'age-aux-b1-09-organizacion-territorial'), 1, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1985-5392'), 'Art. 21.1.e) LBRL', 'e) Dictar bandos.', null, '57297d5b6da2758729575f34659108b691d9704ddf03955d84bfb13cf6cd0556', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '57297d5b6da2758729575f34659108b691d9704ddf03955d84bfb13cf6cd0556')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Al Pleno.', false), ('B', 'A la Junta de Gobierno Local.', false), ('C', 'Al Alcalde.', true), ('D', 'A los Tenientes de Alcalde.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 22.2 de la Ley 7/1985, corresponde al Pleno municipal:', 'El art. 22.2.d) LBRL atribuye al Pleno la aprobación del reglamento orgánico y de las ordenanzas; los bandos, la jefatura de la Policía Municipal y el nombramiento de Tenientes de Alcalde corresponden al Alcalde (art. 21).', 'age_aux_b1_09_organizacion_territorial', (select id from public.topics where slug = 'age-aux-b1-09-organizacion-territorial'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1985-5392'), 'Art. 22.2.d) LBRL', 'd) La aprobación del reglamento orgánico y de las ordenanzas.', null, '00b7c63666481899f07432c3d80951c3942cc81705d9693eed7ec95e8957b249', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '00b7c63666481899f07432c3d80951c3942cc81705d9693eed7ec95e8957b249')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'La aprobación del reglamento orgánico y de las ordenanzas.', true), ('B', 'Dictar bandos.', false), ('C', 'Ejercer la jefatura de la Policía Municipal.', false), ('D', 'El nombramiento de los Tenientes de Alcalde.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'De acuerdo con el artículo 26.1 de la Ley 7/1985, el servicio de transporte colectivo urbano de viajeros es obligatorio en los municipios con población superior a:', 'El art. 26.1.d) LBRL añade en los municipios de más de 50.000 habitantes el transporte colectivo urbano de viajeros y el medio ambiente urbano.', 'age_aux_b1_09_organizacion_territorial', (select id from public.topics where slug = 'age-aux-b1-09-organizacion-territorial'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1985-5392'), 'Art. 26.1.d) LBRL', 'd) En los Municipios con población superior a 50.000 habitantes, además: transporte colectivo urbano de viajeros y medio ambiente urbano.', null, '6b00bb2565113b618a22191071c7b35baa5e5731766c0d72ba902b1d8703389f', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '6b00bb2565113b618a22191071c7b35baa5e5731766c0d72ba902b1d8703389f')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', '20.000 habitantes.', false), ('B', '5.000 habitantes.', false), ('C', '50.000 habitantes.', true), ('D', '100.000 habitantes.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 29.2 de la Ley 7/1985, la constitución en concejo abierto de un municipio en el que lo aconsejen su localización geográfica o la mejor gestión de los intereses municipales requiere:', 'El art. 29.2 LBRL exige petición de la mayoría de los vecinos, acuerdo de dos tercios de los miembros del Ayuntamiento y aprobación por la Comunidad Autónoma.', 'age_aux_b1_09_organizacion_territorial', (select id from public.topics where slug = 'age-aux-b1-09-organizacion-territorial'), 3, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1985-5392'), 'Art. 29.2 LBRL', 'requiere petición de la mayoría de los vecinos, decisión favorable por mayoría de dos tercios de los miembros del Ayuntamiento y aprobación por la Comunidad Autónoma.', null, '13e68d58c0c685e88cc7ea1eca1fd2ec85100e1aa38fde0bca9615a12ca320da', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '13e68d58c0c685e88cc7ea1eca1fd2ec85100e1aa38fde0bca9615a12ca320da')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Petición de la mayoría de los vecinos y aprobación por mayoría absoluta del Pleno de la Diputación.', false), ('B', 'Acuerdo unánime del Ayuntamiento y autorización de la Delegación del Gobierno.', false), ('C', 'Petición de dos tercios de los vecinos y aprobación por ley de las Cortes Generales.', false), ('D', 'Petición de la mayoría de los vecinos, decisión favorable por mayoría de dos tercios de los miembros del Ayuntamiento y aprobación por la Comunidad Autónoma.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'De acuerdo con el artículo 42.2 de la Ley 7/1985, no podrá crearse una comarca si a ello se oponen expresamente:', 'El art. 42.2 LBRL impide crear la comarca si se oponen expresamente dos quintas partes de los municipios afectados que representen al menos la mitad del censo electoral del territorio.', 'age_aux_b1_09_organizacion_territorial', (select id from public.topics where slug = 'age-aux-b1-09-organizacion-territorial'), 3, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1985-5392'), 'Art. 42.2 LBRL', 'no podrá crearse la comarca si a ello se oponen expresamente las dos quintas partes de los Municipios que debieran agruparse en ella, siempre que, en este caso, tales Municipios representen al menos la mitad del censo electoral del territorio correspondiente.', null, 'a14473a6d8aaebb196874b496baf5ff3f637658e31db452486079d1721e7945f', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'a14473a6d8aaebb196874b496baf5ff3f637658e31db452486079d1721e7945f')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'La mitad de los Municipios que debieran agruparse en ella, cualquiera que sea su población.', false), ('B', 'Las dos quintas partes de los Municipios que debieran agruparse en ella, siempre que representen al menos la mitad del censo electoral del territorio.', true), ('C', 'Las dos terceras partes de los Municipios, siempre que representen la mayoría del censo electoral de la provincia.', false), ('D', 'La Diputación Provincial correspondiente, mediante acuerdo de su Pleno.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
-- Lote age-aux-b1-10-union-europea-eu_tfue-v1 (7 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Tratado de Funcionamiento de la Unión Europea (versión consolidada), arts. 223-257', 'https://eur-lex.europa.eu/legal-content/ES/TXT/?uri=CELEX:12016E/TXT', 'web_oficial'::public.source_kind, 'Unión Europea · EUR-Lex (DOUE C 202 de 7.6.2016)', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('age-aux-b1-10-union-europea', 'I.10 La organización de la Unión Europea') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('auxiliar-administrativo-estado') and t.slug = 'age-aux-b1-10-union-europea' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'De acuerdo con el artículo 227 del Tratado de Funcionamiento de la Unión Europea, el derecho a presentar al Parlamento Europeo una petición sobre un asunto propio de los ámbitos de actuación de la Unión que le afecte directamente corresponde:', 'El art. 227 TFUE reconoce el derecho de petición, individual o colectivo, a los ciudadanos de la Unión y a las personas físicas o jurídicas que residan o tengan su domicilio social en un Estado miembro.', 'age_aux_b1_10_union_europea', (select id from public.topics where slug = 'age-aux-b1-10-union-europea'), 2, 'es', true, (select id from public.sources where url = 'https://eur-lex.europa.eu/legal-content/ES/TXT/?uri=CELEX:12016E/TXT'), 'Art. 227 TFUE', 'Cualquier ciudadano de la Unión, así como cualquier persona física o jurídica que resida o tenga su domicilio social en un Estado miembro, tendrá derecho a presentar al Parlamento Europeo, individualmente o asociado con otros ciudadanos o personas, una petición', null, 'e034e4421118ab0f385817f4774ebeef7be4079126387696db4c1264cd0456af', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'e034e4421118ab0f385817f4774ebeef7be4079126387696db4c1264cd0456af')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Solo a los ciudadanos de la Unión mayores de edad inscritos en el censo electoral.', false), ('B', 'Solo a los Estados miembros y a las instituciones de la Unión.', false), ('C', 'A las personas jurídicas con domicilio social en la Unión, pero no a las personas físicas.', false), ('D', 'A cualquier ciudadano de la Unión y a cualquier persona física o jurídica que resida o tenga su domicilio social en un Estado miembro.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 228.1 del Tratado de Funcionamiento de la Unión Europea, cuando el Defensor del Pueblo Europeo haya comprobado un caso de mala administración, la institución, órgano u organismo interesado dispondrá, para exponerle su posición, de un plazo de:', 'El art. 228.1 TFUE concede a la institución afectada tres meses para exponer su posición; después el Defensor remite un informe al Parlamento Europeo y a esa institución.', 'age_aux_b1_10_union_europea', (select id from public.topics where slug = 'age-aux-b1-10-union-europea'), 3, 'es', true, (select id from public.sources where url = 'https://eur-lex.europa.eu/legal-content/ES/TXT/?uri=CELEX:12016E/TXT'), 'Art. 228.1 TFUE', 'Cuando el Defensor del Pueblo haya comprobado un caso de mala administración, lo pondrá en conocimiento de la institución, órgano u organismo interesado, que dispondrá de un plazo de tres meses para exponer su posición al Defensor del Pueblo.', null, 'd8eb04d80ebb8a88e0000f1f374e669af60bdbc0a33e073bd809131769db7a6f', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'd8eb04d80ebb8a88e0000f1f374e669af60bdbc0a33e073bd809131769db7a6f')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Un mes.', false), ('B', 'Dos meses.', false), ('C', 'Tres meses.', true), ('D', 'Seis meses.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'De acuerdo con el artículo 229 del Tratado de Funcionamiento de la Unión Europea, el Parlamento Europeo celebrará cada año un período de sesiones y se reunirá sin necesidad de previa convocatoria:', 'El art. 229 TFUE fija la reunión sin convocatoria el segundo martes de marzo; puede haber períodos parciales extraordinarios a petición de la mayoría de sus miembros, del Consejo o de la Comisión.', 'age_aux_b1_10_union_europea', (select id from public.topics where slug = 'age-aux-b1-10-union-europea'), 3, 'es', true, (select id from public.sources where url = 'https://eur-lex.europa.eu/legal-content/ES/TXT/?uri=CELEX:12016E/TXT'), 'Art. 229 TFUE', 'Se reunirá sin necesidad de previa convocatoria el segundo martes de marzo.', null, '9bd54a7fb63072dc9358bf30ae4c3c67a3ee370721ae7aa5b30480ed3546f29d', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '9bd54a7fb63072dc9358bf30ae4c3c67a3ee370721ae7aa5b30480ed3546f29d')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El primer lunes de septiembre.', false), ('B', 'El segundo martes de marzo.', true), ('C', 'El segundo martes de enero.', false), ('D', 'El primer martes de marzo.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 234 del Tratado de Funcionamiento de la Unión Europea, el Parlamento Europeo solo podrá pronunciarse sobre una moción de censura sobre la gestión de la Comisión:', 'El art. 234 TFUE exige que pasen al menos tres días desde la presentación de la moción y que la votación sea pública.', 'age_aux_b1_10_union_europea', (select id from public.topics where slug = 'age-aux-b1-10-union-europea'), 2, 'es', true, (select id from public.sources where url = 'https://eur-lex.europa.eu/legal-content/ES/TXT/?uri=CELEX:12016E/TXT'), 'Art. 234 TFUE', 'sólo podrá pronunciarse sobre dicha moción transcurridos tres días como mínimo desde la fecha de su presentación y en votación pública.', null, '6b4fdbc1ded9a7243073726607b0cc2a55691c05ae0cd850b60c49078a3714a7', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '6b4fdbc1ded9a7243073726607b0cc2a55691c05ae0cd850b60c49078a3714a7')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Transcurridos tres días como mínimo desde la fecha de su presentación y en votación pública.', true), ('B', 'Transcurridos siete días como mínimo desde su presentación y en votación secreta.', false), ('C', 'Transcurridas cuarenta y ocho horas desde su presentación y en votación pública.', false), ('D', 'Previo dictamen del Consejo Europeo y en votación secreta.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'De acuerdo con el artículo 235.1 del Tratado de Funcionamiento de la Unión Europea, cuando el Consejo Europeo se pronuncie por votación:', 'El art. 235.1 TFUE excluye de las votaciones al Presidente del Consejo Europeo y al Presidente de la Comisión; cada miembro puede representar a uno solo de los demás.', 'age_aux_b1_10_union_europea', (select id from public.topics where slug = 'age-aux-b1-10-union-europea'), 3, 'es', true, (select id from public.sources where url = 'https://eur-lex.europa.eu/legal-content/ES/TXT/?uri=CELEX:12016E/TXT'), 'Art. 235.1 TFUE', 'El Presidente del Consejo Europeo y el Presidente de la Comisión no participarán en las votaciones del Consejo Europeo cuando éste se pronuncie por votación.', null, '85f2ea1a9527bcc2a3e80420bbba1253c916a7597612d1c6c02c13bdb7cb4435', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '85f2ea1a9527bcc2a3e80420bbba1253c916a7597612d1c6c02c13bdb7cb4435')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El Presidente del Consejo Europeo dispondrá de voto de calidad en caso de empate.', false), ('B', 'El Presidente del Consejo Europeo y el Presidente de la Comisión no participarán en las votaciones.', true), ('C', 'El Presidente de la Comisión votará en nombre de la Unión.', false), ('D', 'Cada miembro podrá actuar en representación de hasta tres de los demás miembros.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 246 del Tratado de Funcionamiento de la Unión Europea, el miembro de la Comisión dimisionario, cesado o fallecido será sustituido por el resto de su mandato por un nuevo miembro:', 'El art. 246 TFUE prevé la sustitución por un nacional del mismo Estado, nombrado por el Consejo de común acuerdo con el Presidente de la Comisión y previa consulta al Parlamento; el Consejo, por unanimidad, puede decidir no sustituirlo.', 'age_aux_b1_10_union_europea', (select id from public.topics where slug = 'age-aux-b1-10-union-europea'), 3, 'es', true, (select id from public.sources where url = 'https://eur-lex.europa.eu/legal-content/ES/TXT/?uri=CELEX:12016E/TXT'), 'Art. 246 TFUE', 'El miembro dimisionario, cesado o fallecido será sustituido por el resto de su mandato por un nuevo miembro de la misma nacionalidad, nombrado por el Consejo, de común acuerdo con el Presidente de la Comisión, previa consulta al Parlamento Europeo', null, '89f326fdba38684e191aa08b46e6ca82fb5734f9e2ce65edc1b2cab3caee927a', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '89f326fdba38684e191aa08b46e6ca82fb5734f9e2ce65edc1b2cab3caee927a')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'De cualquier nacionalidad, elegido por el Parlamento Europeo por mayoría de sus miembros.', false), ('B', 'De la misma nacionalidad, nombrado directamente por el Gobierno del Estado miembro afectado.', false), ('C', 'De la misma nacionalidad, nombrado por el Consejo de común acuerdo con el Presidente de la Comisión, previa consulta al Parlamento Europeo.', true), ('D', 'Designado por el Consejo Europeo por unanimidad, sin intervención del Parlamento Europeo.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'De acuerdo con el artículo 253 del Tratado de Funcionamiento de la Unión Europea, el Presidente del Tribunal de Justicia es elegido:', 'El art. 253 TFUE atribuye a los jueces la elección del Presidente del Tribunal de Justicia por tres años, con mandato renovable; cada tres años hay renovación parcial de jueces y abogados generales.', 'age_aux_b1_10_union_europea', (select id from public.topics where slug = 'age-aux-b1-10-union-europea'), 2, 'es', true, (select id from public.sources where url = 'https://eur-lex.europa.eu/legal-content/ES/TXT/?uri=CELEX:12016E/TXT'), 'Art. 253 TFUE', 'Los jueces elegirán de entre ellos al Presidente del Tribunal de Justicia por un período de tres años. Su mandato será renovable.', null, '9b72a8e7c6a8d714551636bbd3d224e3fb1785fa31c0c407e9e72d39d8979210', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '9b72a8e7c6a8d714551636bbd3d224e3fb1785fa31c0c407e9e72d39d8979210')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Por el Consejo, por unanimidad, por un período de seis años.', false), ('B', 'Por los Gobiernos de los Estados miembros de común acuerdo, por un período de tres años no renovable.', false), ('C', 'Por el Parlamento Europeo, a propuesta del comité del artículo 255, por cinco años.', false), ('D', 'Por los jueces, de entre ellos, por un período de tres años renovable.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
-- Lote age-aux-b1-10-union-europea-eu_tue-v1 (13 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Tratado de la Unión Europea (versión consolidada), arts. 13-19', 'https://eur-lex.europa.eu/legal-content/ES/TXT/?uri=CELEX:12016M/TXT', 'web_oficial'::public.source_kind, 'Unión Europea · EUR-Lex (DOUE C 202 de 7.6.2016)', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('age-aux-b1-10-union-europea', 'I.10 La organización de la Unión Europea') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('auxiliar-administrativo-estado') and t.slug = 'age-aux-b1-10-union-europea' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 13.1 del Tratado de la Unión Europea, ¿cuál de los siguientes órganos tiene la condición de institución de la Unión?', 'El art. 13.1 TUE enumera siete instituciones: Parlamento Europeo, Consejo Europeo, Consejo, Comisión, TJUE, Banco Central Europeo y Tribunal de Cuentas. Los Comités Económico y Social y de las Regiones son órganos consultivos (art. 13.4).', 'age_aux_b1_10_union_europea', (select id from public.topics where slug = 'age-aux-b1-10-union-europea'), 1, 'es', true, (select id from public.sources where url = 'https://eur-lex.europa.eu/legal-content/ES/TXT/?uri=CELEX:12016M/TXT'), 'Art. 13.1 TUE', 'Las instituciones de la Unión son: El Parlamento Europeo, El Consejo Europeo, El Consejo, La Comisión Europea (denominada en lo sucesivo «Comisión»), El Tribunal de Justicia de la Unión Europea, El Banco Central Europeo, El Tribunal de Cuentas.', null, '9af295029c4abf745d2efc923b19431f5c0eb508dec0bd7831c409462823a702', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '9af295029c4abf745d2efc923b19431f5c0eb508dec0bd7831c409462823a702')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El Comité de las Regiones.', false), ('B', 'El Comité Económico y Social.', false), ('C', 'El Tribunal de Cuentas.', true), ('D', 'El Defensor del Pueblo Europeo.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'De acuerdo con el artículo 13.2 del Tratado de la Unión Europea, las instituciones de la Unión mantendrán entre sí:', 'El art. 13.2 TUE obliga a cada institución a actuar dentro de sus atribuciones y a mantener con las demás una cooperación leal.', 'age_aux_b1_10_union_europea', (select id from public.topics where slug = 'age-aux-b1-10-union-europea'), 2, 'es', true, (select id from public.sources where url = 'https://eur-lex.europa.eu/legal-content/ES/TXT/?uri=CELEX:12016M/TXT'), 'Art. 13.2 TUE', 'Las instituciones mantendrán entre sí una cooperación leal.', null, '228fdaaac0d1f581b7a30ec53e1852296e7e0cc89fea6d10b7c8aac1c77e6b5f', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '228fdaaac0d1f581b7a30ec53e1852296e7e0cc89fea6d10b7c8aac1c77e6b5f')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Una relación de jerarquía encabezada por el Consejo Europeo.', false), ('B', 'Una cooperación leal.', true), ('C', 'Una relación de subordinación al Parlamento Europeo.', false), ('D', 'Una coordinación dirigida por la Comisión.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 14.1 del Tratado de la Unión Europea, el Parlamento Europeo ejercerá conjuntamente con el Consejo:', 'El art. 14.1 TUE atribuye al Parlamento Europeo, junto con el Consejo, la función legislativa y la presupuestaria; además ejerce funciones de control político y consultivas y elige al Presidente de la Comisión.', 'age_aux_b1_10_union_europea', (select id from public.topics where slug = 'age-aux-b1-10-union-europea'), 1, 'es', true, (select id from public.sources where url = 'https://eur-lex.europa.eu/legal-content/ES/TXT/?uri=CELEX:12016M/TXT'), 'Art. 14.1 TUE', '1. El Parlamento Europeo ejercerá conjuntamente con el Consejo la función legislativa y la función presupuestaria.', null, '5ab183f3c89520e6da5baa470a3cbb44e789b43b85fd0f64a2ab650356f4cd50', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '5ab183f3c89520e6da5baa470a3cbb44e789b43b85fd0f64a2ab650356f4cd50')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'La función ejecutiva y la representación exterior de la Unión.', false), ('B', 'La definición de las orientaciones y prioridades políticas generales de la Unión.', false), ('C', 'La función jurisdiccional y la de control del presupuesto.', false), ('D', 'La función legislativa y la función presupuestaria.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'De acuerdo con el artículo 14.2 del Tratado de la Unión Europea, el número de representantes de los ciudadanos en el Parlamento Europeo no excederá de:', 'El art. 14.2 TUE fija un máximo de setecientos cincuenta diputados más el Presidente; la composición concreta la decide el Consejo Europeo por unanimidad, a iniciativa del Parlamento y con su aprobación.', 'age_aux_b1_10_union_europea', (select id from public.topics where slug = 'age-aux-b1-10-union-europea'), 2, 'es', true, (select id from public.sources where url = 'https://eur-lex.europa.eu/legal-content/ES/TXT/?uri=CELEX:12016M/TXT'), 'Art. 14.2 TUE', 'Su número no excederá de setecientos cincuenta, más el Presidente.', null, '1bb4f5dd4dc9633921ef96f435edbcdc5207cbcf8ff5414f431911ff941d1c88', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '1bb4f5dd4dc9633921ef96f435edbcdc5207cbcf8ff5414f431911ff941d1c88')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Setecientos cincuenta, más el Presidente.', true), ('B', 'Setecientos, más el Presidente.', false), ('C', 'Setecientos cincuenta, incluido el Presidente.', false), ('D', 'Ochocientos, más el Presidente.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 15.2 del Tratado de la Unión Europea, el Consejo Europeo estará compuesto por:', 'El art. 15.2 TUE compone el Consejo Europeo con los Jefes de Estado o de Gobierno, su Presidente y el Presidente de la Comisión; el Alto Representante participa en sus trabajos.', 'age_aux_b1_10_union_europea', (select id from public.topics where slug = 'age-aux-b1-10-union-europea'), 2, 'es', true, (select id from public.sources where url = 'https://eur-lex.europa.eu/legal-content/ES/TXT/?uri=CELEX:12016M/TXT'), 'Art. 15.2 TUE', '2. El Consejo Europeo estará compuesto por los Jefes de Estado o de Gobierno de los Estados miembros, así como por su Presidente y por el Presidente de la Comisión. Participará en sus trabajos el Alto Representante de la Unión para Asuntos Exteriores y Política de Seguridad.', null, '9f7b0a4f3c9d37c48f9e9242d964a5dba7e48107995d41e14641a1b1cc653e79', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '9f7b0a4f3c9d37c48f9e9242d964a5dba7e48107995d41e14641a1b1cc653e79')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Los Jefes de Estado o de Gobierno, su Presidente, el Presidente de la Comisión y el Presidente del Parlamento Europeo.', false), ('B', 'Un representante de cada Estado miembro de rango ministerial.', false), ('C', 'Los Jefes de Estado o de Gobierno de los Estados miembros, su Presidente y el Presidente de la Comisión.', true), ('D', 'Los Jefes de Estado o de Gobierno y el Alto Representante, como miembro de pleno derecho.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'De acuerdo con el artículo 15.4 del Tratado de la Unión Europea, salvo que los Tratados dispongan otra cosa, el Consejo Europeo se pronunciará:', 'El art. 15.4 TUE fija el consenso como regla general de decisión del Consejo Europeo.', 'age_aux_b1_10_union_europea', (select id from public.topics where slug = 'age-aux-b1-10-union-europea'), 1, 'es', true, (select id from public.sources where url = 'https://eur-lex.europa.eu/legal-content/ES/TXT/?uri=CELEX:12016M/TXT'), 'Art. 15.4 TUE', '4. El Consejo Europeo se pronunciará por consenso, excepto cuando los Tratados dispongan otra cosa.', null, 'ccff1934e79646e2a13f6e7200d4b3ec8bdf58c4743de9f9831b089c73c6a798', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'ccff1934e79646e2a13f6e7200d4b3ec8bdf58c4743de9f9831b089c73c6a798')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Por mayoría cualificada.', false), ('B', 'Por mayoría simple.', false), ('C', 'Por unanimidad de los Estados miembros presentes.', false), ('D', 'Por consenso.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 15.6 del Tratado de la Unión Europea, el Presidente del Consejo Europeo:', 'El art. 15.6 TUE declara incompatible la Presidencia del Consejo Europeo con cualquier mandato nacional. El Consejo de Asuntos Exteriores lo preside el Alto Representante (art. 18.3).', 'age_aux_b1_10_union_europea', (select id from public.topics where slug = 'age-aux-b1-10-union-europea'), 2, 'es', true, (select id from public.sources where url = 'https://eur-lex.europa.eu/legal-content/ES/TXT/?uri=CELEX:12016M/TXT'), 'Art. 15.6 TUE', 'El Presidente del Consejo Europeo no podrá ejercer mandato nacional alguno.', null, 'fc01832db60cfa598ef3c62ca7ad485f49a91e779501d36481f934710ff278ee', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'fc01832db60cfa598ef3c62ca7ad485f49a91e779501d36481f934710ff278ee')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'No podrá ejercer mandato nacional alguno.', true), ('B', 'Ejercerá simultáneamente la Presidencia rotatoria del Consejo.', false), ('C', 'Podrá ser a la vez Jefe de Gobierno de su Estado miembro.', false), ('D', 'Presidirá el Consejo de Asuntos Exteriores.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'De acuerdo con el artículo 16.4 del Tratado de la Unión Europea, la minoría de bloqueo en el Consejo estará compuesta por al menos:', 'El art. 16.4, párrafo segundo, TUE exige al menos cuatro miembros para formar una minoría de bloqueo; si no se alcanzan, la mayoría cualificada se considera alcanzada.', 'age_aux_b1_10_union_europea', (select id from public.topics where slug = 'age-aux-b1-10-union-europea'), 3, 'es', true, (select id from public.sources where url = 'https://eur-lex.europa.eu/legal-content/ES/TXT/?uri=CELEX:12016M/TXT'), 'Art. 16.4 TUE', 'Una minoría de bloqueo estará compuesta por al menos cuatro miembros del Consejo, a falta de lo cual la mayoría cualificada se considerará alcanzada.', null, '63ee8a8ea679224658b39dd160eb066c85da17cc1cb8c2bd970c5fb40ff6216c', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '63ee8a8ea679224658b39dd160eb066c85da17cc1cb8c2bd970c5fb40ff6216c')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Tres miembros del Consejo que representen el 35 % de la población de la Unión.', false), ('B', 'Cuatro miembros del Consejo, a falta de lo cual la mayoría cualificada se considerará alcanzada.', true), ('C', 'Seis miembros del Consejo, a falta de lo cual se requerirá unanimidad.', false), ('D', 'Cinco miembros del Consejo, cualquiera que sea su población.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 16.8 del Tratado de la Unión Europea, el Consejo se reunirá en público:', 'El art. 16.8 TUE impone la publicidad cuando el Consejo delibera y vota proyectos de actos legislativos; por eso cada sesión se divide en una parte legislativa y otra no legislativa.', 'age_aux_b1_10_union_europea', (select id from public.topics where slug = 'age-aux-b1-10-union-europea'), 2, 'es', true, (select id from public.sources where url = 'https://eur-lex.europa.eu/legal-content/ES/TXT/?uri=CELEX:12016M/TXT'), 'Art. 16.8 TUE', '8. El Consejo se reunirá en público cuando delibere y vote sobre un proyecto de acto legislativo.', null, '8b0dadb0078973380162987ba4d63d1e935fb9eed421b7ec651d68cf883a9341', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '8b0dadb0078973380162987ba4d63d1e935fb9eed421b7ec651d68cf883a9341')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'En todas sus sesiones, sin excepción.', false), ('B', 'Únicamente cuando lo solicite el Parlamento Europeo.', false), ('C', 'Solo en las reuniones de la formación de Asuntos Generales.', false), ('D', 'Cuando delibere y vote sobre un proyecto de acto legislativo.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'De acuerdo con el artículo 17.2 del Tratado de la Unión Europea, salvo que los Tratados dispongan otra cosa, los actos legislativos de la Unión solo podrán adoptarse a propuesta de:', 'El art. 17.2 TUE reserva a la Comisión, como regla general, la iniciativa de los actos legislativos de la Unión.', 'age_aux_b1_10_union_europea', (select id from public.topics where slug = 'age-aux-b1-10-union-europea'), 1, 'es', true, (select id from public.sources where url = 'https://eur-lex.europa.eu/legal-content/ES/TXT/?uri=CELEX:12016M/TXT'), 'Art. 17.2 TUE', '2. Los actos legislativos de la Unión sólo podrán adoptarse a propuesta de la Comisión, excepto cuando los Tratados dispongan otra cosa.', null, 'f5817ad1210ecbbdb0b06632842b303ad1f583155702528a31d6d6eab9e91793', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'f5817ad1210ecbbdb0b06632842b303ad1f583155702528a31d6d6eab9e91793')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El Consejo Europeo.', false), ('B', 'El Parlamento Europeo.', false), ('C', 'La Comisión.', true), ('D', 'El Comité de Representantes Permanentes.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 18.1 del Tratado de la Unión Europea, el Alto Representante de la Unión para Asuntos Exteriores y Política de Seguridad es nombrado:', 'El art. 18.1 TUE atribuye su nombramiento al Consejo Europeo por mayoría cualificada, con la aprobación del Presidente de la Comisión; por el mismo procedimiento puede ponerse fin a su mandato.', 'age_aux_b1_10_union_europea', (select id from public.topics where slug = 'age-aux-b1-10-union-europea'), 2, 'es', true, (select id from public.sources where url = 'https://eur-lex.europa.eu/legal-content/ES/TXT/?uri=CELEX:12016M/TXT'), 'Art. 18.1 TUE', '1. El Consejo Europeo nombrará por mayoría cualificada, con la aprobación del Presidente de la Comisión, al Alto Representante de la Unión para Asuntos Exteriores y Política de Seguridad.', null, 'daae4d4c432e539d236e1b0922c041bd339f8fef06615f5966894dd5453299d2', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'daae4d4c432e539d236e1b0922c041bd339f8fef06615f5966894dd5453299d2')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Por el Consejo Europeo, por mayoría cualificada, con la aprobación del Presidente de la Comisión.', true), ('B', 'Por el Parlamento Europeo, por mayoría de los miembros que lo componen.', false), ('C', 'Por el Consejo, por unanimidad, a propuesta de la Comisión.', false), ('D', 'Por el Presidente de la Comisión, previa consulta al Consejo Europeo.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'De acuerdo con el artículo 19.1 del Tratado de la Unión Europea, el Tribunal de Justicia de la Unión Europea comprenderá:', 'El art. 19.1 TUE integra en el TJUE al Tribunal de Justicia, al Tribunal General y a los tribunales especializados.', 'age_aux_b1_10_union_europea', (select id from public.topics where slug = 'age-aux-b1-10-union-europea'), 1, 'es', true, (select id from public.sources where url = 'https://eur-lex.europa.eu/legal-content/ES/TXT/?uri=CELEX:12016M/TXT'), 'Art. 19.1 TUE', '1. El Tribunal de Justicia de la Unión Europea comprenderá el Tribunal de Justicia, el Tribunal General y los tribunales especializados.', null, '16dbc6210794a799deba9e1780156671f4ad630457e14a8a411cde515d690cb3', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '16dbc6210794a799deba9e1780156671f4ad630457e14a8a411cde515d690cb3')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El Tribunal de Justicia y el Tribunal de Cuentas.', false), ('B', 'El Tribunal de Justicia, el Tribunal General y los tribunales especializados.', true), ('C', 'El Tribunal de Justicia, el Tribunal Europeo de Derechos Humanos y el Tribunal General.', false), ('D', 'El Tribunal de Justicia y los órganos jurisdiccionales nacionales superiores.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 19.2 del Tratado de la Unión Europea, los jueces y abogados generales del Tribunal de Justicia y los jueces del Tribunal General son nombrados de común acuerdo por los Gobiernos de los Estados miembros para un período de:', 'El art. 19.2 TUE fija un período de seis años, y los jueces y abogados generales salientes pueden ser nombrados de nuevo.', 'age_aux_b1_10_union_europea', (select id from public.topics where slug = 'age-aux-b1-10-union-europea'), 1, 'es', true, (select id from public.sources where url = 'https://eur-lex.europa.eu/legal-content/ES/TXT/?uri=CELEX:12016M/TXT'), 'Art. 19.2 TUE', 'Serán nombrados de común acuerdo por los Gobiernos de los Estados miembros para un período de seis años.', null, '4d57d0983793115639d2c7fd576bfc18a54cc9152b0eb0e373b670ab3ca46ec5', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '4d57d0983793115639d2c7fd576bfc18a54cc9152b0eb0e373b670ab3ca46ec5')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Seis años.', true), ('B', 'Cinco años.', false), ('C', 'Tres años.', false), ('D', 'Nueve años.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
-- Lote age-aux-b1-11-procedimiento-lpac-v1 (10 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Ley 39/2015, de 1 de octubre, del Procedimiento Administrativo Común de las Administraciones Públicas (texto consolidado, BOE)', 'https://www.boe.es/buscar/act.php?id=BOE-A-2015-10565', 'boe'::public.source_kind, 'Agencia Estatal Boletín Oficial del Estado', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('age-aux-b1-11-procedimiento', 'I.11 Procedimiento administrativo común, recursos y contencioso-administrativo') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('auxiliar-administrativo-estado') and t.slug = 'age-aux-b1-11-procedimiento' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 14.2 de la Ley 39/2015, ¿cuál de los siguientes sujetos está obligado en todo caso a relacionarse a través de medios electrónicos con las Administraciones Públicas?', 'El art. 14.2 LPAC obliga, al menos, a las personas jurídicas, las entidades sin personalidad jurídica, los profesionales de colegiación obligatoria en su actividad, los representantes de obligados y los empleados públicos en los trámites por razón de su condición. Las personas físicas pueden elegir (art. 14.1).', 'age_aux_b1_11_procedimiento', (select id from public.topics where slug = 'age-aux-b1-11-procedimiento'), 1, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2015-10565'), 'Art. 14.2 LPAC', 'a) Las personas jurídicas.', null, '968fe9b677de1639fe366f65c24b197ca0ab218f619c1d423e099aa64cafdd70', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '968fe9b677de1639fe366f65c24b197ca0ab218f619c1d423e099aa64cafdd70')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Las personas físicas mayores de edad.', false), ('B', 'Los extranjeros residentes en España.', false), ('C', 'Las personas físicas que sean titulares de un certificado electrónico.', false), ('D', 'Las personas jurídicas.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'De acuerdo con el artículo 39.1 de la Ley 39/2015, los actos de las Administraciones Públicas sujetos al Derecho Administrativo se presumirán válidos y producirán efectos:', 'El art. 39.1 LPAC establece la presunción de validez y la eficacia desde la fecha en que se dicten, salvo disposición en contrario; el apartado 2 prevé la eficacia demorada.', 'age_aux_b1_11_procedimiento', (select id from public.topics where slug = 'age-aux-b1-11-procedimiento'), 1, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2015-10565'), 'Art. 39.1 LPAC', '1. Los actos de las Administraciones Públicas sujetos al Derecho Administrativo se presumirán válidos y producirán efectos desde la fecha en que se dicten, salvo que en ellos se disponga otra cosa.', null, '73022a7db5c1386e29ac01e98de1342ea3a51d197fb97668984f16ea28ee0831', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '73022a7db5c1386e29ac01e98de1342ea3a51d197fb97668984f16ea28ee0831')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Desde la fecha en que se dicten, salvo que en ellos se disponga otra cosa.', true), ('B', 'Desde el día siguiente a su publicación en el boletín oficial correspondiente.', false), ('C', 'A los veinte días de su notificación al interesado.', false), ('D', 'Desde que adquieran firmeza en vía administrativa.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 39.3 de la Ley 39/2015, excepcionalmente podrá otorgarse eficacia retroactiva a los actos:', 'El art. 39.3 LPAC admite la retroactividad de actos que sustituyan a actos anulados y de los favorables al interesado, si los supuestos de hecho ya existían en la fecha a la que se retrotrae y no se lesionan derechos de terceros.', 'age_aux_b1_11_procedimiento', (select id from public.topics where slug = 'age-aux-b1-11-procedimiento'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2015-10565'), 'Art. 39.3 LPAC', '3. Excepcionalmente, podrá otorgarse eficacia retroactiva a los actos cuando se dicten en sustitución de actos anulados, así como cuando produzcan efectos favorables al interesado', null, '34b69a30a09c3d3b3762f5f74f5bcc25861b8e847e93f05b0c79922a05beb5aa', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '34b69a30a09c3d3b3762f5f74f5bcc25861b8e847e93f05b0c79922a05beb5aa')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Siempre que lo solicite el interesado y no exista oposición de terceros.', false), ('B', 'Únicamente cuando se trate de actos sancionadores.', false), ('C', 'Cuando se dicten en sustitución de actos anulados o cuando produzcan efectos favorables al interesado, con los requisitos que la ley establece.', true), ('D', 'Cuando así lo acuerde el órgano superior jerárquico del que los dictó.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'De acuerdo con el artículo 40.2 de la Ley 39/2015, toda notificación deberá ser cursada dentro del plazo de:', 'El art. 40.2 LPAC exige cursar la notificación en diez días desde que se dictó el acto, con el texto íntegro, indicación de si pone fin a la vía administrativa, los recursos procedentes, el órgano y el plazo.', 'age_aux_b1_11_procedimiento', (select id from public.topics where slug = 'age-aux-b1-11-procedimiento'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2015-10565'), 'Art. 40.2 LPAC', '2. Toda notificación deberá ser cursada dentro del plazo de diez días a partir de la fecha en que el acto haya sido dictado', null, '2c61cf5b89ffbdb3caf609fd30147c348ab8c5ff4d741000b66cb78a2364339f', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '2c61cf5b89ffbdb3caf609fd30147c348ab8c5ff4d741000b66cb78a2364339f')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Diez días a partir de la fecha en que el acto haya sido dictado.', true), ('B', 'Quince días a partir de la fecha en que el acto haya sido dictado.', false), ('C', 'Diez días a partir de la firmeza del acto.', false), ('D', 'Un mes desde la fecha en que se dictó el acto.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 43.2 de la Ley 39/2015, cuando la notificación por medios electrónicos sea obligatoria o la haya elegido expresamente el interesado, se entenderá rechazada cuando hayan transcurrido sin acceder a su contenido:', 'El art. 43.2 LPAC fija diez días naturales desde la puesta a disposición sin acceso para entender rechazada la notificación electrónica.', 'age_aux_b1_11_procedimiento', (select id from public.topics where slug = 'age-aux-b1-11-procedimiento'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2015-10565'), 'Art. 43.2 LPAC', 'se entenderá rechazada cuando hayan transcurrido diez días naturales desde la puesta a disposición de la notificación sin que se acceda a su contenido.', null, '3765260c8902fa4b89a8f65cdee2520cee2dffc98a458359f239b78303e57fef', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '3765260c8902fa4b89a8f65cdee2520cee2dffc98a458359f239b78303e57fef')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Diez días hábiles desde la puesta a disposición de la notificación.', false), ('B', 'Diez días naturales desde la puesta a disposición de la notificación.', true), ('C', 'Quince días naturales desde el envío del aviso de notificación.', false), ('D', 'Cinco días hábiles desde la puesta a disposición de la notificación.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Conforme al artículo 47.1 de la Ley 39/2015, los actos de las Administraciones Públicas que tengan un contenido imposible son:', 'El art. 47.1.c) LPAC incluye entre los actos nulos de pleno derecho los que tengan un contenido imposible.', 'age_aux_b1_11_procedimiento', (select id from public.topics where slug = 'age-aux-b1-11-procedimiento'), 1, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2015-10565'), 'Art. 47.1.c) LPAC', 'c) Los que tengan un contenido imposible.', null, '93489b7e87c45e06e52bb0bb3f8fdccfce4db8f8867a1bb289c1f3170a6c88e9', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '93489b7e87c45e06e52bb0bb3f8fdccfce4db8f8867a1bb289c1f3170a6c88e9')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Anulables.', false), ('B', 'Irregulares no invalidantes.', false), ('C', 'Válidos hasta que se declare su lesividad.', false), ('D', 'Nulos de pleno derecho.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'De acuerdo con el artículo 48.2 de la Ley 39/2015, el defecto de forma solo determinará la anulabilidad del acto cuando:', 'El art. 48.2 LPAC limita la anulabilidad por defecto de forma a los casos en que falten requisitos formales indispensables para alcanzar el fin del acto o se cause indefensión.', 'age_aux_b1_11_procedimiento', (select id from public.topics where slug = 'age-aux-b1-11-procedimiento'), 3, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2015-10565'), 'Art. 48.2 LPAC', '2. No obstante, el defecto de forma sólo determinará la anulabilidad cuando el acto carezca de los requisitos formales indispensables para alcanzar su fin o dé lugar a la indefensión de los interesados.', null, '17d2d35e8e5a9dd97b83394e29ad35fd8ce613c6e4bf9c094267a0aa74d70884', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '17d2d35e8e5a9dd97b83394e29ad35fd8ce613c6e4bf9c094267a0aa74d70884')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El acto se haya dictado fuera del plazo establecido, en todo caso.', false), ('B', 'El acto carezca de los requisitos formales indispensables para alcanzar su fin o dé lugar a la indefensión de los interesados.', true), ('C', 'El interesado lo alegue en el plazo de diez días desde la notificación.', false), ('D', 'El defecto afecte a cualquier requisito formal, aunque el acto alcance su fin.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 73.1 de la Ley 39/2015, salvo que la norma correspondiente fije un plazo distinto, los trámites que deban ser cumplimentados por los interesados deberán realizarse en el plazo de:', 'El art. 73.1 LPAC fija con carácter general diez días desde el siguiente a la notificación; si no se cumplen, el interesado puede ser declarado decaído en su derecho al trámite (art. 73.3).', 'age_aux_b1_11_procedimiento', (select id from public.topics where slug = 'age-aux-b1-11-procedimiento'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2015-10565'), 'Art. 73.1 LPAC', '1. Los trámites que deban ser cumplimentados por los interesados deberán realizarse en el plazo de diez días a partir del siguiente al de la notificación del correspondiente acto', null, 'f176c168926c96aa8248df6200c01901ca6fffd08e60c245d6408178b33692ab', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'f176c168926c96aa8248df6200c01901ca6fffd08e60c245d6408178b33692ab')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Diez días a partir del siguiente al de la notificación del correspondiente acto.', true), ('B', 'Quince días a partir del siguiente al de la notificación del correspondiente acto.', false), ('C', 'Cinco días a partir de la fecha del acto.', false), ('D', 'Un mes a partir del siguiente al de la notificación del correspondiente acto.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'De acuerdo con el artículo 112.3 de la Ley 39/2015, contra las disposiciones administrativas de carácter general:', 'El art. 112.3 LPAC excluye el recurso administrativo contra disposiciones generales; los recursos contra actos fundados solo en la nulidad de una disposición general pueden interponerse directamente ante el órgano que la dictó.', 'age_aux_b1_11_procedimiento', (select id from public.topics where slug = 'age-aux-b1-11-procedimiento'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2015-10565'), 'Art. 112.3 LPAC', '3. Contra las disposiciones administrativas de carácter general no cabrá recurso en vía administrativa.', null, '0909f5cb6b7af949133d5fe7e1eeafa13e01d051603cc0cb5adec203c801bbe8', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '0909f5cb6b7af949133d5fe7e1eeafa13e01d051603cc0cb5adec203c801bbe8')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Cabrá recurso de alzada ante el Consejo de Ministros.', false), ('B', 'Cabrá recurso potestativo de reposición en el plazo de un mes desde su publicación.', false), ('C', 'Cabrá recurso extraordinario de revisión en el plazo de cuatro años.', false), ('D', 'No cabrá recurso en vía administrativa.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 121.2 de la Ley 39/2015, si el recurso de alzada se interpone ante el órgano que dictó el acto impugnado, este deberá remitirlo al órgano competente, con su informe y con una copia completa y ordenada del expediente, en el plazo de:', 'El art. 121.2 LPAC permite interponer la alzada ante el órgano que dictó el acto o ante el competente para resolver; en el primer caso, aquel debe remitirlo en diez días con informe y copia del expediente.', 'age_aux_b1_11_procedimiento', (select id from public.topics where slug = 'age-aux-b1-11-procedimiento'), 3, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2015-10565'), 'Art. 121.2 LPAC', 'Si el recurso se hubiera interpuesto ante el órgano que dictó el acto impugnado, éste deberá remitirlo al competente en el plazo de diez días, con su informe y con una copia completa y ordenada del expediente.', null, 'd9d6eef0be0b9f56bf86bb4eea1e90e2fbde11d8b44de810019493f8135bad5a', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'd9d6eef0be0b9f56bf86bb4eea1e90e2fbde11d8b44de810019493f8135bad5a')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Quince días.', false), ('B', 'Cinco días.', false), ('C', 'Diez días.', true), ('D', 'Un mes.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
-- Lote age-aux-b1-12-proteccion-datos-lopdgdd-v1 (20 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Ley Orgánica 3/2018, de 5 de diciembre, de Protección de Datos Personales y garantía de los derechos digitales (texto consolidado, BOE)', 'https://www.boe.es/buscar/act.php?id=BOE-A-2018-16673', 'boe'::public.source_kind, 'Agencia Estatal Boletín Oficial del Estado', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('age-aux-b1-12-proteccion-datos', 'I.12 La protección de datos personales') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('auxiliar-administrativo-estado') and t.slug = 'age-aux-b1-12-proteccion-datos' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 12.1 de la Ley Orgánica 3/2018, los derechos reconocidos en los artículos 15 a 22 del Reglamento (UE) 2016/679 podrán ejercerse:', 'El art. 12.1 LOPDGDD permite ejercer los derechos directamente o mediante representante legal o voluntario.', 'age_aux_b1_12_proteccion_datos', (select id from public.topics where slug = 'age-aux-b1-12-proteccion-datos'), 1, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2018-16673'), 'Art. 12.1 LOPDGDD', '1. Los derechos reconocidos en los artículos 15 a 22 del Reglamento (UE) 2016/679, podrán ejercerse directamente o por medio de representante legal o voluntario.', null, 'b36656806ffa6c19f1a46db9ea1149b1c0aa1658759005fc587eb011fca3c830', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'b36656806ffa6c19f1a46db9ea1149b1c0aa1658759005fc587eb011fca3c830')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Únicamente de forma personal por el afectado.', false), ('B', 'Solo a través de la Agencia Española de Protección de Datos.', false), ('C', 'Únicamente por medio de abogado o procurador.', false), ('D', 'Directamente o por medio de representante legal o voluntario.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'De acuerdo con el artículo 12.6 de la Ley Orgánica 3/2018, los titulares de la patria potestad podrán ejercitar en nombre y representación de los menores los derechos de acceso, rectificación, cancelación, oposición o cualesquiera otros cuando estos sean:', 'El art. 12.6 LOPDGDD habilita a quienes ejercen la patria potestad a ejercitar esos derechos en nombre de los menores de catorce años, edad que coincide con la del consentimiento del art. 7.', 'age_aux_b1_12_proteccion_datos', (select id from public.topics where slug = 'age-aux-b1-12-proteccion-datos'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2018-16673'), 'Art. 12.6 LOPDGDD', 'los titulares de la patria potestad podrán ejercitar en nombre y representación de los menores de catorce años los derechos de acceso, rectificación, cancelación, oposición', null, '2c1a0dec1cdd3059ceef5f933e1bd92dc2b3b5c4dc4a2c2c02d804539b584d82', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '2c1a0dec1cdd3059ceef5f933e1bd92dc2b3b5c4dc4a2c2c02d804539b584d82')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Menores de dieciséis años.', false), ('B', 'Menores de doce años.', false), ('C', 'Menores de catorce años.', true), ('D', 'Menores de dieciocho años.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 12.7 de la Ley Orgánica 3/2018, las actuaciones llevadas a cabo por el responsable del tratamiento para atender las solicitudes de ejercicio de los derechos serán, con las salvedades que la ley prevé:', 'El art. 12.7 LOPDGDD declara gratuitas esas actuaciones, sin perjuicio de los supuestos de solicitudes manifiestamente infundadas o excesivas (arts. 12.5 y 15.3 RGPD y 13.3-4 LOPDGDD).', 'age_aux_b1_12_proteccion_datos', (select id from public.topics where slug = 'age-aux-b1-12-proteccion-datos'), 1, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2018-16673'), 'Art. 12.7 LOPDGDD', '7. Serán gratuitas las actuaciones llevadas a cabo por el responsable del tratamiento para atender las solicitudes de ejercicio de estos derechos', null, '8e02d2bc3c347ac235a15904ca9458d30f8c86d7967fc14f95bc81b8a1e18769', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '8e02d2bc3c347ac235a15904ca9458d30f8c86d7967fc14f95bc81b8a1e18769')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Sujetas al pago de una tasa fijada por la Agencia Española de Protección de Datos.', false), ('B', 'Gratuitas.', true), ('C', 'Gratuitas solo para las personas físicas menores de edad.', false), ('D', 'Sujetas a un precio público que fija cada responsable.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'De acuerdo con el artículo 13.2 de la Ley Orgánica 3/2018, el derecho de acceso se entenderá otorgado si el responsable del tratamiento:', 'El art. 13.2 LOPDGDD tiene por atendido el derecho de acceso cuando se ofrece un sistema de acceso remoto, directo y seguro que garantice permanentemente el acceso a la totalidad de los datos.', 'age_aux_b1_12_proteccion_datos', (select id from public.topics where slug = 'age-aux-b1-12-proteccion-datos'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2018-16673'), 'Art. 13.2 LOPDGDD', '2. El derecho de acceso se entenderá otorgado si el responsable del tratamiento facilitara al afectado un sistema de acceso remoto, directo y seguro a los datos personales que garantice, de modo permanente, el acceso a su totalidad.', null, 'd48a1e293c59093a54ac47e1bd35af7ac1ef23487af2235e62fdcbaa417e5712', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'd48a1e293c59093a54ac47e1bd35af7ac1ef23487af2235e62fdcbaa417e5712')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Facilita al afectado un sistema de acceso remoto, directo y seguro a los datos personales que garantice, de modo permanente, el acceso a su totalidad.', true), ('B', 'Remite al afectado, por correo postal, una copia en papel de una parte de sus datos.', false), ('C', 'Publica los datos del afectado en su sede electrónica durante un mes.', false), ('D', 'Comunica los datos del afectado a la Agencia Española de Protección de Datos.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 14 de la Ley Orgánica 3/2018, al ejercer el derecho de rectificación el afectado deberá indicar en su solicitud:', 'El art. 14 LOPDGDD exige concretar los datos y la corrección pedida, y aportar, cuando sea preciso, documentación que justifique la inexactitud o el carácter incompleto.', 'age_aux_b1_12_proteccion_datos', (select id from public.topics where slug = 'age-aux-b1-12-proteccion-datos'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2018-16673'), 'Art. 14 LOPDGDD', 'el afectado deberá indicar en su solicitud a qué datos se refiere y la corrección que haya de realizarse. Deberá acompañar, cuando sea preciso, la documentación justificativa de la inexactitud o carácter incompleto de los datos objeto de tratamiento.', null, 'c53bc51be4ba48f6c50d3d04260d484691ad550dbb3f5ef4b0f876ecc796bd40', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'c53bc51be4ba48f6c50d3d04260d484691ad550dbb3f5ef4b0f876ecc796bd40')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Únicamente su identidad, sin necesidad de concretar los datos afectados.', false), ('B', 'Los motivos por los que se opone al tratamiento de sus datos.', false), ('C', 'La finalidad para la que pretende usar los datos una vez rectificados.', false), ('D', 'A qué datos se refiere y la corrección que haya de realizarse, acompañando cuando sea preciso la documentación justificativa.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'De acuerdo con el artículo 16.2 de la Ley Orgánica 3/2018, el hecho de que el tratamiento de los datos personales esté limitado:', 'El art. 16.2 LOPDGDD exige que la limitación del tratamiento conste claramente en los sistemas de información del responsable.', 'age_aux_b1_12_proteccion_datos', (select id from public.topics where slug = 'age-aux-b1-12-proteccion-datos'), 1, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2018-16673'), 'Art. 16.2 LOPDGDD', '2. El hecho de que el tratamiento de los datos personales esté limitado debe constar claramente en los sistemas de información del responsable.', null, 'e4fcf74baf33c2d23f71cc788d96dc630f4a5b39663dfece4513e00d39f74ddc', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'e4fcf74baf33c2d23f71cc788d96dc630f4a5b39663dfece4513e00d39f74ddc')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Debe comunicarse a la Agencia Española de Protección de Datos en el plazo de diez días.', false), ('B', 'Debe publicarse en el Boletín Oficial del Estado.', false), ('C', 'Debe constar claramente en los sistemas de información del responsable.', true), ('D', 'Obliga a destruir los datos en el plazo de un mes.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 22.3 de la Ley Orgánica 3/2018, cuando las imágenes de videovigilancia hayan de conservarse para acreditar la comisión de actos que atenten contra la integridad de personas, bienes o instalaciones, deberán ponerse a disposición de la autoridad competente en un plazo máximo de:', 'El art. 22.3 LOPDGDD fija la supresión en un mes como regla y, si deben conservarse como prueba, su entrega a la autoridad en un máximo de setenta y dos horas desde que se conozca la grabación.', 'age_aux_b1_12_proteccion_datos', (select id from public.topics where slug = 'age-aux-b1-12-proteccion-datos'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2018-16673'), 'Art. 22.3 LOPDGDD', 'En tal caso, las imágenes deberán ser puestas a disposición de la autoridad competente en un plazo máximo de setenta y dos horas desde que se tuviera conocimiento de la existencia de la grabación.', null, 'a636e4c847efd5cdaf5a355596d3c97af612e0b76f2fb4975f3485d79d61b252', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'a636e4c847efd5cdaf5a355596d3c97af612e0b76f2fb4975f3485d79d61b252')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Setenta y dos horas desde que se tuviera conocimiento de la existencia de la grabación.', true), ('B', 'Veinticuatro horas desde la captación de las imágenes.', false), ('C', 'Diez días desde que se tuviera conocimiento de la existencia de la grabación.', false), ('D', 'Un mes desde la captación de las imágenes.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'De acuerdo con el artículo 22.5 de la Ley Orgánica 3/2018, se considera excluido del ámbito de aplicación del Reglamento (UE) 2016/679:', 'El art. 22.5 LOPDGDD excluye el tratamiento por una persona física de imágenes que solo capten el interior de su propio domicilio; la exclusión no abarca a la empresa de seguridad contratada que tenga acceso a las imágenes.', 'age_aux_b1_12_proteccion_datos', (select id from public.topics where slug = 'age-aux-b1-12-proteccion-datos'), 1, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2018-16673'), 'Art. 22.5 LOPDGDD', 'se considera excluido de su ámbito de aplicación el tratamiento por una persona física de imágenes que solamente capten el interior de su propio domicilio.', null, 'd55e9e4fd5a3b7f828558b6f8396e5762dc860e862ebe39cd27e15fcde767eea', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'd55e9e4fd5a3b7f828558b6f8396e5762dc860e862ebe39cd27e15fcde767eea')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Cualquier tratamiento de imágenes realizado por una empresa de seguridad privada.', false), ('B', 'El tratamiento por una persona física de imágenes que solamente capten el interior de su propio domicilio.', true), ('C', 'La captación por una comunidad de propietarios de imágenes de la vía pública.', false), ('D', 'El tratamiento de imágenes de trabajadores por el empleador.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 31.2 de la Ley Orgánica 3/2018, los sujetos enumerados en su artículo 77.1, como las Administraciones Públicas, harán público:', 'El art. 31.2 LOPDGDD obliga a los sujetos del art. 77.1 a publicar un inventario de sus actividades de tratamiento accesible electrónicamente, con la información del art. 30 RGPD y su base legal.', 'age_aux_b1_12_proteccion_datos', (select id from public.topics where slug = 'age-aux-b1-12-proteccion-datos'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2018-16673'), 'Art. 31.2 LOPDGDD', '2. Los sujetos enumerados en el artículo 77.1 de esta ley orgánica harán público un inventario de sus actividades de tratamiento accesible por medios electrónicos en el que constará la información establecida en el artículo 30 del Reglamento (UE) 2016/679 y su base legal.', null, 'bc54f906d3fe3da795890e517a4bd4af578157067d57dc745d98946cc37d907e', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'bc54f906d3fe3da795890e517a4bd4af578157067d57dc745d98946cc37d907e')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'La lista de las personas que han ejercido el derecho de acceso durante el año.', false), ('B', 'Las evaluaciones de impacto realizadas, con los datos de los afectados.', false), ('C', 'Un inventario de sus actividades de tratamiento accesible por medios electrónicos, con la información del artículo 30 del Reglamento (UE) 2016/679 y su base legal.', true), ('D', 'El nombre de todos los empleados con acceso a datos personales.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'De acuerdo con el artículo 33.2 de la Ley Orgánica 3/2018, quien figurando como encargado del tratamiento utilizase los datos para sus propias finalidades:', 'El art. 33.2 LOPDGDD considera responsable, y no encargado, a quien figurando como encargado use los datos para sus propias finalidades.', 'age_aux_b1_12_proteccion_datos', (select id from public.topics where slug = 'age-aux-b1-12-proteccion-datos'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2018-16673'), 'Art. 33.2 LOPDGDD', 'Tendrá asimismo la consideración de responsable del tratamiento quien figurando como encargado utilizase los datos para sus propias finalidades.', null, '3300699ef6b169a9eff13944779e0549bb99d84074de0e788fbfc570358ad809', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '3300699ef6b169a9eff13944779e0549bb99d84074de0e788fbfc570358ad809')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Seguirá siendo encargado, aunque deberá informar al responsable.', false), ('B', 'Tendrá la consideración de responsable del tratamiento.', true), ('C', 'Tendrá la consideración de tercero sin obligaciones de protección de datos.', false), ('D', 'Pasará a ser corresponsable solo si lo autoriza la Agencia Española de Protección de Datos.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 34.1 de la Ley Orgánica 3/2018, ¿cuál de las siguientes entidades deberá designar en todo caso un delegado de protección de datos?', 'El art. 34.1 LOPDGDD enumera entidades obligadas a designar DPD, empezando por los colegios profesionales y sus consejos generales; exceptúa expresamente a los profesionales sanitarios que ejerzan a título individual.', 'age_aux_b1_12_proteccion_datos', (select id from public.topics where slug = 'age-aux-b1-12-proteccion-datos'), 1, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2018-16673'), 'Art. 34.1.a) LOPDGDD', 'a) Los colegios profesionales y sus consejos generales.', null, 'edea224503bf913bcf4fbcae129e52e043c10258c7b76d7266dafee23531af4a', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'edea224503bf913bcf4fbcae129e52e043c10258c7b76d7266dafee23531af4a')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Los profesionales de la salud que ejerzan su actividad a título individual.', false), ('B', 'Cualquier comercio minorista que disponga de una lista de clientes.', false), ('C', 'Las comunidades de propietarios.', false), ('D', 'Los colegios profesionales y sus consejos generales.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'De acuerdo con el artículo 36.3 de la Ley Orgánica 3/2018, en el ejercicio de sus funciones el delegado de protección de datos tendrá acceso a los datos personales y procesos de tratamiento:', 'El art. 36.3 LOPDGDD garantiza al DPD el acceso a datos y procesos, sin que pueda oponérsele ningún deber de confidencialidad o secreto, ni siquiera el del art. 5.', 'age_aux_b1_12_proteccion_datos', (select id from public.topics where slug = 'age-aux-b1-12-proteccion-datos'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2018-16673'), 'Art. 36.3 LOPDGDD', '3. En el ejercicio de sus funciones el delegado de protección de datos tendrá acceso a los datos personales y procesos de tratamiento, no pudiendo oponer a este acceso el responsable o el encargado del tratamiento la existencia de cualquier deber de confidencialidad o secreto, incluyendo el previsto en el artículo 5 de esta ley orgánica.', null, '2cd3d30e00ca292704b3a298e3dd703d3ff04b788d71ab76f8192d63f446f913', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '2cd3d30e00ca292704b3a298e3dd703d3ff04b788d71ab76f8192d63f446f913')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Sin que el responsable o el encargado puedan oponer la existencia de cualquier deber de confidencialidad o secreto.', true), ('B', 'Solo previa autorización escrita del responsable del tratamiento.', false), ('C', 'Salvo que se trate de datos sujetos al deber de confidencialidad del artículo 5.', false), ('D', 'Únicamente cuando lo requiera la Agencia Española de Protección de Datos.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 37.2 de la Ley Orgánica 3/2018, cuando el afectado presente una reclamación ante la Agencia Española de Protección de Datos, esta podrá remitirla al delegado de protección de datos para que responda en el plazo de:', 'El art. 37.2 LOPDGDD permite a la autoridad remitir la reclamación al DPD para que responda en un mes; si no lo hace, el procedimiento continúa. El plazo de dos meses es el del DPD cuando el afectado se dirige primero a él (art. 37.1).', 'age_aux_b1_12_proteccion_datos', (select id from public.topics where slug = 'age-aux-b1-12-proteccion-datos'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2018-16673'), 'Art. 37.2 LOPDGDD', 'aquellas podrán remitir la reclamación al delegado de protección de datos a fin de que este responda en el plazo de un mes.', null, 'ce33529fa22becb5b5cbd945bf52a33100dfc9b889790762a69b4ffbaf3de56b', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'ce33529fa22becb5b5cbd945bf52a33100dfc9b889790762a69b4ffbaf3de56b')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Dos meses.', false), ('B', 'Diez días.', false), ('C', 'Un mes.', true), ('D', 'Tres meses.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'De acuerdo con el artículo 44.2 de la Ley Orgánica 3/2018, la Agencia Española de Protección de Datos tendrá la condición de representante común de las autoridades de protección de datos del Reino de España en:', 'El art. 44.2 LOPDGDD atribuye a la AEPD la representación común de las autoridades españolas de protección de datos en el Comité Europeo de Protección de Datos.', 'age_aux_b1_12_proteccion_datos', (select id from public.topics where slug = 'age-aux-b1-12-proteccion-datos'), 1, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2018-16673'), 'Art. 44.2 LOPDGDD', '2. La Agencia Española de Protección de Datos tendrá la condición de representante común de las autoridades de protección de datos del Reino de España en el Comité Europeo de Protección de Datos.', null, '52b340d854615e3acd0141aa474dd469b33646e950056219cdfbde764936ff07', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '52b340d854615e3acd0141aa474dd469b33646e950056219cdfbde764936ff07')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El Consejo de la Unión Europea.', false), ('B', 'El Comité Europeo de Protección de Datos.', true), ('C', 'El Consejo de Transparencia y Buen Gobierno.', false), ('D', 'El Tribunal de Justicia de la Unión Europea.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 46.2 de la Ley Orgánica 3/2018, la Presidencia de la Agencia Española de Protección de Datos puede autorizar las modificaciones presupuestarias que impliquen, siempre que no se incrementen los créditos para gastos de personal, hasta:', 'El art. 46.2 LOPDGDD permite a la Presidencia autorizar modificaciones de hasta el 3 % del presupuesto inicial de gastos; las que no excedan del 5 % las autoriza el Ministerio de Hacienda y las demás, el Gobierno.', 'age_aux_b1_12_proteccion_datos', (select id from public.topics where slug = 'age-aux-b1-12-proteccion-datos'), 3, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2018-16673'), 'Art. 46.2 LOPDGDD', 'Corresponde a la Presidencia de la Agencia Española de Protección de Datos autorizar las modificaciones presupuestarias que impliquen hasta un tres por ciento de la cifra inicial de su presupuesto total de gastos, siempre que no se incrementen los créditos para gastos de personal.', null, '138b1e45ca0ada2afb3cb95817ec1e77fd4dbaf95d77a76fd2c57e7b2bd56bb0', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '138b1e45ca0ada2afb3cb95817ec1e77fd4dbaf95d77a76fd2c57e7b2bd56bb0')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Un cinco por ciento de la cifra inicial de su presupuesto total de gastos.', false), ('B', 'Un diez por ciento de la cifra inicial de su presupuesto total de gastos.', false), ('C', 'Un uno por ciento de la cifra inicial de su presupuesto total de gastos.', false), ('D', 'Un tres por ciento de la cifra inicial de su presupuesto total de gastos.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'De acuerdo con el artículo 48.6 de la Ley Orgánica 3/2018, los actos y disposiciones dictados por la Presidencia de la Agencia Española de Protección de Datos:', 'El art. 48.6 LOPDGDD declara que los actos y disposiciones de la Presidencia agotan la vía administrativa y se recurren directamente ante la Sala de lo Contencioso-administrativo de la Audiencia Nacional.', 'age_aux_b1_12_proteccion_datos', (select id from public.topics where slug = 'age-aux-b1-12-proteccion-datos'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2018-16673'), 'Art. 48.6 LOPDGDD', '6. Los actos y disposiciones dictados por la Presidencia de la Agencia Española de Protección de Datos ponen fin a la vía administrativa, siendo recurribles, directamente, ante la Sala de lo Contencioso-administrativo de la Audiencia Nacional.', null, '7d50cc9ca8225f7754a972dcb7170ed08376d3bcb29357a4422dca91c1cbc824', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '7d50cc9ca8225f7754a972dcb7170ed08376d3bcb29357a4422dca91c1cbc824')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Ponen fin a la vía administrativa y son recurribles directamente ante la Sala de lo Contencioso-administrativo de la Audiencia Nacional.', true), ('B', 'Son recurribles en alzada ante el Ministro de Justicia.', false), ('C', 'Ponen fin a la vía administrativa y son recurribles ante la Sala de lo Contencioso-administrativo del Tribunal Supremo.', false), ('D', 'Son recurribles en reposición obligatoria ante el Consejo Consultivo de la Agencia.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 64.2 de la Ley Orgánica 3/2018, el procedimiento de la Agencia Española de Protección de Datos que tenga por objeto determinar la posible existencia de una infracción tendrá una duración máxima de:', 'El art. 64.2 LOPDGDD fija doce meses desde el acuerdo de inicio, con caducidad y archivo al vencer. Seis meses es el plazo del procedimiento por falta de atención de derechos (art. 64.1) y del de apercibimiento (art. 64.3).', 'age_aux_b1_12_proteccion_datos', (select id from public.topics where slug = 'age-aux-b1-12-proteccion-datos'), 3, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2018-16673'), 'Art. 64.2 LOPDGDD', 'El procedimiento tendrá una duración máxima de doce meses a contar desde la fecha del acuerdo de inicio. Transcurrido ese plazo se producirá su caducidad y, en consecuencia, el archivo de actuaciones.', null, 'd3db8fcdc252fc5b02edf003456f4574e41922bcbe61a3b2bc180a326d3f6716', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'd3db8fcdc252fc5b02edf003456f4574e41922bcbe61a3b2bc180a326d3f6716')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Doce meses desde la fecha del acuerdo de inicio, transcurridos los cuales se producirá su caducidad.', true), ('B', 'Seis meses desde la fecha del acuerdo de inicio, transcurridos los cuales se entenderá estimada la reclamación.', false), ('C', 'Dieciocho meses desde la admisión a trámite de la reclamación.', false), ('D', 'Nueve meses desde la fecha del acuerdo de inicio, transcurridos los cuales se producirá su caducidad.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'De acuerdo con el artículo 67.2 de la Ley Orgánica 3/2018, las actuaciones previas de investigación de la Agencia Española de Protección de Datos no podrán tener una duración superior a:', 'El art. 67.2 LOPDGDD limita las actuaciones previas de investigación a dieciocho meses desde la admisión a trámite o desde el acuerdo de iniciación cuando la Agencia actúe por propia iniciativa.', 'age_aux_b1_12_proteccion_datos', (select id from public.topics where slug = 'age-aux-b1-12-proteccion-datos'), 3, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2018-16673'), 'Art. 67.2 LOPDGDD', 'y no podrán tener una duración superior a dieciocho meses a contar desde la fecha del acuerdo de admisión a trámite', null, 'fa09a8085478cac526ba433fad96e36b1663a480a53b64de8d566f2f94952446', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'fa09a8085478cac526ba433fad96e36b1663a480a53b64de8d566f2f94952446')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Doce meses.', false), ('B', 'Seis meses.', false), ('C', 'Dieciocho meses.', true), ('D', 'Veinticuatro meses.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 76.4 de la Ley Orgánica 3/2018, cuando la autoridad competente sea la Agencia Española de Protección de Datos, será objeto de publicación en el Boletín Oficial del Estado la información que identifique al infractor, la infracción y el importe de la sanción cuando:', 'El art. 76.4 LOPDGDD exige la publicación en el BOE cuando la sanción la imponga la AEPD, supere un millón de euros y el infractor sea persona jurídica.', 'age_aux_b1_12_proteccion_datos', (select id from public.topics where slug = 'age-aux-b1-12-proteccion-datos'), 3, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2018-16673'), 'Art. 76.4 LOPDGDD', 'cuando la autoridad competente sea la Agencia Española de Protección de Datos, la sanción fuese superior a un millón de euros y el infractor sea una persona jurídica.', null, '218e6eddab96a6a8df45d53bcc2ad606163f32e0bfd8c5932a31af8a47c4bc31', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '218e6eddab96a6a8df45d53bcc2ad606163f32e0bfd8c5932a31af8a47c4bc31')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'La sanción sea superior a 300.000 euros, cualquiera que sea el infractor.', false), ('B', 'La sanción sea superior a un millón de euros y el infractor sea una persona jurídica.', true), ('C', 'La infracción sea muy grave y el infractor sea una persona física.', false), ('D', 'Lo solicite el afectado que presentó la reclamación.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'De acuerdo con el artículo 78.1 de la Ley Orgánica 3/2018, las sanciones por importe comprendido entre 40.001 y 300.000 euros prescriben:', 'El art. 78.1 LOPDGDD fija la prescripción de las sanciones por cuantía: hasta 40.000 euros, un año; de 40.001 a 300.000, dos años; más de 300.000, tres años.', 'age_aux_b1_12_proteccion_datos', (select id from public.topics where slug = 'age-aux-b1-12-proteccion-datos'), 3, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2018-16673'), 'Art. 78.1 LOPDGDD', 'b) Las sanciones por importe comprendido entre 40.001 y 300.000 euros prescriben a los dos años.', null, 'fed69c8d7f4ab6e60ed6e78706587b9729650afbd1978b35c0bdf065704b3b8b', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'fed69c8d7f4ab6e60ed6e78706587b9729650afbd1978b35c0bdf065704b3b8b')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Al año.', false), ('B', 'A los tres años.', false), ('C', 'A los cuatro años.', false), ('D', 'A los dos años.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
-- Lote age-aux-b1-14-derechos-deberes-funcionarios-trebep-v1 (2 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Real Decreto Legislativo 5/2015, de 30 de octubre, texto refundido de la Ley del Estatuto Básico del Empleado Público (texto consolidado, BOE)', 'https://www.boe.es/buscar/act.php?id=BOE-A-2015-11719', 'boe'::public.source_kind, 'Agencia Estatal Boletín Oficial del Estado', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('age-aux-b1-14-derechos-deberes-funcionarios', 'I.14 Derechos y deberes de los funcionarios, retribuciones y régimen disciplinario') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('auxiliar-administrativo-estado') and t.slug = 'age-aux-b1-14-derechos-deberes-funcionarios' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 94 del TREBEP, cuando de la instrucción de un procedimiento disciplinario resulten indicios fundados de criminalidad:', 'El art. 94.3 TREBEP ordena suspender la tramitación y comunicarlo al Ministerio Fiscal; además, los hechos declarados probados por resoluciones judiciales firmes vinculan a la Administración.', 'age_aux_b1_14_derechos_deberes_funcionarios', (select id from public.topics where slug = 'age-aux-b1-14-derechos-deberes-funcionarios'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2015-11719'), 'Art. 94.3 TREBEP', 'Cuando de la instrucción de un procedimiento disciplinario resulte la existencia de indicios fundados de criminalidad, se suspenderá su tramitación poniéndolo en conocimiento del Ministerio Fiscal.', null, 'd7f185971db493cd865e64d28387802b1548aa18afa395191706d3fe87089cf7', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'd7f185971db493cd865e64d28387802b1548aa18afa395191706d3fe87089cf7')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Se suspenderá su tramitación poniéndolo en conocimiento del Ministerio Fiscal.', true), ('B', 'Se archivará el procedimiento y se dará traslado del expediente al Juzgado de Instrucción.', false), ('C', 'Continuará su tramitación, pero la sanción no podrá ejecutarse hasta que exista sentencia firme.', false), ('D', 'Se suspenderá su tramitación poniéndolo en conocimiento de la Inspección General de Servicios.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'De acuerdo con el artículo 26 del TREBEP, las retribuciones de los funcionarios en prácticas se corresponderán, como mínimo, a las del:', 'El art. 26 TREBEP deja a cada Administración fijar las retribuciones de los funcionarios en prácticas, con el mínimo del sueldo del Subgrupo o Grupo al que aspiran a ingresar.', 'age_aux_b1_14_derechos_deberes_funcionarios', (select id from public.topics where slug = 'age-aux-b1-14-derechos-deberes-funcionarios'), 1, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2015-11719'), 'Art. 26 TREBEP', 'Las Administraciones Públicas determinarán las retribuciones de los funcionarios en prácticas que, como mínimo, se corresponderán a las del sueldo del Subgrupo o Grupo, en el supuesto de que éste no tenga Subgrupo, en que aspiren a ingresar.', null, '04178590b5993eac0e9deeee7eff7f112a45a08c00b8dca5928250fd7e1187d5', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '04178590b5993eac0e9deeee7eff7f112a45a08c00b8dca5928250fd7e1187d5')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Sueldo y trienios del Subgrupo o Grupo en que aspiren a ingresar.', false), ('B', 'Sueldo del Subgrupo o Grupo en que aspiren a ingresar.', true), ('C', 'Salario mínimo interprofesional vigente.', false), ('D', 'Complemento de destino del nivel mínimo del Subgrupo en que aspiren a ingresar.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
-- Lote age-aux-b1-15-presupuesto-ce-v1 (2 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Constitución Española (texto consolidado, BOE)', 'https://www.boe.es/buscar/act.php?id=BOE-A-1978-31229', 'boe'::public.source_kind, 'Agencia Estatal Boletín Oficial del Estado', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('age-aux-b1-15-presupuesto', 'I.15 El presupuesto del Estado') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('auxiliar-administrativo-estado') and t.slug = 'age-aux-b1-15-presupuesto' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 134 de la Constitución Española, los Presupuestos Generales del Estado tendrán carácter:', 'El art. 134.2 CE fija el carácter anual de los Presupuestos, que incluyen todos los gastos e ingresos del sector público estatal y consignan el importe de los beneficios fiscales que afecten a los tributos del Estado.', 'age_aux_b1_15_presupuesto', (select id from public.topics where slug = 'age-aux-b1-15-presupuesto'), 1, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1978-31229'), 'Art. 134.2 CE', 'Los Presupuestos Generales del Estado tendrán carácter anual, incluirán la totalidad de los gastos e ingresos del sector público estatal y en ellos se consignará el importe de los beneficios fiscales que afecten a los tributos del Estado.', null, 'd0a304e532ad8dbfcdd6b34ee891528d844362250fdee4acf86fd359282277d9', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'd0a304e532ad8dbfcdd6b34ee891528d844362250fdee4acf86fd359282277d9')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Bienal, e incluirán la totalidad de los gastos e ingresos del sector público estatal.', false), ('B', 'Anual, e incluirán solo los gastos e ingresos de la Administración General del Estado.', false), ('C', 'Anual, e incluirán la totalidad de los gastos e ingresos del sector público estatal.', true), ('D', 'Plurianual, ajustado a la duración de la legislatura.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'De acuerdo con el artículo 134 de la Constitución, una vez aprobados los Presupuestos Generales del Estado, los proyectos de ley que impliquen aumento del gasto público o disminución de los ingresos del mismo ejercicio presupuestario:', 'El art. 134.5 CE permite al Gobierno, aprobados los Presupuestos, presentar proyectos de ley que aumenten el gasto o disminuyan los ingresos del mismo ejercicio.', 'age_aux_b1_15_presupuesto', (select id from public.topics where slug = 'age-aux-b1-15-presupuesto'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1978-31229'), 'Art. 134.5 CE', 'Aprobados los Presupuestos Generales del Estado, el Gobierno podrá presentar proyectos de ley que impliquen aumento del gasto público o disminución de los ingresos correspondientes al mismo ejercicio presupuestario.', null, '0cfd8a0e39fe4c633e92f050ba76373e3c2cf16adab53027fe41faedf1960c74', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '0cfd8a0e39fe4c633e92f050ba76373e3c2cf16adab53027fe41faedf1960c74')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Podrán ser presentados por el Gobierno.', true), ('B', 'No podrán presentarse hasta el ejercicio siguiente.', false), ('C', 'Solo podrán presentarse por el Gobierno con autorización previa del Congreso de los Diputados.', false), ('D', 'Solo podrán tramitarse si cuentan con el informe favorable del Tribunal de Cuentas.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
-- Lote age-aux-b1-15-presupuesto-lgp-v1 (18 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Ley 47/2003, de 26 de noviembre, General Presupuestaria (texto consolidado, BOE)', 'https://www.boe.es/buscar/act.php?id=BOE-A-2003-21614', 'boe'::public.source_kind, 'Agencia Estatal Boletín Oficial del Estado', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('age-aux-b1-15-presupuesto', 'I.15 El presupuesto del Estado') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('auxiliar-administrativo-estado') and t.slug = 'age-aux-b1-15-presupuesto' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 28 de la Ley General Presupuestaria, los escenarios presupuestarios plurianuales determinarán los límites que la acción de gobierno debe respetar referidos a:', 'El art. 28.1 LGP refiere los límites de los escenarios presupuestarios plurianuales a los tres ejercicios siguientes.', 'age_aux_b1_15_presupuesto', (select id from public.topics where slug = 'age-aux-b1-15-presupuesto'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2003-21614'), 'Art. 28.1 LGP', 'Los escenarios presupuestarios plurianuales determinarán los límites, referidos a los tres ejercicios siguientes', null, 'bd0f0e0c3e5df1db85e4e98ffeb040208b6a83e49339a4a36b1c1493afc08bd5', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'bd0f0e0c3e5df1db85e4e98ffeb040208b6a83e49339a4a36b1c1493afc08bd5')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Los dos ejercicios siguientes.', false), ('B', 'Los cuatro ejercicios siguientes.', false), ('C', 'Los cinco ejercicios siguientes.', false), ('D', 'Los tres ejercicios siguientes.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'De acuerdo con la Ley General Presupuestaria, ¿quién confecciona los escenarios presupuestarios plurianuales?', 'El art. 28.3 LGP atribuye su confección al Ministerio de Hacienda, que da cuenta al Consejo de Ministros antes de aprobarse el proyecto de Ley de Presupuestos de cada año.', 'age_aux_b1_15_presupuesto', (select id from public.topics where slug = 'age-aux-b1-15-presupuesto'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2003-21614'), 'Art. 28.3 LGP', 'Los escenarios presupuestarios plurianuales serán confeccionados por el Ministerio de Hacienda, que dará cuenta de los mismos al Consejo de Ministros con anterioridad a la aprobación del proyecto de Ley de Presupuestos Generales del Estado de cada año', null, 'c270bb0cb426e276bfb2a2866f92215a20ff4547f4a023e959e500985d05bfd5', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'c270bb0cb426e276bfb2a2866f92215a20ff4547f4a023e959e500985d05bfd5')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'La Comisión de Políticas de Gasto.', false), ('B', 'El Ministerio de Hacienda, que dará cuenta de ellos al Consejo de Ministros.', true), ('C', 'Cada ministerio, respecto de sus centros gestores.', false), ('D', 'La Oficina Presupuestaria de las Cortes Generales.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 28 de la Ley General Presupuestaria, los escenarios presupuestarios plurianuales estarán integrados por:', 'El art. 28.4 LGP los compone de un escenario de ingresos y otro de gastos.', 'age_aux_b1_15_presupuesto', (select id from public.topics where slug = 'age-aux-b1-15-presupuesto'), 1, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2003-21614'), 'Art. 28.4 LGP', 'Los escenarios presupuestarios plurianuales estarán integrados por un escenario de ingresos y un escenario de gastos.', null, '9199a0db4cc72daddc1ceab242a53ff5c15c523de873aa8925a2fa2507847b56', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '9199a0db4cc72daddc1ceab242a53ff5c15c523de873aa8925a2fa2507847b56')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Un escenario de gastos corrientes y un escenario de gastos de capital.', false), ('B', 'Un escenario macroeconómico y un escenario fiscal.', false), ('C', 'Un escenario de ingresos y un escenario de gastos.', true), ('D', 'Un escenario del Estado y un escenario de la Seguridad Social.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según la Ley General Presupuestaria, el programa plurianual de cada ministerio, que contiene los programas de todos los centros gestores que de él dependen, se aprobará por:', 'El art. 29.3 LGP dispone que el programa plurianual de cada ministerio lo aprueba el Ministro.', 'age_aux_b1_15_presupuesto', (select id from public.topics where slug = 'age-aux-b1-15-presupuesto'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2003-21614'), 'Art. 29.3 LGP', 'El programa plurianual de cada ministerio contendrá los programas de todos los centros gestores que de él dependan y se aprobará por el Ministro.', null, '4db230f4036f707fcdfbc836a7b6b776cbdf440ba7ca2d21143ea12fc5f33365', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '4db230f4036f707fcdfbc836a7b6b776cbdf440ba7ca2d21143ea12fc5f33365')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El Ministro.', true), ('B', 'El Consejo de Ministros.', false), ('C', 'El Ministro de Hacienda.', false), ('D', 'El Subsecretario del departamento.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'De acuerdo con el artículo 27 de la Ley General Presupuestaria, los derechos liquidados y las obligaciones reconocidas se aplicarán a los presupuestos:', 'El art. 27.4 LGP recoge el principio de presupuesto bruto: aplicación por el importe íntegro, sin minorar derechos para atender obligaciones, salvo que la ley lo autorice expresamente.', 'age_aux_b1_15_presupuesto', (select id from public.topics where slug = 'age-aux-b1-15-presupuesto'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2003-21614'), 'Art. 27.4 LGP', 'Los derechos liquidados y las obligaciones reconocidas se aplicarán a los presupuestos por su importe íntegro, sin que puedan atenderse obligaciones mediante minoración de los derechos a liquidar o ya ingresados, salvo que la ley lo autorice de modo expreso.', null, '60c336370b93311fc633e7f499a3b2b00c5270749df550fa5cdcaededc9b7f61', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '60c336370b93311fc633e7f499a3b2b00c5270749df550fa5cdcaededc9b7f61')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Por su importe neto, una vez compensados entre sí.', false), ('B', 'Por su importe medio en el ejercicio.', false), ('C', 'Por el importe que determine el Ministerio de Hacienda en cada caso.', false), ('D', 'Por su importe íntegro, sin que puedan atenderse obligaciones mediante minoración de los derechos, salvo autorización legal expresa.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 27 de la Ley General Presupuestaria, los recursos del Estado se destinarán a satisfacer el conjunto de sus obligaciones:', 'El art. 27.3 LGP establece la regla general de no afectación de los recursos, que solo puede excepcionarse por ley.', 'age_aux_b1_15_presupuesto', (select id from public.topics where slug = 'age-aux-b1-15-presupuesto'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2003-21614'), 'Art. 27.3 LGP', 'Los recursos del Estado, los de cada uno de sus organismos autónomos y los de las entidades integrantes del sector público estatal con presupuesto limitativo se destinarán a satisfacer el conjunto de sus respectivas obligaciones, salvo que por ley se establezca su afectación a fines determinados.', null, '222292b3196be5749e0da438583866914cf4cd760391752e35b374706dabb23e', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '222292b3196be5749e0da438583866914cf4cd760391752e35b374706dabb23e')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Salvo que el Consejo de Ministros acuerde su afectación a fines determinados.', false), ('B', 'Salvo que por ley se establezca su afectación a fines determinados.', true), ('C', 'Salvo que el Ministro de Hacienda acuerde su afectación a fines determinados.', false), ('D', 'Sin excepción alguna.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 34 de la Ley General Presupuestaria, las obligaciones que resulten de la liquidación de atrasos a favor del personal y las que tengan su origen en resoluciones judiciales se aplicarán a los créditos:', 'El art. 34.2 LGP exceptúa estas obligaciones de la regla general y las imputa al presupuesto vigente cuando se expiden las órdenes de pago.', 'age_aux_b1_15_presupuesto', (select id from public.topics where slug = 'age-aux-b1-15-presupuesto'), 3, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2003-21614'), 'Art. 34.2 LGP', 'se aplicarán a los créditos del presupuesto vigente en el momento de la expedición de las órdenes de pago, las obligaciones que resulten de la liquidación de atrasos a favor del personal que perciba sus retribuciones con cargo a los Presupuestos Generales del Estado así como las que tengan su origen en resoluciones judiciales.', null, '0fee183c81cc8f47f61e6b052f0f59584aeedd4808cd4ea530cac20f9c2e126a', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '0fee183c81cc8f47f61e6b052f0f59584aeedd4808cd4ea530cac20f9c2e126a')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Del presupuesto del ejercicio en que se devengaron.', false), ('B', 'Del presupuesto vigente en el momento de la expedición de las órdenes de pago.', true), ('C', 'Del Fondo de Contingencia de ejecución presupuestaria.', false), ('D', 'Del presupuesto del ejercicio en que la resolución judicial adquiera firmeza.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según la Ley General Presupuestaria, ¿a quién corresponde elevar al acuerdo del Gobierno el anteproyecto de la Ley de Presupuestos Generales del Estado?', 'El art. 36.5 LGP atribuye al Ministro de Hacienda la elevación del anteproyecto al Gobierno.', 'age_aux_b1_15_presupuesto', (select id from public.topics where slug = 'age-aux-b1-15-presupuesto'), 1, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2003-21614'), 'Art. 36.5 LGP', 'Corresponderá al Ministro de Hacienda elevar al acuerdo del Gobierno el anteproyecto de la Ley de Presupuestos Generales del Estado.', null, 'de2bdf49f2a6c9da26d070eec0fa6e68b9408a08a750a2202918f623bf843611', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'de2bdf49f2a6c9da26d070eec0fa6e68b9408a08a750a2202918f623bf843611')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Al Ministro de Hacienda.', true), ('B', 'Al Presidente del Gobierno.', false), ('C', 'A la Comisión de Políticas de Gasto.', false), ('D', 'Al Ministro de la Presidencia.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'De acuerdo con el artículo 41 de la Ley General Presupuestaria, los estados de ingresos se estructurarán siguiendo las clasificaciones:', 'A diferencia de los estados de gastos, los de ingresos solo siguen las clasificaciones orgánica y económica (art. 41 LGP).', 'age_aux_b1_15_presupuesto', (select id from public.topics where slug = 'age-aux-b1-15-presupuesto'), 1, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2003-21614'), 'Art. 41 LGP', 'Los estados de ingresos de los presupuestos a que se refiere el artículo 33.1.ª) de esta ley se estructurarán siguiendo las clasificaciones orgánica y económica', null, '5a01362f48c8a33c2c7c62d08a79b21e660027bdf326d0270340f0452b41dd72', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '5a01362f48c8a33c2c7c62d08a79b21e660027bdf326d0270340f0452b41dd72')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Orgánica, por programas y económica.', false), ('B', 'Funcional y económica.', false), ('C', 'Por programas y funcional.', false), ('D', 'Orgánica y económica.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'En la clasificación económica de los estados de ingresos, la Ley General Presupuestaria incluye las tasas y los precios públicos entre:', 'El art. 41.b) LGP sitúa entre los ingresos corrientes los impuestos directos y cotizaciones sociales, impuestos indirectos, tasas, precios públicos y otros ingresos, transferencias corrientes e ingresos patrimoniales.', 'age_aux_b1_15_presupuesto', (select id from public.topics where slug = 'age-aux-b1-15-presupuesto'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2003-21614'), 'Art. 41.b) LGP', 'En los ingresos corrientes se distinguirán: impuestos directos y cotizaciones sociales, impuestos indirectos, tasas, precios públicos y otros ingresos, transferencias corrientes e ingresos patrimoniales.', null, '53bbc594497c45b5ea10e8cd9457145e5394173762904854312cf8095d808bb3', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '53bbc594497c45b5ea10e8cd9457145e5394173762904854312cf8095d808bb3')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Los ingresos de capital.', false), ('B', 'Las operaciones financieras.', false), ('C', 'Los ingresos corrientes.', true), ('D', 'Los ingresos patrimoniales de capital.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 43 de la Ley General Presupuestaria, en el presupuesto del Estado los créditos para inversiones reales se especificarán con carácter general a nivel de:', 'El art. 43.1 LGP fija como regla el nivel de concepto, salvo gastos de personal y gastos corrientes en bienes y servicios (artículo) e inversiones reales (capítulo).', 'age_aux_b1_15_presupuesto', (select id from public.topics where slug = 'age-aux-b1-15-presupuesto'), 3, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2003-21614'), 'Art. 43.1 LGP', 'En el presupuesto del Estado los créditos se especificarán a nivel de concepto, salvo los créditos destinados a gastos de personal y los gastos corrientes en bienes y servicios, que se especificarán a nivel de artículo y las inversiones reales a nivel de capítulo.', null, '57a27eed46a8116b859674bce3925763923d02e675abcc81c4bbe51f11c1dbc1', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '57a27eed46a8116b859674bce3925763923d02e675abcc81c4bbe51f11c1dbc1')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Concepto.', false), ('B', 'Capítulo.', true), ('C', 'Artículo.', false), ('D', 'Subconcepto.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'En los compromisos de gasto de carácter plurianual, el artículo 47 de la Ley General Presupuestaria establece que el gasto imputado al ejercicio inmediato siguiente no podrá exceder, sobre el crédito inicial, del:', 'El art. 47.2 LGP limita a cuatro el número de ejercicios y fija los porcentajes del 70 % (primer ejercicio siguiente), 60 % (segundo) y 50 % (tercero y cuarto).', 'age_aux_b1_15_presupuesto', (select id from public.topics where slug = 'age-aux-b1-15-presupuesto'), 3, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2003-21614'), 'Art. 47.2 LGP', 'El número de ejercicios a que pueden aplicarse los gastos no será superior a cuatro. El gasto que se impute a cada uno de los ejercicios posteriores no podrá exceder de la cantidad que resulte de aplicar al crédito inicial a que corresponda la operación los siguientes porcentajes: en el ejercicio inmediato siguiente, el 70 por ciento, en el segundo ejercicio, el 60 por ciento, y en los ejercicios tercero y cuarto, el 50 por ciento.', null, '82665dc84d721d60abdcfe4cd0b16594a0eddcffa5cb95ccfbc27d973f073fb2', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '82665dc84d721d60abdcfe4cd0b16594a0eddcffa5cb95ccfbc27d973f073fb2')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', '70 por ciento.', true), ('B', '50 por ciento.', false), ('C', '60 por ciento.', false), ('D', '80 por ciento.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según la Ley General Presupuestaria, los créditos para gastos que en el último día del ejercicio presupuestario no estén afectados al cumplimiento de obligaciones ya reconocidas:', 'El art. 49.2 LGP (temporalidad de los créditos) los anula de pleno derecho, salvo lo previsto en el art. 58 sobre incorporaciones.', 'age_aux_b1_15_presupuesto', (select id from public.topics where slug = 'age-aux-b1-15-presupuesto'), 1, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2003-21614'), 'Art. 49.2 LGP', 'Los créditos para gastos que en el último día del ejercicio presupuestario no estén afectados al cumplimiento de obligaciones ya reconocidas, quedarán anulados de pleno derecho, sin perjuicio de lo establecido en el artículo 58 de esta ley.', null, '94bf2462f9de0a2b4bc76f0ab7651c69e6e65080ef40834246038448aaee4f2f', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '94bf2462f9de0a2b4bc76f0ab7651c69e6e65080ef40834246038448aaee4f2f')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Se incorporarán automáticamente al ejercicio siguiente.', false), ('B', 'Pasarán a dotar el Fondo de Contingencia del ejercicio siguiente.', false), ('C', 'Quedarán anulados de pleno derecho, sin perjuicio de las incorporaciones de crédito.', true), ('D', 'Se mantendrán vigentes durante el primer trimestre del ejercicio siguiente.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select '¿Cuál de las siguientes figuras NO aparece en el artículo 51 de la Ley General Presupuestaria entre las modificaciones de los créditos iniciales?', 'El art. 51 LGP enumera transferencias, generaciones, ampliaciones, créditos extraordinarios y suplementos de crédito, e incorporaciones.', 'age_aux_b1_15_presupuesto', (select id from public.topics where slug = 'age-aux-b1-15-presupuesto'), 1, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2003-21614'), 'Art. 51 LGP', 'a) Transferencias. b) Generaciones. c) Ampliaciones. d) Créditos extraordinarios y suplementos de crédito. e) Incorporaciones.', null, '749f86c8085a3381d27d76aa9656000f82e56897fb6c1382e493be824413049c', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '749f86c8085a3381d27d76aa9656000f82e56897fb6c1382e493be824413049c')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Las generaciones.', false), ('B', 'Las incorporaciones.', false), ('C', 'Las transferencias.', false), ('D', 'Las prórrogas de crédito.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 52 de la Ley General Presupuestaria, las transferencias de crédito no podrán realizarse:', 'El art. 52.1.a) LGP prohíbe transferir desde operaciones financieras al resto de créditos y desde operaciones de capital a operaciones corrientes; sí admite la creación de créditos nuevos.', 'age_aux_b1_15_presupuesto', (select id from public.topics where slug = 'age-aux-b1-15-presupuesto'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2003-21614'), 'Art. 52.1.a) LGP', 'No podrán realizarse desde créditos para operaciones financieras al resto de los créditos, ni desde créditos para operaciones de capital a créditos para operaciones corrientes.', null, '8ddc3427a5c2ab637c97d289f70cd6eedcaf7c98c6999e0b4698724a5ffc7e9e', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '8ddc3427a5c2ab637c97d289f70cd6eedcaf7c98c6999e0b4698724a5ffc7e9e')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Desde créditos para operaciones de capital a créditos para operaciones corrientes.', true), ('B', 'Desde créditos para operaciones corrientes a créditos para operaciones de capital.', false), ('C', 'Entre créditos de una misma sección presupuestaria.', false), ('D', 'Con creación de créditos nuevos.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'De acuerdo con la Ley General Presupuestaria, las modificaciones que incrementan los créditos como consecuencia de la realización de determinados ingresos no previstos o superiores a los contemplados en el presupuesto inicial son:', 'Así define el art. 53.1 LGP las generaciones de crédito.', 'age_aux_b1_15_presupuesto', (select id from public.topics where slug = 'age-aux-b1-15-presupuesto'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2003-21614'), 'Art. 53.1 LGP', 'Las generaciones son modificaciones que incrementan los créditos como consecuencia de la realización de determinados ingresos no previstos o superiores a los contemplados en el presupuesto inicial.', null, '4d33c1846de470a026083af1315bb20c2852ccb9589faaead3fb502c8d06bec2', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '4d33c1846de470a026083af1315bb20c2852ccb9589faaead3fb502c8d06bec2')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Las ampliaciones de crédito.', false), ('B', 'Los suplementos de crédito.', false), ('C', 'Las incorporaciones de crédito.', false), ('D', 'Las generaciones de crédito.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 54 de la Ley General Presupuestaria, tienen excepcionalmente la condición de ampliables, entre otros, los créditos destinados:', 'El art. 54.1 LGP declara ampliables los créditos para pensiones de Clases Pasivas, los de obligaciones específicas derivadas de normas con rango de ley relacionadas en el estado de gastos y los de la Deuda del Estado.', 'age_aux_b1_15_presupuesto', (select id from public.topics where slug = 'age-aux-b1-15-presupuesto'), 3, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2003-21614'), 'Art. 54.1 LGP', 'Excepcionalmente tendrán la condición de ampliables los créditos destinados al pago de pensiones de Clases Pasivas del Estado', null, '747aba793a684b0ff07dcccd198525705fce2bcc668a48c43fcc926ac458a8bd', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '747aba793a684b0ff07dcccd198525705fce2bcc668a48c43fcc926ac458a8bd')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'A gastos corrientes en bienes y servicios de los ministerios.', false), ('B', 'Al pago de pensiones de Clases Pasivas del Estado.', true), ('C', 'A inversiones reales de carácter plurianual.', false), ('D', 'A atenciones protocolarias y representativas.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 75 de la Ley General Presupuestaria, las funciones de Ordenador General de pagos del Estado competen:', 'El art. 75.1 LGP atribuye esas funciones al Director General del Tesoro y Política Financiera, bajo la superior autoridad del Ministro de Economía.', 'age_aux_b1_15_presupuesto', (select id from public.topics where slug = 'age-aux-b1-15-presupuesto'), 3, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2003-21614'), 'Art. 75.1 LGP', 'Bajo la superior autoridad del Ministro de Economía, competen al Director General del Tesoro y Política Financiera las funciones de Ordenador General de pagos del Estado.', null, 'ce14d5dca1bf8313f959089828f3936feed71630dae379461255c4898619e462', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'ce14d5dca1bf8313f959089828f3936feed71630dae379461255c4898619e462')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Al Interventor General de la Administración del Estado.', false), ('B', 'Al Director General de Presupuestos.', false), ('C', 'Al Director General del Tesoro y Política Financiera.', true), ('D', 'Al Subsecretario de cada departamento ministerial.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
-- Lote age-aux-b1-16-igualdad-ldep-v1 (4 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Ley 39/2006, de 14 de diciembre, de Promoción de la Autonomía Personal y Atención a las personas en situación de dependencia (texto consolidado, BOE)', 'https://www.boe.es/buscar/act.php?id=BOE-A-2006-21990', 'boe'::public.source_kind, 'Agencia Estatal Boletín Oficial del Estado', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('age-aux-b1-16-igualdad', 'I.16 Igualdad, violencia de género, LGTBI, discapacidad y dependencia') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('auxiliar-administrativo-estado') and t.slug = 'age-aux-b1-16-igualdad' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 26 de la Ley 39/2006, el Grado I de dependencia se denomina:', 'El art. 26.1 Ley 39/2006 clasifica la dependencia en Grado I (moderada), Grado II (severa) y Grado III (gran dependencia).', 'age_aux_b1_16_igualdad', (select id from public.topics where slug = 'age-aux-b1-16-igualdad'), 1, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2006-21990'), 'Art. 26.1.a) Ley 39/2006', 'a) Grado I. Dependencia moderada', null, '10c4b58483cfd52a29565a47d3637ea914b75a6561d5b0eb58cd7cb3c7563899', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '10c4b58483cfd52a29565a47d3637ea914b75a6561d5b0eb58cd7cb3c7563899')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Dependencia moderada.', true), ('B', 'Dependencia leve.', false), ('C', 'Dependencia severa.', false), ('D', 'Dependencia parcial.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'De acuerdo con el artículo 28 de la Ley 39/2006, el procedimiento para el reconocimiento de la situación de dependencia se iniciará a instancia de la persona interesada o de quien ostente su representación, estableciéndose para su resolución un plazo máximo de:', 'El art. 28.1 Ley 39/2006 fija un plazo máximo de 3 meses para resolver.', 'age_aux_b1_16_igualdad', (select id from public.topics where slug = 'age-aux-b1-16-igualdad'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2006-21990'), 'Art. 28.1 Ley 39/2006', 'El procedimiento se iniciará a instancia de la persona que pueda estar afectada por algún grado de dependencia o de quien ostente su representación, estableciéndose un plazo máximo de 3 meses para su resolución.', null, 'ef422eb150aa9c02dc9a625f3352aa2a8c3ade96d462877ccc357edbcdd4ef6c', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'ef422eb150aa9c02dc9a625f3352aa2a8c3ade96d462877ccc357edbcdd4ef6c')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Tres meses.', true), ('B', 'Un mes.', false), ('C', 'Seis meses.', false), ('D', 'Un año.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'De acuerdo con el artículo 26 de la Ley 39/2006, se encuentra en situación de dependencia severa (Grado II) la persona que necesita ayuda para realizar varias actividades de la vida diaria:', 'El art. 26.1.b) Ley 39/2006 define el Grado II por la ayuda dos o tres veces al día sin apoyo permanente; una vez al día es el Grado I y varias veces al día con apoyo continuo, el Grado III.', 'age_aux_b1_16_igualdad', (select id from public.topics where slug = 'age-aux-b1-16-igualdad'), 3, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2006-21990'), 'Art. 26.1.b) Ley 39/2006', 'b) Grado II. Dependencia severa: cuando la persona necesita ayuda para realizar varias actividades de la vida diaria dos o tres veces al día, pero no requiere el apoyo permanente de una persona cuidadora', null, 'eeefb7a3a6c3c8d71c0650273bb391f416406edda38792968f159f43b54d6034', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'eeefb7a3a6c3c8d71c0650273bb391f416406edda38792968f159f43b54d6034')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Al menos una vez al día, sin requerir el apoyo permanente de una persona cuidadora.', false), ('B', 'Varias veces al día, y necesita el apoyo indispensable y continuo de otra persona.', false), ('C', 'Al menos una vez a la semana.', false), ('D', 'Dos o tres veces al día, pero no requiere el apoyo permanente de una persona cuidadora.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 28 de la Ley 39/2006, el reconocimiento de la situación de dependencia se efectuará mediante resolución expedida por:', 'El art. 28.2 Ley 39/2006 atribuye la resolución a la Administración Autonómica de residencia y le da validez en todo el territorio del Estado; si cambia de residencia, la comunidad de destino determina los servicios (art. 28.4).', 'age_aux_b1_16_igualdad', (select id from public.topics where slug = 'age-aux-b1-16-igualdad'), 3, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2006-21990'), 'Art. 28.2 Ley 39/2006', 'El reconocimiento de la situación de dependencia se efectuará mediante resolución expedida por la Administración Autonómica correspondiente a la residencia del solicitante y tendrá validez en todo el territorio del Estado.', null, 'b6af4f083c91fdce53bf586e25b04f14432a0afbf18eb75b4b366aae86b79319', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'b6af4f083c91fdce53bf586e25b04f14432a0afbf18eb75b4b366aae86b79319')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'La Administración Autonómica correspondiente a la residencia del solicitante, con validez en todo el territorio del Estado.', true), ('B', 'El Instituto de Mayores y Servicios Sociales, con validez en todo el territorio del Estado.', false), ('C', 'La Administración Autonómica correspondiente a la residencia del solicitante, con validez solo en esa comunidad autónoma.', false), ('D', 'El Ayuntamiento del domicilio del solicitante, con validez en todo el territorio del Estado.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
-- Lote age-aux-b1-16-igualdad-lgtbi-v1 (3 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Ley 4/2023, de 28 de febrero, para la igualdad real y efectiva de las personas trans y para la garantía de los derechos de las personas LGTBI (texto consolidado, BOE)', 'https://www.boe.es/buscar/act.php?id=BOE-A-2023-5366', 'boe'::public.source_kind, 'Agencia Estatal Boletín Oficial del Estado', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('age-aux-b1-16-igualdad', 'I.16 Igualdad, violencia de género, LGTBI, discapacidad y dependencia') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('auxiliar-administrativo-estado') and t.slug = 'age-aux-b1-16-igualdad' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'De acuerdo con el artículo 3 de la Ley 4/2023, se entiende por persona trans:', 'El art. 3.k) Ley 4/2023 define así a la persona trans; la primera opción corresponde a la intersexualidad (letra g) y la segunda a la bisexualidad (letra h).', 'age_aux_b1_16_igualdad', (select id from public.topics where slug = 'age-aux-b1-16-igualdad'), 1, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2023-5366'), 'Art. 3.k) Ley 4/2023', 'k) Persona trans: Persona cuya identidad sexual no se corresponde con el sexo asignado al nacer.', null, 'abea9c9f100c7afe82b6aa648e49e3922887e984a9f0c2d77a87eb3f864bd9a9', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'abea9c9f100c7afe82b6aa648e49e3922887e984a9f0c2d77a87eb3f864bd9a9')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Persona nacida con características biológicas que no se corresponden con las nociones socialmente establecidas de los cuerpos masculinos o femeninos.', false), ('B', 'Persona cuya identidad sexual no se corresponde con el sexo asignado al nacer.', true), ('C', 'Persona que siente atracción física, sexual o afectiva hacia personas de diferentes sexos.', false), ('D', 'Persona que ha obtenido la rectificación registral de la mención relativa al sexo.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 43 de la Ley 4/2023, las personas menores de dieciséis años y mayores de catorce pueden solicitar la rectificación registral de la mención relativa al sexo:', 'El art. 43.2 Ley 4/2023 les permite presentar la solicitud por sí mismas, asistidas por sus representantes legales; si hay desacuerdo, se nombra un defensor judicial.', 'age_aux_b1_16_igualdad', (select id from public.topics where slug = 'age-aux-b1-16-igualdad'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2023-5366'), 'Art. 43.2 Ley 4/2023', 'Las personas menores de dieciséis años y mayores de catorce podrán presentar la solicitud por sí mismas, asistidas en el procedimiento por sus representantes legales.', null, 'a0ab93b9476e7216cc3688e443e0dde70dd445aa3aa41b86c22586546d12c6b9', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'a0ab93b9476e7216cc3688e443e0dde70dd445aa3aa41b86c22586546d12c6b9')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Solo mediante autorización judicial.', false), ('B', 'A través de sus representantes legales, sin intervenir personalmente.', false), ('C', 'Por sí mismas, asistidas en el procedimiento por sus representantes legales.', true), ('D', 'Por sí mismas, sin necesidad de asistencia alguna.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 44 de la Ley 4/2023, reiterada y ratificada la solicitud de rectificación registral de la mención relativa al sexo, la persona encargada del Registro Civil dictará resolución dentro del plazo máximo de:', 'El art. 44.9 Ley 4/2023 fija un mes desde la segunda comparecencia; la cita para esa segunda comparecencia debe producirse en el plazo máximo de tres meses (art. 44.8).', 'age_aux_b1_16_igualdad', (select id from public.topics where slug = 'age-aux-b1-16-igualdad'), 3, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2023-5366'), 'Art. 44.9 Ley 4/2023', 'dictará resolución sobre la rectificación registral solicitada dentro del plazo máximo de un mes a contar desde la fecha de la segunda comparecencia.', null, 'd831b3af363684f8a255f1c0f66f14dc45ab76c68435f02c9806289d9cdc8131', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'd831b3af363684f8a255f1c0f66f14dc45ab76c68435f02c9806289d9cdc8131')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Tres meses a contar desde la fecha de la segunda comparecencia.', false), ('B', 'Un mes a contar desde la presentación de la solicitud.', false), ('C', 'Un mes a contar desde la fecha de la segunda comparecencia.', true), ('D', 'Quince días a contar desde la comparecencia inicial.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
-- Lote age-aux-b1-16-igualdad-loi-v1 (10 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Ley Orgánica 3/2007, de 22 de marzo, para la igualdad efectiva de mujeres y hombres (texto consolidado, BOE)', 'https://www.boe.es/buscar/act.php?id=BOE-A-2007-6115', 'boe'::public.source_kind, 'Agencia Estatal Boletín Oficial del Estado', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('age-aux-b1-16-igualdad', 'I.16 Igualdad, violencia de género, LGTBI, discapacidad y dependencia') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('auxiliar-administrativo-estado') and t.slug = 'age-aux-b1-16-igualdad' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 7 de la Ley Orgánica 3/2007, el acoso sexual y el acoso por razón de sexo:', 'El art. 7.3 LO 3/2007 declara que ambas conductas se considerarán en todo caso discriminatorias.', 'age_aux_b1_16_igualdad', (select id from public.topics where slug = 'age-aux-b1-16-igualdad'), 1, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2007-6115'), 'Art. 7.3 LO 3/2007', 'Se considerarán en todo caso discriminatorios el acoso sexual y el acoso por razón de sexo.', null, '383960f338ffea9042bd2617bb6bb7905d78f06f17dd84542fb2dff8e817c2fa', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '383960f338ffea9042bd2617bb6bb7905d78f06f17dd84542fb2dff8e817c2fa')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Solo se considerarán discriminatorios cuando se produzcan en el ámbito laboral.', false), ('B', 'Se considerarán en todo caso discriminatorios.', true), ('C', 'Se considerarán discriminatorios cuando así lo declare una sentencia penal firme.', false), ('D', 'Se considerarán discriminatorios únicamente si son reiterados.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'De acuerdo con el artículo 10 de la Ley Orgánica 3/2007, los actos y las cláusulas de los negocios jurídicos que constituyan o causen discriminación por razón de sexo:', 'El art. 10 LO 3/2007 los declara nulos y sin efecto, y además dan lugar a reparaciones o indemnizaciones reales, efectivas y proporcionadas y, en su caso, a sanciones.', 'age_aux_b1_16_igualdad', (select id from public.topics where slug = 'age-aux-b1-16-igualdad'), 1, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2007-6115'), 'Art. 10 LO 3/2007', 'Los actos y las cláusulas de los negocios jurídicos que constituyan o causen discriminación por razón de sexo se considerarán nulos y sin efecto', null, '63b8df37499c2387a2a19194631a7cf4e278a2d740fb5c87ffec3841fef4efb1', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '63b8df37499c2387a2a19194631a7cf4e278a2d740fb5c87ffec3841fef4efb1')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Serán anulables a instancia de la persona perjudicada en el plazo de un año.', false), ('B', 'Serán válidos, pero darán lugar a una indemnización.', false), ('C', 'Se considerarán nulos y sin efecto.', true), ('D', 'Se considerarán irregularidades no invalidantes.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 55 de la Ley Orgánica 3/2007, la aprobación de convocatorias de pruebas selectivas para el acceso al empleo público deberá acompañarse, salvo en casos de urgencia, de:', 'El art. 55 LO 3/2007 exige un informe de impacto de género, salvo en casos de urgencia.', 'age_aux_b1_16_igualdad', (select id from public.topics where slug = 'age-aux-b1-16-igualdad'), 1, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2007-6115'), 'Art. 55 LO 3/2007', 'La aprobación de convocatorias de pruebas selectivas para el acceso al empleo público deberá acompañarse de un informe de impacto de género, salvo en casos de urgencia', null, '830bed0ccf37eba3dbe1861c720b23b192bc57b693cbde7cc2557866e6df4c70', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '830bed0ccf37eba3dbe1861c720b23b192bc57b693cbde7cc2557866e6df4c70')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Un informe de impacto de género.', true), ('B', 'Un plan de igualdad del órgano convocante.', false), ('C', 'Un dictamen del Instituto de las Mujeres.', false), ('D', 'Una memoria de composición equilibrada del tribunal.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 3 de la Ley Orgánica 3/2007, el principio de igualdad de trato entre mujeres y hombres supone la ausencia de toda discriminación, directa o indirecta, por razón de sexo, y especialmente las derivadas de:', 'El art. 3 LO 3/2007 destaca especialmente las discriminaciones derivadas de la maternidad, la asunción de obligaciones familiares y el estado civil.', 'age_aux_b1_16_igualdad', (select id from public.topics where slug = 'age-aux-b1-16-igualdad'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2007-6115'), 'Art. 3 LO 3/2007', 'El principio de igualdad de trato entre mujeres y hombres supone la ausencia de toda discriminación, directa o indirecta, por razón de sexo, y, especialmente, las derivadas de la maternidad, la asunción de obligaciones familiares y el estado civil.', null, 'dd35804e55ed999faae50a76235c80e964a33807365829b74e9d546f8663b698', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'dd35804e55ed999faae50a76235c80e964a33807365829b74e9d546f8663b698')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'La edad, la nacionalidad y la religión.', false), ('B', 'La orientación sexual, la discapacidad y el origen étnico.', false), ('C', 'La situación laboral, el nivel de renta y el lugar de residencia.', false), ('D', 'La maternidad, la asunción de obligaciones familiares y el estado civil.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'La Ley Orgánica 3/2007 considera discriminación por razón de sexo cualquier trato adverso o efecto negativo que se produzca en una persona como consecuencia de la presentación por su parte de queja, reclamación, denuncia, demanda o recurso destinados a impedir su discriminación. ¿Cómo denomina el artículo 9 esta garantía?', 'El art. 9 LO 3/2007, rubricado «Indemnidad frente a represalias», protege a quien reclama la igualdad de trato frente a cualquier trato adverso.', 'age_aux_b1_16_igualdad', (select id from public.topics where slug = 'age-aux-b1-16-igualdad'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2007-6115'), 'Art. 9 LO 3/2007', 'Artículo 9. Indemnidad frente a represalias. También se considerará discriminación por razón de sexo cualquier trato adverso o efecto negativo que se produzca en una persona como consecuencia de la presentación por su parte de queja, reclamación, denuncia, demanda o recurso', null, '7931d6d950cc7b01ff2221b989ed5e01b7603da0486e85c50ecf7ecc28e80dae', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '7931d6d950cc7b01ff2221b989ed5e01b7603da0486e85c50ecf7ecc28e80dae')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Tutela judicial efectiva.', false), ('B', 'Acción positiva.', false), ('C', 'Indemnidad frente a represalias.', true), ('D', 'Inversión de la carga de la prueba.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 11 de la Ley Orgánica 3/2007, las medidas específicas que adopten los Poderes Públicos en favor de las mujeres para corregir situaciones patentes de desigualdad de hecho respecto de los hombres:', 'El art. 11.1 LO 3/2007 regula las acciones positivas: temporales (mientras subsista la desigualdad), razonables y proporcionadas al objetivo perseguido.', 'age_aux_b1_16_igualdad', (select id from public.topics where slug = 'age-aux-b1-16-igualdad'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2007-6115'), 'Art. 11.1 LO 3/2007', 'Tales medidas, que serán aplicables en tanto subsistan dichas situaciones, habrán de ser razonables y proporcionadas en relación con el objetivo perseguido en cada caso.', null, 'a30a05590454de02942c228d79150e9c3112392943b47319928fd4caf6b2433e', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'a30a05590454de02942c228d79150e9c3112392943b47319928fd4caf6b2433e')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Tendrán carácter permanente.', false), ('B', 'Tendrán una vigencia máxima de cuatro años.', false), ('C', 'Solo podrán adoptarse mediante ley orgánica.', false), ('D', 'Serán aplicables en tanto subsistan dichas situaciones y habrán de ser razonables y proporcionadas.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'De acuerdo con el artículo 12 de la Ley Orgánica 3/2007, en los litigios sobre acoso sexual y acoso por razón de sexo estará legitimada:', 'El art. 12.3 LO 3/2007 establece que la persona acosada es la única legitimada en estos litigios, frente a la regla general de legitimación por interés legítimo del apartado 2.', 'age_aux_b1_16_igualdad', (select id from public.topics where slug = 'age-aux-b1-16-igualdad'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2007-6115'), 'Art. 12.3 LO 3/2007', 'La persona acosada será la única legitimada en los litigios sobre acoso sexual y acoso por razón de sexo.', null, 'a7aaf6b0b6aa166bd008b6b259e3b7c88b2bbae8fa1e54848f70b98d46e27b10', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'a7aaf6b0b6aa166bd008b6b259e3b7c88b2bbae8fa1e54848f70b98d46e27b10')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Únicamente la persona acosada.', true), ('B', 'Cualquier persona física o jurídica con interés legítimo.', false), ('C', 'La persona acosada y los representantes legales de los trabajadores.', false), ('D', 'La persona acosada y el Ministerio Fiscal, de forma indistinta.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 46 de la Ley Orgánica 3/2007, los planes de igualdad de las empresas son un conjunto ordenado de medidas adoptadas:', 'El art. 46.1 LO 3/2007 define los planes de igualdad como medidas adoptadas tras un diagnóstico de situación, para alcanzar la igualdad de trato y oportunidades y eliminar la discriminación por razón de sexo.', 'age_aux_b1_16_igualdad', (select id from public.topics where slug = 'age-aux-b1-16-igualdad'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2007-6115'), 'Art. 46.1 LO 3/2007', 'Los planes de igualdad de las empresas son un conjunto ordenado de medidas, adoptadas después de realizar un diagnóstico de situación, tendentes a alcanzar en la empresa la igualdad de trato y de oportunidades entre mujeres y hombres y a eliminar la discriminación por razón de sexo.', null, '9f2a85cdf6bfdefff9173c5ba6c6bf054aaa0fb7962caea747b909dafcae51cf', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '9f2a85cdf6bfdefff9173c5ba6c6bf054aaa0fb7962caea747b909dafcae51cf')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Después de recibir una sanción de la autoridad laboral.', false), ('B', 'Después de realizar un diagnóstico de situación.', true), ('C', 'A propuesta de la Inspección de Trabajo.', false), ('D', 'Antes de iniciar la negociación del convenio colectivo.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 53 de la Ley Orgánica 3/2007, los tribunales y órganos de selección del personal de la Administración General del Estado responderán al principio de presencia equilibrada de mujeres y hombres:', 'El art. 53 LO 3/2007 impone la presencia equilibrada en tribunales y órganos de selección, con la salvedad de razones fundadas y objetivas debidamente motivadas.', 'age_aux_b1_16_igualdad', (select id from public.topics where slug = 'age-aux-b1-16-igualdad'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2007-6115'), 'Art. 53 LO 3/2007', 'Todos los tribunales y órganos de selección del personal de la Administración General del Estado y de los organismos públicos vinculados o dependientes de ella responderán al principio de presencia equilibrada de mujeres y hombres, salvo por razones fundadas y objetivas, debidamente motivadas.', null, 'a5b885183f45f7fee54fc3808f48d4b0f6478e1cd83bfbc719326d42df276bc6', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'a5b885183f45f7fee54fc3808f48d4b0f6478e1cd83bfbc719326d42df276bc6')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'En todo caso y sin excepción.', false), ('B', 'Solo en los procesos selectivos de cuerpos del Subgrupo A1.', false), ('C', 'Salvo por razones fundadas y objetivas, debidamente motivadas.', true), ('D', 'Cuando así lo disponga cada convocatoria.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 13 de la Ley Orgánica 3/2007, la regla por la que, en los procedimientos fundados en actuaciones discriminatorias por razón de sexo, corresponde a la persona demandada probar la ausencia de discriminación:', 'El art. 13 LO 3/2007 traslada la carga de la prueba a la parte demandada, pero su apartado 2 la excluye de los procesos penales.', 'age_aux_b1_16_igualdad', (select id from public.topics where slug = 'age-aux-b1-16-igualdad'), 3, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2007-6115'), 'Art. 13 LO 3/2007', 'corresponderá a la persona demandada probar la ausencia de discriminación en las medidas adoptadas y su proporcionalidad. […] Lo establecido en el apartado anterior no será de aplicación a los procesos penales.', null, '730c85b098a90d433b05a6fa863e0bc20ead68c688ec940d876863d4780597ec', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '730c85b098a90d433b05a6fa863e0bc20ead68c688ec940d876863d4780597ec')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Se aplica en todos los órdenes jurisdiccionales sin excepción.', false), ('B', 'No se aplica a los procesos penales.', true), ('C', 'Solo se aplica en los procesos laborales.', false), ('D', 'No se aplica a los procesos contencioso-administrativos.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
-- Lote age-aux-b1-16-igualdad-lovg-v1 (3 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Ley Orgánica 1/2004, de 28 de diciembre, de Medidas de Protección Integral contra la Violencia de Género (texto consolidado, BOE)', 'https://www.boe.es/buscar/act.php?id=BOE-A-2004-21760', 'boe'::public.source_kind, 'Agencia Estatal Boletín Oficial del Estado', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('age-aux-b1-16-igualdad', 'I.16 Igualdad, violencia de género, LGTBI, discapacidad y dependencia') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('auxiliar-administrativo-estado') and t.slug = 'age-aux-b1-16-igualdad' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 25 de la Ley Orgánica 1/2004, las ausencias totales o parciales al trabajo motivadas por la situación física o psicológica derivada de la violencia de género sufrida por una mujer funcionaria:', 'El art. 25 LO 1/2004 considera justificadas esas ausencias, en los términos de la legislación específica.', 'age_aux_b1_16_igualdad', (select id from public.topics where slug = 'age-aux-b1-16-igualdad'), 1, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2004-21760'), 'Art. 25 LO 1/2004', 'Las ausencias totales o parciales al trabajo motivadas por la situación física o psicológica derivada de la violencia de género sufrida por una mujer funcionaria se considerarán justificadas en los términos que se determine en su legislación específica.', null, '45dd5fc9d15fa57d532d13a143d16d3c03fc3fe56cc2501f5453059c8b069304', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '45dd5fc9d15fa57d532d13a143d16d3c03fc3fe56cc2501f5453059c8b069304')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Se descontarán de sus vacaciones anuales.', false), ('B', 'Darán lugar a una deducción proporcional de haberes.', false), ('C', 'Se considerarán justificadas solo si no superan tres días al mes.', false), ('D', 'Se considerarán justificadas en los términos que se determine en su legislación específica.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'De acuerdo con el artículo 1.3 de la Ley Orgánica 1/2004, la violencia de género a que se refiere la ley comprende:', 'El art. 1.3 LO 1/2004 define ampliamente la violencia de género: física y psicológica, incluidas agresiones a la libertad sexual, amenazas, coacciones y privación arbitraria de libertad.', 'age_aux_b1_16_igualdad', (select id from public.topics where slug = 'age-aux-b1-16-igualdad'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2004-21760'), 'Art. 1.3 LO 1/2004', 'La violencia de género a que se refiere la presente Ley comprende todo acto de violencia física y psicológica, incluidas las agresiones a la libertad sexual, las amenazas, las coacciones o la privación arbitraria de libertad.', null, '7639f923a2de5a9c55574426d3eec47b9a9c58a06d4abc41f7ef8e6e76354607', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '7639f923a2de5a9c55574426d3eec47b9a9c58a06d4abc41f7ef8e6e76354607')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Únicamente los actos de violencia física.', false), ('B', 'Los actos de violencia física y psicológica, excluidas las amenazas, que se regulan en el Código Penal.', false), ('C', 'Solo los actos de violencia cometidos en el domicilio familiar.', false), ('D', 'Todo acto de violencia física y psicológica, incluidas las agresiones a la libertad sexual, las amenazas, las coacciones o la privación arbitraria de libertad.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select '¿Cuál de los siguientes medios NO figura en el artículo 23 de la Ley Orgánica 1/2004 para acreditar las situaciones de violencia de género que dan lugar al reconocimiento de derechos?', 'El art. 23 LO 1/2004 admite sentencia condenatoria, orden de protección u otra resolución judicial con medida cautelar, informe del Ministerio Fiscal e informes de servicios sociales, especializados o de acogida; no la mera declaración jurada.', 'age_aux_b1_16_igualdad', (select id from public.topics where slug = 'age-aux-b1-16-igualdad'), 3, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2004-21760'), 'Art. 23 LO 1/2004', 'se acreditarán mediante una sentencia condenatoria por cualquiera de las manifestaciones de la violencia contra las mujeres previstas en esta ley, una orden de protección o cualquier otra resolución judicial que acuerde una medida cautelar a favor de la víctima, o bien por el informe del Ministerio Fiscal que indique la existencia de indicios de que la demandante es víctima de violencia de género.', null, '33804ad220d082e72a5d49eee6cbaf801a8ae19cbd56b72f303bfaa9b9b3ceac', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '33804ad220d082e72a5d49eee6cbaf801a8ae19cbd56b72f303bfaa9b9b3ceac')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Una sentencia condenatoria por cualquiera de las manifestaciones de la violencia contra las mujeres previstas en la ley.', false), ('B', 'La declaración jurada de la propia víctima ante el órgano de personal.', true), ('C', 'Una orden de protección.', false), ('D', 'El informe del Ministerio Fiscal que indique la existencia de indicios de que la demandante es víctima de violencia de género.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
-- Lote age-aux-b2-01-atencion-publico-lgdpd-v1 (1 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Real Decreto Legislativo 1/2013, de 29 de noviembre, texto refundido de la Ley General de derechos de las personas con discapacidad y de su inclusión social (texto consolidado, BOE)', 'https://www.boe.es/buscar/act.php?id=BOE-A-2013-12632', 'boe'::public.source_kind, 'Agencia Estatal Boletín Oficial del Estado', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('age-aux-b2-01-atencion-publico', 'II.1 Atención al público y atención de personas con discapacidad') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('auxiliar-administrativo-estado') and t.slug = 'age-aux-b2-01-atencion-publico' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'De acuerdo con el artículo 4.1 del Real Decreto Legislativo 1/2013, las disposiciones normativas y las comunicaciones de los poderes y las Administraciones públicas, cuando actúen en calidad de tales, utilizarán para denominar a estas personas los términos:', 'El art. 4.1 RDL 1/2013 impone a poderes y Administraciones públicas el uso de los términos «persona con discapacidad» o «personas con discapacidad».', 'age_aux_b2_01_atencion_publico', (select id from public.topics where slug = 'age-aux-b2-01-atencion-publico'), 3, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2013-12632'), 'Art. 4.1 LGDPD', 'utilizarán los términos “persona con discapacidad” o “personas con discapacidad” para denominarlas.', null, '91e188c1755d2c588c83decd06e5ecede65998d1b9cdfb3784776d42477ce6b8', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '91e188c1755d2c588c83decd06e5ecede65998d1b9cdfb3784776d42477ce6b8')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', '«Persona discapacitada» o «personas discapacitadas».', false), ('B', '«Persona con diversidad funcional» o «personas con diversidad funcional».', false), ('C', '«Persona con discapacidad» o «personas con discapacidad».', true), ('D', '«Persona con minusvalía» o «personas con minusvalía».', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
-- Lote age-aux-b2-01-atencion-publico-lpac-v1 (2 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Ley 39/2015, de 1 de octubre, del Procedimiento Administrativo Común de las Administraciones Públicas (texto consolidado, BOE)', 'https://www.boe.es/buscar/act.php?id=BOE-A-2015-10565', 'boe'::public.source_kind, 'Agencia Estatal Boletín Oficial del Estado', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('age-aux-b2-01-atencion-publico', 'II.1 Atención al público y atención de personas con discapacidad') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('auxiliar-administrativo-estado') and t.slug = 'age-aux-b2-01-atencion-publico' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 12 de la Ley 39/2015, si un interesado no obligado a relacionarse electrónicamente no dispone de los medios electrónicos necesarios, su identificación o firma electrónica en el procedimiento podrá ser realizada por un funcionario público, para lo cual será necesario que el interesado:', 'El art. 12.2 Ley 39/2015 permite la firma por funcionario habilitado con su propio sistema, previa identificación del interesado y su consentimiento expreso.', 'age_aux_b2_01_atencion_publico', (select id from public.topics where slug = 'age-aux-b2-01-atencion-publico'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2015-10565'), 'Art. 12.2 LPAC', 'será necesario que el interesado que carezca de los medios electrónicos necesarios se identifique ante el funcionario y preste su consentimiento expreso para esta actuación', null, '3047b590fadf35c83a0f76c9de7b373148fe3fc81569342d7db8b1daf531440c', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '3047b590fadf35c83a0f76c9de7b373148fe3fc81569342d7db8b1daf531440c')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Aporte un certificado de empadronamiento.', false), ('B', 'Se identifique ante el funcionario y preste su consentimiento expreso.', true), ('C', 'Otorgue poder notarial al funcionario.', false), ('D', 'Presente una declaración responsable por escrito ante el registro.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 12 de la Ley 39/2015, en el registro u otro sistema equivalente de funcionarios habilitados para la identificación o firma de los interesados constarán, al menos:', 'El art. 12.3 Ley 39/2015 obliga a mantener ese registro interoperable e incluir, como mínimo, a los funcionarios de las oficinas de asistencia en materia de registros.', 'age_aux_b2_01_atencion_publico', (select id from public.topics where slug = 'age-aux-b2-01-atencion-publico'), 3, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2015-10565'), 'Art. 12.3 LPAC', 'En este registro o sistema equivalente, al menos, constarán los funcionarios que presten servicios en las oficinas de asistencia en materia de registros.', null, '36722e363c9045992747a9356636cfc2c8a6d52472985ef34d603f11850b0057', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '36722e363c9045992747a9356636cfc2c8a6d52472985ef34d603f11850b0057')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Los funcionarios de los cuerpos de Gestión de cada Administración.', false), ('B', 'Los funcionarios que presten servicios en las oficinas de asistencia en materia de registros.', true), ('C', 'Los funcionarios que presten servicios en las unidades de información administrativa.', false), ('D', 'Los funcionarios destinados en las Delegaciones y Subdelegaciones del Gobierno.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
-- Lote age-aux-b2-01-atencion-publico-rddisc-v1 (20 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Real Decreto 366/2007, de 16 de marzo, accesibilidad y no discriminación de las personas con discapacidad en sus relaciones con la AGE (texto consolidado, BOE)', 'https://www.boe.es/buscar/act.php?id=BOE-A-2007-6239', 'boe'::public.source_kind, 'Agencia Estatal Boletín Oficial del Estado', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('age-aux-b2-01-atencion-publico', 'II.1 Atención al público y atención de personas con discapacidad') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('auxiliar-administrativo-estado') and t.slug = 'age-aux-b2-01-atencion-publico' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'De acuerdo con el artículo 4 del Real Decreto 366/2007, las Oficinas de Atención al Ciudadano que dispongan de plazas de aparcamiento:', 'El art. 4.2.d) RD 366/2007 recomienda reservar un número suficiente de plazas señalizadas, exclusivas para personas con movilidad reducida, con itinerarios accesibles hasta la Oficina.', 'age_aux_b2_01_atencion_publico', (select id from public.topics where slug = 'age-aux-b2-01-atencion-publico'), 1, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2007-6239'), 'Art. 4.2.d) RDDISC', 'd) Las Oficinas de Atención al Ciudadano, en el caso de disponer de plazas de aparcamiento, reservarán un número suficiente de plazas, convenientemente señalizadas, destinadas en exclusividad a personas con movilidad reducida', null, '69e07370d11089f703b28f2d1d6b0f808c6c973668d93c3ffe2e6fb946f014b3', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '69e07370d11089f703b28f2d1d6b0f808c6c973668d93c3ffe2e6fb946f014b3')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Reservarán una plaza por cada diez para personas con movilidad reducida.', false), ('B', 'Podrán reservar plazas para personas con movilidad reducida si lo solicita una asociación representativa.', false), ('C', 'Reservarán todas sus plazas para el público con discapacidad en horario de atención.', false), ('D', 'Reservarán un número suficiente de plazas, convenientemente señalizadas, destinadas en exclusividad a personas con movilidad reducida.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 5 del Real Decreto 366/2007, los intercomunicadores y sistemas de aviso o llamada de acceso a las Oficinas de Atención al Ciudadano serán accesibles:', 'El art. 5.2.d) RD 366/2007 exige su accesibilidad por la modalidad de uso (texto y voz) y por su localización.', 'age_aux_b2_01_atencion_publico', (select id from public.topics where slug = 'age-aux-b2-01-atencion-publico'), 1, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2007-6239'), 'Art. 5.2.d) RDDISC', 'd) Los intercomunicadores y sistemas de aviso o llamada serán accesibles, tanto por su modalidad de uso (texto y voz) como por su localización.', null, 'e508549dd5d4f8af13dfca6893b4c990513fadc5032bbaa4132cb27a343ab61c', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'e508549dd5d4f8af13dfca6893b4c990513fadc5032bbaa4132cb27a343ab61c')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Solo por su localización.', false), ('B', 'Solo mediante voz.', false), ('C', 'Tanto por su modalidad de uso (texto y voz) como por su localización.', true), ('D', 'Mediante sistemas táctiles en braille exclusivamente.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'De acuerdo con el artículo 6 del Real Decreto 366/2007, los sistemas de control de acceso de las Oficinas de Atención al Ciudadano no deben interferir con:', 'El art. 6.2.a) RD 366/2007 exige que los controles no obstaculicen a usuarios de sillas de ruedas, perros guía o bastón ni interfieran con marcapasos y prótesis auditivas.', 'age_aux_b2_01_atencion_publico', (select id from public.topics where slug = 'age-aux-b2-01-atencion-publico'), 1, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2007-6239'), 'Art. 6.2.a) RDDISC', 'Tampoco deben interferir con dispositivos personales electromagnéticos tales como marcapasos y prótesis auditivas.', null, '2231921b2d267d649e56df5ccc7bf361cc2793597820734e4733c5f37e606e83', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '2231921b2d267d649e56df5ccc7bf361cc2793597820734e4733c5f37e606e83')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Dispositivos personales electromagnéticos tales como marcapasos y prótesis auditivas.', true), ('B', 'Los teléfonos móviles de los usuarios.', false), ('C', 'Los sistemas de bucle de inducción magnética de los mostradores.', false), ('D', 'Las pantallas táctiles de los puntos de información.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 7 del Real Decreto 366/2007, toda la información emitida por megafonía en las Oficinas de Atención al Ciudadano:', 'El art. 7.e) RD 366/2007 obliga a mostrar en paneles textuales toda la información de megafonía, además de usar una señal de atención previa y bucles de inducción magnética.', 'age_aux_b2_01_atencion_publico', (select id from public.topics where slug = 'age-aux-b2-01-atencion-publico'), 1, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2007-6239'), 'Art. 7.e) RDDISC', 'Toda la información emitida por megafonía debe mostrarse también en paneles textuales bien visibles.', null, '67ed8f242eed4a5482a1de33bdcc2bdd4862ac9629b5023535d1a0c10d27ad71', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '67ed8f242eed4a5482a1de33bdcc2bdd4862ac9629b5023535d1a0c10d27ad71')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Debe repetirse al menos dos veces.', false), ('B', 'Debe mostrarse también en paneles textuales bien visibles.', true), ('C', 'Debe emitirse también en lengua de signos.', false), ('D', 'Debe ir precedida de una señal exclusivamente acústica.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'De acuerdo con el artículo 7 del Real Decreto 366/2007, los sistemas de aviso, incluidos los de alarma o avisos de peligro, deben ser emitidos:', 'El art. 7.h) RD 366/2007 exige la emisión simultánea por medios sonoros y visuales.', 'age_aux_b2_01_atencion_publico', (select id from public.topics where slug = 'age-aux-b2-01-atencion-publico'), 1, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2007-6239'), 'Art. 7.h) RDDISC', 'h) Los sistemas de aviso, incluyendo los de alarma o avisos de peligro, deben ser emitidos simultáneamente por medios sonoros y visuales fácilmente comprensibles y reconocibles.', null, '0dcb88276f8092f0060d847ca71e1fcf01fb7d69ac9cb15228aec43212295a8c', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '0dcb88276f8092f0060d847ca71e1fcf01fb7d69ac9cb15228aec43212295a8c')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Solo por medios sonoros de alta intensidad.', false), ('B', 'Solo por medios visuales, para no alterar a los usuarios.', false), ('C', 'Simultáneamente por medios sonoros y visuales fácilmente comprensibles y reconocibles.', true), ('D', 'Por medios sonoros, visuales y táctiles de forma sucesiva.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 10 del Real Decreto 366/2007, las Oficinas de Atención al Ciudadano deberán contar, al menos, con:', 'El art. 10.1 RD 366/2007 exige al menos un área higiénico-sanitaria accesible, conforme a las especificaciones técnicas de la disposición final segunda.', 'age_aux_b2_01_atencion_publico', (select id from public.topics where slug = 'age-aux-b2-01-atencion-publico'), 1, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2007-6239'), 'Art. 10.1 RDDISC', 'Las Oficinas de Atención deberán contar al menos con un área higiénico-sanitaria accesible', null, 'cd980c7d8f3c30a818b32b046e3812a3a6acc793bdbaa0eae55f266b1ae85b20', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'cd980c7d8f3c30a818b32b046e3812a3a6acc793bdbaa0eae55f266b1ae85b20')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Dos áreas higiénico-sanitarias accesibles, una por sexo.', false), ('B', 'Un área higiénico-sanitaria accesible por cada planta.', false), ('C', 'Un aseo accesible solo si superan una determinada superficie.', false), ('D', 'Un área higiénico-sanitaria accesible.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'De acuerdo con el artículo 12 del Real Decreto 366/2007, los documentos e impresos destinados al ciudadano deberán estar en todo caso disponibles:', 'El art. 12.3 RD 366/2007 exige que estén siempre disponibles en las páginas web y en formato electrónico accesible; los formatos alternativos (tipografía ampliada, braille) se ofrecen a requerimiento (art. 12.2).', 'age_aux_b2_01_atencion_publico', (select id from public.topics where slug = 'age-aux-b2-01-atencion-publico'), 1, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2007-6239'), 'Art. 12.3 RDDISC', 'Además, los documentos e impresos deberán estar en todo caso disponibles en las correspondientes páginas web y en formato electrónico accesible.', null, '817f4a2617b22c33f6a2c9063a046f99db4e77630a6a6e955e9b65010553c377', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '817f4a2617b22c33f6a2c9063a046f99db4e77630a6a6e955e9b65010553c377')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Solo en soporte papel en la propia oficina.', false), ('B', 'En las correspondientes páginas web y en formato electrónico accesible.', true), ('C', 'En braille en todas las oficinas.', false), ('D', 'En la sede de la Secretaría General para la Administración Pública.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'A los efectos del Real Decreto 366/2007, los impresos puestos por la Administración General del Estado a disposición de los ciudadanos para formular solicitudes, declaraciones, alegaciones, recursos o cualquier pretensión ante ella se denominan:', 'El art. 1.2.b) RD 366/2007 los define como modelos normalizados, uno de los dos medios preferentes de relación junto a las Oficinas de Atención al Ciudadano.', 'age_aux_b2_01_atencion_publico', (select id from public.topics where slug = 'age-aux-b2-01-atencion-publico'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2007-6239'), 'Art. 1.2.b) RDDISC', 'b) Modelos normalizados: Impresos puestos por la Administración General del Estado a disposición de los ciudadanos para formular solicitudes, declaraciones, alegaciones, recursos o cualquier pretensión o manifestación de voluntad ante la misma.', null, '7b37b34a7d3a45c86c499c05a6e9f6d6915d0b184a315f82e970e441dc94b31b', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '7b37b34a7d3a45c86c499c05a6e9f6d6915d0b184a315f82e970e441dc94b31b')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Modelos normalizados.', true), ('B', 'Formularios electrónicos.', false), ('C', 'Documentos administrativos.', false), ('D', 'Impresos accesibles.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 2 del Real Decreto 366/2007, la actuación de la Administración General del Estado dirigida a compensar las desventajas que los ciudadanos con discapacidad pudieran presentar en sus relaciones con ella se denomina:', 'El art. 2.b) RD 366/2007 recoge la acción positiva para compensar esas desventajas, junto a la igualdad de oportunidades, los medios y apoyos suplementarios y la eliminación de prácticas discriminatorias.', 'age_aux_b2_01_atencion_publico', (select id from public.topics where slug = 'age-aux-b2-01-atencion-publico'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2007-6239'), 'Art. 2.b) RDDISC', 'b) La acción positiva para compensar las desventajas que estos ciudadanos en sus relaciones con la Administración pudieran presentar.', null, 'a3b6183d598227df5fbd4a4940673766e41b7ce95f537770f6bcc486b0ebc1d9', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'a3b6183d598227df5fbd4a4940673766e41b7ce95f537770f6bcc486b0ebc1d9')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Ajuste razonable.', false), ('B', 'Accesibilidad universal.', false), ('C', 'Acción positiva.', true), ('D', 'Diseño para todos.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'De acuerdo con el artículo 4 del Real Decreto 366/2007, la señalización exterior de la Oficina de Atención al Ciudadano deberá diseñarse de modo que resulte inteligible y comprensible, en particular, por las personas con:', 'El art. 4.2.b) RD 366/2007 exige que la Oficina esté bien señalizada desde el exterior y que la señalización sea inteligible para las personas con discapacidad intelectual.', 'age_aux_b2_01_atencion_publico', (select id from public.topics where slug = 'age-aux-b2-01-atencion-publico'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2007-6239'), 'Art. 4.2.b) RDDISC', 'b) La Oficina debe estar correctamente señalizada visualmente desde el exterior, de tal forma que sea fácilmente identificable. La señalización deberá ser diseñada de modo que resulte inteligible y comprensible por parte de las personas con discapacidad intelectual.', null, 'bc24d3f7aae04df50447a86cebd788363bef1aacbf4067da1584334d2eb10af6', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'bc24d3f7aae04df50447a86cebd788363bef1aacbf4067da1584334d2eb10af6')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Discapacidad auditiva.', false), ('B', 'Movilidad reducida.', false), ('C', 'Discapacidad visual severa.', false), ('D', 'Discapacidad intelectual.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 5 del Real Decreto 366/2007, el cartel que indique el número y letra del portal junto a la entrada principal de la Oficina se situará preferiblemente:', 'El art. 5.2.c) RD 366/2007 recomienda colocarlo preferiblemente a la derecha de la puerta, con buen contraste y a la altura adecuada.', 'age_aux_b2_01_atencion_publico', (select id from public.topics where slug = 'age-aux-b2-01-atencion-publico'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2007-6239'), 'Art. 5.2.c) RDDISC', 'c) Junto a la entrada principal, preferiblemente a la derecha de la puerta, un cartel indicará, en su caso, el número y letra del portal', null, '204abddcdf4574237c96727a094c9d039bb51e8dd46e0a907862f31ac3403a62', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '204abddcdf4574237c96727a094c9d039bb51e8dd46e0a907862f31ac3403a62')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Encima de la puerta.', false), ('B', 'A la derecha de la puerta.', true), ('C', 'A la izquierda de la puerta.', false), ('D', 'En el suelo, junto al umbral.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'De acuerdo con el artículo 6 del Real Decreto 366/2007, cuando el sistema de seguridad o control de acceso no tenga dimensiones suficientes para el paso de personas en silla de ruedas:', 'El art. 6.2.b) RD 366/2007 exige medios alternativos que permitan pasar el control sin separarse de la ayuda técnica.', 'age_aux_b2_01_atencion_publico', (select id from public.topics where slug = 'age-aux-b2-01-atencion-publico'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2007-6239'), 'Art. 6.2.b) RDDISC', 'b) Cuando el sistema de seguridad o control de acceso no tenga las dimensiones suficientes para permitir el paso a personas en silla de ruedas, se tendrán previstas medidas o medios alternativos para pasar este control, de forma que la persona permanezca con su ayuda técnica.', null, '551b6ccec3283700e7b98964766b65225b25b31276f3abcd6488abbfb7c9e49b', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '551b6ccec3283700e7b98964766b65225b25b31276f3abcd6488abbfb7c9e49b')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'La persona deberá abandonar su silla para pasar el control.', false), ('B', 'Se tendrán previstos medios alternativos para pasar el control, de forma que la persona permanezca con su ayuda técnica.', true), ('C', 'Se le eximirá de todo control de seguridad.', false), ('D', 'Deberá acceder por la entrada de servicio del edificio.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 7 del Real Decreto 366/2007, los paneles de información gráfica de la señalización interior:', 'El art. 7.a) RD 366/2007 los sitúa paralelos a la marcha, junto a paredes, sin obstáculos que los oculten, sin cristales y permitiendo el acercamiento.', 'age_aux_b2_01_atencion_publico', (select id from public.topics where slug = 'age-aux-b2-01-atencion-publico'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2007-6239'), 'Art. 7.a) RDDISC', 'a) Los paneles de información gráfica, permanente o temporal, estarán situados paralelamente a la dirección de la marcha […] No se protegerán con cristales', null, 'df771d3b0ccbd08a36b32c6db5cd83911abd5131fec7a3c4d729bad0790351ca', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'df771d3b0ccbd08a36b32c6db5cd83911abd5131fec7a3c4d729bad0790351ca')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Se colocarán perpendiculares a la dirección de la marcha.', false), ('B', 'Se protegerán siempre con cristales antirreflectantes.', false), ('C', 'Se situarán a una altura que impida su manipulación.', false), ('D', 'Estarán situados paralelamente a la dirección de la marcha y no se protegerán con cristales.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'De acuerdo con el artículo 8 del Real Decreto 366/2007, los servicios de atención telefónica al ciudadano estarán dotados, de permitirlo técnicamente, de videotelefonía para:', 'El art. 8.2.e) RD 366/2007 exige telefonía de texto, fax y, si es posible, videotelefonía para facilitar la lectura labial, con personal formado en su uso.', 'age_aux_b2_01_atencion_publico', (select id from public.topics where slug = 'age-aux-b2-01-atencion-publico'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2007-6239'), 'Art. 8.2.e) RDDISC', 'estarán dotados con sistemas de telefonía de texto, de fax y, de permitirlo técnicamente, de videotelefonía para facilitar la lectura labial.', null, 'e9a1700b23ba84dd0cfc5d71b031dd216623f8e4f680bc1f167ab2c90179ded1', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'e9a1700b23ba84dd0cfc5d71b031dd216623f8e4f680bc1f167ab2c90179ded1')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Grabar las conversaciones con los usuarios.', false), ('B', 'Identificar al interlocutor.', false), ('C', 'Facilitar la lectura labial.', true), ('D', 'Permitir la interpretación simultánea a otras lenguas.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 9 del Real Decreto 366/2007, en los sistemas interactivos de información no atendidos por personal, la información:', 'El art. 9.2.i) RD 366/2007 pide información clara, con pocas opciones por pantalla y un tiempo de respuesta dilatado.', 'age_aux_b2_01_atencion_publico', (select id from public.topics where slug = 'age-aux-b2-01-atencion-publico'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2007-6239'), 'Art. 9.2.i) RDDISC', 'i) La información debe ser clara, sin demasiadas opciones en una misma pantalla y permitir un dilatado tiempo de respuesta.', null, 'a353bae4e083465314775a0283476d66e0196c85db6a15500d6aa25f01faf807', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'a353bae4e083465314775a0283476d66e0196c85db6a15500d6aa25f01faf807')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Debe ser clara, sin demasiadas opciones en una misma pantalla y permitir un dilatado tiempo de respuesta.', true), ('B', 'Debe concentrar todas las opciones en una sola pantalla para evitar la navegación.', false), ('C', 'Debe ofrecerse solo en formato texto, para su lectura con lupa.', false), ('D', 'Debe limitar el tiempo de respuesta para agilizar las colas.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'De acuerdo con el artículo 14 del Real Decreto 366/2007, en la formación del personal de la Administración General del Estado encargado de la atención al ciudadano se atenderá especialmente:', 'El art. 14.2 RD 366/2007 orienta la formación al conocimiento de las discapacidades y sus consecuencias en la atención, al trato con estas personas y al uso de medios auxiliares.', 'age_aux_b2_01_atencion_publico', (select id from public.topics where slug = 'age-aux-b2-01-atencion-publico'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2007-6239'), 'Art. 14.2 RDDISC', 'se atenderá especialmente al conocimiento de las distintas discapacidades y sus consecuencias en el desarrollo de los servicios de atención, en el trato e interacción con las personas con discapacidad y en el uso de medios auxiliares facilitadores de dicho trato.', null, '86da76362646924be4273220dee02dc1c01b7001caf0f34457ca130f299e1fa0', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '86da76362646924be4273220dee02dc1c01b7001caf0f34457ca130f299e1fa0')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'A la normativa de protección de datos personales.', false), ('B', 'A las técnicas de gestión de colas y citas previas.', false), ('C', 'Al conocimiento de las distintas discapacidades, al trato e interacción con las personas con discapacidad y al uso de medios auxiliares facilitadores de dicho trato.', true), ('D', 'A la tramitación electrónica de los procedimientos.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 3 del Real Decreto 366/2007, ¿quién determina las Oficinas de Atención al Ciudadano que habrán de ajustarse a las condiciones de accesibilidad previstas en él?', 'El art. 3 RD 366/2007 atribuye esa determinación a una Resolución de la Secretaría General para la Administración Pública, que hará pública una relación actualizada de esas Oficinas.', 'age_aux_b2_01_atencion_publico', (select id from public.topics where slug = 'age-aux-b2-01-atencion-publico'), 3, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2007-6239'), 'Art. 3 RDDISC', 'La Administración General del Estado, mediante Resolución de la Secretaría General para la Administración Pública, previa consulta con los Departamentos Ministeriales afectados, determinará las Oficinas que habrán de ajustarse a las condiciones de accesibilidad previstas en este real decreto', null, '3ed6a114c8541e370193e3c1bbdd516a62e54917d089ac969940cdf4d54d0dac', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '3ed6a114c8541e370193e3c1bbdd516a62e54917d089ac969940cdf4d54d0dac')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El Consejo de Ministros, mediante real decreto.', false), ('B', 'Cada Departamento ministerial, mediante orden de su titular.', false), ('C', 'El Consejo Nacional de la Discapacidad, mediante acuerdo.', false), ('D', 'La Secretaría General para la Administración Pública, mediante Resolución y previa consulta con los Departamentos Ministeriales afectados.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'De acuerdo con el artículo 4 del Real Decreto 366/2007, a las Oficinas de Atención al Ciudadano de carácter itinerante o ambulante, o habilitadas provisionalmente fuera de una dependencia consolidada:', 'El art. 4.3 RD 366/2007 admite singularidades o excepciones para estas oficinas, con el límite de no menoscabar los derechos de las personas con discapacidad.', 'age_aux_b2_01_atencion_publico', (select id from public.topics where slug = 'age-aux-b2-01-atencion-publico'), 3, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2007-6239'), 'Art. 4.3 RDDISC', 'se les aplicarán las singularidades o excepciones que sean necesarias, siempre que no supongan menoscabo de derechos de las personas con discapacidad.', null, '017c99bef3cddbd91296a319b60c6a6bcbd07f2e6005291e6329b2abe3c6aef7', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '017c99bef3cddbd91296a319b60c6a6bcbd07f2e6005291e6329b2abe3c6aef7')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Se les aplicarán las singularidades o excepciones necesarias, siempre que no supongan menoscabo de derechos de las personas con discapacidad.', true), ('B', 'No les resulta aplicable el real decreto.', false), ('C', 'Se les aplican las mismas condiciones sin excepción alguna.', false), ('D', 'Se les aplicará el régimen de excepciones por protección del patrimonio.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 5 del Real Decreto 366/2007, de las dos bandas horizontales que señalizan las puertas acristaladas de las Oficinas, la primera se colocará a una altura:', 'El art. 5.2.h) RD 366/2007 sitúa la primera banda entre 100 y 120 cm y la segunda entre 150 y 170 cm, ambas de 20 cm de ancho y con contraste cromático.', 'age_aux_b2_01_atencion_publico', (select id from public.topics where slug = 'age-aux-b2-01-atencion-publico'), 3, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2007-6239'), 'Art. 5.2.h) RDDISC', 'colocada, la primera, a una altura entre 100 y 120 centímetros, y la segunda entre 150 y 170 centímetros.', null, '5a44535d888a53dca9bf64444c2f1b117b2e4e051735c3cd8114968ff9034e37', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '5a44535d888a53dca9bf64444c2f1b117b2e4e051735c3cd8114968ff9034e37')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Entre 80 y 100 centímetros.', false), ('B', 'Entre 120 y 140 centímetros.', false), ('C', 'Entre 150 y 170 centímetros.', false), ('D', 'Entre 100 y 120 centímetros.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'De acuerdo con el artículo 4 del Real Decreto 366/2007, a efectos del itinerario accesible que una los accesos de la Oficina con la vía pública, se considera suficiente cumplir los criterios establecidos en:', 'El art. 4.2.c) RD 366/2007 exige al menos un itinerario accesible y da por suficiente cumplir la Norma UNE 41510:2002; la UNE 41520 se cita para las puertas (art. 5.2.e).', 'age_aux_b2_01_atencion_publico', (select id from public.topics where slug = 'age-aux-b2-01-atencion-publico'), 3, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2007-6239'), 'Art. 4.2.c) RDDISC', 'A estos efectos se considera suficiente cumplir con los criterios establecidos en la Norma UNE 41510:2002 Accesibilidad en la Edificación. Espacios de Comunicación Horizontal.', null, '3ae96c35ccac5c31bc3ebe3a2c31af29c8a3ac3b3d4a2af2721f6caed9363582', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '3ae96c35ccac5c31bc3ebe3a2c31af29c8a3ac3b3d4a2af2721f6caed9363582')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'La Norma UNE 41510:2002, Accesibilidad en la Edificación. Espacios de Comunicación Horizontal.', true), ('B', 'La Norma UNE 41520 sobre espacios de comunicación vertical.', false), ('C', 'El Código Técnico de la Edificación.', false), ('D', 'Las especificaciones técnicas que apruebe cada Delegación del Gobierno.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
-- Lote age-aux-b2-01-atencion-publico-rdinfo-v1 (2 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Real Decreto 208/1996, de 9 de febrero, por el que se regulan los servicios de información administrativa y atención al ciudadano (texto consolidado, BOE)', 'https://www.boe.es/buscar/act.php?id=BOE-A-1996-4997', 'boe'::public.source_kind, 'Agencia Estatal Boletín Oficial del Estado', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('age-aux-b2-01-atencion-publico', 'II.1 Atención al público y atención de personas con discapacidad') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('auxiliar-administrativo-estado') and t.slug = 'age-aux-b2-01-atencion-publico' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 4.e) del Real Decreto 208/1996, la función de recepción de quejas y reclamaciones de la atención al ciudadano se refiere a las que estos formulen por:', 'El art. 4.e) RD 208/1996 limita esta función a las quejas por tardanzas, desatenciones u otras actuaciones irregulares en el funcionamiento de las dependencias; frente a los actos administrativos caben los recursos.', 'age_aux_b2_01_atencion_publico', (select id from public.topics where slug = 'age-aux-b2-01-atencion-publico'), 1, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1996-4997'), 'Art. 4.e) RDINFO', 'e) De recepción de las quejas y reclamaciones de los ciudadanos por las tardanzas, desatenciones o por cualquier otro tipo de actuación irregular que observen en el funcionamiento de las dependencias administrativas.', null, '4d970721eefe749374c0ee8b0a200f8c87aa396a28a362662e7a1da5d8962bfb', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '4d970721eefe749374c0ee8b0a200f8c87aa396a28a362662e7a1da5d8962bfb')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'La desestimación de sus solicitudes en un procedimiento administrativo.', false), ('B', 'Los actos administrativos que consideren contrarios a Derecho.', false), ('C', 'Las tardanzas, desatenciones o cualquier otro tipo de actuación irregular que observen en el funcionamiento de las dependencias administrativas.', true), ('D', 'Las sanciones administrativas que se les hayan impuesto.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 4.c) del Real Decreto 208/1996, la función de gestión comprende, además de la recepción de la documentación inicial de un expediente cuando así se haya dispuesto reglamentariamente:', 'El art. 4.c) RD 208/1996 incluye en la función de gestión las actuaciones de trámite y la resolución de cuestiones urgentes y sencillas que requieran respuesta inmediata.', 'age_aux_b2_01_atencion_publico', (select id from public.topics where slug = 'age-aux-b2-01-atencion-publico'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1996-4997'), 'Art. 4.c) RDINFO', 'así como las actuaciones de trámite y resolución de las cuestiones cuya urgencia y simplicidad demanden una respuesta inmediata.', null, 'bd458659317ccbb7d2729be5a5a92f22a0173f930955239c7b7ee6d30b6a77d7', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'bd458659317ccbb7d2729be5a5a92f22a0173f930955239c7b7ee6d30b6a77d7')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Las actuaciones de trámite y resolución de las cuestiones cuya urgencia y simplicidad demanden una respuesta inmediata.', true), ('B', 'La interpretación de las normas aplicables al procedimiento.', false), ('C', 'La resolución de las reclamaciones presentadas por los ciudadanos.', false), ('D', 'La elaboración de los informes jurídicos que soliciten los interesados.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
-- Lote age-aux-b2-02-informacion-administrativa-lodpet-v1 (13 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Ley Orgánica 4/2001, de 12 de noviembre, reguladora del Derecho de Petición (texto consolidado, BOE)', 'https://www.boe.es/buscar/act.php?id=BOE-A-2001-21090', 'boe'::public.source_kind, 'Agencia Estatal Boletín Oficial del Estado', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('age-aux-b2-02-informacion-administrativa', 'II.2 Los servicios de información administrativa: iniciativas, reclamaciones, quejas y peticiones') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('auxiliar-administrativo-estado') and t.slug = 'age-aux-b2-02-informacion-administrativa' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'De acuerdo con el artículo 4 de la Ley Orgánica 4/2001, reguladora del derecho de petición, los peticionarios:', 'El art. 4.4 LO 4/2001 reconoce a los peticionarios el derecho a exigir la confidencialidad de sus datos; además, pueden remitir copia a otro órgano para su conocimiento (art. 4.3).', 'age_aux_b2_02_informacion_administrativa', (select id from public.topics where slug = 'age-aux-b2-02-informacion-administrativa'), 1, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2001-21090'), 'Art. 4.4 LODPET', 'Los peticionarios podrán exigir la confidencialidad de sus datos.', null, 'aab881d884cbfdd07087a38e987d8c5f9153a4f4f7d747e5c5da57c9388697c7', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'aab881d884cbfdd07087a38e987d8c5f9153a4f4f7d747e5c5da57c9388697c7')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Podrán exigir la confidencialidad de sus datos.', true), ('B', 'Deberán acreditar un interés legítimo en el objeto de la petición.', false), ('C', 'Deberán presentar la petición personalmente.', false), ('D', 'No podrán dar cuenta de su petición a otro órgano distinto del destinatario.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 2 de la Ley Orgánica 4/2001, el derecho de petición podrá ejercerse ante:', 'El art. 2 LO 4/2001 abre el derecho de petición ante cualquier institución pública, administración o autoridad y ante los órganos de dirección de sus entidades vinculadas o dependientes, en materias de su competencia.', 'age_aux_b2_02_informacion_administrativa', (select id from public.topics where slug = 'age-aux-b2-02-informacion-administrativa'), 1, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2001-21090'), 'Art. 2 LODPET', 'El derecho de petición podrá ejercerse ante cualquier institución pública, administración, o autoridad, así como ante los órganos de dirección y administración de los organismos y entidades vinculados o dependientes de las Administraciones públicas, respecto de las materias de su competencia', null, '6cff8477b490b0de02396684555a2312e64b5f6a490f2a21284ef0b6fa0ab25f', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '6cff8477b490b0de02396684555a2312e64b5f6a490f2a21284ef0b6fa0ab25f')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Únicamente las Cortes Generales y las Asambleas Legislativas de las Comunidades Autónomas.', false), ('B', 'Cualquier institución pública, administración o autoridad, así como ante los órganos de dirección y administración de los organismos y entidades vinculados o dependientes de las Administraciones públicas.', true), ('C', 'Únicamente la Administración General del Estado.', false), ('D', 'Únicamente los órganos de gobierno de las Comunidades Autónomas y de las entidades locales.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'De acuerdo con el artículo 11 de la Ley Orgánica 4/2001, la autoridad u órgano competente confeccionará una memoria de actividades derivadas de las peticiones recibidas con periodicidad:', 'El art. 11.5 LO 4/2001 exige una memoria anual de actividades derivadas de las peticiones.', 'age_aux_b2_02_informacion_administrativa', (select id from public.topics where slug = 'age-aux-b2-02-informacion-administrativa'), 1, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2001-21090'), 'Art. 11.5 LODPET', 'Anualmente la autoridad u órgano competente confeccionará una memoria de actividades derivadas de las peticiones recibidas.', null, 'ad35a9b8dc9ddc282486cb86681d16587c10ba9adea63147cea6d368ffa27df2', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'ad35a9b8dc9ddc282486cb86681d16587c10ba9adea63147cea6d368ffa27df2')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Mensual.', false), ('B', 'Trimestral.', false), ('C', 'Anual.', true), ('D', 'Semestral.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según la Ley Orgánica 4/2001, el régimen de las quejas dirigidas al Defensor del Pueblo y a las instituciones autonómicas de naturaleza análoga:', 'La disposición adicional segunda de la LO 4/2001 excluye estas quejas, que se rigen por su legislación específica.', 'age_aux_b2_02_informacion_administrativa', (select id from public.topics where slug = 'age-aux-b2-02-informacion-administrativa'), 1, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2001-21090'), 'Disp. adic. 2.ª LODPET', 'Queda excluida de la aplicación de esta Ley el régimen de las quejas dirigidas al Defensor del Pueblo y a las instituciones autonómicas de naturaleza análoga, que se regirán por su legislación específica.', null, '665173bd65f78a05d95279e9ba66bd8db62eaf66c3251c7a5c3e34f9c997ad86', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '665173bd65f78a05d95279e9ba66bd8db62eaf66c3251c7a5c3e34f9c997ad86')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Se rige íntegramente por la Ley Orgánica 4/2001.', false), ('B', 'Se rige por la Ley Orgánica 4/2001 en lo no previsto en el Reglamento del Congreso.', false), ('C', 'Se rige por el Real Decreto 951/2005.', false), ('D', 'Queda excluido de su aplicación y se rige por su legislación específica.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'De acuerdo con el artículo 3 de la Ley Orgánica 4/2001, las peticiones podrán versar sobre cualquier asunto o materia comprendido en el ámbito de competencias del destinatario:', 'El art. 3 LO 4/2001 admite peticiones de interés individual, colectivo o general, dentro de las competencias del destinatario.', 'age_aux_b2_02_informacion_administrativa', (select id from public.topics where slug = 'age-aux-b2-02-informacion-administrativa'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2001-21090'), 'Art. 3 LODPET', 'Las peticiones podrán versar sobre cualquier asunto o materia comprendido en el ámbito de competencias del destinatario, con independencia de que afecten exclusivamente al peticionario o sean de interés colectivo o general.', null, 'f7a59e74adc8471c96784c8fac99fe986f0d68256b1e44169f6e58e44205be9a', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'f7a59e74adc8471c96784c8fac99fe986f0d68256b1e44169f6e58e44205be9a')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Siempre que afecten exclusivamente al peticionario.', false), ('B', 'Con independencia de que afecten exclusivamente al peticionario o sean de interés colectivo o general.', true), ('C', 'Siempre que sean de interés general.', false), ('D', 'Siempre que no afecten a la organización interna del destinatario.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 4 de la Ley Orgánica 4/2001, en el caso de peticiones colectivas, además de los requisitos generales:', 'El art. 4.2 LO 4/2001 exige la firma de todos los peticionarios con su nombre y apellidos.', 'age_aux_b2_02_informacion_administrativa', (select id from public.topics where slug = 'age-aux-b2-02-informacion-administrativa'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2001-21090'), 'Art. 4.2 LODPET', 'En el caso de peticiones colectivas, además de cumplir los requisitos anteriores, serán firmadas por todos los peticionarios, debiendo figurar, junto a la firma de cada uno de ellos su nombre y apellidos.', null, '9ba49eb52b9a7b754e7d0374bd0d095fff3091af043560881ac63c92091c208a', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '9ba49eb52b9a7b754e7d0374bd0d095fff3091af043560881ac63c92091c208a')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Serán firmadas por todos los peticionarios, figurando junto a la firma de cada uno su nombre y apellidos.', true), ('B', 'Bastará la firma de un representante designado por los peticionarios.', false), ('C', 'Deberán presentarse a través de una asociación inscrita.', false), ('D', 'Se exigirá un mínimo de quinientas firmas acreditadas.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'De acuerdo con el artículo 5 de la Ley Orgánica 4/2001, en el territorio de una Comunidad Autónoma con cooficialidad lingüística, quien dirija una petición a la Administración General del Estado tendrá derecho a:', 'El art. 5.1 LO 4/2001 permite usar cualquiera de las lenguas oficiales y obtener respuesta en la lengua elegida.', 'age_aux_b2_02_informacion_administrativa', (select id from public.topics where slug = 'age-aux-b2-02-informacion-administrativa'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2001-21090'), 'Art. 5.1 LODPET', 'los peticionarios tendrán derecho a formular sus peticiones a la Administración General del Estado o a los organismos públicos vinculados o dependientes de ella en cualquiera de las lenguas oficiales y a obtener respuesta en la lengua de su elección.', null, 'b1050967306cc8c139015aee6cc2de23bcd1bcedc6456acd0534265484a44f7f', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'b1050967306cc8c139015aee6cc2de23bcd1bcedc6456acd0534265484a44f7f')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Formularla en cualquiera de las lenguas oficiales y obtener respuesta en la lengua de su elección.', true), ('B', 'Formularla en castellano y recibir la respuesta en la lengua cooficial.', false), ('C', 'Formularla en la lengua cooficial, pero la respuesta se dará siempre en castellano.', false), ('D', 'Formularla en la lengua cooficial solo si la acompaña de traducción al castellano.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 8 de la Ley Orgánica 4/2001, no se admitirán las peticiones sobre cuyo objeto exista un proceso judicial ya iniciado:', 'El art. 8 LO 4/2001 impide admitir peticiones sobre cuyo objeto haya un procedimiento parlamentario, administrativo o judicial iniciado mientras no exista acuerdo o resolución firme.', 'age_aux_b2_02_informacion_administrativa', (select id from public.topics where slug = 'age-aux-b2-02-informacion-administrativa'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2001-21090'), 'Art. 8 LODPET', 'Tampoco se admitirán aquellas peticiones sobre cuyo objeto exista un procedimiento parlamentario, administrativo o un proceso judicial ya iniciado, en tanto sobre los mismos no haya recaído acuerdo o resolución firme.', null, '6f18f8d42301a8a18d5546a8f62a4582581ed16bc49437ad90a32a455af2d1a5', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '6f18f8d42301a8a18d5546a8f62a4582581ed16bc49437ad90a32a455af2d1a5')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'En ningún caso, aunque ya haya recaído resolución firme.', false), ('B', 'Salvo que el peticionario no sea parte en el proceso.', false), ('C', 'En tanto sobre él no haya recaído acuerdo o resolución firme.', true), ('D', 'Salvo que la petición sea colectiva.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'De acuerdo con el artículo 10 de la Ley Orgánica 4/2001, cuando la inadmisibilidad de una petición se base en la falta de competencia de su destinatario, este la remitirá a la institución u organismo que estime competente en el plazo de:', 'El art. 10.1 LO 4/2001 fija diez días para la remisión al órgano competente, comunicándolo al peticionario.', 'age_aux_b2_02_informacion_administrativa', (select id from public.topics where slug = 'age-aux-b2-02-informacion-administrativa'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2001-21090'), 'Art. 10.1 LODPET', 'éste la remitirá a la institución, administración u organismo que estime competente en el plazo de diez días y lo comunicará así al peticionario.', null, 'b1de823ea9a8171aadf0d90968307be970cd9bee880d62852fabe0a648819ef2', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'b1de823ea9a8171aadf0d90968307be970cd9bee880d62852fabe0a648819ef2')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Cinco días.', false), ('B', 'Diez días.', true), ('C', 'Quince días.', false), ('D', 'Un mes.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 12 de la Ley Orgánica 4/2001, la declaración de inadmisibilidad de una petición o la omisión de la obligación de contestar en plazo podrán ser objeto de:', 'El art. 12 LO 4/2001 abre el procedimiento especial de protección de derechos fundamentales de la Ley 29/1998 (arts. 114 y ss.) frente a la inadmisión, la falta de contestación en plazo o la contestación sin los requisitos mínimos.', 'age_aux_b2_02_informacion_administrativa', (select id from public.topics where slug = 'age-aux-b2-02-informacion-administrativa'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2001-21090'), 'Art. 12 LODPET', 'Podrán ser objeto de recurso contencioso-administrativo, por el procedimiento de protección jurisdiccional de los derechos fundamentales de la persona, establecido en los artículos 114 y siguientes de la Ley 29/1998', null, '72d468a6b5a7bd09d1df86cb77a377cecdb0785a2e2e2e01e733f9b176f4e127', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '72d468a6b5a7bd09d1df86cb77a377cecdb0785a2e2e2e01e733f9b176f4e127')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Recurso de alzada ante el superior jerárquico, que agota la vía administrativa.', false), ('B', 'Reclamación ante el Defensor del Pueblo como única vía.', false), ('C', 'Recurso extraordinario de revisión.', false), ('D', 'Recurso contencioso-administrativo por el procedimiento de protección jurisdiccional de los derechos fundamentales de la persona.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 9 de la Ley Orgánica 4/2001, si la declaración de inadmisibilidad no se acuerda y notifica en el plazo de cuarenta y cinco días hábiles siguientes a la presentación del escrito:', 'El art. 9.2 LO 4/2001 dispone que, fuera de los casos de inadmisión en plazo, se entiende admitida a trámite la petición.', 'age_aux_b2_02_informacion_administrativa', (select id from public.topics where slug = 'age-aux-b2-02-informacion-administrativa'), 3, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2001-21090'), 'Art. 9.2 LODPET', 'En otro caso, se entenderá que la petición ha sido admitida a trámite.', null, 'f10a1d9ef2325c5baf48e2bc2b10dc7d610673c1e4dd42584d39e05c7804c8b8', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'f10a1d9ef2325c5baf48e2bc2b10dc7d610673c1e4dd42584d39e05c7804c8b8')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Se entenderá que la petición ha sido admitida a trámite.', true), ('B', 'Se entenderá que la petición ha sido inadmitida.', false), ('C', 'El peticionario deberá reiterar su petición.', false), ('D', 'Se entenderá que la petición ha sido estimada.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'De acuerdo con el artículo 11 de la Ley Orgánica 4/2001, una vez admitida a trámite una petición, la autoridad u órgano competente podrá, si lo considera necesario:', 'El art. 11.1 LO 4/2001, además del plazo máximo de tres meses para contestar, permite convocar a los peticionarios en audiencia especial.', 'age_aux_b2_02_informacion_administrativa', (select id from public.topics where slug = 'age-aux-b2-02-informacion-administrativa'), 3, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2001-21090'), 'Art. 11.1 LODPET', 'Asimismo podrá, si así lo considera necesario, convocar a los peticionarios en audiencia especial.', null, '6b445043d53bf887d1227c2ddd1dffd3a69a96befe4258cd2f30d32d62b32758', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '6b445043d53bf887d1227c2ddd1dffd3a69a96befe4258cd2f30d32d62b32758')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Exigir al peticionario una fianza.', false), ('B', 'Remitirla al Defensor del Pueblo para su informe.', false), ('C', 'Convocar a los peticionarios en audiencia especial.', true), ('D', 'Someterla a información pública durante veinte días.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 7 de la Ley Orgánica 4/2001, si se requiere al peticionario la aportación de datos o documentos complementarios imprescindibles para tramitar la petición y no los aporta:', 'El art. 7.3 LO 4/2001 distingue este supuesto de la subsanación del art. 7.2 (desistimiento): la no aportación no determina por sí sola la inadmisión.', 'age_aux_b2_02_informacion_administrativa', (select id from public.topics where slug = 'age-aux-b2-02-informacion-administrativa'), 3, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2001-21090'), 'Art. 7.3 LODPET', 'La no aportación de tales datos y documentos no determinará por sí sola la inadmisibilidad de la petición, sin perjuicio de sus efectos en la contestación que finalmente se adopte.', null, '46d8c6d5337e8aaefe4c55758a688e9a942a02b9f07125d59595efbde1ec30f2', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '46d8c6d5337e8aaefe4c55758a688e9a942a02b9f07125d59595efbde1ec30f2')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Se le tendrá por desistido de su petición.', false), ('B', 'La falta de aportación no determinará por sí sola la inadmisibilidad, sin perjuicio de sus efectos en la contestación.', true), ('C', 'Se declarará la inadmisibilidad de la petición.', false), ('D', 'Se suspenderá la tramitación hasta que los aporte.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
-- Lote age-aux-b2-02-informacion-administrativa-rdcal-v1 (3 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Real Decreto 951/2005, de 29 de julio, marco general para la mejora de la calidad en la Administración General del Estado (texto consolidado, BOE)', 'https://www.boe.es/buscar/act.php?id=BOE-A-2005-14836', 'boe'::public.source_kind, 'Agencia Estatal Boletín Oficial del Estado', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('age-aux-b2-02-informacion-administrativa', 'II.2 Los servicios de información administrativa: iniciativas, reclamaciones, quejas y peticiones') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('auxiliar-administrativo-estado') and t.slug = 'age-aux-b2-02-informacion-administrativa' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'De acuerdo con el artículo 15 del Real Decreto 951/2005, cuando las quejas o sugerencias se formulan presencialmente, los usuarios:', 'El art. 15.3 RD 951/2005 prevé un formulario que el usuario cumplimenta y firma, y le permite ser auxiliado por los funcionarios responsables.', 'age_aux_b2_02_informacion_administrativa', (select id from public.topics where slug = 'age-aux-b2-02-informacion-administrativa'), 1, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2005-14836'), 'Art. 15.3 RDCAL', 'Los usuarios podrán, si así lo desean, ser auxiliados por los funcionarios responsables en la formulación de su queja o sugerencia.', null, 'd79911f9c599586a2301d2507cdd7aae23b03cd3160d12e8af81f71768214dc2', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'd79911f9c599586a2301d2507cdd7aae23b03cd3160d12e8af81f71768214dc2')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Deberán presentarlas siempre por escrito libre, sin formulario.', false), ('B', 'Deberán acompañarlas de una copia de su documento de identidad compulsada.', false), ('C', 'Solo podrán presentarlas en el registro general del departamento.', false), ('D', 'Podrán, si así lo desean, ser auxiliados por los funcionarios responsables en su formulación.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 14 del Real Decreto 951/2005, la unidad responsable de la gestión de las quejas y sugerencias tiene por objeto recoger y tramitar:', 'El art. 14 RD 951/2005 encarga a esa unidad recoger y tramitar quejas (insatisfacción) y sugerencias (iniciativas de mejora), y responder e informar de las actuaciones y medidas adoptadas.', 'age_aux_b2_02_informacion_administrativa', (select id from public.topics where slug = 'age-aux-b2-02-informacion-administrativa'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2005-14836'), 'Art. 14 RDCAL', 'con objeto de recoger y tramitar tanto las manifestaciones de insatisfacción de los usuarios con los servicios como las iniciativas para mejorar su calidad.', null, '5ef4744f0c09645261287ca019843abd0bee4440e458e980c914209d4f81083b', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '5ef4744f0c09645261287ca019843abd0bee4440e458e980c914209d4f81083b')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Únicamente las reclamaciones por responsabilidad patrimonial.', false), ('B', 'Los recursos administrativos interpuestos contra actos del órgano.', false), ('C', 'Las solicitudes de acceso a la información pública.', false), ('D', 'Tanto las manifestaciones de insatisfacción de los usuarios con los servicios como las iniciativas para mejorar su calidad.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'De acuerdo con el artículo 17 del Real Decreto 951/2005, la unidad responsable de quejas y sugerencias remitirá a la Inspección General de Servicios de su ministerio un informe global de las recibidas en el año anterior:', 'El art. 17.3 RD 951/2005 fija el mes de enero para el informe global, estructurado según la clasificación del art. 15.5 y con copia de las contestaciones.', 'age_aux_b2_02_informacion_administrativa', (select id from public.topics where slug = 'age-aux-b2-02-informacion-administrativa'), 3, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2005-14836'), 'Art. 17.3 RDCAL', 'remitirá a la Inspección General de Servicios de su respectivo ministerio, en el mes de enero de cada año, un informe global de las quejas y sugerencias recibidas en el año anterior', null, '184e8209b371da58f47ad857318b1d29ab77ca65e6312d882a3874098058888b', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '184e8209b371da58f47ad857318b1d29ab77ca65e6312d882a3874098058888b')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'En el primer trimestre de cada año.', false), ('B', 'Antes del 30 de junio de cada año.', false), ('C', 'En el mes de enero de cada año.', true), ('D', 'En el mes de diciembre de cada año.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
-- Lote age-aux-b2-02-informacion-administrativa-rdinfo-v1 (4 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Real Decreto 208/1996, de 9 de febrero, por el que se regulan los servicios de información administrativa y atención al ciudadano (texto consolidado, BOE)', 'https://www.boe.es/buscar/act.php?id=BOE-A-1996-4997', 'boe'::public.source_kind, 'Agencia Estatal Boletín Oficial del Estado', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('age-aux-b2-02-informacion-administrativa', 'II.2 Los servicios de información administrativa: iniciativas, reclamaciones, quejas y peticiones') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('auxiliar-administrativo-estado') and t.slug = 'age-aux-b2-02-informacion-administrativa' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 2 del Real Decreto 208/1996, para la difusión de la información general se potenciarán especialmente los medios:', 'El art. 2.4 RD 208/1996 manda usar los medios adecuados en cada caso, potenciando los que permitan la información a distancia (publicaciones, sistemas telefónicos u otros avances tecnológicos).', 'age_aux_b2_02_informacion_administrativa', (select id from public.topics where slug = 'age-aux-b2-02-informacion-administrativa'), 1, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1996-4997'), 'Art. 2.4 RDINFO', 'Se utilizarán los medios de difusión que en cada circunstancia resulten adecuados, potenciando aquellos que permitan la información a distancia', null, 'de189b1bed8cf7bbf349dfad78ea12ca6a789c33122b78d8f97a9dd1312d1ca8', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'de189b1bed8cf7bbf349dfad78ea12ca6a789c33122b78d8f97a9dd1312d1ca8')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'De publicidad institucional en prensa escrita.', false), ('B', 'De atención presencial en las oficinas.', false), ('C', 'Que permitan la información a distancia.', true), ('D', 'De difusión en los tablones de anuncios oficiales.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'De acuerdo con el artículo 2 del Real Decreto 208/1996, cuando resulte conveniente una mayor difusión, la información de carácter general deberá ofrecerse:', 'El art. 2.3 RD 208/1996 prevé ofrecer la información general a los grupos sociales o instituciones interesados cuando convenga una mayor difusión.', 'age_aux_b2_02_informacion_administrativa', (select id from public.topics where slug = 'age-aux-b2-02-informacion-administrativa'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1996-4997'), 'Art. 2.3 RDINFO', 'Cuando resulte conveniente una mayor difusión, la información de carácter general deberá ofrecerse a los grupos sociales o instituciones que estén interesados en su conocimiento.', null, '34c457f3612614f77a6346ec5a5c449bfaacb55091eba80e7ba77584babb4f4a', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '34c457f3612614f77a6346ec5a5c449bfaacb55091eba80e7ba77584babb4f4a')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Solo a quienes acrediten la condición de interesados.', false), ('B', 'A los grupos sociales o instituciones que estén interesados en su conocimiento.', true), ('C', 'Exclusivamente a través del Boletín Oficial del Estado.', false), ('D', 'A las Cortes Generales, para su conocimiento.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 10 del Real Decreto 208/1996, la creación de oficinas integradas de información con participación de varias Administraciones públicas podrá acordarse mediante:', 'El art. 10 RD 208/1996 remite al convenio de colaboración entre Administraciones para ofrecer información de las otras y crear oficinas integradas.', 'age_aux_b2_02_informacion_administrativa', (select id from public.topics where slug = 'age-aux-b2-02-informacion-administrativa'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1996-4997'), 'Art. 10 RDINFO', 'Mediante convenio de colaboración, suscrito por distintas Administraciones públicas, podrá acordarse que desde las oficinas de información y atención de cualesquiera de ellas pueda ofrecerse a los ciudadanos la información administrativa de las otras […] así como la creación de oficinas integradas de información con participación de varias Administraciones públicas.', null, '947d51d2b28c8329c19e817da4ce35176f0d3c726780fa47339040349244b05b', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '947d51d2b28c8329c19e817da4ce35176f0d3c726780fa47339040349244b05b')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Convenio de colaboración suscrito por distintas Administraciones públicas.', true), ('B', 'Real decreto del Consejo de Ministros.', false), ('C', 'Orden del Ministro competente en materia de función pública.', false), ('D', 'Acuerdo de la Conferencia de Presidentes.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 3 del Real Decreto 208/1996, la información particular será aportada por:', 'El art. 3.3 RD 208/1996 atribuye la información particular a las unidades de gestión, que pueden conectarse con las oficinas de información para responder con agilidad.', 'age_aux_b2_02_informacion_administrativa', (select id from public.topics where slug = 'age-aux-b2-02-informacion-administrativa'), 3, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1996-4997'), 'Art. 3.3 RDINFO', 'Esta información será aportada por las unidades de gestión de la Administración General del Estado.', null, '6f0466153885295d4a9808d3ad5c2e6ec76a3ac8a58c2092bd2aac260cc42146', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '6f0466153885295d4a9808d3ad5c2e6ec76a3ac8a58c2092bd2aac260cc42146')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Las unidades departamentales de información administrativa.', false), ('B', 'El Centro de Información Administrativa.', false), ('C', 'Las oficinas de información de las Delegaciones del Gobierno.', false), ('D', 'Las unidades de gestión de la Administración General del Estado.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
-- Lote age-aux-b2-03-documento-registro-archivo-lpac-v1 (9 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Ley 39/2015, de 1 de octubre, del Procedimiento Administrativo Común de las Administraciones Públicas (texto consolidado, BOE)', 'https://www.boe.es/buscar/act.php?id=BOE-A-2015-10565', 'boe'::public.source_kind, 'Agencia Estatal Boletín Oficial del Estado', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('age-aux-b2-03-documento-registro-archivo', 'II.3 Documento, registro y archivo') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('auxiliar-administrativo-estado') and t.slug = 'age-aux-b2-03-documento-registro-archivo' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 28 de la Ley 39/2015, ¿quién se responsabiliza de la veracidad de los documentos que presentan los interesados en el procedimiento administrativo?', 'El art. 28.7 Ley 39/2015 hace responsables a los interesados de la veracidad de los documentos que presenten.', 'age_aux_b2_03_documento_registro_archivo', (select id from public.topics where slug = 'age-aux-b2-03-documento-registro-archivo'), 1, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2015-10565'), 'Art. 28.7 LPAC', 'Los interesados se responsabilizarán de la veracidad de los documentos que presenten.', null, 'cb18ad75437ecefaf6f860730769e736f8a26b63375d588b8dc1b500bdbc024a', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'cb18ad75437ecefaf6f860730769e736f8a26b63375d588b8dc1b500bdbc024a')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El funcionario de la oficina de asistencia en materia de registros que los recibe.', false), ('B', 'Los propios interesados.', true), ('C', 'El órgano instructor del procedimiento.', false), ('D', 'El órgano que expida la copia auténtica.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'De acuerdo con el artículo 28 de la Ley 39/2015, las Administraciones exigirán a los interesados la presentación de documentos originales:', 'El art. 28.3 Ley 39/2015 prohíbe exigir originales salvo que, excepcionalmente, lo establezca la normativa reguladora.', 'age_aux_b2_03_documento_registro_archivo', (select id from public.topics where slug = 'age-aux-b2-03-documento-registro-archivo'), 1, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2015-10565'), 'Art. 28.3 LPAC', 'Las Administraciones no exigirán a los interesados la presentación de documentos originales, salvo que, con carácter excepcional, la normativa reguladora aplicable establezca lo contrario.', null, '34dd03b784e3a6f7570def5b35cfbc8af510d6936b8a98d65eec749d1bc1f7fa', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '34dd03b784e3a6f7570def5b35cfbc8af510d6936b8a98d65eec749d1bc1f7fa')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'En todo caso, para su cotejo.', false), ('B', 'Siempre que el procedimiento se inicie a solicitud del interesado.', false), ('C', 'Solo cuando, con carácter excepcional, la normativa reguladora aplicable lo establezca.', true), ('D', 'Cuando el interesado no esté obligado a relacionarse electrónicamente.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 27 de la Ley 39/2015, las copias auténticas de documentos públicos administrativos solicitadas por los interesados deberán expedirse, salvo las excepciones derivadas de la Ley 19/2013, en el plazo de:', 'El art. 27.4 Ley 39/2015 dirige la solicitud al órgano que emitió el original y fija quince días desde su recepción en el registro electrónico competente.', 'age_aux_b2_03_documento_registro_archivo', (select id from public.topics where slug = 'age-aux-b2-03-documento-registro-archivo'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2015-10565'), 'Art. 27.4 LPAC', 'La solicitud se dirigirá al órgano que emitió el documento original, debiendo expedirse, salvo las excepciones derivadas de la aplicación de la Ley 19/2013, de 9 de diciembre, en el plazo de quince días a contar desde la recepción de la solicitud en el registro electrónico de la Administración u Organismo competente.', null, '48652a546cd4af70fefa9b846eddb45b59f0dc3460b3711acf1426d2a6c105e1', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '48652a546cd4af70fefa9b846eddb45b59f0dc3460b3711acf1426d2a6c105e1')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Quince días desde la recepción de la solicitud en el registro electrónico de la Administración u Organismo competente.', true), ('B', 'Diez días desde la presentación de la solicitud.', false), ('C', 'Un mes desde la recepción de la solicitud.', false), ('D', 'Veinte días hábiles desde la recepción de la solicitud por el órgano que emitió el documento original.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'De acuerdo con el artículo 27 de la Ley 39/2015, las copias auténticas de documentos privados:', 'El art. 27.1 Ley 39/2015 limita a efectos administrativos las copias auténticas de documentos privados; las realizadas por una Administración valen en las restantes.', 'age_aux_b2_03_documento_registro_archivo', (select id from public.topics where slug = 'age-aux-b2-03-documento-registro-archivo'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2015-10565'), 'Art. 27.1 LPAC', 'Las copias auténticas de documentos privados surten únicamente efectos administrativos. Las copias auténticas realizadas por una Administración Pública tendrán validez en las restantes Administraciones.', null, 'b7a9b02bc4b7de562f0e300aab454259d271fae959918d257ea11d8db705769b', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'b7a9b02bc4b7de562f0e300aab454259d271fae959918d257ea11d8db705769b')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Tienen la misma eficacia que una escritura pública.', false), ('B', 'Surten únicamente efectos administrativos.', true), ('C', 'Solo tienen validez en la Administración que las expidió.', false), ('D', 'Carecen de eficacia hasta su cotejo con el original.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 27 de la Ley 39/2015, el proceso tecnológico que permite convertir un documento en soporte papel o en otro soporte no electrónico en un fichero electrónico que contiene la imagen codificada, fiel e íntegra del documento se denomina:', 'El art. 27.3.b) Ley 39/2015 define la digitalización, requisito previo de las copias electrónicas de documentos en papel.', 'age_aux_b2_03_documento_registro_archivo', (select id from public.topics where slug = 'age-aux-b2-03-documento-registro-archivo'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2015-10565'), 'Art. 27.3.b) LPAC', 'Se entiende por digitalización, el proceso tecnológico que permite convertir un documento en soporte papel o en otro soporte no electrónico en un fichero electrónico que contiene la imagen codificada, fiel e íntegra del documento.', null, '750ca026cda7b3ff2875b3df8e3f8d3f2a09921075be8ad3c31dceaab96a4378', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '750ca026cda7b3ff2875b3df8e3f8d3f2a09921075be8ad3c31dceaab96a4378')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Digitalización.', true), ('B', 'Compulsa electrónica.', false), ('C', 'Copia simple electrónica.', false), ('D', 'Sellado de tiempo.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'De acuerdo con el artículo 16 de la Ley 39/2015, respecto de los registros electrónicos de cada Organismo, el Registro Electrónico General de cada Administración:', 'El art. 16.1 Ley 39/2015 permite a los organismos tener registro propio interoperable y configura el Registro Electrónico General como portal de acceso a ellos.', 'age_aux_b2_03_documento_registro_archivo', (select id from public.topics where slug = 'age-aux-b2-03-documento-registro-archivo'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2015-10565'), 'Art. 16.1 LPAC', 'El Registro Electrónico General de cada Administración funcionará como un portal que facilitará el acceso a los registros electrónicos de cada Organismo.', null, '38e7d51073a97d7c42b74cb787bf38af1da88d3ea1df4118be8fc4314546375e', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '38e7d51073a97d7c42b74cb787bf38af1da88d3ea1df4118be8fc4314546375e')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Los sustituye y suprime.', false), ('B', 'Ejercerá funciones de inspección sobre ellos.', false), ('C', 'Funcionará como un portal que facilitará el acceso a ellos.', true), ('D', 'Solo recogerá los asientos que esos registros no puedan practicar.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 16 de la Ley 39/2015, los documentos e información cuyo régimen especial establezca otra forma de presentación:', 'El art. 16.8 Ley 39/2015 dispone que no se tendrán por presentados; el art. 37.4 RD 203/2021 obliga a comunicarlo al interesado e informarle de los requisitos.', 'age_aux_b2_03_documento_registro_archivo', (select id from public.topics where slug = 'age-aux-b2-03-documento-registro-archivo'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2015-10565'), 'Art. 16.8 LPAC', 'No se tendrán por presentados en el registro aquellos documentos e información cuyo régimen especial establezca otra forma de presentación.', null, 'e9b5cc5f0f754f7d08f0bc2fcc16daf212dbeb4f629d74e99bf3b31ab22bb999', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'e9b5cc5f0f754f7d08f0bc2fcc16daf212dbeb4f629d74e99bf3b31ab22bb999')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Se tendrán por presentados en la fecha de su anotación en el registro.', false), ('B', 'No se tendrán por presentados en el registro.', true), ('C', 'Se remitirán de oficio al órgano competente para su presentación.', false), ('D', 'Se tendrán por presentados si el interesado los ratifica en diez días.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'De acuerdo con el artículo 17 de la Ley 39/2015, los medios o soportes en que se almacenen documentos deberán contar con medidas de seguridad de acuerdo con lo previsto en:', 'El art. 17.3 Ley 39/2015 remite al Esquema Nacional de Seguridad para garantizar integridad, autenticidad, confidencialidad, calidad, protección y conservación de los documentos.', 'age_aux_b2_03_documento_registro_archivo', (select id from public.topics where slug = 'age-aux-b2-03-documento-registro-archivo'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2015-10565'), 'Art. 17.3 LPAC', 'Los medios o soportes en que se almacenen documentos, deberán contar con medidas de seguridad, de acuerdo con lo previsto en el Esquema Nacional de Seguridad', null, '5642eb7341ca15effb3c6a1be98f7d2a25083793d6a80b89dfb88ff8a9c999b7', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '5642eb7341ca15effb3c6a1be98f7d2a25083793d6a80b89dfb88ff8a9c999b7')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El Esquema Nacional de Interoperabilidad.', false), ('B', 'La normativa de patrimonio histórico.', false), ('C', 'Las instrucciones de la Comisión de Archivos de la Administración General del Estado.', false), ('D', 'El Esquema Nacional de Seguridad.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 28 de la Ley 39/2015, el interesado tiene derecho a no aportar documentos que ya obren en poder de la Administración, que podrá consultarlos salvo oposición del interesado. Esa oposición no cabrá cuando:', 'El art. 28.2 Ley 39/2015 excluye la oposición del interesado a la consulta cuando la aportación se exige en el ejercicio de potestades sancionadoras o de inspección.', 'age_aux_b2_03_documento_registro_archivo', (select id from public.topics where slug = 'age-aux-b2-03-documento-registro-archivo'), 3, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2015-10565'), 'Art. 28.2 LPAC', 'La administración actuante podrá consultar o recabar dichos documentos salvo que el interesado se opusiera a ello. No cabrá la oposición cuando la aportación del documento se exigiera en el marco del ejercicio de potestades sancionadoras o de inspección.', null, '41ad61844bc2fedc9004600b998b1e8d89ee09d7a99d5097cb97e1b93689ad04', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '41ad61844bc2fedc9004600b998b1e8d89ee09d7a99d5097cb97e1b93689ad04')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El documento haya sido elaborado por otra Administración.', false), ('B', 'El procedimiento se haya iniciado de oficio.', false), ('C', 'El documento contenga datos de carácter personal.', false), ('D', 'La aportación del documento se exija en el marco del ejercicio de potestades sancionadoras o de inspección.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
-- Lote age-aux-b2-03-documento-registro-archivo-rdarch-v1 (8 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Real Decreto 1708/2011, de 18 de noviembre, Sistema Español de Archivos y Sistema de Archivos de la AGE (texto consolidado, BOE)', 'https://www.boe.es/buscar/act.php?id=BOE-A-2011-18541', 'boe'::public.source_kind, 'Agencia Estatal Boletín Oficial del Estado', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('age-aux-b2-03-documento-registro-archivo', 'II.3 Documento, registro y archivo') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('auxiliar-administrativo-estado') and t.slug = 'age-aux-b2-03-documento-registro-archivo' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 2.2 del Real Decreto 1708/2011, la destrucción física de unidades o series documentales por el órgano responsable del archivo u oficina pública en que se encuentren, empleando cualquier método que garantice la imposibilidad de su reconstrucción, se denomina:', 'El art. 2.2.i) RD 1708/2011 define así la eliminación de documentos.', 'age_aux_b2_03_documento_registro_archivo', (select id from public.topics where slug = 'age-aux-b2-03-documento-registro-archivo'), 1, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2011-18541'), 'Art. 2.2.i) RDARCH', 'i) Eliminación de documentos: Consiste en la destrucción física de unidades o series documentales por el órgano responsable del archivo u oficina pública en que se encuentren, empleando cualquier método que garantice la imposibilidad de reconstrucción de los mismos y su posterior utilización.', null, '327ac9016a6af1268374a3f3eb2b23f5c18027e36368fe98a21e01f3ae19f432', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '327ac9016a6af1268374a3f3eb2b23f5c18027e36368fe98a21e01f3ae19f432')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Expurgo provisional.', false), ('B', 'Transferencia de documentos.', false), ('C', 'Valoración documental.', false), ('D', 'Eliminación de documentos.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'De acuerdo con el artículo 2.2 del Real Decreto 1708/2011, las diferentes etapas por las que atraviesan los documentos desde que se producen hasta su eliminación o, en su caso, su conservación permanente constituyen:', 'El art. 2.2.e) RD 1708/2011 define el ciclo vital de los documentos; el calendario de conservación es el instrumento que fija los plazos de permanencia en cada fase (letra f).', 'age_aux_b2_03_documento_registro_archivo', (select id from public.topics where slug = 'age-aux-b2-03-documento-registro-archivo'), 1, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2011-18541'), 'Art. 2.2.e) RDARCH', 'e) Ciclo vital de documentos: Son las diferentes etapas por las que atraviesan los documentos desde que se producen hasta su eliminación conforme al procedimiento establecido, o en su caso, su conservación permanente.', null, 'afa4666f456817e0ebb362573c7799fc21e7afbd9c53395aaf2b837e0605e51c', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'afa4666f456817e0ebb362573c7799fc21e7afbd9c53395aaf2b837e0605e51c')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El ciclo vital de los documentos.', true), ('B', 'El calendario de conservación.', false), ('C', 'El cuadro de clasificación.', false), ('D', 'El sistema archivístico.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 2.2 del Real Decreto 1708/2011, se entiende por metadato:', 'El art. 2.2.j) RD 1708/2011 define el metadato como descripción estandarizada de las características de un conjunto de datos.', 'age_aux_b2_03_documento_registro_archivo', (select id from public.topics where slug = 'age-aux-b2-03-documento-registro-archivo'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2011-18541'), 'Art. 2.2.j) RDARCH', 'j) Metadato: Se entiende por metadato cualquier descripción estandarizada de las características de un conjunto de datos.', null, 'b36be60628f829248f46d6b27c41995a1da3da9f9e7d80d29b0bfa329c44482c', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'b36be60628f829248f46d6b27c41995a1da3da9f9e7d80d29b0bfa329c44482c')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Cualquier descripción estandarizada de las características de un conjunto de datos.', true), ('B', 'El código seguro de verificación de un documento electrónico.', false), ('C', 'La firma electrónica incorporada a un documento.', false), ('D', 'El índice de documentos de un expediente electrónico.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'De acuerdo con el artículo 10 del Real Decreto 1708/2011, el Archivo Central de cada Ministerio realizará las transferencias preceptivas y periódicas de documentos:', 'El art. 10.1.6.º RD 1708/2011 asigna al Archivo Central las transferencias al archivo intermedio con su relación de entrega.', 'age_aux_b2_03_documento_registro_archivo', (select id from public.topics where slug = 'age-aux-b2-03-documento-registro-archivo'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2011-18541'), 'Art. 10.1 RDARCH', '6.º Realizar las transferencias preceptivas y periódicas de documentos al archivo intermedio, acompañadas de su correspondiente relación de entrega.', null, 'f6951e769d5a206021059258f14af21b98a7af1e4752c1743749cddbb86a4674', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'f6951e769d5a206021059258f14af21b98a7af1e4752c1743749cddbb86a4674')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Al Archivo Histórico Nacional.', false), ('B', 'A los archivos de oficina o de gestión.', false), ('C', 'Al archivo intermedio, acompañadas de su correspondiente relación de entrega.', true), ('D', 'Al archivo electrónico único, sin relación de entrega.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 12 del Real Decreto 1708/2011, en el ámbito de los servicios periféricos del Estado desempeñan funciones idénticas a las de los archivos intermedio e histórico:', 'El art. 12 RD 1708/2011 atribuye esas funciones a los Archivos Históricos Provinciales o a los que se creen en las Delegaciones de Gobierno.', 'age_aux_b2_03_documento_registro_archivo', (select id from public.topics where slug = 'age-aux-b2-03-documento-registro-archivo'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2011-18541'), 'Art. 12 RDARCH', 'En el ámbito de los servicios periféricos del Estado, desempeñan idénticas funciones a las de los archivos intermedio e histórico los Archivos Históricos Provinciales o los que en el futuro se puedan crear en las Delegaciones de Gobierno.', null, '48dbfd8a1a2342f88dfde9109b5386e31a9f4ad4350fe2664ce0049b9edcebef', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '48dbfd8a1a2342f88dfde9109b5386e31a9f4ad4350fe2664ce0049b9edcebef')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Los archivos centrales de las Subdelegaciones del Gobierno.', false), ('B', 'Los Archivos Históricos Provinciales o los que en el futuro se puedan crear en las Delegaciones de Gobierno.', true), ('C', 'Los archivos de las Comunidades Autónomas.', false), ('D', 'Los archivos municipales de las capitales de provincia.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'De acuerdo con el artículo 2.2 del Real Decreto 1708/2011, el estudio y análisis de las características administrativas, jurídicas, fiscales, informativas e históricas de los documentos u otras agrupaciones documentales se denomina:', 'El art. 2.2.h) RD 1708/2011 define la valoración documental; la identificación (letra g) es la investigación y sistematización de las categorías en que se sustenta la estructura de un fondo.', 'age_aux_b2_03_documento_registro_archivo', (select id from public.topics where slug = 'age-aux-b2-03-documento-registro-archivo'), 3, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2011-18541'), 'Art. 2.2.h) RDARCH', 'h) Valoración documental: Es el estudio y análisis de las características administrativas, jurídicas, fiscales, informativas e históricas de los documentos u otras agrupaciones documentales.', null, '92363d64cd258271ca84a43680d02537a375655072ccbece3187c024dd922aa5', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '92363d64cd258271ca84a43680d02537a375655072ccbece3187c024dd922aa5')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Valoración documental.', true), ('B', 'Identificación.', false), ('C', 'Descripción archivística.', false), ('D', 'Clasificación.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 15 del Real Decreto 1708/2011, los grupos de trabajo de coordinación archivística de cada Departamento ministerial presentarán sus propuestas de eliminación o de conservación permanente para el dictamen preceptivo de:', 'El art. 15.1 RD 1708/2011 somete esas propuestas al dictamen preceptivo de la Comisión Superior Calificadora de Documentos Administrativos, órgano consultivo superior adscrito a la Comisión de Archivos (art. 13.6).', 'age_aux_b2_03_documento_registro_archivo', (select id from public.topics where slug = 'age-aux-b2-03-documento-registro-archivo'), 3, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2011-18541'), 'Art. 15.1 RDARCH', 'Los grupos de trabajo de coordinación archivística de cada Departamento ministerial presentarán sus propuestas de eliminación o en su caso, de conservación permanente para el dictamen preceptivo por la Comisión Superior Calificadora de Documentos Administrativos.', null, 'e8fcfd64e2dc9ce41b5b05574f2da9a08d485f56f861edc2eb900e886a47212f', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'e8fcfd64e2dc9ce41b5b05574f2da9a08d485f56f861edc2eb900e886a47212f')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'La Comisión de Archivos de la Administración General del Estado.', false), ('B', 'El Archivo General de la Administración.', false), ('C', 'La Comisión Superior Calificadora de Documentos Administrativos.', true), ('D', 'La Subsecretaría del Ministerio de Cultura.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'De acuerdo con el artículo 15 del Real Decreto 1708/2011, los calendarios de conservación determinarán para cada serie o agrupación documental las fases de:', 'El art. 15.3 RD 1708/2011 fija en los calendarios las fases de actividad, semiactividad o inactividad y los periodos de permanencia en cada tipo de archivo.', 'age_aux_b2_03_documento_registro_archivo', (select id from public.topics where slug = 'age-aux-b2-03-documento-registro-archivo'), 3, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2011-18541'), 'Art. 15.3 RDARCH', 'Los calendarios de conservación, determinarán para cada serie o agrupación documental, las fases de actividad, semiactividad o inactividad administrativa', null, '2dac7c91623036b8130d7f1c3ef475faf6386661595b5fd5cc53f33f171243bf', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '2dac7c91623036b8130d7f1c3ef475faf6386661595b5fd5cc53f33f171243bf')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Recepción, tramitación y resolución administrativa.', false), ('B', 'Actividad, semiactividad o inactividad administrativa.', true), ('C', 'Gestión, consulta y difusión.', false), ('D', 'Producción, valoración y eliminación.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
-- Lote age-aux-b2-03-documento-registro-archivo-rdelec-v1 (3 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Real Decreto 203/2021, de 30 de marzo, Reglamento de actuación y funcionamiento del sector público por medios electrónicos (texto consolidado, BOE)', 'https://www.boe.es/buscar/act.php?id=BOE-A-2021-5032', 'boe'::public.source_kind, 'Agencia Estatal Boletín Oficial del Estado', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('age-aux-b2-03-documento-registro-archivo', 'II.3 Documento, registro y archivo') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('auxiliar-administrativo-estado') and t.slug = 'age-aux-b2-03-documento-registro-archivo' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 38 del Real Decreto 203/2021, las anotaciones en el Registro General de la Administración General del Estado tendrán plena eficacia y validez:', 'El art. 38.2 RD 203/2021 reconoce plena eficacia y validez de esas anotaciones para todas las Administraciones Públicas.', 'age_aux_b2_03_documento_registro_archivo', (select id from public.topics where slug = 'age-aux-b2-03-documento-registro-archivo'), 1, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2021-5032'), 'Art. 38.2 RDELEC', 'Las anotaciones en el Registro General de la Administración General del Estado tendrán plena eficacia y validez para todas las Administraciones Públicas.', null, 'bead5dbee253cbce9eb4fb7bfe144e9e7ac423e9e7ef2a92f5daf314eee051ac', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'bead5dbee253cbce9eb4fb7bfe144e9e7ac423e9e7ef2a92f5daf314eee051ac')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Solo en el ámbito de la Administración General del Estado.', false), ('B', 'Solo en el ámbito del departamento ministerial que las practique.', false), ('C', 'Para todas las Administraciones Públicas.', true), ('D', 'Para las Administraciones que hayan suscrito el convenio correspondiente.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'De acuerdo con el artículo 40 del Real Decreto 203/2021, las Oficinas de asistencia en materia de registros de la Administración General del Estado tienen naturaleza de:', 'El art. 40.1 RD 203/2021 les atribuye naturaleza de órgano administrativo, conforme al art. 5 de la Ley 40/2015.', 'age_aux_b2_03_documento_registro_archivo', (select id from public.topics where slug = 'age-aux-b2-03-documento-registro-archivo'), 1, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2021-5032'), 'Art. 40.1 RDELEC', 'Las Oficinas de asistencia en materia de registros tienen naturaleza de órgano administrativo de acuerdo con lo dispuesto en el artículo 5 de la Ley 40/2015, de 1 de octubre.', null, 'a4309a3b4e47f968237f30b596df60331dcd62c1d447e25caf8df3fb3ec2d988', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'a4309a3b4e47f968237f30b596df60331dcd62c1d447e25caf8df3fb3ec2d988')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Unidad administrativa sin funciones con efectos jurídicos.', false), ('B', 'Organismo público.', false), ('C', 'Órgano colegiado.', false), ('D', 'Órgano administrativo.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 54 del Real Decreto 203/2021, la conservación de los documentos electrónicos deberá permitir su acceso y comprender, como mínimo:', 'El art. 54.3 RD 203/2021 exige conservar como mínimo identificación, contenido, metadatos, firma, estructura y formato.', 'age_aux_b2_03_documento_registro_archivo', (select id from public.topics where slug = 'age-aux-b2-03-documento-registro-archivo'), 3, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2021-5032'), 'Art. 54.3 RDELEC', 'La conservación de los documentos electrónicos deberá realizarse de forma que permita su acceso y comprenda, como mínimo, su identificación, contenido, metadatos, firma, estructura y formato.', null, 'ed6e56d86e6311e84ca77eb10a4703c2bf90dd1bfec808c6b734aa03c9d262aa', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'ed6e56d86e6311e84ca77eb10a4703c2bf90dd1bfec808c6b734aa03c9d262aa')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Su contenido y su firma.', false), ('B', 'Su identificación, contenido y fecha de archivo.', false), ('C', 'Su contenido, metadatos y código seguro de verificación.', false), ('D', 'Su identificación, contenido, metadatos, firma, estructura y formato.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
-- Lote age-aux-b2-04-administracion-electronica-lpac-v1 (6 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Ley 39/2015, de 1 de octubre, del Procedimiento Administrativo Común de las Administraciones Públicas (texto consolidado, BOE)', 'https://www.boe.es/buscar/act.php?id=BOE-A-2015-10565', 'boe'::public.source_kind, 'Agencia Estatal Boletín Oficial del Estado', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('age-aux-b2-04-administracion-electronica', 'II.4 Administración electrónica y servicios al ciudadano') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('auxiliar-administrativo-estado') and t.slug = 'age-aux-b2-04-administracion-electronica' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 9.2.c) de la Ley 39/2015, cuando una Administración considere válido un sistema de identificación distinto de los basados en certificados cualificados, ¿cuánto tiempo debe transcurrir desde la comunicación a la Secretaría General de Administración Digital antes de su eficacia jurídica?', 'El art. 9.2.c) LPAC exige que transcurran dos meses desde la comunicación, durante los cuales puede acudirse a la vía jurisdiccional por motivos de seguridad pública.', 'age_aux_b2_04_administracion_electronica', (select id from public.topics where slug = 'age-aux-b2-04-administracion-electronica'), 3, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2015-10565'), 'Art. 9.2.c) LPAC', 'De forma previa a la eficacia jurídica del sistema, habrán de transcurrir dos meses desde dicha comunicación', null, '42543a22ff3431b1ba4a4cc2b65aff35dc99b4546be35fde4dd49ca12f47ce0a', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '42543a22ff3431b1ba4a4cc2b65aff35dc99b4546be35fde4dd49ca12f47ce0a')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Diez días.', false), ('B', 'Un mes.', false), ('C', 'Tres meses.', false), ('D', 'Dos meses.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'De acuerdo con el artículo 9.2 de la Ley 39/2015, las Administraciones Públicas deberán garantizar que, para todo procedimiento, sea posible utilizar:', 'El art. 9.2 LPAC obliga a garantizar el uso de uno de los sistemas de las letras a) y b) (certificados cualificados de firma o de sello), aunque se admitan también los de la letra c).', 'age_aux_b2_04_administracion_electronica', (select id from public.topics where slug = 'age-aux-b2-04-administracion-electronica'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2015-10565'), 'Art. 9.2 LPAC', 'Las Administraciones Públicas deberán garantizar que la utilización de uno de los sistemas previstos en las letras a) y b) sea posible para todo procedimiento', null, '781831b36ad3815307ab7e6580a6f29d6f4e91c9f83241f8937d2772dcdfd35d', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '781831b36ad3815307ab7e6580a6f29d6f4e91c9f83241f8937d2772dcdfd35d')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Uno de los sistemas basados en certificados electrónicos cualificados de firma o de sello electrónico.', true), ('B', 'Un sistema de clave concertada registrado previamente.', false), ('C', 'La comparecencia presencial ante un funcionario habilitado.', false), ('D', 'El Documento Nacional de Identidad en soporte papel escaneado.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 10.5 de la Ley 39/2015, cuando los interesados utilicen un sistema de firma de los previstos en la ley, su identidad:', 'El art. 10.5 LPAC dispone que el propio acto de firmar acredita la identidad del interesado.', 'age_aux_b2_04_administracion_electronica', (select id from public.topics where slug = 'age-aux-b2-04-administracion-electronica'), 1, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2015-10565'), 'Art. 10.5 LPAC', '5. Cuando los interesados utilicen un sistema de firma de los previstos en este artículo, su identidad se entenderá ya acreditada mediante el propio acto de la firma.', null, 'e2f6e5cf7e802c909727668acab221990f0bae991b228b0a62462e3a2172cb5b', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'e2f6e5cf7e802c909727668acab221990f0bae991b228b0a62462e3a2172cb5b')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Deberá acreditarse además mediante un sistema de identificación distinto.', false), ('B', 'Deberá ser verificada posteriormente por un funcionario habilitado.', false), ('C', 'Se entenderá ya acreditada mediante el propio acto de la firma.', true), ('D', 'Solo se entenderá acreditada si la firma está basada en el DNI electrónico.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Conforme al artículo 12.2 de la Ley 39/2015, si un interesado no obligado a relacionarse electrónicamente no dispone de los medios electrónicos necesarios, su identificación o firma electrónica podrá realizarla válidamente:', 'El art. 12.2 LPAC lo permite a un funcionario público, previa identificación y consentimiento expreso del interesado, del que debe quedar constancia.', 'age_aux_b2_04_administracion_electronica', (select id from public.topics where slug = 'age-aux-b2-04-administracion-electronica'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2015-10565'), 'Art. 12.2 LPAC', 'su identificación o firma electrónica en el procedimiento administrativo podrá ser válidamente realizada por un funcionario público mediante el uso del sistema de firma electrónica del que esté dotado para ello', null, 'aa46c0c171b09353e763e20e46a7f16643117025ede775389e4f4da932e39512', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'aa46c0c171b09353e763e20e46a7f16643117025ede775389e4f4da932e39512')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Su representante legal, sin necesidad de consentimiento.', false), ('B', 'Un funcionario público mediante el uso del sistema de firma electrónica del que esté dotado para ello.', true), ('C', 'Cualquier empleado público de la oficina, sin dejar constancia.', false), ('D', 'La Secretaría General de Administración Digital mediante sello electrónico.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'De acuerdo con el artículo 41.7 de la Ley 39/2015, cuando el interesado haya sido notificado por distintos cauces, se tomará como fecha de notificación:', 'El art. 41.7 LPAC toma como fecha la de la primera notificación practicada.', 'age_aux_b2_04_administracion_electronica', (select id from public.topics where slug = 'age-aux-b2-04-administracion-electronica'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2015-10565'), 'Art. 41.7 LPAC', '7. Cuando el interesado fuera notificado por distintos cauces, se tomará como fecha de notificación la de aquélla que se hubiera producido en primer lugar.', null, 'bc77f2427427e2cc7f55cf04ef64bfeec66b955bb7fabda67962f781733b9389', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'bc77f2427427e2cc7f55cf04ef64bfeec66b955bb7fabda67962f781733b9389')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'La de la última notificación practicada.', false), ('B', 'La de aquella que se hubiera producido en primer lugar.', true), ('C', 'La de la notificación practicada en papel.', false), ('D', 'La que elija el interesado.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 43.4 de la Ley 39/2015, los interesados podrán acceder a las notificaciones desde:', 'El art. 43.4 LPAC configura el Punto de Acceso General electrónico como portal de acceso a las notificaciones.', 'age_aux_b2_04_administracion_electronica', (select id from public.topics where slug = 'age-aux-b2-04-administracion-electronica'), 1, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2015-10565'), 'Art. 43.4 LPAC', '4. Los interesados podrán acceder a las notificaciones desde el Punto de Acceso General electrónico de la Administración, que funcionará como un portal de acceso.', null, '088ddb77568d0f594a3e913f5e8c2f6a8b4d052efda4ec0e14057d5d34fa739b', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '088ddb77568d0f594a3e913f5e8c2f6a8b4d052efda4ec0e14057d5d34fa739b')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El tablón edictal del Boletín Oficial del Estado.', false), ('B', 'El registro electrónico de apoderamientos.', false), ('C', 'El Registro Electrónico General de la Administración.', false), ('D', 'El Punto de Acceso General electrónico de la Administración, que funcionará como un portal de acceso.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
-- Lote age-aux-b2-04-administracion-electronica-lrjsp-v1 (3 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Ley 40/2015, de 1 de octubre, de Régimen Jurídico del Sector Público (texto consolidado, BOE)', 'https://www.boe.es/buscar/act.php?id=BOE-A-2015-10566', 'boe'::public.source_kind, 'Agencia Estatal Boletín Oficial del Estado', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('age-aux-b2-04-administracion-electronica', 'II.4 Administración electrónica y servicios al ciudadano') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('auxiliar-administrativo-estado') and t.slug = 'age-aux-b2-04-administracion-electronica' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 39 de la Ley 40/2015, el punto de acceso electrónico cuya titularidad corresponde a una Administración Pública, organismo público o entidad de Derecho Público y que permite el acceso a través de internet a la información publicada y, en su caso, a la sede electrónica correspondiente es:', 'El art. 39 LRJSP define así el portal de internet.', 'age_aux_b2_04_administracion_electronica', (select id from public.topics where slug = 'age-aux-b2-04-administracion-electronica'), 1, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2015-10566'), 'Art. 39 LRJSP', 'Se entiende por portal de internet el punto de acceso electrónico cuya titularidad corresponda a una Administración Pública, organismo público o entidad de Derecho Público que permite el acceso a través de internet a la información publicada y, en su caso, a la sede electrónica correspondiente.', null, '15fb6a9e8fdb5b73a8a9c1a485918c9c8b63e9428be62a1c29e05b8f5fa523aa', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '15fb6a9e8fdb5b73a8a9c1a485918c9c8b63e9428be62a1c29e05b8f5fa523aa')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'La sede electrónica asociada.', false), ('B', 'La Carpeta Ciudadana.', false), ('C', 'La Dirección Electrónica Habilitada única.', false), ('D', 'El portal de internet.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 38.2 de la Ley 40/2015, el establecimiento de una sede electrónica conlleva la responsabilidad del titular respecto de:', 'El art. 38.2 LRJSP atribuye al titular la responsabilidad por la integridad, veracidad y actualización de la información y servicios.', 'age_aux_b2_04_administracion_electronica', (select id from public.topics where slug = 'age-aux-b2-04-administracion-electronica'), 1, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2015-10566'), 'Art. 38.2 LRJSP', '2. El establecimiento de una sede electrónica conlleva la responsabilidad del titular respecto de la integridad, veracidad y actualización de la información y los servicios a los que pueda accederse a través de la misma.', null, 'd3cb0fd4e869a16e47ef53f5595f05e3ccf0378500670c257b9f513cca2f6265', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'd3cb0fd4e869a16e47ef53f5595f05e3ccf0378500670c257b9f513cca2f6265')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'La integridad, veracidad y actualización de la información y los servicios a los que pueda accederse a través de ella.', true), ('B', 'La custodia de los certificados electrónicos de los ciudadanos que acceden a ella.', false), ('C', 'La resolución de todos los procedimientos que se inicien a través de ella.', false), ('D', 'La publicación de los presupuestos anuales del organismo.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 41.1 de la Ley 40/2015, se entiende por actuación administrativa automatizada cualquier acto o actuación realizada íntegramente a través de medios electrónicos en el marco de un procedimiento administrativo y en la que:', 'El art. 41.1 LRJSP define la actuación automatizada por la falta de intervención directa de un empleado público.', 'age_aux_b2_04_administracion_electronica', (select id from public.topics where slug = 'age-aux-b2-04-administracion-electronica'), 1, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2015-10566'), 'Art. 41.1 LRJSP', '1. Se entiende por actuación administrativa automatizada, cualquier acto o actuación realizada íntegramente a través de medios electrónicos por una Administración Pública en el marco de un procedimiento administrativo y en la que no haya intervenido de forma directa un empleado público.', null, '1725dad10516b366941a376f133e5d7d234f22674458f99631068084ac4ac0b6', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '1725dad10516b366941a376f133e5d7d234f22674458f99631068084ac4ac0b6')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Intervenga un empleado público mediante firma con certificado.', false), ('B', 'Participen al menos dos Administraciones Públicas.', false), ('C', 'El interesado haya prestado su consentimiento expreso.', false), ('D', 'No haya intervenido de forma directa un empleado público.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
-- Lote age-aux-b2-04-administracion-electronica-rdacc-v1 (2 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Real Decreto 1112/2018, de 7 de septiembre, sobre accesibilidad de los sitios web y aplicaciones para dispositivos móviles del sector público (texto consolidado, BOE)', 'https://www.boe.es/buscar/act.php?id=BOE-A-2018-12699', 'boe'::public.source_kind, 'Agencia Estatal Boletín Oficial del Estado', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('age-aux-b2-04-administracion-electronica', 'II.4 Administración electrónica y servicios al ciudadano') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('auxiliar-administrativo-estado') and t.slug = 'age-aux-b2-04-administracion-electronica' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'De acuerdo con el artículo 7.3 del Real Decreto 1112/2018, ¿cuál de los siguientes NO se considera motivo que permita apreciar la excepción de carga desproporcionada en materia de accesibilidad?', 'El art. 7.3 RDACC excluye expresamente la falta de prioridad, de tiempo o de conocimientos; las demás circunstancias forman parte del concepto de carga desproporcionada (art. 7.2).', 'age_aux_b2_04_administracion_electronica', (select id from public.topics where slug = 'age-aux-b2-04-administracion-electronica'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2018-12699'), 'Art. 7.3 RDACC', '3. No se consideran motivos que permitan apreciar la excepción de la carga desproporcionada la falta de prioridad, de tiempo o de conocimientos.', null, '6f857e8bd62848679b0b8735138b4731bb21a9bb5e311f7d5526eb162ec9f824', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '6f857e8bd62848679b0b8735138b4731bb21a9bb5e311f7d5526eb162ec9f824')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Una carga financiera y organizativa excesiva para la entidad.', false), ('B', 'Que se comprometa la capacidad de la entidad para cumplir su cometido.', false), ('C', 'La falta de prioridad, de tiempo o de conocimientos.', true), ('D', 'Que se comprometa la capacidad de la entidad para publicar la información necesaria para sus tareas.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 13 del Real Decreto 1112/2018, recibida una reclamación en materia de accesibilidad, la Unidad responsable deberá responder en el plazo máximo de dos meses; si transcurre ese plazo sin notificar la resolución:', 'El art. 13.6 RDACC establece el sentido desestimatorio del silencio en la reclamación.', 'age_aux_b2_04_administracion_electronica', (select id from public.topics where slug = 'age-aux-b2-04-administracion-electronica'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2018-12699'), 'Art. 13.4 RDACC', '4. Recibida la reclamación, la Unidad responsable de atenderla deberá responder a la persona interesada en el plazo máximo de dos meses. […] 6. Transcurrido el plazo máximo para resolver la reclamación sin que se haya notificado la resolución de la misma, se entenderá que la reclamación ha sido desestimada.', null, 'b9c2c36240a0750bdc5d0bb830b725ef36cac933aa27087e1f6b29ed8da8771c', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'b9c2c36240a0750bdc5d0bb830b725ef36cac933aa27087e1f6b29ed8da8771c')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Se entenderá que la reclamación ha sido desestimada.', true), ('B', 'Se entenderá estimada la reclamación.', false), ('C', 'Se ampliará automáticamente el plazo un mes más.', false), ('D', 'La reclamación pasará a la Agencia Española de Protección de Datos.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
-- Lote age-aux-b2-04-administracion-electronica-rdelec-v1 (9 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Real Decreto 203/2021, de 30 de marzo, Reglamento de actuación y funcionamiento del sector público por medios electrónicos (texto consolidado, BOE)', 'https://www.boe.es/buscar/act.php?id=BOE-A-2021-5032', 'boe'::public.source_kind, 'Agencia Estatal Boletín Oficial del Estado', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('age-aux-b2-04-administracion-electronica', 'II.4 Administración electrónica y servicios al ciudadano') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('auxiliar-administrativo-estado') and t.slug = 'age-aux-b2-04-administracion-electronica' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 2 del Real Decreto 203/2021, la capacidad de los sistemas de información, y de los procedimientos a los que dan soporte, de compartir datos y posibilitar el intercambio de información entre ellos se corresponde con el principio de:', 'El art. 2.d) RD 203/2021 define así el principio de interoperabilidad.', 'age_aux_b2_04_administracion_electronica', (select id from public.topics where slug = 'age-aux-b2-04-administracion-electronica'), 1, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2021-5032'), 'Art. 2.d) RDELEC', 'd) El principio de interoperabilidad, entendido como la capacidad de los sistemas de información y, por ende, de los procedimientos a los que éstos dan soporte, de compartir datos y posibilitar el intercambio de información entre ellos.', null, 'dc9e245041ddf16390e10a0db72c8805009cc5fd238817dca7e4e76e73e6b317', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'dc9e245041ddf16390e10a0db72c8805009cc5fd238817dca7e4e76e73e6b317')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Neutralidad tecnológica.', false), ('B', 'Interoperabilidad.', true), ('C', 'Proporcionalidad.', false), ('D', 'Facilidad de uso.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'De acuerdo con el artículo 2 del Real Decreto 203/2021, el principio que determina que el diseño de los servicios electrónicos esté centrado en las personas usuarias, de forma que se minimice el grado de conocimiento necesario para usarlos, es el principio de:', 'El art. 2.c) RD 203/2021 recoge el principio de facilidad de uso.', 'age_aux_b2_04_administracion_electronica', (select id from public.topics where slug = 'age-aux-b2-04-administracion-electronica'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2021-5032'), 'Art. 2.c) RDELEC', 'c) El principio de facilidad de uso, que determina que el diseño de los servicios electrónicos esté centrado en las personas usuarias, de forma que se minimice el grado de conocimiento necesario para el uso del servicio.', null, '437b9e4e3cf3177934fd6e9a3ed66a9dbb456a16c6ae66ef015cc69c5ef3291b', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '437b9e4e3cf3177934fd6e9a3ed66a9dbb456a16c6ae66ef015cc69c5ef3291b')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Accesibilidad.', false), ('B', 'Personalización y proactividad.', false), ('C', 'Adaptabilidad al progreso de las tecnologías.', false), ('D', 'Facilidad de uso.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 2.e) del Real Decreto 203/2021, en virtud del principio de proporcionalidad:', 'El art. 2.e) RD 203/2021 define el principio de proporcionalidad en función de la naturaleza y circunstancias de cada trámite.', 'age_aux_b2_04_administracion_electronica', (select id from public.topics where slug = 'age-aux-b2-04-administracion-electronica'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2021-5032'), 'Art. 2.e) RDELEC', 'e) El principio de proporcionalidad, en cuya virtud sólo se exigirán las garantías y medidas de seguridad adecuadas a la naturaleza y circunstancias de los distintos trámites y actuaciones electrónicos.', null, 'cfabcc6b52bfba53924042fea09be0d960b7fcce2453244a477331bee7e46101', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'cfabcc6b52bfba53924042fea09be0d960b7fcce2453244a477331bee7e46101')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Solo se exigirán las garantías y medidas de seguridad adecuadas a la naturaleza y circunstancias de los distintos trámites y actuaciones electrónicos.', true), ('B', 'Solo se utilizarán estándares abiertos en las comunicaciones electrónicas.', false), ('C', 'Los servicios electrónicos se adaptarán al nivel de conocimientos de cada persona usuaria.', false), ('D', 'Las tasas de los servicios electrónicos serán proporcionales a su coste.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'De acuerdo con el artículo 3.3 del Real Decreto 203/2021, en el ámbito estatal la obligación de relacionarse electrónicamente para determinados colectivos de personas físicas podrá establecerse:', 'El art. 3.3 RD 203/2021 permite establecerla por real decreto acordado en Consejo de Ministros o por orden ministerial, si la regulación no requiere rango de real decreto.', 'age_aux_b2_04_administracion_electronica', (select id from public.topics where slug = 'age-aux-b2-04-administracion-electronica'), 3, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2021-5032'), 'Art. 3.3 RDELEC', 'en el ámbito estatal la mencionada obligatoriedad de relacionarse por medios electrónicos con sus órganos, organismos y entidades de derecho público podrá ser establecida por real decreto acordado en Consejo de Ministros o por orden de la persona titular del Departamento competente', null, 'daffca1493b42950b00893190550bdc5d28a6c122b9fdcd66de10e6bf92b8059', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'daffca1493b42950b00893190550bdc5d28a6c122b9fdcd66de10e6bf92b8059')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Únicamente por ley aprobada por las Cortes Generales.', false), ('B', 'Por resolución de la Secretaría General de Administración Digital.', false), ('C', 'Por real decreto acordado en Consejo de Ministros o por orden de la persona titular del Departamento competente.', true), ('D', 'Por instrucción del órgano competente para tramitar cada procedimiento.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'De acuerdo con el artículo 6.1 del Real Decreto 203/2021, la creación de un portal de internet en el ámbito estatal requerirá informe favorable de:', 'El art. 6.1 RD 203/2021 exige informe favorable de la Comisión Ministerial de Administración Digital y comunicación posterior a los Ministerios de Política Territorial y Función Pública y de Asuntos Económicos y Transformación Digital.', 'age_aux_b2_04_administracion_electronica', (select id from public.topics where slug = 'age-aux-b2-04-administracion-electronica'), 3, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2021-5032'), 'Art. 6.1 RDELEC', 'La creación requerirá informe favorable de la Comisión Ministerial de Administración Digital respectiva', null, '0d63b67efb470570682056891a2001d8fee22ccff7e2ccaa9d8391e293b09fb0', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '0d63b67efb470570682056891a2001d8fee22ccff7e2ccaa9d8391e293b09fb0')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'La Comisión Ministerial de Administración Digital respectiva.', true), ('B', 'El Ministerio de Hacienda.', false), ('C', 'La Agencia Española de Protección de Datos.', false), ('D', 'El Consejo de Ministros.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 10.1 del Real Decreto 203/2021, la sede electrónica asociada:', 'El art. 10.1 RD 203/2021 permite crear sedes asociadas por razones técnicas y organizativas y les da consideración de sede electrónica a todos los efectos.', 'age_aux_b2_04_administracion_electronica', (select id from public.topics where slug = 'age-aux-b2-04-administracion-electronica'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2021-5032'), 'Art. 10.1 RDELEC', 'La sede electrónica asociada tendrá consideración de sede electrónica a todos los efectos.', null, '6c11ee3007c0f3aee186547e12e241b38a641e496b7a213e977b7db40822abf1', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '6c11ee3007c0f3aee186547e12e241b38a641e496b7a213e977b7db40822abf1')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Carece de validez para la práctica de notificaciones.', false), ('B', 'Solo puede crearse en el ámbito de las entidades locales.', false), ('C', 'Tendrá consideración de sede electrónica a todos los efectos.', true), ('D', 'Depende jerárquicamente del portal de internet del ministerio.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'De acuerdo con el artículo 10.2 del Real Decreto 203/2021, el acto de creación de una sede electrónica de una entidad local se publicará en:', 'El art. 10.2 RD 203/2021 indica que, en el caso de las entidades locales, el boletín oficial será el de la provincia.', 'age_aux_b2_04_administracion_electronica', (select id from public.topics where slug = 'age-aux-b2-04-administracion-electronica'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2021-5032'), 'Art. 10.2 RDELEC', 'En el caso de las entidades locales, el boletín oficial será el de la provincia al que pertenezca la entidad.', null, '58faaf90bf45282f472e24f24a26174469fa623bfb8107b31f88660d78ac4431', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '58faaf90bf45282f472e24f24a26174469fa623bfb8107b31f88660d78ac4431')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El Boletín Oficial del Estado.', false), ('B', 'El boletín oficial de la provincia a la que pertenezca la entidad.', true), ('C', 'El boletín oficial de la comunidad autónoma.', false), ('D', 'El tablón de anuncios del ayuntamiento exclusivamente.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'De acuerdo con el artículo 42.4 del Real Decreto 203/2021, en caso de sucesión de una persona interesada, la persona o entidad sucesora debe comunicarla a la Administración que tramita el procedimiento en el plazo de:', 'El art. 42.4 RD 203/2021 fija un plazo de 15 días hábiles desde el día siguiente al de la efectividad de la sucesión o la inscripción de la defunción.', 'age_aux_b2_04_administracion_electronica', (select id from public.topics where slug = 'age-aux-b2-04-administracion-electronica'), 3, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2021-5032'), 'Art. 42.4 RDELEC', 'la sucesión a la Administración Pública a la que corresponda la tramitación de aquel, en el plazo de 15 días hábiles', null, '62b49c34a4993aba6d859c9353956327b4dd4b06bd92d46255ca30caaee9a18b', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '62b49c34a4993aba6d859c9353956327b4dd4b06bd92d46255ca30caaee9a18b')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Diez días naturales.', false), ('B', 'Un mes.', false), ('C', 'Quince días hábiles.', true), ('D', 'Veinte días hábiles.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 21 del Real Decreto 203/2021, el plazo de disponibilidad para la verificación en sede electrónica del código seguro de verificación aplicado a un documento será, salvo que la normativa especial prevea uno superior, de al menos:', 'La letra e) del art. 21 RD 203/2021 fija un mínimo de cinco años.', 'age_aux_b2_04_administracion_electronica', (select id from public.topics where slug = 'age-aux-b2-04-administracion-electronica'), 3, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2021-5032'), 'Art. 21.e) RDELEC', 'Este plazo será al menos de cinco años, salvo que en la normativa especial por razón de la materia se prevea un plazo superior.', null, 'c3bd51663523872323ae4e4d70239fd78024bb536b47671c32f3b00355beb330', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'c3bd51663523872323ae4e4d70239fd78024bb536b47671c32f3b00355beb330')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Un año.', false), ('B', 'Cinco años.', true), ('C', 'Tres años.', false), ('D', 'Diez años.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
-- Lote age-aux-b2-07-explorador-ms_win_atajos-v1 (15 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Microsoft Soporte · Métodos abreviados de teclado de Windows', 'https://support.microsoft.com/es-es/accessibility/windows/keyboard-shortcuts-in-windows', 'web_oficial'::public.source_kind, 'Microsoft (documentación oficial)', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('age-aux-b2-07-explorador', 'II.7 El Explorador de archivos de Windows') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('auxiliar-administrativo-estado') and t.slug = 'age-aux-b2-07-explorador' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'En el Explorador de archivos, ¿qué combinación de teclas muestra las propiedades del elemento seleccionado?', 'Según la tabla de métodos abreviados del Explorador de archivos, Alt + Entrar permite ver las propiedades del elemento seleccionado.', 'age_aux_b2_07_explorador', (select id from public.topics where slug = 'age-aux-b2-07-explorador'), 1, 'es', true, (select id from public.sources where url = 'https://support.microsoft.com/es-es/accessibility/windows/keyboard-shortcuts-in-windows'), 'Explorador de archivos · Alt + Entrar', 'Alt+Entrar | Ver las propiedades del elemento seleccionado.', null, 'e91607106d1b679f462d99e490fb14d7f838e1bd96538b37622df1017b5d9697', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'e91607106d1b679f462d99e490fb14d7f838e1bd96538b37622df1017b5d9697')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Alt + P', false), ('B', 'Alt + Entrar', true), ('C', 'Ctrl + Entrar', false), ('D', 'Mayús + F10', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'En el Explorador de archivos, si se arrastra un archivo con el ratón manteniendo pulsada la tecla Ctrl, al soltarlo:', 'Ctrl + arrastrar crea una copia; Mayús + arrastrar mueve y Alt + arrastrar crea un acceso directo.', 'age_aux_b2_07_explorador', (select id from public.topics where slug = 'age-aux-b2-07-explorador'), 1, 'es', true, (select id from public.sources where url = 'https://support.microsoft.com/es-es/accessibility/windows/keyboard-shortcuts-in-windows'), 'Explorador de archivos · Arrastrar con Ctrl', 'Ctrl+mouse arrastrar un archivo | Cuando suelte el archivo, cree una copia en esa ubicación.', null, 'e6666dbbe55a848b7de9c6c05c87c9cddfcfa1bc4e8dcca286774017472691ad', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'e6666dbbe55a848b7de9c6c05c87c9cddfcfa1bc4e8dcca286774017472691ad')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Se mueve el archivo a esa ubicación.', false), ('B', 'Se crea un acceso directo al archivo original.', false), ('C', 'Se crea una copia del archivo en esa ubicación.', true), ('D', 'Se elimina el archivo de la ubicación de origen.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'En el Explorador de archivos, ¿qué tecla hay que mantener pulsada al arrastrar un archivo con el ratón para que, al soltarlo, se mueva a la nueva ubicación?', 'Según Microsoft, Mayús + arrastrar mueve el archivo a la ubicación donde se suelta.', 'age_aux_b2_07_explorador', (select id from public.topics where slug = 'age-aux-b2-07-explorador'), 2, 'es', true, (select id from public.sources where url = 'https://support.microsoft.com/es-es/accessibility/windows/keyboard-shortcuts-in-windows'), 'Explorador de archivos · Arrastrar con Mayús', 'Mayús+arrastrar un archivo con el mouse | Cuando suelte el archivo, muévalo a esa ubicación.', null, '59b58607034b9a5cdfb4dc8b4fea184b6ebe55e3fbc46e8a9476e3b180136344', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '59b58607034b9a5cdfb4dc8b4fea184b6ebe55e3fbc46e8a9476e3b180136344')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Mayús', true), ('B', 'Ctrl', false), ('C', 'Alt', false), ('D', 'Tecla Windows', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'En el Explorador de archivos, para volver a la carpeta anterior puede utilizarse la combinación:', 'Alt + Flecha izquierda (o Retroceso) va a la carpeta anterior; Alt + Flecha derecha muestra la siguiente y Alt + Flecha arriba sube un nivel.', 'age_aux_b2_07_explorador', (select id from public.topics where slug = 'age-aux-b2-07-explorador'), 1, 'es', true, (select id from public.sources where url = 'https://support.microsoft.com/es-es/accessibility/windows/keyboard-shortcuts-in-windows'), 'Explorador de archivos · Carpeta anterior', 'Alt+Flecha izquierda / Retroceso | Vaya a la carpeta anterior.', null, '32c8db10fe35a3efc519b11a6c7199fe2e91c557abde12c34117dce7539cc8da', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '32c8db10fe35a3efc519b11a6c7199fe2e91c557abde12c34117dce7539cc8da')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Alt + Flecha derecha', false), ('B', 'Alt + Flecha arriba', false), ('C', 'Ctrl + Flecha izquierda', false), ('D', 'Alt + Flecha izquierda', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'En el Explorador de archivos, la tecla F3 sirve para:', 'En el Explorador, F3 busca un archivo o carpeta; F2 cambia el nombre, F5 actualiza y F4 selecciona la barra de direcciones.', 'age_aux_b2_07_explorador', (select id from public.topics where slug = 'age-aux-b2-07-explorador'), 1, 'es', true, (select id from public.sources where url = 'https://support.microsoft.com/es-es/accessibility/windows/keyboard-shortcuts-in-windows'), 'Explorador de archivos · F3', 'F3 | Buscar un archivo o carpeta.', null, '7281dc61d442db1730763ea54374b2f028c7496dbc6018c7c4ecf03c448bad28', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '7281dc61d442db1730763ea54374b2f028c7496dbc6018c7c4ecf03c448bad28')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Buscar un archivo o carpeta.', true), ('B', 'Cambiar el nombre del elemento seleccionado.', false), ('C', 'Actualizar la ventana.', false), ('D', 'Seleccionar la barra de direcciones.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'En el Explorador de archivos, al pulsar Ctrl + D con un elemento seleccionado:', 'Ctrl + D (o Suprimir) envía el elemento a la papelera de reciclaje; Mayús + Supr lo elimina permanentemente.', 'age_aux_b2_07_explorador', (select id from public.topics where slug = 'age-aux-b2-07-explorador'), 1, 'es', true, (select id from public.sources where url = 'https://support.microsoft.com/es-es/accessibility/windows/keyboard-shortcuts-in-windows'), 'Explorador de archivos · Ctrl + D', 'Ctrl+D / Suprimir | Eliminar el elemento seleccionado y moverlo a la papelera de reciclaje.', null, 'f5cc48b61af49c73a7edc65d3568998e85071456b72d637b7dbcd586a682dc3f', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'f5cc48b61af49c73a7edc65d3568998e85071456b72d637b7dbcd586a682dc3f')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Se duplica el elemento en la misma carpeta.', false), ('B', 'Se elimina el elemento y se mueve a la papelera de reciclaje.', true), ('C', 'Se elimina permanentemente sin pasar por la papelera de reciclaje.', false), ('D', 'Se crea un acceso directo en el escritorio.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'En el Explorador de archivos de Windows 11, ¿qué ocurre al pulsar Ctrl + W?', 'Ctrl + W cierra la pestaña activa y, si es la única, la ventana; Ctrl + T abre una pestaña nueva y Ctrl + Tab pasa a la siguiente.', 'age_aux_b2_07_explorador', (select id from public.topics where slug = 'age-aux-b2-07-explorador'), 2, 'es', true, (select id from public.sources where url = 'https://support.microsoft.com/es-es/accessibility/windows/keyboard-shortcuts-in-windows'), 'Explorador de archivos · Ctrl + W', 'Ctrl+W | Cierra la pestaña activa. Cierra la ventana si solo hay una pestaña abierta.', null, 'd2d6e6824c2240f510a05320dc9b54b7bc1b88f6f97556a8e5716b3f02d71172', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'd2d6e6824c2240f510a05320dc9b54b7bc1b88f6f97556a8e5716b3f02d71172')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Se abre una pestaña nueva y se cambia a ella.', false), ('B', 'Se cierran todas las ventanas del Explorador abiertas.', false), ('C', 'Se desplaza a la pestaña siguiente.', false), ('D', 'Se cierra la pestaña activa, o la ventana si solo hay una pestaña abierta.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'En el Explorador de archivos, ¿qué combinación de teclas muestra u oculta el panel de detalles?', 'Alt + Mayús + P muestra u oculta el panel de detalles; Alt + P hace lo mismo con el panel de vista previa.', 'age_aux_b2_07_explorador', (select id from public.topics where slug = 'age-aux-b2-07-explorador'), 2, 'es', true, (select id from public.sources where url = 'https://support.microsoft.com/es-es/accessibility/windows/keyboard-shortcuts-in-windows'), 'Explorador de archivos · Panel de detalles', 'Alt+Mayús+P | Mostrar u ocultar el panel de detalles.', null, '47b01185cb359305e38553c801abe972abee135cbdfe4c356d94bebf1982ca81', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '47b01185cb359305e38553c801abe972abee135cbdfe4c356d94bebf1982ca81')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Alt + Mayús + P', true), ('B', 'Alt + P', false), ('C', 'Ctrl + Mayús + P', false), ('D', 'Ctrl + Alt + D', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'En el Explorador de archivos, ¿cuál de las siguientes combinaciones selecciona el cuadro de búsqueda?', 'Según Microsoft, Ctrl + E o Ctrl + B seleccionan el cuadro de búsqueda; Ctrl + I se centra en la barra de direcciones y Ctrl + D elimina el elemento.', 'age_aux_b2_07_explorador', (select id from public.topics where slug = 'age-aux-b2-07-explorador'), 2, 'es', true, (select id from public.sources where url = 'https://support.microsoft.com/es-es/accessibility/windows/keyboard-shortcuts-in-windows'), 'Explorador de archivos · Cuadro de búsqueda', 'Ctrl+E / Ctrl+B | Seleccionar el cuadro de búsqueda.', null, 'aec6a5f1f423821140fb931e97c061624b52a97122cdb3e3e58e56a3a1ed50dd', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'aec6a5f1f423821140fb931e97c061624b52a97122cdb3e3e58e56a3a1ed50dd')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Ctrl + D', false), ('B', 'Ctrl + I', false), ('C', 'Ctrl + B', true), ('D', 'Ctrl + U', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'En el Explorador de archivos, la combinación Mayús + F10 permite:', 'Mayús + F10 muestra el menú contextual del elemento seleccionado, como el clic con el botón derecho.', 'age_aux_b2_07_explorador', (select id from public.topics where slug = 'age-aux-b2-07-explorador'), 2, 'es', true, (select id from public.sources where url = 'https://support.microsoft.com/es-es/accessibility/windows/keyboard-shortcuts-in-windows'), 'Explorador de archivos · Mayús + F10', 'Mayús+F10 | Mostrar el menú contextual del elemento seleccionado.', null, '60e1c97897cb192b36142e29531e7dc2cc662cce3bdd68399a849742a1c516ee', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '60e1c97897cb192b36142e29531e7dc2cc662cce3bdd68399a849742a1c516ee')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Maximizar o minimizar la ventana activa.', false), ('B', 'Desplazarse por los elementos de la ventana.', false), ('C', 'Cambiar el nombre del elemento seleccionado.', false), ('D', 'Mostrar el menú contextual del elemento seleccionado.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'En el Explorador de archivos, mantener pulsada la tecla Ctrl mientras se gira la rueda del ratón permite:', 'Ctrl + rueda del ratón cambia el tamaño y la apariencia de los iconos.', 'age_aux_b2_07_explorador', (select id from public.topics where slug = 'age-aux-b2-07-explorador'), 2, 'es', true, (select id from public.sources where url = 'https://support.microsoft.com/es-es/accessibility/windows/keyboard-shortcuts-in-windows'), 'Explorador de archivos · Ctrl + rueda del ratón', 'Ctrl + rueda del ratón | Cambiar el tamaño y la apariencia de los iconos de archivos y carpetas.', null, 'b1f0f3f1a68dd9df4f01c24771cde5904338ffa8e206759e87b3e967117bbdb7', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'b1f0f3f1a68dd9df4f01c24771cde5904338ffa8e206759e87b3e967117bbdb7')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Desplazarse entre las pestañas abiertas.', false), ('B', 'Cambiar el tamaño y la apariencia de los iconos de archivos y carpetas.', true), ('C', 'Seleccionar varios elementos consecutivos.', false), ('D', 'Desplazarse hasta la parte inferior de la ventana.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'En el Explorador de archivos, la combinación Ctrl + Mayús + Número cambia el estilo de vista. Según Microsoft, ¿qué vista se obtiene con Ctrl + Mayús + 6?', 'Microsoft pone como ejemplo que el 2 corresponde a iconos grandes y el 6 a detalles.', 'age_aux_b2_07_explorador', (select id from public.topics where slug = 'age-aux-b2-07-explorador'), 3, 'es', true, (select id from public.sources where url = 'https://support.microsoft.com/es-es/accessibility/windows/keyboard-shortcuts-in-windows'), 'Explorador de archivos · Estilo de vista', 'Ctrl+Mayús+Número (1-9) | Cambiar el estilo de vista. Por ejemplo, 2 son iconos grandes y 6 son detalles.', null, '0ba80c42e394e978ed268abe22bc9d3c12c9ff437e5570daa4681ae9a097642f', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '0ba80c42e394e978ed268abe22bc9d3c12c9ff437e5570daa4681ae9a097642f')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Iconos grandes.', false), ('B', 'Lista.', false), ('C', 'Detalles.', true), ('D', 'Mosaicos.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'En el Explorador de archivos, ¿qué combinación de teclas expande todas las carpetas del árbol en el panel de navegación?', 'Ctrl + Mayús + E expande todas las carpetas del árbol del panel de navegación; Ctrl + Mayús + N crea una carpeta nueva.', 'age_aux_b2_07_explorador', (select id from public.topics where slug = 'age-aux-b2-07-explorador'), 3, 'es', true, (select id from public.sources where url = 'https://support.microsoft.com/es-es/accessibility/windows/keyboard-shortcuts-in-windows'), 'Explorador de archivos · Expandir árbol', 'Ctrl+Mayús+E | Expande todas las carpetas del árbol en el panel de navegación.', null, '111bf8797a61330a63e2226babd258fab10c7db441cc28a8a2b9d41d68881fdd', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '111bf8797a61330a63e2226babd258fab10c7db441cc28a8a2b9d41d68881fdd')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Ctrl + Mayús + N', false), ('B', 'Ctrl + Mayús + E', true), ('C', 'Alt + Flecha derecha', false), ('D', 'Ctrl + Signo más (+)', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'En el Explorador de archivos, la combinación Ctrl + Signo más (+) sirve para:', 'Según Microsoft, Ctrl + Signo más ajusta el ancho de todas las columnas al texto.', 'age_aux_b2_07_explorador', (select id from public.topics where slug = 'age-aux-b2-07-explorador'), 3, 'es', true, (select id from public.sources where url = 'https://support.microsoft.com/es-es/accessibility/windows/keyboard-shortcuts-in-windows'), 'Explorador de archivos · Ajustar columnas', 'Ctrl+Signo más (+) | Cambiar el tamaño de todas las columnas para ajustarse al texto.', null, '602b825457be30d5d6f84f081eb207f3e65f144fa99f02f62b0373802c98d44b', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '602b825457be30d5d6f84f081eb207f3e65f144fa99f02f62b0373802c98d44b')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Ampliar el tamaño de los iconos.', false), ('B', 'Abrir una nueva ventana del Explorador.', false), ('C', 'Cambiar el tamaño de todas las columnas para ajustarse al texto.', true), ('D', 'Añadir una columna nueva a la vista Detalles.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'En el Explorador de archivos de Windows 11, ¿qué se obtiene al hacer clic con el botón derecho del ratón sobre un elemento mientras se mantiene pulsada la tecla Mayús?', 'Mayús + clic con el botón derecho muestra directamente el menú contextual ampliado (Mostrar más opciones).', 'age_aux_b2_07_explorador', (select id from public.topics where slug = 'age-aux-b2-07-explorador'), 3, 'es', true, (select id from public.sources where url = 'https://support.microsoft.com/es-es/accessibility/windows/keyboard-shortcuts-in-windows'), 'Explorador de archivos · Mayús + clic derecho', 'Mayús+clic con el botón derecho del mouse | Mostrar el menú contextual Mostrar más opciones para el elemento seleccionado.', null, '748b58cf1de434ae6fee703f1e8e58c7fe60b1ef91e6248418cc550a9edbe412', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '748b58cf1de434ae6fee703f1e8e58c7fe60b1ef91e6248418cc550a9edbe412')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El menú contextual Mostrar más opciones del elemento seleccionado.', true), ('B', 'Las propiedades del elemento seleccionado.', false), ('C', 'Un acceso directo al elemento en el escritorio.', false), ('D', 'La selección de todos los elementos de la carpeta.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
-- Lote age-aux-b2-07-explorador-ms_win_explorador-v1 (3 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Microsoft Soporte · Explorador de archivos en Windows', 'https://support.microsoft.com/es-es/windows/experience/fileexplorer/file-explorer-in-windows', 'web_oficial'::public.source_kind, 'Microsoft (documentación oficial)', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('age-aux-b2-07-explorador', 'II.7 El Explorador de archivos de Windows') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('auxiliar-administrativo-estado') and t.slug = 'age-aux-b2-07-explorador' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'En el menú Ver del Explorador de archivos, la opción «Extensiones de nombre de archivo» sirve para:', 'Según Microsoft, la opción Extensiones de nombre de archivo permite ver las extensiones; la de Elementos ocultos muestra los archivos y carpetas ocultos.', 'age_aux_b2_07_explorador', (select id from public.topics where slug = 'age-aux-b2-07-explorador'), 1, 'es', true, (select id from public.sources where url = 'https://support.microsoft.com/es-es/windows/experience/fileexplorer/file-explorer-in-windows'), 'Explorador de archivos · Extensiones de nombre de archivo', 'Extensiones de nombre de archivo para ver las extensiones de nombre de archivo', null, 'a37d5557ddaaa739e7c3ff72c97adb59915d6c5624324ae5da6145d4ce03c9cb', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'a37d5557ddaaa739e7c3ff72c97adb59915d6c5624324ae5da6145d4ce03c9cb')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Cambiar la extensión de todos los archivos de la carpeta.', false), ('B', 'Asociar cada tipo de archivo con una aplicación predeterminada.', false), ('C', 'Ver las extensiones de nombre de archivo.', true), ('D', 'Ver los archivos y carpetas ocultos.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según Microsoft, para reducir el espacio entre archivos en el Explorador de archivos hay que seleccionar:', 'La página de Microsoft indica que la opción Vista compacta del menú Ver reduce el espacio entre archivos.', 'age_aux_b2_07_explorador', (select id from public.topics where slug = 'age-aux-b2-07-explorador'), 2, 'es', true, (select id from public.sources where url = 'https://support.microsoft.com/es-es/windows/experience/fileexplorer/file-explorer-in-windows'), 'Explorador de archivos · Vista compacta', 'Para reducir el espacio entre archivos, seleccione Vista>compacta.', null, '74b6ee2484bdb132839ca62ae4c2e99e61e0a3a9521a930c8f5d8a45bf97aeef', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '74b6ee2484bdb132839ca62ae4c2e99e61e0a3a9521a930c8f5d8a45bf97aeef')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Ver > Iconos pequeños.', false), ('B', 'Ver > Vista compacta.', true), ('C', 'Ordenar > Por tamaño.', false), ('D', 'Ver > Panel de navegación.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según Microsoft, para buscar archivos relevantes tanto en el PC como en la nube desde el Explorador de archivos, conviene buscar desde:', 'Microsoft recomienda buscar desde Inicio del Explorador para obtener resultados del PC y de la nube; para una búsqueda exhaustiva pero lenta, en Este equipo.', 'age_aux_b2_07_explorador', (select id from public.topics where slug = 'age-aux-b2-07-explorador'), 2, 'es', true, (select id from public.sources where url = 'https://support.microsoft.com/es-es/windows/experience/fileexplorer/file-explorer-in-windows'), 'Buscar archivos · Inicio del Explorador', 'Para buscar archivos relevantes desde el PC y la nube, busque desde Inicio del Explorador de archivos.', null, 'a283bba3eda356458bb00949d821d3d5ff00624149bc025059f912b4c77d2a1b', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'a283bba3eda356458bb00949d821d3d5ff00624149bc025059f912b4c77d2a1b')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Inicio del Explorador de archivos.', true), ('B', 'La barra de direcciones, escribiendo la ruta completa.', false), ('C', 'El panel de vista previa.', false), ('D', 'La Papelera de reciclaje.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
-- Lote age-aux-b2-07-explorador-ms_win_zip-v1 (2 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Microsoft Soporte · Comprimir y descomprimir archivos', 'https://support.microsoft.com/es-es/windows/experience/storage-filemanagement/zip-and-unzip-files', 'web_oficial'::public.source_kind, 'Microsoft (documentación oficial)', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('age-aux-b2-07-explorador', 'II.7 El Explorador de archivos de Windows') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('auxiliar-administrativo-estado') and t.slug = 'age-aux-b2-07-explorador' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según Microsoft, al comprimir un archivo con la opción «Enviar a > Carpeta comprimida (en zip)»:', 'La página de Microsoft indica que se crea una nueva carpeta comprimida con el mismo nombre y en la misma ubicación.', 'age_aux_b2_07_explorador', (select id from public.topics where slug = 'age-aux-b2-07-explorador'), 2, 'es', true, (select id from public.sources where url = 'https://support.microsoft.com/es-es/windows/experience/storage-filemanagement/zip-and-unzip-files'), 'Comprimir y descomprimir archivos · Carpeta creada', 'Se crea una nueva carpeta comprimida con el mismo nombre en la misma ubicación.', null, '8a916df9a28a10add488f5aac00570e9e225df0d7417cda726ac01db89fe6638', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '8a916df9a28a10add488f5aac00570e9e225df0d7417cda726ac01db89fe6638')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Se sustituye el archivo original por su versión comprimida.', false), ('B', 'Se crea la carpeta comprimida en el escritorio.', false), ('C', 'Se guarda la carpeta comprimida en la carpeta Descargas.', false), ('D', 'Se crea una nueva carpeta comprimida con el mismo nombre en la misma ubicación.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según Microsoft, Windows 11 versión 24H2 admite los formatos ZIP, RAR, 7z y TAR, pero:', 'La página de Microsoft advierte que no se admiten operaciones en archivos de archivo cifrados.', 'age_aux_b2_07_explorador', (select id from public.topics where slug = 'age-aux-b2-07-explorador'), 3, 'es', true, (select id from public.sources where url = 'https://support.microsoft.com/es-es/windows/experience/storage-filemanagement/zip-and-unzip-files'), 'Comprimir y descomprimir archivos · Formatos', 'Windows 11, versión 24H2 admite ZIP, RAR. Formatos de archivo 7z y TAR. […] Sin embargo, no admite operaciones en archivos de archivo cifrados.', null, '0873884739b71a34918c7046ba7f84accdf3c32e726034ae3c2908502bdb7dee', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '0873884739b71a34918c7046ba7f84accdf3c32e726034ae3c2908502bdb7dee')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Solo permite extraerlos, no crearlos.', false), ('B', 'Solo admite archivos de un tamaño máximo de 4 GB.', false), ('C', 'Requiere instalar una aplicación adicional para los archivos RAR.', false), ('D', 'No admite operaciones en archivos de archivo cifrados.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
-- Lote age-aux-b2-08-word-ms_word_accesible-v1 (1 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Microsoft Soporte · Hacer que los documentos de Word sean accesibles para personas con discapacidad', 'https://support.microsoft.com/es-es/accessibility/word/make-your-word-documents-accessible-to-people-with-disabilities', 'web_oficial'::public.source_kind, 'Microsoft (documentación oficial)', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('age-aux-b2-08-word', 'II.8 Procesadores de texto: Word 365') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('auxiliar-administrativo-estado') and t.slug = 'age-aux-b2-08-word' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según Microsoft, en un documento de Word accesible el texto alternativo sirve para:', 'El texto alternativo describe el contenido visual (imágenes, gráficos) para quien no puede ver la pantalla.', 'age_aux_b2_08_word', (select id from public.topics where slug = 'age-aux-b2-08-word'), 1, 'es', true, (select id from public.sources where url = 'https://support.microsoft.com/es-es/accessibility/word/make-your-word-documents-accessible-to-people-with-disabilities'), 'Documentos accesibles (texto alternativo)', 'El texto alternativo ayuda a las personas que no pueden ver la pantalla a comprender lo que es importante en el contenido visual.', null, '2e7c979488981fdc8d81a531883bdf8ec2543a22eec4c8ef585acf67965e0d0f', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '2e7c979488981fdc8d81a531883bdf8ec2543a22eec4c8ef585acf67965e0d0f')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Sustituir automáticamente el texto que contiene errores ortográficos.', false), ('B', 'Ofrecer una traducción del documento a otro idioma.', false), ('C', 'Mostrar un texto distinto cuando el documento se imprime.', false), ('D', 'Ayudar a las personas que no pueden ver la pantalla a comprender lo que es importante en el contenido visual.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
-- Lote age-aux-b2-08-word-ms_word_atajos-v1 (13 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Microsoft Soporte · Métodos abreviados de teclado de Word', 'https://support.microsoft.com/es-es/accessibility/word/keyboard-shortcuts-in-word', 'web_oficial'::public.source_kind, 'Microsoft (documentación oficial)', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('age-aux-b2-08-word', 'II.8 Procesadores de texto: Word 365') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('auxiliar-administrativo-estado') and t.slug = 'age-aux-b2-08-word' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'En Word para Windows, ¿qué combinación de teclas centra el texto?', 'Según la tabla de métodos abreviados de Word, Ctrl+E centra el texto y Ctrl+J justifica el párrafo.', 'age_aux_b2_08_word', (select id from public.topics where slug = 'age-aux-b2-08-word'), 1, 'es', true, (select id from public.sources where url = 'https://support.microsoft.com/es-es/accessibility/word/keyboard-shortcuts-in-word'), 'Métodos abreviados de Word (centrar)', 'Centrar el texto. | Ctrl+E', null, 'f35ea39b5bd546963f791149d8fda75ea7a1b3179b4dc3af11651b341b27e471', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'f35ea39b5bd546963f791149d8fda75ea7a1b3179b4dc3af11651b341b27e471')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Ctrl+J', false), ('B', 'Ctrl+T', false), ('C', 'Ctrl+E', true), ('D', 'Ctrl+C', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'En Word, la combinación Ctrl+H muestra:', 'Ctrl+H abre Reemplazar para buscar y reemplazar texto, formato o elementos especiales.', 'age_aux_b2_08_word', (select id from public.topics where slug = 'age-aux-b2-08-word'), 1, 'es', true, (select id from public.sources where url = 'https://support.microsoft.com/es-es/accessibility/word/keyboard-shortcuts-in-word'), 'Métodos abreviados de Word (Reemplazar)', 'Muestra el cuadro de diálogo Reemplazar para buscar y reemplazar texto, formato específico o elementos especiales. | Ctrl+H', null, '1a7ebd3d19c513185d0b83166d34a58666f15d57293de957c5df58d88cf463fa', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '1a7ebd3d19c513185d0b83166d34a58666f15d57293de957c5df58d88cf463fa')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El panel de tareas de Navegación.', false), ('B', 'El cuadro de diálogo Reemplazar.', true), ('C', 'El cuadro de diálogo Ir a.', false), ('D', 'El cuadro de diálogo Guardar como.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'En Word, ¿qué muestra la tecla F7 pulsada sola?', 'F7 abre el panel del Editor; Mayús+F7, el diccionario de sinónimos; Alt+Mayús+F7, el Traductor; F1, la Ayuda.', 'age_aux_b2_08_word', (select id from public.topics where slug = 'age-aux-b2-08-word'), 1, 'es', true, (select id from public.sources where url = 'https://support.microsoft.com/es-es/accessibility/word/keyboard-shortcuts-in-word'), 'Teclas de función de Word (F7)', 'Solo F7: muestra el panel de tareas del Editor', null, 'c88c787db9fcd8c7bf0fd5357036a46930a78f28b9e9ef24bda511af24294e48', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'c88c787db9fcd8c7bf0fd5357036a46930a78f28b9e9ef24bda511af24294e48')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El panel de tareas del diccionario de sinónimos.', false), ('B', 'El panel de tareas Traductor.', false), ('C', 'El panel de tareas Ayuda de Word.', false), ('D', 'El panel de tareas del Editor.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select '¿Qué combinación de teclas inserta un comentario en un documento de Word?', 'Ctrl+Alt+M inserta un comentario; Ctrl+Alt+K inserta un hipervínculo y Ctrl+Alt+F, una nota al pie.', 'age_aux_b2_08_word', (select id from public.topics where slug = 'age-aux-b2-08-word'), 1, 'es', true, (select id from public.sources where url = 'https://support.microsoft.com/es-es/accessibility/word/keyboard-shortcuts-in-word'), 'Métodos abreviados de Word (comentario)', 'Insertar un comentario. | Ctrl+Alt+M', null, 'dc45722c0c64de7d49a5b6f5a11f637188e0b91527b68730d7c88fc392fd0427', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'dc45722c0c64de7d49a5b6f5a11f637188e0b91527b68730d7c88fc392fd0427')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Ctrl+Alt+M', true), ('B', 'Ctrl+Alt+K', false), ('C', 'Ctrl+Alt+F', false), ('D', 'Ctrl+Mayús+C', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'En Word, ¿qué combinación de teclas inserta un salto de columna?', 'Ctrl+Mayús+Entrar inserta un salto de columna; Ctrl+Entrar, un salto de página, y Mayús+Entrar, un salto de línea.', 'age_aux_b2_08_word', (select id from public.topics where slug = 'age-aux-b2-08-word'), 2, 'es', true, (select id from public.sources where url = 'https://support.microsoft.com/es-es/accessibility/word/keyboard-shortcuts-in-word'), 'Métodos abreviados de Word (salto de columna)', 'Insertar un salto de columna. | Ctrl+Mayús+Entrar', null, 'c5486ccab8f170927b9933819502d940bfc5e5cdba5afc99f715de13c794372c', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'c5486ccab8f170927b9933819502d940bfc5e5cdba5afc99f715de13c794372c')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Ctrl+Entrar', false), ('B', 'Ctrl+Mayús+Entrar', true), ('C', 'Mayús+Entrar', false), ('D', 'Alt+Entrar', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'En Word para Windows, la combinación Ctrl+B:', 'Según la página de Microsoft en español, Ctrl+B muestra el panel de Navegación para buscar en el documento.', 'age_aux_b2_08_word', (select id from public.topics where slug = 'age-aux-b2-08-word'), 2, 'es', true, (select id from public.sources where url = 'https://support.microsoft.com/es-es/accessibility/word/keyboard-shortcuts-in-word'), 'Métodos abreviados de Word (Navegación)', 'Mostrar el panel de tareas de Navegación para buscar en el contenido del documento. | Ctrl+B', null, '0783b66a27456cd10a67676541fee2fafc0306c4036c785d06cbbb64a070fc35', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '0783b66a27456cd10a67676541fee2fafc0306c4036c785d06cbbb64a070fc35')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Aplica el formato negrita al texto seleccionado.', false), ('B', 'Muestra el cuadro de diálogo Marcador.', false), ('C', 'Muestra el panel de tareas de Navegación para buscar en el contenido del documento.', true), ('D', 'Inserta un salto de página.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'En Word, ¿qué tecla de función, pulsada sola, muestra el cuadro de diálogo Ir a?', 'F5 muestra Ir a; F4 repite la última acción, F9 actualiza los campos seleccionados y F12 abre Guardar como.', 'age_aux_b2_08_word', (select id from public.topics where slug = 'age-aux-b2-08-word'), 2, 'es', true, (select id from public.sources where url = 'https://support.microsoft.com/es-es/accessibility/word/keyboard-shortcuts-in-word'), 'Teclas de función de Word (F5)', 'Solo F5: muestra el cuadro de diálogo Ir a.', null, 'd3b58d6ecbcf0e705597ca21233fa6dfde9f346f929ccc2d731d7750c6d1e02d', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'd3b58d6ecbcf0e705597ca21233fa6dfde9f346f929ccc2d731d7750c6d1e02d')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'F4', false), ('B', 'F9', false), ('C', 'F5', true), ('D', 'F12', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'En Word, la combinación Ctrl+Alt+F sirve para:', 'Ctrl+Alt+F inserta una nota al pie; Ctrl+Alt+D, una nota al final, y Alt+Mayús+F, un campo de FECHA.', 'age_aux_b2_08_word', (select id from public.topics where slug = 'age-aux-b2-08-word'), 2, 'es', true, (select id from public.sources where url = 'https://support.microsoft.com/es-es/accessibility/word/keyboard-shortcuts-in-word'), 'Métodos abreviados de Word (nota al pie)', 'Insertar una nota al pie. | Ctrl+Alt+F', null, '1587de187d7be423fe44aff74bd7f17a03d5c62e58cb1bf2981c30f43d911d08', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '1587de187d7be423fe44aff74bd7f17a03d5c62e58cb1bf2981c30f43d911d08')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Insertar una nota al final.', false), ('B', 'Insertar una nota al pie.', true), ('C', 'Insertar un campo de FECHA.', false), ('D', 'Abrir el cuadro de diálogo Fuente.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select '¿Qué combinación de teclas muestra todos los caracteres no imprimibles en un documento de Word?', 'Ctrl+Mayús+8 muestra los caracteres no imprimibles; Ctrl+Mayús+N aplica el estilo Normal y Ctrl+Q quita el formato de párrafo.', 'age_aux_b2_08_word', (select id from public.topics where slug = 'age-aux-b2-08-word'), 2, 'es', true, (select id from public.sources where url = 'https://support.microsoft.com/es-es/accessibility/word/keyboard-shortcuts-in-word'), 'Métodos abreviados de Word (caracteres no imprimibles)', 'Mostrar todos los caracteres no imprimibles. | Ctrl+Mayús+8', null, 'f5ea9cf60b7d0d76c0358c893eb0e192e1113a5ac314175b3ceeb12580e77094', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'f5ea9cf60b7d0d76c0358c893eb0e192e1113a5ac314175b3ceeb12580e77094')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Ctrl+Mayús+N', false), ('B', 'Ctrl+Alt+P', false), ('C', 'Ctrl+Q', false), ('D', 'Ctrl+Mayús+8', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'En Word, la combinación Ctrl+F12 muestra:', 'Ctrl+F12 abre el cuadro Abrir; F12 sola, Guardar como; Ctrl+Mayús+F12, la pestaña Imprimir.', 'age_aux_b2_08_word', (select id from public.topics where slug = 'age-aux-b2-08-word'), 2, 'es', true, (select id from public.sources where url = 'https://support.microsoft.com/es-es/accessibility/word/keyboard-shortcuts-in-word'), 'Teclas de función de Word (Ctrl+F12)', 'Ctrl+F12: muestra el cuadro de diálogo Abrir.', null, '9b486cfacaf7031035d9556d95353b126e19e25cc5a5de224d55a104415b4c6f', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '9b486cfacaf7031035d9556d95353b126e19e25cc5a5de224d55a104415b4c6f')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El cuadro de diálogo Guardar como.', false), ('B', 'El cuadro de diálogo Abrir.', true), ('C', 'La pestaña Imprimir en la vista Backstage.', false), ('D', 'El cuadro de diálogo Marcador.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'En Word, ¿qué combinación de teclas cambia a la vista Esquema?', 'Ctrl+Alt+O cambia a Esquema; Ctrl+Alt+N, a Borrador; Ctrl+Alt+P, a Diseño de impresión, y Ctrl+Alt+I, a vista previa de impresión.', 'age_aux_b2_08_word', (select id from public.topics where slug = 'age-aux-b2-08-word'), 3, 'es', true, (select id from public.sources where url = 'https://support.microsoft.com/es-es/accessibility/word/keyboard-shortcuts-in-word'), 'Métodos abreviados de Word (vista Esquema)', 'Cambiar a la vista Esquema. | Ctrl+Alt+O', null, '58112d7651f809af7bcb1f759dafa4bf7142c9510170bfae1b6099c01040b3c4', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '58112d7651f809af7bcb1f759dafa4bf7142c9510170bfae1b6099c01040b3c4')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Ctrl+Alt+O', true), ('B', 'Ctrl+Alt+N', false), ('C', 'Ctrl+Alt+P', false), ('D', 'Ctrl+Alt+I', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'En Word, la combinación Alt+Mayús+F permite:', 'Alt+Mayús+F inserta un campo de FECHA; Ctrl+Alt+F inserta una nota al pie y Alt+Mayús+F7 muestra el Traductor.', 'age_aux_b2_08_word', (select id from public.topics where slug = 'age-aux-b2-08-word'), 3, 'es', true, (select id from public.sources where url = 'https://support.microsoft.com/es-es/accessibility/word/keyboard-shortcuts-in-word'), 'Métodos abreviados de Word (campo FECHA)', 'Insertar un campo de FECHA. | Alt+Mayús+F', null, '0befb7761e51b4d0d2eb7931ec6f6b880bf44a44a95375d44e987a0ea6d8417d', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '0befb7761e51b4d0d2eb7931ec6f6b880bf44a44a95375d44e987a0ea6d8417d')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Insertar una nota al pie.', false), ('B', 'Abrir el cuadro de diálogo Fuente.', false), ('C', 'Insertar un campo de FECHA.', true), ('D', 'Mostrar el panel de tareas Traductor.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'En Word, ¿qué cuadro de diálogo muestra la combinación Ctrl+Mayús+F5?', 'Ctrl+Mayús+F5 muestra el cuadro Marcador; F5 sola muestra Ir a.', 'age_aux_b2_08_word', (select id from public.topics where slug = 'age-aux-b2-08-word'), 3, 'es', true, (select id from public.sources where url = 'https://support.microsoft.com/es-es/accessibility/word/keyboard-shortcuts-in-word'), 'Teclas de función de Word (Ctrl+Mayús+F5)', 'Ctrl+Mayús+F5: muestra el cuadro de diálogo Marcador.', null, '34fc120facae0faeb91db8a0b428bc3313918b4a1506e71524d3c231bd46193b', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '34fc120facae0faeb91db8a0b428bc3313918b4a1506e71524d3c231bd46193b')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Ir a.', false), ('B', 'Marcador.', true), ('C', 'Reemplazar.', false), ('D', 'Abrir.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
-- Lote age-aux-b2-08-word-ms_word_cambios-v1 (2 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Microsoft Soporte · Realizar un seguimiento de los cambios en Word', 'https://support.microsoft.com/es-es/word/training/track-changes-in-word', 'web_oficial'::public.source_kind, 'Microsoft (documentación oficial)', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('age-aux-b2-08-word', 'II.8 Procesadores de texto: Word 365') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('auxiliar-administrativo-estado') and t.slug = 'age-aux-b2-08-word' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'En el Control de cambios de Word, la presentación «Revisión simple»:', 'Revisión simple señala los cambios con una línea roja en el margen; Sin marcado oculta el marcado sin quitar los cambios.', 'age_aux_b2_08_word', (select id from public.topics where slug = 'age-aux-b2-08-word'), 2, 'es', true, (select id from public.sources where url = 'https://support.microsoft.com/es-es/word/training/track-changes-in-word'), 'Control de cambios (Revisión simple)', 'Revisión simple muestra las marcas de revisión con una línea roja en el margen.', null, '62d9e9203a0de4a7775c7bbdb5e0f3db5e67708a4d37b2061f1efa59e5c615d4', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '62d9e9203a0de4a7775c7bbdb5e0f3db5e67708a4d37b2061f1efa59e5c615d4')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Muestra las marcas de revisión con una línea roja en el margen.', true), ('B', 'Oculta el marcado y muestra el documento con los cambios incorporados.', false), ('C', 'Muestra el documento original sin ninguno de los cambios.', false), ('D', 'Elimina definitivamente los cambios del documento.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el soporte de Microsoft sobre el seguimiento de cambios en Word para Microsoft 365, los comentarios:', 'Microsoft indica que los comentarios ya no forman parte del Control de cambios; las revisiones se gestionan con Aceptar y Rechazar.', 'age_aux_b2_08_word', (select id from public.topics where slug = 'age-aux-b2-08-word'), 3, 'es', true, (select id from public.sources where url = 'https://support.microsoft.com/es-es/word/training/track-changes-in-word'), 'Control de cambios (comentarios)', 'Los comentarios ya no forman parte de la función Control de cambios.', null, '75af0e5d81085f083695fca9746c1b78ac3fd049b9f6315b57b329fdc7ac6b2f', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '75af0e5d81085f083695fca9746c1b78ac3fd049b9f6315b57b329fdc7ac6b2f')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Ya no forman parte de la función Control de cambios.', true), ('B', 'Se aceptan o rechazan junto con el resto de revisiones del grupo Cambios.', false), ('C', 'Solo pueden insertarse si el Control de cambios está activado.', false), ('D', 'Se marcan con un tachado de color distinto para cada autor.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
-- Lote age-aux-b2-08-word-ms_word_cinta-v1 (2 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Microsoft Soporte · Personalizar la cinta de opciones en Word', 'https://support.microsoft.com/es-es/office/personalizar-la-cinta-de-opciones-en-word-c4b6051a-7a70-43c8-a527-932917dec682', 'web_oficial'::public.source_kind, 'Microsoft (documentación oficial)', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('age-aux-b2-08-word', 'II.8 Procesadores de texto: Word 365') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('auxiliar-administrativo-estado') and t.slug = 'age-aux-b2-08-word' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según Microsoft, las personalizaciones que se hacen en la cinta de opciones de Word:', 'La página de Microsoft aclara que las personalizaciones solo afectan al programa de Office en que se realizan.', 'age_aux_b2_08_word', (select id from public.topics where slug = 'age-aux-b2-08-word'), 2, 'es', true, (select id from public.sources where url = 'https://support.microsoft.com/es-es/office/personalizar-la-cinta-de-opciones-en-word-c4b6051a-7a70-43c8-a527-932917dec682'), 'Personalizar la cinta de opciones (ámbito)', 'las personalizaciones solo se aplican al programa de Office en el que está trabajando en ese momento', null, 'bd42a5763f3eefc82a00fd9de4360b581c0f06c14327ec339ec39013afdf59c8', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'bd42a5763f3eefc82a00fd9de4360b581c0f06c14327ec339ec39013afdf59c8')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Se aplican a todos los programas de Office instalados en el equipo.', false), ('B', 'Solo se aplican al documento abierto en ese momento.', false), ('C', 'Se aplican a todos los usuarios del equipo.', false), ('D', 'Solo se aplican al programa de Office en el que se está trabajando en ese momento.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Al personalizar la cinta de opciones de Word, ¿qué elementos pueden restablecerse a su configuración predeterminada?', 'Según Microsoft, solo se pueden restablecer las pestañas predeterminadas a su configuración predeterminada.', 'age_aux_b2_08_word', (select id from public.topics where slug = 'age-aux-b2-08-word'), 3, 'es', true, (select id from public.sources where url = 'https://support.microsoft.com/es-es/office/personalizar-la-cinta-de-opciones-en-word-c4b6051a-7a70-43c8-a527-932917dec682'), 'Personalizar la cinta de opciones (restablecer)', 'Solo se pueden restablecer las pestañas predeterminadas a su configuración predeterminada.', null, '991d1c0878f7b06e8bfb2f8ac0d9ae8c1d411e0086a5e77ae69eeb554631d071', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '991d1c0878f7b06e8bfb2f8ac0d9ae8c1d411e0086a5e77ae69eeb554631d071')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Cualquier pestaña, sea predeterminada o personalizada.', false), ('B', 'Solo los grupos personalizados.', false), ('C', 'Solo las pestañas personalizadas que se hayan exportado.', false), ('D', 'Solo las pestañas predeterminadas.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
-- Lote age-aux-b2-08-word-ms_word_indice-v1 (1 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Microsoft Soporte · Crear y actualizar un índice', 'https://support.microsoft.com/es-es/word/create-and-update-an-index', 'web_oficial'::public.source_kind, 'Microsoft (documentación oficial)', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('age-aux-b2-08-word', 'II.8 Procesadores de texto: Word 365') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('auxiliar-administrativo-estado') and t.slug = 'age-aux-b2-08-word' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el soporte de Microsoft, un índice de Word:', 'Microsoft define el índice como la relación de términos y temas con sus páginas; la tabla de contenido, en cambio, se basa en los títulos.', 'age_aux_b2_08_word', (select id from public.topics where slug = 'age-aux-b2-08-word'), 1, 'es', true, (select id from public.sources where url = 'https://support.microsoft.com/es-es/word/create-and-update-an-index'), 'Crear y actualizar un índice', 'Un índice enumera los términos y temas que se tratan en un documento, junto con las páginas en las que aparecen.', null, '79e5301498cf28c35415a3c68c3a2a8a4c65e333ed4113036a68685b268a8bc5', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '79e5301498cf28c35415a3c68c3a2a8a4c65e333ed4113036a68685b268a8bc5')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Enumera los términos y temas que se tratan en un documento, junto con las páginas en las que aparecen.', true), ('B', 'Se basa en los títulos del documento y muestra su estructura.', false), ('C', 'Recoge las notas al final del documento ordenadas por capítulos.', false), ('D', 'Muestra la lista de comentarios de los revisores.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
-- Lote age-aux-b2-08-word-ms_word_rand-v1 (1 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Microsoft Soporte · Cómo insertar texto de ejemplo en Word', 'https://support.microsoft.com/es-es/office/c%C3%B3mo-insertar-texto-de-ejemplo-en-microsoft-office-word-0d648b7c-e2ac-41c4-aca0-bbe4dd676f87', 'web_oficial'::public.source_kind, 'Microsoft (documentación oficial)', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('age-aux-b2-08-word', 'II.8 Procesadores de texto: Word 365') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('auxiliar-administrativo-estado') and t.slug = 'age-aux-b2-08-word' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Si en Word se escribe la función =rand() sin parámetros para insertar texto de ejemplo, el número predeterminado de párrafos que aparece es:', 'Según Microsoft, si se omiten los parámetros p y l, el número predeterminado de párrafos es tres.', 'age_aux_b2_08_word', (select id from public.topics where slug = 'age-aux-b2-08-word'), 2, 'es', true, (select id from public.sources where url = 'https://support.microsoft.com/es-es/office/c%C3%B3mo-insertar-texto-de-ejemplo-en-microsoft-office-word-0d648b7c-e2ac-41c4-aca0-bbe4dd676f87'), 'Texto de ejemplo (=rand())', 'Si omite los parámetros, el número predeterminado de párrafos es tres', null, '3d69b44fe7be179185c57636b4124b5092a62d9a5afb171f346fbcd1a41e352b', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '3d69b44fe7be179185c57636b4124b5092a62d9a5afb171f346fbcd1a41e352b')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Uno.', false), ('B', 'Dos.', false), ('C', 'Tres.', true), ('D', 'Cinco.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
-- Lote age-aux-b2-09-excel-ms_excel_almohadillas-v1 (1 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Microsoft Soporte · Cómo corregir un error #####', 'https://support.microsoft.com/es-es/office/c%C3%B3mo-corregir-un-error-bf801d0a-2a6e-44bd-a70e-0f780ae8f11e', 'web_oficial'::public.source_kind, 'Microsoft (documentación oficial)', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('age-aux-b2-09-excel', 'II.9 Hojas de cálculo: Excel 365') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('auxiliar-administrativo-estado') and t.slug = 'age-aux-b2-09-excel' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según Microsoft, Excel puede mostrar ##### en una celda cuando:', '##### aparece cuando la columna es demasiado estrecha; también con fórmulas que devuelven fechas u horas negativas.', 'age_aux_b2_09_excel', (select id from public.topics where slug = 'age-aux-b2-09-excel'), 1, 'es', true, (select id from public.sources where url = 'https://support.microsoft.com/es-es/office/c%C3%B3mo-corregir-un-error-bf801d0a-2a6e-44bd-a70e-0f780ae8f11e'), 'Error #####', 'Microsoft Excel puede mostrar ##### en las celdas cuando una columna no es lo suficientemente ancha para mostrar todo el contenido de la celda.', null, 'b37fa5cd351a0760542c4c1aa1950f3956cfa5147e88821761f5418e253735fb', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'b37fa5cd351a0760542c4c1aa1950f3956cfa5147e88821761f5418e253735fb')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'La fórmula contiene una referencia circular.', false), ('B', 'La columna no es lo suficientemente ancha para mostrar todo el contenido de la celda.', true), ('C', 'La celda contiene texto de más de 255 caracteres.', false), ('D', 'La fórmula hace referencia a una hoja que se ha eliminado.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
-- Lote age-aux-b2-09-excel-ms_excel_atajos-v1 (7 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Microsoft Soporte · Métodos abreviados de teclado de Excel', 'https://support.microsoft.com/es-es/accessibility/excel/keyboard-shortcuts-in-excel', 'web_oficial'::public.source_kind, 'Microsoft (documentación oficial)', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('age-aux-b2-09-excel', 'II.9 Hojas de cálculo: Excel 365') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('auxiliar-administrativo-estado') and t.slug = 'age-aux-b2-09-excel' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'En Excel, ¿qué combinación de teclas inserta la fecha actual en la celda?', 'Según la tabla de métodos abreviados de Excel, Ctrl+; inserta la fecha actual.', 'age_aux_b2_09_excel', (select id from public.topics where slug = 'age-aux-b2-09-excel'), 1, 'es', true, (select id from public.sources where url = 'https://support.microsoft.com/es-es/accessibility/excel/keyboard-shortcuts-in-excel'), 'Métodos abreviados de Excel (fecha actual)', 'Úselo para insertar la fecha actual. | Ctrl+punto y coma (;)', null, '6ccaff41ea05555e41b5939b9b0729d4c4ef07c4b24145880123215b1b782a76', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '6ccaff41ea05555e41b5939b9b0729d4c4ef07c4b24145880123215b1b782a76')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Ctrl+punto y coma (;)', true), ('B', 'Ctrl+D', false), ('C', 'Ctrl+Mayús+E', false), ('D', 'Alt+signo igual (=)', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'En Excel, la combinación Alt+signo igual (=) sirve para:', 'Alt+= inserta la fórmula Suma (Autosuma).', 'age_aux_b2_09_excel', (select id from public.topics where slug = 'age-aux-b2-09-excel'), 1, 'es', true, (select id from public.sources where url = 'https://support.microsoft.com/es-es/accessibility/excel/keyboard-shortcuts-in-excel'), 'Métodos abreviados de Excel (Suma)', 'Insertar la fórmula Suma | Alt+signo igual (=)', null, '60d975b36a37ba2315617cf648fb8f6b503b79a62973c7a45a0047ac8b3df066', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '60d975b36a37ba2315617cf648fb8f6b503b79a62973c7a45a0047ac8b3df066')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Mostrar el cuadro de diálogo Insertar función.', false), ('B', 'Cambiar entre mostrar valores o fórmulas.', false), ('C', 'Comenzar una nueva línea en la misma celda.', false), ('D', 'Insertar la fórmula Suma.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select '¿Qué combinación de teclas abre el cuadro de diálogo Formato de celdas en Excel?', 'Ctrl+1 abre Formato de celdas; Ctrl+L o Ctrl+T muestran el cuadro Crear tabla.', 'age_aux_b2_09_excel', (select id from public.topics where slug = 'age-aux-b2-09-excel'), 1, 'es', true, (select id from public.sources where url = 'https://support.microsoft.com/es-es/accessibility/excel/keyboard-shortcuts-in-excel'), 'Métodos abreviados de Excel (Formato de celdas)', 'Úselo para abrir el cuadro de diálogo Formato de celdas. | Ctrl+1', null, '0e89465eee708d9a9734960cf3654a46a68792459235e106b082ced2c75d9949', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '0e89465eee708d9a9734960cf3654a46a68792459235e106b082ced2c75d9949')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Ctrl+L', false), ('B', 'Ctrl+1', true), ('C', 'Ctrl+T', false), ('D', 'Mayús+F3', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'En Excel, ¿qué diferencia hay entre pulsar F11 sola y pulsar Alt+F1 con un rango de datos seleccionado?', 'F11 crea el gráfico en una hoja de gráfico aparte; Alt+F1 lo incrusta en la hoja actual. Mayús+F11 inserta una hoja de cálculo nueva.', 'age_aux_b2_09_excel', (select id from public.topics where slug = 'age-aux-b2-09-excel'), 2, 'es', true, (select id from public.sources where url = 'https://support.microsoft.com/es-es/accessibility/excel/keyboard-shortcuts-in-excel'), 'Teclas de función de Excel (F11 y Alt+F1)', 'Solo F11: crea un gráfico a partir de los datos del rango actual en una hoja de gráfico distinta. […] Alt+F1: crea un gráfico incrustado a partir de los datos del rango actual.', null, 'db0a6e86914473298fc5fec295a9d4b959c4bb46c03512a7683aa0d5b7662680', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'db0a6e86914473298fc5fec295a9d4b959c4bb46c03512a7683aa0d5b7662680')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'F11 crea un gráfico incrustado y Alt+F1 crea un gráfico en una hoja de gráfico distinta.', false), ('B', 'F11 inserta una hoja de cálculo nueva y Alt+F1 crea un gráfico incrustado.', false), ('C', 'F11 crea una tabla dinámica y Alt+F1 crea un gráfico dinámico.', false), ('D', 'F11 crea un gráfico en una hoja de gráfico distinta y Alt+F1 crea un gráfico incrustado.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'En Excel, ¿qué combinación de teclas invoca Relleno rápido para reconocer automáticamente los patrones de las columnas adyacentes?', 'Ctrl+Mayús+E invoca Relleno rápido; Ctrl+D rellena hacia abajo y Ctrl+Entrar rellena el rango seleccionado con la entrada actual.', 'age_aux_b2_09_excel', (select id from public.topics where slug = 'age-aux-b2-09-excel'), 2, 'es', true, (select id from public.sources where url = 'https://support.microsoft.com/es-es/accessibility/excel/keyboard-shortcuts-in-excel'), 'Métodos abreviados de Excel (Relleno rápido)', 'Úselo para invocar Relleno rápido a fin de reconocer automáticamente los patrones de las columnas adyacentes | Ctrl+Mayús+E', null, 'f70c142de195edaa951c4162e08293c78f075fbf0315012b73737abb76615401', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'f70c142de195edaa951c4162e08293c78f075fbf0315012b73737abb76615401')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Ctrl+Mayús+E', true), ('B', 'Ctrl+D', false), ('C', 'Ctrl+Entrar', false), ('D', 'Ctrl+Mayús+L', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'En Excel, si se selecciona un rango de celdas, se escribe un valor y se pulsa Ctrl+Entrar:', 'Ctrl+Entrar rellena todo el rango seleccionado con la entrada actual; Alt+Entrar inicia una nueva línea en la celda.', 'age_aux_b2_09_excel', (select id from public.topics where slug = 'age-aux-b2-09-excel'), 2, 'es', true, (select id from public.sources where url = 'https://support.microsoft.com/es-es/accessibility/excel/keyboard-shortcuts-in-excel'), 'Métodos abreviados de Excel (Ctrl+Entrar)', 'Úselo para rellenar el rango de celdas seleccionado con la entrada actual. | Ctrl+Entrar', null, '7c1d0647f5bdecf6f38e3cbd3ff9ad0d4b0fa191299628388ca79148154febab', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '7c1d0647f5bdecf6f38e3cbd3ff9ad0d4b0fa191299628388ca79148154febab')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Se comienza una nueva línea en la misma celda.', false), ('B', 'Se copia el contenido de la celda situada más arriba.', false), ('C', 'Se rellena el rango de celdas seleccionado con la entrada actual.', true), ('D', 'Se crea una tabla con el rango seleccionado.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'En Excel, la combinación Mayús+F3 muestra:', 'Mayús+F3 abre Insertar función; F12, Guardar como; Ctrl+1, Formato de celdas; Mayús+F11 inserta una hoja nueva.', 'age_aux_b2_09_excel', (select id from public.topics where slug = 'age-aux-b2-09-excel'), 2, 'es', true, (select id from public.sources where url = 'https://support.microsoft.com/es-es/accessibility/excel/keyboard-shortcuts-in-excel'), 'Teclas de función de Excel (Mayús+F3)', 'Mayús+F3: muestra el cuadro de diálogo Insertar función.', null, '46192fb6805a400a6ed94977b852a245072836cb6ff6974e81714435816fad68', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '46192fb6805a400a6ed94977b852a245072836cb6ff6974e81714435816fad68')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El cuadro de diálogo Guardar como.', false), ('B', 'El cuadro de diálogo Formato de celdas.', false), ('C', 'Una hoja de cálculo nueva.', false), ('D', 'El cuadro de diálogo Insertar función.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
-- Lote age-aux-b2-09-excel-ms_excel_buscarx-v1 (1 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Microsoft Soporte · Función BUSCARX', 'https://support.microsoft.com/es-es/excel/functions/xlookup-function', 'web_oficial'::public.source_kind, 'Microsoft (documentación oficial)', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('age-aux-b2-09-excel', 'II.9 Hojas de cálculo: Excel 365') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('auxiliar-administrativo-estado') and t.slug = 'age-aux-b2-09-excel' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'En la función BUSCARX, si el argumento modo_de_coincidencia toma el valor -1 y no se encuentra una coincidencia exacta, la función devuelve:', 'Con -1 se busca coincidencia exacta y, si no la hay, se devuelve el siguiente elemento más pequeño; con 1, el siguiente más grande.', 'age_aux_b2_09_excel', (select id from public.topics where slug = 'age-aux-b2-09-excel'), 3, 'es', true, (select id from public.sources where url = 'https://support.microsoft.com/es-es/excel/functions/xlookup-function'), 'Función BUSCARX (coincidencia -1)', '-1: coincidencia exacta. Si no se encuentra ninguna, devolver el siguiente elemento más pequeño.', null, 'cd96ec24e5c69cf9fb09e48555c57d9df21f4e5a5617173d1f01b8fbe2586bde', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'cd96ec24e5c69cf9fb09e48555c57d9df21f4e5a5617173d1f01b8fbe2586bde')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El error #N/A.', false), ('B', 'El siguiente elemento más grande.', false), ('C', 'El último elemento de la matriz.', false), ('D', 'El siguiente elemento más pequeño.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
-- Lote age-aux-b2-09-excel-ms_excel_contarsi-v1 (1 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Microsoft Soporte · Usar la función CONTAR.SI en Microsoft Excel', 'https://support.microsoft.com/es-es/excel/get-started/use-the-countif-function-in-microsoft-excel', 'web_oficial'::public.source_kind, 'Microsoft (documentación oficial)', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('age-aux-b2-09-excel', 'II.9 Hojas de cálculo: Excel 365') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('auxiliar-administrativo-estado') and t.slug = 'age-aux-b2-09-excel' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el soporte de Microsoft, ¿cuál de las siguientes es una limitación de la función CONTAR.SI?', 'CONTAR.SI no cuenta por color; sí admite comodines (? y *) y criterios como ">55". Para varios criterios se usa CONTAR.SI.CONJUNTO.', 'age_aux_b2_09_excel', (select id from public.topics where slug = 'age-aux-b2-09-excel'), 2, 'es', true, (select id from public.sources where url = 'https://support.microsoft.com/es-es/excel/get-started/use-the-countif-function-in-microsoft-excel'), 'Función CONTAR.SI (limitaciones)', 'La función CONTAR.SI no puede contar celdas según el color de fondo o el color de fuente.', null, '4c2727accae1cbb310aa3aac7c66755f3fc5ac0d433f041d5db3304725dcd044', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '4c2727accae1cbb310aa3aac7c66755f3fc5ac0d433f041d5db3304725dcd044')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'No admite caracteres comodín en los criterios.', false), ('B', 'No puede contar celdas según el color de fondo o el color de fuente.', true), ('C', 'Solo puede aplicarse a rangos de una única fila.', false), ('D', 'No admite criterios con operadores de comparación como «>».', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
-- Lote age-aux-b2-09-excel-ms_excel_filtrar-v1 (1 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Microsoft Soporte · Filtrar datos de una tabla o un rango en Excel', 'https://support.microsoft.com/es-es/excel/get-started/filter-data-in-a-range-or-table-in-excel', 'web_oficial'::public.source_kind, 'Microsoft (documentación oficial)', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('age-aux-b2-09-excel', 'II.9 Hojas de cálculo: Excel 365') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('auxiliar-administrativo-estado') and t.slug = 'age-aux-b2-09-excel' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según Microsoft, al colocar datos en una tabla de Excel:', 'La página de Microsoft sobre filtros indica que, en una tabla, los controles de filtro se añaden automáticamente a los encabezados.', 'age_aux_b2_09_excel', (select id from public.topics where slug = 'age-aux-b2-09-excel'), 1, 'es', true, (select id from public.sources where url = 'https://support.microsoft.com/es-es/excel/get-started/filter-data-in-a-range-or-table-in-excel'), 'Filtrar datos (tablas)', 'Al colocar datos en una tabla, los controles de filtro se agregan automáticamente a los encabezados de tabla.', null, '700472bef53f72bca48d93c9b9bc8287d2f3fb99cf1fc574716040e6cb5e1f68', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '700472bef53f72bca48d93c9b9bc8287d2f3fb99cf1fc574716040e6cb5e1f68')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Se ordenan automáticamente de forma ascendente por la primera columna.', false), ('B', 'Se crea automáticamente una tabla dinámica en una hoja nueva.', false), ('C', 'Los controles de filtro se agregan automáticamente a los encabezados de tabla.', true), ('D', 'Se inmoviliza automáticamente la fila de encabezado.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
-- Lote age-aux-b2-09-excel-ms_excel_limites-v1 (3 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Microsoft Soporte · Especificaciones y límites de Excel', 'https://support.microsoft.com/es-es/excel/excel-specifications-and-limits', 'web_oficial'::public.source_kind, 'Microsoft (documentación oficial)', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('age-aux-b2-09-excel', 'II.9 Hojas de cálculo: Excel 365') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('auxiliar-administrativo-estado') and t.slug = 'age-aux-b2-09-excel' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según las especificaciones y límites de Excel, la precisión numérica es de:', 'La tabla de límites de cálculo de Excel fija una precisión numérica de 15 dígitos.', 'age_aux_b2_09_excel', (select id from public.topics where slug = 'age-aux-b2-09-excel'), 3, 'es', true, (select id from public.sources where url = 'https://support.microsoft.com/es-es/excel/excel-specifications-and-limits'), 'Especificaciones y límites de Excel (precisión)', 'Precisión numérica | 15 dígitos', null, 'f63cc0cdace6f5d9b397f84070d2181cf381473a8a29f1767ac6cf2cf0053ab2', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'f63cc0cdace6f5d9b397f84070d2181cf381473a8a29f1767ac6cf2cf0053ab2')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', '10 dígitos.', false), ('B', '32 dígitos.', false), ('C', '15 dígitos.', true), ('D', '64 dígitos.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select '¿Cuántos niveles anidados de funciones admite como máximo una fórmula de Excel, según sus especificaciones?', 'Excel admite 64 niveles anidados de funciones; 255 es el número máximo de argumentos de una función.', 'age_aux_b2_09_excel', (select id from public.topics where slug = 'age-aux-b2-09-excel'), 3, 'es', true, (select id from public.sources where url = 'https://support.microsoft.com/es-es/excel/excel-specifications-and-limits'), 'Especificaciones y límites de Excel (funciones anidadas)', 'Niveles anidados de funciones | 64', null, '0c03b40757337c83a433b13ca74c35869139e7a0862d977fa5167dc417eae6a4', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '0c03b40757337c83a433b13ca74c35869139e7a0862d977fa5167dc417eae6a4')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', '7', false), ('B', '64', true), ('C', '32', false), ('D', '255', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según las especificaciones de Excel, la longitud máxima del contenido de una fórmula es de:', 'La longitud del contenido de una fórmula está limitada a 8.192 caracteres; 32.767 es el máximo de caracteres de una celda.', 'age_aux_b2_09_excel', (select id from public.topics where slug = 'age-aux-b2-09-excel'), 3, 'es', true, (select id from public.sources where url = 'https://support.microsoft.com/es-es/excel/excel-specifications-and-limits'), 'Especificaciones y límites de Excel (longitud de fórmula)', 'Longitud del contenido de una fórmula | 8.192 caracteres', null, '3130ee369a368230e93fc7d02b0353ffa7f701a7d6701af1e4d93ead74caeebc', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '3130ee369a368230e93fc7d02b0353ffa7f701a7d6701af1e4d93ead74caeebc')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', '8.192 caracteres.', true), ('B', '255 caracteres.', false), ('C', '1.024 caracteres.', false), ('D', '32.767 caracteres.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
-- Lote age-aux-b2-09-excel-ms_excel_tabladin-v1 (1 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Microsoft Soporte · Crear una tabla dinámica para analizar datos de una hoja de cálculo', 'https://support.microsoft.com/es-es/office/crear-una-tabla-din%C3%A1mica-para-analizar-datos-de-una-hoja-de-c%C3%A1lculo-a9a84538-bfe9-40a9-a8e9-f99134456576', 'web_oficial'::public.source_kind, 'Microsoft (documentación oficial)', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('age-aux-b2-09-excel', 'II.9 Hojas de cálculo: Excel 365') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('auxiliar-administrativo-estado') and t.slug = 'age-aux-b2-09-excel' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'De forma predeterminada, ¿cómo se muestran los campos numéricos colocados en el área Valores de una tabla dinámica de Excel?', 'Según Microsoft, los campos del área Valores se muestran por defecto como SUM; si Excel interpreta los datos como texto, como RECUENTO.', 'age_aux_b2_09_excel', (select id from public.topics where slug = 'age-aux-b2-09-excel'), 2, 'es', true, (select id from public.sources where url = 'https://support.microsoft.com/es-es/office/crear-una-tabla-din%C3%A1mica-para-analizar-datos-de-una-hoja-de-c%C3%A1lculo-a9a84538-bfe9-40a9-a8e9-f99134456576'), 'Tablas dinámicas (área Valores)', 'De forma predeterminada, los campos de tabla dinámica colocados en el área Valores se muestran como SUM.', null, '765aaba61e65112c1f2a2503c5d903bb81e0fb73b1ac291e45ec9b116afafea8', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '765aaba61e65112c1f2a2503c5d903bb81e0fb73b1ac291e45ec9b116afafea8')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Como SUM.', true), ('B', 'Como PROMEDIO.', false), ('C', 'Como RECUENTO.', false), ('D', 'Como MAX.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
-- Lote age-aux-b2-10-access-ms_access_atajos-v1 (3 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Microsoft Soporte · Métodos abreviados de teclado de Access', 'https://support.microsoft.com/es-es/office/m%C3%A9todos-abreviados-de-teclado-de-access-70a673e4-4f7b-4300-b8e5-3320fa6606e2', 'web_oficial'::public.source_kind, 'Microsoft (documentación oficial)', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('age-aux-b2-10-access', 'II.10 Bases de datos: Access 365') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('auxiliar-administrativo-estado') and t.slug = 'age-aux-b2-10-access' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'En Access, ¿qué tecla muestra u oculta el panel de navegación?', 'Según la tabla de métodos abreviados de Access, F11 muestra u oculta el panel de navegación; F4 muestra u oculta una hoja de propiedades, F5 cambia a la vista Formulario desde la vista Diseño y F12 abre Guardar como.', 'age_aux_b2_10_access', (select id from public.topics where slug = 'age-aux-b2-10-access'), 1, 'es', true, (select id from public.sources where url = 'https://support.microsoft.com/es-es/office/m%C3%A9todos-abreviados-de-teclado-de-access-70a673e4-4f7b-4300-b8e5-3320fa6606e2'), 'Métodos abreviados · Panel de navegación', '| Mostrar u ocultar el panel de navegación. | F11 |', null, '0a09aa06ed1b5f8e5a486620c2a91517524cd74f758c154eabe50463125cd14e', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '0a09aa06ed1b5f8e5a486620c2a91517524cd74f758c154eabe50463125cd14e')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'F4.', false), ('B', 'F5.', false), ('C', 'F11.', true), ('D', 'F12.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Al introducir datos en Access, ¿qué combinación de teclas inserta la fecha actual?', 'Ctrl + ; inserta la fecha actual; Ctrl + '' inserta el valor del mismo campo del registro anterior, Ctrl + + agrega un registro nuevo y Mayús + Entrar guarda los cambios del registro actual.', 'age_aux_b2_10_access', (select id from public.topics where slug = 'age-aux-b2-10-access'), 1, 'es', true, (select id from public.sources where url = 'https://support.microsoft.com/es-es/office/m%C3%A9todos-abreviados-de-teclado-de-access-70a673e4-4f7b-4300-b8e5-3320fa6606e2'), 'Métodos abreviados · Fecha actual', '| Insertar la fecha actual. | Ctrl+punto y coma (;) |', null, '1947a603134ba3e31bf83e06d0571ecee0fc37d2949123a18a928f1043b945de', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '1947a603134ba3e31bf83e06d0571ecee0fc37d2949123a18a928f1043b945de')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Ctrl + apóstrofo ('').', false), ('B', 'Ctrl + signo más (+).', false), ('C', 'Mayús + Entrar.', false), ('D', 'Ctrl + punto y coma (;).', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'En Access, ¿qué hace la combinación Ctrl + apóstrofo ('')?', 'Ctrl + '' inserta el valor del mismo campo del registro anterior; Ctrl + ; inserta la fecha actual, Ctrl + - elimina el registro actual y Mayús + F2 abre el cuadro Zoom.', 'age_aux_b2_10_access', (select id from public.topics where slug = 'age-aux-b2-10-access'), 3, 'es', true, (select id from public.sources where url = 'https://support.microsoft.com/es-es/office/m%C3%A9todos-abreviados-de-teclado-de-access-70a673e4-4f7b-4300-b8e5-3320fa6606e2'), 'Métodos abreviados · Valor del registro anterior', '| Inserte el valor del mismo campo en el registro anterior. | Ctrl+apóstrofo ('') |', null, '58aff72632fdc1ffe434c13e8125078fb1c575f7e6729b1eda8b54c22f49833c', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '58aff72632fdc1ffe434c13e8125078fb1c575f7e6729b1eda8b54c22f49833c')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Inserta la fecha actual.', false), ('B', 'Elimina el registro actual de la hoja de datos.', false), ('C', 'Inserta el valor del mismo campo en el registro anterior.', true), ('D', 'Abre el cuadro Zoom para escribir expresiones.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
-- Lote age-aux-b2-10-access-ms_access_clave-v1 (1 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Microsoft Soporte · Agregar o cambiar la clave principal de una tabla en Access', 'https://support.microsoft.com/es-es/access/add-or-change-a-table-s-primary-key-in-access', 'web_oficial'::public.source_kind, 'Microsoft (documentación oficial)', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('age-aux-b2-10-access', 'II.10 Bases de datos: Access 365') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('auxiliar-administrativo-estado') and t.slug = 'age-aux-b2-10-access' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'En la vista Diseño de una tabla de Access, ¿dónde está el comando Clave principal?', 'En la pestaña Diseño de tabla, grupo Herramientas, se selecciona Clave principal; se agrega un indicador de clave a la izquierda del campo o campos elegidos.', 'age_aux_b2_10_access', (select id from public.topics where slug = 'age-aux-b2-10-access'), 2, 'es', true, (select id from public.sources where url = 'https://support.microsoft.com/es-es/access/add-or-change-a-table-s-primary-key-in-access'), 'Clave principal (establecer)', 'En la pestaña Diseño de tabla , en el grupo Herramientas , seleccione Clave principal.', null, 'e4aa7e7f586e51bc018b1718120d4971d498956482e703c5f371e8b159a9f6fd', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'e4aa7e7f586e51bc018b1718120d4971d498956482e703c5f371e8b159a9f6fd')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'En la pestaña Diseño de tabla, grupo Herramientas.', true), ('B', 'En la pestaña Crear, grupo Tablas.', false), ('C', 'En la pestaña Herramientas de base de datos, grupo Relaciones.', false), ('D', 'En la pestaña Inicio, grupo Registros.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
-- Lote age-aux-b2-10-access-ms_access_consultas-v1 (2 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Microsoft Soporte · Introducción a las consultas', 'https://support.microsoft.com/es-es/access/introduction-to-queries', 'web_oficial'::public.source_kind, 'Microsoft (documentación oficial)', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('age-aux-b2-10-access', 'II.10 Bases de datos: Access 365') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('auxiliar-administrativo-estado') and t.slug = 'age-aux-b2-10-access' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según Microsoft, una consulta de totales en Access es:', 'La consulta de totales es una consulta de selección que permite agrupar y resumir datos; no modifica datos como las consultas de acción.', 'age_aux_b2_10_access', (select id from public.topics where slug = 'age-aux-b2-10-access'), 2, 'es', true, (select id from public.sources where url = 'https://support.microsoft.com/es-es/access/introduction-to-queries'), 'Consulta de totales', 'Una consulta de totales es una consulta de selección que permite agrupar y resumir datos', null, '50295ad3cecb059fe63e794951a7f986bbb694c61889f571559e9be7304677db', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '50295ad3cecb059fe63e794951a7f986bbb694c61889f571559e9be7304677db')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Una consulta de acción que actualiza los totales almacenados en la tabla.', false), ('B', 'Una consulta de datos anexados que suma registros de varias tablas.', false), ('C', 'Una consulta de selección que permite agrupar y resumir datos.', true), ('D', 'Una consulta de parámetros que pide al usuario el campo que se va a sumar.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Para crear una consulta en vista Diseño en Access, ¿qué se selecciona?', 'Se abre la base de datos y, en la pestaña Crear, se hace clic en Diseño de consulta.', 'age_aux_b2_10_access', (select id from public.topics where slug = 'age-aux-b2-10-access'), 2, 'es', true, (select id from public.sources where url = 'https://support.microsoft.com/es-es/access/introduction-to-queries'), 'Crear una consulta', '1. Abra la base de datos y, en la pestaña Crear, haga clic en Diseño de consulta.', null, 'ae9112f809d7b032682c9d42db44d439c7894bb41d5a93fc27d76082d79fd718', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'ae9112f809d7b032682c9d42db44d439c7894bb41d5a93fc27d76082d79fd718')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'En la pestaña Crear, Diseño de consulta.', true), ('B', 'En la pestaña Datos externos, Diseño de consulta.', false), ('C', 'En la pestaña Inicio, Nueva consulta.', false), ('D', 'En la pestaña Herramientas de base de datos, Consultas.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
-- Lote age-aux-b2-10-access-ms_access_exportar-v1 (2 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Microsoft Soporte · Exportar datos a Excel', 'https://support.microsoft.com/es-es/access/export-data-to-excel', 'web_oficial'::public.source_kind, 'Microsoft (documentación oficial)', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('age-aux-b2-10-access', 'II.10 Bases de datos: Access 365') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('auxiliar-administrativo-estado') and t.slug = 'age-aux-b2-10-access' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Al exportar datos de Access a Excel, ¿cuántos objetos de base de datos pueden exportarse en cada operación de exportación?', 'Solo puede exportarse un objeto de base de datos en cada operación de exportación (tablas, consultas, formularios o informes).', 'age_aux_b2_10_access', (select id from public.topics where slug = 'age-aux-b2-10-access'), 2, 'es', true, (select id from public.sources where url = 'https://support.microsoft.com/es-es/access/export-data-to-excel'), 'Exportar a Excel (un objeto por operación)', 'Solo puede exportar un objeto de base de datos en cada operación de exportación.', null, 'c315233538aea0b7e1de7e8dab1c11041daba1fe31f2667e4777280eb6d70562', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'c315233538aea0b7e1de7e8dab1c11041daba1fe31f2667e4777280eb6d70562')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Hasta dos: una tabla y su consulta.', false), ('B', 'Solo uno.', true), ('C', 'Todos los objetos seleccionados en el panel de navegación.', false), ('D', 'Tantos como hojas tenga el libro de destino.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Al exportar un informe de Access a Excel, ¿en qué formato de archivo se puede exportar?', 'Los informes solo se pueden exportar en el antiguo formato *.xls, no en el nuevo *.xlsx.', 'age_aux_b2_10_access', (select id from public.topics where slug = 'age-aux-b2-10-access'), 3, 'es', true, (select id from public.sources where url = 'https://support.microsoft.com/es-es/access/export-data-to-excel'), 'Exportar informes a Excel', 'los informes solo se pueden exportar en el antiguo formato de archivo *.xls, no en el nuevo *.xlsx.', null, '1f3027495e7708a0ca974a7ece3cf6c992037e85830112cc1f206a3a360434f7', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '1f3027495e7708a0ca974a7ece3cf6c992037e85830112cc1f206a3a360434f7')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Solo en el nuevo formato *.xlsx.', false), ('B', 'Solo en el antiguo formato *.xls.', true), ('C', 'En *.xls o en *.xlsx, a elección del usuario.', false), ('D', 'Solo como archivo de texto delimitado (*.csv).', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
-- Lote age-aux-b2-10-access-ms_access_formularios-v1 (1 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Microsoft Soporte · Introducción a formularios', 'https://support.microsoft.com/es-es/topic/introducci%C3%B3n-a-formularios-e8d47343-c937-44e8-a80f-b6a83a1fa3ae', 'web_oficial'::public.source_kind, 'Microsoft (documentación oficial)', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('age-aux-b2-10-access', 'II.10 Bases de datos: Access 365') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('auxiliar-administrativo-estado') and t.slug = 'age-aux-b2-10-access' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'En Access, un formulario que está conectado directamente a un origen de datos, como una tabla o una consulta, se denomina:', 'El formulario dependiente está conectado directamente a un origen de datos (tabla o consulta); el independiente no está vinculado directamente a un origen de datos.', 'age_aux_b2_10_access', (select id from public.topics where slug = 'age-aux-b2-10-access'), 1, 'es', true, (select id from public.sources where url = 'https://support.microsoft.com/es-es/topic/introducci%C3%B3n-a-formularios-e8d47343-c937-44e8-a80f-b6a83a1fa3ae'), 'Formularios · Dependiente e independiente', 'Un formulario dependiente está conectado directamente a un origen de datos, como una tabla o consulta', null, '2467f8a211f33a7db1ca52d930df68e51f10faa25ee259ceae8ab0f59a9f68f8', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '2467f8a211f33a7db1ca52d930df68e51f10faa25ee259ceae8ab0f59a9f68f8')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Formulario independiente.', false), ('B', 'Formulario dependiente.', true), ('C', 'Formulario dividido.', false), ('D', 'Subformulario de búsqueda.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
-- Lote age-aux-b2-10-access-ms_access_importar-v1 (1 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Microsoft Soporte · Importar o vincular a datos de un libro de Excel', 'https://support.microsoft.com/es-es/access/import-or-link-to-data-in-an-excel-workbook', 'web_oficial'::public.source_kind, 'Microsoft (documentación oficial)', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('age-aux-b2-10-access', 'II.10 Bases de datos: Access 365') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('auxiliar-administrativo-estado') and t.slug = 'age-aux-b2-10-access' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Al importar en Access datos de un libro de Excel con varias hojas de cálculo:', 'Según Microsoft, se pueden importar datos solo desde una hoja de cálculo cada vez.', 'age_aux_b2_10_access', (select id from public.topics where slug = 'age-aux-b2-10-access'), 2, 'es', true, (select id from public.sources where url = 'https://support.microsoft.com/es-es/access/import-or-link-to-data-in-an-excel-workbook'), 'Importar desde Excel (una hoja cada vez)', 'puede importar datos solo desde una hoja de cálculo cada vez.', null, 'cfa03aacceb151a620a84b232f9a12af2ab45dc23f6d6388f56cfb7694d1d80f', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'cfa03aacceb151a620a84b232f9a12af2ab45dc23f6d6388f56cfb7694d1d80f')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Se importan siempre todas las hojas del libro en una sola tabla.', false), ('B', 'Se crea automáticamente una tabla por cada hoja del libro.', false), ('C', 'Solo se puede importar la primera hoja del libro.', false), ('D', 'Solo se pueden importar los datos de una hoja de cálculo cada vez.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
-- Lote age-aux-b2-10-access-ms_access_informes-v1 (3 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Microsoft Soporte · Crear informes sencillos', 'https://support.microsoft.com/es-es/access/create-a-simple-report', 'web_oficial'::public.source_kind, 'Microsoft (documentación oficial)', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('age-aux-b2-10-access', 'II.10 Bases de datos: Access 365') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('auxiliar-administrativo-estado') and t.slug = 'age-aux-b2-10-access' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según Microsoft, ¿cuál es la forma más rápida de crear un informe en Access?', 'La herramienta Informe es la forma más rápida; el Asistente para informes permite ser más selectivo con los campos, Informe en blanco sirve para crearlo desde cero y el Asistente para etiquetas crea etiquetas de tamaños estándar.', 'age_aux_b2_10_access', (select id from public.topics where slug = 'age-aux-b2-10-access'), 1, 'es', true, (select id from public.sources where url = 'https://support.microsoft.com/es-es/access/create-a-simple-report'), 'Crear informes · Herramienta Informe', 'La herramienta Informe es la forma más rápida de crear un informe', null, '87510a36be9a1c539cc39c458c3b5ed01134822a6729f54019f31aecf1357170', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '87510a36be9a1c539cc39c458c3b5ed01134822a6729f54019f31aecf1357170')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'La herramienta Informe.', true), ('B', 'El Asistente para informes.', false), ('C', 'La herramienta Informe en blanco.', false), ('D', 'El Asistente para etiquetas.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select '¿Qué sección de un informe de Access se imprime una vez por cada fila del origen de registros?', 'La sección Detalle se imprime una vez por cada fila del origen de registros; el encabezado de página, en la parte superior de cada página; el pie de página, al final de cada página, y el encabezado del informe, solo una vez al principio.', 'age_aux_b2_10_access', (select id from public.topics where slug = 'age-aux-b2-10-access'), 2, 'es', true, (select id from public.sources where url = 'https://support.microsoft.com/es-es/access/create-a-simple-report'), 'Secciones del informe (Detalle)', 'Detalle: Esta sección imprime una vez por cada fila en el origen de registros.', null, '3a33cd4a94a5f6da9f7c8b9a6f08caf008dc3e5c26c28a4b281f482f4846e8d9', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '3a33cd4a94a5f6da9f7c8b9a6f08caf008dc3e5c26c28a4b281f482f4846e8d9')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Encabezado de página.', false), ('B', 'Pie de página.', false), ('C', 'Detalle.', true), ('D', 'Encabezado del informe.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select '¿Qué vista se usa de forma predeterminada al hacer doble clic en un informe en el panel de navegación de Access?', 'La vista Informe es la predeterminada al hacer doble clic en un informe del panel de navegación; el diseño se ajusta fácilmente en la vista Presentación y la Vista previa de impresión muestra el aspecto impreso.', 'age_aux_b2_10_access', (select id from public.topics where slug = 'age-aux-b2-10-access'), 2, 'es', true, (select id from public.sources where url = 'https://support.microsoft.com/es-es/access/create-a-simple-report'), 'Vistas del informe', 'La vista Informe es la vista predeterminada que se usa al hacer doble clic en un informe en el Panel de navegación.', null, '2ebeafc54df898f1aed06136fe14f01d71c259017a698aa439c7914cf9ca05e3', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '2ebeafc54df898f1aed06136fe14f01d71c259017a698aa439c7914cf9ca05e3')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'La vista Informe.', true), ('B', 'La vista Diseño.', false), ('C', 'La vista Presentación.', false), ('D', 'La Vista previa de impresión.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
-- Lote age-aux-b2-10-access-ms_access_relaciones-v1 (2 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Microsoft Soporte · Guía de relaciones de tablas', 'https://support.microsoft.com/es-es/access/guide-to-table-relationships', 'web_oficial'::public.source_kind, 'Microsoft (documentación oficial)', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('age-aux-b2-10-access', 'II.10 Bases de datos: Access 365') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('auxiliar-administrativo-estado') and t.slug = 'age-aux-b2-10-access' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'En Access, ¿qué tipo de relación existe cuando cada registro de la primera tabla solo puede tener un registro coincidente en la segunda?', 'En una relación uno a uno, cada registro de la primera tabla solo puede tener un registro coincidente en la segunda; la de varios a varios exige una tercera tabla de unión.', 'age_aux_b2_10_access', (select id from public.topics where slug = 'age-aux-b2-10-access'), 2, 'es', true, (select id from public.sources where url = 'https://support.microsoft.com/es-es/access/guide-to-table-relationships'), 'Relaciones uno a uno', 'En una relación uno a uno, cada registro de la primera tabla solo puede tener un registro coincidente', null, 'cf354f061e8725c9001cd947afa389284f1551a768f03b756ea32a16fb7582db', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'cf354f061e8725c9001cd947afa389284f1551a768f03b756ea32a16fb7582db')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Una relación uno a varios.', false), ('B', 'Una relación varios a varios.', false), ('C', 'Una relación de tabla de unión.', false), ('D', 'Una relación uno a uno.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'En una relación con integridad referencial y la opción de eliminar en cascada activada, al eliminar un registro de la tabla principal Access:', 'Con la eliminación en cascada, Access elimina automáticamente todos los registros que hacen referencia a la clave principal, en lugar de rechazar la operación.', 'age_aux_b2_10_access', (select id from public.topics where slug = 'age-aux-b2-10-access'), 2, 'es', true, (select id from public.sources where url = 'https://support.microsoft.com/es-es/access/guide-to-table-relationships'), 'Eliminar en cascada', 'Access elimina automáticamente todos los registros que hacen referencia a la clave principal.', null, '70632f7231426eebe6e6c6ddba0781c4ff651c8139b7473a6d21d1f22672c2f6', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '70632f7231426eebe6e6c6ddba0781c4ff651c8139b7473a6d21d1f22672c2f6')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Rechaza la eliminación mientras existan registros relacionados.', false), ('B', 'Elimina automáticamente todos los registros que hacen referencia a la clave principal.', true), ('C', 'Deja los registros relacionados con el campo de clave externa vacío.', false), ('D', 'Convierte los registros relacionados en registros de solo lectura.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
-- Lote age-aux-b2-10-access-ms_access_tareas-v1 (1 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Microsoft Soporte · Tareas básicas para una base de datos de escritorio de Access', 'https://support.microsoft.com/es-es/access/basic-tasks-for-an-access-desktop-database', 'web_oficial'::public.source_kind, 'Microsoft (documentación oficial)', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('age-aux-b2-10-access', 'II.10 Bases de datos: Access 365') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('auxiliar-administrativo-estado') and t.slug = 'age-aux-b2-10-access' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según Microsoft, las plantillas de Access:', 'Las plantillas de Access incluyen tablas, consultas, formularios e informes integrados listos para usar; si ninguna se ajusta, se puede empezar con una base de datos de escritorio en blanco.', 'age_aux_b2_10_access', (select id from public.topics where slug = 'age-aux-b2-10-access'), 1, 'es', true, (select id from public.sources where url = 'https://support.microsoft.com/es-es/access/basic-tasks-for-an-access-desktop-database'), 'Tareas básicas · Plantillas', 'Las plantillas de Access tienen tablas, consultas, formularios e informes integrados que están listos para usar.', null, '2f2f7a36bb10916ec08cf69ededd9dd15915a3c277b189e34328ce869191d34c', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '2f2f7a36bb10916ec08cf69ededd9dd15915a3c277b189e34328ce869191d34c')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Solo contienen la estructura de las tablas, sin consultas ni formularios.', false), ('B', 'Tienen tablas, consultas, formularios e informes integrados listos para usar.', true), ('C', 'Solo pueden usarse si antes se crea una base de datos de escritorio en blanco.', false), ('D', 'Incluyen únicamente informes predefinidos para imprimir datos importados.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
-- Lote age-aux-b2-10-access-ms_access_tipos-v1 (4 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Microsoft Soporte · Tipos de datos para bases de datos de escritorio de Access', 'https://support.microsoft.com/es-es/access/data-types-for-access-desktop-databases', 'web_oficial'::public.source_kind, 'Microsoft (documentación oficial)', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('age-aux-b2-10-access', 'II.10 Bases de datos: Access 365') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('auxiliar-administrativo-estado') and t.slug = 'age-aux-b2-10-access' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select '¿Qué tipo de datos de Access se utiliza para guardar una dirección de vínculo a un documento o archivo en Internet, en una intranet, en una LAN o en el equipo local?', 'El tipo Hipervínculo almacena una dirección de vínculo a un documento o archivo en Internet, una intranet, una red de área local (LAN) o el equipo local.', 'age_aux_b2_10_access', (select id from public.topics where slug = 'age-aux-b2-10-access'), 1, 'es', true, (select id from public.sources where url = 'https://support.microsoft.com/es-es/access/data-types-for-access-desktop-databases'), 'Tipos de datos (Hipervínculo)', '| Hipervínculo | Una dirección de vínculo a un documento o archivo en Internet, en una intranet, en una red de área local (LAN) o en el equipo local', null, 'fc00c8b30ebf7005e0d1610a0030751ab26ad5726770ed45c13aed59c6f3a2f0', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'fc00c8b30ebf7005e0d1610a0030751ab26ad5726770ed45c13aed59c6f3a2f0')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Objeto OLE.', false), ('B', 'Datos adjuntos.', false), ('C', 'Texto largo.', false), ('D', 'Hipervínculo.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'En una base de datos de escritorio de Access, ¿cuánto ocupa un campo de tipo Fecha y hora?', 'Fecha y hora ocupa 8 bytes (como Moneda); Autonumeración ocupa 4 bytes (16 para el Id. de replicación) y Sí/No, 1 byte.', 'age_aux_b2_10_access', (select id from public.topics where slug = 'age-aux-b2-10-access'), 3, 'es', true, (select id from public.sources where url = 'https://support.microsoft.com/es-es/access/data-types-for-access-desktop-databases'), 'Tipos de datos (Fecha y hora)', '| Fecha y hora | Fechas y horas. | 8 bytes. |', null, 'ced9f5fbfc3d470e101cdfe293b98e06d7252853733c221a9f527ecc5460fac6', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'ced9f5fbfc3d470e101cdfe293b98e06d7252853733c221a9f527ecc5460fac6')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', '4 bytes.', false), ('B', '1 byte.', false), ('C', '8 bytes.', true), ('D', '16 bytes.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Respecto al tipo de datos Texto largo de Access, señale la respuesta correcta:', 'Texto largo admite hasta 1 GB aproximadamente, aunque los controles que lo muestran se limitan a los primeros 64 000 caracteres; 255 es el límite del Texto breve y 8192/2048 los del Hipervínculo.', 'age_aux_b2_10_access', (select id from public.topics where slug = 'age-aux-b2-10-access'), 3, 'es', true, (select id from public.sources where url = 'https://support.microsoft.com/es-es/access/data-types-for-access-desktop-databases'), 'Tipos de datos (Texto largo)', '| Texto largo | Grandes cantidades de datos alfanuméricos: oraciones y párrafos. | Hasta 1 gigabyte (GB) aproximadamente, pero los controles para mostrar un texto largo se limitan a los primeros 64 000 caracteres. |', null, 'ad5e17e04ee49cadf7357c5cea8a0a85dcf1075d198309853cdeb1f93ef5b7c2', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'ad5e17e04ee49cadf7357c5cea8a0a85dcf1075d198309853cdeb1f93ef5b7c2')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Admite hasta 1 GB aproximadamente, pero los controles para mostrarlo se limitan a los primeros 64 000 caracteres.', true), ('B', 'Admite hasta 255 caracteres, igual que el Texto breve, pero sin índice.', false), ('C', 'Admite hasta 8192 caracteres, con un máximo de 2048 por cada parte.', false), ('D', 'Admite hasta 2 GB aproximadamente y los controles muestran todo su contenido.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según Microsoft, el tipo de datos Datos adjuntos de Access:', 'Cada campo Datos adjuntos puede contener una cantidad ilimitada de datos adjuntos por registro, pero este tipo no está disponible en los formatos de archivo MDB.', 'age_aux_b2_10_access', (select id from public.topics where slug = 'age-aux-b2-10-access'), 3, 'es', true, (select id from public.sources where url = 'https://support.microsoft.com/es-es/access/data-types-for-access-desktop-databases'), 'Tipos de datos (Datos adjuntos)', 'Tenga en cuenta que el tipo de datos Datos adjuntos no está disponible en los formatos de archivo MDB.', null, '61cc868ebb6b214b4da4dba02a0a58db83fdbc5a13d78473d5b8942367eb8ed1', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '61cc868ebb6b214b4da4dba02a0a58db83fdbc5a13d78473d5b8942367eb8ed1')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Solo admite un archivo adjunto por registro.', false), ('B', 'Solo está disponible en los formatos de archivo MDB.', false), ('C', 'Almacena el valor 0 para Falso y -1 para Verdadero.', false), ('D', 'No está disponible en los formatos de archivo MDB.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
-- Lote age-aux-b2-11-outlook-ms_outlook_buscar-v1 (1 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Microsoft Soporte · Buscar un mensaje o elemento con la Búsqueda instantánea', 'https://support.microsoft.com/es-es/outlook/find-a-message-or-item-with-instant-search', 'web_oficial'::public.source_kind, 'Microsoft (documentación oficial)', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('age-aux-b2-11-outlook', 'II.11 Correo electrónico: Outlook 365') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('auxiliar-administrativo-estado') and t.slug = 'age-aux-b2-11-outlook' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según Microsoft, la carpeta actual en la que se realiza por defecto la Búsqueda instantánea de Outlook es, la mayor parte del tiempo:', 'La Búsqueda instantánea busca solo en la carpeta actual seleccionada, que es la bandeja de entrada la mayor parte del tiempo; el ámbito puede ampliarse, por ejemplo, a todos los buzones.', 'age_aux_b2_11_outlook', (select id from public.topics where slug = 'age-aux-b2-11-outlook'), 2, 'es', true, (select id from public.sources where url = 'https://support.microsoft.com/es-es/outlook/find-a-message-or-item-with-instant-search'), 'Búsqueda instantánea · Ámbito', 'solo en la carpeta actual que seleccionó […] es la bandeja de entrada la mayor parte del tiempo', null, 'a0151ca2e33950a682f88ce5efe2e9555e50eca54580fb645c8cd7b0a9608c44', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'a0151ca2e33950a682f88ce5efe2e9555e50eca54580fb645c8cd7b0a9608c44')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'La carpeta Elementos enviados.', false), ('B', 'La carpeta Archivo.', false), ('C', 'La Bandeja de entrada.', true), ('D', 'La carpeta Elementos eliminados.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
-- Lote age-aux-b2-11-outlook-ms_outlook_calendario-v1 (2 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Microsoft Soporte · Introducción al calendario de Outlook', 'https://support.microsoft.com/es-es/office/introducci%C3%B3n-al-calendario-de-outlook-d94c5203-77c7-48ec-90a5-2e2bc10bd6f8', 'web_oficial'::public.source_kind, 'Microsoft (documentación oficial)', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('age-aux-b2-11-outlook', 'II.11 Correo electrónico: Outlook 365') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('auxiliar-administrativo-estado') and t.slug = 'age-aux-b2-11-outlook' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según Microsoft, en el calendario de Outlook, los distintos calendarios que haya creado el usuario:', 'La introducción al calendario de Outlook indica que se pueden ver en paralelo varios calendarios que se hayan creado.', 'age_aux_b2_11_outlook', (select id from public.topics where slug = 'age-aux-b2-11-outlook'), 1, 'es', true, (select id from public.sources where url = 'https://support.microsoft.com/es-es/office/introducci%C3%B3n-al-calendario-de-outlook-d94c5203-77c7-48ec-90a5-2e2bc10bd6f8'), 'Calendario · Varios calendarios', 'Puede ver en paralelo varios calendarios que haya creado', null, '97fe404d5b6bd656be0de9aa3093579d28f53f1270fe487e0374fa5de0d49416', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '97fe404d5b6bd656be0de9aa3093579d28f53f1270fe487e0374fa5de0d49416')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Solo pueden verse de uno en uno.', false), ('B', 'Deben combinarse antes en un único calendario.', false), ('C', 'Solo pueden verse desde Outlook en la web.', false), ('D', 'Pueden verse en paralelo.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según Microsoft, ¿cómo puede enviarse el calendario de Outlook a un destinatario de correo?', 'El calendario puede enviarse a un destinatario de correo como Calendario de Internet.', 'age_aux_b2_11_outlook', (select id from public.topics where slug = 'age-aux-b2-11-outlook'), 2, 'es', true, (select id from public.sources where url = 'https://support.microsoft.com/es-es/office/introducci%C3%B3n-al-calendario-de-outlook-d94c5203-77c7-48ec-90a5-2e2bc10bd6f8'), 'Calendario · Enviar por correo', 'Puede enviar el calendario a un destinatario de correo como Calendario de Internet', null, '296114d93640a4f5d149295b07b6112040a19830e25142a2e0351ddff4981c79', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '296114d93640a4f5d149295b07b6112040a19830e25142a2e0351ddff4981c79')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Como Calendario de Internet.', true), ('B', 'Como archivo de datos de Outlook (.pst).', false), ('C', 'Como lista de eventos de SharePoint.', false), ('D', 'Como plantilla de Outlook (*.oft).', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
-- Lote age-aux-b2-11-outlook-ms_outlook_cco-v1 (1 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Microsoft Soporte · Mostrar, ocultar y ver el campo CCO (copia carbón oculta) en Outlook para Windows', 'https://support.microsoft.com/es-es/outlook/mail/show-hide-and-view-the-bcc-blind-carbon-copy-field-in-outlook-for-windows', 'web_oficial'::public.source_kind, 'Microsoft (documentación oficial)', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('age-aux-b2-11-outlook', 'II.11 Correo electrónico: Outlook 365') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('auxiliar-administrativo-estado') and t.slug = 'age-aux-b2-11-outlook' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según la página de Microsoft sobre el campo CCO, usar el cuadro CCO:', 'Microsoft advierte que usar el cuadro CCO es la técnica favorita de los remitentes de spam, y recuerda que los nombres del cuadro CCO cuentan para el límite total.', 'age_aux_b2_11_outlook', (select id from public.topics where slug = 'age-aux-b2-11-outlook'), 2, 'es', true, (select id from public.sources where url = 'https://support.microsoft.com/es-es/outlook/mail/show-hide-and-view-the-bcc-blind-carbon-copy-field-in-outlook-for-windows'), 'CCO · Spam', 'Usar el cuadro CCO es la técnica favorita de los remitentes de spam.', null, '5b0df7431cbbe436a0f1f8e4aaa66cad24d9322a968c7606cd76e5bbd4303223', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '5b0df7431cbbe436a0f1f8e4aaa66cad24d9322a968c7606cd76e5bbd4303223')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Es la técnica favorita de los remitentes de spam.', true), ('B', 'Impide que el mensaje cuente para el límite de destinatarios.', false), ('C', 'Hace que todos los destinatarios vean quién recibió copia.', false), ('D', 'Cifra automáticamente el mensaje.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
-- Lote age-aux-b2-11-outlook-ms_outlook_cifrar-v1 (1 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Microsoft Soporte · Cifrar y proteger mensajes de correo electrónico en Outlook', 'https://support.microsoft.com/es-es/office/obtener-informaci%C3%B3n-sobre-c%C3%B3mo-proteger-y-proteger-mensajes-de-correo-electr%C3%B3nico-en-outlook-2baf3ac7-12db-40a4-8af7-1852204b4b67', 'web_oficial'::public.source_kind, 'Microsoft (documentación oficial)', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('age-aux-b2-11-outlook', 'II.11 Correo electrónico: Outlook 365') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('auxiliar-administrativo-estado') and t.slug = 'age-aux-b2-11-outlook' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'En Outlook, si a un mensaje se le aplican permisos como No reenviar o No imprimir:', 'Según Microsoft, un mensaje con permisos como No reenviar o No imprimir se cifra automáticamente.', 'age_aux_b2_11_outlook', (select id from public.topics where slug = 'age-aux-b2-11-outlook'), 3, 'es', true, (select id from public.sources where url = 'https://support.microsoft.com/es-es/office/obtener-informaci%C3%B3n-sobre-c%C3%B3mo-proteger-y-proteger-mensajes-de-correo-electr%C3%B3nico-en-outlook-2baf3ac7-12db-40a4-8af7-1852204b4b67'), 'Cifrar · Permisos', 'como No reenviar o No imprimir, se cifra automáticamente', null, '77079183a4859c81118a92056097115a5e8ecb9c20520ef087d957507c7b787f', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '77079183a4859c81118a92056097115a5e8ecb9c20520ef087d957507c7b787f')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El mensaje se envía como copia carbón oculta.', false), ('B', 'El mensaje se cifra automáticamente.', true), ('C', 'El mensaje se guarda en la Bandeja de salida hasta que el destinatario acepta.', false), ('D', 'El mensaje se convierte en una plantilla de Outlook.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
-- Lote age-aux-b2-11-outlook-ms_outlook_fueraoficina-v1 (2 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Microsoft Soporte · Usar reglas para crear un mensaje de Fuera de la oficina en Outlook clásico para Windows', 'https://support.microsoft.com/es-es/outlook/use-rules-to-create-an-out-of-office-message-in-outlook?ad=es&omkt=es-es&rs=es-es&ui=es-es', 'web_oficial'::public.source_kind, 'Microsoft (documentación oficial)', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('age-aux-b2-11-outlook', 'II.11 Correo electrónico: Outlook 365') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('auxiliar-administrativo-estado') and t.slug = 'age-aux-b2-11-outlook' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'En Outlook clásico, tras elegir Archivo > Administrar reglas y alertas, ¿qué se selecciona para crear la regla de Fuera de la oficina?', 'En el cuadro de diálogo Reglas y alertas, en la pestaña Reglas de correo electrónico, se selecciona Nueva regla.', 'age_aux_b2_11_outlook', (select id from public.topics where slug = 'age-aux-b2-11-outlook'), 2, 'es', true, (select id from public.sources where url = 'https://support.microsoft.com/es-es/outlook/use-rules-to-create-an-out-of-office-message-in-outlook?ad=es&omkt=es-es&rs=es-es&ui=es-es'), 'Fuera de la oficina · Crear la regla', 'En la pestaña Archivo, seleccione Administrar reglas & alertas. […] En el cuadro de diálogo Reglas y alertas, en la pestaña Reglas de correo electrónico, seleccione Nueva regla.', null, '4ad7a905c4a90acc0a37b4bdefdcb7fd24f7eafd29b01902505738360d348f1f', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '4ad7a905c4a90acc0a37b4bdefdcb7fd24f7eafd29b01902505738360d348f1f')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'En la pestaña Administrar alertas, Nueva alerta.', false), ('B', 'En la pestaña Reglas de correo electrónico, Nueva regla.', true), ('C', 'En la pestaña Reglas de correo electrónico, Ejecutar reglas ahora.', false), ('D', 'En la pestaña Opciones, Respuestas automáticas.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Al crear en Outlook clásico la regla de Fuera de la oficina, ¿qué opción se selecciona en «Iniciar desde una regla en blanco»?', 'En Iniciar desde una regla en blanco se selecciona Aplicar regla a los mensajes recibidos y después Siguiente.', 'age_aux_b2_11_outlook', (select id from public.topics where slug = 'age-aux-b2-11-outlook'), 3, 'es', true, (select id from public.sources where url = 'https://support.microsoft.com/es-es/outlook/use-rules-to-create-an-out-of-office-message-in-outlook?ad=es&omkt=es-es&rs=es-es&ui=es-es'), 'Fuera de la oficina · Regla en blanco', 'En Iniciar desde una regla en blanco, seleccione Aplicar regla a los mensajes recibidos y seleccione Siguiente.', null, '23fb1d8bd843c4361942f5062ff8aa5caa0514b3b039f8323a8b7e158382e029', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '23fb1d8bd843c4361942f5062ff8aa5caa0514b3b039f8323a8b7e158382e029')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Aplicar regla a los mensajes recibidos.', true), ('B', 'Aplicar regla a los mensajes que envíe.', false), ('C', 'Marcar los mensajes de alguien para realizarles un seguimiento.', false), ('D', 'Mover mensajes de alguien a una carpeta.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
-- Lote age-aux-b2-11-outlook-ms_outlook_libreta-v1 (2 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Microsoft Soporte · Abrir y usar la libreta de direcciones en Outlook', 'https://support.microsoft.com/es-es/outlook/open-and-use-the-address-book-in-outlook', 'web_oficial'::public.source_kind, 'Microsoft (documentación oficial)', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('age-aux-b2-11-outlook', 'II.11 Correo electrónico: Outlook 365') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('auxiliar-administrativo-estado') and t.slug = 'age-aux-b2-11-outlook' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Mientras redacta un mensaje en Outlook, ¿cómo puede abrir la libreta de direcciones?', 'Para abrir la libreta de direcciones se selecciona cualquiera de los botones Para, CC o CCO; después se busca el contacto y se selecciona Agregar.', 'age_aux_b2_11_outlook', (select id from public.topics where slug = 'age-aux-b2-11-outlook'), 1, 'es', true, (select id from public.sources where url = 'https://support.microsoft.com/es-es/outlook/open-and-use-the-address-book-in-outlook'), 'Libreta de direcciones · Abrir desde un mensaje', 'Para abrir la libreta de direcciones, seleccione cualquiera de los botones Para, CC o CCO.', null, 'b30b9121eb0e5f23ba0fa620ddaa23a492a6855546ebc9448be06917debe4c67', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'b30b9121eb0e5f23ba0fa620ddaa23a492a6855546ebc9448be06917debe4c67')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Seleccionando el botón Adjuntar archivo.', false), ('B', 'Seleccionando cualquiera de los botones Para, CC o CCO.', true), ('C', 'Pulsando dos veces sobre el asunto del mensaje.', false), ('D', 'Solo desde la pestaña Archivo, en Información de la cuenta.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select '¿Qué contiene la lista global de direcciones (LGD o GAL) de una cuenta de Exchange Server?', 'La GAL contiene los nombres y las direcciones de correo de todos los usuarios que tienen cuenta en ese Exchange Server, y Exchange la configura automáticamente.', 'age_aux_b2_11_outlook', (select id from public.topics where slug = 'age-aux-b2-11-outlook'), 2, 'es', true, (select id from public.sources where url = 'https://support.microsoft.com/es-es/outlook/open-and-use-the-address-book-in-outlook'), 'Libreta de direcciones · Contenido de la LGD', 'La GAL contiene los nombres y las direcciones de correo electrónico de todos los usuarios que tienen una cuenta con ese Exchange Server y que Exchange la configura automáticamente.', null, '7900af52d0377681f03109ad40b9ec756662bb4b8d623331aa2aaa0882d3205d', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '7900af52d0377681f03109ad40b9ec756662bb4b8d623331aa2aaa0882d3205d')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Solo los contactos que el usuario ha guardado en su carpeta Contactos.', false), ('B', 'Las direcciones de todos los remitentes de los que se ha recibido algún mensaje.', false), ('C', 'Los nombres y direcciones de correo de todos los usuarios con cuenta en ese Exchange Server.', true), ('D', 'Solo las listas de distribución creadas por el propio usuario.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
-- Lote age-aux-b2-11-outlook-ms_outlook_libreta_crear-v1 (2 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Microsoft Soporte · Crear una libreta de direcciones en la versión clásica de Outlook', 'https://support.microsoft.com/es-ES/Outlook/create-an-address-book-in-classic-outlook', 'web_oficial'::public.source_kind, 'Microsoft (documentación oficial)', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('age-aux-b2-11-outlook', 'II.11 Correo electrónico: Outlook 365') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('auxiliar-administrativo-estado') and t.slug = 'age-aux-b2-11-outlook' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Para crear una libreta de direcciones personal en la versión clásica de Outlook, se hace clic con el botón derecho en la carpeta Contactos y se selecciona:', 'Se crea una carpeta en Contactos (botón derecho en Contactos > Nueva carpeta) y después se hace de esa carpeta una libreta de direcciones.', 'age_aux_b2_11_outlook', (select id from public.topics where slug = 'age-aux-b2-11-outlook'), 2, 'es', true, (select id from public.sources where url = 'https://support.microsoft.com/es-ES/Outlook/create-an-address-book-in-classic-outlook'), 'Crear libreta de direcciones · Nueva carpeta', 'haga clic con el botón derecho en la carpeta Contactos y seleccione Nueva carpeta.', null, '8657a06bd4fbbc3c52e73b42857f880a3f7f5c1ba85973b55fdc62dc628023b2', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '8657a06bd4fbbc3c52e73b42857f880a3f7f5c1ba85973b55fdc62dc628023b2')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Nueva libreta de direcciones.', false), ('B', 'Nuevo grupo de contactos.', false), ('C', 'Exportar contactos.', false), ('D', 'Nueva carpeta.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Para que una nueva carpeta de contactos funcione como libreta de direcciones en Outlook clásico, en sus Propiedades debe estar seleccionada la casilla:', 'En Propiedades de la nueva carpeta hay que asegurarse de que está seleccionada la casilla Mostrar esta carpeta como una libreta de direcciones de correo electrónico.', 'age_aux_b2_11_outlook', (select id from public.topics where slug = 'age-aux-b2-11-outlook'), 3, 'es', true, (select id from public.sources where url = 'https://support.microsoft.com/es-ES/Outlook/create-an-address-book-in-classic-outlook'), 'Crear libreta de direcciones · Propiedades', 'asegúrese de que la casilla Mostrar esta carpeta como una libreta de direcciones de correo electrónico esté seleccionada.', null, 'd889013569df2404268591ed8f9560dd3b7cc84d56ecb0b032da9353be02d269', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'd889013569df2404268591ed8f9560dd3b7cc84d56ecb0b032da9353be02d269')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Agregar esta carpeta a la lista global de direcciones.', false), ('B', 'Compartir esta carpeta con los destinatarios de CCO.', false), ('C', 'Mostrar esta carpeta como una libreta de direcciones de correo electrónico.', true), ('D', 'Sincronizar esta carpeta con la libreta de Exchange.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
-- Lote age-aux-b2-11-outlook-ms_outlook_menciones-v1 (1 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Microsoft Soporte · Usar @menciones para llamar la atención de un usuario en Outlook', 'https://support.microsoft.com/es-es/office/usar-mentions-para-llamar-la-atenci%C3%B3n-de-un-usuario-en-outlook-90701709-5dc1-41c7-aa48-b01d4a46e8c7', 'web_oficial'::public.source_kind, 'Microsoft (documentación oficial)', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('age-aux-b2-11-outlook', 'II.11 Correo electrónico: Outlook 365') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('auxiliar-administrativo-estado') and t.slug = 'age-aux-b2-11-outlook' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Al usar una @mención en el cuerpo de un mensaje de Outlook, ¿a qué línea se pide a Outlook que agregue a la persona mencionada?', 'Al mencionar a alguien con @, se resalta su nombre y se pide a Outlook que lo agregue a la línea Para.', 'age_aux_b2_11_outlook', (select id from public.topics where slug = 'age-aux-b2-11-outlook'), 2, 'es', true, (select id from public.sources where url = 'https://support.microsoft.com/es-es/office/usar-mentions-para-llamar-la-atenci%C3%B3n-de-un-usuario-en-outlook-90701709-5dc1-41c7-aa48-b01d4a46e8c7'), '@menciones · Línea Para', 'se pedirá a Outlook que lo agregue a la línea Para', null, '4a51816d1c01799dfbabd8bf3c8e72e54e16450f56777f028ab625e947dc1ac3', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '4a51816d1c01799dfbabd8bf3c8e72e54e16450f56777f028ab625e947dc1ac3')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'A la línea CC.', false), ('B', 'A la línea CCO.', false), ('C', 'A la línea Asunto.', false), ('D', 'A la línea Para.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
-- Lote age-aux-b2-11-outlook-ms_outlook_programar-v1 (2 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Microsoft Soporte · Retrasar o programar el envío de mensajes de correo electrónico', 'https://support.microsoft.com/es-es/office/retrasar-o-programar-el-env%C3%ADo-de-mensajes-de-correo-electr%C3%B3nico-026af69f-c287-490a-a72f-6c65793744ba', 'web_oficial'::public.source_kind, 'Microsoft (documentación oficial)', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('age-aux-b2-11-outlook', 'II.11 Correo electrónico: Outlook 365') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('auxiliar-administrativo-estado') and t.slug = 'age-aux-b2-11-outlook' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según Microsoft, ¿cómo puede retrasarse la entrega de un mensaje individual en Outlook?', 'Se puede retrasar la entrega de un mensaje individual manteniéndolo en la Bandeja de salida.', 'age_aux_b2_11_outlook', (select id from public.topics where slug = 'age-aux-b2-11-outlook'), 2, 'es', true, (select id from public.sources where url = 'https://support.microsoft.com/es-es/office/retrasar-o-programar-el-env%C3%ADo-de-mensajes-de-correo-electr%C3%B3nico-026af69f-c287-490a-a72f-6c65793744ba'), 'Retrasar la entrega · Bandeja de salida', 'Puede retrasar la entrega de un mensaje individual si lo mantiene en la Bandeja de salida', null, 'f7af5280de4ad12e4522d8f6b129c7ebf393c9c4141f0f995c00b1dd0aaf8e93', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'f7af5280de4ad12e4522d8f6b129c7ebf393c9c4141f0f995c00b1dd0aaf8e93')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Manteniéndolo en la Bandeja de salida.', true), ('B', 'Moviéndolo a la carpeta Elementos eliminados.', false), ('C', 'Guardándolo como plantilla de Outlook.', false), ('D', 'Enviándolo con la opción CCO.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Tras programar el envío de un mensaje y seleccionar Enviar, ¿dónde permanece el mensaje hasta la hora de entrega?', 'Después de seleccionar Enviar, el mensaje programado permanece en la carpeta Borrador hasta la hora de entrega.', 'age_aux_b2_11_outlook', (select id from public.topics where slug = 'age-aux-b2-11-outlook'), 3, 'es', true, (select id from public.sources where url = 'https://support.microsoft.com/es-es/office/retrasar-o-programar-el-env%C3%ADo-de-mensajes-de-correo-electr%C3%B3nico-026af69f-c287-490a-a72f-6c65793744ba'), 'Programar envío · Carpeta Borrador', 'Después de seleccionar Enviar, el mensaje permanece en la carpeta Borrador hasta la hora de entrega.', null, '6607efb59e15acf4d70eb904ef123a0f0d4e6e53bd9f7b076b1185f43c9d975f', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '6607efb59e15acf4d70eb904ef123a0f0d4e6e53bd9f7b076b1185f43c9d975f')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'En la Bandeja de entrada.', false), ('B', 'En la carpeta Elementos enviados.', false), ('C', 'En la carpeta Correo no deseado.', false), ('D', 'En la carpeta Borrador.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
-- Lote age-aux-b2-11-outlook-ms_outlook_recuperar-v1 (1 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Microsoft Soporte · Cómo recuperar un correo electrónico en Outlook', 'https://support.microsoft.com/es-es/outlook/mail/how-to-recall-an-email-in-outlook-requirements-limitations-steps', 'web_oficial'::public.source_kind, 'Microsoft (documentación oficial)', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('age-aux-b2-11-outlook', 'II.11 Correo electrónico: Outlook 365') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('auxiliar-administrativo-estado') and t.slug = 'age-aux-b2-11-outlook' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según Microsoft, la recuperación de un correo enviado con Outlook solo es posible si, entre otros requisitos:', 'La recuperación solo funciona si remitente y destinatario tienen cuenta profesional o educativa de Microsoft 365, en la misma organización, y el destinatario aún no ha abierto el mensaje.', 'age_aux_b2_11_outlook', (select id from public.topics where slug = 'age-aux-b2-11-outlook'), 3, 'es', true, (select id from public.sources where url = 'https://support.microsoft.com/es-es/outlook/mail/how-to-recall-an-email-in-outlook-requirements-limitations-steps'), 'Recuperar un mensaje · Requisitos', 'solo si tanto usted como el destinatario tienen una cuenta de correo electrónico profesional o educativa de Microsoft 365 […] en la misma organización […] el destinatario aún no ha abierto el mensaje', null, '24e080a66c1f6161bcc6498de60ac55b10e01a278191e06d826584b444f2ee09', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '24e080a66c1f6161bcc6498de60ac55b10e01a278191e06d826584b444f2ee09')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El destinatario tiene una cuenta de Outlook.com y aún no ha respondido al mensaje.', false), ('B', 'Remitente y destinatario están en la misma organización y el destinatario aún no ha abierto el mensaje.', true), ('C', 'El mensaje se envió con el campo CCO y tiene menos de 24 horas.', false), ('D', 'El destinatario está en otra organización pero usa también Microsoft 365.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
-- Lote age-aux-b2-11-outlook-ms_outlook_reglas-v1 (1 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Microsoft Soporte · Configurar reglas en Outlook', 'https://support.microsoft.com/es-es/office/configurar-reglas-en-outlook-75ab719a-2ce8-49a7-a214-6d62b67cbd41', 'web_oficial'::public.source_kind, 'Microsoft (documentación oficial)', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('age-aux-b2-11-outlook', 'II.11 Correo electrónico: Outlook 365') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('auxiliar-administrativo-estado') and t.slug = 'age-aux-b2-11-outlook' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según la advertencia de Microsoft sobre las reglas de Outlook:', 'Microsoft advierte de que algunas reglas solo se ejecutarán cuando Outlook esté activado; si aparece esa advertencia, se selecciona Aceptar.', 'age_aux_b2_11_outlook', (select id from public.topics where slug = 'age-aux-b2-11-outlook'), 2, 'es', true, (select id from public.sources where url = 'https://support.microsoft.com/es-es/office/configurar-reglas-en-outlook-75ab719a-2ce8-49a7-a214-6d62b67cbd41'), 'Reglas · Ejecución con Outlook activado', 'Algunas reglas solo se ejecutarán cuando Outlook esté activado.', null, '536f07ba434912e1d4f79806e7b59e282ca2919bc277caa11dd5ebaad0d57ff4', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '536f07ba434912e1d4f79806e7b59e282ca2919bc277caa11dd5ebaad0d57ff4')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Todas las reglas se ejecutan en el servidor aunque Outlook esté cerrado.', false), ('B', 'Las reglas solo se aplican a los mensajes ya leídos.', false), ('C', 'Algunas reglas solo se ejecutarán cuando Outlook esté activado.', true), ('D', 'Una regla no puede mover mensajes a otra carpeta.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
-- Lote age-aux-b2-11-outlook-ms_outlook_responder-v1 (1 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Microsoft Soporte · Responder o reenviar un mensaje de correo electrónico en Outlook clásico', 'https://support.microsoft.com/es-es/office/responder-o-reenviar-un-mensaje-de-correo-electr%C3%B3nico-a843f8d3-01b0-48da-96f5-a71f70d0d7c8', 'web_oficial'::public.source_kind, 'Microsoft (documentación oficial)', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('age-aux-b2-11-outlook', 'II.11 Correo electrónico: Outlook 365') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('auxiliar-administrativo-estado') and t.slug = 'age-aux-b2-11-outlook' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Al responder o reenviar un mensaje en Outlook, ¿cómo se quita un destinatario de los cuadros Para, CC o CCO?', 'En los cuadros Para, CC y CCO se pueden agregar o quitar destinatarios; para quitar uno, se selecciona el nombre y se presiona Eliminar.', 'age_aux_b2_11_outlook', (select id from public.topics where slug = 'age-aux-b2-11-outlook'), 1, 'es', true, (select id from public.sources where url = 'https://support.microsoft.com/es-es/office/responder-o-reenviar-un-mensaje-de-correo-electr%C3%B3nico-a843f8d3-01b0-48da-96f5-a71f70d0d7c8'), 'Responder o reenviar · Quitar un destinatario', 'En los cuadros Para, CC y CCO puede agregar o quitar destinatarios. […] Quitar un destinatario Seleccione el nombre y presione Eliminar.', null, '7eff9b1068d270805076aac86a3ef12070400493a6b69b9a6daa54d89001fac2', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '7eff9b1068d270805076aac86a3ef12070400493a6b69b9a6daa54d89001fac2')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Se hace doble clic en su nombre y se elige Bloquear remitente.', false), ('B', 'No se puede: solo pueden agregarse destinatarios.', false), ('C', 'Se arrastra su nombre al panel de carpetas.', false), ('D', 'Se selecciona su nombre y se presiona Eliminar.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
-- Lote age-aux-b2-11-outlook-ms_outlook_tareas-v1 (3 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Microsoft Soporte · Tareas básicas en Outlook', 'https://support.microsoft.com/es-es/outlook/basic-tasks-in-outlook', 'web_oficial'::public.source_kind, 'Microsoft (documentación oficial)', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('age-aux-b2-11-outlook', 'II.11 Correo electrónico: Outlook 365') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('auxiliar-administrativo-estado') and t.slug = 'age-aux-b2-11-outlook' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según Microsoft, ¿desde dónde pueden abrirse los datos adjuntos de un mensaje recibido en Outlook?', 'Los datos adjuntos pueden abrirse desde el panel de lectura o desde un mensaje abierto, haciendo doble clic en ellos.', 'age_aux_b2_11_outlook', (select id from public.topics where slug = 'age-aux-b2-11-outlook'), 1, 'es', true, (select id from public.sources where url = 'https://support.microsoft.com/es-es/outlook/basic-tasks-in-outlook'), 'Tareas básicas · Abrir datos adjuntos', 'Puede abrir datos adjuntos desde el panel de lectura o desde un mensaje abierto.', null, '885bfc46068424c160ffe40e222140e284d619a2aa5d7789df9fbd13e2073357', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '885bfc46068424c160ffe40e222140e284d619a2aa5d7789df9fbd13e2073357')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Solo desde un mensaje abierto en una ventana nueva.', false), ('B', 'Solo después de guardarlos en una carpeta del equipo.', false), ('C', 'Desde el panel de lectura o desde un mensaje abierto.', true), ('D', 'Solo desde el panel de carpetas.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Respecto a la barra de herramientas de acceso rápido de Outlook, señale la respuesta correcta:', 'El usuario controla qué botones aparecen en la barra de acceso rápido, que se suma a las pestañas y cintas estándar.', 'age_aux_b2_11_outlook', (select id from public.topics where slug = 'age-aux-b2-11-outlook'), 1, 'es', true, (select id from public.sources where url = 'https://support.microsoft.com/es-es/outlook/basic-tasks-in-outlook'), 'Tareas básicas · Barra de herramientas de acceso rápido', 'Puede controlar qué botones (o iconos) aparecen en la barra de acceso rápido', null, 'bc2c941de92efef931feff3123942863a281daeb691f507289c4a158a8b5594c', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'bc2c941de92efef931feff3123942863a281daeb691f507289c4a158a8b5594c')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El usuario puede controlar qué botones o iconos aparecen en ella.', true), ('B', 'Sustituye a las pestañas y cintas estándar.', false), ('C', 'Muestra siempre los mismos botones, que no pueden cambiarse.', false), ('D', 'Solo está disponible en la vista Calendario.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'En Outlook, ¿cómo se muestran los avisos para que no se pase una fecha límite importante?', 'Los avisos aparecen en una ventana de alerta para que no se pierda una fecha límite importante.', 'age_aux_b2_11_outlook', (select id from public.topics where slug = 'age-aux-b2-11-outlook'), 1, 'es', true, (select id from public.sources where url = 'https://support.microsoft.com/es-es/outlook/basic-tasks-in-outlook'), 'Tareas básicas · Avisos', 'Los avisos aparecen en una ventana de alerta para que no se pierda una fecha límite importante.', null, 'e97915bad04fcb5d94714bd92129510fe9c06d7565bdad188fbf912c53233ed5', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'e97915bad04fcb5d94714bd92129510fe9c06d7565bdad188fbf912c53233ed5')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Como un mensaje nuevo en la carpeta Elementos enviados.', false), ('B', 'En una ventana de alerta.', true), ('C', 'Solo en la barra de estado de Windows.', false), ('D', 'Como una tarea en la carpeta Borradores.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
-- Lote age-aux-b2-12-internet-incibe_glosario-v1 (2 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('INCIBE · Glosario de términos de ciberseguridad: una guía de aproximación para el empresario (2021)', 'https://www.incibe.es/sites/default/files/contenidos/guias/doc/guia_glosario_ciberseguridad_2021.pdf', 'web_oficial'::public.source_kind, 'Instituto Nacional de Ciberseguridad (INCIBE)', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('age-aux-b2-12-internet', 'II.12 La red Internet y los navegadores') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('auxiliar-administrativo-estado') and t.slug = 'age-aux-b2-12-internet' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el glosario de ciberseguridad del INCIBE, HTTPS es:', 'El INCIBE define HTTPS, dicho en otras palabras, como la versión segura de HTTP; la traducción de nombres es la función del DNS, la asignación de IP la hace DHCP y la extensión segura de una LAN es la VPN.', 'age_aux_b2_12_internet', (select id from public.topics where slug = 'age-aux-b2-12-internet'), 1, 'es', true, (select id from public.sources where url = 'https://www.incibe.es/sites/default/files/contenidos/guias/doc/guia_glosario_ciberseguridad_2021.pdf'), 'Glosario INCIBE · HTTPS', 'Dicho en otras palabras, es la versión segura de HTTP.', null, 'c0eafe89883105b51c9f7ea467e8b2ca3370f6ed6f79e62e332b354e3e8489dc', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'c0eafe89883105b51c9f7ea467e8b2ca3370f6ed6f79e62e332b354e3e8489dc')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El servicio que traduce nombres de dominio en direcciones IP.', false), ('B', 'El protocolo que asigna automáticamente la dirección IP a un equipo.', false), ('C', 'Una red privada virtual sobre Internet.', false), ('D', 'La versión segura de HTTP.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el INCIBE, el ataque informático que aprovecha una vulnerabilidad del software de los servidores DNS se denomina:', 'El pharming aprovecha una vulnerabilidad del software de los servidores DNS; el phishing suplanta a una entidad mediante correo o mensaje instantáneo.', 'age_aux_b2_12_internet', (select id from public.topics where slug = 'age-aux-b2-12-internet'), 2, 'es', true, (select id from public.sources where url = 'https://www.incibe.es/sites/default/files/contenidos/guias/doc/guia_glosario_ciberseguridad_2021.pdf'), 'Glosario INCIBE · Pharming', 'Ataque informático que aprovecha una vulnerabilidad del software de los servidores DNS', null, 'b4f6dc419f21b91c466145508cfc03d19aade8f7bf1fcf59bf47c6c29445c003', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'b4f6dc419f21b91c466145508cfc03d19aade8f7bf1fcf59bf47c6c29445c003')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Phishing.', false), ('B', 'Botnet.', false), ('C', 'Pharming.', true), ('D', 'Keylogger.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
-- Lote age-aux-b2-12-internet-ms_dhcp-v1 (1 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Microsoft Learn · Protocolo de configuración dinámica de host (DHCP)', 'https://learn.microsoft.com/es-es/windows-server/networking/technologies/dhcp/dhcp-top', 'web_oficial'::public.source_kind, 'Microsoft (documentación oficial)', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('age-aux-b2-12-internet', 'II.12 La red Internet y los navegadores') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('auxiliar-administrativo-estado') and t.slug = 'age-aux-b2-12-internet' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según Microsoft, ¿cuándo concede el servidor DHCP una dirección IP a un cliente habilitado para DHCP?', 'El servidor DHCP mantiene un grupo de direcciones IP y concede una a cualquier cliente habilitado para DHCP cuando se inicia en la red.', 'age_aux_b2_12_internet', (select id from public.topics where slug = 'age-aux-b2-12-internet'), 2, 'es', true, (select id from public.sources where url = 'https://learn.microsoft.com/es-es/windows-server/networking/technologies/dhcp/dhcp-top'), 'DHCP · Servidor', 'El servidor DHCP mantiene un grupo de direcciones IP y concede una dirección a cualquier cliente habilitado para DHCP cuando se inicia en la red.', null, '3870a8af6e62e3f19510dcab26acd5df5a0f06d3fd9fb8a76b27a3e454806f4c', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '3870a8af6e62e3f19510dcab26acd5df5a0f06d3fd9fb8a76b27a3e454806f4c')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Solo cuando el usuario la escribe a mano en la configuración.', false), ('B', 'Cuando el cliente se inicia en la red.', true), ('C', 'Cuando el cliente resuelve un nombre de dominio.', false), ('D', 'Solo cuando el cliente abre una conexión HTTPS.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
-- Lote age-aux-b2-12-internet-ms_dns-v1 (1 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Microsoft Learn · Sistema de nombres de dominio (DNS) en Windows y Windows Server', 'https://learn.microsoft.com/es-es/windows-server/networking/dns/dns-overview', 'web_oficial'::public.source_kind, 'Microsoft (documentación oficial)', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('age-aux-b2-12-internet', 'II.12 La red Internet y los navegadores') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('auxiliar-administrativo-estado') and t.slug = 'age-aux-b2-12-internet' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según la documentación de Microsoft sobre DNS en Windows y Windows Server, señale la respuesta correcta:', 'DNS es el servicio de resolución de nombres predeterminado en las redes de Windows; los controladores de dominio lo usan para localizarse entre sí, pertenece a la capa de aplicación y el cliente DNS se incluye en todas las versiones y se ejecuta de forma predeterminada.', 'age_aux_b2_12_internet', (select id from public.topics where slug = 'age-aux-b2-12-internet'), 3, 'es', true, (select id from public.sources where url = 'https://learn.microsoft.com/es-es/windows-server/networking/dns/dns-overview'), 'DNS · Controladores de dominio', 'Los controladores de dominio también usan DNS para localizarse entre sí.', null, 'a4116f4dc2d889778854ff52cdbceeb539cc60b89073cb1bbb2d8d395e1bf8f3', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'a4116f4dc2d889778854ff52cdbceeb539cc60b89073cb1bbb2d8d395e1bf8f3')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'DNS forma parte de la capa de transporte del modelo TCP/IP.', false), ('B', 'Los controladores de dominio también usan DNS para localizarse entre sí.', true), ('C', 'El servicio cliente DNS solo se incluye en las versiones de servidor de Windows.', false), ('D', 'El servicio cliente DNS debe iniciarse manualmente tras instalar el sistema.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
-- Lote age-aux-b2-12-internet-ms_edge_atajos-v1 (12 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Microsoft Soporte · Métodos abreviados de teclado en Microsoft Edge', 'https://support.microsoft.com/es-es/microsoft-edge/m%C3%A9todos-abreviados-de-teclado-en-microsoft-edge-50d3edab-30d9-c7e4-21ce-37fe2713cfad', 'web_oficial'::public.source_kind, 'Microsoft (documentación oficial)', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('age-aux-b2-12-internet', 'II.12 La red Internet y los navegadores') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('auxiliar-administrativo-estado') and t.slug = 'age-aux-b2-12-internet' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'En Microsoft Edge, ¿qué combinación de teclas abre una pestaña nueva y cambia a ella?', 'Ctrl + T abre una pestaña nueva y cambia a ella; Ctrl + N abre una ventana nueva, Ctrl + W cierra la pestaña actual y Ctrl + Mayús + T reabre la última pestaña cerrada.', 'age_aux_b2_12_internet', (select id from public.topics where slug = 'age-aux-b2-12-internet'), 1, 'es', true, (select id from public.sources where url = 'https://support.microsoft.com/es-es/microsoft-edge/m%C3%A9todos-abreviados-de-teclado-en-microsoft-edge-50d3edab-30d9-c7e4-21ce-37fe2713cfad'), 'Edge · Métodos abreviados · Nueva pestaña', 'Ctrl+T | Abrir una pestaña nueva y cambiar a ella', null, 'afe439d35a056a020953bf45fe4f583a5b35f4bcd32c89812f7fed543f305efa', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'afe439d35a056a020953bf45fe4f583a5b35f4bcd32c89812f7fed543f305efa')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Ctrl + N.', false), ('B', 'Ctrl + T.', true), ('C', 'Ctrl + W.', false), ('D', 'Ctrl + Mayús + T.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select '¿Qué hace la combinación Ctrl + W en Microsoft Edge?', 'Ctrl + W cierra la pestaña actual; Ctrl + N abre una ventana nueva, Ctrl + D guarda la pestaña como favorita y Ctrl + L selecciona la URL.', 'age_aux_b2_12_internet', (select id from public.topics where slug = 'age-aux-b2-12-internet'), 1, 'es', true, (select id from public.sources where url = 'https://support.microsoft.com/es-es/microsoft-edge/m%C3%A9todos-abreviados-de-teclado-en-microsoft-edge-50d3edab-30d9-c7e4-21ce-37fe2713cfad'), 'Edge · Métodos abreviados · Cerrar pestaña', 'Ctrl+W | Cerrar la pestaña actual', null, 'c8e60ce55a67561fff4ff532c919e53334932a883c5404a4063f2bd749f7b688', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'c8e60ce55a67561fff4ff532c919e53334932a883c5404a4063f2bd749f7b688')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Cierra la pestaña actual.', true), ('B', 'Abre una nueva ventana.', false), ('C', 'Guarda la pestaña actual como favorita.', false), ('D', 'Selecciona la URL de la barra de direcciones.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'En Microsoft Edge, para buscar una palabra dentro de la página que se está viendo se pulsa:', 'Ctrl + F abre la búsqueda en la página; Ctrl + E abre una consulta de búsqueda en la barra de direcciones, Ctrl + H el historial y Ctrl + Mayús + E la búsqueda en la barra lateral.', 'age_aux_b2_12_internet', (select id from public.topics where slug = 'age-aux-b2-12-internet'), 1, 'es', true, (select id from public.sources where url = 'https://support.microsoft.com/es-es/microsoft-edge/m%C3%A9todos-abreviados-de-teclado-en-microsoft-edge-50d3edab-30d9-c7e4-21ce-37fe2713cfad'), 'Edge · Métodos abreviados · Buscar en la página', 'Ctrl+F | Abrir búsqueda en la página', null, '1a1587a523b01924cd53ac3f7851e6455ab7d47057fb9a1d412fd14c2f41cd45', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '1a1587a523b01924cd53ac3f7851e6455ab7d47057fb9a1d412fd14c2f41cd45')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Ctrl + E.', false), ('B', 'Ctrl + H.', false), ('C', 'Ctrl + Mayús + E.', false), ('D', 'Ctrl + F.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select '¿Qué método abreviado imprime la página actual en Microsoft Edge?', 'Ctrl + P imprime la página actual; Ctrl + U muestra el origen, Ctrl + J abre Descargas y F12 abre las Herramientas de desarrollo.', 'age_aux_b2_12_internet', (select id from public.topics where slug = 'age-aux-b2-12-internet'), 1, 'es', true, (select id from public.sources where url = 'https://support.microsoft.com/es-es/microsoft-edge/m%C3%A9todos-abreviados-de-teclado-en-microsoft-edge-50d3edab-30d9-c7e4-21ce-37fe2713cfad'), 'Edge · Métodos abreviados · Imprimir', 'Ctrl+P | Imprimir la página actual', null, '470ab305c7f5873f5931611dcc3cfdd5270e0ca70c38cbaf07559f6ddecde927', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '470ab305c7f5873f5931611dcc3cfdd5270e0ca70c38cbaf07559f6ddecde927')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Ctrl + U.', false), ('B', 'Ctrl + J.', false), ('C', 'Ctrl + P.', true), ('D', 'F12.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'En Microsoft Edge, ¿qué combinación restablece el nivel de zoom de la página?', 'Ctrl + 0 restablece el zoom; Ctrl + + acerca, Ctrl + - aleja y Ctrl + 9 pasa a la última pestaña.', 'age_aux_b2_12_internet', (select id from public.topics where slug = 'age-aux-b2-12-internet'), 1, 'es', true, (select id from public.sources where url = 'https://support.microsoft.com/es-es/microsoft-edge/m%C3%A9todos-abreviados-de-teclado-en-microsoft-edge-50d3edab-30d9-c7e4-21ce-37fe2713cfad'), 'Edge · Métodos abreviados · Zoom', 'Ctrl+0 | Restablecer nivel de zoom de página', null, '90fdef9c0cc0f52f4aa3c4a05a1f577d8d3188e9d032b9cc485feac55c38a9f4', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '90fdef9c0cc0f52f4aa3c4a05a1f577d8d3188e9d032b9cc485feac55c38a9f4')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Ctrl + 9.', false), ('B', 'Ctrl + 0.', true), ('C', 'Ctrl + signo menos (-).', false), ('D', 'Ctrl + signo más (+).', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'En Microsoft Edge, ¿qué combinación selecciona la URL de la barra de direcciones para editarla?', 'Ctrl + L selecciona la URL de la barra de direcciones; Ctrl + K abre una consulta de búsqueda en ella, Ctrl + U muestra el origen y F6 cambia el foco al siguiente panel.', 'age_aux_b2_12_internet', (select id from public.topics where slug = 'age-aux-b2-12-internet'), 2, 'es', true, (select id from public.sources where url = 'https://support.microsoft.com/es-es/microsoft-edge/m%C3%A9todos-abreviados-de-teclado-en-microsoft-edge-50d3edab-30d9-c7e4-21ce-37fe2713cfad'), 'Edge · Métodos abreviados · Barra de direcciones', 'Ctrl+L | Seleccionar la URL de la barra de direcciones para editarla', null, '801ed093c294e0c2a1a817cec50a88dfa0724d1ceefeda734e1fd9b4298949f6', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '801ed093c294e0c2a1a817cec50a88dfa0724d1ceefeda734e1fd9b4298949f6')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Ctrl + K.', false), ('B', 'Ctrl + L.', true), ('C', 'Ctrl + U.', false), ('D', 'F6.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select '¿Qué método abreviado muestra u oculta la barra de favoritos en Microsoft Edge?', 'Ctrl + Mayús + B muestra u oculta la barra de favoritos; Ctrl + Mayús + O abre Favoritos, Ctrl + Mayús + Y abre Colecciones y Ctrl + Mayús + U inicia o detiene la lectura en voz alta.', 'age_aux_b2_12_internet', (select id from public.topics where slug = 'age-aux-b2-12-internet'), 2, 'es', true, (select id from public.sources where url = 'https://support.microsoft.com/es-es/microsoft-edge/m%C3%A9todos-abreviados-de-teclado-en-microsoft-edge-50d3edab-30d9-c7e4-21ce-37fe2713cfad'), 'Edge · Métodos abreviados · Barra de favoritos', 'Ctrl+Mayús+B | Mostrar u ocultar la barra de favoritos', null, 'd84dd7b3773e8ea50b5743b0dab79e180f0452151da9d272d010a388352dda0c', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'd84dd7b3773e8ea50b5743b0dab79e180f0452151da9d272d010a388352dda0c')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Ctrl + Mayús + B.', true), ('B', 'Ctrl + Mayús + O.', false), ('C', 'Ctrl + Mayús + Y.', false), ('D', 'Ctrl + Mayús + U.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'En Microsoft Edge, la tecla F12:', 'F12 abre las Herramientas de desarrollo; F11 alterna la pantalla completa, F5 recarga la pestaña y F7 activa la exploración mediante el símbolo de intercalación.', 'age_aux_b2_12_internet', (select id from public.topics where slug = 'age-aux-b2-12-internet'), 2, 'es', true, (select id from public.sources where url = 'https://support.microsoft.com/es-es/microsoft-edge/m%C3%A9todos-abreviados-de-teclado-en-microsoft-edge-50d3edab-30d9-c7e4-21ce-37fe2713cfad'), 'Edge · Métodos abreviados · Herramientas de desarrollo', 'F12 | Abrir Herramientas de desarrollo', null, '30ac357a6312c54149f59cab6bb7732ee8947ea9b3bd4d287b59099f6ef54eed', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '30ac357a6312c54149f59cab6bb7732ee8947ea9b3bd4d287b59099f6ef54eed')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Activa o desactiva la pantalla completa.', false), ('B', 'Vuelve a cargar la pestaña actual.', false), ('C', 'Activa la exploración mediante el símbolo de intercalación.', false), ('D', 'Abre las Herramientas de desarrollo.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select '¿Qué combinación permite volver a la página anterior en Microsoft Edge?', 'Alt + Flecha izquierda vuelve atrás; Alt + Inicio abre la página principal en la pestaña actual y Alt + F abre el menú Configuración y más.', 'age_aux_b2_12_internet', (select id from public.topics where slug = 'age-aux-b2-12-internet'), 2, 'es', true, (select id from public.sources where url = 'https://support.microsoft.com/es-es/microsoft-edge/m%C3%A9todos-abreviados-de-teclado-en-microsoft-edge-50d3edab-30d9-c7e4-21ce-37fe2713cfad'), 'Edge · Métodos abreviados · Volver atrás', 'Alt (en inglés)+Flecha izquierda | Volver atrás', null, '1818dd11c1456658639dc5b7989cc73c6180c8190df9931c35a244d80b87f172', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '1818dd11c1456658639dc5b7989cc73c6180c8190df9931c35a244d80b87f172')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Alt + Inicio.', false), ('B', 'Ctrl + Flecha izquierda.', false), ('C', 'Alt + Flecha izquierda.', true), ('D', 'Alt + F.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'En Microsoft Edge, ¿qué combinación vuelve a cargar la página actual omitiendo el contenido en caché?', 'Ctrl + Mayús + R recarga omitiendo la caché; F5 recarga la pestaña de forma normal, Ctrl + Mayús + T reabre la última pestaña cerrada y Ctrl + Mayús + Supr abre las opciones de borrar los datos de exploración.', 'age_aux_b2_12_internet', (select id from public.topics where slug = 'age-aux-b2-12-internet'), 3, 'es', true, (select id from public.sources where url = 'https://support.microsoft.com/es-es/microsoft-edge/m%C3%A9todos-abreviados-de-teclado-en-microsoft-edge-50d3edab-30d9-c7e4-21ce-37fe2713cfad'), 'Edge · Métodos abreviados · Omitir caché', 'Ctrl+Mayús+R | Volver a cargar la página actual y omitir el contenido en caché', null, '18471b1f3cd0d9068db8ffe544f919567b17cbce466b57188d7fbc0853766377', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '18471b1f3cd0d9068db8ffe544f919567b17cbce466b57188d7fbc0853766377')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Ctrl + Mayús + R.', true), ('B', 'F5.', false), ('C', 'Ctrl + Mayús + T.', false), ('D', 'Ctrl + Mayús + Supr.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select '¿Qué tecla activa o desactiva en Microsoft Edge la exploración mediante el símbolo de intercalación?', 'F7 activa o desactiva la exploración mediante el símbolo de intercalación; F6 cambia el foco al siguiente panel, F11 alterna la pantalla completa y F12 abre las Herramientas de desarrollo.', 'age_aux_b2_12_internet', (select id from public.topics where slug = 'age-aux-b2-12-internet'), 3, 'es', true, (select id from public.sources where url = 'https://support.microsoft.com/es-es/microsoft-edge/m%C3%A9todos-abreviados-de-teclado-en-microsoft-edge-50d3edab-30d9-c7e4-21ce-37fe2713cfad'), 'Edge · Métodos abreviados · Exploración con símbolo de intercalación', 'F7 | Activar o desactivar la exploración mediante el símbolo de intercalación', null, '7a21dedcc854f963604444a3366093d41808ccfe6ecc0a33424f02e521fade7a', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '7a21dedcc854f963604444a3366093d41808ccfe6ecc0a33424f02e521fade7a')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'F6.', false), ('B', 'F11.', false), ('C', 'F12.', false), ('D', 'F7.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'En Microsoft Edge, con diez pestañas abiertas, ¿qué combinación pasa directamente a la última pestaña?', 'Ctrl + 9 pasa a la última pestaña; Ctrl + 1 a Ctrl + 8 pasan a una pestaña específica, Ctrl + Tab cambia a la siguiente y Ctrl + 0 restablece el zoom.', 'age_aux_b2_12_internet', (select id from public.topics where slug = 'age-aux-b2-12-internet'), 3, 'es', true, (select id from public.sources where url = 'https://support.microsoft.com/es-es/microsoft-edge/m%C3%A9todos-abreviados-de-teclado-en-microsoft-edge-50d3edab-30d9-c7e4-21ce-37fe2713cfad'), 'Edge · Métodos abreviados · Última pestaña', 'Ctrl+1, 2, ... 8 | Pasar a una pestaña específica […] Ctrl+9 | Pasar a la última pestaña', null, '7839b426429555ebcc93be8f13042ca72beaf9a59cf0beb54842062ab8a48f12', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '7839b426429555ebcc93be8f13042ca72beaf9a59cf0beb54842062ab8a48f12')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Ctrl + 9.', true), ('B', 'Ctrl + 0.', false), ('C', 'Ctrl + 8.', false), ('D', 'Ctrl + Tab.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
-- Lote age-aux-b2-12-internet-ms_edge_inprivate-v1 (1 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Microsoft Soporte · Explorar InPrivate en Microsoft Edge', 'https://support.microsoft.com/es-es/edge/browse-inprivate-in-microsoft-edge', 'web_oficial'::public.source_kind, 'Microsoft (documentación oficial)', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('age-aux-b2-12-internet', 'II.12 La red Internet y los navegadores') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('auxiliar-administrativo-estado') and t.slug = 'age-aux-b2-12-internet' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Sin usar el teclado, ¿cómo se abre una ventana InPrivate en Microsoft Edge?', 'En Edge se selecciona el icono Configuración y más y, después, la ventana Nuevo InPrivate (con el teclado, Ctrl + Mayús + N).', 'age_aux_b2_12_internet', (select id from public.topics where slug = 'age-aux-b2-12-internet'), 2, 'es', true, (select id from public.sources where url = 'https://support.microsoft.com/es-es/edge/browse-inprivate-in-microsoft-edge'), 'Edge · InPrivate · Abrir con el ratón', 'En Microsoft Edge, seleccione el icono Configuración y más […] y, después, la ventana Nuevo InPrivate.', null, '4bf76c6539b620096a9aabf9e8f78ba0959c6717a520aa07e3122c317776862f', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '4bf76c6539b620096a9aabf9e8f78ba0959c6717a520aa07e3122c317776862f')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Desde el icono del candado de la barra de direcciones.', false), ('B', 'Desde el menú Historial, seleccionando Borrar datos de exploración.', false), ('C', 'Desde la barra de favoritos, seleccionando Colecciones.', false), ('D', 'Desde el icono Configuración y más, seleccionando la ventana Nuevo InPrivate.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
-- Lote age-aux-b2-12-internet-ms_edge_seguridad-v1 (3 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Microsoft Soporte · Explorar la Web de forma segura en Microsoft Edge', 'https://support.microsoft.com/es-es/edge/securely-browse-the-web-in-microsoft-edge', 'web_oficial'::public.source_kind, 'Microsoft (documentación oficial)', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('age-aux-b2-12-internet', 'II.12 La red Internet y los navegadores') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('auxiliar-administrativo-estado') and t.slug = 'age-aux-b2-12-internet' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según Microsoft, para reducir el riesgo de malware al descargar archivos de Internet con Edge, se recomienda:', 'Microsoft recomienda descargar solo de sitios y fuentes de confianza y, antes de abrir lo descargado, comprobar su integridad con un antivirus o un servicio en línea.', 'age_aux_b2_12_internet', (select id from public.topics where slug = 'age-aux-b2-12-internet'), 1, 'es', true, (select id from public.sources where url = 'https://support.microsoft.com/es-es/edge/securely-browse-the-web-in-microsoft-edge'), 'Edge · Descargas seguras', 'descarga solo archivos de sitios web y fuentes de confianza.', null, 'e60a671a72ee0c921af91046a9cd3b1fd33580aee57ab8eec2bb638118112b43', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'e60a671a72ee0c921af91046a9cd3b1fd33580aee57ab8eec2bb638118112b43')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Descargar solo archivos de sitios web y fuentes de confianza.', true), ('B', 'Abrir los archivos descargados antes de analizarlos, para comprobar que funcionan.', false), ('C', 'Descargar los archivos siempre en una ventana InPrivate.', false), ('D', 'Desactivar SmartScreen de Microsoft Defender durante la descarga.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según Microsoft, el icono que muestra Edge en la barra de direcciones mientras se navega sirve para:', 'El icono de la barra de direcciones indica la seguridad de la conexión y ayuda a determinar si se puede enviar y recibir información del sitio de forma segura.', 'age_aux_b2_12_internet', (select id from public.topics where slug = 'age-aux-b2-12-internet'), 2, 'es', true, (select id from public.sources where url = 'https://support.microsoft.com/es-es/edge/securely-browse-the-web-in-microsoft-edge'), 'Edge · Seguridad de la conexión', 'Mientras navega por la Web, verá un icono en la barra de direcciones que indica la seguridad de la conexión', null, '108be610bd301d4ef0bd216e02cf2eefb4ac272010ad18190c14dc69baffc1db', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '108be610bd301d4ef0bd216e02cf2eefb4ac272010ad18190c14dc69baffc1db')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Indicar el nivel de prevención de seguimiento elegido.', false), ('B', 'Mostrar que la ventana es InPrivate.', false), ('C', 'Abrir las opciones de borrar los datos de exploración.', false), ('D', 'Indicar la seguridad de la conexión con el sitio.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select '¿Dónde se comprueba en Microsoft Edge que la opción de actualizaciones automáticas está habilitada?', 'Para recibir automáticamente las correcciones de seguridad, se selecciona Acerca de Microsoft Edge y se comprueba que las actualizaciones automáticas están habilitadas.', 'age_aux_b2_12_internet', (select id from public.topics where slug = 'age-aux-b2-12-internet'), 2, 'es', true, (select id from public.sources where url = 'https://support.microsoft.com/es-es/edge/securely-browse-the-web-in-microsoft-edge'), 'Edge · Actualizaciones', 'Seleccione Acerca de Microsoft Edge y asegúrese de que la opción de actualizaciones automáticas está habilitada.', null, '2c2dc38a9653936693aa2061a6f36cd7ff806ccc83bc3285fa73a5d43c8e21cd', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '2c2dc38a9653936693aa2061a6f36cd7ff806ccc83bc3285fa73a5d43c8e21cd')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'En la ventana Nuevo InPrivate.', false), ('B', 'En las Herramientas de desarrollo.', false), ('C', 'En Acerca de Microsoft Edge.', true), ('D', 'En el panel de Colecciones.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
-- Lote age-aux-b2-12-internet-ms_http-v1 (2 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Microsoft Learn · Introducción a HTTP', 'https://learn.microsoft.com/es-es/xandr/industry-reference/intro-to-http', 'web_oficial'::public.source_kind, 'Microsoft (documentación oficial)', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('age-aux-b2-12-internet', 'II.12 La red Internet y los navegadores') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('auxiliar-administrativo-estado') and t.slug = 'age-aux-b2-12-internet' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Si en una dirección URL no aparece el número de puerto:', 'Según Microsoft, si el puerto no aparece en la lista, se usa el puerto predeterminado para el esquema.', 'age_aux_b2_12_internet', (select id from public.topics where slug = 'age-aux-b2-12-internet'), 2, 'es', true, (select id from public.sources where url = 'https://learn.microsoft.com/es-es/xandr/industry-reference/intro-to-http'), 'HTTP · Puerto predeterminado', 'Si el puerto no aparece en la lista, se usa el puerto predeterminado para el esquema.', null, 'a36cbcaac018194351bef133a4abc3811d776be018d15126154a65b11f8033ff', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'a36cbcaac018194351bef133a4abc3811d776be018d15126154a65b11f8033ff')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Se usa el puerto predeterminado para el esquema.', true), ('B', 'El explorador no puede enviar la solicitud.', false), ('C', 'El servidor asigna un puerto aleatorio.', false), ('D', 'Se usa el puerto indicado en la cadena de consulta.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'En una dirección URL, ¿qué parte indica al servidor en qué tipo de recurso está buscando el cliente?', 'Según Microsoft, el esquema indica al servidor en qué tipo de recurso está buscando el cliente (el explorador); la cadena de consulta se separa con «?» y, si el puerto no aparece, se usa el predeterminado del esquema.', 'age_aux_b2_12_internet', (select id from public.topics where slug = 'age-aux-b2-12-internet'), 3, 'es', true, (select id from public.sources where url = 'https://learn.microsoft.com/es-es/xandr/industry-reference/intro-to-http'), 'HTTP · Esquema', 'El esquema indica al servidor en qué tipo de recurso está buscando el cliente (el explorador).', null, '57f39cfac90fada4ee26eae5148894242084988f91cab68e33903d459800a8a3', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '57f39cfac90fada4ee26eae5148894242084988f91cab68e33903d459800a8a3')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'La cadena de consulta.', false), ('B', 'El puerto.', false), ('C', 'El esquema.', true), ('D', 'El nombre de dominio.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
-- Lote age-aux-b2-12-internet-ms_tls-v1 (1 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Microsoft Learn · Cómo usa Exchange Online TLS para proteger las conexiones de correo', 'https://learn.microsoft.com/es-es/purview/exchange-online-uses-tls-to-secure-email-connections', 'web_oficial'::public.source_kind, 'Microsoft (documentación oficial)', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('age-aux-b2-12-internet', 'II.12 La red Internet y los navegadores') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('auxiliar-administrativo-estado') and t.slug = 'age-aux-b2-12-internet' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según Microsoft, ¿qué protocolo criptográfico es el antecesor de TLS (seguridad de la capa de transporte)?', 'TLS y la capa de sockets seguros (SSL), anterior a TLS, son protocolos criptográficos; DHCP, DNS y HTTP no lo son.', 'age_aux_b2_12_internet', (select id from public.topics where slug = 'age-aux-b2-12-internet'), 2, 'es', true, (select id from public.sources where url = 'https://learn.microsoft.com/es-es/purview/exchange-online-uses-tls-to-secure-email-connections'), 'TLS · SSL', 'La seguridad de la capa de transporte (TLS) y la capa de sockets seguros (SSL) anteriores a TLS son protocolos criptográficos.', null, '6573ca977a94f6288abf5bbb9456abcc33b59bf96784245a5e4d08c33bdb8aca', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '6573ca977a94f6288abf5bbb9456abcc33b59bf96784245a5e4d08c33bdb8aca')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'DHCP (protocolo de configuración dinámica de host).', false), ('B', 'SSL (capa de sockets seguros).', true), ('C', 'DNS (sistema de nombres de dominio).', false), ('D', 'HTTP (protocolo de transferencia de hipertexto).', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('auxiliar-administrativo-estado');
commit;
