-- Temario Mossos, àmbit A (Guia d'estudi 2026, catalán).
-- Todo entra como BORRADOR (status draft). Nada se publica hasta aprobarlo en el panel.
-- Idempotente: se puede ejecutar más de una vez. Requiere haber ejecutado antes 1-, 2-, 3- y 4-.
begin;
-- Lote mossos-a1-historia-1-guia-v1 (20 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Guia d''estudi per accedir a la PG-ME, 1a edició, juny de 2026 (convocatòria 46/26), tema A.1, pp. 11-19', 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=11', 'web_oficial'::public.source_kind, 'Generalitat de Catalunya · Mossos d''Esquadra (web oficial de la convocatòria 46/26)', '2026-06-01') on conflict (url) do nothing;
insert into public.topics (slug, title) values ('mossos-a1-historia-1', 'A.1 Història de Catalunya (part I)') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug = 'mossos-esquadra' and t.slug = 'mossos-a1-historia-1' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, quina és la resta humana més antiga trobada en el territori que avui és Catalunya i el seu entorn?', 'La guia cita l’home de Talteüll (Rosselló, fa uns 450.000 anys) com la resta humana més antiga i destaca també la mandíbula de Banyoles (uns 70.000 anys).', 'mossos_a1_historia_1', (select id from public.topics where slug = 'mossos-a1-historia-1'), 2, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=11'), 'Guia p. 12, §1', 'La resta humana més antiga és l’home de Talteüll, al Rosselló, de fa uns 450.000 anys. I cal destacar la mandíbula de Banyoles, de fa uns 70.000 anys.', null, 'b771e836f6ba96201252961306300217f4aae3b5dc496bc042065666d87ca5ce', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'b771e836f6ba96201252961306300217f4aae3b5dc496bc042065666d87ca5ce')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'L’home de Talteüll, al Rosselló, de fa uns 450.000 anys.', true), ('B', 'La mandíbula de Banyoles, de fa uns 70.000 anys.', false), ('C', 'Les restes de la cova de Serinyà, de fa uns 200.000 anys.', false), ('D', 'L’home d’Empúries, de fa uns 30.000 anys.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, com va definir l’historiador Vicens Vives Catalunya en relació amb la seva antiguitat?', 'Vicens Vives la va definir com a «redós», on es configuren cultures pròpies, i «passadís», per on circulen pobles vinguts de fora.', 'mossos_a1_historia_1', (select id from public.topics where slug = 'mossos-a1-historia-1'), 2, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=11'), 'Guia p. 12, §1', 'L’historiador Vicens Vives va definir Catalunya com a “redós” i “passadís”', null, '2895502cc9d7111f29641959ef4ef7cfbcbff7097f71f15fe05c46073a0e3405', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '2895502cc9d7111f29641959ef4ef7cfbcbff7097f71f15fe05c46073a0e3405')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Com a «frontera» i «marca».', false), ('B', 'Com a «pont» i «mur».', false), ('C', 'Com a «redós» i «passadís».', true), ('D', 'Com a «cruïlla» i «fortalesa».', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, en quin context i en quin any van desembarcar els romans a Empúries?', 'Els romans van desembarcar a Empúries el 218 a. de C., amb Gneu Corneli Escipió, durant les guerres púniques entre Roma i Cartago.', 'mossos_a1_historia_1', (select id from public.topics where slug = 'mossos-a1-historia-1'), 2, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=11'), 'Guia p. 12, §2', 'Fou en el transcurs de les guerres púniques entre Roma i Cartago quan els romans van desembarcar a Catalunya: el 218 a. de C. Gneu Corneli Escipió posava peu a Empúries.', null, '21701ed2dfe53aa9b165b09faac6735164b5f0a26138ce0b35c0f81c9db16c78', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '21701ed2dfe53aa9b165b09faac6735164b5f0a26138ce0b35c0f81c9db16c78')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Durant la conquesta de la Gàl·lia, el 58 a. de C.', false), ('B', 'En el transcurs de les guerres púniques, el 218 a. de C.', true), ('C', 'Després de la fundació de Tarraco, el 120 a. de C.', false), ('D', 'En la lluita contra els visigots, el 218 d. de C.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, quina fou la ciutat més important de la Catalunya romana?', 'Tarraco era la ciutat més important i reproduïa l’estructura urbanística de Roma (fòrum, termes, amfiteatre, circ…).', 'mossos_a1_historia_1', (select id from public.topics where slug = 'mossos-a1-historia-1'), 1, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=11'), 'Guia p. 12, §2', 'La ciutat més important de la Catalunya romana fou Tarraco, on es reproduïa l’estructura urbanística típica de les ciutats romanes', null, '6916c3f806d022ceca023fab38bf418ac76ef64e47266d344d90bc0f92bb81ea', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '6916c3f806d022ceca023fab38bf418ac76ef64e47266d344d90bc0f92bb81ea')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Empúries.', false), ('B', 'Barcino.', false), ('C', 'Ilerda.', false), ('D', 'Tarraco.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, quina capital tenia l’entitat política peninsular que van conformar els visigots entre els segles V i VIII?', 'Els visigots van formar una monarquia peninsular amb capital a Toledo, molt romanitzada i convertida al catolicisme al segle VI.', 'mossos_a1_historia_1', (select id from public.topics where slug = 'mossos-a1-historia-1'), 2, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=11'), 'Guia p. 13, §2', 'Entre els segles v i viii, els visigots van conformar una entitat política peninsular monàrquica, amb Toledo com a capital', null, '93fc5ada34ee95773a2457704d3850117e0800eb28fb823b050eaf14548b2e21', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '93fc5ada34ee95773a2457704d3850117e0800eb28fb823b050eaf14548b2e21')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Barcelona.', false), ('B', 'Còrdova.', false), ('C', 'Toledo.', true), ('D', 'Tarragona.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, entre quins segles se situa el naixement de Catalunya?', 'La guia situa el naixement de Catalunya entre els segles IX i X, amb la Marca Hispànica com a antecedent immediat.', 'mossos_a1_historia_1', (select id from public.topics where slug = 'mossos-a1-historia-1'), 1, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=11'), 'Guia p. 13, §3', 'El naixement de Catalunya se situa entre els segles ix i x.', null, 'f74c0cf739e196129a320123cf72cab53fcc1b0d1f728369b513d0c6269aa440', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'f74c0cf739e196129a320123cf72cab53fcc1b0d1f728369b513d0c6269aa440')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Entre els segles IX i X.', true), ('B', 'Entre els segles VII i VIII.', false), ('C', 'Entre els segles XI i XII.', false), ('D', 'Entre els segles XII i XIII.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, quin va ser l’antecedent polític immediat de la formació de Catalunya?', 'L’antecedent immediat és la Marca Hispànica, creada per Carlemany com a frontera entre el regne franc i els dominis sarraïns.', 'mossos_a1_historia_1', (select id from public.topics where slug = 'mossos-a1-historia-1'), 2, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=11'), 'Guia p. 13, §3', 'L’antecedent polític immediat a la seva formació el trobem en la creació de la Marca Hispànica que va impulsar Carlemany.', null, '4d2649d3805a6f3348c74bdd677c9ad2693409b7c45fba84272ce3d757e13f0c', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '4d2649d3805a6f3348c74bdd677c9ad2693409b7c45fba84272ce3d757e13f0c')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El regne visigot de Toledo.', false), ('B', 'La Marca Hispànica impulsada per Carlemany.', true), ('C', 'La província romana de la Tarraconense.', false), ('D', 'El comtat d’Urgell independent.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, en quin any es va conquerir Barcelona dins l’expansió franca que va emmarcar la Catalunya Vella?', 'El 785 Girona es va lliurar a Carlemany i el 801 es va conquerir Barcelona. El 732 és la batalla de Poitiers i el 778 el fracàs davant Saragossa.', 'mossos_a1_historia_1', (select id from public.topics where slug = 'mossos-a1-historia-1'), 3, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=11'), 'Guia p. 13, §3', 'Amb tot, el lliurament a Carlemany de la ciutat de Girona (785) o la conquesta de Barcelona (801) van emmarcar un territori, que correspon a allò que és conegut com la Catalunya Vella', null, 'a4c203ff428d3ead1d7d51b6471f36cadca05587d10aa4d755de9e25c7790e77', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'a4c203ff428d3ead1d7d51b6471f36cadca05587d10aa4d755de9e25c7790e77')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El 732.', false), ('B', 'El 778.', false), ('C', 'El 785.', false), ('D', 'El 801.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, quin comte va fundar el casal de Barcelona i va repoblar les planes interiors de la Catalunya central?', 'Guifré el Pilós va reunir diversos comtats, va repoblar la Catalunya central i va fundar el casal de Barcelona.', 'mossos_a1_historia_1', (select id from public.topics where slug = 'mossos-a1-historia-1'), 2, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=11'), 'Guia p. 13, §3', 'Guifré el Pilós, fundador del casal de Barcelona, reuní diferents comtats i repoblà les planes interiors de la Catalunya central.', null, '36f1e9848964fbbe45c88a10e8dd3d757aacca7a38997767471327eb0fd12a81', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '36f1e9848964fbbe45c88a10e8dd3d757aacca7a38997767471327eb0fd12a81')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Guifré el Pilós.', true), ('B', 'Borrell II.', false), ('C', 'Ramon Berenguer IV.', false), ('D', 'Jaume I.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, cap a quin any i amb quin comte es va produir la desvinculació final dels comtes catalans respecte a la monarquia franca?', 'La desvinculació final respecte a la monarquia franca es va produir cap al 988 amb el comte Borrell II.', 'mossos_a1_historia_1', (select id from public.topics where slug = 'mossos-a1-historia-1'), 2, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=11'), 'Guia p. 13, §3', 'una desvinculació final dels comtes catalans respecte a la monarquia franca, cosa que es produí cap al 988 amb el comte Borrell II.', null, '0b0fa35734bc7f69f9b85b831acc29272b64545c5b79de8352ec2739c7b4bbe3', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '0b0fa35734bc7f69f9b85b831acc29272b64545c5b79de8352ec2739c7b4bbe3')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Cap al 878, amb Guifré el Pilós.', false), ('B', 'Cap al 988, amb Borrell II.', true), ('C', 'Cap al 1137, amb Ramon Berenguer IV.', false), ('D', 'Cap al 1213, amb Pere el Catòlic.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, què va comportar el matrimoni de Ramon Berenguer IV amb Peronella d’Aragó el 1137?', 'Va ser una unió dinàstica i no una fusió: cada territori conservava institucions, lleis i tradicions i només compartien el monarca («comte rei»).', 'mossos_a1_historia_1', (select id from public.topics where slug = 'mossos-a1-historia-1'), 2, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=11'), 'Guia p. 14, §4', 'El 1137, Ramon Berenguer IV es casa amb Peronella d’Aragó, filla de Ramir el Monjo, amb la qual cosa es forma la Confederació Catalanoaragonesa, una unió dinàstica, més que no pas una fusió entre Aragó i Catalunya, en la qual cada territori conserva les seves institucions, lleis i tradicions i només comparteixen el monarca', null, '9f9f752c66240255593c65ca31b66a306d83c81253666154690a420bc74b34e0', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '9f9f752c66240255593c65ca31b66a306d83c81253666154690a420bc74b34e0')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'La fusió d’Aragó i Catalunya en un sol regne amb unes mateixes lleis.', false), ('B', 'La incorporació de Catalunya a la corona de Castella.', false), ('C', 'La formació de la Confederació Catalanoaragonesa, una unió dinàstica en què cada territori conservava les seves institucions.', true), ('D', 'La renúncia del casal de Barcelona als seus drets sobre Catalunya.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, quina batalla va significar la fi del domini catalanoaragonès sobre les terres d’Occitània?', 'A la batalla de Muret, en el context de la croada contra els càtars, va morir el rei Pere el Catòlic i es va acabar el domini catalanoaragonès a Occitània.', 'mossos_a1_historia_1', (select id from public.topics where slug = 'mossos-a1-historia-1'), 3, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=11'), 'Guia p. 14, §4', 'La batalla de Muret, on va morir el mateix rei Pere el Catòlic, va significar la fi del domini catalanoaragonès sobre aquestes terres.', null, '50be4cf38993cf9f7243f9c1027f59480bb6140a95f1f82693b2c9bcc95a3c1b', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '50be4cf38993cf9f7243f9c1027f59480bb6140a95f1f82693b2c9bcc95a3c1b')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'La batalla de Poitiers.', false), ('B', 'La batalla de les Navas de Tolosa.', false), ('C', 'La batalla de Lepant.', false), ('D', 'La batalla de Muret.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, en quines dues direccions va iniciar Jaume I l’expansió de la corona catalanoaragonesa?', 'Jaume I el Conqueridor va expandir la corona cap a la Mediterrània (Mallorca, Menorca, Eivissa) i cap al sud peninsular (València).', 'mossos_a1_historia_1', (select id from public.topics where slug = 'mossos-a1-historia-1'), 1, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=11'), 'Guia p. 14, §5', 'Jaume I el Conqueridor (1208-1276) fou qui inicià l’expansió de la corona catalanoaragonesa en dues direccions: la Mediterrània i el sud peninsular.', null, '6e918f74dad7fd56da5c08210fee0d960be863ba443dc7c6e639adcef0a2a8ad', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '6e918f74dad7fd56da5c08210fee0d960be863ba443dc7c6e639adcef0a2a8ad')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El nord dels Pirineus i l’Atlàntic.', false), ('B', 'Occitània i Castella.', false), ('C', 'La Mediterrània i el sud peninsular.', true), ('D', 'El nord d’Àfrica i Portugal.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, quins braços o estaments formaven les Corts Catalanes?', 'Les Corts eren l’assemblea dels tres estaments: nobiliari, eclesiàstic i reial (representants de les ciutats).', 'mossos_a1_historia_1', (select id from public.topics where slug = 'mossos-a1-historia-1'), 2, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=11'), 'Guia pp. 14-15, §5', 'les Corts Catalanes, assemblea política formada per representants dels tres estaments: el braç nobiliari, el braç eclesiàstic i el braç reial o representants de les ciutats.', null, '50b6f69f4549a3f7b527fc207ad8133a3864699bcf4a3164955f25bbd7ca5794', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '50b6f69f4549a3f7b527fc207ad8133a3864699bcf4a3164955f25bbd7ca5794')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El braç nobiliari, el braç eclesiàstic i el braç reial o representants de les ciutats.', true), ('B', 'El braç reial, el braç militar i el braç pagès.', false), ('C', 'El braç nobiliari, el braç dels menestrals i el braç dels mercaders.', false), ('D', 'El braç eclesiàstic, el braç dels oïdors i el braç dels diputats.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, com estava composta la Diputació del General o Generalitat nascuda al segle XIV?', 'Era una representació permanent de les Corts amb tres diputats (un per braç) i tres oïdors de comptes; executava les decisions de les Corts i recaptava subsidis i impostos.', 'mossos_a1_historia_1', (select id from public.topics where slug = 'mossos-a1-historia-1'), 2, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=11'), 'Guia p. 15, §5', 'Durant el segle xiv naixeria la Diputació del General o Generalitat, que era una representació de caràcter permanent de les Corts composta per tres diputats, un per cada braç, i tres oïdors de comptes.', null, '957683e9a031cbc89536f2932b7f732cee0166380aad1f4679d56645182498fe', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '957683e9a031cbc89536f2932b7f732cee0166380aad1f4679d56645182498fe')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Per cinc consellers elegits pel Consell de Cent.', false), ('B', 'Per un president nomenat pel rei i dotze diputats.', false), ('C', 'Pels representants dels tres braços reunits en assemblea anual.', false), ('D', 'Per tres diputats, un per cada braç, i tres oïdors de comptes.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, què era el Consell de Cent?', 'El Consell de Cent era l’assemblea de cent prohoms de Barcelona (burgesia comercial, mercaders i menestrals) amb funció consultiva i de control sobre els cinc consellers.', 'mossos_a1_historia_1', (select id from public.topics where slug = 'mossos-a1-historia-1'), 2, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=11'), 'Guia p. 15, §5', 'el Consell de Cent, assemblea de cent prohoms de la ciutat que representaven els estaments de Barcelona: la burgesia comercial, els mercaders i els menestrals. Aquests representants tenien la missió consultiva i de control sobre els cinc consellers que governaven la ciutat.', null, 'a63da3d157ddeaba5ec95a050bfdbcf4ac32672490335059f1f6d0e65785e706', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'a63da3d157ddeaba5ec95a050bfdbcf4ac32672490335059f1f6d0e65785e706')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'L’òrgan de govern de la Generalitat format per cent diputats.', false), ('B', 'L’assemblea de cent prohoms que representaven els estaments de Barcelona i que controlava els cinc consellers que governaven la ciutat.', true), ('C', 'El tribunal suprem de la corona d’Aragó.', false), ('D', 'L’assemblea de cent nobles que assessorava el comte de Barcelona.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, amb quin acord va finalitzar la Guerra dels Remences?', 'La Guerra dels Remences va acabar amb la Sentència de Guadalupe (1486), impulsada per Ferran II, que va regular les relacions socials al camp català.', 'mossos_a1_historia_1', (select id from public.topics where slug = 'mossos-a1-historia-1'), 2, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=11'), 'Guia p. 15, §6', 'La Guerra dels Remences finalitzà amb la Sentència de Guadalupe (1486), auspiciada pel rei Ferran II', null, '50f5cfc3da6c109908296bf9c35ac19460684b31a8e11c1f06d1dc6608c90f98', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '50f5cfc3da6c109908296bf9c35ac19460684b31a8e11c1f06d1dc6608c90f98')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Amb la Sentència de Guadalupe (1486).', true), ('B', 'Amb el Compromís de Casp (1412).', false), ('C', 'Amb la Pau dels Pirineus (1659).', false), ('D', 'Amb el Pacte de Gènova (1705).', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, què va forçar el Compromís de Casp (1412)?', 'La mort de Martí l’Humà sense hereus va obligar al Compromís de Casp, que va elegir rei Ferran d’Antequera, de família castellana.', 'mossos_a1_historia_1', (select id from public.topics where slug = 'mossos-a1-historia-1'), 2, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=11'), 'Guia p. 15, §6', 'La mort de Martí l’Humà sense descendència, l’últim rei de la casa de Barcelona, forçà el Compromís de Casp (1412), en què s’elegí Ferran d’Antequera, de família castellana, com a rei de la corona d’Aragó.', null, 'e0144cff5044aabe8504106a493af5fa21670e02278970cec523d35046845f42', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'e0144cff5044aabe8504106a493af5fa21670e02278970cec523d35046845f42')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'La derrota de Pere el Catòlic a Muret.', false), ('B', 'El casament de Ferran II amb Isabel de Castella.', false), ('C', 'La mort sense descendència de Martí l’Humà, l’últim rei de la casa de Barcelona.', true), ('D', 'La revolta dels remences.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, quins territoris va cedir la monarquia hispànica a França amb la Pau dels Pirineus (1659)?', 'Amb la Pau dels Pirineus, Catalunya va continuar dins la monarquia hispànica i França es va quedar el Rosselló, la Cerdanya, el Vallespir i el Conflent.', 'mossos_a1_historia_1', (select id from public.topics where slug = 'mossos-a1-historia-1'), 2, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=11'), 'Guia p. 16, §7', 'Finalment, amb la Pau dels Pirineus (1659), Catalunya segueix pertanyent a la monarquia hispànica i França es queda amb els comtats del Rosselló, la Cerdanya, el Vallespir i el Conflent.', null, 'f7aa09888de2bcb267032b4be474e609becd44abecc2a99428d0e3e2878f4457', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'f7aa09888de2bcb267032b4be474e609becd44abecc2a99428d0e3e2878f4457')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Els comtats d’Urgell, Pallars i Ribagorça.', false), ('B', 'Els comtats del Rosselló, la Cerdanya, el Vallespir i el Conflent.', true), ('C', 'Sardenya i Sicília.', false), ('D', 'La Vall d’Aran i Andorra.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, què va establir el Decret de Nova Planta de 1716?', 'Després de la caiguda de Barcelona (11/09/1714), Felip V va abolir les institucions catalanes i el Decret de Nova Planta va imposar centralització, castellanització i absolutisme.', 'mossos_a1_historia_1', (select id from public.topics where slug = 'mossos-a1-historia-1'), 2, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=11'), 'Guia p. 17, §8', 'Abolí les institucions catalanes i amb el Decret de Nova Planta, de 1716, s’establiren la centralització, la castellanització i l’absolutisme monàrquic.', null, '9aaa616565dc0ba7827749b3f456a4c506229baa8da8c029bff048cc5e7ae918', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '9aaa616565dc0ba7827749b3f456a4c506229baa8da8c029bff048cc5e7ae918')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'La recuperació de les constitucions catalanes a canvi de suport militar.', false), ('B', 'La creació de la Diputació del General.', false), ('C', 'La lliure comerç de Catalunya amb Amèrica.', false), ('D', 'La centralització, la castellanització i l’absolutisme monàrquic.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
-- Lote mossos-a2-historia-2-guia-v1 (20 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Guia d''estudi per accedir a la PG-ME, 1a edició, juny de 2026 (convocatòria 46/26), tema A.2, pp. 20-31', 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=20', 'web_oficial'::public.source_kind, 'Generalitat de Catalunya · Mossos d''Esquadra (web oficial de la convocatòria 46/26)', '2026-06-01') on conflict (url) do nothing;
insert into public.topics (slug, title) values ('mossos-a2-historia-2', 'A.2 Història de Catalunya (part II)') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug = 'mossos-esquadra' and t.slug = 'mossos-a2-historia-2' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, quin català va tenir un paper important en la redacció de la Constitució de Cadis de 1812?', 'La Constitució de 1812, primer text legal de caire liberal, va comptar amb un paper destacat del català Antoni de Capmany.', 'mossos_a2_historia_2', (select id from public.topics where slug = 'mossos-a2-historia-2'), 2, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=20'), 'Guia p. 21, §1', 'La primera constitució espanyola, de 1812 –si exceptuem la de Baiona, feta pels francesos– significà el primer text legal de caire liberal, i en la seva redacció hi tingué un paper important el català Antoni de Capmany.', null, '06c614c54cf72601c5b6080cc1f0745d2bf5d90f7f5d51b93aaca964bd61fbdd', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '06c614c54cf72601c5b6080cc1f0745d2bf5d90f7f5d51b93aaca964bd61fbdd')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Valentí Almirall.', false), ('B', 'Francesc Pi i Margall.', false), ('C', 'Rafael Casanova.', false), ('D', 'Antoni de Capmany.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, quin va ser l’origen del carlisme?', 'A la mort de Ferran VII, derogada la Llei sàlica, la regent Maria Cristina governava en nom d’Isabel, mentre Carles reclamava els drets successoris: aquest és l’origen del carlisme.', 'mossos_a2_historia_2', (select id from public.topics where slug = 'mossos-a2-historia-2'), 2, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=20'), 'Guia p. 21, §1', 'A la mort del rei Ferran VII es plantejà un conflicte successori entre la regent Maria Cristina, que regnava en nom de la seva filla Isabel un cop havia estat derogada la Llei sàlica, que prohibia a les dones regnar, i Carles, el germà del rei, que reclamava els drets successoris. Això seria l’origen del carlisme', null, 'da12b32c78824279d6fd03f6e6ccaf67df65d4dbb6f36ad462edcb8371f50cc6', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'da12b32c78824279d6fd03f6e6ccaf67df65d4dbb6f36ad462edcb8371f50cc6')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El conflicte successori entre la regent Maria Cristina, en nom de la seva filla Isabel, i Carles, germà de Ferran VII.', true), ('B', 'La revolta dels segadors contra el comte duc d’Olivares.', false), ('C', 'El pronunciament del coronel Riego el 1820.', false), ('D', 'La desamortització de les terres de l’Església.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, quina finalitat tenia la desamortització?', 'La desamortització (venda de terres de l’Església) volia eixugar el dèficit i pagar l’exèrcit contra els carlistes; no va aconseguir que la pagesia accedís a la terra.', 'mossos_a2_historia_2', (select id from public.topics where slug = 'mossos-a2-historia-2'), 2, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=20'), 'Guia p. 22, §1', 'La desamortització (venda de terres de l’Església), que tenia com a finalitat eixugar el dèficit de la hisenda i pagar l’exèrcit que combatia els carlistes, fou una de les mesures més importants de la revolució liberal.', null, '09f601848b1c5db2f1af13be14a1b2f89aabd310fb8e0f95075a682f1523e948', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '09f601848b1c5db2f1af13be14a1b2f89aabd310fb8e0f95075a682f1523e948')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Repartir la terra entre els pagesos que la treballaven.', false), ('B', 'Eixugar el dèficit de la hisenda i pagar l’exèrcit que combatia els carlistes.', true), ('C', 'Retornar a l’Església les terres confiscades durant el Trienni Liberal.', false), ('D', 'Finançar la construcció de la xarxa ferroviària.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, quin polític català va arribar a la presidència de la Primera República (1873-1874)?', 'A Catalunya hi havia molts republicans federals i Francesc Pi i Margall va arribar a presidir la Primera República.', 'mossos_a2_historia_2', (select id from public.topics where slug = 'mossos-a2-historia-2'), 2, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=20'), 'Guia p. 22, §1', 'A Catalunya hi havia un nombre important de republicans federals i, fins i tot, un destacat ideòleg i polític republicà, Francesc Pi i Margall, va arribar a la presidència de la República.', null, '08f9fc47b855c09b221df88629794086e9a847523fed9a45d9985cd253fa2107', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '08f9fc47b855c09b221df88629794086e9a847523fed9a45d9985cd253fa2107')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Valentí Almirall.', false), ('B', 'Joan Prim.', false), ('C', 'Francesc Pi i Margall.', true), ('D', 'Francesc Macià.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, què va ser la fàbrica Bonaplata, fundada a Barcelona el 1833?', 'Bonaplata va ser la primera fàbrica de vapor i la van cremar artesans que hi veien la seva ruïna, un episodi de ludisme.', 'mossos_a2_historia_2', (select id from public.topics where slug = 'mossos-a2-historia-2'), 2, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=20'), 'Guia p. 22, §2', 'el 1833 es fundà a Barcelona la fàbrica Bonaplata, la primera accionada per vapor i que fou cremada per sectors artesanals que veien en aquesta nova instal·lació la seva ruïna (ludisme).', null, 'ff8590b1adba536d0d592d9cbf585c67fdbf48f2ac539b3b1e5e70382f2c4c69', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'ff8590b1adba536d0d592d9cbf585c67fdbf48f2ac539b3b1e5e70382f2c4c69')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'La primera fàbrica accionada per vapor, que va ser cremada per sectors artesanals (ludisme).', true), ('B', 'La primera fàbrica d’indianes de Catalunya.', false), ('C', 'La primera empresa de construcció mecànica, antecessora de La Maquinista.', false), ('D', 'La primera colònia industrial del riu Llobregat.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, quina va ser la primera línia de ferrocarril construïda a Espanya?', 'La guia indica que la línia Barcelona-Mataró de 1848 va ser la primera construïda a Espanya.', 'mossos_a2_historia_2', (select id from public.topics where slug = 'mossos-a2-historia-2'), 1, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=20'), 'Guia p. 22, §2', 'La línia Barcelona-Mataró de 1848 va ser la primera construïda a Espanya.', null, 'e93d4443c32b487b034a028ae1edec9a31a6f62db9c35bacdeb8f7e7671a671d', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'e93d4443c32b487b034a028ae1edec9a31a6f62db9c35bacdeb8f7e7671a671d')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'La línia Barcelona-Sabadell, el 1855.', false), ('B', 'La línia Madrid-Aranjuez, el 1851.', false), ('C', 'La línia Barcelona-Mataró, el 1848.', true), ('D', 'La línia Barcelona-Terrassa, el 1856.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, qui va idear el projecte de l’Eixample de Barcelona?', 'L’enderroc de les muralles va permetre el projecte de l’Eixample, ideat per Ildefons Cerdà.', 'mossos_a2_historia_2', (select id from public.topics where slug = 'mossos-a2-historia-2'), 1, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=20'), 'Guia p. 22, §2', 'especialment Barcelona, que conegué l’enderroc de les muralles i fenòmens urbanístics com el projecte de l’Eixample, ideat per Ildefons Cerdà.', null, '989803000110f692f20f15f886506069b6a6424e360e08c4335b2bfb27ee4859', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '989803000110f692f20f15f886506069b6a6424e360e08c4335b2bfb27ee4859')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Antoni Gaudí.', false), ('B', 'Josep Puig i Cadafalch.', false), ('C', 'Lluís Domènech i Montaner.', false), ('D', 'Ildefons Cerdà.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, quina va ser la primera societat obrera, fundada el 1840?', 'El 1840 es va fundar l’Associació de Protecció Mútua de Teixidors de Cotó, la primera societat obrera. Solidaritat Obrera és de 1907 i la Unió de Rabassaires de 1922.', 'mossos_a2_historia_2', (select id from public.topics where slug = 'mossos-a2-historia-2'), 3, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=20'), 'Guia p. 23, §2', 'El 1840 es fundava l’Associació de Protecció Mútua de Teixidors de Cotó, la primera societat obrera.', null, '72f028c0b90a1f9addfe6cc5757c8df336cfd8cb8cb04914e29329f8d18ce49c', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '72f028c0b90a1f9addfe6cc5757c8df336cfd8cb8cb04914e29329f8d18ce49c')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Les Tres Classes de Vapor.', false), ('B', 'L’Associació de Protecció Mútua de Teixidors de Cotó.', true), ('C', 'Solidaritat Obrera.', false), ('D', 'La Unió de Rabassaires.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, quines tesis es van imposar al Primer Congrés Obrer Espanyol, celebrat a Barcelona el 1870?', 'Al congrés de 1870 es van imposar les tesis bakuninistes, cosa que explica la força i persistència de l’anarquisme a Catalunya.', 'mossos_a2_historia_2', (select id from public.topics where slug = 'mossos-a2-historia-2'), 3, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=20'), 'Guia p. 23, §2', 'El 1870 es produí el Primer Congrés Obrer Espanyol a Barcelona, adherit a la Internacional, en el qual s’imposaren les tesis bakuninistes', null, 'e9f2a72715970fdab28ac94b997f5ed8b5246d45042bfc3e4cf4927e93f35267', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'e9f2a72715970fdab28ac94b997f5ed8b5246d45042bfc3e4cf4927e93f35267')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Les tesis marxistes.', false), ('B', 'Les tesis del sindicalisme catòlic.', false), ('C', 'Les tesis bakuninistes.', true), ('D', 'Les tesis cooperativistes.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, en què es basava el sistema polític de la Restauració borbònica?', 'La Restauració es basava en l’alternança del partit conservador (Cánovas) i el liberal (Sagasta), amb eleccions controlades pels governadors civils mitjançant el caciquisme.', 'mossos_a2_historia_2', (select id from public.topics where slug = 'mossos-a2-historia-2'), 2, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=20'), 'Guia p. 23, §3', 'El sistema polític es basaria en l’alternança de dos partits polítics dinàstics, el conservador i el liberal de Sagasta', null, '2f6d96075c73dc17a7157f8c2f33aec2d97cd4266bdb162c5a48217f748ba6b1', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '2f6d96075c73dc17a7157f8c2f33aec2d97cd4266bdb162c5a48217f748ba6b1')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'En l’alternança de dos partits dinàstics, el conservador i el liberal, amb un sistema electoral controlat pel caciquisme.', true), ('B', 'En un sistema de partit únic dirigit per Cánovas del Castillo.', false), ('C', 'En el sufragi universal i la representació proporcional de tots els partits.', false), ('D', 'En el govern de les juntes revolucionàries locals.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, què es reclamava en el Memorial de Greuges de 1885?', 'El Memorial de Greuges (1885) reclamava la defensa del dret civil català i mesures proteccionistes, i va ajudar a fer quallar la Unió Catalanista.', 'mossos_a2_historia_2', (select id from public.topics where slug = 'mossos-a2-historia-2'), 2, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=20'), 'Guia p. 23, §3', 'Agitació que es va plasmar en accions com el Memorial de Greuges de 1885, en què es reclamava la defensa del dret civil català i mesures proteccionistes.', null, '45325b210e9dc276c60ee6fa5b23f4ae60f5f2e8f82e47705b90245d9cd3ab73', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '45325b210e9dc276c60ee6fa5b23f4ae60f5f2e8f82e47705b90245d9cd3ab73')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'L’autonomia política plena de Catalunya.', false), ('B', 'La defensa del dret civil català i mesures proteccionistes.', true), ('C', 'La independència de Cuba i Puerto Rico.', false), ('D', 'El sufragi universal masculí.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, què va significar el triomf de la Lliga Regionalista a Barcelona amb la «candidatura dels quatre presidents» el 1901?', 'Va ser el primer triomf electoral del catalanisme polític i un cop als partits dinàstics i al caciquisme a Barcelona.', 'mossos_a2_historia_2', (select id from public.topics where slug = 'mossos-a2-historia-2'), 2, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=20'), 'Guia p. 24, §4', 'Això significava dues coses: el primer triomf del catalanisme polític en unes eleccions i un revés als partits dinàstics i al caciquisme a la Ciutat Comtal.', null, '62dc8f12deeaba5b73cb9717b065d00b8b00f36a94573d3926bc30e5a861c264', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '62dc8f12deeaba5b73cb9717b065d00b8b00f36a94573d3926bc30e5a861c264')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'La desaparició definitiva dels partits republicans.', false), ('B', 'La victòria del lerrouxisme a la Ciutat Comtal.', false), ('C', 'La constitució de la Mancomunitat de Catalunya.', false), ('D', 'El primer triomf del catalanisme polític en unes eleccions i un revés als partits dinàstics i al caciquisme.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, quants dels 44 diputats electes a Catalunya va obtenir Solidaritat Catalana a les eleccions a Corts de 1907?', 'Solidaritat Catalana va obtenir 41 dels 44 diputats, un èxit que va escombrar el caciquisme tradicional i els partits dinàstics.', 'mossos_a2_historia_2', (select id from public.topics where slug = 'mossos-a2-historia-2'), 3, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=20'), 'Guia p. 24, §4', 'Es presentaren a les eleccions a corts de 1907 i obtingueren un èxit clamorós: de 44 diputats electes, 41 ho foren de Solidaritat.', null, '1d4f4ad687cb3dbd2121e17d0a01cc8b3190a79017689047c5f1f177362d51a1', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '1d4f4ad687cb3dbd2121e17d0a01cc8b3190a79017689047c5f1f177362d51a1')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', '22.', false), ('B', '33.', false), ('C', '41.', true), ('D', '38.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, què va desencadenar la Setmana Tràgica de 1909?', 'La Setmana Tràgica va ser una insurrecció popular, a l’última setmana de juliol de 1909, contra l’enviament de reservistes al Marroc.', 'mossos_a2_historia_2', (select id from public.topics where slug = 'mossos-a2-historia-2'), 2, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=20'), 'Guia p. 24, §4', 'La Setmana Tràgica fou un moviment insurreccional popular que va tenir lloc a Barcelona i altres ciutats catalanes l’última setmana de juliol de 1909 en contra de la crida de reservistes per anar a lluitar al Marroc contra les cabiles rifenyes.', null, '28cffccb5b27aa5254ef2e6609d3d857733466d4d9e7a75e4206e4e43de704fa', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '28cffccb5b27aa5254ef2e6609d3d857733466d4d9e7a75e4206e4e43de704fa')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'La crida de reservistes per anar a lluitar al Marroc contra les cabiles rifenyes.', true), ('B', 'L’assalt de militars a la redacció del Cu-Cut!.', false), ('C', 'La dissolució de la Mancomunitat de Catalunya.', false), ('D', 'La vaga de la Canadenca.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, què era la Mancomunitat de Catalunya, constituïda el 1914?', 'La Mancomunitat coordinava les diputacions provincials. La van dirigir Prat de la Riba (fins al 1917) i Puig i Cadafalch (1917-1923).', 'mossos_a2_historia_2', (select id from public.topics where slug = 'mossos-a2-historia-2'), 2, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=20'), 'Guia p. 25, §4', 'Només es va aconseguir la Mancomunitat de Catalunya, un ens que coordinava les diputacions provincials catalanes. Constituïda el 1914, fou dirigida per Enric Prat de la Riba, fins a la seva mort el 1917, i per Puig i Cadafalch, del 1917 al 1923.', null, 'fa95852b7dd0482ee04983a35f4d9cd05fe82cffbd9231ec2c9305aee736548c', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'fa95852b7dd0482ee04983a35f4d9cd05fe82cffbd9231ec2c9305aee736548c')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Una institució d’autogovern amb parlament propi.', false), ('B', 'Un ens que coordinava les diputacions provincials catalanes.', true), ('C', 'El govern provisional de la Generalitat.', false), ('D', 'Una associació d’ajuntaments catalanistes sense reconeixement legal.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, què va passar el 14 d’abril de 1931 a Catalunya?', 'El 14 d’abril de 1931 Macià va proclamar la República Catalana, convertida tres dies més tard en Generalitat. Els fets del 6 d’octubre (Companys) són de 1934.', 'mossos_a2_historia_2', (select id from public.topics where slug = 'mossos-a2-historia-2'), 2, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=20'), 'Guia p. 25, §5', 'El 14 d’abril Francesc Macià proclamava la República Catalana que, tres dies més tard, es convertiria en Generalitat de Catalunya.', null, '8141119b15b79e865d7d42f6e9917291064a4c4ce5532ba75257838d0c1cb495', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '8141119b15b79e865d7d42f6e9917291064a4c4ce5532ba75257838d0c1cb495')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Lluís Companys va proclamar l’Estat Català dins de la República Espanyola.', false), ('B', 'Es va aprovar l’Estatut de Núria.', false), ('C', 'Es va constituir el primer Parlament de Catalunya.', false), ('D', 'Francesc Macià va proclamar la República Catalana, que tres dies després es convertiria en Generalitat de Catalunya.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, quin va ser el destí de la Llei de contractes de conreu, primera llei promulgada pel Parlament de Catalunya?', 'La primera llei del Parlament, la Llei de contractes de conreu, va ser invalidada pel Tribunal de Garanties Constitucionals.', 'mossos_a2_historia_2', (select id from public.topics where slug = 'mossos-a2-historia-2'), 3, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=20'), 'Guia p. 25, §5', 'Un parlament que va veure com la primera llei que promulgava, la Llei de contractes de conreu, era invalidada pel Tribunal de Garanties Constitucionals.', null, '661367f81e6d2bb8381d1ec7215cbd80225681f6eddf0a5f4baafe6baa887d6e', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '661367f81e6d2bb8381d1ec7215cbd80225681f6eddf0a5f4baafe6baa887d6e')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Va ser derogada pel mateix Parlament el 1934.', false), ('B', 'Va ser aprovada també per les Corts Espanyoles.', false), ('C', 'No va arribar a entrar en vigor per la Guerra Civil.', false), ('D', 'Va ser invalidada pel Tribunal de Garanties Constitucionals.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, en quina data va caure Barcelona durant l’ofensiva final franquista sobre Catalunya?', 'Barcelona va caure el 26 de gener de 1939 i el 9 de febrer les tropes franquistes arribaven a la frontera francesa. El 15/10/1940 és la data de l’afusellament de Companys.', 'mossos_a2_historia_2', (select id from public.topics where slug = 'mossos-a2-historia-2'), 2, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=20'), 'Guia p. 26, §5', 'el 26 de gener de 1939 queia Barcelona, i el 9 de febrer arribava a la frontera francesa.', null, 'ac9de63cf9d28930470393dec16c1744a01ab6ff38121d0ee24c0c2416215709', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'ac9de63cf9d28930470393dec16c1744a01ab6ff38121d0ee24c0c2416215709')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El 15 d’octubre de 1940.', false), ('B', 'El 17 de juliol de 1936.', false), ('C', 'El 26 de gener de 1939.', true), ('D', 'El 9 de febrer de 1939.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, en quina data va referendar el poble de Catalunya l’Estatut de Sau?', 'L’Estatut de Sau es va referendar el 25 d’octubre de 1979. El 23/10/1977 va tornar Tarradellas i el 20/03/1980 es va escollir Jordi Pujol.', 'mossos_a2_historia_2', (select id from public.topics where slug = 'mossos-a2-historia-2'), 2, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=20'), 'Guia p. 28, §7', 'entrà en vigor un cop referendat pel poble de Catalunya el dia 25 d’octubre de 1979.', null, 'd1799ddc8f2005c7d943d0643a57fd3a634ccd3fa3db2cb1b907f9646702ab2a', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'd1799ddc8f2005c7d943d0643a57fd3a634ccd3fa3db2cb1b907f9646702ab2a')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El 23 d’octubre de 1977.', false), ('B', 'El 25 d’octubre de 1979.', true), ('C', 'El 15 de juny de 1977.', false), ('D', 'El 20 de març de 1980.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, quin número de president de la Generalitat era Jordi Pujol, comptant des de la fundació de la institució amb Berenguer de Cruïlles el 1359?', 'Jordi Pujol, escollit el 20 de març de 1980, va ser el 126è president des de Berenguer de Cruïlles (1359).', 'mossos_a2_historia_2', (select id from public.topics where slug = 'mossos-a2-historia-2'), 2, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=20'), 'Guia p. 28, §7', 'Seria Jordi Pujol, el 126è president des de la fundació de la Generalitat amb Berenguer de Cruïlles l’any 1359, que governaria fins al 2003.', null, '05ffd8056ebdb4d0fcee8bbeb9b4fb52cadcfc5f74feb73456bc48b98000d573', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '05ffd8056ebdb4d0fcee8bbeb9b4fb52cadcfc5f74feb73456bc48b98000d573')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El 126è.', true), ('B', 'El 98è.', false), ('C', 'El 114è.', false), ('D', 'El 129è.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
-- Lote mossos-a3-historia-policia-guia-v1 (20 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Guia d''estudi per accedir a la PG-ME, 1a edició, juny de 2026 (convocatòria 46/26), tema A.3, pp. 32-38', 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=32', 'web_oficial'::public.source_kind, 'Generalitat de Catalunya · Mossos d''Esquadra (web oficial de la convocatòria 46/26)', '2026-06-01') on conflict (url) do nothing;
insert into public.topics (slug, title) values ('mossos-a3-historia-policia', 'A.3 Història de la policia a Catalunya') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug = 'mossos-esquadra' and t.slug = 'mossos-a3-historia-policia' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, com s’exercia el manteniment de l’ordre a Catalunya durant l’època feudal?', 'A Catalunya no va existir mai un cos permanent de policia: l’ordre es mantenia més per la repressió que per la prevenció, amb la Pau i Treva i la col·laboració de la població (sometent i sagramental).', 'mossos_a3_historia_policia', (select id from public.topics where slug = 'mossos-a3-historia-policia'), 2, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=32'), 'Guia p. 33, §1', 'A Catalunya no va existir mai un cos permanent de policia i el manteniment de l’ordre s’exercia a través de la repressió més que de la prevenció.', null, '806fca4f25ef190caa4b6027ee9db3265017db569d1707b1811a3757f619392d', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '806fca4f25ef190caa4b6027ee9db3265017db569d1707b1811a3757f619392d')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Mitjançant un cos permanent de policia reial present a tot el territori.', false), ('B', 'A través de les guàrdies urbanes de cada ciutat.', false), ('C', 'Mitjançant la Guàrdia Civil i el sometent.', false), ('D', 'A través de la repressió més que de la prevenció, ja que no va existir mai un cos permanent de policia.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, a través de quines institucions col·laborava la població en el manteniment de l’ordre durant l’edat mitjana?', 'La guia destaca la defensa de la Pau i Treva i la col·laboració de la població per mitjà del sometent i del sagramental.', 'mossos_a3_historia_policia', (select id from public.topics where slug = 'mossos-a3-historia-policia'), 2, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=32'), 'Guia p. 33, §1', 'Un fet fonamental fou la defensa de la Pau i Treva i la col·laboració de la població, a través del sometent i del sagramental.', null, 'bff30c8f6c62def516b95c8557371204b3936f40b43642673bd6fc905742d16d', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'bff30c8f6c62def516b95c8557371204b3936f40b43642673bd6fc905742d16d')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Del Consell de Cent i de la Reial Audiència.', false), ('B', 'Del sometent i del sagramental.', true), ('C', 'De la Milícia Nacional i dels serenos.', false), ('D', 'De les esquadres de paisans i de la Guàrdia Municipal.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, per què es van organitzar el 1719 unes esquadres de paisans distribuïdes pels corregiments?', 'El 1719, amb l’exèrcit a la frontera per les tensions amb França, el capità general i la Reial Audiència van organitzar esquadres de paisans per controlar l’interior.', 'mossos_a3_historia_policia', (select id from public.topics where slug = 'mossos-a3-historia-policia'), 2, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=32'), 'Guia p. 33, §2', 'El 1719 les tensions amb França van fer situar l’exèrcit a la frontera, per la qual cosa calia crear una força policial que controlés l’interior del territori. Per fer aquesta tasca, el capità general i la Reial Audiència van organitzar unes esquadres de paisans, distribuïdes pels corregiments.', null, '85be85f254f65aceedd52be9b638d55fc49170b0a1716f29cfc29a7876ab2a91', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '85be85f254f65aceedd52be9b638d55fc49170b0a1716f29cfc29a7876ab2a91')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Per perseguir els bandolers de les zones boscoses.', false), ('B', 'Per vigilar el compliment del Decret de Nova Planta.', false), ('C', 'Perquè les tensions amb França havien portat l’exèrcit a la frontera i calia una força que controlés l’interior.', true), ('D', 'Per custodiar les obres de la Ciutadella de Barcelona.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, quina esquadra es va mantenir el 1721, quan es van desarmar la major part de les esquadres?', 'Quan va desaparèixer la tensió fronterera (1721), la major part de les esquadres es van desfer, però la de Valls es va mantenir sota el comandament únic de Pere Anton Veciana.', 'mossos_a3_historia_policia', (select id from public.topics where slug = 'mossos-a3-historia-policia'), 3, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=32'), 'Guia pp. 33-34, §2', 'De fet, la major part van ser desarmades i van desaparèixer, però la de Valls, amb destacaments a Riudoms i Rodonyà, es va mantenir sota la comandància única de Pere Anton Veciana.', null, 'c5a941c36d7a518a0fc52adf9d4261d3a600d6467d1f4806f894455a4d94a3ec', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'c5a941c36d7a518a0fc52adf9d4261d3a600d6467d1f4806f894455a4d94a3ec')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'La de Valls, amb destacaments a Riudoms i Rodonyà, sota el comandament de Pere Anton Veciana.', true), ('B', 'La de Barcelona, amb destacaments a Mataró i Badalona.', false), ('C', 'La de Girona, sota el comandament del capità general.', false), ('D', 'La de Lleida, amb destacaments a Cervera i Tàrrega.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, què va passar l’any 1723 amb les esquadres?', 'El 1723 es van remodelar i ampliar les esquadres i se’n va nomenar comandant Pere Anton Veciana i Rabasa.', 'mossos_a3_historia_policia', (select id from public.topics where slug = 'mossos-a3-historia-policia'), 2, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=32'), 'Guia p. 34, §2', 'L’any 1723 es van remodelar i ampliar les esquadres i, aquest any, Pere Anton Veciana i Rabasa en fou nomenat el comandant.', null, '6e554f31720f56a32381c62215fb3b64d02dfaeede5ca028ca84fe3ea784fe2a', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '6e554f31720f56a32381c62215fb3b64d02dfaeede5ca028ca84fe3ea784fe2a')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Es van dissoldre definitivament.', false), ('B', 'Es van remodelar i ampliar, i Pere Anton Veciana i Rabasa en va ser nomenat comandant.', true), ('C', 'Es van integrar a la Guàrdia Civil.', false), ('D', 'Van passar a dependre de la Diputació de Barcelona.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons les idees força de la Guia d’estudi, entre quins anys va tenir lloc la institucionalització del cos policial dels Mossos d’Esquadra?', 'La segona idea força situa la institucionalització dels Mossos entre 1719 i 1721; la tradició que la datava el 1690 ja no s’accepta.', 'mossos_a3_historia_policia', (select id from public.topics where slug = 'mossos-a3-historia-policia'), 2, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=32'), 'Guia p. 38, idees força 2', '2. La institucionalització del cos policial dels Mossos d’Esquadra va tenir lloc entre 1719 i 1721.', null, 'f9045d1fca3163545fb590b7dd547fa97f26c727af3397e3532af12398aa8422', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'f9045d1fca3163545fb590b7dd547fa97f26c727af3397e3532af12398aa8422')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Entre 1690 i 1700.', false), ('B', 'Entre 1835 i 1837.', false), ('C', 'Entre 1719 i 1721.', true), ('D', 'Entre 1877 i 1880.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, com eren en primera instància els Mossos d’Esquadra del segle XVIII?', 'Els Mossos naixen com una força reial i borbònica que perseguia austriacistes encara armats en un territori on s’havia prohibit el sometent i portar armes.', 'mossos_a3_historia_policia', (select id from public.topics where slug = 'mossos-a3-historia-policia'), 2, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=32'), 'Guia p. 34, §2', 'Els Mossos representarien, en primera instància, una força policial típicament reial i borbònica, controladora de l’ordre públic en un territori amb algun austriacista derrotat però armat que calia perseguir', null, 'a9d0e19812db552722df08dbc37ca495326aaf10ef56b54d8e3d941cc5a265e7', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'a9d0e19812db552722df08dbc37ca495326aaf10ef56b54d8e3d941cc5a265e7')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Una milícia civil i local de caràcter revolucionari.', false), ('B', 'Una força dependent del Consell de Cent de Barcelona.', false), ('C', 'Un cos format per austriacistes que defensaven les constitucions catalanes.', false), ('D', 'Una força policial típicament reial i borbònica, controladora de l’ordre públic.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, en quin any es va fundar la Guàrdia Civil?', 'La Guàrdia Civil es va fundar el 1844 sobre els principis de militarització, centralització i concepció conservadora de la societat.', 'mossos_a3_historia_policia', (select id from public.topics where slug = 'mossos-a3-historia-policia'), 2, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=32'), 'Guia p. 34, §3', 'En aquests principis rau la fundació, el 1844, de la Guàrdia Civil, que va portar el nou Estat fins als últims racons de la Península i va esdevenir l’eix troncal de la seguretat pública.', null, 'd0af16107470e5ffeb70dfde1652c1b87429403f366c2b6efdfe2ebd8f1b9094', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'd0af16107470e5ffeb70dfde1652c1b87429403f366c2b6efdfe2ebd8f1b9094')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El 1844.', true), ('B', 'El 1812.', false), ('C', 'El 1843.', false), ('D', 'El 1877.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, al voltant de quins tres conceptes va fer girar el liberalisme conservador el sistema de seguretat del segle XIX?', 'El liberalisme conservador va basar la seguretat en la militarització, la centralització i una concepció molt conservadora de la societat; d’aquí va sortir la Guàrdia Civil.', 'mossos_a3_historia_policia', (select id from public.topics where slug = 'mossos-a3-historia-policia'), 3, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=32'), 'Guia p. 34, §3', 'va fer que el sistema de seguretat i control de l’ordre públic girés entorn de tres conceptes: la militarització, la centralització i una concepció profundament conservadora de la societat.', null, '5a72f45ca83c6ca2823a97b8fd2cd94bf04bdf6f9dcb14466c35411582e031a2', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '5a72f45ca83c6ca2823a97b8fd2cd94bf04bdf6f9dcb14466c35411582e031a2')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'La descentralització, la professionalització i la prevenció.', false), ('B', 'La municipalització, la participació ciutadana i la llibertat.', false), ('C', 'La militarització, la centralització i una concepció profundament conservadora de la societat.', true), ('D', 'La jerarquia, la disciplina i la neutralitat política.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, quin canvi va experimentar el comandament dels Mossos a partir de 1835-1837?', 'Des de 1835-1837 la família Veciana va perdre el control del cos, que va passar a oficials de l’exèrcit.', 'mossos_a3_historia_policia', (select id from public.topics where slug = 'mossos-a3-historia-policia'), 2, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=32'), 'Guia p. 34, §3', 'la família Veciana ja no va controlar més el cos i des de 1835-1837 es va posar en mans d’oficials provinents de l’exèrcit.', null, '24a9e921e2be929b7ddf5ef228dac35731ba15409802563ff1adc0e810eb62e5', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '24a9e921e2be929b7ddf5ef228dac35731ba15409802563ff1adc0e810eb62e5')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Va passar a mans de la Diputació de Girona.', false), ('B', 'La família Veciana el va deixar de controlar i es va posar en mans d’oficials provinents de l’exèrcit.', true), ('C', 'El van assumir els alcaldes de barri.', false), ('D', 'El va assumir directament el governador civil de Barcelona.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, quan va ser creada la Guàrdia Municipal de la ciutat de Barcelona?', 'La Guàrdia Municipal de Barcelona es va crear el 26 de novembre de 1843 i esdevindria una de les més importants de Catalunya.', 'mossos_a3_historia_policia', (select id from public.topics where slug = 'mossos-a3-historia-policia'), 1, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=32'), 'Guia pp. 34-35, §3', 'La Guàrdia Municipal de la ciutat de Barcelona, per exemple, va ser creada el 26 de novembre de 1843', null, '1661126bc7ba73f8a9f72d75c3f98864172032e5f72e1e673333be62ce7edb71', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '1661126bc7ba73f8a9f72d75c3f98864172032e5f72e1e673333be62ce7edb71')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El 14 d’agost de 1930.', false), ('B', 'L’11 de setembre de 1714.', false), ('C', 'El 14 d’octubre de 1932.', false), ('D', 'El 26 de novembre de 1843.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, quina institució va restituir els Mossos d’Esquadra el 1877 i en va aprovar el Reglament el 1880?', 'En el context de la Restauració, la Diputació Provincial de Barcelona va restituir els Mossos el 1877 i n’aprovà el Reglament el 1880.', 'mossos_a3_historia_policia', (select id from public.topics where slug = 'mossos-a3-historia-policia'), 3, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=32'), 'Guia p. 35, §3', 'És en aquest context que la Diputació Provincial de Barcelona restituí els Mossos d’Esquadra el 1877 i n’aprovà el Reglament el 1880.', null, 'ab776001125ff9228e5ec7fbcc31cbc73735a52b1da1cb319a9da67cbf66609f', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'ab776001125ff9228e5ec7fbcc31cbc73735a52b1da1cb319a9da67cbf66609f')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'La Diputació Provincial de Barcelona.', true), ('B', 'La Capitania General de Catalunya.', false), ('C', 'La Mancomunitat de Catalunya.', false), ('D', 'El Ministeri de la Governació.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, quins dos cossos de policia dependents de l’administració civil va organitzar la reforma de 1905-1908?', 'La reforma va crear el cos de Vigilancia (civil, investigació i policia judicial) i el de Seguridad (uniformat, organització militar, servei a la via pública).', 'mossos_a3_historia_policia', (select id from public.topics where slug = 'mossos-a3-historia-policia'), 3, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=32'), 'Guia p. 35, §4', 'i que serien dos: el de Vigilancia, absolutament civil i dedicat a funcions d’investigació i de policia judicial, i el de Seguridad, uniformat i amb organització militar, que faria el servei a les vies públiques.', null, '8e11b0b6f6a2d72501afe7707ac19cb8ad04614f42d67a18b550d89743cb2565', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '8e11b0b6f6a2d72501afe7707ac19cb8ad04614f42d67a18b550d89743cb2565')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El de Mossos i el de Guàrdia Civil.', false), ('B', 'El de Vigilancia, civil i dedicat a la investigació, i el de Seguridad, uniformat i de servei a la via pública.', true), ('C', 'El de Guàrdia d’Assalt i el de Carrabiners.', false), ('D', 'El de Policia Local i el de Policia Rural.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, què va establir el Decret del 14 d’agost de 1930?', 'Després de la dictadura de Primo de Rivera, el Decret de 14/08/1930 va dissoldre i reorganitzar els Mossos de Barcelona, vinculant-los exclusivament a la Diputació.', 'mossos_a3_historia_policia', (select id from public.topics where slug = 'mossos-a3-historia-policia'), 3, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=32'), 'Guia p. 36, §4', 'El Decret del 14 d’agost de 1930 dissolia el cos dels Mossos d’Esquadra de Barcelona i el tornava a reorganitzar sota uns nous paràmetres.', null, 'a16bb4e308d7a653bdd76ac4b16f46da23e20ae85e71849dd73fc1a3a6f464d7', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'a16bb4e308d7a653bdd76ac4b16f46da23e20ae85e71849dd73fc1a3a6f464d7')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'L’extensió del cos dels Mossos a tot Catalunya.', false), ('B', 'La integració dels Mossos a l’exèrcit espanyol.', false), ('C', 'La dissolució del cos dels Mossos d’Esquadra de Barcelona i la seva reorganització vinculada exclusivament a la Diputació.', true), ('D', 'La creació del Comissariat d’Ordre Públic.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, què va establir el decret signat pel president Macià el 14 d’octubre de 1932?', 'Amb aquest decret de Macià, el cos dels Mossos es va estendre a tot Catalunya.', 'mossos_a3_historia_policia', (select id from public.topics where slug = 'mossos-a3-historia-policia'), 2, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=32'), 'Guia p. 36, §4', 'El 14 d’octubre de 1932, el president Macià signava un decret mitjançant el qual s’estenia el cos policial dels Mossos a tot Catalunya.', null, '57992bd64e5fec8c6a9f2562a4e1cf6d1f9b413f62a1a1994a4d0c84d76752ac', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '57992bd64e5fec8c6a9f2562a4e1cf6d1f9b413f62a1a1994a4d0c84d76752ac')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'La dissolució de les Esquadres.', false), ('B', 'La creació de l’Escola de Policia de Catalunya.', false), ('C', 'El nomenament de Pérez Farràs com a comandant.', false), ('D', 'L’extensió del cos policial dels Mossos a tot Catalunya.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, en quin any van ser restituïts els Mossos, durant el franquisme, com a guàrdia de la Diputació de Barcelona?', 'Els Mossos van ser suspesos pel franquisme i restituïts el 1952 com a guàrdia de la Diputació de Barcelona, integrats a l’exèrcit en fur, insígnies i dependència.', 'mossos_a3_historia_policia', (select id from public.topics where slug = 'mossos-a3-historia-policia'), 3, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=32'), 'Guia pp. 36-37, §4', 'S’hauria d’esperar fins a l’any 1952 perquè els Mossos, integrats en l’exèrcit espanyol en fur, insígnies i dependència, fossin restituïts com una guàrdia de la Diputació de Barcelona', null, '29c08c80f65d67191d635f8e58f5458a08e1d6dff3806e7e5b59f482197d1aba', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '29c08c80f65d67191d635f8e58f5458a08e1d6dff3806e7e5b59f482197d1aba')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El 1952.', true), ('B', 'El 1939.', false), ('C', 'El 1945.', false), ('D', 'El 1977.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, quin model policial va establir la Constitució espanyola de 1978?', 'La CE de 1978 va crear un model pluralista: policia de l’Administració central, policies de les comunitats autònomes que les prevegin en l’estatut i policies locals.', 'mossos_a3_historia_policia', (select id from public.topics where slug = 'mossos-a3-historia-policia'), 2, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=32'), 'Guia p. 37, §5', 'la Constitució espanyola de 1978 va establir un model pluralista en aquesta matèria, a través de tres nivells: la policia de l’Administració central de l’Estat, les policies de les comunitats autònomes l’estatut de les quals en preveiés la creació i les policies locals dependents del poder municipal.', null, '08dfd1399a9e6ef93a8081b751bc699d942d67197432df3b96ba2043443bb2a6', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '08dfd1399a9e6ef93a8081b751bc699d942d67197432df3b96ba2043443bb2a6')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Un model pluralista amb tres nivells: policia estatal, policies autonòmiques i policies locals.', true), ('B', 'Un model centralitzat amb un únic cos de policia estatal.', false), ('C', 'Un model basat exclusivament en les policies locals.', false), ('D', 'Un model militar sota el comandament de l’exèrcit.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, on i en quin any va inaugurar la seva seu l’Escola de Policia de Catalunya?', 'La llei de 1983 va crear la Policia de la Generalitat i l’Escola de Policia va inaugurar la seu a Mollet del Vallès el 1985; des de 1991 també s’hi formen les policies locals.', 'mossos_a3_historia_policia', (select id from public.topics where slug = 'mossos-a3-historia-policia'), 2, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=32'), 'Guia p. 37, §5', 'es donava vida a la que seria l’Escola de Policia de Catalunya, que inauguraria la seva seu a Mollet del Vallès el 1985.', null, '66b3365dd56c40c8b1e6d416fa9feb1ac01e5cfd536df593de31bba4c8ff2543', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '66b3365dd56c40c8b1e6d416fa9feb1ac01e5cfd536df593de31bba4c8ff2543')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'A Barcelona, el 1983.', false), ('B', 'A Sabadell, el 1991.', false), ('C', 'A Mollet del Vallès, el 1994.', false), ('D', 'A Mollet del Vallès, el 1985.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, per quina comarca es va iniciar el desplegament dels Mossos d’Esquadra el novembre de 1994?', 'El desplegament va començar el novembre de 1994 a Osona, seguit del Ripollès i la Selva.', 'mossos_a3_historia_policia', (select id from public.topics where slug = 'mossos-a3-historia-policia'), 2, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=32'), 'Guia p. 37, §5', 'A partir de novembre de 1994 es va iniciar el desplegament dels Mossos d’Esquadra en el territori català, en substitució de les forces i els cossos de seguretat de l’Estat. El primer emplaçament seria la comarca d’Osona, seguida del Ripollès i la Selva.', null, '48935fbfa13360b801df010323228556340eb845cc2443a237f1331f4307e34b', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '48935fbfa13360b801df010323228556340eb845cc2443a237f1331f4307e34b')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El Ripollès.', false), ('B', 'La Selva.', false), ('C', 'Osona.', true), ('D', 'El Gironès.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, quan es va culminar el procés de desplegament dels Mossos d’Esquadra i amb l’arribada a quins territoris?', 'El desplegament va culminar el novembre de 2008 a les Terres de l’Ebre i el Camp de Tarragona.', 'mossos_a3_historia_policia', (select id from public.topics where slug = 'mossos-a3-historia-policia'), 2, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=32'), 'Guia p. 37, §5', 'El novembre de 2008 va significar la culminació del procés de desplegament, amb l’arribada del cos a les Terres de l’Ebre i el Camp de Tarragona.', null, '2663654f2e5647863cb8e7f3d52f6b6c0377e449ee639b691b197dc032fb6654', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '2663654f2e5647863cb8e7f3d52f6b6c0377e449ee639b691b197dc032fb6654')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El 1998, amb l’arribada a l’Alt Pirineu i Aran.', false), ('B', 'El novembre de 2008, amb l’arribada a les Terres de l’Ebre i el Camp de Tarragona.', true), ('C', 'El 2003, amb l’arribada a l’Àrea Metropolitana de Barcelona.', false), ('D', 'El 2005, amb l’arribada a Lleida.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
-- Lote mossos-a4-sociolinguistic-guia-v1 (20 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Guia d''estudi per accedir a la PG-ME, 1a edició, juny de 2026 (convocatòria 46/26), tema A.4, pp. 39-56', 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=39', 'web_oficial'::public.source_kind, 'Generalitat de Catalunya · Mossos d''Esquadra (web oficial de la convocatòria 46/26)', '2026-06-01') on conflict (url) do nothing;
insert into public.topics (slug, title) values ('mossos-a4-sociolinguistic', 'A.4 Àmbit sociolingüístic') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug = 'mossos-esquadra' and t.slug = 'mossos-a4-sociolinguistic' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, de quin llatí prové el català?', 'El català prové del llatí popular i parlat (soldats i mercaders), no del llatí culte o literari.', 'mossos_a4_sociolinguistic', (select id from public.topics where slug = 'mossos-a4-sociolinguistic'), 1, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=39'), 'Guia p. 40, §1', 'El català és una llengua romànica que prové del llatí popular, parlat, portat al territori pels soldats i mercaders, i no pas del llatí culte o literari.', null, 'ef20e1a829ec2ea5c8064bf7bb0e2f98547c67209ee16488ab548c2b797d31f2', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'ef20e1a829ec2ea5c8064bf7bb0e2f98547c67209ee16488ab548c2b797d31f2')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Del llatí culte o literari dels textos clàssics.', false), ('B', 'Del llatí popular, parlat, portat al territori pels soldats i mercaders.', true), ('C', 'Del llatí eclesiàstic de la litúrgia.', false), ('D', 'Del llatí jurídic de l’administració romana.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, quina llengua romànica es va extingir a finals del segle XIX?', 'El dàlmata, parlat a les costes de l’est de l’Adriàtic, es va extingir a finals del segle XIX. El francoprovençal es considera llengua embrionària i el retoromànic encara es parla.', 'mossos_a4_sociolinguistic', (select id from public.topics where slug = 'mossos-a4-sociolinguistic'), 2, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=39'), 'Guia p. 40, §1', 'A finals del segle xix es va extingir una llengua romànica, el dàlmata, parlada a les costes de l’est de la mar Adriàtica.', null, '3bca1ab00a90780aa5f0cc505c22c5dcb44621eac9c1fc958112a5ff2383bcb3', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '3bca1ab00a90780aa5f0cc505c22c5dcb44621eac9c1fc958112a5ff2383bcb3')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El dàlmata.', true), ('B', 'El mossàrab.', false), ('C', 'El francoprovençal.', false), ('D', 'El retoromànic.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, què és el superstrat en la formació de la llengua catalana?', 'El substrat són les llengües prèvies a Roma (cèltic, iberobasc…); el superstrat, les aportacions posteriors, sobretot lèxiques, del germànic i l’àrab.', 'mossos_a4_sociolinguistic', (select id from public.topics where slug = 'mossos-a4-sociolinguistic'), 3, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=39'), 'Guia p. 40, §1', 'c) El superstrat. Les aportacions, especialment lèxiques, posteriors als romans de les llengües germàniques', null, '2a576600650620f613c7c656ca3e361d1f288a55cccfbd719ba83917fb297c6d', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '2a576600650620f613c7c656ca3e361d1f288a55cccfbd719ba83917fb297c6d')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Les llengües parlades al territori abans de la conquesta romana.', false), ('B', 'El grau d’intensitat de la romanització de cada zona.', false), ('C', 'La vida política posterior a la caiguda de l’Imperi Romà d’Occident.', false), ('D', 'Les aportacions, especialment lèxiques, posteriors als romans, com les de les llengües germàniques i de l’àrab.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, què és la diglòssia?', 'En la diglòssia, la llengua A (alta) cobreix administració, ensenyament, literatura i usos públics i la llengua B (baixa) queda reduïda als àmbits privats.', 'mossos_a4_sociolinguistic', (select id from public.topics where slug = 'mossos-a4-sociolinguistic'), 2, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=39'), 'Guia pp. 40-41, §1.1', 'hi ha una situació de diglòssia; és a dir, la convivència de dues llengües en què una, la llengua A (alta, amb més prestigi, en aquest cas el llatí), expressa', null, '90dbe2f3c5555009a30154e58079c9f3c2b33a2f9120df6950607f8899850c1c', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '90dbe2f3c5555009a30154e58079c9f3c2b33a2f9120df6950607f8899850c1c')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El coneixement de dues llengües per part d’un mateix parlant.', false), ('B', 'La coexistència de dos dialectes d’una mateixa llengua en un territori.', false), ('C', 'La convivència de dues llengües en què una, amb més prestigi, s’usa en els àmbits de poder i l’altra només en els àmbits privats.', true), ('D', 'La traducció sistemàtica dels documents oficials a dues llengües.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, què va manar oficialment l’Església al Concili de Tours (813)?', 'Com que la gent era analfabeta i no entenia el llatí culte, al Concili de Tours (813) l’Església va manar predicar en la llengua del poble.', 'mossos_a4_sociolinguistic', (select id from public.topics where slug = 'mossos-a4-sociolinguistic'), 2, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=39'), 'Guia p. 41, §1.1', 'al Concili de Tours (813), l’Església mana oficialment als sacerdots que prediquin en la llengua del poble perquè se’ls entengui.', null, 'db66b032cd66f592027c7630719472dc4fe1fe56b5005bb74cd6084af64b07dd', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'db66b032cd66f592027c7630719472dc4fe1fe56b5005bb74cd6084af64b07dd')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Que es traduís la Bíblia al català.', false), ('B', 'Que els documents notarials s’escrivissin en llengua vulgar.', false), ('C', 'Que s’ensenyés el llatí culte a tota la població.', false), ('D', 'Que els sacerdots prediquessin en la llengua del poble perquè se’ls entengués.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, quin és el primer text escrit en català?', 'Les Homilies d’Organyà, vuit fulls d’un sermó en prosa, són el primer text escrit en català. Del Forum Iudiciorum, escrit en llatí, només se’n coneix la traducció d’un fragment.', 'mossos_a4_sociolinguistic', (select id from public.topics where slug = 'mossos-a4-sociolinguistic'), 1, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=39'), 'Guia p. 41, §1.1', 'Les Homilies d’Organyà. Primer text escrit en català. Són vuit fulls d’un sermó en prosa, on l’autor comenta passatges de l’Evangeli.', null, '1d1d98d5b1e0b4e24d61604826b4ee6b814047675c4c50af74c38095e454a226', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '1d1d98d5b1e0b4e24d61604826b4ee6b814047675c4c50af74c38095e454a226')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El Llibre dels Feyts.', false), ('B', 'Les Homilies d’Organyà.', true), ('C', 'Els Usatges de Barcelona.', false), ('D', 'El Forum Iudiciorum.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, per què va utilitzar el català Ramon Llull?', 'Llull va escriure en català per divulgar el saber entre el poble i no limitar-lo als eclesiàstics; és el creador de la prosa literària i científica catalana.', 'mossos_a4_sociolinguistic', (select id from public.topics where slug = 'mossos-a4-sociolinguistic'), 2, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=39'), 'Guia p. 41, §1.2', 'La raó per la qual usa el català és perquè té la voluntat de difondre entre el poble diverses branques del saber i evitar restringir la seva obra a l’estament culte, als eclesiàstics.', null, '644a87396239988751318f0724eec027d2b900d04666cfe5779c3ceb97fe5210', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '644a87396239988751318f0724eec027d2b900d04666cfe5779c3ceb97fe5210')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Perquè volia difondre entre el poble diverses branques del saber i no restringir la seva obra a l’estament culte.', true), ('B', 'Perquè no dominava el llatí.', false), ('C', 'Perquè el rei li va encarregar escriure en llengua vulgar.', false), ('D', 'Perquè el català era l’única llengua acceptada a les universitats.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, quin organisme va reformar Pere el Cerimoniós i redactava documents oficials considerats models de bona escriptura?', 'La Cancelleria reial redactava els documents de la Corona, que fixaven un model de llengua comparable a l’estàndard actual.', 'mossos_a4_sociolinguistic', (select id from public.topics where slug = 'mossos-a4-sociolinguistic'), 2, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=39'), 'Guia p. 42, §1.2', 'b) Es reforma la Cancelleria reial durant el regnat de Pere el Cerimoniós. Aquest organisme administratiu i burocràtic té la tasca de redactar els documents oficials de la Corona, que són considerats models de bona escriptura', null, '7f19ab49d3613d1b040a67aa97f7b8013be208674707680a14d6c99baa89fdf5', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '7f19ab49d3613d1b040a67aa97f7b8013be208674707680a14d6c99baa89fdf5')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El Consell de Cent.', false), ('B', 'La Diputació del General.', false), ('C', 'La Cancelleria reial.', true), ('D', 'L’Institut d’Estudis Catalans.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, quina obra de Bernat Metge és considerada la primera obra humanística a Espanya?', 'Arran del seu processament, Bernat Metge va escriure Lo somni (1399), primera obra humanística a Espanya.', 'mossos_a4_sociolinguistic', (select id from public.topics where slug = 'mossos-a4-sociolinguistic'), 3, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=39'), 'Guia p. 42, §1.2', 'Arran del seu processament escriu Lo somni (1399), que és la primera obra humanística a Espanya', null, '37ecc9153a18eba6692f05dc93dc367da53905ca0fa5880ebf08c78fccd90801', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '37ecc9153a18eba6692f05dc93dc367da53905ca0fa5880ebf08c78fccd90801')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Tirant lo Blanc.', false), ('B', 'L’Espill.', false), ('C', 'Curial e Güelfa.', false), ('D', 'Lo somni (1399).', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, quin autor va ser el primer poeta que va trencar definitivament amb la poesia trobadoresca?', 'Ausiàs March va trencar amb la poesia trobadoresca i va escriure més de deu mil versos plenament en català.', 'mossos_a4_sociolinguistic', (select id from public.topics where slug = 'mossos-a4-sociolinguistic'), 2, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=39'), 'Guia p. 42, §1.2', 'a) Ausiàs March. És el primer poeta que trenca definitivament amb la poesia trobadoresca.', null, '78177f51d3f0beee887fec1328e95e10ba3c5aa19730dc825cc5987ba88636f0', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '78177f51d3f0beee887fec1328e95e10ba3c5aa19730dc825cc5987ba88636f0')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Ausiàs March.', true), ('B', 'Joanot Martorell.', false), ('C', 'Roís de Corella.', false), ('D', 'Jaume Roig.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, fins a quan es va mantenir el català amb normalitat com a llengua de l’administració?', 'El català va ser llengua normal de l’administració fins al darrer terç del segle XVII; després la van abandonar pel funcionariat castellà, la inquisició i el prestigi del castellà.', 'mossos_a4_sociolinguistic', (select id from public.topics where slug = 'mossos-a4-sociolinguistic'), 3, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=39'), 'Guia p. 43, §1.3', 'El català havia aconseguit mantenir-se amb normalitat com a llengua de l’administració fins al darrer terç del segle xvii.', null, 'cb4ef504d72e3e18ed36309fbbb6ccd048b416a44ce175dadda08363b257fa02', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'cb4ef504d72e3e18ed36309fbbb6ccd048b416a44ce175dadda08363b257fa02')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Fins al Compromís de Casp (1412).', false), ('B', 'Fins al darrer terç del segle XVII.', true), ('C', 'Fins a la Guerra de les Germanies (1519-1523).', false), ('D', 'Fins a la Llei de normalització lingüística (1983).', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, en quins anys els decrets de Nova Planta van anul·lar l’oficialitat del català a València, a les Illes Balears i al Principat de Catalunya, respectivament?', 'Els decrets de Nova Planta van prohibir el català el 1707 a València, el 1715 a les Illes Balears (excepte Menorca, anglesa) i el 1716 al Principat.', 'mossos_a4_sociolinguistic', (select id from public.topics where slug = 'mossos-a4-sociolinguistic'), 3, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=39'), 'Guia p. 44, §1.3', 'es dicten els decrets de Nova Planta, que anul·len l’oficialitat del català i el prohibeixen: el 1707 a València, el 1715 a les Illes Balears (excepte a Menorca, sota dominació anglesa) i el 1716 al Principat de Catalunya.', null, '2704841aa8cc3ed0f23677a1c29675db79cfd4a6d66d6e94ef4d393438399acc', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '2704841aa8cc3ed0f23677a1c29675db79cfd4a6d66d6e94ef4d393438399acc')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', '1705, 1714 i 1716.', false), ('B', '1707, 1714 i 1715.', false), ('C', '1707, 1715 i 1716.', true), ('D', '1714, 1715 i 1716.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, quin fet marca l’inici simbòlic de la Renaixença el 1833?', 'L’inici simbòlic de la Renaixença és el 1833, amb La pàtria d’Aribau. Els Jocs Florals es restauren el 1859.', 'mossos_a4_sociolinguistic', (select id from public.topics where slug = 'mossos-a4-sociolinguistic'), 2, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=39'), 'Guia p. 45, §1.4', 'El 1833 marca l’inici simbòlic de la Renaixença, amb la publicació del poema La pàtria, de Bonaventura Carles Aribau.', null, '41f03d35d35fee4f687ab51c5c0a05457fc622ef6fc420005d952dccd7b1b749', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '41f03d35d35fee4f687ab51c5c0a05457fc622ef6fc420005d952dccd7b1b749')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'La restauració dels Jocs Florals.', false), ('B', 'La publicació de Lo catalanisme de Valentí Almirall.', false), ('C', 'La publicació del poema La pàtria, de Bonaventura Carles Aribau.', true), ('D', 'La fundació de la revista L’Avenç.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, en quin any es van restablir els Jocs Florals, peça clau en la restauració de la llengua?', 'Rubió i Ors, Milà i Fontanals, Balaguer i Bofarull van restablir els Jocs Florals el 1859.', 'mossos_a4_sociolinguistic', (select id from public.topics where slug = 'mossos-a4-sociolinguistic'), 2, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=39'), 'Guia p. 45, §1.4', 'L’any 1859, Joaquim Rubió i Ors, Manuel Milà i Fontanals, Víctor Balaguer i Antoni de Bofarull restableixen els Jocs Florals, peça clau en la restauració de la llengua.', null, 'a0725cc36c367d595b6ccbacca8ce4fbdfc1b33f75b23e8a68ff70ac48ec25ae', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'a0725cc36c367d595b6ccbacca8ce4fbdfc1b33f75b23e8a68ff70ac48ec25ae')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El 1859.', true), ('B', 'El 1833.', false), ('C', 'El 1886.', false), ('D', 'El 1906.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, qui va fundar l’Institut d’Estudis Catalans el 1907?', 'El 1907 Prat de la Riba, elegit president de la Diputació de Barcelona, va fundar l’IEC; a la seva Secció Filològica hi treballaria Pompeu Fabra.', 'mossos_a4_sociolinguistic', (select id from public.topics where slug = 'mossos-a4-sociolinguistic'), 2, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=39'), 'Guia p. 46, §1.5', '1907. Enric Prat de la Riba és elegit president de la Diputació de Barcelona i funda l’Institut d’Estudis Catalans (IEC).', null, '79b1493cde1c5aec12eeeeff0838f360bcc4a629fb74fe50eb2a56cd55928943', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '79b1493cde1c5aec12eeeeff0838f360bcc4a629fb74fe50eb2a56cd55928943')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Pompeu Fabra, com a director de la Secció Filològica.', false), ('B', 'Mossèn Antoni M. Alcover, després del Primer Congrés Internacional de la Llengua.', false), ('C', 'Francesc Macià, com a president de la Generalitat.', false), ('D', 'Enric Prat de la Riba, com a president de la Diputació de Barcelona.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, en quin any va publicar Pompeu Fabra la Gramàtica Catalana?', 'Fabra va publicar les Normes ortogràfiques (1913), el Diccionari Ortogràfic (1917), la Gramàtica Catalana (1918) i el Diccionari General (1932).', 'mossos_a4_sociolinguistic', (select id from public.topics where slug = 'mossos-a4-sociolinguistic'), 2, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=39'), 'Guia p. 46, §1.5', '1918. Pompeu Fabra publica la Gramàtica Catalana a partir dels criteris següents:', null, 'c467f90672471e950d59f0629eead2133c0af2a764b71d532c516842e5a40aca', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'c467f90672471e950d59f0629eead2133c0af2a764b71d532c516842e5a40aca')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El 1913.', false), ('B', 'El 1918.', true), ('C', 'El 1917.', false), ('D', 'El 1932.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, quins quatre factors té en compte el parlant per triar un registre?', 'Els registres depenen del tema, del canal (oral o escrit), del grau de formalitat i de la intencionalitat del parlant.', 'mossos_a4_sociolinguistic', (select id from public.topics where slug = 'mossos-a4-sociolinguistic'), 2, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=39'), 'Guia p. 48, §2.2', 'Per triar o bé definir un registre, el parlant té en compte quatre factors: 1. El camp semàntic o tema', null, 'f8f39540a4d61aa2ea52d4a8742a7a3ef390816f5ce295969238f8ea2baec530', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'f8f39540a4d61aa2ea52d4a8742a7a3ef390816f5ce295969238f8ea2baec530')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El camp semàntic o tema, el canal, el grau de formalitat i la intencionalitat.', true), ('B', 'L’edat, l’origen geogràfic, la classe social i el nivell d’estudis.', false), ('C', 'La gramàtica, l’ortografia, el lèxic i la pronunciació.', false), ('D', 'L’emissor, el receptor, el missatge i el context.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, quina de les següents és una de les cinc funcions de la varietat estàndard?', 'Les cinc funcions de l’estàndard són: unifica, separa, dona prestigi, és participativa i és marc de referència per als parlants.', 'mossos_a4_sociolinguistic', (select id from public.topics where slug = 'mossos-a4-sociolinguistic'), 3, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=39'), 'Guia p. 48, §2.3', 'b) separa, ja que afirma la identitat d’una comunitat lingüística respecte a d’altres;', null, 'f09f5d1a5c6e7f643e67c1a41562babd9251f29d3875c3e317477919b0a0729c', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'f09f5d1a5c6e7f643e67c1a41562babd9251f29d3875c3e317477919b0a0729c')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Substituir els dialectes en l’ús familiar.', false), ('B', 'Fixar la pronúncia única de tots els parlants.', false), ('C', 'Separar, ja que afirma la identitat d’una comunitat lingüística respecte a d’altres.', true), ('D', 'Recuperar les formes medievals de la llengua.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, quin privilegi va atorgar el rei Jaume II als habitants d’Aran el 23 d’agost de 1313?', 'El 23/08/1313 Jaume II va atorgar Era Querimònia, base legal de l’ordenament aranès durant més de cinc-cents anys.', 'mossos_a4_sociolinguistic', (select id from public.topics where slug = 'mossos-a4-sociolinguistic'), 3, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=39'), 'Guia p. 49, §3.1', 'el 23 d’agost de 1313 el rei Jaume II atorgà als habitants d’Aran l’anomenat privilègi d’Era Querimònia, verdadera carta magna de les llibertats araneses', null, 'f4644642849767045d4f76bd9e758dcd13a4c04500673b2bea9ae3f2436e4301', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'f4644642849767045d4f76bd9e758dcd13a4c04500673b2bea9ae3f2436e4301')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El Tractat d’emparança.', false), ('B', 'Les Ordinaciones del Valle de Aran.', false), ('C', 'El privilegi de no separació de la corona reial.', false), ('D', 'Era Querimònia, veritable carta magna de les llibertats araneses.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, quina llei va convertir l’occità, aranès a l’Aran, en llengua oficial a tot Catalunya?', 'La Llei 35/2010 va convertir l’occità en llengua oficial a tot Catalunya, l’únic territori de l’Estat amb tres llengües oficials.', 'mossos_a4_sociolinguistic', (select id from public.topics where slug = 'mossos-a4-sociolinguistic'), 2, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=39'), 'Guia p. 52, §3.2', 'Amb l’aprovació de la Llei 35/2010, de l’1 d’octubre, de l’occità, aranès a l’Aran, el Parlament de Catalunya va encetar el desenvolupament del mandat estatutari amb relació a Aran, i va convertir l’occità en llengua oficial a tot Catalunya.', null, '275b34e5eb0304fc61326a5459beaa2278add155bb6bae6f82a491e446d1f1a6', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '275b34e5eb0304fc61326a5459beaa2278add155bb6bae6f82a491e446d1f1a6')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'La Llei 7/1983, de normalització lingüística a Catalunya.', false), ('B', 'La Llei 35/2010, de l’1 d’octubre, de l’occità, aranès a l’Aran.', true), ('C', 'La Llei 16/1990, sobre el règim especial de la Vall d’Aran.', false), ('D', 'La Llei 1/2015, del règim especial d’Aran.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
-- Lote mossos-a5-marc-geografic-guia-v1 (20 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Guia d''estudi per accedir a la PG-ME, 1a edició, juny de 2026 (convocatòria 46/26), tema A.5, pp. 57-66', 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=57', 'web_oficial'::public.source_kind, 'Generalitat de Catalunya · Mossos d''Esquadra (web oficial de la convocatòria 46/26)', '2026-06-01') on conflict (url) do nothing;
insert into public.topics (slug, title) values ('mossos-a5-marc-geografic', 'A.5 Marc geogràfic de Catalunya') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug = 'mossos-esquadra' and t.slug = 'mossos-a5-marc-geografic' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, quina extensió té Catalunya?', 'Catalunya té 32.108 km² i és a l’extrem nord-est de la península Ibèrica.', 'mossos_a5_marc_geografic', (select id from public.topics where slug = 'mossos-a5-marc-geografic'), 1, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=57'), 'Guia p. 58, §1', 'Catalunya, amb una extensió de 32.108 km2, es troba situada a l’extrem nord-est de la península Ibèrica', null, 'a0294ed8153aedc06b83ba3baba6274397dea94dbc1032013181fc8a090a93f6', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'a0294ed8153aedc06b83ba3baba6274397dea94dbc1032013181fc8a090a93f6')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', '23.108 km².', false), ('B', '41.800 km².', false), ('C', '30.400 km².', false), ('D', '32.108 km².', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons les idees força de la Guia d’estudi, com s’organitza administrativament Catalunya?', 'Catalunya té vuit vegueries, 42 comarques i 947 municipis. Segons les esmenes oficials de setembre de 2026, l’Aran no compta com a comarca: és una entitat territorial singular.', 'mossos_a5_marc_geografic', (select id from public.topics where slug = 'mossos-a5-marc-geografic'), 2, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=57'), 'Guia p. 66, idees força 1 (esmena setembre 2026)', '1. Administrativament, Catalunya s’organitza en vuit vegueries, 42 comarques i 947 municipis.', 'Té en compte l’esmena oficial de setembre de 2026 al tema A.5 (42 comarques + Aran com a entitat territorial singular). La p. 58 de la guia encara diu «43 comarques»; per això no se’n fa cap pregunta.', '1452ec8dc1c8e5f355f45b6962a97bfec76f643e50c449bcb4c45643c256d33c', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '1452ec8dc1c8e5f355f45b6962a97bfec76f643e50c449bcb4c45643c256d33c')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'En set vegueries, 41 comarques i 946 municipis.', false), ('B', 'En vuit vegueries, 42 comarques i 947 municipis.', true), ('C', 'En quatre províncies, 43 comarques i 950 municipis.', false), ('D', 'En vuit vegueries, 44 comarques i 947 municipis.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, quina és la unitat administrativa bàsica, on resideix l’autoritat local?', 'El municipi és la unitat administrativa bàsica on resideix l’autoritat local.', 'mossos_a5_marc_geografic', (select id from public.topics where slug = 'mossos-a5-marc-geografic'), 2, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=57'), 'Guia p. 58, §1', 'El municipi és la unitat administrativa bàsica, on resideix l’autoritat local.', null, 'b3f41305dc32c9836bb439787bdd82c252ca328b062849a4cb93cfa687af741c', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'b3f41305dc32c9836bb439787bdd82c252ca328b062849a4cb93cfa687af741c')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El municipi.', true), ('B', 'La comarca.', false), ('C', 'La vegueria.', false), ('D', 'La província.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, quin nombre de vegueries fixava la Llei de vegueries aprovada el juliol de 2010, i a quantes es va ampliar a començaments de 2017?', 'La Llei de 27 de juliol de 2010 fixava set vegueries; a començaments de 2017 es van ampliar a vuit (amb el Penedès).', 'mossos_a5_marc_geografic', (select id from public.topics where slug = 'mossos-a5-marc-geografic'), 2, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=57'), 'Guia p. 58, §1', 'fixava en set el nombre definitiu de vegueries, ampliat a vuit a començaments de 2017.', null, '2e7eb8d664cdd356ab117ae94232e6ae677abb02b4bb115eb23b8c5703ae65c6', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '2e7eb8d664cdd356ab117ae94232e6ae677abb02b4bb115eb23b8c5703ae65c6')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'En fixava sis, ampliades a set.', false), ('B', 'En fixava vuit, ampliades a nou.', false), ('C', 'En fixava set, ampliades a vuit.', true), ('D', 'En fixava quatre, ampliades a vuit.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, de quina vegueria forma part l’Aran?', 'L’Aran és una entitat territorial singular que es relaciona bilateralment amb la Generalitat i forma part de la vegueria de l’Alt Pirineu.', 'mossos_a5_marc_geografic', (select id from public.topics where slug = 'mossos-a5-marc-geografic'), 2, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=57'), 'Guia p. 58, §1', 'l’Aran constitueix una entitat territorial singular dins de Catalunya, es relaciona de manera bilateral amb els òrgans de govern de la Generalitat, i forma part de la vegueria de l’Alt Pirineu.', null, 'bec3b562c0aec9c590d970b3d7196b7420449620a1ea1218a79bcef1d9c32384', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'bec3b562c0aec9c590d970b3d7196b7420449620a1ea1218a79bcef1d9c32384')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'De la vegueria de Lleida.', false), ('B', 'De la vegueria de l’Alt Pirineu.', true), ('C', 'De la vegueria de la Catalunya Central.', false), ('D', 'No forma part de cap vegueria.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, quin és el punt més elevat de Catalunya?', 'La Pica d’Estats, al Pirineu axial occidental, té 3.143 m i és el cim més alt de Catalunya.', 'mossos_a5_marc_geografic', (select id from public.topics where slug = 'mossos-a5-marc-geografic'), 1, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=57'), 'Guia p. 59, §2.1', 'Alguns cims superen els 3.000 metres, com la Pica d’Estats (3.143 m), que és el punt més elevat de Catalunya.', null, '57f136823ddb7a215fc354e8f9c4d983dbf3ff05ff432b963dc773245b6aa8a5', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '57f136823ddb7a215fc354e8f9c4d983dbf3ff05ff432b963dc773245b6aa8a5')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El Puigmal (2.913 m).', false), ('B', 'La Tossa Plana de Lles (2.916 m).', false), ('C', 'La Pica d’Estats (3.143 m).', true), ('D', 'El Pedraforca (2.497 m).', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, quina és l’excepció a l’orientació nord-sud de les valls pirinenques?', 'Les valls pirinenques són de nord a sud, excepte la Cerdanya, plana tectònica d’est a oest per on circula el curs alt del Segre.', 'mossos_a5_marc_geografic', (select id from public.topics where slug = 'mossos-a5-marc-geografic'), 3, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=57'), 'Guia p. 59, §2.1', 'L’excepció n’és la Cerdanya, plana d’origen tectònic, orientada d’est a oest i per on circula el curs alt del Segre.', null, 'd189f49a70510ac661c7ac715d1348c386698cca1e98137d89a30f46dd62c9dc', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'd189f49a70510ac661c7ac715d1348c386698cca1e98137d89a30f46dd62c9dc')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'La Vall d’Aran, oberta cap al Mediterrani.', false), ('B', 'La Conca de Tremp, orientada de nord a sud.', false), ('C', 'La vall de Núria, d’origen glacial.', false), ('D', 'La Cerdanya, plana d’origen tectònic orientada d’est a oest.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, en quines dues subunitats es pot dividir el Pirineu?', 'El Pirineu es divideix en el Pirineu axial (sector més elevat) i el Prepirineu (de menor alçada, al sud).', 'mossos_a5_marc_geografic', (select id from public.topics where slug = 'mossos-a5-marc-geografic'), 2, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=57'), 'Guia p. 59, §2.1', 'En general, el Pirineu es pot dividir en dues subunitats: el Pirineu axial i el Prepirineu.', null, '7296ac4751072de34262bb075c964802d4c60cb5a744322f66b031a2fb6ba021', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '7296ac4751072de34262bb075c964802d4c60cb5a744322f66b031a2fb6ba021')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El Pirineu axial i el Prepirineu.', true), ('B', 'El Pirineu oriental i el Pirineu occidental.', false), ('C', 'La Serralada Litoral i la Serralada Prelitoral.', false), ('D', 'El Pirineu axial i la Serralada Transversal.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, quin és el punt culminant del Sistema Mediterrani?', 'El Turó de l’Home (1.706 m), al Montseny, és el punt culminant del Sistema Mediterrani.', 'mossos_a5_marc_geografic', (select id from public.topics where slug = 'mossos-a5-marc-geografic'), 2, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=57'), 'Guia p. 60, §2.3', 'el Montseny, amb el cim del Turó de l’Home (1.706 m) com a punt culminant del Sistema Mediterrani', null, '63eca67f31a8858589b18ab868b46fe125f5adfb7332ba62f90bdc7af2b89d94', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '63eca67f31a8858589b18ab868b46fe125f5adfb7332ba62f90bdc7af2b89d94')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Montserrat (1.236 m).', false), ('B', 'Els ports de Besseit (1.442 m).', false), ('C', 'Sant Llorenç del Munt (1.104 m).', false), ('D', 'El Turó de l’Home, al Montseny (1.706 m).', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, quines planes comprèn la Depressió Prelitoral?', 'La Depressió Prelitoral, entre les serralades Prelitoral i Litoral, comprèn el Penedès, el Vallès, la Selva i el Gironès.', 'mossos_a5_marc_geografic', (select id from public.topics where slug = 'mossos-a5-marc-geografic'), 3, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=57'), 'Guia p. 60, §2.3', 'Comprèn les planes del Penedès, el Vallès, la Selva i el Gironès.', null, '5d8032ef4a0276196a927057b94e83f88474d43de948dd80b7a5dadef4f2d79b', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '5d8032ef4a0276196a927057b94e83f88474d43de948dd80b7a5dadef4f2d79b')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Les de l’Urgell, Lleida i la Segarra.', false), ('B', 'Les del Penedès, el Vallès, la Selva i el Gironès.', true), ('C', 'Les de Vic, el Bages i la conca d’Òdena.', false), ('D', 'Les de l’Empordà i el delta de l’Ebre.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, què caracteritza la Serralada Transversal?', 'A la Serralada Transversal hi conflueixen les tres grans unitats de relleu i destaca el vulcanisme de la zona d’Olot (Santa Margarida, el Croscat, Castellfollit de la Roca).', 'mossos_a5_marc_geografic', (select id from public.topics where slug = 'mossos-a5-marc-geografic'), 2, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=57'), 'Guia p. 60, §2.4', 'es caracteritza per l’activitat volcànica localitzada al pla d’Olot i el seu entorn', null, 'abc67ddbc8c02352c0a72ee6cf3dd8adcc03acd9941e26888719e06afdb6a055', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'abc67ddbc8c02352c0a72ee6cf3dd8adcc03acd9941e26888719e06afdb6a055')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'L’activitat volcànica localitzada al pla d’Olot i el seu entorn.', true), ('B', 'Ser la part més elevada del Pirineu.', false), ('C', 'Ser una plana sedimentària oberta a ponent.', false), ('D', 'Estar formada per planes deltaiques.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, aproximadament quants quilòmetres de costa té el litoral català?', 'El litoral català té uns 515 km, de Portbou fins al riu de la Sénia. Els 250 km són la longitud de la part catalana del Pirineu i els 320 km², l’extensió del delta de l’Ebre.', 'mossos_a5_marc_geografic', (select id from public.topics where slug = 'mossos-a5-marc-geografic'), 2, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=57'), 'Guia p. 60, §2.5', 'El litoral català (uns 515 km de costa) s’estén des de Portbou fins al riu de la Sénia (límit amb el País Valencià).', null, 'c54390cba9016e3b85f5c36a802a206cffb678c73e92219830c7558899a0b82b', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'c54390cba9016e3b85f5c36a802a206cffb678c73e92219830c7558899a0b82b')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Uns 250 km.', false), ('B', 'Uns 320 km.', false), ('C', 'Uns 515 km.', true), ('D', 'Uns 840 km.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, quin clima es dona a la Vall d’Aran?', 'Als climes mediterranis s’hi afegeixen el clima atlàntic de la Vall d’Aran i els climes alpí i subalpí del Pirineu a partir dels 1.500 m.', 'mossos_a5_marc_geografic', (select id from public.topics where slug = 'mossos-a5-marc-geografic'), 2, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=57'), 'Guia p. 61, §3', 'A aquests climes, cal afegir-hi el clima atlàntic que trobem a la Vall d’Aran', null, 'd6bb01b5bcfef318fedc6a9cc4680642a5c23dc0fc875165f07b844d2ce38656', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'd6bb01b5bcfef318fedc6a9cc4680642a5c23dc0fc875165f07b844d2ce38656')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El clima mediterrani litoral.', false), ('B', 'El clima mediterrani de tendència continental.', false), ('C', 'El clima subtropical.', false), ('D', 'El clima atlàntic.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, segons quins dos grans factors geogràfics es distribueixen els climes a Catalunya?', 'Com més lluny del mar i com més altitud, menys mediterraneïtat; la latitud hi té poca incidència.', 'mossos_a5_marc_geografic', (select id from public.topics where slug = 'mossos-a5-marc-geografic'), 2, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=57'), 'Guia p. 61, §3', 'Els diferents climes es troben distribuïts a Catalunya segons dos grans factors geogràfics: d’una banda la distància al mar (continentalitat) i de l’altra, l’altitud.', null, '8ce1c18a6d9c332c1f0c8d05a09ddb6a11ef2ae0dc5174dd328675c3b996336e', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '8ce1c18a6d9c332c1f0c8d05a09ddb6a11ef2ae0dc5174dd328675c3b996336e')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'La latitud i la longitud.', false), ('B', 'La distància al mar (continentalitat) i l’altitud.', true), ('C', 'La vegetació i la xarxa hidrogràfica.', false), ('D', 'La densitat de població i l’orientació de les valls.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, què és la inversió tèrmica que es produeix a l’hivern en planes interiors com la plana de Vic?', 'Amb anticicló, l’aire fred s’acumula a les valls amb boira i les temperatures hi són més baixes que als relleus del voltant: no es compleix el gradient tèrmic (0,6 °C menys cada 100 m).', 'mossos_a5_marc_geografic', (select id from public.topics where slug = 'mossos-a5-marc-geografic'), 3, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=57'), 'Guia p. 61, §3.1', 'Durant l’hivern, en algunes planes interiors, com la plana de Vic, es dona aquest fenomen, conegut com inversió tèrmica (és a dir, el no acompliment del gradient tèrmic', null, '039f00d2260281c38fdc193af8cb2775a1e83dcbd21a39e8ed35023c39cbf865', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '039f00d2260281c38fdc193af8cb2775a1e83dcbd21a39e8ed35023c39cbf865')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'L’augment de la temperatura amb la proximitat al mar.', false), ('B', 'La diferència entre la temperatura màxima i la mínima d’un període.', false), ('C', 'El no acompliment del gradient tèrmic, de manera que a les planes fa més fred que als relleus propers.', true), ('D', 'El canvi brusc de temperatura causat per la gota freda.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, quants anys de registres diaris calen perquè les dades de precipitació siguin vàlides?', 'Per a les precipitacions calen 30 anys de registres diaris; per a la temperatura mitjana anual, un mínim de 10 anys.', 'mossos_a5_marc_geografic', (select id from public.topics where slug = 'mossos-a5-marc-geografic'), 3, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=57'), 'Guia p. 62, §3.2', 'Cal un mínim de 30 anys de registres diaris per tal que les dades siguin vàlides.', null, '662db019bf4f40b2884a56d4742867bbac729fa7f8923a985f8df9c3e8661baa', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '662db019bf4f40b2884a56d4742867bbac729fa7f8923a985f8df9c3e8661baa')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Un mínim de 30 anys.', true), ('B', 'Un mínim de 10 anys.', false), ('C', 'Un mínim de 20 anys.', false), ('D', 'Un mínim de 50 anys.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, quin règim fluvial tenen els rius que neixen al Pirineu occidental, amb importants aportacions de neu?', 'La neu del Pirineu occidental garanteix el cabal fins avançat l’estiu (règim pluvionival). Els rius del Pirineu oriental i del Sistema Mediterrani depenen només de la pluja (règim pluvial).', 'mossos_a5_marc_geografic', (select id from public.topics where slug = 'mossos-a5-marc-geografic'), 3, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=57'), 'Guia p. 62, §4', 'les capçaleres dels rius que neixen al Pirineu occidental tenen importants aportacions en forma de neu durant l’hivern, la qual cosa garanteix el cabal fins ben avançat l’estiu (règim pluvionival).', null, '260539008b5b13a6751f1771dfbb1133c9f2660151f7e80fadf2ea9a38c8c5eb', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '260539008b5b13a6751f1771dfbb1133c9f2660151f7e80fadf2ea9a38c8c5eb')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Règim pluvionival, amb una major regularitat dels cabals.', true), ('B', 'Règim pluvial, amb cabals molt irregulars.', false), ('C', 'Règim glacial, amb cabal màxim a l’hivern.', false), ('D', 'Règim mediterrani, amb risc d’assecar-se a l’estiu.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, quines formacions caracteritzen la regió eurosiberiana?', 'La regió eurosiberiana, d’ambient humit, ombrívol i temperat, és el domini de rouredes, fagedes i pi roig.', 'mossos_a5_marc_geografic', (select id from public.topics where slug = 'mossos-a5-marc-geografic'), 2, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=57'), 'Guia p. 63, §5', 'La regió eurosiberiana es caracteritza per formacions adaptades a condicions d’ambient humit, ombrívol i temperat. És el domini dels boscos caducifolis (rouredes i fagedes) i els boscos de pi roig.', null, '4acc1cefe4a0472e18040fcb26301162bdb089ddd6fb49de07a1897d6771f35a', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '4acc1cefe4a0472e18040fcb26301162bdb089ddd6fb49de07a1897d6771f35a')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Els alzinars i les màquies.', false), ('B', 'Els boscos caducifolis (rouredes i fagedes) i els boscos de pi roig.', true), ('C', 'Els boscos de pi negre i les avetoses.', false), ('D', 'Les brolles d’arbustos baixos.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, quina població tenia Catalunya l’any 2021?', 'Catalunya tenia 7.763.362 habitants el 2021, el 65% dels quals a les comarques de l’àmbit metropolità de Barcelona.', 'mossos_a5_marc_geografic', (select id from public.topics where slug = 'mossos-a5-marc-geografic'), 2, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=57'), 'Guia p. 63, §6.1', 'La població de Catalunya l’any 2021 era de 7.763.362 habitants, el 65% dels quals es concentraven a les comarques de l’àmbit metropolità de Barcelona.', null, 'e89fe45795267de1004e7fb40385cd018898efad3b6d76aee3ffe1a6b646f41b', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'e89fe45795267de1004e7fb40385cd018898efad3b6d76aee3ffe1a6b646f41b')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', '6.343.110 habitants.', false), ('B', '8.012.231 habitants.', false), ('C', '5.956.414 habitants.', false), ('D', '7.763.362 habitants.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, d’on procedeix principalment la nova immigració arribada a Catalunya des del final dels anys vuitanta?', 'La tercera onada immigratòria, des de finals dels vuitanta, prové sobretot del nord d’Àfrica, Llatinoamèrica i l’est d’Europa.', 'mossos_a5_marc_geografic', (select id from public.topics where slug = 'mossos-a5-marc-geografic'), 3, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=57'), 'Guia p. 63, §6.1', 'Des del final dels anys vuitanta té lloc una nova immigració, procedent principalment de països del nord d’Àfrica, de Llatinoamèrica i de l’est d’Europa.', null, 'fdfda204a9f657f16fee31cf1fa35ee3a64ecdd8414e2d719d6893419dca60ca', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'fdfda204a9f657f16fee31cf1fa35ee3a64ecdd8414e2d719d6893419dca60ca')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'De la resta de l’Estat, especialment d’Andalusia.', false), ('B', 'Dels països de la Unió Europea occidental.', false), ('C', 'Del nord d’Àfrica, de Llatinoamèrica i de l’est d’Europa.', true), ('D', 'D’Àsia oriental i d’Oceania.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
-- Lote mossos-a6-entorn-social-guia-v1 (20 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Guia d''estudi per accedir a la PG-ME, 1a edició, juny de 2026 (convocatòria 46/26), tema A.6, pp. 67-82', 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=67', 'web_oficial'::public.source_kind, 'Generalitat de Catalunya · Mossos d''Esquadra (web oficial de la convocatòria 46/26)', '2026-06-01') on conflict (url) do nothing;
insert into public.topics (slug, title) values ('mossos-a6-entorn-social', 'A.6 Entorn social a Catalunya') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug = 'mossos-esquadra' and t.slug = 'mossos-a6-entorn-social' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, quantes persones vivien fora del seu territori d’origen l’any 2024, segons les Nacions Unides?', 'Segons l’ONU, el 2024 hi havia 304 milions de persones migrants (més del 3,7% de la població mundial). Els 123,2 milions són les persones desplaçades forçosament segons l’ACNUR.', 'mossos_a6_entorn_social', (select id from public.topics where slug = 'mossos-a6-entorn-social'), 2, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=67'), 'Guia p. 68, §1.1', 'Segons les Nacions Unides, l’any 2024 hi havia 304 milions de persones que vivien fora del seu territori d’origen', null, '5144461c5137dfae22558a991ce08d166f6f91c75dcc7990928306d695179026', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '5144461c5137dfae22558a991ce08d166f6f91c75dcc7990928306d695179026')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', '123,2 milions.', false), ('B', '180 milions.', false), ('C', '3,7 milions.', false), ('D', '304 milions.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, quina de les següents és una de les tres dimensions del caràcter global de les migracions actuals?', 'Les tres dimensions són: creixement o manteniment del volum de migrants, ampliació de les xarxes i cadenes migratòries i diversificació dels tipus migratoris.', 'mossos_a6_entorn_social', (select id from public.topics where slug = 'mossos-a6-entorn-social'), 3, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=67'), 'Guia p. 69, §1.1', 'b) L’ampliació de les xarxes i cadenes migratòries –és a dir, del conjunt de relacions entre individus, famílies i grups que serveixen de pont entre els llocs de partida i els llocs de destinació.', null, 'c21b9d8b37608bf97e4e700d6d6a83c8e34a8cefa502b723469a877cbb31416b', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'c21b9d8b37608bf97e4e700d6d6a83c8e34a8cefa502b723469a877cbb31416b')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'La reducció progressiva del volum de persones migrants.', false), ('B', 'L’ampliació de les xarxes i cadenes migratòries.', true), ('C', 'La desaparició de les xarxes migratòries familiars.', false), ('D', 'La limitació de les migracions a motius exclusivament econòmics.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, quin és el termini normal per obtenir a Espanya la nacionalitat per residència?', 'El termini normal és de 10 anys; són 5 per als refugiats i 2 per als iberoamericans, filipins, equatoguineans, portuguesos i persones d’origen sefardí.', 'mossos_a6_entorn_social', (select id from public.topics where slug = 'mossos-a6-entorn-social'), 3, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=67'), 'Guia p. 69, §1.2', 'El termini normal són 10 anys, tot i que per a alguns col·lectius són menys: 5 anys per als refugiats i 2 anys per als iberoamericans, filipins, equatoguineans, portuguesos i persones d’origen sefardí.', null, '005343bcdc199ec5b6d974803f507e1c05ac5ba14af75ba6f0b639cc7ce0e32b', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '005343bcdc199ec5b6d974803f507e1c05ac5ba14af75ba6f0b639cc7ce0e32b')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', '10 anys.', true), ('B', '2 anys.', false), ('C', '5 anys.', false), ('D', '15 anys.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, quins dos factors expliquen que Espanya i Catalunya es convertissin en receptors d’immigració internacional, sobretot entre 1998 i 2008?', 'La guia assenyala el creixement econòmic dels noranta i primers 2000 (amb mercats de treball molt diferenciats) i l’envelliment de la població amb desequilibris en les edats.', 'mossos_a6_entorn_social', (select id from public.topics where slug = 'mossos-a6-entorn-social'), 2, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=67'), 'Guia p. 70, §1.2', 'a) El ràpid creixement econòmic experimentat al llarg de la dècada dels noranta del segle xx i els primers anys del segle xxi, juntament amb l’existència d’uns mercats de treball molt diferenciats. b) La realitat demogràfica espanyola i catalana, immersa en un ràpid procés d’envelliment i afectada per greus desequilibris en les seves estructures d’edats.', null, '743985ff96d1a8bfc5856a15bc2c4cf9edd130e6561d0cda9c4482aad89c59e7', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '743985ff96d1a8bfc5856a15bc2c4cf9edd130e6561d0cda9c4482aad89c59e7')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'L’entrada a l’espai Schengen i la reducció de l’atur.', false), ('B', 'La crisi econòmica de 2007 i la caiguda de la natalitat als països d’origen.', false), ('C', 'El ràpid creixement econòmic amb mercats de treball molt diferenciats i una realitat demogràfica marcada per l’envelliment.', true), ('D', 'La regularització massiva d’estrangers i la creació de l’euro.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, quines són les tres comunitats autònomes amb més concentració de població estrangera?', 'Catalunya, Madrid i la Comunitat Valenciana acullen prop del 60% dels estrangers residents a Espanya.', 'mossos_a6_entorn_social', (select id from public.topics where slug = 'mossos-a6-entorn-social'), 2, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=67'), 'Guia p. 71, §1.2', 'Actualment, les tres regions amb més concentració de població estrangera són Catalunya, la Comunitat de Madrid i la Comunitat Valenciana, que acullen prop del 60% dels estrangers residents a Espanya.', null, '230228f3d10dd4c83822a355398fdfccb399ca7d4b0fe705acfdabeabe5cc389', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '230228f3d10dd4c83822a355398fdfccb399ca7d4b0fe705acfdabeabe5cc389')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Andalusia, Madrid i Catalunya.', false), ('B', 'Catalunya, les Illes Balears i les Canàries.', false), ('C', 'Madrid, la Comunitat Valenciana i Múrcia.', false), ('D', 'Catalunya, la Comunitat de Madrid i la Comunitat Valenciana.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, quin resultat ha tingut la tercera gran onada immigratòria dels darrers 100 anys a Catalunya?', 'Com en les dues onades anteriors, el resultat és que aproximadament un terç dels catalans han nascut fora de Catalunya. Catalunya és la segona comunitat més poblada.', 'mossos_a6_entorn_social', (select id from public.topics where slug = 'mossos-a6-entorn-social'), 2, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=67'), 'Guia p. 71, §1.3', 'S’ha conclòs la tercera gran onada immigratòria dels darrers 100 anys amb un resultat d’aproximadament un terç de catalans nascuts fora de Catalunya, com ja va passar en les dues onades anteriors.', null, 'f55bdc4ceb09459ee4b84de3c2d4c6d01c7c06fdb79a18425373db2e053e4bf1', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'f55bdc4ceb09459ee4b84de3c2d4c6d01c7c06fdb79a18425373db2e053e4bf1')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Que aproximadament un terç dels catalans han nascut fora de Catalunya, com en les dues onades anteriors.', true), ('B', 'Que la meitat dels catalans han nascut fora de Catalunya.', false), ('C', 'Que la població s’ha concentrat exclusivament a l’interior del país.', false), ('D', 'Que Catalunya ha passat a ser la comunitat més poblada de l’Estat.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, quin és el col·lectiu estranger més nombrós a Catalunya (dades del 2021)?', 'El col·lectiu marroquí representa més del 19% dels estrangers; el segueixen el romanès, l’italià i el xinès.', 'mossos_a6_entorn_social', (select id from public.topics where slug = 'mossos-a6-entorn-social'), 2, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=67'), 'Guia p. 73, §1.3', 'El col·lectiu més nombrós és el marroquí, que representa més del 19% de tots els estrangers. El segueixen el romanès, l’italià i el xinès.', null, '8c869e55580f0eada6e584665d67a671e4eee21cb72bfcf424480e5db6c35063', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '8c869e55580f0eada6e584665d67a671e4eee21cb72bfcf424480e5db6c35063')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El romanès.', false), ('B', 'El xinès.', false), ('C', 'El marroquí.', true), ('D', 'L’italià.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, quin percentatge de població estrangera tenia Catalunya el 2025, segons dades de l’Idescat?', 'El 2025 hi havia 1.522.819 estrangers sobre 8.154.627 habitants (18,7%). El 24,3% és el pes dels europeus comunitaris sobre el total d’estrangers.', 'mossos_a6_entorn_social', (select id from public.topics where slug = 'mossos-a6-entorn-social'), 3, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=67'), 'Guia p. 72, §1.3', '2025 8.154.627 1.522.819 18,7%', null, '1ca8972d649b36a737915454d25b868067fb9f1c9650f237b5082439c6934664', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '1ca8972d649b36a737915454d25b868067fb9f1c9650f237b5082439c6934664')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El 12,8%.', false), ('B', 'El 18,7%.', true), ('C', 'El 15,9%.', false), ('D', 'El 24,3%.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, amb l’entrada en vigor de quin tractat, el 1999, el ciutadà comunitari pot desplaçar-se, assentar-se i treballar lliurement a qualsevol país de la UE?', 'Des de l’entrada en vigor del Tractat d’Amsterdam (1999), el ciutadà comunitari té llibertat de moviment, residència i treball a la UE.', 'mossos_a6_entorn_social', (select id from public.topics where slug = 'mossos-a6-entorn-social'), 3, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=67'), 'Guia p. 75, §2.1', 'Amb l’entrada en vigor, el 1999, del Tractat d’Amsterdam, el ciutadà comunitari pot desplaçar-se, assentar-se i treballar lliurement a qualsevol part dels països de la UE', null, 'ff3b83cf4396c2bb84ae3f498eccc495008dedba3f26cd9f6ff9ea0e1f86e137', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'ff3b83cf4396c2bb84ae3f498eccc495008dedba3f26cd9f6ff9ea0e1f86e137')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El Tractat d’Amsterdam.', true), ('B', 'El Tractat de Maastricht.', false), ('C', 'El Tractat de Lisboa.', false), ('D', 'El Tractat de Roma.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, quina directiva europea especifica els motius de concessió de protecció internacional i defineix qui és refugiat?', 'La Directiva 2011/95/UE defineix qui és refugiat i el contingut de l’estatut de protecció internacional.', 'mossos_a6_entorn_social', (select id from public.topics where slug = 'mossos-a6-entorn-social'), 3, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=67'), 'Guia p. 75, §2.1', 'La Directiva 2011/95/UE, que especifica els motius que donen lloc a la concessió de protecció internacional, defineix qui és refugiat i el contingut d’aquest estatut de protecció.', null, '34a91aacdcee11e0fa9a7c8349ad991eea9d14a586d9596dc34e1009555444df', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '34a91aacdcee11e0fa9a7c8349ad991eea9d14a586d9596dc34e1009555444df')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'La Directiva 2008/115/CE.', false), ('B', 'La Directiva 2003/86/CE.', false), ('C', 'La Directiva 2013/32/UE.', false), ('D', 'La Directiva 2011/95/UE.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, quina norma és la llei marc de la política migratòria espanyola sobre drets i llibertats dels estrangers?', 'Entre les mesures principals hi ha la LO 8/2000 (Llei d’estrangeria), una llei marc per a la gestió dels fluxos migratoris.', 'mossos_a6_entorn_social', (select id from public.topics where slug = 'mossos-a6-entorn-social'), 2, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=67'), 'Guia p. 76, §2.2', 'Entre les principals mesures que conformen la política migratòria espanyola, cal assenyalar la Llei orgànica 8/2000, sobre drets i llibertats dels estrangers a Espanya i la seva integració social.', 'La guia cita en aquest apartat la «LO 8/2000» i més avall el «Reglament de la LO 4/2000» (la LO 4/2000 és la llei d’estrangeria original, reformada per la LO 8/2000). La pregunta segueix la literalitat de la guia.', '0a5458e7454ef87a45505ba71859f458ee2967b1d5271a9258cf5736bb5efcc8', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '0a5458e7454ef87a45505ba71859f458ee2967b1d5271a9258cf5736bb5efcc8')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'La Llei 12/2009, reguladora del dret d’asil.', false), ('B', 'La Llei orgànica 8/2000, sobre drets i llibertats dels estrangers a Espanya i la seva integració social.', true), ('C', 'La Llei 10/2010, d’acollida de les persones immigrades.', false), ('D', 'El Reial decret 557/2011.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, què és la Taula de Ciutadania i Immigració, creada el 2008?', 'El 2008 es va aprovar el Pacte nacional per a la immigració i es va crear la Taula de Ciutadania i Immigració, òrgan de consulta i participació.', 'mossos_a6_entorn_social', (select id from public.topics where slug = 'mossos-a6-entorn-social'), 2, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=67'), 'Guia p. 76, §2.2', 'El 2008 s’aprova el Pacte nacional per a la immigració i es crea La Taula de Ciutadania i Immigració, que és un òrgan de consulta i participació per a les polítiques de gestió del fet migratori que promou la Generalitat de Catalunya.', null, 'e366fb0097f96ae1b5a4df34587b613613ba66ba470507ac59218a401d08f6ac', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'e366fb0097f96ae1b5a4df34587b613613ba66ba470507ac59218a401d08f6ac')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Un tribunal que resol els recursos sobre permisos de residència.', false), ('B', 'Una comissió de l’Estat que fixa el contingent anual de treballadors estrangers.', false), ('C', 'Un òrgan de consulta i participació per a les polítiques de gestió del fet migratori que promou la Generalitat.', true), ('D', 'Un registre municipal de les persones estrangeres empadronades.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, quina llei catalana regula l’acollida de les persones immigrades i de les retornades a Catalunya?', 'La Llei 10/2010, de 7 de maig, regula l’acollida de persones immigrades i retornades; el 2014 la va completar el Decret 150/2014 dels serveis d’acollida.', 'mossos_a6_entorn_social', (select id from public.topics where slug = 'mossos-a6-entorn-social'), 2, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=67'), 'Guia p. 76, §2.2', 'El 2010 s’aprova la Llei 10/2010, de 7 de maig, d’acollida de les persones immigrades i de les retornades a Catalunya', null, '6ded9207c93f3bc434d304767189b4a33d373a2835d11c14e587d298d3f82345', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '6ded9207c93f3bc434d304767189b4a33d373a2835d11c14e587d298d3f82345')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'La Llei 12/2007.', false), ('B', 'La Llei 5/2008.', false), ('C', 'La Llei 17/2015.', false), ('D', 'La Llei 10/2010, de 7 de maig.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, quin model d’integració implica nadius i immigrants en la creació d’una nova cultura general resultat de la fusió dels diversos elements culturals?', 'El melting pot crea una nova cultura per fusió; l’assimilació demana a l’immigrant adoptar la cultura majoritària; el pluralisme manté les peculiaritats dins de principis comuns.', 'mossos_a6_entorn_social', (select id from public.topics where slug = 'mossos-a6-entorn-social'), 2, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=67'), 'Guia p. 77, §3', 'Melting pot (gresol cultural): aquest model d’integració implica tots els membres de la societat (nadius i immigrants) en la creació d’una nova cultura general, com a resultat de la fusió dels diversos elements culturals i les diferents identitats.', null, '85eaf9f25011cf06c2914559ed582c9dc1a0414de52d4653ab53b04360ea3504', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '85eaf9f25011cf06c2914559ed582c9dc1a0414de52d4653ab53b04360ea3504')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El melting pot o gresol cultural.', true), ('B', 'L’assimilació.', false), ('C', 'El pluralisme cultural.', false), ('D', 'La segregació.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, quina crítica es fa al model de pluralisme cultural?', 'L’assimilació i el melting pot es rebutgen perquè contravenen el dret a mantenir la pròpia identitat; el pluralisme es critica pel risc de fragmentació social.', 'mossos_a6_entorn_social', (select id from public.topics where slug = 'mossos-a6-entorn-social'), 3, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=67'), 'Guia p. 77, §3', 'Quant al pluralisme cultural, es critica pels seus riscos de fragmentació social, que pot donar lloc a una coexistència social separada entre els diversos grups.', null, 'b2b294a7d82fefd03b0686720636298cf0f300ec1a9d29d4141892506c71e94a', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'b2b294a7d82fefd03b0686720636298cf0f300ec1a9d29d4141892506c71e94a')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Que obliga l’immigrant a renunciar a la seva cultura.', false), ('B', 'Que comporta riscos de fragmentació social i de coexistència separada entre els grups.', true), ('C', 'Que elimina les senyes d’identitat de la població autòctona.', false), ('D', 'Que impedeix l’existència de principis comuns de convivència.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, quina llei estatal fa una regulació específica per combatre totes les manifestacions de discriminació per raó de sexe i promoure la igualtat real?', 'La Llei 3/2007 regula específicament la lluita contra la discriminació per raó de sexe. La Llei 17/2015 és la primera llei d’igualtat catalana.', 'mossos_a6_entorn_social', (select id from public.topics where slug = 'mossos-a6-entorn-social'), 2, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=67'), 'Guia p. 78, §4', 'Però no és fins a l’entrada en vigor de la Llei 3/2007, de 22 de març, per a la igualtat efectiva entre dones i homes, en què es fa una regulació específica per abordar i combatre totes les manifestacions encara subsistents de discriminació', 'La guia l’anomena «Llei 3/2007»; formalment és la Llei orgànica 3/2007. He afegit «orgànica» a l’opció correcta: comprova que t’està bé.', '96fdeab4c1aa46958cdedbb8c809ab191bfd2f19ba6b3f41a3443c52d01270a5', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '96fdeab4c1aa46958cdedbb8c809ab191bfd2f19ba6b3f41a3443c52d01270a5')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'La Llei 39/1999, de conciliació de la vida familiar i laboral.', false), ('B', 'La Llei 8/2006, de mesures de conciliació.', false), ('C', 'La Llei orgànica 3/2007, de 22 de març, per a la igualtat efectiva entre dones i homes.', true), ('D', 'La Llei 17/2015, d’igualtat efectiva de dones i homes.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, quin article de l’Estatut obliga els poders públics a incorporar la perspectiva de gènere en les polítiques públiques?', 'L’article 41 EAC obliga a incorporar la perspectiva de gènere per garantir la igualtat d’oportunitats entre dones i homes.', 'mossos_a6_entorn_social', (select id from public.topics where slug = 'mossos-a6-entorn-social'), 2, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=67'), 'Guia p. 78, §4', 'L’article 41 de l’EAC estableix l’obligació que tenen els poders públics d’incorporar la perspectiva de gènere en les diferents polítiques públiques', null, 'f8546f4909bf57b480a60eec2339947a13dd0a13e8b9a2037a7bfef184cd8fb2', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'f8546f4909bf57b480a60eec2339947a13dd0a13e8b9a2037a7bfef184cd8fb2')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'L’article 15.', false), ('B', 'L’article 6.', false), ('C', 'L’article 41.', true), ('D', 'L’article 164.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, quina llei catalana té per objectiu eradicar la violència masclista?', 'La Llei 5/2008 vol eradicar les estructures i estereotips que perpetuen la violència masclista i reconeix els drets de les dones que la pateixen.', 'mossos_a6_entorn_social', (select id from public.topics where slug = 'mossos-a6-entorn-social'), 2, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=67'), 'Guia p. 78, §4', 'Posteriorment s’aprova la Llei 5/2008, del 24 d’abril, del dret de les dones a eradicar la violència masclista', null, '7c82eb305c0c234ac1e58e81055172f7b7204a9f47d908cc9b0495c71996426a', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '7c82eb305c0c234ac1e58e81055172f7b7204a9f47d908cc9b0495c71996426a')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'La Llei 17/2015, de 21 de juliol.', false), ('B', 'La Llei 5/2008, del 24 d’abril, del dret de les dones a eradicar la violència masclista.', true), ('C', 'La Llei 8/2006, de 5 de juliol.', false), ('D', 'La Llei 12/2007, de serveis socials.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, en quin any es va crear l’Institut Català de les Dones?', 'L’Institut Català de les Dones es va crear el 1989 i aquell mateix any va començar el I Pla d’actuació per a la igualtat d’oportunitats (1989-1992).', 'mossos_a6_entorn_social', (select id from public.topics where slug = 'mossos-a6-entorn-social'), 2, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=67'), 'Guia p. 79, §4', 'Des de la seva creació el 1989 l’Institut Català de les Dones té el repte de dissenyar estratègies de transversalitat', null, '3ca7398d322ef24310e5a7e2036d2434195bc3671e5cb4035e8b8eb5abd5dbb5', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '3ca7398d322ef24310e5a7e2036d2434195bc3671e5cb4035e8b8eb5abd5dbb5')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El 1979.', false), ('B', 'El 2005.', false), ('C', 'El 2021.', false), ('D', 'El 1989.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, quins dos nivells bàsics d’actuació té la xarxa de serveis socials?', 'L’atenció primària és polivalent i propera; l’especialitzada atén necessitats que no pot cobrir la xarxa bàsica i grups específics (gent gran, infants…).', 'mossos_a6_entorn_social', (select id from public.topics where slug = 'mossos-a6-entorn-social'), 2, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=67'), 'Guia p. 80, §5.2', 'La xarxa bàsica de serveis socials constaria, així, de dos nivells bàsics d’actuació. El primer estaria format per l’atenció primària, que seria la resposta més propera a la ciutadania', null, '5baacc8f34e8420c93479825e8f13a3c7c6b31e39274ad7f56d2b55828d24b6a', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '5baacc8f34e8420c93479825e8f13a3c7c6b31e39274ad7f56d2b55828d24b6a')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'L’atenció primària, la més propera a la ciutadania, i els serveis especialitzats.', true), ('B', 'El nivell municipal i el nivell estatal.', false), ('C', 'La prevenció i la sanció.', false), ('D', 'Els serveis públics i els serveis privats.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
-- Lote mossos-a7-tic-guia-v1 (20 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Guia d''estudi per accedir a la PG-ME, 1a edició, juny de 2026 (convocatòria 46/26), tema A.7, pp. 83-93', 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=83', 'web_oficial'::public.source_kind, 'Generalitat de Catalunya · Mossos d''Esquadra (web oficial de la convocatòria 46/26)', '2026-06-01') on conflict (url) do nothing;
insert into public.topics (slug, title) values ('mossos-a7-tic', 'A.7 Les tecnologies de la informació en el segle XXI') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug = 'mossos-esquadra' and t.slug = 'mossos-a7-tic' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, quin any es considera l’acte de naixement de la societat del coneixement o de la informació?', 'La guia fixa el 1981 (MS-DOS i primer PC d’IBM). El Macintosh del 1984 va estendre l’ús de l’ordinador amb la interfície gràfica i el ratolí.', 'mossos_a7_tic', (select id from public.topics where slug = 'mossos-a7-tic'), 2, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=83'), 'Guia p. 84, §1', 'el punt de partida, l’acte de naixement de la societat del coneixement o de la informació té una data concreta: l’any 1981. Aquest any Microsoft desenvolupa el sistema operatiu MS-DOS i IBM presenta el primer ordinador personal, el PC (personal computer).', null, 'de0457d268b231b2b081882f68a3b06dc382eb830b0c87d5233c507daba9b4e2', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'de0457d268b231b2b081882f68a3b06dc382eb830b0c87d5233c507daba9b4e2')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El 1969, amb la creació d’Arpanet.', false), ('B', 'El 1984, amb l’aparició del Macintosh d’Apple.', false), ('C', 'El 1991, amb la creació de la World Wide Web.', false), ('D', 'El 1981, quan Microsoft desenvolupa l’MS-DOS i IBM presenta el primer ordinador personal.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, què caracteritza la societat informatitzada o cibersocietat?', 'La cibersocietat considera la informació la principal riquesa i font d’organització; la població activa es desplaça al sector terciari.', 'mossos_a7_tic', (select id from public.topics where slug = 'mossos-a7-tic'), 2, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=83'), 'Guia p. 84, §1', 'La societat postindustrial de la segona meitat del segle xx dona pas a la societat informatitzada, la cibersocietat, que es caracteritza per considerar la informació com la principal riquesa i font d’organització.', null, 'a6fa4cd92cd67c4fbb703c774f230a07f83765832a935d8d2fba95852fdc519d', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'a6fa4cd92cd67c4fbb703c774f230a07f83765832a935d8d2fba95852fdc519d')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Considerar la producció industrial com la principal riquesa.', false), ('B', 'Considerar la informació com la principal riquesa i font d’organització.', true), ('C', 'La concentració de la població activa al sector secundari.', false), ('D', 'La limitació de l’accés a la informació a una minoria.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, què és la hipermèdia?', 'La multimèdia integra so, imatge i text; la hipermèdia integra multimèdia i hipertext (text organitzat de forma no seqüencial).', 'mossos_a7_tic', (select id from public.topics where slug = 'mossos-a7-tic'), 2, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=83'), 'Guia p. 85, §1', 'b) Hipermèdia: integració de multimèdia i hipertext, que és un text organitzat de forma no seqüencial.', null, '8abcbe8e2d1974c7c52b8fda4913a8b9a060bb3414729fd469e83e3c36145fd0', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '8abcbe8e2d1974c7c52b8fda4913a8b9a060bb3414729fd469e83e3c36145fd0')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'La integració de multimèdia i hipertext.', true), ('B', 'La integració de so, imatge i text.', false), ('C', 'La possibilitat de traslladar les persones a una realitat diferent.', false), ('D', 'La convergència de la telefonia mòbil amb Internet.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, què és la Internet de les coses (IoT)?', 'La IoT interconnecta dispositius per a múltiples funcions (videovigilància, domòtica, automoció…), cosa que també crea noves amenaces.', 'mossos_a7_tic', (select id from public.topics where slug = 'mossos-a7-tic'), 2, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=83'), 'Guia p. 85, §1', 'La IoT representa el màxim exponent de la interconnexió de dispositius a través d’Internet, els quals poden estar orientats a múltiples funcions, com ara videovigilància, domòtica, automoció, etc.', null, '2cf6f7a3166c7ae0e0b5a6e5b7f7ddf787b69b4bc1651bc3c085a1b588c11e72', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '2cf6f7a3166c7ae0e0b5a6e5b7f7ddf787b69b4bc1651bc3c085a1b588c11e72')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Una xarxa privada d’ordinadors de les administracions públiques.', false), ('B', 'El conjunt de botigues de comerç electrònic.', false), ('C', 'El màxim exponent de la interconnexió de dispositius a través d’Internet, orientats a funcions com la videovigilància, la domòtica o l’automoció.', true), ('D', 'Un protocol de seguretat per enviar dades confidencials.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, a què es refereix el terme anglès safety, en contraposició a security?', 'El món anglosaxó separa safety (seguretat ambiental, riscos laborals…) i security (seguretat física i lògica, control d’accessos, intrusions).', 'mossos_a7_tic', (select id from public.topics where slug = 'mossos-a7-tic'), 3, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=83'), 'Guia p. 85, §1', 'el món anglosaxó sempre ha mantingut dos conceptes ben clars i diferenciats, atès que els separa en safety, per als assumptes relacionats amb la seguretat ambiental, riscos laborals, etc., i security, per a allò relacionat amb la seguretat física i lògica', null, 'd360fba93019008a3c92be8351ccd5ee7efade6d17010f551f33361778e21f08', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'd360fba93019008a3c92be8351ccd5ee7efade6d17010f551f33361778e21f08')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'A la seguretat física i lògica orientada al control d’accessos.', false), ('B', 'A la prevenció d’intrusions informàtiques.', false), ('C', 'Als assumptes relacionats amb la seguretat ambiental, els riscos laborals, etc.', true), ('D', 'A la seguretat ciutadana i l’ordre públic.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, quin efecte de les TIC fa que desaparegui el concepte del valor de l’esforç per aconseguir un objectiu?', 'La relació directa i individualitzada amb les màquines a través de la pantalla provoca ciberdependència.', 'mossos_a7_tic', (select id from public.topics where slug = 'mossos-a7-tic'), 2, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=83'), 'Guia p. 87, §2', 'Això provoca, de retruc, un important efecte de ciberdependència: desapareix el concepte del valor de l’esforç per aconseguir un objectiu', null, 'c2eb17d8097de55d1a624e2e4e796cbfeadefdc02718cecc3b2ba975e0b31f1e', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'c2eb17d8097de55d1a624e2e4e796cbfeadefdc02718cecc3b2ba975e0b31f1e')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'La cibercultura.', false), ('B', 'L’obsolescència.', false), ('C', 'La globalització.', false), ('D', 'La ciberdependència.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, què és la cibercultura?', 'La cibercultura és el resultat de la multimèdia: el mitjà tecnològic és tan important com el contingut transmès.', 'mossos_a7_tic', (select id from public.topics where slug = 'mossos-a7-tic'), 2, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=83'), 'Guia p. 87, §2', 'el resultat final és la cibercultura, que és una nova concepció de la cultura i de la societat, on el que es transmet té tanta importància com el mitjà tecnològic que fa possible aquesta transmissió.', null, '71108d88f98dc33548fd3b7ce370dd7368ebf1bab9bbf518e8a4471535aa0425', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '71108d88f98dc33548fd3b7ce370dd7368ebf1bab9bbf518e8a4471535aa0425')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'La pirateria de productes culturals a Internet.', false), ('B', 'Una nova concepció de la cultura i de la societat on el que es transmet té tanta importància com el mitjà tecnològic que ho fa possible.', true), ('C', 'La formació a distància o e-learning.', false), ('D', 'La cultura dels videojocs en línia.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, quina de les característiques següents defineix el canvi en el pas de la societat postindustrial a la societat del coneixement?', 'Disminueixen l’agricultura i la indústria tradicional i augmenten les feines executives, professionals i tècniques i l’ocupació qualificada.', 'mossos_a7_tic', (select id from public.topics where slug = 'mossos-a7-tic'), 3, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=83'), 'Guia p. 86, §2', 'c) Augmenten i es diversifiquen les feines de caràcter executiu, professional i tècnic.', null, 'a2f31b8937d47658574a679af67ddf981c4d2c75c90afb4df469a99e1ce09cd3', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'a2f31b8937d47658574a679af67ddf981c4d2c75c90afb4df469a99e1ce09cd3')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Augmenten i es diversifiquen les feines de caràcter executiu, professional i tècnic.', true), ('B', 'Augmenta l’ocupació industrial tradicional.', false), ('C', 'L’agricultura i la ramaderia guanyen pes en el sistema productiu.', false), ('D', 'Disminueix l’ocupació de més alta formació i qualificació.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, què és cada vegada més important davant l’excés d’informació?', 'Cal aprendre a valorar i seleccionar la informació abans de processar-la: la qualitat importa més que la quantitat.', 'mossos_a7_tic', (select id from public.topics where slug = 'mossos-a7-tic'), 2, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=83'), 'Guia p. 88, §2', 'Per tant, cada vegada és més important la qualitat de la informació i el coneixement rebuts que la quantitat.', null, '2fe139d528271692a781635ecef90b932ea86b9d357a4a26d38459becb1ba3f6', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '2fe139d528271692a781635ecef90b932ea86b9d357a4a26d38459becb1ba3f6')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'La velocitat de connexió a Internet.', false), ('B', 'El nombre de fonts consultades.', false), ('C', 'L’emmagatzematge de tota la informació rebuda.', false), ('D', 'La qualitat de la informació i el coneixement rebuts, més que la quantitat.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, amb quins aspectes s’ha d’associar la seguretat informàtica, a diferència de la seguretat de la informació?', 'La seguretat informàtica és tècnica i operacional; la seguretat de la informació és estratègica (riscos, amenaces, bones pràctiques) i busca confidencialitat, integritat i disponibilitat.', 'mossos_a7_tic', (select id from public.topics where slug = 'mossos-a7-tic'), 3, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=83'), 'Guia p. 88, §3', 'La seguretat informàtica s’ha d’associar a aquells aspectes tècnics i operacionals de la seguretat', null, '660f87e805acfab75d5b4b235cdb1219317cd61611a85761f1936ab3632e8df1', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '660f87e805acfab75d5b4b235cdb1219317cd61611a85761f1936ab3632e8df1')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Amb la gestió de riscos i l’anàlisi d’escenaris.', false), ('B', 'Amb els aspectes estratègics de l’organització.', false), ('C', 'Amb els aspectes tècnics i operacionals de la seguretat.', true), ('D', 'Amb el marc legal de protecció de dades.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, quin és l’objectiu de la seguretat de la informació?', 'La seguretat de la informació gestiona riscos i amenaces per assegurar confidencialitat, integritat i disponibilitat; els tallafocs i antivirus no són suficients per si mateixos.', 'mossos_a7_tic', (select id from public.topics where slug = 'mossos-a7-tic'), 2, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=83'), 'Guia p. 88, §3', 'amb l’objectiu d’assegurar la confidencialitat, integritat i disponibilitat en l’ús de la informació.', null, '87f9fc189907b7c6bfd27be4b57d51825f35b7d97a4c7afc582d0d6e87b235be', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '87f9fc189907b7c6bfd27be4b57d51825f35b7d97a4c7afc582d0d6e87b235be')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Instal·lar tallafocs i antivirus en tots els equips.', false), ('B', 'Assegurar la confidencialitat, la integritat i la disponibilitat en l’ús de la informació.', true), ('C', 'Garantir la velocitat de transmissió de les dades.', false), ('D', 'Impedir l’ús d’Internet dins l’organització.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, en quin any es va començar a apostar a Catalunya pel desenvolupament d’un model d’administració electrònica?', 'A Catalunya es va començar a apostar per l’administració electrònica el 1997, amb la cooperació entre administracions.', 'mossos_a7_tic', (select id from public.topics where slug = 'mossos-a7-tic'), 2, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=83'), 'Guia p. 89, §4', 'A Catalunya es va començar a apostar pel desenvolupament d’un model d’administració electrònica l’any 1997', null, '9c05799e61e4eda195bfa81450f834c4f44ecc0ca0d1ba605c863f71112c4852', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '9c05799e61e4eda195bfa81450f834c4f44ecc0ca0d1ba605c863f71112c4852')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El 1997.', true), ('B', 'El 1981.', false), ('C', 'El 1992.', false), ('D', 'El 2007.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, quines tres propietats ha de complir la signatura electrònica?', 'La signatura electrònica garanteix autenticitat (identitat del remitent), integritat (missatge no modificat) i no repudi (l’emissor no pot negar l’enviament).', 'mossos_a7_tic', (select id from public.topics where slug = 'mossos-a7-tic'), 1, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=83'), 'Guia p. 89, §4', 'La signatura electrònica permet que un emissor pugui enviar missatges a un receptor complint les tres propietats següents:', null, 'e49aed4074fb72a4ffc6667dda6952f43161a0a7dadef7f13498cc64ea848254', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'e49aed4074fb72a4ffc6667dda6952f43161a0a7dadef7f13498cc64ea848254')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Confidencialitat, rapidesa i gratuïtat.', false), ('B', 'Anonimat, integritat i disponibilitat.', false), ('C', 'Autenticitat, xifratge i traçabilitat.', false), ('D', 'Autenticitat, integritat i no repudi.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, què garanteix la propietat de no repudi de la signatura electrònica?', 'Amb el no repudi, l’emissor no pot argumentar que el missatge l’ha enviat una altra persona.', 'mossos_a7_tic', (select id from public.topics where slug = 'mossos-a7-tic'), 2, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=83'), 'Guia p. 89, §4', 'No repudi: l’emissor d’un missatge no pot repudiar o negar que l’ha enviat (per exemple, podria argumentar que l’ha enviat una tercera persona).', null, '971269ce39aab5ce779660feb924206a6b89f2e851080153f6b268ad0f84aaf3', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '971269ce39aab5ce779660feb924206a6b89f2e851080153f6b268ad0f84aaf3')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Que l’emissor d’un missatge no pot negar que l’ha enviat.', true), ('B', 'Que el missatge no s’ha modificat durant la transmissió.', false), ('C', 'Que el receptor està segur de la identitat del remitent.', false), ('D', 'Que el contingut del missatge és secret.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, en què es basa la solució adoptada a Internet quan cal enviar dades confidencials?', 'Com que Internet és un canal insegur, per enviar dades confidencials s’utilitza el protocol SSL.', 'mossos_a7_tic', (select id from public.topics where slug = 'mossos-a7-tic'), 2, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=83'), 'Guia p. 89, §5', 'En el cas d’Internet, la solució adoptada es basa en la utilització del protocol SSL (Secure Sockets Layer).', null, 'e46405d495f1b3c7713e73a74912429962b14d3a7dbc8bd8bd83a4245ab8d66e', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'e46405d495f1b3c7713e73a74912429962b14d3a7dbc8bd8bd83a4245ab8d66e')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'En l’ús exclusiu del correu electrònic.', false), ('B', 'En la telefonia mòbil.', false), ('C', 'En la utilització del protocol SSL (Secure Sockets Layer).', true), ('D', 'En l’hipertext.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, quin article de la Constitució aplica la Llei orgànica 5/1992 (LORTAD), sobre la limitació de l’ús de la informàtica?', 'La LORTAD va aplicar l’article 18.4 CE per limitar l’ús de la informàtica i garantir l’honor i la intimitat; d’aquí va sorgir l’Agència de Protecció de Dades.', 'mossos_a7_tic', (select id from public.topics where slug = 'mossos-a7-tic'), 3, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=83'), 'Guia p. 90, §5', 'sorgí la Llei orgànica 5/1992, de regulació i tractament automàtic de les dades (LORTAD), que aplica l’article 18.4 de la CE', null, 'd0e8e602228afc36bc16fcb3e41a0c2058aeb63ba56d20de8dcd16693f5aa983', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'd0e8e602228afc36bc16fcb3e41a0c2058aeb63ba56d20de8dcd16693f5aa983')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'L’article 20.1 CE.', false), ('B', 'L’article 18.4 CE.', true), ('C', 'L’article 24.2 CE.', false), ('D', 'L’article 105 CE.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, quina llei orgànica regula actualment la protecció de dades personals i la garantia dels drets digitals?', 'La LO 3/2018 és la norma vigent; la LO 15/1999 va quedar derogada (amb algunes excepcions).', 'mossos_a7_tic', (select id from public.topics where slug = 'mossos-a7-tic'), 2, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=83'), 'Guia p. 90, §5', 'La Llei orgànica 3/2018, de 5 de desembre, de protecció de dades personals i garantia dels drets digitals.', null, '7d0d0d2d6db02149875dde970d1b357c013ab868ab86a6ba5f9c502d2120bf42', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '7d0d0d2d6db02149875dde970d1b357c013ab868ab86a6ba5f9c502d2120bf42')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'La Llei orgànica 5/1992.', false), ('B', 'La Llei orgànica 3/2018, de 5 de desembre.', true), ('C', 'La Llei orgànica 15/1999.', false), ('D', 'El Reial decret 1720/2007.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, com es podrien definir les noves alarmes sorgides del conflicte entre l’esfera pública i la privada a causa de les tecnologies de la informació?', 'El debat sobre els límits de la seguretat pública en l’esfera privada origina el que la guia anomena alarmes de disseny.', 'mossos_a7_tic', (select id from public.topics where slug = 'mossos-a7-tic'), 3, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=83'), 'Guia p. 90, §5', 'S’originen unes noves alarmes, que podríem definir com a alarmes de disseny.', null, '4ad955afff447aa51c53343404aa4e9483984457ea903e03f9cf434aff3cf2d0', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '4ad955afff447aa51c53343404aa4e9483984457ea903e03f9cf434aff3cf2d0')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Alarmes socials.', false), ('B', 'Alarmes tècniques.', false), ('C', 'Alarmes ciutadanes.', false), ('D', 'Alarmes de disseny.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, a què fa referència el terme intel·ligència artificial (IA)?', 'La IA permet a les màquines simular capacitats humanes com l’entrenament, l’anàlisi de dades, el reconeixement de patrons o la presa de decisions automatitzades.', 'mossos_a7_tic', (select id from public.topics where slug = 'mossos-a7-tic'), 2, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=83'), 'Guia p. 90, §6.1', 'Aquest terme fa referència al conjunt de tecnologies i sistemes informàtics que permeten a les màquines simular determinades capacitats pròpies de la intel·ligència humana', null, 'adb2117d0a62336194fe9da586dcabbb90626c1115eb17d1029f7959c3193138', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'adb2117d0a62336194fe9da586dcabbb90626c1115eb17d1029f7959c3193138')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Al conjunt de tecnologies i sistemes informàtics que permeten a les màquines simular determinades capacitats pròpies de la intel·ligència humana.', true), ('B', 'A la robotització de les cadenes de producció industrial.', false), ('C', 'A les xarxes socials i la telefonia mòbil.', false), ('D', 'Al conjunt de normes que regulen l’ús d’Internet.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, quins reptes introdueix l’ús de sistemes basats en IA?', 'La IA planteja reptes de supervisió humana, responsabilitat de les decisions i respecte als drets fonamentals (privacitat, no-discriminació…).', 'mossos_a7_tic', (select id from public.topics where slug = 'mossos-a7-tic'), 2, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=83'), 'Guia p. 91, §6.2', 'l’ús de sistemes basats en IA introdueix reptes rellevants pel que fa a la supervisió humana, la responsabilitat sobre les decisions adoptades de manera automatitzada i el respecte als drets fonamentals', null, 'bfe4c7deadb24a8ba5bb41e2671b9a71b04314c2acd67cf2deb63a74de47ed86', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'bfe4c7deadb24a8ba5bb41e2671b9a71b04314c2acd67cf2deb63a74de47ed86')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Només reptes de cost econòmic.', false), ('B', 'La desaparició de la necessitat de seguretat de la informació.', false), ('C', 'Reptes de supervisió humana, de responsabilitat sobre les decisions automatitzades i de respecte als drets fonamentals.', true), ('D', 'La impossibilitat d’usar-los en l’àmbit públic.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
commit;
