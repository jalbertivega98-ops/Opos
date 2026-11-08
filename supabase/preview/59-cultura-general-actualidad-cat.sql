-- Cultura general y actualidad de Cataluña (policía local y Guardia Urbana), con réplicas culturales: preguntas en BORRADOR con cita literal de la fuente oficial y fichas de estudio.
-- Generado: bash scripts/content/preview-sql.sh content/cultura-cat supabase/preview/57-cultura-general-actualidad-cat.sql. Idempotente.
begin;
-- Lote actcat-01-actualitat-bcnarq-v1 (2 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Barcelona 2026, Capital Mundial de l’Arquitectura', 'https://ajuntament.barcelona.cat/urbanisme-accio-climatica-mobilitat-pla-barris-serveis-urbans/ca/news/barcelona-2026-capital-mundial-de-larquitectura-1377921', 'web_oficial'::public.source_kind, 'Ajuntament de Barcelona', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('actcat-01-actualitat', 'Actualitat (novembre 2025 - novembre 2026): Catalunya, Barcelona, Espanya, UE i món') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('policia-local', 'guardia-urbana-barcelona') and t.slug = 'actcat-01-actualitat' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Quina capitalitat té Barcelona durant el 2026?', '2026: Barcelona és Capital Mundial de l''Arquitectura, amb activitats de Santa Eulàlia a Santa Llúcia, i acull el congrés de la Unió Internacional d''Arquitectes.', 'actcat_01_actualitat', (select id from public.topics where slug = 'actcat-01-actualitat'), 1, 'ca', true, (select id from public.sources where url = 'https://ajuntament.barcelona.cat/urbanisme-accio-climatica-mobilitat-pla-barris-serveis-urbans/ca/news/barcelona-2026-capital-mundial-de-larquitectura-1377921'), 'Barcelona, Capital Mundial de l''Arquitectura', 'Barcelona 2026, Capital Mundial de l’Arquitectura.', null, 'ce35ad5ca39b94b39e5f49d3d55718fc95ed650b480cc3fa3074f0640e9a8755', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'ce35ad5ca39b94b39e5f49d3d55718fc95ed650b480cc3fa3074f0640e9a8755')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Capital Mundial de l''Arquitectura', true), ('B', 'Capital Europea de la Cultura', false), ('C', 'Capital Mundial del Llibre', false), ('D', 'Capital Verda Europea', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local', 'guardia-urbana-barcelona');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Quan havia acollit Barcelona per última vegada el Congrés de la Unió Internacional d''Arquitectes, abans del de l''estiu de 2026?', 'Estiu de 2026: el congrés torna a Barcelona tres dècades després de la 19a edició, de 1996.', 'actcat_01_actualitat', (select id from public.topics where slug = 'actcat-01-actualitat'), 3, 'ca', true, (select id from public.sources where url = 'https://ajuntament.barcelona.cat/urbanisme-accio-climatica-mobilitat-pla-barris-serveis-urbans/ca/news/barcelona-2026-capital-mundial-de-larquitectura-1377921'), 'Congrés de la UIA a Barcelona', 'A l’estiu la ciutat serà la seu del Congrés de la Unió Internacional d’Arquitectes, tres dècades després d’haver estat la seu de la 19a edició, el 1996.', null, '3150c1399991397db28e252fd4bd83414f586c0826412576301bb986acc047bc', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '3150c1399991397db28e252fd4bd83414f586c0826412576301bb986acc047bc')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El 1992', false), ('B', 'El 1996', true), ('C', 'El 1888', false), ('D', 'El 2004', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local', 'guardia-urbana-barcelona');
-- Lote actcat-01-actualitat-bcngaudi26-v1 (2 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Barcelona ret homenatge a Antoni Gaudí amb una placa en el mateix punt on va ser atropellat l’any 1926 (07/06/2026)', 'https://ajuntament.barcelona.cat/premsa/2026/06/07/barcelona-ret-homenatge-a-antoni-gaudi-amb-una-placa-en-el-mateix-punt-on-va-ser-atropellat-lany-1926/', 'web_oficial'::public.source_kind, 'Ajuntament de Barcelona', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('actcat-01-actualitat', 'Actualitat (novembre 2025 - novembre 2026): Catalunya, Barcelona, Espanya, UE i món') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('policia-local', 'guardia-urbana-barcelona') and t.slug = 'actcat-01-actualitat' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'On va col·locar l''Ajuntament de Barcelona, el 7 de juny de 2026, una placa en homenatge a Antoni Gaudí?', '7 de juny de 2026, dins l''Any Gaudí (centenari de la seva mort): placa al lloc on el va atropellar un tramvia el 7 de juny de 1926.', 'actcat_01_actualitat', (select id from public.topics where slug = 'actcat-01-actualitat'), 2, 'ca', true, (select id from public.sources where url = 'https://ajuntament.barcelona.cat/premsa/2026/06/07/barcelona-ret-homenatge-a-antoni-gaudi-amb-una-placa-en-el-mateix-punt-on-va-ser-atropellat-lany-1926/'), 'Placa en record de Gaudí', 'amb la descoberta d’una placa col·locada en el mateix punt de la Gran Via de les Corts Catalanes on va ser atropellat per un tramvia el 7 de juny de 1926.', null, '0e8f929547c246a4e3ca294599fe55558835eac1e898b29f9d0f7a415ec5fd1e', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '0e8f929547c246a4e3ca294599fe55558835eac1e898b29f9d0f7a415ec5fd1e')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'A la façana de la Casa Vicens', false), ('B', 'A l''entrada del Park Güell', false), ('C', 'A la cripta de la Sagrada Família', false), ('D', 'Al punt de la Gran Via de les Corts Catalanes on el va atropellar un tramvia el 1926', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local', 'guardia-urbana-barcelona');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Quina torre de la Sagrada Família es va inaugurar el 10 de juny de 2026, centenari de la mort de Gaudí?', '10 de juny de 2026: inauguració de la torre de Jesucrist, coincidint amb la data de la mort de Gaudí.', 'actcat_01_actualitat', (select id from public.topics where slug = 'actcat-01-actualitat'), 1, 'ca', true, (select id from public.sources where url = 'https://ajuntament.barcelona.cat/premsa/2026/06/07/barcelona-ret-homenatge-a-antoni-gaudi-amb-una-placa-en-el-mateix-punt-on-va-ser-atropellat-lany-1926/'), 'Torre de Jesucrist', 'té lloc tres dies abans de la inauguració de la torre de Jesucrist de la Sagrada Família, prevista el 10 de juny, data de la mort de l’arquitecte.', null, 'bd01ee4f8e2d8b637c60f8cf8823f8d1d4856e28da92e0be9f052864b9306086', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'bd01ee4f8e2d8b637c60f8cf8823f8d1d4856e28da92e0be9f052864b9306086')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'La torre de la Mare de Déu', false), ('B', 'La torre de Jesucrist', true), ('C', 'La torre de Sant Mateu', false), ('D', 'La torre de Sant Joan', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local', 'guardia-urbana-barcelona');
-- Lote actcat-01-actualitat-bcnmerce26-v1 (2 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Tota la programació de la Mercè 2026 (16/09/2026) i Lectura del pregó de les Festes de la Mercè 2026 (22/09/2026)', 'https://ajuntament.barcelona.cat/ciutatvella/ca/noticies/tota-la-programacio-de-la-merce-2026-41192', 'web_oficial'::public.source_kind, 'Ajuntament de Barcelona', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('actcat-01-actualitat', 'Actualitat (novembre 2025 - novembre 2026): Catalunya, Barcelona, Espanya, UE i món') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('policia-local', 'guardia-urbana-barcelona') and t.slug = 'actcat-01-actualitat' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Quina va ser la ciutat convidada de les Festes de la Mercè 2026?', '23-27 de setembre de 2026: la Mercè va programar el millor talent artístic de Xangai, ciutat convidada.', 'actcat_01_actualitat', (select id from public.topics where slug = 'actcat-01-actualitat'), 2, 'ca', true, (select id from public.sources where url = 'https://ajuntament.barcelona.cat/ciutatvella/ca/noticies/tota-la-programacio-de-la-merce-2026-41192'), 'Mercè 2026, ciutat convidada', 'la programació del millor talent artístic de Shanghai, ciutat convidada d’enguany.', null, 'ed314c473477bed1fd9ae1ef988f0fb24f15bbde68bfd6275badf875915dfa06', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'ed314c473477bed1fd9ae1ef988f0fb24f15bbde68bfd6275badf875915dfa06')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Roma', false), ('B', 'Buenos Aires', false), ('C', 'Montreal', false), ('D', 'Xangai', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local', 'guardia-urbana-barcelona');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Qui va fer el pregó de les Festes de la Mercè 2026 al Saló de Cent?', '23 de setembre de 2026: pregó a càrrec d''Antoni i Meritxell Falgueras, en un acte presidit per l''alcalde Jaume Collboni.', 'actcat_01_actualitat', (select id from public.topics where slug = 'actcat-01-actualitat'), 3, 'ca', true, (select id from public.sources where url = 'https://ajuntament.barcelona.cat/ciutatvella/ca/noticies/tota-la-programacio-de-la-merce-2026-41192'), 'Mercè 2026, pregó', 'a càrrec del mestre celler Antoni Falgueras, acompanyat de la seva filla, la sommelier Meritxell Falgueras', null, '5cc6e10199ddd4589225d09c1fbb9213183fb10fba0ca70811a5379cde4b7dc6', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '5cc6e10199ddd4589225d09c1fbb9213183fb10fba0ca70811a5379cde4b7dc6')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El cuiner Ferran Adrià', false), ('B', 'La cantant Sílvia Pérez Cruz', false), ('C', 'El mestre celler Antoni Falgueras, acompanyat de la seva filla, la sommelier Meritxell Falgueras', true), ('D', 'L''actor Oriol Pla', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local', 'guardia-urbana-barcelona');
-- Lote actcat-01-actualitat-bcnpadro26-v1 (3 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('La població de Barcelona. Lectura del padró municipal d’habitants a 01/01/2026: síntesi de resultats', 'https://dades.ajuntament.barcelona.cat/informe-padro-poblacio/ca/seccio_2.html', 'web_oficial'::public.source_kind, 'Ajuntament de Barcelona, Departament d''Estadística i Difusió de Dades', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('actcat-01-actualitat', 'Actualitat (novembre 2025 - novembre 2026): Catalunya, Barcelona, Espanya, UE i món') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('policia-local', 'guardia-urbana-barcelona') and t.slug = 'actcat-01-actualitat' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Quants habitants tenia Barcelona segons el padró municipal de 2026?', 'Padró 2026: la població disminueix lleugerament però és el segon valor més alt dels darrers quaranta anys; l''edat mitjana és de 44,6 anys.', 'actcat_01_actualitat', (select id from public.topics where slug = 'actcat-01-actualitat'), 2, 'ca', true, (select id from public.sources where url = 'https://dades.ajuntament.barcelona.cat/informe-padro-poblacio/ca/seccio_2.html'), 'Padró de Barcelona 2026', 'La població de Barcelona disminueix lleugerament el 2026 i se situa en 1.729.963 persones, el segon valor més elevat dels darrers quaranta anys.', null, 'b1531b1b68720dbe643e4f1e4a934be12e967072854ba3d0a138462bce4acfaa', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'b1531b1b68720dbe643e4f1e4a934be12e967072854ba3d0a138462bce4acfaa')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', '1.729.963', true), ('B', '1.296.300', false), ('C', '2.398.280', false), ('D', '8.210.710', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local', 'guardia-urbana-barcelona');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons el padró de Barcelona de 2026, quins són els noms més triats per als nadons?', 'Padró 2026: Olívia, Sofia, Emma, Júlia i Ona per a les nenes; Mateo, Pau, Marc, Pol i Bruno per als nens.', 'actcat_01_actualitat', (select id from public.topics where slug = 'actcat-01-actualitat'), 1, 'ca', true, (select id from public.sources where url = 'https://dades.ajuntament.barcelona.cat/informe-padro-poblacio/ca/seccio_2.html'), 'Padró 2026, noms dels nadons', 'els noms més triats de nenes són Olívia, Sofia, Emma, Júlia i Ona. Pels nens, els preferits són Mateo, Pau, Marc, Pol i Bruno.', null, '34ec7c3e227f6370b69557b887ad284f97dd0e03af48698f809df19a6a58236b', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '34ec7c3e227f6370b69557b887ad284f97dd0e03af48698f809df19a6a58236b')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Júlia (nenes) i Marc (nens)', false), ('B', 'Olívia (nenes) i Mateo (nens)', true), ('C', 'Sofia (nenes) i Pau (nens)', false), ('D', 'Ona (nenes) i Bruno (nens)', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local', 'guardia-urbana-barcelona');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons el padró de 2026, quin és el país estranger amb més persones nascudes allà que viuen a Barcelona?', 'Padró 2026: gairebé 50.000 persones nascudes a l''Argentina; a Barcelona hi conviuen fins a 181 nacionalitats.', 'actcat_01_actualitat', (select id from public.topics where slug = 'actcat-01-actualitat'), 3, 'ca', true, (select id from public.sources where url = 'https://dades.ajuntament.barcelona.cat/informe-padro-poblacio/ca/seccio_2.html'), 'Padró 2026, país de naixement', 'Amb gairebé 50 mil persones, Argentina continua sent el país amb més aportació de nascuts a l’estranger.', null, '54e465282cf233c0d6063d07e9fed31290f4a45839b4e65b56e8cbde7ad9d11c', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '54e465282cf233c0d6063d07e9fed31290f4a45839b4e65b56e8cbde7ad9d11c')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'L''Argentina', true), ('B', 'El Marroc', false), ('C', 'Itàlia', false), ('D', 'La Xina', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local', 'guardia-urbana-barcelona');
-- Lote actcat-01-actualitat-bcnpapa26-v1 (2 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Barcelona acollirà aquest juny la visita del Papa Lleó XIV (29/05/2026)', 'https://ajuntament.barcelona.cat/oficina-afers-religiosos/ca/noticies/barcelona-acollira-aquest-juny-la-visita-del-papa-lleo-xiv-1640185', 'web_oficial'::public.source_kind, 'Ajuntament de Barcelona, Oficina d''Afers Religiosos', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('actcat-01-actualitat', 'Actualitat (novembre 2025 - novembre 2026): Catalunya, Barcelona, Espanya, UE i món') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('policia-local', 'guardia-urbana-barcelona') and t.slug = 'actcat-01-actualitat' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Quin papa va visitar Barcelona els dies 9 i 10 de juny de 2026?', '9-10 de juny de 2026: Lleó XIV va celebrar missa a la Sagrada Família, va visitar Brians 1 i Montserrat; abans havia estat a Madrid i després va anar a les Canàries.', 'actcat_01_actualitat', (select id from public.topics where slug = 'actcat-01-actualitat'), 1, 'ca', true, (select id from public.sources where url = 'https://ajuntament.barcelona.cat/oficina-afers-religiosos/ca/noticies/barcelona-acollira-aquest-juny-la-visita-del-papa-lleo-xiv-1640185'), 'Visita del papa Lleó XIV', 'Barcelona serà una de les principals seus de la visita oficial del Papa Lleó XIV a l’Estat espanyol aquest mes de juny. La capital catalana concentrarà diversos actes institucionals, religiosos i socials els dies 9 i 10 de juny', null, '17b59e3bfca217af3644b225587936ff9eacf435acb209f3b131911f74748b75', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '17b59e3bfca217af3644b225587936ff9eacf435acb209f3b131911f74748b75')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Francesc', false), ('B', 'Benet XVI', false), ('C', 'Lleó XIV', true), ('D', 'Joan Pau II', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local', 'guardia-urbana-barcelona');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Quina commemoració celebrava l''abadia de Montserrat quan la va visitar el papa el juny de 2026?', 'Juny de 2026: el papa va compartir una pregària amb la comunitat benedictina en la commemoració del mil·lenari del monestir.', 'actcat_01_actualitat', (select id from public.topics where slug = 'actcat-01-actualitat'), 2, 'ca', true, (select id from public.sources where url = 'https://ajuntament.barcelona.cat/oficina-afers-religiosos/ca/noticies/barcelona-acollira-aquest-juny-la-visita-del-papa-lleo-xiv-1640185'), 'Mil·lenari de Montserrat', 'es desplaçarà fins a l’abadia de Montserrat, en la commemoració del mil·lenari del monestir', null, 'da61fa8379a2ac652143a8f690df0080aa0762dbafe7f25fcc6ecff7dadc2123', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'da61fa8379a2ac652143a8f690df0080aa0762dbafe7f25fcc6ecff7dadc2123')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El mil·lenari del monestir', true), ('B', 'Els 500 anys de la basílica', false), ('C', 'El centenari de l''Escolania', false), ('D', 'Els 150 anys del cremallera', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local', 'guardia-urbana-barcelona');
-- Lote actcat-01-actualitat-bcnparkg-v1 (1 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('El Park Güell presenta una exposició de 900 fotografies que recorren un segle de la seva història (05/11/2026)', 'https://ajuntament.barcelona.cat/premsa/2026/11/05/el-park-guell-presenta-una-exposicio-de-900-fotografies-que-recorren-un-segle-de-la-seva-historia/', 'web_oficial'::public.source_kind, 'Ajuntament de Barcelona', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('actcat-01-actualitat', 'Actualitat (novembre 2025 - novembre 2026): Catalunya, Barcelona, Espanya, UE i món') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('policia-local', 'guardia-urbana-barcelona') and t.slug = 'actcat-01-actualitat' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Quin centenari es commemora el 2026 al Park Güell?', 'Novembre de 2026: la commemoració dels cent anys del Park Güell com a parc públic coincideix amb l''Any Gaudí i la Capitalitat Mundial de l''Arquitectura.', 'actcat_01_actualitat', (select id from public.topics where slug = 'actcat-01-actualitat'), 2, 'ca', true, (select id from public.sources where url = 'https://ajuntament.barcelona.cat/premsa/2026/11/05/el-park-guell-presenta-una-exposicio-de-900-fotografies-que-recorren-un-segle-de-la-seva-historia/'), 'Centenari del Park Güell com a parc públic', 'forma part de la commemoració dels cent anys del Park Güell com a parc públic', null, '55f2927d7fe7162754b2eb2ef7e6f82520dc5c8ad0dc8a07b2e7ed5b5a2d9383', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '55f2927d7fe7162754b2eb2ef7e6f82520dc5c8ad0dc8a07b2e7ed5b5a2d9383')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Els cent anys de la mort d''Eusebi Güell', false), ('B', 'Els cent anys de la inscripció a la UNESCO', false), ('C', 'Els cent anys de la Casa Museu Gaudí', false), ('D', 'Els cent anys com a parc públic', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local', 'guardia-urbana-barcelona');
-- Lote actcat-01-actualitat-bcnpremis25-v1 (1 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Premis Ciutat de Barcelona, 2025', 'https://ajuntament.barcelona.cat/ca/informacio-administrativa/premis/premis-ciutat-de-barcelona-2025', 'web_oficial'::public.source_kind, 'Ajuntament de Barcelona', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('actcat-01-actualitat', 'Actualitat (novembre 2025 - novembre 2026): Catalunya, Barcelona, Espanya, UE i món') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('policia-local', 'guardia-urbana-barcelona') and t.slug = 'actcat-01-actualitat' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Quants premis es van lliurar en l''edició 2025 dels Premis Ciutat de Barcelona, que va incorporar tres categories noves de ciència?', '11 de febrer de 2026: lliurament al Saló de Cent; amb tres categories més de ciència, en total sis de científiques i dinou premis.', 'actcat_01_actualitat', (select id from public.topics where slug = 'actcat-01-actualitat'), 3, 'ca', true, (select id from public.sources where url = 'https://ajuntament.barcelona.cat/ca/informacio-administrativa/premis/premis-ciutat-de-barcelona-2025'), 'Premis Ciutat de Barcelona 2025', 'En conseqüència, en l’edició del 2025 es lliuraran un total de dinou premis.', null, '4738a6ac66eb5a834492fce38657e80e1676780c50331dfd1975f3143b112b54', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '4738a6ac66eb5a834492fce38657e80e1676780c50331dfd1975f3143b112b54')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Deu', false), ('B', 'Dinou', true), ('C', 'Sis', false), ('D', 'Trenta', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local', 'guardia-urbana-barcelona');
-- Lote actcat-01-actualitat-bcntour26-v1 (2 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('La Festa Major del Tour omplirà Barcelona amb més de 60 propostes (15/05/2026) i Catalunya i Barcelona s’il·luminen de groc (26/03/2026)', 'https://ajuntament.barcelona.cat/premsa/2026/05/15/la-festa-major-del-tour-omplira-barcelona-amb-mes-de-60-propostes-per-celebrar-el-tour-de-franca/', 'web_oficial'::public.source_kind, 'Ajuntament de Barcelona', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('actcat-01-actualitat', 'Actualitat (novembre 2025 - novembre 2026): Catalunya, Barcelona, Espanya, UE i món') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('policia-local', 'guardia-urbana-barcelona') and t.slug = 'actcat-01-actualitat' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'On va acabar la segona etapa del Tour de França 2026, que va sortir de Barcelona?', '5 de juliol de 2026: la segona etapa del Tour va arribar a Montjuïc, tancant la Festa Major del Tour (26 de juny - 5 de juliol).', 'actcat_01_actualitat', (select id from public.topics where slug = 'actcat-01-actualitat'), 2, 'ca', true, (select id from public.sources where url = 'https://ajuntament.barcelona.cat/premsa/2026/05/15/la-festa-major-del-tour-omplira-barcelona-amb-mes-de-60-propostes-per-celebrar-el-tour-de-franca/'), 'Tour de França 2026', 'fins el 5 de juliol amb l’arribada de la segona etapa de la competició ciclista a Montjuïc', null, 'f3a9c52bdc534da0c7b6a4544bfb57d712bd9cd63c2a7298aeb51dbca9ab8107', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'f3a9c52bdc534da0c7b6a4544bfb57d712bd9cd63c2a7298aeb51dbca9ab8107')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Al Tibidabo', false), ('B', 'A la plaça de Catalunya', false), ('C', 'A Montjuïc', true), ('D', 'A Girona', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local', 'guardia-urbana-barcelona');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Quin grup va estrenar Energia!, la cançó oficial de la sortida del Tour de França 2026 des de Barcelona?', '26 de març de 2026, en el compte enrere de 100 dies per a l''inici del Tour.', 'actcat_01_actualitat', (select id from public.topics where slug = 'actcat-01-actualitat'), 3, 'ca', true, (select id from public.sources where url = 'https://ajuntament.barcelona.cat/premsa/2026/05/15/la-festa-major-del-tour-omplira-barcelona-amb-mes-de-60-propostes-per-celebrar-el-tour-de-franca/'), 'Cançó de la sortida del Tour', 'El grup Doctor Prats estrena Energia!, la cançó oficial de la sortida', null, '5b83c75ea9d7bb09cd2dba790f3af4c143848112b5a8bcdafe393b018c2ffa42', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '5b83c75ea9d7bb09cd2dba790f3af4c143848112b5a8bcdafe393b018c2ffa42')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Txarango', false), ('B', 'Els Catarres', false), ('C', 'Oques Grasses', false), ('D', 'Doctor Prats', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local', 'guardia-urbana-barcelona');
-- Lote actcat-01-actualitat-cervantes-v1 (1 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Gonzalo Celorio, Premio Cervantes 2025 (03/11/2025)', 'https://www.cultura.gob.es/actualidad/2025/11/251103-premio-cervantes-2025.html', 'web_oficial'::public.source_kind, 'Ministerio de Cultura', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('actcat-01-actualitat', 'Actualitat (novembre 2025 - novembre 2026): Catalunya, Barcelona, Espanya, UE i món') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('policia-local', 'guardia-urbana-barcelona') and t.slug = 'actcat-01-actualitat' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Qui va rebre el Premi Cervantes 2025, concedit pel Ministeri de Cultura?', '3 de novembre de 2025: Gonzalo Celorio (Ciutat de Mèxic, 1948) va guanyar el Cervantes, dotat amb 125.000 euros. Pombo el va guanyar el 2024.', 'actcat_01_actualitat', (select id from public.topics where slug = 'actcat-01-actualitat'), 2, 'ca', true, (select id from public.sources where url = 'https://www.cultura.gob.es/actualidad/2025/11/251103-premio-cervantes-2025.html'), 'Premi Cervantes 2025', 'Gonzalo Celorio, Premio Cervantes 2025 03/11/2025', 'El fet és del 3/11/2025, just fora dels 12 mesos (avui 6/11/2026); es manté perquè és el Cervantes vigent fins que es falli el de 2026.', '8fec33367c548fe9c9908a88b57250cf12b7347de3364cec3fd8c3b77241874b', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '8fec33367c548fe9c9908a88b57250cf12b7347de3364cec3fd8c3b77241874b')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Álvaro Pombo', false), ('B', 'L''escriptor mexicà Gonzalo Celorio', true), ('C', 'Luis Mateo Díez', false), ('D', 'Eduardo Mendoza', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local', 'guardia-urbana-barcelona');
-- Lote actcat-01-actualitat-consue26-v1 (1 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Presidency of the Council of the EU (Irish Presidency, July-December 2026)', 'https://irish-presidency.consilium.europa.eu/en/presidency/presidency-of-the-council-of-the-eu/', 'web_oficial'::public.source_kind, 'Council of the European Union', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('actcat-01-actualitat', 'Actualitat (novembre 2025 - novembre 2026): Catalunya, Barcelona, Espanya, UE i món') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('policia-local', 'guardia-urbana-barcelona') and t.slug = 'actcat-01-actualitat' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Quin estat exerceix la Presidència del Consell de la UE del 1 de juliol al 31 de desembre de 2026?', '1 de juliol de 2026: Irlanda assumeix per vuitena vegada la Presidència; forma trio amb Lituània (gener-juny de 2027) i Grècia (juliol-desembre de 2027).', 'actcat_01_actualitat', (select id from public.topics where slug = 'actcat-01-actualitat'), 2, 'ca', true, (select id from public.sources where url = 'https://irish-presidency.consilium.europa.eu/en/presidency/presidency-of-the-council-of-the-eu/'), 'Presidència irlandesa del Consell de la UE', 'On 1 July 2026, Ireland assumes the Presidency of the Council of the EU for the eighth time since its accession to the Union.', null, '497362087ec0d4058afe0203bc1ce87200407c57c03716b9965081f721fb26e2', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '497362087ec0d4058afe0203bc1ce87200407c57c03716b9965081f721fb26e2')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Irlanda', true), ('B', 'Lituània', false), ('C', 'Grècia', false), ('D', 'Dinamarca', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local', 'guardia-urbana-barcelona');
-- Lote actcat-01-actualitat-cop31-v1 (1 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('UN Climate Change Conference - Antalya, November 2026 (COP31)', 'https://unfccc.int/cop31', 'web_oficial'::public.source_kind, 'United Nations Framework Convention on Climate Change (UNFCCC)', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('actcat-01-actualitat', 'Actualitat (novembre 2025 - novembre 2026): Catalunya, Barcelona, Espanya, UE i món') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('policia-local', 'guardia-urbana-barcelona') and t.slug = 'actcat-01-actualitat' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'On se celebra la COP31, la Conferència de les Nacions Unides sobre el Canvi Climàtic, del 9 al 20 de novembre de 2026?', '9-20 de novembre de 2026: la COP31 té lloc a Antalya, presidida per Murat Kurum; l''australià Chris Bowen presideix les negociacions.', 'actcat_01_actualitat', (select id from public.topics where slug = 'actcat-01-actualitat'), 2, 'ca', true, (select id from public.sources where url = 'https://unfccc.int/cop31'), 'COP31', 'COP31 is the United Nations Climate Change Conference taking place in Antalya, Türkiye from 9 to 20 November 2026.', null, '5ffe2c3f3e6a711d8a794edc7aa305f5281c6f24b0fd4a13ee233dd008b7a13a', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '5ffe2c3f3e6a711d8a794edc7aa305f5281c6f24b0fd4a13ee233dd008b7a13a')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'A Belém (Brasil)', false), ('B', 'A Bonn (Alemanya)', false), ('C', 'A Antalya (Türkiye)', true), ('D', 'A Sydney (Austràlia)', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local', 'guardia-urbana-barcelona');
-- Lote actcat-01-actualitat-govcreu26-v1 (3 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('El Govern distingeix amb la Creu de Sant Jordi 20 persones i 10 entitats (nota de premsa, 14/04/2026)', 'https://govern.cat/gov/notes-premsa/812364/govern-distingeix-creu-sant-jordi-20-persones-10-entitats', 'web_oficial'::public.source_kind, 'Generalitat de Catalunya, Govern.cat', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('actcat-01-actualitat', 'Actualitat (novembre 2025 - novembre 2026): Catalunya, Barcelona, Espanya, UE i món') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('policia-local', 'guardia-urbana-barcelona') and t.slug = 'actcat-01-actualitat' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'A quantes persones i entitats va concedir el Govern la Creu de Sant Jordi 2026?', '14 d''abril de 2026: el Govern va concedir la Creu de Sant Jordi, distinció creada el 1981, a 20 persones i 10 entitats.', 'actcat_01_actualitat', (select id from public.topics where slug = 'actcat-01-actualitat'), 2, 'ca', true, (select id from public.sources where url = 'https://govern.cat/gov/notes-premsa/812364/govern-distingeix-creu-sant-jordi-20-persones-10-entitats'), 'Creu de Sant Jordi 2026', 'ha acordat concedir la Creu de Sant Jordi de la Generalitat de Catalunya 2026 a 20 persones i 10 entitats', null, 'e1cb1b79434a6fb01ba4eeec31e614177e391b2805574ac8c943be9b0df71996', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'e1cb1b79434a6fb01ba4eeec31e614177e391b2805574ac8c943be9b0df71996')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', '20 persones i 10 entitats', true), ('B', '10 persones i 20 entitats', false), ('C', '30 persones i 5 entitats', false), ('D', '15 persones i 15 entitats', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local', 'guardia-urbana-barcelona');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Quina representació nadalenca, feta de manera continuada des de 1925 a partir del text de Josep Maria Folch i Torres, va rebre la Creu de Sant Jordi 2026?', '14 d''abril de 2026: els Pastorets de Calaf van ser una de les 10 entitats distingides.', 'actcat_01_actualitat', (select id from public.topics where slug = 'actcat-01-actualitat'), 2, 'ca', true, (select id from public.sources where url = 'https://govern.cat/gov/notes-premsa/812364/govern-distingeix-creu-sant-jordi-20-persones-10-entitats'), 'Creu de Sant Jordi 2026, Pastorets de Calaf', 'Els Pastorets de Calaf constitueixen una de les representacions nadalenques més arrelades del país, representades de manera continuada a Calaf des de l’any 1925 a partir del text de Josep Maria Folch i Torres.', null, '394bd97018ee3e6f2539746a9abaced24efa1eb5b533242adc7f6d0fff870eb9', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '394bd97018ee3e6f2539746a9abaced24efa1eb5b533242adc7f6d0fff870eb9')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'La Passió d''Esparreguera', false), ('B', 'El Pessebre Vivent de Corbera', false), ('C', 'Els Pastorets de Calaf', true), ('D', 'El Cant de la Sibil·la de Mallorca', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local', 'guardia-urbana-barcelona');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Quina institució distingida amb la Creu de Sant Jordi 2026 va ser fundada el 1450 i va celebrar el 575è aniversari el 2025?', '14 d''abril de 2026: la UB, fundada el 1450, va rebre la Creu de Sant Jordi.', 'actcat_01_actualitat', (select id from public.topics where slug = 'actcat-01-actualitat'), 3, 'ca', true, (select id from public.sources where url = 'https://govern.cat/gov/notes-premsa/812364/govern-distingeix-creu-sant-jordi-20-persones-10-entitats'), 'Creu de Sant Jordi 2026, Universitat de Barcelona', 'Fundada l’any 1450, la Universitat de Barcelona és una de les institucions més antigues de Catalunya', null, '50a49ee809a2fb8e22921799c5b1479b2c85517cfe96f2f38efd070a254bb787', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '50a49ee809a2fb8e22921799c5b1479b2c85517cfe96f2f38efd070a254bb787')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'L''Institut d''Estudis Catalans', false), ('B', 'La Universitat de Barcelona', true), ('C', 'La Universitat de Lleida', false), ('D', 'L''Orfeó Català', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local', 'guardia-urbana-barcelona');
-- Lote actcat-01-actualitat-govmedor26-v1 (2 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('El Govern lliura la Medalla d''Or de la Generalitat al cuiner Ferran Adrià i a la física i directora del Sincrotró ALBA Caterina Biscari (nota de premsa, 01/09/2026)', 'https://govern.cat/salapremsa/notes-premsa/862672/el-govern-lliura-la-medalla-d-or-de-la-generalitat-al-cuiner-ferran-adria-i-a-la-fisica-i-directora-del-sincrotro-alba-caterina-biscari', 'web_oficial'::public.source_kind, 'Generalitat de Catalunya, Govern.cat', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('actcat-01-actualitat', 'Actualitat (novembre 2025 - novembre 2026): Catalunya, Barcelona, Espanya, UE i món') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('policia-local', 'guardia-urbana-barcelona') and t.slug = 'actcat-01-actualitat' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'A qui va atorgar el Govern la Medalla d''Or de la Generalitat el setembre de 2026?', '1 de setembre de 2026: el Consell Executiu va aprovar la Medalla d''Or, la màxima distinció de la Generalitat, per a Ferran Adrià i Caterina Biscari; es va lliurar el 8 de setembre.', 'actcat_01_actualitat', (select id from public.topics where slug = 'actcat-01-actualitat'), 1, 'ca', true, (select id from public.sources where url = 'https://govern.cat/salapremsa/notes-premsa/862672/el-govern-lliura-la-medalla-d-or-de-la-generalitat-al-cuiner-ferran-adria-i-a-la-fisica-i-directora-del-sincrotro-alba-caterina-biscari'), 'Medalla d''Or de la Generalitat 2026', 'El Consell Executiu ha aprovat atorgar la Medalla d’Or de la Generalitat de Catalunya al cuiner Ferran Adrià i a la física i directora del Sincrotró ALBA Caterina Biscari', null, '05e843dab2e43ccb7323d13e8abebd48a7411acac4acf5d35f4f506e84ded48d', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '05e843dab2e43ccb7323d13e8abebd48a7411acac4acf5d35f4f506e84ded48d')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'A la filòsofa Victòria Camps i a la periodista Julia Otero', false), ('B', 'A la cantant Sílvia Pérez Cruz i a l''actor Oriol Pla', false), ('C', 'Al cuiner Ferran Adrià i a la física Caterina Biscari', true), ('D', 'Al cuiner Fermí Puig i a l''empresari Miguel A. Torres', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local', 'guardia-urbana-barcelona');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Quina gran instal·lació científica dirigeix Caterina Biscari, Medalla d''Or de la Generalitat 2026?', '1 de setembre de 2026: Biscari dirigeix el Sincrotró ALBA des del 2012; les línies de llum hi han passat de set a catorze.', 'actcat_01_actualitat', (select id from public.topics where slug = 'actcat-01-actualitat'), 2, 'ca', true, (select id from public.sources where url = 'https://govern.cat/salapremsa/notes-premsa/862672/el-govern-lliura-la-medalla-d-or-de-la-generalitat-al-cuiner-ferran-adria-i-a-la-fisica-i-directora-del-sincrotro-alba-caterina-biscari'), 'Medalla d''Or 2026, Caterina Biscari', 'l’any 2012 va arribar a Barcelona per dirigir el Sincrotró ALBA.', null, '59b8745b0f4ea28a561fb409f6b2a4367b635c331e8045e311043d9462f7444c', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '59b8745b0f4ea28a561fb409f6b2a4367b635c331e8045e311043d9462f7444c')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El Sincrotró ALBA', true), ('B', 'El Barcelona Supercomputing Center', false), ('C', 'L''Observatori Fabra', false), ('D', 'L''Institut de Ciències del Mar', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local', 'guardia-urbana-barcelona');
-- Lote actcat-01-actualitat-govpic25-v1 (2 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('El Govern concedeix el Premi Internacional Catalunya 2025 a les activistes per la pau Yael Admi i Reem Alhajajra (acords de Govern, 23/12/2025)', 'https://govern.cat/gov/acords-govern/16039/govern-concedeix-premi-internacional-catalunya-2025-activistes-pau-yael-admi-reem-alhajajra', 'web_oficial'::public.source_kind, 'Generalitat de Catalunya, Govern.cat', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('actcat-01-actualitat', 'Actualitat (novembre 2025 - novembre 2026): Catalunya, Barcelona, Espanya, UE i món') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('policia-local', 'guardia-urbana-barcelona') and t.slug = 'actcat-01-actualitat' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'A qui va concedir el Govern el Premi Internacional Catalunya 2025?', '23 de desembre de 2025: el Govern va premiar Yael Admi i Reem Alhajajra per la iniciativa Mother''s Call; el lliurament va ser el 15 de gener de 2026.', 'actcat_01_actualitat', (select id from public.topics where slug = 'actcat-01-actualitat'), 2, 'ca', true, (select id from public.sources where url = 'https://govern.cat/gov/acords-govern/16039/govern-concedeix-premi-internacional-catalunya-2025-activistes-pau-yael-admi-reem-alhajajra'), 'Premi Internacional Catalunya 2025', 'El Govern ha aprovat concedir el Premi Internacional Catalunya 2025 a Yael Admi i Reem Alhajajra, activistes israeliana i palestina per la pau', null, '78d695d47377973f16b34633bb852c180cbe3cca76770ab814e4fd626532ed52', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '78d695d47377973f16b34633bb852c180cbe3cca76770ab814e4fd626532ed52')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'A Navi Pillay, jurista sud-africana', false), ('B', 'A María Corina Machado, opositora veneçolana', false), ('C', 'A l''organització japonesa Nihon Hidankyo', false), ('D', 'A Yael Admi i Reem Alhajajra, activistes israeliana i palestina per la pau (La Crida de les Mares)', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local', 'guardia-urbana-barcelona');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Quants nous habitatges preveu el pla aprovat pel Govern el desembre de 2025 per transformar sòl de sectors estratègics en solars?', '23 de desembre de 2025: el Govern va aprovar el pla per preparar sòl per a 214.000 nous habitatges.', 'actcat_01_actualitat', (select id from public.topics where slug = 'actcat-01-actualitat'), 2, 'ca', true, (select id from public.sources where url = 'https://govern.cat/gov/acords-govern/16039/govern-concedeix-premi-internacional-catalunya-2025-activistes-pau-yael-admi-reem-alhajajra'), 'Pla d''habitatge, 214.000 habitatges', 'el pla per transformar sòl situat en sectors estratègics en solars preparats per construir-hi 214.000 nous habitatges', null, '43d4c08f41a9433309b1df3bc6f33376c6d778dfec373e8a47dedb7c751c35e3', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '43d4c08f41a9433309b1df3bc6f33376c6d778dfec373e8a47dedb7c751c35e3')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', '214.000', true), ('B', '50.000', false), ('C', '21.400', false), ('D', '1.000.000', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local', 'guardia-urbana-barcelona');
-- Lote actcat-01-actualitat-govpnc26-v1 (2 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('President Illa: "Com Pau Casals, enguany podem dir al món un ''som catalans'' col·lectiu..." (Premis Nacionals de Cultura 2026, nota de premsa, 09/10/2026)', 'https://govern.cat/salapremsa/notes-premsa/878952/president-illa-com-pau-casals-enguany-dir-al-mon-som-catalans-collectiu-tothom-shi-senti-representat-part-activa', 'web_oficial'::public.source_kind, 'Generalitat de Catalunya, Govern.cat', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('actcat-01-actualitat', 'Actualitat (novembre 2025 - novembre 2026): Catalunya, Barcelona, Espanya, UE i món') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('policia-local', 'guardia-urbana-barcelona') and t.slug = 'actcat-01-actualitat' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'On es van lliurar els Premis Nacionals de Cultura 2026, en homenatge a Pau Casals pel 150è aniversari del seu naixement?', '9 d''octubre de 2026: el president va presidir al Vendrell la proclamació i el lliurament dels set Premis Nacionals de Cultura.', 'actcat_01_actualitat', (select id from public.topics where slug = 'actcat-01-actualitat'), 2, 'ca', true, (select id from public.sources where url = 'https://govern.cat/salapremsa/notes-premsa/878952/president-illa-com-pau-casals-enguany-dir-al-mon-som-catalans-collectiu-tothom-shi-senti-representat-part-activa'), 'Premis Nacionals de Cultura 2026, lloc', 'La celebració ha tingut lloc a l’Auditori Pau Casals en homenatge a la figura de Pau Casals, referent universal del compromís amb la cultura, la pau i la llibertat, amb motiu del 150è aniversari del seunaixement.', null, '7cc99cf9b4d0aadb84209ce48a485c77a1cb42bd4c707f3869b0bf4b1df3db48', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '7cc99cf9b4d0aadb84209ce48a485c77a1cb42bd4c707f3869b0bf4b1df3db48')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Al Palau de la Música Catalana', false), ('B', 'Al Teatre Nacional de Catalunya', false), ('C', 'Al Gran Teatre del Liceu', false), ('D', 'A l''Auditori Pau Casals del Vendrell', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local', 'guardia-urbana-barcelona');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Quina cantant va rebre el Premi Nacional de Cultura 2026 per l''excel·lència musical i la qualitat vocal i interpretativa?', '9 d''octubre de 2026: Sílvia Pérez Cruz va ser una dels set guardonats (amb Oriol Pla, Victoria Szpunberg, Pol Guasch, Àlex Ollé, Cabosanroque i Jaŋde Editorial).', 'actcat_01_actualitat', (select id from public.topics where slug = 'actcat-01-actualitat'), 1, 'ca', true, (select id from public.sources where url = 'https://govern.cat/salapremsa/notes-premsa/878952/president-illa-com-pau-casals-enguany-dir-al-mon-som-catalans-collectiu-tothom-shi-senti-representat-part-activa'), 'Premis Nacionals de Cultura 2026, música', 'Sílvia Pérez Cruz, Premi Nacional de Cultura per l’excel·lència musical i la qualitat vocal i interpretativa', null, 'ce1287641a20a39ed5eedb26d4a3648cc7e561bf69df3113dd91932968a95194', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'ce1287641a20a39ed5eedb26d4a3648cc7e561bf69df3113dd91932968a95194')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Rosalía', false), ('B', 'Sílvia Pérez Cruz', true), ('C', 'Maria del Mar Bonet', false), ('D', 'Núria Graham', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local', 'guardia-urbana-barcelona');
-- Lote actcat-01-actualitat-govpress26-v1 (3 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Els pressupostos de la Generalitat per al 2026 creixen un 22,8% respecte als darrers aprovats i acceleren la inversió amb fons propis (nota de premsa, 27/02/2026)', 'https://govern.cat/salapremsa/notes-premsa/795676/pressupostos-generalitat-al-2026-creixen-228-percent-respecte-als-darrers-aprovats-acceleren-inversio-fons-propis', 'web_oficial'::public.source_kind, 'Generalitat de Catalunya, Govern.cat', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('actcat-01-actualitat', 'Actualitat (novembre 2025 - novembre 2026): Catalunya, Barcelona, Espanya, UE i món') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('policia-local', 'guardia-urbana-barcelona') and t.slug = 'actcat-01-actualitat' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Quin import total tenia el projecte de pressupostos de la Generalitat per al 2026 aprovat pel Govern?', '27 de febrer de 2026: el Govern va aprovar un projecte de 49.162 M€, un 22,8% més que els pressupostos del 2023, els darrers aprovats.', 'actcat_01_actualitat', (select id from public.topics where slug = 'actcat-01-actualitat'), 2, 'ca', true, (select id from public.sources where url = 'https://govern.cat/salapremsa/notes-premsa/795676/pressupostos-generalitat-al-2026-creixen-228-percent-respecte-als-darrers-aprovats-acceleren-inversio-fons-propis'), 'Pressupostos 2026', 'El Govern de la Generalitat ha aprovat avui el Projecte de llei de pressupostos per a l’any 2026, uns comptes ambiciosos que assoleixen un import rècord de 49.162 M€.', null, '34aae96ed8d8510a9444ff0367defa97ea7db50af3c69099bcb91760e641b0b5', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '34aae96ed8d8510a9444ff0367defa97ea7db50af3c69099bcb91760e641b0b5')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', '13.840 milions d''euros', false), ('B', '49.162 milions d''euros', true), ('C', '9.126 milions d''euros', false), ('D', '120.000 milions d''euros', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local', 'guardia-urbana-barcelona');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Quin departament té el pressupost més alt en el projecte de pressupostos de la Generalitat per al 2026?', '27 de febrer de 2026: Salut (13.840 M€), Educació i FP (8.356 M€) i Drets Socials (4.248 M€) encapçalen els comptes.', 'actcat_01_actualitat', (select id from public.topics where slug = 'actcat-01-actualitat'), 2, 'ca', true, (select id from public.sources where url = 'https://govern.cat/salapremsa/notes-premsa/795676/pressupostos-generalitat-al-2026-creixen-228-percent-respecte-als-darrers-aprovats-acceleren-inversio-fons-propis'), 'Pressupostos 2026, departaments', 'L’any 2026, els departaments que compten amb un pressupost més alt són Salut (13.840 M€), Educació i Formació Professional (8.356 M€) i Drets Socials i Inclusió (4.248 M€).', null, '6192cedc8947623551b989a2b05af3f0f2c7ae75c3c00f39f970f06f8f97d72b', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '6192cedc8947623551b989a2b05af3f0f2c7ae75c3c00f39f970f06f8f97d72b')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Educació i Formació Professional', false), ('B', 'Drets Socials i Inclusió', false), ('C', 'Interior i Seguretat Pública', false), ('D', 'Salut', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local', 'guardia-urbana-barcelona');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Qui és la consellera d''Economia i Finances que va presentar els pressupostos de 2026 al Parlament?', '27 de febrer de 2026: Alícia Romero va presentar els comptes al Parlament, presidit per Josep Rull.', 'actcat_01_actualitat', (select id from public.topics where slug = 'actcat-01-actualitat'), 1, 'ca', true, (select id from public.sources where url = 'https://govern.cat/salapremsa/notes-premsa/795676/pressupostos-generalitat-al-2026-creixen-228-percent-respecte-als-darrers-aprovats-acceleren-inversio-fons-propis'), 'Consellera d''Economia', 'La consellera d’Economia i Finances, Alícia Romero, ha presentat al Parlament el contingut dels nous comptes', null, '8c02c852806ad6874c35e50f5ea38632e89af01075dba6dc072342527d1ccc6a', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '8c02c852806ad6874c35e50f5ea38632e89af01075dba6dc072342527d1ccc6a')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Alícia Romero', true), ('B', 'Yolanda Díaz', false), ('C', 'Sílvia Paneque', false), ('D', 'Núria Parlon', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local', 'guardia-urbana-barcelona');
-- Lote actcat-01-actualitat-idescat-v1 (1 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Anuari estadístic de Catalunya i El municipi en xifres (Institut d''Estadística de Catalunya)', 'https://www.idescat.cat/indicadors/?id=aec&lang=ca', 'web_oficial'::public.source_kind, 'Institut d''Estadística de Catalunya (Idescat)', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('actcat-01-actualitat', 'Actualitat (novembre 2025 - novembre 2026): Catalunya, Barcelona, Espanya, UE i món') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('policia-local', 'guardia-urbana-barcelona') and t.slug = 'actcat-01-actualitat' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Quina variació interanual del PIB de Catalunya va estimar Idescat per al tercer trimestre de 2026?', 'Novembre de 2026 (estimació avançada): +2,9% interanual i +0,7% intertrimestral.', 'actcat_01_actualitat', (select id from public.topics where slug = 'actcat-01-actualitat'), 3, 'ca', true, (select id from public.sources where url = 'https://www.idescat.cat/indicadors/?id=aec&lang=ca'), 'PIB de Catalunya, 3r trimestre 2026', 'El producte interior brut de Catalunya registra una variació interanual del 2,9% i intertrimestral del 0,7% al tercer trimestre del 2026', null, 'bf956bffa6172e392e0e2100156ec682c78410d273bef1f36d42f3fffbc4842a', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'bf956bffa6172e392e0e2100156ec682c78410d273bef1f36d42f3fffbc4842a')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', '-0,7%', false), ('B', '+8,3%', false), ('C', '+2,9%', true), ('D', '+4,5%', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local', 'guardia-urbana-barcelona');
-- Lote actcat-01-actualitat-moncloasmi26-v1 (1 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Pedro Sánchez destaca que con la subida del SMI en 2026 se da "un paso muy relevante para mejorar la vida de 2,5 millones de trabajadores" (16/02/2026)', 'https://www.lamoncloa.gob.es/presidente/actividades/Paginas/2026/160226-sanchez-subida-salario-minimo.aspx', 'web_oficial'::public.source_kind, 'La Moncloa, Gobierno de España', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('actcat-01-actualitat', 'Actualitat (novembre 2025 - novembre 2026): Catalunya, Barcelona, Espanya, UE i món') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('policia-local', 'guardia-urbana-barcelona') and t.slug = 'actcat-01-actualitat' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Quin és el salari mínim interprofessional (SMI) fixat per al 2026?', '16 de febrer de 2026: vuitena pujada de l''SMI des del 2018 (+3,1%), de 735 a 1.221 euros.', 'actcat_01_actualitat', (select id from public.topics where slug = 'actcat-01-actualitat'), 2, 'ca', true, (select id from public.sources where url = 'https://www.lamoncloa.gob.es/presidente/actividades/Paginas/2026/160226-sanchez-subida-salario-minimo.aspx'), 'Salari mínim interprofessional 2026', 'al pasar de los 735 euros al mes a los 1.221 euros brutos al mes en 14 pagas este año, tras haberse aprobado un nuevo incremento del 3,1% en 2026.', null, '21ca85d75e49bf752c09e55d4789f37375459ca64d4203ae091abc0affd1da0b', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '21ca85d75e49bf752c09e55d4789f37375459ca64d4203ae091abc0affd1da0b')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', '1.134 euros bruts al mes en 14 pagues', false), ('B', '1.221 euros bruts al mes en 14 pagues', true), ('C', '1.000 euros bruts al mes en 12 pagues', false), ('D', '735 euros bruts al mes en 14 pagues', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local', 'guardia-urbana-barcelona');
-- Lote actcat-01-actualitat-nobel-v1 (6 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('All Nobel Prizes 2026 (Nobel Foundation)', 'https://www.nobelprize.org/all-nobel-prizes-2026/', 'web_oficial'::public.source_kind, 'Nobel Foundation / Nobel Prize Outreach', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('actcat-01-actualitat', 'Actualitat (novembre 2025 - novembre 2026): Catalunya, Barcelona, Espanya, UE i món') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('policia-local', 'guardia-urbana-barcelona') and t.slug = 'actcat-01-actualitat' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Per quines contribucions es va concedir el premi Nobel de física 2026 a Francis Halzen?', 'Octubre de 2026: Halzen va adonar-se que el gel del pol Sud servia per detectar neutrins (observatori IceCube).', 'actcat_01_actualitat', (select id from public.topics where slug = 'actcat-01-actualitat'), 2, 'ca', true, (select id from public.sources where url = 'https://www.nobelprize.org/all-nobel-prizes-2026/'), 'Nobel de física 2026', 'Nobel Prize in Physics 2026 Francis Halzen “for decisive contributions to the IceCube Neutrino Observatory and the discovery of high-energy neutrinos of astrophysical origin”', null, '756dd36db8ff1c097592b0c7ff7b6d95a2d2f859d594dd76aa1e3299ced73ad1', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '756dd36db8ff1c097592b0c7ff7b6d95a2d2f859d594dd76aa1e3299ced73ad1')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Pel desenvolupament dels ordinadors quàntics', false), ('B', 'Per l''observatori de neutrins IceCube i el descobriment de neutrins d''alta energia d''origen astrofísic', true), ('C', 'Per la detecció de les ones gravitacionals', false), ('D', 'Pel descobriment del bosó de Higgs', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local', 'guardia-urbana-barcelona');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Quin descobriment va merèixer el premi Nobel de fisiologia o medicina 2026 (Deisseroth, Hegemann i Nagel)?', 'Octubre de 2026: el Nobel de medicina va premiar els descobriments que van portar a l''optogenètica.', 'actcat_01_actualitat', (select id from public.topics where slug = 'actcat-01-actualitat'), 3, 'ca', true, (select id from public.sources where url = 'https://www.nobelprize.org/all-nobel-prizes-2026/'), 'Nobel de medicina 2026', 'Karl Deisseroth, Peter Hegemann and Georg Nagel have been awarded the 2026 Nobel Prize in Physiology or Medicine for discoveries leading to optogenetics', null, '520a481dcacd36a6408a53c4912eb6f28aea9d2267342b38be1f1c4d5cc42300', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '520a481dcacd36a6408a53c4912eb6f28aea9d2267342b38be1f1c4d5cc42300')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Les vacunes d''ARN missatger', false), ('B', 'L''edició genètica amb CRISPR', false), ('C', 'Els microARN', false), ('D', 'L''optogenètica, que permet activar o desactivar amb llum l''activitat de neurones individuals en un cervell viu', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local', 'guardia-urbana-barcelona');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Qui va rebre el premi Nobel de literatura 2026?', 'Octubre de 2026: Anne Carson, per una obra en diàleg amb la tradició clàssica. Krasznahorkai va ser el Nobel 2025, Han Kang el 2024 i Celorio és el Premi Cervantes 2025.', 'actcat_01_actualitat', (select id from public.topics where slug = 'actcat-01-actualitat'), 1, 'ca', true, (select id from public.sources where url = 'https://www.nobelprize.org/all-nobel-prizes-2026/'), 'Nobel de literatura 2026', 'The Nobel Prize in Literature 2026 has been awarded to the Canadian author Anne Carson', null, '153fc4d61a73822945776c85f3d240ceadf342863bcfd6a89da0b1c610faf7c7', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '153fc4d61a73822945776c85f3d240ceadf342863bcfd6a89da0b1c610faf7c7')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'L''autora canadenca Anne Carson', true), ('B', 'L''autor hongarès László Krasznahorkai', false), ('C', 'L''autora sud-coreana Han Kang', false), ('D', 'L''autor mexicà Gonzalo Celorio', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local', 'guardia-urbana-barcelona');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Qui va rebre el premi Nobel de la pau 2026?', 'Octubre de 2026: Navanethem «Navi» Pillay, pels seus esforços per promoure la pau i el dret internacional. Machado el va rebre el 2025, Nihon Hidankyo el 2024 i Mohammadi el 2023.', 'actcat_01_actualitat', (select id from public.topics where slug = 'actcat-01-actualitat'), 1, 'ca', true, (select id from public.sources where url = 'https://www.nobelprize.org/all-nobel-prizes-2026/'), 'Nobel de la pau 2026', 'Nobel Peace Prize 2026 Navanethem “Navi” Pillay “for her efforts to promote peace and international law”', null, 'c1bc160f04f60693e9d86bb1f3bb97fa28d031d7298d0b21578b54948dd1a7b1', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'c1bc160f04f60693e9d86bb1f3bb97fa28d031d7298d0b21578b54948dd1a7b1')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'María Corina Machado', false), ('B', 'Narges Mohammadi', false), ('C', 'Navi Pillay', true), ('D', 'Nihon Hidankyo', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local', 'guardia-urbana-barcelona');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Sobre quin camp van treballar Robert E. Hall i Michael Woodford, premi de ciències econòmiques en memòria d''Alfred Nobel 2026?', 'Octubre de 2026: la seva recerca va generar un canvi de paradigma en la política d''estabilització.', 'actcat_01_actualitat', (select id from public.topics where slug = 'actcat-01-actualitat'), 3, 'ca', true, (select id from public.sources where url = 'https://www.nobelprize.org/all-nobel-prizes-2026/'), 'Nobel d''economia 2026', 'Robert E. Hall “for microeconomic foundations of macroeconomic stabilisation”', null, '0ecf97a25662be4d3a140e4bcdc9ea3aeddf6d9bea9a1f5e2b109660ae81783f', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '0ecf97a25662be4d3a140e4bcdc9ea3aeddf6d9bea9a1f5e2b109660ae81783f')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'L''economia del comportament', false), ('B', 'La desigualtat i el creixement a llarg termini', false), ('C', 'Els fonaments microeconòmics de l''estabilització macroeconòmica', true), ('D', 'Els mercats financers i les bombolles', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local', 'guardia-urbana-barcelona');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Per quin descobriment es va concedir el premi Nobel de química 2026 a Henri B. Kagan?', 'Octubre de 2026. Les estructures metal·loorgàniques van ser el Nobel de química 2025 (Kitagawa i altres).', 'actcat_01_actualitat', (select id from public.topics where slug = 'actcat-01-actualitat'), 3, 'ca', true, (select id from public.sources where url = 'https://www.nobelprize.org/all-nobel-prizes-2026/'), 'Nobel de química 2026', 'Nobel Prize in Chemistry 2026 Henri B. Kagan “for the discovery of non-linear effects and autocatalysis in asymmetric organic synthesis”', null, '75b5c283a4062697638b76f9eb4bfdc7a91251a5f75d3d7932f6af4964f341ce', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '75b5c283a4062697638b76f9eb4bfdc7a91251a5f75d3d7932f6af4964f341ce')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Les estructures metal·loorgàniques (MOF)', false), ('B', 'El disseny computacional de proteïnes', false), ('C', 'Les bateries d''ions de liti', false), ('D', 'Els efectes no lineals i l''autocatàlisi en la síntesi orgànica asimètrica', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local', 'guardia-urbana-barcelona');
-- Lote actcat-01-actualitat-onu-v1 (1 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('United Nations: About Us, UN Charter, Main Bodies i Selection and Appointment of the Next Secretary-General', 'https://www.un.org/en/about-us', 'web_oficial'::public.source_kind, 'United Nations', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('actcat-01-actualitat', 'Actualitat (novembre 2025 - novembre 2026): Catalunya, Barcelona, Espanya, UE i món') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('policia-local', 'guardia-urbana-barcelona') and t.slug = 'actcat-01-actualitat' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Quan es va iniciar formalment el procés de selecció del pròxim secretari general de les Nacions Unides, successor d''António Guterres?', '25 de novembre de 2025: inici formal del procés (Michelle Bachelet, candidata des del 2 de febrer de 2026, es va retirar el 21 de setembre de 2026).', 'actcat_01_actualitat', (select id from public.topics where slug = 'actcat-01-actualitat'), 3, 'ca', true, (select id from public.sources where url = 'https://www.un.org/en/about-us'), 'Selecció del secretari general de l''ONU', 'A joint letter of the President of the General Assembly and the President of the Security Council addressed to Member States, published on 25 November 2025, formally initiated the selection process.', null, '948b99599bdb06747b64d081d93ad03711ee0f6425291b013bd9274320a635c8', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '948b99599bdb06747b64d081d93ad03711ee0f6425291b013bd9274320a635c8')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El 24 d''octubre de 2025, Dia de les Nacions Unides', false), ('B', 'L''1 de gener de 2026, amb una resolució del Consell de Seguretat', false), ('C', 'El 21 de setembre de 2026, a l''Assemblea General', false), ('D', 'El 25 de novembre de 2025, amb una carta conjunta dels presidents de l''Assemblea General i del Consell de Seguretat', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local', 'guardia-urbana-barcelona');
-- Lote actcat-01-actualitat-uepaisos-v1 (1 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Países de la UE: fichas de país (european-union.europa.eu/principles-countries-history/eu-countries/<país>_es)', 'https://european-union.europa.eu/principles-countries-history/eu-countries_es', 'web_oficial'::public.source_kind, 'Unión Europea', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('actcat-01-actualitat', 'Actualitat (novembre 2025 - novembre 2026): Catalunya, Barcelona, Espanya, UE i món') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('policia-local', 'guardia-urbana-barcelona') and t.slug = 'actcat-01-actualitat' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Quin país es va incorporar a la zona euro l''1 de gener de 2026?', '1 de gener de 2026: Bulgària va adoptar l''euro; Croàcia ho havia fet el 2023, i Polònia i Suècia mantenen la seva moneda.', 'actcat_01_actualitat', (select id from public.topics where slug = 'actcat-01-actualitat'), 1, 'ca', true, (select id from public.sources where url = 'https://european-union.europa.eu/principles-countries-history/eu-countries_es'), 'Bulgària a la zona euro', '[Bulgaria] Capital: Sofía Zona del euro: Miembro desde el 1 de enero de 2026', null, 'b2b15b8bf28b1f74b3b20a6ed56bd916c9943e1dc725a7c25980275c350effb6', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'b2b15b8bf28b1f74b3b20a6ed56bd916c9943e1dc725a7c25980275c350effb6')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Croàcia', false), ('B', 'Polònia', false), ('C', 'Bulgària', true), ('D', 'Suècia', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local', 'guardia-urbana-barcelona');
-- Lote cultcat-01-historia-catalunya-eac-v1 (1 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Ley Orgánica 6/2006, de 19 de julio, de reforma del Estatuto de Autonomía de Cataluña (texto consolidado, BOE)', 'https://www.boe.es/buscar/act.php?id=BOE-A-2006-13087', 'boe'::public.source_kind, 'Agencia Estatal Boletín Oficial del Estado', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('cultcat-01-historia-catalunya', 'Cultura general 1. Història de Catalunya: institucions, símbols i fets clau') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('policia-local', 'guardia-urbana-barcelona') and t.slug = 'cultcat-01-historia-catalunya' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''Estatut d''autonomia, quin és l''himne de Catalunya?', 'L''article 8 de l''Estatut fixa com a símbols nacionals la bandera de quatre barres, la festa de l''Onze de Setembre i l''himne Els segadors.', 'cultcat_01_historia_catalunya', (select id from public.topics where slug = 'cultcat-01-historia-catalunya'), 1, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2006-13087'), 'Símbols nacionals, EAC art. 8', 'El himno de Cataluña es «Els segadors».', null, '69d0df6ef07eab51a2540fa068c2a8da9738ac84e1f0c4833cb89b0b7b7294df', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '69d0df6ef07eab51a2540fa068c2a8da9738ac84e1f0c4833cb89b0b7b7294df')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El cant de la senyera', false), ('B', 'Catalunya, pàtria nostra', false), ('C', 'Els segadors', true), ('D', 'El cant dels ocells', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local', 'guardia-urbana-barcelona');
-- Lote cultcat-01-historia-catalunya-genhist-v1 (19 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Història de la Generalitat (Diputació del General, Nova Planta i Generalitat contemporània)', 'https://web.gencat.cat/ca/generalitat/qui-som/historia-generalitat', 'web_oficial'::public.source_kind, 'Generalitat de Catalunya', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('cultcat-01-historia-catalunya', 'Cultura general 1. Història de Catalunya: institucions, símbols i fets clau') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('policia-local', 'guardia-urbana-barcelona') and t.slug = 'cultcat-01-historia-catalunya' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons el sistema pactista implantat a la Cort de Barcelona de 1283, què no podia fer el sobirà sense l''autorització dels tres estaments reunits en Corts?', 'A la Cort de Barcelona de 1283, presidida per Pere el Gran, es va establir que el rei no podia fer lleis (constitucions) ni cobrar impostos generals sense l''acord dels braços militar, eclesiàstic i reial.', 'cultcat_01_historia_catalunya', (select id from public.topics where slug = 'cultcat-01-historia-catalunya'), 2, 'ca', true, (select id from public.sources where url = 'https://web.gencat.cat/ca/generalitat/qui-som/historia-generalitat'), 'Diputació del General, 1283', 'Aquest sistema establia que el sobirà no podia promulgar constitucions ni exigir impostos generals sense l’autorització dels tres estaments o braços —el militar, l’eclesiàstic i el reial o popular— reunits en Corts.', null, '0dfee3eb1f2298816a329701ae96c9cb9a3e01737c81704bcdf9db90d8016458', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '0dfee3eb1f2298816a329701ae96c9cb9a3e01737c81704bcdf9db90d8016458')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Promulgar constitucions ni exigir impostos generals', true), ('B', 'Nomenar els consellers de la ciutat de Barcelona', false), ('C', 'Convocar la host per a la defensa del territori', false), ('D', 'Designar el bisbe de Barcelona', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local', 'guardia-urbana-barcelona');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Quina epidèmia va provocar una crisi econòmica i demogràfica a Catalunya l''any 1348, durant el regnat de Pere el Cerimoniós?', 'La Pesta Negra de 1348 va causar una crisi econòmica i demogràfica que va obligar tots els estaments a contribuir de manera més estable i va consolidar la Diputació.', 'cultcat_01_historia_catalunya', (select id from public.topics where slug = 'cultcat-01-historia-catalunya'), 2, 'ca', true, (select id from public.sources where url = 'https://web.gencat.cat/ca/generalitat/qui-som/historia-generalitat'), 'Diputació del General, Pesta Negra', 'Durant el regnat de Pere el Cerimoniós, Catalunya va viure una crisi econòmica i demogràfica a causa de la Pesta Negra de 1348.', null, 'd8eb934351553ec5f4cd6edca40140e37c3d048e8446947d9ed44415b70bd0da', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'd8eb934351553ec5f4cd6edca40140e37c3d048e8446947d9ed44415b70bd0da')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'La febre groga', false), ('B', 'El còlera', false), ('C', 'La Pesta Negra', true), ('D', 'La grip', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local', 'guardia-urbana-barcelona');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'On es va instal·lar la Diputació del General, en unes cases que amb el temps es van convertir en el Palau de la Generalitat?', 'La institució es va instal·lar a les cases del carrer de Sant Honorat, origen de l''actual Palau de la Generalitat.', 'cultcat_01_historia_catalunya', (select id from public.topics where slug = 'cultcat-01-historia-catalunya'), 2, 'ca', true, (select id from public.sources where url = 'https://web.gencat.cat/ca/generalitat/qui-som/historia-generalitat'), 'Diputació del General, seu', 'La institució es va instal·lar a les cases del carrer de Sant Honorat, que amb el temps es van convertir en el Palau de la Generalitat.', null, '14ce266c0bfd2ae4027c81343d898988e79f8a33216c2e3adc8178ac8c3686ff', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '14ce266c0bfd2ae4027c81343d898988e79f8a33216c2e3adc8178ac8c3686ff')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'A la plaça del Rei de Barcelona', false), ('B', 'Al monestir de Poblet', false), ('C', 'A la Llotja de Mar de Barcelona', false), ('D', 'Al carrer de Sant Honorat de Barcelona', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local', 'guardia-urbana-barcelona');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Com va acabar l''Interregne obert el 1410 per la mort sense descendència del rei Martí l''Humà?', 'L''extinció del Casal de Barcelona (1410) va obrir l''Interregne, que es va tancar amb el Compromís de Casp (1412).', 'cultcat_01_historia_catalunya', (select id from public.topics where slug = 'cultcat-01-historia-catalunya'), 2, 'ca', true, (select id from public.sources where url = 'https://web.gencat.cat/ca/generalitat/qui-som/historia-generalitat'), 'Compromís de Casp, 1412', 'Quan el Casal de Barcelona es va extingir el 1410, es va obrir un període d’incertesa política conegut com Interregne, que va acabar amb el Compromís de Casp de 1412.', null, '6822cd7544fc2dd646669e680eb062af66625c217574c6a17f9d9b535e38fdcc', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '6822cd7544fc2dd646669e680eb062af66625c217574c6a17f9d9b535e38fdcc')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Amb el Tractat dels Pirineus de 1659', false), ('B', 'Amb el Compromís de Casp de 1412', true), ('C', 'Amb la Capitulació de Pedralbes de 1472', false), ('D', 'Amb el Decret de Nova Planta de 1716', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local', 'guardia-urbana-barcelona');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'En quin any es va integrar voluntàriament la Val d''Aran al Principat, amb el compromís de contribuir econòmicament a la Diputació a canvi de protecció militar?', 'La Val d''Aran, territori de senyoria reial autònom, es va integrar al Principat el 1410.', 'cultcat_01_historia_catalunya', (select id from public.topics where slug = 'cultcat-01-historia-catalunya'), 3, 'ca', true, (select id from public.sources where url = 'https://web.gencat.cat/ca/generalitat/qui-som/historia-generalitat'), 'Val d''Aran, 1410', 'Un exemple és la integració voluntària de la Val d’Aran (un territori de senyoria reial autònom) al Principat el 1410', null, 'd646eb7dbcbf621eb2e5469fc4749ede16b2dc803635f36158078c6f9709fa06', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'd646eb7dbcbf621eb2e5469fc4749ede16b2dc803635f36158078c6f9709fa06')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', '1283', false), ('B', '1640', false), ('C', '1410', true), ('D', '1714', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local', 'guardia-urbana-barcelona');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'En què consistia la insaculació, el sistema introduït el 1455 per escollir els càrrecs de la Diputació?', 'La insaculació consistia a introduir en un sac els noms dels candidats, que eren escollits a l''atzar per una mà innocent; el 1455 es va combinar amb la cooptació.', 'cultcat_01_historia_catalunya', (select id from public.topics where slug = 'cultcat-01-historia-catalunya'), 3, 'ca', true, (select id from public.sources where url = 'https://web.gencat.cat/ca/generalitat/qui-som/historia-generalitat'), 'Insaculació, 1455', 'El 1455 es va introduir un sistema mixt que combinava la cooptació amb la insaculació (que consistia a introduir en un sac els noms dels candidats, que eren escollits al atzar per una ma innocent', null, '842f2ec8d969d496928dad3b8e2e9874dac3db4b71e7303a02c5cea7548c22ef', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '842f2ec8d969d496928dad3b8e2e9874dac3db4b71e7303a02c5cea7548c22ef')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'A posar en un sac els noms dels candidats i escollir-los a l''atzar', true), ('B', 'A escollir els càrrecs per votació secreta de tots els veïns', false), ('C', 'A nomenar directament els càrrecs per decisió del rei', false), ('D', 'A heretar el càrrec de pares a fills', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local', 'guardia-urbana-barcelona');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Amb quines paraules començava la Constitució de l''Observança, establerta per Ferran II a les Corts de Barcelona de 1481?', 'La Constitució de l''Observança (1481) obligava el rei i els seus oficials a respectar les lleis pactades.', 'cultcat_01_historia_catalunya', (select id from public.topics where slug = 'cultcat-01-historia-catalunya'), 3, 'ca', true, (select id from public.sources where url = 'https://web.gencat.cat/ca/generalitat/qui-som/historia-generalitat'), 'Constitució de l''Observança, 1481', 'establint la Constitució de l’Observança, que començava dient: "Poc valdria fer lleis i constitucions si no fossin respectades per nosaltres i els nostres oficials".', null, '90f66cd29759beccee429d7a6560128cd6db1c4d861001b6b611a6fdc443ad55', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '90f66cd29759beccee429d7a6560128cd6db1c4d861001b6b611a6fdc443ad55')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', '«Tots els homes neixen lliures i iguals...»', false), ('B', '«Poc valdria fer lleis i constitucions si no fossin respectades...»', true), ('C', '«Catalunya, Comtat gran...»', false), ('D', '«La sobirania resideix en el poble...»', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local', 'guardia-urbana-barcelona');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Amb quin país va signar la Diputació el pacte de Ceret, el 7 de setembre de 1640, per rebre suport militar?', 'Amb el pacte de Ceret (1640) la Diputació buscava el suport militar francès i separar-se de la Monarquia Hispànica.', 'cultcat_01_historia_catalunya', (select id from public.topics where slug = 'cultcat-01-historia-catalunya'), 2, 'ca', true, (select id from public.sources where url = 'https://web.gencat.cat/ca/generalitat/qui-som/historia-generalitat'), 'Pacte de Ceret, 1640', 'La Diputació va signar el pacte de Ceret amb França el 7 de setembre de 1640 per rebre suport militar', null, 'c2134ca34c34227557c3608c4d4dd54cd9b4e0d8ad405f4deb4a9220a37d10a5', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'c2134ca34c34227557c3608c4d4dd54cd9b4e0d8ad405f4deb4a9220a37d10a5')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Anglaterra', false), ('B', 'Portugal', false), ('C', 'Àustria', false), ('D', 'França', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local', 'guardia-urbana-barcelona');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Quin tractat de 1659 va sancionar l''annexió a França del Rosselló, el Conflent, el Vallespir i part de la Cerdanya?', 'El Tractat dels Pirineus (1659) va fixar la cessió a França dels comtats del nord.', 'cultcat_01_historia_catalunya', (select id from public.topics where slug = 'cultcat-01-historia-catalunya'), 2, 'ca', true, (select id from public.sources where url = 'https://web.gencat.cat/ca/generalitat/qui-som/historia-generalitat'), 'Tractat dels Pirineus, 1659', 'Finalment, el Tractat dels Pirineus de 1659 va sancionar l’annexió a França del Rosselló, el Conflent, el Vallespir i part de la Cerdanya.', null, '1a47d59bae6b0d8d935bae9a9a1cfc5ddec20f0d7a5fbfacd3dbdafcda50f693', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '1a47d59bae6b0d8d935bae9a9a1cfc5ddec20f0d7a5fbfacd3dbdafcda50f693')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El Tractat d''Utrecht', false), ('B', 'El Tractat de Versalles', false), ('C', 'El Tractat de Lisboa', false), ('D', 'El Tractat dels Pirineus', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local', 'guardia-urbana-barcelona');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Quin dia va tenir lloc l''assalt definitiu de Barcelona que va posar fi al setge de 1714?', 'El setge de Barcelona va començar a l''abril de 1714 i l''assalt definitiu va ser l''11 de setembre; Casanova en va sortir ferit.', 'cultcat_01_historia_catalunya', (select id from public.topics where slug = 'cultcat-01-historia-catalunya'), 1, 'ca', true, (select id from public.sources where url = 'https://web.gencat.cat/ca/generalitat/qui-som/historia-generalitat'), '11 de setembre de 1714', 'L’assalt definitiu de la ciutat va tenir lloc l’11 de setembre: Casanova va quedar ferit i Villarroel va cridar a la capitulació.', null, '057d91919dfbf0b69f587f19fa2d07b07d57dfd10d7268fb106ed818744bf9c2', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '057d91919dfbf0b69f587f19fa2d07b07d57dfd10d7268fb106ed818744bf9c2')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El 23 d''abril', false), ('B', 'L''11 de setembre', true), ('C', 'El 24 de juny', false), ('D', 'El 12 d''octubre', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local', 'guardia-urbana-barcelona');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Quina població va ser el darrer reducte de resistència, que va caure pocs dies després de Barcelona el 1714?', 'Després de la capitulació de Barcelona, el darrer reducte de resistència, Cardona, va caure pocs dies després.', 'cultcat_01_historia_catalunya', (select id from public.topics where slug = 'cultcat-01-historia-catalunya'), 3, 'ca', true, (select id from public.sources where url = 'https://web.gencat.cat/ca/generalitat/qui-som/historia-generalitat'), 'Darrer reducte, 1714', 'El darrer reducte de resistència, Cardona, va caure pocs dies després.', null, 'cd9ff38c05979c2374463c9eea00f80974b782598b46afee3b2b619f925f7091', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'cd9ff38c05979c2374463c9eea00f80974b782598b46afee3b2b619f925f7091')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Tortosa', false), ('B', 'Lleida', false), ('C', 'Cardona', true), ('D', 'Girona', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local', 'guardia-urbana-barcelona');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Quin rei va establir el règim de la Nova Planta, publicat a Catalunya el 16 de gener de 1716?', 'Amb el Decret de Nova Planta, Felip V va excloure la representació de la societat catalana i va reforçar les autoritats militars.', 'cultcat_01_historia_catalunya', (select id from public.topics where slug = 'cultcat-01-historia-catalunya'), 2, 'ca', true, (select id from public.sources where url = 'https://web.gencat.cat/ca/generalitat/qui-som/historia-generalitat'), 'Decret de Nova Planta, 1716', 'Amb el Decret de Nova Planta, publicat a Catalunya el 16 de gener de 1716, Felip V va establir un règim polític que excloïa la representació de la societat catalana', null, '1f15ad734f6d3cf074328e55ce4dc0ec6696d5407b69fd600c7e2dbdf9c4da4e', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '1f15ad734f6d3cf074328e55ce4dc0ec6696d5407b69fd600c7e2dbdf9c4da4e')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Felip V', true), ('B', 'Carles II', false), ('C', 'Ferran VII', false), ('D', 'Carles III', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local', 'guardia-urbana-barcelona');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Quina va ser la primera experiència d''autogovern català del segle XX, entre 1914 i 1925?', 'La Mancomunitat (1914-1925) va ser la primera experiència d''autogovern català contemporani.', 'cultcat_01_historia_catalunya', (select id from public.topics where slug = 'cultcat-01-historia-catalunya'), 2, 'ca', true, (select id from public.sources where url = 'https://web.gencat.cat/ca/generalitat/qui-som/historia-generalitat'), 'Mancomunitat', 'Hi ha un nexe que uneix els primers triomfs electorals del catalanisme polític el 1901-1907 amb la primera experiència d''autogovern català, la Mancomunitat de 1914-1925.', null, '1a82a1be4680e4055f1d02c5ac18e0f7725d7c340f875744d797ec8c1e57b611', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '1a82a1be4680e4055f1d02c5ac18e0f7725d7c340f875744d797ec8c1e57b611')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'La Generalitat republicana', false), ('B', 'La Diputació del General', false), ('C', 'El Consell de Cent', false), ('D', 'La Mancomunitat', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local', 'guardia-urbana-barcelona');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Qui va presidir la Generalitat de Catalunya constituïda amb caràcter provisional l''abril de 1931?', 'Després de les eleccions municipals d''abril de 1931 es va constituir la Generalitat provisional, presidida per Francesc Macià.', 'cultcat_01_historia_catalunya', (select id from public.topics where slug = 'cultcat-01-historia-catalunya'), 1, 'ca', true, (select id from public.sources where url = 'https://web.gencat.cat/ca/generalitat/qui-som/historia-generalitat'), 'Generalitat provisional, 1931', 'Arran dels esdeveniments d''abril de 1931 quedà constituïda, amb caràcter provisional, la Generalitat de Catalunya, presidida per Francesc Macià', null, '4bac5f9830e2620d5be6fdf60e919c5203fb895be9842940da7ef378d2d42b7f', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '4bac5f9830e2620d5be6fdf60e919c5203fb895be9842940da7ef378d2d42b7f')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Francesc Macià', true), ('B', 'Lluís Companys', false), ('C', 'Josep Tarradellas', false), ('D', 'Josep Irla', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local', 'guardia-urbana-barcelona');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Quan va ser elegit el Parlament de Catalunya per primera i única vegada dins l''etapa republicana?', 'L''Estatut de 1932 encarregava el desenvolupament institucional al nou Parlament, elegit el 20 de novembre de 1932.', 'cultcat_01_historia_catalunya', (select id from public.topics where slug = 'cultcat-01-historia-catalunya'), 3, 'ca', true, (select id from public.sources where url = 'https://web.gencat.cat/ca/generalitat/qui-som/historia-generalitat'), 'Primer Parlament, 1932', 'que fou elegit per primera i única vegada dins l''etapa republicana el 20 de novembre de 1932.', null, '25292c9c91a1e3b18cbc591119e516b1806f044ff4be4ed29c84c62e6032b921', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '25292c9c91a1e3b18cbc591119e516b1806f044ff4be4ed29c84c62e6032b921')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El 14 d''abril de 1931', false), ('B', 'El 6 d''octubre de 1934', false), ('C', 'El 20 de novembre de 1932', true), ('D', 'El 16 de febrer de 1936', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local', 'guardia-urbana-barcelona');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'On va ser afusellat el president Lluís Companys el 15 d''octubre de 1940?', 'Detingut a França pels nazis i lliurat a la policia franquista, Companys va ser jutjat en consell de guerra i afusellat a Montjuïc.', 'cultcat_01_historia_catalunya', (select id from public.topics where slug = 'cultcat-01-historia-catalunya'), 1, 'ca', true, (select id from public.sources where url = 'https://web.gencat.cat/ca/generalitat/qui-som/historia-generalitat'), 'Lluís Companys, 1940', 'el president de la Generalitat va ser jutjat en un consell de guerra sumaríssim i afusellat al castell de Montjuïc el dia 15 d''octubre de 1940.', null, 'c14de520f278abbf4153bdccb61c4b3301b66adff2f15fefa68e2da1b713665e', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'c14de520f278abbf4153bdccb61c4b3301b66adff2f15fefa68e2da1b713665e')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'A la Ciutadella', false), ('B', 'Al castell de Montjuïc', true), ('C', 'Al Camp de la Bota', false), ('D', 'A la presó Model', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local', 'guardia-urbana-barcelona');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Quin president de la Generalitat va ser reconegut el 1977 després de tornar d''un exili de quaranta anys?', 'El decret de 29 de setembre de 1977 va reconèixer Josep Tarradellas com a president de la Generalitat.', 'cultcat_01_historia_catalunya', (select id from public.topics where slug = 'cultcat-01-historia-catalunya'), 1, 'ca', true, (select id from public.sources where url = 'https://web.gencat.cat/ca/generalitat/qui-som/historia-generalitat'), 'Tarradellas, 1977', 'el decret de 29 de setembre de 1977 reconeixia com a president de la Generalitat Josep Tarradellas, l''única autoritat republicana que retornà d''un exili de quaranta anys', null, 'ea57c3d9ec30560276f6a145b3400089c298ff4ef7fcb17a99fa2e524bac084e', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'ea57c3d9ec30560276f6a145b3400089c298ff4ef7fcb17a99fa2e524bac084e')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Jordi Pujol', false), ('B', 'Josep Irla', false), ('C', 'Heribert Barrera', false), ('D', 'Josep Tarradellas', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local', 'guardia-urbana-barcelona');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'On es va reunir la Comissió dels Vint que va redactar l''avantprojecte de l''Estatut d''autonomia de 1979?', 'Per això l''Estatut de 1979 és conegut com a «Estatut de Sau»; va ser aprovat en referèndum el 25 d''octubre de 1979.', 'cultcat_01_historia_catalunya', (select id from public.topics where slug = 'cultcat-01-historia-catalunya'), 2, 'ca', true, (select id from public.sources where url = 'https://web.gencat.cat/ca/generalitat/qui-som/historia-generalitat'), 'Estatut de 1979', 'Aquesta, denominada Comissió dels Vint es reuní al parador de Sau', null, 'b18f4f04f1185408c628cc3b4b4d7cee64d505341ac9e172480b825fd622c2c8', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'b18f4f04f1185408c628cc3b4b4d7cee64d505341ac9e172480b825fd622c2c8')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Al parador de Sau', true), ('B', 'Al monestir de Montserrat', false), ('C', 'Al santuari de Núria', false), ('D', 'Al Palau de Pedralbes', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local', 'guardia-urbana-barcelona');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Quin número d''ordre té Salvador Illa com a president de la Generalitat, investit el 8 d''agost de 2024?', 'Salvador Illa va ser investit 133è president el 8 d''agost de 2024; Pujol va ser el 126è i Puigdemont el 130è.', 'cultcat_01_historia_catalunya', (select id from public.topics where slug = 'cultcat-01-historia-catalunya'), 1, 'ca', true, (select id from public.sources where url = 'https://web.gencat.cat/ca/generalitat/qui-som/historia-generalitat'), 'Presidents, 2024', 'Salvador Illa va ser investit 133è president de la Generalitat el 8 d’agost de 2024', null, 'b95d3fe32015474564cb8cab3c4aa0100e5d853fc51af779523de72a31871474', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'b95d3fe32015474564cb8cab3c4aa0100e5d853fc51af779523de72a31871474')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', '126è', false), ('B', '133è', true), ('C', '130è', false), ('D', '128è', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local', 'guardia-urbana-barcelona');
-- Lote cultcat-02-historia-espanya-mon-ddhc1789-v1 (1 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Déclaration des Droits de l''Homme et du Citoyen de 1789', 'https://www.conseil-constitutionnel.fr/le-bloc-de-constitutionnalite/declaration-des-droits-de-l-homme-et-du-citoyen-de-1789', 'web_oficial'::public.source_kind, 'Conseil constitutionnel (République française)', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('cultcat-02-historia-espanya-mon', 'Cultura general 2. Història d''Espanya i universal') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('policia-local', 'guardia-urbana-barcelona') and t.slug = 'cultcat-02-historia-espanya-mon' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Quin document, aprovat a França el 1789, comença el seu article 1 afirmant que els homes neixen i romanen lliures i iguals en drets?', 'La Declaració dels Drets de l''Home i del Ciutadà (1789), de la Revolució Francesa, forma part encara avui del bloc de constitucionalitat francès. La Declaració Universal és de l''ONU (1948).', 'cultcat_02_historia_espanya_mon', (select id from public.topics where slug = 'cultcat-02-historia-espanya-mon'), 1, 'ca', true, (select id from public.sources where url = 'https://www.conseil-constitutionnel.fr/le-bloc-de-constitutionnalite/declaration-des-droits-de-l-homme-et-du-citoyen-de-1789'), 'Declaració de Drets de l''Home i del Ciutadà, 1789', 'Déclaration des Droits de l''Homme et du Citoyen de 1789 […] Article 1er Les hommes naissent et demeurent libres et égaux en', null, '6e33fda9fabf6b3d130c79f97715ce4b4f09c5ffd2786b3566942d04d0e0a959', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '6e33fda9fabf6b3d130c79f97715ce4b4f09c5ffd2786b3566942d04d0e0a959')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'La Declaració d''Independència dels Estats Units', false), ('B', 'La Declaració Universal dels Drets Humans', false), ('C', 'La Declaració dels Drets de l''Home i del Ciutadà', true), ('D', 'La Carta Magna', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local', 'guardia-urbana-barcelona');
-- Lote cultcat-02-historia-espanya-mon-diec-v1 (1 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Diccionari de la llengua catalana, 2a edició (DIEC2), Institut d''Estudis Catalans', 'https://dlc.iec.cat/', 'web_oficial'::public.source_kind, 'Institut d''Estudis Catalans', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('cultcat-02-historia-espanya-mon', 'Cultura general 2. Història d''Espanya i universal') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('policia-local', 'guardia-urbana-barcelona') and t.slug = 'cultcat-02-historia-espanya-mon' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'En la història medieval catalana, què era la remença?', 'El pagès de remença havia de pagar al senyor per redimir-se i poder abandonar la terra; les guerres remences del segle XV en van reclamar l''abolició.', 'cultcat_02_historia_espanya_mon', (select id from public.topics where slug = 'cultcat-02-historia-espanya-mon'), 3, 'ca', true, (select id from public.sources where url = 'https://dlc.iec.cat/'), 'Remença', 'remença 2 f. [HIH] Dret que el senyor podia exigir del vassall subjecte a adscripció a la terra quan aquest volia abandonar-la.', null, 'd9017b368886ca0e5e236703f41284c9341c71321574a1298b4229a542aa648c', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'd9017b368886ca0e5e236703f41284c9341c71321574a1298b4229a542aa648c')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'L''impost que pagaven les ciutats al rei per celebrar Corts', false), ('B', 'El dret que el senyor podia exigir al vassall adscrit a la terra quan aquest la volia abandonar', true), ('C', 'El tribunal que jutjava els delictes dels nobles', false), ('D', 'La milícia formada pels gremis de Barcelona', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local', 'guardia-urbana-barcelona');
-- Lote cultcat-02-historia-espanya-mon-genhist-v1 (6 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Història de la Generalitat (Diputació del General, Nova Planta i Generalitat contemporània)', 'https://web.gencat.cat/ca/generalitat/qui-som/historia-generalitat', 'web_oficial'::public.source_kind, 'Generalitat de Catalunya', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('cultcat-02-historia-espanya-mon', 'Cultura general 2. Història d''Espanya i universal') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('policia-local', 'guardia-urbana-barcelona') and t.slug = 'cultcat-02-historia-espanya-mon' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Quin dia es va aprovar en referèndum la Constitució espanyola vigent?', 'Les Corts elegides el 15 de juny de 1977 van redactar la Constitució, aprovada en referèndum el 6 de desembre de 1978 (Dia de la Constitució).', 'cultcat_02_historia_espanya_mon', (select id from public.topics where slug = 'cultcat-02-historia-espanya-mon'), 1, 'ca', true, (select id from public.sources where url = 'https://web.gencat.cat/ca/generalitat/qui-som/historia-generalitat'), 'Constitució espanyola, referèndum', 'configuraren unes cambres que tingueren com a missió principal la redacció d''una constitució, que ser aprovada en referèndum el 6 de desembre de 1978.', null, '40e0e62a22a2d68f11def9e3385c960edc33dc862009ba6a2060942f39744b73', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '40e0e62a22a2d68f11def9e3385c960edc33dc862009ba6a2060942f39744b73')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El 15 de juny de 1977', false), ('B', 'El 20 de novembre de 1975', false), ('C', 'El 6 de desembre de 1978', true), ('D', 'El 25 d''octubre de 1979', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local', 'guardia-urbana-barcelona');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Quin fet va posar fi a la dictadura del general Franco?', 'El període de privació de la democràcia va durar fins a la mort de Franco, el 20 de novembre de 1975.', 'cultcat_02_historia_espanya_mon', (select id from public.topics where slug = 'cultcat-02-historia-espanya-mon'), 1, 'ca', true, (select id from public.sources where url = 'https://web.gencat.cat/ca/generalitat/qui-som/historia-generalitat'), 'Fi de la dictadura franquista', 'encetaren un període de privació de la democràcia i els drets nacionals catalans que havia de durar fins a la mort del dictador el 20 de novembre de 1975.', null, '21fb4e98f02dba1b2ed2e7f3da6645c73c209ac6c9c2571dc2e9faee3bfe58e1', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '21fb4e98f02dba1b2ed2e7f3da6645c73c209ac6c9c2571dc2e9faee3bfe58e1')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'La mort del dictador el 20 de novembre de 1975', true), ('B', 'La proclamació de la Segona República el 1931', false), ('C', 'L''aprovació de l''Estatut d''Autonomia el 1979', false), ('D', 'Les primeres eleccions municipals democràtiques el 1983', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local', 'guardia-urbana-barcelona');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Qui va ser nomenat president del Govern espanyol el 3 de juliol de 1976 i va impulsar la reforma política de la Transició?', 'Adolfo Suárez va ser nomenat president del Govern el 3 de juliol de 1976 i va avançar cap a la reforma democràtica.', 'cultcat_02_historia_espanya_mon', (select id from public.topics where slug = 'cultcat-02-historia-espanya-mon'), 2, 'ca', true, (select id from public.sources where url = 'https://web.gencat.cat/ca/generalitat/qui-som/historia-generalitat'), 'Transició, Adolfo Suárez', 'El 3 de juliol de 1976, fou nomenat president del govern Adolfo Suárez, que avançà de manera cada vegada més decidida cap a la reforma.', null, 'd7c5e83229c3452a6e308b4c5174fe1946d45eb38e91ef857f9888b114c79d94', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'd7c5e83229c3452a6e308b4c5174fe1946d45eb38e91ef857f9888b114c79d94')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Carlos Arias Navarro', false), ('B', 'Felipe González', false), ('C', 'Adolfo Suárez', true), ('D', 'Leopoldo Calvo-Sotelo', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local', 'guardia-urbana-barcelona');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Quan es van celebrar les primeres eleccions legislatives democràtiques a Espanya des de 1936?', 'Un cop legalitzats els partits, les eleccions del 15 de juny de 1977 van configurar unes Corts que van redactar la Constitució.', 'cultcat_02_historia_espanya_mon', (select id from public.topics where slug = 'cultcat-02-historia-espanya-mon'), 2, 'ca', true, (select id from public.sources where url = 'https://web.gencat.cat/ca/generalitat/qui-som/historia-generalitat'), 'Eleccions generals de 1977', 'les primeres eleccions legislatives espanyoles democràtiques des de 1936, celebrades el 15 de juny de 1977', null, '9826e2f1131398cbbeb3add0aee4a332c438213c44515a2ef613852c4fa6e3e7', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '9826e2f1131398cbbeb3add0aee4a332c438213c44515a2ef613852c4fa6e3e7')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El 15 de juny de 1977', true), ('B', 'El 20 de novembre de 1975', false), ('C', 'El 6 de desembre de 1978', false), ('D', 'El 20 de març de 1980', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local', 'guardia-urbana-barcelona');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Entre quins anys va durar la dictadura del general Primo de Rivera?', 'El segle XX espanyol va conèixer dues dictadures: la de Primo de Rivera (1923-1930) i la de Franco (1939-1975). 1914-1925 són les dates de la Mancomunitat de Catalunya.', 'cultcat_02_historia_espanya_mon', (select id from public.topics where slug = 'cultcat-02-historia-espanya-mon'), 2, 'ca', true, (select id from public.sources where url = 'https://web.gencat.cat/ca/generalitat/qui-som/historia-generalitat'), 'Dictadura de Primo de Rivera', 'la del general Primo de Rivera (1923-1930) i la del general Franco (1939-1975).', null, 'f054ccacae1d4369d4d0d46e7d7baf5d89b6709ba2fafb3816e51cdca2d0703b', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'f054ccacae1d4369d4d0d46e7d7baf5d89b6709ba2fafb3816e51cdca2d0703b')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', '1931-1936', false), ('B', '1939-1975', false), ('C', '1914-1925', false), ('D', '1923-1930', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local', 'guardia-urbana-barcelona');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Quin règim es va proclamar a Madrid l''abril de 1931, després de les eleccions municipals que van provocar la caiguda de la monarquia?', 'Arran de les eleccions municipals del 12 d''abril de 1931 va caure la monarquia; el dia 14 es va proclamar la Segona República (a Barcelona, poques hores abans, Macià havia proclamat la República catalana).', 'cultcat_02_historia_espanya_mon', (select id from public.topics where slug = 'cultcat-02-historia-espanya-mon'), 1, 'ca', true, (select id from public.sources where url = 'https://web.gencat.cat/ca/generalitat/qui-som/historia-generalitat'), 'Segona República, 1931', 'proclamà de manera unilateral «la República catalana com a Estat de la Federació Ibèrica» el dia 14, poques hores abans que a Madrid es procedís a proclamar la Segona República espanyola.', null, '3554dbc39849f0c9340f75bcf4247d8529b6757bf2311991a72e56ef6e1dbee8', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '3554dbc39849f0c9340f75bcf4247d8529b6757bf2311991a72e56ef6e1dbee8')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'La Primera República espanyola', false), ('B', 'La Segona República espanyola', true), ('C', 'La dictadura de Primo de Rivera', false), ('D', 'La monarquia parlamentària', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local', 'guardia-urbana-barcelona');
-- Lote cultcat-02-historia-espanya-mon-onu-v1 (2 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('United Nations: About Us, UN Charter, Main Bodies i Selection and Appointment of the Next Secretary-General', 'https://www.un.org/en/about-us', 'web_oficial'::public.source_kind, 'United Nations', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('cultcat-02-historia-espanya-mon', 'Cultura general 2. Història d''Espanya i universal') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('policia-local', 'guardia-urbana-barcelona') and t.slug = 'cultcat-02-historia-espanya-mon' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'En quin any es va fundar l''Organització de les Nacions Unides (ONU)?', 'L''ONU es va fundar el 1945, en acabar la Segona Guerra Mundial; avui en formen part 193 estats membres.', 'cultcat_02_historia_espanya_mon', (select id from public.topics where slug = 'cultcat-02-historia-espanya-mon'), 1, 'ca', true, (select id from public.sources where url = 'https://www.un.org/en/about-us'), 'ONU, fundació', 'The United Nations is an international organization founded in 1945.', null, '84501be3e117b34cba6a9bd4c439c958d9b4ef348aef47c3b6bdd84fdcb49799', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '84501be3e117b34cba6a9bd4c439c958d9b4ef348aef47c3b6bdd84fdcb49799')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', '1919', false), ('B', '1939', false), ('C', '1957', false), ('D', '1945', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local', 'guardia-urbana-barcelona');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'En quina ciutat es va signar, el 26 de juny de 1945, la Carta de les Nacions Unides?', 'La Carta, document fundacional de l''ONU, es va signar a San Francisco el 26 de juny de 1945 i va entrar en vigor el 24 d''octubre de 1945 (Dia de les Nacions Unides).', 'cultcat_02_historia_espanya_mon', (select id from public.topics where slug = 'cultcat-02-historia-espanya-mon'), 2, 'ca', true, (select id from public.sources where url = 'https://www.un.org/en/about-us'), 'Carta de les Nacions Unides, signatura', 'It was signed on 26 June 1945, in San Francisco, at the conclusion of the United Nations Conference on International Organization, and came into force on 24 October 1945.', null, '719157419f6da57aaa4f4af5bad360667e7d86d2e7eabd4684d84379c7aebbcf', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '719157419f6da57aaa4f4af5bad360667e7d86d2e7eabd4684d84379c7aebbcf')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Nova York', false), ('B', 'San Francisco', true), ('C', 'Ginebra', false), ('D', 'Londres', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local', 'guardia-urbana-barcelona');
-- Lote cultcat-02-historia-espanya-mon-ue-v1 (7 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Portal oficial de la Unión Europea: países, historia, euro e instituciones', 'https://european-union.europa.eu/index_es', 'web_oficial'::public.source_kind, 'Unión Europea', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('cultcat-02-historia-espanya-mon', 'Cultura general 2. Història d''Espanya i universal') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('policia-local', 'guardia-urbana-barcelona') and t.slug = 'cultcat-02-historia-espanya-mon' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Quan es va crear l''Organització del Tractat de l''Atlàntic Nord (OTAN)?', 'L''OTAN es va crear el 4 d''abril de 1949 com a aliança de seguretat entre els Estats Units, el Canadà i deu països de l''Europa occidental.', 'cultcat_02_historia_espanya_mon', (select id from public.topics where slug = 'cultcat-02-historia-espanya-mon'), 2, 'ca', true, (select id from public.sources where url = 'https://european-union.europa.eu/index_es'), 'OTAN, 1949', '4 de abril de 1949 — Creación de la OTAN Se crea la Organización del Tratado del Atlántico Norte (OTAN), una alianza intergubernamental de seguridad entre los Estados Unidos, Canadá y diez países de Europa Occidental.', null, '5c9d2564606e9730460b7e8d61f504799e3c09a1dd66883581e35ef33f508e57', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '5c9d2564606e9730460b7e8d61f504799e3c09a1dd66883581e35ef33f508e57')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El 4 d''abril de 1949', true), ('B', 'El 8 de maig de 1945', false), ('C', 'El 25 de març de 1957', false), ('D', 'El 9 de novembre de 1989', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local', 'guardia-urbana-barcelona');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Quina organització, fundada el 1951, es considera el primer pas de la integració europea per garantir una pau duradora?', 'La CECA (1951) va ser el primer pas; el 1957 el Tractat de Roma va crear la CEE.', 'cultcat_02_historia_espanya_mon', (select id from public.topics where slug = 'cultcat-02-historia-espanya-mon'), 2, 'ca', true, (select id from public.sources where url = 'https://european-union.europa.eu/index_es'), 'CECA, 1951', 'La Comunidad Europea del Carbón y del Acero, fundada en 1951, fue el primer paso para garantizar una paz duradera.', null, 'c2d961ee51b1cf50d1e47416b70924ae8e58962dc30d3c9260a78edc045c99fe', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'c2d961ee51b1cf50d1e47416b70924ae8e58962dc30d3c9260a78edc045c99fe')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'La Comunitat Econòmica Europea (CEE)', false), ('B', 'El Consell d''Europa', false), ('C', 'L''Organització del Tractat de l''Atlàntic Nord (OTAN)', false), ('D', 'La Comunitat Europea del Carbó i de l''Acer (CECA)', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local', 'guardia-urbana-barcelona');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Quin tractat de 1957 va establir la Comunitat Econòmica Europea (CEE)?', 'El Tractat de Roma (1957) va crear la CEE; el de Maastricht (1992) va crear la Unió Europea.', 'cultcat_02_historia_espanya_mon', (select id from public.topics where slug = 'cultcat-02-historia-espanya-mon'), 1, 'ca', true, (select id from public.sources where url = 'https://european-union.europa.eu/index_es'), 'Tractat de Roma, 1957', 'En 1957, el Tratado de Roma establece la Comunidad Económica Europea (CEE)', null, 'a3770219c663824b07db99569ad3e63cb6998f5a8a0b3b9cac29dd8884e5cc00', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'a3770219c663824b07db99569ad3e63cb6998f5a8a0b3b9cac29dd8884e5cc00')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El Tractat de Maastricht', false), ('B', 'El Tractat de Lisboa', false), ('C', 'El Tractat de Roma', true), ('D', 'El Tractat de Versalles', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local', 'guardia-urbana-barcelona');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'En quin any es van incorporar Espanya i Portugal a les Comunitats Europees?', 'Grècia hi va entrar el 1981 i, cinc anys més tard, el 1986, Espanya i Portugal.', 'cultcat_02_historia_espanya_mon', (select id from public.topics where slug = 'cultcat-02-historia-espanya-mon'), 2, 'ca', true, (select id from public.sources where url = 'https://european-union.europa.eu/index_es'), 'Adhesió d''Espanya, 1986', 'En 1981, Grecia pasa a ser el décimo miembro de las Comunidades Europeas, seguida cinco años más tarde por España y Portugal.', null, '7db0276efcf123eae93782a6ca8add0723dd5459c8139fd13806713a9e4d53de', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '7db0276efcf123eae93782a6ca8add0723dd5459c8139fd13806713a9e4d53de')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', '1981', false), ('B', '1986', true), ('C', '1992', false), ('D', '1995', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local', 'guardia-urbana-barcelona');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Quin país va esdevenir el desè membre de les Comunitats Europees l''any 1981?', 'Grècia hi va entrar el 1981; Dinamarca, Irlanda i el Regne Unit ho havien fet el 1973, i Portugal el 1986.', 'cultcat_02_historia_espanya_mon', (select id from public.topics where slug = 'cultcat-02-historia-espanya-mon'), 3, 'ca', true, (select id from public.sources where url = 'https://european-union.europa.eu/index_es'), 'Adhesió de Grècia, 1981', 'En 1981, Grecia pasa a ser el décimo miembro de las Comunidades Europeas', null, 'fbfe5b624281b9a3657c87259fcbb3a73bbef250ea9e931afb7b5d97f19bf07b', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'fbfe5b624281b9a3657c87259fcbb3a73bbef250ea9e931afb7b5d97f19bf07b')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Irlanda', false), ('B', 'Portugal', false), ('C', 'Grècia', true), ('D', 'Dinamarca', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local', 'guardia-urbana-barcelona');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Contra quins edificis es van estavellar avions segrestats en els atemptats de l''11 de setembre de 2001?', 'Els atemptats del 2001 van causar unes 3.000 morts a Nova York i Washington.', 'cultcat_02_historia_espanya_mon', (select id from public.topics where slug = 'cultcat-02-historia-espanya-mon'), 2, 'ca', true, (select id from public.sources where url = 'https://european-union.europa.eu/index_es'), 'Atemptats de l''11 de setembre de 2001', 'Varios aviones son secuestrados y estrellados contra las torres gemelas del World Trade Center, en Nueva York, y el Pentágono, en Washington. Mueren alrededor de 3 000 personas.', null, '271698eb5039774e3fbd51c02ca93cba3825bf1e77526c1e63c63d179d930151', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '271698eb5039774e3fbd51c02ca93cba3825bf1e77526c1e63c63d179d930151')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Les Torres Bessones del World Trade Center (Nova York) i el Pentàgon (Washington)', true), ('B', 'La Casa Blanca i el Capitoli (Washington)', false), ('C', 'L''Empire State Building i la seu de l''ONU (Nova York)', false), ('D', 'El Pentàgon i la seu de l''OTAN (Brussel·les)', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local', 'guardia-urbana-barcelona');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Qui va dirigir la vaga dels treballadors de les drassanes de Gdańsk (Polònia) que reclamaven més drets, al final de la Guerra Freda?', 'Els treballadors de les drassanes de Gdańsk, dirigits per Lech Wałęsa, van fer vaga per reclamar més drets; poc després van caure els règims comunistes de l''Europa central i de l''Est.', 'cultcat_02_historia_espanya_mon', (select id from public.topics where slug = 'cultcat-02-historia-espanya-mon'), 3, 'ca', true, (select id from public.sources where url = 'https://european-union.europa.eu/index_es'), 'Solidaritat, Gdańsk', 'Los trabajadores de los astilleros de la ciudad polaca de Gdansk, dirigidos por Lech Walesa, entran en huelga para reclamar más derechos.', null, '9822fe69d42d6fc0226019dcc6b825e617887887c8c6ab7fe6e5e8ec17e33ba0', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '9822fe69d42d6fc0226019dcc6b825e617887887c8c6ab7fe6e5e8ec17e33ba0')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Václav Havel', false), ('B', 'Lech Wałęsa', true), ('C', 'Mikhaïl Gorbatxov', false), ('D', 'Karol Wojtyła', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local', 'guardia-urbana-barcelona');
-- Lote cultcat-02-historia-espanya-mon-unesco-v1 (3 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('World Heritage List (fitxes dels béns inscrits), UNESCO World Heritage Centre', 'https://whc.unesco.org/en/list/', 'web_oficial'::public.source_kind, 'UNESCO World Heritage Centre', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('cultcat-02-historia-espanya-mon', 'Cultura general 2. Història d''Espanya i universal') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('policia-local', 'guardia-urbana-barcelona') and t.slug = 'cultcat-02-historia-espanya-mon' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Quin camp de concentració i extermini nazi, el més gran del Tercer Reich, és patrimoni mundial de la UNESCO des de 1979?', 'Segons la UNESCO, a Auschwitz-Birkenau (1940-1945) hi van ser assassinades 1,5 milions de persones, moltes d''elles jueves.', 'cultcat_02_historia_espanya_mon', (select id from public.topics where slug = 'cultcat-02-historia-espanya-mon'), 2, 'ca', true, (select id from public.sources where url = 'https://whc.unesco.org/en/list/'), 'Auschwitz-Birkenau', 'Auschwitz Birkenau German Nazi Concentration and Extermination Camp (1940-1945) (Date of Inscription: 1979).', null, '47bcc5c79b0b786561cb926710bc835659f4f094148f8a7f5f79d6e2a7422ca9', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '47bcc5c79b0b786561cb926710bc835659f4f094148f8a7f5f79d6e2a7422ca9')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Dachau', false), ('B', 'Mauthausen', false), ('C', 'Buchenwald', false), ('D', 'Auschwitz-Birkenau', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local', 'guardia-urbana-barcelona');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Quina ciutat romana, fundada el 25 aC amb el nom d''Augusta Emerita, va ser la capital de la Lusitània?', 'Augusta Emerita (avui Mèrida, Extremadura) va ser fundada el 25 aC i va ser capital de la Lusitània; Tàrraco (Tarragona) ho era de la Tarraconense.', 'cultcat_02_historia_espanya_mon', (select id from public.topics where slug = 'cultcat-02-historia-espanya-mon'), 3, 'ca', true, (select id from public.sources where url = 'https://whc.unesco.org/en/list/'), 'Mèrida, Augusta Emerita', 'The colony of Augusta Emerita, which became present-day Mérida in Estremadura, was founded in 25 B.C. at the end of the Spanish Campaign and was the capital of Lusitania.', null, '632b4b8d7bc630d6704d270ebcec7d5fec4ad5f1be973b27d18306931321f2a6', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '632b4b8d7bc630d6704d270ebcec7d5fec4ad5f1be973b27d18306931321f2a6')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Mèrida', true), ('B', 'Tarragona', false), ('C', 'Lisboa', false), ('D', 'Segòvia', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local', 'guardia-urbana-barcelona');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Sota quin emperador es van unir, cap al 220 aC, diversos trams de fortificacions per formar la Gran Muralla xinesa?', 'Cap al 220 aC, Qin Shi Huang va unir fortificacions anteriors; la construcció va continuar fins a la dinastia Ming (1368-1644).', 'cultcat_02_historia_espanya_mon', (select id from public.topics where slug = 'cultcat-02-historia-espanya-mon'), 3, 'ca', true, (select id from public.sources where url = 'https://whc.unesco.org/en/list/'), 'Gran Muralla xinesa', 'In c. 220 B.C., under Qin Shi Huang, sections of earlier fortifications were joined together to form a united defence system against invasions from the north.', null, '19a9470e5e57f633f5ad56960d97a881f3b679abc619bad52f3df362cf61e4a6', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '19a9470e5e57f633f5ad56960d97a881f3b679abc619bad52f3df362cf61e4a6')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Gengis Khan', false), ('B', 'Kublai Khan', false), ('C', 'L''emperador Hongwu, de la dinastia Ming', false), ('D', 'Qin Shi Huang', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local', 'guardia-urbana-barcelona');
-- Lote cultcat-03-geografia-diec-v1 (5 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Diccionari de la llengua catalana, 2a edició (DIEC2), Institut d''Estudis Catalans', 'https://dlc.iec.cat/', 'web_oficial'::public.source_kind, 'Institut d''Estudis Catalans', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('cultcat-03-geografia', 'Cultura general 3. Geografia de Catalunya, d''Espanya i del món') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('policia-local', 'guardia-urbana-barcelona') and t.slug = 'cultcat-03-geografia' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Com s''anomena el cercle màxim de l''esfera terrestre tots els punts del qual són a la mateixa distància dels dos pols?', 'L''equador divideix la Terra en els hemisferis nord i sud; la latitud es mesura a partir d''ell.', 'cultcat_03_geografia', (select id from public.topics where slug = 'cultcat-03-geografia'), 1, 'ca', true, (select id from public.sources where url = 'https://dlc.iec.cat/'), 'Equador', 'equador 2 m. [FIA] [GG] [LC] Cercle màxim de l’esfera terrestre tots els punts del qual equidisten dels dos pols.', null, '97c2acc0e35bf6040b89b8d48d84454062fe88a75d65858fc8b016ef6c267198', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '97c2acc0e35bf6040b89b8d48d84454062fe88a75d65858fc8b016ef6c267198')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Meridià', false), ('B', 'Tròpic de Càncer', false), ('C', 'Equador', true), ('D', 'Cercle polar àrtic', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local', 'guardia-urbana-barcelona');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Per on passa el primer meridià, origen de les longituds geogràfiques (0°)?', 'El primer meridià, adoptat com a origen de les longituds, és el que passa per l''observatori anglès de Greenwich.', 'cultcat_03_geografia', (select id from public.topics where slug = 'cultcat-03-geografia'), 1, 'ca', true, (select id from public.sources where url = 'https://dlc.iec.cat/'), 'Primer meridià', 'primer meridià Meridià que passa per l’observatori anglès de Greenwich, adoptat actualment com a origen de les longituds geogràfiques', null, 'f6e655e13ec1fe7243eb51cb28ec71d6ea87e0a7110f257ea42d3f522077560f', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'f6e655e13ec1fe7243eb51cb28ec71d6ea87e0a7110f257ea42d3f522077560f')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Per l''observatori de Greenwich (Anglaterra)', true), ('B', 'Per l''observatori de París', false), ('C', 'Per l''equador', false), ('D', 'Per l''illa de Hierro (Canàries)', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local', 'guardia-urbana-barcelona');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Com s''anomena la formació sedimentària que diposita un riu en desembocar al mar o en un llac, com la de l''Ebre?', 'El delta és una formació sedimentària a la desembocadura; l''estuari, en canvi, és una embocadura àmplia afectada per les marees.', 'cultcat_03_geografia', (select id from public.topics where slug = 'cultcat-03-geografia'), 1, 'ca', true, (select id from public.sources where url = 'https://dlc.iec.cat/'), 'Delta', 'delta 1 m. [GG] [GL] [LC] Formació sedimentària dipositada per un riu en el desguàs a la mar o en un llac', null, '8a5ecc091c6cfa73ca338f223e9f2a6240de1f196c75da0495c50f3e00551dfe', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '8a5ecc091c6cfa73ca338f223e9f2a6240de1f196c75da0495c50f3e00551dfe')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Estuari', false), ('B', 'Meandre', false), ('C', 'Delta', true), ('D', 'Albufera', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local', 'guardia-urbana-barcelona');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Què és la latitud d''un lloc?', 'La latitud es mesura des de l''equador cap al nord o cap al sud; la distància respecte del meridià de Greenwich és la longitud.', 'cultcat_03_geografia', (select id from public.topics where slug = 'cultcat-03-geografia'), 2, 'ca', true, (select id from public.sources where url = 'https://dlc.iec.cat/'), 'Latitud', 'latitud 2 1 f. [GG] Distància d’un lloc a l’equador mesurada per l’arc de meridià que va des del dit lloc a l’equador.', null, 'fd847ef8627a7146ab7abee3f7582960dc20c949683be5aa2e0b13f0a0ecf1b6', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'fd847ef8627a7146ab7abee3f7582960dc20c949683be5aa2e0b13f0a0ecf1b6')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'La distància del lloc al meridià de Greenwich, mesurada sobre el paral·lel', false), ('B', 'La distància del lloc a l''equador, mesurada per l''arc de meridià', true), ('C', 'L''altura del lloc sobre el nivell del mar', false), ('D', 'L''angle que forma l''eix de la Terra amb el pla de l''òrbita', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local', 'guardia-urbana-barcelona');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Com s''anomena l''embocadura àmplia d''un riu afectada per les marees?', 'L''estuari és una desembocadura oberta on entra la marea; el delta, en canvi, és una acumulació de sediments.', 'cultcat_03_geografia', (select id from public.topics where slug = 'cultcat-03-geografia'), 2, 'ca', true, (select id from public.sources where url = 'https://dlc.iec.cat/'), 'Estuari', 'estuari m. [GG] [LC] Embocadura àmplia d’un riu afectada per les marees.', null, '3f1a74fcf79518e1ab3736c74bce5541d89dba10e71584cabd11d44fd377a09f', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '3f1a74fcf79518e1ab3736c74bce5541d89dba10e71584cabd11d44fd377a09f')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Delta', false), ('B', 'Meandre', false), ('C', 'Estuari', true), ('D', 'Afluent', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local', 'guardia-urbana-barcelona');
-- Lote cultcat-03-geografia-idescat-v1 (12 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Anuari estadístic de Catalunya i El municipi en xifres (Institut d''Estadística de Catalunya)', 'https://www.idescat.cat/indicadors/?id=aec&lang=ca', 'web_oficial'::public.source_kind, 'Institut d''Estadística de Catalunya (Idescat)', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('cultcat-03-geografia', 'Cultura general 3. Geografia de Catalunya, d''Espanya i del món') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('policia-local', 'guardia-urbana-barcelona') and t.slug = 'cultcat-03-geografia' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Quin és el cim més alt de Catalunya, amb 3.143 metres, situat entre el Pallars Sobirà i França?', 'Segons l''Anuari estadístic de Catalunya, la Pica d''Estats (3.143 m) és el cim principal dels Pirineus catalans; el Puigmal fa 2.909 m.', 'cultcat_03_geografia', (select id from public.topics where slug = 'cultcat-03-geografia'), 1, 'ca', true, (select id from public.sources where url = 'https://www.idescat.cat/indicadors/?id=aec&lang=ca'), 'Cim més alt de Catalunya', 'Pica d''Estats 3.143 Pallars Sobirà/França', null, '096e5e7653f7481bdf067b53463e925aa7ae6470f9de2c496501673b20eca3fa', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '096e5e7653f7481bdf067b53463e925aa7ae6470f9de2c496501673b20eca3fa')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El Puigmal', false), ('B', 'El Pedraforca', false), ('C', 'El Turó de l''Home', false), ('D', 'La Pica d''Estats', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local', 'guardia-urbana-barcelona');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Quina és la capital de la comarca del Vallès Occidental?', 'El Vallès Occidental té una capitalitat compartida entre Sabadell i Terrassa; Granollers és la capital del Vallès Oriental.', 'cultcat_03_geografia', (select id from public.topics where slug = 'cultcat-03-geografia'), 1, 'ca', true, (select id from public.sources where url = 'https://www.idescat.cat/indicadors/?id=aec&lang=ca'), 'Vallès Occidental, capital', 'Vallès Occidental Sabadell i Terrassa Barcelona 23 970.228 Vallès Oriental Granollers', null, '2eb02ec1b486eda6be298461dcac9bef0617bb242ea75e9599abaa00ded62799', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '2eb02ec1b486eda6be298461dcac9bef0617bb242ea75e9599abaa00ded62799')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Granollers', false), ('B', 'Sabadell i Terrassa (capitalitat compartida)', true), ('C', 'Sant Cugat del Vallès', false), ('D', 'Rubí', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local', 'guardia-urbana-barcelona');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Quants municipis té Catalunya segons l''Anuari estadístic d''Idescat (2025)?', 'Catalunya té 947 municipis, agrupats en comarques i l''Aran.', 'cultcat_03_geografia', (select id from public.topics where slug = 'cultcat-03-geografia'), 2, 'ca', true, (select id from public.sources where url = 'https://www.idescat.cat/indicadors/?id=aec&lang=ca'), 'Nombre de municipis de Catalunya', 'Catalunya 947 8.124.126', null, '8add6450cfff216167b356f4732740bdf23fc9a70841fb5a9eaed6691c41c5ee', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '8add6450cfff216167b356f4732740bdf23fc9a70841fb5a9eaed6691c41c5ee')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', '311', false), ('B', '947', true), ('C', '1.024', false), ('D', '42', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local', 'guardia-urbana-barcelona');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Quin d''aquests rius de les conques internes de Catalunya és el més llarg?', 'Segons Idescat, el Ter fa 208 km i el Llobregat 170 km, tot i que la conca del Llobregat és més extensa.', 'cultcat_03_geografia', (select id from public.topics where slug = 'cultcat-03-geografia'), 2, 'ca', true, (select id from public.sources where url = 'https://www.idescat.cat/indicadors/?id=aec&lang=ca'), 'Rius de les conques internes', 'Muga 65 854 Castelló d''Empúries 51,9 Fluvià 97 1.125 Esponellà 144,5 Ter 208 3.010 Masies de Roda 403,0 […] Llobregat 170 4.948', null, '1b9c8976940b22638856a77736663b4e73268822a1b2cc30af6ed78a0be67d4c', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '1b9c8976940b22638856a77736663b4e73268822a1b2cc30af6ed78a0be67d4c')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El Llobregat (170 km)', false), ('B', 'El Fluvià (97 km)', false), ('C', 'La Muga (65 km)', false), ('D', 'El Ter (208 km)', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local', 'guardia-urbana-barcelona');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'A quina comarca és el Pedraforca (2.506 m)?', 'El Pedraforca és al Berguedà; el Puigmal, entre el Ripollès i França.', 'cultcat_03_geografia', (select id from public.topics where slug = 'cultcat-03-geografia'), 2, 'ca', true, (select id from public.sources where url = 'https://www.idescat.cat/indicadors/?id=aec&lang=ca'), 'Pedraforca', 'Pedraforca 2.506 Berguedà', null, '55908dc699bd2eae2cf5ddffc8ee0ed1dd614e74f91afa3334ff6c8d67ff9f00', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '55908dc699bd2eae2cf5ddffc8ee0ed1dd614e74f91afa3334ff6c8d67ff9f00')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Ripollès', false), ('B', 'Cerdanya', false), ('C', 'Berguedà', true), ('D', 'Solsonès', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local', 'guardia-urbana-barcelona');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'A quin massís de la Serralada Prelitoral pertany el Turó de l''Home (1.706 m)?', 'El Turó de l''Home, al Vallès Oriental, és el cim principal del Montseny.', 'cultcat_03_geografia', (select id from public.topics where slug = 'cultcat-03-geografia'), 2, 'ca', true, (select id from public.sources where url = 'https://www.idescat.cat/indicadors/?id=aec&lang=ca'), 'Turó de l''Home', 'Prelitoral Turó de l''Home 1.706 Montseny Vallès Oriental', null, 'd32d9f3f1e6f21baedba6490cd1a2ef3d326082ddcdae258d0a89c4f43fdfe1d', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'd32d9f3f1e6f21baedba6490cd1a2ef3d326082ddcdae258d0a89c4f43fdfe1d')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Montserrat', false), ('B', 'Montsant', false), ('C', 'Collserola', false), ('D', 'Montseny', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local', 'guardia-urbana-barcelona');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Quina és la capital de l''Aran?', 'Vielha e Mijaran és la capital de l''Aran, que té 9 municipis; Sort és la capital del Pallars Sobirà.', 'cultcat_03_geografia', (select id from public.topics where slug = 'cultcat-03-geografia'), 2, 'ca', true, (select id from public.sources where url = 'https://www.idescat.cat/indicadors/?id=aec&lang=ca'), 'Aran, capital', 'Aran Vielha e Mijaran Lleida 9 10.651', null, 'b892137f0004302b2b4a1eb814d71b1b12dde60f7218144a943ad11fb40bf871', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'b892137f0004302b2b4a1eb814d71b1b12dde60f7218144a943ad11fb40bf871')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Vielha e Mijaran', true), ('B', 'Bossòst', false), ('C', 'Sort', false), ('D', 'El Pont de Suert', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local', 'guardia-urbana-barcelona');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Quina comarca es va crear per la Llei 7/2023, que també va modificar el territori d''Osona?', 'El Lluçanès (capital, Prats de Lluçanès) és la comarca més recent; el Moianès es va crear el 2015.', 'cultcat_03_geografia', (select id from public.topics where slug = 'cultcat-03-geografia'), 2, 'ca', true, (select id from public.sources where url = 'https://www.idescat.cat/indicadors/?id=aec&lang=ca'), 'Comarca del Lluçanès', 'Llei 7/2023, de creació de la comarca del Lluçanès, que també modifica territorialment Osona', null, '8d5472db0df04a8a155a102c4013fce0516c570664ad7da16817ffb4be995ba8', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '8d5472db0df04a8a155a102c4013fce0516c570664ad7da16817ffb4be995ba8')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El Moianès', false), ('B', 'El Lluçanès', true), ('C', 'El Bages', false), ('D', 'La Garrotxa', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local', 'guardia-urbana-barcelona');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Quin percentatge aproximat de la població d''Espanya viu a Catalunya, segons les dades provisionals d''Idescat a 1 de gener de 2026?', 'Catalunya tenia 8.210.710 habitants (provisional) a 1 de gener de 2026, el 16,6% dels 49.570.725 d''Espanya.', 'cultcat_03_geografia', (select id from public.topics where slug = 'cultcat-03-geografia'), 3, 'ca', true, (select id from public.sources where url = 'https://www.idescat.cat/indicadors/?id=aec&lang=ca'), 'Població de Catalunya, 2026', '2026 (p) 6.017.087 839.692 464.600 889.331 8.210.710 49.570.725 16,6', null, 'fc19a9405a4bb6fadc80126b6809573dff0974adca8c26358d576929122e000c', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'fc19a9405a4bb6fadc80126b6809573dff0974adca8c26358d576929122e000c')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Un 10,2%', false), ('B', 'Un 16,6%', true), ('C', 'Un 22,4%', false), ('D', 'Un 30,1%', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local', 'guardia-urbana-barcelona');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Quants municipis té la comarca del Barcelonès?', 'El Barcelonès té 5 municipis i uns 2,4 milions d''habitants.', 'cultcat_03_geografia', (select id from public.topics where slug = 'cultcat-03-geografia'), 3, 'ca', true, (select id from public.sources where url = 'https://www.idescat.cat/indicadors/?id=aec&lang=ca'), 'Barcelonès, municipis', 'Barcelonès Barcelona Barcelona 5 2.398.280', null, 'bf8023f2927a023bbfbb032dc22945ac4e574e3599ff4ae73cf41f493547d406', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'bf8023f2927a023bbfbb032dc22945ac4e574e3599ff4ae73cf41f493547d406')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', '5', true), ('B', '11', false), ('C', '23', false), ('D', '36', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local', 'guardia-urbana-barcelona');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Quina és la capital de l''Alta Ribagorça, la comarca on hi ha les esglésies romàniques de la Vall de Boí?', 'El Pont de Suert és la capital de l''Alta Ribagorça, comarca de 3 municipis.', 'cultcat_03_geografia', (select id from public.topics where slug = 'cultcat-03-geografia'), 3, 'ca', true, (select id from public.sources where url = 'https://www.idescat.cat/indicadors/?id=aec&lang=ca'), 'Alta Ribagorça, capital', 'Alta Ribagorça Pont de Suert, el Lleida 3 4.051', null, '0d5f3644b56d1a5e9659dac15961588196c6a469faf11e81dc6ba91ba56acb3d', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '0d5f3644b56d1a5e9659dac15961588196c6a469faf11e81dc6ba91ba56acb3d')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Sort', false), ('B', 'Tremp', false), ('C', 'El Pont de Suert', true), ('D', 'Vielha', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local', 'guardia-urbana-barcelona');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Quina superfície aproximada té el municipi de Barcelona segons El municipi en xifres d''Idescat?', 'Barcelona té 101,35 km² i 1.713.247 habitants (2025), amb una densitat de 16.904 hab./km².', 'cultcat_03_geografia', (select id from public.topics where slug = 'cultcat-03-geografia'), 3, 'ca', true, (select id from public.sources where url = 'https://www.idescat.cat/indicadors/?id=aec&lang=ca'), 'Barcelona, superfície i població', 'Barcelona Codi 080193 Comarca Barcelonès Població (2025) 1.713.247 Superfície (km²) 101,35 Densitat (hab./km²) 16.904,3', null, '98935fb23a6f6ef2850f10e9354a480d0a7d02e6bd30eb31b7c5a67d5cd5ae27', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '98935fb23a6f6ef2850f10e9354a480d0a7d02e6bd30eb31b7c5a67d5cd5ae27')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Uns 36 km²', false), ('B', 'Uns 250 km²', false), ('C', 'Uns 636 km²', false), ('D', 'Uns 101 km²', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local', 'guardia-urbana-barcelona');
-- Lote cultcat-03-geografia-uepaisos-v1 (3 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Países de la UE: fichas de país (european-union.europa.eu/principles-countries-history/eu-countries/<país>_es)', 'https://european-union.europa.eu/principles-countries-history/eu-countries_es', 'web_oficial'::public.source_kind, 'Unión Europea', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('cultcat-03-geografia', 'Cultura general 3. Geografia de Catalunya, d''Espanya i del món') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('policia-local', 'guardia-urbana-barcelona') and t.slug = 'cultcat-03-geografia' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Quina és la capital de Portugal?', 'Lisboa és la capital de Portugal, estat membre de la UE des de 1986.', 'cultcat_03_geografia', (select id from public.topics where slug = 'cultcat-03-geografia'), 1, 'ca', true, (select id from public.sources where url = 'https://european-union.europa.eu/principles-countries-history/eu-countries_es'), 'Capital de Portugal', '[Portugal] Capital: Lisboa', null, '32f23772028e61aca2cebcdedb3d876ed7c19c524713784b9499a11e5bf9980b', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '32f23772028e61aca2cebcdedb3d876ed7c19c524713784b9499a11e5bf9980b')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Lisboa', true), ('B', 'Porto', false), ('C', 'Coïmbra', false), ('D', 'Braga', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local', 'guardia-urbana-barcelona');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Quina és la capital dels Països Baixos?', 'La capital és Amsterdam; la Haia és la seu del Parlament i del Govern. Brussel·les és la capital de Bèlgica.', 'cultcat_03_geografia', (select id from public.topics where slug = 'cultcat-03-geografia'), 2, 'ca', true, (select id from public.sources where url = 'https://european-union.europa.eu/principles-countries-history/eu-countries_es'), 'Països Baixos, capital', '[Países Bajos] Capital: Ámsterdam. El Parlamento y el Gobierno tienen su sede en La Haya', null, 'd3170730e2dcaf55cadd1073de470b4aa68935f07e66f3be4019409e8d216aa2', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'd3170730e2dcaf55cadd1073de470b4aa68935f07e66f3be4019409e8d216aa2')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Amsterdam, tot i que el Parlament i el Govern tenen la seu a la Haia', true), ('B', 'La Haia, on hi ha també el Parlament', false), ('C', 'Rotterdam', false), ('D', 'Brussel·les', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local', 'guardia-urbana-barcelona');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Quina és l''extensió aproximada d''Espanya segons la fitxa oficial de la Unió Europea?', 'La fitxa de la UE dona a Espanya 505.983 km²; França en té 638.475.', 'cultcat_03_geografia', (select id from public.topics where slug = 'cultcat-03-geografia'), 3, 'ca', true, (select id from public.sources where url = 'https://european-union.europa.eu/principles-countries-history/eu-countries_es'), 'Superfície d''Espanya', 'Extensión geográfica: 505 983 km2', null, '890baa6e692d3db41e664513e5869559bfb8cacc80da3e633e7ed31ef5551bac', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '890baa6e692d3db41e664513e5869559bfb8cacc80da3e633e7ed31ef5551bac')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Uns 638.000 km²', false), ('B', 'Uns 357.000 km²', false), ('C', 'Uns 302.000 km²', false), ('D', 'Uns 506.000 km²', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local', 'guardia-urbana-barcelona');
-- Lote cultcat-04-art-patrimoni-bcngaudi26-v1 (1 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Barcelona ret homenatge a Antoni Gaudí amb una placa en el mateix punt on va ser atropellat l’any 1926 (07/06/2026)', 'https://ajuntament.barcelona.cat/premsa/2026/06/07/barcelona-ret-homenatge-a-antoni-gaudi-amb-una-placa-en-el-mateix-punt-on-va-ser-atropellat-lany-1926/', 'web_oficial'::public.source_kind, 'Ajuntament de Barcelona', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('cultcat-04-art-patrimoni', 'Cultura general 4. Art i patrimoni (estils artístics, museus i patrimoni mundial)') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('policia-local', 'guardia-urbana-barcelona') and t.slug = 'cultcat-04-art-patrimoni' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'De quin moviment és considerat el màxim exponent l''arquitecte Antoni Gaudí (1852-1926)?', 'L''Ajuntament de Barcelona presenta Gaudí com el màxim exponent del modernisme català; el 2026 se''n commemora el centenari de la mort.', 'cultcat_04_art_patrimoni', (select id from public.topics where slug = 'cultcat-04-art-patrimoni'), 1, 'ca', true, (select id from public.sources where url = 'https://ajuntament.barcelona.cat/premsa/2026/06/07/barcelona-ret-homenatge-a-antoni-gaudi-amb-una-placa-en-el-mateix-punt-on-va-ser-atropellat-lany-1926/'), 'Gaudí i el modernisme', 'Antoni Gaudí i Cornet, nascut el 1852, és una de les figures cabdals de l’arquitectura universal i el màxim exponent del modernisme català.', null, '755e3f569d5aee2ad00df4ffb6784fd80abb766f35d08fb85d075c7373de241d', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '755e3f569d5aee2ad00df4ffb6784fd80abb766f35d08fb85d075c7373de241d')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El modernisme català', true), ('B', 'El noucentisme', false), ('C', 'El romanticisme', false), ('D', 'El racionalisme', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local', 'guardia-urbana-barcelona');
-- Lote cultcat-04-art-patrimoni-diec-v1 (8 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Diccionari de la llengua catalana, 2a edició (DIEC2), Institut d''Estudis Catalans', 'https://dlc.iec.cat/', 'web_oficial'::public.source_kind, 'Institut d''Estudis Catalans', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('cultcat-04-art-patrimoni', 'Cultura general 4. Art i patrimoni (estils artístics, museus i patrimoni mundial)') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('policia-local', 'guardia-urbana-barcelona') and t.slug = 'cultcat-04-art-patrimoni' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Quin estil artístic es va desenvolupar a l''Europa occidental entre el preromànic i el gòtic, i és el de les esglésies de la Vall de Boí?', 'El romànic precedeix el gòtic; les esglésies romàniques de la Vall de Boí són patrimoni mundial des del 2000.', 'cultcat_04_art_patrimoni', (select id from public.topics where slug = 'cultcat-04-art-patrimoni'), 1, 'ca', true, (select id from public.sources where url = 'https://dlc.iec.cat/'), 'Romànic', 'romànic 2 1 adj. [AR] Relatiu o pertanyent a l’art, a l’estil arquitectònic, desenvolupat en diversos països de l’Europa occidental entre el preromànic i el gòtic.', null, '89765ad1ba9a4fa59a97356c5b134f655c23a4995c4c23194ca026cca55841e1', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '89765ad1ba9a4fa59a97356c5b134f655c23a4995c4c23194ca026cca55841e1')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El barroc', false), ('B', 'El renaixement', false), ('C', 'El romànic', true), ('D', 'El modernisme', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local', 'guardia-urbana-barcelona');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Com s''anomena l''obra d''arquitectura, amb escultures o pintures, que decora un altar?', 'El retaule és l''obra decorativa que es col·loca darrere o damunt de l''altar.', 'cultcat_04_art_patrimoni', (select id from public.topics where slug = 'cultcat-04-art-patrimoni'), 1, 'ca', true, (select id from public.sources where url = 'https://dlc.iec.cat/'), 'Retaule', 'retaule 1 m. [AR] [LC] Obra d’arquitectura, amb escultures, pintures, que compon la decoració d’un altar.', null, 'a1482464e2b8cd94a73713e1d0c443eacf257cba1e932107ac9e9dac56d64623', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'a1482464e2b8cd94a73713e1d0c443eacf257cba1e932107ac9e9dac56d64623')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Absis', false), ('B', 'Retaule', true), ('C', 'Claustre', false), ('D', 'Capitell', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local', 'guardia-urbana-barcelona');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Com s''anomena el gran finestral circular i vidrat de les façanes de les esglésies gòtiques?', 'La rosassa és un element típic de les esglésies gòtiques, especialment a la façana.', 'cultcat_04_art_patrimoni', (select id from public.topics where slug = 'cultcat-04-art-patrimoni'), 1, 'ca', true, (select id from public.sources where url = 'https://dlc.iec.cat/'), 'Rosassa', 'rosassa f. [AQ] [AR] [LC] Gran finestral circular, calat i vidrat, que es troba als murs de les esglésies gòtiques, especialment a la façana.', null, '066cf8b38d9e667b005d526901e58cc57ecf251cc70476f20cd5c7e0ef764bfb', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '066cf8b38d9e667b005d526901e58cc57ecf251cc70476f20cd5c7e0ef764bfb')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Arcbotant', false), ('B', 'Timpà', false), ('C', 'Vitrall emplomat', false), ('D', 'Rosassa', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local', 'guardia-urbana-barcelona');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Com s''anomena la part d''una església, generalment de planta semicircular, que sobresurt de la façana posterior i conté un altar?', 'L''absis és la capçalera de l''església; als absis romànics hi ha sovint pintures murals.', 'cultcat_04_art_patrimoni', (select id from public.topics where slug = 'cultcat-04-art-patrimoni'), 2, 'ca', true, (select id from public.sources where url = 'https://dlc.iec.cat/'), 'Absis', 'absis 1 m. [AQ] [AR] [LC] Part d’una església, comunament de planta semicircular, que sobresurt de la façana posterior i que conté un altar.', null, '3b34c991b8645c38fb44f2d790f18db3660c279d268dac5167a2316e7470747c', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '3b34c991b8645c38fb44f2d790f18db3660c279d268dac5167a2316e7470747c')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Absis', true), ('B', 'Nau central', false), ('C', 'Creuer', false), ('D', 'Campanar', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local', 'guardia-urbana-barcelona');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Quin corrent pictòric, desenvolupat sobretot a França, cerca donar la impressió immediata que produeixen els objectes a la vista de l''artista?', 'L''impressionisme se centra en el paisatge i els temes quotidians i en la impressió immediata.', 'cultcat_04_art_patrimoni', (select id from public.topics where slug = 'cultcat-04-art-patrimoni'), 2, 'ca', true, (select id from public.sources where url = 'https://dlc.iec.cat/'), 'Impressionisme', 'impressionisme m. [AR] [LC] Corrent estètic, especialment pictòric, iniciat i desenvolupat sobretot a França, que se centra en el paisatge o en els temes quotidians i cerca de donar la impressió immediata produïda a l’artista per la vista dels objectes.', null, '30a26e6a48c09746eae00cf48e25050eb2a4cb4e36ad034b6c0d83563346239d', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '30a26e6a48c09746eae00cf48e25050eb2a4cb4e36ad034b6c0d83563346239d')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El cubisme', false), ('B', 'El surrealisme', false), ('C', 'El barroc', false), ('D', 'L''impressionisme', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local', 'guardia-urbana-barcelona');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Quin moviment artístic expressa el volum dels objectes per mitjà de figures i sòlids geomètrics?', 'El cubisme considera el volum l''atribut important dels objectes i l''expressa amb formes geomètriques.', 'cultcat_04_art_patrimoni', (select id from public.topics where slug = 'cultcat-04-art-patrimoni'), 2, 'ca', true, (select id from public.sources where url = 'https://dlc.iec.cat/'), 'Cubisme', 'cubisme m. [AR] [LC] Moviment artístic que considera el volum com l’atribut important dels objectes i tracta d’expressar-lo plàsticament per mitjà tan sols de figures i sòlids geomètrics.', null, 'd04f82cd88003289352c8dd6a6e06732b1dc6f3bcb2498051998aa737e779086', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'd04f82cd88003289352c8dd6a6e06732b1dc6f3bcb2498051998aa737e779086')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'L''impressionisme', false), ('B', 'El romanticisme', false), ('C', 'El cubisme', true), ('D', 'El modernisme', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local', 'guardia-urbana-barcelona');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'On i quan va sorgir el surrealisme, moviment que proclama l''automatisme psíquic i la importància del món oníric?', 'El surrealisme va sorgir a França el 1924; Dalí i Miró en són figures destacades.', 'cultcat_04_art_patrimoni', (select id from public.topics where slug = 'cultcat-04-art-patrimoni'), 3, 'ca', true, (select id from public.sources where url = 'https://dlc.iec.cat/'), 'Surrealisme', 'surrealisme m. [AR] [FLL] [FS] Moviment literari, artístic i filosòfic, sorgit a França l’any 1924', null, 'c48d95596c2c3786deff54371017c49b0ee72ffd0ddfa8bdea1b64bbba916d8a', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'c48d95596c2c3786deff54371017c49b0ee72ffd0ddfa8bdea1b64bbba916d8a')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'A Itàlia, el 1909', false), ('B', 'A Alemanya, el 1919', false), ('C', 'A Espanya, el 1898', false), ('D', 'A França, el 1924', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local', 'guardia-urbana-barcelona');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'On va aparèixer l''estil barroc, evolució complexa del Renaixement, i fins quan va predominar a Europa?', 'El barroc va sorgir a Itàlia a les darreries del segle XVI i va predominar fins a bona part del XVIII; la segona opció correspon al gòtic.', 'cultcat_04_art_patrimoni', (select id from public.topics where slug = 'cultcat-04-art-patrimoni'), 3, 'ca', true, (select id from public.sources where url = 'https://dlc.iec.cat/'), 'Barroc', 'barroc 1 1 adj. [AQ] [AR] [LC] Relatiu o pertanyent a un estil artístic, evolució complexa del Renaixement, aparegut a Itàlia a les darreries del segle xvi i predominant a Europa fins gran part del segle xviii.', null, 'c761742da933c4ab264c3e03b65bf79631d08f7e68ed66c7f0c453bf6718870f', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'c761742da933c4ab264c3e03b65bf79631d08f7e68ed66c7f0c453bf6718870f')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'A França, al segle XII, i va predominar fins al Renaixement', false), ('B', 'A Itàlia, a finals del segle XVI, i va predominar fins a bona part del segle XVIII', true), ('C', 'A Catalunya, a finals del segle XIX, i va predominar fins al 1920', false), ('D', 'Als Països Baixos, al segle XV, i va predominar fins al segle XVI', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local', 'guardia-urbana-barcelona');
-- Lote cultcat-04-art-patrimoni-reinasofia-v1 (3 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Guernica (Pablo Picasso, 1937), fitxa de la col·lecció', 'https://www.museoreinasofia.es/colecciones/obra/guernica', 'web_oficial'::public.source_kind, 'Museo Nacional Centro de Arte Reina Sofía', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('cultcat-04-art-patrimoni', 'Cultura general 4. Art i patrimoni (estils artístics, museus i patrimoni mundial)') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('policia-local', 'guardia-urbana-barcelona') and t.slug = 'cultcat-04-art-patrimoni' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Qui va pintar el Guernica, que es conserva al Museo Reina Sofía de Madrid?', 'El Guernica és un oli sobre tela de Pablo Picasso, pintat a París el 1937.', 'cultcat_04_art_patrimoni', (select id from public.topics where slug = 'cultcat-04-art-patrimoni'), 1, 'ca', true, (select id from public.sources where url = 'https://www.museoreinasofia.es/colecciones/obra/guernica'), 'Guernica, autor', 'GUERNICA Picasso, Pablo (Pablo Ruiz Picasso)', null, '8839a9b491146409d046b1524eba95969de05e5f04d15e075a2515de495c7ec5', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '8839a9b491146409d046b1524eba95969de05e5f04d15e075a2515de495c7ec5')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Salvador Dalí', false), ('B', 'Joan Miró', false), ('C', 'Antoni Tàpies', false), ('D', 'Pablo Picasso', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local', 'guardia-urbana-barcelona');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Per a quin esdeveniment va néixer el Guernica de Picasso, el 1937?', 'El quadre va néixer per formar part del Pavelló Espanyol a l''Exposició Internacional de París de 1937, arran del bombardeig de la vila basca de Gernika per l''aviació alemanya.', 'cultcat_04_art_patrimoni', (select id from public.topics where slug = 'cultcat-04-art-patrimoni'), 2, 'ca', true, (select id from public.sources where url = 'https://www.museoreinasofia.es/colecciones/obra/guernica'), 'Guernica, encàrrec', 'el lienzo Guernica nació para formar parte del Pabellón Español en la Exposición Internacional de París, de 1937.', null, 'ee9ca3945688a5ec9b53f64cd2d7682b2a28a584a6383784304c8e128dbce1d1', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'ee9ca3945688a5ec9b53f64cd2d7682b2a28a584a6383784304c8e128dbce1d1')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Per a l''Exposició Universal de Barcelona', false), ('B', 'Per al Pavelló Espanyol de l''Exposició Internacional de París', true), ('C', 'Per a la inauguració del MoMA de Nova York', false), ('D', 'Per a la Biennal de Venècia', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local', 'guardia-urbana-barcelona');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'En quin any va tornar a Espanya el Guernica, que Picasso havia deixat en préstec al MoMA fins que s''hi restablissin les llibertats democràtiques?', 'El Guernica va tornar a Espanya el 1981; el museu el defineix com un quadre tardocubista i surrealista.', 'cultcat_04_art_patrimoni', (select id from public.topics where slug = 'cultcat-04-art-patrimoni'), 3, 'ca', true, (select id from public.sources where url = 'https://www.museoreinasofia.es/colecciones/obra/guernica'), 'Guernica, retorn a Espanya', 'regresando la obra finalmente a nuestro país en el año 1981.', null, '5324b830c214d4cb3087628939ea000d978d8d2bf6fb90eb2e00ab49e18d4f7d', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '5324b830c214d4cb3087628939ea000d978d8d2bf6fb90eb2e00ab49e18d4f7d')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', '1975', false), ('B', '1978', false), ('C', '1992', false), ('D', '1981', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local', 'guardia-urbana-barcelona');
-- Lote cultcat-04-art-patrimoni-unesco-v1 (8 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('World Heritage List (fitxes dels béns inscrits), UNESCO World Heritage Centre', 'https://whc.unesco.org/en/list/', 'web_oficial'::public.source_kind, 'UNESCO World Heritage Centre', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('cultcat-04-art-patrimoni', 'Cultura general 4. Art i patrimoni (estils artístics, museus i patrimoni mundial)') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('policia-local', 'guardia-urbana-barcelona') and t.slug = 'cultcat-04-art-patrimoni' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'A quina civilització s''atribueix la ciutat de Machu Picchu, al Perú?', 'Segons la UNESCO, Machu Picchu, a 2.430 m d''altitud, va ser probablement la creació urbana més extraordinària de l''Imperi inca.', 'cultcat_04_art_patrimoni', (select id from public.topics where slug = 'cultcat-04-art-patrimoni'), 1, 'ca', true, (select id from public.sources where url = 'https://whc.unesco.org/en/list/'), 'Machu Picchu', 'It was probably the most amazing urban creation of the Inca Empire at its height', null, 'ac201eca7c68e898cb44fb33818207058020bb0e5b5870a67fcc880df58a7d72', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'ac201eca7c68e898cb44fb33818207058020bb0e5b5870a67fcc880df58a7d72')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'A l''Imperi inca', true), ('B', 'Als maies', false), ('C', 'Als asteques', false), ('D', 'Als olmeques', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local', 'guardia-urbana-barcelona');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Quin arquitecte modernista va fer el Palau de la Música Catalana i l''Hospital de Sant Pau, patrimoni mundial des de 1997?', 'Tots dos edificis són obra de Lluís Domènech i Montaner i la UNESCO els va inscriure el 1997.', 'cultcat_04_art_patrimoni', (select id from public.topics where slug = 'cultcat-04-art-patrimoni'), 2, 'ca', true, (select id from public.sources where url = 'https://whc.unesco.org/en/list/'), 'Palau de la Música i Sant Pau', 'Palau de la Música Catalana and Hospital de Sant Pau, Barcelona (Date of Inscription: 1997). These are two of the finest contributions to Barcelona''s architecture by the Catalan art nouveau architect Lluís Domènech i Montaner.', null, '1752e98926e6ed974a5141115d0b4e1f7faa9d33cb6d3614960eeabee49d5170', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '1752e98926e6ed974a5141115d0b4e1f7faa9d33cb6d3614960eeabee49d5170')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Antoni Gaudí', false), ('B', 'Josep Puig i Cadafalch', false), ('C', 'Lluís Domènech i Montaner', true), ('D', 'Josep Maria Jujol', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local', 'guardia-urbana-barcelona');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Quin monestir català, patrimoni mundial des de 1991, és una abadia cistercenca que conté el panteó dels reis de Catalunya i Aragó?', 'L''abadia cistercenca de Poblet, del segle XII, té una residència reial fortificada i el panteó reial.', 'cultcat_04_art_patrimoni', (select id from public.topics where slug = 'cultcat-04-art-patrimoni'), 2, 'ca', true, (select id from public.sources where url = 'https://whc.unesco.org/en/list/'), 'Monestir de Poblet', 'This Cistercian abbey in Catalonia is one of the largest in Spain. At its centre is a 12th-century church. The austere, majestic monastery, which has a fortified royal residence and contains the pantheon of the kings of Catalonia and Aragon', null, 'cfb82c0e2fb74b33fe0eb6d136ee94b47b76e17ddd35e87f4baf8ac469072cc0', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'cfb82c0e2fb74b33fe0eb6d136ee94b47b76e17ddd35e87f4baf8ac469072cc0')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Montserrat', false), ('B', 'Poblet', true), ('C', 'Ripoll', false), ('D', 'Sant Cugat', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local', 'guardia-urbana-barcelona');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Què és el Taj Mahal, a Agra (Índia)?', 'El Taj Mahal (1631-1648) és un mausoleu de marbre blanc, joia de l''art musulmà a l''Índia.', 'cultcat_04_art_patrimoni', (select id from public.topics where slug = 'cultcat-04-art-patrimoni'), 2, 'ca', true, (select id from public.sources where url = 'https://whc.unesco.org/en/list/'), 'Taj Mahal', 'An immense mausoleum of white marble, built in Agra between 1631 and 1648 by order of the Mughal emperor Shah Jahan in memory of his favourite wife', null, '9358cc37390600cfb6e3afd2b617378ba449833fd2cbc718cc4329a5779ebca8', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '9358cc37390600cfb6e3afd2b617378ba449833fd2cbc718cc4329a5779ebca8')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Un temple hindú dedicat al déu Xiva', false), ('B', 'El palau residencial dels emperadors mogols', false), ('C', 'Un mausoleu de marbre blanc construït per ordre de l''emperador Shah Jahan en memòria de la seva esposa', true), ('D', 'Una fortalesa construïda pels britànics', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local', 'guardia-urbana-barcelona');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Quin poble va fer de Petra (Jordània) una ciutat caravanera entre el mar Roig i el mar Mort?', 'Petra era una ciutat caravanera nabatea, cruïlla entre Aràbia, Egipte i Síria-Fenícia.', 'cultcat_04_art_patrimoni', (select id from public.topics where slug = 'cultcat-04-art-patrimoni'), 2, 'ca', true, (select id from public.sources where url = 'https://whc.unesco.org/en/list/'), 'Petra', 'Inhabited since prehistoric times, this Nabataean caravan-city, situated between the Red Sea and the Dead Sea', null, 'f7a531a5bb81dbc4ade5b9eed997b0e263084b3039e06beea3ba9ddf0171f520', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'f7a531a5bb81dbc4ade5b9eed997b0e263084b3039e06beea3ba9ddf0171f520')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Els fenicis', false), ('B', 'Els nabateus', true), ('C', 'Els romans', false), ('D', 'Els perses', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local', 'guardia-urbana-barcelona');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'De quin estil és la Llotja de la Seda de València (1482-1533), patrimoni mundial?', 'La UNESCO la qualifica d''obra mestra de l''arquitectura gòtica tardana; s''hi comerciava amb seda.', 'cultcat_04_art_patrimoni', (select id from public.topics where slug = 'cultcat-04-art-patrimoni'), 2, 'ca', true, (select id from public.sources where url = 'https://whc.unesco.org/en/list/'), 'Llotja de la Seda de València', 'It is a masterpiece of late Gothic architecture.', null, '53fe269b5cc109296a9dc62e6f2dd7c044be5d867d3d0f5b8bcd1334788f5a25', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '53fe269b5cc109296a9dc62e6f2dd7c044be5d867d3d0f5b8bcd1334788f5a25')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Gòtic tardà', true), ('B', 'Romànic', false), ('C', 'Barroc', false), ('D', 'Modernista', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local', 'guardia-urbana-barcelona');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Sota la direcció de quin escultor es va transformar l''Acròpoli d''Atenes, seguint els plans de l''estadista Pèricles?', 'La UNESCO atribueix la transformació de l''Acròpoli a un grup d''artistes guiats per l''escultor Fídies, seguint els plans de Pèricles.', 'cultcat_04_art_patrimoni', (select id from public.topics where slug = 'cultcat-04-art-patrimoni'), 3, 'ca', true, (select id from public.sources where url = 'https://whc.unesco.org/en/list/'), 'Acròpoli d''Atenes', 'an exceptional group of artists put into effect the ambitious plans of Athenian statesman Pericles and, under the inspired guidance of the sculptor Pheidias', null, '532393781b24e51fb43b769657f46a48fa6f1613c8a7cdd5ee0440d8e76ec248', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '532393781b24e51fb43b769657f46a48fa6f1613c8a7cdd5ee0440d8e76ec248')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Fídies', true), ('B', 'Praxíteles', false), ('C', 'Miró de Beòcia', false), ('D', 'Policlet', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local', 'guardia-urbana-barcelona');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Quin d''aquests edificis NO forma part de les set obres d''Antoni Gaudí inscrites a la Llista del patrimoni mundial de la UNESCO (1984)?', 'Les set obres de Gaudí són el Park Güell, el Palau Güell, la Casa Milà, la Casa Vicens, la façana del Naixement i la cripta de la Sagrada Família, la Casa Batlló i la cripta de la Colònia Güell. El Palau de la Música és de Domènech i Montaner.', 'cultcat_04_art_patrimoni', (select id from public.topics where slug = 'cultcat-04-art-patrimoni'), 3, 'ca', true, (select id from public.sources where url = 'https://whc.unesco.org/en/list/'), 'Obres de Gaudí, patrimoni mundial', 'The seven buildings are: Parque Güell; Palacio Güell; Casa Mila; Casa Vicens; Gaudí’s work on the Nativity façade and Crypt of La Sagrada Familia; Casa Batlló Crypt in Colonia Güell.', null, 'b78a3db52667a91ac7b74510d34a1eb832800a3aee712fbbc2d8266e759ead07', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'b78a3db52667a91ac7b74510d34a1eb832800a3aee712fbbc2d8266e759ead07')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El Palau Güell', false), ('B', 'La Casa Vicens', false), ('C', 'El Palau de la Música Catalana', true), ('D', 'La Casa Milà', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local', 'guardia-urbana-barcelona');
-- Lote cultcat-05-literatura-cervantes-v1 (2 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Gonzalo Celorio, Premio Cervantes 2025 (03/11/2025)', 'https://www.cultura.gob.es/actualidad/2025/11/251103-premio-cervantes-2025.html', 'web_oficial'::public.source_kind, 'Ministerio de Cultura', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('cultcat-05-literatura', 'Cultura general 5. Literatura catalana, castellana i universal') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('policia-local', 'guardia-urbana-barcelona') and t.slug = 'cultcat-05-literatura' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Quin requisit ha de complir l''obra d''un autor per poder rebre el Premi Cervantes?', 'El Premi Cervantes, concedit pel Ministeri de Cultura, reconeix autors d''obra en castellà de qualsevol país.', 'cultcat_05_literatura', (select id from public.topics where slug = 'cultcat-05-literatura'), 2, 'ca', true, (select id from public.sources where url = 'https://www.cultura.gob.es/actualidad/2025/11/251103-premio-cervantes-2025.html'), 'Premi Cervantes', 'Puede ser galardonado con el Premio Cervantes cualquier autor o autora cuya obra literaria esté escrita totalmente, o en parte esencial, en castellano.', null, '4e4f6cbe0179586c64bb277fb684dc1481f3ac17eb0284e859c8305ae0ace426', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '4e4f6cbe0179586c64bb277fb684dc1481f3ac17eb0284e859c8305ae0ace426')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Estar escrita totalment, o en una part essencial, en castellà', true), ('B', 'Estar escrita en qualsevol de les llengües oficials d''Espanya', false), ('C', 'Haver estat publicada per primer cop a Espanya', false), ('D', 'Ser d''un autor de nacionalitat espanyola', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local', 'guardia-urbana-barcelona');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Quin poeta català va rebre el Premi Cervantes el 2019?', 'Joan Margarit va rebre el Cervantes el 2019; Juan Marsé l''havia rebut el 2008 i Eduardo Mendoza el 2016.', 'cultcat_05_literatura', (select id from public.topics where slug = 'cultcat-05-literatura'), 3, 'ca', true, (select id from public.sources where url = 'https://www.cultura.gob.es/actualidad/2025/11/251103-premio-cervantes-2025.html'), 'Joan Margarit, Premi Cervantes 2019', '2019 Joan Margarit', null, '77e0e82193f00adeb27995f253ef3cad5eae220d0483cbc27ab0a2db3ffe7e4a', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '77e0e82193f00adeb27995f253ef3cad5eae220d0483cbc27ab0a2db3ffe7e4a')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Juan Marsé', false), ('B', 'Eduardo Mendoza', false), ('C', 'Pere Gimferrer', false), ('D', 'Joan Margarit', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local', 'guardia-urbana-barcelona');
-- Lote cultcat-05-literatura-diec-v1 (4 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Diccionari de la llengua catalana, 2a edició (DIEC2), Institut d''Estudis Catalans', 'https://dlc.iec.cat/', 'web_oficial'::public.source_kind, 'Institut d''Estudis Catalans', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('cultcat-05-literatura', 'Cultura general 5. Literatura catalana, castellana i universal') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('policia-local', 'guardia-urbana-barcelona') and t.slug = 'cultcat-05-literatura' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Com s''anomena el moviment cultural del segle XIX que va promoure la recuperació de la llengua i la literatura catalanes?', 'La Renaixença és el moviment vuitcentista de recuperació del català; el Renaixement és el moviment europeu que recupera l''art grecoromà.', 'cultcat_05_literatura', (select id from public.topics where slug = 'cultcat-05-literatura'), 1, 'ca', true, (select id from public.sources where url = 'https://dlc.iec.cat/'), 'Renaixença', 'renaixença 2 f. [FLL] Moviment cultural vuitcentista promotor de la recuperació de la llengua i la literatura catalanes.', null, '27027f08ebcd320f61b2f8a7f2aad1c189e94ac0b6e36f6d640b882c5dc56a3f', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '27027f08ebcd320f61b2f8a7f2aad1c189e94ac0b6e36f6d640b882c5dc56a3f')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'La Renaixença', true), ('B', 'El Noucentisme', false), ('C', 'El Renaixement', false), ('D', 'El Modernisme', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local', 'guardia-urbana-barcelona');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Com s''anomena la composició poètica formada per dos quartets i dos tercets?', 'El sonet té catorze versos: dos quartets i dos tercets.', 'cultcat_05_literatura', (select id from public.topics where slug = 'cultcat-05-literatura'), 1, 'ca', true, (select id from public.sources where url = 'https://dlc.iec.cat/'), 'Sonet', 'sonet 1 m. [FLL] [LC] Composició poètica formada per dos quartets amb dues soles rimes i dos tercets.', null, '1886c19b5b3b5d034c2aaa3156550f7872fc509c3de41ca9dc3e8bff7e6a9d28', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '1886c19b5b3b5d034c2aaa3156550f7872fc509c3de41ca9dc3e8bff7e6a9d28')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Haiku', false), ('B', 'Romanç', false), ('C', 'Sonet', true), ('D', 'Octava reial', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local', 'guardia-urbana-barcelona');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Com s''anomena la narració que dona un ensenyament moral per mitjà d''animals que parlen i actuen com a persones?', 'La faula és una ficció al·legòrica amb un ensenyament útil o moral, sovint amb animals com a protagonistes.', 'cultcat_05_literatura', (select id from public.topics where slug = 'cultcat-05-literatura'), 1, 'ca', true, (select id from public.sources where url = 'https://dlc.iec.cat/'), 'Faula', 'faula 2 2 f. [FLL] [LC] Narració en què es dona un ensenyament útil o moral, per mitjà d’una ficció al·legòrica en què intervenen animals i àdhuc éssers inanimats parlant i obrant com si fossin éssers humans o racionals.', null, '28d0680e326f823f453d74b67fdf204459801a603eeb7cb204996c9b2acb60fa', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '28d0680e326f823f453d74b67fdf204459801a603eeb7cb204996c9b2acb60fa')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Faula', true), ('B', 'Llegenda', false), ('C', 'Epopeia', false), ('D', 'Crònica', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local', 'guardia-urbana-barcelona');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Quin moviment cultural d''abast polític es va iniciar a Catalunya a la primeria del segle XX?', 'El noucentisme va seguir el modernisme; la Renaixença és del segle XIX.', 'cultcat_05_literatura', (select id from public.topics where slug = 'cultcat-05-literatura'), 2, 'ca', true, (select id from public.sources where url = 'https://dlc.iec.cat/'), 'Noucentisme', 'noucentisme m. [HIH] Moviment cultural d’abast polític iniciat a Catalunya a la primeria del segle xx.', null, 'f7395a21e07c32d22e890cffda5babd10e57c9a3349cb5b02a33c216dc5234bd', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'f7395a21e07c32d22e890cffda5babd10e57c9a3349cb5b02a33c216dc5234bd')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'La Renaixença', false), ('B', 'El noucentisme', true), ('C', 'El romanticisme', false), ('D', 'El modernisme', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local', 'guardia-urbana-barcelona');
-- Lote cultcat-05-literatura-nobelhist-v1 (5 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('NobelPrize.org: All Nobel Prizes 2025 i fitxes de premiats (Literature 1956, 1977, 1982, 1989, 2010, 2023-2024; Peace 2023-2024)', 'https://www.nobelprize.org/all-nobel-prizes-2025/', 'web_oficial'::public.source_kind, 'Nobel Foundation / Nobel Prize Outreach', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('cultcat-05-literatura', 'Cultura general 5. Literatura catalana, castellana i universal') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('policia-local', 'guardia-urbana-barcelona') and t.slug = 'cultcat-05-literatura' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Quin escriptor, nascut a Aracataca (Colòmbia), va rebre el premi Nobel de literatura el 1982?', 'Gabriel García Márquez (Aracataca, 1927) va rebre el Nobel de literatura el 1982.', 'cultcat_05_literatura', (select id from public.topics where slug = 'cultcat-05-literatura'), 1, 'ca', true, (select id from public.sources where url = 'https://www.nobelprize.org/all-nobel-prizes-2025/'), 'García Márquez, Nobel 1982', 'Gabriel García Márquez Nobel Prize in Literature 1982 Born: 6 March 1927, Aracataca, Colombia', null, '147142fe902ff86dbec3632c0d2c0a61c90197ce68d0fa2da8a607bfda0978f6', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '147142fe902ff86dbec3632c0d2c0a61c90197ce68d0fa2da8a607bfda0978f6')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Mario Vargas Llosa', false), ('B', 'Gabriel García Márquez', true), ('C', 'Pablo Neruda', false), ('D', 'Octavio Paz', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local', 'guardia-urbana-barcelona');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Quin poeta, nascut a Moguer, va rebre el premi Nobel de literatura el 1956?', 'Juan Ramón Jiménez va rebre el Nobel el 1956; Vicente Aleixandre, el 1977.', 'cultcat_05_literatura', (select id from public.topics where slug = 'cultcat-05-literatura'), 2, 'ca', true, (select id from public.sources where url = 'https://www.nobelprize.org/all-nobel-prizes-2025/'), 'Juan Ramón Jiménez, Nobel 1956', 'Juan Ramón Jiménez Nobel Prize in Literature 1956 Born: 24 December 1881, Moguer, Spain', null, 'bc25d0d862f1bea9bb1f4814abdd82e0318c21fcb5c9833ed512b55daf020a3d', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'bc25d0d862f1bea9bb1f4814abdd82e0318c21fcb5c9833ed512b55daf020a3d')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Juan Ramón Jiménez', true), ('B', 'Vicente Aleixandre', false), ('C', 'Antonio Machado', false), ('D', 'Federico García Lorca', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local', 'guardia-urbana-barcelona');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Quin escriptor nascut a Iria Flavia el 1916 va rebre el premi Nobel de literatura el 1989?', 'Camilo José Cela (Iria Flavia, 1916) va rebre el Nobel el 1989 i el Premi Cervantes el 1995.', 'cultcat_05_literatura', (select id from public.topics where slug = 'cultcat-05-literatura'), 2, 'ca', true, (select id from public.sources where url = 'https://www.nobelprize.org/all-nobel-prizes-2025/'), 'Cela, Nobel 1989', 'Camilo José Cela Nobel Prize in Literature 1989 Born: 11 May 1916, Iria Flavia, Spain', null, 'b995fb8467ecdeda3db44d44155a868afd0eb2d435f218c2e46ead8eea9f1fe6', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'b995fb8467ecdeda3db44d44155a868afd0eb2d435f218c2e46ead8eea9f1fe6')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Gonzalo Torrente Ballester', false), ('B', 'Miguel Delibes', false), ('C', 'Álvaro Cunqueiro', false), ('D', 'Camilo José Cela', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local', 'guardia-urbana-barcelona');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'On va néixer Mario Vargas Llosa, premi Nobel de literatura 2010, mort a Lima el 13 d''abril de 2025?', 'Vargas Llosa va néixer a Arequipa el 1936; també havia rebut el Premi Cervantes el 1994.', 'cultcat_05_literatura', (select id from public.topics where slug = 'cultcat-05-literatura'), 3, 'ca', true, (select id from public.sources where url = 'https://www.nobelprize.org/all-nobel-prizes-2025/'), 'Vargas Llosa', 'Mario Vargas Llosa Nobel Prize in Literature 2010 Born: 28 March 1936, Arequipa, Peru Died: 13 April 2025, Lima, Peru', null, 'dc2c4f15ef2bf7d800fd0b1d2ee56aae100f151adb9d567f21d2f763d1143487', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'dc2c4f15ef2bf7d800fd0b1d2ee56aae100f151adb9d567f21d2f763d1143487')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'A Arequipa (Perú)', true), ('B', 'A Lima (Perú)', false), ('C', 'A Bogotà (Colòmbia)', false), ('D', 'A Santiago de Xile', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local', 'guardia-urbana-barcelona');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Quin poeta nascut a Sevilla el 1898 va rebre el premi Nobel de literatura el 1977?', 'Vicente Aleixandre (Sevilla, 1898) va rebre el Nobel el 1977; Alberti i Guillén van rebre el Premi Cervantes (1983 i 1976).', 'cultcat_05_literatura', (select id from public.topics where slug = 'cultcat-05-literatura'), 3, 'ca', true, (select id from public.sources where url = 'https://www.nobelprize.org/all-nobel-prizes-2025/'), 'Aleixandre, Nobel 1977', 'Vicente Aleixandre Nobel Prize in Literature 1977 Born: 26 April 1898, Sevilla, Spain', null, 'e3d23183e22eb5ade0b49c1299c2fdb075cbc0d6444ea6456af0ca69a9bd66fd', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'e3d23183e22eb5ade0b49c1299c2fdb075cbc0d6444ea6456af0ca69a9bd66fd')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Luis Cernuda', false), ('B', 'Vicente Aleixandre', true), ('C', 'Rafael Alberti', false), ('D', 'Jorge Guillén', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local', 'guardia-urbana-barcelona');
-- Lote cultcat-05-literatura-patrimoni-v1 (9 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Patrimoni Cultural de la Generalitat de Catalunya: col·leccions (Jacint Verdaguer, Salvador Espriu, Joan Maragall, Josep Pla) i històries del patrimoni', 'https://patrimoni.gencat.cat/ca/coleccio/jacint-verdaguer', 'web_oficial'::public.source_kind, 'Generalitat de Catalunya, Departament de Cultura (Patrimoni Cultural)', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('cultcat-05-literatura', 'Cultura general 5. Literatura catalana, castellana i universal') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('policia-local', 'guardia-urbana-barcelona') and t.slug = 'cultcat-05-literatura' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Qui és l''autor de la novel·la cavalleresca Tirant lo Blanc?', 'Tirant lo Blanc és obra del valencià Joanot Martorell (segle XV).', 'cultcat_05_literatura', (select id from public.topics where slug = 'cultcat-05-literatura'), 1, 'ca', true, (select id from public.sources where url = 'https://patrimoni.gencat.cat/ca/coleccio/jacint-verdaguer'), 'Tirant lo Blanc, autor', 'El protagonista de la novela ''Tirant Lo Blanc'', obra del valenciano Joanot Martorell', null, '7d8370688b5a6c8dd6b4fa4dcee0dcf29f7915a1e349c8756cca4ca4462249bf', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '7d8370688b5a6c8dd6b4fa4dcee0dcf29f7915a1e349c8756cca4ca4462249bf')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Ramon Llull', false), ('B', 'Ausiàs March', false), ('C', 'Joanot Martorell', true), ('D', 'Bernat Metge', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local', 'guardia-urbana-barcelona');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Qui va escriure els poemes L''Atlàntida (1877) i Canigó (1886)?', 'L''Atlàntida i Canigó són dos dels grans poemes de Jacint Verdaguer, figura clau de la Renaixença.', 'cultcat_05_literatura', (select id from public.topics where slug = 'cultcat-05-literatura'), 1, 'ca', true, (select id from public.sources where url = 'https://patrimoni.gencat.cat/ca/coleccio/jacint-verdaguer'), 'Verdaguer, Canigó', 'va ser quan va escriure dos dels seus poemes més importants: L’Atlàntida (1877) i Canigó (1886)', null, 'd7f86deb440647ee05c5253effa438f4ccbb71561c9d8616d2cdaeda0a62b4e6', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'd7f86deb440647ee05c5253effa438f4ccbb71561c9d8616d2cdaeda0a62b4e6')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Joan Maragall', false), ('B', 'Àngel Guimerà', false), ('C', 'Salvador Espriu', false), ('D', 'Jacint Verdaguer', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local', 'guardia-urbana-barcelona');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Quin poble és la Sinera mítica de l''obra de Salvador Espriu?', 'Sinera és Arenys llegit al revés; el poble del Maresme va ser la «petita pàtria» d''Espriu.', 'cultcat_05_literatura', (select id from public.topics where slug = 'cultcat-05-literatura'), 2, 'ca', true, (select id from public.sources where url = 'https://patrimoni.gencat.cat/ca/coleccio/jacint-verdaguer'), 'Espriu, Sinera', 'Aquest poble del Maresme va ser la seva “petita pàtria” i apareix mitificat en la seva obra com a Sinera (Arenys al revés).', null, '675f7587fd2a353f1ad106e50b65c8fcfc7cddda51d02d361970dc10be116018', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '675f7587fd2a353f1ad106e50b65c8fcfc7cddda51d02d361970dc10be116018')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Palafrugell', false), ('B', 'Folgueroles', false), ('C', 'Cadaqués', false), ('D', 'Arenys de Mar', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local', 'guardia-urbana-barcelona');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'De quina població era fill l''escriptor i periodista Josep Pla (1897-1981)?', 'Josep Pla era fill d''una família de petits propietaris rurals de Palafrugell (Baix Empordà).', 'cultcat_05_literatura', (select id from public.topics where slug = 'cultcat-05-literatura'), 2, 'ca', true, (select id from public.sources where url = 'https://patrimoni.gencat.cat/ca/coleccio/jacint-verdaguer'), 'Josep Pla, Palafrugell', 'Fill d’una família de petits propietaris rurals de Palafrugell, va estudiar dret a la Universitat de Barcelona.', null, '375d9b9cd7cc183a4b71632af282d09ecfd487f6e234193dd5ef992dbf64e073', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '375d9b9cd7cc183a4b71632af282d09ecfd487f6e234193dd5ef992dbf64e073')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Figueres', false), ('B', 'Palafrugell', true), ('C', 'Arenys de Mar', false), ('D', 'Vic', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local', 'guardia-urbana-barcelona');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'De quin moviment poètic és una de les figures cabdals Joan Maragall?', 'Joan Maragall és una figura cabdal de la poesia modernista, tot i que també va cultivar la prosa.', 'cultcat_05_literatura', (select id from public.topics where slug = 'cultcat-05-literatura'), 2, 'ca', true, (select id from public.sources where url = 'https://patrimoni.gencat.cat/ca/coleccio/jacint-verdaguer'), 'Joan Maragall', 'Joan Maragall és una de les figures cabdals de la poesia modernista, tot i que també va cultivar la prosa.', null, '51d0c5f01cdba118871386ba8266798f4159efc9895f23881676e6bd4e0ff2b7', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '51d0c5f01cdba118871386ba8266798f4159efc9895f23881676e6bd4e0ff2b7')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El noucentisme', false), ('B', 'El modernisme', true), ('C', 'El barroc', false), ('D', 'El surrealisme', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local', 'guardia-urbana-barcelona');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'On va néixer Jacint Verdaguer, fill d''un mestre i pagès modest?', 'Verdaguer (1845-1902) era de Folgueroles i va ingressar al seminari de Vic el 1855.', 'cultcat_05_literatura', (select id from public.topics where slug = 'cultcat-05-literatura'), 2, 'ca', true, (select id from public.sources where url = 'https://patrimoni.gencat.cat/ca/coleccio/jacint-verdaguer'), 'Verdaguer, Folgueroles', 'Fill d’un mestre i pagès modest de Folgueroles (Osona), va ingressar al seminari de Vic el 1855.', null, 'df75574b73751b76581c427731bcc9ccf8dc50daaf472fcbde6cd58169eafb93', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'df75574b73751b76581c427731bcc9ccf8dc50daaf472fcbde6cd58169eafb93')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'A Vic (Osona)', false), ('B', 'A Arenys de Mar (Maresme)', false), ('C', 'A Folgueroles (Osona)', true), ('D', 'A Barcelona', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local', 'guardia-urbana-barcelona');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'De qui s''enamora Tirant lo Blanc en arribar a Constantinoble?', 'Tirant s''enamora de Carmesina; la seva donzella Plaerdemavida l''ajuda a conquistar-la.', 'cultcat_05_literatura', (select id from public.topics where slug = 'cultcat-05-literatura'), 2, 'ca', true, (select id from public.sources where url = 'https://patrimoni.gencat.cat/ca/coleccio/jacint-verdaguer'), 'Tirant lo Blanc, Carmesina', 'Carmesina es hija del emperador, y su doncella Plaerdemavida ayudará a Tirant Lo Blanc a conquistarla.', null, 'd1a21cdf1c7760e267e57e533b9f0bcc1d846a416bdacaf6a8718a47f065cf4c', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'd1a21cdf1c7760e267e57e533b9f0bcc1d846a416bdacaf6a8718a47f065cf4c')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'De Plaerdemavida, la donzella de la princesa', false), ('B', 'De la reina d''Anglaterra', false), ('C', 'De la Viuda Reposada', false), ('D', 'De la princesa Carmesina, filla de l''emperador', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local', 'guardia-urbana-barcelona');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Quina obra de Salvador Espriu (1960), al·legoria crítica amb l''Espanya de la postguerra, en va suposar la consagració?', 'La pell de brau (1960) va consagrar Espriu; el seu primer volum de poemes, Cementiri de Sinera, és de 1946.', 'cultcat_05_literatura', (select id from public.topics where slug = 'cultcat-05-literatura'), 3, 'ca', true, (select id from public.sources where url = 'https://patrimoni.gencat.cat/ca/coleccio/jacint-verdaguer'), 'Espriu, La pell de brau', 'La consagració va arribar amb La pell de Brau (1960), una al·legoria crítica amb l''Espanya de la postguerra', null, '0f7507174a547aa24d61e4351e0b9566cababc1947bdcf1e0f87d3a848c5e48c', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '0f7507174a547aa24d61e4351e0b9566cababc1947bdcf1e0f87d3a848c5e48c')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Cementiri de Sinera', false), ('B', 'Primera història d''Esther', false), ('C', 'La pell de brau', true), ('D', 'Les cançons d''Ariadna', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local', 'guardia-urbana-barcelona');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Amb quina edat va guanyar Jacint Verdaguer els seus primers Jocs Florals, on va anar a recollir el premi vestit de pagès?', 'Amb només 20 anys Verdaguer va guanyar els Jocs Florals i va anar a recollir el premi vestit de pagès.', 'cultcat_05_literatura', (select id from public.topics where slug = 'cultcat-05-literatura'), 3, 'ca', true, (select id from public.sources where url = 'https://patrimoni.gencat.cat/ca/coleccio/jacint-verdaguer'), 'Verdaguer, Jocs Florals', 'amb només 20 anys, Jacint Verdaguer (1845 –1902) va guanyar els seus primers Jocs Florals i va anar a recollir el premi vestit de pagès.', null, '5e64ee408c400f0d43420e0ef2375dfb40e472eba459b4f78da9402c89e80ae9', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '5e64ee408c400f0d43420e0ef2375dfb40e472eba459b4f78da9402c89e80ae9')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Amb 15 anys', false), ('B', 'Amb 32 anys', false), ('C', 'Amb 20 anys', true), ('D', 'Amb 41 anys', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local', 'guardia-urbana-barcelona');
-- Lote cultcat-06-llengua-catalana-diec-v1 (20 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Diccionari de la llengua catalana, 2a edició (DIEC2), Institut d''Estudis Catalans', 'https://dlc.iec.cat/', 'web_oficial'::public.source_kind, 'Institut d''Estudis Catalans', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('cultcat-06-llengua-catalana', 'Cultura general 6. Llengua: gramàtica, lèxic i recursos literaris') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('policia-local', 'guardia-urbana-barcelona') and t.slug = 'cultcat-06-llengua-catalana' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Quina figura retòrica consisteix a emprar un mot que expressa literalment una cosa per expressar-ne una altra que s''hi assembla (per exemple, «les perles de la teva boca» per «les dents»)?', 'La metàfora substitueix un terme per un altre amb què té una certa semblança.', 'cultcat_06_llengua_catalana', (select id from public.topics where slug = 'cultcat-06-llengua-catalana'), 1, 'ca', true, (select id from public.sources where url = 'https://dlc.iec.cat/'), 'Metàfora', 'metàfora f. [FL] [FLL] [LC] Figura retòrica que consisteix a emprar un mot que expressa literalment una cosa per a expressar-ne una altra que té una certa semblança amb aquella.', null, 'ffa8372fca2be659ccb40c883d9f5c6e786a8d6f8c490b6b7818085376064697', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'ffa8372fca2be659ccb40c883d9f5c6e786a8d6f8c490b6b7818085376064697')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Hipèrbole', false), ('B', 'Metàfora', true), ('C', 'Onomatopeia', false), ('D', 'Al·literació', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local', 'guardia-urbana-barcelona');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons el diccionari normatiu, quina parella de mots són sinònims?', 'Dos mots són sinònims quan tenen el mateix significat; el DIEC posa l''exemple de llevant i est.', 'cultcat_06_llengua_catalana', (select id from public.topics where slug = 'cultcat-06-llengua-catalana'), 1, 'ca', true, (select id from public.sources where url = 'https://dlc.iec.cat/'), 'Sinònim', 'Els termes llevant i est són mots sinònims.', null, '38ebfa29eeb742d32e281d8b13d9c64e87f31779aa6edbf191693a862bf1d3fb', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '38ebfa29eeb742d32e281d8b13d9c64e87f31779aa6edbf191693a862bf1d3fb')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Llevant i ponent', false), ('B', 'Nord i sud', false), ('C', 'Llevant i est', true), ('D', 'Est i oest', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local', 'guardia-urbana-barcelona');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Com s''anomena un mot que té un significat directament oposat al d''un altre (com «alt» i «baix»)?', 'Els antònims tenen significats oposats; els sinònims, el mateix significat.', 'cultcat_06_llengua_catalana', (select id from public.topics where slug = 'cultcat-06-llengua-catalana'), 1, 'ca', true, (select id from public.sources where url = 'https://dlc.iec.cat/'), 'Antònim', 'antònim -a 1 adj. [FL] [LC] Que té un significat directament oposat al d’un altre mot.', null, '6177491df49ebdc5584bbd9d3aae1d1d95400a8eaa268daf46a3b52307b9a488', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '6177491df49ebdc5584bbd9d3aae1d1d95400a8eaa268daf46a3b52307b9a488')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Sinònim', false), ('B', 'Homònim', false), ('C', 'Parònim', false), ('D', 'Antònim', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local', 'guardia-urbana-barcelona');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Com s''anomena la formació de mots a partir de la imitació de sons naturals, com «tic-tac» o «nyam-nyam»?', 'L''onomatopeia imita sons naturals; també s''anomena així el mot que en resulta.', 'cultcat_06_llengua_catalana', (select id from public.topics where slug = 'cultcat-06-llengua-catalana'), 1, 'ca', true, (select id from public.sources where url = 'https://dlc.iec.cat/'), 'Onomatopeia', 'onomatopeia 1 f. [FL] [LC] Formació de mots a partir de la imitació de sons naturals.', null, '3383d541a8e1fc8fd7f3a9aa658ef85ce6eeb6f23697f90fb34d2207768d84e2', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '3383d541a8e1fc8fd7f3a9aa658ef85ce6eeb6f23697f90fb34d2207768d84e2')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Onomatopeia', true), ('B', 'Interjecció', false), ('C', 'Acrònim', false), ('D', 'Metonímia', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local', 'guardia-urbana-barcelona');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Com s''anomena un mot d''una sola síl·laba, com «pa» o «sol»?', 'Un monosíl·lab té una sola síl·laba.', 'cultcat_06_llengua_catalana', (select id from public.topics where slug = 'cultcat-06-llengua-catalana'), 1, 'ca', true, (select id from public.sources where url = 'https://dlc.iec.cat/'), 'Monosíl·lab', 'monosíl·lab -a 1 2 m. [FL] [FLL] [LC] Mot d’una sola síl·laba.', null, '552c83d10645710271b58269c4ad10b70af4700c8b588272ef72ca75238e60d6', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '552c83d10645710271b58269c4ad10b70af4700c8b588272ef72ca75238e60d6')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Esdrúixol', false), ('B', 'Diftong', false), ('C', 'Monosíl·lab', true), ('D', 'Agut', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local', 'guardia-urbana-barcelona');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Quina categoria gramatical expressa una qualitat del substantiu amb què es relaciona, com «verd» a «un arbre verd»?', 'L''adjectiu qualificatiu expressa una qualitat del substantiu i hi concorda.', 'cultcat_06_llengua_catalana', (select id from public.topics where slug = 'cultcat-06-llengua-catalana'), 1, 'ca', true, (select id from public.sources where url = 'https://dlc.iec.cat/'), 'Adjectiu qualificatiu', 'adjectiu qualificatiu Adjectiu que expressa alguna qualitat del substantiu amb què es relaciona i sovint en restringeix l’extensió.', null, '8f87515febc95e9c93d51c14d2da59875fb265673cd1206fda891092c9e0e7c5', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '8f87515febc95e9c93d51c14d2da59875fb265673cd1206fda891092c9e0e7c5')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'L''adverbi', false), ('B', 'L''adjectiu qualificatiu', true), ('C', 'El pronom', false), ('D', 'La preposició', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local', 'guardia-urbana-barcelona');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Com s''anomena un mot format per les lletres inicials dels components d''un sintagma, com IEC (Institut d''Estudis Catalans)?', 'Una sigla es forma amb les inicials (IEC); un acrònim fon parts de dos o més mots (boirum, de boira i fum).', 'cultcat_06_llengua_catalana', (select id from public.topics where slug = 'cultcat-06-llengua-catalana'), 2, 'ca', true, (select id from public.sources where url = 'https://dlc.iec.cat/'), 'Sigla', 'sigla 3 1 f. [FL] [LC] Mot format per les lletres inicials dels components d’un sintagma o d’un compost, que manté les propietats sintàctiques i el significat del sintagma o del mot originals. La sigla IEC és la manera abreujada de referir-nos a l’Institut d’Estudis Catalans.', null, 'caa41df4b6016ef5f3fe583265d1839a3c99ed7d940072cc9b32d084778aef8d', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'caa41df4b6016ef5f3fe583265d1839a3c99ed7d940072cc9b32d084778aef8d')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Sigla', true), ('B', 'Acrònim', false), ('C', 'Abreviatura', false), ('D', 'Símbol', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local', 'guardia-urbana-barcelona');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Quin d''aquests mots és un acrònim, format per la fusió de dos mots retallats?', 'Segons el DIEC, boirum (boira + fum) i cantautor (cantant + autor) són acrònims; paraigua és un compost sense reducció i IEC és una sigla.', 'cultcat_06_llengua_catalana', (select id from public.topics where slug = 'cultcat-06-llengua-catalana'), 2, 'ca', true, (select id from public.sources where url = 'https://dlc.iec.cat/'), 'Acrònim', 'Els mots boirum i cantautor són acrònims formats a partir de boira i fum i de cantant i autor, respectivament.', null, '86b17815b38bb31fda462b50b725586066460a4d181358f5499aa5b02b00919b', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '86b17815b38bb31fda462b50b725586066460a4d181358f5499aa5b02b00919b')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'IEC (Institut d''Estudis Catalans)', false), ('B', 'Paraigua (de para i aigua)', false), ('C', 'Rellotge', false), ('D', 'Cantautor (de cantant i autor)', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local', 'guardia-urbana-barcelona');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Quina figura retòrica hi ha a la frase «T''ho he dit un milió de vegades»?', 'La hipèrbole exagera, augmentant o reduint d''una manera desmesurada el que es designa.', 'cultcat_06_llengua_catalana', (select id from public.topics where slug = 'cultcat-06-llengua-catalana'), 2, 'ca', true, (select id from public.sources where url = 'https://dlc.iec.cat/'), 'Hipèrbole', 'hipèrbole 1 f. [FLL] [LC] Figura retòrica que consisteix a substituir el terme propi per un altre que n’augmenta o en redueix la designació d’una manera exagerada.', null, '98f1820be1f4f7f0e7b1f5b21f20c54eec2f3ec4a941fce10613b5822085f917', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '98f1820be1f4f7f0e7b1f5b21f20c54eec2f3ec4a941fce10613b5822085f917')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Metonímia', false), ('B', 'Personificació', false), ('C', 'Hipèrbole', true), ('D', 'Al·literació', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local', 'guardia-urbana-barcelona');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Quina figura retòrica hi ha a la frase «El vent xiuxiuejava secrets a les finestres»?', 'La personificació atribueix qualitats humanes a animals, coses o conceptes (el vent «xiuxiueja secrets»).', 'cultcat_06_llengua_catalana', (select id from public.topics where slug = 'cultcat-06-llengua-catalana'), 2, 'ca', true, (select id from public.sources where url = 'https://dlc.iec.cat/'), 'Personificació', 'personificació 2 f. [FLL] Figura retòrica que consisteix en l’atribució de qualitats humanes a animals, coses o conceptes.', null, '713fb6b88ceb00106feabeb035d251cad41a0907c0b7d1af58c2f9a322ddad31', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '713fb6b88ceb00106feabeb035d251cad41a0907c0b7d1af58c2f9a322ddad31')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Personificació', true), ('B', 'Hipèrbole', false), ('C', 'Sinècdoque', false), ('D', 'Onomatopeia', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local', 'guardia-urbana-barcelona');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Com s''anomena l''adjectiu que indica la procedència d''una persona, com «terrassenc» o «barceloní»?', 'Un gentilici denota la nació o la pàtria d''una persona.', 'cultcat_06_llengua_catalana', (select id from public.topics where slug = 'cultcat-06-llengua-catalana'), 2, 'ca', true, (select id from public.sources where url = 'https://dlc.iec.cat/'), 'Gentilici', 'gentilici 2 1 adj. [FL] [LC] Que denota la nació o la pàtria d’una persona. Adjectiu gentilici.', null, '234fbea0e65e8b049c57851381fea2a4349ce0109905ce27260cd25c4f323070', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '234fbea0e65e8b049c57851381fea2a4349ce0109905ce27260cd25c4f323070')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Possessiu', false), ('B', 'Gentilici', true), ('C', 'Demostratiu', false), ('D', 'Numeral', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local', 'guardia-urbana-barcelona');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'En el mot «desfer», què és «des-»?', 'El prefix és un afix que precedeix el radical; el sufix el segueix.', 'cultcat_06_llengua_catalana', (select id from public.topics where slug = 'cultcat-06-llengua-catalana'), 2, 'ca', true, (select id from public.sources where url = 'https://dlc.iec.cat/'), 'Prefix', 'prefix 1 m. [FL] [LC] Afix que precedeix un radical o un mot.', null, '1f2c8d6d20825f5f3a48145beb2fefdc49a0246ea926dcdba86cc75c11d0092f', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '1f2c8d6d20825f5f3a48145beb2fefdc49a0246ea926dcdba86cc75c11d0092f')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Un sufix', false), ('B', 'Un radical', false), ('C', 'Una desinència', false), ('D', 'Un prefix', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local', 'guardia-urbana-barcelona');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Quin signe gràfic, en forma de coma volada, assenyala l''elisió d''algunes lletres, com a «l''home»?', 'L''apòstrof (’) assenyala l''elisió de lletres.', 'cultcat_06_llengua_catalana', (select id from public.topics where slug = 'cultcat-06-llengua-catalana'), 2, 'ca', true, (select id from public.sources where url = 'https://dlc.iec.cat/'), 'Apòstrof', 'apòstrof m. [FL] [LC] Signe gràfic consistent en una coma volada (’), que serveix per a assenyalar l’elisió d’algunes lletres.', null, 'f68fc7c43909ac3813d829250bf212a475439a99467b5a30fbb65c00f0d8e7e8', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'f68fc7c43909ac3813d829250bf212a475439a99467b5a30fbb65c00f0d8e7e8')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'La dièresi', false), ('B', 'L''apòstrof', true), ('C', 'El guionet', false), ('D', 'L''accent obert', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local', 'guardia-urbana-barcelona');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Com s''anomena el signe gràfic de dos punts col·locats sobre una vocal, com a «pingüí» o «veïna»?', 'La dièresi (¨) és un signe de dos punts sobre una vocal.', 'cultcat_06_llengua_catalana', (select id from public.topics where slug = 'cultcat-06-llengua-catalana'), 2, 'ca', true, (select id from public.sources where url = 'https://dlc.iec.cat/'), 'Dièresi', 'dièresi 1 2 f. [FL] [LC] Signe gràfic consistent en dos punts col·locats sobre una vocal (¨)', null, '606dba5a80262a876464737787218b7a3e1320f27e53661cc5e86a76c04dd519', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '606dba5a80262a876464737787218b7a3e1320f27e53661cc5e86a76c04dd519')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Dièresi', true), ('B', 'Apòstrof', false), ('C', 'Accent tancat', false), ('D', 'Punt volat', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local', 'guardia-urbana-barcelona');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Quin d''aquests mots és esdrúixol (proparoxíton)?', 'Un mot esdrúixol té l''accent a l''antepenúltima síl·laba; el DIEC posa l''exemple de «fórmula».', 'cultcat_06_llengua_catalana', (select id from public.topics where slug = 'cultcat-06-llengua-catalana'), 2, 'ca', true, (select id from public.sources where url = 'https://dlc.iec.cat/'), 'Esdrúixol', 'esdrúixol -a adj. [FL] [FLL] [LC] Proparoxíton 1. La paraula fórmula és esdrúixola.', null, 'e1928137f82d195ae4427d67eef03dffa08f7875900af1b64fffe108ff9cf3bb', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'e1928137f82d195ae4427d67eef03dffa08f7875900af1b64fffe108ff9cf3bb')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Cançó', false), ('B', 'Taula', false), ('C', 'Rellotge', false), ('D', 'Fórmula', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local', 'guardia-urbana-barcelona');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Quina figura retòrica hi ha a «Ens vam beure un got de vi» (el continent pel contingut)?', 'La metonímia designa una cosa amb el nom d''una altra amb què té una relació necessària: efecte per causa, contingut per continent, etc.', 'cultcat_06_llengua_catalana', (select id from public.topics where slug = 'cultcat-06-llengua-catalana'), 3, 'ca', true, (select id from public.sources where url = 'https://dlc.iec.cat/'), 'Metonímia', 'metonímia f. [FL] [FLL] [LC] Figura retòrica que consisteix a designar una cosa amb el nom d’una altra amb la qual manté una relació necessària, com ara l’efecte per la causa, el contingut pel continent, etc., o viceversa.', null, '8ca49fb53f8974862ef1720c58c3c0d00c7351b634f82e24357ed40f02a32d7f', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '8ca49fb53f8974862ef1720c58c3c0d00c7351b634f82e24357ed40f02a32d7f')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Metàfora', false), ('B', 'Hipèrbole', false), ('C', 'Metonímia', true), ('D', 'Personificació', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local', 'guardia-urbana-barcelona');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'L''infinitiu «dur» (portar) i l''adjectiu «dur» (que no és tou) són mots...', 'Els homònims tenen la mateixa forma però significats diferents i no relacionats; la polisèmia és la propietat d''una sola unitat lèxica amb més d''un significat.', 'cultcat_06_llengua_catalana', (select id from public.topics where slug = 'cultcat-06-llengua-catalana'), 3, 'ca', true, (select id from public.sources where url = 'https://dlc.iec.cat/'), 'Homònim', 'La forma d’infinitiu dur i l’adjectiu masculí singular dur són mots homònims.', null, '2ef653b18ce7fab57cbe62e2fea4f374214d25e992b23e9e74df0bf65e2b8fb5', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '2ef653b18ce7fab57cbe62e2fea4f374214d25e992b23e9e74df0bf65e2b8fb5')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Sinònims', false), ('B', 'Antònims', false), ('C', 'Polisèmics', false), ('D', 'Homònims', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local', 'guardia-urbana-barcelona');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Quina figura retòrica consisteix a repetir un mateix so en mots consecutius o propers?', 'L''al·literació repeteix un so en dos o més mots consecutius o situats a intervals curts.', 'cultcat_06_llengua_catalana', (select id from public.topics where slug = 'cultcat-06-llengua-catalana'), 3, 'ca', true, (select id from public.sources where url = 'https://dlc.iec.cat/'), 'Al·literació', 'al·literació 1 f. [FL] [FLL] Figura retòrica que consisteix a repetir un mateix so en dos o més mots consecutius o situats a intervals curts.', null, '1b92d3745c2cbbdb03c1e6db5cfa796cc624fd9e49d135c8e621be5507b6dea7', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '1b92d3745c2cbbdb03c1e6db5cfa796cc624fd9e49d135c8e621be5507b6dea7')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Al·literació', true), ('B', 'Anàfora', false), ('C', 'Hipèrbaton', false), ('D', 'Polisèmia', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local', 'guardia-urbana-barcelona');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Què és un diftong?', 'En un diftong la vocal i la semivocal o semiconsonant van en la mateixa síl·laba; si van en síl·labes diferents hi ha hiat.', 'cultcat_06_llengua_catalana', (select id from public.topics where slug = 'cultcat-06-llengua-catalana'), 3, 'ca', true, (select id from public.sources where url = 'https://dlc.iec.cat/'), 'Diftong', 'diftong 1 m. [FL] [LC] Grup fònic format per una vocal i una semivocal o semiconsonant pronunciades dins una mateixa síl·laba.', null, '3fd6449b7c428fe41c9af824f7cbb91eb0c9c355de615f8930411902ea591e24', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '3fd6449b7c428fe41c9af824f7cbb91eb0c9c355de615f8930411902ea591e24')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Dues vocals que es pronuncien en síl·labes diferents', false), ('B', 'Dues consonants que representen un sol so', false), ('C', 'Un grup format per una vocal i una semivocal o semiconsonant pronunciades en una mateixa síl·laba', true), ('D', 'Una vocal tònica marcada amb accent', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local', 'guardia-urbana-barcelona');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'A quina categoria pertanyen mots invariables com «i», «però» o «perquè», que relacionen mots o oracions coordinades o subordinades?', 'La conjunció relaciona mots o oracions coordinades o subordinades; la preposició s''anteposa a un constituent, normalment nominal.', 'cultcat_06_llengua_catalana', (select id from public.topics where slug = 'cultcat-06-llengua-catalana'), 3, 'ca', true, (select id from public.sources where url = 'https://dlc.iec.cat/'), 'Conjunció', 'conjunció 3 2 f. [FL] [LC] Categoria lèxica constituïda per mots invariables que relacionen dos mots o grups de mots d’idèntica funció sintàctica o bé dues oracions coordinades o subordinades.', null, 'f5ad1fb10b5cfa513e3886b625dd305b013189780cd110825bf052eb511f7bcb', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'f5ad1fb10b5cfa513e3886b625dd305b013189780cd110825bf052eb511f7bcb')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Preposició', false), ('B', 'Conjunció', true), ('C', 'Adverbi', false), ('D', 'Pronom', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local', 'guardia-urbana-barcelona');
-- Lote cultcat-07-ciencies-diec-v1 (20 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Diccionari de la llengua catalana, 2a edició (DIEC2), Institut d''Estudis Catalans', 'https://dlc.iec.cat/', 'web_oficial'::public.source_kind, 'Institut d''Estudis Catalans', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('cultcat-07-ciencies', 'Cultura general 7. Ciències: física, química, biologia, ciències de la Terra i medi ambient') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('policia-local', 'guardia-urbana-barcelona') and t.slug = 'cultcat-07-ciencies' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Quina és la unitat estructural i funcional dels éssers vius?', 'La cèl·lula, generalment microscòpica, és formada de citoplasma i un o més nuclis i envoltada d''una membrana.', 'cultcat_07_ciencies', (select id from public.topics where slug = 'cultcat-07-ciencies'), 1, 'ca', true, (select id from public.sources where url = 'https://dlc.iec.cat/'), 'Cèl·lula', 'cèl·lula 1 1 f. [BI] [LC] Unitat estructural i funcional dels éssers vius', null, 'b21481f4d54695500118c4de614f87bd542a19bf6d08264c424709ec64acef7f', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'b21481f4d54695500118c4de614f87bd542a19bf6d08264c424709ec64acef7f')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'L''àtom', false), ('B', 'La molècula', false), ('C', 'La cèl·lula', true), ('D', 'El teixit', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local', 'guardia-urbana-barcelona');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Quin procés fan les plantes per assimilar diòxid de carboni (anhídrid carbònic) gràcies a la llum, alliberant oxigen?', 'La fotosíntesi vegetal utilitza l''aigua i la llum i allibera oxigen.', 'cultcat_07_ciencies', (select id from public.topics where slug = 'cultcat-07-ciencies'), 1, 'ca', true, (select id from public.sources where url = 'https://dlc.iec.cat/'), 'Fotosíntesi', 'fotosíntesi 1 f. [BI] [EG] Assimilació d’anhídrid carbònic per un procés que depèn de la llum. 3 [BI] fotosíntesi vegetal Fotosíntesi que utilitza l’aigua com a font de poder reductor i lliura oxigen.', null, '67628b4131b2a0efeb1b83ea5b14378cecf9ac4aeb04a42047d91e71c189ec6f', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '67628b4131b2a0efeb1b83ea5b14378cecf9ac4aeb04a42047d91e71c189ec6f')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'La respiració cel·lular', false), ('B', 'La fermentació', false), ('C', 'La transpiració', false), ('D', 'La fotosíntesi', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local', 'guardia-urbana-barcelona');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Com s''anomena el preparat que estimula la formació d''anticossos i proporciona immunitat contra infeccions?', 'La vacuna estimula la formació d''anticossos i n''aconsegueix la immunització.', 'cultcat_07_ciencies', (select id from public.topics where slug = 'cultcat-07-ciencies'), 1, 'ca', true, (select id from public.sources where url = 'https://dlc.iec.cat/'), 'Vacuna', 'vacuna f. [LC] [MD] Preparat que estimula la formació d’anticossos, amb la qual cosa hom aconsegueix immunització contra diverses infeccions.', null, '806ef193dba8aab41a605cbc375eb7f278b1462642c877a2e46d321f551cce5e', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '806ef193dba8aab41a605cbc375eb7f278b1462642c877a2e46d321f551cce5e')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Antibiòtic', false), ('B', 'Vacuna', true), ('C', 'Analgèsic', false), ('D', 'Antihistamínic', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local', 'guardia-urbana-barcelona');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Quin és el símbol químic de l''or?', 'L''or té el símbol Au i el nombre atòmic 79; Ag és l''argent.', 'cultcat_07_ciencies', (select id from public.topics where slug = 'cultcat-07-ciencies'), 1, 'ca', true, (select id from public.sources where url = 'https://dlc.iec.cat/'), 'Or, símbol', '(símbol, Au; nombre atòmic, 79; pes atòmic, 196,97)', null, '6e3d7fba42a2e2e174086f1df3e229190ef200ddf80ad30c8bcbdfd53f2a4621', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '6e3d7fba42a2e2e174086f1df3e229190ef200ddf80ad30c8bcbdfd53f2a4621')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Au', true), ('B', 'Or', false), ('C', 'Ag', false), ('D', 'Go', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local', 'guardia-urbana-barcelona');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Quins àtoms formen una molècula d''aigua?', 'La fórmula de l''aigua és H2O.', 'cultcat_07_ciencies', (select id from public.topics where slug = 'cultcat-07-ciencies'), 1, 'ca', true, (select id from public.sources where url = 'https://dlc.iec.cat/'), 'Molècula d''aigua', 'La molècula d’aigua està formada per dos àtoms d’hidrogen i un d’oxigen.', null, 'bd0d41f7b41c1b7805aecd9a93e976e39bebef551c47c283c6bfda9901a49dd3', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'bd0d41f7b41c1b7805aecd9a93e976e39bebef551c47c283c6bfda9901a49dd3')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Un d''hidrogen i dos d''oxigen', false), ('B', 'Dos d''hidrogen i dos d''oxigen', false), ('C', 'Un d''hidrogen, un d''oxigen i un de carboni', false), ('D', 'Dos d''hidrogen i un d''oxigen', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local', 'guardia-urbana-barcelona');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Quina característica defineix la classe dels mamífers?', 'Els mamífers tenen glàndules mamàries; inclouen monotremes, marsupials i placentaris.', 'cultcat_07_ciencies', (select id from public.topics where slug = 'cultcat-07-ciencies'), 1, 'ca', true, (select id from public.sources where url = 'https://dlc.iec.cat/'), 'Mamífers', 'mamífer 2 1 m. pl. [LC] [ZOM] Classe d’animals del grup dels cordats vertebrats, que tenen glàndules mamàries', null, '1fddb17a3ae062515d0574d30434a719cd664652d2e6e6929d198b85d3c64d24', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '1fddb17a3ae062515d0574d30434a719cd664652d2e6e6929d198b85d3c64d24')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Tenen el cos cobert d''escames', false), ('B', 'Respiren per brànquies tota la vida', false), ('C', 'Tenen glàndules mamàries', true), ('D', 'Són tots ovípars', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local', 'guardia-urbana-barcelona');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Com s''anomena l''energia que té un cos a causa del seu moviment?', 'Cinètic vol dir relatiu al moviment o degut al moviment: energia cinètica.', 'cultcat_07_ciencies', (select id from public.topics where slug = 'cultcat-07-ciencies'), 2, 'ca', true, (select id from public.sources where url = 'https://dlc.iec.cat/'), 'Energia cinètica', 'cinètic -a 1 adj. [FIF] Relatiu o pertanyent al moviment. Teoria cinètica dels gasos. 2 adj. [FIF] Degut al moviment. Energia cinètica.', null, '35234350c6eef46e021a1c10f5f31e5a7c7f96ccd31e38758f9ca94d05ef18b5', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '35234350c6eef46e021a1c10f5f31e5a7c7f96ccd31e38758f9ca94d05ef18b5')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Energia cinètica', true), ('B', 'Energia potencial', false), ('C', 'Energia tèrmica', false), ('D', 'Energia química', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local', 'guardia-urbana-barcelona');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Quina magnitud mesura el watt (W) en el sistema internacional?', 'El watt és la unitat de potència i equival a 1 joule per segon; la intensitat es mesura en amperes i la resistència en ohms.', 'cultcat_07_ciencies', (select id from public.topics where slug = 'cultcat-07-ciencies'), 2, 'ca', true, (select id from public.sources where url = 'https://dlc.iec.cat/'), 'Watt', 'watt 1 m. [FIF] [FIM] [LC] Unitat de potència del sistema internacional, equivalent a 1 joule per segon (símbol, W).', null, '6c2d095915004b739cacbc8d7576bca3194714992cb7b79b85092567329f2544', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '6c2d095915004b739cacbc8d7576bca3194714992cb7b79b85092567329f2544')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'L''energia', false), ('B', 'La potència', true), ('C', 'La intensitat de corrent', false), ('D', 'La resistència elèctrica', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local', 'guardia-urbana-barcelona');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Quina és la unitat de força del sistema internacional?', 'El newton és la força necessària per comunicar una acceleració d''1 m/s² a una massa d''1 kg; el joule és la unitat d''energia.', 'cultcat_07_ciencies', (select id from public.topics where slug = 'cultcat-07-ciencies'), 2, 'ca', true, (select id from public.sources where url = 'https://dlc.iec.cat/'), 'Newton', 'newton m. [FIM] Unitat de força del sistema internacional', null, '45d16502a5efa0719c5df1ce47c946c62b4f0053c3f0d5b81916e20aff984bb5', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '45d16502a5efa0719c5df1ce47c946c62b4f0053c3f0d5b81916e20aff984bb5')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El joule (J)', false), ('B', 'El pascal (Pa)', false), ('C', 'El newton (N)', true), ('D', 'El watt (W)', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local', 'guardia-urbana-barcelona');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Com s''anomena el pas d''una substància de l''estat de vapor a l''estat líquid?', 'La condensació és el pas de vapor a líquid; l''evaporació, de líquid a vapor.', 'cultcat_07_ciencies', (select id from public.topics where slug = 'cultcat-07-ciencies'), 2, 'ca', true, (select id from public.sources where url = 'https://dlc.iec.cat/'), 'Condensació', 'condensació 1 2 f. [FIF] [IQ] Pas d’una substància de l’estat de vapor a l’estat líquid.', null, '5832fb11b8abc845158a554ad90eeeadc2f86c9c5d0500850e01fb604db320fe', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '5832fb11b8abc845158a554ad90eeeadc2f86c9c5d0500850e01fb604db320fe')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Condensació', true), ('B', 'Evaporació', false), ('C', 'Sublimació', false), ('D', 'Solidificació', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local', 'guardia-urbana-barcelona');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Com s''anomena la regió de comunicació i transmissió d''impulsos nerviosos entre neurones?', 'La sinapsi és la regió de contacte i transmissió entre neurones, o entre una neurona motora i el múscul.', 'cultcat_07_ciencies', (select id from public.topics where slug = 'cultcat-07-ciencies'), 2, 'ca', true, (select id from public.sources where url = 'https://dlc.iec.cat/'), 'Sinapsi', 'sinapsi 1 f. [MD] [ZOA] Regió de comunicació i de transmissió d’impulsos nerviosos entre les neurones o entre una neurona motora i el múscul.', null, '511dcbc50f712b322ff4196f82f12882a7894987c1a2577607e470c1ec04c20c', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '511dcbc50f712b322ff4196f82f12882a7894987c1a2577607e470c1ec04c20c')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Axó', false), ('B', 'Dendrita', false), ('C', 'Mielina', false), ('D', 'Sinapsi', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local', 'guardia-urbana-barcelona');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'A quina classe d''animals pertanyen les granotes, els gripaus, els tritons i les salamandres?', 'Els amfibis passen per un estat de larva aquàtica amb brànquies; les serps i els cocodrils són rèptils.', 'cultcat_07_ciencies', (select id from public.topics where slug = 'cultcat-07-ciencies'), 2, 'ca', true, (select id from public.sources where url = 'https://dlc.iec.cat/'), 'Amfibis', 'que inclou les granotes, els gripaus, els tritons i les salamandres.', null, '62228f705531c75f9b4d35edfea449ef4839138a678cf975faf557fb8db6284f', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '62228f705531c75f9b4d35edfea449ef4839138a678cf975faf557fb8db6284f')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Rèptils', false), ('B', 'Amfibis', true), ('C', 'Peixos', false), ('D', 'Mamífers', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local', 'guardia-urbana-barcelona');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Quina és la capa de l''atmosfera situada entre la superfície de la Terra i uns 10-17 km d''altitud, on la temperatura disminueix amb l''altitud?', 'A la troposfera la temperatura decreix amb l''altitud; a l''estratosfera (12-50 km) creix.', 'cultcat_07_ciencies', (select id from public.topics where slug = 'cultcat-07-ciencies'), 2, 'ca', true, (select id from public.sources where url = 'https://dlc.iec.cat/'), 'Troposfera', 'troposfera f. [ME] Capa de l’atmosfera terrestre situada entre la superfície de la Terra i la tropopausa, que s’estén fins a uns 10 o 17 quilòmetres d’altitud segons la latitud, i on la temperatura decreix gradualment amb l’altitud.', null, '2103b18c0dec2f3230c603d26fd5c82c3c6eb0eab804a606ed02ad44d78949b1', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '2103b18c0dec2f3230c603d26fd5c82c3c6eb0eab804a606ed02ad44d78949b1')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'L''estratosfera', false), ('B', 'La mesosfera', false), ('C', 'La troposfera', true), ('D', 'La ionosfera', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local', 'guardia-urbana-barcelona');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Quina és la fórmula de l''ozó, el gas que absorbeix la radiació ultraviolada?', 'L''ozó (O3) és una forma al·lotròpica de l''oxigen (O2).', 'cultcat_07_ciencies', (select id from public.topics where slug = 'cultcat-07-ciencies'), 2, 'ca', true, (select id from public.sources where url = 'https://dlc.iec.cat/'), 'Ozó', 'ozó m. [FIF] [LC] [ME] [QU] Gas blavós d’olor característica, de fórmula O3, fortament absorbent de la radiació ultraviolada de longitud d’ona curta, que és un estat al·lotròpic de l’oxigen (O2).', null, 'b5626f9cef2d14d6dd406568d8675301a144aea0d1abe6a3e336bbd9b4140bc9', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'b5626f9cef2d14d6dd406568d8675301a144aea0d1abe6a3e336bbd9b4140bc9')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'O3', true), ('B', 'O2', false), ('C', 'CO2', false), ('D', 'H2O2', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local', 'guardia-urbana-barcelona');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Com s''anomena la concreció calcària que penja de la volta d''una cova, originada per un degotall?', 'L''estalactita penja del sostre; l''estalagmita creix des de terra.', 'cultcat_07_ciencies', (select id from public.topics where slug = 'cultcat-07-ciencies'), 2, 'ca', true, (select id from public.sources where url = 'https://dlc.iec.cat/'), 'Estalactita', 'estalactita f. [GL] [LC] Concreció generalment calcària i de forma cilíndrica, amb un canalicle paral·lel a l’eix longitudinal, originada per un degotall, que penja de la volta de les coves.', null, '0c22135cf175173feaf1882dce9ab0ab536071baba43a0a2778d986e6ef2eef6', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '0c22135cf175173feaf1882dce9ab0ab536071baba43a0a2778d986e6ef2eef6')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Estalagmita', false), ('B', 'Estalactita', true), ('C', 'Dolina', false), ('D', 'Avenc', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local', 'guardia-urbana-barcelona');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'En quina reacció es formen nous nuclis atòmics per unió d''altres de més lleugers, amb alliberament de grans quantitats d''energia?', 'En la fusió nuclear els nuclis lleugers s''uneixen; en la fissió, un nucli pesant es divideix.', 'cultcat_07_ciencies', (select id from public.topics where slug = 'cultcat-07-ciencies'), 3, 'ca', true, (select id from public.sources where url = 'https://dlc.iec.cat/'), 'Fusió nuclear', 'fusió nuclear Reacció nuclear en què es formen nous nuclis atòmics per associació d’altres de més lleugers amb pèrdua de massa, pèrdua que es manifesta amb l’alliberament de grans quantitats d’energia.', null, 'f778b2f1c5bd95584cf4a385a7ad53127bbd8ed2a4a0bed44f2ddad21ef688a7', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'f778b2f1c5bd95584cf4a385a7ad53127bbd8ed2a4a0bed44f2ddad21ef688a7')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'La fissió nuclear', false), ('B', 'La combustió', false), ('C', 'L''electròlisi', false), ('D', 'La fusió nuclear', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local', 'guardia-urbana-barcelona');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Com s''anomena l''enfonsament d''una placa litosfèrica sota una altra?', 'La subducció és un procés de la tectònica de plaques; l''erosió és el despreniment i transport de materials en superfície.', 'cultcat_07_ciencies', (select id from public.topics where slug = 'cultcat-07-ciencies'), 3, 'ca', true, (select id from public.sources where url = 'https://dlc.iec.cat/'), 'Subducció', 'subducció f. [GL] Enfonsament de gran amplitud d’una placa litosfèrica sota d’una altra.', null, '198c24602b751322eaee971359fe9a2d6b4e6c88be852e57dee016cda8e4a1b3', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '198c24602b751322eaee971359fe9a2d6b4e6c88be852e57dee016cda8e4a1b3')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Erosió', false), ('B', 'Sedimentació', false), ('C', 'Orogènesi', false), ('D', 'Subducció', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local', 'guardia-urbana-barcelona');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Què és una gota freda?', 'La gota freda s''origina en la troposfera mitjana o alta i pot provocar pluges torrencials a la costa mediterrània.', 'cultcat_07_ciencies', (select id from public.topics where slug = 'cultcat-07-ciencies'), 3, 'ca', true, (select id from public.sources where url = 'https://dlc.iec.cat/'), 'Gota freda', 'gota freda Depressió atmosfèrica freda en altura les característiques de la qual s’originen en la circulació de la troposfera mitjana o alta i que en superfície no es correspon amb una zona depressionària.', null, '8a756d0abd99e932f16e7d403dd12243f455796c89efbe8cf8bcce52c4005347', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '8a756d0abd99e932f16e7d403dd12243f455796c89efbe8cf8bcce52c4005347')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Una depressió atmosfèrica freda en altura que en superfície no es correspon amb una zona de baixes pressions', true), ('B', 'Un anticicló d''aire fred situat a nivell del mar', false), ('C', 'Una pluja de gel de gra gros', false), ('D', 'Un vent fred i sec que baixa de les muntanyes', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local', 'guardia-urbana-barcelona');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Quin metall és líquid a temperatura ordinària i té el símbol Hg?', 'El mercuri (Hg, nombre atòmic 80) és líquid a temperatura ambient; el gal·li fon a 29,7 °C.', 'cultcat_07_ciencies', (select id from public.topics where slug = 'cultcat-07-ciencies'), 3, 'ca', true, (select id from public.sources where url = 'https://dlc.iec.cat/'), 'Mercuri', 'mercuri m. [LC] [ML] [QU] Metall líquid a la temperatura ordinària, molt pesant, de color blanc d’argent (símbol, Hg', null, 'd8407152c55fddf69bb8313b965247c843e866ff5c7633572e6f16c6ae271d4e', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'd8407152c55fddf69bb8313b965247c843e866ff5c7633572e6f16c6ae271d4e')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El gal·li', false), ('B', 'El plom', false), ('C', 'El mercuri', true), ('D', 'El platí', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local', 'guardia-urbana-barcelona');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Quina magnitud es mesura en ohms (Ω)?', 'L''ohm és la resistència d''un conductor que deixa passar 1 ampere quan se li aplica 1 volt.', 'cultcat_07_ciencies', (select id from public.topics where slug = 'cultcat-07-ciencies'), 3, 'ca', true, (select id from public.sources where url = 'https://dlc.iec.cat/'), 'Ohm', 'ohm 1 m. [FIM] Unitat de resistència elèctrica del sistema internacional', null, 'c8a6fc3ce9fe718640022542155ad372cb7705fad3f9e82c0299cb51281133ee', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'c8a6fc3ce9fe718640022542155ad372cb7705fad3f9e82c0299cb51281133ee')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'La intensitat de corrent', false), ('B', 'La resistència elèctrica', true), ('C', 'La diferència de potencial', false), ('D', 'La potència elèctrica', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local', 'guardia-urbana-barcelona');
-- Lote cultcat-08-matematiques-diec-v1 (20 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Diccionari de la llengua catalana, 2a edició (DIEC2), Institut d''Estudis Catalans', 'https://dlc.iec.cat/', 'web_oficial'::public.source_kind, 'Institut d''Estudis Catalans', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('cultcat-08-matematiques', 'Cultura general 8. Matemàtiques: aritmètica, geometria i estadística bàsiques') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('policia-local', 'guardia-urbana-barcelona') and t.slug = 'cultcat-08-matematiques' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Quin és el perímetre d''un rectangle de 8 m de llarg i 5 m d''ample?', 'El perímetre és el contorn de la figura: 8 + 5 + 8 + 5 = 26 m. 40 m² seria l''àrea.', 'cultcat_08_matematiques', (select id from public.topics where slug = 'cultcat-08-matematiques'), 1, 'ca', true, (select id from public.sources where url = 'https://dlc.iec.cat/'), 'Perímetre', 'perímetre 1 1 m. [LC] [MT] Contorn d’una figura plana.', null, '6d3f8e4bdd009dbe880720d66adce6b0eae7b7310cb4de7fa4ba4949da21b807', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '6d3f8e4bdd009dbe880720d66adce6b0eae7b7310cb4de7fa4ba4949da21b807')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', '26 m', true), ('B', '40 m', false), ('C', '13 m', false), ('D', '80 m', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local', 'guardia-urbana-barcelona');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Si el radi d''un cercle fa 7 cm, quant fa el diàmetre?', 'El diàmetre val dos radis: 2 × 7 = 14 cm.', 'cultcat_08_matematiques', (select id from public.topics where slug = 'cultcat-08-matematiques'), 1, 'ca', true, (select id from public.sources where url = 'https://dlc.iec.cat/'), 'Diàmetre', 'El diàmetre d’un cercle val tant com dos radis.', null, '398e44a7be608d5ac064d06ea551d7331475aea94a85b74dcc1a33718a988532', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '398e44a7be608d5ac064d06ea551d7331475aea94a85b74dcc1a33718a988532')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', '3,5 cm', false), ('B', '14 cm', true), ('C', '21 cm', false), ('D', '49 cm', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local', 'guardia-urbana-barcelona');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Quants costats té un hexàgon?', 'L''hexàgon té sis angles i sis costats; el pentàgon, cinc.', 'cultcat_08_matematiques', (select id from public.topics where slug = 'cultcat-08-matematiques'), 1, 'ca', true, (select id from public.sources where url = 'https://dlc.iec.cat/'), 'Hexàgon', 'hexàgon m. [MT] Polígon de sis angles i de sis costats.', null, 'ea762805e7ec526ce8eec71e87835c4e0a96d8b2ef9428fa21ca8701bb3c0b35', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'ea762805e7ec526ce8eec71e87835c4e0a96d8b2ef9428fa21ca8701bb3c0b35')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', '5', false), ('B', '7', false), ('C', '8', false), ('D', '6', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local', 'guardia-urbana-barcelona');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Quants dies té un any de traspàs (bixest)?', 'L''any comú té 365 dies i l''any de traspàs, 366.', 'cultcat_08_matematiques', (select id from public.topics where slug = 'cultcat-08-matematiques'), 1, 'ca', true, (select id from public.sources where url = 'https://dlc.iec.cat/'), 'Any de traspàs', 'any 3 5 [FIA] any comú Any civil que consta de 365 dies. 3 6 [FIA] [LC] any de traspàs Any civil que consta de 366 dies.', null, '0de0d393458c53d989d01a6f2297e1527a25870d5ec4d2a5b1cb98b5797b266c', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '0de0d393458c53d989d01a6f2297e1527a25870d5ec4d2a5b1cb98b5797b266c')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', '365', false), ('B', '364', false), ('C', '366', true), ('D', '360', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local', 'guardia-urbana-barcelona');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Quant és el 25% de 80?', 'Un percentatge és un tant per cent: 80 × 25 / 100 = 20.', 'cultcat_08_matematiques', (select id from public.topics where slug = 'cultcat-08-matematiques'), 1, 'ca', true, (select id from public.sources where url = 'https://dlc.iec.cat/'), 'Percentatge', 'percentatge m. [LC] [MT] Tant per cent.', null, 'c1d297de69a8d2525dba18c4d78dc8b4aaf5111fdae44c14c25a5f88df1b4f55', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'c1d297de69a8d2525dba18c4d78dc8b4aaf5111fdae44c14c25a5f88df1b4f55')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', '20', true), ('B', '25', false), ('C', '32', false), ('D', '4', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local', 'guardia-urbana-barcelona');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Com s''anomena el triangle que té tots els costats iguals?', 'L''equilàter té tots els costats iguals; l''isòsceles, dos.', 'cultcat_08_matematiques', (select id from public.topics where slug = 'cultcat-08-matematiques'), 1, 'ca', true, (select id from public.sources where url = 'https://dlc.iec.cat/'), 'Triangle equilàter', 'equilàter -a adj. [LC] [MT] Que té tots els costats iguals.', null, '6b6eadd763354bec690f7f3c30f9ddf2b6862ba5d065add711c9dd8fb71c73f1', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '6b6eadd763354bec690f7f3c30f9ddf2b6862ba5d065add711c9dd8fb71c73f1')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Isòsceles', false), ('B', 'Escalè', false), ('C', 'Equilàter', true), ('D', 'Rectangle', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local', 'guardia-urbana-barcelona');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'En un triangle rectangle els catets fan 6 cm i 8 cm. Quant fa la hipotenusa?', 'Pel teorema de Pitàgores: 6² + 8² = 36 + 64 = 100, i l''arrel quadrada de 100 és 10.', 'cultcat_08_matematiques', (select id from public.topics where slug = 'cultcat-08-matematiques'), 2, 'ca', true, (select id from public.sources where url = 'https://dlc.iec.cat/'), 'Hipotenusa', 'hipotenusa f. [LC] [MT] Costat d’un triangle rectangle oposat a l’angle recte. El quadrat de la hipotenusa és igual a la suma dels quadrats dels catets.', null, 'fea5054c73fa5fd79bb24e0e14ef1f733aeae3f824620911aac031b0505c7fee', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'fea5054c73fa5fd79bb24e0e14ef1f733aeae3f824620911aac031b0505c7fee')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', '14 cm', false), ('B', '12 cm', false), ('C', '48 cm', false), ('D', '10 cm', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local', 'guardia-urbana-barcelona');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Com s''anomena un triangle que té dos costats iguals?', 'Isòsceles s''aplica als triangles o trapezis amb dos costats iguals.', 'cultcat_08_matematiques', (select id from public.topics where slug = 'cultcat-08-matematiques'), 2, 'ca', true, (select id from public.sources where url = 'https://dlc.iec.cat/'), 'Isòsceles', 'isòsceles adj. [LC] [MT] Que té dos costats iguals, s’aplica als triangles o als trapezis.', null, 'b029f15dac4a334bd0e5dacd3e3211496dcb202411fcfa277c4fa1ad93cdb50c', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'b029f15dac4a334bd0e5dacd3e3211496dcb202411fcfa277c4fa1ad93cdb50c')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Equilàter', false), ('B', 'Isòsceles', true), ('C', 'Escalè', false), ('D', 'Obtusangle', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local', 'guardia-urbana-barcelona');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'En la sèrie de dades 3, 5, 5, 7, 9, 5, 7, quina és la moda?', 'La moda és el valor més freqüent: el 5 apareix tres vegades.', 'cultcat_08_matematiques', (select id from public.topics where slug = 'cultcat-08-matematiques'), 2, 'ca', true, (select id from public.sources where url = 'https://dlc.iec.cat/'), 'Moda estadística', 'moda 2 f. [MT] En estad., valor de l’observació més freqüent en un conjunt de dades.', null, '35c9573779d485046b2e8b2e11805a893137c6b492604e07f614a5e3acde5f80', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '35c9573779d485046b2e8b2e11805a893137c6b492604e07f614a5e3acde5f80')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', '7', false), ('B', '6', false), ('C', '5', true), ('D', '3', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local', 'guardia-urbana-barcelona');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Quina és la mitjana aritmètica de 4, 8, 10 i 14?', 'La suma és 36 i, dividida entre 4 valors, dona 9.', 'cultcat_08_matematiques', (select id from public.topics where slug = 'cultcat-08-matematiques'), 2, 'ca', true, (select id from public.sources where url = 'https://dlc.iec.cat/'), 'Mitjana aritmètica', 'mitjà2 -ana 2 adj. [LC] [MT] Que correspon a la mitjana aritmètica, s’aplica a noms que expressen quantitat.', null, 'd8262b93bbb5339e793857aac22c78fbeb11a19975240da481639dfdeb674a0e', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'd8262b93bbb5339e793857aac22c78fbeb11a19975240da481639dfdeb674a0e')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', '10', false), ('B', '9', true), ('C', '8', false), ('D', '36', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local', 'guardia-urbana-barcelona');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Quin d''aquests nombres és múltiple de 4?', 'Un múltiple conté el nombre un nombre exacte de vegades: 12 = 4 × 3.', 'cultcat_08_matematiques', (select id from public.topics where slug = 'cultcat-08-matematiques'), 2, 'ca', true, (select id from public.sources where url = 'https://dlc.iec.cat/'), 'Múltiple', 'El nombre 12 és un múltiple de 4.', null, '00cc1dbcb889ea90cedc85a8e6f28776bcd001a2e877fffd23243ec806e3b17a', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '00cc1dbcb889ea90cedc85a8e6f28776bcd001a2e877fffd23243ec806e3b17a')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', '12', true), ('B', '10', false), ('C', '14', false), ('D', '18', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local', 'guardia-urbana-barcelona');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Quin resultat s''obté en elevar 7 al quadrat?', 'Elevar al quadrat és multiplicar el nombre per ell mateix: 7 × 7 = 49.', 'cultcat_08_matematiques', (select id from public.topics where slug = 'cultcat-08-matematiques'), 2, 'ca', true, (select id from public.sources where url = 'https://dlc.iec.cat/'), 'Quadrat d''un nombre', 'quadrar 1 3 v. tr. [MT] Elevar (un nombre) al quadrat, multiplicar-lo per ell mateix.', null, 'cc87af50f8db02d700ac15d4f4b0da8edd70953b3b7b268aef263f63fa662758', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'cc87af50f8db02d700ac15d4f4b0da8edd70953b3b7b268aef263f63fa662758')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', '14', false), ('B', '21', false), ('C', '77', false), ('D', '49', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local', 'guardia-urbana-barcelona');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Quina suma dels costats té un pentàgon regular de 6 cm de costat?', 'El pentàgon té cinc costats: 5 × 6 = 30 cm (amb sis costats, un hexàgon, serien 36 cm).', 'cultcat_08_matematiques', (select id from public.topics where slug = 'cultcat-08-matematiques'), 2, 'ca', true, (select id from public.sources where url = 'https://dlc.iec.cat/'), 'Pentàgon', 'pentàgon m. [MT] Polígon de cinc angles i de cinc costats.', null, 'f18fba63a59e00e1e77890243b98173bdce690e01be9ad3e69f80eaf19122d8a', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'f18fba63a59e00e1e77890243b98173bdce690e01be9ad3e69f80eaf19122d8a')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', '36 cm', false), ('B', '24 cm', false), ('C', '30 cm', true), ('D', '42 cm', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local', 'guardia-urbana-barcelona');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Quin any representa en xifres romanes MCDXCII?', 'M = 1000, CD = 400, XC = 90 i II = 2: 1492. Les xifres romanes són I, V, X, L, C, D i M.', 'cultcat_08_matematiques', (select id from public.topics where slug = 'cultcat-08-matematiques'), 2, 'ca', true, (select id from public.sources where url = 'https://dlc.iec.cat/'), 'Xifra romana', 'xifra romana Lletra majúscula emprada pels romans per a representar els nombres: I, V, X, L, C, D, M.', null, 'eb3b1e4f9e35332408981b3626a1aa6c18425d8f464dc83f62f3af6dbe0f27ae', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'eb3b1e4f9e35332408981b3626a1aa6c18425d8f464dc83f62f3af6dbe0f27ae')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', '1492', true), ('B', '1592', false), ('C', '1412', false), ('D', '1942', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local', 'guardia-urbana-barcelona');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Com s''anomena la corba plana els punts de la qual són tots a la mateixa distància d''un punt interior, el centre?', 'Tots els punts de la circumferència equidisten del centre; aquesta distància és el radi.', 'cultcat_08_matematiques', (select id from public.topics where slug = 'cultcat-08-matematiques'), 2, 'ca', true, (select id from public.sources where url = 'https://dlc.iec.cat/'), 'Circumferència', 'circumferència 1 1 f. [LC] [MT] Corba plana els punts de la qual equidisten tots d’un punt interior, el centre.', null, '340216e2197673acb5b0083e5e26c4c7eaa5a6855963f45d197ded0e09d294ec', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '340216e2197673acb5b0083e5e26c4c7eaa5a6855963f45d197ded0e09d294ec')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El·lipse', false), ('B', 'Paràbola', false), ('C', 'Hipèrbola', false), ('D', 'Circumferència', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local', 'guardia-urbana-barcelona');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Quina propietat expressa la igualtat 3 × 5 = 5 × 3?', 'Una operació és commutativa quan l''ordre dels elements no canvia el resultat, com la suma i el producte de nombres reals.', 'cultcat_08_matematiques', (select id from public.topics where slug = 'cultcat-08-matematiques'), 3, 'ca', true, (select id from public.sources where url = 'https://dlc.iec.cat/'), 'Propietat commutativa', 'commutatiu -iva 3 1 adj. [MT] En què l’ordre dels elements no canvia el resultat, s’aplica a operacions aritmètiques. La suma i el producte de nombres reals són commutatius.', null, '60cf50971ac1d7f60723941bd04b9a6e5b45813823b695db08049fdecd7d9008', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '60cf50971ac1d7f60723941bd04b9a6e5b45813823b695db08049fdecd7d9008')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'La propietat associativa', false), ('B', 'La propietat commutativa', true), ('C', 'La propietat distributiva', false), ('D', 'L''element neutre', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local', 'guardia-urbana-barcelona');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Quin valor de x resol l''equació 3x - 4 = 11?', 'Una equació és una igualtat amb incògnites: 3x = 15, per tant x = 5.', 'cultcat_08_matematiques', (select id from public.topics where slug = 'cultcat-08-matematiques'), 3, 'ca', true, (select id from public.sources where url = 'https://dlc.iec.cat/'), 'Equació', 'equació 2 1 f. [MT] En mat., igualtat entre dues expressions que contenen una o més incògnites.', null, '3a06e89d70a133af03bc836b004815a579d748056678dbbcc90871be38018d8f', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '3a06e89d70a133af03bc836b004815a579d748056678dbbcc90871be38018d8f')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', '5', true), ('B', '7/3', false), ('C', '15', false), ('D', '3', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local', 'guardia-urbana-barcelona');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Quina és la probabilitat d''obtenir un nombre parell en llançar un dau de sis cares?', 'Hi ha tres casos favorables (2, 4 i 6) de sis possibles: 3/6 = 1/2.', 'cultcat_08_matematiques', (select id from public.topics where slug = 'cultcat-08-matematiques'), 3, 'ca', true, (select id from public.sources where url = 'https://dlc.iec.cat/'), 'Probabilitat', 'probabilitat 2 f. [MT] Concepte que permet d’expressar quantitativament el caràcter aleatori d’un esdeveniment o fenomen que hom creu que pot succeir.', null, 'cf99567921190690b4e4e88e69d4a5bd67fcf1a12189f29c83c608ddea4b61c9', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'cf99567921190690b4e4e88e69d4a5bd67fcf1a12189f29c83c608ddea4b61c9')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', '1/6', false), ('B', '1/2', true), ('C', '1/3', false), ('D', '2/3', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local', 'guardia-urbana-barcelona');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Quin és el màxim comú divisor de 18 i 24?', 'Els divisors comuns de 18 i 24 són 1, 2, 3 i 6; el més gran és 6 (72 és el mínim comú múltiple). El DIEC posa l''exemple de 16 i 20, amb MCD 4.', 'cultcat_08_matematiques', (select id from public.topics where slug = 'cultcat-08-matematiques'), 3, 'ca', true, (select id from public.sources where url = 'https://dlc.iec.cat/'), 'Màxim comú divisor', 'divisor comú Nombre que és divisor de dues o més quantitats alhora. El més gran divisor comú de 16 i 20 és 4.', null, '0bb25e1c6326afb9035a8569a2e3ea5a4e71c3fb2d58deb51c3db06fabca9c3e', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '0bb25e1c6326afb9035a8569a2e3ea5a4e71c3fb2d58deb51c3db06fabca9c3e')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', '3', false), ('B', '12', false), ('C', '6', true), ('D', '72', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local', 'guardia-urbana-barcelona');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Quant són els 3/4 de 60?', 'Una fracció representa parts de la unitat: 60 / 4 = 15 i 15 × 3 = 45.', 'cultcat_08_matematiques', (select id from public.topics where slug = 'cultcat-08-matematiques'), 3, 'ca', true, (select id from public.sources where url = 'https://dlc.iec.cat/'), 'Fracció', 'fracció 2 2 f. [LC] [MT] En mat., una o més parts alíquotes de la unitat.', null, 'a5f4894dc106dcd22ec4fc3d9b5a4a097ffbc134503c169d85a7ccddc8306ae5', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'a5f4894dc106dcd22ec4fc3d9b5a4a097ffbc134503c169d85a7ccddc8306ae5')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', '15', false), ('B', '20', false), ('C', '80', false), ('D', '45', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local', 'guardia-urbana-barcelona');
-- Lote cultcat-09-institucions-economia-ce-v1 (6 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Constitución Española (texto consolidado, BOE)', 'https://www.boe.es/buscar/act.php?id=BOE-A-1978-31229', 'boe'::public.source_kind, 'Agencia Estatal Boletín Oficial del Estado', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('cultcat-09-institucions-economia', 'Cultura general 9. Institucions (Catalunya, Espanya, UE, ONU) i economia bàsica') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('policia-local', 'guardia-urbana-barcelona') and t.slug = 'cultcat-09-institucions-economia' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Quina és la forma política de l''Estat espanyol segons la Constitució?', 'L''article 1.3 de la Constitució estableix que la forma política de l''Estat espanyol és la monarquia parlamentària.', 'cultcat_09_institucions_economia', (select id from public.topics where slug = 'cultcat-09-institucions-economia'), 1, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1978-31229'), 'CE art. 1.3, forma política', 'La forma política del Estado español es la Monarquía parlamentaria.', null, 'af35f50d759706345fbe9b8d6dbaab2abee657e3bcc375cfd19972bd22e5c9db', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'af35f50d759706345fbe9b8d6dbaab2abee657e3bcc375cfd19972bd22e5c9db')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'La monarquia parlamentària', true), ('B', 'La república federal', false), ('C', 'La monarquia absoluta', false), ('D', 'La república presidencialista', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local', 'guardia-urbana-barcelona');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Quines cambres formen les Corts Generals?', 'Les Corts Generals representen el poble espanyol i estan formades pel Congrés i el Senat (art. 66.1 CE).', 'cultcat_09_institucions_economia', (select id from public.topics where slug = 'cultcat-09-institucions-economia'), 1, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1978-31229'), 'CE art. 66.1, Corts Generals', 'Las Cortes Generales representan al pueblo español y están formadas por el Congreso de los Diputados y el Senado.', null, '9c2c646d20c3524db182f33dd58f1e5c72730c741a11d4c7248a8cf9dc32afb7', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '9c2c646d20c3524db182f33dd58f1e5c72730c741a11d4c7248a8cf9dc32afb7')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El Congrés dels Diputats i el Govern', false), ('B', 'El Congrés dels Diputats i el Senat', true), ('C', 'El Senat i el Tribunal Constitucional', false), ('D', 'El Congrés, el Senat i els parlaments autonòmics', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local', 'guardia-urbana-barcelona');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Quants diputats pot tenir el Congrés dels Diputats segons la Constitució?', 'L''article 68.1 fixa entre 300 i 400 diputats; la llei electoral n''estableix 350.', 'cultcat_09_institucions_economia', (select id from public.topics where slug = 'cultcat-09-institucions-economia'), 2, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1978-31229'), 'CE art. 68.1, Congrés', 'El Congreso se compone de un mínimo de 300 y un máximo de 400 Diputados', null, 'fd065bc5f87187b0e8dc9e747aba32cc3bf20f4593f4e6889506d9b5978b2939', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'fd065bc5f87187b0e8dc9e747aba32cc3bf20f4593f4e6889506d9b5978b2939')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Entre 100 i 150', false), ('B', 'Exactament 350', false), ('C', 'Entre 200 i 300', false), ('D', 'Entre 300 i 400', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local', 'guardia-urbana-barcelona');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Com defineix la Constitució el Senat?', 'El Senat és la cambra de representació territorial; a cada província s''hi elegeixen quatre senadors.', 'cultcat_09_institucions_economia', (select id from public.topics where slug = 'cultcat-09-institucions-economia'), 2, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1978-31229'), 'CE art. 69.1, Senat', 'El Senado es la Cámara de representación territorial.', null, 'fed229011ad6c9c3e15a6f764ea3d2d9a9e074a192e02f4f685641cc512439b1', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'fed229011ad6c9c3e15a6f764ea3d2d9a9e074a192e02f4f685641cc512439b1')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Com l''òrgan suprem del poder judicial', false), ('B', 'Com la cambra de representació territorial', true), ('C', 'Com la cambra que elegeix el president del Govern', false), ('D', 'Com l''òrgan consultiu del Govern', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local', 'guardia-urbana-barcelona');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Per a quant de temps són designats els 12 membres del Tribunal Constitucional?', 'Els 12 magistrats els nomena el Rei i són designats per nou anys, amb renovació per terceres parts cada tres.', 'cultcat_09_institucions_economia', (select id from public.topics where slug = 'cultcat-09-institucions-economia'), 3, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1978-31229'), 'CE art. 159, Tribunal Constitucional', 'Los miembros del Tribunal Constitucional serán designados por un período de nueve años y se renovarán por terceras partes cada tres.', null, '258498a176544fce869e366e427b28f513fcbe11f6c92ffe90bb1d1fdaab9779', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '258498a176544fce869e366e427b28f513fcbe11f6c92ffe90bb1d1fdaab9779')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Per nou anys, i es renoven per terços cada tres anys', true), ('B', 'Per sis anys, i es renoven per meitats cada tres anys', false), ('C', 'Per quatre anys, coincidint amb la legislatura', false), ('D', 'Amb caràcter vitalici', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local', 'guardia-urbana-barcelona');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 137 de la Constitució, en quines entitats s''organitza territorialment l''Estat?', 'L''article 137 enumera municipis, províncies i comunitats autònomes, totes amb autonomia per a la gestió dels seus interessos.', 'cultcat_09_institucions_economia', (select id from public.topics where slug = 'cultcat-09-institucions-economia'), 3, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1978-31229'), 'CE art. 137, organització territorial', 'El Estado se organiza territorialmente en municipios, en provincias y en las Comunidades Autónomas que se constituyan.', null, 'd5736b438d23850ef4570f54322992299ed26427f45c9de6171eb19e1121fa7f', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'd5736b438d23850ef4570f54322992299ed26427f45c9de6171eb19e1121fa7f')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'En municipis, en comarques i en comunitats autònomes', false), ('B', 'En províncies, en vegueries i en regions', false), ('C', 'Només en comunitats autònomes i municipis', false), ('D', 'En municipis, en províncies i en les comunitats autònomes que es constitueixin', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local', 'guardia-urbana-barcelona');
-- Lote cultcat-09-institucions-economia-consue26-v1 (1 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Presidency of the Council of the EU (Irish Presidency, July-December 2026)', 'https://irish-presidency.consilium.europa.eu/en/presidency/presidency-of-the-council-of-the-eu/', 'web_oficial'::public.source_kind, 'Council of the European Union', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('cultcat-09-institucions-economia', 'Cultura general 9. Institucions (Catalunya, Espanya, UE, ONU) i economia bàsica') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('policia-local', 'guardia-urbana-barcelona') and t.slug = 'cultcat-09-institucions-economia' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Quina d''aquestes afirmacions sobre el Consell d''Europa és correcta?', 'El Consell d''Europa (1949, 46 membres) promou la democràcia i els drets humans; no s''ha de confondre amb el Consell Europeu ni amb el Consell de la UE.', 'cultcat_09_institucions_economia', (select id from public.topics where slug = 'cultcat-09-institucions-economia'), 3, 'ca', true, (select id from public.sources where url = 'https://irish-presidency.consilium.europa.eu/en/presidency/presidency-of-the-council-of-the-eu/'), 'Consell d''Europa', 'The Council of Europe is not an EU institution. It is a separate international organisation, founded in 1949, that promotes democracy, human rights, and the rule of law across its 46 member countries.', null, '60b6df8a2605ca5693ad201dd979ab72a6a24f808977394d38a46272541ea3cd', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '60b6df8a2605ca5693ad201dd979ab72a6a24f808977394d38a46272541ea3cd')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'És la institució de la UE formada pels caps d''estat o de govern dels 27', false), ('B', 'No és una institució de la UE: és una organització internacional fundada el 1949 amb 46 estats membres', true), ('C', 'És el nom oficial del Consell de la UE, presidit per torns de sis mesos', false), ('D', 'Va ser creat pel Tractat de Lisboa el 2009', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local', 'guardia-urbana-barcelona');
-- Lote cultcat-09-institucions-economia-diec-v1 (2 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Diccionari de la llengua catalana, 2a edició (DIEC2), Institut d''Estudis Catalans', 'https://dlc.iec.cat/', 'web_oficial'::public.source_kind, 'Institut d''Estudis Catalans', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('cultcat-09-institucions-economia', 'Cultura general 9. Institucions (Catalunya, Espanya, UE, ONU) i economia bàsica') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('policia-local', 'guardia-urbana-barcelona') and t.slug = 'cultcat-09-institucions-economia' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Com s''anomena l''increment generalitzat i persistent dels preus, que redueix el poder adquisitiu dels diners?', 'La inflació implica una reducció del poder adquisitiu; es mesura habitualment amb l''IPC.', 'cultcat_09_institucions_economia', (select id from public.topics where slug = 'cultcat-09-institucions-economia'), 1, 'ca', true, (select id from public.sources where url = 'https://dlc.iec.cat/'), 'Inflació', 'inflació 2 1 f. [ECT] [LC] Increment generalitzat i persistent dels preus de les mercaderies i els serveis que implica una reducció del poder adquisitiu del diner.', null, 'ad31026c3157dc82db085a4f55f80099cb645351aea150a1280906e5883a2e56', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'ad31026c3157dc82db085a4f55f80099cb645351aea150a1280906e5883a2e56')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Deflació', false), ('B', 'Dèficit', false), ('C', 'Inflació', true), ('D', 'Recessió', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local', 'guardia-urbana-barcelona');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Què és l''euro?', 'L''euro és la moneda dels estats de la UE que participen en la unió monetària (21 dels 27 el 2026).', 'cultcat_09_institucions_economia', (select id from public.topics where slug = 'cultcat-09-institucions-economia'), 1, 'ca', true, (select id from public.sources where url = 'https://dlc.iec.cat/'), 'Euro', 'euro 1 m. [ECT] [LC] Unitat monetària comuna dels estats de la Unió Europea que participen en la unió econòmica i monetària.', null, 'bf20852044c4f3db1292b20d0be8049efb4a6b806e38fd335e588d4ad21b2f9e', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'bf20852044c4f3db1292b20d0be8049efb4a6b806e38fd335e588d4ad21b2f9e')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'La moneda oficial de tots els estats del continent europeu', false), ('B', 'La moneda de tots els estats membres de la UE sense excepció', false), ('C', 'La unitat de compte del Consell d''Europa', false), ('D', 'La unitat monetària comuna dels estats de la UE que participen en la unió econòmica i monetària', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local', 'guardia-urbana-barcelona');
-- Lote cultcat-09-institucions-economia-eac-v1 (4 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Ley Orgánica 6/2006, de 19 de julio, de reforma del Estatuto de Autonomía de Cataluña (texto consolidado, BOE)', 'https://www.boe.es/buscar/act.php?id=BOE-A-2006-13087', 'boe'::public.source_kind, 'Agencia Estatal Boletín Oficial del Estado', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('cultcat-09-institucions-economia', 'Cultura general 9. Institucions (Catalunya, Espanya, UE, ONU) i economia bàsica') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('policia-local', 'guardia-urbana-barcelona') and t.slug = 'cultcat-09-institucions-economia' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''Estatut d''autonomia, quina ciutat és la capital de Catalunya i seu permanent del Parlament, la Presidència i el Govern?', 'L''article 10 de l''Estatut estableix que la capital és Barcelona, tot i que el Parlament i el Govern es poden reunir en altres llocs de Catalunya.', 'cultcat_09_institucions_economia', (select id from public.topics where slug = 'cultcat-09-institucions-economia'), 1, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2006-13087'), 'EAC art. 10, capital', 'La capital de Cataluña es la ciudad de Barcelona, que es la sede permanente del Parlamento, de la Presidencia de la Generalitat y del Gobierno', null, 'b8c4140d7706018659d683c076cb27a2e2cc92a8dabc35e0be616af73a5d036a', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'b8c4140d7706018659d683c076cb27a2e2cc92a8dabc35e0be616af73a5d036a')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Tarragona', false), ('B', 'Girona', false), ('C', 'Lleida', false), ('D', 'Barcelona', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local', 'guardia-urbana-barcelona');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Quina és la llengua pròpia de Catalunya segons l''article 6 de l''Estatut?', 'El català és la llengua pròpia i oficial de Catalunya; el castellà també hi és oficial, com a llengua oficial de l''Estat.', 'cultcat_09_institucions_economia', (select id from public.topics where slug = 'cultcat-09-institucions-economia'), 1, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2006-13087'), 'EAC art. 6.1, llengua pròpia', 'La lengua propia de Cataluña es el catalán.', null, '6c3a2a6daffc67bdd2f724f13c85d197835137af29665e4dda9487d5a9d215e8', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '6c3a2a6daffc67bdd2f724f13c85d197835137af29665e4dda9487d5a9d215e8')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El castellà', false), ('B', 'El català', true), ('C', 'L''occità', false), ('D', 'El català i el castellà per igual', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local', 'guardia-urbana-barcelona');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''Estatut, entre quants diputats pot tenir el Parlament de Catalunya?', 'L''article 56.1 fixa entre 100 i 150 diputats, elegits per quatre anys; actualment en són 135 per la normativa electoral.', 'cultcat_09_institucions_economia', (select id from public.topics where slug = 'cultcat-09-institucions-economia'), 2, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2006-13087'), 'EAC art. 56.1, Parlament', 'El Parlamento se compone de un mínimo de cien Diputados y un máximo de ciento cincuenta, elegidos para un plazo de cuatro años', null, '7db7ea6d5b17f3c2585f0c46f895a5e1e2c5713f4714a06e304def3bbef5ea2f', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '7db7ea6d5b17f3c2585f0c46f895a5e1e2c5713f4714a06e304def3bbef5ea2f')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Entre un mínim de 300 i un màxim de 400', false), ('B', 'Entre un mínim de 50 i un màxim de 100', false), ('C', 'Entre un mínim de 100 i un màxim de 150', true), ('D', 'Exactament 135, fixats per l''Estatut', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local', 'guardia-urbana-barcelona');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Qui nomena el president o presidenta de la Generalitat, un cop elegit pel Parlament?', 'El president és elegit pel Parlament d''entre els seus membres i nomenat pel Rei (art. 67 EAC).', 'cultcat_09_institucions_economia', (select id from public.topics where slug = 'cultcat-09-institucions-economia'), 2, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2006-13087'), 'EAC art. 67.4, nomenament del president', 'El Presidente o Presidenta de la Generalitat es nombrado por el Rey.', null, '2bbfd02e0274bb7955ff682a9bf8b40b6044dbe46823f8ca4231e58a5d73af75', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '2bbfd02e0274bb7955ff682a9bf8b40b6044dbe46823f8ca4231e58a5d73af75')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El president del Govern de l''Estat', false), ('B', 'El president del Parlament', false), ('C', 'El Rei', true), ('D', 'El Tribunal Constitucional', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local', 'guardia-urbana-barcelona');
-- Lote cultcat-09-institucions-economia-idescat-v1 (2 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Anuari estadístic de Catalunya i El municipi en xifres (Institut d''Estadística de Catalunya)', 'https://www.idescat.cat/indicadors/?id=aec&lang=ca', 'web_oficial'::public.source_kind, 'Institut d''Estadística de Catalunya (Idescat)', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('cultcat-09-institucions-economia', 'Cultura general 9. Institucions (Catalunya, Espanya, UE, ONU) i economia bàsica') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('policia-local', 'guardia-urbana-barcelona') and t.slug = 'cultcat-09-institucions-economia' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Quants escons té el Parlament de Catalunya, segons les dades electorals d''Idescat?', 'El Parlament té 135 escons (85 per Barcelona, 17 per Girona, 15 per Lleida i 18 per Tarragona).', 'cultcat_09_institucions_economia', (select id from public.topics where slug = 'cultcat-09-institucions-economia'), 2, 'ca', true, (select id from public.sources where url = 'https://www.idescat.cat/indicadors/?id=aec&lang=ca'), 'Parlament de Catalunya, escons', 'Total escons 2021 85 17 15 18 135', null, '54c641205cb24aaad31d7eba092c8419a555035c08b68911d5fdcae4e2b5fefb', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '54c641205cb24aaad31d7eba092c8419a555035c08b68911d5fdcae4e2b5fefb')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', '135', true), ('B', '150', false), ('C', '100', false), ('D', '350', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local', 'guardia-urbana-barcelona');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Quin percentatge mínim de vots cal per entrar en el repartiment d''escons a les eleccions al Parlament de Catalunya?', 'Els escons es reparteixen per la regla d''Hondt; el mínim és el 3% al Parlament i a les generals, i el 5% a les municipals.', 'cultcat_09_institucions_economia', (select id from public.topics where slug = 'cultcat-09-institucions-economia'), 2, 'ca', true, (select id from public.sources where url = 'https://www.idescat.cat/indicadors/?id=aec&lang=ca'), 'Regla d''Hondt i llindar electoral', 'Hi ha uns percentatges mínims (3% per a les eleccions al Parlament de Catalunya i a les legislatives i 5% per a les locals)', null, '965ff34d286e10f2f32709408b9d55a86fcc066b93d95b4fc75fcd405df3d051', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '965ff34d286e10f2f32709408b9d55a86fcc066b93d95b4fc75fcd405df3d051')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El 3%', true), ('B', 'El 5%', false), ('C', 'El 10%', false), ('D', 'No hi ha cap mínim', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local', 'guardia-urbana-barcelona');
-- Lote cultcat-09-institucions-economia-onu-v1 (2 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('United Nations: About Us, UN Charter, Main Bodies i Selection and Appointment of the Next Secretary-General', 'https://www.un.org/en/about-us', 'web_oficial'::public.source_kind, 'United Nations', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('cultcat-09-institucions-economia', 'Cultura general 9. Institucions (Catalunya, Espanya, UE, ONU) i economia bàsica') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('policia-local', 'guardia-urbana-barcelona') and t.slug = 'cultcat-09-institucions-economia' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Quants membres té el Consell de Seguretat de les Nacions Unides?', 'El Consell de Seguretat, responsable del manteniment de la pau, té 15 membres: 5 permanents i 10 no permanents.', 'cultcat_09_institucions_economia', (select id from public.topics where slug = 'cultcat-09-institucions-economia'), 2, 'ca', true, (select id from public.sources where url = 'https://www.un.org/en/about-us'), 'Consell de Seguretat de l''ONU', 'It has 15 Members (5 permanent and 10 non-permanent members).', null, '8215d91697746c8826ce5a86730e41c90a3e8f3ba5b3bd7e06581250a2a7d6fa', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '8215d91697746c8826ce5a86730e41c90a3e8f3ba5b3bd7e06581250a2a7d6fa')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', '10, tots permanents', false), ('B', '193, tants com estats membres', false), ('C', '15, dels quals 5 són permanents', true), ('D', '27, un per cada estat de la UE', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local', 'guardia-urbana-barcelona');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'En quin any va ser admès Andorra com a estat membre de les Nacions Unides?', 'Andorra va ser admesa a l''ONU el 28 de juliol de 1993; els estats s''admeten per decisió de l''Assemblea General a recomanació del Consell de Seguretat.', 'cultcat_09_institucions_economia', (select id from public.topics where slug = 'cultcat-09-institucions-economia'), 3, 'ca', true, (select id from public.sources where url = 'https://www.un.org/en/about-us'), 'Andorra a l''ONU', 'Andorra Date of Admission: 28-07-1993', null, '3a904cdd9d3f4fdd18bcb2543b3e84a5e96470ede75a4681b35e8f839672cc4e', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '3a904cdd9d3f4fdd18bcb2543b3e84a5e96470ede75a4681b35e8f839672cc4e')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', '1993', true), ('B', '1945', false), ('C', '1978', false), ('D', '2001', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local', 'guardia-urbana-barcelona');
-- Lote cultcat-09-institucions-economia-ue-v1 (3 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Portal oficial de la Unión Europea: países, historia, euro e instituciones', 'https://european-union.europa.eu/index_es', 'web_oficial'::public.source_kind, 'Unión Europea', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('cultcat-09-institucions-economia', 'Cultura general 9. Institucions (Catalunya, Espanya, UE, ONU) i economia bàsica') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('policia-local', 'guardia-urbana-barcelona') and t.slug = 'cultcat-09-institucions-economia' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Quina institució és l''òrgan executiu de la UE i l''única responsable d''elaborar propostes de nova legislació europea?', 'La Comissió Europea, amb seu a Brussel·les, proposa la legislació; el Parlament Europeu és l''òrgan legislatiu.', 'cultcat_09_institucions_economia', (select id from public.topics where slug = 'cultcat-09-institucions-economia'), 2, 'ca', true, (select id from public.sources where url = 'https://european-union.europa.eu/index_es'), 'Comissió Europea', 'La Comisión Europea es el órgano ejecutivo, políticamente independiente, de la UE. Es la única instancia responsable de elaborar propuestas de nueva legislación europea', null, '5ca281aafe636b35b899793d1046f955e891738988f23aa9a28ea3f36b6509a0', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '5ca281aafe636b35b899793d1046f955e891738988f23aa9a28ea3f36b6509a0')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El Parlament Europeu', false), ('B', 'La Comissió Europea', true), ('C', 'El Consell Europeu', false), ('D', 'El Tribunal de Justícia de la UE', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local', 'guardia-urbana-barcelona');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Cada quant temps s''elegeix el Parlament Europeu per sufragi directe?', 'El Parlament Europeu, de 720 eurodiputats, s''elegeix cada cinc anys; les darreres eleccions van ser del 6 al 9 de juny de 2024.', 'cultcat_09_institucions_economia', (select id from public.topics where slug = 'cultcat-09-institucions-economia'), 2, 'ca', true, (select id from public.sources where url = 'https://european-union.europa.eu/index_es'), 'Parlament Europeu', 'Es elegido directamente por los votantes de la UE cada cinco años.', null, 'a04a054a68700cda3de6bdce28bb30e7fc6370c27326d499d7efa67494766eb5', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'a04a054a68700cda3de6bdce28bb30e7fc6370c27326d499d7efa67494766eb5')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Cada quatre anys', false), ('B', 'Cada sis anys', false), ('C', 'Cada dos anys i mig', false), ('D', 'Cada cinc anys', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local', 'guardia-urbana-barcelona');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Quants dels 27 estats de la UE tenen l''euro com a moneda oficial el 2026?', 'L''euro és la moneda oficial de 21 dels 27 països (Bulgària s''hi va incorporar l''1 de gener de 2026); Dinamarca té una clàusula d''exclusió.', 'cultcat_09_institucions_economia', (select id from public.topics where slug = 'cultcat-09-institucions-economia'), 3, 'ca', true, (select id from public.sources where url = 'https://european-union.europa.eu/index_es'), 'Zona euro', 'Hoy en día, el euro (€) es la moneda oficial de 21 de los 27 países de la UE', null, 'f7aa0216ef69c1155ccf72f4393593197a074281256363889e9197df59cf50f0', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'f7aa0216ef69c1155ccf72f4393593197a074281256363889e9197df59cf50f0')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', '19', false), ('B', '27', false), ('C', '21', true), ('D', '12', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local', 'guardia-urbana-barcelona');
-- Lote plcatexamen-2025-terrassa-cultural-bcnmerce26-v1 (2 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Tota la programació de la Mercè 2026 (16/09/2026) i Lectura del pregó de les Festes de la Mercè 2026 (22/09/2026)', 'https://ajuntament.barcelona.cat/ciutatvella/ca/noticies/tota-la-programacio-de-la-merce-2026-41192', 'web_oficial'::public.source_kind, 'Ajuntament de Barcelona', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('plcatexamen-2025-terrassa', 'Examen rèplica · Terrassa 2025 (1f/AGENTS/2025), exercici teòric: 50 preguntes') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('policia-local') and t.slug = 'plcatexamen-2025-terrassa' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'En quina sala de l''Ajuntament de Barcelona es va llegir el pregó de la Mercè 2026?', 'Rèplica de la p. 14 (polèmica local; substituïda per un fet de Barcelona). 23 de setembre de 2026.', 'plcatexamen_2025_terrassa', (select id from public.topics where slug = 'plcatexamen-2025-terrassa'), 2, 'ca', true, (select id from public.sources where url = 'https://ajuntament.barcelona.cat/ciutatvella/ca/noticies/tota-la-programacio-de-la-merce-2026-41192'), 'Terrassa 2025 p. 14 · Pregó de la Mercè', 'Dimecres 23 de setembre, a les 19.00 hores, al Saló de Cent', null, '1c2240552c89c821b2d0ceb8cc5fe36c10f2d9026f1dede84b32b3ba074b4090', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '1c2240552c89c821b2d0ceb8cc5fe36c10f2d9026f1dede84b32b3ba074b4090')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Al Saló Sant Jordi', false), ('B', 'Al Saló del Tinell', false), ('C', 'Al Saló de Cent', true), ('D', 'A la sala Martí l''Humà', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Qui és l''alcalde de Barcelona?', 'Rèplica de la p. 31 (càrrec municipal; substituït pel de Barcelona). Setembre de 2026.', 'plcatexamen_2025_terrassa', (select id from public.topics where slug = 'plcatexamen-2025-terrassa'), 1, 'ca', true, (select id from public.sources where url = 'https://ajuntament.barcelona.cat/ciutatvella/ca/noticies/tota-la-programacio-de-la-merce-2026-41192'), 'Terrassa 2025 p. 31 · Alcalde de Barcelona', 'l’alcalde de Barcelona, Jaume Collboni', null, '959a44df355d0edc7b352b88383ffe8c1a206f0e118d4f4b9d659236fc546ee2', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '959a44df355d0edc7b352b88383ffe8c1a206f0e118d4f4b9d659236fc546ee2')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Salvador Illa', false), ('B', 'Josep Rull', false), ('C', 'Jordi Ballart', false), ('D', 'Jaume Collboni', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
-- Lote plcatexamen-2025-terrassa-cultural-bcnpadro26-v1 (1 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('La població de Barcelona. Lectura del padró municipal d’habitants a 01/01/2026: síntesi de resultats', 'https://dades.ajuntament.barcelona.cat/informe-padro-poblacio/ca/seccio_2.html', 'web_oficial'::public.source_kind, 'Ajuntament de Barcelona, Departament d''Estadística i Difusió de Dades', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('plcatexamen-2025-terrassa', 'Examen rèplica · Terrassa 2025 (1f/AGENTS/2025), exercici teòric: 50 preguntes') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('policia-local') and t.slug = 'plcatexamen-2025-terrassa' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Quina és l''edat mitjana de la població de Barcelona segons el padró de 2026?', 'Rèplica de la p. 50 (equipament municipal; substituït per una dada de ciutat). Padró 2026.', 'plcatexamen_2025_terrassa', (select id from public.topics where slug = 'plcatexamen-2025-terrassa'), 3, 'ca', true, (select id from public.sources where url = 'https://dades.ajuntament.barcelona.cat/informe-padro-poblacio/ca/seccio_2.html'), 'Terrassa 2025 p. 50 · Edat mitjana a Barcelona', 'L’edat mitjana de la població repunta lleugerament fins al 44,6 anys.', null, '6592835550a632d80bd8a92c410d0971d2459662070a983aca49f49d77faf786', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '6592835550a632d80bd8a92c410d0971d2459662070a983aca49f49d77faf786')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', '38,2 anys', false), ('B', '51,0 anys', false), ('C', '44,6 anys', true), ('D', '40,0 anys', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
-- Lote plcatexamen-2025-terrassa-cultural-bcnpapa26-v1 (2 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Barcelona acollirà aquest juny la visita del Papa Lleó XIV (29/05/2026)', 'https://ajuntament.barcelona.cat/oficina-afers-religiosos/ca/noticies/barcelona-acollira-aquest-juny-la-visita-del-papa-lleo-xiv-1640185', 'web_oficial'::public.source_kind, 'Ajuntament de Barcelona, Oficina d''Afers Religiosos', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('plcatexamen-2025-terrassa', 'Examen rèplica · Terrassa 2025 (1f/AGENTS/2025), exercici teòric: 50 preguntes') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('policia-local') and t.slug = 'plcatexamen-2025-terrassa' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Quin centre va visitar el papa Lleó XIV durant la seva estada a Catalunya el juny de 2026?', 'Rèplica de la p. 2 (actualitat local amb actuació d''un servei públic; substituïda per un fet de Catalunya). 9-10 de juny de 2026.', 'plcatexamen_2025_terrassa', (select id from public.topics where slug = 'plcatexamen-2025-terrassa'), 2, 'ca', true, (select id from public.sources where url = 'https://ajuntament.barcelona.cat/oficina-afers-religiosos/ca/noticies/barcelona-acollira-aquest-juny-la-visita-del-papa-lleo-xiv-1640185'), 'Terrassa 2025 p. 2 · Visita papal a Brians 1', 'el pontífex visitarà el centre penitenciari Brians 1', null, '677b1a73f8aa0b2d64dd637ebfe47064e947d14d2c707771939a22c6cf26a540', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '677b1a73f8aa0b2d64dd637ebfe47064e947d14d2c707771939a22c6cf26a540')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'La comissaria central dels Mossos d''Esquadra', false), ('B', 'El centre penitenciari Brians 1', true), ('C', 'L''Hospital de Sant Pau', false), ('D', 'El Parlament de Catalunya', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'A quina parròquia de Barcelona es va trobar Lleó XIV amb entitats socials, en referència al seu origen agustinià?', 'Rèplica de la p. 40 (càrrec local; substituït per un fet de Barcelona). Juny de 2026.', 'plcatexamen_2025_terrassa', (select id from public.topics where slug = 'plcatexamen-2025-terrassa'), 3, 'ca', true, (select id from public.sources where url = 'https://ajuntament.barcelona.cat/oficina-afers-religiosos/ca/noticies/barcelona-acollira-aquest-juny-la-visita-del-papa-lleo-xiv-1640185'), 'Terrassa 2025 p. 40 · Origen agustinià de Lleó XIV', 'Lleó XIV participarà en una trobada amb entitats socials a la parròquia de Sant Agustí.', null, '2f64471f2852deb1ed40c59992a49d5e417d94071d98075df77fe85940a7429c', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '2f64471f2852deb1ed40c59992a49d5e417d94071d98075df77fe85940a7429c')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Santa Maria del Mar', false), ('B', 'Sant Just i Pastor', false), ('C', 'Sant Agustí', true), ('D', 'La Mercè', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
-- Lote plcatexamen-2025-terrassa-cultural-bcnpremis25-v1 (1 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Premis Ciutat de Barcelona, 2025', 'https://ajuntament.barcelona.cat/ca/informacio-administrativa/premis/premis-ciutat-de-barcelona-2025', 'web_oficial'::public.source_kind, 'Ajuntament de Barcelona', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('plcatexamen-2025-terrassa', 'Examen rèplica · Terrassa 2025 (1f/AGENTS/2025), exercici teòric: 50 preguntes') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('policia-local') and t.slug = 'plcatexamen-2025-terrassa' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Quantes categories dedicades a la ciència tenen els Premis Ciutat de Barcelona en l''edició 2025?', 'Rèplica de la p. 3 (col·laboració amb la universitat i la recerca; substituïda per un fet de Barcelona). Lliurament l''11 de febrer de 2026.', 'plcatexamen_2025_terrassa', (select id from public.topics where slug = 'plcatexamen-2025-terrassa'), 3, 'ca', true, (select id from public.sources where url = 'https://ajuntament.barcelona.cat/ca/informacio-administrativa/premis/premis-ciutat-de-barcelona-2025'), 'Terrassa 2025 p. 3 · Premis Ciutat de Barcelona', 'en total són sis les categories dedicades a ciència.', null, '29e2c86ddcb866c5efa1a415383f9a7ec9af39a7480a523ba678918dc20ed480', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '29e2c86ddcb866c5efa1a415383f9a7ec9af39a7480a523ba678918dc20ed480')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Tres', false), ('B', 'Dinou', false), ('C', 'Sis', true), ('D', 'Una', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
-- Lote plcatexamen-2025-terrassa-cultural-bcntour26-v1 (2 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('La Festa Major del Tour omplirà Barcelona amb més de 60 propostes (15/05/2026) i Catalunya i Barcelona s’il·luminen de groc (26/03/2026)', 'https://ajuntament.barcelona.cat/premsa/2026/05/15/la-festa-major-del-tour-omplira-barcelona-amb-mes-de-60-propostes-per-celebrar-el-tour-de-franca/', 'web_oficial'::public.source_kind, 'Ajuntament de Barcelona', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('plcatexamen-2025-terrassa', 'Examen rèplica · Terrassa 2025 (1f/AGENTS/2025), exercici teòric: 50 preguntes') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('policia-local') and t.slug = 'plcatexamen-2025-terrassa' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'On va arribar la segona etapa del Tour de França 2026?', 'Rèplica de la p. 19 (actualitat esportiva; substitueix el Godó 2025). 5 de juliol de 2026.', 'plcatexamen_2025_terrassa', (select id from public.topics where slug = 'plcatexamen-2025-terrassa'), 2, 'ca', true, (select id from public.sources where url = 'https://ajuntament.barcelona.cat/premsa/2026/05/15/la-festa-major-del-tour-omplira-barcelona-amb-mes-de-60-propostes-per-celebrar-el-tour-de-franca/'), 'Terrassa 2025 p. 19 · Tour 2026, segona etapa', 'l’arribada de la segona etapa de la competició ciclista a Montjuïc', null, 'c9646234f506a157c238ccc361973a742ce9db38ee93c577d62df8f427e01e2d', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'c9646234f506a157c238ccc361973a742ce9db38ee93c577d62df8f427e01e2d')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'A Terrassa', false), ('B', 'A Montjuïc (Barcelona)', true), ('C', 'A Andorra la Vella', false), ('D', 'Al Tibidabo', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Entre quines dates es va celebrar a Barcelona la Festa Major del Tour 2026?', 'Rèplica de la p. 49 (actualitat esportiva; substitueix la Fórmula 1). 2026.', 'plcatexamen_2025_terrassa', (select id from public.topics where slug = 'plcatexamen-2025-terrassa'), 2, 'ca', true, (select id from public.sources where url = 'https://ajuntament.barcelona.cat/premsa/2026/05/15/la-festa-major-del-tour-omplira-barcelona-amb-mes-de-60-propostes-per-celebrar-el-tour-de-franca/'), 'Terrassa 2025 p. 49 · Festa Major del Tour, dates', 'del 26 de juny al 5 de juliol', null, '56ace36919bc37ae15cca3d8ccaa6da18a1657fc77ed3c4b24be040047f7f97b', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '56ace36919bc37ae15cca3d8ccaa6da18a1657fc77ed3c4b24be040047f7f97b')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Del 23 al 27 de setembre', false), ('B', 'Del 26 de juny al 5 de juliol', true), ('C', 'De l''1 al 15 d''agost', false), ('D', 'Del 10 al 20 de juny', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
-- Lote plcatexamen-2025-terrassa-cultural-cop31-v1 (1 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('UN Climate Change Conference - Antalya, November 2026 (COP31)', 'https://unfccc.int/cop31', 'web_oficial'::public.source_kind, 'United Nations Framework Convention on Climate Change (UNFCCC)', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('plcatexamen-2025-terrassa', 'Examen rèplica · Terrassa 2025 (1f/AGENTS/2025), exercici teòric: 50 preguntes') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('policia-local') and t.slug = 'plcatexamen-2025-terrassa' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Qui ha estat nomenat president de la COP31 d''Antalya?', 'Rèplica de la p. 35 (càrrec internacional; substitueix el vicepresident dels EUA). Novembre de 2026.', 'plcatexamen_2025_terrassa', (select id from public.topics where slug = 'plcatexamen-2025-terrassa'), 3, 'ca', true, (select id from public.sources where url = 'https://unfccc.int/cop31'), 'Terrassa 2025 p. 35 · President de la COP31', 'Mr. Murat Kurum has been nominated as President of COP31 in Antalya.', null, '067ba5e1c8e4ce36b53aed55815a328f10cf998df04cbbc166b520ad8f1f3e40', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '067ba5e1c8e4ce36b53aed55815a328f10cf998df04cbbc166b520ad8f1f3e40')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Chris Bowen', false), ('B', 'Murat Kurum', true), ('C', 'António Guterres', false), ('D', 'António Costa', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
-- Lote plcatexamen-2025-terrassa-cultural-ddhc1789-v1 (1 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Déclaration des Droits de l''Homme et du Citoyen de 1789', 'https://www.conseil-constitutionnel.fr/le-bloc-de-constitutionnalite/declaration-des-droits-de-l-homme-et-du-citoyen-de-1789', 'web_oficial'::public.source_kind, 'Conseil constitutionnel (République française)', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('plcatexamen-2025-terrassa', 'Examen rèplica · Terrassa 2025 (1f/AGENTS/2025), exercici teòric: 50 preguntes') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('policia-local') and t.slug = 'plcatexamen-2025-terrassa' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'En quin any es va aprovar la Declaració dels Drets de l''Home i del Ciutadà, a l''inici de la Revolució Francesa?', 'Rèplica de la p. 32 (inici de la Revolució Francesa).', 'plcatexamen_2025_terrassa', (select id from public.topics where slug = 'plcatexamen-2025-terrassa'), 1, 'ca', true, (select id from public.sources where url = 'https://www.conseil-constitutionnel.fr/le-bloc-de-constitutionnalite/declaration-des-droits-de-l-homme-et-du-citoyen-de-1789'), 'Terrassa 2025 p. 32 · Revolució Francesa', 'Déclaration des Droits de l''Homme et du Citoyen de 1789', null, 'ddf5997651321ba1424f74515d99bfa3f6197942064f34fd91406d18d6ba53ea', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'ddf5997651321ba1424f74515d99bfa3f6197942064f34fd91406d18d6ba53ea')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', '1689', false), ('B', '1815', false), ('C', '1789', true), ('D', '1848', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
-- Lote plcatexamen-2025-terrassa-cultural-diec-v1 (15 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Diccionari de la llengua catalana, 2a edició (DIEC2), Institut d''Estudis Catalans', 'https://dlc.iec.cat/', 'web_oficial'::public.source_kind, 'Institut d''Estudis Catalans', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('plcatexamen-2025-terrassa', 'Examen rèplica · Terrassa 2025 (1f/AGENTS/2025), exercici teòric: 50 preguntes') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('policia-local') and t.slug = 'plcatexamen-2025-terrassa' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Què és una hipoteca?', 'Rèplica de la p. 5 (euríbor: es pregunta pel concepte financer bàsic amb font oficial).', 'plcatexamen_2025_terrassa', (select id from public.topics where slug = 'plcatexamen-2025-terrassa'), 2, 'ca', true, (select id from public.sources where url = 'https://dlc.iec.cat/'), 'Terrassa 2025 p. 5 · Hipoteca', 'hipoteca 1 f. [DR] [ECT] [LC] Dret donat per contracte com a garantia a un creditor sobre una propietat del deutor sense transferència de possessió.', null, '2cadc4ff937855c91384a36fd71b94751f58d1e980db2d02cf5bea02feb9bd1b', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '2cadc4ff937855c91384a36fd71b94751f58d1e980db2d02cf5bea02feb9bd1b')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Un impost sobre la compra d''habitatges', false), ('B', 'Un dret que garanteix un crèdit sobre una propietat del deutor, sense que se''n transfereixi la possessió', true), ('C', 'Un índex de referència dels tipus d''interès', false), ('D', 'Un contracte de lloguer a llarg termini', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Quin és el màxim comú divisor de 12 i 18?', 'Rèplica de la p. 9. Divisors comuns: 1, 2, 3 i 6; el més gran és 6 (36 és el mínim comú múltiple).', 'plcatexamen_2025_terrassa', (select id from public.topics where slug = 'plcatexamen-2025-terrassa'), 2, 'ca', true, (select id from public.sources where url = 'https://dlc.iec.cat/'), 'Terrassa 2025 p. 9 · Màxim comú divisor', 'màxim -a 1 adj. [LC] [MT] El més gran. El màxim comú divisor de dos o més nombres.', null, '0ad95da60bd7f3f140b1ffa3523391ece0717f6c4c81c6b5fd716fd77f972b0b', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '0ad95da60bd7f3f140b1ffa3523391ece0717f6c4c81c6b5fd716fd77f972b0b')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', '6', true), ('B', '3', false), ('C', '36', false), ('D', '2', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Quin element de la taula periòdica té el símbol He i el nombre atòmic 2?', 'Rèplica de la p. 13 (taula periòdica). L''heli és un gas noble; l''hidrogen (H) té el nombre atòmic 1.', 'plcatexamen_2025_terrassa', (select id from public.topics where slug = 'plcatexamen-2025-terrassa'), 2, 'ca', true, (select id from public.sources where url = 'https://dlc.iec.cat/'), 'Terrassa 2025 p. 13 · Heli', '(símbol, He; nombre atòmic, 2; pes atòmic, 4,002)', null, '5ec456e9167949ca2422ce1df65834a1f3a8af81d6e60b376bbb38f501a33342', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '5ec456e9167949ca2422ce1df65834a1f3a8af81d6e60b376bbb38f501a33342')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'L''hidrogen', false), ('B', 'L''heli', true), ('C', 'L''hafni', false), ('D', 'L''holmi', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Quina font d''energia renovable aprofita la matèria viva d''un ecosistema?', 'Rèplica de la p. 15 (energies renovables).', 'plcatexamen_2025_terrassa', (select id from public.topics where slug = 'plcatexamen-2025-terrassa'), 2, 'ca', true, (select id from public.sources where url = 'https://dlc.iec.cat/'), 'Terrassa 2025 p. 15 · Biomassa', 'biomassa f. [EG] Massa total de la matèria viva existent en una comunitat o en un ecosistema, a la qual sovint s’afegeix també matèria no viva, utilitzable com a font d’energia', null, 'bda60405c66ded770899fc7e20c1a448876b44735147a12fddcd5cdc08829152', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'bda60405c66ded770899fc7e20c1a448876b44735147a12fddcd5cdc08829152')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El gas natural', false), ('B', 'El carbó', false), ('C', 'L''urani', false), ('D', 'La biomassa', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Com s''anomena en matemàtiques la figura formada per dues rectes que es troben en un punt?', 'Rèplica de la p. 17 (branca de les matemàtiques que estudia les formes; a l''examen era en anglès, aquí en català).', 'plcatexamen_2025_terrassa', (select id from public.topics where slug = 'plcatexamen-2025-terrassa'), 1, 'ca', true, (select id from public.sources where url = 'https://dlc.iec.cat/'), 'Terrassa 2025 p. 17 · Angle', 'angle1 2 1 m. [LC] [MT] En mat., figura formada per dues rectes que es troben', null, '9939b2ece305563c6312e58790ec078c88ecc6b204ffc9ebac9c69ba9afab7a8', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '9939b2ece305563c6312e58790ec078c88ecc6b204ffc9ebac9c69ba9afab7a8')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Radi', false), ('B', 'Perímetre', false), ('C', 'Diàmetre', false), ('D', 'Angle', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Amb quina categoria gramatical concorda l''adjectiu?', 'Rèplica de la p. 27. Els adjectius es relacionen amb els substantius i hi concorden.', 'plcatexamen_2025_terrassa', (select id from public.topics where slug = 'plcatexamen-2025-terrassa'), 1, 'ca', true, (select id from public.sources where url = 'https://dlc.iec.cat/'), 'Terrassa 2025 p. 27 · Adjectiu', 'es relacionen amb els substantius i hi concorden.', null, '623bea9d6667fa91d5e8a5ddaef039285bce723f6ae2a73da1a914dfca215a36', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '623bea9d6667fa91d5e8a5ddaef039285bce723f6ae2a73da1a914dfca215a36')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Amb el substantiu', true), ('B', 'Amb el verb', false), ('C', 'Amb l''adverbi', false), ('D', 'Amb la preposició', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'A «Vull venir, però no puc», quina categoria és «però»?', 'Rèplica de la p. 28. La conjunció relaciona oracions coordinades o subordinades.', 'plcatexamen_2025_terrassa', (select id from public.topics where slug = 'plcatexamen-2025-terrassa'), 2, 'ca', true, (select id from public.sources where url = 'https://dlc.iec.cat/'), 'Terrassa 2025 p. 28 · Conjunció', 'Categoria lèxica constituïda per mots invariables que relacionen dos mots o grups de mots d’idèntica funció sintàctica o bé dues oracions coordinades o subordinades.', null, '779db25ab24baaa0c50f20accc4d9b5a6e168f848ed6913b3c20020af85ce332', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '779db25ab24baaa0c50f20accc4d9b5a6e168f848ed6913b3c20020af85ce332')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Una preposició', false), ('B', 'Una conjunció', true), ('C', 'Un adverbi', false), ('D', 'Un pronom', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Quin element té el símbol químic Pt?', 'Rèplica de la p. 29. Pt és el platí; Pb, el plom; K, el potassi; Ag, l''argent (plata).', 'plcatexamen_2025_terrassa', (select id from public.topics where slug = 'plcatexamen-2025-terrassa'), 2, 'ca', true, (select id from public.sources where url = 'https://dlc.iec.cat/'), 'Terrassa 2025 p. 29 · Platí', '(símbol, Pt; nombre atòmic, 78; pes atòmic, 195,09)', null, 'a96271ca465e4fbef7df394367fce9a8ebda04886ee932726f25ff202d8076ad', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'a96271ca465e4fbef7df394367fce9a8ebda04886ee932726f25ff202d8076ad')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El platí', true), ('B', 'El plom', false), ('C', 'El potassi', false), ('D', 'La plata', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Com s''anomena el pas de l''estat líquid a l''estat sòlid, com quan l''aigua es glaça?', 'Rèplica de la p. 30.', 'plcatexamen_2025_terrassa', (select id from public.topics where slug = 'plcatexamen-2025-terrassa'), 1, 'ca', true, (select id from public.sources where url = 'https://dlc.iec.cat/'), 'Terrassa 2025 p. 30 · Solidificació', 'solidificació f. [FIF] [LC] Acció de solidificar o de solidificar-se.', null, '26715529cd400f1355bc379af48ab38fa6683aa503cf258882bf4eed02ac1bf4', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '26715529cd400f1355bc379af48ab38fa6683aa503cf258882bf4eed02ac1bf4')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Condensació', false), ('B', 'Solidificació', true), ('C', 'Evaporació', false), ('D', 'Sublimació', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Un pare té 40 anys i el seu fill, 10. D''aquí a quants anys el pare tindrà el doble d''edat que el fill?', 'Rèplica de la p. 36 (problema d''edats; a l''examen era en anglès). Equació: 40 + x = 2(10 + x), d''on x = 20 (el pare en tindrà 60 i el fill 30).', 'plcatexamen_2025_terrassa', (select id from public.topics where slug = 'plcatexamen-2025-terrassa'), 3, 'ca', true, (select id from public.sources where url = 'https://dlc.iec.cat/'), 'Terrassa 2025 p. 36 · Problema d''edats', 'equació 2 1 f. [MT] En mat., igualtat entre dues expressions que contenen una o més incògnites.', null, 'cf18799b97e464c68439f01d1859be23ebe99aa99259e69d1ef84b420eb7205e', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'cf18799b97e464c68439f01d1859be23ebe99aa99259e69d1ef84b420eb7205e')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', '20', true), ('B', '10', false), ('C', '15', false), ('D', '30', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Què és un pronom feble?', 'Rèplica de la p. 37. El pronom fort, en canvi, és accentuat i pot fer de subjecte.', 'plcatexamen_2025_terrassa', (select id from public.topics where slug = 'plcatexamen-2025-terrassa'), 2, 'ca', true, (select id from public.sources where url = 'https://dlc.iec.cat/'), 'Terrassa 2025 p. 37 · Pronoms febles', 'pronom feble Pronom inaccentuat que va immediatament al davant o al darrere del verb.', null, '416e0fa7d77ee6d0bda2c0001d4dcc7db89dda6cbca07d1266a942f77527ec9d', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '416e0fa7d77ee6d0bda2c0001d4dcc7db89dda6cbca07d1266a942f77527ec9d')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Un pronom accentuat que fa de subjecte', false), ('B', 'Un pronom inaccentuat que va immediatament davant o darrere del verb', true), ('C', 'Un pronom que només s''usa en plural', false), ('D', 'Un pronom que substitueix un adjectiu qualificatiu', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Un triangle amb dos costats de 7 cm i un de 4 cm és...', 'Rèplica de la p. 41. Té dos costats iguals.', 'plcatexamen_2025_terrassa', (select id from public.topics where slug = 'plcatexamen-2025-terrassa'), 1, 'ca', true, (select id from public.sources where url = 'https://dlc.iec.cat/'), 'Terrassa 2025 p. 41 · Isòsceles', 'isòsceles adj. [LC] [MT] Que té dos costats iguals', null, 'eded917b20c095cef6145f2caf9354dae9b45f358da04a7e5b75fb3c808d5dff', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'eded917b20c095cef6145f2caf9354dae9b45f358da04a7e5b75fb3c808d5dff')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Equilàter', false), ('B', 'Escalè', false), ('C', 'Isòsceles', true), ('D', 'Rectangle', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Com s''escriu l''any 2026 en xifres romanes?', 'Rèplica de la p. 42. M + M = 2000, XX = 20, VI = 6.', 'plcatexamen_2025_terrassa', (select id from public.topics where slug = 'plcatexamen-2025-terrassa'), 2, 'ca', true, (select id from public.sources where url = 'https://dlc.iec.cat/'), 'Terrassa 2025 p. 42 · Xifres romanes', 'xifra romana Lletra majúscula emprada pels romans per a representar els nombres: I, V, X, L, C, D, M.', null, '67a39524141146c62adddfa0d612501a6e25bb56c79ae9334a570f8ec9992157', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '67a39524141146c62adddfa0d612501a6e25bb56c79ae9334a570f8ec9992157')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'MMXXVI', true), ('B', 'MMXXIV', false), ('C', 'MMXVI', false), ('D', 'MCMXXVI', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Quin és el terme següent de la successió 4, 8, 12, 16...?', 'Rèplica de la p. 44 (successió aritmètica). Cada terme suma 4: són els múltiples de 4.', 'plcatexamen_2025_terrassa', (select id from public.topics where slug = 'plcatexamen-2025-terrassa'), 1, 'ca', true, (select id from public.sources where url = 'https://dlc.iec.cat/'), 'Terrassa 2025 p. 44 · Successió de múltiples', 'múltiple2 -a 1 adj. [LC] [MT] Referit a un nombre enter, que el conté un nombre exacte de vegades.', null, 'aa50717c33b8b5651ff66e0a4c72f75083403776391d76693aa30d59fb0f5d3a', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'aa50717c33b8b5651ff66e0a4c72f75083403776391d76693aa30d59fb0f5d3a')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', '18', false), ('B', '20', true), ('C', '24', false), ('D', '32', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Quants dies té un any comú (no de traspàs)?', 'Rèplica de la p. 47. L''any comú té 365 dies i el de traspàs, 366.', 'plcatexamen_2025_terrassa', (select id from public.topics where slug = 'plcatexamen-2025-terrassa'), 1, 'ca', true, (select id from public.sources where url = 'https://dlc.iec.cat/'), 'Terrassa 2025 p. 47 · Any de traspàs', 'any comú Any civil que consta de 365 dies.', null, '53297ce0ea33c53344c227c56211ef58a3efd2d98efdd9fa73791a9123ae8b0c', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '53297ce0ea33c53344c227c56211ef58a3efd2d98efdd9fa73791a9123ae8b0c')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', '365', true), ('B', '366', false), ('C', '364', false), ('D', '360', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
-- Lote plcatexamen-2025-terrassa-cultural-genhist-v1 (2 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Història de la Generalitat (Diputació del General, Nova Planta i Generalitat contemporània)', 'https://web.gencat.cat/ca/generalitat/qui-som/historia-generalitat', 'web_oficial'::public.source_kind, 'Generalitat de Catalunya', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('plcatexamen-2025-terrassa', 'Examen rèplica · Terrassa 2025 (1f/AGENTS/2025), exercici teòric: 50 preguntes') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('policia-local') and t.slug = 'plcatexamen-2025-terrassa' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Quin número de president de la Generalitat és Salvador Illa, investit el 8 d''agost de 2024?', 'Rèplica de la p. 18 (càrrec de la Generalitat). Pujol va ser el 126è i Puigdemont el 130è.', 'plcatexamen_2025_terrassa', (select id from public.topics where slug = 'plcatexamen-2025-terrassa'), 1, 'ca', true, (select id from public.sources where url = 'https://web.gencat.cat/ca/generalitat/qui-som/historia-generalitat'), 'Terrassa 2025 p. 18 · President de la Generalitat', 'Salvador Illa va ser investit 133è president de la Generalitat el 8 d’agost de 2024', null, 'ad19949bc5933e4a60d3b8661c32ec69c841cfafb8244ea6b89f6e52fa09c280', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'ad19949bc5933e4a60d3b8661c32ec69c841cfafb8244ea6b89f6e52fa09c280')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El 126è', false), ('B', 'El 130è', false), ('C', 'El 133è', true), ('D', 'El 100è', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Quin rei va presidir la Cort de Barcelona de 1283, on es va implantar el sistema pactista?', 'Rèplica de la p. 43 (rei medieval; es pregunta per un rei de la Corona d''Aragó en lloc d''Alfons X).', 'plcatexamen_2025_terrassa', (select id from public.topics where slug = 'plcatexamen-2025-terrassa'), 2, 'ca', true, (select id from public.sources where url = 'https://web.gencat.cat/ca/generalitat/qui-som/historia-generalitat'), 'Terrassa 2025 p. 43 · Pere el Gran', 'A la Cort de Barcelona de 1283, presidida pel rei Pere el Gran, es va implantar el sistema pactista.', null, '9be889c9d34ac9712d36ae8745e202a02913d934e393cd594eed7f0468693488', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '9be889c9d34ac9712d36ae8745e202a02913d934e393cd594eed7f0468693488')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Jaume I', false), ('B', 'Martí l''Humà', false), ('C', 'Pere el Cerimoniós', false), ('D', 'Pere el Gran', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
-- Lote plcatexamen-2025-terrassa-cultural-govcreu26-v1 (5 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('El Govern distingeix amb la Creu de Sant Jordi 20 persones i 10 entitats (nota de premsa, 14/04/2026)', 'https://govern.cat/gov/notes-premsa/812364/govern-distingeix-creu-sant-jordi-20-persones-10-entitats', 'web_oficial'::public.source_kind, 'Generalitat de Catalunya, Govern.cat', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('plcatexamen-2025-terrassa', 'Examen rèplica · Terrassa 2025 (1f/AGENTS/2025), exercici teòric: 50 preguntes') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('policia-local') and t.slug = 'plcatexamen-2025-terrassa' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Quin aniversari va celebrar la Universitat de Barcelona el 2025?', 'Rèplica de la p. 10 (formació; substituïda per un fet universitari de Catalunya). La UB, fundada el 1450, va rebre la Creu de Sant Jordi el 14 d''abril de 2026.', 'plcatexamen_2025_terrassa', (select id from public.topics where slug = 'plcatexamen-2025-terrassa'), 2, 'ca', true, (select id from public.sources where url = 'https://govern.cat/gov/notes-premsa/812364/govern-distingeix-creu-sant-jordi-20-persones-10-entitats'), 'Terrassa 2025 p. 10 · Universitat de Barcelona', 'L’any 2025 va celebrar el 575è aniversari.', null, '650ae60ad5f6450c2b3025daadda0e77fb893b2ab6b20fd3cf4fa2a96de49d86', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '650ae60ad5f6450c2b3025daadda0e77fb893b2ab6b20fd3cf4fa2a96de49d86')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El 500è aniversari', false), ('B', 'El 250è aniversari', false), ('C', 'El 575è aniversari', true), ('D', 'El centenari', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'En quin any es va crear la Creu de Sant Jordi, una de les màximes distincions de la Generalitat?', 'Rèplica de la p. 20 (reconeixement institucional). 14 d''abril de 2026: Creu de Sant Jordi a 20 persones i 10 entitats.', 'plcatexamen_2025_terrassa', (select id from public.topics where slug = 'plcatexamen-2025-terrassa'), 2, 'ca', true, (select id from public.sources where url = 'https://govern.cat/gov/notes-premsa/812364/govern-distingeix-creu-sant-jordi-20-persones-10-entitats'), 'Terrassa 2025 p. 20 · Creu de Sant Jordi', 'La distinció es va crear el 1981', null, '39fee9891106ac959d8c40b98c0599672f2545a1e0d6948431adb63d1e306a0a', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '39fee9891106ac959d8c40b98c0599672f2545a1e0d6948431adb63d1e306a0a')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', '1981', true), ('B', '1932', false), ('C', '1977', false), ('D', '2006', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'En quin gènere ha destacat l''escriptora Maite Carranza, Creu de Sant Jordi 2026?', 'Rèplica de la p. 21 (autora de la literatura catalana). 14 d''abril de 2026.', 'plcatexamen_2025_terrassa', (select id from public.topics where slug = 'plcatexamen-2025-terrassa'), 3, 'ca', true, (select id from public.sources where url = 'https://govern.cat/gov/notes-premsa/812364/govern-distingeix-creu-sant-jordi-20-persones-10-entitats'), 'Terrassa 2025 p. 21 · Maite Carranza', 'Maite Carranza Gil-Dolz del Castellar. Escriptora: per la seva trajectòria literària i la seva contribució a la literatura infantil i juvenil.', null, 'c781d395e64d6b9880a8bc307f35f5ffcc0138c7413f68a19f3805b19ffb5476', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'c781d395e64d6b9880a8bc307f35f5ffcc0138c7413f68a19f3805b19ffb5476')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'La poesia', false), ('B', 'El periodisme radiofònic', false), ('C', 'La literatura infantil i juvenil', true), ('D', 'La filosofia', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Quins premis Goya té l''actriu i cineasta Sílvia Munt, Creu de Sant Jordi 2026?', 'Rèplica de la p. 39 (actriu premiada; actualitzat). 14 d''abril de 2026; també té el Gaudí d''Honor 2026.', 'plcatexamen_2025_terrassa', (select id from public.topics where slug = 'plcatexamen-2025-terrassa'), 2, 'ca', true, (select id from public.sources where url = 'https://govern.cat/gov/notes-premsa/812364/govern-distingeix-creu-sant-jordi-20-persones-10-entitats'), 'Terrassa 2025 p. 39 · Sílvia Munt', 'els premis Goya a la millor actriu i al millor curtmetratge documental', null, 'c01027c35948cdfde1bdaf7750ba847b0a606fd7a9058b15ca7afab4b2cae3c0', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'c01027c35948cdfde1bdaf7750ba847b0a606fd7a9058b15ca7afab4b2cae3c0')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'A la millor actriu i al millor curtmetratge documental', true), ('B', 'A la millor direcció i al millor guió', false), ('C', 'A la millor actriu secundària i a la millor cançó', false), ('D', 'Al millor documental i a la millor pel·lícula', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Des de quin any es representen de manera continuada els Pastorets de Calaf, Creu de Sant Jordi 2026?', 'Rèplica de la p. 48 (festa popular; substitueix la Tomatina per una tradició catalana). 14 d''abril de 2026.', 'plcatexamen_2025_terrassa', (select id from public.topics where slug = 'plcatexamen-2025-terrassa'), 2, 'ca', true, (select id from public.sources where url = 'https://govern.cat/gov/notes-premsa/812364/govern-distingeix-creu-sant-jordi-20-persones-10-entitats'), 'Terrassa 2025 p. 48 · Pastorets de Calaf', 'representades de manera continuada a Calaf des de l’any 1925', null, '997245901522c4f42e128afebd7a0820229254a263a72cf34c6d73cdcf043663', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '997245901522c4f42e128afebd7a0820229254a263a72cf34c6d73cdcf043663')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Des de 1714', false), ('B', 'Des de 1981', false), ('C', 'Des de 1888', false), ('D', 'Des de 1925', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
-- Lote plcatexamen-2025-terrassa-cultural-govpic25-v1 (3 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('El Govern concedeix el Premi Internacional Catalunya 2025 a les activistes per la pau Yael Admi i Reem Alhajajra (acords de Govern, 23/12/2025)', 'https://govern.cat/gov/acords-govern/16039/govern-concedeix-premi-internacional-catalunya-2025-activistes-pau-yael-admi-reem-alhajajra', 'web_oficial'::public.source_kind, 'Generalitat de Catalunya, Govern.cat', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('plcatexamen-2025-terrassa', 'Examen rèplica · Terrassa 2025 (1f/AGENTS/2025), exercici teòric: 50 preguntes') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('policia-local') and t.slug = 'plcatexamen-2025-terrassa' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Qui va encapçalar el lliurament del Premi Internacional Catalunya 2025, el 15 de gener de 2026?', 'Rèplica de la p. 8 (campanya solidària local; substituïda per un premi de Catalunya a la pau). 23 de desembre de 2025.', 'plcatexamen_2025_terrassa', (select id from public.topics where slug = 'plcatexamen-2025-terrassa'), 3, 'ca', true, (select id from public.sources where url = 'https://govern.cat/gov/acords-govern/16039/govern-concedeix-premi-internacional-catalunya-2025-activistes-pau-yael-admi-reem-alhajajra'), 'Terrassa 2025 p. 8 · Premi Internacional Catalunya, lliurament', 'Els guardons es lliuraran en un acte institucional al Palau de la Generalitat encapçalat pel president de la Generalitat, Salvador Illa el pròxim 15 de gener.', null, '0f8d102c13907a1d9f395f0f0bcc6c9fdf91f8452197679730734f0af9ba4a3a', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '0f8d102c13907a1d9f395f0f0bcc6c9fdf91f8452197679730734f0af9ba4a3a')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'L''alcalde de Barcelona, Jaume Collboni', false), ('B', 'El president del Parlament, Josep Rull', false), ('C', 'El president de la Generalitat, Salvador Illa', true), ('D', 'El rei Felip VI', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'D''on són les activistes Yael Admi i Reem Alhajajra, Premi Internacional Catalunya 2025?', 'Rèplica de la p. 23 (reconeixement de l''estat de Palestina; substituït per un fet recent sobre el conflicte). 23 de desembre de 2025.', 'plcatexamen_2025_terrassa', (select id from public.topics where slug = 'plcatexamen-2025-terrassa'), 2, 'ca', true, (select id from public.sources where url = 'https://govern.cat/gov/acords-govern/16039/govern-concedeix-premi-internacional-catalunya-2025-activistes-pau-yael-admi-reem-alhajajra'), 'Terrassa 2025 p. 23 · Premi Internacional Catalunya 2025', 'activistes israeliana i palestina per la pau, respectivament', null, '1161d7c673aa26b38d1b2778b48c465344a23fed9ea2d833de5a2020c318c8b7', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '1161d7c673aa26b38d1b2778b48c465344a23fed9ea2d833de5a2020c318c8b7')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Ucraïnesa i russa, respectivament', false), ('B', 'Iraniana i afganesa, respectivament', false), ('C', 'Veneçolana i colombiana, respectivament', false), ('D', 'Israeliana i palestina, respectivament', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Quin pla va aprovar el Govern en la darrera reunió de 2025?', 'Rèplica de la p. 38 (pla del Govern; substitueix el pla d''Interior). 23 de desembre de 2025.', 'plcatexamen_2025_terrassa', (select id from public.topics where slug = 'plcatexamen-2025-terrassa'), 2, 'ca', true, (select id from public.sources where url = 'https://govern.cat/gov/acords-govern/16039/govern-concedeix-premi-internacional-catalunya-2025-activistes-pau-yael-admi-reem-alhajajra'), 'Terrassa 2025 p. 38 · Pla de 214.000 habitatges', 'En l''última reunió de l''any, l''Executiu també ha aprovat el pla per transformar sòl situat en sectors estratègics en solars preparats per construir-hi 214.000 nous habitatges', null, '90f1a7c01065aef75dbe6bef685bf37eaa9af83a7d620c1044e447648f33733e', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '90f1a7c01065aef75dbe6bef685bf37eaa9af83a7d620c1044e447648f33733e')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Un pla per declarar espais lliures d''armes', false), ('B', 'Un pla per ampliar la plantilla de Mossos en 10.000 agents', false), ('C', 'Un pla de reforma del Codi de consum', false), ('D', 'Un pla per preparar sòl per construir 214.000 nous habitatges', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
-- Lote plcatexamen-2025-terrassa-cultural-govpnc26-v1 (1 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('President Illa: "Com Pau Casals, enguany podem dir al món un ''som catalans'' col·lectiu..." (Premis Nacionals de Cultura 2026, nota de premsa, 09/10/2026)', 'https://govern.cat/salapremsa/notes-premsa/878952/president-illa-com-pau-casals-enguany-dir-al-mon-som-catalans-collectiu-tothom-shi-senti-representat-part-activa', 'web_oficial'::public.source_kind, 'Generalitat de Catalunya, Govern.cat', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('plcatexamen-2025-terrassa', 'Examen rèplica · Terrassa 2025 (1f/AGENTS/2025), exercici teòric: 50 preguntes') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('policia-local') and t.slug = 'plcatexamen-2025-terrassa' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Entre quines disciplines se situa la pràctica artística de Cabosanroque, Premi Nacional de Cultura 2026?', 'Rèplica de la p. 24 (festival de música local; substituït per un premi musical de Catalunya). 9 d''octubre de 2026.', 'plcatexamen_2025_terrassa', (select id from public.topics where slug = 'plcatexamen-2025-terrassa'), 3, 'ca', true, (select id from public.sources where url = 'https://govern.cat/salapremsa/notes-premsa/878952/president-illa-com-pau-casals-enguany-dir-al-mon-som-catalans-collectiu-tothom-shi-senti-representat-part-activa'), 'Terrassa 2025 p. 24 · Cabosanroque', 'Cabosanroque, Premi Nacional de Cultura per l’originalitat de la seva pràctica artística, a cavall entre la música i les instal·lacions visuals.', null, 'f9c5bffd0351183d476a704ba147c9c57be0e863546ea317c80ae28a4c0750b6', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'f9c5bffd0351183d476a704ba147c9c57be0e863546ea317c80ae28a4c0750b6')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Entre la música i les instal·lacions visuals', true), ('B', 'Entre el teatre i la dansa', false), ('C', 'Entre la literatura i el cinema', false), ('D', 'Entre l''arquitectura i el disseny', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
-- Lote plcatexamen-2025-terrassa-cultural-govpress26-v1 (2 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Els pressupostos de la Generalitat per al 2026 creixen un 22,8% respecte als darrers aprovats i acceleren la inversió amb fons propis (nota de premsa, 27/02/2026)', 'https://govern.cat/salapremsa/notes-premsa/795676/pressupostos-generalitat-al-2026-creixen-228-percent-respecte-als-darrers-aprovats-acceleren-inversio-fons-propis', 'web_oficial'::public.source_kind, 'Generalitat de Catalunya, Govern.cat', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('plcatexamen-2025-terrassa', 'Examen rèplica · Terrassa 2025 (1f/AGENTS/2025), exercici teòric: 50 preguntes') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('policia-local') and t.slug = 'plcatexamen-2025-terrassa' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'En quin percentatge superava el projecte de pressupostos de la Generalitat per al 2026 els darrers pressupostos aprovats, els del 2023?', 'Rèplica de la p. 7 (programa públic econòmic; substituït per un fet econòmic de Catalunya). 27 de febrer de 2026: 49.162 M€, 9.126 M€ més que el 2023.', 'plcatexamen_2025_terrassa', (select id from public.topics where slug = 'plcatexamen-2025-terrassa'), 3, 'ca', true, (select id from public.sources where url = 'https://govern.cat/salapremsa/notes-premsa/795676/pressupostos-generalitat-al-2026-creixen-228-percent-respecte-als-darrers-aprovats-acceleren-inversio-fons-propis'), 'Terrassa 2025 p. 7 · Pressupostos de la Generalitat 2026', 'que superen en un 22,8% (+9.126 M€) l’import dels pressupostos del 2023, els darrers aprovats.', null, 'd441b12589d37dc6faf9bffc34d20b8f66c33bc957d25794c8d01d61f5f6ee74', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'd441b12589d37dc6faf9bffc34d20b8f66c33bc957d25794c8d01d61f5f6ee74')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Un 2,7%', false), ('B', 'Un 8%', false), ('C', 'Un 49%', false), ('D', 'Un 22,8%', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Qui és el president del Parlament de Catalunya?', 'Rèplica de la p. 33. Febrer de 2026.', 'plcatexamen_2025_terrassa', (select id from public.topics where slug = 'plcatexamen-2025-terrassa'), 1, 'ca', true, (select id from public.sources where url = 'https://govern.cat/salapremsa/notes-premsa/795676/pressupostos-generalitat-al-2026-creixen-228-percent-respecte-als-darrers-aprovats-acceleren-inversio-fons-propis'), 'Terrassa 2025 p. 33 · President del Parlament', 'el president del Parlament, Josep Rull', null, 'd2910a7c8c2a19c4b7a481445ec4025e23808afb5092cfb56577172fd9e9f89c', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'd2910a7c8c2a19c4b7a481445ec4025e23808afb5092cfb56577172fd9e9f89c')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Salvador Illa', false), ('B', 'Alícia Romero', false), ('C', 'Josep Rull', true), ('D', 'Jaume Collboni', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
-- Lote plcatexamen-2025-terrassa-cultural-idescat-v1 (4 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Anuari estadístic de Catalunya i El municipi en xifres (Institut d''Estadística de Catalunya)', 'https://www.idescat.cat/indicadors/?id=aec&lang=ca', 'web_oficial'::public.source_kind, 'Institut d''Estadística de Catalunya (Idescat)', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('plcatexamen-2025-terrassa', 'Examen rèplica · Terrassa 2025 (1f/AGENTS/2025), exercici teòric: 50 preguntes') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('policia-local') and t.slug = 'plcatexamen-2025-terrassa' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Quin riu de les conques internes de Catalunya té la conca més extensa, amb 4.948 km²?', 'Rèplica de la p. 1 (rius d''Espanya; es pregunta per un riu català). El Llobregat fa 170 km i té una conca de 4.948 km²; el Ter és més llarg (208 km) però amb menys conca (3.010 km²).', 'plcatexamen_2025_terrassa', (select id from public.topics where slug = 'plcatexamen-2025-terrassa'), 2, 'ca', true, (select id from public.sources where url = 'https://www.idescat.cat/indicadors/?id=aec&lang=ca'), 'Terrassa 2025 p. 1 · Conca del Llobregat', 'Llobregat 170 4.948 Castellbell i el Vilar 381,6', null, '47b27d0754c10dd909b48d457fb83767a04bf6a090dce4c5e6ca18b745a4e244', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '47b27d0754c10dd909b48d457fb83767a04bf6a090dce4c5e6ca18b745a4e244')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El Llobregat', true), ('B', 'El Ter', false), ('C', 'El Fluvià', false), ('D', 'La Muga', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Quina població provisional tenia Catalunya a 1 de gener de 2026, segons Idescat?', 'Rèplica de la p. 4 (població del municipi; es pregunta per la de Catalunya). 8.210.710 habitants (provisional 2026).', 'plcatexamen_2025_terrassa', (select id from public.topics where slug = 'plcatexamen-2025-terrassa'), 2, 'ca', true, (select id from public.sources where url = 'https://www.idescat.cat/indicadors/?id=aec&lang=ca'), 'Terrassa 2025 p. 4 · Població de Catalunya', '2026 (p) 6.017.087 839.692 464.600 889.331 8.210.710', null, 'fee925302b815f9054370527b371e828c529b6c2abb5fc93855d5348f055623f', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'fee925302b815f9054370527b371e828c529b6c2abb5fc93855d5348f055623f')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Uns 6 milions d''habitants', false), ('B', 'Uns 10,5 milions d''habitants', false), ('C', 'Uns 1,7 milions d''habitants', false), ('D', 'Uns 8,2 milions d''habitants', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'A quina província pertanyen els municipis de l''Aran?', 'Rèplica de la p. 16 (província d''un municipi).', 'plcatexamen_2025_terrassa', (select id from public.topics where slug = 'plcatexamen-2025-terrassa'), 1, 'ca', true, (select id from public.sources where url = 'https://www.idescat.cat/indicadors/?id=aec&lang=ca'), 'Terrassa 2025 p. 16 · Província de l''Aran', 'Aran Vielha e Mijaran Lleida 9 10.651', null, '53607b3226132885f608aed61ff9ef38e50e80500ac17f3a76aac272de47b319', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '53607b3226132885f608aed61ff9ef38e50e80500ac17f3a76aac272de47b319')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Lleida', true), ('B', 'Girona', false), ('C', 'Barcelona', false), ('D', 'Osca', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Amb quina regla es reparteixen els escons al Parlament i els regidors als ajuntaments?', 'Rèplica de la p. 46 (govern municipal; es pregunta pel sistema electoral).', 'plcatexamen_2025_terrassa', (select id from public.topics where slug = 'plcatexamen-2025-terrassa'), 2, 'ca', true, (select id from public.sources where url = 'https://www.idescat.cat/indicadors/?id=aec&lang=ca'), 'Terrassa 2025 p. 46 · Sistema d''Hondt', 'La distribució d''escons (siguin escons al Parlament o regidors per als consistoris) es fa d''acord amb la regla matemàtica d''Hondt.', null, 'f70e1e83b942bf3475125c7a963bbd13ffb4910f32800ba52dd4e46150f05d4a', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'f70e1e83b942bf3475125c7a963bbd13ffb4910f32800ba52dd4e46150f05d4a')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El sistema majoritari a dues voltes', false), ('B', 'La regla de Sainte-Laguë', false), ('C', 'La regla d''Hondt', true), ('D', 'El vot únic transferible', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
-- Lote plcatexamen-2025-terrassa-cultural-moncloasmi26-v1 (1 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Pedro Sánchez destaca que con la subida del SMI en 2026 se da "un paso muy relevante para mejorar la vida de 2,5 millones de trabajadores" (16/02/2026)', 'https://www.lamoncloa.gob.es/presidente/actividades/Paginas/2026/160226-sanchez-subida-salario-minimo.aspx', 'web_oficial'::public.source_kind, 'La Moncloa, Gobierno de España', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('plcatexamen-2025-terrassa', 'Examen rèplica · Terrassa 2025 (1f/AGENTS/2025), exercici teòric: 50 preguntes') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('policia-local') and t.slug = 'plcatexamen-2025-terrassa' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Quin ministeri dirigeix Yolanda Díaz, vicepresidenta segona del Govern?', 'Rèplica de la p. 26 (ministre del Govern d''Espanya). 16 de febrer de 2026, acte de la pujada de l''SMI.', 'plcatexamen_2025_terrassa', (select id from public.topics where slug = 'plcatexamen-2025-terrassa'), 2, 'ca', true, (select id from public.sources where url = 'https://www.lamoncloa.gob.es/presidente/actividades/Paginas/2026/160226-sanchez-subida-salario-minimo.aspx'), 'Terrassa 2025 p. 26 · Yolanda Díaz', 'la vicepresidenta segunda y ministra de Trabajo y Economía Social, Yolanda Díaz', null, '4a69ecac504c3eef8e45328c8870a8446e6607dab967016daed47497c6332f43', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '4a69ecac504c3eef8e45328c8870a8446e6607dab967016daed47497c6332f43')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Indústria i Turisme', false), ('B', 'Hisenda', false), ('C', 'Treball i Economia Social', true), ('D', 'Interior', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
-- Lote plcatexamen-2025-terrassa-cultural-nobelhist-v1 (2 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('NobelPrize.org: All Nobel Prizes 2025 i fitxes de premiats (Literature 1956, 1977, 1982, 1989, 2010, 2023-2024; Peace 2023-2024)', 'https://www.nobelprize.org/all-nobel-prizes-2025/', 'web_oficial'::public.source_kind, 'Nobel Foundation / Nobel Prize Outreach', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('plcatexamen-2025-terrassa', 'Examen rèplica · Terrassa 2025 (1f/AGENTS/2025), exercici teòric: 50 preguntes') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('policia-local') and t.slug = 'plcatexamen-2025-terrassa' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Quina escriptora sud-coreana va rebre el premi Nobel de literatura el 2024?', 'Rèplica de la p. 6 (autora d''una obra mundialment coneguda). Han Kang, Nobel 2024; Anne Carson, Nobel 2026.', 'plcatexamen_2025_terrassa', (select id from public.topics where slug = 'plcatexamen-2025-terrassa'), 2, 'ca', true, (select id from public.sources where url = 'https://www.nobelprize.org/all-nobel-prizes-2025/'), 'Terrassa 2025 p. 6 · Han Kang', 'Nobel Prize in Literature 2024 Han Kang', null, 'cba2d1604bd1a79f394d9d27b42b6af7a96ac3fcc13ffcabb7e73e4194d03974', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'cba2d1604bd1a79f394d9d27b42b6af7a96ac3fcc13ffcabb7e73e4194d03974')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Han Kang', true), ('B', 'Anne Carson', false), ('C', 'Narges Mohammadi', false), ('D', 'Olga Tokarczuk', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'En quin any va rebre Juan Ramón Jiménez el premi Nobel de literatura?', 'Rèplica de la p. 34 (obra de Juan Ramón Jiménez). 1977 és Aleixandre; 1989, Cela; 1982, García Márquez.', 'plcatexamen_2025_terrassa', (select id from public.topics where slug = 'plcatexamen-2025-terrassa'), 2, 'ca', true, (select id from public.sources where url = 'https://www.nobelprize.org/all-nobel-prizes-2025/'), 'Terrassa 2025 p. 34 · Juan Ramón Jiménez', 'Juan Ramón Jiménez Nobel Prize in Literature 1956', null, '2a57d8d53d432476bf1a25800431fc7ae6bb111e74a54d1cf28e96052d360cf1', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '2a57d8d53d432476bf1a25800431fc7ae6bb111e74a54d1cf28e96052d360cf1')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', '1977', false), ('B', '1989', false), ('C', '1982', false), ('D', '1956', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
-- Lote plcatexamen-2025-terrassa-cultural-onu-v1 (1 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('United Nations: About Us, UN Charter, Main Bodies i Selection and Appointment of the Next Secretary-General', 'https://www.un.org/en/about-us', 'web_oficial'::public.source_kind, 'United Nations', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('plcatexamen-2025-terrassa', 'Examen rèplica · Terrassa 2025 (1f/AGENTS/2025), exercici teòric: 50 preguntes') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('policia-local') and t.slug = 'plcatexamen-2025-terrassa' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Per a quin càrrec va ser candidata Michelle Bachelet fins que va retirar la candidatura el 21 de setembre de 2026?', 'Rèplica de la p. 45 (dirigent política internacional; substitueix la vicepresidenta dels EUA). El procés de selecció va començar el 25 de novembre de 2025.', 'plcatexamen_2025_terrassa', (select id from public.topics where slug = 'plcatexamen-2025-terrassa'), 3, 'ca', true, (select id from public.sources where url = 'https://www.un.org/en/about-us'), 'Terrassa 2025 p. 45 · Candidatura de Bachelet', 'Michelle Bachelet Jeria (nominated 2 February 2026; withdrawn 21 September 2026)', null, '0a3033e19e610cc6984b7e11839cf8c2115f0aa02909fc420270cf996905b733', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '0a3033e19e610cc6984b7e11839cf8c2115f0aa02909fc420270cf996905b733')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Presidenta del Consell Europeu', false), ('B', 'Secretària general de les Nacions Unides', true), ('C', 'Alta comissionada de l''ONU per als drets humans', false), ('D', 'Presidenta de la COP31', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
-- Lote plcatexamen-2025-terrassa-cultural-ue-v1 (2 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Portal oficial de la Unión Europea: países, historia, euro e instituciones', 'https://european-union.europa.eu/index_es', 'web_oficial'::public.source_kind, 'Unión Europea', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('plcatexamen-2025-terrassa', 'Examen rèplica · Terrassa 2025 (1f/AGENTS/2025), exercici teòric: 50 preguntes') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('policia-local') and t.slug = 'plcatexamen-2025-terrassa' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Quants eurodiputats té el Parlament Europeu, presidit per Roberta Metsola?', 'Rèplica de la p. 12 (presidenta del Parlament Europeu).', 'plcatexamen_2025_terrassa', (select id from public.topics where slug = 'plcatexamen-2025-terrassa'), 2, 'ca', true, (select id from public.sources where url = 'https://european-union.europa.eu/index_es'), 'Terrassa 2025 p. 12 · Parlament Europeu', 'Miembros: 720 eurodiputados (diputados al Parlamento Europeo) Presidenta: Roberta Metsola', null, 'fd6fba9dd29ee10b8a28a378ba983976d98bc53dd4b0ee91eedc7f7d44f6ca33', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'fd6fba9dd29ee10b8a28a378ba983976d98bc53dd4b0ee91eedc7f7d44f6ca33')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', '350', false), ('B', '720', true), ('C', '135', false), ('D', '27', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Quin càrrec ocupa Ursula von der Leyen?', 'Rèplica de la p. 25.', 'plcatexamen_2025_terrassa', (select id from public.topics where slug = 'plcatexamen-2025-terrassa'), 1, 'ca', true, (select id from public.sources where url = 'https://european-union.europa.eu/index_es'), 'Terrassa 2025 p. 25 · Càrrec de von der Leyen', 'Presidencia: Ursula von der Leyen', null, '825be91dcc4b8bd0db1e8a87b38e66b81c34b9daa506bc239d3993b1308b37dc', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '825be91dcc4b8bd0db1e8a87b38e66b81c34b9daa506bc239d3993b1308b37dc')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Presidenta del Parlament Europeu', false), ('B', 'Presidenta del Banc Central Europeu', false), ('C', 'Presidenta del Consell Europeu', false), ('D', 'Presidenta de la Comissió Europea', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
-- Lote plcatexamen-2025-terrassa-cultural-uepaisos-v1 (1 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Países de la UE: fichas de país (european-union.europa.eu/principles-countries-history/eu-countries/<país>_es)', 'https://european-union.europa.eu/principles-countries-history/eu-countries_es', 'web_oficial'::public.source_kind, 'Unión Europea', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('plcatexamen-2025-terrassa', 'Examen rèplica · Terrassa 2025 (1f/AGENTS/2025), exercici teòric: 50 preguntes') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('policia-local') and t.slug = 'plcatexamen-2025-terrassa' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Quin estat de la UE ha negociat una clàusula d''exclusió voluntària de l''espai Schengen?', 'Rèplica de la p. 11 (Gibraltar i Schengen). Irlanda és a la UE des de 1973 però fora de Schengen; Irlanda presideix el Consell de la UE el segon semestre de 2026.', 'plcatexamen_2025_terrassa', (select id from public.topics where slug = 'plcatexamen-2025-terrassa'), 3, 'ca', true, (select id from public.sources where url = 'https://european-union.europa.eu/principles-countries-history/eu-countries_es'), 'Terrassa 2025 p. 11 · Irlanda i Schengen', 'Schengen: Irlanda ha negociado una cláusula de exclusión voluntaria del espacio Schengen.', null, '733754226ad5278fe6b73de430989373f7dd44e01fba9a8544dc003df300efef', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '733754226ad5278fe6b73de430989373f7dd44e01fba9a8544dc003df300efef')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Espanya', false), ('B', 'Bulgària', false), ('C', 'Croàcia', false), ('D', 'Irlanda', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
-- Lote plcatexamen-2025-terrassa-cultural-unesco-v1 (1 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('World Heritage List (fitxes dels béns inscrits), UNESCO World Heritage Centre', 'https://whc.unesco.org/en/list/', 'web_oficial'::public.source_kind, 'UNESCO World Heritage Centre', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('plcatexamen-2025-terrassa', 'Examen rèplica · Terrassa 2025 (1f/AGENTS/2025), exercici teòric: 50 preguntes') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('policia-local') and t.slug = 'plcatexamen-2025-terrassa' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Quin aniversari celebrava l''Estàtua de la Llibertat, regal de França als Estats Units inaugurat el 1886?', 'Rèplica de la p. 22 (història dels Estats Units). Obra de Bartholdi, amb estructura de Gustave Eiffel.', 'plcatexamen_2025_terrassa', (select id from public.topics where slug = 'plcatexamen-2025-terrassa'), 3, 'ca', true, (select id from public.sources where url = 'https://whc.unesco.org/en/list/'), 'Terrassa 2025 p. 22 · Estàtua de la Llibertat', 'this towering monument to liberty was a gift from France on the centenary of American independence. Inaugurated in 1886', null, 'd96c74416279d8756e3b4252c1b4e3ea8c8b3ca3fdeeeba945878f4a7580815f', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'd96c74416279d8756e3b4252c1b4e3ea8c8b3ca3fdeeeba945878f4a7580815f')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'La fi de la guerra de Secessió', false), ('B', 'El centenari de la independència americana', true), ('C', 'La Revolució Francesa', false), ('D', 'L''abolició de l''esclavitud', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
-- Lote plcatexamen-2026-terrassa-cultural-bcnarq-v1 (1 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Barcelona 2026, Capital Mundial de l’Arquitectura', 'https://ajuntament.barcelona.cat/urbanisme-accio-climatica-mobilitat-pla-barris-serveis-urbans/ca/news/barcelona-2026-capital-mundial-de-larquitectura-1377921', 'web_oficial'::public.source_kind, 'Ajuntament de Barcelona', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('plcatexamen-2026-terrassa', 'Examen rèplica · Terrassa 2026 (1f/AGENTS/2026), exercici teòric: 50 preguntes') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('policia-local') and t.slug = 'plcatexamen-2026-terrassa' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Quin congrés internacional va acollir Barcelona l''estiu de 2026, com a Capital Mundial de l''Arquitectura?', 'Rèplica de la p. 33 (equipament cultural local; substituït per un fet de Barcelona). Estiu de 2026.', 'plcatexamen_2026_terrassa', (select id from public.topics where slug = 'plcatexamen-2026-terrassa'), 3, 'ca', true, (select id from public.sources where url = 'https://ajuntament.barcelona.cat/urbanisme-accio-climatica-mobilitat-pla-barris-serveis-urbans/ca/news/barcelona-2026-capital-mundial-de-larquitectura-1377921'), 'Terrassa 2026 p. 33 · Congrés de la UIA', 'A l’estiu la ciutat serà la seu del Congrés de la Unió Internacional d’Arquitectes', null, 'a553bd83a0175cd625e532b1cdc76be1e09b0dd4559ba368156268cac35f4886', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'a553bd83a0175cd625e532b1cdc76be1e09b0dd4559ba368156268cac35f4886')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El Mobile World Congress', false), ('B', 'El de la Unió Internacional de Telecomunicacions', false), ('C', 'El de la Unió Internacional d''Arquitectes', true), ('D', 'El de l''Organització Mundial del Turisme', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
-- Lote plcatexamen-2026-terrassa-cultural-bcnmerce26-v1 (2 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Tota la programació de la Mercè 2026 (16/09/2026) i Lectura del pregó de les Festes de la Mercè 2026 (22/09/2026)', 'https://ajuntament.barcelona.cat/ciutatvella/ca/noticies/tota-la-programacio-de-la-merce-2026-41192', 'web_oficial'::public.source_kind, 'Ajuntament de Barcelona', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('plcatexamen-2026-terrassa', 'Examen rèplica · Terrassa 2026 (1f/AGENTS/2026), exercici teòric: 50 preguntes') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('policia-local') and t.slug = 'plcatexamen-2026-terrassa' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Quants concerts tenia la programació de la Mercè 2026?', 'Rèplica de la p. 9 (servei municipal local; substituït per un fet de Barcelona). Setembre de 2026: 109 concerts, 55 actuacions de cultura popular i 180 funcions d''arts de carrer.', 'plcatexamen_2026_terrassa', (select id from public.topics where slug = 'plcatexamen-2026-terrassa'), 2, 'ca', true, (select id from public.sources where url = 'https://ajuntament.barcelona.cat/ciutatvella/ca/noticies/tota-la-programacio-de-la-merce-2026-41192'), 'Terrassa 2026 p. 9 · Programa de la Mercè', 'amb una programació de 109 concerts, 55 actuacions de cultura popular i 180 funcions d’arts de carrer.', null, '5818a57eca8d25fb7f795904a5d6ac0495ad4f6f248fd36a5022e28ebd575087', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '5818a57eca8d25fb7f795904a5d6ac0495ad4f6f248fd36a5022e28ebd575087')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', '55', false), ('B', '180', false), ('C', '1.000', false), ('D', '109', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Quina ciutat va ser convidada a la Mercè 2026?', 'Rèplica de la p. 36 (espai o fet local; substituït per un fet de Barcelona). Setembre de 2026.', 'plcatexamen_2026_terrassa', (select id from public.topics where slug = 'plcatexamen-2026-terrassa'), 2, 'ca', true, (select id from public.sources where url = 'https://ajuntament.barcelona.cat/ciutatvella/ca/noticies/tota-la-programacio-de-la-merce-2026-41192'), 'Terrassa 2026 p. 36 · Ciutat convidada de la Mercè', 'Shanghai, ciutat convidada d’enguany.', null, '880b2412f2d3dcb5027896895bd7913663849837de77f0176946e7a65fe90be9', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '880b2412f2d3dcb5027896895bd7913663849837de77f0176946e7a65fe90be9')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Nàpols', false), ('B', 'Lisboa', false), ('C', 'Mèxic', false), ('D', 'Xangai', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
-- Lote plcatexamen-2026-terrassa-cultural-bcnpapa26-v1 (1 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Barcelona acollirà aquest juny la visita del Papa Lleó XIV (29/05/2026)', 'https://ajuntament.barcelona.cat/oficina-afers-religiosos/ca/noticies/barcelona-acollira-aquest-juny-la-visita-del-papa-lleo-xiv-1640185', 'web_oficial'::public.source_kind, 'Ajuntament de Barcelona, Oficina d''Afers Religiosos', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('plcatexamen-2026-terrassa', 'Examen rèplica · Terrassa 2026 (1f/AGENTS/2026), exercici teòric: 50 preguntes') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('policia-local') and t.slug = 'plcatexamen-2026-terrassa' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Quin papa va celebrar una missa a la Sagrada Família el juny de 2026?', 'Rèplica de la p. 38 (papa anterior a Lleó XIV). 9-10 de juny de 2026.', 'plcatexamen_2026_terrassa', (select id from public.topics where slug = 'plcatexamen-2026-terrassa'), 1, 'ca', true, (select id from public.sources where url = 'https://ajuntament.barcelona.cat/oficina-afers-religiosos/ca/noticies/barcelona-acollira-aquest-juny-la-visita-del-papa-lleo-xiv-1640185'), 'Terrassa 2026 p. 38 · Lleó XIV', 'visita oficial del Papa Lleó XIV a l’Estat espanyol', null, 'd018ab277c1142b567fdf3b0ccb0115e4144d75129edb7f029dbb43e7beb0b7a', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'd018ab277c1142b567fdf3b0ccb0115e4144d75129edb7f029dbb43e7beb0b7a')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Francesc', false), ('B', 'Benet XVI', false), ('C', 'Lleó XIV', true), ('D', 'Joan XXIII', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
-- Lote plcatexamen-2026-terrassa-cultural-bcnparkg-v1 (1 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('El Park Güell presenta una exposició de 900 fotografies que recorren un segle de la seva història (05/11/2026)', 'https://ajuntament.barcelona.cat/premsa/2026/11/05/el-park-guell-presenta-una-exposicio-de-900-fotografies-que-recorren-un-segle-de-la-seva-historia/', 'web_oficial'::public.source_kind, 'Ajuntament de Barcelona', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('plcatexamen-2026-terrassa', 'Examen rèplica · Terrassa 2026 (1f/AGENTS/2026), exercici teòric: 50 preguntes') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('policia-local') and t.slug = 'plcatexamen-2026-terrassa' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Amb quins altres esdeveniments coincideix el centenari del Park Güell com a parc públic?', 'Rèplica de la p. 16 (aniversari d''un equipament de Barcelona; substitueix el del MACBA). 5 de novembre de 2026.', 'plcatexamen_2026_terrassa', (select id from public.topics where slug = 'plcatexamen-2026-terrassa'), 2, 'ca', true, (select id from public.sources where url = 'https://ajuntament.barcelona.cat/premsa/2026/11/05/el-park-guell-presenta-una-exposicio-de-900-fotografies-que-recorren-un-segle-de-la-seva-historia/'), 'Terrassa 2026 p. 16 · Park Güell', 'coincideix amb l’Any Gaudí i la Capitalitat Mundial de l’Arquitectura Barcelona 2026.', null, '2b0a058115f9eb2c596308417605f1041dda1a367860bb59bb0ddd52201759b8', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '2b0a058115f9eb2c596308417605f1041dda1a367860bb59bb0ddd52201759b8')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Amb l''Any Gaudí i la Capitalitat Mundial de l''Arquitectura Barcelona 2026', true), ('B', 'Amb els Jocs Olímpics i la Mercè', false), ('C', 'Amb el Fòrum de les Cultures i l''Any Picasso', false), ('D', 'Amb l''Exposició Universal i el Tour', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
-- Lote plcatexamen-2026-terrassa-cultural-bcnpremis25-v1 (1 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Premis Ciutat de Barcelona, 2025', 'https://ajuntament.barcelona.cat/ca/informacio-administrativa/premis/premis-ciutat-de-barcelona-2025', 'web_oficial'::public.source_kind, 'Ajuntament de Barcelona', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('plcatexamen-2026-terrassa', 'Examen rèplica · Terrassa 2026 (1f/AGENTS/2026), exercici teòric: 50 preguntes') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('policia-local') and t.slug = 'plcatexamen-2026-terrassa' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'On es van lliurar els Premis Ciutat de Barcelona 2025, l''11 de febrer de 2026?', 'Rèplica de la p. 40 (servei municipal local; substituït per un fet de Barcelona).', 'plcatexamen_2026_terrassa', (select id from public.topics where slug = 'plcatexamen-2026-terrassa'), 3, 'ca', true, (select id from public.sources where url = 'https://ajuntament.barcelona.cat/ca/informacio-administrativa/premis/premis-ciutat-de-barcelona-2025'), 'Terrassa 2026 p. 40 · Premis Ciutat de Barcelona', 'en un acte institucional al Saló de Cent de l’Ajuntament de Barcelona, el dia 11 de febrer del 2026.', null, '3d0e287793de43052f573632ec9ef838ce6a4bdc7fb8c060881eeb2da64ae385', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '3d0e287793de43052f573632ec9ef838ce6a4bdc7fb8c060881eeb2da64ae385')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Al Saló de Cent de l''Ajuntament de Barcelona', true), ('B', 'Al Palau de la Música Catalana', false), ('C', 'Al Gran Teatre del Liceu', false), ('D', 'Al Saló Sant Jordi del Palau de la Generalitat', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
-- Lote plcatexamen-2026-terrassa-cultural-bcntour26-v1 (1 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('La Festa Major del Tour omplirà Barcelona amb més de 60 propostes (15/05/2026) i Catalunya i Barcelona s’il·luminen de groc (26/03/2026)', 'https://ajuntament.barcelona.cat/premsa/2026/05/15/la-festa-major-del-tour-omplira-barcelona-amb-mes-de-60-propostes-per-celebrar-el-tour-de-franca/', 'web_oficial'::public.source_kind, 'Ajuntament de Barcelona', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('plcatexamen-2026-terrassa', 'Examen rèplica · Terrassa 2026 (1f/AGENTS/2026), exercici teòric: 50 preguntes') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('policia-local') and t.slug = 'plcatexamen-2026-terrassa' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'De quina ciutat va sortir el Tour de França 2026?', 'Rèplica de la p. 5 (fita esportiva de 2026). La Festa Major del Tour es va celebrar del 26 de juny al 5 de juliol.', 'plcatexamen_2026_terrassa', (select id from public.topics where slug = 'plcatexamen-2026-terrassa'), 1, 'ca', true, (select id from public.sources where url = 'https://ajuntament.barcelona.cat/premsa/2026/05/15/la-festa-major-del-tour-omplira-barcelona-amb-mes-de-60-propostes-per-celebrar-el-tour-de-franca/'), 'Terrassa 2026 p. 5 · Sortida del Tour', 'amb motiu de la sortida del Tour de França 2026.', null, '433c8a760284c13320101f39945a6341aa58efcb80596431056e839048dd9a63', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '433c8a760284c13320101f39945a6341aa58efcb80596431056e839048dd9a63')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'París', false), ('B', 'Barcelona', true), ('C', 'Bilbao', false), ('D', 'Florència', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
-- Lote plcatexamen-2026-terrassa-cultural-ce-v1 (1 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Constitución Española (texto consolidado, BOE)', 'https://www.boe.es/buscar/act.php?id=BOE-A-1978-31229', 'boe'::public.source_kind, 'Agencia Estatal Boletín Oficial del Estado', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('plcatexamen-2026-terrassa', 'Examen rèplica · Terrassa 2026 (1f/AGENTS/2026), exercici teòric: 50 preguntes') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('policia-local') and t.slug = 'plcatexamen-2026-terrassa' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 137 de la Constitució, l''Estat s''organitza territorialment en municipis, províncies i...', 'Rèplica de la p. 30 (nombre de comunitats autònomes; es pregunta per la base constitucional).', 'plcatexamen_2026_terrassa', (select id from public.topics where slug = 'plcatexamen-2026-terrassa'), 2, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1978-31229'), 'Terrassa 2026 p. 30 · Organització territorial de l''Estat', 'El Estado se organiza territorialmente en municipios, en provincias y en las Comunidades Autónomas que se constituyan.', null, '1635b49a57b23a0b200e517c06b995d6cf4f3a23b9ab93ad1c3f72c22cc0a6af', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '1635b49a57b23a0b200e517c06b995d6cf4f3a23b9ab93ad1c3f72c22cc0a6af')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Comarques', false), ('B', 'Vegueries', false), ('C', 'Regions', false), ('D', 'Comunitats autònomes', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
-- Lote plcatexamen-2026-terrassa-cultural-cervantes-v1 (1 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Gonzalo Celorio, Premio Cervantes 2025 (03/11/2025)', 'https://www.cultura.gob.es/actualidad/2025/11/251103-premio-cervantes-2025.html', 'web_oficial'::public.source_kind, 'Ministerio de Cultura', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('plcatexamen-2026-terrassa', 'Examen rèplica · Terrassa 2026 (1f/AGENTS/2026), exercici teòric: 50 preguntes') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('policia-local') and t.slug = 'plcatexamen-2026-terrassa' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Quina dotació té el Premi Cervantes, que el 2025 va guanyar Gonzalo Celorio?', 'Rèplica de la p. 28 (premi literari; substitueix el Planeta 2025). 3 de novembre de 2025.', 'plcatexamen_2026_terrassa', (select id from public.topics where slug = 'plcatexamen-2026-terrassa'), 2, 'ca', true, (select id from public.sources where url = 'https://www.cultura.gob.es/actualidad/2025/11/251103-premio-cervantes-2025.html'), 'Terrassa 2026 p. 28 · Premi Cervantes 2025', 'Concedido por el Ministerio de Cultura, el galardón está dotado con 125.000 euros.', null, 'c7e0804fec9484f19dc719cab29d047afa5587c5f5a50c40fa5515d9696910fa', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'c7e0804fec9484f19dc719cab29d047afa5587c5f5a50c40fa5515d9696910fa')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', '125.000 euros', true), ('B', '1.000.000 d''euros', false), ('C', '50.000 euros', false), ('D', '601.000 euros', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
-- Lote plcatexamen-2026-terrassa-cultural-consue26-v1 (1 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Presidency of the Council of the EU (Irish Presidency, July-December 2026)', 'https://irish-presidency.consilium.europa.eu/en/presidency/presidency-of-the-council-of-the-eu/', 'web_oficial'::public.source_kind, 'Council of the European Union', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('plcatexamen-2026-terrassa', 'Examen rèplica · Terrassa 2026 (1f/AGENTS/2026), exercici teòric: 50 preguntes') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('policia-local') and t.slug = 'plcatexamen-2026-terrassa' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Quin país presidirà el Consell de la UE de gener a juny de 2027, després d''Irlanda?', 'Rèplica de la p. 15 (presidència del Consell de la UE). Irlanda (juliol-desembre de 2026), Lituània (gener-juny de 2027) i Grècia (juliol-desembre de 2027) formen el trio.', 'plcatexamen_2026_terrassa', (select id from public.topics where slug = 'plcatexamen-2026-terrassa'), 3, 'ca', true, (select id from public.sources where url = 'https://irish-presidency.consilium.europa.eu/en/presidency/presidency-of-the-council-of-the-eu/'), 'Terrassa 2026 p. 15 · Trio de presidències', 'Lithuania will hold the Presidency from January–June 2027, followed by Greece from July–December 2027.', null, '05677ff9440f97563fa7ca7b2403fb577ed9b5cc6f76a9e3877e625d957561f8', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '05677ff9440f97563fa7ca7b2403fb577ed9b5cc6f76a9e3877e625d957561f8')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Grècia', false), ('B', 'Xipre', false), ('C', 'Dinamarca', false), ('D', 'Lituània', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
-- Lote plcatexamen-2026-terrassa-cultural-cop31-v1 (1 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('UN Climate Change Conference - Antalya, November 2026 (COP31)', 'https://unfccc.int/cop31', 'web_oficial'::public.source_kind, 'United Nations Framework Convention on Climate Change (UNFCCC)', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('plcatexamen-2026-terrassa', 'Examen rèplica · Terrassa 2026 (1f/AGENTS/2026), exercici teòric: 50 preguntes') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('policia-local') and t.slug = 'plcatexamen-2026-terrassa' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'De quin tractat internacional de 1992 és la Conferència de les Parts (COP) que el novembre de 2026 arriba a la 31a edició?', 'Rèplica de la p. 1 (seu de la COP30, actualitzada a la COP31: Antalya, 9-20 de novembre de 2026). L''Acord de París (2015) depèn de la UNFCCC.', 'plcatexamen_2026_terrassa', (select id from public.topics where slug = 'plcatexamen-2026-terrassa'), 3, 'ca', true, (select id from public.sources where url = 'https://unfccc.int/cop31'), 'Terrassa 2026 p. 1 · COP i UNFCCC', 'Officially, COP31 stands for the 31st meeting of the Conference of the Parties (COP) to the UN Framework Convention on Climate Change (UNFCCC), a landmark international treaty agreed in 1992, and parent treaty to the 2015 Paris Agreement.', null, 'a17cf8480806bcd96ebfbb184eecd9f8b63ebe274418ce6b4020a19eb123d277', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'a17cf8480806bcd96ebfbb184eecd9f8b63ebe274418ce6b4020a19eb123d277')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'La Convenció Marc de les Nacions Unides sobre el Canvi Climàtic (UNFCCC)', true), ('B', 'L''Acord de París', false), ('C', 'El Protocol de Kyoto', false), ('D', 'El Tractat de Maastricht', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
-- Lote plcatexamen-2026-terrassa-cultural-ddhc1789-v1 (1 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Déclaration des Droits de l''Homme et du Citoyen de 1789', 'https://www.conseil-constitutionnel.fr/le-bloc-de-constitutionnalite/declaration-des-droits-de-l-homme-et-du-citoyen-de-1789', 'web_oficial'::public.source_kind, 'Conseil constitutionnel (République française)', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('plcatexamen-2026-terrassa', 'Examen rèplica · Terrassa 2026 (1f/AGENTS/2026), exercici teòric: 50 preguntes') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('policia-local') and t.slug = 'plcatexamen-2026-terrassa' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Quina assemblea va proclamar la Declaració dels Drets de l''Home i del Ciutadà de 1789?', 'Rèplica de la p. 43 (inici de la Revolució Francesa).', 'plcatexamen_2026_terrassa', (select id from public.topics where slug = 'plcatexamen-2026-terrassa'), 2, 'ca', true, (select id from public.sources where url = 'https://www.conseil-constitutionnel.fr/le-bloc-de-constitutionnalite/declaration-des-droits-de-l-homme-et-du-citoyen-de-1789'), 'Terrassa 2026 p. 43 · Declaració de 1789', 'Les représentants du peuple français, constitués en Assemblée nationale', null, '19fc8b1b1ec3303bf8ea9c9c24cc4a0a6268086ae4061db1254af75ef4f31249', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '19fc8b1b1ec3303bf8ea9c9c24cc4a0a6268086ae4061db1254af75ef4f31249')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El Parlament anglès', false), ('B', 'El Congrés dels Estats Units', false), ('C', 'Les Corts de Cadis', false), ('D', 'L''Assemblea Nacional francesa', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
-- Lote plcatexamen-2026-terrassa-cultural-diec-v1 (15 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Diccionari de la llengua catalana, 2a edició (DIEC2), Institut d''Estudis Catalans', 'https://dlc.iec.cat/', 'web_oficial'::public.source_kind, 'Institut d''Estudis Catalans', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('plcatexamen-2026-terrassa', 'Examen rèplica · Terrassa 2026 (1f/AGENTS/2026), exercici teòric: 50 preguntes') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('policia-local') and t.slug = 'plcatexamen-2026-terrassa' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Quina característica és pròpia de la faula?', 'Rèplica de la p. 3.', 'plcatexamen_2026_terrassa', (select id from public.topics where slug = 'plcatexamen-2026-terrassa'), 1, 'ca', true, (select id from public.sources where url = 'https://dlc.iec.cat/'), 'Terrassa 2026 p. 3 · Faula', 'Narració en què es dona un ensenyament útil o moral, per mitjà d’una ficció al·legòrica en què intervenen animals i àdhuc éssers inanimats parlant i obrant com si fossin éssers humans o racionals.', null, '612374fab1bc6b0cc9ba020c2a27382f25197ab31568b7b3bbece3d52d7a46ac', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '612374fab1bc6b0cc9ba020c2a27382f25197ab31568b7b3bbece3d52d7a46ac')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'És un poema de catorze versos', false), ('B', 'Narra fets històrics reals amb dates exactes', false), ('C', 'Dona un ensenyament moral per mitjà d''una ficció en què parlen animals o objectes', true), ('D', 'És una obra de teatre en tres actes', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Com s''escriu en xifres romanes l''any 1714?', 'Rèplica de la p. 4 (un any històric en xifres romanes). M = 1000, D = 500, CC = 200, X = 10, IV = 4.', 'plcatexamen_2026_terrassa', (select id from public.topics where slug = 'plcatexamen-2026-terrassa'), 2, 'ca', true, (select id from public.sources where url = 'https://dlc.iec.cat/'), 'Terrassa 2026 p. 4 · 1714 en xifres romanes', 'xifra romana Lletra majúscula emprada pels romans per a representar els nombres: I, V, X, L, C, D, M.', null, 'a565034f4af9c089aed4099ae2ec44002c89d731f6afee30c716c8cd718083c1', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'a565034f4af9c089aed4099ae2ec44002c89d731f6afee30c716c8cd718083c1')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'MDCCXVI', false), ('B', 'MCCCXIV', false), ('C', 'MDCLXIV', false), ('D', 'MDCCXIV', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'El mot «boirum», format a partir de «boira» i «fum», és un...', 'Rèplica de la p. 6. Un acrònim es forma fusionant dos o més mots, un dels quals almenys s''ha escurçat.', 'plcatexamen_2026_terrassa', (select id from public.topics where slug = 'plcatexamen-2026-terrassa'), 2, 'ca', true, (select id from public.sources where url = 'https://dlc.iec.cat/'), 'Terrassa 2026 p. 6 · Acrònim', 'Els mots boirum i cantautor són acrònims formats a partir de boira i fum i de cantant i autor, respectivament.', null, '13cb1d53fac342621976357368169a3edee6736c059c53e4405331b80fed0842', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '13cb1d53fac342621976357368169a3edee6736c059c53e4405331b80fed0842')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Sigla', false), ('B', 'Prefix', false), ('C', 'Acrònim', true), ('D', 'Sinònim', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Com s''anomena la resistència de la matèria a modificar el seu estat de repòs o de moviment?', 'Rèplica de la p. 8 (principi físic; es pregunta per la inèrcia en lloc del principi d''Arquimedes).', 'plcatexamen_2026_terrassa', (select id from public.topics where slug = 'plcatexamen-2026-terrassa'), 2, 'ca', true, (select id from public.sources where url = 'https://dlc.iec.cat/'), 'Terrassa 2026 p. 8 · Inèrcia', 'inèrcia 2 1 f. [FIF] Resistència de la matèria a modificar el seu estat de repòs o de moviment.', null, 'bf1b990e5f6bdceef972854605fff4f82ab5f5b9f89e9fefcb0d28528aed568e', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'bf1b990e5f6bdceef972854605fff4f82ab5f5b9f89e9fefcb0d28528aed568e')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Pressió', false), ('B', 'Inèrcia', true), ('C', 'Gravetat', false), ('D', 'Fricció', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Com s''anomena la volta sinuosa que fa un riu?', 'Rèplica de la p. 12.', 'plcatexamen_2026_terrassa', (select id from public.topics where slug = 'plcatexamen-2026-terrassa'), 1, 'ca', true, (select id from public.sources where url = 'https://dlc.iec.cat/'), 'Terrassa 2026 p. 12 · Meandre', 'meandre 1 m. [GL] [LC] Volta sinuosa que fa un curs d’aigua, un riu, un camí.', null, '17c983a00d66bcbf6ae8b57c6d7b7ee39a591a5e59c7f0e0f64f2d580ec28d80', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '17c983a00d66bcbf6ae8b57c6d7b7ee39a591a5e59c7f0e0f64f2d580ec28d80')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Delta', false), ('B', 'Estuari', false), ('C', 'Afluent', false), ('D', 'Meandre', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Quin d''aquests animals és un amfibi?', 'Rèplica de la p. 17. Granotes, gripaus, tritons i salamandres són amfibis; llangardaixos i tortugues, rèptils; el dofí, mamífer.', 'plcatexamen_2026_terrassa', (select id from public.topics where slug = 'plcatexamen-2026-terrassa'), 1, 'ca', true, (select id from public.sources where url = 'https://dlc.iec.cat/'), 'Terrassa 2026 p. 17 · Amfibis', 'que inclou les granotes, els gripaus, els tritons i les salamandres.', null, '3e32b17031b8f14f140bd04b690942743a9cd8fc4e1a6309eebec6cd3e08f737', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '3e32b17031b8f14f140bd04b690942743a9cd8fc4e1a6309eebec6cd3e08f737')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El llangardaix', false), ('B', 'La tortuga', false), ('C', 'La salamandra', true), ('D', 'El dofí', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Quina forma de govern té un cap d''estat de caràcter electiu i no hereditari, com la Segona República espanyola?', 'Rèplica de la p. 18 (règim anterior al franquisme).', 'plcatexamen_2026_terrassa', (select id from public.topics where slug = 'plcatexamen-2026-terrassa'), 2, 'ca', true, (select id from public.sources where url = 'https://dlc.iec.cat/'), 'Terrassa 2026 p. 18 · República', 'república 1 1 f. [LC] [PO] Forma de govern en què el cap d’estat té caràcter electiu i no hereditari.', null, '29b9e7902185ef5cb1ba08dc0f83ed0d3d7f27caeea69a717b338748dc3c6e27', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '29b9e7902185ef5cb1ba08dc0f83ed0d3d7f27caeea69a717b338748dc3c6e27')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Monarquia', false), ('B', 'República', true), ('C', 'Dictadura', false), ('D', 'Oligarquia', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'En la frase «Els egarencs celebren la festa major», quin tipus de mot és «egarencs»?', 'Rèplica de la p. 20. El gentilici denota la pàtria o procedència d''una persona.', 'plcatexamen_2026_terrassa', (select id from public.topics where slug = 'plcatexamen-2026-terrassa'), 1, 'ca', true, (select id from public.sources where url = 'https://dlc.iec.cat/'), 'Terrassa 2026 p. 20 · Gentilici', 'gentilici 2 1 adj. [FL] [LC] Que denota la nació o la pàtria d’una persona.', null, '904b0fae6ad6a8be3797b6478060f81c5188e022560de6db86647ba2f29fdec8', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '904b0fae6ad6a8be3797b6478060f81c5188e022560de6db86647ba2f29fdec8')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Un topònim', false), ('B', 'Un adverbi', false), ('C', 'Un gentilici', true), ('D', 'Un antònim', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Una patrulla recorre 150 km en 1 hora i 30 minuts. Quina és la seva velocitat mitjana?', 'Rèplica de la p. 21 (velocitat, distància i temps). v = d / t = 150 / 1,5 = 100 km/h.', 'plcatexamen_2026_terrassa', (select id from public.topics where slug = 'plcatexamen-2026-terrassa'), 2, 'ca', true, (select id from public.sources where url = 'https://dlc.iec.cat/'), 'Terrassa 2026 p. 21 · Velocitat mitjana', 'mitjà2 -ana 2 adj. [LC] [MT] Que correspon a la mitjana aritmètica, s’aplica a noms que expressen quantitat.', null, '04db29a02f2a73401b38b8164716a8baac0d53f4871ca05896b56c18c509cc07', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '04db29a02f2a73401b38b8164716a8baac0d53f4871ca05896b56c18c509cc07')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', '150 km/h', false), ('B', '75 km/h', false), ('C', '225 km/h', false), ('D', '100 km/h', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Quin gas, principal causant de l''efecte hivernacle, assimilen les plantes en la fotosíntesi?', 'Rèplica de la p. 22 (gasos d''efecte hivernacle). La fotosíntesi assimila anhídrid carbònic i allibera oxigen.', 'plcatexamen_2026_terrassa', (select id from public.topics where slug = 'plcatexamen-2026-terrassa'), 2, 'ca', true, (select id from public.sources where url = 'https://dlc.iec.cat/'), 'Terrassa 2026 p. 22 · Fotosíntesi i CO2', 'fotosíntesi 1 f. [BI] [EG] Assimilació d’anhídrid carbònic per un procés que depèn de la llum.', null, '77fcf83cef25abc8f70348880f50ca1a70ef0a7068294ac6fa363a1359b9cb6c', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '77fcf83cef25abc8f70348880f50ca1a70ef0a7068294ac6fa363a1359b9cb6c')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'L''oxigen', false), ('B', 'El diòxid de carboni (anhídrid carbònic)', true), ('C', 'El nitrogen', false), ('D', 'L''heli', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Quin d''aquests mots és una onomatopeia?', 'Rèplica de la p. 23. Una onomatopeia imita un so natural.', 'plcatexamen_2026_terrassa', (select id from public.topics where slug = 'plcatexamen-2026-terrassa'), 1, 'ca', true, (select id from public.sources where url = 'https://dlc.iec.cat/'), 'Terrassa 2026 p. 23 · Onomatopeia', 'f. [FL] Mot que resulta d’una onomatopeia.', null, 'f156f909b180787b612d710ddee344f46cb801e1bd7b4303621ca7776498fe51', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'f156f909b180787b612d710ddee344f46cb801e1bd7b4303621ca7776498fe51')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Taula', false), ('B', 'Ràpidament', false), ('C', 'Nyic-nyic', true), ('D', 'Però', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Quin efecte té la inflació sobre els diners?', 'Rèplica de la p. 29 (inflació a la zona euro). La inflació és un increment generalitzat i persistent dels preus.', 'plcatexamen_2026_terrassa', (select id from public.topics where slug = 'plcatexamen-2026-terrassa'), 1, 'ca', true, (select id from public.sources where url = 'https://dlc.iec.cat/'), 'Terrassa 2026 p. 29 · Inflació', 'que implica una reducció del poder adquisitiu del diner.', null, '77d07e13c21b43b4950a314c3c94b5deaa6891aae5e30d2f10f7990aa0b028b5', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '77d07e13c21b43b4950a314c3c94b5deaa6891aae5e30d2f10f7990aa0b028b5')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'N''augmenta el poder adquisitiu', false), ('B', 'Redueix el seu poder adquisitiu', true), ('C', 'No hi té cap efecte', false), ('D', 'Només afecta els estalvis en dòlars', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Què va ser l''apartheid?', 'Rèplica de la p. 32.', 'plcatexamen_2026_terrassa', (select id from public.topics where slug = 'plcatexamen-2026-terrassa'), 2, 'ca', true, (select id from public.sources where url = 'https://dlc.iec.cat/'), 'Terrassa 2026 p. 32 · Apartheid', 'apartheid m. [LC] [PO] Sistema oficial de segregació racial de les poblacions no blanques vigent a Sud-àfrica fins a l’any 1991.', null, 'd770f2eda3f88477b4b269c512ce38842115b76889ed590c35d6098927bf8cc6', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'd770f2eda3f88477b4b269c512ce38842115b76889ed590c35d6098927bf8cc6')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El règim comunista de l''Europa de l''Est', false), ('B', 'La política colonial francesa a Algèria', false), ('C', 'El sistema oficial de segregació racial de Sud-àfrica, vigent fins al 1991', true), ('D', 'El sistema de castes de l''Índia', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'En gramàtica, què vol dir «predicar» alguna cosa del subjecte?', 'Rèplica de la p. 39 (el predicat).', 'plcatexamen_2026_terrassa', (select id from public.topics where slug = 'plcatexamen-2026-terrassa'), 3, 'ca', true, (select id from public.sources where url = 'https://dlc.iec.cat/'), 'Terrassa 2026 p. 39 · Predicar', 'predicar 3 v. tr. [FL] Afirmar o negar (alguna cosa) del subjecte d’una oració.', null, '13b85033633360f772d28001ec197240ae4fa00df1ffc2e49ed93d7400bf62da', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '13b85033633360f772d28001ec197240ae4fa00df1ffc2e49ed93d7400bf62da')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Concordar en gènere i nombre amb el subjecte', false), ('B', 'Substituir el subjecte per un pronom', false), ('C', 'Situar el subjecte al final de l''oració', false), ('D', 'Afirmar-la o negar-la del subjecte de l''oració', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Com s''anomena el costat d''un triangle rectangle oposat a l''angle recte?', 'Rèplica de la p. 41.', 'plcatexamen_2026_terrassa', (select id from public.topics where slug = 'plcatexamen-2026-terrassa'), 1, 'ca', true, (select id from public.sources where url = 'https://dlc.iec.cat/'), 'Terrassa 2026 p. 41 · Hipotenusa', 'hipotenusa f. [LC] [MT] Costat d’un triangle rectangle oposat a l’angle recte.', null, 'e8451ac221fe2e26ceb72a4e952ed11c0351ff8aeda3a50f4e82b91b29e9af46', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'e8451ac221fe2e26ceb72a4e952ed11c0351ff8aeda3a50f4e82b91b29e9af46')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Hipotenusa', true), ('B', 'Catet', false), ('C', 'Altura', false), ('D', 'Bisectriu', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
-- Lote plcatexamen-2026-terrassa-cultural-eac-v1 (1 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Ley Orgánica 6/2006, de 19 de julio, de reforma del Estatuto de Autonomía de Cataluña (texto consolidado, BOE)', 'https://www.boe.es/buscar/act.php?id=BOE-A-2006-13087', 'boe'::public.source_kind, 'Agencia Estatal Boletín Oficial del Estado', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('plcatexamen-2026-terrassa', 'Examen rèplica · Terrassa 2026 (1f/AGENTS/2026), exercici teòric: 50 preguntes') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('policia-local') and t.slug = 'plcatexamen-2026-terrassa' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''Estatut, on ha de ser present la bandera de Catalunya?', 'Rèplica de la p. 26 (senyera del Parlament). Art. 8.2 EAC: quatre barres vermelles sobre fons groc.', 'plcatexamen_2026_terrassa', (select id from public.topics where slug = 'plcatexamen-2026-terrassa'), 1, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2006-13087'), 'Terrassa 2026 p. 26 · Bandera de Catalunya', 'La bandera de Cataluña es la tradicional de cuatro barras rojas en fondo amarillo y debe estar presente en los edificios públicos y en los actos oficiales que tengan lugar en Cataluña.', null, '8cf2bdff9d325dfebfd96a32fea8a98f89e57683a4dbf11435cc55a87d4a31b9', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '8cf2bdff9d325dfebfd96a32fea8a98f89e57683a4dbf11435cc55a87d4a31b9')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Només al Palau de la Generalitat', false), ('B', 'Només el dia de la Diada', false), ('C', 'En tots els habitatges particulars', false), ('D', 'En els edificis públics i en els actes oficials que tinguin lloc a Catalunya', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
-- Lote plcatexamen-2026-terrassa-cultural-govcreu26-v1 (2 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('El Govern distingeix amb la Creu de Sant Jordi 20 persones i 10 entitats (nota de premsa, 14/04/2026)', 'https://govern.cat/gov/notes-premsa/812364/govern-distingeix-creu-sant-jordi-20-persones-10-entitats', 'web_oficial'::public.source_kind, 'Generalitat de Catalunya, Govern.cat', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('plcatexamen-2026-terrassa', 'Examen rèplica · Terrassa 2026 (1f/AGENTS/2026), exercici teòric: 50 preguntes') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('policia-local') and t.slug = 'plcatexamen-2026-terrassa' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Qui va rebre el Gaudí d''Honor de 2026?', 'Rèplica de la p. 19 (Premis Gaudí 2026). Sílvia Munt també va rebre la Creu de Sant Jordi el 14 d''abril de 2026.', 'plcatexamen_2026_terrassa', (select id from public.topics where slug = 'plcatexamen-2026-terrassa'), 2, 'ca', true, (select id from public.sources where url = 'https://govern.cat/gov/notes-premsa/812364/govern-distingeix-creu-sant-jordi-20-persones-10-entitats'), 'Terrassa 2026 p. 19 · Gaudí d''Honor 2026', 'i el Gaudí d’Honor de 2026.', null, '34cf967dfd8949e6765a86c02df9b93d5f9bdf4682fc9166195889da363960fb', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '34cf967dfd8949e6765a86c02df9b93d5f9bdf4682fc9166195889da363960fb')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Sílvia Munt', true), ('B', 'Oriol Pla', false), ('C', 'Rosa Maria Sardà', false), ('D', 'Julia Otero', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Quina filòsofa va rebre la Creu de Sant Jordi 2026 pel seu compromís amb el pensament ètic i cívic?', 'Rèplica de la p. 34 (personalitat de Sant Jordi 2026). 14 d''abril de 2026.', 'plcatexamen_2026_terrassa', (select id from public.topics where slug = 'plcatexamen-2026-terrassa'), 2, 'ca', true, (select id from public.sources where url = 'https://govern.cat/gov/notes-premsa/812364/govern-distingeix-creu-sant-jordi-20-persones-10-entitats'), 'Terrassa 2026 p. 34 · Victòria Camps', 'Victòria Camps i Cervera. Filòsofa: per la seva trajectòria intel·lectual i el seu compromís amb el pensament ètic i cívic.', null, 'aca5ef90303c8d2a2d85863ece63b26ed3c7d2fd3447cb915faad0424fdebc61', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'aca5ef90303c8d2a2d85863ece63b26ed3c7d2fd3447cb915faad0424fdebc61')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Victòria Camps', true), ('B', 'Marina Garcés', false), ('C', 'Maite Carranza', false), ('D', 'Julia Otero', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
-- Lote plcatexamen-2026-terrassa-cultural-govmedor26-v1 (1 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('El Govern lliura la Medalla d''Or de la Generalitat al cuiner Ferran Adrià i a la física i directora del Sincrotró ALBA Caterina Biscari (nota de premsa, 01/09/2026)', 'https://govern.cat/salapremsa/notes-premsa/862672/el-govern-lliura-la-medalla-d-or-de-la-generalitat-al-cuiner-ferran-adria-i-a-la-fisica-i-directora-del-sincrotro-alba-caterina-biscari', 'web_oficial'::public.source_kind, 'Generalitat de Catalunya, Govern.cat', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('plcatexamen-2026-terrassa', 'Examen rèplica · Terrassa 2026 (1f/AGENTS/2026), exercici teòric: 50 preguntes') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('policia-local') and t.slug = 'plcatexamen-2026-terrassa' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'En quin any va tancar Ferran Adrià El Bulli, en el moment de màxim reconeixement internacional?', 'Rèplica de la p. 50 (reconeixement local; substituït per la Medalla d''Or de la Generalitat 2026, 1 de setembre de 2026).', 'plcatexamen_2026_terrassa', (select id from public.topics where slug = 'plcatexamen-2026-terrassa'), 2, 'ca', true, (select id from public.sources where url = 'https://govern.cat/salapremsa/notes-premsa/862672/el-govern-lliura-la-medalla-d-or-de-la-generalitat-al-cuiner-ferran-adria-i-a-la-fisica-i-directora-del-sincrotro-alba-caterina-biscari'), 'Terrassa 2026 p. 50 · Ferran Adrià', 'L’any 2011, en el moment de màxim reconeixement internacional, va tancar El Bulli', null, '7a9193eb92b83337ee6ceb3aa64b6285092d6df7735431904c78e272b6e39fee', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '7a9193eb92b83337ee6ceb3aa64b6285092d6df7735431904c78e272b6e39fee')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', '2001', false), ('B', '2019', false), ('C', '1997', false), ('D', '2011', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
-- Lote plcatexamen-2026-terrassa-cultural-govpic25-v1 (1 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('El Govern concedeix el Premi Internacional Catalunya 2025 a les activistes per la pau Yael Admi i Reem Alhajajra (acords de Govern, 23/12/2025)', 'https://govern.cat/gov/acords-govern/16039/govern-concedeix-premi-internacional-catalunya-2025-activistes-pau-yael-admi-reem-alhajajra', 'web_oficial'::public.source_kind, 'Generalitat de Catalunya, Govern.cat', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('plcatexamen-2026-terrassa', 'Examen rèplica · Terrassa 2026 (1f/AGENTS/2026), exercici teòric: 50 preguntes') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('policia-local') and t.slug = 'plcatexamen-2026-terrassa' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Què preveu el pla d''habitatge aprovat pel Govern el desembre de 2025?', 'Rèplica de la p. 35 (política d''habitatge de Catalunya). 23 de desembre de 2025.', 'plcatexamen_2026_terrassa', (select id from public.topics where slug = 'plcatexamen-2026-terrassa'), 2, 'ca', true, (select id from public.sources where url = 'https://govern.cat/gov/acords-govern/16039/govern-concedeix-premi-internacional-catalunya-2025-activistes-pau-yael-admi-reem-alhajajra'), 'Terrassa 2026 p. 35 · Pla d''habitatge', 'el pla per transformar sòl situat en sectors estratègics en solars preparats per construir-hi 214.000 nous habitatges', null, 'e5d92a989db6552e34499ecb1c754c0cb56f07199829f0dc9d59026523659ecd', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'e5d92a989db6552e34499ecb1c754c0cb56f07199829f0dc9d59026523659ecd')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Prohibir els lloguers de temporada', false), ('B', 'Transformar sòl de sectors estratègics en solars per a 214.000 nous habitatges', true), ('C', 'Construir 2.000 habitatges públics a Barcelona', false), ('D', 'Congelar el preu dels lloguers durant deu anys', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
-- Lote plcatexamen-2026-terrassa-cultural-govpnc26-v1 (4 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('President Illa: "Com Pau Casals, enguany podem dir al món un ''som catalans'' col·lectiu..." (Premis Nacionals de Cultura 2026, nota de premsa, 09/10/2026)', 'https://govern.cat/salapremsa/notes-premsa/878952/president-illa-com-pau-casals-enguany-dir-al-mon-som-catalans-collectiu-tothom-shi-senti-representat-part-activa', 'web_oficial'::public.source_kind, 'Generalitat de Catalunya, Govern.cat', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('plcatexamen-2026-terrassa', 'Examen rèplica · Terrassa 2026 (1f/AGENTS/2026), exercici teòric: 50 preguntes') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('policia-local') and t.slug = 'plcatexamen-2026-terrassa' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Quants guardons van tenir els Premis Nacionals de Cultura 2026?', 'Rèplica de la p. 13 (Premi Nacional de Cultura). 9 d''octubre de 2026: el CoNCA va fer créixer els premis fins a set.', 'plcatexamen_2026_terrassa', (select id from public.topics where slug = 'plcatexamen-2026-terrassa'), 2, 'ca', true, (select id from public.sources where url = 'https://govern.cat/salapremsa/notes-premsa/878952/president-illa-com-pau-casals-enguany-dir-al-mon-som-catalans-collectiu-tothom-shi-senti-representat-part-activa'), 'Terrassa 2026 p. 13 · Premis Nacionals de Cultura 2026', 'El Plenari del CoNCA ha fet créixer enguany els premis fins a set guardons', null, '6c645f3416a416e1ede017191965cfed4f9ed22c38e6e7066686f53e6ff28047', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '6c645f3416a416e1ede017191965cfed4f9ed22c38e6e7066686f53e6ff28047')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Dotze', false), ('B', 'Set', true), ('C', 'Tres', false), ('D', 'Vint', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'En quins àmbits ha fet papers destacats Oriol Pla, Premi Nacional de Cultura 2026?', 'Rèplica de la p. 24 (actor o pel·lícula del moment; substitueix les nominacions de «Sirât»). 9 d''octubre de 2026.', 'plcatexamen_2026_terrassa', (select id from public.topics where slug = 'plcatexamen-2026-terrassa'), 2, 'ca', true, (select id from public.sources where url = 'https://govern.cat/salapremsa/notes-premsa/878952/president-illa-com-pau-casals-enguany-dir-al-mon-som-catalans-collectiu-tothom-shi-senti-representat-part-activa'), 'Terrassa 2026 p. 24 · Oriol Pla', 'fins als seus papers esclatants en el teatre, la televisió i el cinema', null, '6f58537ef479c363bbd6c06e2c52d49958c985165cdc31d81007fe468fffa8cc', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '6f58537ef479c363bbd6c06e2c52d49958c985165cdc31d81007fe468fffa8cc')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El teatre, la televisió i el cinema', true), ('B', 'La música i la dansa', false), ('C', 'La literatura i el periodisme', false), ('D', 'L''arquitectura i el disseny', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Quin d''aquests creadors va rebre el Premi Nacional de Cultura 2026?', 'Rèplica de la p. 25 (premi del cinema i les arts; substitueix el Goya al millor documental). 9 d''octubre de 2026: Fontcuberta, Puig i Camps van rebre la Creu de Sant Jordi.', 'plcatexamen_2026_terrassa', (select id from public.topics where slug = 'plcatexamen-2026-terrassa'), 3, 'ca', true, (select id from public.sources where url = 'https://govern.cat/salapremsa/notes-premsa/878952/president-illa-com-pau-casals-enguany-dir-al-mon-som-catalans-collectiu-tothom-shi-senti-representat-part-activa'), 'Terrassa 2026 p. 25 · Àlex Ollé', 'Sílvia Pérez Cruz, Oriol Pla, Victoria Szpunberg, Pol Guasch, Àlex Ollé, Cabosanroque i Jaŋde Editorial', null, '80e0de7466f398c4fa5c616557674bfb7fa11ab445107ce5f41b3789c5ab0a39', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '80e0de7466f398c4fa5c616557674bfb7fa11ab445107ce5f41b3789c5ab0a39')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Joan Fontcuberta', false), ('B', 'Àlex Ollé', true), ('C', 'Fermí Puig', false), ('D', 'Victòria Camps', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Per quin motiu va rebre Sílvia Pérez Cruz el Premi Nacional de Cultura 2026?', 'Rèplica de la p. 49 (disc d''una cantant catalana; substituït per un premi musical recent). 9 d''octubre de 2026.', 'plcatexamen_2026_terrassa', (select id from public.topics where slug = 'plcatexamen-2026-terrassa'), 2, 'ca', true, (select id from public.sources where url = 'https://govern.cat/salapremsa/notes-premsa/878952/president-illa-com-pau-casals-enguany-dir-al-mon-som-catalans-collectiu-tothom-shi-senti-representat-part-activa'), 'Terrassa 2026 p. 49 · Sílvia Pérez Cruz', 'Premi Nacional de Cultura per l’excel·lència musical i la qualitat vocal i interpretativa', null, '70d03556ceb39fbeea5de2bd8c08f35d7fcee7d879d2ca26a22c4d551010b7bf', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '70d03556ceb39fbeea5de2bd8c08f35d7fcee7d879d2ca26a22c4d551010b7bf')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Per l''excel·lència musical i la qualitat vocal i interpretativa', true), ('B', 'Per la seva trajectòria com a directora de cinema', false), ('C', 'Per la seva obra poètica', false), ('D', 'Per la recuperació de la cultura popular', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
-- Lote plcatexamen-2026-terrassa-cultural-idescat-v1 (1 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Anuari estadístic de Catalunya i El municipi en xifres (Institut d''Estadística de Catalunya)', 'https://www.idescat.cat/indicadors/?id=aec&lang=ca', 'web_oficial'::public.source_kind, 'Institut d''Estadística de Catalunya (Idescat)', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('plcatexamen-2026-terrassa', 'Examen rèplica · Terrassa 2026 (1f/AGENTS/2026), exercici teòric: 50 preguntes') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('policia-local') and t.slug = 'plcatexamen-2026-terrassa' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Quina taxa d''atur de Catalunya mostrava la portada d''Idescat el novembre de 2026?', 'Rèplica de la p. 10 (estadística oficial del mercat de treball; Idescat en lloc de l''EPA de l''INE). Novembre de 2026.', 'plcatexamen_2026_terrassa', (select id from public.topics where slug = 'plcatexamen-2026-terrassa'), 3, 'ca', true, (select id from public.sources where url = 'https://www.idescat.cat/indicadors/?id=aec&lang=ca'), 'Terrassa 2026 p. 10 · Taxa d''atur a Catalunya', '8.237.683 Població 8,30 % Atur +2,9 % PIB +4,5 % IPC', null, '946435aa6c596b29aab91a28d55943b9a7657b0e11a4ef7a69ebfd87ee4a5a5e', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '946435aa6c596b29aab91a28d55943b9a7657b0e11a4ef7a69ebfd87ee4a5a5e')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', '2,9%', false), ('B', '4,5%', false), ('C', '8,30%', true), ('D', '16,6%', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
-- Lote plcatexamen-2026-terrassa-cultural-moncloasmi26-v1 (1 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Pedro Sánchez destaca que con la subida del SMI en 2026 se da "un paso muy relevante para mejorar la vida de 2,5 millones de trabajadores" (16/02/2026)', 'https://www.lamoncloa.gob.es/presidente/actividades/Paginas/2026/160226-sanchez-subida-salario-minimo.aspx', 'web_oficial'::public.source_kind, 'La Moncloa, Gobierno de España', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('plcatexamen-2026-terrassa', 'Examen rèplica · Terrassa 2026 (1f/AGENTS/2026), exercici teòric: 50 preguntes') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('policia-local') and t.slug = 'plcatexamen-2026-terrassa' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Quantes pujades del salari mínim interprofessional s''han aprovat des del 2018, comptant la de 2026?', 'Rèplica de la p. 37 (SMI 2026: 1.221 euros en 14 pagues). 16 de febrer de 2026.', 'plcatexamen_2026_terrassa', (select id from public.topics where slug = 'plcatexamen-2026-terrassa'), 2, 'ca', true, (select id from public.sources where url = 'https://www.lamoncloa.gob.es/presidente/actividades/Paginas/2026/160226-sanchez-subida-salario-minimo.aspx'), 'Terrassa 2026 p. 37 · SMI 2026', 'se ha aprobado la octava subida del SMI desde 2018', null, '4fc67913f051c54bca217bc4a868d438639b5edf2a01eb89df90769a41c0398d', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '4fc67913f051c54bca217bc4a868d438639b5edf2a01eb89df90769a41c0398d')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Tres', false), ('B', 'Vuit', true), ('C', 'Dotze', false), ('D', 'Una', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
-- Lote plcatexamen-2026-terrassa-cultural-nobel-v1 (2 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('All Nobel Prizes 2026 (Nobel Foundation)', 'https://www.nobelprize.org/all-nobel-prizes-2026/', 'web_oficial'::public.source_kind, 'Nobel Foundation / Nobel Prize Outreach', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('plcatexamen-2026-terrassa', 'Examen rèplica · Terrassa 2026 (1f/AGENTS/2026), exercici teòric: 50 preguntes') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('policia-local') and t.slug = 'plcatexamen-2026-terrassa' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Què va permetre descobrir l''observatori IceCube, segons el premi Nobel de física 2026?', 'Rèplica de la p. 7 (fita científica; substitueix la missió Artemis II). Octubre de 2026: Nobel de física a Francis Halzen.', 'plcatexamen_2026_terrassa', (select id from public.topics where slug = 'plcatexamen-2026-terrassa'), 3, 'ca', true, (select id from public.sources where url = 'https://www.nobelprize.org/all-nobel-prizes-2026/'), 'Terrassa 2026 p. 7 · IceCube', 'the discovery of high-energy neutrinos of astrophysical origin', null, '1a808a28afdedea4e3e4f699a321fb44f409673b2820c861f68507a41fe1e2f1', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '1a808a28afdedea4e3e4f699a321fb44f409673b2820c861f68507a41fe1e2f1')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Neutrins d''alta energia d''origen astrofísic', true), ('B', 'Ones gravitacionals de forats negres', false), ('C', 'Aigua líquida a Mart', false), ('D', 'Un nou planeta del sistema solar', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Qui va rebre el premi Nobel de la pau 2026, pels seus esforços per promoure la pau i el dret internacional?', 'Rèplica de la p. 14 (Nobel de la pau 2025, actualitzat al de 2026). Octubre de 2026.', 'plcatexamen_2026_terrassa', (select id from public.topics where slug = 'plcatexamen-2026-terrassa'), 1, 'ca', true, (select id from public.sources where url = 'https://www.nobelprize.org/all-nobel-prizes-2026/'), 'Terrassa 2026 p. 14 · Nobel de la pau 2026', 'Nobel Peace Prize 2026 Navanethem “Navi” Pillay', null, 'e4c57ed6de0320893a7603496cb6643d0fa35cb0f433523b4d93dc720c4f8cb8', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'e4c57ed6de0320893a7603496cb6643d0fa35cb0f433523b4d93dc720c4f8cb8')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Navi Pillay', true), ('B', 'María Corina Machado', false), ('C', 'António Guterres', false), ('D', 'Michelle Bachelet', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
-- Lote plcatexamen-2026-terrassa-cultural-patrimoni-v1 (1 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Patrimoni Cultural de la Generalitat de Catalunya: col·leccions (Jacint Verdaguer, Salvador Espriu, Joan Maragall, Josep Pla) i històries del patrimoni', 'https://patrimoni.gencat.cat/ca/coleccio/jacint-verdaguer', 'web_oficial'::public.source_kind, 'Generalitat de Catalunya, Departament de Cultura (Patrimoni Cultural)', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('plcatexamen-2026-terrassa', 'Examen rèplica · Terrassa 2026 (1f/AGENTS/2026), exercici teòric: 50 preguntes') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('policia-local') and t.slug = 'plcatexamen-2026-terrassa' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'D''on era Joanot Martorell, autor de Tirant lo Blanc?', 'Rèplica de la p. 42 (autor del Tirant).', 'plcatexamen_2026_terrassa', (select id from public.topics where slug = 'plcatexamen-2026-terrassa'), 2, 'ca', true, (select id from public.sources where url = 'https://patrimoni.gencat.cat/ca/coleccio/jacint-verdaguer'), 'Terrassa 2026 p. 42 · Martorell', 'obra del valenciano Joanot Martorell', null, 'fa1e224b5607d670ab5bebf78b16caab3511a4c06af8050619f4c23d09327b2d', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'fa1e224b5607d670ab5bebf78b16caab3511a4c06af8050619f4c23d09327b2d')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Mallorquí', false), ('B', 'Valencià', true), ('C', 'Barceloní', false), ('D', 'Rossellonès', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
-- Lote plcatexamen-2026-terrassa-cultural-uepaisos-v1 (1 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Países de la UE: fichas de país (european-union.europa.eu/principles-countries-history/eu-countries/<país>_es)', 'https://european-union.europa.eu/principles-countries-history/eu-countries_es', 'web_oficial'::public.source_kind, 'Unión Europea', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('plcatexamen-2026-terrassa', 'Examen rèplica · Terrassa 2026 (1f/AGENTS/2026), exercici teòric: 50 preguntes') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('policia-local') and t.slug = 'plcatexamen-2026-terrassa' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Quina és la capital d''Irlanda, país que presideix el Consell de la UE el segon semestre de 2026?', 'Rèplica de la p. 47.', 'plcatexamen_2026_terrassa', (select id from public.topics where slug = 'plcatexamen-2026-terrassa'), 1, 'ca', true, (select id from public.sources where url = 'https://european-union.europa.eu/principles-countries-history/eu-countries_es'), 'Terrassa 2026 p. 47 · Capital d''Irlanda', '[Irlanda] Capital: Dublín', null, '4b73673c8b33545c890db11ce7cf3de5cb3c20cfd2421061ab7ca9c1b515d404', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '4b73673c8b33545c890db11ce7cf3de5cb3c20cfd2421061ab7ca9c1b515d404')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Belfast', false), ('B', 'Cork', false), ('C', 'Dublín', true), ('D', 'Edimburg', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
-- Lote gubexamen-2022-cultural-bcnarq-v1 (1 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Barcelona 2026, Capital Mundial de l’Arquitectura', 'https://ajuntament.barcelona.cat/urbanisme-accio-climatica-mobilitat-pla-barris-serveis-urbans/ca/news/barcelona-2026-capital-mundial-de-larquitectura-1377921', 'web_oficial'::public.source_kind, 'Ajuntament de Barcelona', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('gubexamen-2022', 'Rèplica de l''examen d''agent de la Guàrdia Urbana 2022 (exercici teòric)') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('guardia-urbana-barcelona') and t.slug = 'gubexamen-2022' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Durant quin període de 2026 hi ha activitats de Barcelona Capital Mundial de l''Arquitectura?', 'Rèplica de la p. 11 (lloc i calendari d''un gran programa cultural de la ciutat). 2026.', 'gubexamen_2022', (select id from public.topics where slug = 'gubexamen-2022'), 3, 'ca', true, (select id from public.sources where url = 'https://ajuntament.barcelona.cat/urbanisme-accio-climatica-mobilitat-pla-barris-serveis-urbans/ca/news/barcelona-2026-capital-mundial-de-larquitectura-1377921'), 'GUB 2022 p. 11 · Capital Mundial de l''Arquitectura', 'Durant deu mesos, des de Santa Eulàlia fins a Santa Llúcia', null, '798731ec30a8ab902d97e402edbcec8adf0e02248a1fb70e627da6b406154f5b', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '798731ec30a8ab902d97e402edbcec8adf0e02248a1fb70e627da6b406154f5b')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Des de Santa Eulàlia fins a Santa Llúcia (deu mesos)', true), ('B', 'Des de Sant Jordi fins a la Mercè', false), ('C', 'Només durant l''estiu', false), ('D', 'Del Tour a la Mercè', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-urbana-barcelona');
-- Lote gubexamen-2022-cultural-bcngaudi26-v1 (2 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Barcelona ret homenatge a Antoni Gaudí amb una placa en el mateix punt on va ser atropellat l’any 1926 (07/06/2026)', 'https://ajuntament.barcelona.cat/premsa/2026/06/07/barcelona-ret-homenatge-a-antoni-gaudi-amb-una-placa-en-el-mateix-punt-on-va-ser-atropellat-lany-1926/', 'web_oficial'::public.source_kind, 'Ajuntament de Barcelona', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('gubexamen-2022', 'Rèplica de l''examen d''agent de la Guàrdia Urbana 2022 (exercici teòric)') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('guardia-urbana-barcelona') and t.slug = 'gubexamen-2022' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Per què es va escollir el 10 de juny de 2026 per inaugurar la torre de Jesucrist de la Sagrada Família?', 'Rèplica de la p. 13 (torres de la Sagrada Família). 10 de juny de 2026.', 'gubexamen_2022', (select id from public.topics where slug = 'gubexamen-2022'), 3, 'ca', true, (select id from public.sources where url = 'https://ajuntament.barcelona.cat/premsa/2026/06/07/barcelona-ret-homenatge-a-antoni-gaudi-amb-una-placa-en-el-mateix-punt-on-va-ser-atropellat-lany-1926/'), 'GUB 2022 p. 13 · Torre de Jesucrist, data', 'prevista el 10 de juny, data de la mort de l’arquitecte.', null, '9bc12d4f1da62eba531fde5be8e38585661214f56bd336753b4e9daa27634bf0', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '9bc12d4f1da62eba531fde5be8e38585661214f56bd336753b4e9daa27634bf0')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Perquè és el dia de Sant Antoni', false), ('B', 'Perquè és l''aniversari del naixement de Gaudí', false), ('C', 'Perquè coincidia amb la Mercè', false), ('D', 'Perquè és la data de la mort de Gaudí, cent anys després', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-urbana-barcelona');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Què commemora l''Any Gaudí 2026?', 'Rèplica de la p. 17 (iniciativa municipal de l''any; substitueix «Obrim carrers»). 2026.', 'gubexamen_2022', (select id from public.topics where slug = 'gubexamen-2022'), 1, 'ca', true, (select id from public.sources where url = 'https://ajuntament.barcelona.cat/premsa/2026/06/07/barcelona-ret-homenatge-a-antoni-gaudi-amb-una-placa-en-el-mateix-punt-on-va-ser-atropellat-lany-1926/'), 'GUB 2022 p. 17 · Any Gaudí', 'l’Any Gaudí, impulsat per les institucions per commemorar el centenari de la seva mort', null, 'f671d3b3eb2166817cbd68109639086fbeca379f363ec4158a1cab3e17e7224c', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'f671d3b3eb2166817cbd68109639086fbeca379f363ec4158a1cab3e17e7224c')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El centenari del naixement de Gaudí', false), ('B', 'L''acabament de la Sagrada Família', false), ('C', 'El centenari de la mort d''Antoni Gaudí', true), ('D', 'Els 50 anys de la declaració de patrimoni mundial', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-urbana-barcelona');
-- Lote gubexamen-2022-cultural-bcnpadro26-v1 (2 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('La població de Barcelona. Lectura del padró municipal d’habitants a 01/01/2026: síntesi de resultats', 'https://dades.ajuntament.barcelona.cat/informe-padro-poblacio/ca/seccio_2.html', 'web_oficial'::public.source_kind, 'Ajuntament de Barcelona, Departament d''Estadística i Difusió de Dades', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('gubexamen-2022', 'Rèplica de l''examen d''agent de la Guàrdia Urbana 2022 (exercici teòric)') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('guardia-urbana-barcelona') and t.slug = 'gubexamen-2022' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons el padró de 2026, en quins districtes de Barcelona ha augmentat lleugerament la població?', 'Rèplica de la p. 23 (districtes de Barcelona). Padró 2026: a set dels deu districtes la població baixa lleugerament.', 'gubexamen_2022', (select id from public.topics where slug = 'gubexamen-2022'), 3, 'ca', true, (select id from public.sources where url = 'https://dades.ajuntament.barcelona.cat/informe-padro-poblacio/ca/seccio_2.html'), 'GUB 2022 p. 23 · Districtes de Barcelona', 'mentre que a Ciutat Vella, Nou Barris i Sant Andreu es detecten petits increments.', null, '8366ffed95ecff098f599433b032e054152d3a534383e2a7bbec8f686cdf83ec', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '8366ffed95ecff098f599433b032e054152d3a534383e2a7bbec8f686cdf83ec')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Ciutat Vella, Nou Barris i Sant Andreu', true), ('B', 'L''Eixample, Gràcia i Sants-Montjuïc', false), ('C', 'Sarrià-Sant Gervasi, Les Corts i Horta-Guinardó', false), ('D', 'En tots els deu districtes', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-urbana-barcelona');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Quantes persones centenàries vivien a Barcelona segons el padró de 2026, un nou màxim?', 'Rèplica de la p. 25 (dada de ciutat; substitueix un canvi de nomenclàtor). Padró 2026.', 'gubexamen_2022', (select id from public.topics where slug = 'gubexamen-2022'), 3, 'ca', true, (select id from public.sources where url = 'https://dades.ajuntament.barcelona.cat/informe-padro-poblacio/ca/seccio_2.html'), 'GUB 2022 p. 25 · Centenaris a Barcelona', 'El nombre de persones centenàries assoleix un nou màxim: 1.196.', null, 'e7dec39ebe808b1fe2028ce2bae96fe6efccb5534b1001ef9ac2886e6cf5ed1a', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'e7dec39ebe808b1fe2028ce2bae96fe6efccb5534b1001ef9ac2886e6cf5ed1a')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', '196', false), ('B', '11.960', false), ('C', '50', false), ('D', '1.196', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-urbana-barcelona');
-- Lote gubexamen-2022-cultural-bcntour26-v1 (2 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('La Festa Major del Tour omplirà Barcelona amb més de 60 propostes (15/05/2026) i Catalunya i Barcelona s’il·luminen de groc (26/03/2026)', 'https://ajuntament.barcelona.cat/premsa/2026/05/15/la-festa-major-del-tour-omplira-barcelona-amb-mes-de-60-propostes-per-celebrar-el-tour-de-franca/', 'web_oficial'::public.source_kind, 'Ajuntament de Barcelona', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('gubexamen-2022', 'Rèplica de l''examen d''agent de la Guàrdia Urbana 2022 (exercici teòric)') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('guardia-urbana-barcelona') and t.slug = 'gubexamen-2022' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Amb quin motiu es va celebrar a Barcelona, del 26 de juny al 5 de juliol de 2026, la Festa Major del Tour?', 'Rèplica de la p. 6 (actualitat esportiva; substitueix el premi d''Alexia Putellas). 15 de maig de 2026: presentació de la Festa Major del Tour.', 'gubexamen_2022', (select id from public.topics where slug = 'gubexamen-2022'), 1, 'ca', true, (select id from public.sources where url = 'https://ajuntament.barcelona.cat/premsa/2026/05/15/la-festa-major-del-tour-omplira-barcelona-amb-mes-de-60-propostes-per-celebrar-el-tour-de-franca/'), 'GUB 2022 p. 6 · Festa Major del Tour', 'Barcelona ha presentat aquest matí la Festa Major del Tour, una gran celebració popular que, del 26 de juny al 5 de juliol, convidarà a la ciutadania a sortir al carrer i celebrar l’orgull de la ciutat amb motiu de la sortida del Tour de França 2026.', null, 'd8262388fbc22157fd4c43543022ff26cb1cfbb4b23ec77be3195ea5517ca83b', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'd8262388fbc22157fd4c43543022ff26cb1cfbb4b23ec77be3195ea5517ca83b')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'La final de la Copa Amèrica de vela', false), ('B', 'La sortida del Tour de França 2026 des de Barcelona', true), ('C', 'Els 50 anys dels Jocs Olímpics', false), ('D', 'La Volta Ciclista a Catalunya', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-urbana-barcelona');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Quines són les dues grans festivitats tradicionals de Barcelona, a l''hivern i a la tardor?', 'Rèplica de la p. 20 (tradicions de Barcelona). L''Ajuntament va voler fer de la Festa Major del Tour la tercera gran festivitat, després de Santa Eulàlia i la Mercè.', 'gubexamen_2022', (select id from public.topics where slug = 'gubexamen-2022'), 1, 'ca', true, (select id from public.sources where url = 'https://ajuntament.barcelona.cat/premsa/2026/05/15/la-festa-major-del-tour-omplira-barcelona-amb-mes-de-60-propostes-per-celebrar-el-tour-de-franca/'), 'GUB 2022 p. 20 · Grans festes de Barcelona', 'la tercera gran festivitat de Barcelona, després de Santa Eulàlia i la Mercè', null, 'b3b3de2dc052c430b1b3b0b11a94a7c29744b752a667d1ecd0147b834a9e8169', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'b3b3de2dc052c430b1b3b0b11a94a7c29744b752a667d1ecd0147b834a9e8169')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Sant Joan i Sant Jordi', false), ('B', 'Sant Medir i Sant Antoni', false), ('C', 'La Festa Major de Gràcia i la de Sants', false), ('D', 'Santa Eulàlia i la Mercè', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-urbana-barcelona');
-- Lote gubexamen-2022-cultural-cop31-v1 (1 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('UN Climate Change Conference - Antalya, November 2026 (COP31)', 'https://unfccc.int/cop31', 'web_oficial'::public.source_kind, 'United Nations Framework Convention on Climate Change (UNFCCC)', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('gubexamen-2022', 'Rèplica de l''examen d''agent de la Guàrdia Urbana 2022 (exercici teòric)') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('guardia-urbana-barcelona') and t.slug = 'gubexamen-2022' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'De quin país és Chris Bowen, president de les negociacions de la COP31?', 'Rèplica de la p. 19 (COP26 a Glasgow, actualitzat a la COP31). 9-20 de novembre de 2026, Antalya.', 'gubexamen_2022', (select id from public.topics where slug = 'gubexamen-2022'), 3, 'ca', true, (select id from public.sources where url = 'https://unfccc.int/cop31'), 'GUB 2022 p. 19 · COP31, negociacions', 'Mr. Chris Bowen of Australia will be the President of Negotiations.', null, '325c30a094f06316fd92063d3ace4e2c476a2eb1f1df2b02c7c5bb5f446e20e8', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '325c30a094f06316fd92063d3ace4e2c476a2eb1f1df2b02c7c5bb5f446e20e8')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Türkiye', false), ('B', 'El Canadà', false), ('C', 'Nova Zelanda', false), ('D', 'Austràlia', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-urbana-barcelona');
-- Lote gubexamen-2022-cultural-diec-v1 (20 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Diccionari de la llengua catalana, 2a edició (DIEC2), Institut d''Estudis Catalans', 'https://dlc.iec.cat/', 'web_oficial'::public.source_kind, 'Institut d''Estudis Catalans', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('gubexamen-2022', 'Rèplica de l''examen d''agent de la Guàrdia Urbana 2022 (exercici teòric)') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('guardia-urbana-barcelona') and t.slug = 'gubexamen-2022' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Com s''anomenen els agents infecciosos submicroscòpics que causen malalties com la COVID-19 (variants com l''òmicron)?', 'Rèplica de la p. 7 (variant òmicron). Les variants són formes d''un virus.', 'gubexamen_2022', (select id from public.topics where slug = 'gubexamen-2022'), 1, 'ca', true, (select id from public.sources where url = 'https://dlc.iec.cat/'), 'GUB 2022 p. 7 · Virus', 'virus 1 1 m. [BI] [LC] [MD] Individu d’un grup d’agents infecciosos submicroscòpics', null, '6ef29749b65eb4c134f7de3506d6eb00691c0dfa4fb7ef462b5b03c8a5c5ec5a', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '6ef29749b65eb4c134f7de3506d6eb00691c0dfa4fb7ef462b5b03c8a5c5ec5a')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Bacteris', false), ('B', 'Fongs', false), ('C', 'Protozous', false), ('D', 'Virus', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-urbana-barcelona');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Com s''anomena la massa de matèria mineral fosa i a alta temperatura que es genera dins l''escorça terrestre i que surt pels volcans?', 'Rèplica de la p. 9 (volcà de Cumbre Vieja, La Palma). Quan el magma es refreda forma roques ígnies.', 'gubexamen_2022', (select id from public.topics where slug = 'gubexamen-2022'), 2, 'ca', true, (select id from public.sources where url = 'https://dlc.iec.cat/'), 'GUB 2022 p. 9 · Magma', 'magma 1 m. [GL] Massa de matèria mineral en estat de fusió i a una elevada temperatura', null, '1cc569469137dd7332fe69a648ea7523b5d5c62e75ac9be5a13cbb0c20a6d347', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '1cc569469137dd7332fe69a648ea7523b5d5c62e75ac9be5a13cbb0c20a6d347')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Piroclast', false), ('B', 'Sediment', false), ('C', 'Magma', true), ('D', 'Carst', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-urbana-barcelona');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Quan el vapor d''aigua de la dutxa es converteix en gotes al mirall, quin canvi d''estat es produeix?', 'Rèplica de la p. 26. La condensació és el pas de vapor a líquid.', 'gubexamen_2022', (select id from public.topics where slug = 'gubexamen-2022'), 1, 'ca', true, (select id from public.sources where url = 'https://dlc.iec.cat/'), 'GUB 2022 p. 26 · Condensació', 'condensació 1 2 f. [FIF] [IQ] Pas d’una substància de l’estat de vapor a l’estat líquid.', null, 'de479256aa831609e048181ddf2a2133a0cf573a1165c9d49905f9a030e4258a', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'de479256aa831609e048181ddf2a2133a0cf573a1165c9d49905f9a030e4258a')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Evaporació', false), ('B', 'Fusió', false), ('C', 'Condensació', true), ('D', 'Sublimació', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-urbana-barcelona');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Què és un piroclast?', 'Rèplica de la p. 27.', 'gubexamen_2022', (select id from public.topics where slug = 'gubexamen-2022'), 2, 'ca', true, (select id from public.sources where url = 'https://dlc.iec.cat/'), 'GUB 2022 p. 27 · Piroclasts', 'piroclast m. [GL] Fragment de lava o de roca encaixant expulsat per un volcà', null, '6e937a902fcbec6fcb3ddcb3902ac1713a1684882346aeffb97f0072298892ac', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '6e937a902fcbec6fcb3ddcb3902ac1713a1684882346aeffb97f0072298892ac')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Un fragment de lava o de roca expulsat per un volcà', true), ('B', 'Un mineral que es forma a les coves', false), ('C', 'Un tipus de núvol de tempesta', false), ('D', 'Un fòssil d''animal marí', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-urbana-barcelona');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Quins textos reconeixen com a autoritat les varietats religioses de l''hinduisme?', 'Rèplica de la p. 28 (religions). L''hinduisme és el conjunt de varietats religioses de l''Índia que reconeixen l''autoritat dels Vedes.', 'gubexamen_2022', (select id from public.topics where slug = 'gubexamen-2022'), 2, 'ca', true, (select id from public.sources where url = 'https://dlc.iec.cat/'), 'GUB 2022 p. 28 · Hinduisme', 'hinduisme m. [AN] [LC] [RE] Conjunt de varietats religioses pròpies de l’Índia, que reconeixen l’autoritat dels Vedes.', null, 'e4dedf595fdc278e59e748e35f3ea507bc20032cd9cd76256fece979c94aa8c7', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'e4dedf595fdc278e59e748e35f3ea507bc20032cd9cd76256fece979c94aa8c7')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Els Vedes', true), ('B', 'L''Alcorà', false), ('C', 'La Torà', false), ('D', 'Els Evangelis', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-urbana-barcelona');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Respecte de quin cercle es defineixen els paral·lels terrestres, i quin és el paral·lel més llarg?', 'Rèplica de la p. 29. Els paral·lels són paral·lels a l''equador, que és un cercle màxim; la resta són cercles menors.', 'gubexamen_2022', (select id from public.topics where slug = 'gubexamen-2022'), 2, 'ca', true, (select id from public.sources where url = 'https://dlc.iec.cat/'), 'GUB 2022 p. 29 · Paral·lels i equador', 'paral·lel terrestre Cercle menor de l’esfera terrestre determinat per la intersecció d’un pla paral·lel a l’equador amb l’esfera terrestre.', null, 'c2660ba9aadfa8993ae3249b14c7fe281336b6a413d369a276296e2678b18838', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'c2660ba9aadfa8993ae3249b14c7fe281336b6a413d369a276296e2678b18838')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Respecte del meridià de Greenwich, que és el més llarg', false), ('B', 'Respecte del tròpic de Càncer, que és el més llarg', false), ('C', 'Respecte del cercle polar, que és el més llarg', false), ('D', 'Respecte de l''equador, que és el més llarg', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-urbana-barcelona');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'A quin moviment artístic del segle XIX, que defuig la formalitat del classicisme, pertany La Llibertat guiant el poble de Delacroix?', 'Rèplica de la p. 31 (autor de La Llibertat guiant el poble). Delacroix és un pintor romàntic.', 'gubexamen_2022', (select id from public.topics where slug = 'gubexamen-2022'), 3, 'ca', true, (select id from public.sources where url = 'https://dlc.iec.cat/'), 'GUB 2022 p. 31 · Romanticisme', 'romanticisme 2 m. [AR] [LC] Moviment artístic del segle xix que defuig la formalitat restrictiva del classicisme', null, '8adb57091a6582725b59e7fc95d84c947c0f726d21dc48dee99615a67cf7c010', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '8adb57091a6582725b59e7fc95d84c947c0f726d21dc48dee99615a67cf7c010')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Impressionisme', false), ('B', 'Romanticisme', true), ('C', 'Barroc', false), ('D', 'Cubisme', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-urbana-barcelona');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'En física, què és la pressió?', 'Rèplica de la p. 33. La densitat és massa per volum, la potència energia per temps i l''acceleració velocitat per temps.', 'gubexamen_2022', (select id from public.topics where slug = 'gubexamen-2022'), 1, 'ca', true, (select id from public.sources where url = 'https://dlc.iec.cat/'), 'GUB 2022 p. 33 · Pressió', 'pressió 2 1 f. [FIF] [ME] En fís., força per unitat de superfície que és exercida perpendicularment sobre un cos.', null, '4e3758d56c45e2513e9448137d57b5a495f156345fba9f933c63bb5510d3053d', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '4e3758d56c45e2513e9448137d57b5a495f156345fba9f933c63bb5510d3053d')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'La massa per unitat de volum', false), ('B', 'La força per unitat de superfície exercida perpendicularment sobre un cos', true), ('C', 'L''energia per unitat de temps', false), ('D', 'La velocitat per unitat de temps', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-urbana-barcelona');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Què fa un lutier?', 'Rèplica de la p. 34 (definició).', 'gubexamen_2022', (select id from public.topics where slug = 'gubexamen-2022'), 2, 'ca', true, (select id from public.sources where url = 'https://dlc.iec.cat/'), 'GUB 2022 p. 34 · Lutier', 'lutier m. i f. [MU] [PR] Persona que fabrica instruments musicals, especialment de cordes pinçades o fregades.', null, '4b0b99e951885095543414043faac39f923a3b0b51de9defad9ff22bcc575469', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '4b0b99e951885095543414043faac39f923a3b0b51de9defad9ff22bcc575469')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Restaura pintures antigues', false), ('B', 'Enquaderna llibres', false), ('C', 'Fabrica instruments musicals, especialment de corda', true), ('D', 'Talla pedres precioses', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-urbana-barcelona');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'En quina unitat es mesura la intensitat del corrent elèctric?', 'Rèplica de la p. 36.', 'gubexamen_2022', (select id from public.topics where slug = 'gubexamen-2022'), 1, 'ca', true, (select id from public.sources where url = 'https://dlc.iec.cat/'), 'GUB 2022 p. 36 · Ampere', 'ampere 1 1 m. [FIF] [FIM] [LC] Unitat d’intensitat de corrent elèctric del sistema internacional', null, '92fb4b85cde75deeae98bfd413e498484b895039228e1c793be6cb45d31ed631', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '92fb4b85cde75deeae98bfd413e498484b895039228e1c793be6cb45d31ed631')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Volt', false), ('B', 'Ohm', false), ('C', 'Watt', false), ('D', 'Ampere', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-urbana-barcelona');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Una persona que se''n va del seu país per anar a viure a un altre és, des del punt de vista del país d''origen, un...', 'Rèplica de la p. 37. Emigrant és qui emigra (surt); immigrant, qui immigra (arriba).', 'gubexamen_2022', (select id from public.topics where slug = 'gubexamen-2022'), 2, 'ca', true, (select id from public.sources where url = 'https://dlc.iec.cat/'), 'GUB 2022 p. 37 · Emigrant i immigrant', 'emigrant adj. i m. i f. [LC] Que emigra.', null, '8d65e1d973a22fcc05fa714bdf60ef6ffdd221f040b4c413e1aec567e7b1311f', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '8d65e1d973a22fcc05fa714bdf60ef6ffdd221f040b4c413e1aec567e7b1311f')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Emigrant', true), ('B', 'Immigrant', false), ('C', 'Turista', false), ('D', 'Refugiat', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-urbana-barcelona');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Quin metall té un punt de fusió molt baix, de 29,7 °C?', 'Rèplica de la p. 38 (element gal·li).', 'gubexamen_2022', (select id from public.topics where slug = 'gubexamen-2022'), 3, 'ca', true, (select id from public.sources where url = 'https://dlc.iec.cat/'), 'GUB 2022 p. 38 · Gal·li', 'gal·li m. [ML] [QU] Metall blanc, dur, mal·leable, semblant a l’alumini, remarcable pel seu punt de fusió molt baix, 29,7 °C', null, '48609f36a41e93b2cc91cc70fb56769d4d5ac2128f1a1ee20eb4592700ace646', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '48609f36a41e93b2cc91cc70fb56769d4d5ac2128f1a1ee20eb4592700ace646')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El plom', false), ('B', 'El gal·li', true), ('C', 'El zinc', false), ('D', 'El ferro', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-urbana-barcelona');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Quin d''aquests elements és característic de les façanes de les esglésies gòtiques?', 'Rèplica de la p. 39 (elements del gòtic).', 'gubexamen_2022', (select id from public.topics where slug = 'gubexamen-2022'), 2, 'ca', true, (select id from public.sources where url = 'https://dlc.iec.cat/'), 'GUB 2022 p. 39 · Elements del gòtic', 'rosassa f. [AQ] [AR] [LC] Gran finestral circular, calat i vidrat, que es troba als murs de les esglésies gòtiques, especialment a la façana.', null, '1a33b45eb13574a183fbe8499838cf5a17054e71c7443382db83b5d47c3c3782', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '1a33b45eb13574a183fbe8499838cf5a17054e71c7443382db83b5d47c3c3782')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'L''arc de ferradura', false), ('B', 'La cúpula de ceba', false), ('C', 'La rosassa', true), ('D', 'La columna salomònica', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-urbana-barcelona');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'En quina part del cos humà hi ha el cúbit?', 'Rèplica de la p. 40. El cúbit és l''os més llarg intern de l''avantbraç i forma el colze amb l''húmer.', 'gubexamen_2022', (select id from public.topics where slug = 'gubexamen-2022'), 2, 'ca', true, (select id from public.sources where url = 'https://dlc.iec.cat/'), 'GUB 2022 p. 40 · Cúbit', 'cúbit m. [MD] [ZOA] Os més llarg intern de l’avantbraç, que forma el colze en la seva articulació amb l’húmer.', null, '76e7b2ffe8df57db105332ee0c4c5eb15e18db6b022624f91071e363a4750ad5', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '76e7b2ffe8df57db105332ee0c4c5eb15e18db6b022624f91071e363a4750ad5')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'A l''avantbraç', true), ('B', 'A la cama', false), ('C', 'Al crani', false), ('D', 'Al peu', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-urbana-barcelona');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Quin tipus d''oració és «No llenceu papers a terra»?', 'Rèplica de la p. 44. Una oració exhortativa implica exhortació a fer o no fer alguna cosa.', 'gubexamen_2022', (select id from public.topics where slug = 'gubexamen-2022'), 2, 'ca', true, (select id from public.sources where url = 'https://dlc.iec.cat/'), 'GUB 2022 p. 44 · Oracions exhortatives', 'exhortatiu -iva adj. [FL] En gram., que implica exhortació a fer o no fer alguna cosa.', null, '65e3caba34a8d2f2e0a86e30c88b4bbe078d09ab4e89524b16a3cf0743f819a5', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '65e3caba34a8d2f2e0a86e30c88b4bbe078d09ab4e89524b16a3cf0743f819a5')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Interrogativa', false), ('B', 'Exclamativa', false), ('C', 'Exhortativa', true), ('D', 'Dubitativa', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-urbana-barcelona');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Quina eina de prevenció estimula la formació d''anticossos contra infeccions com la del virus del papil·loma humà?', 'Rèplica de la p. 45 (virus del papil·loma humà).', 'gubexamen_2022', (select id from public.topics where slug = 'gubexamen-2022'), 1, 'ca', true, (select id from public.sources where url = 'https://dlc.iec.cat/'), 'GUB 2022 p. 45 · Vacuna', 'vacuna f. [LC] [MD] Preparat que estimula la formació d’anticossos', null, 'f9ce080cffb330d1b4612b6d5cb915cccadcef1959d6793b554275b5606a8e37', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'f9ce080cffb330d1b4612b6d5cb915cccadcef1959d6793b554275b5606a8e37')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'L''antibiòtic', false), ('B', 'La vacuna', true), ('C', 'L''antiinflamatori', false), ('D', 'L''anestèsia', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-urbana-barcelona');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Entre quins elements es produeix la sinapsi?', 'Rèplica de la p. 46.', 'gubexamen_2022', (select id from public.topics where slug = 'gubexamen-2022'), 2, 'ca', true, (select id from public.sources where url = 'https://dlc.iec.cat/'), 'GUB 2022 p. 46 · Sinapsi', 'Regió de comunicació i de transmissió d’impulsos nerviosos entre les neurones o entre una neurona motora i el múscul.', null, '891a244c336ca39404f1a9d7e18e43b5a4c4d66ce01de9362e1be58b7deb12b6', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '891a244c336ca39404f1a9d7e18e43b5a4c4d66ce01de9362e1be58b7deb12b6')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Entre glòbuls vermells', false), ('B', 'Entre ossos d''una articulació', false), ('C', 'Entre cèl·lules de la pell', false), ('D', 'Entre neurones, o entre una neurona motora i el múscul', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-urbana-barcelona');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Com s''anomena la desocupació forçosa per manca d''oferta de feina?', 'Rèplica de la p. 47 (concepte econòmic; es pregunta per l''atur en lloc del sector terciari). Idescat publica la taxa d''atur de Catalunya.', 'gubexamen_2022', (select id from public.topics where slug = 'gubexamen-2022'), 1, 'ca', true, (select id from public.sources where url = 'https://dlc.iec.cat/'), 'GUB 2022 p. 47 · Atur', 'atur m. [ECT] [LC] [SO] Desocupació forçosa, involuntària, per manca d’oferta de col·locació.', null, '4b94888ae6d7bd3045be0af39d60663923efcd49493ade60c9c6b325f6684085', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '4b94888ae6d7bd3045be0af39d60663923efcd49493ade60c9c6b325f6684085')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Atur', true), ('B', 'Jubilació', false), ('C', 'Excedència', false), ('D', 'Inflació', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-urbana-barcelona');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Quin és el símbol químic del mercuri?', 'Rèplica de la p. 49. El mercuri és un metall líquid a temperatura ordinària.', 'gubexamen_2022', (select id from public.topics where slug = 'gubexamen-2022'), 1, 'ca', true, (select id from public.sources where url = 'https://dlc.iec.cat/'), 'GUB 2022 p. 49 · Mercuri', '(símbol, Hg; nombre atòmic, 80; pes atòmic, 200,59)', null, '91323c33067967142448f55a79bbf735cbfc0edf555284113d903c8fee94dbf6', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '91323c33067967142448f55a79bbf735cbfc0edf555284113d903c8fee94dbf6')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Me', false), ('B', 'Hg', true), ('C', 'Mr', false), ('D', 'Hr', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-urbana-barcelona');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'En informàtica, a què equival un byte?', 'Rèplica de la reserva 52 (unitats d''informació). Byte és sinònim d''octet.', 'gubexamen_2022', (select id from public.topics where slug = 'gubexamen-2022'), 2, 'ca', true, (select id from public.sources where url = 'https://dlc.iec.cat/'), 'GUB 2022 p. 52 (reserva) · Byte', 'byte [angl.] m. [IN] Octet 2.', null, 'e588685132f2a6a590998319546f74dc653eca2a24a33e96976bd7bda4eae1a2', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'e588685132f2a6a590998319546f74dc653eca2a24a33e96976bd7bda4eae1a2')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'A mil bits', false), ('B', 'A un megabyte', false), ('C', 'A un sol bit', false), ('D', 'A un octet (vuit bits)', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-urbana-barcelona');
-- Lote gubexamen-2022-cultural-genhist-v1 (2 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Història de la Generalitat (Diputació del General, Nova Planta i Generalitat contemporània)', 'https://web.gencat.cat/ca/generalitat/qui-som/historia-generalitat', 'web_oficial'::public.source_kind, 'Generalitat de Catalunya', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('gubexamen-2022', 'Rèplica de l''examen d''agent de la Guàrdia Urbana 2022 (exercici teòric)') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('guardia-urbana-barcelona') and t.slug = 'gubexamen-2022' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Quin decret va reconèixer Josep Tarradellas com a president de la Generalitat?', 'Rèplica de la p. 41. Tarradellas va ser l''única autoritat republicana que va tornar de l''exili per assumir un càrrec en la democràcia.', 'gubexamen_2022', (select id from public.topics where slug = 'gubexamen-2022'), 2, 'ca', true, (select id from public.sources where url = 'https://web.gencat.cat/ca/generalitat/qui-som/historia-generalitat'), 'GUB 2022 p. 41 · Tarradellas, 1977', 'el decret de 29 de setembre de 1977 reconeixia com a president de la Generalitat Josep Tarradellas', null, '1af2e99e8b7fad9a0a675e0e38e71a72636c534578fd9d6115157530c3357008', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '1af2e99e8b7fad9a0a675e0e38e71a72636c534578fd9d6115157530c3357008')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El decret de 5 d''abril de 1938', false), ('B', 'El decret de 16 de gener de 1716', false), ('C', 'El decret de 29 de setembre de 1977', true), ('D', 'El decret de 18 de desembre de 1979', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-urbana-barcelona');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Quan va ser nomenat president del Govern Adolfo Suárez?', 'Rèplica de la p. 50.', 'gubexamen_2022', (select id from public.topics where slug = 'gubexamen-2022'), 2, 'ca', true, (select id from public.sources where url = 'https://web.gencat.cat/ca/generalitat/qui-som/historia-generalitat'), 'GUB 2022 p. 50 · Adolfo Suárez', 'El 3 de juliol de 1976, fou nomenat president del govern Adolfo Suárez', null, 'f5d8644caf7d527a35f24f3e9216cd57b29f4421f6f9c8010fafb1c0073d7f48', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'f5d8644caf7d527a35f24f3e9216cd57b29f4421f6f9c8010fafb1c0073d7f48')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El 3 de juliol de 1976', true), ('B', 'El 20 de novembre de 1975', false), ('C', 'El 15 de juny de 1977', false), ('D', 'El 6 de desembre de 1978', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-urbana-barcelona');
-- Lote gubexamen-2022-cultural-govcreu26-v1 (1 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('El Govern distingeix amb la Creu de Sant Jordi 20 persones i 10 entitats (nota de premsa, 14/04/2026)', 'https://govern.cat/gov/notes-premsa/812364/govern-distingeix-creu-sant-jordi-20-persones-10-entitats', 'web_oficial'::public.source_kind, 'Generalitat de Catalunya, Govern.cat', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('gubexamen-2022', 'Rèplica de l''examen d''agent de la Guàrdia Urbana 2022 (exercici teòric)') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('guardia-urbana-barcelona') and t.slug = 'gubexamen-2022' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Quin cuiner i gastrònom va rebre la Creu de Sant Jordi 2026 per la renovació i projecció de la cuina catalana?', 'Rèplica de la p. 8 (gastronomia de Barcelona; substitueix l''estrella Michelin de 2021). 14 d''abril de 2026.', 'gubexamen_2022', (select id from public.topics where slug = 'gubexamen-2022'), 2, 'ca', true, (select id from public.sources where url = 'https://govern.cat/gov/notes-premsa/812364/govern-distingeix-creu-sant-jordi-20-persones-10-entitats'), 'GUB 2022 p. 8 · Fermí Puig', 'Fermí Puig i Botey. Cuiner i gastrònom: per la seva destacada trajectòria en el món de la gastronomia i per la seva contribució a la renovació i la projecció de la cuina catalana.', null, '6bef874eb7dfd44476da319c9aad22acd9dccb51d43f5525606cf240c909ec04', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '6bef874eb7dfd44476da319c9aad22acd9dccb51d43f5525606cf240c909ec04')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Fermí Puig', true), ('B', 'Ferran Adrià', false), ('C', 'Carme Ruscalleda', false), ('D', 'Joan Roca', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-urbana-barcelona');
-- Lote gubexamen-2022-cultural-govmedor26-v1 (1 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('El Govern lliura la Medalla d''Or de la Generalitat al cuiner Ferran Adrià i a la física i directora del Sincrotró ALBA Caterina Biscari (nota de premsa, 01/09/2026)', 'https://govern.cat/salapremsa/notes-premsa/862672/el-govern-lliura-la-medalla-d-or-de-la-generalitat-al-cuiner-ferran-adria-i-a-la-fisica-i-directora-del-sincrotro-alba-caterina-biscari', 'web_oficial'::public.source_kind, 'Generalitat de Catalunya, Govern.cat', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('gubexamen-2022', 'Rèplica de l''examen d''agent de la Guàrdia Urbana 2022 (exercici teòric)') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('guardia-urbana-barcelona') and t.slug = 'gubexamen-2022' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Quina professió té Caterina Biscari, Medalla d''Or de la Generalitat 2026?', 'Rèplica de la p. 24 (professió d''una personalitat d''actualitat; substitueix Zelenski). 1 de setembre de 2026.', 'gubexamen_2022', (select id from public.topics where slug = 'gubexamen-2022'), 2, 'ca', true, (select id from public.sources where url = 'https://govern.cat/salapremsa/notes-premsa/862672/el-govern-lliura-la-medalla-d-or-de-la-generalitat-al-cuiner-ferran-adria-i-a-la-fisica-i-directora-del-sincrotro-alba-caterina-biscari'), 'GUB 2022 p. 24 · Caterina Biscari', 'a la física i directora del Sincrotró ALBA Caterina Biscari', null, '482c2e76e5972dc4eec69bb1bc9882914084feb82251b7861476fe87857bd85a', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '482c2e76e5972dc4eec69bb1bc9882914084feb82251b7861476fe87857bd85a')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Cuinera', false), ('B', 'Física, directora del Sincrotró ALBA', true), ('C', 'Actriu', false), ('D', 'Arquitecta', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-urbana-barcelona');
-- Lote gubexamen-2022-cultural-govpic25-v1 (1 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('El Govern concedeix el Premi Internacional Catalunya 2025 a les activistes per la pau Yael Admi i Reem Alhajajra (acords de Govern, 23/12/2025)', 'https://govern.cat/gov/acords-govern/16039/govern-concedeix-premi-internacional-catalunya-2025-activistes-pau-yael-admi-reem-alhajajra', 'web_oficial'::public.source_kind, 'Generalitat de Catalunya, Govern.cat', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('gubexamen-2022', 'Rèplica de l''examen d''agent de la Guàrdia Urbana 2022 (exercici teòric)') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('guardia-urbana-barcelona') and t.slug = 'gubexamen-2022' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Quina iniciativa encarnen Yael Admi i Reem Alhajajra, Premi Internacional Catalunya 2025?', 'Rèplica de la p. 3 (causa solidària de l''any; substitueix La Marató 2021). 23 de desembre de 2025.', 'gubexamen_2022', (select id from public.topics where slug = 'gubexamen-2022'), 2, 'ca', true, (select id from public.sources where url = 'https://govern.cat/gov/acords-govern/16039/govern-concedeix-premi-internacional-catalunya-2025-activistes-pau-yael-admi-reem-alhajajra'), 'GUB 2022 p. 3 · Premi Internacional Catalunya 2025', 'El guardó distingeix la col·laboració de totes dues, que encarna la iniciativa La Crida de les Mares (Mother’s Call), un moviment transfronterer liderat per dones que reclama la fi de la violència', null, '3fc7a1b187bc73940fe5758a3f002900c6e80222cb79ba531a51e341703c17d8', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '3fc7a1b187bc73940fe5758a3f002900c6e80222cb79ba531a51e341703c17d8')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Una ONG de rescat de migrants al Mediterrani', false), ('B', 'Una campanya mundial contra les armes nuclears', false), ('C', 'La Crida de les Mares (Mother''s Call), un moviment de dones que reclama la fi de la violència a l''Orient Mitjà', true), ('D', 'Un projecte d''escoles a l''Afganistan', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-urbana-barcelona');
-- Lote gubexamen-2022-cultural-govpress26-v1 (1 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Els pressupostos de la Generalitat per al 2026 creixen un 22,8% respecte als darrers aprovats i acceleren la inversió amb fons propis (nota de premsa, 27/02/2026)', 'https://govern.cat/salapremsa/notes-premsa/795676/pressupostos-generalitat-al-2026-creixen-228-percent-respecte-als-darrers-aprovats-acceleren-inversio-fons-propis', 'web_oficial'::public.source_kind, 'Generalitat de Catalunya, Govern.cat', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('gubexamen-2022', 'Rèplica de l''examen d''agent de la Guàrdia Urbana 2022 (exercici teòric)') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('guardia-urbana-barcelona') and t.slug = 'gubexamen-2022' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Qui és el president del Parlament de Catalunya que va rebre el projecte de pressupostos de 2026?', 'Rèplica de la p. 12 (càrrec institucional català; substitueix el cap dels Mossos, sense font oficial carregada). 27 de febrer de 2026.', 'gubexamen_2022', (select id from public.topics where slug = 'gubexamen-2022'), 2, 'ca', true, (select id from public.sources where url = 'https://govern.cat/salapremsa/notes-premsa/795676/pressupostos-generalitat-al-2026-creixen-228-percent-respecte-als-darrers-aprovats-acceleren-inversio-fons-propis'), 'GUB 2022 p. 12 · President del Parlament', 'La consellera d''Economia i Finances, Alícia Romero, i el president del Parlament, Josep Rull', null, 'b83dd51c61e8ba663afa2d814a3413358eec5abb109a15f1dad88502a64419ca', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'b83dd51c61e8ba663afa2d814a3413358eec5abb109a15f1dad88502a64419ca')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Salvador Illa', false), ('B', 'Jaume Collboni', false), ('C', 'Josep Rull', true), ('D', 'Josep Tarradellas', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-urbana-barcelona');
-- Lote gubexamen-2022-cultural-idescat-v1 (1 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Anuari estadístic de Catalunya i El municipi en xifres (Institut d''Estadística de Catalunya)', 'https://www.idescat.cat/indicadors/?id=aec&lang=ca', 'web_oficial'::public.source_kind, 'Institut d''Estadística de Catalunya (Idescat)', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('gubexamen-2022', 'Rèplica de l''examen d''agent de la Guàrdia Urbana 2022 (exercici teòric)') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('guardia-urbana-barcelona') and t.slug = 'gubexamen-2022' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Quants municipis formen la comarca del Barcelonès, el nucli de l''àrea metropolitana?', 'Rèplica de la reserva 55 (municipis de l''àmbit metropolità). El Barcelonès té 5 municipis; l''Àrea Metropolitana de Barcelona n''aplega més.', 'gubexamen_2022', (select id from public.topics where slug = 'gubexamen-2022'), 3, 'ca', true, (select id from public.sources where url = 'https://www.idescat.cat/indicadors/?id=aec&lang=ca'), 'GUB 2022 p. 55 (reserva) · Barcelonès', 'Barcelonès Barcelona Barcelona 5 2.398.280', null, '573d88f626047291694d9de398a10bf1a75fb31de69e71376594fa32342e7d0f', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '573d88f626047291694d9de398a10bf1a75fb31de69e71376594fa32342e7d0f')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', '5', true), ('B', '36', false), ('C', '23', false), ('D', '9', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-urbana-barcelona');
-- Lote gubexamen-2022-cultural-moncloasmi26-v1 (1 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Pedro Sánchez destaca que con la subida del SMI en 2026 se da "un paso muy relevante para mejorar la vida de 2,5 millones de trabajadores" (16/02/2026)', 'https://www.lamoncloa.gob.es/presidente/actividades/Paginas/2026/160226-sanchez-subida-salario-minimo.aspx', 'web_oficial'::public.source_kind, 'La Moncloa, Gobierno de España', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('gubexamen-2022', 'Rèplica de l''examen d''agent de la Guàrdia Urbana 2022 (exercici teòric)') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('guardia-urbana-barcelona') and t.slug = 'gubexamen-2022' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Qui és la vicepresidenta segona i ministra de Treball i Economia Social que va intervenir en l''acte de la pujada de l''SMI 2026?', 'Rèplica de la p. 10 (membre del Govern d''Espanya; actualitzat). 16 de febrer de 2026.', 'gubexamen_2022', (select id from public.topics where slug = 'gubexamen-2022'), 2, 'ca', true, (select id from public.sources where url = 'https://www.lamoncloa.gob.es/presidente/actividades/Paginas/2026/160226-sanchez-subida-salario-minimo.aspx'), 'GUB 2022 p. 10 · Ministra de Treball', 'la vicepresidenta segunda y ministra de Trabajo y Economía Social, Yolanda Díaz', null, '472773abbdfab78d73ebb66e043b3f5a976f812b0c63e2edcdf213f4ede97791', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '472773abbdfab78d73ebb66e043b3f5a976f812b0c63e2edcdf213f4ede97791')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'María Jesús Montero', false), ('B', 'Yolanda Díaz', true), ('C', 'Nadia Calviño', false), ('D', 'Teresa Ribera', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-urbana-barcelona');
-- Lote gubexamen-2022-cultural-nobelhist-v1 (4 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('NobelPrize.org: All Nobel Prizes 2025 i fitxes de premiats (Literature 1956, 1977, 1982, 1989, 2010, 2023-2024; Peace 2023-2024)', 'https://www.nobelprize.org/all-nobel-prizes-2025/', 'web_oficial'::public.source_kind, 'Nobel Foundation / Nobel Prize Outreach', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('gubexamen-2022', 'Rèplica de l''examen d''agent de la Guàrdia Urbana 2022 (exercici teòric)') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('guardia-urbana-barcelona') and t.slug = 'gubexamen-2022' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Pels drets democràtics de quin país va rebre María Corina Machado el premi Nobel de la pau 2025?', 'Rèplica de la p. 1 (Nobel de la pau 2021, actualitzat a un premi recent). Octubre de 2025.', 'gubexamen_2022', (select id from public.topics where slug = 'gubexamen-2022'), 2, 'ca', true, (select id from public.sources where url = 'https://www.nobelprize.org/all-nobel-prizes-2025/'), 'GUB 2022 p. 1 · Nobel de la pau 2025', 'Nobel Peace Prize 2025 Maria Corina Machado “for her tireless work promoting democratic rights for the people of Venezuela', null, 'b91082cc644ca7b6010dc108f5e5b2d26e696028705c32ff5152d8cfade1ebac', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'b91082cc644ca7b6010dc108f5e5b2d26e696028705c32ff5152d8cfade1ebac')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Veneçuela', true), ('B', 'Colòmbia', false), ('C', 'Cuba', false), ('D', 'Nicaragua', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-urbana-barcelona');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Quin premi Nobel de literatura va morir a Lima el 13 d''abril de 2025?', 'Rèplica de la p. 4 (mort d''una figura coneguda; substitueix la de Manolo Santana). Vargas Llosa (Nobel 2010) va morir el 13 d''abril de 2025.', 'gubexamen_2022', (select id from public.topics where slug = 'gubexamen-2022'), 2, 'ca', true, (select id from public.sources where url = 'https://www.nobelprize.org/all-nobel-prizes-2025/'), 'GUB 2022 p. 4 · Mort de Vargas Llosa', 'Mario Vargas Llosa Nobel Prize in Literature 2010 Born: 28 March 1936, Arequipa, Peru Died: 13 April 2025, Lima, Peru', 'Fet de fa uns 19 mesos (fora dels 12 mesos); es manté perquè no hi ha cap altra mort de figura pública amb font oficial carregada.', 'c2625f2763e40b3d552ab34f061e82fe16204fc316c5aae0701108c5d519f033', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'c2625f2763e40b3d552ab34f061e82fe16204fc316c5aae0701108c5d519f033')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Gabriel García Márquez', false), ('B', 'Camilo José Cela', false), ('C', 'Gonzalo Celorio', false), ('D', 'Mario Vargas Llosa', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-urbana-barcelona');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'De quina nacionalitat és László Krasznahorkai, premi Nobel de literatura 2025?', 'Rèplica de la p. 16 (figura literària; substitueix la mort d''Almudena Grandes). Octubre de 2025.', 'gubexamen_2022', (select id from public.topics where slug = 'gubexamen-2022'), 3, 'ca', true, (select id from public.sources where url = 'https://www.nobelprize.org/all-nobel-prizes-2025/'), 'GUB 2022 p. 16 · Nobel de literatura 2025', 'The Nobel Prize in Literature for 2025 is awarded to the Hungarian author László Krasznahorkai', null, '00536acd35445435636092d4a10f2ef6072ddfb6c84dee9fdb6b5860f216ab3b', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '00536acd35445435636092d4a10f2ef6072ddfb6c84dee9fdb6b5860f216ab3b')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Hongaresa', true), ('B', 'Polonesa', false), ('C', 'Txeca', false), ('D', 'Romanesa', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-urbana-barcelona');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Quin d''aquests poetes espanyols va rebre el premi Nobel de literatura?', 'Rèplica de la p. 35 (autor de teatre i poesia del segle XX). Aleixandre va rebre el Nobel el 1977; Lorca, Machado i Alberti no el van rebre.', 'gubexamen_2022', (select id from public.topics where slug = 'gubexamen-2022'), 2, 'ca', true, (select id from public.sources where url = 'https://www.nobelprize.org/all-nobel-prizes-2025/'), 'GUB 2022 p. 35 · Nobel espanyols de literatura', 'Vicente Aleixandre Nobel Prize in Literature 1977', null, 'b74e523334734b538b3b56d500785cd6900a39ae6c9c3e76cfda6285a76ae337', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'b74e523334734b538b3b56d500785cd6900a39ae6c9c3e76cfda6285a76ae337')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Federico García Lorca', false), ('B', 'Antonio Machado', false), ('C', 'Rafael Alberti', false), ('D', 'Vicente Aleixandre', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-urbana-barcelona');
-- Lote gubexamen-2022-cultural-onu-v1 (1 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('United Nations: About Us, UN Charter, Main Bodies i Selection and Appointment of the Next Secretary-General', 'https://www.un.org/en/about-us', 'web_oficial'::public.source_kind, 'United Nations', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('gubexamen-2022', 'Rèplica de l''examen d''agent de la Guàrdia Urbana 2022 (exercici teòric)') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('guardia-urbana-barcelona') and t.slug = 'gubexamen-2022' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Qui és el secretari general de les Nacions Unides?', 'Rèplica de la p. 21 (persona d''actualitat internacional; substitueix l''alcalde de Nova York). El procés per triar-ne el successor va començar el 25 de novembre de 2025.', 'gubexamen_2022', (select id from public.topics where slug = 'gubexamen-2022'), 1, 'ca', true, (select id from public.sources where url = 'https://www.un.org/en/about-us'), 'GUB 2022 p. 21 · Secretari general de l''ONU', 'António Guterres United Nations Secretary-General', null, '531f69f026b9a8622f508ac8f8ace7b925384a1a9dd5314fa187e45522bd0f30', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '531f69f026b9a8622f508ac8f8ace7b925384a1a9dd5314fa187e45522bd0f30')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'António Costa', false), ('B', 'António Guterres', true), ('C', 'Ban Ki-moon', false), ('D', 'Kofi Annan', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-urbana-barcelona');
-- Lote gubexamen-2022-cultural-ue-v1 (3 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Portal oficial de la Unión Europea: países, historia, euro e instituciones', 'https://european-union.europa.eu/index_es', 'web_oficial'::public.source_kind, 'Unión Europea', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('gubexamen-2022', 'Rèplica de l''examen d''agent de la Guàrdia Urbana 2022 (exercici teòric)') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('guardia-urbana-barcelona') and t.slug = 'gubexamen-2022' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Qui presideix el Parlament Europeu?', 'Rèplica de la p. 15 (cap d''una institució; substitueix el president de Xile).', 'gubexamen_2022', (select id from public.topics where slug = 'gubexamen-2022'), 2, 'ca', true, (select id from public.sources where url = 'https://european-union.europa.eu/index_es'), 'GUB 2022 p. 15 · Presidenta del Parlament Europeu', 'Presidenta: Roberta Metsola', null, '80948c701e75be780862e590a699e4a6c51e642c56ec9546d48f1d334d4786b2', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '80948c701e75be780862e590a699e4a6c51e642c56ec9546d48f1d334d4786b2')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Ursula von der Leyen', false), ('B', 'Roberta Metsola', true), ('C', 'Christine Lagarde', false), ('D', 'Kaja Kallas', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-urbana-barcelona');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'On té la seu la Comissió Europea, presidida per Ursula von der Leyen?', 'Rèplica de la p. 22. La Comissió és a Brussel·les; el Parlament Europeu té seus a Estrasburg, Brussel·les i Luxemburg.', 'gubexamen_2022', (select id from public.topics where slug = 'gubexamen-2022'), 2, 'ca', true, (select id from public.sources where url = 'https://european-union.europa.eu/index_es'), 'GUB 2022 p. 22 · Seu de la Comissió Europea', 'Sede: Bruselas (Bélgica)', null, '58e8b3c5b6816716971ccc21d77adec0daca8a6b2f957d2a21d92379900910d6', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '58e8b3c5b6816716971ccc21d77adec0daca8a6b2f957d2a21d92379900910d6')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'A Estrasburg', false), ('B', 'A Luxemburg', false), ('C', 'A Brussel·les', true), ('D', 'A Frankfurt', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-urbana-barcelona');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Quin tractat, signat el 7 de febrer de 1992, va crear oficialment la Unió Europea?', 'Rèplica de la p. 48 (un gran tractat de la història; substitueix Versalles). Va entrar en vigor l''1 de novembre de 1993.', 'gubexamen_2022', (select id from public.topics where slug = 'gubexamen-2022'), 2, 'ca', true, (select id from public.sources where url = 'https://european-union.europa.eu/index_es'), 'GUB 2022 p. 48 · Tractat de Maastricht', '7 de febrero de 1992 – Tratado de Maastricht En Maastricht (Países Bajos) se firma el Tratado de la Unión Europea.', null, 'bb31b40c81847477f813c59e2eb6b7e7b9a7e7ecb34cf09bcef351e09de86f5e', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'bb31b40c81847477f813c59e2eb6b7e7b9a7e7ecb34cf09bcef351e09de86f5e')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El Tractat de Versalles', false), ('B', 'El Tractat de Roma', false), ('C', 'El Tractat de Lisboa', false), ('D', 'El Tractat de Maastricht', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-urbana-barcelona');
-- Lote gubexamen-2022-cultural-uepaisos-v1 (3 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Países de la UE: fichas de país (european-union.europa.eu/principles-countries-history/eu-countries/<país>_es)', 'https://european-union.europa.eu/principles-countries-history/eu-countries_es', 'web_oficial'::public.source_kind, 'Unión Europea', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('gubexamen-2022', 'Rèplica de l''examen d''agent de la Guàrdia Urbana 2022 (exercici teòric)') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('guardia-urbana-barcelona') and t.slug = 'gubexamen-2022' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Quina moneda té Bulgària des de l''1 de gener de 2026?', 'Rèplica de la p. 18 (país i moneda de curs legal; substitueix el bitcoin a El Salvador). 1 de gener de 2026.', 'gubexamen_2022', (select id from public.topics where slug = 'gubexamen-2022'), 1, 'ca', true, (select id from public.sources where url = 'https://european-union.europa.eu/principles-countries-history/eu-countries_es'), 'GUB 2022 p. 18 · Bulgària i l''euro', 'Zona del euro: Miembro desde el 1 de enero de 2026', null, '5159807efbda36a5eb53eb2a6970899890a005a89f918182aacc2c6373b5c2ac', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '5159807efbda36a5eb53eb2a6970899890a005a89f918182aacc2c6373b5c2ac')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El lev búlgar', false), ('B', 'L''euro', true), ('C', 'El dòlar', false), ('D', 'La corona', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-urbana-barcelona');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Quin d''aquests estats sorgits de l''antiga Iugoslàvia és membre de la UE des de l''1 de juliol de 2013?', 'Rèplica de la p. 42 (estats de l''antiga Iugoslàvia). Croàcia (capital, Zagreb) és el 28è estat que es va adherir.', 'gubexamen_2022', (select id from public.topics where slug = 'gubexamen-2022'), 3, 'ca', true, (select id from public.sources where url = 'https://european-union.europa.eu/principles-countries-history/eu-countries_es'), 'GUB 2022 p. 42 · Croàcia a la UE', '[Croacia] Capital: Zagreb Estado miembro de la UE: desde el 1 de julio de 2013', null, '0b7f84eb75a600e033d9758870af7ed2e3c35364aacb41f5f3abf68eb2a6fca0', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '0b7f84eb75a600e033d9758870af7ed2e3c35364aacb41f5f3abf68eb2a6fca0')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Sèrbia', false), ('B', 'Bòsnia i Hercegovina', false), ('C', 'Macedònia del Nord', false), ('D', 'Croàcia', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-urbana-barcelona');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Quina és la capital d''Eslovàquia?', 'Rèplica de la reserva 54 (capitals; substitueix la de Corea del Nord per una capital europea).', 'gubexamen_2022', (select id from public.topics where slug = 'gubexamen-2022'), 2, 'ca', true, (select id from public.sources where url = 'https://european-union.europa.eu/principles-countries-history/eu-countries_es'), 'GUB 2022 p. 54 (reserva) · Capital d''Eslovàquia', '[Eslovaquia] Capital: Bratislava', null, '850f292973a8a61e52dbf7a86f77f3a4520acbfe47ca97a6437b7b0e1d2de96c', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '850f292973a8a61e52dbf7a86f77f3a4520acbfe47ca97a6437b7b0e1d2de96c')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Praga', false), ('B', 'Bratislava', true), ('C', 'Budapest', false), ('D', 'Liubliana', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-urbana-barcelona');
-- Lote gubexamen-2022-cultural-unesco-v1 (4 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('World Heritage List (fitxes dels béns inscrits), UNESCO World Heritage Centre', 'https://whc.unesco.org/en/list/', 'web_oficial'::public.source_kind, 'UNESCO World Heritage Centre', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('gubexamen-2022', 'Rèplica de l''examen d''agent de la Guàrdia Urbana 2022 (exercici teòric)') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('guardia-urbana-barcelona') and t.slug = 'gubexamen-2022' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Quantes persones, segons les investigacions històriques que recull la UNESCO, van ser assassinades al camp d''Auschwitz-Birkenau?', 'Rèplica de la p. 30. Auschwitz-Birkenau va ser el camp més gran del Tercer Reich.', 'gubexamen_2022', (select id from public.topics where slug = 'gubexamen-2022'), 2, 'ca', true, (select id from public.sources where url = 'https://whc.unesco.org/en/list/'), 'GUB 2022 p. 30 · Auschwitz', '1.5 million people, among them a great number of Jews, were systematically starved, tortured and murdered in this camp', null, '1443c55901752145cd751e758d6dcebd6d50a5cf00290f2c51d2c5a9114d8bcc', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '1443c55901752145cd751e758d6dcebd6d50a5cf00290f2c51d2c5a9114d8bcc')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', '150.000', false), ('B', '6 milions', false), ('C', '1,5 milions', true), ('D', '15 milions', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-urbana-barcelona');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'De quin imperi eren capitals les restes d''Angkor (Cambodja), amb el temple d''Angkor Wat?', 'Rèplica de la p. 32. Angkor conté les restes de les capitals de l''Imperi khmer, dels segles IX al XV.', 'gubexamen_2022', (select id from public.topics where slug = 'gubexamen-2022'), 3, 'ca', true, (select id from public.sources where url = 'https://whc.unesco.org/en/list/'), 'GUB 2022 p. 32 · Angkor', 'Angkor Archaeological Park contains the magnificent remains of the different capitals of the Khmer Empire, from the 9th to the 15th century.', null, '53507bcdb8f1fb132886581bea28c1d3302b4c7088c11d0733b5d92f1cbd4cca', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '53507bcdb8f1fb132886581bea28c1d3302b4c7088c11d0733b5d92f1cbd4cca')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'De l''Imperi khmer', true), ('B', 'De l''Imperi mogol', false), ('C', 'De l''Imperi xinès', false), ('D', 'De l''Imperi inca', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-urbana-barcelona');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Entre quins mars se situa la ciutat caravanera de Petra?', 'Rèplica de la p. 43 (geografia d''un lloc emblemàtic; substitueix el canal de Panamà).', 'gubexamen_2022', (select id from public.topics where slug = 'gubexamen-2022'), 3, 'ca', true, (select id from public.sources where url = 'https://whc.unesco.org/en/list/'), 'GUB 2022 p. 43 · Petra', 'situated between the Red Sea and the Dead Sea', null, '4a8c3e129049575515dea65f4946e2ac35fe24a65ba45ecbdce1bba163feed5b', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '4a8c3e129049575515dea65f4946e2ac35fe24a65ba45ecbdce1bba163feed5b')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Entre el mar Mediterrani i el mar Negre', false), ('B', 'Entre el mar Roig i el mar Mort', true), ('C', 'Entre el mar Caspi i el mar Negre', false), ('D', 'Entre el golf Pèrsic i el mar d''Aràbia', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-urbana-barcelona');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Quina ciutat romana, avui Tarragona, era el centre del culte imperial de totes les províncies hispàniques?', 'Rèplica de la reserva 51 (arqueologia; substitueix la troballa al Born). El conjunt arqueològic de Tàrraco és patrimoni mundial des del 2000.', 'gubexamen_2022', (select id from public.topics where slug = 'gubexamen-2022'), 2, 'ca', true, (select id from public.sources where url = 'https://whc.unesco.org/en/list/'), 'GUB 2022 p. 51 (reserva) · Tàrraco', 'Tarraco (modern-day Tarragona) was a major administrative and mercantile city in Roman Spain and the centre of the Imperial cult for all the Iberian provinces.', null, 'd0562d16d0e08e4be20d00481bb08b2205d43f3c16cd1386e8d150440ea1a89c', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'd0562d16d0e08e4be20d00481bb08b2205d43f3c16cd1386e8d150440ea1a89c')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Bàrcino', false), ('B', 'Empúries', false), ('C', 'Tàrraco', true), ('D', 'Augusta Emerita', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-urbana-barcelona');
-- Lote gubexamen-2023-cultural-bcngaudi26-v1 (1 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Barcelona ret homenatge a Antoni Gaudí amb una placa en el mateix punt on va ser atropellat l’any 1926 (07/06/2026)', 'https://ajuntament.barcelona.cat/premsa/2026/06/07/barcelona-ret-homenatge-a-antoni-gaudi-amb-una-placa-en-el-mateix-punt-on-va-ser-atropellat-lany-1926/', 'web_oficial'::public.source_kind, 'Ajuntament de Barcelona', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('gubexamen-2023', 'Rèplica de l''examen d''agent de la Guàrdia Urbana 2023 (part de temari)') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('guardia-urbana-barcelona') and t.slug = 'gubexamen-2023' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Per quina causa va morir Antoni Gaudí el juny de 1926?', 'Rèplica de la reserva 68 (coneixement de Barcelona). 7 de juny de 2026: placa a la Gran Via de les Corts Catalanes.', 'gubexamen_2023', (select id from public.topics where slug = 'gubexamen-2023'), 1, 'ca', true, (select id from public.sources where url = 'https://ajuntament.barcelona.cat/premsa/2026/06/07/barcelona-ret-homenatge-a-antoni-gaudi-amb-una-placa-en-el-mateix-punt-on-va-ser-atropellat-lany-1926/'), 'GUB 2023 p. 68 (reserva) · Mort de Gaudí', 'on va ser atropellat per un tramvia el 7 de juny de 1926.', null, 'c0a776ece72bd4641621aa8a5276ba2845e83193ccb5b39a054e85454d417394', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'c0a776ece72bd4641621aa8a5276ba2845e83193ccb5b39a054e85454d417394')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Atropellat per un tramvia a la Gran Via', true), ('B', 'Per una caiguda a les obres de la Sagrada Família', false), ('C', 'Per una epidèmia de grip', false), ('D', 'En un incendi al Park Güell', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-urbana-barcelona');
-- Lote gubexamen-2023-cultural-bcnmerce26-v1 (2 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Tota la programació de la Mercè 2026 (16/09/2026) i Lectura del pregó de les Festes de la Mercè 2026 (22/09/2026)', 'https://ajuntament.barcelona.cat/ciutatvella/ca/noticies/tota-la-programacio-de-la-merce-2026-41192', 'web_oficial'::public.source_kind, 'Ajuntament de Barcelona', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('gubexamen-2023', 'Rèplica de l''examen d''agent de la Guàrdia Urbana 2023 (part de temari)') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('guardia-urbana-barcelona') and t.slug = 'gubexamen-2023' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Qui és l''alcalde de Barcelona que va presidir el pregó de la Mercè 2026?', 'Rèplica de la p. 53 (càrrecs de l''Ajuntament de Barcelona). 23 de setembre de 2026.', 'gubexamen_2023', (select id from public.topics where slug = 'gubexamen-2023'), 1, 'ca', true, (select id from public.sources where url = 'https://ajuntament.barcelona.cat/ciutatvella/ca/noticies/tota-la-programacio-de-la-merce-2026-41192'), 'GUB 2023 p. 53 · Alcalde de Barcelona', 'l’alcalde de Barcelona, Jaume Collboni, presidirà l’acte de lectura del pregó', null, '6dfb5f251c3fda9e854f541e84b10af760db32b66b75e0723f188afd90d81a67', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '6dfb5f251c3fda9e854f541e84b10af760db32b66b75e0723f188afd90d81a67')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Ada Colau', false), ('B', 'Xavier Trias', false), ('C', 'Jaume Collboni', true), ('D', 'Ernest Maragall', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-urbana-barcelona');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Quins dies es van celebrar les Festes de la Mercè 2026?', 'Rèplica de la p. 58 (fet de la vida ciutadana de Barcelona; substitueix el trasllat del Pinotxo). 16 de setembre de 2026: 109 concerts, 55 actuacions de cultura popular i 180 funcions d''arts de carrer.', 'gubexamen_2023', (select id from public.topics where slug = 'gubexamen-2023'), 2, 'ca', true, (select id from public.sources where url = 'https://ajuntament.barcelona.cat/ciutatvella/ca/noticies/tota-la-programacio-de-la-merce-2026-41192'), 'GUB 2023 p. 58 · Mercè 2026', 'Del 23 al 27 de setembre, Barcelona celebra la Mercè amb una programació de 109 concerts', null, '0494f4011439e91a3ac9f43aef42459a2c3cf8599affbadb4ce815f796d3fed9', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '0494f4011439e91a3ac9f43aef42459a2c3cf8599affbadb4ce815f796d3fed9')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'De l''11 al 15 de setembre', false), ('B', 'Del 24 al 28 d''agost', false), ('C', 'Del 23 al 27 de setembre', true), ('D', 'Del 26 de juny al 5 de juliol', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-urbana-barcelona');
-- Lote gubexamen-2023-cultural-bcnpadro26-v1 (1 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('La població de Barcelona. Lectura del padró municipal d’habitants a 01/01/2026: síntesi de resultats', 'https://dades.ajuntament.barcelona.cat/informe-padro-poblacio/ca/seccio_2.html', 'web_oficial'::public.source_kind, 'Ajuntament de Barcelona, Departament d''Estadística i Difusió de Dades', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('gubexamen-2023', 'Rèplica de l''examen d''agent de la Guàrdia Urbana 2023 (part de temari)') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('guardia-urbana-barcelona') and t.slug = 'gubexamen-2023' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Quantes nacionalitats diferents, a més de l''espanyola, hi ha a Barcelona segons el padró de 2026?', 'Rèplica de la p. 65 (notícia de ciutat; substitueix la mort de l''hipopòtam del Zoo). Padró 2026.', 'gubexamen_2023', (select id from public.topics where slug = 'gubexamen-2023'), 3, 'ca', true, (select id from public.sources where url = 'https://dades.ajuntament.barcelona.cat/informe-padro-poblacio/ca/seccio_2.html'), 'GUB 2023 p. 65 · Padró 2026, nacionalitats', 'hi conviuen persones de fins a 181 nacionalitats diferents.', null, '600e910970c0151a611faf7c59387c8c645d07ef13aeec2c658da2f865f15470', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '600e910970c0151a611faf7c59387c8c645d07ef13aeec2c658da2f865f15470')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', '81', false), ('B', '121', false), ('C', '251', false), ('D', '181', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-urbana-barcelona');
-- Lote gubexamen-2023-cultural-bcntour26-v1 (2 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('La Festa Major del Tour omplirà Barcelona amb més de 60 propostes (15/05/2026) i Catalunya i Barcelona s’il·luminen de groc (26/03/2026)', 'https://ajuntament.barcelona.cat/premsa/2026/05/15/la-festa-major-del-tour-omplira-barcelona-amb-mes-de-60-propostes-per-celebrar-el-tour-de-franca/', 'web_oficial'::public.source_kind, 'Ajuntament de Barcelona', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('gubexamen-2023', 'Rèplica de l''examen d''agent de la Guàrdia Urbana 2023 (part de temari)') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('guardia-urbana-barcelona') and t.slug = 'gubexamen-2023' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Quin color van lluir edificis com la Sagrada Família, la Pedrera o el MNAC en el compte enrere del Tour de França 2026, el del mallot de líder?', 'Rèplica de la p. 55 (gran esdeveniment esportiu a Barcelona; substitueix la Copa Amèrica 2023-2024). 26 de març de 2026: Catalunya i Barcelona s''il·luminen de groc, el color del mallot de líder del Tour.', 'gubexamen_2023', (select id from public.topics where slug = 'gubexamen-2023'), 2, 'ca', true, (select id from public.sources where url = 'https://ajuntament.barcelona.cat/premsa/2026/05/15/la-festa-major-del-tour-omplira-barcelona-amb-mes-de-60-propostes-per-celebrar-el-tour-de-franca/'), 'GUB 2023 p. 55 · Compte enrere del Tour 2026', 'Icones arquitectòniques com la Sagrada Família, la Casa Batlló, La Pedrera i el MNAC han lluït el color del mallot de líder.', 'El text de la nota diu «el color del mallot de líder»; el títol de la notícia (URL) diu «s''il·luminen de groc».', 'b0423c2b020416bb478180385c160bb41a77f7ddaf36a0e6b7752441d8ee4c08', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'b0423c2b020416bb478180385c160bb41a77f7ddaf36a0e6b7752441d8ee4c08')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Verd', false), ('B', 'Groc', true), ('C', 'Vermell', false), ('D', 'Blau', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-urbana-barcelona');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Quina voluntat tenia l''Ajuntament amb la Festa Major del Tour 2026?', 'Rèplica de la p. 59 (actualitat esportiva; substitueix la Pilota d''Or 2023). 15 de maig de 2026.', 'gubexamen_2023', (select id from public.topics where slug = 'gubexamen-2023'), 3, 'ca', true, (select id from public.sources where url = 'https://ajuntament.barcelona.cat/premsa/2026/05/15/la-festa-major-del-tour-omplira-barcelona-amb-mes-de-60-propostes-per-celebrar-el-tour-de-franca/'), 'GUB 2023 p. 59 · Festa Major del Tour', 'L’objectiu és convertir excepcional aquest any la Festa Major del Tour en la tercera gran festivitat de Barcelona, després de Santa Eulàlia i la Mercè', null, '42e86741ac353694465123e3cfbf5562841c8f19793de1d15d6b9764a7191b52', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '42e86741ac353694465123e3cfbf5562841c8f19793de1d15d6b9764a7191b52')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Convertir-la excepcionalment en la tercera gran festivitat de Barcelona, després de Santa Eulàlia i la Mercè', true), ('B', 'Substituir la Festa Major de Gràcia aquell any', false), ('C', 'Fer-la coincidir amb la Mercè', false), ('D', 'Convertir-la en una festa anual permanent', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-urbana-barcelona');
-- Lote gubexamen-2023-cultural-diec-v1 (7 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Diccionari de la llengua catalana, 2a edició (DIEC2), Institut d''Estudis Catalans', 'https://dlc.iec.cat/', 'web_oficial'::public.source_kind, 'Institut d''Estudis Catalans', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('gubexamen-2023', 'Rèplica de l''examen d''agent de la Guàrdia Urbana 2023 (part de temari)') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('guardia-urbana-barcelona') and t.slug = 'gubexamen-2023' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Un vehicle que circula a gran velocitat té molta energia...', 'Rèplica de la p. 40 (energia cinètica). L''energia cinètica és la deguda al moviment.', 'gubexamen_2023', (select id from public.topics where slug = 'gubexamen-2023'), 1, 'ca', true, (select id from public.sources where url = 'https://dlc.iec.cat/'), 'GUB 2023 p. 40 · Energia cinètica', '2 adj. [FIF] Degut al moviment. Energia cinètica.', null, '3913e5270fe2c15544b02a435f0da255d112d879ec64459b2b718d8250df7195', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '3913e5270fe2c15544b02a435f0da255d112d879ec64459b2b718d8250df7195')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Potencial', false), ('B', 'Cinètica', true), ('C', 'Química', false), ('D', 'Nuclear', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-urbana-barcelona');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Quin és el símbol químic de l''argent (plata)?', 'Rèplica de la p. 41. L''argent té el símbol Ag (nombre atòmic 47); Au és l''or i Pt el platí.', 'gubexamen_2023', (select id from public.topics where slug = 'gubexamen-2023'), 2, 'ca', true, (select id from public.sources where url = 'https://dlc.iec.cat/'), 'GUB 2023 p. 41 · Símbol de l''argent', '(símbol, Ag; nombre atòmic, 47; pes atòmic, 107,87)', null, '05092e2afb564f5e692c75d10e58443c105b304b282d2721da9dfc29599afcbb', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '05092e2afb564f5e692c75d10e58443c105b304b282d2721da9dfc29599afcbb')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Au', false), ('B', 'Ar', false), ('C', 'Ag', true), ('D', 'Pt', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-urbana-barcelona');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Quina és la unitat de potència del sistema internacional?', 'Rèplica de la p. 45. El watt equival a 1 joule per segon.', 'gubexamen_2023', (select id from public.topics where slug = 'gubexamen-2023'), 1, 'ca', true, (select id from public.sources where url = 'https://dlc.iec.cat/'), 'GUB 2023 p. 45 · Unitat de potència', 'watt 1 m. [FIF] [FIM] [LC] Unitat de potència del sistema internacional', null, '058f04a5e69cdef3eb4c2419eaf7ea0aca94a915c6e3a8a35065e0381def49f6', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '058f04a5e69cdef3eb4c2419eaf7ea0aca94a915c6e3a8a35065e0381def49f6')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El joule', false), ('B', 'El watt', true), ('C', 'El volt', false), ('D', 'L''ampere', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-urbana-barcelona');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'La sal comuna és clorur de sodi. Quin és el símbol químic del sodi?', 'Rèplica de la p. 48 (fórmula de la sal comuna, NaCl). El sodi és Na i el clor, Cl.', 'gubexamen_2023', (select id from public.topics where slug = 'gubexamen-2023'), 2, 'ca', true, (select id from public.sources where url = 'https://dlc.iec.cat/'), 'GUB 2023 p. 48 · Sal comuna', '(símbol, Na; nombre atòmic, 11; pes atòmic, 22,99)', null, '65bbbf8c2f239522d31ede843c661d847c9aeb33f2b12fe729229ae2d9959e29', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '65bbbf8c2f239522d31ede843c661d847c9aeb33f2b12fe729229ae2d9959e29')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'So', false), ('B', 'Na', true), ('C', 'S', false), ('D', 'Cl', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-urbana-barcelona');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Les inicials IEC (Institut d''Estudis Catalans), com DAFO o ONU, són un exemple de...', 'Rèplica de la p. 50 (significat d''una sigla). Una sigla es forma amb les lletres inicials dels components d''un sintagma.', 'gubexamen_2023', (select id from public.topics where slug = 'gubexamen-2023'), 2, 'ca', true, (select id from public.sources where url = 'https://dlc.iec.cat/'), 'GUB 2023 p. 50 · Sigla', 'La sigla IEC és la manera abreujada de referir-nos a l’Institut d’Estudis Catalans.', null, 'a8d1bb8c8accf5c2c483b35f9ffc0f058d6008b1c08932997d2dfee564baff1d', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'a8d1bb8c8accf5c2c483b35f9ffc0f058d6008b1c08932997d2dfee564baff1d')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Sigla', true), ('B', 'Acrònim', false), ('C', 'Abreviatura', false), ('D', 'Símbol', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-urbana-barcelona');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Com s''anomena el lloc públic on es negocien els valors mobiliaris admesos a cotització, i del qual l''Ibex 35 és l''índex de referència a Espanya?', 'Rèplica de la p. 60 (índex borsari).', 'gubexamen_2023', (select id from public.topics where slug = 'gubexamen-2023'), 2, 'ca', true, (select id from public.sources where url = 'https://dlc.iec.cat/'), 'GUB 2023 p. 60 · Borsa', 'borsa 1 f. [ECT] [LC] Lloc públic on es reuneixen els agents de canvi, on es negocien els valors mobiliaris admesos a cotització.', null, '4f2312e0ad7eb15c93b4b62c1c0de0392f68a948c31d34e9504aae16c9ee571b', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '4f2312e0ad7eb15c93b4b62c1c0de0392f68a948c31d34e9504aae16c9ee571b')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Banc central', false), ('B', 'Llotja agrària', false), ('C', 'Tresor públic', false), ('D', 'Borsa', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-urbana-barcelona');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'En una setmana, una patrulla fa 4, 6, 6, 3, 6, 4 i 5 denúncies diàries. Quina és la moda?', 'Rèplica de la reserva 69 (estadística: es pregunta la moda en lloc del rang). El valor més freqüent és el 6 (tres vegades).', 'gubexamen_2023', (select id from public.topics where slug = 'gubexamen-2023'), 2, 'ca', true, (select id from public.sources where url = 'https://dlc.iec.cat/'), 'GUB 2023 p. 69 (reserva) · Moda estadística', 'moda 2 f. [MT] En estad., valor de l’observació més freqüent en un conjunt de dades.', null, '0167535eff4f84c9148789719604835a65bda55ff05be5afc3cb2611db68d680', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '0167535eff4f84c9148789719604835a65bda55ff05be5afc3cb2611db68d680')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', '4', false), ('B', '6', true), ('C', '5', false), ('D', '3', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-urbana-barcelona');
-- Lote gubexamen-2023-cultural-genhist-v1 (3 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Història de la Generalitat (Diputació del General, Nova Planta i Generalitat contemporània)', 'https://web.gencat.cat/ca/generalitat/qui-som/historia-generalitat', 'web_oficial'::public.source_kind, 'Generalitat de Catalunya', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('gubexamen-2023', 'Rèplica de l''examen d''agent de la Guàrdia Urbana 2023 (part de temari)') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('guardia-urbana-barcelona') and t.slug = 'gubexamen-2023' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Quina dictadura va governar Espanya entre 1923 i 1930?', 'Rèplica de la p. 43 (fet de la història d''Espanya contemporània; substitueix la guerra de Cuba, sense font oficial carregada).', 'gubexamen_2023', (select id from public.topics where slug = 'gubexamen-2023'), 2, 'ca', true, (select id from public.sources where url = 'https://web.gencat.cat/ca/generalitat/qui-som/historia-generalitat'), 'GUB 2023 p. 43 · Dictadura de Primo de Rivera', 'la del general Primo de Rivera (1923-1930)', null, 'c5adbbfff44e2559241df1225dbbc0e490aa8b2a68e7c2eabf98d312c0afed0f', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'c5adbbfff44e2559241df1225dbbc0e490aa8b2a68e7c2eabf98d312c0afed0f')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'La del general Franco', false), ('B', 'La del general Espartero', false), ('C', 'La del general Prim', false), ('D', 'La del general Primo de Rivera', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-urbana-barcelona');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'On va ser afusellat el president Lluís Companys el 15 d''octubre de 1940?', 'Rèplica de la p. 46 (execució d''una figura política catalana; substitueix Puig Antich, sense font oficial carregada).', 'gubexamen_2023', (select id from public.topics where slug = 'gubexamen-2023'), 2, 'ca', true, (select id from public.sources where url = 'https://web.gencat.cat/ca/generalitat/qui-som/historia-generalitat'), 'GUB 2023 p. 46 · Afusellament de Companys', 'jutjat en un consell de guerra sumaríssim i afusellat al castell de Montjuïc el dia 15 d''octubre de 1940.', null, 'c9166eb2cd5619010e5770533199f0f889ef0a2583d83d6b4895dbd83a9a48d3', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'c9166eb2cd5619010e5770533199f0f889ef0a2583d83d6b4895dbd83a9a48d3')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Al Camp de la Bota', false), ('B', 'A la presó Model', false), ('C', 'Al castell de Montjuïc', true), ('D', 'Al castell de Figueres', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-urbana-barcelona');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'En quin any es van celebrar les primeres eleccions generals democràtiques després de la dictadura franquista?', 'Rèplica de la p. 49. Es van celebrar el 15 de juny de 1977.', 'gubexamen_2023', (select id from public.topics where slug = 'gubexamen-2023'), 1, 'ca', true, (select id from public.sources where url = 'https://web.gencat.cat/ca/generalitat/qui-som/historia-generalitat'), 'GUB 2023 p. 49 · Eleccions de 1977', 'celebrades el 15 de juny de 1977', null, '2aeade994063f6dc6c45b036decdb27c47cc085b7927c22ec56d77513e86e6c1', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '2aeade994063f6dc6c45b036decdb27c47cc085b7927c22ec56d77513e86e6c1')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', '1975', false), ('B', '1978', false), ('C', '1977', true), ('D', '1982', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-urbana-barcelona');
-- Lote gubexamen-2023-cultural-govcreu26-v1 (1 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('El Govern distingeix amb la Creu de Sant Jordi 20 persones i 10 entitats (nota de premsa, 14/04/2026)', 'https://govern.cat/gov/notes-premsa/812364/govern-distingeix-creu-sant-jordi-20-persones-10-entitats', 'web_oficial'::public.source_kind, 'Generalitat de Catalunya, Govern.cat', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('gubexamen-2023', 'Rèplica de l''examen d''agent de la Guàrdia Urbana 2023 (part de temari)') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('guardia-urbana-barcelona') and t.slug = 'gubexamen-2023' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'En quin àmbit ha destacat Joan Fontcuberta, Creu de Sant Jordi 2026?', 'Rèplica de la p. 56 (personalitat de la cultura; substitueix la mort del dibuixant Ibáñez per un fet recent). 14 d''abril de 2026.', 'gubexamen_2023', (select id from public.topics where slug = 'gubexamen-2023'), 2, 'ca', true, (select id from public.sources where url = 'https://govern.cat/gov/notes-premsa/812364/govern-distingeix-creu-sant-jordi-20-persones-10-entitats'), 'GUB 2023 p. 56 · Joan Fontcuberta', 'Joan Fontcuberta i Villà. Artista i teòric de la imatge: per la seva trajectòria en el camp de la fotografia i la reflexió crítica sobre la imatge.', null, '74d6c6ba424130b1cd5b258d15f7ba5b3bf8989d78dfad1a30e183a2a7e4e176', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '74d6c6ba424130b1cd5b258d15f7ba5b3bf8989d78dfad1a30e183a2a7e4e176')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'La gastronomia', false), ('B', 'La fotografia i la reflexió crítica sobre la imatge', true), ('C', 'La literatura infantil i juvenil', false), ('D', 'El periodisme radiofònic', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-urbana-barcelona');
-- Lote gubexamen-2023-cultural-govpnc26-v1 (1 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('President Illa: "Com Pau Casals, enguany podem dir al món un ''som catalans'' col·lectiu..." (Premis Nacionals de Cultura 2026, nota de premsa, 09/10/2026)', 'https://govern.cat/salapremsa/notes-premsa/878952/president-illa-com-pau-casals-enguany-dir-al-mon-som-catalans-collectiu-tothom-shi-senti-representat-part-activa', 'web_oficial'::public.source_kind, 'Generalitat de Catalunya, Govern.cat', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('gubexamen-2023', 'Rèplica de l''examen d''agent de la Guàrdia Urbana 2023 (part de temari)') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('guardia-urbana-barcelona') and t.slug = 'gubexamen-2023' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Per quina trajectòria va rebre Pol Guasch el Premi Nacional de Cultura 2026?', 'Rèplica de la p. 57 (actualitat cultural; substitueix la pel·lícula «Oppenheimer»). 9 d''octubre de 2026.', 'gubexamen_2023', (select id from public.topics where slug = 'gubexamen-2023'), 3, 'ca', true, (select id from public.sources where url = 'https://govern.cat/salapremsa/notes-premsa/878952/president-illa-com-pau-casals-enguany-dir-al-mon-som-catalans-collectiu-tothom-shi-senti-representat-part-activa'), 'GUB 2023 p. 57 · Pol Guasch', 'Pol Guasch, Premi Nacional de Cultura per la solidesa de la seva incipient trajectòria literària, que abraça des de la poesia fins a la narrativa', null, '0c508fdd372f7f67088b89aa096c14b62e8b6846a13d7f76b119c5a226a73a41', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '0c508fdd372f7f67088b89aa096c14b62e8b6846a13d7f76b119c5a226a73a41')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Per la direcció escènica de grans òperes', false), ('B', 'Per la seva carrera com a actor de circ i cinema', false), ('C', 'Per la seva tasca editorial', false), ('D', 'Per la seva incipient trajectòria literària, de la poesia a la narrativa', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-urbana-barcelona');
-- Lote gubexamen-2023-cultural-govpress26-v1 (1 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Els pressupostos de la Generalitat per al 2026 creixen un 22,8% respecte als darrers aprovats i acceleren la inversió amb fons propis (nota de premsa, 27/02/2026)', 'https://govern.cat/salapremsa/notes-premsa/795676/pressupostos-generalitat-al-2026-creixen-228-percent-respecte-als-darrers-aprovats-acceleren-inversio-fons-propis', 'web_oficial'::public.source_kind, 'Generalitat de Catalunya, Govern.cat', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('gubexamen-2023', 'Rèplica de l''examen d''agent de la Guàrdia Urbana 2023 (part de temari)') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('guardia-urbana-barcelona') and t.slug = 'gubexamen-2023' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Qui és la consellera d''Economia i Finances de la Generalitat que va presentar els pressupostos de 2026?', 'Rèplica de la p. 54 (consellera del Govern; actualitzat al Govern de 2026). 27 de febrer de 2026.', 'gubexamen_2023', (select id from public.topics where slug = 'gubexamen-2023'), 2, 'ca', true, (select id from public.sources where url = 'https://govern.cat/salapremsa/notes-premsa/795676/pressupostos-generalitat-al-2026-creixen-228-percent-respecte-als-darrers-aprovats-acceleren-inversio-fons-propis'), 'GUB 2023 p. 54 · Consellera d''Economia', 'La consellera d''Economia i Finances, Alícia Romero, i el president del Parlament, Josep Rull', null, '13229554541f6dd7c6969258b0c83e5f4f695246bbc590d1e426f340d9b2ef66', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '13229554541f6dd7c6969258b0c83e5f4f695246bbc590d1e426f340d9b2ef66')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Alícia Romero', true), ('B', 'Natàlia Garriga', false), ('C', 'Esther Niubó', false), ('D', 'Sílvia Paneque', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-urbana-barcelona');
-- Lote gubexamen-2023-cultural-idescat-v1 (1 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Anuari estadístic de Catalunya i El municipi en xifres (Institut d''Estadística de Catalunya)', 'https://www.idescat.cat/indicadors/?id=aec&lang=ca', 'web_oficial'::public.source_kind, 'Institut d''Estadística de Catalunya (Idescat)', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('gubexamen-2023', 'Rèplica de l''examen d''agent de la Guàrdia Urbana 2023 (part de temari)') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('guardia-urbana-barcelona') and t.slug = 'gubexamen-2023' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Què volen dir les sigles PIB, indicador bàsic de l''economia que publica Idescat?', 'Rèplica de la p. 42 (sigla econòmica; substitueix la TAE de l''examen per una sigla econòmica amb font oficial). El PIB de Catalunya va créixer un 2,9% interanual el tercer trimestre de 2026.', 'gubexamen_2023', (select id from public.topics where slug = 'gubexamen-2023'), 1, 'ca', true, (select id from public.sources where url = 'https://www.idescat.cat/indicadors/?id=aec&lang=ca'), 'GUB 2023 p. 42 · Sigla PIB', 'El producte interior brut de Catalunya registra una variació interanual del 2,9%', null, '4d0939a486202041608ce0746b89c105f48c3320d9e3843faac79efbfc26011f', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '4d0939a486202041608ce0746b89c105f48c3320d9e3843faac79efbfc26011f')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Producte interior brut', true), ('B', 'Pressupost d''inversió bàsica', false), ('C', 'Preu índex del benestar', false), ('D', 'Pla d''inversió de béns', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-urbana-barcelona');
-- Lote gubexamen-2023-cultural-nobel-v1 (2 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('All Nobel Prizes 2026 (Nobel Foundation)', 'https://www.nobelprize.org/all-nobel-prizes-2026/', 'web_oficial'::public.source_kind, 'Nobel Foundation / Nobel Prize Outreach', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('gubexamen-2023', 'Rèplica de l''examen d''agent de la Guàrdia Urbana 2023 (part de temari)') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('guardia-urbana-barcelona') and t.slug = 'gubexamen-2023' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons el Comitè Nobel, què ha demostrat Navi Pillay, premi Nobel de la pau 2026, en casos històrics de tribunals internacionals?', 'Rèplica de la p. 62 (Nobel de la pau 2023, actualitzat al de 2026). Octubre de 2026.', 'gubexamen_2023', (select id from public.topics where slug = 'gubexamen-2023'), 3, 'ca', true, (select id from public.sources where url = 'https://www.nobelprize.org/all-nobel-prizes-2026/'), 'GUB 2023 p. 62 · Navi Pillay', 'In historic international court cases, Navi Pillay has shown that legal measures can help prevent acts of war and violence.', null, '43df83a6b83dfb52add0f464b29520045a9b1951560fe7561918948a1acfe8e3', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '43df83a6b83dfb52add0f464b29520045a9b1951560fe7561918948a1acfe8e3')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Que les mesures legals poden ajudar a prevenir actes de guerra i violència', true), ('B', 'Que les sancions econòmiques són més eficaces que la diplomàcia', false), ('C', 'Que les armes nuclears no s''han de tornar a fer servir', false), ('D', 'Que les eleccions lliures garanteixen la pau', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-urbana-barcelona');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Quin medi va utilitzar Francis Halzen, premi Nobel de física 2026, per detectar neutrins?', 'Rèplica de la p. 64 (actualitat tecnològica; substitueix l''empresa de ChatGPT per una fita científica recent). Octubre de 2026.', 'gubexamen_2023', (select id from public.topics where slug = 'gubexamen-2023'), 3, 'ca', true, (select id from public.sources where url = 'https://www.nobelprize.org/all-nobel-prizes-2026/'), 'GUB 2023 p. 64 · IceCube', 'Francis Halzen realised that ice at the South Pole could be used to track particles known as neutrinos.', null, '2de4e27ab68231582ef27ff0a6b61fd5bbe0070af64a560fc5c7ec9d26342a3f', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '2de4e27ab68231582ef27ff0a6b61fd5bbe0070af64a560fc5c7ec9d26342a3f')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'L''aigua del mar Mediterrani', false), ('B', 'Un túnel sota els Alps', false), ('C', 'El gel del pol Sud', true), ('D', 'Un satèl·lit en òrbita', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-urbana-barcelona');
-- Lote gubexamen-2023-cultural-nobelhist-v1 (1 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('NobelPrize.org: All Nobel Prizes 2025 i fitxes de premiats (Literature 1956, 1977, 1982, 1989, 2010, 2023-2024; Peace 2023-2024)', 'https://www.nobelprize.org/all-nobel-prizes-2025/', 'web_oficial'::public.source_kind, 'Nobel Foundation / Nobel Prize Outreach', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('gubexamen-2023', 'Rèplica de l''examen d''agent de la Guàrdia Urbana 2023 (part de temari)') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('guardia-urbana-barcelona') and t.slug = 'gubexamen-2023' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Quin premi Nobel de literatura (1982) era colombià?', 'Rèplica de la p. 51 (autor de Cien años de soledad). García Márquez va néixer a Aracataca (Colòmbia).', 'gubexamen_2023', (select id from public.topics where slug = 'gubexamen-2023'), 1, 'ca', true, (select id from public.sources where url = 'https://www.nobelprize.org/all-nobel-prizes-2025/'), 'GUB 2023 p. 51 · García Márquez', 'Gabriel García Márquez Nobel Prize in Literature 1982 Born: 6 March 1927, Aracataca, Colombia', null, '6d26fb959ac83809f28e46aa2c58775f9cfa50199dc00125425c7aed427d57a7', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '6d26fb959ac83809f28e46aa2c58775f9cfa50199dc00125425c7aed427d57a7')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Mario Vargas Llosa', false), ('B', 'Camilo José Cela', false), ('C', 'Juan Ramón Jiménez', false), ('D', 'Gabriel García Márquez', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-urbana-barcelona');
-- Lote gubexamen-2023-cultural-onu-v1 (1 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('United Nations: About Us, UN Charter, Main Bodies i Selection and Appointment of the Next Secretary-General', 'https://www.un.org/en/about-us', 'web_oficial'::public.source_kind, 'United Nations', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('gubexamen-2023', 'Rèplica de l''examen d''agent de la Guàrdia Urbana 2023 (part de temari)') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('guardia-urbana-barcelona') and t.slug = 'gubexamen-2023' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Quina expresidenta xilena va retirar la candidatura a secretària general de l''ONU el 21 de setembre de 2026?', 'Rèplica de la reserva 70 (fet internacional; substitueix el terratrèmol del Marroc de 2023). Nominada el 2 de febrer de 2026 i retirada el 21 de setembre de 2026.', 'gubexamen_2023', (select id from public.topics where slug = 'gubexamen-2023'), 3, 'ca', true, (select id from public.sources where url = 'https://www.un.org/en/about-us'), 'GUB 2023 p. 70 (reserva) · Selecció del secretari general de l''ONU', 'Michelle Bachelet Jeria (nominated 2 February 2026; withdrawn 21 September 2026)', '«Expresidenta xilena» no surt a la font; és coneixement general que el revisor pot treure si cal.', '3757b882eccadacf77b67d6c1303698cd959404091450d60d552655660e1f291', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '3757b882eccadacf77b67d6c1303698cd959404091450d60d552655660e1f291')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'María Corina Machado', false), ('B', 'Navi Pillay', false), ('C', 'Michelle Bachelet', true), ('D', 'Narges Mohammadi', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-urbana-barcelona');
-- Lote gubexamen-2023-cultural-patrimoni-v1 (3 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Patrimoni Cultural de la Generalitat de Catalunya: col·leccions (Jacint Verdaguer, Salvador Espriu, Joan Maragall, Josep Pla) i històries del patrimoni', 'https://patrimoni.gencat.cat/ca/coleccio/jacint-verdaguer', 'web_oficial'::public.source_kind, 'Generalitat de Catalunya, Departament de Cultura (Patrimoni Cultural)', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('gubexamen-2023', 'Rèplica de l''examen d''agent de la Guàrdia Urbana 2023 (part de temari)') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('guardia-urbana-barcelona') and t.slug = 'gubexamen-2023' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Quin poeta va mitificar Arenys de Mar amb el nom de Sinera?', 'Rèplica de la p. 44 (literatura catalana: noms i pseudònims). Sinera és Arenys al revés; el primer llibre d''Espriu és Cementiri de Sinera (1946).', 'gubexamen_2023', (select id from public.topics where slug = 'gubexamen-2023'), 2, 'ca', true, (select id from public.sources where url = 'https://patrimoni.gencat.cat/ca/coleccio/jacint-verdaguer'), 'GUB 2023 p. 44 · Espriu i Sinera', 'apareix mitificat en la seva obra com a Sinera (Arenys al revés).', null, '05e7d0a0f0a7c717ac29df282bd27c4440d8c23bc7d5497e2ec7b1cd7588246a', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '05e7d0a0f0a7c717ac29df282bd27c4440d8c23bc7d5497e2ec7b1cd7588246a')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Joan Oliver (Pere Quart)', false), ('B', 'Josep Pla', false), ('C', 'Joan Maragall', false), ('D', 'Salvador Espriu', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-urbana-barcelona');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Quina d''aquestes obres és de Jacint Verdaguer?', 'Rèplica de la p. 47 (autor d''una obra cabdal de la literatura catalana). Canigó (1886) és de Verdaguer; La pell de brau, d''Espriu; Mecanoscrit, de Pedrolo; Tirant, de Martorell.', 'gubexamen_2023', (select id from public.topics where slug = 'gubexamen-2023'), 1, 'ca', true, (select id from public.sources where url = 'https://patrimoni.gencat.cat/ca/coleccio/jacint-verdaguer'), 'GUB 2023 p. 47 · Verdaguer', 'L’Atlàntida (1877) i Canigó (1886), l’expressió més genuïna de la seva producció.', null, 'b3db7de1b74ddaf18e4f590ac3d7e3cc5f31fdc86e3d64595187aed96b3fe56d', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'b3db7de1b74ddaf18e4f590ac3d7e3cc5f31fdc86e3d64595187aed96b3fe56d')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Canigó', true), ('B', 'La pell de brau', false), ('C', 'Mecanoscrit del segon origen', false), ('D', 'Tirant lo Blanc', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-urbana-barcelona');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Qui és Plaerdemavida, en la novel·la Tirant lo Blanc?', 'Rèplica de la p. 52 (personatge literari; substitueix el detectiu de Vázquez Montalbán per un personatge de la literatura catalana amb font oficial).', 'gubexamen_2023', (select id from public.topics where slug = 'gubexamen-2023'), 2, 'ca', true, (select id from public.sources where url = 'https://patrimoni.gencat.cat/ca/coleccio/jacint-verdaguer'), 'GUB 2023 p. 52 · Personatges del Tirant', 'Carmesina es hija del emperador, y su doncella Plaerdemavida ayudará a Tirant Lo Blanc a conquistarla.', null, '0e790ef17c6a3015426e5ca960b178c3bf2668189c6aa3619ae36f85abc0551a', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '0e790ef17c6a3015426e5ca960b178c3bf2668189c6aa3619ae36f85abc0551a')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'La mare de Tirant', false), ('B', 'L''emperadriu de Constantinoble', false), ('C', 'La reina d''Anglaterra', false), ('D', 'La donzella de la princesa Carmesina', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-urbana-barcelona');
-- Lote gubexamen-2023-cultural-ue-v1 (2 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Portal oficial de la Unión Europea: países, historia, euro e instituciones', 'https://european-union.europa.eu/index_es', 'web_oficial'::public.source_kind, 'Unión Europea', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('gubexamen-2023', 'Rèplica de l''examen d''agent de la Guàrdia Urbana 2023 (part de temari)') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('guardia-urbana-barcelona') and t.slug = 'gubexamen-2023' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Quants estats membres té la Unió Europea?', 'Rèplica de la p. 61. Són 27 des de la sortida del Regne Unit; 21 tenen l''euro.', 'gubexamen_2023', (select id from public.topics where slug = 'gubexamen-2023'), 1, 'ca', true, (select id from public.sources where url = 'https://european-union.europa.eu/index_es'), 'GUB 2023 p. 61 · Estats membres de la UE', 'Hoy en día, el euro (€) es la moneda oficial de 21 de los 27 países de la UE', null, '004b039e9f6c6c82444926b2c7f2573f35a8610f3e0b24d374c148345a59b07d', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '004b039e9f6c6c82444926b2c7f2573f35a8610f3e0b24d374c148345a59b07d')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', '28', false), ('B', '25', false), ('C', '27', true), ('D', '21', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-urbana-barcelona');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Qui presideix el Consell Europeu, que defineix les orientacions polítiques generals de la UE?', 'Rèplica de la p. 63 (cap d''una institució internacional; substitueix el president d''Ucraïna per un càrrec de la UE amb font oficial).', 'gubexamen_2023', (select id from public.topics where slug = 'gubexamen-2023'), 2, 'ca', true, (select id from public.sources where url = 'https://european-union.europa.eu/index_es'), 'GUB 2023 p. 63 · President del Consell Europeu', 'Presidente: António Costa', null, '72601f181c09681e4fb2600c89b097131764f72a08f98e66fcd73cd68e1075a1', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '72601f181c09681e4fb2600c89b097131764f72a08f98e66fcd73cd68e1075a1')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Ursula von der Leyen', false), ('B', 'António Costa', true), ('C', 'Roberta Metsola', false), ('D', 'Charles Michel', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-urbana-barcelona');
-- Lote gubexamen-2025-cultural-bcnarq-v1 (1 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Barcelona 2026, Capital Mundial de l’Arquitectura', 'https://ajuntament.barcelona.cat/urbanisme-accio-climatica-mobilitat-pla-barris-serveis-urbans/ca/news/barcelona-2026-capital-mundial-de-larquitectura-1377921', 'web_oficial'::public.source_kind, 'Ajuntament de Barcelona', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('gubexamen-2025', 'Rèplica de l''examen d''agent de la Guàrdia Urbana 2025 (part de temari)') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('guardia-urbana-barcelona') and t.slug = 'gubexamen-2025' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'En quants districtes de Barcelona hi ha activitats de la Capital Mundial de l''Arquitectura 2026?', 'Rèplica de la p. 78 (substitueix la reurbanització de la Via Laietana per un projecte urbà recent). 2026: activitats de Santa Eulàlia a Santa Llúcia als deu districtes.', 'gubexamen_2025', (select id from public.topics where slug = 'gubexamen-2025'), 2, 'ca', true, (select id from public.sources where url = 'https://ajuntament.barcelona.cat/urbanisme-accio-climatica-mobilitat-pla-barris-serveis-urbans/ca/news/barcelona-2026-capital-mundial-de-larquitectura-1377921'), 'GUB 2025 p. 78 · Capital Mundial de l''Arquitectura', 'Durant deu mesos, des de Santa Eulàlia fins a Santa Llúcia, hi haurà activitats als deu districtes', null, '194fa624cc4c05daff9f4854bb4431724ddd8c555526bf242c3fecda02011fe4', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '194fa624cc4c05daff9f4854bb4431724ddd8c555526bf242c3fecda02011fe4')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'En els deu districtes', true), ('B', 'Només a Ciutat Vella i l''Eixample', false), ('C', 'En cinc districtes', false), ('D', 'Només a Sant Martí', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-urbana-barcelona');
-- Lote gubexamen-2025-cultural-bcnpapa26-v1 (2 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Barcelona acollirà aquest juny la visita del Papa Lleó XIV (29/05/2026)', 'https://ajuntament.barcelona.cat/oficina-afers-religiosos/ca/noticies/barcelona-acollira-aquest-juny-la-visita-del-papa-lleo-xiv-1640185', 'web_oficial'::public.source_kind, 'Ajuntament de Barcelona, Oficina d''Afers Religiosos', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('gubexamen-2025', 'Rèplica de l''examen d''agent de la Guàrdia Urbana 2025 (part de temari)') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('guardia-urbana-barcelona') and t.slug = 'gubexamen-2025' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Quina torre de la Sagrada Família es va inaugurar durant la visita del papa Lleó XIV a Barcelona, el juny de 2026?', 'Rèplica de la p. 68 (substitueix la reobertura de Notre-Dame, desembre de 2024, per la inauguració d''un gran temple). 9-10 de juny de 2026.', 'gubexamen_2025', (select id from public.topics where slug = 'gubexamen-2025'), 1, 'ca', true, (select id from public.sources where url = 'https://ajuntament.barcelona.cat/oficina-afers-religiosos/ca/noticies/barcelona-acollira-aquest-juny-la-visita-del-papa-lleo-xiv-1640185'), 'GUB 2025 p. 68 · Torre de Jesucrist', 'tindrà com a moment central la celebració d’una missa solemne a la basílica de la Sagrada Família, així com la inauguració de la torre de Jesucrist', null, '5cefd2571b70bb3968dd5919722a5c84e7079e726f4ffe68707a1cc87c09a70e', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '5cefd2571b70bb3968dd5919722a5c84e7079e726f4ffe68707a1cc87c09a70e')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'La torre de Jesucrist', true), ('B', 'La torre de Maria', false), ('C', 'La torre de Sant Lluc', false), ('D', 'La torre de Sant Marc', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-urbana-barcelona');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Quina comunitat religiosa va compartir una pregària amb el papa Lleó XIV en la commemoració del mil·lenari del monestir de Montserrat?', 'Rèplica de la p. 72 (mil·lenari de Montserrat). Juny de 2026.', 'gubexamen_2025', (select id from public.topics where slug = 'gubexamen-2025'), 2, 'ca', true, (select id from public.sources where url = 'https://ajuntament.barcelona.cat/oficina-afers-religiosos/ca/noticies/barcelona-acollira-aquest-juny-la-visita-del-papa-lleo-xiv-1640185'), 'GUB 2025 p. 72 · Mil·lenari de Montserrat', 'en la commemoració del mil·lenari del monestir, on compartirà una pregària amb la comunitat benedictina.', null, 'f860db42d59af61d84f9ac51dc3e320f6f68b29d231adc75f050a46ba2a8eca3', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'f860db42d59af61d84f9ac51dc3e320f6f68b29d231adc75f050a46ba2a8eca3')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'La comunitat cistercenca', false), ('B', 'La comunitat benedictina', true), ('C', 'La comunitat franciscana', false), ('D', 'La comunitat jesuïta', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-urbana-barcelona');
-- Lote gubexamen-2025-cultural-bcnparkg-v1 (1 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('El Park Güell presenta una exposició de 900 fotografies que recorren un segle de la seva història (05/11/2026)', 'https://ajuntament.barcelona.cat/premsa/2026/11/05/el-park-guell-presenta-una-exposicio-de-900-fotografies-que-recorren-un-segle-de-la-seva-historia/', 'web_oficial'::public.source_kind, 'Ajuntament de Barcelona', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('gubexamen-2025', 'Rèplica de l''examen d''agent de la Guàrdia Urbana 2025 (part de temari)') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('guardia-urbana-barcelona') and t.slug = 'gubexamen-2025' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Quin espai de Barcelona celebra el 2026 els cent anys com a parc públic?', 'Rèplica de la p. 77 (substitueix el centenari del Metro per un altre centenari barceloní). Novembre de 2026.', 'gubexamen_2025', (select id from public.topics where slug = 'gubexamen-2025'), 2, 'ca', true, (select id from public.sources where url = 'https://ajuntament.barcelona.cat/premsa/2026/11/05/el-park-guell-presenta-una-exposicio-de-900-fotografies-que-recorren-un-segle-de-la-seva-historia/'), 'GUB 2025 p. 77 · Centenari del Park Güell com a parc públic', 'forma part de la commemoració dels cent anys del Park Güell com a parc públic', null, '5710c96ba039e92423b4f181b39d2d4a60e735b8381bd3550fe524f6c8260c6b', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '5710c96ba039e92423b4f181b39d2d4a60e735b8381bd3550fe524f6c8260c6b')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El parc de la Ciutadella', false), ('B', 'El parc de Montjuïc', false), ('C', 'El Park Güell', true), ('D', 'El parc del Laberint d''Horta', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-urbana-barcelona');
-- Lote gubexamen-2025-cultural-bcntour26-v1 (2 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('La Festa Major del Tour omplirà Barcelona amb més de 60 propostes (15/05/2026) i Catalunya i Barcelona s’il·luminen de groc (26/03/2026)', 'https://ajuntament.barcelona.cat/premsa/2026/05/15/la-festa-major-del-tour-omplira-barcelona-amb-mes-de-60-propostes-per-celebrar-el-tour-de-franca/', 'web_oficial'::public.source_kind, 'Ajuntament de Barcelona', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('gubexamen-2025', 'Rèplica de l''examen d''agent de la Guàrdia Urbana 2025 (part de temari)') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('guardia-urbana-barcelona') and t.slug = 'gubexamen-2025' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Quin gran esdeveniment esportiu va sortir de Barcelona l''estiu de 2026?', 'Rèplica de la p. 70 (substitueix la Copa Amèrica de vela 2024 per l''esdeveniment esportiu internacional de 2026 a Barcelona). 26 de juny - 5 de juliol de 2026: Festa Major del Tour.', 'gubexamen_2025', (select id from public.topics where slug = 'gubexamen-2025'), 1, 'ca', true, (select id from public.sources where url = 'https://ajuntament.barcelona.cat/premsa/2026/05/15/la-festa-major-del-tour-omplira-barcelona-amb-mes-de-60-propostes-per-celebrar-el-tour-de-franca/'), 'GUB 2025 p. 70 · Grand Départ del Tour 2026', 'amb motiu de la sortida del Tour de França 2026.', null, '3b07d60ff9fef449251f5b1d6fc3917d862c2ea332341ec9a632f7669d51424e', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '3b07d60ff9fef449251f5b1d6fc3917d862c2ea332341ec9a632f7669d51424e')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'La Copa Amèrica de vela', false), ('B', 'La Volta a Espanya', false), ('C', 'El Giro d''Itàlia', false), ('D', 'El Tour de França', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-urbana-barcelona');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Quin dia va arribar a Montjuïc la segona etapa del Tour de França 2026, que va tancar la Festa Major del Tour?', 'Rèplica de la p. 71 (substitueix la retirada de Rafa Nadal per un fet esportiu de 2026). 5 de juliol de 2026.', 'gubexamen_2025', (select id from public.topics where slug = 'gubexamen-2025'), 2, 'ca', true, (select id from public.sources where url = 'https://ajuntament.barcelona.cat/premsa/2026/05/15/la-festa-major-del-tour-omplira-barcelona-amb-mes-de-60-propostes-per-celebrar-el-tour-de-franca/'), 'GUB 2025 p. 71 · Tour 2026, arribada a Montjuïc', 'El 26 de juny arrencaran les primeres activitats festives que s’allargaran fins el 5 de juliol amb l’arribada de la segona etapa de la competició ciclista a Montjuïc', null, '2ee5f51665a94f1833c37ffbd3d99482ea2ef464dc63c00b4ed5245fd33afdbd', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '2ee5f51665a94f1833c37ffbd3d99482ea2ef464dc63c00b4ed5245fd33afdbd')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El 5 de juliol', true), ('B', 'El 26 de juny', false), ('C', 'El 24 de setembre', false), ('D', 'L''11 de setembre', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-urbana-barcelona');
-- Lote gubexamen-2025-cultural-cervantes-v1 (1 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Gonzalo Celorio, Premio Cervantes 2025 (03/11/2025)', 'https://www.cultura.gob.es/actualidad/2025/11/251103-premio-cervantes-2025.html', 'web_oficial'::public.source_kind, 'Ministerio de Cultura', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('gubexamen-2025', 'Rèplica de l''examen d''agent de la Guàrdia Urbana 2025 (part de temari)') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('guardia-urbana-barcelona') and t.slug = 'gubexamen-2025' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Quin escriptor mexicà, nascut el 1948, va guanyar el Premi Cervantes 2025?', 'Rèplica de la p. 65 (substitueix el Premi Planeta 2024 de l''examen per un premi literari més recent). 3 de novembre de 2025: Celorio, Premi Cervantes, dotat amb 125.000 euros.', 'gubexamen_2025', (select id from public.topics where slug = 'gubexamen-2025'), 2, 'ca', true, (select id from public.sources where url = 'https://www.cultura.gob.es/actualidad/2025/11/251103-premio-cervantes-2025.html'), 'GUB 2025 p. 65 · Premi Cervantes 2025', 'Gonzalo Celorio nació en la Ciudad de México en 1948.', null, '989810c6f43efb967c89ac063b84d3cecc211ab659405ffdf777ddb1e44c9e7c', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '989810c6f43efb967c89ac063b84d3cecc211ab659405ffdf777ddb1e44c9e7c')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Álvaro Pombo', false), ('B', 'Juan Villoro', false), ('C', 'Gonzalo Celorio', true), ('D', 'Luis Mateo Díez', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-urbana-barcelona');
-- Lote gubexamen-2025-cultural-cop31-v1 (1 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('UN Climate Change Conference - Antalya, November 2026 (COP31)', 'https://unfccc.int/cop31', 'web_oficial'::public.source_kind, 'United Nations Framework Convention on Climate Change (UNFCCC)', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('gubexamen-2025', 'Rèplica de l''examen d''agent de la Guàrdia Urbana 2025 (part de temari)') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('guardia-urbana-barcelona') and t.slug = 'gubexamen-2025' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Quin país acull la COP31, la conferència del clima de l''ONU de novembre de 2026?', 'Rèplica de la reserva 87 (substitueix la caiguda d''al-Assad per un fet internacional recent). 9-20 de novembre de 2026, Antalya.', 'gubexamen_2025', (select id from public.topics where slug = 'gubexamen-2025'), 2, 'ca', true, (select id from public.sources where url = 'https://unfccc.int/cop31'), 'GUB 2025 p. 87 (reserva) · COP31', 'Türkiye will host the Conference and Mr. Murat Kurum has been nominated as President of COP31 in Antalya.', null, 'a11f9f54529bbae92d129ece5be95474eee914a8818124361f0667d6ae760efe', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'a11f9f54529bbae92d129ece5be95474eee914a8818124361f0667d6ae760efe')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Austràlia', false), ('B', 'El Brasil', false), ('C', 'Egipte', false), ('D', 'Türkiye (Turquia)', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-urbana-barcelona');
-- Lote gubexamen-2025-cultural-diec-v1 (14 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Diccionari de la llengua catalana, 2a edició (DIEC2), Institut d''Estudis Catalans', 'https://dlc.iec.cat/', 'web_oficial'::public.source_kind, 'Institut d''Estudis Catalans', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('gubexamen-2025', 'Rèplica de l''examen d''agent de la Guàrdia Urbana 2025 (part de temari)') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('guardia-urbana-barcelona') and t.slug = 'gubexamen-2025' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Com s''anomena allò que és relatiu o pertanyent al filòsof grec Plató, autor del mite de la caverna?', 'Rèplica de la p. 49 (filosofia: autor del mite de la caverna). Plató és l''autor del mite de la caverna; d''aquí l''adjectiu «platònic».', 'gubexamen_2025', (select id from public.topics where slug = 'gubexamen-2025'), 1, 'ca', true, (select id from public.sources where url = 'https://dlc.iec.cat/'), 'GUB 2025 p. 49 · Plató', 'platònic -a 1 1 adj. [FS] [LC] Relatiu o pertanyent al filòsof grec Plató, als platònics o al platonisme.', null, '37ce88a42b557b512035222525d7fa65c87b025ccc9e3f83017161d295e433ef', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '37ce88a42b557b512035222525d7fa65c87b025ccc9e3f83017161d295e433ef')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Aristotèlic', false), ('B', 'Socràtic', false), ('C', 'Platònic', true), ('D', 'Epicuri', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-urbana-barcelona');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'A quin gènere pertany Tirant lo Blanc, de Joanot Martorell, protagonitzat per un cavaller ideal?', 'Rèplica de la p. 50 (gènere del Tirant). És una novel·la cavalleresca: cavalleresc vol dir que té l''esperit de la cavalleria.', 'gubexamen_2025', (select id from public.topics where slug = 'gubexamen-2025'), 1, 'ca', true, (select id from public.sources where url = 'https://dlc.iec.cat/'), 'GUB 2025 p. 50 · Tirant lo Blanc, gènere', 'cavalleresc -a 3 adj. [FLL] [HIH] [LC] Que té el caràcter, les qualitats, del cavaller ideal, l’esperit de la cavalleria. Ideals cavallerescos.', null, '2211aa46c921216ec9e7e791901d5a598195bc56e007b0e1655ada65624b9815', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '2211aa46c921216ec9e7e791901d5a598195bc56e007b0e1655ada65624b9815')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Poesia trobadoresca', false), ('B', 'Teatre barroc', false), ('C', 'Crònica reial', false), ('D', 'Novel·la cavalleresca', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-urbana-barcelona');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Quina d''aquestes característiques NO correspon al clima continental?', 'Rèplica de la p. 52 (dominis climàtics, pregunta de «NO»). El clima continental es caracteritza per grans oscil·lacions tèrmiques, diürnes i anuals.', 'gubexamen_2025', (select id from public.topics where slug = 'gubexamen-2025'), 2, 'ca', true, (select id from public.sources where url = 'https://dlc.iec.cat/'), 'GUB 2025 p. 52 · Clima continental', 'clima continental Clima propi de l’interior dels grans continents, caracteritzat per grans oscil·lacions de la temperatura, tant diürnes com anuals.', null, '8d53c0bc463fbdbd2bf7ba265a27f1b3b60e7964e81db6a21f619f7baafc53e5', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '8d53c0bc463fbdbd2bf7ba265a27f1b3b60e7964e81db6a21f619f7baafc53e5')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Grans oscil·lacions de temperatura diürnes', false), ('B', 'Temperatures molt estables al llarg del dia i de l''any', true), ('C', 'Grans oscil·lacions de temperatura anuals', false), ('D', 'És propi de l''interior dels grans continents', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-urbana-barcelona');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Quina capa de l''atmosfera està en contacte amb la superfície terrestre?', 'Rèplica de la p. 53. La troposfera va de la superfície fins a la tropopausa (uns 10-17 km).', 'gubexamen_2025', (select id from public.topics where slug = 'gubexamen-2025'), 1, 'ca', true, (select id from public.sources where url = 'https://dlc.iec.cat/'), 'GUB 2025 p. 53 · Troposfera', 'troposfera f. [ME] Capa de l’atmosfera terrestre situada entre la superfície de la Terra i la tropopausa', null, '30b840bc096294d9af283f7ac69d588ad927597a6e02c7c87f4a725c7d11962a', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '30b840bc096294d9af283f7ac69d588ad927597a6e02c7c87f4a725c7d11962a')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'L''estratosfera', false), ('B', 'La troposfera', true), ('C', 'La termosfera', false), ('D', 'L''exosfera', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-urbana-barcelona');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Què afirma la teoria de la tectònica de plaques?', 'Rèplica de la p. 54.', 'gubexamen_2025', (select id from public.topics where slug = 'gubexamen-2025'), 2, 'ca', true, (select id from public.sources where url = 'https://dlc.iec.cat/'), 'GUB 2025 p. 54 · Tectònica de plaques', 'tectònica de plaques Teoria segons la qual la litosfera terrestre és dividida en un nombre reduït de plaques rígides que es mouen amb independència les unes de les', null, '0d43d784555baebe7bf553b79a9227a4883fa4796c3d236e7d2fd498f1914ef5', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '0d43d784555baebe7bf553b79a9227a4883fa4796c3d236e7d2fd498f1914ef5')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Que els continents són fixos i les muntanyes es formen per refredament de la Terra', false), ('B', 'Que l''escorça terrestre és una única placa contínua', false), ('C', 'Que la litosfera terrestre està dividida en un nombre reduït de plaques rígides que es mouen amb independència', true), ('D', 'Que els terratrèmols són causats per la gravetat de la Lluna', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-urbana-barcelona');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Com es formen les estalactites?', 'Rèplica de la p. 55 (formació d''estalactites).', 'gubexamen_2025', (select id from public.topics where slug = 'gubexamen-2025'), 2, 'ca', true, (select id from public.sources where url = 'https://dlc.iec.cat/'), 'GUB 2025 p. 55 · Estalactites', 'estalactita f. [GL] [LC] Concreció generalment calcària i de forma cilíndrica, amb un canalicle paral·lel a l’eix longitudinal, originada per un degotall, que penja de la volta de les coves.', null, '9601d018975620e442022287b7d85c8aad21fbe87665ceea294de5e3f5cbefd6', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '9601d018975620e442022287b7d85c8aad21fbe87665ceea294de5e3f5cbefd6')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Per un degotall que diposita una concreció generalment calcària que penja de la volta de les coves', true), ('B', 'Per l''acció del vent sobre les roques del sostre de la cova', false), ('C', 'Per la solidificació del magma dins de la cova', false), ('D', 'Per l''acumulació de gel als avencs d''alta muntanya', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-urbana-barcelona');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Quin d''aquests processos NO forma part del cicle de l''aigua?', 'Rèplica de la p. 56 (cicle de l''aigua, pregunta de «NO»). La subducció és l''enfonsament d''una placa litosfèrica sota una altra; no és un canvi d''estat de l''aigua.', 'gubexamen_2025', (select id from public.topics where slug = 'gubexamen-2025'), 2, 'ca', true, (select id from public.sources where url = 'https://dlc.iec.cat/'), 'GUB 2025 p. 56 · Cicle de l''aigua', 'subducció f. [GL] Enfonsament de gran amplitud d’una placa litosfèrica sota d’una altra.', null, '9e5f51ea0dc2d3b1d99e47be07ad2eab5480cf5e55f9a5c49f342b18ea2ba332', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '9e5f51ea0dc2d3b1d99e47be07ad2eab5480cf5e55f9a5c49f342b18ea2ba332')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'L''evaporació', false), ('B', 'La condensació', false), ('C', 'La solidificació', false), ('D', 'La subducció', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-urbana-barcelona');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'La DANA (depressió aïllada en nivells alts) és el que tradicionalment s''anomena...', 'Rèplica de la p. 57 (DANA). La gota freda és una depressió freda en altura que en superfície no es correspon amb una zona de baixes pressions; l''anticicló és una zona d''altes pressions.', 'gubexamen_2025', (select id from public.topics where slug = 'gubexamen-2025'), 2, 'ca', true, (select id from public.sources where url = 'https://dlc.iec.cat/'), 'GUB 2025 p. 57 · DANA i gota freda', 'gota freda Depressió atmosfèrica freda en altura les característiques de la qual s’originen en la circulació de la troposfera mitjana o alta', null, '8ecc4891c70a82ff3488602354cf470073b6141fbfd01b8801502c1802fa2f31', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '8ecc4891c70a82ff3488602354cf470073b6141fbfd01b8801502c1802fa2f31')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Anticicló', false), ('B', 'Marinada', false), ('C', 'Gota freda', true), ('D', 'Tramuntana', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-urbana-barcelona');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Què caracteritza químicament un àcid, que té un pH inferior a 7?', 'Rèplica de la p. 58 (pH). Un àcid dona protons (H+) a una base i, en neutralitzar-la, forma sals.', 'gubexamen_2025', (select id from public.topics where slug = 'gubexamen-2025'), 3, 'ca', true, (select id from public.sources where url = 'https://dlc.iec.cat/'), 'GUB 2025 p. 58 · Àcids i pH', 'àcid 4 1 m. [QU] Compost químic que és capaç de donar ions d’hidrogen o protons (H+) a una base', null, 'a47ade635a776d1b3618f0238915ff696b3d770877310461448231a513b97732', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'a47ade635a776d1b3618f0238915ff696b3d770877310461448231a513b97732')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Que és capaç de donar ions d''hidrogen (H+) a una base', true), ('B', 'Que és capaç d''acceptar ions d''hidrogen d''una altra substància', false), ('C', 'Que no reacciona amb les bases', false), ('D', 'Que és sempre un gas a temperatura ordinària', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-urbana-barcelona');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Com s''anomena la massa total de matèria viva d''un ecosistema, que es pot utilitzar com a font d''energia?', 'Rèplica de la p. 59 (medi ambient: petjada ecològica). Com que no tenim una definició oficial de petjada ecològica, es pregunta per un concepte del mateix bloc: la biomassa.', 'gubexamen_2025', (select id from public.topics where slug = 'gubexamen-2025'), 3, 'ca', true, (select id from public.sources where url = 'https://dlc.iec.cat/'), 'GUB 2025 p. 59 · Ecosistema i biomassa', 'biomassa f. [EG] Massa total de la matèria viva existent en una comunitat o en un ecosistema, a la qual sovint s’afegeix també matèria no viva, utilitzable com a font d’energia per a l’activitat orgànica.', 'Substitució de concepte per manca de font oficial carregada per a «petjada ecològica».', 'f7a5c97c1c3581af28d87e5cf55e0f9d74110cba8ac01c85862f89bba2d541a2', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'f7a5c97c1c3581af28d87e5cf55e0f9d74110cba8ac01c85862f89bba2d541a2')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Biodiversitat', false), ('B', 'Petjada ecològica', false), ('C', 'Biosfera', false), ('D', 'Biomassa', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-urbana-barcelona');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Un agent fa 6, 8, 7 i 11 serveis en quatre torns. Quina és la mitjana aritmètica de serveis per torn?', 'Rèplica de la p. 60 (mitjana aritmètica): (6 + 8 + 7 + 11) / 4 = 32 / 4 = 8.', 'gubexamen_2025', (select id from public.topics where slug = 'gubexamen-2025'), 1, 'ca', true, (select id from public.sources where url = 'https://dlc.iec.cat/'), 'GUB 2025 p. 60 · Mitjana aritmètica', 'mitjà2 -ana 2 adj. [LC] [MT] Que correspon a la mitjana aritmètica, s’aplica a noms que expressen quantitat.', null, 'd14447f1e5c8c8419fbd90470eab64dd59c8c08c8a1a5b43c8e61c0713d2a895', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'd14447f1e5c8c8419fbd90470eab64dd59c8c08c8a1a5b43c8e61c0713d2a895')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', '7', false), ('B', '8', true), ('C', '7,5', false), ('D', '32', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-urbana-barcelona');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Una escala de 5 m recolzada en una paret té el peu a 3 m de la paret. A quina altura toca la paret?', 'Rèplica de la p. 61 (geometria del triangle). Pel teorema de Pitàgores, 5² = 3² + h², 25 - 9 = 16, h = 4 m.', 'gubexamen_2025', (select id from public.topics where slug = 'gubexamen-2025'), 2, 'ca', true, (select id from public.sources where url = 'https://dlc.iec.cat/'), 'GUB 2025 p. 61 · Triangle rectangle', 'El quadrat de la hipotenusa és igual a la suma dels quadrats dels catets.', null, '94311ee17a0fa16b0f8121004c2900fdc42822b985c6afa12e4461325f5cfa29', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '94311ee17a0fa16b0f8121004c2900fdc42822b985c6afa12e4461325f5cfa29')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'A 2 m', false), ('B', 'A 8 m', false), ('C', 'A 4 m', true), ('D', 'A 15 m', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-urbana-barcelona');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Quina figura retòrica hi ha a «La seva mirada era un ganivet»?', 'Rèplica de la p. 63 (metàfora). S''expressa una cosa (una mirada dura) amb un mot que literalment en designa una altra que s''hi assembla.', 'gubexamen_2025', (select id from public.topics where slug = 'gubexamen-2025'), 2, 'ca', true, (select id from public.sources where url = 'https://dlc.iec.cat/'), 'GUB 2025 p. 63 · Metàfora', 'metàfora f. [FL] [FLL] [LC] Figura retòrica que consisteix a emprar un mot que expressa literalment una cosa per a expressar-ne una altra que té una certa semblança amb aquella.', null, '6450890206c31018372d23c99864c43a91bc3f46ab3dff843a5e115d959de588', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '6450890206c31018372d23c99864c43a91bc3f46ab3dff843a5e115d959de588')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Al·literació', false), ('B', 'Metàfora', true), ('C', 'Onomatopeia', false), ('D', 'Hipèrbaton', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-urbana-barcelona');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Quina propietat diu que 7 + 2 = 2 + 7?', 'Rèplica de la p. 64. En una operació commutativa l''ordre dels elements no canvia el resultat.', 'gubexamen_2025', (select id from public.topics where slug = 'gubexamen-2025'), 1, 'ca', true, (select id from public.sources where url = 'https://dlc.iec.cat/'), 'GUB 2025 p. 64 · Propietat commutativa', 'La suma i el producte de nombres reals són commutatius.', null, '99ee1b01a69731bb40010c9e25f0a485b9e0fb18f8f357606084950816a531da', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '99ee1b01a69731bb40010c9e25f0a485b9e0fb18f8f357606084950816a531da')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'L''associativa', false), ('B', 'La distributiva', false), ('C', 'La de l''element invers', false), ('D', 'La commutativa', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-urbana-barcelona');
-- Lote gubexamen-2025-cultural-genhist-v1 (3 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Història de la Generalitat (Diputació del General, Nova Planta i Generalitat contemporània)', 'https://web.gencat.cat/ca/generalitat/qui-som/historia-generalitat', 'web_oficial'::public.source_kind, 'Generalitat de Catalunya', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('gubexamen-2025', 'Rèplica de l''examen d''agent de la Guàrdia Urbana 2025 (part de temari)') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('guardia-urbana-barcelona') and t.slug = 'gubexamen-2025' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Què va passar a Barcelona l''11 de setembre de 1714, data que commemora la Diada?', 'Rèplica de la p. 62. Durant l''assalt Casanova va quedar ferit i Villarroel va cridar a la capitulació; Cardona va caure pocs dies després.', 'gubexamen_2025', (select id from public.topics where slug = 'gubexamen-2025'), 1, 'ca', true, (select id from public.sources where url = 'https://web.gencat.cat/ca/generalitat/qui-som/historia-generalitat'), 'GUB 2025 p. 62 · 11 de setembre de 1714', 'L’assalt definitiu de la ciutat va tenir lloc l’11 de setembre: Casanova va quedar ferit i Villarroel va cridar a la capitulació.', null, 'ed3db3a217e490ebf2e69646336962116ad82080ac100ae50cdc6f0c2b2afbee', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'ed3db3a217e490ebf2e69646336962116ad82080ac100ae50cdc6f0c2b2afbee')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'L''assalt definitiu a la ciutat assetjada, que va acabar amb la capitulació', true), ('B', 'La signatura del pacte de Ceret amb França', false), ('C', 'La publicació del Decret de Nova Planta', false), ('D', 'La proclamació de la República catalana', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-urbana-barcelona');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'En quina data va entrar en vigor l''Estatut d''autonomia de Catalunya de 2006, aprovat en referèndum el 18 de juny?', 'Rèplica de la p. 73 (any d''una llei clau de la història recent; substitueix el matrimoni igualitari de 2005, sense font oficial carregada). Referèndum el 18 de juny de 2006 i entrada en vigor el 9 d''agost.', 'gubexamen_2025', (select id from public.topics where slug = 'gubexamen-2025'), 3, 'ca', true, (select id from public.sources where url = 'https://web.gencat.cat/ca/generalitat/qui-som/historia-generalitat'), 'GUB 2025 p. 73 · Estatut de 2006', 'El text final resultant fou aprovat pel poble de Catalunya en el referèndum celebrat el 18 de juny de 2006 i va entrar en vigor el 9 d''agost del mateix any.', null, 'ff1351e786be19810da1ba04e7c181231f32b1a6839e6ba316469160eb308e58', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'ff1351e786be19810da1ba04e7c181231f32b1a6839e6ba316469160eb308e58')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El 18 de desembre de 2006', false), ('B', 'El 9 d''agost de 2006', true), ('C', 'L''11 de setembre de 2006', false), ('D', 'El 6 de desembre de 2006', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-urbana-barcelona');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Qui va presidir la Generalitat de Catalunya constituïda amb caràcter provisional l''abril de 1931?', 'Rèplica de la reserva 86.', 'gubexamen_2025', (select id from public.topics where slug = 'gubexamen-2025'), 1, 'ca', true, (select id from public.sources where url = 'https://web.gencat.cat/ca/generalitat/qui-som/historia-generalitat'), 'GUB 2025 p. 86 (reserva) · Francesc Macià', 'Arran dels esdeveniments d''abril de 1931 quedà constituïda, amb caràcter provisional, la Generalitat de Catalunya, presidida per Francesc Macià', null, '4bac5f9830e2620d5be6fdf60e919c5203fb895be9842940da7ef378d2d42b7f', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '4bac5f9830e2620d5be6fdf60e919c5203fb895be9842940da7ef378d2d42b7f')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Lluís Companys', false), ('B', 'Josep Tarradellas', false), ('C', 'Francesc Macià', true), ('D', 'Josep Irla', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-urbana-barcelona');
-- Lote gubexamen-2025-cultural-govcreu26-v1 (1 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('El Govern distingeix amb la Creu de Sant Jordi 20 persones i 10 entitats (nota de premsa, 14/04/2026)', 'https://govern.cat/gov/notes-premsa/812364/govern-distingeix-creu-sant-jordi-20-persones-10-entitats', 'web_oficial'::public.source_kind, 'Generalitat de Catalunya, Govern.cat', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('gubexamen-2025', 'Rèplica de l''examen d''agent de la Guàrdia Urbana 2025 (part de temari)') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('guardia-urbana-barcelona') and t.slug = 'gubexamen-2025' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Quina actriu i cineasta, Creu de Sant Jordi 2026, va rebre el Gaudí d''Honor de 2026?', 'Rèplica de la p. 67 (substitueix la pel·lícula «El 47» per un fet recent del cinema català). 14 d''abril de 2026: Creu de Sant Jordi a Sílvia Munt, que té els Goya i el Gaudí d''Honor 2026.', 'gubexamen_2025', (select id from public.topics where slug = 'gubexamen-2025'), 2, 'ca', true, (select id from public.sources where url = 'https://govern.cat/gov/notes-premsa/812364/govern-distingeix-creu-sant-jordi-20-persones-10-entitats'), 'GUB 2025 p. 67 · Sílvia Munt, Gaudí d''Honor 2026', 'La seva trajectòria ha estat reconeguda amb nombrosos guardons, entre els quals els premis Goya a la millor actriu i al millor curtmetratge documental, i el Gaudí d’Honor de 2026.', null, 'e7471af85809fd5df01d9902457f15c160ac35660112224ad4c77a4592ea1809', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'e7471af85809fd5df01d9902457f15c160ac35660112224ad4c77a4592ea1809')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Rosa Maria Sardà', false), ('B', 'Emma Vilarasau', false), ('C', 'Laia Marull', false), ('D', 'Sílvia Munt', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-urbana-barcelona');
-- Lote gubexamen-2025-cultural-govmedor26-v1 (1 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('El Govern lliura la Medalla d''Or de la Generalitat al cuiner Ferran Adrià i a la física i directora del Sincrotró ALBA Caterina Biscari (nota de premsa, 01/09/2026)', 'https://govern.cat/salapremsa/notes-premsa/862672/el-govern-lliura-la-medalla-d-or-de-la-generalitat-al-cuiner-ferran-adria-i-a-la-fisica-i-directora-del-sincrotro-alba-caterina-biscari', 'web_oficial'::public.source_kind, 'Generalitat de Catalunya, Govern.cat', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('gubexamen-2025', 'Rèplica de l''examen d''agent de la Guàrdia Urbana 2025 (part de temari)') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('guardia-urbana-barcelona') and t.slug = 'gubexamen-2025' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Quin restaurant, a cala Montjoi (Roses), va dirigir Ferran Adrià, Medalla d''Or de la Generalitat 2026?', 'Rèplica de la p. 75 (substitueix el restaurant barceloní amb 3 estrelles Michelin per un fet gastronòmic recent). 1 de setembre de 2026: Medalla d''Or a Ferran Adrià, que va tancar El Bulli el 2011.', 'gubexamen_2025', (select id from public.topics where slug = 'gubexamen-2025'), 2, 'ca', true, (select id from public.sources where url = 'https://govern.cat/salapremsa/notes-premsa/862672/el-govern-lliura-la-medalla-d-or-de-la-generalitat-al-cuiner-ferran-adria-i-a-la-fisica-i-directora-del-sincrotro-alba-caterina-biscari'), 'GUB 2025 p. 75 · Ferran Adrià', 'Amb només 22 anys va esdevenir xef d’El Bulli, el restaurant de cala Montjoi, a Roses', null, '6b1dbc18f29f82df6bbd0c52e8af3a902452b376a182d6e35cc1aa5bce56476a', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '6b1dbc18f29f82df6bbd0c52e8af3a902452b376a182d6e35cc1aa5bce56476a')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El Bulli', true), ('B', 'Disfrutar', false), ('C', 'El Celler de Can Roca', false), ('D', 'Lasarte', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-urbana-barcelona');
-- Lote gubexamen-2025-cultural-govpnc26-v1 (2 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('President Illa: "Com Pau Casals, enguany podem dir al món un ''som catalans'' col·lectiu..." (Premis Nacionals de Cultura 2026, nota de premsa, 09/10/2026)', 'https://govern.cat/salapremsa/notes-premsa/878952/president-illa-com-pau-casals-enguany-dir-al-mon-som-catalans-collectiu-tothom-shi-senti-representat-part-activa', 'web_oficial'::public.source_kind, 'Generalitat de Catalunya, Govern.cat', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('gubexamen-2025', 'Rèplica de l''examen d''agent de la Guàrdia Urbana 2025 (part de temari)') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('guardia-urbana-barcelona') and t.slug = 'gubexamen-2025' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Quin actor, que va començar de petit en la companyia familiar de circ i teatre de carrer, va rebre el Premi Nacional de Cultura 2026?', 'Rèplica de la p. 76 (substitueix els Goya 2025 per un premi recent del món audiovisual i escènic). 9 d''octubre de 2026.', 'gubexamen_2025', (select id from public.topics where slug = 'gubexamen-2025'), 2, 'ca', true, (select id from public.sources where url = 'https://govern.cat/salapremsa/notes-premsa/878952/president-illa-com-pau-casals-enguany-dir-al-mon-som-catalans-collectiu-tothom-shi-senti-representat-part-activa'), 'GUB 2025 p. 76 · Premis Nacionals de Cultura 2026, Oriol Pla', 'Oriol Pla, Premi Nacional de Cultura per una carrera brillant en la interpretació, des de les primeres actuacions de petit en la companyia familiar de circ i teatre de carrer', null, 'e04ea337fd517ad5413e19e54cf3ece076a9166a47a5c3482613b110c81e2fd0', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'e04ea337fd517ad5413e19e54cf3ece076a9166a47a5c3482613b110c81e2fd0')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Sergi López', false), ('B', 'Eduard Fernández', false), ('C', 'Lluís Homar', false), ('D', 'Oriol Pla', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-urbana-barcelona');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Quin aniversari de Pau Casals es commemorava el 2026, quan es van lliurar els Premis Nacionals de Cultura al Vendrell?', 'Rèplica de la reserva 88 (substitueix la mort de Marisa Paredes per una efemèride cultural recent). 9 d''octubre de 2026.', 'gubexamen_2025', (select id from public.topics where slug = 'gubexamen-2025'), 2, 'ca', true, (select id from public.sources where url = 'https://govern.cat/salapremsa/notes-premsa/878952/president-illa-com-pau-casals-enguany-dir-al-mon-som-catalans-collectiu-tothom-shi-senti-representat-part-activa'), 'GUB 2025 p. 88 (reserva) · Pau Casals, 150è aniversari', 'amb motiu del 150è aniversari del seunaixement.', null, '365b32f610c1669ebeecccfd78d19c4a4f97f992bbd765bf39df0142146ac1c8', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '365b32f610c1669ebeecccfd78d19c4a4f97f992bbd765bf39df0142146ac1c8')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El 150è aniversari del naixement', true), ('B', 'El centenari de la mort', false), ('C', 'El 50è aniversari de la mort', false), ('D', 'El 125è aniversari del naixement', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-urbana-barcelona');
-- Lote gubexamen-2025-cultural-moncloasmi26-v1 (1 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Pedro Sánchez destaca que con la subida del SMI en 2026 se da "un paso muy relevante para mejorar la vida de 2,5 millones de trabajadores" (16/02/2026)', 'https://www.lamoncloa.gob.es/presidente/actividades/Paginas/2026/160226-sanchez-subida-salario-minimo.aspx', 'web_oficial'::public.source_kind, 'La Moncloa, Gobierno de España', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('gubexamen-2025', 'Rèplica de l''examen d''agent de la Guàrdia Urbana 2025 (part de temari)') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('guardia-urbana-barcelona') and t.slug = 'gubexamen-2025' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Quant ha pujat el salari mínim interprofessional el 2026?', 'Rèplica de la p. 80 (SMI 2025 de l''examen, actualitzat al 2026). 16 de febrer de 2026.', 'gubexamen_2025', (select id from public.topics where slug = 'gubexamen-2025'), 2, 'ca', true, (select id from public.sources where url = 'https://www.lamoncloa.gob.es/presidente/actividades/Paginas/2026/160226-sanchez-subida-salario-minimo.aspx'), 'GUB 2025 p. 80 · SMI 2026', 'tras haberse aprobado un nuevo incremento del 3,1% en 2026.', null, '40eef9ddc1e4f26314b3fef8006fc4c97f72f382c5fafe7423605521ca2bfcc5', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '40eef9ddc1e4f26314b3fef8006fc4c97f72f382c5fafe7423605521ca2bfcc5')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Un 5%, fins a 1.184 euros al mes en 14 pagues', false), ('B', 'Un 3,1%, fins a 1.221 euros al mes en 14 pagues', true), ('C', 'Un 10%, fins a 1.300 euros al mes en 12 pagues', false), ('D', 'No ha pujat respecte del 2025', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-urbana-barcelona');
-- Lote gubexamen-2025-cultural-nobel-v1 (2 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('All Nobel Prizes 2026 (Nobel Foundation)', 'https://www.nobelprize.org/all-nobel-prizes-2026/', 'web_oficial'::public.source_kind, 'Nobel Foundation / Nobel Prize Outreach', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('gubexamen-2025', 'Rèplica de l''examen d''agent de la Guàrdia Urbana 2025 (part de temari)') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('guardia-urbana-barcelona') and t.slug = 'gubexamen-2025' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'De quina nacionalitat és Anne Carson, premi Nobel de literatura 2026?', 'Rèplica de la p. 69 (Nobel de literatura 2024, actualitzat al de 2026). Octubre de 2026.', 'gubexamen_2025', (select id from public.topics where slug = 'gubexamen-2025'), 1, 'ca', true, (select id from public.sources where url = 'https://www.nobelprize.org/all-nobel-prizes-2026/'), 'GUB 2025 p. 69 · Nobel de literatura 2026', 'The Nobel Prize in Literature 2026 has been awarded to the Canadian author Anne Carson', null, 'aa9b9af96d661d6b6ed963f5404cfc19fbef122c8113875ac4d2a202b7c902eb', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'aa9b9af96d661d6b6ed963f5404cfc19fbef122c8113875ac4d2a202b7c902eb')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Nord-americana', false), ('B', 'Britànica', false), ('C', 'Canadenca', true), ('D', 'Australiana', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-urbana-barcelona');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Per què va rebre Navi Pillay el premi Nobel de la pau 2026?', 'Rèplica de la p. 74 (substitueix Elon Musk al govern de Trump per una personalitat internacional d''actualitat). Octubre de 2026.', 'gubexamen_2025', (select id from public.topics where slug = 'gubexamen-2025'), 2, 'ca', true, (select id from public.sources where url = 'https://www.nobelprize.org/all-nobel-prizes-2026/'), 'GUB 2025 p. 74 · Nobel de la pau 2026', 'Nobel Peace Prize 2026 Navanethem “Navi” Pillay “for her efforts to promote peace and international law”', null, 'aff2a02535d920bad09a33c8d861449623d34ce1b1c41e7bbfa5488400d6c431', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'aff2a02535d920bad09a33c8d861449623d34ce1b1c41e7bbfa5488400d6c431')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Per la seva lluita contra les armes nuclears', false), ('B', 'Per la defensa dels drets de les dones a l''Iran', false), ('C', 'Pels seus esforços per promoure la pau i el dret internacional', true), ('D', 'Per la transició democràtica a Veneçuela', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-urbana-barcelona');
-- Lote gubexamen-2025-cultural-nobelhist-v1 (1 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('NobelPrize.org: All Nobel Prizes 2025 i fitxes de premiats (Literature 1956, 1977, 1982, 1989, 2010, 2023-2024; Peace 2023-2024)', 'https://www.nobelprize.org/all-nobel-prizes-2025/', 'web_oficial'::public.source_kind, 'Nobel Foundation / Nobel Prize Outreach', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('gubexamen-2025', 'Rèplica de l''examen d''agent de la Guàrdia Urbana 2025 (part de temari)') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('guardia-urbana-barcelona') and t.slug = 'gubexamen-2025' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Quina dirigent veneçolana va rebre el premi Nobel de la pau 2025 per la seva lluita pels drets democràtics?', 'Rèplica de la p. 66 (substitueix «presidenta de Mèxic» per una dirigent política llatinoamericana d''actualitat). Octubre de 2025: Machado, Nobel de la pau.', 'gubexamen_2025', (select id from public.topics where slug = 'gubexamen-2025'), 2, 'ca', true, (select id from public.sources where url = 'https://www.nobelprize.org/all-nobel-prizes-2025/'), 'GUB 2025 p. 66 · Nobel de la pau 2025', 'Nobel Peace Prize 2025 Maria Corina Machado “for her tireless work promoting democratic rights for the people of Venezuela', null, 'b8d23a350018e0ef7a5609234f72e854665a423177aef45bc9295d2cadb5367e', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'b8d23a350018e0ef7a5609234f72e854665a423177aef45bc9295d2cadb5367e')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Navi Pillay', false), ('B', 'María Corina Machado', true), ('C', 'Narges Mohammadi', false), ('D', 'Michelle Bachelet', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-urbana-barcelona');
-- Lote gubexamen-2025-cultural-reinasofia-v1 (1 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Guernica (Pablo Picasso, 1937), fitxa de la col·lecció', 'https://www.museoreinasofia.es/colecciones/obra/guernica', 'web_oficial'::public.source_kind, 'Museo Nacional Centro de Arte Reina Sofía', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('gubexamen-2025', 'Rèplica de l''examen d''agent de la Guàrdia Urbana 2025 (part de temari)') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('guardia-urbana-barcelona') and t.slug = 'gubexamen-2025' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Quin fet va motivar Picasso a pintar el Guernica?', 'Rèplica de la reserva 85 (substitueix Dalí per una altra obra cabdal de la pintura del segle XX amb font oficial). Guernica, 1937.', 'gubexamen_2025', (select id from public.topics where slug = 'gubexamen-2025'), 2, 'ca', true, (select id from public.sources where url = 'https://www.museoreinasofia.es/colecciones/obra/guernica'), 'GUB 2025 p. 85 (reserva) · Guernica', 'El motivo que impulsó a Pablo Picasso a realizar la escena representada en esta gran pintura fue la noticia de los bombardeos efectuados por la aviación alemana sobre la villa vasca que da nombre a la obra', null, '712803627756b108ee511782418ed46dcc822d622914706039635147680553f2', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '712803627756b108ee511782418ed46dcc822d622914706039635147680553f2')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'La caiguda de Barcelona el 1939', false), ('B', 'El bombardeig de l''aviació alemanya sobre la vila basca de Gernika', true), ('C', 'El setge de Madrid', false), ('D', 'L''afusellament de Lorca', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-urbana-barcelona');
-- Lote gubexamen-2025-cultural-ue-v1 (1 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Portal oficial de la Unión Europea: países, historia, euro e instituciones', 'https://european-union.europa.eu/index_es', 'web_oficial'::public.source_kind, 'Unión Europea', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('gubexamen-2025', 'Rèplica de l''examen d''agent de la Guàrdia Urbana 2025 (part de temari)') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('guardia-urbana-barcelona') and t.slug = 'gubexamen-2025' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Qui presideix la Comissió Europea?', 'Rèplica de la p. 79. Von der Leyen presideix la Comissió; Metsola, el Parlament Europeu; Costa, el Consell Europeu.', 'gubexamen_2025', (select id from public.topics where slug = 'gubexamen-2025'), 1, 'ca', true, (select id from public.sources where url = 'https://european-union.europa.eu/index_es'), 'GUB 2025 p. 79 · Comissió Europea', 'Presidencia: Ursula von der Leyen Año de creación: 1958 Sede: Bruselas (Bélgica)', null, '047c504d4dc0e98701e3d13abb33efb3e6596bc397a31cf5c90be851377023ba', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '047c504d4dc0e98701e3d13abb33efb3e6596bc397a31cf5c90be851377023ba')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Roberta Metsola', false), ('B', 'António Costa', false), ('C', 'Christine Lagarde', false), ('D', 'Ursula von der Leyen', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-urbana-barcelona');
-- Lote gubexamen-2025-cultural-unesco-v1 (1 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('World Heritage List (fitxes dels béns inscrits), UNESCO World Heritage Centre', 'https://whc.unesco.org/en/list/', 'web_oficial'::public.source_kind, 'UNESCO World Heritage Centre', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('gubexamen-2025', 'Rèplica de l''examen d''agent de la Guàrdia Urbana 2025 (part de temari)') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('guardia-urbana-barcelona') and t.slug = 'gubexamen-2025' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'De quin estil són les esglésies de la Vall de Boí (Alta Ribagorça), patrimoni mundial des del 2000?', 'Rèplica de la p. 51 (estil de les pintures de la Vall de Boí, conservades en part al MNAC). Cada poble de la vall té una església romànica.', 'gubexamen_2025', (select id from public.topics where slug = 'gubexamen-2025'), 1, 'ca', true, (select id from public.sources where url = 'https://whc.unesco.org/en/list/'), 'GUB 2025 p. 51 · Vall de Boí', 'Each village in the valley contains a Romanesque church, and is surrounded by a pattern of enclosed fields.', null, '427f2c287e3b16dbf7b1b4e719989b77eef2a9eaf0f9a3c63109206fe9c9ac7b', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '427f2c287e3b16dbf7b1b4e719989b77eef2a9eaf0f9a3c63109206fe9c9ac7b')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Romànic', true), ('B', 'Gòtic', false), ('C', 'Barroc', false), ('D', 'Modernista', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-urbana-barcelona');
-- Fichas de estudio (10) · generado por scripts/content/notes-to-sql.mjs
insert into public.sources (title, url, kind, publisher, published_on) values ('All Nobel Prizes 2026 (Nobel Foundation)', 'https://www.nobelprize.org/all-nobel-prizes-2026/', 'web_oficial'::public.source_kind, 'Nobel Foundation / Nobel Prize Outreach', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('actcat-01-actualitat', 'Actualitat (novembre 2025 - novembre 2026): Catalunya, Barcelona, Espanya, UE i món') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('policia-local', 'guardia-urbana-barcelona') and t.slug = 'actcat-01-actualitat' on conflict do nothing;
insert into public.topic_notes as n (topic_id, locale, outline, key_ideas, glossary, amendments, source_id, source_url, page_from, page_to, key_ideas_page, review_note)
select t.id, 'ca', '[{"n":"1","title":"Premis Nobel 2026 i Premi Cervantes 2025"},{"n":"2","title":"Distincions de la Generalitat (Creu de Sant Jordi, Medalla d''Or, PIC, PNC)"},{"n":"3","title":"Govern i economia de Catalunya"},{"n":"4","title":"Barcelona 2026: Arquitectura, Any Gaudí, Tour, Mercè, padró"},{"n":"5","title":"Espanya, UE i món: SMI, Bulgària, presidència irlandesa, COP31, ONU"}]'::jsonb, '["Nobel de física 2026 NobelPrize.org, premis 2026: «Nobel Prize in Physics 2026 Francis Halzen “for decisive contributions to the IceCube Neutrino Observatory and the discovery of high-energy neutrinos of astrophysical origin”»","Nobel de medicina 2026 NobelPrize.org, premis 2026: «Karl Deisseroth, Peter Hegemann and Georg Nagel have been awarded the 2026 Nobel Prize in Physiology or Medicine for discoveries leading to optogenetics»","Nobel de literatura 2026 NobelPrize.org, premis 2026: «The Nobel Prize in Literature 2026 has been awarded to the Canadian author Anne Carson»","Nobel de la pau 2026 NobelPrize.org, premis 2026: «Nobel Peace Prize 2026 Navanethem “Navi” Pillay “for her efforts to promote peace and international law”»","Nobel d''economia 2026 NobelPrize.org, premis 2026: «Robert E. Hall “for microeconomic foundations of macroeconomic stabilisation”»","Nobel de química 2026 NobelPrize.org, premis 2026: «Nobel Prize in Chemistry 2026 Henri B. Kagan “for the discovery of non-linear effects and autocatalysis in asymmetric organic synthesis”»","Premi Cervantes 2025 Ministerio de Cultura, Premio Cervantes: «Gonzalo Celorio, Premio Cervantes 2025 03/11/2025»","Creu de Sant Jordi 2026 Govern.cat, Creu de Sant Jordi 2026: «ha acordat concedir la Creu de Sant Jordi de la Generalitat de Catalunya 2026 a 20 persones i 10 entitats»","Creu de Sant Jordi 2026, Pastorets de Calaf Govern.cat, Creu de Sant Jordi 2026: «Els Pastorets de Calaf constitueixen una de les representacions nadalenques més arrelades del país, representades de manera continuada a Calaf des de l’any 1925 a partir del text de Josep Maria Folch i Torres.»","Creu de Sant Jordi 2026, Universitat de Barcelona Govern.cat, Creu de Sant Jordi 2026: «Fundada l’any 1450, la Universitat de Barcelona és una de les institucions més antigues de Catalunya»","Premi Internacional Catalunya 2025 Govern.cat, Premi Internacional Catalunya 2025: «El Govern ha aprovat concedir el Premi Internacional Catalunya 2025 a Yael Admi i Reem Alhajajra, activistes israeliana i palestina per la pau»","Pla d''habitatge, 214.000 habitatges Govern.cat, Premi Internacional Catalunya 2025: «el pla per transformar sòl situat en sectors estratègics en solars preparats per construir-hi 214.000 nous habitatges»","Premis Nacionals de Cultura 2026, lloc Govern.cat, Premis Nacionals de Cultura 2026: «La celebració ha tingut lloc a l’Auditori Pau Casals en homenatge a la figura de Pau Casals, referent universal del compromís amb la cultura, la pau i la llibertat, amb motiu del 150è aniversari del seunaixement.»","Premis Nacionals de Cultura 2026, música Govern.cat, Premis Nacionals de Cultura 2026: «Sílvia Pérez Cruz, Premi Nacional de Cultura per l’excel·lència musical i la qualitat vocal i interpretativa»","Medalla d''Or de la Generalitat 2026 Govern.cat, Medalla d''Or 2026: «El Consell Executiu ha aprovat atorgar la Medalla d’Or de la Generalitat de Catalunya al cuiner Ferran Adrià i a la física i directora del Sincrotró ALBA Caterina Biscari»","Medalla d''Or 2026, Caterina Biscari Govern.cat, Medalla d''Or 2026: «l’any 2012 va arribar a Barcelona per dirigir el Sincrotró ALBA.»","Pressupostos 2026 Govern.cat, Pressupostos 2026: «El Govern de la Generalitat ha aprovat avui el Projecte de llei de pressupostos per a l’any 2026, uns comptes ambiciosos que assoleixen un import rècord de 49.162 M€.»","Pressupostos 2026, departaments Govern.cat, Pressupostos 2026: «L’any 2026, els departaments que compten amb un pressupost més alt són Salut (13.840 M€), Educació i Formació Professional (8.356 M€) i Drets Socials i Inclusió (4.248 M€).»","Consellera d''Economia Govern.cat, Pressupostos 2026: «La consellera d’Economia i Finances, Alícia Romero, ha presentat al Parlament el contingut dels nous comptes»","PIB de Catalunya, 3r trimestre 2026 Idescat: «El producte interior brut de Catalunya registra una variació interanual del 2,9% i intertrimestral del 0,7% al tercer trimestre del 2026»","Barcelona, Capital Mundial de l''Arquitectura Ajuntament de Barcelona, Capital Mundial de l’Arquitectura 2026: «Barcelona 2026, Capital Mundial de l’Arquitectura.»","Congrés de la UIA a Barcelona Ajuntament de Barcelona, Capital Mundial de l’Arquitectura 2026: «A l’estiu la ciutat serà la seu del Congrés de la Unió Internacional d’Arquitectes, tres dècades després d’haver estat la seu de la 19a edició, el 1996.»","Mercè 2026, ciutat convidada Ajuntament de Barcelona, Mercè 2026: «la programació del millor talent artístic de Shanghai, ciutat convidada d’enguany.»","Mercè 2026, pregó Ajuntament de Barcelona, Mercè 2026: «a càrrec del mestre celler Antoni Falgueras, acompanyat de la seva filla, la sommelier Meritxell Falgueras»","Placa en record de Gaudí Ajuntament de Barcelona, Any Gaudí: «amb la descoberta d’una placa col·locada en el mateix punt de la Gran Via de les Corts Catalanes on va ser atropellat per un tramvia el 7 de juny de 1926.»","Torre de Jesucrist Ajuntament de Barcelona, Any Gaudí: «té lloc tres dies abans de la inauguració de la torre de Jesucrist de la Sagrada Família, prevista el 10 de juny, data de la mort de l’arquitecte.»","Visita del papa Lleó XIV Ajuntament de Barcelona, visita de Lleó XIV: «Barcelona serà una de les principals seus de la visita oficial del Papa Lleó XIV a l’Estat espanyol aquest mes de juny. La capital catalana concentrarà diversos actes institucionals, religiosos i socials els dies 9 i 10 de juny»","Mil·lenari de Montserrat Ajuntament de Barcelona, visita de Lleó XIV: «es desplaçarà fins a l’abadia de Montserrat, en la commemoració del mil·lenari del monestir»","Tour de França 2026 Ajuntament de Barcelona, Grand Départ del Tour 2026: «fins el 5 de juliol amb l’arribada de la segona etapa de la competició ciclista a Montjuïc»","Cançó de la sortida del Tour Ajuntament de Barcelona, Grand Départ del Tour 2026: «El grup Doctor Prats estrena Energia!, la cançó oficial de la sortida»","Padró de Barcelona 2026 Ajuntament de Barcelona, padró 2026: «La població de Barcelona disminueix lleugerament el 2026 i se situa en 1.729.963 persones, el segon valor més elevat dels darrers quaranta anys.»","Padró 2026, noms dels nadons Ajuntament de Barcelona, padró 2026: «els noms més triats de nenes són Olívia, Sofia, Emma, Júlia i Ona. Pels nens, els preferits són Mateo, Pau, Marc, Pol i Bruno.»","Padró 2026, país de naixement Ajuntament de Barcelona, padró 2026: «Amb gairebé 50 mil persones, Argentina continua sent el país amb més aportació de nascuts a l’estranger.»","Centenari del Park Güell com a parc públic Ajuntament de Barcelona, centenari del Park Güell: «forma part de la commemoració dels cent anys del Park Güell com a parc públic»","Salari mínim interprofessional 2026 La Moncloa, SMI 2026: «al pasar de los 735 euros al mes a los 1.221 euros brutos al mes en 14 pagas este año, tras haberse aprobado un nuevo incremento del 3,1% en 2026.»","Bulgària a la zona euro european-union.europa.eu, fitxes de país: «[Bulgaria] Capital: Sofía Zona del euro: Miembro desde el 1 de enero de 2026»","Presidència irlandesa del Consell de la UE Consell de la UE, presidència irlandesa 2026: «On 1 July 2026, Ireland assumes the Presidency of the Council of the EU for the eighth time since its accession to the Union.»","COP31 UNFCCC, COP31: «COP31 is the United Nations Climate Change Conference taking place in Antalya, Türkiye from 9 to 20 November 2026.»","Selecció del secretari general de l''ONU un.org: «A joint letter of the President of the General Assembly and the President of the Security Council addressed to Member States, published on 25 November 2025, formally initiated the selection process.»","Premis Ciutat de Barcelona 2025 Ajuntament de Barcelona, Premis Ciutat de Barcelona 2025: «En conseqüència, en l’edició del 2025 es lliuraran un total de dinou premis.»"]'::jsonb, '[]'::jsonb, '[]'::jsonb, (select id from public.sources where url = 'https://www.nobelprize.org/all-nobel-prizes-2026/'), 'https://www.nobelprize.org/all-nobel-prizes-2026/', null, null, null, 'Otras normas citadas: Ministerio de Cultura, Premio Cervantes (https://www.cultura.gob.es/actualidad/2025/11/251103-premio-cervantes-2025.html), Govern.cat, Creu de Sant Jordi 2026 (https://govern.cat/gov/notes-premsa/812364/govern-distingeix-creu-sant-jordi-20-persones-10-entitats), Govern.cat, Premi Internacional Catalunya 2025 (https://govern.cat/gov/acords-govern/16039/govern-concedeix-premi-internacional-catalunya-2025-activistes-pau-yael-admi-reem-alhajajra), Govern.cat, Premis Nacionals de Cultura 2026 (https://govern.cat/salapremsa/notes-premsa/878952/president-illa-com-pau-casals-enguany-dir-al-mon-som-catalans-collectiu-tothom-shi-senti-representat-part-activa), Govern.cat, Medalla d''Or 2026 (https://govern.cat/salapremsa/notes-premsa/862672/el-govern-lliura-la-medalla-d-or-de-la-generalitat-al-cuiner-ferran-adria-i-a-la-fisica-i-directora-del-sincrotro-alba-caterina-biscari), Govern.cat, Pressupostos 2026 (https://govern.cat/salapremsa/notes-premsa/795676/pressupostos-generalitat-al-2026-creixen-228-percent-respecte-als-darrers-aprovats-acceleren-inversio-fons-propis), Idescat (https://www.idescat.cat/indicadors/?id=aec&lang=ca), Ajuntament de Barcelona, Capital Mundial de l’Arquitectura 2026 (https://ajuntament.barcelona.cat/urbanisme-accio-climatica-mobilitat-pla-barris-serveis-urbans/ca/news/barcelona-2026-capital-mundial-de-larquitectura-1377921), Ajuntament de Barcelona, Mercè 2026 (https://ajuntament.barcelona.cat/ciutatvella/ca/noticies/tota-la-programacio-de-la-merce-2026-41192), Ajuntament de Barcelona, Any Gaudí (https://ajuntament.barcelona.cat/premsa/2026/06/07/barcelona-ret-homenatge-a-antoni-gaudi-amb-una-placa-en-el-mateix-punt-on-va-ser-atropellat-lany-1926/), Ajuntament de Barcelona, visita de Lleó XIV (https://ajuntament.barcelona.cat/oficina-afers-religiosos/ca/noticies/barcelona-acollira-aquest-juny-la-visita-del-papa-lleo-xiv-1640185), Ajuntament de Barcelona, Grand Départ del Tour 2026 (https://ajuntament.barcelona.cat/premsa/2026/05/15/la-festa-major-del-tour-omplira-barcelona-amb-mes-de-60-propostes-per-celebrar-el-tour-de-franca/), Ajuntament de Barcelona, padró 2026 (https://dades.ajuntament.barcelona.cat/informe-padro-poblacio/ca/seccio_2.html), Ajuntament de Barcelona, centenari del Park Güell (https://ajuntament.barcelona.cat/premsa/2026/11/05/el-park-guell-presenta-una-exposicio-de-900-fotografies-que-recorren-un-segle-de-la-seva-historia/), La Moncloa, SMI 2026 (https://www.lamoncloa.gob.es/presidente/actividades/Paginas/2026/160226-sanchez-subida-salario-minimo.aspx), european-union.europa.eu, fitxes de país (https://european-union.europa.eu/principles-countries-history/eu-countries_es), Consell de la UE, presidència irlandesa 2026 (https://irish-presidency.consilium.europa.eu/en/presidency/presidency-of-the-council-of-the-eu/), UNFCCC, COP31 (https://unfccc.int/cop31), un.org (https://www.un.org/en/about-us), Ajuntament de Barcelona, Premis Ciutat de Barcelona 2025 (https://ajuntament.barcelona.cat/ca/informacio-administrativa/premis/premis-ciutat-de-barcelona-2025)'
  from public.topics t where t.slug = 'actcat-01-actualitat'
on conflict (topic_id, locale) do update
   set outline = excluded.outline, key_ideas = excluded.key_ideas, glossary = excluded.glossary,
       amendments = excluded.amendments, source_id = excluded.source_id, source_url = excluded.source_url,
       page_from = excluded.page_from, page_to = excluded.page_to, key_ideas_page = excluded.key_ideas_page
 where (n.outline, n.key_ideas, n.glossary, n.amendments)
       is distinct from (excluded.outline, excluded.key_ideas, excluded.glossary, excluded.amendments);
insert into public.sources (title, url, kind, publisher, published_on) values ('Història de la Generalitat (Diputació del General, Nova Planta i Generalitat contemporània)', 'https://web.gencat.cat/ca/generalitat/qui-som/historia-generalitat', 'web_oficial'::public.source_kind, 'Generalitat de Catalunya', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('cultcat-01-historia-catalunya', 'Cultura general 1. Història de Catalunya: institucions, símbols i fets clau') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('policia-local', 'guardia-urbana-barcelona') and t.slug = 'cultcat-01-historia-catalunya' on conflict do nothing;
insert into public.topic_notes as n (topic_id, locale, outline, key_ideas, glossary, amendments, source_id, source_url, page_from, page_to, key_ideas_page, review_note)
select t.id, 'ca', '[{"n":"1","title":"Edat mitjana: Corts, pactisme i Diputació del General"},{"n":"2","title":"Època moderna: Casp, Observança, 1640 i 1714"},{"n":"3","title":"Segle XX: Mancomunitat, República i Generalitat a l''exili"},{"n":"4","title":"Transició i Estatuts (1979, 2006)"},{"n":"5","title":"Símbols nacionals i presidents recents"}]'::jsonb, '["Diputació del General, 1283 Generalitat, Història de la Generalitat: «Aquest sistema establia que el sobirà no podia promulgar constitucions ni exigir impostos generals sense l’autorització dels tres estaments o braços —el militar, l’eclesiàstic i el reial o popular— reunits en Corts.»","Diputació del General, Pesta Negra Generalitat, Història de la Generalitat: «Durant el regnat de Pere el Cerimoniós, Catalunya va viure una crisi econòmica i demogràfica a causa de la Pesta Negra de 1348.»","Diputació del General, seu Generalitat, Història de la Generalitat: «La institució es va instal·lar a les cases del carrer de Sant Honorat, que amb el temps es van convertir en el Palau de la Generalitat.»","Compromís de Casp, 1412 Generalitat, Història de la Generalitat: «Quan el Casal de Barcelona es va extingir el 1410, es va obrir un període d’incertesa política conegut com Interregne, que va acabar amb el Compromís de Casp de 1412.»","Val d''Aran, 1410 Generalitat, Història de la Generalitat: «Un exemple és la integració voluntària de la Val d’Aran (un territori de senyoria reial autònom) al Principat el 1410»","Insaculació, 1455 Generalitat, Història de la Generalitat: «El 1455 es va introduir un sistema mixt que combinava la cooptació amb la insaculació (que consistia a introduir en un sac els noms dels candidats, que eren escollits al atzar per una ma innocent»","Constitució de l''Observança, 1481 Generalitat, Història de la Generalitat: «establint la Constitució de l’Observança, que començava dient: \"Poc valdria fer lleis i constitucions si no fossin respectades per nosaltres i els nostres oficials\".»","Pacte de Ceret, 1640 Generalitat, Història de la Generalitat: «La Diputació va signar el pacte de Ceret amb França el 7 de setembre de 1640 per rebre suport militar»","Tractat dels Pirineus, 1659 Generalitat, Història de la Generalitat: «Finalment, el Tractat dels Pirineus de 1659 va sancionar l’annexió a França del Rosselló, el Conflent, el Vallespir i part de la Cerdanya.»","11 de setembre de 1714 Generalitat, Història de la Generalitat: «L’assalt definitiu de la ciutat va tenir lloc l’11 de setembre: Casanova va quedar ferit i Villarroel va cridar a la capitulació.»","Darrer reducte, 1714 Generalitat, Història de la Generalitat: «El darrer reducte de resistència, Cardona, va caure pocs dies després.»","Decret de Nova Planta, 1716 Generalitat, Història de la Generalitat: «Amb el Decret de Nova Planta, publicat a Catalunya el 16 de gener de 1716, Felip V va establir un règim polític que excloïa la representació de la societat catalana»","Mancomunitat Generalitat, Història de la Generalitat: «Hi ha un nexe que uneix els primers triomfs electorals del catalanisme polític el 1901-1907 amb la primera experiència d''autogovern català, la Mancomunitat de 1914-1925.»","Generalitat provisional, 1931 Generalitat, Història de la Generalitat: «Arran dels esdeveniments d''abril de 1931 quedà constituïda, amb caràcter provisional, la Generalitat de Catalunya, presidida per Francesc Macià»","Primer Parlament, 1932 Generalitat, Història de la Generalitat: «que fou elegit per primera i única vegada dins l''etapa republicana el 20 de novembre de 1932.»","Lluís Companys, 1940 Generalitat, Història de la Generalitat: «el president de la Generalitat va ser jutjat en un consell de guerra sumaríssim i afusellat al castell de Montjuïc el dia 15 d''octubre de 1940.»","Tarradellas, 1977 Generalitat, Història de la Generalitat: «el decret de 29 de setembre de 1977 reconeixia com a president de la Generalitat Josep Tarradellas, l''única autoritat republicana que retornà d''un exili de quaranta anys»","Estatut de 1979 Generalitat, Història de la Generalitat: «Aquesta, denominada Comissió dels Vint es reuní al parador de Sau»","Símbols nacionals, EAC art. 8 EAC: «El himno de Cataluña es «Els segadors».»","Presidents, 2024 Generalitat, Història de la Generalitat: «Salvador Illa va ser investit 133è president de la Generalitat el 8 d’agost de 2024»"]'::jsonb, '[]'::jsonb, '[]'::jsonb, (select id from public.sources where url = 'https://web.gencat.cat/ca/generalitat/qui-som/historia-generalitat'), 'https://web.gencat.cat/ca/generalitat/qui-som/historia-generalitat', null, null, null, 'Otras normas citadas: EAC (https://www.boe.es/buscar/act.php?id=BOE-A-2006-13087)'
  from public.topics t where t.slug = 'cultcat-01-historia-catalunya'
on conflict (topic_id, locale) do update
   set outline = excluded.outline, key_ideas = excluded.key_ideas, glossary = excluded.glossary,
       amendments = excluded.amendments, source_id = excluded.source_id, source_url = excluded.source_url,
       page_from = excluded.page_from, page_to = excluded.page_to, key_ideas_page = excluded.key_ideas_page
 where (n.outline, n.key_ideas, n.glossary, n.amendments)
       is distinct from (excluded.outline, excluded.key_ideas, excluded.glossary, excluded.amendments);
insert into public.sources (title, url, kind, publisher, published_on) values ('Portal oficial de la Unión Europea: países, historia, euro e instituciones', 'https://european-union.europa.eu/index_es', 'web_oficial'::public.source_kind, 'Unión Europea', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('cultcat-02-historia-espanya-mon', 'Cultura general 2. Història d''Espanya i universal') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('policia-local', 'guardia-urbana-barcelona') and t.slug = 'cultcat-02-historia-espanya-mon' on conflict do nothing;
insert into public.topic_notes as n (topic_id, locale, outline, key_ideas, glossary, amendments, source_id, source_url, page_from, page_to, key_ideas_page, review_note)
select t.id, 'ca', '[{"n":"1","title":"Espanya contemporània: dictadures, República i Transició"},{"n":"2","title":"Història universal: Revolució Francesa, Segona Guerra Mundial i ONU"},{"n":"3","title":"Integració europea: CECA, Tractat de Roma i ampliacions"},{"n":"4","title":"Món antic i medieval: Roma a Hispània, Xina, remences"},{"n":"5","title":"Fets del segle XX i XXI"}]'::jsonb, '["ONU, fundació un.org: «The United Nations is an international organization founded in 1945.»","Carta de les Nacions Unides, signatura un.org: «It was signed on 26 June 1945, in San Francisco, at the conclusion of the United Nations Conference on International Organization, and came into force on 24 October 1945.»","Constitució espanyola, referèndum Generalitat, Història de la Generalitat: «configuraren unes cambres que tingueren com a missió principal la redacció d''una constitució, que ser aprovada en referèndum el 6 de desembre de 1978.»","Fi de la dictadura franquista Generalitat, Història de la Generalitat: «encetaren un període de privació de la democràcia i els drets nacionals catalans que havia de durar fins a la mort del dictador el 20 de novembre de 1975.»","Transició, Adolfo Suárez Generalitat, Història de la Generalitat: «El 3 de juliol de 1976, fou nomenat president del govern Adolfo Suárez, que avançà de manera cada vegada més decidida cap a la reforma.»","Eleccions generals de 1977 Generalitat, Història de la Generalitat: «les primeres eleccions legislatives espanyoles democràtiques des de 1936, celebrades el 15 de juny de 1977»","Dictadura de Primo de Rivera Generalitat, Història de la Generalitat: «la del general Primo de Rivera (1923-1930) i la del general Franco (1939-1975).»","Segona República, 1931 Generalitat, Història de la Generalitat: «proclamà de manera unilateral «la República catalana com a Estat de la Federació Ibèrica» el dia 14, poques hores abans que a Madrid es procedís a proclamar la Segona República espanyola.»","OTAN, 1949 european-union.europa.eu: «4 de abril de 1949 — Creación de la OTAN Se crea la Organización del Tratado del Atlántico Norte (OTAN), una alianza intergubernamental de seguridad entre los Estados Unidos, Canadá y diez países de Europa Occidental.»","CECA, 1951 european-union.europa.eu: «La Comunidad Europea del Carbón y del Acero, fundada en 1951, fue el primer paso para garantizar una paz duradera.»","Tractat de Roma, 1957 european-union.europa.eu: «En 1957, el Tratado de Roma establece la Comunidad Económica Europea (CEE)»","Adhesió d''Espanya, 1986 european-union.europa.eu: «En 1981, Grecia pasa a ser el décimo miembro de las Comunidades Europeas, seguida cinco años más tarde por España y Portugal.»","Adhesió de Grècia, 1981 european-union.europa.eu: «En 1981, Grecia pasa a ser el décimo miembro de las Comunidades Europeas»","Atemptats de l''11 de setembre de 2001 european-union.europa.eu: «Varios aviones son secuestrados y estrellados contra las torres gemelas del World Trade Center, en Nueva York, y el Pentágono, en Washington. Mueren alrededor de 3 000 personas.»","Solidaritat, Gdańsk european-union.europa.eu: «Los trabajadores de los astilleros de la ciudad polaca de Gdansk, dirigidos por Lech Walesa, entran en huelga para reclamar más derechos.»","Auschwitz-Birkenau UNESCO, World Heritage List: «Auschwitz Birkenau German Nazi Concentration and Extermination Camp (1940-1945) (Date of Inscription: 1979).»","Declaració de Drets de l''Home i del Ciutadà, 1789 Conseil constitutionnel, DDHC 1789: «Déclaration des Droits de l''Homme et du Citoyen de 1789 […] Article 1er Les hommes naissent et demeurent libres et égaux en»","Mèrida, Augusta Emerita UNESCO, World Heritage List: «The colony of Augusta Emerita, which became present-day Mérida in Estremadura, was founded in 25 B.C. at the end of the Spanish Campaign and was the capital of Lusitania.»","Gran Muralla xinesa UNESCO, World Heritage List: «In c. 220 B.C., under Qin Shi Huang, sections of earlier fortifications were joined together to form a united defence system against invasions from the north.»","Remença DIEC2: «remença 2 f. [HIH] Dret que el senyor podia exigir del vassall subjecte a adscripció a la terra quan aquest volia abandonar-la.»"]'::jsonb, '[]'::jsonb, '[]'::jsonb, (select id from public.sources where url = 'https://european-union.europa.eu/index_es'), 'https://european-union.europa.eu/index_es', null, null, null, 'Otras normas citadas: un.org (https://www.un.org/en/about-us), Generalitat, Història de la Generalitat (https://web.gencat.cat/ca/generalitat/qui-som/historia-generalitat), UNESCO, World Heritage List (https://whc.unesco.org/en/list/), Conseil constitutionnel, DDHC 1789 (https://www.conseil-constitutionnel.fr/le-bloc-de-constitutionnalite/declaration-des-droits-de-l-homme-et-du-citoyen-de-1789), DIEC2 (https://dlc.iec.cat/)'
  from public.topics t where t.slug = 'cultcat-02-historia-espanya-mon'
on conflict (topic_id, locale) do update
   set outline = excluded.outline, key_ideas = excluded.key_ideas, glossary = excluded.glossary,
       amendments = excluded.amendments, source_id = excluded.source_id, source_url = excluded.source_url,
       page_from = excluded.page_from, page_to = excluded.page_to, key_ideas_page = excluded.key_ideas_page
 where (n.outline, n.key_ideas, n.glossary, n.amendments)
       is distinct from (excluded.outline, excluded.key_ideas, excluded.glossary, excluded.amendments);
insert into public.sources (title, url, kind, publisher, published_on) values ('Anuari estadístic de Catalunya i El municipi en xifres (Institut d''Estadística de Catalunya)', 'https://www.idescat.cat/indicadors/?id=aec&lang=ca', 'web_oficial'::public.source_kind, 'Institut d''Estadística de Catalunya (Idescat)', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('cultcat-03-geografia', 'Cultura general 3. Geografia de Catalunya, d''Espanya i del món') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('policia-local', 'guardia-urbana-barcelona') and t.slug = 'cultcat-03-geografia' on conflict do nothing;
insert into public.topic_notes as n (topic_id, locale, outline, key_ideas, glossary, amendments, source_id, source_url, page_from, page_to, key_ideas_page, review_note)
select t.id, 'ca', '[{"n":"1","title":"Relleu i rius de Catalunya (Idescat)"},{"n":"2","title":"Organització territorial: municipis i comarques"},{"n":"3","title":"Població de Catalunya i Barcelona"},{"n":"4","title":"Capitals i dades d''Europa"},{"n":"5","title":"Conceptes de geografia física i cartografia"}]'::jsonb, '["Cim més alt de Catalunya Idescat: «Pica d''Estats 3.143 Pallars Sobirà/França»","Capital de Portugal european-union.europa.eu, fitxes de país: «[Portugal] Capital: Lisboa»","Vallès Occidental, capital Idescat: «Vallès Occidental Sabadell i Terrassa Barcelona 23 970.228 Vallès Oriental Granollers»","Equador DIEC2: «equador 2 m. [FIA] [GG] [LC] Cercle màxim de l’esfera terrestre tots els punts del qual equidisten dels dos pols.»","Primer meridià DIEC2: «primer meridià Meridià que passa per l’observatori anglès de Greenwich, adoptat actualment com a origen de les longituds geogràfiques»","Delta DIEC2: «delta 1 m. [GG] [GL] [LC] Formació sedimentària dipositada per un riu en el desguàs a la mar o en un llac»","Nombre de municipis de Catalunya Idescat: «Catalunya 947 8.124.126»","Rius de les conques internes Idescat: «Muga 65 854 Castelló d''Empúries 51,9 Fluvià 97 1.125 Esponellà 144,5 Ter 208 3.010 Masies de Roda 403,0 […] Llobregat 170 4.948»","Pedraforca Idescat: «Pedraforca 2.506 Berguedà»","Turó de l''Home Idescat: «Prelitoral Turó de l''Home 1.706 Montseny Vallès Oriental»","Aran, capital Idescat: «Aran Vielha e Mijaran Lleida 9 10.651»","Comarca del Lluçanès Idescat: «Llei 7/2023, de creació de la comarca del Lluçanès, que també modifica territorialment Osona»","Països Baixos, capital european-union.europa.eu, fitxes de país: «[Países Bajos] Capital: Ámsterdam. El Parlamento y el Gobierno tienen su sede en La Haya»","Latitud DIEC2: «latitud 2 1 f. [GG] Distància d’un lloc a l’equador mesurada per l’arc de meridià que va des del dit lloc a l’equador.»","Estuari DIEC2: «estuari m. [GG] [LC] Embocadura àmplia d’un riu afectada per les marees.»","Superfície d''Espanya european-union.europa.eu, fitxes de país: «Extensión geográfica: 505 983 km2»","Població de Catalunya, 2026 Idescat: «2026 (p) 6.017.087 839.692 464.600 889.331 8.210.710 49.570.725 16,6»","Barcelonès, municipis Idescat: «Barcelonès Barcelona Barcelona 5 2.398.280»","Alta Ribagorça, capital Idescat: «Alta Ribagorça Pont de Suert, el Lleida 3 4.051»","Barcelona, superfície i població Idescat: «Barcelona Codi 080193 Comarca Barcelonès Població (2025) 1.713.247 Superfície (km²) 101,35 Densitat (hab./km²) 16.904,3»"]'::jsonb, '[]'::jsonb, '[]'::jsonb, (select id from public.sources where url = 'https://www.idescat.cat/indicadors/?id=aec&lang=ca'), 'https://www.idescat.cat/indicadors/?id=aec&lang=ca', null, null, null, 'Otras normas citadas: european-union.europa.eu, fitxes de país (https://european-union.europa.eu/principles-countries-history/eu-countries_es), DIEC2 (https://dlc.iec.cat/)'
  from public.topics t where t.slug = 'cultcat-03-geografia'
on conflict (topic_id, locale) do update
   set outline = excluded.outline, key_ideas = excluded.key_ideas, glossary = excluded.glossary,
       amendments = excluded.amendments, source_id = excluded.source_id, source_url = excluded.source_url,
       page_from = excluded.page_from, page_to = excluded.page_to, key_ideas_page = excluded.key_ideas_page
 where (n.outline, n.key_ideas, n.glossary, n.amendments)
       is distinct from (excluded.outline, excluded.key_ideas, excluded.glossary, excluded.amendments);
insert into public.sources (title, url, kind, publisher, published_on) values ('Diccionari de la llengua catalana, 2a edició (DIEC2), Institut d''Estudis Catalans', 'https://dlc.iec.cat/', 'web_oficial'::public.source_kind, 'Institut d''Estudis Catalans', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('cultcat-04-art-patrimoni', 'Cultura general 4. Art i patrimoni (estils artístics, museus i patrimoni mundial)') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('policia-local', 'guardia-urbana-barcelona') and t.slug = 'cultcat-04-art-patrimoni' on conflict do nothing;
insert into public.topic_notes as n (topic_id, locale, outline, key_ideas, glossary, amendments, source_id, source_url, page_from, page_to, key_ideas_page, review_note)
select t.id, 'ca', '[{"n":"1","title":"Estils artístics: romànic, gòtic, barroc i avantguardes"},{"n":"2","title":"Elements arquitectònics de les esglésies"},{"n":"3","title":"Modernisme i Gaudí"},{"n":"4","title":"Patrimoni mundial a Catalunya i Espanya"},{"n":"5","title":"Patrimoni mundial universal i el Guernica"}]'::jsonb, '["Guernica, autor Museo Reina Sofía, Guernica: «GUERNICA Picasso, Pablo (Pablo Ruiz Picasso)»","Romànic DIEC2: «romànic 2 1 adj. [AR] Relatiu o pertanyent a l’art, a l’estil arquitectònic, desenvolupat en diversos països de l’Europa occidental entre el preromànic i el gòtic.»","Gaudí i el modernisme Ajuntament de Barcelona, Any Gaudí: «Antoni Gaudí i Cornet, nascut el 1852, és una de les figures cabdals de l’arquitectura universal i el màxim exponent del modernisme català.»","Retaule DIEC2: «retaule 1 m. [AR] [LC] Obra d’arquitectura, amb escultures, pintures, que compon la decoració d’un altar.»","Rosassa DIEC2: «rosassa f. [AQ] [AR] [LC] Gran finestral circular, calat i vidrat, que es troba als murs de les esglésies gòtiques, especialment a la façana.»","Machu Picchu UNESCO, World Heritage List: «It was probably the most amazing urban creation of the Inca Empire at its height»","Palau de la Música i Sant Pau UNESCO, World Heritage List: «Palau de la Música Catalana and Hospital de Sant Pau, Barcelona (Date of Inscription: 1997). These are two of the finest contributions to Barcelona''s architecture by the Catalan art nouveau architect Lluís Domènech i Montaner.»","Monestir de Poblet UNESCO, World Heritage List: «This Cistercian abbey in Catalonia is one of the largest in Spain. At its centre is a 12th-century church. The austere, majestic monastery, which has a fortified royal residence and contains the pantheon of the kings of Catalonia and Aragon»","Absis DIEC2: «absis 1 m. [AQ] [AR] [LC] Part d’una església, comunament de planta semicircular, que sobresurt de la façana posterior i que conté un altar.»","Guernica, encàrrec Museo Reina Sofía, Guernica: «el lienzo Guernica nació para formar parte del Pabellón Español en la Exposición Internacional de París, de 1937.»","Impressionisme DIEC2: «impressionisme m. [AR] [LC] Corrent estètic, especialment pictòric, iniciat i desenvolupat sobretot a França, que se centra en el paisatge o en els temes quotidians i cerca de donar la impressió immediata produïda a l’artista per la vista dels objectes.»","Cubisme DIEC2: «cubisme m. [AR] [LC] Moviment artístic que considera el volum com l’atribut important dels objectes i tracta d’expressar-lo plàsticament per mitjà tan sols de figures i sòlids geomètrics.»","Taj Mahal UNESCO, World Heritage List: «An immense mausoleum of white marble, built in Agra between 1631 and 1648 by order of the Mughal emperor Shah Jahan in memory of his favourite wife»","Petra UNESCO, World Heritage List: «Inhabited since prehistoric times, this Nabataean caravan-city, situated between the Red Sea and the Dead Sea»","Llotja de la Seda de València UNESCO, World Heritage List: «It is a masterpiece of late Gothic architecture.»","Guernica, retorn a Espanya Museo Reina Sofía, Guernica: «regresando la obra finalmente a nuestro país en el año 1981.»","Surrealisme DIEC2: «surrealisme m. [AR] [FLL] [FS] Moviment literari, artístic i filosòfic, sorgit a França l’any 1924»","Acròpoli d''Atenes UNESCO, World Heritage List: «an exceptional group of artists put into effect the ambitious plans of Athenian statesman Pericles and, under the inspired guidance of the sculptor Pheidias»","Obres de Gaudí, patrimoni mundial UNESCO, World Heritage List: «The seven buildings are: Parque Güell; Palacio Güell; Casa Mila; Casa Vicens; Gaudí’s work on the Nativity façade and Crypt of La Sagrada Familia; Casa Batlló Crypt in Colonia Güell.»","Barroc DIEC2: «barroc 1 1 adj. [AQ] [AR] [LC] Relatiu o pertanyent a un estil artístic, evolució complexa del Renaixement, aparegut a Itàlia a les darreries del segle xvi i predominant a Europa fins gran part del segle xviii.»"]'::jsonb, '[]'::jsonb, '[]'::jsonb, (select id from public.sources where url = 'https://dlc.iec.cat/'), 'https://dlc.iec.cat/', null, null, null, 'Otras normas citadas: Museo Reina Sofía, Guernica (https://www.museoreinasofia.es/colecciones/obra/guernica), Ajuntament de Barcelona, Any Gaudí (https://ajuntament.barcelona.cat/premsa/2026/06/07/barcelona-ret-homenatge-a-antoni-gaudi-amb-una-placa-en-el-mateix-punt-on-va-ser-atropellat-lany-1926/), UNESCO, World Heritage List (https://whc.unesco.org/en/list/)'
  from public.topics t where t.slug = 'cultcat-04-art-patrimoni'
on conflict (topic_id, locale) do update
   set outline = excluded.outline, key_ideas = excluded.key_ideas, glossary = excluded.glossary,
       amendments = excluded.amendments, source_id = excluded.source_id, source_url = excluded.source_url,
       page_from = excluded.page_from, page_to = excluded.page_to, key_ideas_page = excluded.key_ideas_page
 where (n.outline, n.key_ideas, n.glossary, n.amendments)
       is distinct from (excluded.outline, excluded.key_ideas, excluded.glossary, excluded.amendments);
insert into public.sources (title, url, kind, publisher, published_on) values ('Patrimoni Cultural de la Generalitat de Catalunya: col·leccions (Jacint Verdaguer, Salvador Espriu, Joan Maragall, Josep Pla) i històries del patrimoni', 'https://patrimoni.gencat.cat/ca/coleccio/jacint-verdaguer', 'web_oficial'::public.source_kind, 'Generalitat de Catalunya, Departament de Cultura (Patrimoni Cultural)', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('cultcat-05-literatura', 'Cultura general 5. Literatura catalana, castellana i universal') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('policia-local', 'guardia-urbana-barcelona') and t.slug = 'cultcat-05-literatura' on conflict do nothing;
insert into public.topic_notes as n (topic_id, locale, outline, key_ideas, glossary, amendments, source_id, source_url, page_from, page_to, key_ideas_page, review_note)
select t.id, 'ca', '[{"n":"1","title":"Literatura catalana medieval: Tirant lo Blanc"},{"n":"2","title":"Renaixença, modernisme i noucentisme"},{"n":"3","title":"Autors catalans: Verdaguer, Maragall, Espriu, Pla"},{"n":"4","title":"Premis Nobel i Premi Cervantes"},{"n":"5","title":"Gèneres i formes: sonet i faula"}]'::jsonb, '["Tirant lo Blanc, autor Patrimoni.gencat: «El protagonista de la novela ''Tirant Lo Blanc'', obra del valenciano Joanot Martorell»","Verdaguer, Canigó Patrimoni.gencat: «va ser quan va escriure dos dels seus poemes més importants: L’Atlàntida (1877) i Canigó (1886)»","García Márquez, Nobel 1982 NobelPrize.org: «Gabriel García Márquez Nobel Prize in Literature 1982 Born: 6 March 1927, Aracataca, Colombia»","Renaixença DIEC2: «renaixença 2 f. [FLL] Moviment cultural vuitcentista promotor de la recuperació de la llengua i la literatura catalanes.»","Sonet DIEC2: «sonet 1 m. [FLL] [LC] Composició poètica formada per dos quartets amb dues soles rimes i dos tercets.»","Faula DIEC2: «faula 2 2 f. [FLL] [LC] Narració en què es dona un ensenyament útil o moral, per mitjà d’una ficció al·legòrica en què intervenen animals i àdhuc éssers inanimats parlant i obrant com si fossin éssers humans o racionals.»","Espriu, Sinera Patrimoni.gencat: «Aquest poble del Maresme va ser la seva “petita pàtria” i apareix mitificat en la seva obra com a Sinera (Arenys al revés).»","Josep Pla, Palafrugell Patrimoni.gencat: «Fill d’una família de petits propietaris rurals de Palafrugell, va estudiar dret a la Universitat de Barcelona.»","Joan Maragall Patrimoni.gencat: «Joan Maragall és una de les figures cabdals de la poesia modernista, tot i que també va cultivar la prosa.»","Verdaguer, Folgueroles Patrimoni.gencat: «Fill d’un mestre i pagès modest de Folgueroles (Osona), va ingressar al seminari de Vic el 1855.»","Tirant lo Blanc, Carmesina Patrimoni.gencat: «Carmesina es hija del emperador, y su doncella Plaerdemavida ayudará a Tirant Lo Blanc a conquistarla.»","Juan Ramón Jiménez, Nobel 1956 NobelPrize.org: «Juan Ramón Jiménez Nobel Prize in Literature 1956 Born: 24 December 1881, Moguer, Spain»","Cela, Nobel 1989 NobelPrize.org: «Camilo José Cela Nobel Prize in Literature 1989 Born: 11 May 1916, Iria Flavia, Spain»","Premi Cervantes Ministerio de Cultura, Premio Cervantes: «Puede ser galardonado con el Premio Cervantes cualquier autor o autora cuya obra literaria esté escrita totalmente, o en parte esencial, en castellano.»","Noucentisme DIEC2: «noucentisme m. [HIH] Moviment cultural d’abast polític iniciat a Catalunya a la primeria del segle xx.»","Espriu, La pell de brau Patrimoni.gencat: «La consagració va arribar amb La pell de Brau (1960), una al·legoria crítica amb l''Espanya de la postguerra»","Verdaguer, Jocs Florals Patrimoni.gencat: «amb només 20 anys, Jacint Verdaguer (1845 –1902) va guanyar els seus primers Jocs Florals i va anar a recollir el premi vestit de pagès.»","Vargas Llosa NobelPrize.org: «Mario Vargas Llosa Nobel Prize in Literature 2010 Born: 28 March 1936, Arequipa, Peru Died: 13 April 2025, Lima, Peru»","Joan Margarit, Premi Cervantes 2019 Ministerio de Cultura, Premio Cervantes: «2019 Joan Margarit»","Aleixandre, Nobel 1977 NobelPrize.org: «Vicente Aleixandre Nobel Prize in Literature 1977 Born: 26 April 1898, Sevilla, Spain»"]'::jsonb, '[]'::jsonb, '[]'::jsonb, (select id from public.sources where url = 'https://patrimoni.gencat.cat/ca/coleccio/jacint-verdaguer'), 'https://patrimoni.gencat.cat/ca/coleccio/jacint-verdaguer', null, null, null, 'Otras normas citadas: NobelPrize.org (https://www.nobelprize.org/all-nobel-prizes-2025/), DIEC2 (https://dlc.iec.cat/), Ministerio de Cultura, Premio Cervantes (https://www.cultura.gob.es/actualidad/2025/11/251103-premio-cervantes-2025.html)'
  from public.topics t where t.slug = 'cultcat-05-literatura'
on conflict (topic_id, locale) do update
   set outline = excluded.outline, key_ideas = excluded.key_ideas, glossary = excluded.glossary,
       amendments = excluded.amendments, source_id = excluded.source_id, source_url = excluded.source_url,
       page_from = excluded.page_from, page_to = excluded.page_to, key_ideas_page = excluded.key_ideas_page
 where (n.outline, n.key_ideas, n.glossary, n.amendments)
       is distinct from (excluded.outline, excluded.key_ideas, excluded.glossary, excluded.amendments);
insert into public.sources (title, url, kind, publisher, published_on) values ('Diccionari de la llengua catalana, 2a edició (DIEC2), Institut d''Estudis Catalans', 'https://dlc.iec.cat/', 'web_oficial'::public.source_kind, 'Institut d''Estudis Catalans', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('cultcat-06-llengua-catalana', 'Cultura general 6. Llengua: gramàtica, lèxic i recursos literaris') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('policia-local', 'guardia-urbana-barcelona') and t.slug = 'cultcat-06-llengua-catalana' on conflict do nothing;
insert into public.topic_notes as n (topic_id, locale, outline, key_ideas, glossary, amendments, source_id, source_url, page_from, page_to, key_ideas_page, review_note)
select t.id, 'ca', '[{"n":"1","title":"Categories gramaticals"},{"n":"2","title":"Formació de mots: sigles, acrònims, prefixos"},{"n":"3","title":"Relacions semàntiques: sinonímia, antonímia, homonímia"},{"n":"4","title":"Figures retòriques"},{"n":"5","title":"Fonètica i ortografia: diftong, dièresi, apòstrof, accentuació"}]'::jsonb, '["Metàfora DIEC2: «metàfora f. [FL] [FLL] [LC] Figura retòrica que consisteix a emprar un mot que expressa literalment una cosa per a expressar-ne una altra que té una certa semblança amb aquella.»","Sinònim DIEC2: «Els termes llevant i est són mots sinònims.»","Antònim DIEC2: «antònim -a 1 adj. [FL] [LC] Que té un significat directament oposat al d’un altre mot.»","Onomatopeia DIEC2: «onomatopeia 1 f. [FL] [LC] Formació de mots a partir de la imitació de sons naturals.»","Monosíl·lab DIEC2: «monosíl·lab -a 1 2 m. [FL] [FLL] [LC] Mot d’una sola síl·laba.»","Adjectiu qualificatiu DIEC2: «adjectiu qualificatiu Adjectiu que expressa alguna qualitat del substantiu amb què es relaciona i sovint en restringeix l’extensió.»","Sigla DIEC2: «sigla 3 1 f. [FL] [LC] Mot format per les lletres inicials dels components d’un sintagma o d’un compost, que manté les propietats sintàctiques i el significat del sintagma o del mot originals. La sigla IEC és la manera abreujada de referir-nos a l’Institut d’Estudis Catalans.»","Acrònim DIEC2: «Els mots boirum i cantautor són acrònims formats a partir de boira i fum i de cantant i autor, respectivament.»","Hipèrbole DIEC2: «hipèrbole 1 f. [FLL] [LC] Figura retòrica que consisteix a substituir el terme propi per un altre que n’augmenta o en redueix la designació d’una manera exagerada.»","Personificació DIEC2: «personificació 2 f. [FLL] Figura retòrica que consisteix en l’atribució de qualitats humanes a animals, coses o conceptes.»","Gentilici DIEC2: «gentilici 2 1 adj. [FL] [LC] Que denota la nació o la pàtria d’una persona. Adjectiu gentilici.»","Prefix DIEC2: «prefix 1 m. [FL] [LC] Afix que precedeix un radical o un mot.»","Apòstrof DIEC2: «apòstrof m. [FL] [LC] Signe gràfic consistent en una coma volada (’), que serveix per a assenyalar l’elisió d’algunes lletres.»","Dièresi DIEC2: «dièresi 1 2 f. [FL] [LC] Signe gràfic consistent en dos punts col·locats sobre una vocal (¨)»","Esdrúixol DIEC2: «esdrúixol -a adj. [FL] [FLL] [LC] Proparoxíton 1. La paraula fórmula és esdrúixola.»","Metonímia DIEC2: «metonímia f. [FL] [FLL] [LC] Figura retòrica que consisteix a designar una cosa amb el nom d’una altra amb la qual manté una relació necessària, com ara l’efecte per la causa, el contingut pel continent, etc., o viceversa.»","Homònim DIEC2: «La forma d’infinitiu dur i l’adjectiu masculí singular dur són mots homònims.»","Al·literació DIEC2: «al·literació 1 f. [FL] [FLL] Figura retòrica que consisteix a repetir un mateix so en dos o més mots consecutius o situats a intervals curts.»","Diftong DIEC2: «diftong 1 m. [FL] [LC] Grup fònic format per una vocal i una semivocal o semiconsonant pronunciades dins una mateixa síl·laba.»","Conjunció DIEC2: «conjunció 3 2 f. [FL] [LC] Categoria lèxica constituïda per mots invariables que relacionen dos mots o grups de mots d’idèntica funció sintàctica o bé dues oracions coordinades o subordinades.»"]'::jsonb, '[]'::jsonb, '[]'::jsonb, (select id from public.sources where url = 'https://dlc.iec.cat/'), 'https://dlc.iec.cat/', null, null, null, null
  from public.topics t where t.slug = 'cultcat-06-llengua-catalana'
on conflict (topic_id, locale) do update
   set outline = excluded.outline, key_ideas = excluded.key_ideas, glossary = excluded.glossary,
       amendments = excluded.amendments, source_id = excluded.source_id, source_url = excluded.source_url,
       page_from = excluded.page_from, page_to = excluded.page_to, key_ideas_page = excluded.key_ideas_page
 where (n.outline, n.key_ideas, n.glossary, n.amendments)
       is distinct from (excluded.outline, excluded.key_ideas, excluded.glossary, excluded.amendments);
insert into public.sources (title, url, kind, publisher, published_on) values ('Diccionari de la llengua catalana, 2a edició (DIEC2), Institut d''Estudis Catalans', 'https://dlc.iec.cat/', 'web_oficial'::public.source_kind, 'Institut d''Estudis Catalans', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('cultcat-07-ciencies', 'Cultura general 7. Ciències: física, química, biologia, ciències de la Terra i medi ambient') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('policia-local', 'guardia-urbana-barcelona') and t.slug = 'cultcat-07-ciencies' on conflict do nothing;
insert into public.topic_notes as n (topic_id, locale, outline, key_ideas, glossary, amendments, source_id, source_url, page_from, page_to, key_ideas_page, review_note)
select t.id, 'ca', '[{"n":"1","title":"Física: energia, unitats del SI, canvis d''estat"},{"n":"2","title":"Química: elements i símbols, molècules"},{"n":"3","title":"Biologia: cèl·lula, éssers vius, cos humà"},{"n":"4","title":"Ciències de la Terra: geologia i atmosfera"},{"n":"5","title":"Medi ambient"}]'::jsonb, '["Cèl·lula DIEC2: «cèl·lula 1 1 f. [BI] [LC] Unitat estructural i funcional dels éssers vius»","Fotosíntesi DIEC2: «fotosíntesi 1 f. [BI] [EG] Assimilació d’anhídrid carbònic per un procés que depèn de la llum. 3 [BI] fotosíntesi vegetal Fotosíntesi que utilitza l’aigua com a font de poder reductor i lliura oxigen.»","Vacuna DIEC2: «vacuna f. [LC] [MD] Preparat que estimula la formació d’anticossos, amb la qual cosa hom aconsegueix immunització contra diverses infeccions.»","Or, símbol DIEC2: «(símbol, Au; nombre atòmic, 79; pes atòmic, 196,97)»","Molècula d''aigua DIEC2: «La molècula d’aigua està formada per dos àtoms d’hidrogen i un d’oxigen.»","Mamífers DIEC2: «mamífer 2 1 m. pl. [LC] [ZOM] Classe d’animals del grup dels cordats vertebrats, que tenen glàndules mamàries»","Energia cinètica DIEC2: «cinètic -a 1 adj. [FIF] Relatiu o pertanyent al moviment. Teoria cinètica dels gasos. 2 adj. [FIF] Degut al moviment. Energia cinètica.»","Watt DIEC2: «watt 1 m. [FIF] [FIM] [LC] Unitat de potència del sistema internacional, equivalent a 1 joule per segon (símbol, W).»","Newton DIEC2: «newton m. [FIM] Unitat de força del sistema internacional»","Condensació DIEC2: «condensació 1 2 f. [FIF] [IQ] Pas d’una substància de l’estat de vapor a l’estat líquid.»","Sinapsi DIEC2: «sinapsi 1 f. [MD] [ZOA] Regió de comunicació i de transmissió d’impulsos nerviosos entre les neurones o entre una neurona motora i el múscul.»","Amfibis DIEC2: «que inclou les granotes, els gripaus, els tritons i les salamandres.»","Troposfera DIEC2: «troposfera f. [ME] Capa de l’atmosfera terrestre situada entre la superfície de la Terra i la tropopausa, que s’estén fins a uns 10 o 17 quilòmetres d’altitud segons la latitud, i on la temperatura decreix gradualment amb l’altitud.»","Ozó DIEC2: «ozó m. [FIF] [LC] [ME] [QU] Gas blavós d’olor característica, de fórmula O3, fortament absorbent de la radiació ultraviolada de longitud d’ona curta, que és un estat al·lotròpic de l’oxigen (O2).»","Estalactita DIEC2: «estalactita f. [GL] [LC] Concreció generalment calcària i de forma cilíndrica, amb un canalicle paral·lel a l’eix longitudinal, originada per un degotall, que penja de la volta de les coves.»","Fusió nuclear DIEC2: «fusió nuclear Reacció nuclear en què es formen nous nuclis atòmics per associació d’altres de més lleugers amb pèrdua de massa, pèrdua que es manifesta amb l’alliberament de grans quantitats d’energia.»","Subducció DIEC2: «subducció f. [GL] Enfonsament de gran amplitud d’una placa litosfèrica sota d’una altra.»","Gota freda DIEC2: «gota freda Depressió atmosfèrica freda en altura les característiques de la qual s’originen en la circulació de la troposfera mitjana o alta i que en superfície no es correspon amb una zona depressionària.»","Mercuri DIEC2: «mercuri m. [LC] [ML] [QU] Metall líquid a la temperatura ordinària, molt pesant, de color blanc d’argent (símbol, Hg»","Ohm DIEC2: «ohm 1 m. [FIM] Unitat de resistència elèctrica del sistema internacional»"]'::jsonb, '[]'::jsonb, '[]'::jsonb, (select id from public.sources where url = 'https://dlc.iec.cat/'), 'https://dlc.iec.cat/', null, null, null, null
  from public.topics t where t.slug = 'cultcat-07-ciencies'
on conflict (topic_id, locale) do update
   set outline = excluded.outline, key_ideas = excluded.key_ideas, glossary = excluded.glossary,
       amendments = excluded.amendments, source_id = excluded.source_id, source_url = excluded.source_url,
       page_from = excluded.page_from, page_to = excluded.page_to, key_ideas_page = excluded.key_ideas_page
 where (n.outline, n.key_ideas, n.glossary, n.amendments)
       is distinct from (excluded.outline, excluded.key_ideas, excluded.glossary, excluded.amendments);
insert into public.sources (title, url, kind, publisher, published_on) values ('Diccionari de la llengua catalana, 2a edició (DIEC2), Institut d''Estudis Catalans', 'https://dlc.iec.cat/', 'web_oficial'::public.source_kind, 'Institut d''Estudis Catalans', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('cultcat-08-matematiques', 'Cultura general 8. Matemàtiques: aritmètica, geometria i estadística bàsiques') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('policia-local', 'guardia-urbana-barcelona') and t.slug = 'cultcat-08-matematiques' on conflict do nothing;
insert into public.topic_notes as n (topic_id, locale, outline, key_ideas, glossary, amendments, source_id, source_url, page_from, page_to, key_ideas_page, review_note)
select t.id, 'ca', '[{"n":"1","title":"Aritmètica: percentatges, fraccions, divisibilitat"},{"n":"2","title":"Geometria: figures, perímetre, Pitàgores"},{"n":"3","title":"Estadística: mitjana, moda i probabilitat"},{"n":"4","title":"Àlgebra: equacions i propietats"},{"n":"5","title":"Calendari i xifres romanes"}]'::jsonb, '["Perímetre DIEC2: «perímetre 1 1 m. [LC] [MT] Contorn d’una figura plana.»","Diàmetre DIEC2: «El diàmetre d’un cercle val tant com dos radis.»","Hexàgon DIEC2: «hexàgon m. [MT] Polígon de sis angles i de sis costats.»","Any de traspàs DIEC2: «any 3 5 [FIA] any comú Any civil que consta de 365 dies. 3 6 [FIA] [LC] any de traspàs Any civil que consta de 366 dies.»","Percentatge DIEC2: «percentatge m. [LC] [MT] Tant per cent.»","Triangle equilàter DIEC2: «equilàter -a adj. [LC] [MT] Que té tots els costats iguals.»","Hipotenusa DIEC2: «hipotenusa f. [LC] [MT] Costat d’un triangle rectangle oposat a l’angle recte. El quadrat de la hipotenusa és igual a la suma dels quadrats dels catets.»","Isòsceles DIEC2: «isòsceles adj. [LC] [MT] Que té dos costats iguals, s’aplica als triangles o als trapezis.»","Moda estadística DIEC2: «moda 2 f. [MT] En estad., valor de l’observació més freqüent en un conjunt de dades.»","Mitjana aritmètica DIEC2: «mitjà2 -ana 2 adj. [LC] [MT] Que correspon a la mitjana aritmètica, s’aplica a noms que expressen quantitat.»","Múltiple DIEC2: «El nombre 12 és un múltiple de 4.»","Quadrat d''un nombre DIEC2: «quadrar 1 3 v. tr. [MT] Elevar (un nombre) al quadrat, multiplicar-lo per ell mateix.»","Pentàgon DIEC2: «pentàgon m. [MT] Polígon de cinc angles i de cinc costats.»","Xifra romana DIEC2: «xifra romana Lletra majúscula emprada pels romans per a representar els nombres: I, V, X, L, C, D, M.»","Circumferència DIEC2: «circumferència 1 1 f. [LC] [MT] Corba plana els punts de la qual equidisten tots d’un punt interior, el centre.»","Propietat commutativa DIEC2: «commutatiu -iva 3 1 adj. [MT] En què l’ordre dels elements no canvia el resultat, s’aplica a operacions aritmètiques. La suma i el producte de nombres reals són commutatius.»","Equació DIEC2: «equació 2 1 f. [MT] En mat., igualtat entre dues expressions que contenen una o més incògnites.»","Probabilitat DIEC2: «probabilitat 2 f. [MT] Concepte que permet d’expressar quantitativament el caràcter aleatori d’un esdeveniment o fenomen que hom creu que pot succeir.»","Màxim comú divisor DIEC2: «divisor comú Nombre que és divisor de dues o més quantitats alhora. El més gran divisor comú de 16 i 20 és 4.»","Fracció DIEC2: «fracció 2 2 f. [LC] [MT] En mat., una o més parts alíquotes de la unitat.»"]'::jsonb, '[]'::jsonb, '[]'::jsonb, (select id from public.sources where url = 'https://dlc.iec.cat/'), 'https://dlc.iec.cat/', null, null, null, null
  from public.topics t where t.slug = 'cultcat-08-matematiques'
on conflict (topic_id, locale) do update
   set outline = excluded.outline, key_ideas = excluded.key_ideas, glossary = excluded.glossary,
       amendments = excluded.amendments, source_id = excluded.source_id, source_url = excluded.source_url,
       page_from = excluded.page_from, page_to = excluded.page_to, key_ideas_page = excluded.key_ideas_page
 where (n.outline, n.key_ideas, n.glossary, n.amendments)
       is distinct from (excluded.outline, excluded.key_ideas, excluded.glossary, excluded.amendments);
insert into public.sources (title, url, kind, publisher, published_on) values ('Constitución Española (texto consolidado, BOE)', 'https://www.boe.es/buscar/act.php?id=BOE-A-1978-31229', 'boe'::public.source_kind, 'Agencia Estatal Boletín Oficial del Estado', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('cultcat-09-institucions-economia', 'Cultura general 9. Institucions (Catalunya, Espanya, UE, ONU) i economia bàsica') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('policia-local', 'guardia-urbana-barcelona') and t.slug = 'cultcat-09-institucions-economia' on conflict do nothing;
insert into public.topic_notes as n (topic_id, locale, outline, key_ideas, glossary, amendments, source_id, source_url, page_from, page_to, key_ideas_page, review_note)
select t.id, 'ca', '[{"n":"1","title":"Constitució espanyola: forma d''Estat, Corts i Tribunal Constitucional"},{"n":"2","title":"Estatut d''autonomia: capital, llengua, Parlament i President"},{"n":"3","title":"Sistema electoral (Idescat)"},{"n":"4","title":"Unió Europea i ONU"},{"n":"5","title":"Conceptes d''economia"}]'::jsonb, '["CE art. 1.3, forma política CE: «La forma política del Estado español es la Monarquía parlamentaria.»","EAC art. 10, capital EAC: «La capital de Cataluña es la ciudad de Barcelona, que es la sede permanente del Parlamento, de la Presidencia de la Generalitat y del Gobierno»","EAC art. 6.1, llengua pròpia EAC: «La lengua propia de Cataluña es el catalán.»","Inflació DIEC2: «inflació 2 1 f. [ECT] [LC] Increment generalitzat i persistent dels preus de les mercaderies i els serveis que implica una reducció del poder adquisitiu del diner.»","Euro DIEC2: «euro 1 m. [ECT] [LC] Unitat monetària comuna dels estats de la Unió Europea que participen en la unió econòmica i monetària.»","CE art. 66.1, Corts Generals CE: «Las Cortes Generales representan al pueblo español y están formadas por el Congreso de los Diputados y el Senado.»","EAC art. 56.1, Parlament EAC: «El Parlamento se compone de un mínimo de cien Diputados y un máximo de ciento cincuenta, elegidos para un plazo de cuatro años»","Parlament de Catalunya, escons Idescat: «Total escons 2021 85 17 15 18 135»","Regla d''Hondt i llindar electoral Idescat: «Hi ha uns percentatges mínims (3% per a les eleccions al Parlament de Catalunya i a les legislatives i 5% per a les locals)»","CE art. 68.1, Congrés CE: «El Congreso se compone de un mínimo de 300 y un máximo de 400 Diputados»","CE art. 69.1, Senat CE: «El Senado es la Cámara de representación territorial.»","EAC art. 67.4, nomenament del president EAC: «El Presidente o Presidenta de la Generalitat es nombrado por el Rey.»","Comissió Europea european-union.europa.eu: «La Comisión Europea es el órgano ejecutivo, políticamente independiente, de la UE. Es la única instancia responsable de elaborar propuestas de nueva legislación europea»","Parlament Europeu european-union.europa.eu: «Es elegido directamente por los votantes de la UE cada cinco años.»","Consell de Seguretat de l''ONU un.org: «It has 15 Members (5 permanent and 10 non-permanent members).»","CE art. 159, Tribunal Constitucional CE: «Los miembros del Tribunal Constitucional serán designados por un período de nueve años y se renovarán por terceras partes cada tres.»","CE art. 137, organització territorial CE: «El Estado se organiza territorialmente en municipios, en provincias y en las Comunidades Autónomas que se constituyan.»","Zona euro european-union.europa.eu: «Hoy en día, el euro (€) es la moneda oficial de 21 de los 27 países de la UE»","Andorra a l''ONU un.org: «Andorra Date of Admission: 28-07-1993»","Consell d''Europa Consell de la UE, presidència irlandesa 2026: «The Council of Europe is not an EU institution. It is a separate international organisation, founded in 1949, that promotes democracy, human rights, and the rule of law across its 46 member countries.»"]'::jsonb, '[]'::jsonb, '[]'::jsonb, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1978-31229'), 'https://www.boe.es/buscar/act.php?id=BOE-A-1978-31229', null, null, null, 'Otras normas citadas: EAC (https://www.boe.es/buscar/act.php?id=BOE-A-2006-13087), DIEC2 (https://dlc.iec.cat/), Idescat (https://www.idescat.cat/indicadors/?id=aec&lang=ca), european-union.europa.eu (https://european-union.europa.eu/index_es), un.org (https://www.un.org/en/about-us), Consell de la UE, presidència irlandesa 2026 (https://irish-presidency.consilium.europa.eu/en/presidency/presidency-of-the-council-of-the-eu/)'
  from public.topics t where t.slug = 'cultcat-09-institucions-economia'
on conflict (topic_id, locale) do update
   set outline = excluded.outline, key_ideas = excluded.key_ideas, glossary = excluded.glossary,
       amendments = excluded.amendments, source_id = excluded.source_id, source_url = excluded.source_url,
       page_from = excluded.page_from, page_to = excluded.page_to, key_ideas_page = excluded.key_ideas_page
 where (n.outline, n.key_ideas, n.glossary, n.amendments)
       is distinct from (excluded.outline, excluded.key_ideas, excluded.glossary, excluded.amendments);
commit;
