-- Temario Mossos, àmbit B (Guia d'estudi 2026, catalán).
-- Todo entra como BORRADOR (status draft). Nada se publica hasta aprobarlo en el panel.
-- Idempotente: se puede ejecutar más de una vez. Requiere haber ejecutado antes 1-, 2-, 3- y 4-.
begin;
-- Lote mossos-b2-institucions-catalunya-guia-v1 (20 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Guia d''estudi per accedir a la PG-ME, 1a edició, juny de 2026 (convocatòria 46/26), tema B.2, pp. 107-117', 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=107', 'web_oficial'::public.source_kind, 'Generalitat de Catalunya · Mossos d''Esquadra (web oficial de la convocatòria 46/26)', '2026-06-01') on conflict (url) do nothing;
insert into public.topics (slug, title) values ('mossos-b2-institucions-catalunya', 'B.2 Les institucions polítiques de Catalunya') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug = 'mossos-esquadra' and t.slug = 'mossos-b2-institucions-catalunya' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, quines institucions comprèn bàsicament la Generalitat de Catalunya?', 'La Generalitat és el complex institucional de l’autogovern i comprèn bàsicament el Parlament, la Presidència i el Govern; en queden fora els òrgans de l’Estat i els de l’autonomia local.', 'mossos_b2_institucions_catalunya', (select id from public.topics where slug = 'mossos-b2-institucions-catalunya'), 1, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=107'), 'Guia p. 108, §1', 'la Generalitat, com va succeir també durant la Segona República espanyola, és el complex institucional de Catalunya, que comprèn bàsicament el Parlament, la Presidència de la Generalitat i el Govern.', null, '48953de6cd90f5746e97120a2da050b75bbac7f364644cd2fac9d24b55a84a02', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '48953de6cd90f5746e97120a2da050b75bbac7f364644cd2fac9d24b55a84a02')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El Parlament, el Govern i el Tribunal Superior de Justícia de Catalunya.', false), ('B', 'El Parlament, el Govern i els consells comarcals.', false), ('C', 'La Presidència, el Govern i el Síndic de Greuges.', false), ('D', 'El Parlament, la Presidència de la Generalitat i el Govern.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, quin òrgan medieval evoca el nom de Generalitat?', 'El nom evoca la Diputació del General, que representava els interessos de les Corts Catalanes i els defensava davant el rei quan no estaven reunides.', 'mossos_b2_institucions_catalunya', (select id from public.topics where slug = 'mossos-b2-institucions-catalunya'), 2, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=107'), 'Guia p. 108, §1', 'el nom de Generalitat evoca un òrgan medieval de caràcter politicoadministratiu i financer, denominat també Diputació del General, que representava els interessos de les Corts Catalanes', null, '4cf87dbae8795610e641569b86f0f4d5857cf8dc42d1d6a095b981828c327aaf', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '4cf87dbae8795610e641569b86f0f4d5857cf8dc42d1d6a095b981828c327aaf')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'La Diputació del General, de caràcter politicoadministratiu i financer.', true), ('B', 'El Consell de Cent.', false), ('C', 'La Reial Audiència de Catalunya.', false), ('D', 'Les Corts Catalanes, com a assemblea legislativa.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, quan s’entén atorgada la qüestió de confiança plantejada pel president o presidenta de la Generalitat?', 'La qüestió de confiança s’entén atorgada per majoria simple dels vots emesos; en canvi, la moció de censura (constructiva) requereix la majoria absoluta.', 'mossos_b2_institucions_catalunya', (select id from public.topics where slug = 'mossos-b2-institucions-catalunya'), 3, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=107'), 'Guia p. 108, §1', 'de la qüestió de confiança que s’entén atorgada si el president o presidenta de la Generalitat obté la majoria simple dels vots emesos', null, 'af9c78b9cd54e168f7ce52cb896eb029a71f7f940032a2a6ecdff7b961cbb140', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'af9c78b9cd54e168f7ce52cb896eb029a71f7f940032a2a6ecdff7b961cbb140')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Quan obté la majoria absoluta dels diputats.', false), ('B', 'Quan obté la majoria simple dels vots emesos.', true), ('C', 'Quan obté la majoria de tres cinquenes parts del Parlament.', false), ('D', 'Quan no prospera cap moció de censura en els dos mesos següents.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, entre quin nombre mínim i màxim de diputats pot estar compost el Parlament de Catalunya?', 'El Parlament el componen un mínim de cent i un màxim de cent cinquanta diputats; actualment en té 135.', 'mossos_b2_institucions_catalunya', (select id from public.topics where slug = 'mossos-b2-institucions-catalunya'), 2, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=107'), 'Guia p. 109, §2', 'es compon d’una única cambra i la componen un mínim de cent diputats i un màxim de cent cinquanta, elegits per a un termini de quatre anys', null, '41fc57c4936583e7ad72bc0a476437aaf790086a753d0af2bb49dc55dc69e154', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '41fc57c4936583e7ad72bc0a476437aaf790086a753d0af2bb49dc55dc69e154')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Entre 100 i 135 diputats.', false), ('B', 'Entre 120 i 150 diputats.', false), ('C', 'Entre 100 i 150 diputats.', true), ('D', 'Entre 135 i 150 diputats.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, quants diputats elegeix actualment la circumscripció de Girona?', 'Dels 135 diputats, Barcelona n’elegeix 85, Tarragona 18, Girona 17 i Lleida 15.', 'mossos_b2_institucions_catalunya', (select id from public.topics where slug = 'mossos-b2-institucions-catalunya'), 2, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=107'), 'Guia p. 109, §2', 'integrada per 135 diputats dels quals 18 són elegits per la circumscripció de Tarragona, 17 per la de Girona, 15 per la de Lleida i 85 per la de Barcelona.', null, 'd1d9f8c2c66d1c38c374f31ff80c9ff206f13c6bfbc463287964c902208df523', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'd1d9f8c2c66d1c38c374f31ff80c9ff206f13c6bfbc463287964c902208df523')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', '15 diputats.', false), ('B', '17 diputats.', true), ('C', '18 diputats.', false), ('D', '21 diputats.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, quins àmbits inclou el principi d’autonomia parlamentària reconegut a l’article 58 de l’EAC?', 'L’article 58 de l’EAC reconeix l’autonomia organitzativa, financera, administrativa i disciplinària del Parlament.', 'mossos_b2_institucions_catalunya', (select id from public.topics where slug = 'mossos-b2-institucions-catalunya'), 2, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=107'), 'Guia p. 109, §3', 'L’article 58 de l’EAC reconeix el principi d’autonomia parlamentària, que inclou l’autonomia organitzativa, financera, administrativa i disciplinària.', null, 'e5965fc8c09962e76aaa1b67758e68a20fd8404e03e3b2f821168244a6edf45b', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'e5965fc8c09962e76aaa1b67758e68a20fd8404e03e3b2f821168244a6edf45b')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Legislatiu, executiu, judicial i electoral.', false), ('B', 'Pressupostari, tributari, sancionador i electoral.', false), ('C', 'Representatiu, legislatiu, de control i de participació.', false), ('D', 'Organitzatiu, financer, administratiu i disciplinari.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, què succeeix si, en el procediment d’investidura, transcorren dos mesos a comptar des de la primera votació i cap candidat no ha obtingut la confiança del Parlament?', 'La manca d’investidura en dos mesos des de la primera votació provoca la dissolució automàtica del Parlament i la convocatòria de noves eleccions.', 'mossos_b2_institucions_catalunya', (select id from public.topics where slug = 'mossos-b2-institucions-catalunya'), 3, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=107'), 'Guia p. 109, §5', 'si transcorren dos mesos –a comptar des de la primera votació– i cap candidat no ha obtingut la confiança del Parlament, aquest serà dissolt automàticament i es convocaran noves eleccions.', null, '83e8b003d912e74a977e70587af025ec138ed403020d8d95ee3377c21e892191', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '83e8b003d912e74a977e70587af025ec138ed403020d8d95ee3377c21e892191')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El president del Parlament esdevé president de la Generalitat en funcions.', false), ('B', 'És investit el candidat del grup parlamentari amb més diputats.', false), ('C', 'El Parlament és dissolt automàticament i es convoquen noves eleccions.', true), ('D', 'La Diputació Permanent elegeix el president o presidenta de la Generalitat.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, quin tribunal és competent per determinar la inculpació, la presó, el processament i el judici d’un diputat del Parlament per actes delictius comesos fora del territori de Catalunya?', 'Pels delictes comesos a Catalunya és competent el TSJC; fora de Catalunya, la Sala Penal del Tribunal Suprem.', 'mossos_b2_institucions_catalunya', (select id from public.topics where slug = 'mossos-b2-institucions-catalunya'), 2, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=107'), 'Guia p. 110, §1', 'Fora del territori de Catalunya, la responsabilitat penal és exigible en els mateixos termes davant la Sala Penal del Tribunal Suprem.', null, 'c15ae5df8af76233e1c2b72c4771afb6fe2ee62f02b52b8f3b0691b44f98d51c', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'c15ae5df8af76233e1c2b72c4771afb6fe2ee62f02b52b8f3b0691b44f98d51c')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'La Sala Penal del Tribunal Suprem.', true), ('B', 'El Tribunal Superior de Justícia de Catalunya.', false), ('C', 'L’Audiència Nacional.', false), ('D', 'El Tribunal Constitucional.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, com està integrada la Mesa del Parlament de Catalunya?', 'La Mesa és l’òrgan rector col·legiat: president, dos vicepresidents i quatre secretaris. Els portaveus formen la Junta de Portaveus.', 'mossos_b2_institucions_catalunya', (select id from public.topics where slug = 'mossos-b2-institucions-catalunya'), 2, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=107'), 'Guia p. 110, §2', 'una mesa (òrgan rector col·legiat del Parlament, integrat pel president, dos vicepresidents i quatre secretaris, que és el centre decisori pel que fa al govern institucional del Parlament).', null, 'e929eb5e6b0ccf0f0063a35d238e261c3b49b338ca2507bd45c087e5b11a83bc', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'e929eb5e6b0ccf0f0063a35d238e261c3b49b338ca2507bd45c087e5b11a83bc')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Pel president, un vicepresident i dos secretaris.', false), ('B', 'Pel president, tres vicepresidents i tres secretaris.', false), ('C', 'Pel president, dos vicepresidents i quatre secretaris.', true), ('D', 'Pel president i els portaveus de tots els grups parlamentaris.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, quants membres formen la Diputació Permanent del Parlament de Catalunya?', 'La Diputació Permanent, presidida pel president del Parlament, té vint-i-tres membres en proporció a la representació de cada grup.', 'mossos_b2_institucions_catalunya', (select id from public.topics where slug = 'mossos-b2-institucions-catalunya'), 2, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=107'), 'Guia p. 110, §3', 'El Parlament té una diputació permanent, presidida pel president o presidenta del Parlament, i formada per vint-i-tres membres en proporció a la representació de cada grup parlamentari', null, '15e0612dbfbb10ce52f87bd93d71ddea0ea648aea135bf8e540e86fbf7f08269', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '15e0612dbfbb10ce52f87bd93d71ddea0ea648aea135bf8e540e86fbf7f08269')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Quinze membres.', false), ('B', 'Trenta-cinc membres.', false), ('C', 'Tots els membres de la Mesa i els portaveus.', false), ('D', 'Vint-i-tres membres.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, quin és el nombre mínim de diputats per formar un grup parlamentari, amb l’excepció del grup mixt?', 'Cada grup parlamentari ha de tenir un mínim de cinc diputats, excepte el grup mixt.', 'mossos_b2_institucions_catalunya', (select id from public.topics where slug = 'mossos-b2-institucions-catalunya'), 2, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=107'), 'Guia p. 110, §4', 'cada partit o coalició només pot formar un grup parlamentari, que ha de tenir un mínim de cinc diputats, amb l’excepció del grup mixt', null, 'b44cd3b9f697254edc1d4b7d77421e6e74fd80d20fa9cc589928a79225e0fcc8', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'b44cd3b9f697254edc1d4b7d77421e6e74fd80d20fa9cc589928a79225e0fcc8')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Cinc diputats.', true), ('B', 'Tres diputats.', false), ('C', 'Set diputats.', false), ('D', 'Deu diputats.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, quins són els dos períodes ordinaris de sessions del Parlament de Catalunya?', 'El Parlament es reuneix en dos períodes ordinaris: del 16 d’agost al 31 de desembre i del 15 de gener al 31 de juliol.', 'mossos_b2_institucions_catalunya', (select id from public.topics where slug = 'mossos-b2-institucions-catalunya'), 2, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=107'), 'Guia p. 110, §6', 'El Parlament es reuneix anualment en dos períodes ordinaris de sessions, del 16 d’agost al 31 de desembre i del 15 de gener al 31 de juliol.', null, '7e3ca82c7937448c87f25ed028b0ec65f17d0193af038af7e5a38571276f69c4', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '7e3ca82c7937448c87f25ed028b0ec65f17d0193af038af7e5a38571276f69c4')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'De l’1 de setembre al 31 de desembre i de l’1 de febrer al 30 de juny.', false), ('B', 'Del 16 d’agost al 31 de desembre i del 15 de gener al 31 de juliol.', true), ('C', 'De l’1 de setembre al 15 de desembre i del 15 de gener al 30 de juny.', false), ('D', 'Del 16 d’agost al 15 de desembre i de l’1 de febrer al 31 de juliol.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, quina majoria requereixen les lleis de desplegament bàsic de l’Estatut?', 'Les lleis de desplegament bàsic de l’Estatut regulen matèries rellevants de l’autogovern i requereixen la majoria absoluta del Ple.', 'mossos_b2_institucions_catalunya', (select id from public.topics where slug = 'mossos-b2-institucions-catalunya'), 3, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=107'), 'Guia p. 111, §5', 'les lleis de desplegament bàsic de l’Estatut, que són aquelles que regulen directament certes matèries rellevants de l’autogovern de Catalunya i que requereixen el vot favorable de la majoria absoluta del Ple del Parlament.', null, '2c61a453ba8ca01f6f6e380ddf170f4cca6f2312ee5e795826f6a0b5fc910325', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '2c61a453ba8ca01f6f6e380ddf170f4cca6f2312ee5e795826f6a0b5fc910325')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'La majoria simple del Ple del Parlament.', false), ('B', 'La majoria de tres cinquenes parts del Parlament.', false), ('C', 'La majoria de dues terceres parts del Parlament.', false), ('D', 'El vot favorable de la majoria absoluta del Ple del Parlament.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, quants senadors autonòmics corresponen actualment a Catalunya, designats pel Parlament?', 'El Parlament designa els senadors autonòmics que corresponen a Catalunya, actualment vuit.', 'mossos_b2_institucions_catalunya', (select id from public.topics where slug = 'mossos-b2-institucions-catalunya'), 2, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=107'), 'Guia p. 111, §7', 'designar els senadors autonòmics que corresponen a Catalunya (actualment vuit)', null, '7b24ee7762f0fcc1cf8130ef69c4c4a8bab51f74082c3ca02734626a3a4cf862', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '7b24ee7762f0fcc1cf8130ef69c4c4a8bab51f74082c3ca02734626a3a4cf862')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Quatre.', false), ('B', 'Dotze.', false), ('C', 'Vuit.', true), ('D', 'Setze.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, quina majoria es requereix per elegir el president o presidenta de la Generalitat en segona votació, al cap de 48 hores?', 'En primera votació cal majoria absoluta; si no s’obté, n’hi ha prou amb la majoria simple al cap de 48 hores.', 'mossos_b2_institucions_catalunya', (select id from public.topics where slug = 'mossos-b2-institucions-catalunya'), 2, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=107'), 'Guia p. 112, §2', 'Ha de ser elegit pel Parlament de Catalunya entre els seus membres, per majoria absoluta en primera votació, o per majoria simple al cap de 48 hores.', null, 'bd2c003f925e170d3d1d034c08c0f33bc33dcae06a241646bc2192b12f60d7b3', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'bd2c003f925e170d3d1d034c08c0f33bc33dcae06a241646bc2192b12f60d7b3')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Majoria simple.', true), ('B', 'Majoria absoluta.', false), ('C', 'Majoria de tres cinquenes parts.', false), ('D', 'Majoria de dues terceres parts.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, quina d’aquestes atribucions correspon al president o presidenta de la Generalitat com a representant ordinari de l’Estat a Catalunya?', 'Promulgar les lleis en nom del rei és una funció com a representant ordinari de l’Estat. Convocar eleccions i signar convenis són funcions de representant suprem de la Generalitat; nomenar consellers, de cap del Govern.', 'mossos_b2_institucions_catalunya', (select id from public.topics where slug = 'mossos-b2-institucions-catalunya'), 3, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=107'), 'Guia p. 112, §4', 'a) promulgar, en nom del rei, les lleis, els decrets llei, i els decrets legislatius de Catalunya i ordenar-ne la publicació;', null, '3766d2fcf8956f330bcae29b63f71f1eea7e633ceb4d9df1a5b7a832690bf256', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '3766d2fcf8956f330bcae29b63f71f1eea7e633ceb4d9df1a5b7a832690bf256')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Convocar eleccions al Parlament de Catalunya.', false), ('B', 'Promulgar, en nom del rei, les lleis, els decrets llei i els decrets legislatius de Catalunya i ordenar-ne la publicació.', true), ('C', 'Signar els convenis de cooperació amb les comunitats autònomes.', false), ('D', 'Nomenar i separar els consellers.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, quina diferència hi ha entre el president o presidenta de la Generalitat i els consellers pel que fa a la condició de diputat?', 'El president ha de ser diputat quan és elegit; els consellers no han de tenir necessàriament aquesta condició.', 'mossos_b2_institucions_catalunya', (select id from public.topics where slug = 'mossos-b2-institucions-catalunya'), 2, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=107'), 'Guia p. 113, §1', 'els consellers no han de tenir necessàriament la condició de diputat i el president sí que ho ha de ser en el moment de ser elegit.', null, 'f96bad8d1fee78a8dab56f68996719ace561e5431efec65c1e6363f92b1fca5c', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'f96bad8d1fee78a8dab56f68996719ace561e5431efec65c1e6363f92b1fca5c')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Tots dos han de ser diputats en el moment del nomenament.', false), ('B', 'Els consellers han de ser diputats; el president no necessàriament.', false), ('C', 'Cap dels dos no pot tenir la condició de diputat.', false), ('D', 'El president ha de ser diputat en el moment de ser elegit; els consellers no necessàriament.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, quines prerrogatives tenen el president o presidenta de la Generalitat i els consellers durant el seu mandat, d’acord amb l’article 70 de l’EAC?', 'L’article 70 de l’EAC els atribueix dues prerrogatives: la immunitat i el fur especial, en els mateixos termes que els diputats.', 'mossos_b2_institucions_catalunya', (select id from public.topics where slug = 'mossos-b2-institucions-catalunya'), 3, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=107'), 'Guia p. 113, §6', 'L’article 70 de l’EAC, sobre l’estatut personal dels membres del Govern, estableix que el president o presidenta de la Generalitat i els consellers, durant llurs mandats, gaudeixen de dues prerrogatives: la immunitat i el fur especial', null, '6c3ad56f6bfa97091a07b31d91e6ce990a75f89b3d57e5c3b6bb2a7936c0ee5f', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '6c3ad56f6bfa97091a07b31d91e6ce990a75f89b3d57e5c3b6bb2a7936c0ee5f')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'La inviolabilitat i la immunitat.', false), ('B', 'La immunitat i el fur especial.', true), ('C', 'La inviolabilitat i el fur especial.', false), ('D', 'La inviolabilitat, la immunitat i el fur especial.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, quin és l’alt òrgan consultiu del Govern de la Generalitat?', 'L’article 72 de l’EAC preveu la Comissió Jurídica Assessora com a alt òrgan consultiu del Govern; el CTESC assessora en matèries socioeconòmiques, laborals i ocupacionals.', 'mossos_b2_institucions_catalunya', (select id from public.topics where slug = 'mossos-b2-institucions-catalunya'), 2, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=107'), 'Guia p. 114, §5', 'la Comissió Jurídica Assessora, que és l’alt òrgan consultiu del Govern', null, 'ed496568e1135d5a37673c30b9f47773aac64044eba5fc08ce46a50c2c4dbb5c', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'ed496568e1135d5a37673c30b9f47773aac64044eba5fc08ce46a50c2c4dbb5c')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'La Comissió Jurídica Assessora.', true), ('B', 'El Consell de Garanties Estatutàries.', false), ('C', 'El Consell de Treball, Econòmic i Social.', false), ('D', 'La Sindicatura de Comptes.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, quina és la durada del mandat del Síndic o Síndica de Greuges?', 'El mandat del Síndic de Greuges és de sis anys des de l’elecció pel Parlament, per majoria de tres cinquenes parts, i no pot ser reelegit.', 'mossos_b2_institucions_catalunya', (select id from public.topics where slug = 'mossos-b2-institucions-catalunya'), 3, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=107'), 'Guia p. 115, §2', 'El mandat del síndic o síndica de greuges és de sis anys des de la data en què és elegit pel Parlament, i no pot ser reelegit.', null, 'ecc45f5c44d3f63851c4ccf7eb3ae8e54808a5ae0c8ac09ef6260634c72aa7c7', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'ecc45f5c44d3f63851c4ccf7eb3ae8e54808a5ae0c8ac09ef6260634c72aa7c7')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Cinc anys, i pot ser reelegit una vegada.', false), ('B', 'Quatre anys, coincidint amb la legislatura.', false), ('C', 'Sis anys, i no pot ser reelegit.', true), ('D', 'Nou anys, i no pot ser reelegit.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
-- Lote mossos-b3-ordenament-juridic-guia-v1 (20 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Guia d''estudi per accedir a la PG-ME, 1a edició, juny de 2026 (convocatòria 46/26), tema B.3, pp. 118-128', 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=118', 'web_oficial'::public.source_kind, 'Generalitat de Catalunya · Mossos d''Esquadra (web oficial de la convocatòria 46/26)', '2026-06-01') on conflict (url) do nothing;
insert into public.topics (slug, title) values ('mossos-b3-ordenament-juridic', 'B.3 L''ordenament jurídic de l''Estat') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug = 'mossos-esquadra' and t.slug = 'mossos-b3-ordenament-juridic' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, quina norma encapçala l’ordenament jurídic espanyol?', 'L’ordenament jurídic espanyol està encapçalat per la Constitució, que regula la producció de les altres normes i serveix de paràmetre de validesa i de criteri interpretatiu.', 'mossos_b3_ordenament_juridic', (select id from public.topics where slug = 'mossos-b3-ordenament-juridic'), 1, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=118'), 'Guia p. 119, §2', 'L’ordenament jurídic espanyol està encapçalat per la Constitució, que és la norma que regula la producció de les altres normes jurídiques positives', null, '9d13ddbe7c9ba39caf5916a4a64abec38d372e946ce8f0f5e4e9a3ea0dd7c5c2', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '9d13ddbe7c9ba39caf5916a4a64abec38d372e946ce8f0f5e4e9a3ea0dd7c5c2')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'La Llei orgànica del poder judicial.', false), ('B', 'El Codi civil.', false), ('C', 'La Constitució.', true), ('D', 'Els tractats internacionals ratificats per Espanya.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, quina característica de l’ordenament jurídic exigeix que sempre hi hagi una norma aplicable per a cada supòsit de fet?', 'La plenitud implica que l’ordenament ha de ser complet i preveure regles per resoldre les llacunes normatives.', 'mossos_b3_ordenament_juridic', (select id from public.topics where slug = 'mossos-b3-ordenament-juridic'), 2, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=118'), 'Guia p. 119, §3', 'Plenitud: l’ordenament jurídic ha de ser complet; sempre hi ha d’haver una norma aplicable per a cada supòsit de fet.', null, '05027bd3c35d3cddbf1d5b90621f34632dff075d1f25b3b1da03b3ea0e043573', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '05027bd3c35d3cddbf1d5b90621f34632dff075d1f25b3b1da03b3ea0e043573')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'La plenitud.', true), ('B', 'La unitat.', false), ('C', 'La coherència.', false), ('D', 'El dinamisme.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, quina característica de l’ordenament jurídic consisteix a dotar-se d’unes regles per resoldre contradiccions normatives?', 'La coherència és la característica per la qual l’ordenament es dota de regles per resoldre les contradiccions entre normes.', 'mossos_b3_ordenament_juridic', (select id from public.topics where slug = 'mossos-b3-ordenament-juridic'), 2, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=118'), 'Guia p. 119, §3', 'Coherència: l’ordenament jurídic es dota d’unes regles per resoldre contradiccions normatives.', null, 'cc4c9bbf028e48a4901637d5130bb3153dd0d1c97f7de413b942e99ea4474ea7', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'cc4c9bbf028e48a4901637d5130bb3153dd0d1c97f7de413b942e99ea4474ea7')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'La pluralitat.', false), ('B', 'La coherència.', true), ('C', 'La plenitud.', false), ('D', 'La unitat.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, entre quines normes es pot aplicar el principi de temporalitat?', 'El principi de temporalitat (la norma posterior deroga l’anterior) només s’aplica entre normes del mateix rang; la derogació pot ser expressa o tàcita.', 'mossos_b3_ordenament_juridic', (select id from public.topics where slug = 'mossos-b3-ordenament-juridic'), 2, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=118'), 'Guia p. 120, §1', 'Aquest és un principi que només pot ser aplicat entre normes del mateix rang, i comporta la derogació de les normes.', null, '45919979f52375d782da7640709cf2b5305e1d6aa93eed7c9e102de6f4326600', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '45919979f52375d782da7640709cf2b5305e1d6aa93eed7c9e102de6f4326600')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Entre normes de rang diferent, de manera que la superior deroga la inferior.', false), ('B', 'Només entre normes estatals i autonòmiques.', false), ('C', 'Entre qualsevol norma, sempre que la derogació sigui expressa.', false), ('D', 'Només entre normes del mateix rang.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, quan es produeix una derogació tàcita?', 'La derogació és expressa quan la nova norma diu quines normes modifica, i tàcita quan se’n desprèn una contradicció amb l’antiga.', 'mossos_b3_ordenament_juridic', (select id from public.topics where slug = 'mossos-b3-ordenament-juridic'), 2, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=118'), 'Guia p. 120, §1', 'o tàcita (quan de la nova norma es desprèn l’existència d’una contradicció amb l’antiga).', null, '800b02c72ff57ab417d7ad530cf4700ba4bca4e45aa396fd14d75667657812db', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '800b02c72ff57ab417d7ad530cf4700ba4bca4e45aa396fd14d75667657812db')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Quan la nova norma enumera exactament les normes que modifica.', false), ('B', 'Quan una norma deixa d’aplicar-se per desús durant un llarg període.', false), ('C', 'Quan de la nova norma es desprèn l’existència d’una contradicció amb l’antiga.', true), ('D', 'Quan el Tribunal Constitucional declara nul·la una llei.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, què estableix la clàusula de supletorietat del dret estatal prevista a l’article 149.3 de la CE?', 'La supletorietat evita llacunes: s’aplica el dret estatal si la comunitat no ha exercit la seva competència. La prevalença resol conflictes en matèries no exclusives autonòmiques.', 'mossos_b3_ordenament_juridic', (select id from public.topics where slug = 'mossos-b3-ordenament-juridic'), 3, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=118'), 'Guia p. 120, §2', 'La clàusula de supletorietat del dret estatal: en el cas que una comunitat autònoma no faci ús de les seves competències normatives, s’ha d’aplicar supletòriament el dret estatal perquè no es produeixin llacunes normatives.', null, '05f8a937feec182ea31a300fab71b43af85245bb260cadc808825bc05a6e14bf', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '05f8a937feec182ea31a300fab71b43af85245bb260cadc808825bc05a6e14bf')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Que les normes estatals prevalen sempre sobre les autonòmiques.', false), ('B', 'Que, si una comunitat autònoma no fa ús de les seves competències normatives, s’aplica supletòriament el dret estatal.', true), ('C', 'Que les comunitats autònomes poden suplir les llacunes del dret estatal.', false), ('D', 'Que el dret estatal només s’aplica si ho acorda el Parlament autonòmic.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, quines són les fonts directes subsidiàries del dret administratiu?', 'Les fonts directes primàries són la Constitució, la llei (i normes amb rang de llei) i el reglament; les subsidiàries, el costum i els principis generals del dret.', 'mossos_b3_ordenament_juridic', (select id from public.topics where slug = 'mossos-b3-ordenament-juridic'), 3, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=118'), 'Guia p. 120, §3', 'Fonts directes subsidiàries: El costum Els principis generals del dret', null, 'fa2f0f9ea8ee92ddd9b1303467d0cd453a113d6a9eabac20f580d59ca13aa316', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'fa2f0f9ea8ee92ddd9b1303467d0cd453a113d6a9eabac20f580d59ca13aa316')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El costum i els principis generals del dret.', true), ('B', 'La llei i el reglament.', false), ('C', 'La jurisprudència i la doctrina científica.', false), ('D', 'Els tractats internacionals i la jurisprudència.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, quina d’aquestes és una font indirecta del dret administratiu?', 'Són fonts indirectes els tractats internacionals, la jurisprudència contenciosa administrativa del Tribunal Suprem i la doctrina científica.', 'mossos_b3_ordenament_juridic', (select id from public.topics where slug = 'mossos-b3-ordenament-juridic'), 3, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=118'), 'Guia p. 121, §1', 'Fonts indirectes: Els tractats internacionals La jurisprudència contenciosa administrativa del Tribunal Suprem La doctrina científica', null, '797b0caa39133c857db25d7506a637e46dbe831b96e8f59eb12e21b0e11eaa2a', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '797b0caa39133c857db25d7506a637e46dbe831b96e8f59eb12e21b0e11eaa2a')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El costum.', false), ('B', 'El reglament.', false), ('C', 'Els principis generals del dret.', false), ('D', 'La jurisprudència contenciosa administrativa del Tribunal Suprem.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, en quin article de la Constitució es recull el principi de jerarquia normativa?', 'El principi de jerarquia normativa el recull l’article 9.3 del títol preliminar de la CE.', 'mossos_b3_ordenament_juridic', (select id from public.topics where slug = 'mossos-b3-ordenament-juridic'), 2, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=118'), 'Guia p. 121, §2', 'L’ordenament jurídic positiu s’estructura d’acord amb el principi de jerarquia normativa, que la Constitució recull a l’article 9.3 del títol preliminar.', null, 'abc94a479d0eec4aebe214a969d1a9430121cd23b2400ec076c8de7890b9cb5d', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'abc94a479d0eec4aebe214a969d1a9430121cd23b2400ec076c8de7890b9cb5d')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Article 1.1.', false), ('B', 'Article 9.3.', true), ('C', 'Article 53.1.', false), ('D', 'Article 81.2.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, quan va ser referendada la Constitució espanyola?', 'La CE va ser referendada el 6 de desembre de 1978.', 'mossos_b3_ordenament_juridic', (select id from public.topics where slug = 'mossos-b3-ordenament-juridic'), 2, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=118'), 'Guia p. 121, §5', 'la CE va ser referendada el 6 de desembre de 1978', 'La guia esmenta només les reformes de 1992 i 2011; per això no es pregunta pel nombre de reformes (el 2024 es va reformar l’article 49).', 'bf14f08189c1209fe3c3f4e2a7ac3678b6a2327443bbee02c7409371e8a38ac1', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'bf14f08189c1209fe3c3f4e2a7ac3678b6a2327443bbee02c7409371e8a38ac1')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El 6 de desembre de 1978.', true), ('B', 'El 31 d’octubre de 1978.', false), ('C', 'El 27 de desembre de 1978.', false), ('D', 'El 29 de desembre de 1978.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, quin article de la CE es va modificar l’any 2011, arran de la crisi econòmica?', 'El 2011 es va modificar l’article 135 per donar estabilitat pressupostària. La reforma de 1992 va afectar el sufragi passiu dels ciutadans comunitaris a les municipals.', 'mossos_b3_ordenament_juridic', (select id from public.topics where slug = 'mossos-b3-ordenament-juridic'), 3, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=118'), 'Guia p. 121, §5', 'l’any 2011, en què es va modificar l’article 135, arran de la crisi econòmica i en el context de les indicacions europees per tal de donar estabilitat pressupostària.', null, '6f252df25d09229f59d67750cc8d5bb083d9460f9b422942c6a3edd7aa042c7b', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '6f252df25d09229f59d67750cc8d5bb083d9460f9b422942c6a3edd7aa042c7b')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'L’article 13.', false), ('B', 'L’article 49.', false), ('C', 'L’article 135.', true), ('D', 'L’article 149.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, quants articles i títols té la part articulada de la Constitució espanyola?', 'La part articulada té 169 articles agrupats en 11 títols (títol preliminar i títols I a X).', 'mossos_b3_ordenament_juridic', (select id from public.topics where slug = 'mossos-b3-ordenament-juridic'), 2, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=118'), 'Guia p. 122, §1', 'b) Una part articulada (169 articles): s’agrupa en 11 títols, que se subdivideixen en capítols, i aquests, en seccions.', null, 'e3d241e635a04a403c94cd3f7cee743ce1257af9fc4917123b9c4b3ff85a6831', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'e3d241e635a04a403c94cd3f7cee743ce1257af9fc4917123b9c4b3ff85a6831')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', '159 articles agrupats en 10 títols.', false), ('B', '169 articles agrupats en 10 títols.', false), ('C', '179 articles agrupats en 11 títols.', false), ('D', '169 articles agrupats en 11 títols.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, a quina matèria està dedicat el títol VII de la Constitució espanyola?', 'El títol VII es dedica a economia i finances; el poder judicial és el VI, l’organització territorial el VIII i el Tribunal Constitucional el IX.', 'mossos_b3_ordenament_juridic', (select id from public.topics where slug = 'mossos-b3-ordenament-juridic'), 3, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=118'), 'Guia p. 122, §1', 'Els títols II al IX (excepte el VII, dedicat a economia i finances) despleguen l’anomenada part orgànica de la CE', null, '7a23c645f5d8a2c33b51e28b2f781952dabc5b50f9836ba71319f7d9229b6920', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '7a23c645f5d8a2c33b51e28b2f781952dabc5b50f9836ba71319f7d9229b6920')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Al poder judicial.', false), ('B', 'A l’organització territorial de l’Estat.', false), ('C', 'Al Tribunal Constitucional.', false), ('D', 'A l’economia i les finances.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, quin article de la CE és el supòsit més clar de reserva de llei, en relació amb la regulació dels drets fonamentals?', 'L’article 53.1 de la CE reserva a la llei la regulació dels drets fonamentals.', 'mossos_b3_ordenament_juridic', (select id from public.topics where slug = 'mossos-b3-ordenament-juridic'), 2, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=118'), 'Guia p. 122, §3', 'L’article 53.1 és el supòsit més clar de reserva de llei que estableix la CE, en relació amb la regulació dels drets fonamentals.', null, 'd1c598a24689ea575e3c970d8f55880bcb369361e133a511f5c72f1e8c065447', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'd1c598a24689ea575e3c970d8f55880bcb369361e133a511f5c72f1e8c065447')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'L’article 9.3.', false), ('B', 'L’article 86.1.', false), ('C', 'L’article 53.1.', true), ('D', 'L’article 97.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, en què consisteix la força passiva de la llei?', 'La força activa permet modificar o derogar normes inferiors i anteriors del mateix rang; la passiva fa la llei immune a les normes de rang inferior.', 'mossos_b3_ordenament_juridic', (select id from public.topics where slug = 'mossos-b3-ordenament-juridic'), 3, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=118'), 'Guia p. 122, §4', 'passiva (és immune a les altres normes de rang inferior, que no poden modificar-la ni derogar-la)', null, 'a77918cd27e42340f585680e249d55f38ee99f745f49b8d7c447cc8187649bf4', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'a77918cd27e42340f585680e249d55f38ee99f745f49b8d7c447cc8187649bf4')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'En la capacitat de modificar o derogar normes de rang inferior.', false), ('B', 'En la immunitat davant les normes de rang inferior, que no poden modificar-la ni derogar-la.', true), ('C', 'En la possibilitat de ser controlada pel Tribunal Constitucional.', false), ('D', 'En la capacitat de derogar normes anteriors del mateix rang.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, a qui correspon l’aprovació final d’una llei ordinària en el procediment legislatiu comú?', 'L’aprovació final correspon al Congrés per majoria simple; després el rei la sanciona i promulga i s’ordena la publicació al BOE.', 'mossos_b3_ordenament_juridic', (select id from public.topics where slug = 'mossos-b3-ordenament-juridic'), 2, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=118'), 'Guia p. 123, §2', 'L’aprovació final de la llei correspon al Congrés mitjançant la majoria simple de vots a favor.', null, '86f93d4d5200a898bb97aa838fcbfbcc85a84a4296f2cebb448bf7405e8d71ca', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '86f93d4d5200a898bb97aa838fcbfbcc85a84a4296f2cebb448bf7405e8d71ca')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Al Congrés, per majoria simple de vots a favor.', true), ('B', 'Al Senat, per majoria absoluta.', false), ('C', 'Al Congrés, per majoria absoluta en una votació final del conjunt.', false), ('D', 'Al rei, mitjançant la sanció.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, quin principi regeix les relacions entre la llei orgànica i la llei ordinària?', 'No hi ha jerarquia entre llei orgànica i ordinària: la relació respon al principi de competència (procedimental).', 'mossos_b3_ordenament_juridic', (select id from public.topics where slug = 'mossos-b3-ordenament-juridic'), 3, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=118'), 'Guia p. 123, §4', 'les relacions entre ambdues lleis es regeixen pel principi de competència i no de jerarquia.', null, '3da33d0115c8c5dbc0419bc9332bca1c9a43d5a969a4a98a51c035a3afcddd42', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '3da33d0115c8c5dbc0419bc9332bca1c9a43d5a969a4a98a51c035a3afcddd42')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El principi de jerarquia, ja que la llei orgànica és superior.', false), ('B', 'El principi de competència.', true), ('C', 'El principi d’especialitat.', false), ('D', 'El principi de temporalitat.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, de quin termini disposa el Congrés dels Diputats per convalidar o derogar un decret llei?', 'Els decrets llei són disposicions provisionals limitades a 30 dies, durant els quals el Congrés decideix si els convalida o els deroga.', 'mossos_b3_ordenament_juridic', (select id from public.topics where slug = 'mossos-b3-ordenament-juridic'), 2, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=118'), 'Guia p. 124, §2', 'són disposicions normatives provisionals limitades a 30 dies partir de la seva promulgació. Durant aquest termini, el Congrés dels Diputats ha d’estudiar-los i decidir si els convalida o si, per contra, els deroga.', null, 'c7789845b27047e85cd9130329ec02088a988bd78fde367e3367fe9d8ccc225e', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'c7789845b27047e85cd9130329ec02088a988bd78fde367e3367fe9d8ccc225e')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', '30 dies.', true), ('B', '15 dies.', false), ('C', '45 dies.', false), ('D', '60 dies.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, mitjançant quina norma s’ha de fer la delegació legislativa quan el Parlament encarrega al Govern l’elaboració d’un text articulat?', 'Per a un text articulat la delegació es fa amb una llei de bases; per a un text refós, amb una llei ordinària.', 'mossos_b3_ordenament_juridic', (select id from public.topics where slug = 'mossos-b3-ordenament-juridic'), 3, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=118'), 'Guia p. 124, §4', 'a) Si el Parlament encarrega al Govern l’elaboració d’un text articulat, la delegació s’ha de fer mitjançant una llei de bases.', null, '44dbe29e42577c3c3f36f84a10fe8c3fd2430e61943c60c64cdc0a248fc4d17d', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '44dbe29e42577c3c3f36f84a10fe8c3fd2430e61943c60c64cdc0a248fc4d17d')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Mitjançant una llei ordinària.', false), ('B', 'Mitjançant una llei orgànica.', false), ('C', 'Mitjançant una llei de bases.', true), ('D', 'Mitjançant una llei marc.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, quina posició ocupen els tractats internacionals un cop incorporats a l’ordenament jurídic espanyol?', 'Els tractats tenen força passiva davant la llei, cosa que els situa per sobre de les lleis; tanmateix, la CE garanteix la seva supremacia fins i tot sobre els tractats (art. 95 CE).', 'mossos_b3_ordenament_juridic', (select id from public.topics where slug = 'mossos-b3-ordenament-juridic'), 3, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=118'), 'Guia p. 126, §2', 'Aquesta rigidesa els confereix una posició jeràrquicament superior a les lleis. En canvi, l’ordenament jurídic espanyol garanteix la supremacia de la CE, fins i tot per sobre dels tractats internacionals que s’hi incorporin (article 95 de la CE).', null, 'b32a87a165bbfe74cff1cf04af247e0867a4efb0543256eb52060314072b9f3f', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'b32a87a165bbfe74cff1cf04af247e0867a4efb0543256eb52060314072b9f3f')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Tenen el mateix rang que els reglaments.', false), ('B', 'Se situen per sobre de la Constitució.', false), ('C', 'Tenen el mateix rang que la llei ordinària i poden ser derogats per una llei posterior.', false), ('D', 'Tenen una posició jeràrquicament superior a les lleis, però la CE manté la supremacia sobre els tractats.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
-- Lote mossos-b4-drets-guia-v1 (20 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Guia d''estudi per accedir a la PG-ME, 1a edició, juny de 2026 (convocatòria 46/26), tema B.4, pp. 129-141', 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=129', 'web_oficial'::public.source_kind, 'Generalitat de Catalunya · Mossos d''Esquadra (web oficial de la convocatòria 46/26)', '2026-06-01') on conflict (url) do nothing;
insert into public.topics (slug, title) values ('mossos-b4-drets', 'B.4 Els drets humans i els drets constitucionals') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug = 'mossos-esquadra' and t.slug = 'mossos-b4-drets' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, quina és la carta de drets més important aprovada a les colònies britàniques d’Amèrica al segle XVIII?', 'La guia destaca la Declaració de drets de Virgínia de 1776. La Petition of Rights (1628) és un precedent anglès i la Declaració de 1789 és francesa.', 'mossos_b4_drets', (select id from public.topics where slug = 'mossos-b4-drets'), 2, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=129'), 'Guia p. 130, §2', 'es van aprovar cartes de drets, la més important de les quals és la Declaració de drets de Virgínia de 1776.', null, 'e7b2cf8f0048ebc0188d12fae331069dac6725135ef9cdfad58e4b3bc7f75e0e', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'e7b2cf8f0048ebc0188d12fae331069dac6725135ef9cdfad58e4b3bc7f75e0e')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'La Petition of Rights.', false), ('B', 'La Declaració dels drets de l’home i del ciutadà.', false), ('C', 'El Bill of Rights de 1689.', false), ('D', 'La Declaració de drets de Virgínia de 1776.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, de quin any és el Conveni europeu de drets humans i de les llibertats fonamentals?', 'La Declaració Universal és de 1948, el Conveni europeu de 1950, els dos pactes internacionals de 1966 i la Carta dels drets fonamentals de la UE de 2000.', 'mossos_b4_drets', (select id from public.topics where slug = 'mossos-b4-drets'), 2, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=129'), 'Guia p. 130, §5', 'la Declaració Universal dels Drets Humans de 1948, el Conveni europeu de drets humans i de les llibertats fonamentals de 1950', null, 'db2f0d6f22d7c9278f78b2c72ccd0df1611163629c4a1f4e2f3834562a702755', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'db2f0d6f22d7c9278f78b2c72ccd0df1611163629c4a1f4e2f3834562a702755')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', '1950.', true), ('B', '1948.', false), ('C', '1966.', false), ('D', '2000.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, en quins articles de la CE estan previstos els drets fonamentals i les llibertats públiques en sentit estricte?', 'Els drets fonamentals en sentit estricte són els de la secció primera del capítol II del títol I: articles 15 a 29.', 'mossos_b4_drets', (select id from public.topics where slug = 'mossos-b4-drets'), 2, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=129'), 'Guia p. 131, §1', 'Els drets fonamentals i les llibertats públiques estan previstos als articles 15 a 29 de la CE.', null, 'd68e1bf20576c4fc104b7bf6d880d65938242df81dbec98353a46f81e9f6c864', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'd68e1bf20576c4fc104b7bf6d880d65938242df81dbec98353a46f81e9f6c864')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Articles 1 a 9.', false), ('B', 'Articles 10 a 14.', false), ('C', 'Articles 15 a 29.', true), ('D', 'Articles 30 a 52.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, amb quin model d’Estat es relaciona el reconeixement dels drets de participació o polítics?', 'Els drets personals es relacionen amb l’Estat de dret; els de participació, amb l’Estat democràtic; i els econòmics i socials, amb l’Estat social.', 'mossos_b4_drets', (select id from public.topics where slug = 'mossos-b4-drets'), 3, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=129'), 'Guia p. 131, §3', 'El reconeixement d’aquests drets es relaciona amb l’Estat democràtic, en què es garanteix el pluralisme polític i la participació de la ciutadania en els afers públics', null, 'd11951c536c350082c6ed4016c8f14a2d892c0600be841bcce18010e238127c9', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'd11951c536c350082c6ed4016c8f14a2d892c0600be841bcce18010e238127c9')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Amb l’Estat de dret.', false), ('B', 'Amb l’Estat democràtic.', true), ('C', 'Amb l’Estat social.', false), ('D', 'Amb l’Estat autonòmic.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, quin d’aquests drets s’inclou entre els drets econòmics i socials?', 'Entre els drets econòmics i socials hi ha l’educació, el treball, la vaga i la sindicació, la negociació col·lectiva i la propietat.', 'mossos_b4_drets', (select id from public.topics where slug = 'mossos-b4-drets'), 2, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=129'), 'Guia p. 132, §1', 'Entre aquests drets es troben el dret a l’educació (art. 27), el dret al treball (art. 35), el dret a la vaga i el dret de sindicació (art. 28) el dret a la negociació col·lectiva (art. 37) i el dret a la propietat (art. 33).', null, '5a4a847f775344902d24007a11973ca4dfc066ca021f34ea4781d09ed58efe67', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '5a4a847f775344902d24007a11973ca4dfc066ca021f34ea4781d09ed58efe67')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El dret de reunió i manifestació.', false), ('B', 'El dret a la inviolabilitat del domicili.', false), ('C', 'El dret de petició als poders públics.', false), ('D', 'El dret a la negociació col·lectiva.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, a partir de quina sentència del Tribunal Constitucional es va reformular la posició sobre els drets dels estrangers, imposant com a límit la dignitat de la persona?', 'Durant molt de temps es va seguir la STC 107/1984; la posició es va reformular amb la STC 263/2007, que imposa el límit de la dignitat de la persona.', 'mossos_b4_drets', (select id from public.topics where slug = 'mossos-b4-drets'), 3, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=129'), 'Guia p. 132, §4', 'aquesta posició es va reformular a partir de la STC 263/2007, de 7 de novembre, que imposa com a límit a tenir en compte pel legislador el de la dignitat de la persona.', null, '97219911ab3ccfad364bee4d22c8830526a6288ca1741ad190d9ba29974b1d6f', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '97219911ab3ccfad364bee4d22c8830526a6288ca1741ad190d9ba29974b1d6f')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'La STC 107/1984.', false), ('B', 'La STC 263/2007, de 7 de novembre.', true), ('C', 'La STC 31/2010.', false), ('D', 'La STC 62/1978.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, quin d’aquests drets en són titulars nacionals i estrangers en les mateixes condicions, pel sol fet de ser persones?', 'La vida, la integritat física i moral, la tutela judicial efectiva i la llibertat són drets de tota persona en les mateixes condicions.', 'mossos_b4_drets', (select id from public.topics where slug = 'mossos-b4-drets'), 2, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=129'), 'Guia p. 132, §5', 'Exemples: dret a la vida, a la integritat física i moral, dret a la tutela judicial efectiva, dret a la llibertat.', null, 'a2976255da7b78db96936637ede92def428772d71389567db3137e5f19a824a1', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'a2976255da7b78db96936637ede92def428772d71389567db3137e5f19a824a1')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El dret de sufragi a les eleccions generals.', false), ('B', 'El dret d’accés a funcions i càrrecs públics.', false), ('C', 'El dret a la tutela judicial efectiva.', true), ('D', 'El dret de vaga, sense cap condició legal.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, quina és la durada màxima de la detenció preventiva abans que la persona sigui posada en llibertat o a disposició de l’autoritat judicial?', 'La detenció no pot durar més del temps estrictament necessari i, com a màxim, 72 hores.', 'mossos_b4_drets', (select id from public.topics where slug = 'mossos-b4-drets'), 1, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=129'), 'Guia p. 133, §3', 'La detenció no pot durar més que el temps estrictament necessari per fer les indagacions per aclarir els fets i, en qualsevol cas, com a màxim 72 hores.', null, 'e6088cfda194e60456a36d5f7e1dbebe647440ec1839b127508bff0c24400d34', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'e6088cfda194e60456a36d5f7e1dbebe647440ec1839b127508bff0c24400d34')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', '72 hores.', true), ('B', '24 hores.', false), ('C', '48 hores.', false), ('D', '5 dies.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, quina finalitat té el procediment d’habeas corpus?', 'L’habeas corpus és un procediment senzill i àgil per posar immediatament a disposició judicial qualsevol persona detinguda il·legalment.', 'mossos_b4_drets', (select id from public.topics where slug = 'mossos-b4-drets'), 2, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=129'), 'Guia p. 133, §3', 'És un procediment senzill i àgil que té per finalitat que el jutge es pronunciï sobre si hi ha o no una situació de detenció il·legal.', null, 'd32d936eb35669165f66b0f92b0f8fbf4a77683d4168154982a69f9683b99415', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'd32d936eb35669165f66b0f92b0f8fbf4a77683d4168154982a69f9683b99415')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Que el jutge es pronunciï sobre si hi ha o no una situació de detenció il·legal.', true), ('B', 'Revisar les sentències penals fermes.', false), ('C', 'Garantir l’assistència lletrada a la persona detinguda.', false), ('D', 'Autoritzar l’entrada en un domicili.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, en quin d’aquests supòsits és legítima l’entrada en un domicili sense consentiment del morador ni autorització judicial?', 'Només és legítima l’entrada amb consentiment, en delicte flagrant o amb autorització judicial; les presumpcions no són suficients.', 'mossos_b4_drets', (select id from public.topics where slug = 'mossos-b4-drets'), 2, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=129'), 'Guia p. 133, §4', 'b) En supòsits de delicte flagrant. Quan hi ha evidència de la comissió del delicte, entesa l’evidència com a percepció directa, i ha de ser urgent la intervenció de la policia. No són suficients les presumpcions sobre la comissió del delicte.', null, '74e2be33fc6bbc678655d9a0c69120b15ff588c943c04510f33bf8a9f29304d6', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '74e2be33fc6bbc678655d9a0c69120b15ff588c943c04510f33bf8a9f29304d6')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Quan hi ha sospites fonamentades sobre la comissió d’un delicte.', false), ('B', 'En supòsits de delicte flagrant, amb evidència entesa com a percepció directa i urgència de la intervenció policial.', true), ('C', 'Quan ho ordena el comandament policial de servei.', false), ('D', 'Quan el domicili és una segona residència.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, què inclou el contingut del secret de les comunicacions?', 'El secret de les comunicacions protegeix tant la comunicació com la identitat dels interlocutors.', 'mossos_b4_drets', (select id from public.topics where slug = 'mossos-b4-drets'), 2, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=129'), 'Guia p. 134, §1', 'El contingut del secret de les comunicacions inclou tant la mateixa comunicació com la identitat dels interlocutors.', null, 'b110e3427705ffca03ee60a516fec0ddc8bc94eae2bdec45031a0aa9faf7a4be', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'b110e3427705ffca03ee60a516fec0ddc8bc94eae2bdec45031a0aa9faf7a4be')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Només el contingut de la comunicació.', false), ('B', 'Només les comunicacions postals i telegràfiques.', false), ('C', 'Només la identitat dels interlocutors.', false), ('D', 'Tant la mateixa comunicació com la identitat dels interlocutors.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, quina d’aquestes és una garantia específica del procés penal dins el dret a la tutela judicial efectiva?', 'Les garanties específiques del procés penal són el dret a ser informat de l’acusació, a no declarar contra si mateix i a la presumpció d’innocència; les altres són garanties generals.', 'mossos_b4_drets', (select id from public.topics where slug = 'mossos-b4-drets'), 2, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=129'), 'Guia p. 135, §1', 'b) Dret a no declarar contra si mateix i a no confessar-se culpable: l’acusat té dret a guardar silenci i a no col·laborar en la investigació.', null, '53fa811011fb63a173784f411a5b59eb4419c011f16fa504560f2a31eb907392', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '53fa811011fb63a173784f411a5b59eb4419c011f16fa504560f2a31eb907392')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El dret al jutge ordinari predeterminat per la llei.', false), ('B', 'El dret a un procés sense dilacions indegudes.', false), ('C', 'El dret a no declarar contra si mateix i a no confessar-se culpable.', true), ('D', 'El dret a l’execució de la decisió.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, quina llei recull les mesures de protecció integral sobre la violència sexual?', 'La guia remet a la Llei orgànica 10/2022, de garantia de la llibertat sexual, i en concret als títols preliminar, II i V.', 'mossos_b4_drets', (select id from public.topics where slug = 'mossos-b4-drets'), 2, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=129'), 'Guia p. 135, §2', 'La Llei orgànica 10/2022, de 6 de setembre, de garantia de la llibertat sexual recull les mesures de protecció integral sobre la violència sexual.', null, 'e9cb81f31b751bb3d69116f860fd6596ff939546bd424ab164919204f760c7c6', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'e9cb81f31b751bb3d69116f860fd6596ff939546bd424ab164919204f760c7c6')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'La Llei orgànica 10/2022, de 6 de setembre, de garantia de la llibertat sexual.', true), ('B', 'La Llei orgànica 1/2004, de 28 de desembre.', false), ('C', 'La Llei orgànica 3/2007, de 22 de març.', false), ('D', 'La Llei orgànica 8/2021, de 4 de juny.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, quin tipus de llei pot regular els drets reconeguts a la secció primera del capítol II del títol I de la CE (articles 15 a 29)?', 'La reserva de llei de l’article 53.1 exigeix llei; per als drets dels articles 15 a 29 ha de ser llei orgànica, que n’ha de respectar el contingut essencial.', 'mossos_b4_drets', (select id from public.topics where slug = 'mossos-b4-drets'), 3, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=129'), 'Guia p. 135, §6', 'En relació amb els drets reconeguts a la secció primera del capítol II (articles 15 a 29), la llei que els pot regular només pot ser una llei orgànica.', null, '5e55d8c979dfbf4f3644442e64f3e8116cc078cd79ab4435f138e1e95385b6fb', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '5e55d8c979dfbf4f3644442e64f3e8116cc078cd79ab4435f138e1e95385b6fb')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Una llei ordinària o un decret llei.', false), ('B', 'Només una llei orgànica.', true), ('C', 'Un reglament executiu.', false), ('D', 'Una llei de bases.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, quin procediment de reforma constitucional cal seguir per reformar els drets dels articles 15 a 29 de la CE?', 'La reforma dels articles 15 a 29 segueix el procediment agreujat de l’article 168, cosa que actua com a garantia d’aquests drets.', 'mossos_b4_drets', (select id from public.topics where slug = 'mossos-b4-drets'), 3, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=129'), 'Guia p. 135, §7', 'Els drets reconeguts als articles 15 a 29 de la CE només poden ser reformats seguint el procediment previst a l’article 168 del text constitucional.', null, 'c7293d753ae530b38dd90d6c926f5c9865b6b627602cf6ae88b3658cdf82138d', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'c7293d753ae530b38dd90d6c926f5c9865b6b627602cf6ae88b3658cdf82138d')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El de l’article 167, per majoria de tres cinquenes parts de cada cambra.', false), ('B', 'El de l’article 81, per majoria absoluta del Congrés.', false), ('C', 'El de l’article 168, que exigeix dos terços de cada cambra, dissolució, noves eleccions, ratificació, aprovació per dos terços i referèndum.', true), ('D', 'El de l’article 87, a iniciativa del Govern.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, per a quin període és escollit el Defensor del Poble?', 'El Defensor del Poble és escollit per cinc anys per les Corts Generals, per tres cinquenes parts del Congrés, ratificat per la mateixa majoria al Senat.', 'mossos_b4_drets', (select id from public.topics where slug = 'mossos-b4-drets'), 2, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=129'), 'Guia p. 136, §2', 'El Defensor del Poble és escollit, per un període de cinc anys, per les Corts Generals', null, '33050c99f59a4f9cfe77249ba77acb43b73ba5c25299bcdbd277a0df187c6ef3', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '33050c99f59a4f9cfe77249ba77acb43b73ba5c25299bcdbd277a0df187c6ef3')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Quatre anys.', false), ('B', 'Sis anys.', false), ('C', 'Nou anys.', false), ('D', 'Cinc anys.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, en quin termini els promotors d’una reunió prohibida per l’autoritat administrativa poden interposar recurs contenciós administratiu?', 'Hi ha una protecció específica del dret de reunió: recurs en 48 hores des de la notificació i decisió judicial en 4 dies.', 'mossos_b4_drets', (select id from public.topics where slug = 'mossos-b4-drets'), 3, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=129'), 'Guia p. 137, §2', 'els promotors de la reunió poden interposar un recurs contenciós administratiu en el termini de 48 hores des de la notificació de la resolució i el jutge ha de decidir en 4 dies', null, 'c4e6a584d2b9d24c947f611585fdc90ebd85f641c333072b7f33cc490addd643', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'c4e6a584d2b9d24c947f611585fdc90ebd85f641c333072b7f33cc490addd643')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', '24 hores des de la notificació, i el jutge decideix en 48 hores.', false), ('B', '72 hores des de la notificació, i el jutge decideix en 5 dies.', false), ('C', '48 hores des de la notificació, i el jutge ha de decidir en 4 dies.', true), ('D', '10 dies des de la notificació, i el jutge decideix en un mes.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, en quin termini s’ha d’interposar el recurs d’empara constitucional contra violacions originades per òrgans judicials?', 'Òrgans legislatius: tres mesos; òrgans executius: vint dies; òrgans judicials: trenta dies. Els sis mesos corresponen al Tribunal Europeu de Drets Humans.', 'mossos_b4_drets', (select id from public.topics where slug = 'mossos-b4-drets'), 3, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=129'), 'Guia p. 138, §2', 'L’empara s’ha d’interposar en el termini de trenta dies següents a la notificació de la resolució dictada en el procés judicial.', null, 'c225afa8f5dde2a9efb4c8cfaa7f89d57c9b2b5192b85e5ba2a54af83f91dd9a', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'c225afa8f5dde2a9efb4c8cfaa7f89d57c9b2b5192b85e5ba2a54af83f91dd9a')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Trenta dies següents a la notificació de la resolució dictada en el procés judicial.', true), ('B', 'Vint dies següents a la notificació de la resolució.', false), ('C', 'Tres mesos des que la decisió és ferma.', false), ('D', 'Sis mesos des de la decisió judicial interna ferma.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, durant l’estat d’excepció, durant quant de temps com a màxim es pot detenir una persona si hi ha sospites fonamentades que provocarà alteracions de l’ordre públic?', 'En l’estat d’excepció la detenció per aquest motiu pot durar fins a 10 dies, i s’ha de comunicar al jutge en 24 hores.', 'mossos_b4_drets', (select id from public.topics where slug = 'mossos-b4-drets'), 3, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=129'), 'Guia p. 139, §4', 'Es pot detenir una persona, si hi ha sospites fonamentades que provocarà alteracions de l’ordre públic, durant un termini màxim de 10 dies. S’ha de comunicar la detenció al jutge en el termini de 24 hores.', null, '57d7f4f2f2f26206076d1f6ac570bffbe60672d55519ded9ab8be36c63ed0ae5', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '57d7f4f2f2f26206076d1f6ac570bffbe60672d55519ded9ab8be36c63ed0ae5')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', '72 hores.', false), ('B', '10 dies.', true), ('C', '5 dies.', false), ('D', '30 dies.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, qui declara l’estat de setge?', 'L’estat d’excepció el declara el Govern amb autorització prèvia del Congrés; l’estat de setge, la majoria absoluta del Congrés a proposta del Govern.', 'mossos_b4_drets', (select id from public.topics where slug = 'mossos-b4-drets'), 3, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=129'), 'Guia p. 140, §2', 'Aquest estat el declara la majoria absoluta del Congrés dels Diputats, a proposició del Govern.', null, 'd907113727669bc4019dd269b87e1d7032430ecbe6dd2b649e651a412366efd0', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'd907113727669bc4019dd269b87e1d7032430ecbe6dd2b649e651a412366efd0')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El Govern, mitjançant decret, sense autorització prèvia.', false), ('B', 'El Govern, prèvia autorització del Congrés, per un màxim de 30 dies.', false), ('C', 'El rei, a proposta del president del Govern.', false), ('D', 'La majoria absoluta del Congrés dels Diputats, a proposició del Govern.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
-- Lote mossos-b5-institucions-estat-guia-v1 (20 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Guia d''estudi per accedir a la PG-ME, 1a edició, juny de 2026 (convocatòria 46/26), tema B.5, pp. 142-149', 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=142', 'web_oficial'::public.source_kind, 'Generalitat de Catalunya · Mossos d''Esquadra (web oficial de la convocatòria 46/26)', '2026-06-01') on conflict (url) do nothing;
insert into public.topics (slug, title) values ('mossos-b5-institucions-estat', 'B.5 Les institucions polítiques de l''Estat') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug = 'mossos-esquadra' and t.slug = 'mossos-b5-institucions-estat' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, quins òrgans s’inclouen en la categoria d’òrgans constitucionals, essencials per a l’existència de l’Estat?', 'Són òrgans constitucionals la Corona, les Corts Generals i el Govern; el Tribunal de Comptes i el Consell d’Estat són òrgans auxiliars.', 'mossos_b5_institucions_estat', (select id from public.topics where slug = 'mossos-b5-institucions-estat'), 2, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=142'), 'Guia p. 143, §1', 'En aquesta categoria s’inclouen: la Corona, les Corts Generals i el Govern.', null, '1171c835c51f1d83566e29e319c088c9c52b42a23c553eeec423030e19871fe0', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '1171c835c51f1d83566e29e319c088c9c52b42a23c553eeec423030e19871fe0')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El Tribunal Constitucional, el Consell d’Estat i el Tribunal de Comptes.', false), ('B', 'Les Corts Generals, el Govern i el Consell General del Poder Judicial.', false), ('C', 'La Corona, el Govern i el Defensor del Poble.', false), ('D', 'La Corona, les Corts Generals i el Govern.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, quina cambra de les Corts Generals representa l’Estat atenent criteris de població?', 'El Congrés representa l’Estat atenent criteris de població; el Senat representa els diferents territoris.', 'mossos_b5_institucions_estat', (select id from public.topics where slug = 'mossos-b5-institucions-estat'), 1, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=142'), 'Guia p. 143, §2', 'el Congrés dels Diputats, que representa l’Estat atenent criteris de població, i el Senat, que representa els diferents territoris de l’Estat espanyol.', null, 'ff292e2005cb159e400f8bbe84dcc54de283f2e856cf45d41fa492afa18571b8', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'ff292e2005cb159e400f8bbe84dcc54de283f2e856cf45d41fa492afa18571b8')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El Senat.', false), ('B', 'El Congrés dels Diputats.', true), ('C', 'Totes dues per igual.', false), ('D', 'Cap de les dues; ho fan els parlaments autonòmics.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, en què consisteix l’autonomia administrativa de les Corts Generals?', 'Les quatre autonomies de les cambres són la reglamentària, la de govern intern, l’administrativa (personal amb estatut propi) i la pressupostària.', 'mossos_b5_institucions_estat', (select id from public.topics where slug = 'mossos-b5-institucions-estat'), 3, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=142'), 'Guia p. 144, §1', 'Autonomia administrativa: el personal al servei de les Corts Generals no forma part de l’Administració pública, que se situa sota la dependència i la direcció del Govern, sinó que té el seu propi estatut personal.', null, 'cad11d3f453dab2215925fce4a419cf3a2605abb223d25c88fe1480e69a8f5d9', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'cad11d3f453dab2215925fce4a419cf3a2605abb223d25c88fe1480e69a8f5d9')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'En la possibilitat d’aprovar els seus reglaments d’organització interna.', false), ('B', 'En l’elecció dels seus òrgans rectors sense interferències externes.', false), ('C', 'En el fet que el seu personal no forma part de l’Administració pública sinó que té el seu propi estatut.', true), ('D', 'En l’aprovació autònoma del seu pressupost.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, quants diputats formen el Congrés dels Diputats?', 'El Congrés té 350 diputats, segons l’article 172 de la Llei orgànica 5/1985, del règim electoral general.', 'mossos_b5_institucions_estat', (select id from public.topics where slug = 'mossos-b5-institucions-estat'), 2, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=142'), 'Guia p. 144, §2', 'està format per tres-cents cinquanta diputats, tal com s’estableix a l’article 172 de la Llei orgànica 5/1985, de 19 de juny, del règim electoral general.', null, '0028e9443baa929aee3d8baea65f29f1f58b061f5b072ff25c63795ec22b8b1a', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '0028e9443baa929aee3d8baea65f29f1f58b061f5b072ff25c63795ec22b8b1a')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', '350.', true), ('B', '300.', false), ('C', '400.', false), ('D', '266.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, quin mínim inicial de diputats s’assigna a cada circumscripció provincial en les eleccions al Congrés?', 'Cada província té un mínim inicial de dos diputats i la resta es distribueix en proporció a la població amb la Llei d’Hondt; Ceuta i Melilla tenen un diputat cadascuna.', 'mossos_b5_institucions_estat', (select id from public.topics where slug = 'mossos-b5-institucions-estat'), 2, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=142'), 'Guia p. 144, §2', 'el nombre total de diputats es distribueix assignant a cada circumscripció un mínim inicial de dos diputats.', null, '24a85255ccbf82ed21bfcabdce4bfc09e03b8b18a73b0898c91fe72988784bf6', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '24a85255ccbf82ed21bfcabdce4bfc09e03b8b18a73b0898c91fe72988784bf6')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Un diputat.', false), ('B', 'Tres diputats.', false), ('C', 'Dos diputats.', true), ('D', 'Quatre diputats.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, quin tipus de llistes electorals s’utilitzen en les eleccions al Congrés dels Diputats?', 'El sufragi per al Congrés es fa mitjançant llistes tancades i bloquejades.', 'mossos_b5_institucions_estat', (select id from public.topics where slug = 'mossos-b5-institucions-estat'), 2, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=142'), 'Guia p. 144, §3', 'El sufragi es fa mitjançant llistes electorals tancades i bloquejades de candidats', null, '22da7413e8b4db8ad35df6829ee9fe41fe358b9b4c72abb33af839795970065d', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '22da7413e8b4db8ad35df6829ee9fe41fe358b9b4c72abb33af839795970065d')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Llistes obertes.', false), ('B', 'Llistes tancades i bloquejades.', true), ('C', 'Llistes tancades i desbloquejades.', false), ('D', 'Candidatures uninominals.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, quants senadors s’elegeixen en cada circumscripció provincial?', 'En cada circumscripció provincial s’elegeixen quatre senadors (art. 165 LOREG).', 'mossos_b5_institucions_estat', (select id from public.topics where slug = 'mossos-b5-institucions-estat'), 2, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=142'), 'Guia p. 144, §5', '1. En cada circumscripció provincial s’elegeixen quatre senadors.', null, '54a0b2a86f75186e672af8547480fcda4b97ce2e5e3ec211b60d6b9ef20a552a', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '54a0b2a86f75186e672af8547480fcda4b97ce2e5e3ec211b60d6b9ef20a552a')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Dos.', false), ('B', 'Tres.', false), ('C', 'Cinc.', false), ('D', 'Quatre.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, quants senadors designa cada comunitat autònoma?', 'Les comunitats autònomes designen un senador i un altre per cada milió d’habitants; la designació correspon a la seva assemblea legislativa.', 'mossos_b5_institucions_estat', (select id from public.topics where slug = 'mossos-b5-institucions-estat'), 3, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=142'), 'Guia p. 144, §5', 'Les comunitats autònomes designen a més un Senador i un altre més per cada milió d’habitants del seu territori respectiu.', null, 'ff7c27177057e3b5bdedc98e30fc10a42aaa04406cce057ead2e23d5a7cb5e2a', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'ff7c27177057e3b5bdedc98e30fc10a42aaa04406cce057ead2e23d5a7cb5e2a')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Un senador i un altre més per cada milió d’habitants del seu territori.', true), ('B', 'Dos senadors, independentment de la població.', false), ('C', 'Un senador per cada província del seu territori.', false), ('D', 'Quatre senadors i un altre per cada milió d’habitants.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, a quants candidats com a màxim poden donar el seu vot els electors en les circumscripcions provincials en l’elecció directa de senadors?', 'En les circumscripcions provincials es pot votar un màxim de tres candidats; a Gran Canària, Mallorca, Tenerife, Ceuta i Melilla, dos; a la resta d’illes, un.', 'mossos_b5_institucions_estat', (select id from public.topics where slug = 'mossos-b5-institucions-estat'), 3, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=142'), 'Guia p. 145, §1', 'Els electors poden donar el seu vot a un màxim de tres candidats en les circumscripcions provincials', null, '2aa3d9a1d035b53cdf3c6de4fbc669e5fbdc9aea1673c24cfb9193668ea12eb0', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '2aa3d9a1d035b53cdf3c6de4fbc669e5fbdc9aea1673c24cfb9193668ea12eb0')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'A tres.', true), ('B', 'A un.', false), ('C', 'A dos.', false), ('D', 'A quatre.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, què és necessari perquè un diputat o senador de les Corts Generals pugui ser inculpat o processat?', 'La immunitat implica que només poden ser detinguts en cas de delicte flagrant i que no poden ser inculpats ni processats sense el suplicatori de la seva cambra.', 'mossos_b5_institucions_estat', (select id from public.topics where slug = 'mossos-b5-institucions-estat'), 2, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=142'), 'Guia p. 145, §3', 'no poden ser inculpats ni processats sense l’autorització prèvia de la seva cambra respectiva, mitjançant la concessió del suplicatori', null, 'bdf986190512807d87a2c3d4cb1ebfd99e170e8420bd93a4293619898a291260', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'bdf986190512807d87a2c3d4cb1ebfd99e170e8420bd93a4293619898a291260')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'L’autorització del Tribunal Constitucional.', false), ('B', 'L’autorització prèvia de la seva cambra respectiva, mitjançant la concessió del suplicatori.', true), ('C', 'L’autorització del president del Govern.', false), ('D', 'No cal cap autorització, perquè només tenen inviolabilitat.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, de què és la institució encarregada el Govern de l’Estat?', 'El Govern dirigeix la política interior i exterior, l’Administració civil i militar i exerceix la funció executiva i la potestat reglamentària.', 'mossos_b5_institucions_estat', (select id from public.topics where slug = 'mossos-b5-institucions-estat'), 2, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=142'), 'Guia p. 145, §4', 'El Govern és la institució encarregada de la direcció de la política interior i exterior de l’Estat.', null, 'daabcdfab4d04438111ca498ad8607cf2b96e63ddd9619a8ac71636609ae177a', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'daabcdfab4d04438111ca498ad8607cf2b96e63ddd9619a8ac71636609ae177a')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'De l’elaboració exclusiva de les lleis.', false), ('B', 'Del control de la constitucionalitat de les lleis.', false), ('C', 'De la direcció de la política interior i exterior de l’Estat.', true), ('D', 'De la representació de la unitat de l’Estat.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, quin tribunal pot exigir la responsabilitat penal dels membres del Govern de l’Estat?', 'Els membres del Govern no gaudeixen d’immunitat ni d’inviolabilitat (llevat que siguin parlamentaris), però sí d’aforament davant el Tribunal Suprem.', 'mossos_b5_institucions_estat', (select id from public.topics where slug = 'mossos-b5-institucions-estat'), 3, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=142'), 'Guia p. 145, §6', 'En canvi, sí que gaudeixen d’aforament: la seva responsabilitat penal només pot ser exigida pel Tribunal Suprem.', null, '728825fad1a1f02d81bc34620bcbb6d0b1de8e1bbb6b0c27fdddb193ae303180', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '728825fad1a1f02d81bc34620bcbb6d0b1de8e1bbb6b0c27fdddb193ae303180')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El Tribunal Constitucional.', false), ('B', 'L’Audiència Nacional.', false), ('C', 'El Tribunal Superior de Justícia de Madrid.', false), ('D', 'El Tribunal Suprem.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, en quin d’aquests casos cessa conjuntament el Govern de l’Estat?', 'El Govern cessa conjuntament després d’unes eleccions, per pèrdua de confiança parlamentària i per dimissió o mort del president; continua en funcions fins al nou govern.', 'mossos_b5_institucions_estat', (select id from public.topics where slug = 'mossos-b5-institucions-estat'), 3, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=142'), 'Guia p. 146, §2', 'el Govern cessa conjuntament en tres casos concrets: després d’unes eleccions, en els casos de pèrdua de confiança parlamentària i per dimissió o mort del president del Govern.', null, '0872ebdc0950303527227b4e0c237ae83e88b7cd1ee914504d891e9e21c75992', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '0872ebdc0950303527227b4e0c237ae83e88b7cd1ee914504d891e9e21c75992')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Quan un ministre dimiteix.', false), ('B', 'Quan el Senat rebutja un projecte de llei.', false), ('C', 'Quan el rei ho decideix lliurement.', false), ('D', 'Per dimissió o mort del president del Govern.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, quina és la forma política de govern de l’Estat espanyol?', 'La forma política de l’Estat és la monarquia parlamentària; la titularitat de la Corona és vitalícia i hereditària.', 'mossos_b5_institucions_estat', (select id from public.topics where slug = 'mossos-b5-institucions-estat'), 1, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=142'), 'Guia p. 146, §3', 'La forma política de govern de l’Estat espanyol és la monarquia parlamentària.', null, '1ce54ca06ce31f887cbc3ea4a82655569ea41685ada3e9a7d8afc6f859243aed', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '1ce54ca06ce31f887cbc3ea4a82655569ea41685ada3e9a7d8afc6f859243aed')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'La república parlamentària.', false), ('B', 'La monarquia constitucional amb poder executiu del rei.', false), ('C', 'La monarquia parlamentària.', true), ('D', 'La república federal.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, com qualifica la Constitució les funcions del rei, que no pot negar-se a fer?', 'Les funcions del rei són simbòliques i es consideren actes deguts: no s’hi pot negar ni en pot modificar el contingut.', 'mossos_b5_institucions_estat', (select id from public.topics where slug = 'mossos-b5-institucions-estat'), 2, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=142'), 'Guia p. 146, §5', 'aquestes funcions són considerades des del punt de vista constitucional com a actes deguts, és a dir, actes que el rei no pot negar-se a fer.', null, '6500592bf7078ef37ade3ab76abd9b47bbd04a23fbd2f295673b1c5c4aa97172', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '6500592bf7078ef37ade3ab76abd9b47bbd04a23fbd2f295673b1c5c4aa97172')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Com a actes deguts.', true), ('B', 'Com a actes discrecionals.', false), ('C', 'Com a actes de govern.', false), ('D', 'Com a actes polítics lliures.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, quina d’aquestes és una funció del rei?', 'Entre les funcions del rei hi ha expedir els decrets del Consell de Ministres, sancionar i promulgar les lleis o proposar candidat a president; l’elegeix el Congrés.', 'mossos_b5_institucions_estat', (select id from public.topics where slug = 'mossos-b5-institucions-estat'), 2, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=142'), 'Guia p. 146, §4', 'd) expedir els decrets aprovats pel Consell de Ministres;', null, '90fb359a908e4207efd8cb855df5a0409b554aa960b972c4c9e29929f4880df0', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '90fb359a908e4207efd8cb855df5a0409b554aa960b972c4c9e29929f4880df0')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Dirigir la política exterior de l’Estat.', false), ('B', 'Expedir els decrets aprovats pel Consell de Ministres.', true), ('C', 'Aprovar els pressupostos generals de l’Estat.', false), ('D', 'Elegir el president del Govern.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, què comporta la inviolabilitat del rei?', 'La inviolabilitat implica que no pot ser jutjat penalment; la irresponsabilitat, que no respon dels seus actes, que per això han de ser referendats.', 'mossos_b5_institucions_estat', (select id from public.topics where slug = 'mossos-b5-institucions-estat'), 3, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=142'), 'Guia p. 147, §1', 'La inviolabilitat comporta que el rei no pot ser jutjat d’acord amb les lleis penals.', null, '3cb479dc31c8a8f0d03dc3af2a01de3c35323bcb30dec3886528364c865265c0', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '3cb479dc31c8a8f0d03dc3af2a01de3c35323bcb30dec3886528364c865265c0')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Que el rei no pot ser jutjat d’acord amb les lleis penals.', true), ('B', 'Que els seus actes no estan subjectes a control constitucional.', false), ('C', 'Que no respon de la responsabilitat patrimonial en dret privat.', false), ('D', 'Que els seus actes no necessiten referendament.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, qui ha de referendar la proposta reial de candidat a president o presidenta del Govern?', 'Amb caràcter general refrenden el president del Govern o els ministres; excepcionalment, la proposta de candidat i la dissolució automàtica les referenda el president del Congrés.', 'mossos_b5_institucions_estat', (select id from public.topics where slug = 'mossos-b5-institucions-estat'), 3, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=142'), 'Guia p. 147, §4', 'Excepcionalment, la proposta reial de candidat a president o presidenta del Govern i la dissolució automàtica de les Corts Generals (en aquells casos en què no s’hagi pogut completar el procediment d’investidura del president o presidenta del Govern) han de ser referendats pel president o presidenta del Congrés dels Diputats.', null, 'c429942db7a24c68b43657e33ae6069d706dd47b5467b56b7ee95d647e93fe58', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'c429942db7a24c68b43657e33ae6069d706dd47b5467b56b7ee95d647e93fe58')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El president o presidenta del Govern en funcions.', false), ('B', 'El president o presidenta del Congrés dels Diputats.', true), ('C', 'El ministre de Justícia.', false), ('D', 'El president o presidenta del Senat.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, quin òrgan determina la responsabilitat comptable dels qui tenen al seu càrrec la utilització de fons públics?', 'El Tribunal de Comptes fiscalitza els comptes de l’Estat i del sector públic i té una funció jurisdiccional de responsabilitat comptable.', 'mossos_b5_institucions_estat', (select id from public.topics where slug = 'mossos-b5-institucions-estat'), 2, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=142'), 'Guia p. 147, §6', 'fa una funció jurisdiccional consistent a determinar la responsabilitat comptable en què incorren aquells que tenen al seu càrrec la utilització de fons i cabals públics.', null, '3daf9551ed98c060842700ac6e2813757a6b96c3582efafc67d225c24bfaffc3', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '3daf9551ed98c060842700ac6e2813757a6b96c3582efafc67d225c24bfaffc3')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El Consell d’Estat.', false), ('B', 'La Sindicatura de Comptes.', false), ('C', 'El Tribunal de Comptes.', true), ('D', 'El Tribunal Suprem.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, quin és l’òrgan consultiu suprem del Govern de l’Estat?', 'L’article 107 de la CE configura el Consell d’Estat com a òrgan consultiu suprem del Govern.', 'mossos_b5_institucions_estat', (select id from public.topics where slug = 'mossos-b5-institucions-estat'), 2, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=142'), 'Guia p. 147, §7', 'És l’òrgan consultiu suprem del Govern (article 107 de la CE).', null, '4fefed06b83e6eb3ad808118dbeb8e9eb5a750e1e7432ed0abfacb3c837a5364', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '4fefed06b83e6eb3ad808118dbeb8e9eb5a750e1e7432ed0abfacb3c837a5364')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El Tribunal de Comptes.', false), ('B', 'La Comissió Jurídica Assessora.', false), ('C', 'El Consell Econòmic i Social.', false), ('D', 'El Consell d’Estat.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
-- Lote mossos-b6-organs-jurisdiccionals-guia-v1 (20 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Guia d''estudi per accedir a la PG-ME, 1a edició, juny de 2026 (convocatòria 46/26), tema B.6, pp. 150-157', 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=150', 'web_oficial'::public.source_kind, 'Generalitat de Catalunya · Mossos d''Esquadra (web oficial de la convocatòria 46/26)', '2026-06-01') on conflict (url) do nothing;
insert into public.topics (slug, title) values ('mossos-b6-organs-jurisdiccionals', 'B.6 Els òrgans jurisdiccionals') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug = 'mossos-esquadra' and t.slug = 'mossos-b6-organs-jurisdiccionals' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, quina llei regula el poder judicial, juntament amb la CE?', 'El poder judicial es regula a la CE i a la Llei orgànica 6/1985, del poder judicial (LOPJ).', 'mossos_b6_organs_jurisdiccionals', (select id from public.topics where slug = 'mossos-b6-organs-jurisdiccionals'), 2, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=150'), 'Guia p. 151, §1', 'El poder judicial es regula a la CE i a la Llei orgànica 6/1985, d’1 de juliol, del poder judicial.', null, 'ec289bb033e7e2aa1982c9966a1328c32a17e3ea280361cc31b0650dc09c1f2d', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'ec289bb033e7e2aa1982c9966a1328c32a17e3ea280361cc31b0650dc09c1f2d')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'La Llei orgànica 2/1979, del Tribunal Constitucional.', false), ('B', 'La Llei 50/1981, de l’Estatut orgànic del Ministeri Fiscal.', false), ('C', 'La Llei orgànica 5/1985, del règim electoral general.', false), ('D', 'La Llei orgànica 6/1985, d’1 de juliol, del poder judicial.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, què és l’Administració de justícia?', 'L’Administració de justícia no és poder judicial: és el conjunt de mitjans personals i materials que li dona suport.', 'mossos_b6_organs_jurisdiccionals', (select id from public.topics where slug = 'mossos-b6-organs-jurisdiccionals'), 2, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=150'), 'Guia p. 151, §3', 'L’Administració de justícia no és poder judicial, sinó que comprèn el conjunt de mitjans personals i materials destinats a l’organització de les activitats relacionades amb la justícia', null, 'f12347a293cd7b48383e28bd396fbf2e695cbff2b4ca1f857954b86f27461ce3', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'f12347a293cd7b48383e28bd396fbf2e695cbff2b4ca1f857954b86f27461ce3')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Un dels òrgans que integren el poder judicial.', false), ('B', 'El conjunt de mitjans personals i materials destinats a l’organització de les activitats relacionades amb la justícia.', true), ('C', 'L’òrgan de govern dels jutges i magistrats.', false), ('D', 'El conjunt de fiscals que promouen l’acció de la justícia.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, quin principi configurador del poder judicial impedeix que hi hagi jurisdiccions especials o tribunals no determinats prèviament per la llei?', 'La unitat jurisdiccional implica un poder judicial únic a tot l’Estat, sense jurisdiccions especials; l’exclusivitat reserva la potestat jurisdiccional als jutjats i tribunals.', 'mossos_b6_organs_jurisdiccionals', (select id from public.topics where slug = 'mossos-b6-organs-jurisdiccionals'), 3, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=150'), 'Guia p. 151, §5', 'No hi pot haver jurisdiccions especials, ni es poden crear tribunals que no es trobin prèviament determinats per la llei.', null, 'f4a342385c56ae6ef62e33e80350b22bcd20c04b20630207a125040284574084', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'f4a342385c56ae6ef62e33e80350b22bcd20c04b20630207a125040284574084')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El principi d’exclusivitat.', false), ('B', 'El principi d’inamovibilitat.', false), ('C', 'El principi d’unitat jurisdiccional.', true), ('D', 'El principi d’imparcialitat.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, quins principis regeixen l’estatut dels jutges i magistrats?', 'L’estatut dels jutges es regeix per la independència, la inamovibilitat, la imparcialitat, la incompatibilitat i la responsabilitat. Unitat d’actuació i dependència jeràrquica són principis del Ministeri Fiscal.', 'mossos_b6_organs_jurisdiccionals', (select id from public.topics where slug = 'mossos-b6-organs-jurisdiccionals'), 2, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=150'), 'Guia p. 151, §6', 'es regeix pels principis següents: independència, inamovibilitat, imparcialitat, incompatibilitat i responsabilitat.', null, '0139b81df30150b214fae1f1f3aa56805b49359bb59aef840e0f9f2ac3b77c0b', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '0139b81df30150b214fae1f1f3aa56805b49359bb59aef840e0f9f2ac3b77c0b')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Independència, inamovibilitat, imparcialitat, incompatibilitat i responsabilitat.', true), ('B', 'Unitat, exclusivitat, jerarquia i legalitat.', false), ('C', 'Unitat d’actuació, dependència jeràrquica, legalitat i imparcialitat.', false), ('D', 'Publicitat, oralitat, gratuïtat i immediació.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, quin principi de l’estatut dels jutges garanteix que només puguin ser separats, suspesos, traslladats o jubilats per les causes establertes per la llei?', 'La inamovibilitat evita que siguin apartats de les funcions per causes no estrictament professionals.', 'mossos_b6_organs_jurisdiccionals', (select id from public.topics where slug = 'mossos-b6-organs-jurisdiccionals'), 2, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=150'), 'Guia p. 152, §2', 'Els jutges i magistrats només poden ser separats, suspesos, traslladats o jubilats per les causes establertes per la llei', null, '87e3bb867ab317662a701e02ddd7ae2dfca49979828b5a59c567fc367887c21c', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '87e3bb867ab317662a701e02ddd7ae2dfca49979828b5a59c567fc367887c21c')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'La inamovibilitat.', true), ('B', 'La independència.', false), ('C', 'La incompatibilitat.', false), ('D', 'La responsabilitat.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, com s’anomena el mecanisme pel qual les parts del procés poden demanar que el jutge no conegui del cas?', 'L’abstenció la fa el mateix òrgan judicial; la recusació la demanen les parts. Totes dues garanteixen la imparcialitat.', 'mossos_b6_organs_jurisdiccionals', (select id from public.topics where slug = 'mossos-b6-organs-jurisdiccionals'), 2, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=150'), 'Guia p. 152, §3', 'la recusació (les parts del procés poden demanar que el jutge i magistrat no conegui del cas si incorre en alguna de les causes esmentades).', null, '70687a8fbd4748b24f8866148320d4e69924b86c0fbc60b95efc29bcc40549df', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '70687a8fbd4748b24f8866148320d4e69924b86c0fbc60b95efc29bcc40549df')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'L’abstenció.', false), ('B', 'La inhibició.', false), ('C', 'El suplicatori.', false), ('D', 'La recusació.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, què poden fer els jutges i magistrats d’acord amb el règim d’incompatibilitats?', 'No poden exercir altres càrrecs públics ni pertànyer a partits o sindicats, però sí crear associacions professionals.', 'mossos_b6_organs_jurisdiccionals', (select id from public.topics where slug = 'mossos-b6-organs-jurisdiccionals'), 2, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=150'), 'Guia p. 152, §4', 'Els jutges i magistrats no poden exercir altres càrrecs públics, ni pertànyer a partits polítics o sindicats, però poden crear associacions professionals.', null, '611d0958194abd2fed77ca0767e7450377c010f33dde3256a802de282c154c27', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '611d0958194abd2fed77ca0767e7450377c010f33dde3256a802de282c154c27')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Pertànyer a partits polítics.', false), ('B', 'Crear associacions professionals.', true), ('C', 'Afiliar-se a sindicats.', false), ('D', 'Exercir altres càrrecs públics.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, quina sala del Tribunal Suprem és la militar?', 'La jurisdicció militar no s’integra en el poder judicial, excepte la Sala Cinquena del Tribunal Suprem.', 'mossos_b6_organs_jurisdiccionals', (select id from public.topics where slug = 'mossos-b6-organs-jurisdiccionals'), 3, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=150'), 'Guia p. 153, §2', 'excepte pel que fa a la Sala Cinquena del Tribunal Suprem, que és militar.', null, '916c4954cc14d46ec5dc03eba009b81523d6c670aa32afa663144cfbc8dd3d75', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '916c4954cc14d46ec5dc03eba009b81523d6c670aa32afa663144cfbc8dd3d75')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'La Sala Primera.', false), ('B', 'La Sala Segona.', false), ('C', 'La Sala Cinquena.', true), ('D', 'La Sala Quarta.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, on hi ha jutjats de pau?', 'Els jutjats de primera instància i instrucció són a cada partit judicial; els de pau, als municipis on no n’hi ha.', 'mossos_b6_organs_jurisdiccionals', (select id from public.topics where slug = 'mossos-b6-organs-jurisdiccionals'), 2, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=150'), 'Guia p. 153, §3', 'g) Jutjats de pau (en els municipis en què no hi hagi jutjats de primera instància i instrucció).', null, '28862f27edddeee40abaadbf7f0a97a04e4e8bb4acd8f84cfd18328776337bdb', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '28862f27edddeee40abaadbf7f0a97a04e4e8bb4acd8f84cfd18328776337bdb')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'A cada partit judicial.', false), ('B', 'A cada província.', false), ('C', 'En els municipis en què no hi hagi jutjats de primera instància i instrucció.', true), ('D', 'A cada comarca.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, a quin òrgan correspon en exclusiva la unificació de la interpretació del dret de Catalunya?', 'El TSJC és l’última instància dels processos iniciats a Catalunya i li correspon en exclusiva unificar la interpretació del dret de Catalunya.', 'mossos_b6_organs_jurisdiccionals', (select id from public.topics where slug = 'mossos-b6-organs-jurisdiccionals'), 2, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=150'), 'Guia p. 153, §6', 'Correspon en exclusiva al Tribunal Superior de Justícia de Catalunya la unificació de la interpretació del dret de Catalunya.', null, 'db736f76e1719dfa5afd9a645a05af9813b67db571c9c2ded2980a1b86e39bd5', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'db736f76e1719dfa5afd9a645a05af9813b67db571c9c2ded2980a1b86e39bd5')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Al Tribunal Superior de Justícia de Catalunya.', true), ('B', 'Al Tribunal Suprem.', false), ('C', 'Al Consell de Garanties Estatutàries.', false), ('D', 'Al Tribunal Constitucional.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, com és nomenat el president o presidenta del Tribunal Superior de Justícia de Catalunya?', 'El president del TSJC és nomenat pel rei a proposta del CGPJ.', 'mossos_b6_organs_jurisdiccionals', (select id from public.topics where slug = 'mossos-b6-organs-jurisdiccionals'), 2, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=150'), 'Guia p. 153, §7', 'El president o presidenta del Tribunal Superior de Justícia de Catalunya és nomenat pel rei a proposta del Consell General del Poder Judicial.', null, 'd97723a6ef1501d8f0c2332e2ce1fa1f79f8983852850874bc1b757070613c63', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'd97723a6ef1501d8f0c2332e2ce1fa1f79f8983852850874bc1b757070613c63')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Pel president de la Generalitat, a proposta del Parlament.', false), ('B', 'Pel rei, a proposta del Consell General del Poder Judicial.', true), ('C', 'Pel Parlament, per majoria de tres cinquenes parts.', false), ('D', 'Pel Govern de l’Estat, a proposta del ministre de Justícia.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, quin és l’òrgan de govern del poder judicial?', 'El CGPJ és l’òrgan de govern del poder judicial, amb funcions de nomenaments, ascensos, inspecció i règim disciplinari.', 'mossos_b6_organs_jurisdiccionals', (select id from public.topics where slug = 'mossos-b6-organs-jurisdiccionals'), 2, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=150'), 'Guia p. 154, §1', 'El Consell General del Poder Judicial (CGPJ) és l’òrgan de govern del poder judicial', null, '21048a28268f685d0d67343a5676bdcc25c0ab42ed7a2286eea38248452ac17d', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '21048a28268f685d0d67343a5676bdcc25c0ab42ed7a2286eea38248452ac17d')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El Tribunal Suprem.', false), ('B', 'El Ministeri de Justícia.', false), ('C', 'El Ministeri Fiscal.', false), ('D', 'El Consell General del Poder Judicial.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, com es distribueixen els vint vocals del Consell General del Poder Judicial?', 'El CGPJ té un president i vint vocals: dotze jutges i magistrats i vuit juristes de reconeguda competència.', 'mossos_b6_organs_jurisdiccionals', (select id from public.topics where slug = 'mossos-b6-organs-jurisdiccionals'), 3, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=150'), 'Guia p. 154, §5', 'El CGPJ es compon d’un president i vint vocals nomenats pel rei i escollits per les Corts Generals entre jutges (12) i juristes (8) de reconeguda competència', 'La guia descriu el sistema d’elecció de la LO 4/2013; les reformes posteriors del CGPJ poden haver modificat detalls del procediment. Es pregunta només la composició.', '54834eca38334c1e7d8b40b50cd1c3536b87804efd0a9e4a7cbadbe4f6eac09a', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '54834eca38334c1e7d8b40b50cd1c3536b87804efd0a9e4a7cbadbe4f6eac09a')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Deu jutges i deu juristes.', false), ('B', 'Dotze jutges i magistrats i vuit juristes de reconeguda competència.', true), ('C', 'Vuit jutges i dotze juristes.', false), ('D', 'Quinze jutges i cinc juristes.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, quina d’aquestes és una funció del Consell General del Poder Judicial?', 'El CGPJ exerceix l’alta inspecció de jutjats i tribunals; respecte del Fiscal General només és escoltat pel Govern.', 'mossos_b6_organs_jurisdiccionals', (select id from public.topics where slug = 'mossos-b6-organs-jurisdiccionals'), 3, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=150'), 'Guia p. 155, §1', 'd) Exercir l’alta inspecció de jutjats i tribunals.', null, '3caf083ee0cab4320e2945838e2c1eca365ad19a7b21fe6584adb71318f62a88', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '3caf083ee0cab4320e2945838e2c1eca365ad19a7b21fe6584adb71318f62a88')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Exercir l’alta inspecció de jutjats i tribunals.', true), ('B', 'Nomenar el Fiscal General de l’Estat.', false), ('C', 'Resoldre els recursos d’empara.', false), ('D', 'Aprovar la Llei orgànica del poder judicial.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, d’acord amb quins principis exerceix les seves funcions el Ministeri Fiscal?', 'El Ministeri Fiscal, que no forma part del poder judicial, actua segons els principis d’unitat d’actuació i dependència jeràrquica, amb subjecció a la legalitat i imparcialitat.', 'mossos_b6_organs_jurisdiccionals', (select id from public.topics where slug = 'mossos-b6-organs-jurisdiccionals'), 3, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=150'), 'Guia p. 155, §2', 'Exerceix les seves funcions mitjançant òrgans propis d’acord amb els principis d’unitat d’actuació, dependència jeràrquica i subjecció a la legalitat i imparcialitat.', null, '8a96b9f33c22dccb09930725acb8750019f461598c2f22bb0243a058b98a3c1a', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '8a96b9f33c22dccb09930725acb8750019f461598c2f22bb0243a058b98a3c1a')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Independència, inamovibilitat i responsabilitat.', false), ('B', 'Exclusivitat i unitat jurisdiccional.', false), ('C', 'Unitat d’actuació, dependència jeràrquica, i subjecció a la legalitat i imparcialitat.', true), ('D', 'Autonomia orgànica, funcional i pressupostària.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, quina és la durada del mandat del Fiscal General de l’Estat?', 'El mandat del Fiscal General és de quatre anys (art. 31 de l’Estatut orgànic del Ministeri Fiscal).', 'mossos_b6_organs_jurisdiccionals', (select id from public.topics where slug = 'mossos-b6-organs-jurisdiccionals'), 2, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=150'), 'Guia p. 155, §3', 'El mandat del fiscal general té una durada de quatre anys', null, '2bd8964ee05a9dd561eaa1d4e3f1a709334dc0a230d92139c90d87808d82cc2b', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '2bd8964ee05a9dd561eaa1d4e3f1a709334dc0a230d92139c90d87808d82cc2b')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Tres anys.', false), ('B', 'Cinc anys.', false), ('C', 'Nou anys.', false), ('D', 'Quatre anys.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, quants magistrats componen el Tribunal Constitucional i per a quin període són nomenats?', 'Segons l’article 159 de la CE, el TC té dotze magistrats nomenats pel rei per nou anys.', 'mossos_b6_organs_jurisdiccionals', (select id from public.topics where slug = 'mossos-b6-organs-jurisdiccionals'), 2, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=150'), 'Guia p. 156, §1', 'El TC, d’acord amb el que disposa l’article 159 de la CE, es compon de dotze magistrats, nomenats pel rei per un període de nou anys.', null, '1fc48249e98aa88b8918f507cc8d762a3e6e233d6edb7a3841f496f0a8c65507', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '1fc48249e98aa88b8918f507cc8d762a3e6e233d6edb7a3841f496f0a8c65507')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Dotze magistrats per un període de nou anys.', true), ('B', 'Deu magistrats per un període de sis anys.', false), ('C', 'Dotze magistrats per un període de cinc anys.', false), ('D', 'Quinze magistrats per un període de nou anys.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, quants magistrats del Tribunal Constitucional són nomenats a proposta del Govern?', 'Quatre a proposta del Congrés, quatre del Senat, dos del Govern i dos del CGPJ.', 'mossos_b6_organs_jurisdiccionals', (select id from public.topics where slug = 'mossos-b6-organs-jurisdiccionals'), 3, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=150'), 'Guia p. 156, §2', 'Dels altres quatre magistrats, dos són nomenats a proposta del Govern i dos a proposta del CGPJ per majoria de 3/5.', null, 'd53c19275e1a2279e721fa7ab5340de21a469ed289584a62ca4027ecbce9d269', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'd53c19275e1a2279e721fa7ab5340de21a469ed289584a62ca4027ecbce9d269')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Cap.', false), ('B', 'Tres.', false), ('C', 'Quatre.', false), ('D', 'Dos.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, cada quant de temps es nomena el president o presidenta del Tribunal Constitucional?', 'El president del TC és nomenat entre i pels seus membres cada tres anys (majoria absoluta a la primera votació i simple a la segona).', 'mossos_b6_organs_jurisdiccionals', (select id from public.topics where slug = 'mossos-b6-organs-jurisdiccionals'), 2, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=150'), 'Guia p. 156, §3', 'El president o presidenta del TC és nomenat entre i pels seus membres cada tres anys.', null, '807233e27835d8bc21879eda30fe4e8603aa0aa85b88dc028e54778b77cdcf3e', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '807233e27835d8bc21879eda30fe4e8603aa0aa85b88dc028e54778b77cdcf3e')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Cada any.', false), ('B', 'Cada dos anys.', false), ('C', 'Cada tres anys.', true), ('D', 'Cada nou anys.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, quin és l’objecte del control previ de tractats internacionals pel Tribunal Constitucional?', 'El control previ permet que el TC es pronunciï abans de la signatura sobre possibles estipulacions contràries a la CE.', 'mossos_b6_organs_jurisdiccionals', (select id from public.topics where slug = 'mossos-b6-organs-jurisdiccionals'), 3, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=150'), 'Guia p. 156, §4', 'abans de la signatura d’un tractat internacional per l’Estat, es pronunciï sobre si el tractat conté estipulacions contràries a la CE.', null, '9a1882d4591fa074c0918c2db46a78d375a06cce923a7341f3fdaf1cd30caed4', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '9a1882d4591fa074c0918c2db46a78d375a06cce923a7341f3fdaf1cd30caed4')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Ratificar els tractats després de la seva signatura.', false), ('B', 'Que el TC es pronunciï, abans de la signatura, sobre si el tractat conté estipulacions contràries a la CE.', true), ('C', 'Resoldre conflictes entre l’Estat i les comunitats autònomes sobre els tractats.', false), ('D', 'Declarar la nul·litat dels tractats ja incorporats a l’ordenament.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
-- Lote mossos-b7-organitzacio-territorial-guia-v1 (20 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Guia d''estudi per accedir a la PG-ME, 1a edició, juny de 2026 (convocatòria 46/26), tema B.7, pp. 158-166', 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=158', 'web_oficial'::public.source_kind, 'Generalitat de Catalunya · Mossos d''Esquadra (web oficial de la convocatòria 46/26)', '2026-06-01') on conflict (url) do nothing;
insert into public.topics (slug, title) values ('mossos-b7-organitzacio-territorial', 'B.7 L''organització territorial de l''Estat') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug = 'mossos-esquadra' and t.slug = 'mossos-b7-organitzacio-territorial' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, en quines entitats s’estructura territorialment l’Estat espanyol?', 'L’Estat s’estructura en comunitats autònomes, municipis i províncies, i es poden crear agrupacions de municipis diferents de la província.', 'mossos_b7_organitzacio_territorial', (select id from public.topics where slug = 'mossos-b7-organitzacio-territorial'), 1, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=158'), 'Guia p. 159, §1', 'L’Estat espanyol s’estructura en comunitats autònomes, municipis i províncies.', null, '4a6a13992e002897ef613e25e02d9c94ae949b0a9c3f78654d603549e46788b0', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '4a6a13992e002897ef613e25e02d9c94ae949b0a9c3f78654d603549e46788b0')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'En regions, comarques i municipis.', false), ('B', 'En comunitats autònomes, municipis i províncies.', true), ('C', 'En estats federats i municipis.', false), ('D', 'En vegueries, províncies i municipis.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, on i amb quina constitució neix l’Estat unitari?', 'L’Estat unitari neix a França amb la caiguda de l’antic règim i la Constitució de 1791; l’Estat federal, amb la Constitució dels Estats Units de 1787.', 'mossos_b7_organitzacio_territorial', (select id from public.topics where slug = 'mossos-b7-organitzacio-territorial'), 2, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=158'), 'Guia p. 159, §3', 'L’Estat unitari neix a França amb la caiguda de l’antic règim, a partir de les idees racionalistes dels revolucionaris i que foren portades a la pràctica amb la Constitució de 1791.', null, '81ba6a7da484194521a1bd5138b64199724d1e089e370dae40e498ca2b713331', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '81ba6a7da484194521a1bd5138b64199724d1e089e370dae40e498ca2b713331')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'A França, portat a la pràctica amb la Constitució de 1791.', true), ('B', 'Als Estats Units, amb la Constitució de 1787.', false), ('C', 'A Espanya, amb la Constitució de 1812.', false), ('D', 'A Alemanya, amb la Constitució de 1871.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, en quins principis es basa l’Estat unitari?', 'L’Estat unitari es basa en la unitat (un sol Estat), la uniformitat (la mateixa llei a tot el territori) i la centralització.', 'mossos_b7_organitzacio_territorial', (select id from public.topics where slug = 'mossos-b7-organitzacio-territorial'), 2, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=158'), 'Guia p. 159, §5', 'Els principis en què es basa són, doncs, la unitat (un sol Estat), la uniformitat (la mateixa llei per a tot el territori) i la centralització', null, 'a279bd54d78c69319a7c06e5eed5fce16018848652b22191e7d08ff7ff7e2426', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'a279bd54d78c69319a7c06e5eed5fce16018848652b22191e7d08ff7ff7e2426')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Pluralitat, diversitat i descentralització.', false), ('B', 'Autonomia, solidaritat i coordinació.', false), ('C', 'Unitat, subsidiarietat i proporcionalitat.', false), ('D', 'Unitat, uniformitat i centralització.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, què afegeix l’Estat federal a la divisió horitzontal de poders?', 'A l’Estat federal, a més de la divisió horitzontal (executiu, legislatiu i judicial), hi ha una divisió vertical del poder entre la federació i els estats membres.', 'mossos_b7_organitzacio_territorial', (select id from public.topics where slug = 'mossos-b7-organitzacio-territorial'), 3, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=158'), 'Guia p. 160, §1', 'en l’Estat federal no hi ha només el que se’n diu una divisió horitzontal de poders (executiu, legislatiu i judicial), sinó també una divisió vertical, que provoca que aquell poder ja dividit es trobi també repartit territorialment.', null, 'be3307b984048b0f1a399343dbc7ab696acb2058cdb6c4eba160047b1a5f49c0', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'be3307b984048b0f1a399343dbc7ab696acb2058cdb6c4eba160047b1a5f49c0')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Una divisió funcional entre administració civil i militar.', false), ('B', 'Una divisió entre poder constituent i poders constituïts.', false), ('C', 'Una divisió vertical, que reparteix territorialment el poder ja dividit.', true), ('D', 'Una divisió entre l’Estat i la societat civil.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, quina d’aquestes estructures es manté unitària a l’interior d’un Estat federal?', 'L’Estat federal manté estructures unitàries com l’exèrcit, la moneda, el sistema econòmic, les duanes, les comunicacions i els símbols.', 'mossos_b7_organitzacio_territorial', (select id from public.topics where slug = 'mossos-b7-organitzacio-territorial'), 3, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=158'), 'Guia p. 160, §2', 'manté unes estructures unitàries a l’interior (exèrcit, moneda, sistema econòmic, duanes, comunicacions i símbols)', null, '100e35bdbecd31c7832039eaf8ac5d3c7578b365d04d9ef1ef451a29e0fff5ca', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '100e35bdbecd31c7832039eaf8ac5d3c7578b365d04d9ef1ef451a29e0fff5ca')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'La moneda.', true), ('B', 'El sistema educatiu.', false), ('C', 'El règim local.', false), ('D', 'La policia de proximitat.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, com s’acostumen a agrupar les noves formes d’organització territorial com l’Estat regional, l’Estat integral i l’Estat autonòmic?', 'Les noves formes (Estat regional, integral i autonòmic) s’agrupen sota la denominació d’estats compostos.', 'mossos_b7_organitzacio_territorial', (select id from public.topics where slug = 'mossos-b7-organitzacio-territorial'), 2, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=158'), 'Guia p. 160, §3', '(Estat regional, Estat integral i Estat autonòmic), que s’acostumen a agrupar sota la denominació d’estats compostos.', null, 'b30697db5694cdbf975b31c0ba802954f594e46d340240fe583a0049bf216d92', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'b30697db5694cdbf975b31c0ba802954f594e46d340240fe583a0049bf216d92')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Sota la denominació d’estats federals.', false), ('B', 'Sota la denominació d’estats compostos.', true), ('C', 'Sota la denominació d’estats unitaris descentralitzats.', false), ('D', 'Sota la denominació de confederacions.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, a partir de quin principi la CE possibilita la generalització del règim autonòmic?', 'Partint del principi dispositiu, la CE deixa als estatuts d’autonomia la decisió final sobre l’organització territorial.', 'mossos_b7_organitzacio_territorial', (select id from public.topics where slug = 'mossos-b7-organitzacio-territorial'), 3, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=158'), 'Guia p. 160, §5', 'Mitjançant un determinat procés polític i jurídic, partint de l’anomenat principi dispositiu, la CE possibilita que el règim autonòmic es generalitzi', null, 'fda4482c2bbb6596ccf6ffa4a4e6d0ddb3866b5b3d186aa7dd7819318c12bbf7', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'fda4482c2bbb6596ccf6ffa4a4e6d0ddb3866b5b3d186aa7dd7819318c12bbf7')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El principi de jerarquia.', false), ('B', 'El principi de subsidiarietat.', false), ('C', 'El principi de supletorietat.', false), ('D', 'El principi dispositiu.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, quin any es van aprovar els primers estatuts d’autonomia?', 'L’aprovació el 1979 dels primers estatuts va posar en funcionament l’Estat autonòmic o de les autonomies.', 'mossos_b7_organitzacio_territorial', (select id from public.topics where slug = 'mossos-b7-organitzacio-territorial'), 2, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=158'), 'Guia p. 161, §2', 'L’aprovació el 1979 dels primers estatuts d’autonomia va posar en funcionament un determinat tipus d’organització territorial de l’Estat', null, '578906cc891f3187e438b1df5ff834d19524a315b1aae7ebff195bf22a60fc68', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '578906cc891f3187e438b1df5ff834d19524a315b1aae7ebff195bf22a60fc68')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', '1978.', false), ('B', '1981.', false), ('C', '1979.', true), ('D', '1983.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, quin tipus d’autonomia s’atorga als municipis i les províncies, a diferència de les comunitats autònomes?', 'L’autonomia de les comunitats autònomes és qualitativament diferent: municipis i províncies només tenen autonomia administrativa.', 'mossos_b7_organitzacio_territorial', (select id from public.topics where slug = 'mossos-b7-organitzacio-territorial'), 3, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=158'), 'Guia p. 161, §3', 'els municipis i les províncies, a les quals només s’atorga autonomia administrativa.', null, '0cb4201463e2ac85c5612e4cfc055864d3cc2295c258c569dda874e52e1e2f32', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '0cb4201463e2ac85c5612e4cfc055864d3cc2295c258c569dda874e52e1e2f32')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Autonomia política.', false), ('B', 'Només autonomia administrativa.', true), ('C', 'Autonomia legislativa.', false), ('D', 'Autonomia jurisdiccional.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, de quin tipus són les relacions de les comunitats autònomes amb l’Estat central?', 'Les relacions amb l’Estat central no són de jerarquia sinó de competència.', 'mossos_b7_organitzacio_territorial', (select id from public.topics where slug = 'mossos-b7-organitzacio-territorial'), 2, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=158'), 'Guia p. 161, §3', 'f) Les relacions amb l’Estat central no són de jerarquia sinó de competència.', null, 'cd2db8a462b0111463267822de14d7b266c05a81a43fa4486300e5396c43de46', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'cd2db8a462b0111463267822de14d7b266c05a81a43fa4486300e5396c43de46')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'De jerarquia.', false), ('B', 'De tutela.', false), ('C', 'De competència.', true), ('D', 'De dependència orgànica.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, quantes comunitats autònomes i ciutats autònomes s’han creat?', 'El dret a l’autonomia es va completar amb 17 comunitats autònomes i dues ciutats autònomes, Ceuta i Melilla.', 'mossos_b7_organitzacio_territorial', (select id from public.topics where slug = 'mossos-b7-organitzacio-territorial'), 2, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=158'), 'Guia p. 161, §4', 'es va completar amb la creació de 17 comunitats autònomes i de dues ciutats autònomes (Ceuta i Melilla).', null, 'abaf79895f9ab792d5d9d2b913305459cbd0ccfbda07ce7bfc2662ff4b201666', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'abaf79895f9ab792d5d9d2b913305459cbd0ccfbda07ce7bfc2662ff4b201666')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', '17 comunitats autònomes i 2 ciutats autònomes.', true), ('B', '15 comunitats autònomes i 2 ciutats autònomes.', false), ('C', '17 comunitats autònomes i cap ciutat autònoma.', false), ('D', '19 comunitats autònomes.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, quan poden ampliar les seves competències les comunitats autònomes que van accedir a l’autonomia per la via de l’article 143?', 'D’acord amb l’article 148.2, poden ampliar successivament les competències un cop transcorreguts cinc anys des de l’aprovació dels estatuts.', 'mossos_b7_organitzacio_territorial', (select id from public.topics where slug = 'mossos-b7-organitzacio-territorial'), 3, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=158'), 'Guia p. 162, §3', 'd’acord amb l’article 148.2, poden ampliar successivament les seves competències un cop hagin transcorregut cinc anys des de l’aprovació dels seus respectius estatuts d’autonomia.', null, '86db81a29ee0b45f28c365c30e36669639a6b0069ae34557467e95677cd846b8', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '86db81a29ee0b45f28c365c30e36669639a6b0069ae34557467e95677cd846b8')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Immediatament després d’aprovar el seu estatut.', false), ('B', 'Al cap de tres anys de l’aprovació de l’estatut.', false), ('C', 'Només mitjançant una reforma constitucional.', false), ('D', 'Un cop transcorreguts cinc anys des de l’aprovació dels seus estatuts.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, quines forces polítiques van signar el pacte autonòmic de 1981?', 'El pacte autonòmic de 1981 el van signar el PSOE i la UCD; el de 1992, el PSOE i el PP.', 'mossos_b7_organitzacio_territorial', (select id from public.topics where slug = 'mossos-b7-organitzacio-territorial'), 3, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=158'), 'Guia p. 162, §5', 'el “pacte autonòmic” signat el 1981 per les aleshores forces polítiques majoritàries a l’Estat espanyol, el PSOE i la UCD', null, '60f87ca279ec610ce6b13d28d683323a8f74e45bb53fca1c160fa9b87d745952', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '60f87ca279ec610ce6b13d28d683323a8f74e45bb53fca1c160fa9b87d745952')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El PSOE i el PP.', false), ('B', 'El PSOE i la UCD.', true), ('C', 'La UCD i AP.', false), ('D', 'El PSOE i CiU.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, quin és la unitat local bàsica de l’organització territorial?', 'El municipi és la unitat local bàsica; els ajuntaments són els seus òrgans de govern.', 'mossos_b7_organitzacio_territorial', (select id from public.topics where slug = 'mossos-b7-organitzacio-territorial'), 2, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=158'), 'Guia p. 162, §7', 'El municipi és, doncs, la unitat local bàsica de l’organització territorial', null, '2b00ac891dbe4497066eb5c116e7cd8298fa4b23a26418af1a47dab4d9132e04', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '2b00ac891dbe4497066eb5c116e7cd8298fa4b23a26418af1a47dab4d9132e04')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'La comarca.', false), ('B', 'La província.', false), ('C', 'La vegueria.', false), ('D', 'El municipi.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, a partir de quina població els municipis han de tenir necessàriament una comissió de govern?', 'Els municipis de més de cinc mil habitants han de tenir necessàriament una comissió de govern.', 'mossos_b7_organitzacio_territorial', (select id from public.topics where slug = 'mossos-b7-organitzacio-territorial'), 3, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=158'), 'Guia p. 162, §7', 'els municipis de més de cinc mil habitants han de tenir necessàriament una comissió de govern.', null, '8fccdbeed57afb3449d063ab3e77f560d7629b2136733f7e492c7a3fd2fa6aad', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '8fccdbeed57afb3449d063ab3e77f560d7629b2136733f7e492c7a3fd2fa6aad')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Més de mil habitants.', false), ('B', 'Més de vint mil habitants.', false), ('C', 'Més de cinc mil habitants.', true), ('D', 'Més de cinquanta mil habitants.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, quina llei estatal reserva una esfera pròpia de competències als ens locals?', 'La Llei 7/1985, de bases de règim local (LBRL), atribueix als municipis matèries com urbanisme, trànsit urbà, mercats o cementiris.', 'mossos_b7_organitzacio_territorial', (select id from public.topics where slug = 'mossos-b7-organitzacio-territorial'), 2, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=158'), 'Guia p. 163, §1', 'La legislació de l’Estat, a través de la Llei 7/1985, de bases de règim local (LBRL), ha reservat una esfera pròpia de competències als ens locals', null, 'b26fcfcf098ce270a1c9d7bb7c5665c20a8e2e61bfbc5e795480efed14d5fdbe', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'b26fcfcf098ce270a1c9d7bb7c5665c20a8e2e61bfbc5e795480efed14d5fdbe')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'La Llei 7/1985, de bases de règim local.', true), ('B', 'El Decret legislatiu 2/2003.', false), ('C', 'La Llei orgànica 5/1985, del règim electoral general.', false), ('D', 'La Llei 50/1997, del Govern.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, què vol dir que la província té un caràcter bifront?', 'La província és divisió administrativa per al compliment de les finalitats de l’Estat i circumscripció electoral per al Congrés i el Senat.', 'mossos_b7_organitzacio_territorial', (select id from public.topics where slug = 'mossos-b7-organitzacio-territorial'), 3, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=158'), 'Guia p. 163, §3', 'la província té un caràcter bifront, és a dir, d’una banda, gaudeix de la doble condició de divisió administrativa per al compliment de les finalitats de l’Estat, i de l’altra, és una circumscripció electoral determinant', null, '48e17c1c5e374811c82e825ed642a8264c9ef912d2f106414ceb1a9c4b4d2e51', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '48e17c1c5e374811c82e825ed642a8264c9ef912d2f106414ceb1a9c4b4d2e51')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Que és alhora divisió administrativa per a les finalitats de l’Estat i circumscripció electoral per a les Corts Generals.', true), ('B', 'Que té dos òrgans de govern: el ple i la presidència.', false), ('C', 'Que depèn alhora de l’Estat i de la comunitat autònoma.', false), ('D', 'Que té competències municipals i autonòmiques.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, quins òrgans constitueixen el consell comarcal?', 'El consell comarcal està format pel ple, el president i la comissió especial de comptes; els consellers s’elegeixen de forma indirecta.', 'mossos_b7_organitzacio_territorial', (select id from public.topics where slug = 'mossos-b7-organitzacio-territorial'), 3, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=158'), 'Guia p. 163, §4', 'El govern i l’administració de les comarques correspon al consell comarcal, que està constituït per tres òrgans: el ple, el president i la comissió especial de comptes.', null, 'b7d729a914871914b7a827d070b3f3efee6b58d4094e5fd95f4b14721a375a48', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'b7d729a914871914b7a827d070b3f3efee6b58d4094e5fd95f4b14721a375a48')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'L’alcalde, els regidors i el ple.', false), ('B', 'El ple, el president i la comissió especial de comptes.', true), ('C', 'El president, el gerent i la junta de portaveus.', false), ('D', 'El ple, la comissió de govern i els tinents d’alcalde.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, de quin caràcter és l’elecció dels consellers comarcals?', 'L’elecció és indirecta: cada formació rep consellers en proporció als vots i regidors obtinguts a les eleccions municipals.', 'mossos_b7_organitzacio_territorial', (select id from public.topics where slug = 'mossos-b7-organitzacio-territorial'), 2, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=158'), 'Guia p. 163, §4', 'l’elecció dels quals és de caràcter indirecte', null, '925848f39b5e524d1eb85029a7fb5d4d3caaa8c1957706112671d9aea2eea6cb', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '925848f39b5e524d1eb85029a7fb5d4d3caaa8c1957706112671d9aea2eea6cb')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Directa, per sufragi universal en eleccions comarcals.', false), ('B', 'Per designació del Govern de la Generalitat.', false), ('C', 'Indirecta, a partir dels resultats de les eleccions municipals.', true), ('D', 'Per sorteig entre els regidors de la comarca.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, quin article de l’Estatut d’autonomia defineix la vegueria com l’àmbit territorial específic per a l’exercici del govern intermunicipal de cooperació local?', 'L’article 90 de l’EAC defineix la vegueria; l’article 91 regula el Consell de Vegueria.', 'mossos_b7_organitzacio_territorial', (select id from public.topics where slug = 'mossos-b7-organitzacio-territorial'), 2, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=158'), 'Guia p. 164, §2', 'Segons l’article 90 de l’Estatut d’autonomia, la vegueria és l’àmbit territorial específic per a l’exercici del govern intermunicipal de cooperació local, i té personalitat jurídica pròpia.', null, '92db7fc8415366a4a455efbcd0a05766c5248a3a230f3d129c53aba1aadf3ef5', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '92db7fc8415366a4a455efbcd0a05766c5248a3a230f3d129c53aba1aadf3ef5')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'L’article 2.', false), ('B', 'L’article 68.', false), ('C', 'L’article 152.', false), ('D', 'L’article 90.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
-- Lote mossos-b8-unio-europea-guia-v1 (20 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Guia d''estudi per accedir a la PG-ME, 1a edició, juny de 2026 (convocatòria 46/26), tema B.8, pp. 167-176', 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=167', 'web_oficial'::public.source_kind, 'Generalitat de Catalunya · Mossos d''Esquadra (web oficial de la convocatòria 46/26)', '2026-06-01') on conflict (url) do nothing;
insert into public.topics (slug, title) values ('mossos-b8-unio-europea', 'B.8 La Unió Europea') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug = 'mossos-esquadra' and t.slug = 'mossos-b8-unio-europea' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, com es defineix la Unió Europea?', 'La UE és una organització supraestatal basada en la unitat política, econòmica i monetària, construïda mitjançant tractats internacionals.', 'mossos_b8_unio_europea', (select id from public.topics where slug = 'mossos-b8-unio-europea'), 1, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=167'), 'Guia p. 168, §1', 'La Unió Europea és una organització supraestatal, basada en la unitat política, econòmica i monetària, construïda mitjançant la signatura de diversos tractats internacionals entre els països que en formen part.', null, 'f0ad1288abaec8291d55cb3f9a4559d6663422c7b044a28161c90f33326bfcbb', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'f0ad1288abaec8291d55cb3f9a4559d6663422c7b044a28161c90f33326bfcbb')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Com una confederació d’estats amb una constitució comuna.', false), ('B', 'Com una organització internacional exclusivament comercial.', false), ('C', 'Com un estat federal integrat pels estats membres.', false), ('D', 'Com una organització supraestatal, basada en la unitat política, econòmica i monetària.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, quan va entrar en vigor el Tractat de Lisboa?', 'El Tractat de Lisboa es va signar el 13 de desembre de 2007 i va entrar en vigor l’1 de desembre de 2009.', 'mossos_b8_unio_europea', (select id from public.topics where slug = 'mossos-b8-unio-europea'), 2, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=167'), 'Guia p. 168, §4', 'El Tractat de Lisboa va entrar en vigor l’1 de desembre de 2009, un cop ratificat per tots els estats membres.', null, '8620acb425dc9fecf4947cb8bcfb5fc08b3b42a5644232d7b2cde9b7b468961f', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '8620acb425dc9fecf4947cb8bcfb5fc08b3b42a5644232d7b2cde9b7b468961f')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El 13 de desembre de 2007.', false), ('B', 'L’1 de gener de 2008.', false), ('C', 'L’1 de desembre de 2009.', true), ('D', 'L’1 de novembre de 2014.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, amb quin tractat es va iniciar el 1951 el procés d’integració europea?', 'El procés s’inicia el 1951 amb la CECA (signada a París); la CEE i l’EURATOM es van signar a Roma el 1957.', 'mossos_b8_unio_europea', (select id from public.topics where slug = 'mossos-b8-unio-europea'), 2, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=167'), 'Guia p. 168, §5', 'un procés d’integració política i econòmica que es va iniciar el 1951 amb la signatura del Tractat de la Comunitat Europea del Carbó i l’Acer (CECA)', null, 'f5963ccaa0d4e532de813373b441ec46129702a0410eeb74ffafe29476a0d4e4', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'f5963ccaa0d4e532de813373b441ec46129702a0410eeb74ffafe29476a0d4e4')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Amb el Tractat de la Comunitat Europea del Carbó i l’Acer (CECA).', true), ('B', 'Amb el Tractat de la Comunitat Econòmica Europea (CEE).', false), ('C', 'Amb el Tractat de l’Energia Atòmica (EURATOM).', false), ('D', 'Amb el Tractat de Brussel·les.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, a partir de quina data s’incorpora el dret comunitari a l’ordenament jurídic espanyol?', 'El Tractat d’adhesió, autoritzat per la LO 10/1985, preveu que el dret comunitari s’incorpori a l’ordenament espanyol a partir de l’1 de gener de 1986.', 'mossos_b8_unio_europea', (select id from public.topics where slug = 'mossos-b8-unio-europea'), 2, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=167'), 'Guia p. 168, §6', 'D’acord amb el Tractat, a partir de l’1 de gener de 1986, el dret comunitari originari fins aleshores vigent, així com totes les normes que s’aprovin amb posterioritat, s’incorporen com un tot a l’ordenament jurídic espanyol.', null, '1a7d815fdac338467dd309c06c75afbe6d1bbe47d860b289989e48b6d7891487', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '1a7d815fdac338467dd309c06c75afbe6d1bbe47d860b289989e48b6d7891487')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Des del 25 de març de 1957.', false), ('B', 'Des de l’1 de gener de 1986.', true), ('C', 'Des del 2 d’agost de 1985.', false), ('D', 'Des del 7 de febrer de 1992.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, quin tractat de 1965 va unificar institucions de les tres comunitats com la Comissió i el Consell?', 'El Tractat de Brussel·les, de 8 d’abril de 1965, va unificar la Comissió i el Consell de les tres comunitats.', 'mossos_b8_unio_europea', (select id from public.topics where slug = 'mossos-b8-unio-europea'), 3, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=167'), 'Guia p. 169, §3', 'Els tractats inicials foren seguits més endavant pel Tractat de Brussel·les, de 8 d’abril de 1965, pel qual es van unificar algunes de les institucions de les tres comunitats anteriors', null, 'f75f39fc79817aeaa28dbd5d3847311d681402951bf580fd967b00d82d3128f1', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'f75f39fc79817aeaa28dbd5d3847311d681402951bf580fd967b00d82d3128f1')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El Tractat de Roma.', false), ('B', 'L’Acta Única Europea.', false), ('C', 'El Tractat de Maastricht.', false), ('D', 'El Tractat de Brussel·les.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, quin instrument va crear un mercat interior com a únic espai econòmic, amb plena llibertat de circulació de persones, béns, serveis i capitals?', 'L’Acta Única Europea (17 de febrer de 1986) va crear el mercat interior com a únic espai econòmic.', 'mossos_b8_unio_europea', (select id from public.topics where slug = 'mossos-b8-unio-europea'), 3, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=167'), 'Guia p. 169, §3', 'per l’Acta Única Europea (AUE), signada a Luxemburg el 17 de febrer de 1986, mitjançant la qual es creà un mercat interior com a únic espai econòmic entre els estats membres', null, 'b11b18826fd49e17251c3353e37c10c96f1fb5af67780a7769adeaebb86b83ed', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'b11b18826fd49e17251c3353e37c10c96f1fb5af67780a7769adeaebb86b83ed')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'L’Acta Única Europea, signada a Luxemburg el 1986.', true), ('B', 'El Tractat de Niça.', false), ('C', 'El Tractat d’Amsterdam.', false), ('D', 'El Tractat de Lisboa.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, quin tractat va instituir la política exterior i seguretat comuna (PESC) i la cooperació en justícia i assumptes d’interior (CJAI)?', 'El Tractat de Maastricht (1992) va integrar la cooperació governamental a través de la PESC i la CJAI.', 'mossos_b8_unio_europea', (select id from public.topics where slug = 'mossos-b8-unio-europea'), 2, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=167'), 'Guia p. 169, §5', 'el Tractat de Maastricht va introduir reformes importants als tractats constitutius, i va desenvolupar i integrar la cooperació de tipus governamental entre els estats membres a través de la institució de la política exterior i seguretat comuna (PESC)', null, 'e45b6476ea0549f7e7a8b463d651cb2f83898a0a259496e677a93da200e9aaec', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'e45b6476ea0549f7e7a8b463d651cb2f83898a0a259496e677a93da200e9aaec')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El Tractat de Roma.', false), ('B', 'El Tractat de Niça.', false), ('C', 'El Tractat de Maastricht.', true), ('D', 'El Tractat de Brussel·les.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, quin va ser l’objectiu del Tractat de Niça de 2001?', 'El Tractat de Niça va modificar els tractats per adaptar les institucions a l’ampliació cap als països de l’est.', 'mossos_b8_unio_europea', (select id from public.topics where slug = 'mossos-b8-unio-europea'), 3, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=167'), 'Guia p. 169, §7', 'el Tractat de Niça, de 2001, torna a modificar els tractats fundacionals i de la Unió per poder adaptar les institucions comunitàries en la perspectiva de l’ampliació de la Unió Europea als països de l’est d’Europa.', null, '3650fc07db29ef41450b4b908917aff8de5d41479dc26bb252a232017eb62358', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '3650fc07db29ef41450b4b908917aff8de5d41479dc26bb252a232017eb62358')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Crear la moneda única.', false), ('B', 'Adaptar les institucions comunitàries en la perspectiva de l’ampliació als països de l’est d’Europa.', true), ('C', 'Establir la ciutadania europea.', false), ('D', 'Unificar les assemblees legislatives de les tres comunitats.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, quina durada té la presidència estable del Consell Europeu introduïda pel Tractat de Lisboa?', 'El Tractat de Lisboa crea una presidència estable del Consell Europeu de dos anys i mig, renovable una vegada. La presidència rotativa de sis mesos és la del Consell de la UE.', 'mossos_b8_unio_europea', (select id from public.topics where slug = 'mossos-b8-unio-europea'), 3, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=167'), 'Guia p. 170, §4', 'Presidència estable del Consell Europeu: dos anys i mig de durada amb possibilitat d’una reelecció.', null, 'b40d87c589d4bf75d041a8ccd3a0eb56459314c3bec8dfa785f264374b2475db', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'b40d87c589d4bf75d041a8ccd3a0eb56459314c3bec8dfa785f264374b2475db')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Sis mesos, de manera rotativa.', false), ('B', 'Un any, sense reelecció.', false), ('C', 'Dos anys i mig, amb possibilitat d’una reelecció.', true), ('D', 'Cinc anys, coincidint amb la legislatura europea.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, quin és el sistema de doble majoria per a les votacions per majoria qualificada al Consell de la UE?', 'Des de novembre de 2014, la majoria qualificada exigeix el 55% dels estats membres i el 65% de la població de la UE.', 'mossos_b8_unio_europea', (select id from public.topics where slug = 'mossos-b8-unio-europea'), 3, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=167'), 'Guia p. 170, §4', 'Nou sistema de doble majoria per a les votacions per majoria qualificada al Consell de la UE a partir de novembre de 2014: 55% dels estats membres i 65% de la població UE.', null, '31dbd4d9228e207ec0d03523496c8fb6a9ee526c34a7f3cf445c9b6188a1c4f5', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '31dbd4d9228e207ec0d03523496c8fb6a9ee526c34a7f3cf445c9b6188a1c4f5')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', '50% dels estats membres i 60% de la població.', false), ('B', '65% dels estats membres i 55% de la població.', false), ('C', 'Dues terceres parts dels estats i de la població.', false), ('D', '55% dels estats membres i 65% de la població.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, quina d’aquestes és una competència exclusiva de la Unió Europea?', 'Són exclusives la unió duanera, les normes de competència, la política monetària, la conservació dels recursos biològics marins i la política comercial comuna.', 'mossos_b8_unio_europea', (select id from public.topics where slug = 'mossos-b8-unio-europea'), 3, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=167'), 'Guia p. 171, §1', 'Es clarifiquen les competències de la Unió i es classifiquen en exclusives (unió duanera, normes de competència, política monetària', null, 'dda1ed47e81a37054a8deda586975bafcc92bef1b74d828cf26f7acabe44e1ed', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'dda1ed47e81a37054a8deda586975bafcc92bef1b74d828cf26f7acabe44e1ed')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'La política monetària.', true), ('B', 'La sanitat.', false), ('C', 'El turisme.', false), ('D', 'La protecció civil.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, des de quina data és operativa la Fiscalia Europea?', 'La Fiscalia Europea és operativa des de l’1 de juny de 2021 i investiga delictes contra els interessos financers de la UE; Eurojust existeix des del 2001.', 'mossos_b8_unio_europea', (select id from public.topics where slug = 'mossos-b8-unio-europea'), 2, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=167'), 'Guia p. 171, §3', 'Des de l’1 de juny de 2021, és operativa la Fiscalia Europea, un òrgan independent de la Unió Europea encarregat d’investigar els delictes que atempten contra els interessos financers de la UE', null, '6ed9150b46ec694e758b3eef0474b8af85abb52e18c4702620b0764ac9302688', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '6ed9150b46ec694e758b3eef0474b8af85abb52e18c4702620b0764ac9302688')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Des del 2001.', false), ('B', 'Des de l’1 de juny de 2021.', true), ('C', 'Des de l’1 de desembre de 2009.', false), ('D', 'Des del 31 de gener de 2020.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, quin òrgan de la Unió Europea existeix des de l’any 2001 per millorar la coordinació en la lluita contra la criminalitat organitzada transfronterera?', 'Eurojust, des del 2001, millora l’eficàcia i la coordinació de les autoritats competents dels estats membres contra la criminalitat organitzada transfronterera.', 'mossos_b8_unio_europea', (select id from public.topics where slug = 'mossos-b8-unio-europea'), 2, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=167'), 'Guia p. 171, §3', 'Des de l’any 2001 existeix Eurojust com a òrgan de la Unió Europea encarregat de millorar l’eficàcia de les autoritats competents dels estats membres en la lluita contra la criminalitat organitzada transfronterera', null, '12d3b01266c70d5e7fcb52960edf415c9c4a7b663fe885f64231ce2c922fe277', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '12d3b01266c70d5e7fcb52960edf415c9c4a7b663fe885f64231ce2c922fe277')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Europol.', false), ('B', 'Eurojust.', true), ('C', 'La Fiscalia Europea.', false), ('D', 'La Xarxa Judicial Europea.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, què forma el dret comunitari originari o primari?', 'El dret originari el formen els tractats constitutius; el dret derivat, els actes normatius dels òrgans comunitaris.', 'mossos_b8_unio_europea', (select id from public.topics where slug = 'mossos-b8-unio-europea'), 2, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=167'), 'Guia p. 171, §5', 'Les fonts del dret comunitari europeu es divideixen entre dret originari (o primari), format pels tractats constitutius de la Unió, i dret derivat (o secundari)', null, 'e7d80c5a270132ce2c6435e3c3953bb9427eca5a16f7852f38a54b38b47a5a8a', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'e7d80c5a270132ce2c6435e3c3953bb9427eca5a16f7852f38a54b38b47a5a8a')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Els reglaments i les directives.', false), ('B', 'Les sentències del Tribunal de Justícia.', false), ('C', 'Els tractats constitutius de la Unió.', true), ('D', 'Els actes normatius dictats pels òrgans comunitaris.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, quin acte comunitari té abast general, és obligatori i directament aplicable a cada Estat membre sense necessitat de cap acte de recepció?', 'El reglament és d’abast general, obligatori i directament aplicable; la directiva imposa una obligació de resultat i cal transposar-la.', 'mossos_b8_unio_europea', (select id from public.topics where slug = 'mossos-b8-unio-europea'), 2, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=167'), 'Guia p. 172, §3', 'Reglaments: són actes que tenen abast general, són obligatoris i directament aplicables a cada Estat membre.', null, 'f7e9bc34c43d5a6dd2117c83f991d5538e870cccfc0edfd7da49416cdd6d7c7f', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'f7e9bc34c43d5a6dd2117c83f991d5538e870cccfc0edfd7da49416cdd6d7c7f')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El reglament.', true), ('B', 'La directiva.', false), ('C', 'La recomanació.', false), ('D', 'El dictamen.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, què imposa una directiva als estats destinataris?', 'Les directives vinculen quant al resultat i deixen als estats la forma i els mitjans, dins d’un termini fixat.', 'mossos_b8_unio_europea', (select id from public.topics where slug = 'mossos-b8-unio-europea'), 3, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=167'), 'Guia p. 172, §4', 'Mitjançant les directives s’imposa als estats destinataris una obligació de resultat (aquests han d’assolir un determinat objectiu) i deixen a la seva elecció la manera i els mitjans per complir el que disposa la directiva.', null, '01c0078db83980265968908586b39c72601fd509e47287719b9c32dac2b45e02', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '01c0078db83980265968908586b39c72601fd509e47287719b9c32dac2b45e02')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Un text uniforme que han de publicar sense canvis.', false), ('B', 'Una simple orientació sense caràcter vinculant.', false), ('C', 'Una obligació individual a persones físiques concretes.', false), ('D', 'Una obligació de resultat, deixant a la seva elecció la manera i els mitjans per complir-la.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, quins principis regeixen les relacions entre el dret comunitari i el dret dels estats membres?', 'Les relacions es regeixen per l’autonomia institucional, l’efecte directe i la primacia.', 'mossos_b8_unio_europea', (select id from public.topics where slug = 'mossos-b8-unio-europea'), 3, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=167'), 'Guia p. 173, §3', 'Les relacions entre el dret comunitari i el dret dels estats membres es regeixen per tres principis: l’autonomia institucional, l’efecte directe i la primacia.', null, 'ecd6bd91db60826a7341b7e3c5ec1aec91c80c26ede2944b733434be9561d5cb', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'ecd6bd91db60826a7341b7e3c5ec1aec91c80c26ede2944b733434be9561d5cb')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'L’autonomia institucional, l’efecte directe i la primacia.', true), ('B', 'La jerarquia, la competència i la supletorietat.', false), ('C', 'La subsidiarietat, la proporcionalitat i la solidaritat.', false), ('D', 'La unitat, la uniformitat i la centralització.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, què comporta la primacia del dret comunitari quan una norma comunitària i una d’interna són contradictòries?', 'La primacia obliga a aplicar la norma comunitària; la interna no deixa de formar part de l’ordenament, sinó que no s’aplica en aquell supòsit.', 'mossos_b8_unio_europea', (select id from public.topics where slug = 'mossos-b8-unio-europea'), 3, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=167'), 'Guia p. 173, §6', 's’ha d’aplicar la norma comunitària davant de la interna. Això no implica que la norma interna deixi de formar part de l’ordenament, sinó que no és aplicable en la resolució d’aquell supòsit.', null, 'b9714872ed00e2cbd42fc427ae8880cd6f9dc23f4a7e7f31d1347bbf878723b4', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'b9714872ed00e2cbd42fc427ae8880cd6f9dc23f4a7e7f31d1347bbf878723b4')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Que la norma interna queda derogada automàticament.', false), ('B', 'Que el Tribunal Constitucional ha d’anul·lar la norma interna.', false), ('C', 'Que s’aplica la norma més recent.', false), ('D', 'Que s’aplica la norma comunitària, sense que la interna deixi de formar part de l’ordenament.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, com s’exerceix la Presidència del Consell de la Unió Europea?', 'La Presidència del Consell de la UE és rotativa per sis mesos entre els estats membres.', 'mossos_b8_unio_europea', (select id from public.topics where slug = 'mossos-b8-unio-europea'), 2, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=167'), 'Guia p. 174, §1', 'La Presidència del Consell correspon rotativament, per un període de sis mesos, a cadascun dels estats membres.', null, 'a77c7934e7853cfa2d18be8aa4e19d235fe27746c61be442858d9df7573cd8e6', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'a77c7934e7853cfa2d18be8aa4e19d235fe27746c61be442858d9df7573cd8e6')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'De manera estable, per dos anys i mig.', false), ('B', 'Pel president de la Comissió Europea.', false), ('C', 'Rotativament, per un període de sis mesos, per cadascun dels estats membres.', true), ('D', 'Rotativament, per un període d’un any.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, quin òrgan judicial nacional pot plantejar una qüestió prejudicial al Tribunal de Justícia de la Unió Europea?', 'La qüestió prejudicial la planteja l’òrgan judicial que ha d’aplicar el dret comunitari en un litigi, per demanar-ne la interpretació o la validesa.', 'mossos_b8_unio_europea', (select id from public.topics where slug = 'mossos-b8-unio-europea'), 3, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=167'), 'Guia p. 175, §2', 'De la qüestió prejudicial, quan un òrgan judicial d’un Estat membre que ha d’aplicar el dret comunitari en un litigi sol·licita al Tribunal de Justícia que es pronunciï', 'No s’inclouen preguntes sobre el nombre d’eurodiputats: la guia diu 705 (59 per a Espanya) i les esmenes de setembre de 2026 l’actualitzen a 720.', '3ea02d4317e2a04d3a8d812bc5d058964efa4dc1f5f7bac56226b102bad203d0', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '3ea02d4317e2a04d3a8d812bc5d058964efa4dc1f5f7bac56226b102bad203d0')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Només el Tribunal Constitucional de cada Estat.', false), ('B', 'Un òrgan judicial d’un Estat membre que ha d’aplicar el dret comunitari en un litigi.', true), ('C', 'Només els tribunals suprems dels estats membres.', false), ('D', 'Només la Comissió Europea, en nom dels tribunals nacionals.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
commit;
