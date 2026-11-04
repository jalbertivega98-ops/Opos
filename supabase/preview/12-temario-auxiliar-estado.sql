-- Auxiliar Administrativo del Estado · Bloque I: 290 preguntas en BORRADOR con cita literal del BOE.
-- Generado: for f in content/auxiliar-estado/*.json; do node scripts/content/to-sql.mjs $f; done. Idempotente.
begin;
-- Lote age-aux-b1-01-constitucion-ce-v1 (20 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Constitución Española (texto consolidado, BOE)', 'https://www.boe.es/buscar/act.php?id=BOE-A-1978-31229', 'boe'::public.source_kind, 'Agencia Estatal Boletín Oficial del Estado', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('age-aux-b1-01-constitucion', 'I.1 La Constitución Española de 1978: principios, valores, derechos y deberes') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug = 'auxiliar-administrativo-estado' and t.slug = 'age-aux-b1-01-constitucion' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 1.1 de la Constitución Española, ¿cuáles son los valores superiores del ordenamiento jurídico?', 'El art. 1.1 CE enumera cuatro valores superiores: libertad, justicia, igualdad y pluralismo político. La solidaridad aparece en el art. 2 y la dignidad de la persona en el art. 10.1, pero no como valores superiores.', 'age_aux_b1_01_constitucion', (select id from public.topics where slug = 'age-aux-b1-01-constitucion'), 1, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1978-31229'), 'Art. 1.1 CE', 'España se constituye en un Estado social y democrático de Derecho, que propugna como valores superiores de su ordenamiento jurídico la libertad, la justicia, la igualdad y el pluralismo político.', null, '8d64f0e33e787a2a5d1e8f8f1f754d444a37cbec6a0d2f4d99e6a52fd4f7bd12', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '8d64f0e33e787a2a5d1e8f8f1f754d444a37cbec6a0d2f4d99e6a52fd4f7bd12')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'La libertad, la justicia, la igualdad y la solidaridad.', false), ('B', 'La libertad, la seguridad, la igualdad y el pluralismo político.', false), ('C', 'La libertad, la justicia, la igualdad y el pluralismo político.', true), ('D', 'La dignidad, la justicia, la igualdad y el pluralismo político.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'De acuerdo con la Constitución Española, ¿cuál es la forma política del Estado español?', 'El art. 1.3 CE dispone que la forma política del Estado español es la Monarquía parlamentaria. El carácter hereditario se refiere a la Corona (art. 57.1), no a la forma política del Estado.', 'age_aux_b1_01_constitucion', (select id from public.topics where slug = 'age-aux-b1-01-constitucion'), 1, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1978-31229'), 'Art. 1.3 CE', 'La forma política del Estado español es la Monarquía parlamentaria.', null, '3abb7bbda71187f62cd9b4970d4eba5e8d0c6a1b524eb0b7f3c72fc764662331', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '3abb7bbda71187f62cd9b4970d4eba5e8d0c6a1b524eb0b7f3c72fc764662331')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'La Monarquía constitucional.', false), ('B', 'La Monarquía parlamentaria.', true), ('C', 'La Monarquía hereditaria.', false), ('D', 'El Estado autonómico.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 3.1 de la Constitución, respecto del castellano, todos los españoles tienen:', 'El art. 3.1 CE configura el castellano como lengua española oficial del Estado y establece para todos los españoles el deber de conocerla y el derecho a usarla.', 'age_aux_b1_01_constitucion', (select id from public.topics where slug = 'age-aux-b1-01-constitucion'), 1, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1978-31229'), 'Art. 3.1 CE', 'El castellano es la lengua española oficial del Estado. Todos los españoles tienen el deber de conocerla y el derecho a usarla.', null, 'd2bf91f17ac439169801fbe8c0304f78d0aa711bdbeb18719c53dbf5a0e3bc16', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'd2bf91f17ac439169801fbe8c0304f78d0aa711bdbeb18719c53dbf5a0e3bc16')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El deber de conocerlo y el derecho a usarlo.', true), ('B', 'El derecho a conocerlo y el deber de usarlo.', false), ('C', 'El deber de conocerlo y el deber de usarlo.', false), ('D', 'El derecho a conocerlo y a usarlo, sin deber alguno.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 6 de la Constitución Española, los partidos políticos:', 'El art. 6 CE dice que los partidos expresan el pluralismo político, concurren a la formación y manifestación de la voluntad popular y son instrumento fundamental para la participación política; su creación es libre. La defensa de intereses económicos y sociales corresponde a sindicatos y asociaciones empresariales (art. 7) y la garantía del ordenamiento constitucional a las Fuerzas Armadas (art. 8).', 'age_aux_b1_01_constitucion', (select id from public.topics where slug = 'age-aux-b1-01-constitucion'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1978-31229'), 'Art. 6 CE', 'Los partidos políticos expresan el pluralismo político, concurren a la formación y manifestación de la voluntad popular y son instrumento fundamental para la participación política. Su creación y el ejercicio de su actividad son libres dentro del respeto a la Constitución y a la ley.', null, '0744d429757f06da75902562e317a76b5721bc0419c1f6889264e328eb4db27e', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '0744d429757f06da75902562e317a76b5721bc0419c1f6889264e328eb4db27e')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Contribuyen a la defensa y promoción de los intereses económicos y sociales que les son propios.', false), ('B', 'Tienen como misión garantizar el ordenamiento constitucional.', false), ('C', 'Requieren autorización previa para su creación.', false), ('D', 'Expresan el pluralismo político y son instrumento fundamental para la participación política.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select '¿Cuál de los siguientes principios garantiza expresamente el artículo 9.3 de la Constitución?', 'El art. 9.3 CE garantiza la legalidad, la jerarquía normativa, la publicidad de las normas, la irretroactividad de las disposiciones sancionadoras no favorables o restrictivas de derechos individuales, la seguridad jurídica, la responsabilidad y la interdicción de la arbitrariedad. La irretroactividad no se predica de todas las normas.', 'age_aux_b1_01_constitucion', (select id from public.topics where slug = 'age-aux-b1-01-constitucion'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1978-31229'), 'Art. 9.3 CE', 'La Constitución garantiza el principio de legalidad, la jerarquía normativa, la publicidad de las normas, la irretroactividad de las disposiciones sancionadoras no favorables o restrictivas de derechos individuales, la seguridad jurídica, la responsabilidad y la interdicción de la arbitrariedad de los poderes públicos.', null, '2aad904a43a9b2f15adc0453413c9cbc7ec351fb42fbc013a79496fec98de031', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '2aad904a43a9b2f15adc0453413c9cbc7ec351fb42fbc013a79496fec98de031')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'La irretroactividad de todas las disposiciones normativas.', false), ('B', 'La interdicción de la arbitrariedad de los poderes públicos.', true), ('C', 'La primacía del Derecho internacional sobre la ley.', false), ('D', 'La reserva de ley en materia tributaria.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 10.2 de la Constitución, las normas relativas a los derechos fundamentales y a las libertades que la Constitución reconoce se interpretarán de conformidad con:', 'El art. 10.2 CE impone interpretar los derechos fundamentales de conformidad con la Declaración Universal de Derechos Humanos y con los tratados y acuerdos internacionales sobre las mismas materias ratificados por España.', 'age_aux_b1_01_constitucion', (select id from public.topics where slug = 'age-aux-b1-01-constitucion'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1978-31229'), 'Art. 10.2 CE', 'Las normas relativas a los derechos fundamentales y a las libertades que la Constitución reconoce se interpretarán de conformidad con la Declaración Universal de Derechos Humanos y los tratados y acuerdos internacionales sobre las mismas materias ratificados por España.', null, 'f6fc5607a53998aa6323d3e51af85040ad63525ecc34c5086db2d123784d2103', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'f6fc5607a53998aa6323d3e51af85040ad63525ecc34c5086db2d123784d2103')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'La jurisprudencia del Tribunal Supremo y los tratados internacionales ratificados por España.', false), ('B', 'Las leyes orgánicas que los desarrollen y los Reglamentos de las Cámaras.', false), ('C', 'La Declaración Universal de Derechos Humanos y los tratados y acuerdos internacionales sobre las mismas materias ratificados por España.', true), ('D', 'La Carta de las Naciones Unidas y la costumbre internacional.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Respecto de los españoles de origen, la Constitución Española establece que:', 'El art. 11.2 CE dispone que ningún español de origen podrá ser privado de su nacionalidad. Además, el art. 11.3 permite a los españoles naturalizarse en países iberoamericanos sin perder su nacionalidad de origen.', 'age_aux_b1_01_constitucion', (select id from public.topics where slug = 'age-aux-b1-01-constitucion'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1978-31229'), 'Art. 11.2 CE', 'Ningún español de origen podrá ser privado de su nacionalidad.', null, '66b7d9c73e48150a3fac0668f444ca21c6c9653852ab51a41c64a36b7405c7e3', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '66b7d9c73e48150a3fac0668f444ca21c6c9653852ab51a41c64a36b7405c7e3')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Sólo podrán ser privados de su nacionalidad por resolución judicial firme.', false), ('B', 'Perderán su nacionalidad si se naturalizan en un país iberoamericano.', false), ('C', 'Sólo podrán ser privados de su nacionalidad en virtud de ley orgánica.', false), ('D', 'Ninguno podrá ser privado de su nacionalidad.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según la Constitución Española, ¿a qué edad son mayores de edad los españoles?', 'El art. 12 CE fija la mayoría de edad de los españoles en los dieciocho años.', 'age_aux_b1_01_constitucion', (select id from public.topics where slug = 'age-aux-b1-01-constitucion'), 1, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1978-31229'), 'Art. 12 CE', 'Los españoles son mayores de edad a los dieciocho años.', null, '76cd8021192e0efff621fb4068fc7eebb9be80c545704621c7aa3457df409aba', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '76cd8021192e0efff621fb4068fc7eebb9be80c545704621c7aa3457df409aba')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'A los dieciocho años.', true), ('B', 'A los dieciséis años.', false), ('C', 'A los veintiún años.', false), ('D', 'A los catorce años.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 13.2 de la Constitución, atendiendo a criterios de reciprocidad, podrá establecerse por tratado o ley que los extranjeros sean titulares del derecho de:', 'Los derechos del art. 23 corresponden solo a los españoles, salvo lo que, con criterios de reciprocidad, pueda establecerse por tratado o ley para el sufragio activo y pasivo en las elecciones municipales (redacción dada por la reforma de 1992).', 'age_aux_b1_01_constitucion', (select id from public.topics where slug = 'age-aux-b1-01-constitucion'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1978-31229'), 'Art. 13.2 CE', 'Solamente los españoles serán titulares de los derechos reconocidos en el artículo 23, salvo lo que, atendiendo a criterios de reciprocidad, pueda establecerse por tratado o ley para el derecho de sufragio activo y pasivo en las elecciones municipales.', null, '96140474e0e05dc408a3fb7a698d4eb29a11658f9d9ab166a88b5a0437364080', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '96140474e0e05dc408a3fb7a698d4eb29a11658f9d9ab166a88b5a0437364080')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Sufragio activo, pero no pasivo, en las elecciones municipales.', false), ('B', 'Sufragio activo y pasivo en las elecciones municipales.', true), ('C', 'Sufragio activo y pasivo en las elecciones autonómicas y municipales.', false), ('D', 'Sufragio activo en las elecciones generales.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 17.2 de la Constitución, ¿cuál es el plazo máximo en que el detenido deberá ser puesto en libertad o a disposición de la autoridad judicial?', 'La detención preventiva no puede durar más del tiempo estrictamente necesario y, en todo caso, el plazo máximo es de setenta y dos horas (art. 17.2 CE).', 'age_aux_b1_01_constitucion', (select id from public.topics where slug = 'age-aux-b1-01-constitucion'), 1, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1978-31229'), 'Art. 17.2 CE', 'en todo caso, en el plazo máximo de setenta y dos horas, el detenido deberá ser puesto en libertad o a disposición de la autoridad judicial.', null, '49a8e9286f23b867e4865a25fa72591e9c47a42177045f7f75f54272d4f94a4a', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '49a8e9286f23b867e4865a25fa72591e9c47a42177045f7f75f54272d4f94a4a')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Cuarenta y ocho horas.', false), ('B', 'Veinticuatro horas.', false), ('C', 'Noventa y seis horas.', false), ('D', 'Setenta y dos horas.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 18.2 de la Constitución, ¿en qué supuesto puede hacerse una entrada o registro en un domicilio sin consentimiento del titular ni resolución judicial?', 'El domicilio es inviolable; la entrada o registro exige consentimiento del titular o resolución judicial, con la única salvedad del flagrante delito (art. 18.2 CE).', 'age_aux_b1_01_constitucion', (select id from public.topics where slug = 'age-aux-b1-01-constitucion'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1978-31229'), 'Art. 18.2 CE', 'El domicilio es inviolable. Ninguna entrada o registro podrá hacerse en él sin consentimiento del titular o resolución judicial, salvo en caso de flagrante delito.', null, 'bcedab126c41aedfafb951ae9c4afd1e4090951fc044ceb74def4532e0d30a83', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'bcedab126c41aedfafb951ae9c4afd1e4090951fc044ceb74def4532e0d30a83')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'En caso de flagrante delito.', true), ('B', 'Cuando lo autorice el Ministerio Fiscal.', false), ('C', 'Cuando lo ordene la autoridad gubernativa por razones de seguridad.', false), ('D', 'Cuando lo autorice el Defensor del Pueblo.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 21 de la Constitución, en los casos de reuniones en lugares de tránsito público y manifestaciones:', 'El derecho de reunión pacífica y sin armas no necesita autorización previa (art. 21.1), pero en lugares de tránsito público y manifestaciones se dará comunicación previa a la autoridad, que solo puede prohibirlas por razones fundadas de alteración del orden público con peligro para personas o bienes (art. 21.2).', 'age_aux_b1_01_constitucion', (select id from public.topics where slug = 'age-aux-b1-01-constitucion'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1978-31229'), 'Art. 21.2 CE', 'En los casos de reuniones en lugares de tránsito público y manifestaciones se dará comunicación previa a la autoridad, que sólo podrá prohibirlas cuando existan razones fundadas de alteración del orden público, con peligro para personas o bienes.', null, '8337047bdf166bf1fab27295b1ccc07161acad89d3034c764a1cd8849d58532e', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '8337047bdf166bf1fab27295b1ccc07161acad89d3034c764a1cd8849d58532e')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Se requerirá autorización previa de la autoridad.', false), ('B', 'Se requerirá autorización judicial previa.', false), ('C', 'Se dará comunicación previa a la autoridad.', true), ('D', 'No es necesaria comunicación alguna.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 22 de la Constitución, las asociaciones constituidas al amparo de dicho artículo deberán inscribirse en un registro:', 'El art. 22.3 CE dispone que la inscripción registral de las asociaciones se hace a los solos efectos de publicidad.', 'age_aux_b1_01_constitucion', (select id from public.topics where slug = 'age-aux-b1-01-constitucion'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1978-31229'), 'Art. 22.3 CE', 'Las asociaciones constituidas al amparo de este artículo deberán inscribirse en un registro a los solos efectos de publicidad.', null, 'f75fc1b959f20249d3c92dd8e9e3ea82978e28542338c9688112ae8625378820', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'f75fc1b959f20249d3c92dd8e9e3ea82978e28542338c9688112ae8625378820')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'A los solos efectos de publicidad.', true), ('B', 'Con carácter constitutivo, para adquirir existencia legal.', false), ('C', 'Solo si persiguen fines de interés general.', false), ('D', 'Previa autorización administrativa de su actividad.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 27 de la Constitución Española, la enseñanza básica es:', 'El art. 27.4 CE establece que la enseñanza básica es obligatoria y gratuita.', 'age_aux_b1_01_constitucion', (select id from public.topics where slug = 'age-aux-b1-01-constitucion'), 1, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1978-31229'), 'Art. 27.4 CE', 'La enseñanza básica es obligatoria y gratuita.', null, 'a9c0c28417a9e60aa0fa90f11b1cc0e356d4ddbf786b7e7bed988813d80c4134', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'a9c0c28417a9e60aa0fa90f11b1cc0e356d4ddbf786b7e7bed988813d80c4134')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Obligatoria, pero no necesariamente gratuita.', false), ('B', 'Gratuita, pero no obligatoria.', false), ('C', 'Obligatoria y gratuita.', true), ('D', 'Obligatoria y gratuita solo en los centros públicos.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 29 de la Constitución, los miembros de las Fuerzas o Institutos armados o de los Cuerpos sometidos a disciplina militar podrán ejercer el derecho de petición:', 'El art. 29.1 reconoce a todos los españoles el derecho de petición individual y colectiva, por escrito; el art. 29.2 limita a los miembros de las Fuerzas o Institutos armados y Cuerpos sometidos a disciplina militar a ejercerlo solo individualmente y conforme a su legislación específica.', 'age_aux_b1_01_constitucion', (select id from public.topics where slug = 'age-aux-b1-01-constitucion'), 3, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1978-31229'), 'Art. 29.2 CE', 'Los miembros de las Fuerzas o Institutos armados o de los Cuerpos sometidos a disciplina militar podrán ejercer este derecho sólo individualmente y con arreglo a lo dispuesto en su legislación específica.', null, 'a2a4c4a904bb7d75ec8a6ac45548f4517a2a4066b19ba7df5e541fbc4f5d1a9a', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'a2a4c4a904bb7d75ec8a6ac45548f4517a2a4066b19ba7df5e541fbc4f5d1a9a')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'De forma individual y colectiva, en los mismos términos que el resto de ciudadanos.', false), ('B', 'Sólo individualmente y con arreglo a lo dispuesto en su legislación específica.', true), ('C', 'Sólo colectivamente, a través de sus mandos.', false), ('D', 'No pueden ejercer el derecho de petición.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 31.1 de la Constitución, el sistema tributario justo mediante el que todos contribuirán al sostenimiento de los gastos públicos se inspirará en los principios de:', 'El art. 31.1 CE recoge los principios de igualdad y progresividad del sistema tributario, que en ningún caso tendrá alcance confiscatorio. Los criterios de eficiencia y economía se refieren a la programación y ejecución del gasto público (art. 31.2).', 'age_aux_b1_01_constitucion', (select id from public.topics where slug = 'age-aux-b1-01-constitucion'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1978-31229'), 'Art. 31.1 CE', 'Todos contribuirán al sostenimiento de los gastos públicos de acuerdo con su capacidad económica mediante un sistema tributario justo inspirado en los principios de igualdad y progresividad que, en ningún caso, tendrá alcance confiscatorio.', null, 'd04ade98c0e4de7db19c8c3e78265b68b39c6ebb5027b7d212c3758b9df40b78', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'd04ade98c0e4de7db19c8c3e78265b68b39c6ebb5027b7d212c3758b9df40b78')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Generalidad y proporcionalidad.', false), ('B', 'Eficiencia y economía.', false), ('C', 'Legalidad y suficiencia.', false), ('D', 'Igualdad y progresividad.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 53.2 de la Constitución, además de a las libertades y derechos del artículo 14 y de la Sección primera del Capítulo segundo, el recurso de amparo ante el Tribunal Constitucional será aplicable a:', 'El art. 53.2 CE extiende expresamente el recurso de amparo a la objeción de conciencia del art. 30. La propiedad (art. 33) y el trabajo (art. 35) están en la Sección segunda y la salud (art. 43) es un principio rector.', 'age_aux_b1_01_constitucion', (select id from public.topics where slug = 'age-aux-b1-01-constitucion'), 3, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1978-31229'), 'Art. 53.2 CE', 'Cualquier ciudadano podrá recabar la tutela de las libertades y derechos reconocidos en el artículo 14 y la Sección primera del Capítulo segundo ante los Tribunales ordinarios por un procedimiento basado en los principios de preferencia y sumariedad y, en su caso, a través del recurso de amparo ante el Tribunal Constitucional. Este último recurso será aplicable a la objeción de conciencia reconocida en el artículo 30.', null, 'a42b549ef97787372f3661c26887d293c39be19a48270397899a3641a9391cd2', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'a42b549ef97787372f3661c26887d293c39be19a48270397899a3641a9391cd2')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El derecho a la propiedad privada y a la herencia.', false), ('B', 'El derecho al trabajo y a la libre elección de profesión u oficio.', false), ('C', 'La objeción de conciencia reconocida en el artículo 30.', true), ('D', 'El derecho a la protección de la salud.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 53.3 de la Constitución, los principios reconocidos en el Capítulo tercero del Título I (principios rectores de la política social y económica):', 'Los principios rectores informan la legislación positiva, la práctica judicial y la actuación de los poderes públicos, pero solo pueden alegarse ante la jurisdicción ordinaria según lo que dispongan las leyes que los desarrollen (art. 53.3 CE).', 'age_aux_b1_01_constitucion', (select id from public.topics where slug = 'age-aux-b1-01-constitucion'), 3, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1978-31229'), 'Art. 53.3 CE', 'El reconocimiento, el respeto y la protección de los principios reconocidos en el Capítulo tercero informarán la legislación positiva, la práctica judicial y la actuación de los poderes públicos. Sólo podrán ser alegados ante la Jurisdicción ordinaria de acuerdo con lo que dispongan las leyes que los desarrollen.', null, '701b9cd09a036446eee9cf4e9d1cad00088ab3a5ff06ccd26f6247f99b814316', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '701b9cd09a036446eee9cf4e9d1cad00088ab3a5ff06ccd26f6247f99b814316')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Podrán ser alegados directamente ante la Jurisdicción ordinaria por un procedimiento basado en la preferencia y sumariedad.', false), ('B', 'Son tutelables mediante recurso de amparo ante el Tribunal Constitucional.', false), ('C', 'Sólo vinculan al legislador y no pueden ser alegados ante ninguna jurisdicción.', false), ('D', 'Sólo podrán ser alegados ante la Jurisdicción ordinaria de acuerdo con lo que dispongan las leyes que los desarrollen.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 55.1 de la Constitución, ¿qué precepto queda exceptuado de la suspensión de derechos en el supuesto de declaración del estado de excepción?', 'El art. 55.1 CE permite suspender en los estados de excepción o de sitio los derechos de los arts. 17, 18.2 y 3, 19, 20.1 a) y d) y 5, 21, 28.2 y 37.2, pero exceptúa el art. 17.3 cuando se declara el estado de excepción.', 'age_aux_b1_01_constitucion', (select id from public.topics where slug = 'age-aux-b1-01-constitucion'), 3, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1978-31229'), 'Art. 55.1 CE', 'Se exceptúa de lo establecido anteriormente el apartado 3 del artículo 17 para el supuesto de declaración de estado de excepción.', null, '796fcc4e02f2588de0cc23c48979b4b93125d458a7424e3007526b16feb6d453', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '796fcc4e02f2588de0cc23c48979b4b93125d458a7424e3007526b16feb6d453')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El apartado 2 del artículo 18, relativo a la inviolabilidad del domicilio.', false), ('B', 'El apartado 3 del artículo 17, relativo a los derechos de la persona detenida.', true), ('C', 'El apartado 2 del artículo 28, relativo al derecho de huelga.', false), ('D', 'El artículo 19, relativo a la libertad de residencia y circulación.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 55.2 de la Constitución, en relación con las investigaciones sobre la actuación de bandas armadas o elementos terroristas, una ley orgánica podrá determinar la suspensión, para personas determinadas, de los derechos reconocidos en:', 'La suspensión individual del art. 55.2 CE afecta solo a la duración de la detención preventiva (art. 17.2), la inviolabilidad del domicilio (art. 18.2) y el secreto de las comunicaciones (art. 18.3), con intervención judicial y control parlamentario.', 'age_aux_b1_01_constitucion', (select id from public.topics where slug = 'age-aux-b1-01-constitucion'), 3, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1978-31229'), 'Art. 55.2 CE', 'Una ley orgánica podrá determinar la forma y los casos en los que, de forma individual y con la necesaria intervención judicial y el adecuado control parlamentario, los derechos reconocidos en los artículos 17, apartado 2, y 18, apartados 2 y 3, pueden ser suspendidos para personas determinadas, en relación con las investigaciones correspondientes a la actuación de bandas armadas o elementos terroristas.', null, '6b4b21ae88554c77d37f520cf5e2a97e4862a14a4e4fb097bdafc1a1b07e7216', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '6b4b21ae88554c77d37f520cf5e2a97e4862a14a4e4fb097bdafc1a1b07e7216')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Los artículos 17, apartado 2, y 18, apartados 2 y 3.', true), ('B', 'Los artículos 20, apartado 1, a) y d), y 21.', false), ('C', 'Los artículos 19 y 28, apartado 2.', false), ('D', 'Los artículos 17, apartado 3, y 24, apartado 2.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
-- Lote age-aux-b1-02-tc-reforma-corona-ce-v1 (17 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Constitución Española (texto consolidado, BOE)', 'https://www.boe.es/buscar/act.php?id=BOE-A-1978-31229', 'boe'::public.source_kind, 'Agencia Estatal Boletín Oficial del Estado', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('age-aux-b1-02-tc-reforma-corona', 'I.2 El Tribunal Constitucional, la reforma de la Constitución y la Corona') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug = 'auxiliar-administrativo-estado' and t.slug = 'age-aux-b1-02-tc-reforma-corona' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 159.1 de la Constitución, ¿cuántos miembros del Tribunal Constitucional se nombran a propuesta del Senado y con qué mayoría?', 'De los 12 miembros del Tribunal Constitucional, cuatro se proponen por el Congreso por mayoría de tres quintos, cuatro por el Senado con idéntica mayoría, dos por el Gobierno y dos por el Consejo General del Poder Judicial.', 'age_aux_b1_02_tc_reforma_corona', (select id from public.topics where slug = 'age-aux-b1-02-tc-reforma-corona'), 1, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1978-31229'), 'Art. 159.1 CE', 'El Tribunal Constitucional se compone de 12 miembros nombrados por el Rey; de ellos, cuatro a propuesta del Congreso por mayoría de tres quintos de sus miembros; cuatro a propuesta del Senado, con idéntica mayoría; dos a propuesta del Gobierno, y dos a propuesta del Consejo General del Poder Judicial.', null, '3cf153bb3ae63d301bf9a7f3abebdc7f45b9a119c1386bdf1e9de24ddb7123ca', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '3cf153bb3ae63d301bf9a7f3abebdc7f45b9a119c1386bdf1e9de24ddb7123ca')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Cuatro, por mayoría de tres quintos de sus miembros.', true), ('B', 'Cuatro, por mayoría absoluta de sus miembros.', false), ('C', 'Dos, por mayoría de tres quintos de sus miembros.', false), ('D', 'Seis, por mayoría de dos tercios de sus miembros.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según la Constitución, los miembros del Tribunal Constitucional son designados por un período de:', 'El art. 159.3 CE fija un mandato de nueve años con renovación por terceras partes cada tres años.', 'age_aux_b1_02_tc_reforma_corona', (select id from public.topics where slug = 'age-aux-b1-02-tc-reforma-corona'), 1, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1978-31229'), 'Art. 159.3 CE', 'Los miembros del Tribunal Constitucional serán designados por un período de nueve años y se renovarán por terceras partes cada tres.', null, '4b1f40d957d3dd992343e566acfe79813f51836010c3997c670195bf89c63923', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '4b1f40d957d3dd992343e566acfe79813f51836010c3997c670195bf89c63923')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Nueve años, renovándose por mitades cada cuatro años y medio.', false), ('B', 'Doce años, renovándose por terceras partes cada cuatro.', false), ('C', 'Nueve años, renovándose por terceras partes cada tres.', true), ('D', 'Seis años, renovándose por mitades cada tres.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 160 de la Constitución, el Presidente del Tribunal Constitucional es nombrado:', 'El Presidente del Tribunal Constitucional se nombra por el Rey entre los miembros del Tribunal, a propuesta del Pleno del propio Tribunal y por tres años (art. 160 CE).', 'age_aux_b1_02_tc_reforma_corona', (select id from public.topics where slug = 'age-aux-b1-02-tc-reforma-corona'), 1, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1978-31229'), 'Art. 160 CE', 'El Presidente del Tribunal Constitucional será nombrado entre sus miembros por el Rey, a propuesta del mismo Tribunal en pleno y por un período de tres años.', null, '32c234f59051fafc48ba43669cbf6e632682546adc812805f53046dc1e6e9d6c', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '32c234f59051fafc48ba43669cbf6e632682546adc812805f53046dc1e6e9d6c')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Entre sus miembros por el Rey, a propuesta del Gobierno, por un período de tres años.', false), ('B', 'Entre sus miembros por el Rey, a propuesta del mismo Tribunal en pleno, por un período de tres años.', true), ('C', 'Por el Rey, a propuesta del Congreso de los Diputados, por un período de nueve años.', false), ('D', 'Entre sus miembros por el Rey, a propuesta del mismo Tribunal en pleno, por un período de cinco años.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 159.2 de la Constitución, los miembros del Tribunal Constitucional deberán ser nombrados entre Magistrados y Fiscales, Profesores de Universidad, funcionarios públicos y Abogados, todos ellos juristas de reconocida competencia con:', 'El art. 159.2 CE exige juristas de reconocida competencia con más de quince años de ejercicio profesional.', 'age_aux_b1_02_tc_reforma_corona', (select id from public.topics where slug = 'age-aux-b1-02-tc-reforma-corona'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1978-31229'), 'Art. 159.2 CE', 'Los miembros del Tribunal Constitucional deberán ser nombrados entre Magistrados y Fiscales, Profesores de Universidad, funcionarios públicos y Abogados, todos ellos juristas de reconocida competencia con más de quince años de ejercicio profesional.', null, '0981423480bebc8a11a8d9abe022fa364a43fe8d4b406048fa443a303420bb41', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '0981423480bebc8a11a8d9abe022fa364a43fe8d4b406048fa443a303420bb41')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Más de diez años de ejercicio profesional.', false), ('B', 'Más de veinte años de ejercicio profesional.', false), ('C', 'Más de veinticinco años de ejercicio profesional.', false), ('D', 'Más de quince años de ejercicio profesional.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 162 de la Constitución, ¿cuál de los siguientes está legitimado para interponer el recurso de inconstitucionalidad?', 'Están legitimados el Presidente del Gobierno, el Defensor del Pueblo, 50 Diputados, 50 Senadores, los órganos colegiados ejecutivos de las Comunidades Autónomas y, en su caso, sus Asambleas (art. 162.1.a CE).', 'age_aux_b1_02_tc_reforma_corona', (select id from public.topics where slug = 'age-aux-b1-02-tc-reforma-corona'), 1, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1978-31229'), 'Art. 162.1.a) CE', 'Para interponer el recurso de inconstitucionalidad, el Presidente del Gobierno, el Defensor del Pueblo, 50 Diputados, 50 Senadores, los órganos colegiados ejecutivos de las Comunidades Autónomas y, en su caso, las Asambleas de las mismas.', null, '4dcbf185dbf3787141a9ea1f2417838a00850a494b786a059eaeaf815106f156', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '4dcbf185dbf3787141a9ea1f2417838a00850a494b786a059eaeaf815106f156')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El Fiscal General del Estado.', false), ('B', 'El Consejo General del Poder Judicial.', false), ('C', 'El Defensor del Pueblo.', true), ('D', 'Veinticinco Diputados.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 162.1.b) de la Constitución, además de toda persona natural o jurídica que invoque un interés legítimo, están legitimados para interponer el recurso de amparo:', 'El art. 162.1.b) CE legitima para el recurso de amparo a toda persona natural o jurídica que invoque un interés legítimo, al Defensor del Pueblo y al Ministerio Fiscal.', 'age_aux_b1_02_tc_reforma_corona', (select id from public.topics where slug = 'age-aux-b1-02-tc-reforma-corona'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1978-31229'), 'Art. 162.1.b) CE', 'Para interponer el recurso de amparo, toda persona natural o jurídica que invoque un interés legítimo, así como el Defensor del Pueblo y el Ministerio Fiscal.', null, 'cff8716cde247ca764088867ecc2974356bcc3163c20a27809d821d773d9318a', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'cff8716cde247ca764088867ecc2974356bcc3163c20a27809d821d773d9318a')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El Defensor del Pueblo y el Ministerio Fiscal.', true), ('B', 'El Presidente del Gobierno y el Defensor del Pueblo.', false), ('C', 'Cincuenta Diputados y cincuenta Senadores.', false), ('D', 'El Ministerio Fiscal y el Consejo General del Poder Judicial.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Cuando el Gobierno impugna ante el Tribunal Constitucional disposiciones o resoluciones de los órganos de las Comunidades Autónomas, la impugnación produce la suspensión de la disposición o resolución recurrida, pero el Tribunal deberá ratificarla o levantarla en un plazo no superior a:', 'El art. 161.2 CE fija un plazo no superior a cinco meses para que el Tribunal ratifique o levante la suspensión.', 'age_aux_b1_02_tc_reforma_corona', (select id from public.topics where slug = 'age-aux-b1-02-tc-reforma-corona'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1978-31229'), 'Art. 161.2 CE', 'La impugnación producirá la suspensión de la disposición o resolución recurrida, pero el Tribunal, en su caso, deberá ratificarla o levantarla en un plazo no superior a cinco meses.', null, '3076d195e3e33eceec951ba25df6858638206a7916ec1bc924ce21eea169ecd8', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '3076d195e3e33eceec951ba25df6858638206a7916ec1bc924ce21eea169ecd8')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Tres meses.', false), ('B', 'Cinco meses.', true), ('C', 'Seis meses.', false), ('D', 'Dos meses.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 163 de la Constitución, cuando un órgano judicial plantee la cuestión de inconstitucionalidad ante el Tribunal Constitucional, los efectos que establezca la ley:', 'El art. 163 CE remite a la ley los supuestos, la forma y los efectos de la cuestión de inconstitucionalidad, precisando que estos en ningún caso serán suspensivos.', 'age_aux_b1_02_tc_reforma_corona', (select id from public.topics where slug = 'age-aux-b1-02-tc-reforma-corona'), 3, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1978-31229'), 'Art. 163 CE', 'planteará la cuestión ante el Tribunal Constitucional en los supuestos, en la forma y con los efectos que establezca la ley, que en ningún caso serán suspensivos.', null, '366b50d6d563a620d7228171fc853d499fe2d78fed1bc61bc8113a8e99925ade', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '366b50d6d563a620d7228171fc853d499fe2d78fed1bc61bc8113a8e99925ade')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Suspenderán la vigencia de la norma cuestionada hasta la sentencia.', false), ('B', 'Suspenderán la vigencia de la norma por un plazo máximo de cinco meses.', false), ('C', 'Serán suspensivos solo si la norma cuestionada es una ley autonómica.', false), ('D', 'En ningún caso serán suspensivos.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 56.3 de la Constitución, la persona del Rey:', 'El art. 56.3 CE declara que la persona del Rey es inviolable y no está sujeta a responsabilidad; sus actos estarán siempre refrendados y de ellos responden quienes los refrenden (art. 64.2).', 'age_aux_b1_02_tc_reforma_corona', (select id from public.topics where slug = 'age-aux-b1-02-tc-reforma-corona'), 1, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1978-31229'), 'Art. 56.3 CE', 'La persona del Rey es inviolable y no está sujeta a responsabilidad.', null, '7a0b8b4e8bb67d12abb3b7cb56243303c9dcddb519b492e4fe48c93a4a90829d', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '7a0b8b4e8bb67d12abb3b7cb56243303c9dcddb519b492e4fe48c93a4a90829d')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Es inviolable y no está sujeta a responsabilidad.', true), ('B', 'Es inviolable, pero responde de sus actos ante las Cortes Generales.', false), ('C', 'Goza de inmunidad y solo puede ser juzgada por la Sala de lo Penal del Tribunal Supremo.', false), ('D', 'Es inviolable salvo en los actos no refrendados.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 167 de la Constitución, los proyectos de reforma constitucional por el procedimiento ordinario deberán ser aprobados por:', 'El art. 167.1 CE exige tres quintos de cada Cámara. Los dos tercios corresponden al procedimiento agravado del art. 168.', 'age_aux_b1_02_tc_reforma_corona', (select id from public.topics where slug = 'age-aux-b1-02-tc-reforma-corona'), 1, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1978-31229'), 'Art. 167.1 CE', 'Los proyectos de reforma constitucional deberán ser aprobados por una mayoría de tres quintos de cada una de las Cámaras.', null, 'd2039d08f61e3d1ba0f9d34cf61c53a501c5553b97d32df16855ab0233187c18', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'd2039d08f61e3d1ba0f9d34cf61c53a501c5553b97d32df16855ab0233187c18')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Una mayoría de dos tercios de cada una de las Cámaras.', false), ('B', 'La mayoría absoluta de cada una de las Cámaras.', false), ('C', 'Una mayoría de tres quintos del Congreso y mayoría absoluta del Senado.', false), ('D', 'Una mayoría de tres quintos de cada una de las Cámaras.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 167.2 de la Constitución, si no se logra la aprobación de la reforma mediante la Comisión de composición paritaria, el Congreso podrá aprobarla siempre que el texto haya obtenido el voto favorable de la mayoría absoluta del Senado y que el Congreso lo apruebe por:', 'El art. 167.2 CE prevé esta vía subsidiaria: mayoría absoluta del Senado y dos tercios del Congreso.', 'age_aux_b1_02_tc_reforma_corona', (select id from public.topics where slug = 'age-aux-b1-02-tc-reforma-corona'), 3, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1978-31229'), 'Art. 167.2 CE', 'De no lograrse la aprobación mediante el procedimiento del apartado anterior, y siempre que el texto hubiere obtenido el voto favorable de la mayoría absoluta del Senado, el Congreso, por mayoría de dos tercios, podrá aprobar la reforma.', null, '574f85f7bd973f4fd94aa1a7ad23b77a60949433633e2f341786b9a4ef448014', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '574f85f7bd973f4fd94aa1a7ad23b77a60949433633e2f341786b9a4ef448014')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Mayoría de tres quintos.', false), ('B', 'Mayoría de dos tercios.', true), ('C', 'Mayoría absoluta.', false), ('D', 'Mayoría de tres cuartos.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 167.3 de la Constitución, la reforma aprobada por las Cortes Generales por el procedimiento ordinario será sometida a referéndum para su ratificación cuando así lo solicite:', 'En el procedimiento del art. 167 el referéndum es facultativo: basta que lo pida una décima parte de los miembros de cualquiera de las Cámaras dentro de los quince días siguientes a la aprobación. En el del art. 168 el referéndum es obligatorio.', 'age_aux_b1_02_tc_reforma_corona', (select id from public.topics where slug = 'age-aux-b1-02-tc-reforma-corona'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1978-31229'), 'Art. 167.3 CE', 'Aprobada la reforma por las Cortes Generales, será sometida a referéndum para su ratificación cuando así lo soliciten, dentro de los quince días siguientes a su aprobación, una décima parte de los miembros de cualquiera de las Cámaras.', null, '5aabbe93b51caa2a6990d2cd781e6c8b541937250c18df350be37f4a4a31fd99', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '5aabbe93b51caa2a6990d2cd781e6c8b541937250c18df350be37f4a4a31fd99')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Una décima parte de los miembros de cada una de las Cámaras, dentro de los treinta días siguientes a su aprobación.', false), ('B', 'Una quinta parte de los miembros del Congreso, dentro de los quince días siguientes a su aprobación.', false), ('C', 'Una décima parte de los miembros de cualquiera de las Cámaras, dentro de los quince días siguientes a su aprobación.', true), ('D', 'El Presidente del Gobierno, previa autorización del Congreso de los Diputados.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select '¿La reforma de cuál de las siguientes partes de la Constitución exige el procedimiento agravado del artículo 168?', 'El art. 168.1 CE reserva el procedimiento agravado a la revisión total o a la parcial que afecte al Título preliminar, al Capítulo segundo, Sección primera del Título I, o al Título II.', 'age_aux_b1_02_tc_reforma_corona', (select id from public.topics where slug = 'age-aux-b1-02-tc-reforma-corona'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1978-31229'), 'Art. 168.1 CE', 'Cuando se propusiere la revisión total de la Constitución o una parcial que afecte al Título preliminar, al Capítulo segundo, Sección primera del Título I, o al Título II, se procederá a la aprobación del principio por mayoría de dos tercios de cada Cámara, y a la disolución inmediata de las Cortes.', null, '821869308172bd0ac059761ea47e6d9975a897e618fc895a1a3408620d70ae64', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '821869308172bd0ac059761ea47e6d9975a897e618fc895a1a3408620d70ae64')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El Título II, de la Corona.', true), ('B', 'El Título III, de las Cortes Generales.', false), ('C', 'El Título VIII, de la organización territorial del Estado.', false), ('D', 'El Capítulo tercero del Título I, de los principios rectores de la política social y económica.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 57.1 de la Constitución, la sucesión en el trono seguirá el orden regular de:', 'El art. 57.1 CE establece el orden regular de primogenitura y representación, prefiriendo la línea anterior a las posteriores; en la misma línea, el grado más próximo; en el mismo grado, el varón a la mujer; y en el mismo sexo, la persona de más edad.', 'age_aux_b1_02_tc_reforma_corona', (select id from public.topics where slug = 'age-aux-b1-02-tc-reforma-corona'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1978-31229'), 'Art. 57.1 CE', 'La sucesión en el trono seguirá el orden regular de primogenitura y representación', null, 'b56af415dbba64fd81809bbe20c6291e0be33e187276018ef20ec84bba23e96e', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'b56af415dbba64fd81809bbe20c6291e0be33e187276018ef20ec84bba23e96e')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Primogenitura y agnación.', false), ('B', 'Proximidad de grado y elección por las Cortes Generales.', false), ('C', 'Primogenitura y representación.', true), ('D', 'Representación y mayor edad.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 59.3 de la Constitución, si no hubiere ninguna persona a quien corresponda la Regencia, ésta será nombrada por las Cortes Generales y se compondrá de:', 'A falta de persona llamada a la Regencia, las Cortes Generales la nombran y puede ser de una, tres o cinco personas (art. 59.3 CE).', 'age_aux_b1_02_tc_reforma_corona', (select id from public.topics where slug = 'age-aux-b1-02-tc-reforma-corona'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1978-31229'), 'Art. 59.3 CE', 'Si no hubiere ninguna persona a quien corresponda la Regencia, ésta será nombrada por las Cortes Generales, y se compondrá de una, tres o cinco personas.', null, '3c03fe3b51b8b3d357f77a92835f75b24ceb82c754f6e395b2306217aefb29ae', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '3c03fe3b51b8b3d357f77a92835f75b24ceb82c754f6e395b2306217aefb29ae')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Una o tres personas.', false), ('B', 'Tres o cinco personas.', false), ('C', 'Dos o cuatro personas.', false), ('D', 'Una, tres o cinco personas.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 62 de la Constitución, corresponde al Rey ejercer el derecho de gracia con arreglo a la ley, la cual:', 'El art. 62.i) CE atribuye al Rey el derecho de gracia con arreglo a la ley, que no podrá autorizar indultos generales.', 'age_aux_b1_02_tc_reforma_corona', (select id from public.topics where slug = 'age-aux-b1-02-tc-reforma-corona'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1978-31229'), 'Art. 62.i) CE', 'Ejercer el derecho de gracia con arreglo a la ley, que no podrá autorizar indultos generales.', null, 'dc1f0fe6fc39def8195cc8b300e040c05b780fed5dbbeb438c1df656708f9f60', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'dc1f0fe6fc39def8195cc8b300e040c05b780fed5dbbeb438c1df656708f9f60')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Podrá autorizar indultos generales con autorización de las Cortes Generales.', false), ('B', 'No podrá autorizar indultos generales.', true), ('C', 'Podrá autorizar indultos generales a propuesta del Consejo de Ministros.', false), ('D', 'Requerirá en todo caso informe favorable del Tribunal Supremo.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 64.1 de la Constitución, ¿quién refrenda la propuesta y el nombramiento del Presidente del Gobierno?', 'Con carácter general refrendan el Presidente del Gobierno y, en su caso, los Ministros competentes, pero la propuesta y el nombramiento del Presidente del Gobierno y la disolución del art. 99 los refrenda el Presidente del Congreso (art. 64.1 CE).', 'age_aux_b1_02_tc_reforma_corona', (select id from public.topics where slug = 'age-aux-b1-02-tc-reforma-corona'), 3, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1978-31229'), 'Art. 64.1 CE', 'La propuesta y el nombramiento del Presidente del Gobierno, y la disolución prevista en el artículo 99, serán refrendados por el Presidente del Congreso.', null, 'fb75a6906039a4ecb8264a2830509abe450afdbc657f14f5cf7c97a6d9c492f4', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'fb75a6906039a4ecb8264a2830509abe450afdbc657f14f5cf7c97a6d9c492f4')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El Presidente del Congreso.', true), ('B', 'El Presidente del Gobierno saliente.', false), ('C', 'El Presidente del Senado.', false), ('D', 'El Ministro de la Presidencia.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
-- Lote age-aux-b1-02-tc-reforma-corona-lotc-v1 (3 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Ley Orgánica 2/1979, de 3 de octubre, del Tribunal Constitucional (texto consolidado, BOE)', 'https://www.boe.es/buscar/act.php?id=BOE-A-1979-23709', 'boe'::public.source_kind, 'Agencia Estatal Boletín Oficial del Estado', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('age-aux-b1-02-tc-reforma-corona', 'I.2 El Tribunal Constitucional, la reforma de la Constitución y la Corona') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug = 'auxiliar-administrativo-estado' and t.slug = 'age-aux-b1-02-tc-reforma-corona' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'De acuerdo con la Ley Orgánica del Tribunal Constitucional, expirado el período de tres años para el que fue nombrado, el Presidente del Tribunal Constitucional:', 'El art. 9.3 LOTC dispone que el nombre del elegido se eleva al Rey para su nombramiento por tres años, expirados los cuales podrá ser reelegido por una sola vez.', 'age_aux_b1_02_tc_reforma_corona', (select id from public.topics where slug = 'age-aux-b1-02-tc-reforma-corona'), 3, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1979-23709'), 'Art. 9.3 LOTC', 'El nombre del elegido se elevará al Rey para su nombramiento por un período de tres años, expirado el cual podrá ser reelegido por una sola vez.', null, '79a3d119d3f5361c55dbc18e180bc97daca46e45ded77205404e1a9a658bf096', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '79a3d119d3f5361c55dbc18e180bc97daca46e45ded77205404e1a9a658bf096')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'No podrá ser reelegido.', false), ('B', 'Podrá ser reelegido sin limitación mientras conserve la condición de Magistrado.', false), ('C', 'Podrá ser reelegido por una sola vez, pero solo tras un período intermedio de tres años.', false), ('D', 'Podrá ser reelegido por una sola vez.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Con carácter general, según la Ley Orgánica del Tribunal Constitucional, el recurso de inconstitucionalidad se formulará dentro del plazo de:', 'El art. 33.1 LOTC fija el plazo general de tres meses desde la publicación. El plazo de nueve meses del art. 33.2 es excepcional y solo para el Presidente del Gobierno y los órganos colegiados ejecutivos autonómicos cuando se cumplen ciertos requisitos.', 'age_aux_b1_02_tc_reforma_corona', (select id from public.topics where slug = 'age-aux-b1-02-tc-reforma-corona'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1979-23709'), 'Art. 33.1 LOTC', 'El recurso de inconstitucionalidad se formulará dentro del plazo de tres meses a partir de la publicación de la Ley, disposición o acto con fuerza de Ley impugnado mediante demanda presentada ante el Tribunal Constitucional', null, '2403a8a46c0c036f2262e249bcba527d7c3004b421ff135e876196136f519604', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '2403a8a46c0c036f2262e249bcba527d7c3004b421ff135e876196136f519604')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Nueve meses a partir de la publicación de la Ley, disposición o acto con fuerza de Ley impugnado.', false), ('B', 'Treinta días a partir de la entrada en vigor de la Ley impugnada.', false), ('C', 'Tres meses a partir de la publicación de la Ley, disposición o acto con fuerza de Ley impugnado.', true), ('D', 'Seis meses a partir de la entrada en vigor de la Ley impugnada.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 44 de la Ley Orgánica del Tribunal Constitucional, el plazo para interponer el recurso de amparo frente a violaciones de derechos con origen inmediato y directo en un acto u omisión de un órgano judicial es de:', 'El art. 44.2 LOTC fija 30 días para el amparo contra actos judiciales. El plazo de 20 días del art. 43.2 corresponde al amparo contra actos del Gobierno y de las Administraciones, y el de tres meses del art. 42 a los actos parlamentarios sin valor de ley.', 'age_aux_b1_02_tc_reforma_corona', (select id from public.topics where slug = 'age-aux-b1-02-tc-reforma-corona'), 3, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1979-23709'), 'Art. 44.2 LOTC', 'El plazo para interponer el recurso de amparo será de 30 días, a partir de la notificación de la resolución recaída en el proceso judicial.', null, 'a73e38d369f555a1262e07bb1d8af4d53a6896e723e99fed3a0b1224e734e6c1', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'a73e38d369f555a1262e07bb1d8af4d53a6896e723e99fed3a0b1224e734e6c1')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', '20 días, a partir de la notificación de la resolución recaída en el proceso judicial.', false), ('B', '30 días, a partir de la notificación de la resolución recaída en el proceso judicial.', true), ('C', 'Tres meses, a partir de que la resolución judicial sea firme.', false), ('D', '15 días, a partir de la notificación de la resolución recaída en el proceso judicial.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
-- Lote age-aux-b1-03-cortes-defensor-ce-v1 (14 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Constitución Española (texto consolidado, BOE)', 'https://www.boe.es/buscar/act.php?id=BOE-A-1978-31229', 'boe'::public.source_kind, 'Agencia Estatal Boletín Oficial del Estado', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('age-aux-b1-03-cortes-defensor', 'I.3 Las Cortes Generales y el Defensor del Pueblo') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug = 'auxiliar-administrativo-estado' and t.slug = 'age-aux-b1-03-cortes-defensor' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 68.1 de la Constitución, el Congreso se compone de:', 'El art. 68.1 CE fija una horquilla de 300 a 400 Diputados, elegidos por sufragio universal, libre, igual, directo y secreto.', 'age_aux_b1_03_cortes_defensor', (select id from public.topics where slug = 'age-aux-b1-03-cortes-defensor'), 1, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1978-31229'), 'Art. 68.1 CE', 'El Congreso se compone de un mínimo de 300 y un máximo de 400 Diputados, elegidos por sufragio universal, libre, igual, directo y secreto, en los términos que establezca la ley.', null, '329c8db7269487e306b0987b7dffee12f2229b98f6298d816f1c33907111860b', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '329c8db7269487e306b0987b7dffee12f2229b98f6298d816f1c33907111860b')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Un mínimo de 250 y un máximo de 350 Diputados.', false), ('B', 'Un mínimo de 300 y un máximo de 400 Diputados.', true), ('C', 'Un mínimo de 350 y un máximo de 400 Diputados.', false), ('D', 'Un mínimo de 300 y un máximo de 450 Diputados.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 68.6 de la Constitución, las elecciones tendrán lugar entre los treinta y sesenta días desde la terminación del mandato, y el Congreso electo deberá ser convocado:', 'El art. 68.6 CE establece que las elecciones se celebran entre los treinta y sesenta días desde la terminación del mandato y que el Congreso electo debe convocarse dentro de los veinticinco días siguientes a las elecciones.', 'age_aux_b1_03_cortes_defensor', (select id from public.topics where slug = 'age-aux-b1-03-cortes-defensor'), 3, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1978-31229'), 'Art. 68.6 CE', 'Las elecciones tendrán lugar entre los treinta días y sesenta días desde la terminación del mandato. El Congreso electo deberá ser convocado dentro de los veinticinco días siguientes a la celebración de las elecciones.', null, '0cbf18f9f3b26b837a1697ef0187e86232270c2803875d13205057b58e457a53', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '0cbf18f9f3b26b837a1697ef0187e86232270c2803875d13205057b58e457a53')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Dentro de los quince días siguientes a la celebración de las elecciones.', false), ('B', 'Dentro de los treinta días siguientes a la celebración de las elecciones.', false), ('C', 'Dentro de los sesenta días siguientes a la terminación del mandato.', false), ('D', 'Dentro de los veinticinco días siguientes a la celebración de las elecciones.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 69.2 de la Constitución, ¿cuántos Senadores se elegirán en cada provincia?', 'En cada provincia se eligen cuatro Senadores por sufragio universal, libre, igual, directo y secreto (art. 69.2 CE). Las provincias insulares, Ceuta y Melilla tienen reglas propias (arts. 69.3 y 69.4).', 'age_aux_b1_03_cortes_defensor', (select id from public.topics where slug = 'age-aux-b1-03-cortes-defensor'), 1, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1978-31229'), 'Art. 69.2 CE', 'En cada provincia se elegirán cuatro Senadores por sufragio universal, libre, igual, directo y secreto por los votantes de cada una de ellas, en los términos que señale una ley orgánica.', null, 'ae68af68360903eed26f28d298cf2c85ba5ebf4c23424ad99f3fd1a6e238896f', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'ae68af68360903eed26f28d298cf2c85ba5ebf4c23424ad99f3fd1a6e238896f')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Tres.', false), ('B', 'Dos.', false), ('C', 'Cuatro.', true), ('D', 'Cinco.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 69.5 de la Constitución, las Comunidades Autónomas designarán:', 'Cada Comunidad Autónoma designa un Senador y otro más por cada millón de habitantes; la designación corresponde a la Asamblea legislativa o, en su defecto, al órgano colegiado superior de la Comunidad.', 'age_aux_b1_03_cortes_defensor', (select id from public.topics where slug = 'age-aux-b1-03-cortes-defensor'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1978-31229'), 'Art. 69.5 CE', 'Las Comunidades Autónomas designarán además un Senador y otro más por cada millón de habitantes de su respectivo territorio.', null, '977dd8fd8c22fbaebb97d9f7298204a64466aa3b35d417c44f16b5d347c16465', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '977dd8fd8c22fbaebb97d9f7298204a64466aa3b35d417c44f16b5d347c16465')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Un Senador y otro más por cada millón de habitantes de su respectivo territorio.', true), ('B', 'Dos Senadores y otro más por cada millón de habitantes de su respectivo territorio.', false), ('C', 'Un Senador por cada millón de habitantes de su respectivo territorio.', false), ('D', 'Un Senador y otro más por cada quinientos mil habitantes de su respectivo territorio.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 71.2 de la Constitución, durante el período de su mandato los Diputados y Senadores:', 'La inmunidad del art. 71.2 CE implica que solo pueden ser detenidos en flagrante delito y que su inculpación o procesamiento requiere autorización previa de la Cámara respectiva.', 'age_aux_b1_03_cortes_defensor', (select id from public.topics where slug = 'age-aux-b1-03-cortes-defensor'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1978-31229'), 'Art. 71.2 CE', 'Durante el período de su mandato los Diputados y Senadores gozarán asimismo de inmunidad y sólo podrán ser detenidos en caso de flagrante delito. No podrán ser inculpados ni procesados sin la previa autorización de la Cámara respectiva.', null, '0391948bf5cec1fa5dbd966ae2dd0bcb0c9400f45acaa3edc830092f79076a4d', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '0391948bf5cec1fa5dbd966ae2dd0bcb0c9400f45acaa3edc830092f79076a4d')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'No podrán ser detenidos en ningún caso sin la previa autorización de la Cámara respectiva.', false), ('B', 'Sólo podrán ser detenidos en caso de flagrante delito y no podrán ser inculpados ni procesados sin la previa autorización de las Cortes Generales en sesión conjunta.', false), ('C', 'Sólo podrán ser inculpados con autorización del Tribunal Supremo.', false), ('D', 'Sólo podrán ser detenidos en caso de flagrante delito y no podrán ser inculpados ni procesados sin la previa autorización de la Cámara respectiva.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según la Constitución, ¿qué órgano es competente en las causas contra Diputados y Senadores?', 'El art. 71.3 CE atribuye a la Sala de lo Penal del Tribunal Supremo las causas contra Diputados y Senadores.', 'age_aux_b1_03_cortes_defensor', (select id from public.topics where slug = 'age-aux-b1-03-cortes-defensor'), 1, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1978-31229'), 'Art. 71.3 CE', 'En las causas contra Diputados y Senadores será competente la Sala de lo Penal del Tribunal Supremo.', null, 'e51c5dcc57895199ae313d2487df8de4447cfcfb42ddc97605ad060a4a17cb79', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'e51c5dcc57895199ae313d2487df8de4447cfcfb42ddc97605ad060a4a17cb79')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'La Sala de lo Penal del Tribunal Supremo.', true), ('B', 'La Sala de lo Penal de la Audiencia Nacional.', false), ('C', 'El Tribunal Superior de Justicia de la Comunidad Autónoma por la que fueron elegidos.', false), ('D', 'El Pleno del Tribunal Constitucional.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 72.1 de la Constitución, los Reglamentos de las Cámaras y su reforma serán sometidos a una votación final sobre su totalidad que requerirá:', 'Las Cámaras establecen sus propios Reglamentos, cuya aprobación y reforma exige una votación final sobre su totalidad por mayoría absoluta (art. 72.1 CE).', 'age_aux_b1_03_cortes_defensor', (select id from public.topics where slug = 'age-aux-b1-03-cortes-defensor'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1978-31229'), 'Art. 72.1 CE', 'Los Reglamentos y su reforma serán sometidos a una votación final sobre su totalidad, que requerirá la mayoría absoluta.', null, 'd4cfb9e9d338ac20ee4acc11a1e9d6987c87d274b02af283ea6e06e350b4656a', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'd4cfb9e9d338ac20ee4acc11a1e9d6987c87d274b02af283ea6e06e350b4656a')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'La mayoría simple.', false), ('B', 'La mayoría absoluta.', true), ('C', 'La mayoría de tres quintos.', false), ('D', 'La mayoría de dos tercios.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 73.1 de la Constitución, las Cámaras se reunirán anualmente en dos períodos ordinarios de sesiones:', 'El art. 73.1 CE fija dos períodos ordinarios: el primero de septiembre a diciembre y el segundo de febrero a junio.', 'age_aux_b1_03_cortes_defensor', (select id from public.topics where slug = 'age-aux-b1-03-cortes-defensor'), 1, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1978-31229'), 'Art. 73.1 CE', 'Las Cámaras se reunirán anualmente en dos períodos ordinarios de sesiones: el primero, de septiembre a diciembre, y el segundo, de febrero a junio.', null, '7f2f0ba7c9d0e8eb4327c0c0f7fd0c1f3b277f0553e6dad6101a03cc1f21c15c', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '7f2f0ba7c9d0e8eb4327c0c0f7fd0c1f3b277f0553e6dad6101a03cc1f21c15c')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'De septiembre a diciembre y de enero a junio.', false), ('B', 'De octubre a diciembre y de febrero a julio.', false), ('C', 'De septiembre a diciembre y de febrero a junio.', true), ('D', 'De septiembre a enero y de marzo a junio.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 73.2 de la Constitución, las Cámaras podrán reunirse en sesiones extraordinarias a petición de:', 'Pueden pedir sesiones extraordinarias el Gobierno, la Diputación Permanente o la mayoría absoluta de los miembros de cualquiera de las Cámaras; se convocan sobre un orden del día determinado y se clausuran al agotarlo.', 'age_aux_b1_03_cortes_defensor', (select id from public.topics where slug = 'age-aux-b1-03-cortes-defensor'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1978-31229'), 'Art. 73.2 CE', 'Las Cámaras podrán reunirse en sesiones extraordinarias a petición del Gobierno, de la Diputación Permanente o de la mayoría absoluta de los miembros de cualquiera de las Cámaras.', null, 'b3c59dab0b4e63c564d3876fa73aa2c923c40be8be6c458a5e149bf7ddf6c90d', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'b3c59dab0b4e63c564d3876fa73aa2c923c40be8be6c458a5e149bf7ddf6c90d')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El Rey, el Gobierno o la mayoría absoluta de los miembros de cualquiera de las Cámaras.', false), ('B', 'El Gobierno, la Diputación Permanente o una quinta parte de los miembros de cualquiera de las Cámaras.', false), ('C', 'El Gobierno, la Diputación Permanente o la mayoría absoluta de los miembros de cualquiera de las Cámaras.', true), ('D', 'El Presidente del Congreso, la Diputación Permanente o la mayoría absoluta de los miembros de ambas Cámaras.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 75 de la Constitución, ¿cuál de las siguientes materias no puede delegarse por las Cámaras en las Comisiones Legislativas Permanentes?', 'El art. 75.3 CE excluye de la delegación en Comisiones la reforma constitucional, las cuestiones internacionales, las leyes orgánicas y de bases y los Presupuestos Generales del Estado.', 'age_aux_b1_03_cortes_defensor', (select id from public.topics where slug = 'age-aux-b1-03-cortes-defensor'), 3, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1978-31229'), 'Art. 75.3 CE', 'Quedan exceptuados de lo dispuesto en el apartado anterior la reforma constitucional, las cuestiones internacionales, las leyes orgánicas y de bases y los Presupuestos Generales del Estado.', null, '88f09b1368f025a3b31c86fae31830f0a66790b88d4ae5e3951d5729177cbbd7', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '88f09b1368f025a3b31c86fae31830f0a66790b88d4ae5e3951d5729177cbbd7')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Las leyes ordinarias sobre materias no reservadas a ley orgánica.', false), ('B', 'Las proposiciones de ley de iniciativa popular.', false), ('C', 'Las leyes ordinarias que desarrollen principios rectores de la política social y económica.', false), ('D', 'Los Presupuestos Generales del Estado.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 78.1 de la Constitución, en cada Cámara habrá una Diputación Permanente compuesta por:', 'El art. 78.1 CE exige un mínimo de veintiún miembros, en representación proporcional de los grupos parlamentarios. La preside el Presidente de la Cámara respectiva (art. 78.2).', 'age_aux_b1_03_cortes_defensor', (select id from public.topics where slug = 'age-aux-b1-03-cortes-defensor'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1978-31229'), 'Art. 78.1 CE', 'En cada Cámara habrá una Diputación Permanente compuesta por un mínimo de veintiún miembros, que representarán a los grupos parlamentarios, en proporción a su importancia numérica.', null, 'b23a5eda422cf8d18894feeec6a54aa7388cf25a24b6cb9360a72dd9bb12e305', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'b23a5eda422cf8d18894feeec6a54aa7388cf25a24b6cb9360a72dd9bb12e305')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Un máximo de veintiún miembros, que representarán a los grupos parlamentarios por partes iguales.', false), ('B', 'Un mínimo de veintiún miembros, que representarán a los grupos parlamentarios en proporción a su importancia numérica.', true), ('C', 'Un mínimo de quince miembros, que representarán a los grupos parlamentarios en proporción a su importancia numérica.', false), ('D', 'Veinte miembros, elegidos por mayoría absoluta del Pleno.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 81.2 de la Constitución, la aprobación, modificación o derogación de las leyes orgánicas exigirá:', 'El art. 81.2 CE exige mayoría absoluta del Congreso en una votación final sobre el conjunto del proyecto.', 'age_aux_b1_03_cortes_defensor', (select id from public.topics where slug = 'age-aux-b1-03-cortes-defensor'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1978-31229'), 'Art. 81.2 CE', 'La aprobación, modificación o derogación de las leyes orgánicas exigirá mayoría absoluta del Congreso, en una votación final sobre el conjunto del proyecto.', null, 'd3e69cfe102d44009def0b291c475831fca11fc6db2021a94ee46bb39b9f22bf', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'd3e69cfe102d44009def0b291c475831fca11fc6db2021a94ee46bb39b9f22bf')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Mayoría absoluta del Congreso, en una votación final sobre el conjunto del proyecto.', true), ('B', 'Mayoría absoluta de ambas Cámaras, en una votación final sobre el conjunto del proyecto.', false), ('C', 'Mayoría de tres quintos del Congreso, en una votación final sobre el conjunto del proyecto.', false), ('D', 'Mayoría absoluta del Congreso en cada uno de los artículos del proyecto.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 90 de la Constitución, el plazo de dos meses de que dispone el Senado para vetar o enmendar un proyecto de ley se reducirá, en los proyectos declarados urgentes por el Gobierno o por el Congreso, a:', 'El Senado dispone de dos meses para vetar (por mayoría absoluta) o enmendar; en los proyectos declarados urgentes el plazo se reduce a veinte días naturales (art. 90.3 CE).', 'age_aux_b1_03_cortes_defensor', (select id from public.topics where slug = 'age-aux-b1-03-cortes-defensor'), 3, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1978-31229'), 'Art. 90.2 y 90.3 CE', 'El plazo de dos meses de que el Senado dispone para vetar o enmendar el proyecto se reducirá al de veinte días naturales en los proyectos declarados urgentes por el Gobierno o por el Congreso de los Diputados.', null, '453fc4bb0d588c577aa8a990b154e102d9a866f27de6627149d463bd4cfe42d2', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '453fc4bb0d588c577aa8a990b154e102d9a866f27de6627149d463bd4cfe42d2')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Quince días hábiles.', false), ('B', 'Treinta días naturales.', false), ('C', 'Diez días naturales.', false), ('D', 'Veinte días naturales.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 54 de la Constitución, el Defensor del Pueblo es:', 'El art. 54 CE configura al Defensor del Pueblo como alto comisionado de las Cortes Generales, designado por ellas para defender los derechos del Título I, pudiendo supervisar la actividad de la Administración.', 'age_aux_b1_03_cortes_defensor', (select id from public.topics where slug = 'age-aux-b1-03-cortes-defensor'), 1, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1978-31229'), 'Art. 54 CE', 'Una ley orgánica regulará la institución del Defensor del Pueblo, como alto comisionado de las Cortes Generales, designado por éstas para la defensa de los derechos comprendidos en este Título, a cuyo efecto podrá supervisar la actividad de la Administración, dando cuenta a las Cortes Generales.', null, '1e01571936baf0d70f1f27482f088373fe362cd044ad1e92dc608378863c3ad6', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '1e01571936baf0d70f1f27482f088373fe362cd044ad1e92dc608378863c3ad6')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Alto comisionado del Gobierno, designado por éste para la defensa de los derechos comprendidos en el Título I.', false), ('B', 'Órgano del Consejo General del Poder Judicial para la defensa de los derechos fundamentales.', false), ('C', 'Alto comisionado de las Cortes Generales, designado por éstas para la defensa de los derechos comprendidos en el Título I.', true), ('D', 'Alto comisionado del Congreso de los Diputados, designado por el Rey.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
-- Lote age-aux-b1-03-cortes-defensor-lodp-v1 (6 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Ley Orgánica 3/1981, de 6 de abril, del Defensor del Pueblo (texto consolidado, BOE)', 'https://www.boe.es/buscar/act.php?id=BOE-A-1981-10325', 'boe'::public.source_kind, 'Agencia Estatal Boletín Oficial del Estado', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('age-aux-b1-03-cortes-defensor', 'I.3 Las Cortes Generales y el Defensor del Pueblo') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug = 'auxiliar-administrativo-estado' and t.slug = 'age-aux-b1-03-cortes-defensor' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según la Ley Orgánica 3/1981, del Defensor del Pueblo, ¿por cuánto tiempo es elegido el Defensor del Pueblo?', 'El art. 2.1 LODP dispone que el Defensor del Pueblo es elegido por las Cortes Generales para un periodo de cinco años.', 'age_aux_b1_03_cortes_defensor', (select id from public.topics where slug = 'age-aux-b1-03-cortes-defensor'), 1, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1981-10325'), 'Art. 2.1 LO 3/1981', 'El Defensor del Pueblo será elegido por las Cortes Generales para un periodo de cinco años', null, '830285444e5381c4ed0410d554d053a72978bc7a72e4683ff2e25b891f626cfe', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '830285444e5381c4ed0410d554d053a72978bc7a72e4683ff2e25b891f626cfe')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Por un periodo de cinco años.', true), ('B', 'Por un periodo de cuatro años.', false), ('C', 'Por un periodo de seis años.', false), ('D', 'Por un periodo de nueve años.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según la Ley Orgánica del Defensor del Pueblo, si en la primera propuesta no se alcanzan las mayorías exigidas y se formulan sucesivas propuestas, una vez conseguida la mayoría de tres quintos en el Congreso, la designación quedará realizada al alcanzarse en el Senado:', 'En la primera votación se exigen tres quintos del Congreso y ratificación por la misma mayoría del Senado en un plazo máximo de veinte días (art. 2.4). En las sucesivas propuestas, logrados los tres quintos en el Congreso, basta la mayoría absoluta del Senado (art. 2.5).', 'age_aux_b1_03_cortes_defensor', (select id from public.topics where slug = 'age-aux-b1-03-cortes-defensor'), 3, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1981-10325'), 'Art. 2.4 y 2.5 LO 3/1981', 'En tales casos, una vez conseguida la mayoría de los tres quintos en el Congreso, la designación quedará realizada al alcanzarse la mayoría absoluta del Senado.', null, '6f96f91b274f95e70e7fbc39131a9aec17e8a3ec3d7b2923b9d93eefafdc4216', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '6f96f91b274f95e70e7fbc39131a9aec17e8a3ec3d7b2923b9d93eefafdc4216')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'La mayoría de tres quintos.', false), ('B', 'La mayoría absoluta.', true), ('C', 'La mayoría simple.', false), ('D', 'La mayoría de dos tercios.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según la Ley Orgánica del Defensor del Pueblo, mientras permanezca en el ejercicio de sus funciones, la decisión sobre la inculpación, prisión, procesamiento y juicio del Defensor del Pueblo corresponde exclusivamente a:', 'El art. 6.3 LODP dispone que el Defensor del Pueblo solo puede ser detenido o retenido en flagrante delito y que la decisión sobre su inculpación, prisión, procesamiento y juicio corresponde exclusivamente a la Sala de lo Penal del Tribunal Supremo.', 'age_aux_b1_03_cortes_defensor', (select id from public.topics where slug = 'age-aux-b1-03-cortes-defensor'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1981-10325'), 'Art. 6.3 LO 3/1981', 'correspondiendo la decisión sobre su inculpación, prisión, procesamiento y juicio exclusivamente a la Sala de lo Penal del Tribunal Supremo.', null, '4f359fdcce55cd413c1d5d4a2f8f37977c4e733e482928573af8bcd7efec495e', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '4f359fdcce55cd413c1d5d4a2f8f37977c4e733e482928573af8bcd7efec495e')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'La Sala de lo Penal de la Audiencia Nacional.', false), ('B', 'El Pleno del Tribunal Constitucional.', false), ('C', 'La Sala de lo Penal del Tribunal Supremo.', true), ('D', 'La Comisión Mixta Congreso-Senado de relaciones con el Defensor del Pueblo.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según la Ley Orgánica del Defensor del Pueblo, cuando el Defensor del Pueblo reciba quejas referidas al funcionamiento de la Administración de Justicia, deberá dirigirlas:', 'El art. 13 LODP obliga a dirigir esas quejas al Ministerio Fiscal, para que investigue y adopte medidas, o a dar traslado al Consejo General del Poder Judicial, según el tipo de reclamación, sin perjuicio de mencionarlo en su informe general a las Cortes.', 'age_aux_b1_03_cortes_defensor', (select id from public.topics where slug = 'age-aux-b1-03-cortes-defensor'), 3, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1981-10325'), 'Art. 13 LO 3/1981', 'Cuando el Defensor del Pueblo reciba quejas referidas al funcionamiento de la Administración de Justicia, deberá dirigirlas al Ministerio Fiscal para que éste investigue su realidad y adopte las medidas oportunas con arreglo a la ley, o bien dé traslado de las mismas al Consejo General del Poder Judicial, según el tipo de reclamación de que se trate', null, '9f1e33f16e4ea8df2ea62eac042793c37d942dc2c5393ed366a6265b5e46e26b', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '9f1e33f16e4ea8df2ea62eac042793c37d942dc2c5393ed366a6265b5e46e26b')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Al Ministerio de Justicia, para que investigue su realidad.', false), ('B', 'A la Sala de Gobierno del Tribunal Supremo.', false), ('C', 'Al Tribunal Constitucional, cuando afecten a derechos fundamentales.', false), ('D', 'Al Ministerio Fiscal o al Consejo General del Poder Judicial, según el tipo de reclamación de que se trate.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según la Ley Orgánica del Defensor del Pueblo, ¿en qué plazo máximo debe presentarse una queja?', 'El art. 15.1 LODP exige que la queja se presente firmada, con nombre, apellidos y domicilio, en escrito razonado y en el plazo máximo de un año desde que se tuvo conocimiento de los hechos.', 'age_aux_b1_03_cortes_defensor', (select id from public.topics where slug = 'age-aux-b1-03-cortes-defensor'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1981-10325'), 'Art. 15.1 LO 3/1981', 'Toda queja se presentará firmada por el interesado, con indicación de su nombre, apellidos y domicilio, en escrito razonado en papel común y en el plazo máximo de un año, contado a partir del momento en que tuviera conocimiento de los hechos objeto de la misma.', null, 'dab580686efb17edbea60d4efb609bab2027ce87884818fe4e5b5727ddb2f47d', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'dab580686efb17edbea60d4efb609bab2027ce87884818fe4e5b5727ddb2f47d')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Seis meses, contados a partir del momento en que el interesado tuviera conocimiento de los hechos.', false), ('B', 'Un año, contado a partir del momento en que el interesado tuviera conocimiento de los hechos.', true), ('C', 'Tres meses, contados desde que se produjeron los hechos.', false), ('D', 'Dos años, contados desde que se produjeron los hechos.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según la Ley Orgánica del Defensor del Pueblo, ¿qué tratamiento reciben las quejas anónimas?', 'El art. 17.3 LODP obliga a rechazar las quejas anónimas; en cambio, las quejas con mala fe, carencia de fundamento o inexistencia de pretensión «podrá» rechazarlas. Sus decisiones no son susceptibles de recurso.', 'age_aux_b1_03_cortes_defensor', (select id from public.topics where slug = 'age-aux-b1-03-cortes-defensor'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1981-10325'), 'Art. 17.3 LO 3/1981', 'El Defensor del Pueblo rechazará las quejas anónimas y podrá rechazar aquellas en las que advierta mala fe, carencia de fundamento, inexistencia de pretensión', null, 'dad63092f81b58e00e06837ea9d848295c2c196fd40019c1a6a2a9f74163674f', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'dad63092f81b58e00e06837ea9d848295c2c196fd40019c1a6a2a9f74163674f')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El Defensor del Pueblo las rechazará.', true), ('B', 'El Defensor del Pueblo podrá rechazarlas si advierte mala fe.', false), ('C', 'Se tramitarán si se refieren a la Administración Militar.', false), ('D', 'Se remitirán al Ministerio Fiscal.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
-- Lote age-aux-b1-04-poder-judicial-ce-v1 (11 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Constitución Española (texto consolidado, BOE)', 'https://www.boe.es/buscar/act.php?id=BOE-A-1978-31229', 'boe'::public.source_kind, 'Agencia Estatal Boletín Oficial del Estado', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('age-aux-b1-04-poder-judicial', 'I.4 El Poder Judicial') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug = 'auxiliar-administrativo-estado' and t.slug = 'age-aux-b1-04-poder-judicial' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 117.1 de la Constitución, la justicia emana del pueblo y se administra:', 'El art. 117.1 CE dispone que la justicia emana del pueblo y se administra en nombre del Rey por Jueces y Magistrados independientes, inamovibles, responsables y sometidos únicamente al imperio de la ley.', 'age_aux_b1_04_poder_judicial', (select id from public.topics where slug = 'age-aux-b1-04-poder-judicial'), 1, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1978-31229'), 'Art. 117.1 CE', 'La justicia emana del pueblo y se administra en nombre del Rey por Jueces y Magistrados integrantes del poder judicial, independientes, inamovibles, responsables y sometidos únicamente al imperio de la ley.', null, '55d69d7958f4952778cbe9aef6fcf69a9f4952c533dff30c9dc0d15f3427da64', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '55d69d7958f4952778cbe9aef6fcf69a9f4952c533dff30c9dc0d15f3427da64')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'En nombre del Rey por Jueces y Magistrados integrantes del poder judicial.', true), ('B', 'En nombre del pueblo español por Jueces y Magistrados integrantes del poder judicial.', false), ('C', 'En nombre del Estado por los Juzgados y Tribunales bajo la dirección del Consejo General del Poder Judicial.', false), ('D', 'En nombre de las Cortes Generales por Jueces y Magistrados de carrera.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 117.5 de la Constitución, ¿qué principio es la base de la organización y funcionamiento de los Tribunales?', 'El art. 117.5 CE proclama la unidad jurisdiccional como base de la organización y funcionamiento de los Tribunales. La unidad de actuación y la dependencia jerárquica son principios del Ministerio Fiscal (art. 124.2).', 'age_aux_b1_04_poder_judicial', (select id from public.topics where slug = 'age-aux-b1-04-poder-judicial'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1978-31229'), 'Art. 117.5 CE', 'El principio de unidad jurisdiccional es la base de la organización y funcionamiento de los Tribunales.', null, '14dbc32b31a4710f7f04c7ad9ccbc22c57535fdfe88f18ba9245ad93da70fd81', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '14dbc32b31a4710f7f04c7ad9ccbc22c57535fdfe88f18ba9245ad93da70fd81')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El principio de dependencia jerárquica.', false), ('B', 'El principio de unidad de actuación.', false), ('C', 'El principio de exclusividad territorial.', false), ('D', 'El principio de unidad jurisdiccional.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 117 de la Constitución, ¿qué tribunales se prohíben?', 'El art. 117.6 CE prohíbe los Tribunales de excepción. Los Tribunales consuetudinarios y tradicionales y el Jurado están previstos en el art. 125, y la jurisdicción militar en el art. 117.5.', 'age_aux_b1_04_poder_judicial', (select id from public.topics where slug = 'age-aux-b1-04-poder-judicial'), 1, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1978-31229'), 'Art. 117.6 CE', 'Se prohíben los Tribunales de excepción.', null, 'e6b21294d50237d5d4893dc6763d67a25fb8d0752c8195c4ae46935a17c05854', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'e6b21294d50237d5d4893dc6763d67a25fb8d0752c8195c4ae46935a17c05854')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Los Tribunales consuetudinarios y tradicionales.', false), ('B', 'Los Tribunales de excepción.', true), ('C', 'Los Tribunales militares.', false), ('D', 'Los Tribunales con Jurado.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 119 de la Constitución, la justicia será gratuita:', 'El art. 119 CE remite a la ley los casos de gratuidad y la garantiza en todo caso a quienes acrediten insuficiencia de recursos para litigar.', 'age_aux_b1_04_poder_judicial', (select id from public.topics where slug = 'age-aux-b1-04-poder-judicial'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1978-31229'), 'Art. 119 CE', 'La justicia será gratuita cuando así lo disponga la ley y, en todo caso, respecto de quienes acrediten insuficiencia de recursos para litigar.', null, 'e7c37c11db3164bad8e616cff1cba20c262635d08c44ac8722c72b35b61b57ca', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'e7c37c11db3164bad8e616cff1cba20c262635d08c44ac8722c72b35b61b57ca')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'En todo caso y para todos los ciudadanos.', false), ('B', 'Únicamente en los procesos penales.', false), ('C', 'Cuando así lo disponga la ley y, en todo caso, respecto de quienes acrediten insuficiencia de recursos para litigar.', true), ('D', 'Únicamente respecto de quienes acrediten insuficiencia de recursos para litigar, sin que la ley pueda ampliar ese supuesto.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 120.3 de la Constitución, las sentencias:', 'El art. 120.3 CE exige que las sentencias sean siempre motivadas y se pronuncien en audiencia pública.', 'age_aux_b1_04_poder_judicial', (select id from public.topics where slug = 'age-aux-b1-04-poder-judicial'), 1, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1978-31229'), 'Art. 120.3 CE', 'Las sentencias serán siempre motivadas y se pronunciarán en audiencia pública.', null, 'a680d55b5abed063f3e29466617a625209b2feb9e511c3d0718a00c9d92075d4', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'a680d55b5abed063f3e29466617a625209b2feb9e511c3d0718a00c9d92075d4')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Serán motivadas solo cuando sean condenatorias.', false), ('B', 'Se pronunciarán en audiencia pública solo en materia criminal.', false), ('C', 'Serán siempre motivadas y se pronunciarán en audiencia pública.', true), ('D', 'Serán siempre motivadas y se notificarán por escrito sin audiencia pública.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 122.3 de la Constitución, el Consejo General del Poder Judicial está integrado por el Presidente del Tribunal Supremo, que lo presidirá, y por:', 'El art. 122.3 CE fija veinte miembros nombrados por el Rey por cinco años, además del Presidente del Tribunal Supremo, que lo preside.', 'age_aux_b1_04_poder_judicial', (select id from public.topics where slug = 'age-aux-b1-04-poder-judicial'), 1, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1978-31229'), 'Art. 122.3 CE', 'El Consejo General del Poder Judicial estará integrado por el Presidente del Tribunal Supremo, que lo presidirá, y por veinte miembros nombrados por el Rey por un período de cinco años.', null, '3e7f8d4adc826900353a6f4af5a037540762945d8713dedf3d5636d87023c4a5', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '3e7f8d4adc826900353a6f4af5a037540762945d8713dedf3d5636d87023c4a5')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Veinte miembros nombrados por el Rey por un período de cuatro años.', false), ('B', 'Doce miembros nombrados por el Rey por un período de nueve años.', false), ('C', 'Veinte miembros elegidos por las Cortes Generales por un período de seis años.', false), ('D', 'Veinte miembros nombrados por el Rey por un período de cinco años.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 122.3 de la Constitución, los cuatro miembros del Consejo General del Poder Judicial propuestos por el Congreso de los Diputados y los cuatro propuestos por el Senado se eligen:', 'El art. 122.3 CE exige mayoría de tres quintos en cada Cámara y que los elegidos sean abogados u otros juristas de reconocida competencia con más de quince años de ejercicio profesional.', 'age_aux_b1_04_poder_judicial', (select id from public.topics where slug = 'age-aux-b1-04-poder-judicial'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1978-31229'), 'Art. 122.3 CE', 'cuatro a propuesta del Congreso de los Diputados, y cuatro a propuesta del Senado, elegidos en ambos casos por mayoría de tres quintos de sus miembros, entre abogados y otros juristas, todos ellos de reconocida competencia y con más de quince años de ejercicio en su profesión.', null, '46e8f0f5f9d0aff9298034a51e4dd2417894846f44ae372d4402fd1698000a4f', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '46e8f0f5f9d0aff9298034a51e4dd2417894846f44ae372d4402fd1698000a4f')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Por mayoría absoluta de sus miembros, entre abogados y otros juristas de reconocida competencia con más de quince años de ejercicio en su profesión.', false), ('B', 'Por mayoría de tres quintos de sus miembros, entre abogados y otros juristas de reconocida competencia con más de quince años de ejercicio en su profesión.', true), ('C', 'Por mayoría de tres quintos de sus miembros, entre abogados y otros juristas de reconocida competencia con más de diez años de ejercicio en su profesión.', false), ('D', 'Por mayoría de dos tercios de sus miembros, entre Jueces y Magistrados de todas las categorías judiciales.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 123.1 de la Constitución, el Tribunal Supremo, con jurisdicción en toda España, es el órgano jurisdiccional superior en todos los órdenes:', 'El art. 123.1 CE exceptúa de la superioridad del Tribunal Supremo lo dispuesto en materia de garantías constitucionales, que corresponde al Tribunal Constitucional.', 'age_aux_b1_04_poder_judicial', (select id from public.topics where slug = 'age-aux-b1-04-poder-judicial'), 1, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1978-31229'), 'Art. 123.1 CE', 'El Tribunal Supremo, con jurisdicción en toda España, es el órgano jurisdiccional superior en todos los órdenes, salvo lo dispuesto en materia de garantías constitucionales.', null, '667ceeee33b145f285b029a0e2f383149bc30f06fc788feb7620271859dd4faa', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '667ceeee33b145f285b029a0e2f383149bc30f06fc788feb7620271859dd4faa')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Salvo lo dispuesto en materia de garantías constitucionales.', true), ('B', 'Sin excepción alguna.', false), ('C', 'Salvo en el orden jurisdiccional militar.', false), ('D', 'Salvo en las materias atribuidas a los Tribunales Superiores de Justicia.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 123.2 de la Constitución, el Presidente del Tribunal Supremo será nombrado:', 'El art. 123.2 CE atribuye el nombramiento al Rey a propuesta del Consejo General del Poder Judicial. La fórmula «a propuesta del Gobierno, oído el Consejo General del Poder Judicial» corresponde al Fiscal General del Estado (art. 124.4).', 'age_aux_b1_04_poder_judicial', (select id from public.topics where slug = 'age-aux-b1-04-poder-judicial'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1978-31229'), 'Art. 123.2 CE', 'El Presidente del Tribunal Supremo será nombrado por el Rey, a propuesta del Consejo General del Poder Judicial, en la forma que determine la ley.', null, '0ff8eadc1d621cf79fe78192154c0234f6afab97661519d38d0e7c21e00b3d37', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '0ff8eadc1d621cf79fe78192154c0234f6afab97661519d38d0e7c21e00b3d37')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Por el Rey, a propuesta del Gobierno, oído el Consejo General del Poder Judicial.', false), ('B', 'Por el Rey, a propuesta del Congreso de los Diputados.', false), ('C', 'Por el Consejo General del Poder Judicial, a propuesta de la Sala de Gobierno del Tribunal Supremo.', false), ('D', 'Por el Rey, a propuesta del Consejo General del Poder Judicial.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 124.4 de la Constitución, el Fiscal General del Estado será nombrado por el Rey:', 'El art. 124.4 CE establece que el Fiscal General del Estado es nombrado por el Rey a propuesta del Gobierno, oído el Consejo General del Poder Judicial.', 'age_aux_b1_04_poder_judicial', (select id from public.topics where slug = 'age-aux-b1-04-poder-judicial'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1978-31229'), 'Art. 124.4 CE', 'El Fiscal General del Estado será nombrado por el Rey, a propuesta del Gobierno, oído el Consejo General del Poder Judicial.', null, 'fcd0d309d87e593d42d06efbf71f91d6897fa94828ee738755a1043f1653a872', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'fcd0d309d87e593d42d06efbf71f91d6897fa94828ee738755a1043f1653a872')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'A propuesta del Gobierno, oído el Consejo General del Poder Judicial.', true), ('B', 'A propuesta del Consejo General del Poder Judicial, oído el Gobierno.', false), ('C', 'A propuesta del Congreso de los Diputados, por mayoría de tres quintos.', false), ('D', 'A propuesta del Ministro de Justicia, oído el Consejo Fiscal.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 127.1 de la Constitución, los Jueces y Magistrados, así como los Fiscales, mientras se hallen en activo:', 'El art. 127.1 CE prohíbe a Jueces, Magistrados y Fiscales en activo desempeñar otros cargos públicos y pertenecer a partidos políticos o sindicatos; la ley establece el sistema y modalidades de su asociación profesional.', 'age_aux_b1_04_poder_judicial', (select id from public.topics where slug = 'age-aux-b1-04-poder-judicial'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1978-31229'), 'Art. 127.1 CE', 'Los Jueces y Magistrados así como los Fiscales, mientras se hallen en activo, no podrán desempeñar otros cargos públicos, ni pertenecer a partidos políticos o sindicatos. La ley establecerá el sistema y modalidades de asociación profesional de los Jueces, Magistrados y Fiscales.', null, '79b80267c9816e3ebbd30294639ef6ac518c758ea92b86c10ab2547fb1ef6d4f', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '79b80267c9816e3ebbd30294639ef6ac518c758ea92b86c10ab2547fb1ef6d4f')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'No podrán pertenecer a partidos políticos, pero sí a sindicatos.', false), ('B', 'No podrán desempeñar otros cargos públicos ni pertenecer a partidos políticos o sindicatos.', true), ('C', 'Podrán pertenecer a partidos políticos, pero no desempeñar cargos directivos en ellos.', false), ('D', 'No podrán pertenecer a asociaciones profesionales de ningún tipo.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
-- Lote age-aux-b1-04-poder-judicial-lopj-v1 (9 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Ley Orgánica 6/1985, de 1 de julio, del Poder Judicial (texto consolidado, BOE)', 'https://www.boe.es/buscar/act.php?id=BOE-A-1985-12666', 'boe'::public.source_kind, 'Agencia Estatal Boletín Oficial del Estado', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('age-aux-b1-04-poder-judicial', 'I.4 El Poder Judicial') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug = 'auxiliar-administrativo-estado' and t.slug = 'age-aux-b1-04-poder-judicial' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'De acuerdo con el artículo 567.2 de la Ley Orgánica del Poder Judicial, cada una de las Cámaras elige, por mayoría de tres quintos de sus miembros, a diez Vocales del Consejo General del Poder Judicial, de los cuales:', 'Cada Cámara elige diez Vocales: cuatro juristas y seis del turno judicial. Así se completan los veinte Vocales del art. 566 LOPJ: doce Jueces o Magistrados y ocho juristas de reconocida competencia.', 'age_aux_b1_04_poder_judicial', (select id from public.topics where slug = 'age-aux-b1-04-poder-judicial'), 3, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1985-12666'), 'Art. 567.2 LOPJ', 'Cada una de las Cámaras elegirá, por mayoría de tres quintos de sus miembros, a diez Vocales, cuatro entre juristas de reconocida competencia con más de quince años de ejercicio en su profesión y seis correspondientes al turno judicial', null, '31eab12030535195d07865cedbdc9927c4d729f56550c525233a0d0b76272f9b', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '31eab12030535195d07865cedbdc9927c4d729f56550c525233a0d0b76272f9b')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Seis entre juristas de reconocida competencia con más de quince años de ejercicio y cuatro correspondientes al turno judicial.', false), ('B', 'Cinco entre juristas de reconocida competencia con más de quince años de ejercicio y cinco correspondientes al turno judicial.', false), ('C', 'Cuatro entre juristas de reconocida competencia con más de quince años de ejercicio y seis correspondientes al turno judicial.', true), ('D', 'Dos entre juristas de reconocida competencia con más de quince años de ejercicio y ocho correspondientes al turno judicial.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según la Ley Orgánica del Poder Judicial, ¿qué mayoría se exige en el Pleno del Consejo General del Poder Judicial para elegir al Presidente del Tribunal Supremo y del Consejo?', 'El art. 586.3 LOPJ exige el apoyo de la mayoría de tres quintos de los miembros del Pleno en votación nominal, en una sesión celebrada entre tres y siete días después de la constitutiva.', 'age_aux_b1_04_poder_judicial', (select id from public.topics where slug = 'age-aux-b1-04-poder-judicial'), 3, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1985-12666'), 'Art. 586.3 LOPJ', 'La elección tendrá lugar en una sesión a celebrar entre tres y siete días más tarde, siendo elegido quien en votación nominal obtenga el apoyo de la mayoría de tres quintos de los miembros del Pleno.', null, '4385934257ae4c92dbce00508773d29cfac54a674aaa2d835f4413072a283e39', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '4385934257ae4c92dbce00508773d29cfac54a674aaa2d835f4413072a283e39')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'La mayoría absoluta de los miembros del Pleno, en votación secreta.', false), ('B', 'La mayoría de tres quintos de los miembros del Pleno, en votación nominal.', true), ('C', 'La mayoría de dos tercios de los miembros del Pleno, en votación nominal.', false), ('D', 'La mayoría simple de los miembros presentes, en votación secreta.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según la Ley Orgánica del Poder Judicial, la Comisión Permanente del Consejo General del Poder Judicial está compuesta por el Presidente del Tribunal Supremo y del Consejo, que la presidirá, y:', 'El art. 601.2 LOPJ fija la composición de la Comisión Permanente: Presidente y siete Vocales (cuatro del turno judicial y tres juristas), renovados anualmente.', 'age_aux_b1_04_poder_judicial', (select id from public.topics where slug = 'age-aux-b1-04-poder-judicial'), 3, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1985-12666'), 'Art. 601.2 LOPJ', 'La Comisión Permanente estará compuesta por el Presidente del Tribunal Supremo y del Consejo General del Poder Judicial, que la presidirá, y otros siete Vocales: cuatro de los nombrados por el turno judicial y tres de los designados por el turno de juristas de reconocida competencia.', null, '72ff7166592a3c81d7c05a04cfefa35f6b7c2b1f67665bafbdd498a0446eee9b', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '72ff7166592a3c81d7c05a04cfefa35f6b7c2b1f67665bafbdd498a0446eee9b')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Otros siete Vocales: tres del turno judicial y cuatro del turno de juristas de reconocida competencia.', false), ('B', 'Otros cinco Vocales: tres del turno judicial y dos del turno de juristas de reconocida competencia.', false), ('C', 'Otros siete Vocales: cuatro del turno judicial y tres del turno de juristas de reconocida competencia.', true), ('D', 'Otros nueve Vocales: seis del turno judicial y tres del turno de juristas de reconocida competencia.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según la Ley Orgánica del Poder Judicial, ¿cuál es la Sala Tercera del Tribunal Supremo?', 'El art. 55 LOPJ enumera las Salas del Tribunal Supremo: Primera, de lo Civil; Segunda, de lo Penal; Tercera, de lo Contencioso-Administrativo; Cuarta, de lo Social; y Quinta, de lo Militar.', 'age_aux_b1_04_poder_judicial', (select id from public.topics where slug = 'age-aux-b1-04-poder-judicial'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1985-12666'), 'Art. 55 LOPJ', 'El Tribunal Supremo estará integrado por las siguientes Salas: Primera: De lo Civil. Segunda: De lo Penal. Tercera: De lo Contencioso-Administrativo. Cuarta: De lo Social. Quinta: De lo Militar', null, '1bd69accd265b197f359aa765568df4f0de7efc34e2e8dcdc148147e53f1f0ae', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '1bd69accd265b197f359aa765568df4f0de7efc34e2e8dcdc148147e53f1f0ae')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'La de lo Social.', false), ('B', 'La de lo Penal.', false), ('C', 'La de lo Militar.', false), ('D', 'La de lo Contencioso-Administrativo.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 61 de la Ley Orgánica del Poder Judicial, ¿qué órgano conoce de los procesos de declaración de ilegalidad y consecuente disolución de los partidos políticos?', 'El art. 61.1.6.º LOPJ atribuye estos procesos a la llamada Sala especial del art. 61, formada por el Presidente del Tribunal Supremo, los Presidentes de Sala y el Magistrado más antiguo y el más moderno de cada Sala.', 'age_aux_b1_04_poder_judicial', (select id from public.topics where slug = 'age-aux-b1-04-poder-judicial'), 3, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1985-12666'), 'Art. 61.1.6.º LOPJ', 'Una Sala formada por el Presidente del Tribunal Supremo, los Presidentes de Sala y el Magistrado más antiguo y el más moderno de cada una de ellas conocerá: […] De los procesos de declaración de ilegalidad y consecuente disolución de los partidos políticos', null, '575a5d6e01f14d3dc5afc4fcccb1d8c1e58619b8186345cab84d3b4077e8a93e', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '575a5d6e01f14d3dc5afc4fcccb1d8c1e58619b8186345cab84d3b4077e8a93e')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Una Sala del Tribunal Supremo formada por su Presidente, los Presidentes de Sala y el Magistrado más antiguo y el más moderno de cada una de ellas.', true), ('B', 'La Sala de lo Penal del Tribunal Supremo.', false), ('C', 'La Sala de lo Contencioso-Administrativo de la Audiencia Nacional.', false), ('D', 'El Pleno del Tribunal Constitucional.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según la Ley Orgánica del Poder Judicial, ¿cuál de las siguientes Salas forma parte de la Audiencia Nacional?', 'La Audiencia Nacional tiene Salas de Apelación, de lo Penal, de lo Contencioso-Administrativo y de lo Social (art. 64.1 LOPJ). No tiene Sala de lo Civil; la Sala de lo Militar es del Tribunal Supremo y la de lo Civil y Penal, de los Tribunales Superiores de Justicia.', 'age_aux_b1_04_poder_judicial', (select id from public.topics where slug = 'age-aux-b1-04-poder-judicial'), 3, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1985-12666'), 'Art. 64.1 LOPJ', 'La Audiencia Nacional estará integrada por las siguientes Salas: De Apelación. De lo Penal. De lo Contencioso-Administrativo. De lo Social.', null, '0eed230e87c8cd1867525482f40efaaedae42c13589d954e446c5d1e58c114be', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '0eed230e87c8cd1867525482f40efaaedae42c13589d954e446c5d1e58c114be')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'La Sala de lo Civil.', false), ('B', 'La Sala de Apelación.', true), ('C', 'La Sala de lo Militar.', false), ('D', 'La Sala de lo Civil y Penal.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según la Ley Orgánica del Poder Judicial, el Tribunal Superior de Justicia estará integrado por las siguientes Salas:', 'El art. 72.1 LOPJ dispone tres Salas en cada Tribunal Superior de Justicia: de lo Civil y Penal, de lo Contencioso-Administrativo y de lo Social. Su Presidente lo es también de la Sala de lo Civil y Penal.', 'age_aux_b1_04_poder_judicial', (select id from public.topics where slug = 'age-aux-b1-04-poder-judicial'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1985-12666'), 'Art. 72.1 LOPJ', 'El Tribunal Superior de Justicia estará integrado por las siguientes Salas: de lo Civil y Penal, de lo Contencioso-Administrativo y de lo Social.', null, 'cf50383c105e085e43d98730609b4f8c8dda1daf7c8bb4b70c9078b9e006e679', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'cf50383c105e085e43d98730609b4f8c8dda1daf7c8bb4b70c9078b9e006e679')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'De lo Civil, de lo Penal, de lo Contencioso-Administrativo y de lo Social.', false), ('B', 'De Apelación, de lo Contencioso-Administrativo y de lo Social.', false), ('C', 'De lo Civil y Penal, de lo Contencioso-Administrativo, de lo Social y de lo Militar.', false), ('D', 'De lo Civil y Penal, de lo Contencioso-Administrativo y de lo Social.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según la Ley Orgánica del Poder Judicial, el Estado se organiza territorialmente, a efectos judiciales, en:', 'El art. 30 LOPJ establece la división territorial judicial en Municipios, Partidos, Provincias y Comunidades Autónomas.', 'age_aux_b1_04_poder_judicial', (select id from public.topics where slug = 'age-aux-b1-04-poder-judicial'), 1, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1985-12666'), 'Art. 30 LOPJ', 'El Estado se organiza territorialmente, a efectos judiciales, en Municipios, Partidos, Provincias y Comunidades Autónomas.', null, '5cf8864a9b201dc86a39a0d52238f6a00455ff4d71da7058d9440d4911f89895', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '5cf8864a9b201dc86a39a0d52238f6a00455ff4d71da7058d9440d4911f89895')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Municipios, Comarcas, Provincias y Comunidades Autónomas.', false), ('B', 'Partidos, Provincias y Comunidades Autónomas.', false), ('C', 'Municipios, Partidos, Provincias y Comunidades Autónomas.', true), ('D', 'Municipios, Distritos, Provincias y Regiones.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según la Ley Orgánica del Poder Judicial, los Jueces de Paz y sus sustitutos serán nombrados:', 'El art. 101.1 LOPJ atribuye el nombramiento a la Sala de Gobierno del Tribunal Superior de Justicia, por cuatro años, recayendo en las personas elegidas por el Ayuntamiento (que elige, pero no nombra).', 'age_aux_b1_04_poder_judicial', (select id from public.topics where slug = 'age-aux-b1-04-poder-judicial'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1985-12666'), 'Art. 101.1 LOPJ', 'Los Jueces de Paz y sus sustitutos serán nombrados para un periodo de cuatro años por la Sala de Gobierno del Tribunal Superior de Justicia correspondiente. El nombramiento recaerá en las personas elegidas por el respectivo Ayuntamiento.', null, 'fe35053f2c630e3a17b2348a14d15263b1ced458c077263f591239a1094b3e9c', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'fe35053f2c630e3a17b2348a14d15263b1ced458c077263f591239a1094b3e9c')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Para un periodo de cuatro años por la Sala de Gobierno del Tribunal Superior de Justicia correspondiente.', true), ('B', 'Para un periodo de cinco años por el Consejo General del Poder Judicial.', false), ('C', 'Para un periodo de cuatro años por el Pleno del Ayuntamiento.', false), ('D', 'Para un periodo de seis años por el Presidente de la Audiencia Provincial.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
-- Lote age-aux-b1-05-gobierno-ce-v1 (13 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Constitución Española (texto consolidado, BOE)', 'https://www.boe.es/buscar/act.php?id=BOE-A-1978-31229', 'boe'::public.source_kind, 'Agencia Estatal Boletín Oficial del Estado', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('age-aux-b1-05-gobierno', 'I.5 El Gobierno y la Administración') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug = 'auxiliar-administrativo-estado' and t.slug = 'age-aux-b1-05-gobierno' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 97 de la Constitución Española, ¿qué órgano dirige la política interior y exterior, la Administración civil y militar y la defensa del Estado?', 'El art. 97 CE atribuye al Gobierno la dirección de la política interior y exterior, de la Administración civil y militar y de la defensa del Estado, así como la función ejecutiva y la potestad reglamentaria.', 'age_aux_b1_05_gobierno', (select id from public.topics where slug = 'age-aux-b1-05-gobierno'), 1, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1978-31229'), 'Art. 97 CE', 'El Gobierno dirige la política interior y exterior, la Administración civil y militar y la defensa del Estado. Ejerce la función ejecutiva y la potestad reglamentaria de acuerdo con la Constitución y las leyes.', null, 'fa4462cae40c3cfc523b9ce47b470396118b4e141de914d985ab96f854c179fe', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'fa4462cae40c3cfc523b9ce47b470396118b4e141de914d985ab96f854c179fe')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El Gobierno.', true), ('B', 'Las Cortes Generales.', false), ('C', 'El Rey.', false), ('D', 'El Consejo de Estado.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'De acuerdo con el artículo 98.1 de la Constitución, el Gobierno se compone:', 'El art. 98.1 CE enumera al Presidente, a los Vicepresidentes (solo si existen), a los Ministros y a los demás miembros que establezca la ley. Los Secretarios de Estado no son miembros del Gobierno.', 'age_aux_b1_05_gobierno', (select id from public.topics where slug = 'age-aux-b1-05-gobierno'), 1, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1978-31229'), 'Art. 98.1 CE', '1. El Gobierno se compone del Presidente, de los Vicepresidentes, en su caso, de los Ministros y de los demás miembros que establezca la ley.', null, 'e9c3ebbde94547208d2787f6fdf59a9508445a44f309a093b3773d5f84c0f051', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'e9c3ebbde94547208d2787f6fdf59a9508445a44f309a093b3773d5f84c0f051')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Del Presidente, de los Ministros y de los Secretarios de Estado.', false), ('B', 'Del Presidente, de un Vicepresidente en todo caso y de los Ministros con cartera.', false), ('C', 'Únicamente del Presidente y de los Ministros.', false), ('D', 'Del Presidente, de los Vicepresidentes, en su caso, de los Ministros y de los demás miembros que establezca la ley.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 99.3 de la Constitución, si el candidato a la Presidencia del Gobierno no obtiene la mayoría absoluta en la primera votación, se someterá la misma propuesta a nueva votación:', 'En la primera votación se exige la mayoría absoluta del Congreso; si no se alcanza, se vota de nuevo 48 horas después y basta la mayoría simple (art. 99.3 CE).', 'age_aux_b1_05_gobierno', (select id from public.topics where slug = 'age-aux-b1-05-gobierno'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1978-31229'), 'Art. 99.3 CE', 'De no alcanzarse dicha mayoría, se someterá la misma propuesta a nueva votación cuarenta y ocho horas después de la anterior, y la confianza se entenderá otorgada si obtuviere la mayoría simple.', null, 'cf38f6513a08b083d739ddd7c60b574779c46331edc62a895ede1c374baf75e7', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'cf38f6513a08b083d739ddd7c60b574779c46331edc62a895ede1c374baf75e7')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Veinticuatro horas después, bastando la mayoría simple.', false), ('B', 'Cuarenta y ocho horas después, bastando la mayoría simple.', true), ('C', 'Cuarenta y ocho horas después, exigiéndose de nuevo la mayoría absoluta.', false), ('D', 'Siete días después, bastando la mayoría de tres quintos.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Conforme al artículo 99.5 de la Constitución, si transcurridos dos meses desde la primera votación de investidura ningún candidato ha obtenido la confianza del Congreso, el Rey disolverá ambas Cámaras y convocará nuevas elecciones con el refrendo:', 'El art. 99.5 CE prevé que, en ese caso, la disolución automática y la convocatoria de elecciones se hagan con el refrendo del Presidente del Congreso.', 'age_aux_b1_05_gobierno', (select id from public.topics where slug = 'age-aux-b1-05-gobierno'), 3, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1978-31229'), 'Art. 99.5 CE', '5. Si transcurrido el plazo de dos meses, a partir de la primera votación de investidura, ningún candidato hubiere obtenido la confianza del Congreso, el Rey disolverá ambas Cámaras y convocará nuevas elecciones con el refrendo del Presidente del Congreso.', null, '7120380d34092d85226c93254e17af2b1528d16d5966f3a7ee49224b9aa32060', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '7120380d34092d85226c93254e17af2b1528d16d5966f3a7ee49224b9aa32060')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Del Presidente del Gobierno en funciones.', false), ('B', 'Del Presidente del Senado.', false), ('C', 'Del Presidente del Congreso.', true), ('D', 'Del Ministro de la Presidencia.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 100 de la Constitución, los miembros del Gobierno distintos del Presidente son nombrados y separados:', 'El art. 100 CE dispone que los demás miembros del Gobierno serán nombrados y separados por el Rey a propuesta del Presidente.', 'age_aux_b1_05_gobierno', (select id from public.topics where slug = 'age-aux-b1-05-gobierno'), 1, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1978-31229'), 'Art. 100 CE', 'Los demás miembros del Gobierno serán nombrados y separados por el Rey, a propuesta de su Presidente.', null, 'b52725aee07c4d8e081be00ebef45e0f3b68b7940a5cce46d3abf301497581f3', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'b52725aee07c4d8e081be00ebef45e0f3b68b7940a5cce46d3abf301497581f3')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Por el Presidente del Gobierno, previa deliberación del Consejo de Ministros.', false), ('B', 'Por el Rey, a propuesta de su Presidente.', true), ('C', 'Por el Rey, previa votación del Congreso de los Diputados.', false), ('D', 'Por el Congreso de los Diputados, a propuesta del Presidente del Gobierno.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select '¿Cuál de las siguientes es una causa de cese del Gobierno según el artículo 101.1 de la Constitución?', 'El Gobierno cesa tras las elecciones generales, por pérdida de la confianza parlamentaria y por dimisión o fallecimiento de su Presidente (art. 101.1 CE). La salida de otro miembro no provoca el cese del Gobierno.', 'age_aux_b1_05_gobierno', (select id from public.topics where slug = 'age-aux-b1-05-gobierno'), 1, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1978-31229'), 'Art. 101.1 CE', '1. El Gobierno cesa tras la celebración de elecciones generales, en los casos de pérdida de la confianza parlamentaria previstos en la Constitución, o por dimisión o fallecimiento de su Presidente.', null, '8bc96dbda52bd4f0bf2e07812089677b8004b6b4ce104854f24f32fc9c21d17a', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '8bc96dbda52bd4f0bf2e07812089677b8004b6b4ce104854f24f32fc9c21d17a')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'La dimisión de un Vicepresidente.', false), ('B', 'La disolución anticipada del Senado.', false), ('C', 'La separación de un Ministro por el Rey.', false), ('D', 'El fallecimiento de su Presidente.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 102.1 de la Constitución, la responsabilidad criminal del Presidente y de los demás miembros del Gobierno será exigible ante:', 'El art. 102.1 CE residencia la responsabilidad criminal de los miembros del Gobierno en la Sala de lo Penal del Tribunal Supremo.', 'age_aux_b1_05_gobierno', (select id from public.topics where slug = 'age-aux-b1-05-gobierno'), 1, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1978-31229'), 'Art. 102.1 CE', '1. La responsabilidad criminal del Presidente y los demás miembros del Gobierno será exigible, en su caso, ante la Sala de lo Penal del Tribunal Supremo.', null, 'ba59b2723efc21c15d927affa588f23b45fab3488a24427c0d89238f5c46148d', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'ba59b2723efc21c15d927affa588f23b45fab3488a24427c0d89238f5c46148d')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'La Sala de lo Penal de la Audiencia Nacional.', false), ('B', 'El Tribunal Constitucional.', false), ('C', 'La Sala de lo Penal del Tribunal Supremo.', true), ('D', 'El Tribunal Superior de Justicia de Madrid.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'De acuerdo con el artículo 102.2 de la Constitución, la acusación contra un miembro del Gobierno por traición o por cualquier delito contra la seguridad del Estado en el ejercicio de sus funciones solo podrá plantearse:', 'El art. 102.2 CE exige la iniciativa de una cuarta parte de los Diputados y la aprobación por mayoría absoluta del Congreso. Además, la prerrogativa real de gracia no es aplicable (art. 102.3).', 'age_aux_b1_05_gobierno', (select id from public.topics where slug = 'age-aux-b1-05-gobierno'), 3, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1978-31229'), 'Art. 102.2 CE', '2. Si la acusación fuere por traición o por cualquier delito contra la seguridad del Estado en el ejercicio de sus funciones, sólo podrá ser planteada por iniciativa de la cuarta parte de los miembros del Congreso, y con la aprobación de la mayoría absoluta del mismo.', null, '4e720d861d678044497acf93413a6b9b5a3b7b07c188f94206a4c6b10aff5164', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '4e720d861d678044497acf93413a6b9b5a3b7b07c188f94206a4c6b10aff5164')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Por iniciativa de la cuarta parte de los miembros del Congreso y con la aprobación de la mayoría absoluta del mismo.', true), ('B', 'Por iniciativa de la décima parte de los miembros del Congreso y con la aprobación de la mayoría absoluta del mismo.', false), ('C', 'Por iniciativa de la cuarta parte de los miembros del Congreso y con la aprobación de los tres quintos del mismo.', false), ('D', 'Por iniciativa del Fiscal General del Estado y con la aprobación de la mayoría absoluta del Senado.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 108 de la Constitución, el Gobierno responde solidariamente en su gestión política ante:', 'La responsabilidad política solidaria del Gobierno se exige solo ante el Congreso de los Diputados (art. 108 CE), que es quien otorga la confianza y puede retirarla.', 'age_aux_b1_05_gobierno', (select id from public.topics where slug = 'age-aux-b1-05-gobierno'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1978-31229'), 'Art. 108 CE', 'El Gobierno responde solidariamente en su gestión política ante el Congreso de los Diputados.', null, 'de85e5b1d53e952ddc3338eaa850781227f5e9ce5ac12f0799de6a98ae9be1ec', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'de85e5b1d53e952ddc3338eaa850781227f5e9ce5ac12f0799de6a98ae9be1ec')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Las Cortes Generales en sesión conjunta.', false), ('B', 'El Senado.', false), ('C', 'El Congreso de los Diputados.', true), ('D', 'El Rey.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Conforme al artículo 112 de la Constitución, la confianza solicitada por el Presidente del Gobierno mediante la cuestión de confianza se entenderá otorgada cuando vote a favor:', 'La cuestión de confianza, planteada previa deliberación del Consejo de Ministros, prospera con la mayoría simple de los Diputados (art. 112 CE).', 'age_aux_b1_05_gobierno', (select id from public.topics where slug = 'age-aux-b1-05-gobierno'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1978-31229'), 'Art. 112 CE', 'La confianza se entenderá otorgada cuando vote a favor de la misma la mayoría simple de los Diputados.', null, '4147ecd20ed46fb1cd3fb796f407ae68770280996a2b3f77e89cb263c18bcd02', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '4147ecd20ed46fb1cd3fb796f407ae68770280996a2b3f77e89cb263c18bcd02')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'La mayoría absoluta de los Diputados.', false), ('B', 'Los tres quintos de los Diputados.', false), ('C', 'La mayoría absoluta de ambas Cámaras.', false), ('D', 'La mayoría simple de los Diputados.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 113.2 de la Constitución, la moción de censura deberá ser propuesta al menos por:', 'El art. 113.2 CE exige que la moción sea propuesta por al menos la décima parte de los Diputados y que incluya un candidato a la Presidencia (moción de censura constructiva).', 'age_aux_b1_05_gobierno', (select id from public.topics where slug = 'age-aux-b1-05-gobierno'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1978-31229'), 'Art. 113.2 CE', '2. La moción de censura deberá ser propuesta al menos por la décima parte de los Diputados, y habrá de incluir un candidato a la Presidencia del Gobierno.', null, '37f024eba2bba14d189558e1e2702afb5ad9e75c683e2813b8bba95ff7a80001', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '37f024eba2bba14d189558e1e2702afb5ad9e75c683e2813b8bba95ff7a80001')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'La décima parte de los Diputados, e incluir un candidato a la Presidencia del Gobierno.', true), ('B', 'La cuarta parte de los Diputados, e incluir un candidato a la Presidencia del Gobierno.', false), ('C', 'La décima parte de los Diputados, sin necesidad de incluir candidato alguno.', false), ('D', 'Dos Grupos parlamentarios, e incluir un programa de gobierno alternativo.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'De acuerdo con el artículo 113.3 de la Constitución, la moción de censura no podrá ser votada hasta que transcurran:', 'El art. 113.3 CE fija un plazo mínimo de cinco días entre la presentación y la votación; en los dos primeros pueden presentarse mociones alternativas.', 'age_aux_b1_05_gobierno', (select id from public.topics where slug = 'age-aux-b1-05-gobierno'), 3, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1978-31229'), 'Art. 113.3 CE', '3. La moción de censura no podrá ser votada hasta que transcurran cinco días desde su presentación. En los dos primeros días de dicho plazo podrán presentarse mociones alternativas.', null, '911afecf6b09c8e1dbdaa6c8cda3ede35485f193320b05190c5edd0ad85affc4', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '911afecf6b09c8e1dbdaa6c8cda3ede35485f193320b05190c5edd0ad85affc4')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Dos días desde su presentación, pudiendo presentarse mociones alternativas en el primer día.', false), ('B', 'Cinco días desde su presentación, pudiendo presentarse mociones alternativas en los dos primeros días.', true), ('C', 'Cinco días desde su presentación, sin que quepa presentar mociones alternativas.', false), ('D', 'Diez días desde su presentación, pudiendo presentarse mociones alternativas en los cinco primeros días.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 115.3 de la Constitución, salvo lo dispuesto en el artículo 99.5, no procederá una nueva disolución de las Cámaras antes de que transcurra:', 'El art. 115.3 CE impide una nueva disolución antes de un año desde la anterior, con la salvedad de la disolución automática del art. 99.5.', 'age_aux_b1_05_gobierno', (select id from public.topics where slug = 'age-aux-b1-05-gobierno'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1978-31229'), 'Art. 115.3 CE', '3. No procederá nueva disolución antes de que transcurra un año desde la anterior, salvo lo dispuesto en el artículo 99, apartado 5.', null, 'f4f61b45e0617ae66a66ae656b1e7761f9967825842b7805a579f0a0d979ccf6', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'f4f61b45e0617ae66a66ae656b1e7761f9967825842b7805a579f0a0d979ccf6')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Un año desde la anterior.', true), ('B', 'Seis meses desde la anterior.', false), ('C', 'Dos años desde la anterior.', false), ('D', 'Un período de sesiones desde la anterior.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
-- Lote age-aux-b1-05-gobierno-lg-v1 (7 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Ley 50/1997, de 27 de noviembre, del Gobierno (texto consolidado, BOE)', 'https://www.boe.es/buscar/act.php?id=BOE-A-1997-25336', 'boe'::public.source_kind, 'Agencia Estatal Boletín Oficial del Estado', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('age-aux-b1-05-gobierno', 'I.5 El Gobierno y la Administración') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug = 'auxiliar-administrativo-estado' and t.slug = 'age-aux-b1-05-gobierno' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 11 de la Ley 50/1997, del Gobierno, ¿cuál de los siguientes es un requisito para ser miembro del Gobierno?', 'El art. 11 LG exige ser español, mayor de edad, disfrutar del sufragio activo y pasivo, no estar inhabilitado por sentencia firme y reunir los requisitos de idoneidad de la Ley 3/2015. No se exige ser parlamentario.', 'age_aux_b1_05_gobierno', (select id from public.topics where slug = 'age-aux-b1-05-gobierno'), 1, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1997-25336'), 'Art. 11 LG', 'Para ser miembro del Gobierno se requiere ser español, mayor de edad, disfrutar de los derechos de sufragio activo y pasivo, así como no estar inhabilitado para ejercer empleo o cargo público por sentencia judicial firme', null, '8fcb6d1f72f546d025b5e4ce460019080109d33eff1932d59b8b153115d2e54e', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '8fcb6d1f72f546d025b5e4ce460019080109d33eff1932d59b8b153115d2e54e')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Ser Diputado o Senador.', false), ('B', 'Ser funcionario de carrera del Subgrupo A1.', false), ('C', 'Ser español y mayor de edad.', true), ('D', 'Haber residido en España durante los cinco años anteriores.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'De acuerdo con el artículo 12.2 bis de la Ley 50/1997, del Gobierno, en el nombramiento de las personas titulares de las Vicepresidencias y los Ministerios, cada uno de los sexos deberá suponer en su conjunto como mínimo:', 'El art. 12.2 bis LG garantiza la presencia equilibrada de mujeres y hombres: cada sexo debe representar al menos el 40 % del conjunto de Vicepresidencias y Ministerios.', 'age_aux_b1_05_gobierno', (select id from public.topics where slug = 'age-aux-b1-05-gobierno'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1997-25336'), 'Art. 12.2 bis LG', '2 bis. En el nombramiento de las personas titulares de las Vicepresidencias y los Ministerios se garantizará el principio de presencia equilibrada de mujeres y hombres, de forma que cada uno de los sexos suponga como mínimo el cuarenta por ciento en su conjunto.', null, '675f9326516d8159c478caa9b62bf8ce91c98e14f69d2c8e9ce99c0c4d14ce6d', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '675f9326516d8159c478caa9b62bf8ce91c98e14f69d2c8e9ce99c0c4d14ce6d')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El cincuenta por ciento.', false), ('B', 'El treinta y tres por ciento.', false), ('C', 'El sesenta por ciento.', false), ('D', 'El cuarenta por ciento.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 13.1 de la Ley 50/1997, del Gobierno, en los casos de vacante, ausencia o enfermedad, las funciones del Presidente del Gobierno serán asumidas:', 'El art. 13.1 LG ordena la suplencia del Presidente: primero los Vicepresidentes por su orden de prelación y, en defecto de ellos, los Ministros por el orden de precedencia de los Departamentos.', 'age_aux_b1_05_gobierno', (select id from public.topics where slug = 'age-aux-b1-05-gobierno'), 3, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1997-25336'), 'Art. 13.1 LG', '1. En los casos de vacante, ausencia o enfermedad, las funciones del Presidente del Gobierno serán asumidas por los Vicepresidentes, de acuerdo con el correspondiente orden de prelación, y, en defecto de ellos, por los Ministros, según el orden de precedencia de los Departamentos.', null, '114fd0719c48ff08abbffa740ef080d00ce6e83fc8492a8fb867c5581d05a2ce', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '114fd0719c48ff08abbffa740ef080d00ce6e83fc8492a8fb867c5581d05a2ce')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Por el Ministro de la Presidencia y, en su defecto, por el Ministro de mayor edad.', false), ('B', 'Por los Vicepresidentes, según su orden de prelación, y, en su defecto, por los Ministros según el orden de precedencia de los Departamentos.', true), ('C', 'Por los Vicepresidentes, según su orden de prelación, y, en su defecto, por el Presidente del Congreso de los Diputados.', false), ('D', 'Por el Ministro que designe el Consejo de Ministros en cada caso.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 18.1 de la Ley 50/1997, del Gobierno, ¿quién actúa como Secretario en las reuniones del Consejo de Ministros?', 'El Presidente del Gobierno convoca y preside el Consejo de Ministros y actúa como Secretario el Ministro de la Presidencia (art. 18.1 LG). El Subsecretario de la Presidencia es el secretario de la Comisión General de Secretarios de Estado y Subsecretarios (art. 8.3).', 'age_aux_b1_05_gobierno', (select id from public.topics where slug = 'age-aux-b1-05-gobierno'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1997-25336'), 'Art. 18.1 LG', '1. El Presidente del Gobierno convoca y preside las reuniones del Consejo de Ministros, actuando como Secretario el Ministro de la Presidencia.', null, '225a88dc4c66e5dc009b68a96253539a8ce02ced8137699bfe898afa40d519fa', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '225a88dc4c66e5dc009b68a96253539a8ce02ced8137699bfe898afa40d519fa')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El Ministro de la Presidencia.', true), ('B', 'El Subsecretario de la Presidencia.', false), ('C', 'El Director del Secretariado del Gobierno.', false), ('D', 'El Vicepresidente primero del Gobierno.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'De acuerdo con la Ley 50/1997, del Gobierno, las deliberaciones de la Comisión General de Secretarios de Estado y Subsecretarios serán:', 'El art. 8.4 LG califica de reservadas las deliberaciones de la Comisión General y le prohíbe adoptar decisiones por delegación del Gobierno; en cambio, las del Consejo de Ministros y las Comisiones Delegadas son secretas (arts. 5.3 y 6.5).', 'age_aux_b1_05_gobierno', (select id from public.topics where slug = 'age-aux-b1-05-gobierno'), 3, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1997-25336'), 'Art. 8.4 LG', '4. Las deliberaciones de la Comisión General de Secretarios de Estado y Subsecretarios serán reservadas. En ningún caso la Comisión podrá adoptar decisiones o acuerdos por delegación del Gobierno.', null, 'dc0273b6e323418fc629041262ed8eb9970d2ec9e4334d9a1bada9f65c09db2b', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'dc0273b6e323418fc629041262ed8eb9970d2ec9e4334d9a1bada9f65c09db2b')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Secretas, pudiendo la Comisión adoptar acuerdos por delegación del Gobierno.', false), ('B', 'Reservadas, sin que la Comisión pueda adoptar en ningún caso decisiones o acuerdos por delegación del Gobierno.', true), ('C', 'Públicas, salvo que el Presidente de la Comisión acuerde su reserva.', false), ('D', 'Reservadas, pudiendo la Comisión resolver por delegación los asuntos que afecten a varios Ministerios.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 21.4 de la Ley 50/1997, del Gobierno, el Presidente del Gobierno en funciones no podrá:', 'El Presidente en funciones no puede proponer la disolución de las Cámaras, plantear la cuestión de confianza ni proponer la convocatoria de un referéndum consultivo (art. 21.4 LG).', 'age_aux_b1_05_gobierno', (select id from public.topics where slug = 'age-aux-b1-05-gobierno'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1997-25336'), 'Art. 21.4 LG', '4. El Presidente del Gobierno en funciones no podrá ejercer las siguientes facultades: a) Proponer al Rey la disolución de alguna de las Cámaras, o de las Cortes Generales. b) Plantear la cuestión de confianza. c) Proponer al Rey la convocatoria de un referéndum consultivo.', null, '62fa5f08fdebf2138a6d33e15e06722769ea4888b8a7a3a63ef33fbadebfc751', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '62fa5f08fdebf2138a6d33e15e06722769ea4888b8a7a3a63ef33fbadebfc751')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Convocar y presidir las reuniones del Consejo de Ministros.', false), ('B', 'Representar al Gobierno.', false), ('C', 'Plantear la cuestión de confianza.', true), ('D', 'Refrendar los actos del Rey.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'De acuerdo con el artículo 21.5 de la Ley 50/1997, del Gobierno, ¿cuál de las siguientes facultades no puede ejercer el Gobierno en funciones?', 'El Gobierno en funciones no puede aprobar el Proyecto de Ley de Presupuestos ni presentar proyectos de ley a las Cortes (art. 21.5 LG); sí debe facilitar el traspaso de poderes y despachar los asuntos ordinarios, y puede adoptar otras medidas en casos de urgencia (art. 21.3).', 'age_aux_b1_05_gobierno', (select id from public.topics where slug = 'age-aux-b1-05-gobierno'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1997-25336'), 'Art. 21.5 LG', '5. El Gobierno en funciones no podrá ejercer las siguientes facultades: a) Aprobar el Proyecto de Ley de Presupuestos Generales del Estado. b) Presentar proyectos de ley al Congreso de los Diputados o, en su caso, al Senado.', null, 'dc9135ccbf496c4c649ffa2455c02b4f95707c6d1df2a9e75081b5790e891711', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'dc9135ccbf496c4c649ffa2455c02b4f95707c6d1df2a9e75081b5790e891711')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Despachar los asuntos públicos ordinarios.', false), ('B', 'Facilitar el traspaso de poderes al nuevo Gobierno.', false), ('C', 'Adoptar medidas en casos de urgencia debidamente acreditados.', false), ('D', 'Aprobar el Proyecto de Ley de Presupuestos Generales del Estado.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
-- Lote age-aux-b1-07-transparencia-lt-v1 (20 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Ley 19/2013, de 9 de diciembre, de transparencia, acceso a la información pública y buen gobierno (texto consolidado, BOE)', 'https://www.boe.es/buscar/act.php?id=BOE-A-2013-12887', 'boe'::public.source_kind, 'Agencia Estatal Boletín Oficial del Estado', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('age-aux-b1-07-transparencia', 'I.7 La Ley 19/2013 de transparencia, acceso a la información pública y buen gobierno') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug = 'auxiliar-administrativo-estado' and t.slug = 'age-aux-b1-07-transparencia' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 2.1 de la Ley 19/2013, de transparencia, las disposiciones de su título I se aplican a las sociedades mercantiles en cuyo capital social la participación, directa o indirecta, de las entidades previstas en ese artículo sea:', 'El art. 2.1.g) LT incluye en su ámbito subjetivo a las sociedades mercantiles con participación pública, directa o indirecta, superior al 50 %.', 'age_aux_b1_07_transparencia', (select id from public.topics where slug = 'age-aux-b1-07-transparencia'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2013-12887'), 'Art. 2.1.g) LT', 'g) Las sociedades mercantiles en cuyo capital social la participación, directa o indirecta, de las entidades previstas en este artículo sea superior al 50 por 100.', null, 'b77dc143aa2a9e9c74a45f89c1d98ce091ecbd0068f9fc783aa4a37544b85254', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'b77dc143aa2a9e9c74a45f89c1d98ce091ecbd0068f9fc783aa4a37544b85254')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Superior al 50 por 100.', true), ('B', 'Igual o superior al 25 por 100.', false), ('C', 'Superior al 40 por 100.', false), ('D', 'Del 100 por 100.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'De acuerdo con el artículo 3 de la Ley 19/2013, los partidos políticos, las organizaciones sindicales y las organizaciones empresariales están sujetos:', 'El art. 3 LT extiende a estos sujetos solo el capítulo II del título I (publicidad activa); no les son de aplicación las normas sobre derecho de acceso ni las de buen gobierno.', 'age_aux_b1_07_transparencia', (select id from public.topics where slug = 'age-aux-b1-07-transparencia'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2013-12887'), 'Art. 3.a) LT', 'Las disposiciones del capítulo II de este título serán también aplicables a: a) Los partidos políticos, organizaciones sindicales y organizaciones empresariales.', null, '88e2792067be7774e87be20e27a06b44deeef789d2bf73733e13ac7b845f53da', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '88e2792067be7774e87be20e27a06b44deeef789d2bf73733e13ac7b845f53da')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'A las disposiciones del título II, relativo al buen gobierno.', false), ('B', 'A la totalidad de las disposiciones del título I, incluido el derecho de acceso.', false), ('C', 'A las disposiciones del capítulo II del título I, relativo a la publicidad activa.', true), ('D', 'Únicamente a la obligación de suministrar información a la Administración previo requerimiento.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 3.b) de la Ley 19/2013, quedan sujetas a las obligaciones de publicidad activa las entidades privadas que perciban durante el período de un año ayudas o subvenciones públicas en una cuantía superior a:', 'El art. 3.b) LT fija el umbral en 100.000 euros anuales o, alternativamente, en que al menos el 40 % de los ingresos anuales sean ayudas o subvenciones públicas, con un mínimo de 5.000 euros.', 'age_aux_b1_07_transparencia', (select id from public.topics where slug = 'age-aux-b1-07-transparencia'), 3, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2013-12887'), 'Art. 3.b) LT', 'b) Las entidades privadas que perciban durante el período de un año ayudas o subvenciones públicas en una cuantía superior a 100.000 euros o cuando al menos el 40 % del total de sus ingresos anuales tengan carácter de ayuda o subvención pública, siempre que alcancen como mínimo la cantidad de 5.000 euros.', null, '4e064eab62e85c9078e221199e6dfd36467c626e3bc58c740d296b69c93aa3de', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '4e064eab62e85c9078e221199e6dfd36467c626e3bc58c740d296b69c93aa3de')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', '50.000 euros.', false), ('B', '100.000 euros.', true), ('C', '60.000 euros.', false), ('D', '500.000 euros.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'De acuerdo con el artículo 10.1 de la Ley 19/2013, el Portal de la Transparencia que desarrollará la Administración General del Estado dependerá:', 'El art. 10.1 LT dispone que el Portal de la Transparencia dependa del Ministerio de la Presidencia. Al Ministerio de Hacienda y Administraciones Públicas está adscrito el Consejo de Transparencia y Buen Gobierno (art. 33.1).', 'age_aux_b1_07_transparencia', (select id from public.topics where slug = 'age-aux-b1-07-transparencia'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2013-12887'), 'Art. 10.1 LT', '1. La Administración General del Estado desarrollará un Portal de la Transparencia, dependiente del Ministerio de la Presidencia, que facilitará el acceso de los ciudadanos a toda la información a la que se refieren los artículos anteriores relativa a su ámbito de actuación.', 'El texto consolidado dice «Ministerio de la Presidencia», denominación que ha cambiado con las reestructuraciones ministeriales; revisar si conviene mantenerla.', '3466d767e9de0eea6ad7e6b31be71c29d672896bdc051de48a4937b8c82a7371', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '3466d767e9de0eea6ad7e6b31be71c29d672896bdc051de48a4937b8c82a7371')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Del Consejo de Transparencia y Buen Gobierno.', false), ('B', 'Del Ministerio de Hacienda y Administraciones Públicas.', false), ('C', 'De la Agencia Española de Protección de Datos.', false), ('D', 'Del Ministerio de la Presidencia.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 12 de la Ley 19/2013, ¿quién tiene derecho a acceder a la información pública?', 'El art. 12 LT reconoce el derecho de acceso a todas las personas, en los términos del art. 105.b) CE.', 'age_aux_b1_07_transparencia', (select id from public.topics where slug = 'age-aux-b1-07-transparencia'), 1, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2013-12887'), 'Art. 12 LT', 'Todas las personas tienen derecho a acceder a la información pública, en los términos previstos en el artículo 105.b) de la Constitución Española, desarrollados por esta Ley.', null, 'ef1a26c14c37d8e9e22a3f339bc2c781ec6af28d5302d956b23c22a70e975a4e', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'ef1a26c14c37d8e9e22a3f339bc2c781ec6af28d5302d956b23c22a70e975a4e')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Solo los ciudadanos españoles mayores de edad.', false), ('B', 'Todas las personas.', true), ('C', 'Solo quienes tengan la condición de interesados en un procedimiento administrativo.', false), ('D', 'Solo quienes acrediten un interés legítimo en la información.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select '¿Cuál de los siguientes figura entre los límites al derecho de acceso enumerados en el artículo 14.1 de la Ley 19/2013?', 'El art. 14.1 LT enumera, entre otros límites, la seguridad nacional, la defensa, las relaciones exteriores, los intereses económicos y comerciales y la protección del medio ambiente. Los demás supuestos no figuran en la lista.', 'age_aux_b1_07_transparencia', (select id from public.topics where slug = 'age-aux-b1-07-transparencia'), 1, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2013-12887'), 'Art. 14.1 LT', '1. El derecho de acceso podrá ser limitado cuando acceder a la información suponga un perjuicio para: […] l) La protección del medio ambiente.', null, '07390a1a799a0e255dfcc715a7a641bd96b674b517e4fdf5a7e41dafb0ff0ae7', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '07390a1a799a0e255dfcc715a7a641bd96b674b517e4fdf5a7e41dafb0ff0ae7')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'La protección de la imagen institucional del órgano.', false), ('B', 'El volumen de trabajo de la unidad que posee la información.', false), ('C', 'El coste de reproducción de los documentos.', false), ('D', 'La protección del medio ambiente.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 15.1 de la Ley 19/2013, si la información solicitada contiene datos personales que revelen la ideología, afiliación sindical, religión o creencias, y el afectado no los hubiese hecho manifiestamente públicos con anterioridad, el acceso únicamente se podrá autorizar si se cuenta con:', 'Para estos datos especialmente protegidos el art. 15.1 LT exige consentimiento expreso y por escrito, salvo que el afectado los hubiera hecho manifiestamente públicos. La vía de la norma con rango de ley solo se prevé para los datos del segundo párrafo (origen racial, salud, vida sexual, etc.).', 'age_aux_b1_07_transparencia', (select id from public.topics where slug = 'age-aux-b1-07-transparencia'), 3, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2013-12887'), 'Art. 15.1 LT', '1. Si la información solicitada contuviera datos personales que revelen la ideología, afiliación sindical, religión o creencias, el acceso únicamente se podrá autorizar en caso de que se contase con el consentimiento expreso y por escrito del afectado, a menos que dicho afectado hubiese hecho manifiestamente públicos los datos con anterioridad a que se solicitase el acceso.', null, 'e1996b1e2570369861ba28ff8211aedefcaaf5c2d567d11de5346399ffa11640', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'e1996b1e2570369861ba28ff8211aedefcaaf5c2d567d11de5346399ffa11640')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El consentimiento expreso y por escrito del afectado.', true), ('B', 'El consentimiento expreso del afectado, aunque sea verbal.', false), ('C', 'La autorización del Consejo de Transparencia y Buen Gobierno.', false), ('D', 'Una norma con rango de ley que ampare el acceso, aunque falte el consentimiento.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'De acuerdo con el artículo 17.3 de la Ley 19/2013, en relación con la motivación de la solicitud de acceso a la información:', 'El art. 17.3 LT establece que el solicitante no tiene que motivar su solicitud, aunque puede exponer sus motivos, que podrán tenerse en cuenta al resolver.', 'age_aux_b1_07_transparencia', (select id from public.topics where slug = 'age-aux-b1-07-transparencia'), 1, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2013-12887'), 'Art. 17.3 LT', '3. El solicitante no está obligado a motivar su solicitud de acceso a la información. Sin embargo, podrá exponer los motivos por los que solicita la información y que podrán ser tenidos en cuenta cuando se dicte la resolución. No obstante, la ausencia de motivación no será por si sola causa de rechazo de la solicitud.', null, '576f0f057ebc3e45d9cd7f26042ae72381bba3b756fc2552595ea8d22bb1210a', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '576f0f057ebc3e45d9cd7f26042ae72381bba3b756fc2552595ea8d22bb1210a')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El solicitante debe motivarla siempre, bajo pena de inadmisión.', false), ('B', 'Solo deben motivarla las personas jurídicas.', false), ('C', 'El solicitante no está obligado a motivarla, y la ausencia de motivación no será por sí sola causa de rechazo.', true), ('D', 'Debe motivarse cuando la información se refiera a la Administración General del Estado.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select '¿Cuál de las siguientes es una causa de inadmisión a trámite de la solicitud de acceso según el artículo 18.1 de la Ley 19/2013?', 'El art. 18.1.c) LT prevé la inadmisión de las solicitudes relativas a información que exija una acción previa de reelaboración. La falta de motivación no es causa de rechazo (art. 17.3) y cabe dirigirse en lengua cooficial (art. 17.4).', 'age_aux_b1_07_transparencia', (select id from public.topics where slug = 'age-aux-b1-07-transparencia'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2013-12887'), 'Art. 18.1.c) LT', 'c) Relativas a información para cuya divulgación sea necesaria una acción previa de reelaboración.', null, 'df394c6394cae900f8c830425418307c8a9ce407552c2b0e15f2fc70eddde269', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'df394c6394cae900f8c830425418307c8a9ce407552c2b0e15f2fc70eddde269')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Que el solicitante no haya expuesto los motivos de su solicitud.', false), ('B', 'Que la información contenga datos meramente identificativos relacionados con la organización del órgano.', false), ('C', 'Que se refiera a información para cuya divulgación sea necesaria una acción previa de reelaboración.', true), ('D', 'Que la solicitud se presente en una lengua cooficial del territorio donde radica la Administración.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 19.2 de la Ley 19/2013, cuando la solicitud no identifique de forma suficiente la información, se pedirá al solicitante que la concrete en un plazo de:', 'El art. 19.2 LT concede diez días para concretar la solicitud, advierte del desistimiento y suspende el plazo para resolver.', 'age_aux_b1_07_transparencia', (select id from public.topics where slug = 'age-aux-b1-07-transparencia'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2013-12887'), 'Art. 19.2 LT', '2. Cuando la solicitud no identifique de forma suficiente la información, se pedirá al solicitante que la concrete en un plazo de diez días, con indicación de que, en caso de no hacerlo, se le tendrá por desistido, así como de la suspensión del plazo para dictar resolución.', null, '06969ae6cf38584f3b5fd4e2243d91523a8845dbc6a558e623928a47691cf570', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '06969ae6cf38584f3b5fd4e2243d91523a8845dbc6a558e623928a47691cf570')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Quince días, con indicación de que, si no lo hace, se le tendrá por desistido.', false), ('B', 'Diez días, con indicación de que, si no lo hace, la solicitud se entenderá estimada.', false), ('C', 'Un mes, sin que se suspenda el plazo para resolver.', false), ('D', 'Diez días, con indicación de que, si no lo hace, se le tendrá por desistido.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'De acuerdo con el artículo 19.3 de la Ley 19/2013, si la información solicitada pudiera afectar a derechos o intereses de terceros debidamente identificados, se les concederá para formular alegaciones un plazo de:', 'El art. 19.3 LT otorga a los terceros afectados quince días para alegar, y el plazo para resolver queda suspendido mientras tanto.', 'age_aux_b1_07_transparencia', (select id from public.topics where slug = 'age-aux-b1-07-transparencia'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2013-12887'), 'Art. 19.3 LT', '3. Si la información solicitada pudiera afectar a derechos o intereses de terceros, debidamente identificados, se les concederá un plazo de quince días para que puedan realizar las alegaciones que estimen oportunas.', null, 'c9c4988f53f14ec962d7bf5f4f992c62d505494c3722957d2bea5a85dbc90383', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'c9c4988f53f14ec962d7bf5f4f992c62d505494c3722957d2bea5a85dbc90383')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Diez días.', false), ('B', 'Quince días.', true), ('C', 'Cinco días.', false), ('D', 'Un mes.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 20.1 de la Ley 19/2013, la resolución que conceda o deniegue el acceso deberá notificarse en el plazo máximo de:', 'El plazo general es de un mes desde que el órgano competente recibe la solicitud, ampliable por otro mes por el volumen o la complejidad de la información, previa notificación al solicitante (art. 20.1 LT).', 'age_aux_b1_07_transparencia', (select id from public.topics where slug = 'age-aux-b1-07-transparencia'), 1, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2013-12887'), 'Art. 20.1 LT', '1. La resolución en la que se conceda o deniegue el acceso deberá notificarse al solicitante y a los terceros afectados que así lo hayan solicitado en el plazo máximo de un mes desde la recepción de la solicitud por el órgano competente para resolver. Este plazo podrá ampliarse por otro mes', null, 'dea06f3dc93d199b50e2baf2807c7de86c259faa49cc94abd6e0399657f0adc8', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'dea06f3dc93d199b50e2baf2807c7de86c259faa49cc94abd6e0399657f0adc8')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Un mes desde la recepción de la solicitud por el órgano competente, ampliable por otro mes.', true), ('B', 'Tres meses desde la presentación de la solicitud, sin posibilidad de ampliación.', false), ('C', 'Quince días desde la recepción de la solicitud, ampliable por otros quince.', false), ('D', 'Dos meses desde la recepción de la solicitud, ampliable por otro mes.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'De acuerdo con el artículo 20.4 de la Ley 19/2013, transcurrido el plazo máximo para resolver una solicitud de acceso sin que se haya dictado y notificado resolución expresa:', 'El silencio en materia de acceso a la información pública es desestimatorio (art. 20.4 LT).', 'age_aux_b1_07_transparencia', (select id from public.topics where slug = 'age-aux-b1-07-transparencia'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2013-12887'), 'Art. 20.4 LT', '4. Transcurrido el plazo máximo para resolver sin que se haya dictado y notificado resolución expresa se entenderá que la solicitud ha sido desestimada.', null, '816e7bb2cc77022635c4a1fa26f4b4b8207f267f17ecf90affddb31daa867491', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '816e7bb2cc77022635c4a1fa26f4b4b8207f267f17ecf90affddb31daa867491')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Se entenderá que la solicitud ha sido estimada.', false), ('B', 'Se entenderá concedido el acceso parcial.', false), ('C', 'El órgano deberá remitir la solicitud al Consejo de Transparencia y Buen Gobierno.', false), ('D', 'Se entenderá que la solicitud ha sido desestimada.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 22.1 de la Ley 19/2013, cuando no pueda darse el acceso a la información en el momento de la notificación de la resolución, deberá otorgarse en un plazo no superior a:', 'El art. 22.1 LT establece que el acceso se realice preferentemente por vía electrónica y, si no puede darse al notificar la resolución, en un plazo no superior a diez días.', 'age_aux_b1_07_transparencia', (select id from public.topics where slug = 'age-aux-b1-07-transparencia'), 3, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2013-12887'), 'Art. 22.1 LT', 'Cuando no pueda darse el acceso en el momento de la notificación de la resolución deberá otorgarse, en cualquier caso, en un plazo no superior a diez días.', null, 'd2faecc679985c316453f61137666baefb6cd5fc0b322fa526b5abe67d8152d7', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'd2faecc679985c316453f61137666baefb6cd5fc0b322fa526b5abe67d8152d7')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Quince días.', false), ('B', 'Diez días.', true), ('C', 'Un mes.', false), ('D', 'Cinco días.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'De acuerdo con el artículo 24 de la Ley 19/2013, la reclamación ante el Consejo de Transparencia y Buen Gobierno frente a una resolución en materia de acceso:', 'La reclamación es potestativa y previa a la vía contencioso-administrativa (art. 24.1 LT) y se interpone en el plazo de un mes desde la notificación o desde que se produzcan los efectos del silencio (art. 24.2).', 'age_aux_b1_07_transparencia', (select id from public.topics where slug = 'age-aux-b1-07-transparencia'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2013-12887'), 'Art. 24.1-2 LT', '1. Frente a toda resolución expresa o presunta en materia de acceso podrá interponerse una reclamación ante el Consejo de Transparencia y Buen Gobierno, con carácter potestativo y previo a su impugnación en vía contencioso-administrativa. 2. La reclamación se interpondrá en el plazo de un mes', null, '69df05c16028e1ba8d85156f682ee3dc4c51a951518a189893e3a011d3eb2b5e', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '69df05c16028e1ba8d85156f682ee3dc4c51a951518a189893e3a011d3eb2b5e')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Es obligatoria antes de acudir a la vía contencioso-administrativa y se interpone en el plazo de un mes.', false), ('B', 'Tiene carácter potestativo y se interpone en el plazo de tres meses.', false), ('C', 'Tiene carácter potestativo y se interpone en el plazo de un mes.', true), ('D', 'Es obligatoria y se interpone en el plazo de dos meses.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 24.4 de la Ley 19/2013, el plazo máximo para resolver y notificar la resolución de la reclamación ante el Consejo de Transparencia y Buen Gobierno es de:', 'El art. 24.4 LT fija tres meses para resolver la reclamación, con silencio desestimatorio.', 'age_aux_b1_07_transparencia', (select id from public.topics where slug = 'age-aux-b1-07-transparencia'), 3, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2013-12887'), 'Art. 24.4 LT', '4. El plazo máximo para resolver y notificar la resolución será de tres meses, transcurrido el cual, la reclamación se entenderá desestimada.', null, 'fe7f9e40ffce1a7f22f005ab1a45ace0878324c86034614e50312b76c4d86ebb', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'fe7f9e40ffce1a7f22f005ab1a45ace0878324c86034614e50312b76c4d86ebb')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Tres meses, transcurridos los cuales la reclamación se entenderá desestimada.', true), ('B', 'Tres meses, transcurridos los cuales la reclamación se entenderá estimada.', false), ('C', 'Un mes, transcurrido el cual la reclamación se entenderá desestimada.', false), ('D', 'Seis meses, transcurridos los cuales la reclamación se entenderá estimada.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'De acuerdo con el artículo 30.1 de la Ley 19/2013, las infracciones leves en materia de buen gobierno serán sancionadas con:', 'Las infracciones leves se sancionan con amonestación (art. 30.1 LT). La declaración del incumplimiento y su publicación, y la pérdida de la indemnización por cese, corresponden a las graves (art. 30.2); la destitución, a las muy graves (art. 30.4).', 'age_aux_b1_07_transparencia', (select id from public.topics where slug = 'age-aux-b1-07-transparencia'), 1, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2013-12887'), 'Art. 30.1 LT', '1. Las infracciones leves serán sancionadas con una amonestación.', null, '8038e028b6e2adf36026144427c85f0ae469646864c0ce1006a4ba6395214e51', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '8038e028b6e2adf36026144427c85f0ae469646864c0ce1006a4ba6395214e51')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'La declaración del incumplimiento y su publicación en el «Boletín Oficial del Estado».', false), ('B', 'La destitución del cargo.', false), ('C', 'La no percepción de la indemnización por cese en el cargo.', false), ('D', 'Una amonestación.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 30.4 de la Ley 19/2013, los sancionados por la comisión de una infracción muy grave no podrán ser nombrados para ocupar ningún puesto de alto cargo o asimilado durante un periodo:', 'Además de la destitución, la infracción muy grave conlleva la imposibilidad de ser nombrado alto cargo durante un periodo de entre cinco y diez años (art. 30.4 LT).', 'age_aux_b1_07_transparencia', (select id from public.topics where slug = 'age-aux-b1-07-transparencia'), 3, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2013-12887'), 'Art. 30.4 LT', '4. Los sancionados por la comisión de una infracción muy grave serán destituidos del cargo que ocupen salvo que ya hubiesen cesado y no podrán ser nombrados para ocupar ningún puesto de alto cargo o asimilado durante un periodo de entre cinco y diez años', null, 'afd648104a9b01bb19841ccd6c11eefa4a3afdb1173ebb834e155f6983caf90a', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'afd648104a9b01bb19841ccd6c11eefa4a3afdb1173ebb834e155f6983caf90a')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'De entre tres y cinco años.', false), ('B', 'De entre uno y tres años.', false), ('C', 'De entre cinco y diez años.', true), ('D', 'De entre diez y quince años.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'De acuerdo con el artículo 32.1 de la Ley 19/2013, el plazo de prescripción de las infracciones graves previstas en su título II es de:', 'Las infracciones del título II LT prescriben a los cinco años las muy graves, a los tres años las graves y al año las leves (art. 32.1).', 'age_aux_b1_07_transparencia', (select id from public.topics where slug = 'age-aux-b1-07-transparencia'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2013-12887'), 'Art. 32.1 LT', '1. El plazo de prescripción de las infracciones previstas en este título será de cinco años para las infracciones muy graves, tres años para las graves y un año para las leves.', null, '470e8b34f6b20092ef5c3741d4089f3505e67e4439a55511f8f518e56617517b', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '470e8b34f6b20092ef5c3741d4089f3505e67e4439a55511f8f518e56617517b')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Cinco años.', false), ('B', 'Tres años.', true), ('C', 'Un año.', false), ('D', 'Dos años.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 37.1 de la Ley 19/2013, el Presidente del Consejo de Transparencia y Buen Gobierno será nombrado mediante Real Decreto por un período de:', 'El art. 37.1 LT fija un mandato de cinco años no renovable. El nombramiento requiere comparecencia previa ante la Comisión correspondiente del Congreso, que debe refrendarlo por mayoría absoluta.', 'age_aux_b1_07_transparencia', (select id from public.topics where slug = 'age-aux-b1-07-transparencia'), 1, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2013-12887'), 'Art. 37.1 LT', '1. El Presidente del Consejo de Transparencia y Buen Gobierno será nombrado por un período no renovable de cinco años mediante Real Decreto', null, 'a735443c4d6e62834a18cae9e1ceece3768af0604b2429b40491b6ab9d92a0f0', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'a735443c4d6e62834a18cae9e1ceece3768af0604b2429b40491b6ab9d92a0f0')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Cinco años, no renovable.', true), ('B', 'Cuatro años, renovable por una sola vez.', false), ('C', 'Seis años, no renovable.', false), ('D', 'Cinco años, renovable por una sola vez.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
-- Lote age-aux-b1-08-age-lrjsp-v1 (20 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Ley 40/2015, de 1 de octubre, de Régimen Jurídico del Sector Público (texto consolidado, BOE)', 'https://www.boe.es/buscar/act.php?id=BOE-A-2015-10566', 'boe'::public.source_kind, 'Agencia Estatal Boletín Oficial del Estado', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('age-aux-b1-08-age', 'I.8 La Administración General del Estado') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug = 'auxiliar-administrativo-estado' and t.slug = 'age-aux-b1-08-age' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 55.2 de la Ley 40/2015, de Régimen Jurídico del Sector Público, la Administración General del Estado comprende:', 'El art. 55.2 LRJSP distingue tres niveles: la Organización Central (Ministerios y servicios comunes), la Organización Territorial y la Administración General del Estado en el exterior.', 'age_aux_b1_08_age', (select id from public.topics where slug = 'age-aux-b1-08-age'), 1, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2015-10566'), 'Art. 55.2 LRJSP', '2. La Administración General del Estado comprende: a) La Organización Central, que integra los Ministerios y los servicios comunes. b) La Organización Territorial. c) La Administración General del Estado en el exterior.', null, '1530dd7b4e90094c4fadc3038d4a8f55cae77cbbe99fdcd623e5c9b546a47907', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '1530dd7b4e90094c4fadc3038d4a8f55cae77cbbe99fdcd623e5c9b546a47907')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'La Organización Central, las Comunidades Autónomas y las Entidades Locales.', false), ('B', 'Los Ministerios, los Organismos públicos y las sociedades mercantiles estatales.', false), ('C', 'La Organización Central y la Organización Territorial, exclusivamente.', false), ('D', 'La Organización Central, la Organización Territorial y la Administración General del Estado en el exterior.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'De acuerdo con el artículo 55.3 de la Ley 40/2015, ¿cuál de los siguientes es un órgano superior de la organización central de la Administración General del Estado?', 'Son órganos superiores los Ministros y los Secretarios de Estado (art. 55.3.a LRJSP); Subsecretarios, Secretarios generales y Directores generales son órganos directivos.', 'age_aux_b1_08_age', (select id from public.topics where slug = 'age-aux-b1-08-age'), 1, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2015-10566'), 'Art. 55.3.a) LRJSP', 'a) Órganos superiores: 1.º Los Ministros. 2.º Los Secretarios de Estado.', null, 'fc528e28b50a12948f2bcae0d5bcf34a081c5e9b3eb8e588f4e2486f492c6c6c', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'fc528e28b50a12948f2bcae0d5bcf34a081c5e9b3eb8e588f4e2486f492c6c6c')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Los Secretarios de Estado.', true), ('B', 'Los Subsecretarios.', false), ('C', 'Los Secretarios generales.', false), ('D', 'Los Directores generales.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 55.3 de la Ley 40/2015, en la organización central de la Administración General del Estado tienen la consideración de órganos directivos:', 'El art. 55.3.b) LRJSP considera órganos directivos a los Subsecretarios y Secretarios generales, a los Secretarios generales técnicos y Directores generales, y a los Subdirectores generales.', 'age_aux_b1_08_age', (select id from public.topics where slug = 'age-aux-b1-08-age'), 1, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2015-10566'), 'Art. 55.3.b) LRJSP', 'b) Órganos directivos: 1.º Los Subsecretarios y Secretarios generales. 2.º Los Secretarios generales técnicos y Directores generales. 3.º Los Subdirectores generales.', null, 'ac75fd12d71b4d18d45d9697a74404d5460917f3bb3177dfa751344cde02fce2', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'ac75fd12d71b4d18d45d9697a74404d5460917f3bb3177dfa751344cde02fce2')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Los Ministros.', false), ('B', 'Los Secretarios de Estado.', false), ('C', 'Los Secretarios generales técnicos.', true), ('D', 'Las Comisiones Delegadas del Gobierno.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'De acuerdo con el artículo 55.4 de la Ley 40/2015, en la organización territorial de la Administración General del Estado:', 'El art. 55.4 LRJSP califica a Delegados y Subdelegados del Gobierno como órganos directivos: los primeros con rango de Subsecretario y los segundos con nivel de Subdirector general.', 'age_aux_b1_08_age', (select id from public.topics where slug = 'age-aux-b1-08-age'), 3, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2015-10566'), 'Art. 55.4 LRJSP', '4. En la organización territorial de la Administración General del Estado son órganos directivos tanto los Delegados del Gobierno en las Comunidades Autónomas, que tendrán rango de Subsecretario, como los Subdelegados del Gobierno en las provincias, los cuales tendrán nivel de Subdirector general.', null, '9780dff35a613a6b1811b746d7e9c65d19a8d91db52dbab107a70d9ef3c5d56f', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '9780dff35a613a6b1811b746d7e9c65d19a8d91db52dbab107a70d9ef3c5d56f')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Los Delegados del Gobierno tienen rango de Secretario de Estado y los Subdelegados del Gobierno, rango de Subsecretario.', false), ('B', 'Los Delegados del Gobierno tienen rango de Subsecretario y los Subdelegados del Gobierno, nivel de Subdirector general.', true), ('C', 'Los Delegados del Gobierno tienen rango de Director general y los Subdelegados del Gobierno, nivel de Subdirector general.', false), ('D', 'Los Delegados y los Subdelegados del Gobierno tienen ambos rango de Subsecretario.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 55.5 de la Ley 40/2015, en la Administración General del Estado en el exterior son órganos directivos:', 'El art. 55.5 LRJSP atribuye la condición de órganos directivos en el exterior a los embajadores y representantes permanentes ante Organizaciones internacionales.', 'age_aux_b1_08_age', (select id from public.topics where slug = 'age-aux-b1-08-age'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2015-10566'), 'Art. 55.5 LRJSP', '5. En la Administración General del Estado en el exterior son órganos directivos los embajadores y representantes permanentes ante Organizaciones internacionales.', null, '01639f8b46b5065345c8eb69a09f02aaf9b323e85287d63ac9635d8ec0135304', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '01639f8b46b5065345c8eb69a09f02aaf9b323e85287d63ac9635d8ec0135304')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Los cónsules honorarios.', false), ('B', 'Los agregados sectoriales de los Ministerios.', false), ('C', 'Los Delegados del Gobierno en el exterior.', false), ('D', 'Los embajadores y representantes permanentes ante Organizaciones internacionales.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'De acuerdo con el artículo 55.6 de la Ley 40/2015, los órganos superiores y directivos tienen además la condición de alto cargo, excepto:', 'Según el art. 55.6 LRJSP, todos los órganos superiores y directivos son altos cargos salvo los Subdirectores generales y asimilados.', 'age_aux_b1_08_age', (select id from public.topics where slug = 'age-aux-b1-08-age'), 3, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2015-10566'), 'Art. 55.6 LRJSP', '6. Los órganos superiores y directivos tienen además la condición de alto cargo, excepto los Subdirectores generales y asimilados', null, '5ee48304794e3f51d0afa8d91c4855f51ace36440eb286cba3374c81ed9a8dcb', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '5ee48304794e3f51d0afa8d91c4855f51ace36440eb286cba3374c81ed9a8dcb')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Los Secretarios generales técnicos.', false), ('B', 'Los Delegados del Gobierno en las Comunidades Autónomas.', false), ('C', 'Los Subdirectores generales y asimilados.', true), ('D', 'Los Directores generales.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 57.3 de la Ley 40/2015, la determinación del número, la denominación y el ámbito de competencia respectivo de los Ministerios y las Secretarías de Estado se establecen mediante:', 'El art. 57.3 LRJSP reserva esta decisión a un Real Decreto del Presidente del Gobierno.', 'age_aux_b1_08_age', (select id from public.topics where slug = 'age-aux-b1-08-age'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2015-10566'), 'Art. 57.3 LRJSP', '3. La determinación del número, la denominación y el ámbito de competencia respectivo de los Ministerios y las Secretarías de Estado se establecen mediante Real Decreto del Presidente del Gobierno.', null, 'ad45f3b91ceef382f40d95738aeff216ae31eed55c4b793a05e7b4a42ba0d6de', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'ad45f3b91ceef382f40d95738aeff216ae31eed55c4b793a05e7b4a42ba0d6de')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Real Decreto del Presidente del Gobierno.', true), ('B', 'Real Decreto del Consejo de Ministros.', false), ('C', 'Ley de las Cortes Generales.', false), ('D', 'Orden del Ministro de la Presidencia.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'De acuerdo con el artículo 58.2 de la Ley 40/2015, para la gestión de los servicios comunes los Ministerios contarán, en todo caso, con:', 'El art. 58.2 LRJSP exige en todo Ministerio una Subsecretaría y una Secretaría General Técnica dependiente de ella; las Secretarías de Estado y las Secretarías Generales son potestativas (art. 58.1).', 'age_aux_b1_08_age', (select id from public.topics where slug = 'age-aux-b1-08-age'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2015-10566'), 'Art. 58.2 LRJSP', '2. Los Ministerios contarán, en todo caso, con una Subsecretaría, y dependiendo de ella una Secretaría General Técnica, para la gestión de los servicios comunes previstos en este Título.', null, '47ad71980a26082f6fae9f3bcd67c1a82d15d376b719e3d40627fb88faea0f7e', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '47ad71980a26082f6fae9f3bcd67c1a82d15d376b719e3d40627fb88faea0f7e')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Una Secretaría de Estado y, dependiendo de ella, una Secretaría General.', false), ('B', 'Una Subsecretaría y, dependiendo de ella, una Secretaría General Técnica.', true), ('C', 'Una Secretaría General y, dependiendo de ella, una Dirección General de Servicios.', false), ('D', 'Una Subsecretaría y, dependiendo de ella, una Secretaría de Estado.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 59 de la Ley 40/2015, los órganos de nivel inferior a Subdirección General se crean, modifican y suprimen:', 'El art. 59.2 LRJSP prevé la orden del Ministro respectivo, previa autorización del Ministro de Hacienda y Administraciones Públicas. El Real Decreto del Consejo de Ministros se reserva a Subsecretarías, Secretarías Generales, Direcciones y Subdirecciones Generales (art. 59.1), y las relaciones de puestos de trabajo, a las unidades que no son órganos (art. 59.3).', 'age_aux_b1_08_age', (select id from public.topics where slug = 'age-aux-b1-08-age'), 3, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2015-10566'), 'Art. 59.2 LRJSP', '2. Los órganos de nivel inferior a Subdirección General se crean, modifican y suprimen por orden del Ministro respectivo, previa autorización del Ministro de Hacienda y Administraciones Públicas.', 'El texto consolidado mantiene «Ministro de Hacienda y Administraciones Públicas», denominación ya desaparecida; revisar si conviene mantenerla.', 'ffade3fdf44f1036c4f7082e6cd7cd8236e14d8b5258973f646e76f89c3280e6', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'ffade3fdf44f1036c4f7082e6cd7cd8236e14d8b5258973f646e76f89c3280e6')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Por Real Decreto del Consejo de Ministros, a iniciativa del Ministro interesado.', false), ('B', 'Por Real Decreto del Presidente del Gobierno.', false), ('C', 'Por orden del Ministro respectivo, previa autorización del Ministro de Hacienda y Administraciones Públicas.', true), ('D', 'A través de las relaciones de puestos de trabajo.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'De acuerdo con el artículo 60.2 de la Ley 40/2015, los Secretarios generales y los Secretarios generales técnicos tienen, respectivamente, categoría de:', 'El art. 60.2 LRJSP equipara a los Secretarios generales con los Subsecretarios y a los Secretarios generales técnicos con los Directores generales.', 'age_aux_b1_08_age', (select id from public.topics where slug = 'age-aux-b1-08-age'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2015-10566'), 'Art. 60.2 LRJSP', 'Los Secretarios generales tienen categoría de Subsecretario y los Secretarios Generales Técnicos tienen categoría de Director general.', null, '91fbd7b1e528c64cdcc332967e4a1c90c985d41d5aee32fb2d007bb752621758', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '91fbd7b1e528c64cdcc332967e4a1c90c985d41d5aee32fb2d007bb752621758')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Subsecretario y Director general.', true), ('B', 'Secretario de Estado y Subsecretario.', false), ('C', 'Director general y Subdirector general.', false), ('D', 'Subsecretario y Subsecretario.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según la Ley 40/2015, ¿a qué órgano del Ministerio corresponde imponer la sanción de separación del servicio por faltas muy graves?', 'El art. 61.s) LRJSP atribuye al Ministro la imposición de la separación del servicio por faltas muy graves; el Subsecretario ejerce la potestad disciplinaria por faltas graves o muy graves salvo la separación del servicio (art. 63.1.ñ).', 'age_aux_b1_08_age', (select id from public.topics where slug = 'age-aux-b1-08-age'), 3, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2015-10566'), 'Art. 61.s) LRJSP', 's) Imponer la sanción de separación del servicio por faltas muy graves.', null, 'c306047e066e76f4ddcfe7dea48817ac14f3047dc1e2adf63619a6761e14c399', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'c306047e066e76f4ddcfe7dea48817ac14f3047dc1e2adf63619a6761e14c399')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Al Subsecretario.', false), ('B', 'Al Ministro.', true), ('C', 'Al Secretario general técnico.', false), ('D', 'Al Secretario de Estado del que dependa el funcionario.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'De acuerdo con el artículo 63.1 de la Ley 40/2015, ¿qué órgano ostenta la representación ordinaria del Ministerio y dirige los servicios comunes?', 'El art. 63.1 LRJSP atribuye a los Subsecretarios la representación ordinaria del Ministerio y la dirección de los servicios comunes.', 'age_aux_b1_08_age', (select id from public.topics where slug = 'age-aux-b1-08-age'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2015-10566'), 'Art. 63.1 LRJSP', '1. Los Subsecretarios ostentan la representación ordinaria del Ministerio, dirigen los servicios comunes, ejercen las competencias correspondientes a dichos servicios comunes', null, '75525145eac93b071dfaca282f9946bb3801b6189163a153b8b23d212aa628d9', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '75525145eac93b071dfaca282f9946bb3801b6189163a153b8b23d212aa628d9')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El Secretario general técnico.', false), ('B', 'El Secretario de Estado.', false), ('C', 'El Director general de Servicios.', false), ('D', 'El Subsecretario.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 63.3 de la Ley 40/2015, los nombramientos de Subsecretarios habrán de efectuarse entre funcionarios de carrera del Estado, de las Comunidades Autónomas o de las Entidades locales pertenecientes:', 'El art. 63.3 LRJSP exige que los Subsecretarios sean funcionarios de carrera del Subgrupo A1 (o jubilados que tuvieran esa condición) y reúnan los requisitos de idoneidad de la Ley 3/2015.', 'age_aux_b1_08_age', (select id from public.topics where slug = 'age-aux-b1-08-age'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2015-10566'), 'Art. 63.3 LRJSP', 'Los nombramientos habrán de efectuarse entre funcionarios de carrera del Estado, de las Comunidades Autónomas o de las Entidades locales, pertenecientes al Subgrupo A1', null, 'aee7bef1f3148610cfce6d615269d17ffe798b7e93a11ef556a18df8f98b0b1a', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'aee7bef1f3148610cfce6d615269d17ffe798b7e93a11ef556a18df8f98b0b1a')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Al Subgrupo A2.', false), ('B', 'Al Subgrupo A1.', true), ('C', 'A cualquier Subgrupo, siempre que acrediten experiencia directiva.', false), ('D', 'Al Grupo B.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'De acuerdo con el artículo 65.1 de la Ley 40/2015, los Secretarios generales técnicos tendrán, en todo caso, las competencias relativas a:', 'Bajo la inmediata dependencia del Subsecretario, los Secretarios generales técnicos tienen siempre las competencias de producción normativa, asistencia jurídica y publicaciones (art. 65.1 LRJSP).', 'age_aux_b1_08_age', (select id from public.topics where slug = 'age-aux-b1-08-age'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2015-10566'), 'Art. 65.1 LRJSP', '1. Los Secretarios generales técnicos, bajo la inmediata dependencia del Subsecretario, tendrán las competencias sobre servicios comunes que les atribuya el Real Decreto de estructura del Departamento y, en todo caso, las relativas a producción normativa, asistencia jurídica y publicaciones.', null, 'a64344b2143603efbc3fb2d6d7d7e8356201989c093e49a815f6ff0af8ac3b44', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'a64344b2143603efbc3fb2d6d7d7e8356201989c093e49a815f6ff0af8ac3b44')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Gestión de personal, contratación y patrimonio.', false), ('B', 'Relaciones con las Comunidades Autónomas y convocatoria de Conferencias sectoriales.', false), ('C', 'Inspección de servicios y potestad disciplinaria.', false), ('D', 'Producción normativa, asistencia jurídica y publicaciones.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 67.2 de la Ley 40/2015, los Subdirectores generales son nombrados y cesados:', 'El art. 67.2 LRJSP atribuye su nombramiento y cese al Ministro, Secretario de Estado o Subsecretario del que dependan, respetando los principios de igualdad, mérito y capacidad. Los Directores generales, en cambio, se nombran por Real Decreto del Consejo de Ministros (art. 66.2).', 'age_aux_b1_08_age', (select id from public.topics where slug = 'age-aux-b1-08-age'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2015-10566'), 'Art. 67.2 LRJSP', '2. Los Subdirectores generales serán nombrados, respetando los principios de igualdad, mérito y capacidad, y cesados por el Ministro, Secretario de Estado o Subsecretario del que dependan.', null, '2961f5de2c7cdd6ea95af384e63cebb1810ff9022128f92c2d2d404ae5fa92a6', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '2961f5de2c7cdd6ea95af384e63cebb1810ff9022128f92c2d2d404ae5fa92a6')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Por el Ministro, Secretario de Estado o Subsecretario del que dependan.', true), ('B', 'Por Real Decreto del Consejo de Ministros, a propuesta del titular del Departamento.', false), ('C', 'Por el Director general del que dependan.', false), ('D', 'Por Real Decreto del Presidente del Gobierno.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'De acuerdo con el artículo 69 de la Ley 40/2015, las Delegaciones del Gobierno:', 'El art. 69 LRJSP prevé una Delegación del Gobierno en cada Comunidad Autónoma, con sede donde radique el Consejo de Gobierno autonómico, salvo que el Consejo de Ministros acuerde otra ubicación o el Estatuto disponga otra cosa.', 'age_aux_b1_08_age', (select id from public.topics where slug = 'age-aux-b1-08-age'), 1, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2015-10566'), 'Art. 69.1-2 LRJSP', '1. Existirá una Delegación del Gobierno en cada una de las Comunidades Autónomas. 2. Las Delegaciones del Gobierno tendrán su sede en la localidad donde radique el Consejo de Gobierno de la Comunidad Autónoma', null, '438e99f1afb469a127255458345d9a2ce3b7de0573b9ac45549284a09d0cdf2a', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '438e99f1afb469a127255458345d9a2ce3b7de0573b9ac45549284a09d0cdf2a')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Existen en cada una de las provincias y tienen su sede en la capital de la provincia.', false), ('B', 'Existen solo en las Comunidades Autónomas pluriprovinciales y tienen su sede donde decida el Delegado.', false), ('C', 'Existen en cada una de las Comunidades Autónomas y tienen su sede, como regla general, en la localidad donde radique el Consejo de Gobierno de la Comunidad.', true), ('D', 'Existen en cada Comunidad Autónoma y tienen su sede, en todo caso, en la capital del Estado.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 72.3 de la Ley 40/2015, los Delegados del Gobierno en las Comunidades Autónomas dependen:', 'El art. 72.3 LRJSP define a los Delegados del Gobierno como órganos directivos con rango de Subsecretario, con dependencia orgánica del Presidente del Gobierno y funcional del Ministerio competente por razón de la materia.', 'age_aux_b1_08_age', (select id from public.topics where slug = 'age-aux-b1-08-age'), 3, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2015-10566'), 'Art. 72.3 LRJSP', '3. Los Delegados del Gobierno son órganos directivos con rango de Subsecretario que dependen orgánicamente del Presidente del Gobierno y funcionalmente del Ministerio competente por razón de la materia.', null, '0f921d241c79be66d5ea36f530d0e9af848572459d4f40f3792c7c6aa2b38475', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '0f921d241c79be66d5ea36f530d0e9af848572459d4f40f3792c7c6aa2b38475')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Orgánicamente del Ministerio del Interior y funcionalmente del Presidente del Gobierno.', false), ('B', 'Orgánica y funcionalmente del Presidente de la Comunidad Autónoma.', false), ('C', 'Orgánicamente del Presidente del Gobierno y funcionalmente del Ministerio competente por razón de la materia.', true), ('D', 'Orgánicamente del Consejo de Ministros y funcionalmente del Subsecretario de la Presidencia.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'De acuerdo con el artículo 72.4 de la Ley 40/2015, los Delegados del Gobierno en las Comunidades Autónomas son nombrados y separados:', 'El art. 72.4 LRJSP dispone su nombramiento y separación por Real Decreto del Consejo de Ministros a propuesta del Presidente del Gobierno, atendiendo a criterios de competencia profesional y experiencia.', 'age_aux_b1_08_age', (select id from public.topics where slug = 'age-aux-b1-08-age'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2015-10566'), 'Art. 72.4 LRJSP', '4. Los Delegados del Gobierno serán nombrados y separados por Real Decreto del Consejo de Ministros, a propuesta del Presidente del Gobierno.', null, 'd1373ce038e02f6211cb394ad8e90bf6b2dbce342d283610464c0ee644334166', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'd1373ce038e02f6211cb394ad8e90bf6b2dbce342d283610464c0ee644334166')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Por Real Decreto del Presidente del Gobierno, a propuesta del Ministro del Interior.', false), ('B', 'Por el Presidente de la Comunidad Autónoma, previa conformidad del Gobierno.', false), ('C', 'Por orden del Ministro de Hacienda y Administraciones Públicas, mediante libre designación.', false), ('D', 'Por Real Decreto del Consejo de Ministros, a propuesta del Presidente del Gobierno.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 74 de la Ley 40/2015, ¿quién nombra al Subdelegado del Gobierno en cada provincia?', 'El Subdelegado, con nivel de Subdirector General y bajo la inmediata dependencia del Delegado, es nombrado por este por libre designación entre funcionarios de carrera del Subgrupo A1 (art. 74 LRJSP).', 'age_aux_b1_08_age', (select id from public.topics where slug = 'age-aux-b1-08-age'), 1, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2015-10566'), 'Art. 74 LRJSP', 'En cada provincia y bajo la inmediata dependencia del Delegado del Gobierno en la respectiva Comunidad Autónoma, existirá un Subdelegado del Gobierno, con nivel de Subdirector General, que será nombrado por aquél mediante el procedimiento de libre designación', null, '1abbc37937e857ce8477e17b5449754c296ae1c62bf1ac3801ca5fd4cd5d0696', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '1abbc37937e857ce8477e17b5449754c296ae1c62bf1ac3801ca5fd4cd5d0696')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El Delegado del Gobierno en la respectiva Comunidad Autónoma, mediante libre designación.', true), ('B', 'El Consejo de Ministros, mediante Real Decreto.', false), ('C', 'El Ministro del Interior, mediante concurso.', false), ('D', 'El Presidente de la Diputación Provincial.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'De acuerdo con el artículo 80 de la Ley 40/2015, el Servicio Exterior del Estado se rige en lo concerniente a su composición, organización, funciones, integración y personal:', 'El art. 80 LRJSP remite a la Ley 2/2014, de 25 de marzo, de la Acción y del Servicio Exterior del Estado, y a su normativa de desarrollo, con aplicación supletoria de la propia Ley 40/2015.', 'age_aux_b1_08_age', (select id from public.topics where slug = 'age-aux-b1-08-age'), 1, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2015-10566'), 'Art. 80 LRJSP', 'El Servicio Exterior del Estado se rige en todo lo concerniente a su composición, organización, funciones, integración y personal por lo dispuesto en la Ley 2/2014, de 25 de marzo, de la Acción y del Servicio Exterior del Estado y en su normativa de desarrollo y, supletoriamente, por lo dispuesto en esta Ley.', null, '480fdf7aa94abd21c1044b6295d923720b234e39c7de7250f8f4cbc6278b6a95', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '480fdf7aa94abd21c1044b6295d923720b234e39c7de7250f8f4cbc6278b6a95')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Exclusivamente por la Ley 40/2015.', false), ('B', 'Por la Ley 2/2014, de la Acción y del Servicio Exterior del Estado, y su normativa de desarrollo y, supletoriamente, por la Ley 40/2015.', true), ('C', 'Por la Ley 50/1997, del Gobierno, y, supletoriamente, por los tratados internacionales.', false), ('D', 'Por la Ley 39/2015, del Procedimiento Administrativo Común, y, supletoriamente, por la Ley 40/2015.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
-- Lote age-aux-b1-09-organizacion-territorial-ce-v1 (13 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Constitución Española (texto consolidado, BOE)', 'https://www.boe.es/buscar/act.php?id=BOE-A-1978-31229', 'boe'::public.source_kind, 'Agencia Estatal Boletín Oficial del Estado', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('age-aux-b1-09-organizacion-territorial', 'I.9 La organización territorial del Estado') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug = 'auxiliar-administrativo-estado' and t.slug = 'age-aux-b1-09-organizacion-territorial' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 137 de la Constitución Española, el Estado se organiza territorialmente en:', 'El art. 137 CE enumera municipios, provincias y Comunidades Autónomas, y reconoce a todas ellas autonomía para la gestión de sus respectivos intereses.', 'age_aux_b1_09_organizacion_territorial', (select id from public.topics where slug = 'age-aux-b1-09-organizacion-territorial'), 1, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1978-31229'), 'Art. 137 CE', 'El Estado se organiza territorialmente en municipios, en provincias y en las Comunidades Autónomas que se constituyan. Todas estas entidades gozan de autonomía para la gestión de sus respectivos intereses.', null, 'd7151f5a3ccc24b841aa2d954da0e4676ce6ee7cc16b1c2d5fe67285edf17043', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'd7151f5a3ccc24b841aa2d954da0e4676ce6ee7cc16b1c2d5fe67285edf17043')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Municipios, comarcas y Comunidades Autónomas.', false), ('B', 'Municipios, provincias y las Comunidades Autónomas que se constituyan.', true), ('C', 'Provincias, regiones y nacionalidades.', false), ('D', 'Municipios, provincias, islas y áreas metropolitanas.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'De acuerdo con el artículo 141.1 de la Constitución, cualquier alteración de los límites provinciales habrá de ser aprobada:', 'El art. 141.1 CE reserva la alteración de los límites provinciales a las Cortes Generales mediante ley orgánica.', 'age_aux_b1_09_organizacion_territorial', (select id from public.topics where slug = 'age-aux-b1-09-organizacion-territorial'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1978-31229'), 'Art. 141.1 CE', 'Cualquier alteración de los límites provinciales habrá de ser aprobada por las Cortes Generales mediante ley orgánica.', null, '7aca613f7540377c135b7616602c84d6e3d3cd7f9045aec8d76d5f4c0d8a3182', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '7aca613f7540377c135b7616602c84d6e3d3cd7f9045aec8d76d5f4c0d8a3182')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Por las Comunidades Autónomas afectadas mediante ley autonómica.', false), ('B', 'Por el Gobierno mediante Real Decreto, previo dictamen del Consejo de Estado.', false), ('C', 'Por las Cortes Generales mediante ley orgánica.', true), ('D', 'Por las Diputaciones afectadas, con ratificación del Senado.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 141.4 de la Constitución, en los archipiélagos las islas tendrán además su administración propia en forma de:', 'El art. 141.4 CE prevé que en los archipiélagos las islas tengan administración propia en forma de Cabildos o Consejos.', 'age_aux_b1_09_organizacion_territorial', (select id from public.topics where slug = 'age-aux-b1-09-organizacion-territorial'), 1, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1978-31229'), 'Art. 141.4 CE', '4. En los archipiélagos, las islas tendrán además su administración propia en forma de Cabildos o Consejos.', null, 'f50e2e81ecd11c38ceab586609d78dbb85f6db4ba02d52810883ba5fa74cc78b', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'f50e2e81ecd11c38ceab586609d78dbb85f6db4ba02d52810883ba5fa74cc78b')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Cabildos o Consejos.', true), ('B', 'Diputaciones insulares exclusivamente.', false), ('C', 'Mancomunidades interinsulares.', false), ('D', 'Delegaciones insulares del Gobierno.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'De acuerdo con el artículo 143.2 de la Constitución, la iniciativa del proceso autonómico corresponde a todas las Diputaciones interesadas o al órgano interinsular correspondiente y a:', 'El art. 143.2 CE exige, además de las Diputaciones u órgano interinsular, a dos tercios de los municipios que representen la mayoría del censo de cada provincia o isla, en el plazo de seis meses. Las tres cuartas partes son las del art. 151.1.', 'age_aux_b1_09_organizacion_territorial', (select id from public.topics where slug = 'age-aux-b1-09-organizacion-territorial'), 3, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1978-31229'), 'Art. 143.2 CE', '2. La iniciativa del proceso autonómico corresponde a todas las Diputaciones interesadas o al órgano interinsular correspondiente y a las dos terceras partes de los municipios cuya población represente, al menos, la mayoría del censo electoral de cada provincia o isla.', null, 'd28c18380055b1a572d54e8b7643f6ffe8c8665b753d2aa3b809a85683330a8f', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'd28c18380055b1a572d54e8b7643f6ffe8c8665b753d2aa3b809a85683330a8f')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Las tres cuartas partes de los municipios cuya población represente, al menos, la mayoría del censo electoral de cada provincia o isla.', false), ('B', 'La mayoría absoluta de los municipios, cualquiera que sea su población.', false), ('C', 'La mitad de los municipios cuya población represente, al menos, las dos terceras partes del censo electoral de cada provincia.', false), ('D', 'Las dos terceras partes de los municipios cuya población represente, al menos, la mayoría del censo electoral de cada provincia o isla.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 143.3 de la Constitución, la iniciativa del proceso autonómico, en caso de no prosperar, solamente podrá reiterarse pasados:', 'El art. 143.3 CE impide reiterar la iniciativa fallida hasta transcurridos cinco años.', 'age_aux_b1_09_organizacion_territorial', (select id from public.topics where slug = 'age-aux-b1-09-organizacion-territorial'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1978-31229'), 'Art. 143.3 CE', '3. La iniciativa, en caso de no prosperar, solamente podrá reiterarse pasados cinco años.', null, '8a5dd10526dc57d781f13620343618fd0a5721c5c577e175a85b5a188716793a', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '8a5dd10526dc57d781f13620343618fd0a5721c5c577e175a85b5a188716793a')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Tres años.', false), ('B', 'Dos años.', false), ('C', 'Seis meses.', false), ('D', 'Cinco años.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'En relación con las Comunidades Autónomas, el artículo 145.1 de la Constitución establece que:', 'El art. 145.1 CE prohíbe en todo caso la federación de Comunidades Autónomas; sí caben convenios y acuerdos de cooperación en los términos del art. 145.2.', 'age_aux_b1_09_organizacion_territorial', (select id from public.topics where slug = 'age-aux-b1-09-organizacion-territorial'), 1, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1978-31229'), 'Art. 145.1 CE', '1. En ningún caso se admitirá la federación de Comunidades Autónomas.', null, '7b01df874321cf05e23279552b1624d914a7e1a4db2363ef8d16803ae2077680', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '7b01df874321cf05e23279552b1624d914a7e1a4db2363ef8d16803ae2077680')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'En ningún caso se admitirá la federación de Comunidades Autónomas.', true), ('B', 'Las Comunidades Autónomas limítrofes podrán federarse con autorización de las Cortes Generales.', false), ('C', 'La federación de Comunidades Autónomas requiere referéndum en cada una de ellas.', false), ('D', 'La federación de Comunidades Autónomas se admite si así lo prevén sus Estatutos.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'De acuerdo con el artículo 147.1 de la Constitución, dentro de los términos de esta, la norma institucional básica de cada Comunidad Autónoma es:', 'El art. 147.1 CE configura los Estatutos como norma institucional básica de cada Comunidad, que el Estado reconoce y ampara como parte de su ordenamiento.', 'age_aux_b1_09_organizacion_territorial', (select id from public.topics where slug = 'age-aux-b1-09-organizacion-territorial'), 1, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1978-31229'), 'Art. 147.1 CE', '1. Dentro de los términos de la presente Constitución, los Estatutos serán la norma institucional básica de cada Comunidad Autónoma y el Estado los reconocerá y amparará como parte integrante de su ordenamiento jurídico.', null, '8ef50df5575ef52ae154ee86d5f3a44edfe4fc9a2174445e0a1b1cfe9c81356f', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '8ef50df5575ef52ae154ee86d5f3a44edfe4fc9a2174445e0a1b1cfe9c81356f')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'La ley orgánica de transferencia de competencias.', false), ('B', 'Su Estatuto de Autonomía.', true), ('C', 'El Reglamento de su Asamblea Legislativa.', false), ('D', 'La ley de bases de régimen autonómico.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 148.2 de la Constitución, las Comunidades Autónomas podrán ampliar sucesivamente sus competencias dentro del marco del artículo 149, mediante la reforma de sus Estatutos, una vez transcurridos:', 'El art. 148.2 CE permite ampliar competencias por reforma estatutaria transcurridos cinco años; el art. 151.1 regula el supuesto en que no es preciso esperar ese plazo.', 'age_aux_b1_09_organizacion_territorial', (select id from public.topics where slug = 'age-aux-b1-09-organizacion-territorial'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1978-31229'), 'Art. 148.2 CE', '2. Transcurridos cinco años, y mediante la reforma de sus Estatutos, las Comunidades Autónomas podrán ampliar sucesivamente sus competencias dentro del marco establecido en el artículo 149.', null, '750394fe2959e33bef426cb4cdbc437aa82b6088b5545102aadc9f2d802060f7', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '750394fe2959e33bef426cb4cdbc437aa82b6088b5545102aadc9f2d802060f7')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Tres años.', false), ('B', 'Cuatro años.', false), ('C', 'Cinco años.', true), ('D', 'Diez años.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select '¿Cuál de las siguientes materias es competencia exclusiva del Estado según el artículo 149.1 de la Constitución?', 'Las relaciones internacionales figuran en el art. 149.1.3.ª CE. Asistencia social, artesanía y promoción del deporte son materias que pueden asumir las Comunidades Autónomas (art. 148.1, materias 20.ª, 14.ª y 19.ª).', 'age_aux_b1_09_organizacion_territorial', (select id from public.topics where slug = 'age-aux-b1-09-organizacion-territorial'), 1, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1978-31229'), 'Art. 149.1.3.ª CE', '1. El Estado tiene competencia exclusiva sobre las siguientes materias: […] 3.ª Relaciones internacionales.', null, '549786d063514a53ca5ca004c94c8fa3d4938d17c66dc5829326f179ae78d766', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '549786d063514a53ca5ca004c94c8fa3d4938d17c66dc5829326f179ae78d766')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Asistencia social.', false), ('B', 'Artesanía.', false), ('C', 'Relaciones internacionales.', true), ('D', 'Promoción del deporte y de la adecuada utilización del ocio.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'De acuerdo con el artículo 149.3 de la Constitución, en relación con el derecho de las Comunidades Autónomas, el derecho estatal será:', 'El art. 149.3 CE establece la cláusula de supletoriedad: el derecho estatal es, en todo caso, supletorio del autonómico. La prevalencia estatal solo opera en lo que no sea competencia exclusiva de las Comunidades.', 'age_aux_b1_09_organizacion_territorial', (select id from public.topics where slug = 'age-aux-b1-09-organizacion-territorial'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1978-31229'), 'Art. 149.3 CE', 'El derecho estatal será, en todo caso, supletorio del derecho de las Comunidades Autónomas.', null, 'd70cd24f2e64773dee4e2a2f1daaede99b9641c98a986bd31a06e4d81a8b2a82', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'd70cd24f2e64773dee4e2a2f1daaede99b9641c98a986bd31a06e4d81a8b2a82')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'En todo caso, supletorio.', true), ('B', 'Siempre de aplicación preferente, aunque la materia sea de competencia exclusiva autonómica.', false), ('C', 'Inaplicable en las materias asumidas por los Estatutos.', false), ('D', 'Supletorio únicamente en las Comunidades que accedieron a la autonomía por el artículo 143.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 150.3 de la Constitución, la apreciación de la necesidad de dictar leyes que establezcan los principios necesarios para armonizar las disposiciones normativas de las Comunidades Autónomas corresponde:', 'Las leyes de armonización exigen que las Cortes Generales aprecien su necesidad por mayoría absoluta de cada Cámara (art. 150.3 CE).', 'age_aux_b1_09_organizacion_territorial', (select id from public.topics where slug = 'age-aux-b1-09-organizacion-territorial'), 3, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1978-31229'), 'Art. 150.3 CE', 'Corresponde a las Cortes Generales, por mayoría absoluta de cada Cámara, la apreciación de esta necesidad.', null, '9faeee13b36541c84bdf65f128ff10433527f85898d73bc460fcfa2a7b47f57e', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '9faeee13b36541c84bdf65f128ff10433527f85898d73bc460fcfa2a7b47f57e')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Al Gobierno, previo dictamen del Consejo de Estado.', false), ('B', 'Al Congreso de los Diputados, por mayoría de tres quintos.', false), ('C', 'Al Senado, por mayoría absoluta.', false), ('D', 'A las Cortes Generales, por mayoría absoluta de cada Cámara.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'De acuerdo con el artículo 153 de la Constitución, el control económico y presupuestario de la actividad de los órganos de las Comunidades Autónomas se ejercerá por:', 'El art. 153 CE reparte el control: el Tribunal Constitucional (normas con fuerza de ley), el Gobierno (funciones delegadas del art. 150.2), la jurisdicción contencioso-administrativa (administración autonómica y reglamentos) y el Tribunal de Cuentas (económico y presupuestario).', 'age_aux_b1_09_organizacion_territorial', (select id from public.topics where slug = 'age-aux-b1-09-organizacion-territorial'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1978-31229'), 'Art. 153.d) CE', 'd) Por el Tribunal de Cuentas, el económico y presupuestario.', null, 'e7f48141309659d229979421a632b4d48f89dd9eb617cc4443a1497418f8a81b', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'e7f48141309659d229979421a632b4d48f89dd9eb617cc4443a1497418f8a81b')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El Tribunal Constitucional.', false), ('B', 'El Tribunal de Cuentas.', true), ('C', 'El Gobierno, previo dictamen del Consejo de Estado.', false), ('D', 'La jurisdicción contencioso-administrativa.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 155.1 de la Constitución, para adoptar las medidas necesarias para obligar a una Comunidad Autónoma al cumplimiento forzoso de sus obligaciones, el Gobierno necesita, tras un requerimiento no atendido a su Presidente:', 'El art. 155.1 CE exige requerimiento previo al Presidente de la Comunidad y, si no es atendido, la aprobación por mayoría absoluta del Senado.', 'age_aux_b1_09_organizacion_territorial', (select id from public.topics where slug = 'age-aux-b1-09-organizacion-territorial'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1978-31229'), 'Art. 155.1 CE', 'el Gobierno, previo requerimiento al Presidente de la Comunidad Autónoma y, en el caso de no ser atendido, con la aprobación por mayoría absoluta del Senado, podrá adoptar las medidas necesarias para obligar a aquélla al cumplimiento forzoso de dichas obligaciones', null, 'e2a81727ecab980af25562b408e61f7d4af149853347ed39b5897fe25bc029ed', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'e2a81727ecab980af25562b408e61f7d4af149853347ed39b5897fe25bc029ed')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'La autorización por mayoría absoluta del Congreso de los Diputados.', false), ('B', 'La aprobación por mayoría absoluta del Senado.', true), ('C', 'La aprobación por mayoría absoluta de ambas Cámaras.', false), ('D', 'El dictamen favorable del Tribunal Constitucional.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
-- Lote age-aux-b1-09-organizacion-territorial-lbrl-v1 (7 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Ley 7/1985, de 2 de abril, Reguladora de las Bases del Régimen Local (texto consolidado, BOE)', 'https://www.boe.es/buscar/act.php?id=BOE-A-1985-5392', 'boe'::public.source_kind, 'Agencia Estatal Boletín Oficial del Estado', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('age-aux-b1-09-organizacion-territorial', 'I.9 La organización territorial del Estado') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug = 'auxiliar-administrativo-estado' and t.slug = 'age-aux-b1-09-organizacion-territorial' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'De acuerdo con el artículo 3.1 de la Ley 7/1985, Reguladora de las Bases del Régimen Local, ¿cuál de las siguientes es una Entidad Local territorial?', 'Son Entidades Locales territoriales el Municipio, la Provincia y la Isla en los archipiélagos balear y canario (art. 3.1 LBRL). Comarcas, Áreas Metropolitanas y Mancomunidades son también Entidades Locales, pero no territoriales (art. 3.2).', 'age_aux_b1_09_organizacion_territorial', (select id from public.topics where slug = 'age-aux-b1-09-organizacion-territorial'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1985-5392'), 'Art. 3.1 LBRL', '1. Son Entidades Locales territoriales: a) El Municipio. b) La Provincia. c) La Isla en los archipiélagos balear y canario.', null, '2928a5c1bf948b122b7614fc22ab24cf7d9d470161ac59cdf850c65c78adacb2', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '2928a5c1bf948b122b7614fc22ab24cf7d9d470161ac59cdf850c65c78adacb2')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'La Isla en los archipiélagos balear y canario.', true), ('B', 'La Comarca.', false), ('C', 'El Área Metropolitana.', false), ('D', 'La Mancomunidad de Municipios.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 11.2 de la Ley 7/1985, Reguladora de las Bases del Régimen Local, son elementos del Municipio:', 'El art. 11.2 LBRL enumera como elementos del Municipio el territorio, la población y la organización.', 'age_aux_b1_09_organizacion_territorial', (select id from public.topics where slug = 'age-aux-b1-09-organizacion-territorial'), 1, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1985-5392'), 'Art. 11.2 LBRL', '2. Son elementos del Municipio el territorio, la población y la organización.', null, '8edd779d83f5dacc545ad534e7dfc6966ba89c787ffb8852d18525ea027efa31', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '8edd779d83f5dacc545ad534e7dfc6966ba89c787ffb8852d18525ea027efa31')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El territorio, el Padrón y el Ayuntamiento.', false), ('B', 'La población, el Alcalde y el Pleno.', false), ('C', 'El territorio, la población y la organización.', true), ('D', 'El término municipal, los vecinos y la Hacienda local.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'De acuerdo con el artículo 13.2 de la Ley 7/1985, la creación de nuevos municipios solo podrá realizarse sobre la base de núcleos de población territorialmente diferenciados de al menos:', 'El art. 13.2 LBRL exige núcleos territorialmente diferenciados de al menos 4.000 habitantes y que los municipios resultantes sean financieramente sostenibles.', 'age_aux_b1_09_organizacion_territorial', (select id from public.topics where slug = 'age-aux-b1-09-organizacion-territorial'), 3, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1985-5392'), 'Art. 13.2 LBRL', '2. La creación de nuevos municipios solo podrá realizarse sobre la base de núcleos de población territorialmente diferenciados, de al menos 4.000 habitantes', null, 'efa0bb0d40b809119d3c8be1c3cee5c6d574be9a10a0e30340c3de9317d24dc1', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'efa0bb0d40b809119d3c8be1c3cee5c6d574be9a10a0e30340c3de9317d24dc1')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', '5.000 habitantes.', false), ('B', '2.000 habitantes.', false), ('C', '10.000 habitantes.', false), ('D', '4.000 habitantes.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 20.1 de la Ley 7/1985, la Junta de Gobierno Local existe en todos los municipios con población superior a:', 'El art. 20.1.b) LBRL establece la Junta de Gobierno Local en municipios de más de 5.000 habitantes y, en los de menos, cuando lo disponga el reglamento orgánico o lo acuerde el Pleno. Alcalde, Tenientes de Alcalde y Pleno existen en todos los ayuntamientos.', 'age_aux_b1_09_organizacion_territorial', (select id from public.topics where slug = 'age-aux-b1-09-organizacion-territorial'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1985-5392'), 'Art. 20.1.b) LBRL', 'b) La Junta de Gobierno Local existe en todos los municipios con población superior a 5.000 habitantes y en los de menos, cuando así lo disponga su reglamento orgánico o así lo acuerde el Pleno de su ayuntamiento.', null, '449393cd076ecab05ad7b391b120cb1279e9c979ed9efb6d64dfec71502ebd89', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '449393cd076ecab05ad7b391b120cb1279e9c979ed9efb6d64dfec71502ebd89')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', '5.000 habitantes, y en los de menos cuando así lo disponga su reglamento orgánico o lo acuerde el Pleno.', true), ('B', '20.000 habitantes, y en los de menos cuando así lo acuerde el Alcalde.', false), ('C', '5.000 habitantes, sin que pueda existir en los de población inferior.', false), ('D', '50.000 habitantes, y en los de menos cuando así lo disponga la Comunidad Autónoma.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'De acuerdo con el artículo 23.1 de la Ley 7/1985, la Junta de Gobierno Local se integra por el Alcalde y un número de Concejales:', 'El art. 23.1 LBRL limita los Concejales de la Junta de Gobierno Local a un tercio del número legal, nombrados y separados libremente por el Alcalde, que da cuenta al Pleno.', 'age_aux_b1_09_organizacion_territorial', (select id from public.topics where slug = 'age-aux-b1-09-organizacion-territorial'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1985-5392'), 'Art. 23.1 LBRL', '1. La Junta de Gobierno Local se integra por el Alcalde y un número de Concejales no superior al tercio del número legal de los mismos, nombrados y separados libremente por aquél, dando cuenta al Pleno.', null, '3b408ba3b36821aee2715e76b818e5953263fbf1e30a269e617567e0f5a96f50', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '3b408ba3b36821aee2715e76b818e5953263fbf1e30a269e617567e0f5a96f50')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'No superior a la mitad del número legal de los mismos, elegidos por el Pleno.', false), ('B', 'No superior al tercio del número legal de los mismos, elegidos por el Pleno a propuesta del Alcalde.', false), ('C', 'Igual al de Tenientes de Alcalde, designados por los grupos políticos.', false), ('D', 'No superior al tercio del número legal de los mismos, nombrados y separados libremente por el Alcalde.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 36.1.b) de la Ley 7/1985, la Diputación garantizará la prestación de los servicios de secretaría e intervención en los municipios de menos de:', 'Entre las competencias propias de la Diputación, el art. 36.1.b) LBRL incluye la asistencia y cooperación a los municipios y, en todo caso, garantizar la secretaría e intervención en los de menos de 1.000 habitantes.', 'age_aux_b1_09_organizacion_territorial', (select id from public.topics where slug = 'age-aux-b1-09-organizacion-territorial'), 3, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1985-5392'), 'Art. 36.1.b) LBRL', 'En todo caso garantizará en los municipios de menos de 1.000 habitantes la prestación de los servicios de secretaría e intervención.', null, '37d18b5e5161646999c6c0fdc6ffe8247b86257db281fc889bfbf49824fdefe8', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '37d18b5e5161646999c6c0fdc6ffe8247b86257db281fc889bfbf49824fdefe8')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', '5.000 habitantes.', false), ('B', '1.000 habitantes.', true), ('C', '2.000 habitantes.', false), ('D', '20.000 habitantes.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'De acuerdo con el artículo 41.1 de la Ley 7/1985, los Cabildos Insulares Canarios, como órganos de gobierno, administración y representación de cada isla, se rigen supletoriamente por las normas que regulan la organización y funcionamiento de:', 'El art. 41.1 LBRL remite a la disposición adicional decimocuarta y, supletoriamente, a las normas de las Diputaciones provinciales, cuyas competencias asumen los Cabildos.', 'age_aux_b1_09_organizacion_territorial', (select id from public.topics where slug = 'age-aux-b1-09-organizacion-territorial'), 3, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1985-5392'), 'Art. 41.1 LBRL', '1. Los Cabildos Insulares Canarios, como órganos de gobierno, administración y representación de cada isla, se rigen por las normas contenidas en la disposición adicional decimocuarta de esta ley y supletoriamente por las normas que regulan la organización y funcionamiento de las Diputaciones provinciales', null, '4b2915a5836b94317abc7024f9943bf974907bb6cca6dc1f95c5e14259493df9', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '4b2915a5836b94317abc7024f9943bf974907bb6cca6dc1f95c5e14259493df9')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Los municipios de gran población.', false), ('B', 'Las mancomunidades de municipios.', false), ('C', 'Las Diputaciones provinciales.', true), ('D', 'Las áreas metropolitanas.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
-- Lote age-aux-b1-11-procedimiento-ljca-v1 (7 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Ley 29/1998, de 13 de julio, reguladora de la Jurisdicción Contencioso-administrativa (texto consolidado, BOE)', 'https://www.boe.es/buscar/act.php?id=BOE-A-1998-16718', 'boe'::public.source_kind, 'Agencia Estatal Boletín Oficial del Estado', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('age-aux-b1-11-procedimiento', 'I.11 Procedimiento administrativo común, recursos y contencioso-administrativo') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug = 'auxiliar-administrativo-estado' and t.slug = 'age-aux-b1-11-procedimiento' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 25 de la Ley 29/1998, el recurso contencioso-administrativo es admisible en relación con:', 'El art. 25.1 LJCA admite el recurso contra disposiciones generales y actos expresos y presuntos que pongan fin a la vía administrativa, sean definitivos o de trámite cualificados; el 25.2 añade la inactividad y la vía de hecho.', 'age_aux_b1_11_procedimiento', (select id from public.topics where slug = 'age-aux-b1-11-procedimiento'), 1, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1998-16718'), 'Art. 25.1 LJCA', '1. El recurso contencioso-administrativo es admisible en relación con las disposiciones de carácter general y con los actos expresos y presuntos de la Administración pública que pongan fin a la vía administrativa', null, '209bd7f7513eeee7ac7737de6a9ce3cadc41e99bf93065dce513c6b289663b4c', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '209bd7f7513eeee7ac7737de6a9ce3cadc41e99bf93065dce513c6b289663b4c')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Únicamente los actos expresos que pongan fin a la vía administrativa.', false), ('B', 'Cualquier acto de trámite, aunque no ponga fin a la vía administrativa.', false), ('C', 'Las leyes aprobadas por las Cortes Generales y las disposiciones de carácter general.', false), ('D', 'Las disposiciones de carácter general y los actos expresos y presuntos de la Administración pública que pongan fin a la vía administrativa.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'De acuerdo con la Ley 29/1998, el plazo para interponer el recurso contencioso-administrativo contra un acto que ponga fin a la vía administrativa es de:', 'El art. 46.1 LJCA fija dos meses desde el día siguiente a la notificación o publicación del acto expreso, y seis meses en caso de acto presunto.', 'age_aux_b1_11_procedimiento', (select id from public.topics where slug = 'age-aux-b1-11-procedimiento'), 1, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1998-16718'), 'Art. 46.1 LJCA', '1. El plazo para interponer el recurso contencioso-administrativo será de dos meses contados desde el día siguiente al de la publicación de la disposición impugnada o al de la notificación o publicación del acto que ponga fin a la vía administrativa, si fuera expreso. Si no lo fuera, el plazo será de seis meses', null, '09f4134c096f7282309e29f1e8884921983f97d6b1a8a8196ce54572e2962702', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '09f4134c096f7282309e29f1e8884921983f97d6b1a8a8196ce54572e2962702')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Un mes si el acto es expreso y tres meses si no lo es.', false), ('B', 'Dos meses si el acto es expreso y seis meses si no lo es.', true), ('C', 'Dos meses tanto si el acto es expreso como si no lo es.', false), ('D', 'Seis meses si el acto es expreso y dos meses si no lo es.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 19 de la Ley 29/1998, la acción popular ante el orden jurisdiccional contencioso-administrativo puede ejercerla:', 'El art. 19.1.h) LJCA reconoce la acción popular a cualquier ciudadano solo en los casos expresamente previstos por las leyes.', 'age_aux_b1_11_procedimiento', (select id from public.topics where slug = 'age-aux-b1-11-procedimiento'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1998-16718'), 'Art. 19.1 LJCA', 'h) Cualquier ciudadano, en ejercicio de la acción popular, en los casos expresamente previstos por las Leyes.', null, '084a8ec09e2e5a25331c036cfc2dea554231854f30ae7f6faddf181fcd114d3c', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '084a8ec09e2e5a25331c036cfc2dea554231854f30ae7f6faddf181fcd114d3c')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Cualquier ciudadano, en todo caso y frente a cualquier actuación administrativa.', false), ('B', 'Únicamente el Ministerio Fiscal.', false), ('C', 'Solo las personas jurídicas que ostenten un interés legítimo colectivo.', false), ('D', 'Cualquier ciudadano, en los casos expresamente previstos por las leyes.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'De acuerdo con el artículo 20 de la Ley 29/1998, no pueden interponer recurso contencioso-administrativo contra la actividad de una Administración pública:', 'El art. 20 LJCA excluye a los órganos de la propia Administración y miembros de sus órganos colegiados (salvo ley), a los particulares que obren por delegación o como agentes de ella y a las entidades de Derecho público dependientes respecto de su Administración matriz.', 'age_aux_b1_11_procedimiento', (select id from public.topics where slug = 'age-aux-b1-11-procedimiento'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1998-16718'), 'Art. 20 LJCA', 'No pueden interponer recurso contencioso-administrativo contra la actividad de una Administración pública: a) Los órganos de la misma y los miembros de sus órganos colegiados, salvo que una Ley lo autorice expresamente.', null, 'f1e8b0bb53639bca40f13099ca39d67c3ae8e9d200bb4c95a246ea356489df17', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'f1e8b0bb53639bca40f13099ca39d67c3ae8e9d200bb4c95a246ea356489df17')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Las Comunidades Autónomas, respecto de los actos de la Administración del Estado que afecten al ámbito de su autonomía.', false), ('B', 'Las personas jurídicas que ostenten un derecho o interés legítimo.', false), ('C', 'Los órganos de la misma y los miembros de sus órganos colegiados, salvo que una ley lo autorice expresamente.', true), ('D', 'Los sindicatos que resulten afectados en la defensa de intereses legítimos colectivos.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 23 de la Ley 29/1998, en sus actuaciones ante órganos jurisdiccionales colegiados, las partes:', 'Ante órganos colegiados, Procurador y Abogado son obligatorios (art. 23.2); ante órganos unipersonales el Procurador es potestativo y el Abogado obligatorio (art. 23.1). Los funcionarios pueden comparecer por sí mismos en ciertas cuestiones de personal (art. 23.3).', 'age_aux_b1_11_procedimiento', (select id from public.topics where slug = 'age-aux-b1-11-procedimiento'), 3, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1998-16718'), 'Art. 23 LJCA', '2. En sus actuaciones ante órganos colegiados, las partes deberán conferir su representación a un Procurador y ser asistidas por Abogado.', null, '3d1bbd5c3a859b9f10814751f2e2d9a026acf0214b902c777f9ccd94b57e695d', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '3d1bbd5c3a859b9f10814751f2e2d9a026acf0214b902c777f9ccd94b57e695d')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Deberán conferir su representación a un Procurador y ser asistidas por Abogado.', true), ('B', 'Podrán conferir su representación a un Procurador y serán asistidas, en todo caso, por Abogado.', false), ('C', 'Podrán comparecer por sí mismas, sin Procurador ni Abogado.', false), ('D', 'Deberán conferir su representación a un Procurador, siendo potestativa la asistencia de Abogado.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según la Ley 29/1998, no es admisible el recurso contencioso-administrativo respecto de:', 'El art. 28 LJCA declara inadmisible el recurso contra actos reproductorios o confirmatorios de actos consentidos; los actos presuntos, los actos de aplicación de disposiciones generales y la vía de hecho sí son impugnables (arts. 25 y 26).', 'age_aux_b1_11_procedimiento', (select id from public.topics where slug = 'age-aux-b1-11-procedimiento'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1998-16718'), 'Art. 28 LJCA', 'No es admisible el recurso contencioso-administrativo respecto de los actos que sean reproducción de otros anteriores definitivos y firmes y los confirmatorios de actos consentidos por no haber sido recurridos en tiempo y forma.', null, '33cdcbc0cfd42953c739b1ff16d4806322473335a41dc5475432a6886ffcfb00', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '33cdcbc0cfd42953c739b1ff16d4806322473335a41dc5475432a6886ffcfb00')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Los actos presuntos de la Administración que pongan fin a la vía administrativa.', false), ('B', 'Los actos que sean reproducción de otros anteriores definitivos y firmes y los confirmatorios de actos consentidos por no haber sido recurridos en tiempo y forma.', true), ('C', 'Los actos dictados en aplicación de una disposición general que no fue impugnada directamente.', false), ('D', 'Las actuaciones materiales de la Administración que constituyan vía de hecho.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Cuando la Administración esté obligada a realizar una prestación concreta en favor de personas determinadas, los titulares del derecho pueden reclamarla y, conforme al artículo 29 de la Ley 29/1998, podrán deducir recurso contencioso-administrativo contra la inactividad si la Administración no la cumple o no llega a un acuerdo con ellos en el plazo de:', 'El art. 29.1 LJCA fija tres meses para la inactividad prestacional; si se trata de no ejecutar actos firmes (art. 29.2) el plazo es de un mes, y en la vía de hecho el requerimiento ha de atenderse en diez días (art. 30).', 'age_aux_b1_11_procedimiento', (select id from public.topics where slug = 'age-aux-b1-11-procedimiento'), 3, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1998-16718'), 'Art. 29.1 LJCA', 'Si en el plazo de tres meses desde la fecha de la reclamación, la Administración no hubiera dado cumplimiento a lo solicitado o no hubiera llegado a un acuerdo con los interesados, éstos pueden deducir recurso contencioso-administrativo contra la inactividad de la Administración.', null, 'eb87e20152d30c28e6bc1294242ced820cb7f5351714a80b18adeb132e02b91a', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'eb87e20152d30c28e6bc1294242ced820cb7f5351714a80b18adeb132e02b91a')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Un mes desde la fecha de la reclamación.', false), ('B', 'Seis meses desde la fecha de la reclamación.', false), ('C', 'Tres meses desde la fecha de la reclamación.', true), ('D', 'Diez días desde la fecha de la reclamación.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
-- Lote age-aux-b1-11-procedimiento-lpac-v1 (21 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Ley 39/2015, de 1 de octubre, del Procedimiento Administrativo Común de las Administraciones Públicas (texto consolidado, BOE)', 'https://www.boe.es/buscar/act.php?id=BOE-A-2015-10565', 'boe'::public.source_kind, 'Agencia Estatal Boletín Oficial del Estado', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('age-aux-b1-11-procedimiento', 'I.11 Procedimiento administrativo común, recursos y contencioso-administrativo') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug = 'auxiliar-administrativo-estado' and t.slug = 'age-aux-b1-11-procedimiento' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'De acuerdo con el artículo 4 de la Ley 39/2015, se consideran interesados aquellos cuyos intereses legítimos puedan resultar afectados por la resolución y se personen en el procedimiento:', 'El art. 4.1.c) LPAC permite personarse a los titulares de intereses legítimos afectados mientras no haya recaído resolución definitiva.', 'age_aux_b1_11_procedimiento', (select id from public.topics where slug = 'age-aux-b1-11-procedimiento'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2015-10565'), 'Art. 4.1 LPAC', 'c) Aquellos cuyos intereses legítimos, individuales o colectivos, puedan resultar afectados por la resolución y se personen en el procedimiento en tanto no haya recaído resolución definitiva.', null, 'bed0f037d2971cfd52fd20b8a53a7c0f1ae7c9abe1b806c159a5840f5f2c1c61', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'bed0f037d2971cfd52fd20b8a53a7c0f1ae7c9abe1b806c159a5840f5f2c1c61')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Antes de que finalice el trámite de audiencia.', false), ('B', 'Dentro de los diez días siguientes a la iniciación del procedimiento.', false), ('C', 'En cualquier momento, incluso después de dictarse la resolución definitiva.', false), ('D', 'En tanto no haya recaído resolución definitiva.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 5 de la Ley 39/2015, ¿para cuál de las siguientes actuaciones en nombre de otra persona se presume la representación?', 'El art. 5.3 LPAC exige acreditar la representación para solicitar, presentar declaraciones responsables o comunicaciones, recurrir, desistir y renunciar; solo se presume para los actos de mero trámite.', 'age_aux_b1_11_procedimiento', (select id from public.topics where slug = 'age-aux-b1-11-procedimiento'), 3, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2015-10565'), 'Art. 5.3 LPAC', 'Para formular solicitudes, presentar declaraciones responsables o comunicaciones, interponer recursos, desistir de acciones y renunciar a derechos en nombre de otra persona, deberá acreditarse la representación. Para los actos y gestiones de mero trámite se presumirá aquella representación.', null, 'a98490800bf4cb2901e54e19f99e492aeb88fb1e89aa40fa59f92f1e2dd5ba5e', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'a98490800bf4cb2901e54e19f99e492aeb88fb1e89aa40fa59f92f1e2dd5ba5e')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'La interposición de recursos.', false), ('B', 'El desistimiento de acciones.', false), ('C', 'Los actos y gestiones de mero trámite.', true), ('D', 'La presentación de declaraciones responsables.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Conforme al artículo 21 de la Ley 39/2015, el plazo máximo para notificar la resolución expresa fijado por la norma reguladora del procedimiento no podrá exceder de:', 'El art. 21.2 LPAC fija un tope de seis meses, que solo puede superarse por norma con rango de ley o por el Derecho de la Unión Europea.', 'age_aux_b1_11_procedimiento', (select id from public.topics where slug = 'age-aux-b1-11-procedimiento'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2015-10565'), 'Art. 21.2 LPAC', 'Este plazo no podrá exceder de seis meses salvo que una norma con rango de Ley establezca uno mayor o así venga previsto en el Derecho de la Unión Europea.', null, 'aa681c6b5b6e407aaef4ee9e1917debf33860bc57b329f79abc13f3280d6c68a', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'aa681c6b5b6e407aaef4ee9e1917debf33860bc57b329f79abc13f3280d6c68a')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Seis meses, salvo que una norma con rango de ley establezca uno mayor o así venga previsto en el Derecho de la Unión Europea.', true), ('B', 'Tres meses, salvo que una norma con rango de ley establezca uno mayor.', false), ('C', 'Seis meses, sin excepción alguna.', false), ('D', 'Un año, salvo que una norma reglamentaria establezca uno mayor.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según la Ley 39/2015, cuando las normas reguladoras de los procedimientos no fijen el plazo máximo para resolver, este será de:', 'El art. 21.3 LPAC establece un plazo supletorio de tres meses.', 'age_aux_b1_11_procedimiento', (select id from public.topics where slug = 'age-aux-b1-11-procedimiento'), 1, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2015-10565'), 'Art. 21.3 LPAC', 'Cuando las normas reguladoras de los procedimientos no fijen el plazo máximo, éste será de tres meses.', null, '0ece2803b9144cf6025251198f8a4c9418f475abb8cd999209d1785f5e51e19c', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '0ece2803b9144cf6025251198f8a4c9418f475abb8cd999209d1785f5e51e19c')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Seis meses.', false), ('B', 'Tres meses.', true), ('C', 'Un mes.', false), ('D', 'Dos meses.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'De acuerdo con el artículo 24 de la Ley 39/2015, en los procedimientos iniciados a solicitud del interesado el silencio administrativo tendrá efecto desestimatorio en:', 'El art. 24.1 LPAC enumera los supuestos de silencio desestimatorio: derecho de petición, transferencia de facultades sobre el dominio o servicio público, actividades que puedan dañar el medio ambiente y responsabilidad patrimonial. La regla general es el silencio estimatorio, salvo norma con rango de ley, Derecho de la UE o Derecho internacional.', 'age_aux_b1_11_procedimiento', (select id from public.topics where slug = 'age-aux-b1-11-procedimiento'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2015-10565'), 'Art. 24.1 LPAC', 'El silencio tendrá efecto desestimatorio en los procedimientos relativos al ejercicio del derecho de petición, a que se refiere el artículo 29 de la Constitución, aquellos cuya estimación tuviera como consecuencia que se transfirieran al solicitante o a terceros facultades relativas al dominio público o al servicio público, impliquen el ejercicio de actividades que puedan dañar el medio ambiente y en los procedimientos de responsabilidad patrimonial de las Administraciones Públicas.', null, 'c8b480ca50e18e55c1104af16cb505290842bf0ca11bbf95838b23ce9ecbd166', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'c8b480ca50e18e55c1104af16cb505290842bf0ca11bbf95838b23ce9ecbd166')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Los procedimientos de responsabilidad patrimonial de las Administraciones Públicas.', true), ('B', 'Los procedimientos de acceso a actividades o a su ejercicio, en todo caso.', false), ('C', 'Los recursos de alzada interpuestos contra la desestimación por silencio de una solicitud, en todo caso.', false), ('D', 'Los procedimientos de autorización, salvo que una norma reglamentaria disponga lo contrario.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según la Ley 39/2015, en los procedimientos iniciados de oficio en los que la Administración ejercite potestades sancionadoras, el vencimiento del plazo máximo sin haberse dictado y notificado resolución expresa produce:', 'El art. 25.1.b) LPAC prevé la caducidad en los procedimientos sancionadores o de intervención susceptibles de producir efectos desfavorables; la resolución que la declare ordenará el archivo de las actuaciones.', 'age_aux_b1_11_procedimiento', (select id from public.topics where slug = 'age-aux-b1-11-procedimiento'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2015-10565'), 'Art. 25.1 LPAC', 'b) En los procedimientos en que la Administración ejercite potestades sancionadoras o, en general, de intervención, susceptibles de producir efectos desfavorables o de gravamen, se producirá la caducidad.', null, '84a02b16e6ed464e9a594557a9c1b9881edca22d1fc6e3b973ea2200e36525d3', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '84a02b16e6ed464e9a594557a9c1b9881edca22d1fc6e3b973ea2200e36525d3')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'La desestimación por silencio administrativo.', false), ('B', 'La estimación por silencio administrativo.', false), ('C', 'La prescripción automática de la infracción.', false), ('D', 'La caducidad del procedimiento.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 30 de la Ley 39/2015, cuando los plazos se señalen por días y no se exprese otro cómputo, se entiende que son hábiles, excluyéndose del cómputo:', 'Desde la Ley 39/2015 los sábados son inhábiles a efectos de cómputo administrativo, junto con domingos y festivos.', 'age_aux_b1_11_procedimiento', (select id from public.topics where slug = 'age-aux-b1-11-procedimiento'), 1, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2015-10565'), 'Art. 30.2 LPAC', 'cuando los plazos se señalen por días, se entiende que éstos son hábiles, excluyéndose del cómputo los sábados, los domingos y los declarados festivos.', null, '23291215ae8c6529f5a6246d3880c99bcb31d0fd8aeec0f527c182c544ae43f0', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '23291215ae8c6529f5a6246d3880c99bcb31d0fd8aeec0f527c182c544ae43f0')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Solo los domingos y los declarados festivos.', false), ('B', 'Solo los declarados festivos.', false), ('C', 'Los sábados, los domingos y los declarados festivos.', true), ('D', 'Los sábados, los domingos, los declarados festivos y el mes de agosto.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'En un plazo fijado en meses conforme a la Ley 39/2015, si en el mes de vencimiento no hubiera día equivalente a aquel en que comienza el cómputo:', 'El art. 30.4 LPAC dispone que el plazo concluye el mismo día del mes de vencimiento y, si no existe día equivalente, el último día del mes.', 'age_aux_b1_11_procedimiento', (select id from public.topics where slug = 'age-aux-b1-11-procedimiento'), 3, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2015-10565'), 'Art. 30.4 LPAC', 'Si en el mes de vencimiento no hubiera día equivalente a aquel en que comienza el cómputo, se entenderá que el plazo expira el último día del mes.', null, '82224968fbb87c734fe9810e0b53a0c68af3ee37ba3125d106416b72f5fc9f72', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '82224968fbb87c734fe9810e0b53a0c68af3ee37ba3125d106416b72f5fc9f72')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Se entenderá que el plazo expira el primer día del mes siguiente.', false), ('B', 'Se entenderá que el plazo expira el último día del mes.', true), ('C', 'El plazo se prorrogará al primer día hábil del mes siguiente.', false), ('D', 'El plazo se ampliará en tantos días como falten para completar treinta.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 31 de la Ley 39/2015, a efectos del cómputo de plazos fijados en días hábiles y del cumplimiento de plazos por los interesados, la presentación de un documento en el registro electrónico en un día inhábil:', 'El registro electrónico admite documentos los 365 días durante las 24 horas, pero lo presentado en día inhábil se entiende presentado en la primera hora del primer día hábil siguiente (art. 31.2.b LPAC).', 'age_aux_b1_11_procedimiento', (select id from public.topics where slug = 'age-aux-b1-11-procedimiento'), 3, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2015-10565'), 'Art. 31.2 LPAC', 'b) A los efectos del cómputo de plazo fijado en días hábiles, y en lo que se refiere al cumplimiento de plazos por los interesados, la presentación en un día inhábil se entenderá realizada en la primera hora del primer día hábil siguiente salvo que una norma permita expresamente la recepción en día inhábil.', null, '4fc91269a61280886ed54330c154a042db1bd4c58f4e16d41bd42e4e82b46e48', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '4fc91269a61280886ed54330c154a042db1bd4c58f4e16d41bd42e4e82b46e48')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Se entenderá realizada en la última hora del día hábil anterior.', false), ('B', 'No es posible, porque el registro electrónico solo admite presentaciones en días hábiles.', false), ('C', 'Se entenderá realizada en el propio día inhábil a todos los efectos.', false), ('D', 'Se entenderá realizada en la primera hora del primer día hábil siguiente, salvo que una norma permita expresamente la recepción en día inhábil.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según la Ley 39/2015, la Administración, salvo precepto en contrario, podrá conceder una ampliación de los plazos establecidos que no exceda:', 'El art. 32.1 LPAC permite ampliar plazos, de oficio o a petición, hasta la mitad, si las circunstancias lo aconsejan y no se perjudican derechos de tercero.', 'age_aux_b1_11_procedimiento', (select id from public.topics where slug = 'age-aux-b1-11-procedimiento'), 1, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2015-10565'), 'Art. 32.1 LPAC', 'una ampliación de los plazos establecidos, que no exceda de la mitad de los mismos, si las circunstancias lo aconsejan y con ello no se perjudican derechos de tercero.', null, '29324b5e1792a7f278d1fd2e3c64519b0cfaeb3100a55a3fec162f2ce368e3d6', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '29324b5e1792a7f278d1fd2e3c64519b0cfaeb3100a55a3fec162f2ce368e3d6')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'De la mitad de los mismos.', true), ('B', 'De un tercio de los mismos.', false), ('C', 'Del doble de los mismos.', false), ('D', 'De la cuarta parte de los mismos.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'De acuerdo con el artículo 33 de la Ley 39/2015, la aplicación de la tramitación de urgencia a un procedimiento supone que:', 'La urgencia, acordada por razones de interés público, reduce los plazos a la mitad excepto los de solicitudes y recursos; contra el acuerdo no cabe recurso (art. 33 LPAC).', 'age_aux_b1_11_procedimiento', (select id from public.topics where slug = 'age-aux-b1-11-procedimiento'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2015-10565'), 'Art. 33.1 LPAC', 'por la cual se reducirán a la mitad los plazos establecidos para el procedimiento ordinario, salvo los relativos a la presentación de solicitudes y recursos.', null, '8816d41a2c5fc3d957ea8174facfef0cd34a851454a26d390826a4af4bc63275', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '8816d41a2c5fc3d957ea8174facfef0cd34a851454a26d390826a4af4bc63275')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Se reducen a la mitad todos los plazos, incluidos los de presentación de solicitudes y recursos.', false), ('B', 'Se reducen a la mitad los plazos establecidos para el procedimiento ordinario, salvo los relativos a la presentación de solicitudes y recursos.', true), ('C', 'Se reducen a un tercio los plazos del procedimiento ordinario, salvo los de presentación de recursos.', false), ('D', 'Se suprime el trámite de audiencia y se reducen a la mitad los demás plazos.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 68 de la Ley 39/2015, si la solicitud de iniciación no reúne los requisitos exigidos, se requerirá al interesado para que la subsane en un plazo de:', 'El art. 68.1 LPAC fija diez días para subsanar con advertencia de desistimiento, previa resolución dictada conforme al art. 21.', 'age_aux_b1_11_procedimiento', (select id from public.topics where slug = 'age-aux-b1-11-procedimiento'), 1, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2015-10565'), 'Art. 68.1 LPAC', 'se requerirá al interesado para que, en un plazo de diez días, subsane la falta o acompañe los documentos preceptivos, con indicación de que, si así no lo hiciera, se le tendrá por desistido de su petición', null, 'b59fa3bb4e034b3983e3978044f5ac71a3ab99c5da44511cf5af022d55a0b0ff', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'b59fa3bb4e034b3983e3978044f5ac71a3ab99c5da44511cf5af022d55a0b0ff')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Quince días, con indicación de que, si no lo hiciera, se declarará la caducidad del procedimiento.', false), ('B', 'Diez días, con indicación de que, si no lo hiciera, se entenderá desestimada su solicitud por silencio administrativo.', false), ('C', 'Diez días, con indicación de que, si no lo hiciera, se le tendrá por desistido de su petición.', true), ('D', 'Cinco días, con indicación de que, si no lo hiciera, se archivará sin más trámite y sin resolución.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'En el trámite de audiencia regulado en el artículo 82 de la Ley 39/2015, los interesados podrán alegar y presentar los documentos y justificaciones que estimen pertinentes en un plazo:', 'La audiencia se abre una vez instruido el procedimiento e inmediatamente antes de redactar la propuesta de resolución, con un plazo de 10 a 15 días (art. 82 LPAC).', 'age_aux_b1_11_procedimiento', (select id from public.topics where slug = 'age-aux-b1-11-procedimiento'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2015-10565'), 'Art. 82.2 LPAC', '2. Los interesados, en un plazo no inferior a diez días ni superior a quince, podrán alegar y presentar los documentos y justificaciones que estimen pertinentes.', null, '5f8e666ce98c954f9e7c4bc3a1c16de38d6cd26ac6b48ceacda00e9ba8355c06', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '5f8e666ce98c954f9e7c4bc3a1c16de38d6cd26ac6b48ceacda00e9ba8355c06')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'No inferior a cinco días ni superior a diez.', false), ('B', 'No inferior a quince días ni superior a veinte.', false), ('C', 'No inferior a veinte días.', false), ('D', 'No inferior a diez días ni superior a quince.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según la Ley 39/2015, en los procedimientos iniciados a solicitud del interesado que se paralicen por causa imputable al mismo, la Administración le advertirá de que se producirá la caducidad transcurridos:', 'El art. 95.1 LPAC prevé la advertencia de caducidad a los tres meses; consumido ese plazo sin reanudar la tramitación, se acuerda el archivo.', 'age_aux_b1_11_procedimiento', (select id from public.topics where slug = 'age-aux-b1-11-procedimiento'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2015-10565'), 'Art. 95.1 LPAC', 'la Administración le advertirá que, transcurridos tres meses, se producirá la caducidad del procedimiento.', null, 'be3f56dcce9895c382dba77f5aac9ff3a740800eff93546119e19a8697fff610', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'be3f56dcce9895c382dba77f5aac9ff3a740800eff93546119e19a8697fff610')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Seis meses.', false), ('B', 'Un mes.', false), ('C', 'Tres meses.', true), ('D', 'Diez días.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 106 de la Ley 39/2015, las Administraciones Públicas declararán de oficio la nulidad de los actos administrativos que hayan puesto fin a la vía administrativa o que no hayan sido recurridos en plazo, en los supuestos del artículo 47.1:', 'La revisión de oficio de actos nulos no está sujeta a plazo y exige dictamen favorable del Consejo de Estado u órgano consultivo autonómico equivalente.', 'age_aux_b1_11_procedimiento', (select id from public.topics where slug = 'age-aux-b1-11-procedimiento'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2015-10565'), 'Art. 106.1 LPAC', '1. Las Administraciones Públicas, en cualquier momento, por iniciativa propia o a solicitud de interesado, y previo dictamen favorable del Consejo de Estado u órgano consultivo equivalente de la Comunidad Autónoma, si lo hubiere, declararán de oficio la nulidad de los actos administrativos', null, '2c44c974c48ed557557819ce644a4b9761444e63d74f9d83366909e46336a66e', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '2c44c974c48ed557557819ce644a4b9761444e63d74f9d83366909e46336a66e')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Dentro de los cuatro años siguientes a la fecha en que se dictó el acto, previo dictamen del Consejo de Estado.', false), ('B', 'En cualquier momento, previo dictamen favorable del Consejo de Estado u órgano consultivo equivalente de la Comunidad Autónoma, si lo hubiere.', true), ('C', 'En cualquier momento, sin necesidad de dictamen previo de ningún órgano consultivo.', false), ('D', 'Dentro del plazo de un año, previa declaración de lesividad.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'De acuerdo con la Ley 39/2015, la declaración de lesividad de un acto favorable anulable no podrá adoptarse una vez transcurridos, desde que se dictó el acto:', 'El art. 107.2 LPAC limita la declaración de lesividad a cuatro años y exige audiencia previa de los interesados; después la Administración debe impugnar el acto ante la jurisdicción contencioso-administrativa.', 'age_aux_b1_11_procedimiento', (select id from public.topics where slug = 'age-aux-b1-11-procedimiento'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2015-10565'), 'Art. 107.2 LPAC', 'La declaración de lesividad no podrá adoptarse una vez transcurridos cuatro años desde que se dictó el acto administrativo', null, 'c6d6f0a5b5c2b8c6d53355cbb03f0cba8c1d6b212536e7ccaf3e2b57de5cf9df', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'c6d6f0a5b5c2b8c6d53355cbb03f0cba8c1d6b212536e7ccaf3e2b57de5cf9df')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Cuatro años.', true), ('B', 'Seis meses.', false), ('C', 'Un año.', false), ('D', 'Dos años.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según la Ley 39/2015, si el acto es expreso, el plazo para interponer el recurso de alzada y el plazo máximo para dictar y notificar su resolución son, respectivamente:', 'Alzada: un mes para interponer (acto expreso) y tres meses para resolver; transcurrido este, se puede entender desestimado salvo el supuesto del art. 24.1, tercer párrafo.', 'age_aux_b1_11_procedimiento', (select id from public.topics where slug = 'age-aux-b1-11-procedimiento'), 1, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2015-10565'), 'Art. 122 LPAC', '1. El plazo para la interposición del recurso de alzada será de un mes, si el acto fuera expreso. […] 2. El plazo máximo para dictar y notificar la resolución será de tres meses.', null, '9fe96396d444b8631861dc561f9a4c39019d35375e2eae2be14d7ed4c6f02e7d', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '9fe96396d444b8631861dc561f9a4c39019d35375e2eae2be14d7ed4c6f02e7d')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Un mes y tres meses.', true), ('B', 'Un mes y un mes.', false), ('C', 'Dos meses y tres meses.', false), ('D', 'Tres meses y un mes.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Señale la respuesta correcta sobre el recurso potestativo de reposición según la Ley 39/2015:', 'La reposición es potestativa, cabe contra actos que ponen fin a la vía administrativa, se interpone ante el mismo órgano autor del acto y se resuelve en un mes (arts. 123 y 124 LPAC).', 'age_aux_b1_11_procedimiento', (select id from public.topics where slug = 'age-aux-b1-11-procedimiento'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2015-10565'), 'Art. 123.1 y 124.2 LPAC', '1. Los actos administrativos que pongan fin a la vía administrativa podrán ser recurridos potestativamente en reposición ante el mismo órgano que los hubiera dictado […] 2. El plazo máximo para dictar y notificar la resolución del recurso será de un mes.', null, 'de9a38bb99984421811293affeebdbf0fde980481bcd635e424708ac4f62986c', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'de9a38bb99984421811293affeebdbf0fde980481bcd635e424708ac4f62986c')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Se interpone ante el órgano superior jerárquico del que dictó el acto, y se resuelve en tres meses.', false), ('B', 'Se interpone ante el mismo órgano que dictó el acto, y se resuelve en tres meses.', false), ('C', 'Se interpone ante el mismo órgano que dictó el acto, y el plazo máximo para dictar y notificar su resolución es de un mes.', true), ('D', 'Es obligatorio antes de acudir a la vía contencioso-administrativa, y se resuelve en un mes.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Cuando el recurso extraordinario de revisión se funde en que al dictar el acto se incurrió en error de hecho que resulte de los propios documentos incorporados al expediente, se interpondrá dentro del plazo de:', 'Para la causa a) del art. 125.1 (error de hecho) el plazo es de cuatro años desde la notificación; en las demás causas es de tres meses desde el conocimiento de los documentos o la firmeza de la sentencia.', 'age_aux_b1_11_procedimiento', (select id from public.topics where slug = 'age-aux-b1-11-procedimiento'), 3, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2015-10565'), 'Art. 125.2 LPAC', 'El recurso extraordinario de revisión se interpondrá, cuando se trate de la causa a) del apartado anterior, dentro del plazo de cuatro años siguientes a la fecha de la notificación de la resolución impugnada.', null, '9f85dc1cd977a28aba2f7bf6d5e271744c9f5bb14e5e9ee2c266fef78b3ee663', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '9f85dc1cd977a28aba2f7bf6d5e271744c9f5bb14e5e9ee2c266fef78b3ee663')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Tres meses desde la notificación de la resolución impugnada.', false), ('B', 'Cuatro años siguientes a la fecha de la notificación de la resolución impugnada.', true), ('C', 'Cuatro años desde que la sentencia judicial quedó firme.', false), ('D', 'Un año desde que el interesado tuvo conocimiento del error.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 114 de la Ley 39/2015, en el ámbito estatal ponen fin a la vía administrativa:', 'El art. 114.2 LPAC incluye, entre otros, los actos de los miembros y órganos del Gobierno, de Ministros y Secretarios de Estado, y de los órganos directivos con nivel de Director general o superior solo en materia de personal.', 'age_aux_b1_11_procedimiento', (select id from public.topics where slug = 'age-aux-b1-11-procedimiento'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2015-10565'), 'Art. 114.2 LPAC', 'b) Los emanados de los Ministros y los Secretarios de Estado en el ejercicio de las competencias que tienen atribuidas los órganos de los que son titulares.', null, '766047ba064da407857a034504865aa61039c5f4636417bf34cb749a5c195dc0', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '766047ba064da407857a034504865aa61039c5f4636417bf34cb749a5c195dc0')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Los actos de los Subdirectores generales, en cualquier materia.', false), ('B', 'Los actos de los Directores generales, en cualquier materia.', false), ('C', 'Los actos de los Jefes de Servicio en materia de personal.', false), ('D', 'Los actos emanados de los Ministros y los Secretarios de Estado en el ejercicio de las competencias que tienen atribuidas los órganos de los que son titulares.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'De acuerdo con el artículo 117 de la Ley 39/2015, cuando el recurrente solicite la suspensión de la ejecución del acto impugnado:', 'La regla general es que el recurso no suspende la ejecución (art. 117.1), pero la solicitud de suspensión no resuelta en un mes produce la suspensión (art. 117.3).', 'age_aux_b1_11_procedimiento', (select id from public.topics where slug = 'age-aux-b1-11-procedimiento'), 3, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2015-10565'), 'Art. 117.3 LPAC', '3. La ejecución del acto impugnado se entenderá suspendida si transcurrido un mes desde que la solicitud de suspensión haya tenido entrada en el registro electrónico de la Administración u Organismo competente para decidir sobre la misma, el órgano a quien competa resolver el recurso no ha dictado y notificado resolución expresa al respecto.', null, '35de2985e42e4a894986f6fd07caf49939eb93c44448ccdfc6daecb5f479dbd8', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '35de2985e42e4a894986f6fd07caf49939eb93c44448ccdfc6daecb5f479dbd8')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'La ejecución se entenderá suspendida si, transcurridos tres meses desde la solicitud, no se ha dictado resolución expresa al respecto.', false), ('B', 'La solicitud se entenderá denegada si no se resuelve expresamente en el plazo de un mes.', false), ('C', 'La ejecución se entenderá suspendida si, transcurrido un mes desde la entrada de la solicitud en el registro electrónico del órgano competente, no se ha dictado y notificado resolución expresa al respecto.', true), ('D', 'La ejecución queda suspendida desde la mera interposición del recurso, en todo caso.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
-- Lote age-aux-b1-11-procedimiento-lrjsp-v1 (2 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Ley 40/2015, de 1 de octubre, de Régimen Jurídico del Sector Público (texto consolidado, BOE)', 'https://www.boe.es/buscar/act.php?id=BOE-A-2015-10566', 'boe'::public.source_kind, 'Agencia Estatal Boletín Oficial del Estado', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('age-aux-b1-11-procedimiento', 'I.11 Procedimiento administrativo común, recursos y contencioso-administrativo') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug = 'auxiliar-administrativo-estado' and t.slug = 'age-aux-b1-11-procedimiento' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 3 de la Ley 40/2015, las Administraciones Públicas sirven con objetividad los intereses generales y actúan de acuerdo con los principios de:', 'El art. 3.1 LRJSP reproduce los principios del art. 103.1 CE, con sometimiento pleno a la Constitución, a la Ley y al Derecho.', 'age_aux_b1_11_procedimiento', (select id from public.topics where slug = 'age-aux-b1-11-procedimiento'), 1, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2015-10566'), 'Art. 3.1 LRJSP', '1. Las Administraciones Públicas sirven con objetividad los intereses generales y actúan de acuerdo con los principios de eficacia, jerarquía, descentralización, desconcentración y coordinación, con sometimiento pleno a la Constitución, a la Ley y al Derecho.', null, '5bd1f4a7d52947094d4cd198a0c49d2bd68050c42baf6e1a2ce6ba9023f8a617', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '5bd1f4a7d52947094d4cd198a0c49d2bd68050c42baf6e1a2ce6ba9023f8a617')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Eficacia, legalidad, centralización, desconcentración y cooperación.', false), ('B', 'Eficacia, jerarquía, descentralización, desconcentración y coordinación.', true), ('C', 'Eficiencia, jerarquía, autonomía, delegación y coordinación.', false), ('D', 'Eficacia, jerarquía, centralización, delegación y colaboración.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según la Ley 40/2015, es motivo de abstención tener con cualquiera de los interesados parentesco de:', 'El art. 23.2.b) LRJSP fija el cuarto grado de consanguinidad y el segundo de afinidad, además del vínculo matrimonial o situación de hecho asimilable.', 'age_aux_b1_11_procedimiento', (select id from public.topics where slug = 'age-aux-b1-11-procedimiento'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2015-10566'), 'Art. 23.2 LRJSP', 'b) Tener un vínculo matrimonial o situación de hecho asimilable y el parentesco de consanguinidad dentro del cuarto grado o de afinidad dentro del segundo, con cualquiera de los interesados', null, 'e782c411d4983471088af2e7624635c3c000aef563248530bf3689f80fe050fb', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'e782c411d4983471088af2e7624635c3c000aef563248530bf3689f80fe050fb')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Consanguinidad dentro del cuarto grado o de afinidad dentro del segundo.', true), ('B', 'Consanguinidad dentro del segundo grado o de afinidad dentro del cuarto.', false), ('C', 'Consanguinidad o afinidad dentro del tercer grado.', false), ('D', 'Consanguinidad dentro del cuarto grado o de afinidad dentro del tercero.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
-- Lote age-aux-b1-12-proteccion-datos-lopdgdd-v1 (20 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Ley Orgánica 3/2018, de 5 de diciembre, de Protección de Datos Personales y garantía de los derechos digitales (texto consolidado, BOE)', 'https://www.boe.es/buscar/act.php?id=BOE-A-2018-16673', 'boe'::public.source_kind, 'Agencia Estatal Boletín Oficial del Estado', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('age-aux-b1-12-proteccion-datos', 'I.12 La protección de datos personales') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug = 'auxiliar-administrativo-estado' and t.slug = 'age-aux-b1-12-proteccion-datos' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según la Ley Orgánica 3/2018, el derecho fundamental de las personas físicas a la protección de datos personales está amparado por el artículo de la Constitución:', 'El art. 1.a) LOPDGDD recuerda que este derecho fundamental está amparado por el art. 18.4 CE y se ejerce conforme al Reglamento (UE) 2016/679 y a la propia ley orgánica.', 'age_aux_b1_12_proteccion_datos', (select id from public.topics where slug = 'age-aux-b1-12-proteccion-datos'), 1, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2018-16673'), 'Art. 1 LOPDGDD', 'El derecho fundamental de las personas físicas a la protección de datos personales, amparado por el artículo 18.4 de la Constitución, se ejercerá con arreglo a lo establecido en el Reglamento (UE) 2016/679 y en esta ley orgánica.', null, '3d95f7c59583851a1d20e61560edde76287f347e6c78d5cb05bae587c9788695', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '3d95f7c59583851a1d20e61560edde76287f347e6c78d5cb05bae587c9788695')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', '18.1.', false), ('B', '20.1.d).', false), ('C', '18.4.', true), ('D', '105.b).', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'De acuerdo con el artículo 2 de la Ley Orgánica 3/2018, esta ley orgánica no será de aplicación:', 'El art. 2.2 excluye, entre otros, los tratamientos sometidos a la normativa de materias clasificadas; el tratamiento no automatizado de datos en ficheros está incluido (art. 2.1) y el de los órganos judiciales se rige por el RGPD y esta ley (art. 2.4).', 'age_aux_b1_12_proteccion_datos', (select id from public.topics where slug = 'age-aux-b1-12-proteccion-datos'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2018-16673'), 'Art. 2.2 LOPDGDD', '2. Esta ley orgánica no será de aplicación: […] c) A los tratamientos sometidos a la normativa sobre protección de materias clasificadas.', null, '906493ff81cf34fcd04457eb5cad205553122dc783434d973f0c8f28cd3b715c', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '906493ff81cf34fcd04457eb5cad205553122dc783434d973f0c8f28cd3b715c')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Al tratamiento no automatizado de datos personales contenidos en un fichero.', false), ('B', 'Al tratamiento de datos realizado por los órganos judiciales en la tramitación de los procesos de su competencia.', false), ('C', 'A los tratamientos de datos de las Administraciones Públicas.', false), ('D', 'A los tratamientos sometidos a la normativa sobre protección de materias clasificadas.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según la Ley Orgánica 3/2018, si la persona fallecida hubiese prohibido expresamente que sus familiares accedan a sus datos personales, esa prohibición:', 'El art. 3.1 LOPDGDD permite al fallecido prohibir el acceso, pero esa prohibición no alcanza a los datos patrimoniales respecto de los herederos.', 'age_aux_b1_12_proteccion_datos', (select id from public.topics where slug = 'age-aux-b1-12-proteccion-datos'), 3, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2018-16673'), 'Art. 3.1 LOPDGDD', 'Dicha prohibición no afectará al derecho de los herederos a acceder a los datos de carácter patrimonial del causante.', null, 'a44cc097c31616bf718775847af30100418b1c2dd06ab34660c7ccc1b6d26f1f', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'a44cc097c31616bf718775847af30100418b1c2dd06ab34660c7ccc1b6d26f1f')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Impedirá en todo caso cualquier acceso de los herederos a los datos del causante.', false), ('B', 'No afectará al derecho de los herederos a acceder a los datos de carácter patrimonial del causante.', true), ('C', 'Solo será válida si se inscribe en el registro de la Agencia Española de Protección de Datos.', false), ('D', 'Podrá ser dejada sin efecto por el responsable del tratamiento a petición de cualquier heredero.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 4 de la Ley Orgánica 3/2018, siempre que haya adoptado todas las medidas razonables para que se supriman o rectifiquen sin dilación, no será imputable al responsable la inexactitud de los datos personales cuando estos:', 'El art. 4.2 LOPDGDD enumera los casos de inexactitud no imputable: datos obtenidos directamente del afectado, de un mediador o intermediario en los términos previstos, recibidos por portabilidad u obtenidos de un registro público.', 'age_aux_b1_12_proteccion_datos', (select id from public.topics where slug = 'age-aux-b1-12-proteccion-datos'), 3, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2018-16673'), 'Art. 4.2 LOPDGDD', 'a) Hubiesen sido obtenidos por el responsable directamente del afectado.', null, '5a380dce9996fd2b6a03363c017281e2f2863092ae202b5dc66596667414f9fa', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '5a380dce9996fd2b6a03363c017281e2f2863092ae202b5dc66596667414f9fa')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Hubiesen sido obtenidos por el responsable directamente del afectado.', true), ('B', 'Hubiesen sido elaborados por el propio responsable mediante deducciones o perfiles.', false), ('C', 'Hubiesen sido obtenidos de cualquier fuente, aunque el responsable no haya adoptado medida alguna.', false), ('D', 'Hubiesen sido facilitados por un encargado del tratamiento sin instrucciones del responsable.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según la Ley Orgánica 3/2018, el deber de confidencialidad de quienes intervienen en cualquier fase del tratamiento de datos:', 'El art. 5 LOPDGDD dispone que el deber de confidencialidad es complementario del secreto profesional y persiste tras finalizar la relación.', 'age_aux_b1_12_proteccion_datos', (select id from public.topics where slug = 'age-aux-b1-12-proteccion-datos'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2018-16673'), 'Art. 5 LOPDGDD', '3. Las obligaciones establecidas en los apartados anteriores se mantendrán aun cuando hubiese finalizado la relación del obligado con el responsable o encargado del tratamiento.', null, 'fb00dc66271da089f79b5ffc4ecd1bae35876c027e3d0259e5edf90bea588c27', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'fb00dc66271da089f79b5ffc4ecd1bae35876c027e3d0259e5edf90bea588c27')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Se mantiene aun cuando hubiese finalizado la relación del obligado con el responsable o encargado del tratamiento.', true), ('B', 'Se extingue al finalizar la relación del obligado con el responsable o encargado del tratamiento.', false), ('C', 'Se mantiene durante los dos años siguientes a la finalización de la relación.', false), ('D', 'Sustituye a los deberes de secreto profesional previstos en su normativa aplicable.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'De acuerdo con el artículo 6 de la Ley Orgánica 3/2018, se entiende por consentimiento del afectado toda manifestación de voluntad:', 'El consentimiento debe ser libre, específico, informado e inequívoco, mediante una declaración o una clara acción afirmativa.', 'age_aux_b1_12_proteccion_datos', (select id from public.topics where slug = 'age-aux-b1-12-proteccion-datos'), 1, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2018-16673'), 'Art. 6.1 LOPDGDD', 'se entiende por consentimiento del afectado toda manifestación de voluntad libre, específica, informada e inequívoca por la que este acepta, ya sea mediante una declaración o una clara acción afirmativa, el tratamiento de datos personales que le conciernen.', null, '3aca9664d8fd768dbd7f41ed6aea6ea61778a00ccc830e5a9e85b6b3a90853cd', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '3aca9664d8fd768dbd7f41ed6aea6ea61778a00ccc830e5a9e85b6b3a90853cd')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Libre, expresa, escrita y revocable.', false), ('B', 'Libre, específica, informada e inequívoca.', true), ('C', 'Libre, informada, tácita y específica.', false), ('D', 'Expresa, por escrito y ante fedatario público.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según la Ley Orgánica 3/2018, el tratamiento de los datos personales de un menor de edad únicamente podrá fundarse en su consentimiento cuando sea mayor de:', 'El art. 7 LOPDGDD fija la edad en catorce años; por debajo, el consentimiento debe prestarlo el titular de la patria potestad o tutela.', 'age_aux_b1_12_proteccion_datos', (select id from public.topics where slug = 'age-aux-b1-12-proteccion-datos'), 1, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2018-16673'), 'Art. 7.1 LOPDGDD', '1. El tratamiento de los datos personales de un menor de edad únicamente podrá fundarse en su consentimiento cuando sea mayor de catorce años.', null, 'a2ccb31de550e262c401e68641e53a90cc73264e143325fd5e930d2f14788093', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'a2ccb31de550e262c401e68641e53a90cc73264e143325fd5e930d2f14788093')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Doce años.', false), ('B', 'Dieciséis años.', false), ('C', 'Trece años.', false), ('D', 'Catorce años.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según la Ley Orgánica 3/2018, el tratamiento de datos personales solo podrá considerarse fundado en el cumplimiento de una misión realizada en interés público o en el ejercicio de poderes públicos conferidos al responsable cuando:', 'El art. 8.2 LOPDGDD exige que la competencia esté atribuida por norma con rango de ley; para la obligación legal (art. 8.1) se requiere norma de Derecho de la UE o con rango de ley.', 'age_aux_b1_12_proteccion_datos', (select id from public.topics where slug = 'age-aux-b1-12-proteccion-datos'), 3, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2018-16673'), 'Art. 8.2 LOPDGDD', 'cuando derive de una competencia atribuida por una norma con rango de ley.', null, 'd5ff903a31e5880ae6a4d843d97d52a3ab87ae7ea3653e718adc780b12bbd28e', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'd5ff903a31e5880ae6a4d843d97d52a3ab87ae7ea3653e718adc780b12bbd28e')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Lo autorice expresamente la Agencia Española de Protección de Datos.', false), ('B', 'Derive de una competencia atribuida por cualquier norma reglamentaria.', false), ('C', 'Derive de una competencia atribuida por una norma con rango de ley.', true), ('D', 'El afectado haya prestado previamente su consentimiento expreso.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 9 de la Ley Orgánica 3/2018, a fin de evitar situaciones discriminatorias, el solo consentimiento del afectado no bastará para levantar la prohibición del tratamiento de datos cuya finalidad principal sea identificar:', 'El art. 9.1 se refiere a la ideología, afiliación sindical, religión, orientación sexual, creencias u origen racial o étnico.', 'age_aux_b1_12_proteccion_datos', (select id from public.topics where slug = 'age-aux-b1-12-proteccion-datos'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2018-16673'), 'Art. 9.1 LOPDGDD', 'el solo consentimiento del afectado no bastará para levantar la prohibición del tratamiento de datos cuya finalidad principal sea identificar su ideología, afiliación sindical, religión, orientación sexual, creencias u origen racial o étnico.', null, '11875ee18c8055c4959f3d7d5f7f9ff92e9cb1f39caf7b65c0118f937d8edcb8', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '11875ee18c8055c4959f3d7d5f7f9ff92e9cb1f39caf7b65c0118f937d8edcb8')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Su afiliación sindical.', true), ('B', 'Su domicilio.', false), ('C', 'Su número de teléfono.', false), ('D', 'Su titulación académica.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Cuando los datos personales se obtengan del propio afectado, la información básica que debe facilitarle el responsable conforme al artículo 11 de la Ley Orgánica 3/2018 deberá contener, al menos:', 'El art. 11.2 enumera la información básica; las categorías de datos y las fuentes solo se añaden cuando los datos no se obtienen del afectado (art. 11.3).', 'age_aux_b1_12_proteccion_datos', (select id from public.topics where slug = 'age-aux-b1-12-proteccion-datos'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2018-16673'), 'Art. 11.2 LOPDGDD', '2. La información básica a la que se refiere el apartado anterior deberá contener, al menos: a) La identidad del responsable del tratamiento y de su representante, en su caso. b) La finalidad del tratamiento. c) La posibilidad de ejercer los derechos establecidos en los artículos 15 a 22 del Reglamento (UE) 2016/679.', null, '09e1dd52baea206c8d04ce712760ccf01867f7536e9a6ca3559ae701debdbbed', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '09e1dd52baea206c8d04ce712760ccf01867f7536e9a6ca3559ae701debdbbed')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Las categorías de datos objeto de tratamiento y las fuentes de las que procedan.', false), ('B', 'La identidad de todos los encargados del tratamiento y el plazo de conservación de los datos.', false), ('C', 'La identidad del responsable del tratamiento, la finalidad del tratamiento y la posibilidad de ejercer los derechos de los artículos 15 a 22 del Reglamento (UE) 2016/679.', true), ('D', 'Únicamente una dirección electrónica en la que consultar la política de privacidad.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según la Ley Orgánica 3/2018, se podrá considerar repetitivo el ejercicio del derecho de acceso, salvo causa legítima, cuando se ejerza en más de una ocasión durante el plazo de:', 'El art. 13.3 LOPDGDD permite considerar repetitivo el acceso ejercido más de una vez en seis meses, a menos que exista causa legítima.', 'age_aux_b1_12_proteccion_datos', (select id from public.topics where slug = 'age-aux-b1-12-proteccion-datos'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2018-16673'), 'Art. 13.3 LOPDGDD', 'se podrá considerar repetitivo el ejercicio del derecho de acceso en más de una ocasión durante el plazo de seis meses, a menos que exista causa legítima para ello.', null, '84c1826406f3d5d020018daaee02019b25ad660586d61f27e8057b5a496b1048', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '84c1826406f3d5d020018daaee02019b25ad660586d61f27e8057b5a496b1048')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Tres meses.', false), ('B', 'Seis meses.', true), ('C', 'Un año.', false), ('D', 'Un mes.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Cuando la supresión de los datos derive del ejercicio del derecho de oposición previsto en el artículo 21.2 del Reglamento (UE) 2016/679, la Ley Orgánica 3/2018 permite al responsable:', 'El art. 15.2 LOPDGDD autoriza a conservar solo los datos identificativos necesarios para impedir futuros tratamientos de mercadotecnia directa.', 'age_aux_b1_12_proteccion_datos', (select id from public.topics where slug = 'age-aux-b1-12-proteccion-datos'), 3, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2018-16673'), 'Art. 15.2 LOPDGDD', 'el responsable podrá conservar los datos identificativos del afectado necesarios con el fin de impedir tratamientos futuros para fines de mercadotecnia directa.', null, '53639a45f2f58f119f4adfd905001b5d62a1e5db80050c4d825565375cd639c7', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '53639a45f2f58f119f4adfd905001b5d62a1e5db80050c4d825565375cd639c7')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Conservar todos los datos del afectado durante un año antes de suprimirlos.', false), ('B', 'Ceder los datos identificativos a otros responsables para que no le envíen publicidad.', false), ('C', 'Denegar la supresión si el afectado había prestado previamente su consentimiento.', false), ('D', 'Conservar los datos identificativos del afectado necesarios con el fin de impedir tratamientos futuros para fines de mercadotecnia directa.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 22 de la Ley Orgánica 3/2018, los datos obtenidos mediante sistemas de videovigilancia serán suprimidos, con carácter general, en el plazo máximo de:', 'Las imágenes se suprimen en un mes, salvo que deban conservarse para acreditar actos contra la integridad de personas, bienes o instalaciones; en ese caso se ponen a disposición de la autoridad en un máximo de 72 horas.', 'age_aux_b1_12_proteccion_datos', (select id from public.topics where slug = 'age-aux-b1-12-proteccion-datos'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2018-16673'), 'Art. 22.3 LOPDGDD', '3. Los datos serán suprimidos en el plazo máximo de un mes desde su captación, salvo cuando hubieran de ser conservados para acreditar la comisión de actos que atenten contra la integridad de personas, bienes o instalaciones.', null, 'ac811f72247926acc5719ab9481c32677b3b9b18f3d9d1eb0e7e9f35d4fba0dd', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'ac811f72247926acc5719ab9481c32677b3b9b18f3d9d1eb0e7e9f35d4fba0dd')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Setenta y dos horas desde su captación.', false), ('B', 'Quince días desde su captación.', false), ('C', 'Tres meses desde su captación.', false), ('D', 'Un mes desde su captación.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según la Ley Orgánica 3/2018, el responsable del tratamiento estará obligado a bloquear los datos:', 'El art. 32 LOPDGDD impone el bloqueo al rectificar o suprimir; los datos bloqueados solo pueden ponerse a disposición de jueces, Ministerio Fiscal o Administraciones competentes durante el plazo de prescripción.', 'age_aux_b1_12_proteccion_datos', (select id from public.topics where slug = 'age-aux-b1-12-proteccion-datos'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2018-16673'), 'Art. 32.1 LOPDGDD', '1. El responsable del tratamiento estará obligado a bloquear los datos cuando proceda a su rectificación o supresión.', null, 'f3d5b4b7681480692436f753df8ba4c19e836278b4b4f38e7974d3e07a844850', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'f3d5b4b7681480692436f753df8ba4c19e836278b4b4f38e7974d3e07a844850')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Cuando proceda a su rectificación o supresión.', true), ('B', 'Únicamente cuando lo ordene la Agencia Española de Protección de Datos.', false), ('C', 'Cuando el afectado ejerza el derecho de acceso.', false), ('D', 'Cuando el afectado sea menor de catorce años.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'De acuerdo con la Ley Orgánica 3/2018, los responsables y encargados del tratamiento comunicarán a la Agencia Española de Protección de Datos o, en su caso, a las autoridades autonómicas, las designaciones, nombramientos y ceses de los delegados de protección de datos en el plazo de:', 'El art. 34.3 LOPDGDD fija diez días para comunicar designaciones, nombramientos y ceses, sea obligatoria o voluntaria la designación.', 'age_aux_b1_12_proteccion_datos', (select id from public.topics where slug = 'age-aux-b1-12-proteccion-datos'), 3, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2018-16673'), 'Art. 34.3 LOPDGDD', '3. Los responsables y encargados del tratamiento comunicarán en el plazo de diez días a la Agencia Española de Protección de Datos o, en su caso, a las autoridades autonómicas de protección de datos, las designaciones, nombramientos y ceses de los delegados de protección de datos tanto en los supuestos en que se encuentren obligadas a su designación como en el caso en que sea voluntaria.', null, '484fd330c0965644c2e838db14e84a7fba70681b905580390c7fed48b2f5a739', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '484fd330c0965644c2e838db14e84a7fba70681b905580390c7fed48b2f5a739')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Diez días, solo cuando la designación sea obligatoria.', false), ('B', 'Un mes, tanto si la designación es obligatoria como si es voluntaria.', false), ('C', 'Diez días, tanto si la designación es obligatoria como si es voluntaria.', true), ('D', 'Quince días, solo cuando la designación sea voluntaria.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según la Ley Orgánica 3/2018, cuando el delegado de protección de datos sea una persona física integrada en la organización del responsable o encargado, no podrá ser removido ni sancionado por desempeñar sus funciones:', 'El art. 36.2 garantiza la independencia del delegado: solo puede ser removido o sancionado por dolo o negligencia grave.', 'age_aux_b1_12_proteccion_datos', (select id from public.topics where slug = 'age-aux-b1-12-proteccion-datos'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2018-16673'), 'Art. 36.2 LOPDGDD', 'el delegado de protección de datos no podrá ser removido ni sancionado por el responsable o el encargado por desempeñar sus funciones salvo que incurriera en dolo o negligencia grave en su ejercicio.', null, 'fd89799ebd799655bfa8877396674c90429bd15c3850a325bce2955ff6c89119', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'fd89799ebd799655bfa8877396674c90429bd15c3850a325bce2955ff6c89119')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Salvo que lo autorice la Agencia Española de Protección de Datos.', false), ('B', 'Salvo que incurriera en dolo o negligencia grave en su ejercicio.', true), ('C', 'Durante los cinco primeros años de su designación.', false), ('D', 'Salvo que incurriera en cualquier tipo de negligencia, aunque sea leve.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Si el afectado, antes de reclamar ante la autoridad de protección de datos, se dirige al delegado de protección de datos de la entidad, el delegado le comunicará la decisión adoptada en el plazo máximo de:', 'El art. 37.1 LOPDGDD fija dos meses; si es la autoridad la que remite la reclamación al delegado, este debe responder en un mes (art. 37.2).', 'age_aux_b1_12_proteccion_datos', (select id from public.topics where slug = 'age-aux-b1-12-proteccion-datos'), 3, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2018-16673'), 'Art. 37.1 LOPDGDD', 'En este caso, el delegado de protección de datos comunicará al afectado la decisión que se hubiera adoptado en el plazo máximo de dos meses a contar desde la recepción de la reclamación.', null, 'a778d51eb855b4fbc9b1a787d4a48b823fbd7f0625d73db01f6a382feddf61c2', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'a778d51eb855b4fbc9b1a787d4a48b823fbd7f0625d73db01f6a382feddf61c2')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Un mes a contar desde la recepción de la reclamación.', false), ('B', 'Dos meses a contar desde la recepción de la reclamación.', true), ('C', 'Diez días a contar desde la recepción de la reclamación.', false), ('D', 'Tres meses a contar desde la recepción de la reclamación.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según la Ley Orgánica 3/2018, la Agencia Española de Protección de Datos es:', 'La AEPD es autoridad administrativa independiente con personalidad jurídica y plena capacidad, y se relaciona con el Gobierno a través del Ministerio de Justicia.', 'age_aux_b1_12_proteccion_datos', (select id from public.topics where slug = 'age-aux-b1-12-proteccion-datos'), 1, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2018-16673'), 'Art. 44.1 LOPDGDD', 'La Agencia Española de Protección de Datos es una autoridad administrativa independiente de ámbito estatal […] Se relaciona con el Gobierno a través del Ministerio de Justicia.', null, '12779fb217774f53ac01f37bf5a8854ca457549fc383fd6c1062a26099314dfd', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '12779fb217774f53ac01f37bf5a8854ca457549fc383fd6c1062a26099314dfd')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Una autoridad administrativa independiente de ámbito estatal, que se relaciona con el Gobierno a través del Ministerio de Justicia.', true), ('B', 'Un organismo autónomo adscrito al Ministerio del Interior.', false), ('C', 'Un órgano del Consejo General del Poder Judicial.', false), ('D', 'Una entidad pública empresarial dependiente del Ministerio de Hacienda.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'El mandato de la Presidencia y del Adjunto de la Agencia Española de Protección de Datos, según la Ley Orgánica 3/2018, tiene una duración de:', 'El art. 48.5 LOPDGDD fija un mandato de cinco años, renovable una vez por igual período.', 'age_aux_b1_12_proteccion_datos', (select id from public.topics where slug = 'age-aux-b1-12-proteccion-datos'), 1, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2018-16673'), 'Art. 48.5 LOPDGDD', '5. El mandato de la Presidencia y del Adjunto de la Agencia Española de Protección de Datos tiene una duración de cinco años y puede ser renovado para otro período de igual duración.', null, '971e11ae7fb21864e1e007851bed061db0638bdc3e0a3a0759f74fa547d5e2b3', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '971e11ae7fb21864e1e007851bed061db0638bdc3e0a3a0759f74fa547d5e2b3')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Cuatro años, renovable para otro período de igual duración.', false), ('B', 'Cinco años, no renovable.', false), ('C', 'Cinco años, renovable para otro período de igual duración.', true), ('D', 'Seis años, no renovable.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según la Ley Orgánica 3/2018, las infracciones muy graves, graves y leves prescriben, respectivamente, a:', 'Los arts. 72, 73 y 74 LOPDGDD fijan la prescripción de las infracciones en tres años (muy graves), dos (graves) y uno (leves).', 'age_aux_b1_12_proteccion_datos', (select id from public.topics where slug = 'age-aux-b1-12-proteccion-datos'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2018-16673'), 'Arts. 72-74 LOPDGDD', 'se consideran muy graves y prescribirán a los tres años […] se consideran graves y prescribirán a los dos años […] Se consideran leves y prescribirán al año', null, '541ecc083f0786f993beea390e9199d83b8fc8f90155b8cc17854725a13912ca', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '541ecc083f0786f993beea390e9199d83b8fc8f90155b8cc17854725a13912ca')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Los cinco años, a los tres años y al año.', false), ('B', 'Los tres años, al año y a los seis meses.', false), ('C', 'Los cuatro años, a los dos años y a los seis meses.', false), ('D', 'Los tres años, a los dos años y al año.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
-- Lote age-aux-b1-13-funcion-publica-trebep-v1 (20 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Real Decreto Legislativo 5/2015, de 30 de octubre, texto refundido de la Ley del Estatuto Básico del Empleado Público (texto consolidado, BOE)', 'https://www.boe.es/buscar/act.php?id=BOE-A-2015-11719', 'boe'::public.source_kind, 'Agencia Estatal Boletín Oficial del Estado', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('age-aux-b1-13-funcion-publica', 'I.13 El personal funcionario: clases, selección, provisión y situaciones') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug = 'auxiliar-administrativo-estado' and t.slug = 'age-aux-b1-13-funcion-publica' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 8.2 del texto refundido de la Ley del Estatuto Básico del Empleado Público, ¿cuál de las siguientes NO figura entre las clases de empleados públicos?', 'El art. 8.2 TREBEP clasifica a los empleados públicos en funcionarios de carrera, funcionarios interinos, personal laboral (fijo, por tiempo indefinido o temporal) y personal eventual. El personal directivo se regula aparte, en el art. 13, pero no es una de las clases del art. 8.2.', 'age_aux_b1_13_funcion_publica', (select id from public.topics where slug = 'age-aux-b1-13-funcion-publica'), 1, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2015-11719'), 'Art. 8.2 TREBEP', '2. Los empleados públicos se clasifican en: a) Funcionarios de carrera. b) Funcionarios interinos. c) Personal laboral, ya sea fijo, por tiempo indefinido o temporal. d) Personal eventual.', null, '0a8ebc71a26f29b803c19083fe7dccbd0afd4c6b7256035049381c948b9c6feb', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '0a8ebc71a26f29b803c19083fe7dccbd0afd4c6b7256035049381c948b9c6feb')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Los funcionarios interinos.', false), ('B', 'El personal directivo profesional.', true), ('C', 'El personal eventual.', false), ('D', 'El personal laboral, ya sea fijo, por tiempo indefinido o temporal.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'De acuerdo con el artículo 10 del TREBEP, el nombramiento de funcionarios interinos por exceso o acumulación de tareas podrá hacerse:', 'El art. 10.1.d) TREBEP limita la interinidad por exceso o acumulación de tareas a un máximo de nueve meses dentro de un periodo de dieciocho meses. El plazo de tres años es el de las plazas vacantes (letra a).', 'age_aux_b1_13_funcion_publica', (select id from public.topics where slug = 'age-aux-b1-13-funcion-publica'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2015-11719'), 'Art. 10.1.d) TREBEP', 'd) El exceso o acumulación de tareas por plazo máximo de nueve meses, dentro de un periodo de dieciocho meses.', null, '585b9c4d448a3a6ec5dc72d8ee4dce02575d364f94f4f610b1b8045ff67a8761', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '585b9c4d448a3a6ec5dc72d8ee4dce02575d364f94f4f610b1b8045ff67a8761')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Por plazo máximo de seis meses, dentro de un periodo de doce meses.', false), ('B', 'Por plazo máximo de doce meses, dentro de un periodo de veinticuatro meses.', false), ('C', 'Por plazo máximo de tres años, en los términos previstos para las plazas vacantes.', false), ('D', 'Por plazo máximo de nueve meses, dentro de un periodo de dieciocho meses.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 10.1.c) del TREBEP, los programas de carácter temporal que justifican el nombramiento de funcionarios interinos no podrán tener una duración superior a:', 'La ejecución de programas de carácter temporal permite nombrar interinos por un máximo de tres años, ampliable hasta doce meses más por las leyes de Función Pública de desarrollo (art. 10.1.c TREBEP).', 'age_aux_b1_13_funcion_publica', (select id from public.topics where slug = 'age-aux-b1-13-funcion-publica'), 3, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2015-11719'), 'Art. 10.1.c) TREBEP', 'c) La ejecución de programas de carácter temporal, que no podrán tener una duración superior a tres años, ampliable hasta doce meses más por las leyes de Función Pública que se dicten en desarrollo de este Estatuto.', null, 'a7a2f730505af6b6cb5c531be66ba1117722143ea4dff83bbcad741138192500', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'a7a2f730505af6b6cb5c531be66ba1117722143ea4dff83bbcad741138192500')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Tres años, ampliable hasta doce meses más por las leyes de Función Pública que se dicten en desarrollo del Estatuto.', true), ('B', 'Dos años, ampliable hasta seis meses más por las leyes de Función Pública que se dicten en desarrollo del Estatuto.', false), ('C', 'Tres años, sin posibilidad de ampliación.', false), ('D', 'Cuatro años, ampliable hasta doce meses más por acuerdo del Consejo de Ministros.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 12 del TREBEP, el cese del personal eventual tendrá lugar, en todo caso:', 'El nombramiento y cese del personal eventual son libres, y el cese se produce en todo caso cuando cesa la autoridad a la que presta la función de confianza o asesoramiento (art. 12.3 TREBEP).', 'age_aux_b1_13_funcion_publica', (select id from public.topics where slug = 'age-aux-b1-13-funcion-publica'), 1, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2015-11719'), 'Art. 12.3 TREBEP', '3. El nombramiento y cese serán libres. El cese tendrá lugar, en todo caso, cuando se produzca el de la autoridad a la que se preste la función de confianza o asesoramiento.', null, '9910c735c6afe45571bdad7a560061f1b65fb8940d28be1608f84a2516aacf70', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '9910c735c6afe45571bdad7a560061f1b65fb8940d28be1608f84a2516aacf70')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Al cumplirse tres años desde su nombramiento.', false), ('B', 'Cuando finalice la legislatura de las Cortes Generales.', false), ('C', 'Cuando se produzca el de la autoridad a la que preste la función de confianza o asesoramiento.', true), ('D', 'Previa instrucción del correspondiente expediente disciplinario.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'De acuerdo con el artículo 13 del TREBEP, cuando el personal directivo reúna la condición de personal laboral, estará sometido a:', 'El art. 13.4 TREBEP establece que el personal directivo con condición de personal laboral queda sometido a la relación laboral especial de alta dirección; además, sus condiciones de empleo no son materia de negociación colectiva.', 'age_aux_b1_13_funcion_publica', (select id from public.topics where slug = 'age-aux-b1-13-funcion-publica'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2015-11719'), 'Art. 13.4 TREBEP', 'Cuando el personal directivo reúna la condición de personal laboral estará sometido a la relación laboral de carácter especial de alta dirección.', null, 'd1261068c8fa13d525f29f6ab2943136f8d05e4d77d2fae02b1f69598bfb89a5', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'd1261068c8fa13d525f29f6ab2943136f8d05e4d77d2fae02b1f69598bfb89a5')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'La relación estatutaria regulada por el Derecho Administrativo.', false), ('B', 'El régimen general del personal funcionario de carrera.', false), ('C', 'La relación laboral de carácter especial de alta dirección.', true), ('D', 'El convenio colectivo aplicable al resto del personal laboral de su Administración.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Entre los requisitos generales para participar en los procesos selectivos, el artículo 56 del TREBEP exige:', 'El art. 56.1.c) TREBEP fija la edad mínima en dieciséis años y la máxima en la de jubilación forzosa; solo por ley puede establecerse otra edad máxima distinta.', 'age_aux_b1_13_funcion_publica', (select id from public.topics where slug = 'age-aux-b1-13-funcion-publica'), 1, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2015-11719'), 'Art. 56.1.c) TREBEP', 'c) Tener cumplidos dieciséis años y no exceder, en su caso, de la edad máxima de jubilación forzosa.', null, '6d5b9c6cf932a58e3888568b7ab49099e73d45070f0aea8c8abc8d0fc441ff48', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '6d5b9c6cf932a58e3888568b7ab49099e73d45070f0aea8c8abc8d0fc441ff48')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Tener cumplidos dieciséis años y no exceder, en su caso, de la edad máxima de jubilación forzosa.', true), ('B', 'Tener cumplidos dieciocho años y no exceder de sesenta y cinco años.', false), ('C', 'Tener cumplidos dieciocho años, sin límite máximo de edad.', false), ('D', 'Tener cumplidos dieciséis años y no exceder de cincuenta y cinco años.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 59 del TREBEP, en las ofertas de empleo público se reservará para personas con discapacidad un cupo:', 'El art. 59.1 TREBEP reserva un cupo mínimo del 7 % de las vacantes para personas con discapacidad; dentro de él, al menos el 2 % de las plazas ofertadas se destina a personas con discapacidad intelectual.', 'age_aux_b1_13_funcion_publica', (select id from public.topics where slug = 'age-aux-b1-13-funcion-publica'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2015-11719'), 'Art. 59.1 TREBEP', 'En las ofertas de empleo público se reservará un cupo no inferior al siete por ciento de las vacantes para ser cubiertas entre personas con discapacidad […] La reserva del mínimo del siete por ciento se realizará de manera que, al menos, el dos por ciento de las plazas ofertadas lo sea para ser cubiertas por personas que acrediten discapacidad intelectual', null, '288c90d5a4ca60566a952a8d4f485db628226d81ba867b1eb6e783dcb35c28da', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '288c90d5a4ca60566a952a8d4f485db628226d81ba867b1eb6e783dcb35c28da')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'No inferior al cinco por ciento de las vacantes, de modo que al menos el dos por ciento de las plazas ofertadas sea para personas con discapacidad intelectual.', false), ('B', 'No inferior al siete por ciento de las vacantes, de modo que al menos el uno por ciento de las plazas ofertadas sea para personas con discapacidad intelectual.', false), ('C', 'No inferior al diez por ciento de las vacantes, de modo que al menos el tres por ciento de las plazas ofertadas sea para personas con discapacidad intelectual.', false), ('D', 'No inferior al siete por ciento de las vacantes, de modo que al menos el dos por ciento de las plazas ofertadas sea para personas con discapacidad intelectual.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'De acuerdo con el artículo 60 del TREBEP, ¿quiénes no podrán formar parte de los órganos de selección?', 'El art. 60.2 TREBEP excluye de los órganos de selección al personal de elección o de designación política, a los funcionarios interinos y al personal eventual.', 'age_aux_b1_13_funcion_publica', (select id from public.topics where slug = 'age-aux-b1-13-funcion-publica'), 1, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2015-11719'), 'Art. 60.2 TREBEP', '2. El personal de elección o de designación política, los funcionarios interinos y el personal eventual no podrán formar parte de los órganos de selección.', null, '24f87ca9170f9a9ebd476f81a18f0d20ff988d910f2e7c972480802a2bbc3fb1', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '24f87ca9170f9a9ebd476f81a18f0d20ff988d910f2e7c972480802a2bbc3fb1')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Los funcionarios de carrera en situación de servicio activo.', false), ('B', 'Los funcionarios interinos.', true), ('C', 'Los funcionarios de carrera pertenecientes a otra Administración Pública.', false), ('D', 'Los funcionarios de carrera con más de veinte años de antigüedad.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 61.6 del TREBEP, el sistema de concurso, consistente únicamente en la valoración de méritos, para el acceso a la condición de funcionario de carrera:', 'Los sistemas selectivos de funcionarios de carrera son la oposición y el concurso-oposición; el concurso solo cabe, excepcionalmente, en virtud de ley (art. 61.6 TREBEP).', 'age_aux_b1_13_funcion_publica', (select id from public.topics where slug = 'age-aux-b1-13-funcion-publica'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2015-11719'), 'Art. 61.6 TREBEP', 'Sólo en virtud de ley podrá aplicarse, con carácter excepcional, el sistema de concurso que consistirá únicamente en la valoración de méritos.', null, 'f053b8475f754d7801bd11cfdb61698b0c7a00be2620c4361fc61a381a9af4f8', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'f053b8475f754d7801bd11cfdb61698b0c7a00be2620c4361fc61a381a9af4f8')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Es, junto con la oposición, el sistema selectivo ordinario de los funcionarios de carrera.', false), ('B', 'Podrá aplicarse cuando así lo acuerde el órgano de selección.', false), ('C', 'Solo podrá aplicarse en virtud de ley y con carácter excepcional.', true), ('D', 'Solo podrá aplicarse para el acceso a los cuerpos y escalas del Grupo C.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'La condición de funcionario de carrera se adquiere por el cumplimiento sucesivo de varios requisitos. Según el artículo 62.1 del TREBEP, ¿cuál es el último de ellos?', 'El orden del art. 62.1 TREBEP es: a) superación del proceso selectivo; b) nombramiento publicado en el Diario Oficial; c) acatamiento de la Constitución, del Estatuto de Autonomía y del resto del ordenamiento; d) toma de posesión dentro del plazo establecido.', 'age_aux_b1_13_funcion_publica', (select id from public.topics where slug = 'age-aux-b1-13-funcion-publica'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2015-11719'), 'Art. 62.1 TREBEP', '1. La condición de funcionario de carrera se adquiere por el cumplimiento sucesivo de los siguientes requisitos: a) Superación del proceso selectivo. b) Nombramiento por el órgano o autoridad competente, que será publicado en el Diario Oficial correspondiente. c) Acto de acatamiento de la Constitución y, en su caso, del Estatuto de Autonomía correspondiente y del resto del Ordenamiento Jurídico. d) Toma de posesión dentro del plazo que se establezca.', null, 'cc01dd716c1d7ba2893cab07d028733ff044174c2c9df893d689f751361062eb', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'cc01dd716c1d7ba2893cab07d028733ff044174c2c9df893d689f751361062eb')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'La toma de posesión dentro del plazo que se establezca.', true), ('B', 'El acto de acatamiento de la Constitución y, en su caso, del Estatuto de Autonomía correspondiente.', false), ('C', 'El nombramiento por el órgano o autoridad competente, publicado en el Diario Oficial correspondiente.', false), ('D', 'La superación del proceso selectivo.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'De acuerdo con el artículo 70.1 del TREBEP, la Oferta de empleo público comporta la obligación de convocar los procesos selectivos para las plazas comprometidas y:', 'El art. 70.1 TREBEP obliga a convocar las plazas comprometidas y hasta un 10 % adicional, y fija un plazo improrrogable de tres años para ejecutar la oferta.', 'age_aux_b1_13_funcion_publica', (select id from public.topics where slug = 'age-aux-b1-13-funcion-publica'), 3, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2015-11719'), 'Art. 70.1 TREBEP', 'lo que comportará la obligación de convocar los correspondientes procesos selectivos para las plazas comprometidas y hasta un diez por cien adicional, fijando el plazo máximo para la convocatoria de los mismos. En todo caso, la ejecución de la oferta de empleo público o instrumento similar deberá desarrollarse dentro del plazo improrrogable de tres años.', null, '06d455fe159ad22fcb81c5de4209db65422dd17c3b886a74d569f76c0af5c695', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '06d455fe159ad22fcb81c5de4209db65422dd17c3b886a74d569f76c0af5c695')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Hasta un cinco por cien adicional, y su ejecución deberá desarrollarse dentro del plazo improrrogable de tres años.', false), ('B', 'Hasta un diez por cien adicional, y su ejecución deberá desarrollarse dentro del plazo de dos años, prorrogable por uno más.', false), ('C', 'Hasta un veinte por cien adicional, y su ejecución deberá desarrollarse dentro del plazo improrrogable de un año.', false), ('D', 'Hasta un diez por cien adicional, y su ejecución deberá desarrollarse dentro del plazo improrrogable de tres años.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 76 del TREBEP, para el acceso a los cuerpos o escalas del Subgrupo C1 se exigirá estar en posesión del:', 'El art. 76 TREBEP exige para el Subgrupo C1 el título de Bachiller o Técnico; para el C2, el de Graduado en ESO; para el Grupo B, el de Técnico Superior; y para el Grupo A, el título universitario de Grado.', 'age_aux_b1_13_funcion_publica', (select id from public.topics where slug = 'age-aux-b1-13-funcion-publica'), 1, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2015-11719'), 'Art. 76 TREBEP', 'C1: Título de Bachiller o Técnico.', null, '139358bdbb700aad798419e895b4eb3c9f7c2ca2d636155c5d89e866b2196229', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '139358bdbb700aad798419e895b4eb3c9f7c2ca2d636155c5d89e866b2196229')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Título de Graduado en Educación Secundaria Obligatoria.', false), ('B', 'Título de Bachiller o Técnico.', true), ('C', 'Título de Técnico Superior.', false), ('D', 'Título universitario de Grado.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 79 del TREBEP, ¿cuál es el procedimiento normal de provisión de puestos de trabajo del personal funcionario de carrera?', 'El art. 79.1 TREBEP califica el concurso como procedimiento normal de provisión, consistente en la valoración de méritos y capacidades por órganos colegiados de carácter técnico.', 'age_aux_b1_13_funcion_publica', (select id from public.topics where slug = 'age-aux-b1-13-funcion-publica'), 1, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2015-11719'), 'Art. 79.1 TREBEP', '1. El concurso, como procedimiento normal de provisión de puestos de trabajo, consistirá en la valoración de los méritos y capacidades y, en su caso, aptitudes de los candidatos por órganos colegiados de carácter técnico.', null, '3315c29fa62f2706f59b37878f27840a0f4a23b3bfed818f910ad941df0d6936', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '3315c29fa62f2706f59b37878f27840a0f4a23b3bfed818f910ad941df0d6936')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El concurso.', true), ('B', 'La libre designación con convocatoria pública.', false), ('C', 'La comisión de servicios.', false), ('D', 'La redistribución de efectivos.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'De acuerdo con el artículo 80 del TREBEP, los titulares de puestos de trabajo provistos por libre designación con convocatoria pública:', 'El art. 80.4 TREBEP permite el cese discrecional de quienes ocupan puestos de libre designación, con la garantía de asignarles un puesto conforme al sistema de carrera de su Administración.', 'age_aux_b1_13_funcion_publica', (select id from public.topics where slug = 'age-aux-b1-13-funcion-publica'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2015-11719'), 'Art. 80.4 TREBEP', '4. Los titulares de los puestos de trabajo provistos por el procedimiento de libre designación con convocatoria pública podrán ser cesados discrecionalmente. En caso de cese, se les deberá asignar un puesto de trabajo conforme al sistema de carrera profesional propio de cada Administración Pública y con las garantías inherentes de dicho sistema.', null, '9e56f71d7e7414faa47c8c3c64322babc61ded6a9ac6cbfa8e1546b266c2d014', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '9e56f71d7e7414faa47c8c3c64322babc61ded6a9ac6cbfa8e1546b266c2d014')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Solo podrán ser cesados tras una evaluación del desempeño negativa, con audiencia del interesado.', false), ('B', 'No podrán ser cesados hasta que transcurran dos años desde su toma de posesión.', false), ('C', 'Podrán ser cesados discrecionalmente, y en caso de cese se les deberá asignar un puesto de trabajo conforme al sistema de carrera profesional propio de cada Administración.', true), ('D', 'En caso de cese, pasarán de oficio a la situación de excedencia voluntaria por interés particular.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 84.3 del TREBEP, el funcionario cesado en un puesto de libre designación obtenido en otra Administración que, sin haber sido adscrito a otro puesto, no solicite el reingreso en su Administración de origen en el plazo máximo de un mes, será declarado de oficio en situación de:', 'Si no se acuerda la adscripción en la Administración de destino, el funcionario debe pedir el reingreso en la de origen en el plazo máximo de un mes; si no lo hace, se le declara de oficio en excedencia voluntaria por interés particular (art. 84.3 TREBEP).', 'age_aux_b1_13_funcion_publica', (select id from public.topics where slug = 'age-aux-b1-13-funcion-publica'), 3, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2015-11719'), 'Art. 84.3 TREBEP', 'De no solicitarse el reingreso al servicio activo en el plazo indicado será declarado de oficio en situación de excedencia voluntaria por interés particular', null, '2b1829181e69a2b8240460a691f339b2897e0c9c0e1c1aac617f3bd6bb912ca6', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '2b1829181e69a2b8240460a691f339b2897e0c9c0e1c1aac617f3bd6bb912ca6')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Excedencia voluntaria por agrupación familiar.', false), ('B', 'Excedencia voluntaria por interés particular.', true), ('C', 'Suspensión de funciones.', false), ('D', 'Servicio en otras Administraciones Públicas.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select '¿Cuál de las siguientes figura entre las situaciones administrativas de los funcionarios de carrera enumeradas en el artículo 85.1 del TREBEP?', 'El art. 85.1 TREBEP enumera cinco situaciones: servicio activo, servicios especiales, servicio en otras Administraciones Públicas, excedencia y suspensión de funciones. Las leyes de Función Pública pueden regular otras (art. 85.2), pero no figuran en el apartado 1.', 'age_aux_b1_13_funcion_publica', (select id from public.topics where slug = 'age-aux-b1-13-funcion-publica'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2015-11719'), 'Art. 85.1 TREBEP', '1. Los funcionarios de carrera se hallarán en alguna de las siguientes situaciones: a) Servicio activo. b) Servicios especiales. c) Servicio en otras Administraciones Públicas. d) Excedencia. e) Suspensión de funciones.', null, '28331dc007fb7c745f05eedc96667a9d1845806a59044c14930c2b6bb05e7038', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '28331dc007fb7c745f05eedc96667a9d1845806a59044c14930c2b6bb05e7038')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Expectativa de destino.', false), ('B', 'Disponibilidad.', false), ('C', 'Reserva activa.', false), ('D', 'Servicio en otras Administraciones Públicas.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 87 del TREBEP, los funcionarios de carrera autorizados para realizar una misión en organismos internacionales, gobiernos o entidades públicas extranjeras serán declarados en servicios especiales cuando la misión sea:', 'El art. 87.1.b) TREBEP declara en servicios especiales a los funcionarios autorizados para una misión por periodo determinado superior a seis meses en organismos internacionales, gobiernos o entidades públicas extranjeras o en programas de cooperación internacional.', 'age_aux_b1_13_funcion_publica', (select id from public.topics where slug = 'age-aux-b1-13-funcion-publica'), 3, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2015-11719'), 'Art. 87.1.b) TREBEP', 'b) Cuando sean autorizados para realizar una misión por periodo determinado superior a seis meses en organismos internacionales, gobiernos o entidades públicas extranjeras o en programas de cooperación internacional.', null, '3fa111a321c0c8c84cb03c4bc229792fb639349baa9c216fff6c80ae2af9f5e4', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '3fa111a321c0c8c84cb03c4bc229792fb639349baa9c216fff6c80ae2af9f5e4')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Por periodo determinado superior a tres meses.', false), ('B', 'Por periodo determinado superior a seis meses.', true), ('C', 'Por periodo determinado superior a un año.', false), ('D', 'De cualquier duración, siempre que esté retribuida por el organismo de destino.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'De acuerdo con el artículo 89.2 del TREBEP, los funcionarios de carrera podrán obtener la excedencia voluntaria por interés particular cuando hayan prestado servicios efectivos en cualquiera de las Administraciones Públicas durante un periodo mínimo de:', 'El art. 89.2 TREBEP exige cinco años de servicios efectivos inmediatamente anteriores, aunque las leyes de Función Pública pueden fijar un periodo menor.', 'age_aux_b1_13_funcion_publica', (select id from public.topics where slug = 'age-aux-b1-13-funcion-publica'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2015-11719'), 'Art. 89.2 TREBEP', '2. Los funcionarios de carrera podrán obtener la excedencia voluntaria por interés particular cuando hayan prestado servicios efectivos en cualquiera de las Administraciones Públicas durante un periodo mínimo de cinco años inmediatamente anteriores.', null, 'cc03420f373f07d5399b8b30a73f8a21c6ba07e389670596581f69a85ca83309', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'cc03420f373f07d5399b8b30a73f8a21c6ba07e389670596581f69a85ca83309')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Cinco años inmediatamente anteriores.', true), ('B', 'Tres años inmediatamente anteriores.', false), ('C', 'Un año inmediatamente anterior.', false), ('D', 'Diez años, consecutivos o no.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 89.5 del TREBEP, las funcionarias en excedencia por razón de violencia de género o de violencia sexual tendrán derecho a la reserva del puesto de trabajo:', 'El art. 89.5 TREBEP reconoce la reserva del puesto durante los seis primeros meses; si las actuaciones judiciales lo exigen, puede prorrogarse por tres meses, con un máximo de dieciocho. La reserva de dos años corresponde a la excedencia por cuidado de familiares.', 'age_aux_b1_13_funcion_publica', (select id from public.topics where slug = 'age-aux-b1-13-funcion-publica'), 3, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2015-11719'), 'Art. 89.5 TREBEP', 'Durante los seis primeros meses tendrán derecho a la reserva del puesto de trabajo que desempeñarán […] Cuando las actuaciones judiciales lo exigieran se podrá prorrogar este periodo por tres meses, con un máximo de dieciocho', null, 'f60d92c0fa4b623ffb072a4be0baf591fec24bfe80189b8eadf6171127d917ee', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'f60d92c0fa4b623ffb072a4be0baf591fec24bfe80189b8eadf6171127d917ee')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Durante los dos primeros años, y después a un puesto en la misma localidad y de igual retribución.', false), ('B', 'Durante el primer año, sin posibilidad de prórroga.', false), ('C', 'Durante los tres primeros meses, prorrogables hasta un máximo de seis.', false), ('D', 'Durante los seis primeros meses, prorrogables por periodos de tres meses hasta un máximo de dieciocho cuando las actuaciones judiciales lo exigieran.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'De acuerdo con el artículo 90 del TREBEP, la suspensión firme de funciones por sanción disciplinaria no podrá exceder de:', 'El art. 90.2 TREBEP limita la suspensión firme por sanción disciplinaria a seis años. Los seis meses son el umbral a partir del cual la suspensión determina la pérdida del puesto de trabajo (art. 90.1).', 'age_aux_b1_13_funcion_publica', (select id from public.topics where slug = 'age-aux-b1-13-funcion-publica'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2015-11719'), 'Art. 90.2 TREBEP', 'La suspensión firme por sanción disciplinaria no podrá exceder de seis años.', null, '1026f64851e9bd6578aa5601fff51d7710af8516ef05ecea2995d5f66a8b8fd1', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '1026f64851e9bd6578aa5601fff51d7710af8516ef05ecea2995d5f66a8b8fd1')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Seis meses.', false), ('B', 'Tres años.', false), ('C', 'Seis años.', true), ('D', 'Diez años.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
-- Lote age-aux-b1-14-derechos-deberes-funcionarios-trebep-v1 (20 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Real Decreto Legislativo 5/2015, de 30 de octubre, texto refundido de la Ley del Estatuto Básico del Empleado Público (texto consolidado, BOE)', 'https://www.boe.es/buscar/act.php?id=BOE-A-2015-11719', 'boe'::public.source_kind, 'Agencia Estatal Boletín Oficial del Estado', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('age-aux-b1-14-derechos-deberes-funcionarios', 'I.14 Derechos y deberes de los funcionarios, retribuciones y régimen disciplinario') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug = 'auxiliar-administrativo-estado' and t.slug = 'age-aux-b1-14-derechos-deberes-funcionarios' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el TREBEP, ¿cuál de los siguientes es un derecho individual que se ejerce de forma colectiva?', 'El art. 15 TREBEP recoge como derechos individuales ejercidos colectivamente la libertad sindical, la negociación colectiva, la huelga, el planteamiento de conflictos colectivos y la reunión. La inamovilidad, la formación continua y la libre asociación profesional son derechos individuales del art. 14.', 'age_aux_b1_14_derechos_deberes_funcionarios', (select id from public.topics where slug = 'age-aux-b1-14-derechos-deberes-funcionarios'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2015-11719'), 'Art. 15 TREBEP', 'c) Al ejercicio de la huelga, con la garantía del mantenimiento de los servicios esenciales de la comunidad.', null, '7b455bd92d59ff5b5e45339a82c856a40715dd0d61a19a9e2f1d3e74c81a842f', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '7b455bd92d59ff5b5e45339a82c856a40715dd0d61a19a9e2f1d3e74c81a842f')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El ejercicio de la huelga, con la garantía del mantenimiento de los servicios esenciales de la comunidad.', true), ('B', 'La inamovilidad en la condición de funcionario de carrera.', false), ('C', 'La formación continua y la actualización permanente de sus conocimientos y capacidades profesionales.', false), ('D', 'La libre asociación profesional.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'De acuerdo con el artículo 16 del TREBEP, la progresión de grado, categoría, escalón u otros conceptos análogos, sin necesidad de cambiar de puesto de trabajo, constituye:', 'El art. 16.3.a) TREBEP define la carrera horizontal como la progresión de grado, categoría o escalón sin cambiar de puesto. La carrera vertical es el ascenso en la estructura de puestos mediante los procedimientos de provisión.', 'age_aux_b1_14_derechos_deberes_funcionarios', (select id from public.topics where slug = 'age-aux-b1-14-derechos-deberes-funcionarios'), 1, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2015-11719'), 'Art. 16.3.a) TREBEP', 'a) Carrera horizontal, que consiste en la progresión de grado, categoría, escalón u otros conceptos análogos, sin necesidad de cambiar de puesto de trabajo', null, '2e00983bcd093fe2c4c0fe3976e2799d461c7303e22fa3b3aa4e8c169dc2961c', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '2e00983bcd093fe2c4c0fe3976e2799d461c7303e22fa3b3aa4e8c169dc2961c')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'La carrera vertical.', false), ('B', 'La carrera horizontal.', true), ('C', 'La promoción interna vertical.', false), ('D', 'La promoción interna horizontal.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Para participar en la promoción interna, el artículo 18 del TREBEP exige a los funcionarios, entre otros requisitos, una antigüedad de al menos:', 'El art. 18.2 TREBEP exige poseer los requisitos de ingreso, dos años de servicio activo en el Subgrupo (o Grupo) inferior y superar las pruebas selectivas.', 'age_aux_b1_14_derechos_deberes_funcionarios', (select id from public.topics where slug = 'age-aux-b1-14-derechos-deberes-funcionarios'), 1, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2015-11719'), 'Art. 18.2 TREBEP', '2. Los funcionarios deberán poseer los requisitos exigidos para el ingreso, tener una antigüedad de, al menos, dos años de servicio activo en el inferior Subgrupo, o Grupo de clasificación profesional, en el supuesto de que éste no tenga Subgrupo y superar las correspondientes pruebas selectivas.', null, '2b15e652dd7a6fd68dcb65f7c355047f620f617732675ecefb78ab130aded3fc', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '2b15e652dd7a6fd68dcb65f7c355047f620f617732675ecefb78ab130aded3fc')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Tres años de servicio activo en el inferior Subgrupo, o Grupo de clasificación profesional si este no tiene Subgrupo.', false), ('B', 'Cinco años de servicio activo en cualquier Subgrupo.', false), ('C', 'Un año de servicio activo en el mismo cuerpo o escala.', false), ('D', 'Dos años de servicio activo en el inferior Subgrupo, o Grupo de clasificación profesional si este no tiene Subgrupo.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 20 del TREBEP, la evaluación del desempeño es:', 'El art. 20.1 TREBEP define la evaluación del desempeño. Las demás opciones definen, respectivamente, la carrera profesional (art. 16.2), la promoción interna vertical y la carrera horizontal (art. 16.3).', 'age_aux_b1_14_derechos_deberes_funcionarios', (select id from public.topics where slug = 'age-aux-b1-14-derechos-deberes-funcionarios'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2015-11719'), 'Art. 20.1 TREBEP', 'La evaluación del desempeño es el procedimiento mediante el cual se mide y valora la conducta profesional y el rendimiento o el logro de resultados.', null, '6ac7c67ce4437cf1802754e40ae2bd11dbf1f7db83a141d0360d2d5c7c3243b9', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '6ac7c67ce4437cf1802754e40ae2bd11dbf1f7db83a141d0360d2d5c7c3243b9')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El conjunto ordenado de oportunidades de ascenso y expectativas de progreso profesional.', false), ('B', 'El ascenso desde un cuerpo o escala de un Subgrupo a otro superior.', false), ('C', 'El procedimiento mediante el cual se mide y valora la conducta profesional y el rendimiento o el logro de resultados.', true), ('D', 'La progresión de grado, categoría o escalón sin necesidad de cambiar de puesto de trabajo.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'De acuerdo con el artículo 22 del TREBEP, las pagas extraordinarias de los funcionarios serán:', 'Según el art. 22.4 TREBEP hay dos pagas extraordinarias al año; cada una incluye una mensualidad de retribuciones básicas y todas las complementarias, salvo las ligadas al rendimiento (art. 24.c) y a los servicios extraordinarios (art. 24.d).', 'age_aux_b1_14_derechos_deberes_funcionarios', (select id from public.topics where slug = 'age-aux-b1-14-derechos-deberes-funcionarios'), 3, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2015-11719'), 'Art. 22.4 TREBEP', '4. Las pagas extraordinarias serán dos al año, cada una por el importe de una mensualidad de retribuciones básicas y de la totalidad de las retribuciones complementarias, salvo aquéllas a las que se refieren los apartados c) y d) del artículo 24.', null, '74f86b728c7fa3983ca17c93bcd242f3ffa709587a595a57bf38c4de29d89d36', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '74f86b728c7fa3983ca17c93bcd242f3ffa709587a595a57bf38c4de29d89d36')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Dos al año, cada una por el importe de una mensualidad de retribuciones básicas únicamente.', false), ('B', 'Dos al año, cada una por el importe de una mensualidad de retribuciones básicas y de la totalidad de las retribuciones complementarias, salvo las de los apartados c) y d) del artículo 24.', true), ('C', 'Dos al año, cada una por el importe de una mensualidad de retribuciones básicas y de la totalidad de las retribuciones complementarias, sin excepción.', false), ('D', 'Tres al año, cada una por el importe de una mensualidad de retribuciones básicas y del complemento ligado a la carrera.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 23 del TREBEP, las retribuciones básicas de los funcionarios estarán integradas única y exclusivamente por:', 'El art. 23 TREBEP dispone que las retribuciones básicas, fijadas en la Ley de Presupuestos Generales del Estado, son únicamente el sueldo del Subgrupo o Grupo y los trienios, que se devengan por cada tres años de servicio.', 'age_aux_b1_14_derechos_deberes_funcionarios', (select id from public.topics where slug = 'age-aux-b1-14-derechos-deberes-funcionarios'), 1, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2015-11719'), 'Art. 23 TREBEP', 'Las retribuciones básicas, que se fijan en la Ley de Presupuestos Generales del Estado, estarán integradas única y exclusivamente por: a) El sueldo asignado a cada Subgrupo o Grupo de clasificación profesional, en el supuesto de que éste no tenga Subgrupo. b) Los trienios', null, 'e9da7ae41be46092b20fc41f8dd743f53d6c286e54f83d0aabcb33e2a1303049', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'e9da7ae41be46092b20fc41f8dd743f53d6c286e54f83d0aabcb33e2a1303049')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El sueldo y los trienios.', true), ('B', 'El sueldo, los trienios y el complemento de destino.', false), ('C', 'El sueldo y el complemento específico.', false), ('D', 'El sueldo, los trienios y las indemnizaciones por razón del servicio.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'De acuerdo con el artículo 25 del TREBEP, ¿qué retribuciones complementarias perciben los funcionarios interinos?', 'El art. 25.1 TREBEP reconoce a los interinos las retribuciones básicas, las pagas extraordinarias y las complementarias de las letras b), c) y d) del art. 24, más las de la categoría de entrada; no la de la letra a), ligada a la progresión en la carrera.', 'age_aux_b1_14_derechos_deberes_funcionarios', (select id from public.topics where slug = 'age-aux-b1-14-derechos-deberes-funcionarios'), 3, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2015-11719'), 'Art. 25.1 TREBEP', 'Percibirán asimismo las retribuciones complementarias a que se refieren los apartados b), c) y d) del artículo 24 y las correspondientes a la categoría de entrada en el cuerpo o escala en el que se le nombre.', null, 'f08628e2b9c448b218265ed117541202dcd6478954946aaae28f11ce5d9ac734', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'f08628e2b9c448b218265ed117541202dcd6478954946aaae28f11ce5d9ac734')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Todas las del artículo 24, incluida la correspondiente a la progresión alcanzada dentro del sistema de carrera administrativa.', false), ('B', 'Únicamente las del apartado d) del artículo 24, por servicios extraordinarios.', false), ('C', 'Las de los apartados b), c) y d) del artículo 24 y las correspondientes a la categoría de entrada en el cuerpo o escala en el que se les nombre.', true), ('D', 'Ninguna, ya que solo perciben las retribuciones básicas y las pagas extraordinarias.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 30 del TREBEP, quienes ejerciten el derecho de huelga:', 'El art. 30.2 TREBEP excluye el devengo de retribuciones durante la huelga, aclarando que la deducción no es una sanción ni afecta al régimen de prestaciones sociales.', 'age_aux_b1_14_derechos_deberes_funcionarios', (select id from public.topics where slug = 'age-aux-b1-14-derechos-deberes-funcionarios'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2015-11719'), 'Art. 30.2 TREBEP', '2. Quienes ejerciten el derecho de huelga no devengarán ni percibirán las retribuciones correspondientes al tiempo en que hayan permanecido en esa situación sin que la deducción de haberes que se efectúe tenga carácter de sanción, ni afecte al régimen respectivo de sus prestaciones sociales.', null, '48201e6cb2189e73c77eb0a33fcc4e1fb4909d87f426728e63af821e96c45d1d', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '48201e6cb2189e73c77eb0a33fcc4e1fb4909d87f426728e63af821e96c45d1d')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Sufrirán una deducción de haberes que tendrá la consideración de sanción por falta leve.', false), ('B', 'Percibirán las retribuciones básicas, pero no las complementarias, durante el tiempo en huelga.', false), ('C', 'Percibirán la totalidad de sus retribuciones si se garantiza el mantenimiento de los servicios esenciales.', false), ('D', 'No devengarán ni percibirán las retribuciones correspondientes al tiempo en huelga, sin que la deducción de haberes tenga carácter de sanción.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'De acuerdo con el artículo 39 del TREBEP, las Juntas de Personal se constituirán en unidades electorales que cuenten con un censo mínimo de:', 'El art. 39 TREBEP atribuye la representación a los Delegados de Personal en unidades de 6 a 49 funcionarios, y a las Juntas de Personal a partir de un censo mínimo de 50.', 'age_aux_b1_14_derechos_deberes_funcionarios', (select id from public.topics where slug = 'age-aux-b1-14-derechos-deberes-funcionarios'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2015-11719'), 'Art. 39.3 TREBEP', '3. Las Juntas de Personal se constituirán en unidades electorales que cuenten con un censo mínimo de 50 funcionarios.', null, '520c9158de66fa90f92d71eab215eb2fc2d551190ef0d5653f646267f2c45973', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '520c9158de66fa90f92d71eab215eb2fc2d551190ef0d5653f646267f2c45973')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', '50 funcionarios.', true), ('B', '30 funcionarios.', false), ('C', '6 funcionarios.', false), ('D', '100 funcionarios.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 42 del TREBEP, el mandato de los miembros de las Juntas de Personal y de los Delegados de Personal será de:', 'El art. 42 TREBEP fija un mandato de cuatro años con posibilidad de reelección, que se entiende prorrogado si no se promueven nuevas elecciones.', 'age_aux_b1_14_derechos_deberes_funcionarios', (select id from public.topics where slug = 'age-aux-b1-14-derechos-deberes-funcionarios'), 1, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2015-11719'), 'Art. 42 TREBEP', 'El mandato de los miembros de las Juntas de Personal y de los Delegados de Personal, en su caso, será de cuatro años, pudiendo ser reelegidos.', null, 'e67c352dce833ac001749b56da72fd17cfea26c2bce59285c17cb9e9aabf755d', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'e67c352dce833ac001749b56da72fd17cfea26c2bce59285c17cb9e9aabf755d')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Dos años, pudiendo ser reelegidos.', false), ('B', 'Cuatro años, pudiendo ser reelegidos.', true), ('C', 'Tres años, sin posibilidad de reelección.', false), ('D', 'Cinco años, pudiendo ser reelegidos una sola vez.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 46 del TREBEP, los empleados públicos están legitimados para convocar una reunión cuando lo hagan en número no inferior al:', 'Además de las organizaciones sindicales, los Delegados y las Juntas de Personal, pueden convocar una reunión los empleados públicos en número no inferior al 40 % del colectivo convocado (art. 46.1.d TREBEP).', 'age_aux_b1_14_derechos_deberes_funcionarios', (select id from public.topics where slug = 'age-aux-b1-14-derechos-deberes-funcionarios'), 3, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2015-11719'), 'Art. 46.1.d) TREBEP', 'd) Los empleados públicos de las Administraciones respectivas en número no inferior al 40 por 100 del colectivo convocado.', null, '7198192a61c78cdda7aa49d7fa562ad2faf7533360f144cc68da2328b3136ee2', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '7198192a61c78cdda7aa49d7fa562ad2faf7533360f144cc68da2328b3136ee2')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', '25 por 100 del colectivo convocado.', false), ('B', '33 por 100 del colectivo convocado.', false), ('C', '50 por 100 del colectivo convocado.', false), ('D', '40 por 100 del colectivo convocado.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'De acuerdo con el artículo 48 del TREBEP, en caso de fallecimiento del cónyuge, pareja de hecho o familiar dentro del primer grado de consanguinidad o afinidad, el permiso será de:', 'El art. 48.a) TREBEP concede 3 días hábiles (misma localidad) o 5 (distinta localidad) por fallecimiento de familiar de primer grado; para el segundo grado son 2 y 4 días hábiles.', 'age_aux_b1_14_derechos_deberes_funcionarios', (select id from public.topics where slug = 'age-aux-b1-14-derechos-deberes-funcionarios'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2015-11719'), 'Art. 48.a) TREBEP', 'Cuando se trate de fallecimiento del cónyuge, pareja de hecho o familiar dentro del primer grado de consanguinidad o afinidad, tres días hábiles cuando el suceso se produzca en la misma localidad, y cinco días hábiles, cuando sea en distinta localidad.', null, 'f78a486a75cd805bd2bf2fa0c517b326f7d0304fe95ec53de3dea559c9da1ccd', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'f78a486a75cd805bd2bf2fa0c517b326f7d0304fe95ec53de3dea559c9da1ccd')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Dos días hábiles si el suceso se produce en la misma localidad y cuatro días hábiles si es en distinta localidad.', false), ('B', 'Cinco días naturales, con independencia de la localidad.', false), ('C', 'Tres días hábiles si el suceso se produce en la misma localidad y cinco días hábiles si es en distinta localidad.', true), ('D', 'Cuatro días hábiles si el suceso se produce en la misma localidad y seis días hábiles si es en distinta localidad.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 48 del TREBEP, ¿de cuántos días de permiso por asuntos particulares disponen los funcionarios públicos?', 'El art. 48.k) TREBEP reconoce seis días al año por asuntos particulares, sin perjuicio de los días adicionales por antigüedad que prevé la disposición adicional decimotercera.', 'age_aux_b1_14_derechos_deberes_funcionarios', (select id from public.topics where slug = 'age-aux-b1-14-derechos-deberes-funcionarios'), 1, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2015-11719'), 'Art. 48.k) TREBEP', 'k) Por asuntos particulares, seis días al año.', null, '8c401d8b67c8e6c808f6f4877efc11150e07c544135694efb35a8a14fe7bfb69', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '8c401d8b67c8e6c808f6f4877efc11150e07c544135694efb35a8a14fe7bfb69')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Cinco días al año.', false), ('B', 'Tres días al año.', false), ('C', 'Seis días al año.', true), ('D', 'Ocho días al año.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'De acuerdo con el artículo 49 del TREBEP, el permiso por nacimiento para la madre biológica tendrá una duración de:', 'El art. 49.a) TREBEP, en su redacción vigente, fija en diecinueve semanas el permiso por nacimiento para la madre biológica (treinta y dos en caso de monoparentalidad), de las cuales las seis inmediatamente posteriores al parto son obligatorias.', 'age_aux_b1_14_derechos_deberes_funcionarios', (select id from public.topics where slug = 'age-aux-b1-14-derechos-deberes-funcionarios'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2015-11719'), 'Art. 49.a) TREBEP', 'a) Permiso por nacimiento para la madre biológica: tendrá una duración de diecinueve semanas.', 'Duración ampliada de dieciséis a diecinueve semanas por el Real Decreto-ley 9/2025, de 29 de julio; comprobar que la convocatoria toma como referencia el texto vigente tras esa reforma.', '26512465ac2cb2f83ea45e8dca3e98735b7e354f31451195d12de540b2d3173c', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '26512465ac2cb2f83ea45e8dca3e98735b7e354f31451195d12de540b2d3173c')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Dieciséis semanas.', false), ('B', 'Dieciocho semanas.', false), ('C', 'Veinte semanas.', false), ('D', 'Diecinueve semanas.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 50 del TREBEP, los funcionarios públicos tendrán derecho a disfrutar, durante cada año natural, de unas vacaciones retribuidas de:', 'El art. 50.1 TREBEP fija veintidós días hábiles de vacaciones anuales retribuidas; a estos efectos los sábados no se consideran días hábiles.', 'age_aux_b1_14_derechos_deberes_funcionarios', (select id from public.topics where slug = 'age-aux-b1-14-derechos-deberes-funcionarios'), 1, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2015-11719'), 'Art. 50.1 TREBEP', '1. Los funcionarios públicos tendrán derecho a disfrutar, durante cada año natural, de unas vacaciones retribuidas de veintidós días hábiles, o de los días que correspondan proporcionalmente si el tiempo de servicio durante el año fue menor.', null, '075357186a6b795235553d5762ed5e7c6eb69c4c1fb026b438646fbb16cae761', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '075357186a6b795235553d5762ed5e7c6eb69c4c1fb026b438646fbb16cae761')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Veintidós días hábiles, o los que correspondan proporcionalmente si el tiempo de servicio fue menor.', true), ('B', 'Treinta días naturales, o los que correspondan proporcionalmente si el tiempo de servicio fue menor.', false), ('C', 'Veinticinco días hábiles, con independencia del tiempo de servicio prestado.', false), ('D', 'Un mes natural, que deberá disfrutarse de forma ininterrumpida.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Entre los principios de conducta del artículo 54 del TREBEP, en relación con regalos y favores se establece que:', 'El art. 54.6 TREBEP obliga a rechazar regalos, favores o servicios en condiciones ventajosas que excedan de los usos habituales, sociales y de cortesía, sin perjuicio del Código Penal.', 'age_aux_b1_14_derechos_deberes_funcionarios', (select id from public.topics where slug = 'age-aux-b1-14-derechos-deberes-funcionarios'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2015-11719'), 'Art. 54.6 TREBEP', '6. Se rechazará cualquier regalo, favor o servicio en condiciones ventajosas que vaya más allá de los usos habituales, sociales y de cortesía, sin perjuicio de lo establecido en el Código Penal.', null, '5faaf8dd782ea4c55a9a5079b26e154550fd7c126448d77b3da80955633eda97', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '5faaf8dd782ea4c55a9a5079b26e154550fd7c126448d77b3da80955633eda97')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Podrán aceptarse siempre que se comuniquen al superior jerárquico en el plazo de diez días.', false), ('B', 'Se rechazará cualquier regalo, favor o servicio en condiciones ventajosas que vaya más allá de los usos habituales, sociales y de cortesía.', true), ('C', 'Se rechazará cualquier regalo, incluidos los propios de los usos habituales, sociales y de cortesía.', false), ('D', 'Podrán aceptarse cuando su valor no supere el importe de una mensualidad de retribuciones básicas.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select '¿Cuál de las siguientes conductas está tipificada como falta muy grave en el artículo 95.2 del TREBEP?', 'La incomparecencia injustificada en las Comisiones de Investigación parlamentarias es falta muy grave (art. 95.2.ñ TREBEP). Las demás conductas no figuran en la relación del art. 95.2.', 'age_aux_b1_14_derechos_deberes_funcionarios', (select id from public.topics where slug = 'age-aux-b1-14-derechos-deberes-funcionarios'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2015-11719'), 'Art. 95.2 TREBEP', 'ñ) La incomparecencia injustificada en las Comisiones de Investigación de las Cortes Generales y de las asambleas legislativas de las comunidades autónomas.', null, '7926f0cd605e198b6540414ad1874b49b9de757d99702d264e00f0d3e94472c7', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '7926f0cd605e198b6540414ad1874b49b9de757d99702d264e00f0d3e94472c7')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'La falta de puntualidad en la entrada al trabajo durante un solo día.', false), ('B', 'El descuido en la conservación del material de oficina.', false), ('C', 'La incorrección leve con los compañeros de trabajo.', false), ('D', 'La incomparecencia injustificada en las Comisiones de Investigación de las Cortes Generales y de las asambleas legislativas de las comunidades autónomas.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'De acuerdo con el artículo 96 del TREBEP, la sanción de separación del servicio:', 'El art. 96.1.a) TREBEP reserva la separación del servicio a las faltas muy graves y precisa que, para los interinos, supone la revocación del nombramiento. El límite de seis años corresponde a la suspensión firme de funciones.', 'age_aux_b1_14_derechos_deberes_funcionarios', (select id from public.topics where slug = 'age-aux-b1-14-derechos-deberes-funcionarios'), 3, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2015-11719'), 'Art. 96.1.a) TREBEP', 'a) Separación del servicio de los funcionarios, que en el caso de los funcionarios interinos comportará la revocación de su nombramiento, y que sólo podrá sancionar la comisión de faltas muy graves.', null, '0b49a9a2cae14306f47cac2532bd34d4c10323f4ad57d1d4f2ee21b78fa24f87', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '0b49a9a2cae14306f47cac2532bd34d4c10323f4ad57d1d4f2ee21b78fa24f87')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Solo podrá sancionar la comisión de faltas muy graves y, en el caso de los funcionarios interinos, comportará la revocación de su nombramiento.', true), ('B', 'Podrá sancionar la comisión de faltas graves y muy graves.', false), ('C', 'Solo puede imponerse a funcionarios de carrera, nunca a funcionarios interinos.', false), ('D', 'Tendrá una duración máxima de seis años.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 97 del TREBEP, las sanciones impuestas por faltas leves prescribirán:', 'El art. 97.1 TREBEP fija la prescripción de las faltas en 3 años (muy graves), 2 años (graves) y 6 meses (leves); la de las sanciones, en 3 años (muy graves), 2 años (graves) y 1 año (leves).', 'age_aux_b1_14_derechos_deberes_funcionarios', (select id from public.topics where slug = 'age-aux-b1-14-derechos-deberes-funcionarios'), 3, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2015-11719'), 'Art. 97.1 TREBEP', 'las sanciones impuestas por faltas muy graves prescribirán a los tres años, las impuestas por faltas graves a los dos años y las impuestas por faltas leves al año.', null, '07ec92012015927a7a30323b4f8f8fe3687112be9beb9114790d6fb95a59bdda', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '07ec92012015927a7a30323b4f8f8fe3687112be9beb9114790d6fb95a59bdda')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'A los seis meses.', false), ('B', 'A los dos años.', false), ('C', 'Al año.', true), ('D', 'A los tres meses.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'De acuerdo con el artículo 98 del TREBEP, la suspensión provisional como medida cautelar en la tramitación de un expediente disciplinario no podrá exceder de:', 'El art. 98.3 TREBEP limita la suspensión provisional a seis meses, salvo paralización imputable al interesado; durante ella se perciben las retribuciones básicas y, en su caso, las prestaciones familiares por hijo a cargo.', 'age_aux_b1_14_derechos_deberes_funcionarios', (select id from public.topics where slug = 'age-aux-b1-14-derechos-deberes-funcionarios'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2015-11719'), 'Art. 98.3 TREBEP', 'La suspensión provisional como medida cautelar en la tramitación de un expediente disciplinario no podrá exceder de 6 meses, salvo en caso de paralización del procedimiento imputable al interesado.', null, '7dd74788fc42d16bb594a6a0af34fc2a0f4c59046043354ac8eb631f301d06d9', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '7dd74788fc42d16bb594a6a0af34fc2a0f4c59046043354ac8eb631f301d06d9')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Tres meses, prorrogables por otros tres.', false), ('B', 'Seis meses, salvo en caso de paralización del procedimiento imputable al interesado.', true), ('C', 'Un año, en todo caso.', false), ('D', 'Seis años, salvo que la suspensión se eleve a definitiva.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
-- Lote age-aux-b1-15-presupuesto-ce-v1 (5 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Constitución Española (texto consolidado, BOE)', 'https://www.boe.es/buscar/act.php?id=BOE-A-1978-31229', 'boe'::public.source_kind, 'Agencia Estatal Boletín Oficial del Estado', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('age-aux-b1-15-presupuesto', 'I.15 El presupuesto del Estado') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug = 'auxiliar-administrativo-estado' and t.slug = 'age-aux-b1-15-presupuesto' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 134 de la Constitución Española, corresponde la elaboración de los Presupuestos Generales del Estado:', 'El art. 134.1 CE reparte las funciones: el Gobierno elabora y las Cortes Generales examinan, enmiendan y aprueban.', 'age_aux_b1_15_presupuesto', (select id from public.topics where slug = 'age-aux-b1-15-presupuesto'), 1, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1978-31229'), 'Art. 134.1 CE', '1. Corresponde al Gobierno la elaboración de los Presupuestos Generales del Estado y a las Cortes Generales, su examen, enmienda y aprobación.', null, 'f71ca28650aa7f336f3603a34b4873d2c77ebd1247c7409f7263b6b2d5ae3488', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'f71ca28650aa7f336f3603a34b4873d2c77ebd1247c7409f7263b6b2d5ae3488')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Al Gobierno, y a las Cortes Generales su examen, enmienda y aprobación.', true), ('B', 'A las Cortes Generales, y al Gobierno su examen y aprobación.', false), ('C', 'Al Ministerio de Hacienda, y al Consejo de Ministros su aprobación definitiva.', false), ('D', 'Al Congreso de los Diputados, y al Senado su enmienda y aprobación.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'De acuerdo con la Constitución, el Gobierno deberá presentar ante el Congreso de los Diputados los Presupuestos Generales del Estado:', 'El art. 134.3 CE exige presentarlos al menos tres meses antes de que expiren los del año anterior.', 'age_aux_b1_15_presupuesto', (select id from public.topics where slug = 'age-aux-b1-15-presupuesto'), 1, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1978-31229'), 'Art. 134.3 CE', '3. El Gobierno deberá presentar ante el Congreso de los Diputados los Presupuestos Generales del Estado al menos tres meses antes de la expiración de los del año anterior.', null, '5aa5aa63d2440de62bb9f14fce0c79ac7511f70067aced4568332eb496a2c510', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '5aa5aa63d2440de62bb9f14fce0c79ac7511f70067aced4568332eb496a2c510')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Al menos seis meses antes de la expiración de los del año anterior.', false), ('B', 'Al menos un mes antes de la expiración de los del año anterior.', false), ('C', 'Al menos tres meses antes de la expiración de los del año anterior.', true), ('D', 'Antes del 31 de diciembre del año anterior al que se refieran.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 134 de la Constitución, si la Ley de Presupuestos no se aprobara antes del primer día del ejercicio económico correspondiente:', 'La prórroga es automática y dura hasta la aprobación de los nuevos Presupuestos (art. 134.4 CE; art. 38 LGP).', 'age_aux_b1_15_presupuesto', (select id from public.topics where slug = 'age-aux-b1-15-presupuesto'), 1, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1978-31229'), 'Art. 134.4 CE', '4. Si la Ley de Presupuestos no se aprobara antes del primer día del ejercicio económico correspondiente, se considerarán automáticamente prorrogados los Presupuestos del ejercicio anterior hasta la aprobación de los nuevos.', null, '2a9eca624a04fcf31a283b9e1eaf26c8743c58982675e665acbf8286f32d172e', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '2a9eca624a04fcf31a283b9e1eaf26c8743c58982675e665acbf8286f32d172e')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El Gobierno deberá aprobar un real decreto-ley de presupuestos provisionales.', false), ('B', 'Se prorrogarán los Presupuestos del ejercicio anterior por un plazo máximo de seis meses.', false), ('C', 'El Gobierno deberá presentar un nuevo proyecto en el plazo de un mes.', false), ('D', 'Se considerarán automáticamente prorrogados los Presupuestos del ejercicio anterior hasta la aprobación de los nuevos.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según la Constitución Española, la Ley de Presupuestos:', 'El art. 134.7 CE prohíbe crear tributos en la Ley de Presupuestos y solo permite modificarlos si una ley tributaria sustantiva lo prevé.', 'age_aux_b1_15_presupuesto', (select id from public.topics where slug = 'age-aux-b1-15-presupuesto'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1978-31229'), 'Art. 134.7 CE', '7. La Ley de Presupuestos no puede crear tributos. Podrá modificarlos cuando una ley tributaria sustantiva así lo prevea.', null, '720be409e6c94869c69f39fe8935d0c1201dbd151f3ed2b7378496abe0b741d3', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '720be409e6c94869c69f39fe8935d0c1201dbd151f3ed2b7378496abe0b741d3')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Puede crear y modificar tributos libremente.', false), ('B', 'No puede crear tributos, pero podrá modificarlos cuando una ley tributaria sustantiva así lo prevea.', true), ('C', 'Puede crear tributos solo si son de carácter temporal.', false), ('D', 'No puede crear ni modificar tributos en ningún caso.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'De acuerdo con el artículo 134 de la Constitución, toda proposición o enmienda que suponga aumento de los créditos o disminución de los ingresos presupuestarios requerirá para su tramitación:', 'El art. 134.6 CE otorga al Gobierno un veto sobre proposiciones y enmiendas que aumenten créditos o disminuyan ingresos.', 'age_aux_b1_15_presupuesto', (select id from public.topics where slug = 'age-aux-b1-15-presupuesto'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1978-31229'), 'Art. 134.6 CE', '6. Toda proposición o enmienda que suponga aumento de los créditos o disminución de los ingresos presupuestarios requerirá la conformidad del Gobierno para su tramitación.', null, '54b8ad7cddba345c5ce7071b177e0276da7dcf1a71052205836f3642b97ad2d5', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '54b8ad7cddba345c5ce7071b177e0276da7dcf1a71052205836f3642b97ad2d5')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'La mayoría absoluta del Congreso de los Diputados.', false), ('B', 'El informe previo del Tribunal de Cuentas.', false), ('C', 'La conformidad de la Mesa del Senado.', false), ('D', 'La conformidad del Gobierno.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
-- Lote age-aux-b1-15-presupuesto-lgp-v1 (15 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Ley 47/2003, de 26 de noviembre, General Presupuestaria (texto consolidado, BOE)', 'https://www.boe.es/buscar/act.php?id=BOE-A-2003-21614', 'boe'::public.source_kind, 'Agencia Estatal Boletín Oficial del Estado', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('age-aux-b1-15-presupuesto', 'I.15 El presupuesto del Estado') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug = 'auxiliar-administrativo-estado' and t.slug = 'age-aux-b1-15-presupuesto' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 26 de la Ley 47/2003, General Presupuestaria, la programación presupuestaria se regirá, entre otros, por los principios de:', 'El art. 26.1 LGP enumera estabilidad presupuestaria, sostenibilidad financiera, plurianualidad, transparencia, eficiencia, responsabilidad y lealtad institucional.', 'age_aux_b1_15_presupuesto', (select id from public.topics where slug = 'age-aux-b1-15-presupuesto'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2003-21614'), 'Art. 26.1 LGP', '1. La programación presupuestaria se regirá por los principios de estabilidad presupuestaria, sostenibilidad financiera, plurianualidad, transparencia, eficiencia en la asignación y utilización de los recursos públicos, responsabilidad y lealtad institucional', null, 'c54c5c61ed320b4466f72c06000290fa9e454ca7c305729575b0887addbd3e79', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'c54c5c61ed320b4466f72c06000290fa9e454ca7c305729575b0887addbd3e79')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Estabilidad presupuestaria, jerarquía y descentralización.', false), ('B', 'Plurianualidad, confidencialidad y discrecionalidad.', false), ('C', 'Estabilidad presupuestaria, sostenibilidad financiera y plurianualidad.', true), ('D', 'Sostenibilidad financiera, autonomía y desconcentración.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según la Ley General Presupuestaria, los Presupuestos Generales del Estado constituyen:', 'El art. 32 LGP define los PGE como la expresión cifrada, conjunta y sistemática de derechos y obligaciones a liquidar en el ejercicio.', 'age_aux_b1_15_presupuesto', (select id from public.topics where slug = 'age-aux-b1-15-presupuesto'), 1, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2003-21614'), 'Art. 32 LGP', 'Los Presupuestos Generales del Estado constituyen la expresión cifrada, conjunta y sistemática de los derechos y obligaciones a liquidar durante el ejercicio por cada uno de los órganos y entidades que forman parte del sector público estatal.', null, '7d724e4ab4104c2113cf24795b021b50fdcaf5c013d17f5efc77757b0a6a64ad', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '7d724e4ab4104c2113cf24795b021b50fdcaf5c013d17f5efc77757b0a6a64ad')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'La previsión orientativa de los ingresos y gastos de la Administración General del Estado para un período de cuatro años.', false), ('B', 'La expresión cifrada, conjunta y sistemática de los derechos y obligaciones a liquidar durante el ejercicio por cada uno de los órganos y entidades que forman parte del sector público estatal.', true), ('C', 'La relación de los gastos máximos de los ministerios, sin incluir los ingresos.', false), ('D', 'El conjunto de los derechos y obligaciones reconocidos en el ejercicio anterior por el sector público estatal.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 34 de la Ley General Presupuestaria, el ejercicio presupuestario coincide con el año natural y a él se imputarán las obligaciones económicas reconocidas:', 'Al ejercicio se imputan los derechos liquidados durante él, cualquiera que sea su origen, y las obligaciones reconocidas hasta fin de diciembre por gastos realizados en el ejercicio.', 'age_aux_b1_15_presupuesto', (select id from public.topics where slug = 'age-aux-b1-15-presupuesto'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2003-21614'), 'Art. 34.1 LGP', 'b) Las obligaciones económicas reconocidas hasta el fin del mes de diciembre, siempre que correspondan a adquisiciones, obras, servicios, prestaciones o, en general, gastos realizados dentro del ejercicio y con cargo a los respectivos créditos.', null, '5a5f3cb8c16fc7a651ed6813d7136d7f58c19572503abbc8ad539b3c82a6cf3a', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '5a5f3cb8c16fc7a651ed6813d7136d7f58c19572503abbc8ad539b3c82a6cf3a')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Hasta el fin del mes de diciembre, siempre que correspondan a gastos realizados dentro del ejercicio y con cargo a los respectivos créditos.', true), ('B', 'Hasta el 31 de marzo del año siguiente, siempre que correspondan a gastos del ejercicio.', false), ('C', 'Durante el ejercicio, cualquiera que sea el período del que deriven.', false), ('D', 'Hasta el fin del mes de noviembre, salvo autorización del Consejo de Ministros.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según la Ley General Presupuestaria, el proyecto de Ley de Presupuestos Generales del Estado será remitido a las Cortes Generales:', 'El art. 37.1 LGP fija el 1 de octubre, en coherencia con los tres meses de antelación del art. 134.3 CE.', 'age_aux_b1_15_presupuesto', (select id from public.topics where slug = 'age-aux-b1-15-presupuesto'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2003-21614'), 'Art. 37.1 LGP', 'será remitido a las Cortes Generales antes del día 1 de octubre del año anterior al que se refiera.', null, '4b405c1f91d439d86cd8006cc0cdb0ea8c2265b1c2b42a4789c3720e7e54c7e3', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '4b405c1f91d439d86cd8006cc0cdb0ea8c2265b1c2b42a4789c3720e7e54c7e3')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Antes del día 1 de septiembre del año anterior al que se refiera.', false), ('B', 'Antes del día 1 de noviembre del año anterior al que se refiera.', false), ('C', 'Antes del día 31 de diciembre del año anterior al que se refiera.', false), ('D', 'Antes del día 1 de octubre del año anterior al que se refiera.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'De acuerdo con el artículo 37 de la Ley General Presupuestaria, ¿cuál de los siguientes documentos acompaña al proyecto de Ley de Presupuestos Generales del Estado?', 'Entre la documentación complementaria figuran las memorias de los programas, el informe de impacto de género, el de impacto en la infancia, adolescencia y familia, el de alineamiento con los ODS y la memoria de beneficios fiscales, entre otros.', 'age_aux_b1_15_presupuesto', (select id from public.topics where slug = 'age-aux-b1-15-presupuesto'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2003-21614'), 'Art. 37.2 LGP', '2. Al proyecto de Ley de Presupuestos Generales del Estado se acompañará la siguiente documentación complementaria: […] b) El informe de impacto de género.', null, 'fa168c071044c58e85277f3516796fe1687ce9c9297d514d0b89dd999971c3c7', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'fa168c071044c58e85277f3516796fe1687ce9c9297d514d0b89dd999971c3c7')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El informe de impacto de género.', true), ('B', 'El dictamen del Consejo de Estado sobre el proyecto.', false), ('C', 'El informe del Tribunal de Cuentas sobre el anteproyecto.', false), ('D', 'El dictamen del Consejo Económico y Social.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'En el procedimiento de elaboración de los Presupuestos Generales del Estado, las directrices para la distribución del gasto las determina el Ministro de Hacienda y, con este fin, se constituye:', 'La regla primera del art. 36.2 LGP prevé la Comisión de Políticas de Gasto para fijar criterios y límites de las propuestas de presupuesto.', 'age_aux_b1_15_presupuesto', (select id from public.topics where slug = 'age-aux-b1-15-presupuesto'), 3, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2003-21614'), 'Art. 36.2 LGP', 'Con este fin, se constituirá la Comisión de Políticas de Gasto, cuya composición se determinará por orden del Ministro de Hacienda.', null, '94f6342e8602c56162996cf01c3985685a6096f28344b405a0c72fdcfe0bf7cf', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '94f6342e8602c56162996cf01c3985685a6096f28344b405a0c72fdcfe0bf7cf')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'La Comisión General de Secretarios de Estado y Subsecretarios.', false), ('B', 'La Comisión de Presupuestos del Congreso de los Diputados.', false), ('C', 'La Comisión de Políticas de Gasto, cuya composición se determinará por orden del Ministro de Hacienda.', true), ('D', 'El Consejo de Política Fiscal y Financiera.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Señale la respuesta correcta sobre la prórroga de los Presupuestos Generales del Estado según el artículo 38 de la Ley General Presupuestaria:', 'La prórroga es automática y se refiere a los presupuestos iniciales; no alcanza a programas que terminen ni a obligaciones que se extingan, y su estructura orgánica se adapta a la organización vigente.', 'age_aux_b1_15_presupuesto', (select id from public.topics where slug = 'age-aux-b1-15-presupuesto'), 3, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2003-21614'), 'Art. 38 LGP', '2. La prórroga no afectará a los créditos para gastos correspondientes a programas o actuaciones que terminen en el ejercicio cuyos presupuestos se prorrogan o para obligaciones que se extingan en el mismo.', null, '70e2dfaa9487c7cce01ad4a2deabf8c4f7df2f52930c8828f533ee4bdc1f803b', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '70e2dfaa9487c7cce01ad4a2deabf8c4f7df2f52930c8828f533ee4bdc1f803b')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Requiere un acuerdo expreso del Consejo de Ministros que la declare.', false), ('B', 'No afecta a los créditos para gastos correspondientes a programas o actuaciones que terminen en el ejercicio cuyos presupuestos se prorrogan.', true), ('C', 'Afecta a los presupuestos definitivos del ejercicio anterior, incluidas todas sus modificaciones.', false), ('D', 'Mantiene inalterada la estructura orgánica del presupuesto prorrogado.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según la Ley General Presupuestaria, los estados de gastos de los Presupuestos Generales del Estado se estructuran de acuerdo con las clasificaciones:', 'El art. 40.1 LGP establece las clasificaciones orgánica, por programas y económica; el art. 40.2 añade la identificación funcional de los créditos.', 'age_aux_b1_15_presupuesto', (select id from public.topics where slug = 'age-aux-b1-15-presupuesto'), 1, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2003-21614'), 'Art. 40.1 LGP', '1. Los estados de gastos de los presupuestos a que se refiere el artículo 33.1.ª) de esta ley se estructurarán de acuerdo con las siguientes clasificaciones: a) La clasificación orgánica', null, 'a507d68f8a27fc18b8871f331329dad9e6477edc78ef4b3a16695187b748bdb2', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'a507d68f8a27fc18b8871f331329dad9e6477edc78ef4b3a16695187b748bdb2')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Orgánica, territorial y económica.', false), ('B', 'Funcional, por ministerios y por capítulos.', false), ('C', 'Económica, financiera y patrimonial.', false), ('D', 'Orgánica, por programas y económica.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'En la clasificación económica de los estados de gastos, la Ley General Presupuestaria dispone que en los créditos para operaciones de capital se distinguirán:', 'Operaciones corrientes: personal, bienes y servicios, gastos financieros y transferencias corrientes; de capital: inversiones reales y transferencias de capital; financieras: activos y pasivos financieros.', 'age_aux_b1_15_presupuesto', (select id from public.topics where slug = 'age-aux-b1-15-presupuesto'), 3, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2003-21614'), 'Art. 40.1.c) LGP', 'En los créditos para operaciones de capital se distinguirán las inversiones reales y las transferencias de capital.', null, 'c1af65b8b914410f4e670d3417d1b8f26a349369c72743792f509c2b13575c44', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'c1af65b8b914410f4e670d3417d1b8f26a349369c72743792f509c2b13575c44')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Las inversiones reales y las transferencias de capital.', true), ('B', 'Los gastos de personal y los gastos corrientes en bienes y servicios.', false), ('C', 'Los activos financieros y los pasivos financieros.', false), ('D', 'Los gastos financieros y las transferencias corrientes.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según la Ley General Presupuestaria, los actos administrativos y las disposiciones generales con rango inferior a ley que adquieran compromisos de gasto por cuantía superior al importe de los créditos autorizados en los estados de gastos son:', 'El art. 46 LGP declara limitativos los créditos para gastos y sanciona con nulidad de pleno derecho los actos que superen su importe.', 'age_aux_b1_15_presupuesto', (select id from public.topics where slug = 'age-aux-b1-15-presupuesto'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2003-21614'), 'Art. 46 LGP', 'Los créditos para gastos son limitativos. No podrán adquirirse compromisos de gasto ni adquirirse obligaciones por cuantía superior al importe de los créditos autorizados en los estados de gastos, siendo nulos de pleno derecho los actos administrativos y las disposiciones generales con rango inferior a ley que incumplan esta limitación', null, '0e6baa3d2f08a3ee419c9076e02832da419330929abd88069561b6844f13d682', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '0e6baa3d2f08a3ee419c9076e02832da419330929abd88069561b6844f13d682')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Anulables.', false), ('B', 'Válidos, aunque generan responsabilidad disciplinaria.', false), ('C', 'Nulos de pleno derecho.', true), ('D', 'Válidos si se convalidan por el Consejo de Ministros.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según la Ley General Presupuestaria, el Fondo de Contingencia de ejecución presupuestaria se dota por importe del:', 'El art. 50.1 LGP fija el Fondo en el 2 % del gasto no financiero (excluida la financiación territorial) para atender necesidades inaplazables y no discrecionales.', 'age_aux_b1_15_presupuesto', (select id from public.topics where slug = 'age-aux-b1-15-presupuesto'), 3, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2003-21614'), 'Art. 50.1 LGP', 'por importe del dos por ciento del total de gastos para operaciones no financieras, excluidos los destinados a financiar a las comunidades autónomas y entidades locales en aplicación de sus respectivos sistemas de financiación', null, 'c06a72924adfd014cb74e4986b7e791ef12f2265034347991b44a1b615138b11', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'c06a72924adfd014cb74e4986b7e791ef12f2265034347991b44a1b615138b11')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Cinco por ciento del total de gastos del presupuesto del Estado.', false), ('B', 'Dos por ciento del total de gastos para operaciones no financieras, excluidos los destinados a financiar a las comunidades autónomas y entidades locales en aplicación de sus sistemas de financiación.', true), ('C', 'Dos por ciento del total de ingresos tributarios del Estado.', false), ('D', 'Uno por ciento del total de gastos para operaciones financieras.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 73 de la Ley General Presupuestaria, la gestión del Presupuesto de gastos del Estado se realiza a través de las siguientes fases, por este orden:', 'Las fases son aprobación (A), compromiso (D), reconocimiento de la obligación (O), ordenación del pago y pago material (P); pueden acumularse en un solo acto cuando la naturaleza del gasto lo determine.', 'age_aux_b1_15_presupuesto', (select id from public.topics where slug = 'age-aux-b1-15-presupuesto'), 1, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2003-21614'), 'Art. 73.1 LGP', 'a) Aprobación del gasto. b) Compromiso de gasto. c) Reconocimiento de la obligación. d) Ordenación del pago. e) Pago material.', null, '29b75196b4eaa70e8bdf99703e85ffbe92117c15e039f2fc8fd5079fe90acd47', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '29b75196b4eaa70e8bdf99703e85ffbe92117c15e039f2fc8fd5079fe90acd47')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Compromiso de gasto, aprobación del gasto, ordenación del pago, reconocimiento de la obligación y pago material.', false), ('B', 'Aprobación del gasto, compromiso de gasto, reconocimiento de la obligación, ordenación del pago y pago material.', true), ('C', 'Aprobación del gasto, reconocimiento de la obligación, compromiso de gasto, pago material y ordenación del pago.', false), ('D', 'Reconocimiento de la obligación, aprobación del gasto, compromiso de gasto, ordenación del pago y pago material.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según la Ley General Presupuestaria, el acto mediante el cual se autoriza la realización de un gasto determinado por una cuantía cierta o aproximada, reservando a tal fin la totalidad o parte de un crédito presupuestario, es:', 'La aprobación inicia el procedimiento de ejecución del gasto y no implica relaciones con terceros ajenos a la Hacienda Pública estatal.', 'age_aux_b1_15_presupuesto', (select id from public.topics where slug = 'age-aux-b1-15-presupuesto'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2003-21614'), 'Art. 73.2 LGP', '2. La aprobación es el acto mediante el cual se autoriza la realización de un gasto determinado por una cuantía cierta o aproximada, reservando a tal fin la totalidad o parte de un crédito presupuestario.', null, 'f629150d196495f8f11d0350bf7d14a8de924081179d9ac5287a788da2a7aee2', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'f629150d196495f8f11d0350bf7d14a8de924081179d9ac5287a788da2a7aee2')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El compromiso de gasto.', false), ('B', 'El reconocimiento de la obligación.', false), ('C', 'La aprobación del gasto.', true), ('D', 'La ordenación del pago.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'De acuerdo con la Ley General Presupuestaria, ¿qué fase de la gestión del gasto es un acto con relevancia jurídica para con terceros, que vincula a la Hacienda Pública estatal a la realización del gasto en la cuantía y condiciones establecidas?', 'El compromiso acuerda la realización de gastos previamente aprobados por importe determinado o determinable y vincula frente a terceros (art. 73.3 LGP).', 'age_aux_b1_15_presupuesto', (select id from public.topics where slug = 'age-aux-b1-15-presupuesto'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2003-21614'), 'Art. 73.3 LGP', 'El compromiso es un acto con relevancia jurídica para con terceros, vinculando a la Hacienda Pública estatal o a la Seguridad Social a la realización del gasto a que se refiera en la cuantía y condiciones establecidas.', null, '4ea27c8a7d31dae056b1a4f030164513db1adda494e8be70b0054eae96194393', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '4ea27c8a7d31dae056b1a4f030164513db1adda494e8be70b0054eae96194393')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'La aprobación del gasto.', false), ('B', 'La elaboración del anteproyecto de presupuesto.', false), ('C', 'La retención de crédito.', false), ('D', 'El compromiso de gasto.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 73 de la Ley General Presupuestaria, el reconocimiento de la obligación es el acto mediante el que:', 'El reconocimiento de la obligación (fase O) exige acreditación documental de la prestación o del derecho del acreedor y comporta la propuesta de pago.', 'age_aux_b1_15_presupuesto', (select id from public.topics where slug = 'age-aux-b1-15-presupuesto'), 3, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2003-21614'), 'Art. 73.4 LGP', '4. El reconocimiento de la obligación es el acto mediante el que se declara la existencia de un crédito exigible contra la Hacienda Pública estatal o contra la Seguridad Social, derivado de un gasto aprobado y comprometido y que comporta la propuesta de pago correspondiente.', null, 'b6abb557fc0423c7ab0a6fdde490b3834d82e2375fd4f2e8facfd53ecc94d70f', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'b6abb557fc0423c7ab0a6fdde490b3834d82e2375fd4f2e8facfd53ecc94d70f')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Se declara la existencia de un crédito exigible contra la Hacienda Pública estatal, derivado de un gasto aprobado y comprometido, y que comporta la propuesta de pago correspondiente.', true), ('B', 'Se autoriza la realización de un gasto por una cuantía cierta o aproximada, reservando crédito presupuestario.', false), ('C', 'Se acuerda la realización de gastos previamente aprobados por un importe determinado o determinable.', false), ('D', 'Se expide la orden de pago a favor del acreedor por el Ordenador general de pagos.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
-- Lote age-aux-b1-16-igualdad-ldep-v1 (3 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Ley 39/2006, de 14 de diciembre, de Promoción de la Autonomía Personal y Atención a las personas en situación de dependencia (texto consolidado, BOE)', 'https://www.boe.es/buscar/act.php?id=BOE-A-2006-21990', 'boe'::public.source_kind, 'Agencia Estatal Boletín Oficial del Estado', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('age-aux-b1-16-igualdad', 'I.16 Igualdad, violencia de género, LGTBI, discapacidad y dependencia') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug = 'auxiliar-administrativo-estado' and t.slug = 'age-aux-b1-16-igualdad' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'De acuerdo con el artículo 7 de la Ley 39/2006, de Promoción de la Autonomía Personal y Atención a las personas en situación de dependencia, el nivel de protección mínimo del Sistema lo establece:', 'El art. 7 Ley 39/2006 distingue tres niveles: el mínimo, fijado por la Administración General del Estado; el acordado entre esta y cada Comunidad Autónoma mediante convenios; y el adicional que pueda establecer cada Comunidad Autónoma.', 'age_aux_b1_16_igualdad', (select id from public.topics where slug = 'age-aux-b1-16-igualdad'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2006-21990'), 'Art. 7 Ley 39/2006', '1.º El nivel de protección mínimo establecido por la Administración General del Estado', null, 'cd90b1dabe378e4699188663e1ea84f117d84e8bde1fc5e168e4f2b4f840c8a6', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'cd90b1dabe378e4699188663e1ea84f117d84e8bde1fc5e168e4f2b4f840c8a6')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Cada Comunidad Autónoma.', false), ('B', 'Las Entidades Locales.', false), ('C', 'La Administración General del Estado.', true), ('D', 'El Consejo Territorial de Servicios Sociales y del Sistema para la Autonomía y Atención a la Dependencia.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 26 de la Ley 39/2006, el Grado III de dependencia se denomina:', 'El art. 26.1 Ley 39/2006 clasifica la dependencia en Grado I (moderada), Grado II (severa) y Grado III (gran dependencia).', 'age_aux_b1_16_igualdad', (select id from public.topics where slug = 'age-aux-b1-16-igualdad'), 1, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2006-21990'), 'Art. 26.1.c) Ley 39/2006', 'c) Grado III. Gran dependencia', null, '3cb128750cc76ff0e9d7eb2597c39b97654296425255910dffa6f04737ebd92d', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '3cb128750cc76ff0e9d7eb2597c39b97654296425255910dffa6f04737ebd92d')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Gran dependencia.', true), ('B', 'Dependencia severa.', false), ('C', 'Dependencia moderada.', false), ('D', 'Dependencia total.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Para ser titular de los derechos establecidos en la Ley 39/2006, su artículo 5 exige, con carácter general, residir en territorio español y haberlo hecho durante:', 'El art. 5.1.c) Ley 39/2006 exige cinco años de residencia, dos de ellos inmediatamente anteriores a la solicitud; para los menores de cinco años, el periodo se exige a quien ejerza su guarda y custodia.', 'age_aux_b1_16_igualdad', (select id from public.topics where slug = 'age-aux-b1-16-igualdad'), 3, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2006-21990'), 'Art. 5.1.c) Ley 39/2006', 'c) Residir en territorio español y haberlo hecho durante cinco años, de los cuales dos deberán ser inmediatamente anteriores a la fecha de presentación de la solicitud.', 'El apartado 1 del art. 5 fue modificado por la Ley 4/2026, de 1 de octubre (excepciones para solicitantes y beneficiarios de asilo o protección temporal); el requisito de residencia se mantiene, pero conviene confirmar la versión que tome como referencia el examen.', '70ced163e3d1278db16383e2255378a8502352006ba58b2f3bd8f93eeed55c87', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '70ced163e3d1278db16383e2255378a8502352006ba58b2f3bd8f93eeed55c87')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Tres años, de los cuales uno deberá ser inmediatamente anterior a la fecha de presentación de la solicitud.', false), ('B', 'Cinco años, de los cuales dos deberán ser inmediatamente anteriores a la fecha de presentación de la solicitud.', true), ('C', 'Diez años, de los cuales cinco deberán ser inmediatamente anteriores a la fecha de presentación de la solicitud.', false), ('D', 'Dos años inmediatamente anteriores a la fecha de presentación de la solicitud.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
-- Lote age-aux-b1-16-igualdad-lgdpd-v1 (4 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Real Decreto Legislativo 1/2013, de 29 de noviembre, texto refundido de la Ley General de derechos de las personas con discapacidad y de su inclusión social (texto consolidado, BOE)', 'https://www.boe.es/buscar/act.php?id=BOE-A-2013-12632', 'boe'::public.source_kind, 'Agencia Estatal Boletín Oficial del Estado', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('age-aux-b1-16-igualdad', 'I.16 Igualdad, violencia de género, LGTBI, discapacidad y dependencia') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug = 'auxiliar-administrativo-estado' and t.slug = 'age-aux-b1-16-igualdad' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'De acuerdo con el artículo 2 del texto refundido de la Ley General de derechos de las personas con discapacidad y de su inclusión social, cuando una persona es objeto de un trato discriminatorio debido a su relación con otra por motivo o por razón de discapacidad, existe:', 'El art. 2.e) RDL 1/2013 define la discriminación por asociación. La discriminación directa (art. 2.c) se refiere al trato menos favorable a la propia persona con discapacidad por razón de ella.', 'age_aux_b1_16_igualdad', (select id from public.topics where slug = 'age-aux-b1-16-igualdad'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2013-12632'), 'Art. 2.e) RDL 1/2013', 'e) Discriminación por asociación: existe cuando una persona o grupo en que se integra es objeto de un trato discriminatorio debido a su relación con otra por motivo o por razón de discapacidad.', null, '02ed3f2561229e15f90fc58a7e9d201eaa802a270b5129d67956396c5e373fa6', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '02ed3f2561229e15f90fc58a7e9d201eaa802a270b5129d67956396c5e373fa6')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Discriminación por asociación.', true), ('B', 'Discriminación indirecta.', false), ('C', 'Acoso.', false), ('D', 'Discriminación directa.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 2 del Real Decreto Legislativo 1/2013, la actividad por la que se conciben o proyectan desde el origen, y siempre que sea posible, entornos, procesos, bienes, productos y servicios de tal forma que puedan ser utilizados por todas las personas, en la mayor extensión posible, sin necesidad de adaptación ni diseño especializado, se denomina:', 'El art. 2.l) RDL 1/2013 define el diseño universal como una actividad de concepción desde el origen. La accesibilidad universal (art. 2.k) es la condición que deben cumplir los entornos y productos; los ajustes razonables (art. 2.m) son adaptaciones para un caso particular.', 'age_aux_b1_16_igualdad', (select id from public.topics where slug = 'age-aux-b1-16-igualdad'), 3, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2013-12632'), 'Art. 2.l) RDL 1/2013', 'l) Diseño universal o diseño para todas las personas: es la actividad por la que se conciben o proyectan desde el origen, y siempre que ello sea posible, entornos, procesos, bienes, productos, servicios, objetos, instrumentos, programas, dispositivos o herramientas, de tal forma que puedan ser utilizados por todas las personas, en la mayor extensión posible, sin necesidad de adaptación ni diseño especializado.', null, 'a32162278528f378a6bbb966a06a0d3e0b1d1befeca1e516ba58d503da8112f9', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'a32162278528f378a6bbb966a06a0d3e0b1d1befeca1e516ba58d503da8112f9')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Accesibilidad universal.', false), ('B', 'Diseño universal o diseño para todas las personas.', true), ('C', 'Ajustes razonables.', false), ('D', 'Normalización.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'A los efectos del Real Decreto Legislativo 1/2013, además de las definidas en el artículo 4.1, tendrán la consideración de personas con discapacidad aquellas a quienes se les haya reconocido un grado de discapacidad igual o superior al:', 'El art. 4.2 RDL 1/2013 considera personas con discapacidad, a efectos de la ley, a quienes tengan reconocido un grado de discapacidad igual o superior al 33 %.', 'age_aux_b1_16_igualdad', (select id from public.topics where slug = 'age-aux-b1-16-igualdad'), 1, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2013-12632'), 'Art. 4.2 RDL 1/2013', '2. Además de lo establecido en el apartado anterior, a los efectos de esta ley, tendrán la consideración de personas con discapacidad aquellas a quienes se les haya reconocido un grado de discapacidad igual o superior al 33 por ciento.', null, 'cde1c5afaf2fa324c6c13bafbc5eed4b84252b8ff4c730c3948ab35e8b1dc1bc', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'cde1c5afaf2fa324c6c13bafbc5eed4b84252b8ff4c730c3948ab35e8b1dc1bc')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', '25 por ciento.', false), ('B', '45 por ciento.', false), ('C', '65 por ciento.', false), ('D', '33 por ciento.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 42 del Real Decreto Legislativo 1/2013, las empresas públicas y privadas que empleen a un número de 50 o más trabajadores vendrán obligadas a que, de entre ellos, sean trabajadores con discapacidad al menos:', 'El art. 42.1 RDL 1/2013 establece una cuota de reserva de al menos el 2 % en empresas de 50 o más trabajadores, computada sobre la plantilla total; excepcionalmente cabe la exención con medidas alternativas.', 'age_aux_b1_16_igualdad', (select id from public.topics where slug = 'age-aux-b1-16-igualdad'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2013-12632'), 'Art. 42.1 RDL 1/2013', '1. Las empresas públicas y privadas que empleen a un número de 50 o más trabajadores vendrán obligadas a que de entre ellos, al menos, el 2 por 100 sean trabajadores con discapacidad.', null, '8990436e1f27fe5823e1214a633444f85aa7659f6ad9e5329efea284a93ff6ea', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '8990436e1f27fe5823e1214a633444f85aa7659f6ad9e5329efea284a93ff6ea')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El 5 por 100.', false), ('B', 'El 7 por 100.', false), ('C', 'El 1 por 100.', false), ('D', 'El 2 por 100.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
-- Lote age-aux-b1-16-igualdad-lgtbi-v1 (4 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Ley 4/2023, de 28 de febrero, para la igualdad real y efectiva de las personas trans y para la garantía de los derechos de las personas LGTBI (texto consolidado, BOE)', 'https://www.boe.es/buscar/act.php?id=BOE-A-2023-5366', 'boe'::public.source_kind, 'Agencia Estatal Boletín Oficial del Estado', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('age-aux-b1-16-igualdad', 'I.16 Igualdad, violencia de género, LGTBI, discapacidad y dependencia') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug = 'auxiliar-administrativo-estado' and t.slug = 'age-aux-b1-16-igualdad' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 43 de la Ley 4/2023, para la igualdad real y efectiva de las personas trans y para la garantía de los derechos de las personas LGTBI, podrá solicitar por sí misma ante el Registro Civil la rectificación de la mención registral relativa al sexo:', 'El art. 43 Ley 4/2023 permite solicitarla por sí mismas a las personas españolas mayores de 16 años; entre 14 y 16, asistidas por sus representantes legales; entre 12 y 14, mediante autorización judicial.', 'age_aux_b1_16_igualdad', (select id from public.topics where slug = 'age-aux-b1-16-igualdad'), 1, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2023-5366'), 'Art. 43.1 Ley 4/2023', '1. Toda persona de nacionalidad española mayor de dieciséis años podrá solicitar por sí misma ante el Registro Civil la rectificación de la mención registral relativa al sexo.', null, 'bc1693973d6337672f335e94c2dcfc6e59ff11774db642a6657294506578a42e', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'bc1693973d6337672f335e94c2dcfc6e59ff11774db642a6657294506578a42e')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Únicamente la persona de nacionalidad española mayor de dieciocho años.', false), ('B', 'Toda persona de nacionalidad española mayor de catorce años, sin necesidad de asistencia de sus representantes legales.', false), ('C', 'Toda persona de nacionalidad española mayor de dieciséis años.', true), ('D', 'Toda persona de nacionalidad española mayor de doce años, sin necesidad de autorización judicial.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'De acuerdo con el artículo 44 de la Ley 4/2023, el ejercicio del derecho a la rectificación registral de la mención relativa al sexo:', 'El art. 44.3 Ley 4/2023 prohíbe condicionar la rectificación registral del sexo a informes médicos o psicológicos o a modificaciones corporales previas.', 'age_aux_b1_16_igualdad', (select id from public.topics where slug = 'age-aux-b1-16-igualdad'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2023-5366'), 'Art. 44.3 Ley 4/2023', '3. El ejercicio del derecho a la rectificación registral de la mención relativa al sexo en ningún caso podrá estar condicionado a la previa exhibición de informe médico o psicológico relativo a la disconformidad con el sexo mencionado en la inscripción de nacimiento, ni a la previa modificación de la apariencia o función corporal de la persona a través de procedimientos médicos, quirúrgicos o de otra índole.', null, '5cfc29c7728b9e2a928a282656e2c8f4560a452d3e0c1930dc3a1025447e9bfd', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '5cfc29c7728b9e2a928a282656e2c8f4560a452d3e0c1930dc3a1025447e9bfd')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Requiere la previa exhibición de un informe psicológico sobre la disconformidad con el sexo mencionado en la inscripción de nacimiento.', false), ('B', 'En ningún caso podrá estar condicionado a la previa exhibición de informe médico o psicológico ni a la previa modificación de la apariencia o función corporal.', true), ('C', 'Requiere acreditar un tratamiento médico previo de, al menos, dos años.', false), ('D', 'Requiere informe médico únicamente cuando la persona solicitante sea menor de edad.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'En el procedimiento de rectificación registral de la mención relativa al sexo, el artículo 44.8 de la Ley 4/2023 dispone que la persona encargada del Registro Civil deberá citar a la persona legitimada para que comparezca de nuevo y ratifique su solicitud en el plazo máximo de:', 'Tras la comparecencia inicial, el encargado del Registro Civil debe citar de nuevo a la persona en un máximo de tres meses para que ratifique su solicitud; después dicta resolución en el plazo máximo de un mes desde esa segunda comparecencia (art. 44.8 y 9 Ley 4/2023).', 'age_aux_b1_16_igualdad', (select id from public.topics where slug = 'age-aux-b1-16-igualdad'), 3, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2023-5366'), 'Art. 44.8 Ley 4/2023', '8. En el plazo máximo de tres meses desde la comparecencia inicial reiterando la solicitud de rectificación inicial, la persona encargada del Registro Civil deberá citar a la persona legitimada para que comparezca de nuevo y ratifique su solicitud, aseverando la persistencia de su decisión.', null, '928569329be9adc2fac07140badd246cde875341c03cb15b34e46615c9092c16', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '928569329be9adc2fac07140badd246cde875341c03cb15b34e46615c9092c16')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Tres meses desde la comparecencia inicial.', true), ('B', 'Un mes desde la comparecencia inicial.', false), ('C', 'Seis meses desde la comparecencia inicial.', false), ('D', 'Quince días desde la comparecencia inicial.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 47 de la Ley 4/2023, las personas que hubieran promovido la rectificación de la mención registral relativa al sexo podrán recuperar la mención que figuraba previamente, siguiendo el mismo procedimiento, una vez transcurridos desde la inscripción de la rectificación:', 'El art. 47 Ley 4/2023 permite revertir la rectificación transcurridos seis meses desde su inscripción en el Registro Civil, por el mismo procedimiento.', 'age_aux_b1_16_igualdad', (select id from public.topics where slug = 'age-aux-b1-16-igualdad'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2023-5366'), 'Art. 47 Ley 4/2023', 'Transcurridos seis meses desde la inscripción en el Registro Civil de la rectificación de la mención registral relativa al sexo, las personas que hubieran promovido dicha rectificación podrán recuperar la mención registral del sexo que figuraba previamente a dicha rectificación en el Registro Civil, siguiendo el mismo procedimiento establecido en este Capítulo para la rectificación registral.', null, '4535f08d7b03fd98e2bb992f346f477054c9dedad22ce5f19b03d72d70770b06', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '4535f08d7b03fd98e2bb992f346f477054c9dedad22ce5f19b03d72d70770b06')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Tres meses.', false), ('B', 'Un año.', false), ('C', 'Seis meses.', true), ('D', 'Dos años.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
-- Lote age-aux-b1-16-igualdad-loi-v1 (5 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Ley Orgánica 3/2007, de 22 de marzo, para la igualdad efectiva de mujeres y hombres (texto consolidado, BOE)', 'https://www.boe.es/buscar/act.php?id=BOE-A-2007-6115', 'boe'::public.source_kind, 'Agencia Estatal Boletín Oficial del Estado', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('age-aux-b1-16-igualdad', 'I.16 Igualdad, violencia de género, LGTBI, discapacidad y dependencia') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug = 'auxiliar-administrativo-estado' and t.slug = 'age-aux-b1-16-igualdad' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 6 de la Ley Orgánica 3/2007, para la igualdad efectiva de mujeres y hombres, la situación en que una disposición, criterio o práctica aparentemente neutros pone a personas de un sexo en desventaja particular con respecto a personas del otro se considera:', 'El art. 6.2 LO 3/2007 define la discriminación indirecta, salvo que la disposición, criterio o práctica pueda justificarse objetivamente por una finalidad legítima con medios necesarios y adecuados. La directa (art. 6.1) supone un trato menos favorable en atención al sexo.', 'age_aux_b1_16_igualdad', (select id from public.topics where slug = 'age-aux-b1-16-igualdad'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2007-6115'), 'Art. 6.2 LO 3/2007', '2. Se considera discriminación indirecta por razón de sexo la situación en que una disposición, criterio o práctica aparentemente neutros pone a personas de un sexo en desventaja particular con respecto a personas del otro', null, 'c2acc1cfedb850001ab9d782e972f5a2eeb949e3c159ca70f435324256e28c2f', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'c2acc1cfedb850001ab9d782e972f5a2eeb949e3c159ca70f435324256e28c2f')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Discriminación indirecta por razón de sexo.', true), ('B', 'Discriminación directa por razón de sexo.', false), ('C', 'Acoso por razón de sexo.', false), ('D', 'Acción positiva.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'De acuerdo con la Ley Orgánica 3/2007, todo trato desfavorable a las mujeres relacionado con el embarazo o la maternidad constituye:', 'El art. 8 LO 3/2007 califica expresamente como discriminación directa por razón de sexo el trato desfavorable a las mujeres relacionado con el embarazo o la maternidad.', 'age_aux_b1_16_igualdad', (select id from public.topics where slug = 'age-aux-b1-16-igualdad'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2007-6115'), 'Art. 8 LO 3/2007', 'Constituye discriminación directa por razón de sexo todo trato desfavorable a las mujeres relacionado con el embarazo o la maternidad.', null, '43f500ebc3ed82ddf916d5cad8439ab9b3d8f243e8ce032094cf1a67b69e1901', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '43f500ebc3ed82ddf916d5cad8439ab9b3d8f243e8ce032094cf1a67b69e1901')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Discriminación indirecta por razón de sexo.', false), ('B', 'Acoso sexual.', false), ('C', 'Discriminación directa por razón de sexo.', true), ('D', 'Acoso por razón de sexo.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 45 de la Ley Orgánica 3/2007, las medidas de igualdad deberán dirigirse a la elaboración y aplicación de un plan de igualdad en las empresas de:', 'El art. 45.2 LO 3/2007 obliga a las empresas de cincuenta o más trabajadores a elaborar y aplicar un plan de igualdad, que debe negociarse con la representación legal de los trabajadores.', 'age_aux_b1_16_igualdad', (select id from public.topics where slug = 'age-aux-b1-16-igualdad'), 1, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2007-6115'), 'Art. 45.2 LO 3/2007', '2. En el caso de las empresas de cincuenta o más trabajadores, las medidas de igualdad a que se refiere el apartado anterior deberán dirigirse a la elaboración y aplicación de un plan de igualdad', null, 'dfdaed9c5f05035486f5930cb26e7597e073a71c36d837bd4b8362e8674248ae', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'dfdaed9c5f05035486f5930cb26e7597e073a71c36d837bd4b8362e8674248ae')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Cien o más trabajadores.', false), ('B', 'Cincuenta o más trabajadores.', true), ('C', 'Doscientos cincuenta o más trabajadores.', false), ('D', 'Veinticinco o más trabajadores.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'A los efectos de la Ley Orgánica 3/2007, se entiende por composición equilibrada la presencia de mujeres y hombres de forma que, en el conjunto a que se refiera, las personas de cada sexo:', 'La disposición adicional primera de la LO 3/2007 define la composición equilibrada con la horquilla 40-60 % para cada sexo.', 'age_aux_b1_16_igualdad', (select id from public.topics where slug = 'age-aux-b1-16-igualdad'), 1, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2007-6115'), 'Disp. adic. 1.ª LO 3/2007', 'A los efectos de esta Ley, se entenderá por composición equilibrada la presencia de mujeres y hombres de forma que, en el conjunto a que se refiera, las personas de cada sexo no superen el sesenta por ciento ni sean menos del cuarenta por ciento.', null, '58067ce30d157120d31fe66779662dca8bf2b8ee9a3b2c8c3e17aa6ea07d17b3', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '58067ce30d157120d31fe66779662dca8bf2b8ee9a3b2c8c3e17aa6ea07d17b3')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'No superen el setenta por ciento ni sean menos del treinta por ciento.', false), ('B', 'Representen exactamente el cincuenta por ciento.', false), ('C', 'No superen el sesenta y cinco por ciento ni sean menos del treinta y cinco por ciento.', false), ('D', 'No superen el sesenta por ciento ni sean menos del cuarenta por ciento.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 64 de la Ley Orgánica 3/2007, el Plan para la Igualdad entre mujeres y hombres en la Administración General del Estado:', 'El art. 64 LO 3/2007 atribuye al Gobierno la aprobación del Plan al inicio de cada legislatura; el Plan se negocia con la representación de los empleados públicos y su cumplimiento lo evalúa anualmente el Consejo de Ministros.', 'age_aux_b1_16_igualdad', (select id from public.topics where slug = 'age-aux-b1-16-igualdad'), 3, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2007-6115'), 'Art. 64 LO 3/2007', 'El Gobierno aprobará, al inicio de cada legislatura, un Plan para la Igualdad entre mujeres y hombres en la Administración General del Estado y en los organismos públicos vinculados o dependientes de ella. […] su cumplimiento será evaluado anualmente por el Consejo de Ministros.', null, '0951cc698cde4ffed41c375406602194a93fec91fc64bce8257992d279ec3516', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '0951cc698cde4ffed41c375406602194a93fec91fc64bce8257992d279ec3516')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Lo aprueba el Gobierno al inicio de cada legislatura y su cumplimiento es evaluado anualmente por el Consejo de Ministros.', true), ('B', 'Lo aprueba el Ministerio de Igualdad cada cuatro años y su cumplimiento es evaluado por las Cortes Generales.', false), ('C', 'Lo aprueba el Gobierno cada dos años y su cumplimiento es evaluado por la Comisión Interministerial de Igualdad entre mujeres y hombres.', false), ('D', 'Lo aprueba el Consejo de Participación de la Mujer anualmente y su cumplimiento es evaluado por el Gobierno.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
-- Lote age-aux-b1-16-igualdad-lovg-v1 (4 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Ley Orgánica 1/2004, de 28 de diciembre, de Medidas de Protección Integral contra la Violencia de Género (texto consolidado, BOE)', 'https://www.boe.es/buscar/act.php?id=BOE-A-2004-21760', 'boe'::public.source_kind, 'Agencia Estatal Boletín Oficial del Estado', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('age-aux-b1-16-igualdad', 'I.16 Igualdad, violencia de género, LGTBI, discapacidad y dependencia') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug = 'auxiliar-administrativo-estado' and t.slug = 'age-aux-b1-16-igualdad' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 1 de la Ley Orgánica 1/2004, de Medidas de Protección Integral contra la Violencia de Género, la ley actúa contra la violencia que se ejerce sobre las mujeres por parte de:', 'El art. 1.1 LO 1/2004 delimita la violencia de género por la relación entre agresor y víctima: cónyuges o personas ligadas por relaciones similares de afectividad, actuales o pasadas, aun sin convivencia.', 'age_aux_b1_16_igualdad', (select id from public.topics where slug = 'age-aux-b1-16-igualdad'), 1, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2004-21760'), 'Art. 1.1 LO 1/2004', 'se ejerce sobre éstas por parte de quienes sean o hayan sido sus cónyuges o de quienes estén o hayan estado ligados a ellas por relaciones similares de afectividad, aun sin convivencia.', null, '5209f65387c3c290a73f460ac634894015b762919c8948e5a3fa6640429da5f2', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '5209f65387c3c290a73f460ac634894015b762919c8948e5a3fa6640429da5f2')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Únicamente sus cónyuges actuales, siempre que exista convivencia.', false), ('B', 'Quienes convivan con ellas en el mismo domicilio, cualquiera que sea su relación.', false), ('C', 'Sus cónyuges o parejas de hecho inscritas, siempre que la relación siga vigente.', false), ('D', 'Quienes sean o hayan sido sus cónyuges o de quienes estén o hayan estado ligados a ellas por relaciones similares de afectividad, aun sin convivencia.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'De acuerdo con el artículo 1.4 de la Ley Orgánica 1/2004, la violencia de género a que se refiere la ley también comprende la violencia que, con el objetivo de causar perjuicio o daño a las mujeres, se ejerza sobre:', 'El art. 1.4 LO 1/2004 incluye en el concepto de violencia de género la ejercida sobre familiares o allegados menores de edad de la mujer con el objetivo de causarle perjuicio o daño.', 'age_aux_b1_16_igualdad', (select id from public.topics where slug = 'age-aux-b1-16-igualdad'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2004-21760'), 'Art. 1.4 LO 1/2004', '4. La violencia de género a que se refiere esta Ley también comprende la violencia que con el objetivo de causar perjuicio o daño a las mujeres se ejerza sobre sus familiares o allegados menores de edad por parte de las personas indicadas en el apartado primero.', null, 'dd9f0318595004bbaf1f540584c28167cdcb2c68c2fde82d93fb5fd2ca3e0670', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'dd9f0318595004bbaf1f540584c28167cdcb2c68c2fde82d93fb5fd2ca3e0670')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Sus familiares mayores de edad que convivan con ellas.', false), ('B', 'Sus familiares o allegados menores de edad.', true), ('C', 'Exclusivamente sus hijos comunes con el agresor.', false), ('D', 'Sus compañeros de trabajo.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 24 de la Ley Orgánica 1/2004, la funcionaria víctima de violencia de género tendrá derecho, en los términos que determine su legislación específica, a:', 'El art. 24 LO 1/2004 enumera los derechos de la funcionaria víctima: reducción o reordenación del tiempo de trabajo, movilidad geográfica de centro de trabajo y excedencia.', 'age_aux_b1_16_igualdad', (select id from public.topics where slug = 'age-aux-b1-16-igualdad'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2004-21760'), 'Art. 24 LO 1/2004', 'La funcionaria víctima de violencia de género tendrá derecho a la reducción o a la reordenación de su tiempo de trabajo, a la movilidad geográfica de centro de trabajo y a la excedencia en los términos que se determinen en su legislación específica.', null, '47e4cae48c15931e50b15dc6bb38068854122d5c71923d603977ce9e0c1629fb', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '47e4cae48c15931e50b15dc6bb38068854122d5c71923d603977ce9e0c1629fb')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'La jubilación anticipada voluntaria y a la excedencia.', false), ('B', 'Un permiso retribuido de seis meses y a la movilidad geográfica de centro de trabajo.', false), ('C', 'La reducción o la reordenación de su tiempo de trabajo, a la movilidad geográfica de centro de trabajo y a la excedencia.', true), ('D', 'La reducción de jornada sin pérdida de retribuciones y al traslado a otra Administración Pública.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'De acuerdo con la Ley Orgánica 1/2004, el Observatorio Estatal de Violencia sobre la Mujer remitirá un informe sobre la evolución de la violencia ejercida sobre la mujer:', 'El art. 30.2 LO 1/2004 obliga al Observatorio a remitir anualmente al Gobierno y a las Comunidades Autónomas un informe sobre la evolución de la violencia sobre la mujer y la efectividad de las medidas de protección.', 'age_aux_b1_16_igualdad', (select id from public.topics where slug = 'age-aux-b1-16-igualdad'), 3, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2004-21760'), 'Art. 30.2 LO 1/2004', '2. El Observatorio Estatal de Violencia sobre la Mujer remitirá al Gobierno y a las Comunidades Autónomas, con periodicidad anual, un informe sobre la evolución de la violencia ejercida sobre la mujer', null, '4dda696e0f1dabd6c7e2339c6d4aa19a9ed7967f01c8e172729c20402aba65f0', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '4dda696e0f1dabd6c7e2339c6d4aa19a9ed7967f01c8e172729c20402aba65f0')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'A las Cortes Generales, con periodicidad semestral.', false), ('B', 'Al Consejo General del Poder Judicial, cada dos años.', false), ('C', 'Al Defensor del Pueblo, con periodicidad anual.', false), ('D', 'Al Gobierno y a las Comunidades Autónomas, con periodicidad anual.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
commit;
