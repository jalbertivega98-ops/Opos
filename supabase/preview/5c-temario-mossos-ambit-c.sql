-- Temario Mossos, àmbit C (Guia d'estudi 2026, catalán).
-- Todo entra como BORRADOR (status draft). Nada se publica hasta aprobarlo en el panel.
-- Idempotente: se puede ejecutar más de una vez. Requiere haber ejecutado antes 1-, 2-, 3- y 4-.
begin;
-- Lote mossos-c1-competencies-seguretat-guia-v1 (20 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Guia d''estudi per accedir a la PG-ME, 1a edició, juny de 2026 (convocatòria 46/26), tema C.1, pp. 177-182', 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=177', 'web_oficial'::public.source_kind, 'Generalitat de Catalunya · Mossos d''Esquadra (web oficial de la convocatòria 46/26)', '2026-06-01') on conflict (url) do nothing;
insert into public.topics (slug, title) values ('mossos-c1-competencies-seguretat', 'C.1 Competències de la Generalitat en seguretat') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug = 'mossos-esquadra' and t.slug = 'mossos-c1-competencies-seguretat' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, què designa l’expressió competència en el camp del dret públic?', 'En dret públic, competència és el conjunt de funcions que l’ordenament atribueix a un subjecte públic en una matèria.', 'mossos_c1_competencies_seguretat', (select id from public.topics where slug = 'mossos-c1-competencies-seguretat'), 1, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=177'), 'Guia p. 179, §1', 'el conjunt de funcions que l’ordenament jurídic atribueix a un subjecte públic en una determinada matèria.', null, 'e03f6bff118fb2e084f4b11828d1ce8ba33ac21e56a1d41b7fdc5afcc790894e', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'e03f6bff118fb2e084f4b11828d1ce8ba33ac21e56a1d41b7fdc5afcc790894e')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'La capacitat d’una persona per exercir un ofici.', false), ('B', 'El conjunt de funcions que l’ordenament jurídic atribueix a un subjecte públic en una determinada matèria.', true), ('C', 'La rivalitat entre administracions per gestionar un servei.', false), ('D', 'El conjunt de normes aprovades per un parlament.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, en quin capítol del títol VIII de la CE es determinen les competències exclusives de l’Estat i les que poden assumir les comunitats autònomes?', 'El capítol III del títol VIII de la CE regula les competències de l’Estat i de les comunitats autònomes.', 'mossos_c1_competencies_seguretat', (select id from public.topics where slug = 'mossos-c1-competencies-seguretat'), 2, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=177'), 'Guia p. 179, §2', 'El títol VIII de la Constitució espanyola fa referència a l’organització territorial de l’Estat i en el capítol III es determinen aquelles competències que són exclusives de l’Estat', null, 'b94dd0f77aaf2c097df0567662bbc3d985f505327083cf8f6a95fe58f47705c1', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'b94dd0f77aaf2c097df0567662bbc3d985f505327083cf8f6a95fe58f47705c1')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Capítol I.', false), ('B', 'Capítol II.', false), ('C', 'Capítol III.', true), ('D', 'Capítol IV.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, quina és la norma atributiva de competències a la Generalitat de Catalunya?', 'L’article 149.1 CE atribueix competències a l’Estat; a la Generalitat les atribueix l’Estatut i, excepcionalment, una llei estatal (art. 150.1 i 2 CE).', 'mossos_c1_competencies_seguretat', (select id from public.topics where slug = 'mossos-c1-competencies-seguretat'), 2, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=177'), 'Guia p. 179, §3', 'la norma atributiva de competències a la Generalitat de Catalunya és l’Estatut d’autonomia, encara que excepcionalment podria ser una llei estatal (art. 150.1 i 2 CE).', null, '1325e3682d18656c7f6a20509bf1932030151785580f795f8f6077ffa0474071', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '1325e3682d18656c7f6a20509bf1932030151785580f795f8f6077ffa0474071')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'La Constitució espanyola, a l’article 149.1.', false), ('B', 'La Llei orgànica 2/1986, de forces i cossos de seguretat.', false), ('C', 'Una llei del Parlament de Catalunya.', false), ('D', 'L’Estatut d’autonomia, encara que excepcionalment podria ser una llei estatal.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, quin article de la CE atribueix a l’Estat la competència exclusiva sobre la seguretat pública, sens perjudici que les comunitats autònomes puguin crear policies?', 'L’article 149.1.29 CE atribueix la seguretat pública a l’Estat, però permet que les comunitats autònomes creïn policies segons els estatuts i una llei orgànica.', 'mossos_c1_competencies_seguretat', (select id from public.topics where slug = 'mossos-c1-competencies-seguretat'), 2, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=177'), 'Guia p. 179, §4', 'L’article 149.1.29 de la CE diu que l’Estat té competència exclusiva sobre la seguretat pública, sens perjudici que les comunitats autònomes puguin crear policies', null, '4a4d0d17aa2eb0a0bb69119ed7b5c294bf9f049391698cfb2a3d1b572bbdb2b1', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '4a4d0d17aa2eb0a0bb69119ed7b5c294bf9f049391698cfb2a3d1b572bbdb2b1')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'L’article 149.1.29.', true), ('B', 'L’article 104.', false), ('C', 'L’article 126.', false), ('D', 'L’article 152.1.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, quina disposició de la Llei orgànica 2/1986 fa referència a la policia autònoma de Catalunya?', 'La disposició final segona de la LO 2/1986 es refereix a la policia autònoma de Catalunya, en execució de l’article 150 de la CE.', 'mossos_c1_competencies_seguretat', (select id from public.topics where slug = 'mossos-c1-competencies-seguretat'), 3, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=177'), 'Guia p. 179, §5', 'la Llei orgànica 2/1986 fa referència a la policia autònoma de Catalunya a la disposició final segona', null, 'd48e0e56b4891db7cac16bbb922f602dbc175044eac760f664f81998bb59c53e', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'd48e0e56b4891db7cac16bbb922f602dbc175044eac760f664f81998bb59c53e')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'La disposició addicional primera.', false), ('B', 'La disposició transitòria primera.', false), ('C', 'La disposició final segona.', true), ('D', 'La disposició derogatòria única.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, quina competència té la Generalitat en matèria de protecció civil?', 'La Generalitat té competència exclusiva en protecció civil, inclosos els serveis de prevenció i extinció d’incendis, sens perjudici de les facultats dels governs locals.', 'mossos_c1_competencies_seguretat', (select id from public.topics where slug = 'mossos-c1-competencies-seguretat'), 2, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=177'), 'Guia p. 179, §7', 'Correspon a la Generalitat la competència exclusiva en matèria de protecció civil', null, '0d27bf6e96ee1513b35c7c94b94cf72eb4afd765b73dbc34e95a84bdc7b5f9a2', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '0d27bf6e96ee1513b35c7c94b94cf72eb4afd765b73dbc34e95a84bdc7b5f9a2')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Competència executiva de la legislació estatal.', false), ('B', 'Competència exclusiva, que inclou la direcció i coordinació dels serveis de protecció civil, incloent-hi la prevenció i extinció d’incendis.', true), ('C', 'Competència compartida amb les diputacions provincials.', false), ('D', 'Cap competència, ja que és exclusiva de l’Estat.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, quina competència correspon a la Generalitat en matèria de salvament marítim?', 'En salvament marítim la Generalitat té competència executiva; en seguretat nuclear, participa en l’execució segons convenis.', 'mossos_c1_competencies_seguretat', (select id from public.topics where slug = 'mossos-c1-competencies-seguretat'), 3, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=177'), 'Guia p. 180, §1', 'Correspon a la Generalitat la competència executiva en matèria de salvament marítim, en els termes que determini la legislació de l’Estat.', null, 'b757ec10729e0dbb12f5ee8e075338ef22949685ba5e3d267f2f5d0d59b6ccd6', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'b757ec10729e0dbb12f5ee8e075338ef22949685ba5e3d267f2f5d0d59b6ccd6')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'La competència executiva, en els termes que determini la legislació de l’Estat.', true), ('B', 'La competència exclusiva.', false), ('C', 'La participació en l’execució mitjançant convenis.', false), ('D', 'Cap, perquè correspon a l’Estat íntegrament.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, com participa la Generalitat en matèria de seguretat nuclear?', 'La Generalitat participa en l’execució en seguretat nuclear segons els convenis subscrits i, si escau, les lleis.', 'mossos_c1_competencies_seguretat', (select id from public.topics where slug = 'mossos-c1-competencies-seguretat'), 3, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=177'), 'Guia p. 180, §2', 'La Generalitat participa en l’execució en matèria de seguretat nuclear, en els termes que siguin acordats en els convenis subscrits a aquest efecte i, si s’escau, en les lleis.', null, '58d500b93f30f627a6b3847a6587e1c84e2fd978414865fc2ecbe68c010702de', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '58d500b93f30f627a6b3847a6587e1c84e2fd978414865fc2ecbe68c010702de')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Té la competència exclusiva.', false), ('B', 'Té la competència executiva plena.', false), ('C', 'No hi té cap participació.', false), ('D', 'Participa en l’execució, en els termes acordats en els convenis subscrits i, si s’escau, en les lleis.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, quina condició s’exigeix perquè la competència de la Generalitat en matèria de joc, apostes i casinos sigui exclusiva?', 'La competència és exclusiva si l’activitat s’acompleix exclusivament a Catalunya, incloses les modalitats per mitjans informàtics i telemàtics.', 'mossos_c1_competencies_seguretat', (select id from public.topics where slug = 'mossos-c1-competencies-seguretat'), 2, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=177'), 'Guia p. 180, §3', 'Correspon a la Generalitat la competència exclusiva en matèria de joc, apostes i casinos, si l’activitat s’acompleix exclusivament a Catalunya', null, '237e0cf3b2ac127869df3b58ffe0fe13ecd1125e38bbf86cec9a18091d3c1d36', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '237e0cf3b2ac127869df3b58ffe0fe13ecd1125e38bbf86cec9a18091d3c1d36')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Que l’activitat la faci una empresa amb seu a Catalunya.', false), ('B', 'Que l’activitat no es faci per mitjans telemàtics.', false), ('C', 'Que ho autoritzi la Comissió Bilateral Generalitat-Estat.', false), ('D', 'Que l’activitat s’acompleixi exclusivament a Catalunya.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, què requereix l’autorització de noves modalitats de joc i apostes d’àmbit estatal?', 'Les noves modalitats estatals de joc requereixen deliberació a la Comissió Bilateral i informe previ determinant de la Generalitat.', 'mossos_c1_competencies_seguretat', (select id from public.topics where slug = 'mossos-c1-competencies-seguretat'), 3, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=177'), 'Guia p. 180, §4', 'L’autorització de noves modalitats de joc i apostes d’àmbit estatal, o bé la modificació de les existents, requereix la deliberació a la Comissió Bilateral Generalitat-Estat que estableix el títol V i l’informe previ determinant de la Generalitat.', null, 'f44fb89d19a41c912e2f04d82ff2233aedfe5db0e94cc8d82ef4e219dd1c3881', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'f44fb89d19a41c912e2f04d82ff2233aedfe5db0e94cc8d82ef4e219dd1c3881')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'L’aprovació del Parlament de Catalunya.', false), ('B', 'La deliberació a la Comissió Bilateral Generalitat-Estat i l’informe previ determinant de la Generalitat.', true), ('C', 'L’autorització de la Junta de Seguretat de Catalunya.', false), ('D', 'Únicament una resolució del Ministeri de l’Interior.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, què inclou la competència exclusiva de la Generalitat en matèria d’espectacles i activitats recreatives?', 'La competència exclusiva inclou l’ordenació del sector, la intervenció administrativa i el control de tota mena d’espectacles en espais i locals públics.', 'mossos_c1_competencies_seguretat', (select id from public.topics where slug = 'mossos-c1-competencies-seguretat'), 2, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=177'), 'Guia p. 180, §5', 'que inclou, en tot cas, l’ordenació del sector, el règim d’intervenció administrativa i el control de tota mena d’espectacles en espais i locals públics.', null, 'd315104857bf80591f3d185f91b30793fe3781b1cd441cb7865558f2e84dd3d6', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'd315104857bf80591f3d185f91b30793fe3781b1cd441cb7865558f2e84dd3d6')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Només l’autorització d’espectacles taurins.', false), ('B', 'Només la seguretat dels espectacles esportius.', false), ('C', 'L’ordenació del sector, el règim d’intervenció administrativa i el control de tota mena d’espectacles en espais i locals públics.', true), ('D', 'La regulació fiscal dels espectacles d’àmbit estatal.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, quin tipus de competència té la Generalitat en matèria de seguretat privada?', 'En seguretat privada correspon a la Generalitat l’execució de la legislació estatal (autorització d’empreses, inspecció i sanció, centres de formació i coordinació).', 'mossos_c1_competencies_seguretat', (select id from public.topics where slug = 'mossos-c1-competencies-seguretat'), 2, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=177'), 'Guia p. 180, §6', 'Correspon a la Generalitat l’execució de la legislació de l’Estat en les matèries següents:', null, '24a1c9fc22ac1bd6c365fcd8a4dc4dc5771509ed6a65a7e3b10339bcba03828e', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '24a1c9fc22ac1bd6c365fcd8a4dc4dc5771509ed6a65a7e3b10339bcba03828e')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'L’execució de la legislació de l’Estat.', true), ('B', 'Competència exclusiva legislativa.', false), ('C', 'Competència compartida amb els ajuntaments.', false), ('D', 'Cap competència.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, quines empreses de seguretat privada pot autoritzar la Generalitat?', 'La Generalitat autoritza les empreses amb domicili social a Catalunya i àmbit d’actuació limitat a Catalunya.', 'mossos_c1_competencies_seguretat', (select id from public.topics where slug = 'mossos-c1-competencies-seguretat'), 3, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=177'), 'Guia p. 180, §6', 'a) L’autorització de les empreses de seguretat privada que tenen llur domicili social a Catalunya i l’àmbit d’actuació de les quals no ultrapassa el territori de Catalunya.', null, '805c59397786abcac4e3840da18ad9ecef4e27c206515d747421c967d7c1e596', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '805c59397786abcac4e3840da18ad9ecef4e27c206515d747421c967d7c1e596')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Totes les que actuen a Catalunya, tinguin el domicili on el tinguin.', false), ('B', 'Només les que es dediquen al transport de fons.', false), ('C', 'Les que tenen el domicili social a Catalunya, encara que actuïn a tot l’Estat.', false), ('D', 'Les que tenen el domicili social a Catalunya i el seu àmbit d’actuació no ultrapassa el territori de Catalunya.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, quin article de l’Estatut d’autonomia de Catalunya regula les competències de la Generalitat en matèria de seguretat pública?', 'L’article 164 de l’EAC regula la seguretat pública: planificació del sistema, creació de la PG-ME i control i vigilància del trànsit, entre altres.', 'mossos_c1_competencies_seguretat', (select id from public.topics where slug = 'mossos-c1-competencies-seguretat'), 2, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=177'), 'Guia p. 180, §7', 'L’article 164 de l’Estatut d’autonomia de Catalunya estableix que en matèria de seguretat pública, d’acord amb el que disposa la legislació estatal, correspon a la Generalitat:', null, 'd861f4b2c2eb4a3d554e366ccfc03a4ddaf21eb5f3b7d26b386e96c963bd4e75', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'd861f4b2c2eb4a3d554e366ccfc03a4ddaf21eb5f3b7d26b386e96c963bd4e75')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'L’article 164.', true), ('B', 'L’article 90.', false), ('C', 'L’article 150.', false), ('D', 'L’article 185.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, quina d’aquestes facultats executives correspon en tot cas a la Generalitat, en el marc de la legislació estatal sobre seguretat?', 'Correspon a la Generalitat, en tot cas, l’exercici de les funcions governatives sobre els drets de reunió i manifestació i el compliment de les disposicions per conservar la natura, el medi ambient i els recursos hidrològics.', 'mossos_c1_competencies_seguretat', (select id from public.topics where slug = 'mossos-c1-competencies-seguretat'), 3, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=177'), 'Guia p. 181, §1', 'a) Les funcions governatives sobre l’exercici dels drets de reunió i manifestació.', null, '34833ceab9d9ea0719469c01bfac0020a8b1a62f93108d2d0e289d179e37a90b', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '34833ceab9d9ea0719469c01bfac0020a8b1a62f93108d2d0e289d179e37a90b')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'L’expedició del DNI i del passaport.', false), ('B', 'Les funcions governatives sobre l’exercici dels drets de reunió i manifestació.', true), ('C', 'El control de fronteres exteriors.', false), ('D', 'La matriculació de vehicles.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, en quins àmbits exerceix totes les funcions pròpies d’un cos de policia la Policia de la Generalitat - Mossos d’Esquadra?', 'La PG-ME actua a tot Catalunya en seguretat ciutadana i ordre públic, policia administrativa i policia judicial i investigació criminal (inclosos crim organitzat i terrorisme).', 'mossos_c1_competencies_seguretat', (select id from public.topics where slug = 'mossos-c1-competencies-seguretat'), 2, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=177'), 'Guia p. 181, §3', 'a) La seguretat ciutadana i l’ordre públic. b) La policia administrativa, que inclou la que deriva de la normativa estatal. c) La policia judicial i la investigació criminal', null, '3e95a13a39a227a795263ef55e4a09ff7e346ab3e418057f70a3e518e3eb7a64', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '3e95a13a39a227a795263ef55e4a09ff7e346ab3e418057f70a3e518e3eb7a64')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Només en seguretat ciutadana i trànsit.', false), ('B', 'En seguretat ciutadana, control de fronteres i duanes.', false), ('C', 'En seguretat ciutadana i ordre públic, policia administrativa i policia judicial i investigació criminal.', true), ('D', 'Només en policia administrativa i protecció civil.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, quina llei orgànica va transferir a la Generalitat les competències executives en matèria de trànsit i circulació de vehicles de motor?', 'La LO 6/1997 va transferir les competències executives de trànsit, llevat de permisos de conduir, exàmens i matriculació.', 'mossos_c1_competencies_seguretat', (select id from public.topics where slug = 'mossos-c1-competencies-seguretat'), 3, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=177'), 'Guia p. 181, §4', 'mitjançant la Llei orgànica 6/1997, de 15 de desembre, l’Estat va transferir a la Generalitat les competències executives en matèria de trànsit i circulació de vehicles de motor', null, '9f976183370ef89d85a1866ed7331b7f87906d8b0821292e956ceeffb2961993', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '9f976183370ef89d85a1866ed7331b7f87906d8b0821292e956ceeffb2961993')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'La Llei orgànica 2/1986, de 13 de març.', false), ('B', 'La Llei orgànica 6/1997, de 15 de desembre.', true), ('C', 'La Llei orgànica 4/2015, de 30 de març.', false), ('D', 'La Llei orgànica 6/2006, de 19 de juliol.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, quina d’aquestes matèries va quedar exclosa de la transferència de competències executives en trànsit feta per la Llei orgànica 6/1997?', 'En van quedar excloses els permisos i llicències de conduir, l’examen per obtenir-los i la matriculació i expedició de permisos de circulació.', 'mossos_c1_competencies_seguretat', (select id from public.topics where slug = 'mossos-c1-competencies-seguretat'), 3, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=177'), 'Guia p. 181, §4', 'llevat del que fa referència a permisos i llicències per conduir, examen per a l’obtenció del permís de conduir i matriculació i expedició de permisos o llicències de circulació.', null, '9888f12547d87628226f92a7b577010043d8b25fd0347a439b410f7e8236b9ae', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '9888f12547d87628226f92a7b577010043d8b25fd0347a439b410f7e8236b9ae')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'La vigilància del trànsit a les carreteres.', false), ('B', 'La denúncia d’infraccions de trànsit.', false), ('C', 'La matriculació i l’expedició de permisos o llicències de circulació.', true), ('D', 'La regulació del trànsit en vies interurbanes.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, quina llei va crear el Servei Català de Trànsit com a organisme autònom?', 'El Servei Català de Trànsit es va crear per la Llei 14/1997, arran de la transferència de les competències de trànsit.', 'mossos_c1_competencies_seguretat', (select id from public.topics where slug = 'mossos-c1-competencies-seguretat'), 2, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=177'), 'Guia p. 181, §5', 'Mitjançant la Llei 14/1997, de 24 de desembre, es va crear un organisme autònom denominat Servei Català de Trànsit.', null, '0093cbca151a8c0a9491c05ec8e355a3b45627e03ade1fbdf7df35a8dd0825e6', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '0093cbca151a8c0a9491c05ec8e355a3b45627e03ade1fbdf7df35a8dd0825e6')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'La Llei 10/1994, d’11 de juliol.', false), ('B', 'La Llei 4/2003, de 7 d’abril.', false), ('C', 'La Llei 16/1991, de 10 de juliol.', false), ('D', 'La Llei 14/1997, de 24 de desembre.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, quin caràcter tenen actualment el control i la vigilància del trànsit per a la Generalitat, d’acord amb l’Estatut d’autonomia?', 'L’Estatut actual configura el control i la vigilància del trànsit com a competències pròpies (art. 164.1), que deixen de ser delegades.', 'mossos_c1_competencies_seguretat', (select id from public.topics where slug = 'mossos-c1-competencies-seguretat'), 3, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=177'), 'Guia p. 181, §6', 'l’actual Estatut d’autonomia de Catalunya disposa que el control i la vigilància del trànsit són competències pròpies de la Generalitat, i deixen de ser competències delegades', null, 'ec11dcb80ca365b77a660a0117dc41f9be737f848de0a262ba118c64f507055d', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'ec11dcb80ca365b77a660a0117dc41f9be737f848de0a262ba118c64f507055d')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Són competències pròpies de la Generalitat.', true), ('B', 'Són competències delegades per l’Estat.', false), ('C', 'Són competències compartides amb la Guàrdia Civil.', false), ('D', 'Són competències dels ajuntaments.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
-- Lote mossos-c2-departament-interior-guia-v1 (20 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Guia d''estudi per accedir a la PG-ME, 1a edició, juny de 2026 (convocatòria 46/26), tema C.2, pp. 183-204', 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=183', 'web_oficial'::public.source_kind, 'Generalitat de Catalunya · Mossos d''Esquadra (web oficial de la convocatòria 46/26)', '2026-06-01') on conflict (url) do nothing;
insert into public.topics (slug, title) values ('mossos-c2-departament-interior', 'C.2 Departament d''Interior i Seguretat Pública') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug = 'mossos-esquadra' and t.slug = 'mossos-c2-departament-interior' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, quin decret recull les funcions genèriques del Departament d’Interior i Seguretat Pública?', 'El Decret 133/2024 determina l’àmbit de competència dels departaments; el 12/2023 reestructura el Departament, el 57/2023 la Direcció General de la Policia i el 240/2024 l’ISPC.', 'mossos_c2_departament_interior', (select id from public.topics where slug = 'mossos-c2-departament-interior'), 2, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=183'), 'Guia p. 184, §1', 'Les funcions genèriques del Departament d’Interior i Seguretat Pública de la Generalitat de Catalunya es recullen en el Decret 133/2024, d’11 d’agost', null, '896919d8d8d9c5cd97031a78518ccee4fe80524b7d3489e8a43a7133a8c7d777', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '896919d8d8d9c5cd97031a78518ccee4fe80524b7d3489e8a43a7133a8c7d777')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El Decret 12/2023, de 24 de gener.', false), ('B', 'El Decret 57/2023, de 21 de març.', false), ('C', 'El Decret 133/2024, d’11 d’agost.', true), ('D', 'El Decret 240/2024, de 4 de novembre.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, quin decret recull les funcions i l’estructura actuals de la Direcció General de la Policia?', 'L’estructura actual de la DGP la recull el Decret 57/2023; el Decret 415/2011 va crear la Prefectura de la Policia.', 'mossos_c2_departament_interior', (select id from public.topics where slug = 'mossos-c2-departament-interior'), 2, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=183'), 'Guia p. 185, §1', 'El Decret 57/2023, de 21 de març, de reestructuració de la Direcció General de la Policia, en recull les funcions i l’estructura actuals.', null, '20b50f4d5f36a732470766fe17d065276858367bf84ac200b2d073b6fe7b0da6', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '20b50f4d5f36a732470766fe17d065276858367bf84ac200b2d073b6fe7b0da6')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El Decret 415/2011, de 13 de desembre.', false), ('B', 'El Decret 19/2002, de 22 de gener.', false), ('C', 'El Decret 64/2005, de 19 d’abril.', false), ('D', 'El Decret 57/2023, de 21 de març.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, en quina data el capità general de Catalunya crea el cos de Mossos d’Esquadra?', 'El cos es crea el 21 d’abril de 1719; el 8 de juny de 1719 s’aprova el primer Reglament de les Esquadres.', 'mossos_c2_departament_interior', (select id from public.topics where slug = 'mossos-c2-departament-interior'), 1, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=183'), 'Guia p. 186, §1', 'el 21 d’abril de 1719, el capità general de Catalunya crea el cos de Mossos d’Esquadra, amb la finalitat de mantenir l’ordre públic, en substitució de la institució catalana del sometent', null, '64e0242b7b2c02ff25f2a6757da9defe1ddf81c70350f355161906e7a8611074', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '64e0242b7b2c02ff25f2a6757da9defe1ddf81c70350f355161906e7a8611074')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El 21 d’abril de 1719.', true), ('B', 'L’11 de setembre de 1714.', false), ('C', 'El 8 de juny de 1719.', false), ('D', 'El 24 de desembre de 1721.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, de quina institució depenien en els seus orígens els Mossos d’Esquadra com a força de policia judicial?', 'En els seus orígens era un institut armat de naturalesa civil, amb doble dependència, que depenia de la Reial Audiència com a policia judicial.', 'mossos_c2_departament_interior', (select id from public.topics where slug = 'mossos-c2-departament-interior'), 2, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=183'), 'Guia p. 186, §3', 'Depèn de la Reial Audiència del Principat de Catalunya, com a força de policia judicial.', null, '59dedffec74e6ac5a2acc965330799534051934b88f48379a91b12d2915bf9a6', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '59dedffec74e6ac5a2acc965330799534051934b88f48379a91b12d2915bf9a6')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Del Consell de Cent.', false), ('B', 'De la Reial Audiència del Principat de Catalunya.', true), ('C', 'De la Diputació del General.', false), ('D', 'De la Capitania General de Madrid.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, quant de temps va estar la família Veciana al capdavant dels Mossos d’Esquadra fins que hi va renunciar el 1836?', 'L’any 1836 la família Veciana renuncia al comandament, després de 115 anys ininterromputs.', 'mossos_c2_departament_interior', (select id from public.topics where slug = 'mossos-c2-departament-interior'), 3, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=183'), 'Guia p. 186, §6', 'L’any 1836, la família Veciana renuncia al comandament dels Mossos d’Esquadra, després de 115 anys al capdavant del cos ininterrompudament.', null, '7556d4e25f7de32ed4e652a00cb4212c38d628f888dc80318641203e57ee541d', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '7556d4e25f7de32ed4e652a00cb4212c38d628f888dc80318641203e57ee541d')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', '50 anys.', false), ('B', '85 anys.', false), ('C', '115 anys.', true), ('D', '150 anys.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, qui va abolir el cos de Mossos d’Esquadra l’any 1868?', 'El 1868 el general Prim va abolir el cos per considerar que tenia adscripció monàrquica, i el va substituir per la Guàrdia Civil.', 'mossos_c2_departament_interior', (select id from public.topics where slug = 'mossos-c2-departament-interior'), 2, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=183'), 'Guia p. 186, §7', 'l’any 1868 va ser abolit per ordre del mateix general Prim, en considerar que els Mossos d’Esquadra tenien una adscripció monàrquica.', null, 'c4f7c8b49748a98f2e10ddea55878f55ccd6e394366136dc3406ae8b432168a8', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'c4f7c8b49748a98f2e10ddea55878f55ccd6e394366136dc3406ae8b432168a8')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El general Primo de Rivera.', false), ('B', 'La reina Isabel II.', false), ('C', 'El capità general de Catalunya.', false), ('D', 'El general Prim.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, qui va signar el 14 d’octubre de 1932 el decret de desplegament del cos de Mossos d’Esquadra a tot el territori català?', 'Francesc Macià va signar el decret de desplegament el 14 d’octubre de 1932; els fets d’octubre de 1934 van impedir que es fes efectiu.', 'mossos_c2_departament_interior', (select id from public.topics where slug = 'mossos-c2-departament-interior'), 2, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=183'), 'Guia p. 187, §5', 'El 14 d’octubre de 1932, el president de la Generalitat de Catalunya, Francesc Macià, va signar el decret de desplegament del cos de Mossos d’Esquadra a tot el territori català.', null, 'ed1d1be5af85b9365e82995bf7305e297f68233879614be5ec9302b52c3ed46c', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'ed1d1be5af85b9365e82995bf7305e297f68233879614be5ec9302b52c3ed46c')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El president Lluís Companys.', false), ('B', 'El president Francesc Macià.', true), ('C', 'El president Josep Tarradellas.', false), ('D', 'El president Enric Prat de la Riba.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, de quants efectius estava constituïda la Sección de Mozos de Escuadra autoritzada a la Diputació de Barcelona el 1950?', 'La secció tenia 40 efectius i va començar a prestar servei el dia de Sant Jordi de 1952; el 1961 en tenia 50.', 'mossos_c2_departament_interior', (select id from public.topics where slug = 'mossos-c2-departament-interior'), 3, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=183'), 'Guia p. 188, §2', 'Aquesta estava constituïda per 40 efectius i va començar a prestar servei el dia de Sant Jordi de 1952, a la seu de la Diputació.', null, 'a1f1c8ec3f21c9cd59fc80f4988792cf197f74dd37d1583e868fc6c8634e1cfe', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'a1f1c8ec3f21c9cd59fc80f4988792cf197f74dd37d1583e868fc6c8634e1cfe')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', '40 efectius.', true), ('B', '20 efectius.', false), ('C', '100 efectius.', false), ('D', '182 efectius.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, quin dia s’estableix com a Dia de les Esquadres d’acord amb el Decret 64/2005?', 'El Dia de les Esquadres era el 21 d’abril des de 1976; el Decret 64/2005 el va traslladar al 22 d’abril.', 'mossos_c2_departament_interior', (select id from public.topics where slug = 'mossos-c2-departament-interior'), 2, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=183'), 'Guia p. 188, §4', 'Aquesta data va ser modificada recentment mitjançant el Decret 64/2005, de 19 d’abril, en què s’estableix el dia 22 d’abril com el Dia de les Esquadres.', null, '8ed18c8f437d5c5fa56c22cc2ce2ff46feabf17df4fbb5616bf4af0dddd47ea7', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '8ed18c8f437d5c5fa56c22cc2ce2ff46feabf17df4fbb5616bf4af0dddd47ea7')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El 21 d’abril.', false), ('B', 'El 22 d’abril.', true), ('C', 'El 23 d’abril.', false), ('D', 'El 14 d’octubre.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, quina llei crea el 1983 la Policia Autonòmica de la Generalitat de Catalunya?', 'La Llei 19/1983 crea la Policia Autonòmica, que absorbeix l’històric cos de Mossos d’Esquadra i n’adopta el nom i els efectius.', 'mossos_c2_departament_interior', (select id from public.topics where slug = 'mossos-c2-departament-interior'), 3, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=183'), 'Guia p. 188, §6', 'El 1983, amb la Llei 19/1983, de 14 de juliol, es crea la Policia Autonòmica de la Generalitat de Catalunya.', null, '4a8748e34dd7b162267262fd547c88eef754933172c69680277f6ccc828e8ade', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '4a8748e34dd7b162267262fd547c88eef754933172c69680277f6ccc828e8ade')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'La Llei 10/1994, d’11 de juliol.', false), ('B', 'La Llei 16/1991, de 10 de juliol.', false), ('C', 'La Llei 19/1983, de 14 de juliol.', true), ('D', 'La Llei orgànica 2/1986, de 13 de març.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, què va passar l’any 1985 en relació amb l’accés al cos de Mossos d’Esquadra?', 'El 1985 es convoca la segona promoció, la primera amb accés de dones, i es crea l’Escola de Policia de Catalunya a Mollet del Vallès.', 'mossos_c2_departament_interior', (select id from public.topics where slug = 'mossos-c2-departament-interior'), 2, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=183'), 'Guia p. 189, §4', 'Es convoca la segona promoció dels Mossos d’Esquadra –és el primer cop que es permet l’accés al cos per a les dones–', null, '3ff998e0dee0fa3ed448001d29865c5c8853d2107ffa9f915f39b8bb626b004c', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '3ff998e0dee0fa3ed448001d29865c5c8853d2107ffa9f915f39b8bb626b004c')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Es va convocar la segona promoció i per primer cop es va permetre l’accés de les dones.', true), ('B', 'Es va convocar la primera promoció del cos.', false), ('C', 'Es va aprovar la Llei de la Policia de la Generalitat.', false), ('D', 'Es va iniciar el desplegament a Osona.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, quina resolució del Parlament de Catalunya de 1985 posa la primera pedra del model policial català?', 'Amb la Resolució 39/II, totes les forces polítiques declaren la voluntat que la PG-ME substitueixi les FCSE a Catalunya.', 'mossos_c2_departament_interior', (select id from public.topics where slug = 'mossos-c2-departament-interior'), 3, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=183'), 'Guia p. 189, §4', 'el Parlament de Catalunya aprova la Resolució 39/II, que posa la primera pedra del que després s’anomenarà el model policial català.', null, '1b43322d0f4e21c549acc108a56ea56c7a4c55bd183d2088b9e1e732144f905d', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '1b43322d0f4e21c549acc108a56ea56c7a4c55bd183d2088b9e1e732144f905d')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'La Resolució 1/I.', false), ('B', 'La Resolució 10/III.', false), ('C', 'La Resolució 25/IV.', false), ('D', 'La Resolució 39/II.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, quines competències adquireixen els Mossos d’Esquadra a partir de l’any 1990?', 'El 1990 es delimiten funcions i s’adquireixen el trasllat de presos i el tractament policial dels menors d’edat penal i civil.', 'mossos_c2_departament_interior', (select id from public.topics where slug = 'mossos-c2-departament-interior'), 3, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=183'), 'Guia p. 189, §6', 's’adquireixen les primeres competències en seguretat en un període llarg de temps: el trasllat de presos i el tractament policial dels menors d’edat penal (entre 14 i 18 anys)', null, '5855c0cf22033728a15de205636f4a9d8aaf4b3f130135ca6d7e2a3aae5124a3', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '5855c0cf22033728a15de205636f4a9d8aaf4b3f130135ca6d7e2a3aae5124a3')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'La seguretat ciutadana a la ciutat de Barcelona.', false), ('B', 'El trasllat de presos i el tractament policial dels menors.', true), ('C', 'La vigilància del trànsit a tot Catalunya.', false), ('D', 'La investigació del terrorisme.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, a quina comarca es va fer el primer desplegament de substitució de les forces i cossos de seguretat de l’Estat?', 'La Junta de Seguretat de 17 d’octubre de 1994 acorda el primer desplegament a Osona (4 de desembre), seguit de la Selva i el Ripollès el 1995.', 'mossos_c2_departament_interior', (select id from public.topics where slug = 'mossos-c2-departament-interior'), 2, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=183'), 'Guia p. 189, §8', 'També s’acorda el primer desplegament de substitució de les forces i cossos de seguretat de l’Estat, en matèria de seguretat ciutadana, ordre públic i investigació, per al 4 de desembre a la comarca d’Osona', null, 'aa5103d595417e24fbcf33efa8625182b7515a818766728666a3cb84ebc6de6d', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'aa5103d595417e24fbcf33efa8625182b7515a818766728666a3cb84ebc6de6d')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Al Barcelonès.', false), ('B', 'A la Selva.', false), ('C', 'Al Gironès.', false), ('D', 'A Osona.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, en quina data els agents de la PG-ME comencen a patrullar per primera vegada a Barcelona, dins del dispositiu Turisme?', 'El 27 de juny de 2004 comencen a patrullar a Barcelona amb el dispositiu Turisme; el desplegament de substitució a la ciutat s’inicia l’any següent.', 'mossos_c2_departament_interior', (select id from public.topics where slug = 'mossos-c2-departament-interior'), 2, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=183'), 'Guia p. 190, §6', 'El 27 de juny de 2004, agents de la Policia de la Generalitat - Mossos d’Esquadra comencen a patrullar per primera vegada a Barcelona', null, '6d1f1dc00683b9a660879ea04a22103636bb9d7083e85d915966605f22b24558', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '6d1f1dc00683b9a660879ea04a22103636bb9d7083e85d915966605f22b24558')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'L’1 de novembre de 2005.', false), ('B', 'El 4 de desembre de 1994.', false), ('C', 'El 27 de juny de 2004.', true), ('D', 'El novembre de 2008.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, quines comarques conclouen el desplegament territorial de la PG-ME el novembre de 2008?', 'El desplegament territorial conclou el novembre de 2008 amb el Camp de Tarragona i les Terres de l’Ebre.', 'mossos_c2_departament_interior', (select id from public.topics where slug = 'mossos-c2-departament-interior'), 2, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=183'), 'Guia p. 190, §6', 'Les comarques del Camp de Tarragona i de les Terres de l’Ebre conclouen el desplegament territorial el novembre de 2008.', null, 'a90e62b88db4fc9fcb03865749aa67d096ec9c860190a8deb47ba3e67dc31f55', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'a90e62b88db4fc9fcb03865749aa67d096ec9c860190a8deb47ba3e67dc31f55')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Les del Camp de Tarragona i de les Terres de l’Ebre.', true), ('B', 'Les del Pirineu.', false), ('C', 'Les de l’Àrea Metropolitana de Barcelona.', false), ('D', 'Les de les comarques gironines.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, en quin municipi està situat el Complex Central de la PG-ME?', 'El Complex Central, a ple rendiment des d’octubre de 2009, és a Sabadell i acull els serveis centrals i especialitzats.', 'mossos_c2_departament_interior', (select id from public.topics where slug = 'mossos-c2-departament-interior'), 2, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=183'), 'Guia p. 192, §4', 'És un conjunt d’edificis situat al municipi de Sabadell que acull els serveis centrals i els recursos operatius especialitzats', null, '4e8522d910eb0c27dbf05e6e28ed6e60578f5a2abd6a45b797cb8a980346b89b', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '4e8522d910eb0c27dbf05e6e28ed6e60578f5a2abd6a45b797cb8a980346b89b')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Barcelona.', false), ('B', 'Sabadell.', true), ('C', 'Mollet del Vallès.', false), ('D', 'Sant Cugat del Vallès.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, fins a quin nombre màxim d’efectius va acordar ampliar el cos de Mossos d’Esquadra la Junta de Seguretat de Catalunya el 5 de novembre de 2021?', 'La Junta de Seguretat de 5 de novembre de 2021 va ampliar el nombre màxim d’efectius a 22.006.', 'mossos_c2_departament_interior', (select id from public.topics where slug = 'mossos-c2-departament-interior'), 3, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=183'), 'Guia p. 193, §1', 'la Junta de Seguretat de Catalunya acorda, el 5 de novembre de 2021, ampliar el nombre màxim d’efectius del cos de Mossos d’Esquadra a 22.006.', null, '2be7b1f75682c49af4b7d825d18062dcc4f7c620a67f06601b54630499df48e2', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '2be7b1f75682c49af4b7d825d18062dcc4f7c620a67f06601b54630499df48e2')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', '22.006.', true), ('B', '17.000.', false), ('C', '20.000.', false), ('D', '25.000.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, quina llei va crear l’Institut de Seguretat Pública de Catalunya?', 'L’ISPC es va crear per la Llei 10/2007; la Llei 9/2007, de la mateixa data, regula el Centre 112.', 'mossos_c2_departament_interior', (select id from public.topics where slug = 'mossos-c2-departament-interior'), 2, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=183'), 'Guia p. 197, §3', 'Per la Llei 10/2007, de 30 de juliol, es va crear l’Institut de Seguretat Pública de Catalunya com a entitat autònoma de caràcter administratiu', null, 'aa93af7d6509bb58a82cae86f2f1f4c5bd3f3999dae533814f748db73cd78805', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'aa93af7d6509bb58a82cae86f2f1f4c5bd3f3999dae533814f748db73cd78805')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'La Llei 4/2003, de 7 d’abril.', false), ('B', 'La Llei 9/2007, de 30 de juliol.', false), ('C', 'La Llei 14/1997, de 24 de desembre.', false), ('D', 'La Llei 10/2007, de 30 de juliol.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, a partir de quina data van deixar d’estar actius els números 085 (Bombers) i 088 (Mossos d’Esquadra)?', 'Amb la integració progressiva al 112, els números 085 i 088 van deixar d’estar actius el 30 de setembre de 2012.', 'mossos_c2_departament_interior', (select id from public.topics where slug = 'mossos-c2-departament-interior'), 2, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=183'), 'Guia p. 201, §2', 'Els números de telèfon del cos de Bombers de la Generalitat (085) i de la Policia de la Generalitat - Mossos d’Esquadra (088) van deixar d’estar actius a partir del 30 de setembre de 2012.', null, '6723a6dfe6308415cfa8b7e43abaa2885cb20ba274b03ec15ff8e530ffc5cccd', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '6723a6dfe6308415cfa8b7e43abaa2885cb20ba274b03ec15ff8e530ffc5cccd')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'L’1 de gener de 2008.', false), ('B', 'El 30 de juliol de 2007.', false), ('C', 'El 30 de setembre de 2012.', true), ('D', 'El 3 de febrer de 2023.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
-- Lote mossos-c3-coordinacio-policial-guia-v1 (20 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Guia d''estudi per accedir a la PG-ME, 1a edició, juny de 2026 (convocatòria 46/26), tema C.3, pp. 205-222', 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=205', 'web_oficial'::public.source_kind, 'Generalitat de Catalunya · Mossos d''Esquadra (web oficial de la convocatòria 46/26)', '2026-06-01') on conflict (url) do nothing;
insert into public.topics (slug, title) values ('mossos-c3-coordinacio-policial', 'C.3 La coordinació policial') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug = 'mossos-esquadra' and t.slug = 'mossos-c3-coordinacio-policial' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, què és un sistema de seguretat pública?', 'El sistema de seguretat pública agrupa administracions, òrgans, autoritats i serveis i preveu l’intercanvi d’informació i l’homogeneïtzació de mitjans.', 'mossos_c3_coordinacio_policial', (select id from public.topics where slug = 'mossos-c3-coordinacio-policial'), 2, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=205'), 'Guia p. 206, §2', 'Un sistema de seguretat pública és el conjunt d’administracions, òrgans, autoritats i serveis que contribueixen a garantir la llibertat i la seguretat dels ciutadans i l’ordre públic.', null, '999fd0337f990a1eb7fc40372bb67cb355768ef934ff935a2423a14f536f6a35', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '999fd0337f990a1eb7fc40372bb67cb355768ef934ff935a2423a14f536f6a35')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El conjunt de cossos policials d’un mateix territori.', false), ('B', 'L’òrgan que coordina les policies locals d’una comarca.', false), ('C', 'El conjunt d’administracions, òrgans, autoritats i serveis que contribueixen a garantir la llibertat i la seguretat dels ciutadans i l’ordre públic.', true), ('D', 'El pla quadriennal aprovat pel Govern en matèria de seguretat.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, quins principis proclama l’article 3 de la Llei orgànica 2/1986, de forces i cossos de seguretat?', 'L’article 3 de la LO 2/1986 proclama la cooperació recíproca i la coordinació orgànica.', 'mossos_c3_coordinacio_policial', (select id from public.topics where slug = 'mossos-c3-coordinacio-policial'), 3, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=205'), 'Guia p. 206, §7', 'L’article 3 de la Llei orgànica 2/1986, de forces i cossos de seguretat, proclama el principi de cooperació recíproca i el de coordinació orgànica.', null, '2c4b4c4197064d351e1cce85f9cf44f48214bbf5a323aca1b5d6de44ab86425e', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '2c4b4c4197064d351e1cce85f9cf44f48214bbf5a323aca1b5d6de44ab86425e')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Els principis de cooperació recíproca i de coordinació orgànica.', true), ('B', 'Els principis de jerarquia i subordinació.', false), ('C', 'Els principis de proximitat i descentralització.', false), ('D', 'Els principis d’exclusivitat i unitat.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, a qui correspon prioritàriament vigilar espais públics, protegir manifestacions i mantenir l’ordre en grans concentracions humanes, com a funció en col·laboració amb les FCSE?', 'L’exercici d’aquesta funció correspon prioritàriament a les policies autonòmiques, sens perjudici de la intervenció de les FCSE.', 'mossos_c3_coordinacio_policial', (select id from public.topics where slug = 'mossos-c3-coordinacio-policial'), 3, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=205'), 'Guia p. 207, §1', 'L’exercici d’aquesta funció correspon prioritàriament a les policies autonòmiques, sense perjudici de la intervenció de les FCSE', null, '41ca9b08bbd8c835af4a1c0d163a6ffef148bad1428fbd55924185d7f1d2fda4', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '41ca9b08bbd8c835af4a1c0d163a6ffef148bad1428fbd55924185d7f1d2fda4')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'A la Guàrdia Civil.', false), ('B', 'A les policies autonòmiques.', true), ('C', 'A les policies locals.', false), ('D', 'A la Policia Nacional.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, en quines condicions intervé la policia local en la protecció de manifestacions i el manteniment de l’ordre en grans concentracions humanes?', 'La policia local hi intervé només a requeriment previ i com a col·laboradora de les FCSE i de les policies autonòmiques.', 'mossos_c3_coordinacio_policial', (select id from public.topics where slug = 'mossos-c3-coordinacio-policial'), 3, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=205'), 'Guia p. 207, §2', 'ho fa únicament a requeriment previ i a títol de col·laboradora amb les FCSE i amb les policies autonòmiques.', null, 'ab5b1c299fd32922fc155c6c6194d808e9745ae69799fef5b02f6496ab84c1a7', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'ab5b1c299fd32922fc155c6c6194d808e9745ae69799fef5b02f6496ab84c1a7')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Com a cos principal i amb caràcter exclusiu.', false), ('B', 'Només si ho autoritza la Junta de Seguretat de Catalunya.', false), ('C', 'Sempre que el municipi tingui més de 50.000 habitants.', false), ('D', 'Únicament a requeriment previ i a títol de col·laboradora amb les FCSE i les policies autonòmiques.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, sota quins principis ha de complir el cos de Mossos d’Esquadra les seves funcions, segons l’article 12.2 de la Llei 10/1994?', 'L’article 12.2 de la Llei 10/1994 estableix els principis de cooperació, coordinació i col·laboració mútua amb la resta de FCS.', 'mossos_c3_coordinacio_policial', (select id from public.topics where slug = 'mossos-c3-coordinacio-policial'), 2, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=205'), 'Guia p. 207, §5', 'totes les funcions que l’ordenament jurídic atribueix al cos de Mossos d’Esquadra s’han de complir sota els principis de cooperació, coordinació i col·laboració mútua amb la resta de FCS.', null, 'aea17bee1ae95d123eed11e12967ee8340e6a41745be9a5652f798cd4c34b14f', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'aea17bee1ae95d123eed11e12967ee8340e6a41745be9a5652f798cd4c34b14f')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Jerarquia, disciplina i obediència.', false), ('B', 'Cooperació, coordinació i col·laboració mútua amb la resta de FCS.', true), ('C', 'Exclusivitat, unitat i especialitat.', false), ('D', 'Proximitat, prevenció i eficàcia.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, com pren els acords la Junta de Seguretat de Catalunya?', 'La Junta de Seguretat, regulada per Resolució de 28 de desembre de 1982, funciona com un òrgan col·legiat i pren els acords per unanimitat.', 'mossos_c3_coordinacio_policial', (select id from public.topics where slug = 'mossos-c3-coordinacio-policial'), 3, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=205'), 'Guia p. 208, §3', 'Funciona com els òrgans col·legiats i pren els acords per unanimitat.', null, 'b722ea14addfed953b5952db20210d59a2003f359d774773ec724b05103d940c', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'b722ea14addfed953b5952db20210d59a2003f359d774773ec724b05103d940c')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Per majoria simple.', false), ('B', 'Per majoria absoluta.', false), ('C', 'Per unanimitat.', true), ('D', 'Per majoria de dues terceres parts.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, quines comissions va crear el Reial decret 769/1987 per harmonitzar la direcció de les forces policials adscrites a la investigació criminal?', 'El RD 769/1987, sobre regulació de la policia judicial, va crear la Comissió Nacional i la Comissió Provincial de Coordinació de la Policia Judicial.', 'mossos_c3_coordinacio_policial', (select id from public.topics where slug = 'mossos-c3-coordinacio-policial'), 3, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=205'), 'Guia p. 209, §1', 'a) Comissió Nacional de Coordinació de la Policia Judicial. b) Comissió Provincial de Coordinació de la Policia Judicial.', null, '5cc52201b0812eaa0781672a1eed3d9d9aeca98f7c56cf8f2a6fa722ab7683cd', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '5cc52201b0812eaa0781672a1eed3d9d9aeca98f7c56cf8f2a6fa722ab7683cd')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'La Comissió Nacional i la Comissió Provincial de Coordinació de la Policia Judicial.', true), ('B', 'La Comissió de Policia de Catalunya i les comissions regionals de seguretat.', false), ('C', 'La Comissió Interdepartamental i l’Observatori de la Seguretat.', false), ('D', 'La Sala de Coordinació Interpolicial i la Mesa de Coordinació Operativa.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, quants municipis de Catalunya tenen cos de policia propi?', 'Dels 947 municipis de Catalunya, 213 tenen cos de policia propi.', 'mossos_c3_coordinacio_policial', (select id from public.topics where slug = 'mossos-c3-coordinacio-policial'), 2, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=205'), 'Guia p. 209, §2', 'Té un total de 947 municipis, dels quals 213 tenen cos de policia propi.', null, 'a66c630ef1bcf84f242cb6e1f40d971e015f0b169280d9539ed76489b3931b33', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'a66c630ef1bcf84f242cb6e1f40d971e015f0b169280d9539ed76489b3931b33')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', '113.', false), ('B', '313.', false), ('C', '947.', false), ('D', '213.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, quina és la manifestació més elevada dels òrgans de coordinació i participació ciutadana del sistema de seguretat pública de Catalunya?', 'El Consell de Seguretat de Catalunya és l’òrgan consultiu i de participació superior en matèria de seguretat.', 'mossos_c3_coordinacio_policial', (select id from public.topics where slug = 'mossos-c3-coordinacio-policial'), 2, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=205'), 'Guia p. 209, §3', 'la manifestació més elevada dels quals la constitueix el Consell de Seguretat de Catalunya.', null, '17ed17010fa8d92e710e315929e13240433761bde3a2671f2224b2727f5fb91f', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '17ed17010fa8d92e710e315929e13240433761bde3a2671f2224b2727f5fb91f')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'La Junta de Seguretat de Catalunya.', false), ('B', 'El Consell de Seguretat de Catalunya.', true), ('C', 'La Comissió del Govern per a la Seguretat.', false), ('D', 'La Junta Local de Seguretat.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, com va ser aprovada pel Parlament de Catalunya la Llei 4/2003, d’ordenació del sistema de seguretat pública de Catalunya?', 'La Llei 4/2003 va ser aprovada per unanimitat pel Parlament de Catalunya.', 'mossos_c3_coordinacio_policial', (select id from public.topics where slug = 'mossos-c3-coordinacio-policial'), 2, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=205'), 'Guia p. 210, §2', 'La Llei 4/2003, de 7 d’abril, d’ordenació del sistema de seguretat pública de Catalunya, que va ser aprovada per unanimitat pel Parlament de Catalunya', null, '7d8302d8cda4d8f2a6cc1e1efe29edeff0390c07b5b04a99a14dae657a2a0b49', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '7d8302d8cda4d8f2a6cc1e1efe29edeff0390c07b5b04a99a14dae657a2a0b49')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Per majoria absoluta.', false), ('B', 'Per majoria simple.', false), ('C', 'Per majoria de tres cinquenes parts.', false), ('D', 'Per unanimitat.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, quin d’aquests és un dels principis que inspiren la Llei 4/2003, d’ordenació del sistema de seguretat pública de Catalunya?', 'Entre els principis hi ha la prevenció, l’adequació a la demanda social, la proximitat, l’eficàcia, la planificació, la proporcionalitat, la corresponsabilitat, la coordinació i la transparència.', 'mossos_c3_coordinacio_policial', (select id from public.topics where slug = 'mossos-c3-coordinacio-policial'), 3, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=205'), 'Guia p. 211, §1', '– La proporcionalitat de la intervenció pública.', null, 'e181c42fabb04e12a69304533ac4acf96f1754d9560c617b367eaf955b07d7ed', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'e181c42fabb04e12a69304533ac4acf96f1754d9560c617b367eaf955b07d7ed')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'La proporcionalitat de la intervenció pública.', true), ('B', 'La centralització de tots els serveis de seguretat.', false), ('C', 'La confidencialitat de les actuacions davant els ciutadans.', false), ('D', 'L’exclusivitat de la Policia de la Generalitat en matèria de seguretat.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, qui és l’autoritat superior en matèria de seguretat pública en l’àmbit local?', 'En l’àmbit local, els alcaldes són l’autoritat superior en matèria de seguretat pública, en el marc de les seves competències.', 'mossos_c3_coordinacio_policial', (select id from public.topics where slug = 'mossos-c3-coordinacio-policial'), 2, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=205'), 'Guia p. 211, §4', 'En l’àmbit local, els alcaldes són l’autoritat superior en matèria de seguretat pública, en el marc de les seves competències.', null, 'c73fc0667f71190b48890db57912c1de11f403b2d1eed7eabe449579fa5e17b0', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'c73fc0667f71190b48890db57912c1de11f403b2d1eed7eabe449579fa5e17b0')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El cap de la policia local.', false), ('B', 'El delegat territorial del Govern.', false), ('C', 'L’alcalde.', true), ('D', 'El cap de l’àrea bàsica policial.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, qui presideix la Comissió del Govern per a la Seguretat?', 'La Comissió del Govern per a la Seguretat, presidida pel president de la Generalitat, coordina les actuacions dels departaments que afecten la seguretat.', 'mossos_c3_coordinacio_policial', (select id from public.topics where slug = 'mossos-c3-coordinacio-policial'), 3, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=205'), 'Guia p. 212, §3', 'es crea la Comissió del Govern per a la Seguretat, presidida pel president de la Generalitat', null, 'dcddc24d1399097dc0f59514de781ea48a9d0db69ea487d9effbd38ab5ac704a', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'dcddc24d1399097dc0f59514de781ea48a9d0db69ea487d9effbd38ab5ac704a')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El president de la Generalitat.', true), ('B', 'El conseller d’Interior i Seguretat Pública.', false), ('C', 'El director general de la Policia.', false), ('D', 'El secretari general d’Interior.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, en quins municipis tenen caràcter obligatori les juntes locals de seguretat?', 'Les juntes locals de seguretat són obligatòries en els municipis amb policia local i les presideix l’alcalde.', 'mossos_c3_coordinacio_policial', (select id from public.topics where slug = 'mossos-c3-coordinacio-policial'), 2, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=205'), 'Guia p. 212, §5', 'La Llei atorga una rellevància especial a les juntes locals de seguretat, que tenen caràcter obligatori en els municipis que comptin amb policia local.', null, '623e33311917894be57007cb2659744d00e35c37fffc31387cbb494e97d165e7', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '623e33311917894be57007cb2659744d00e35c37fffc31387cbb494e97d165e7')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'En tots els municipis de Catalunya.', false), ('B', 'Només en els municipis de més de 20.000 habitants.', false), ('C', 'En els municipis que comptin amb policia local.', true), ('D', 'Només a les capitals de comarca.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, quina periodicitat té el Pla general de seguretat de Catalunya?', 'El Pla general de seguretat de Catalunya és quadriennal i l’aprova el Govern.', 'mossos_c3_coordinacio_policial', (select id from public.topics where slug = 'mossos-c3-coordinacio-policial'), 3, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=205'), 'Guia p. 212, §6', 'El Pla, que té una periodicitat quadriennal, ha de ser aprovat pel Govern', null, '93dee7ae28f3dfbf35f60a87238b48db1037d6623b01977f4f09bdc80fd536b6', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '93dee7ae28f3dfbf35f60a87238b48db1037d6623b01977f4f09bdc80fd536b6')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Anual.', false), ('B', 'Biennal.', false), ('C', 'Decennal.', false), ('D', 'Quadriennal.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, quin any s’adopta definitivament el nom d’Organització Internacional de Policia Criminal - Interpol (OIPC-Interpol)?', 'El 1914 hi ha la reunió de Mònaco, el 1923 es crea la Comissió Internacional de Policia Criminal a Viena, el 1946 s’adopta el nom d’Interpol i el 1956 el d’OIPC-Interpol.', 'mossos_c3_coordinacio_policial', (select id from public.topics where slug = 'mossos-c3-coordinacio-policial'), 2, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=205'), 'Guia p. 214, §1', 'Serà l’any 1946 quan s’adopti el nom d’Interpol, que posteriorment, l’any 1956, passa a anomenar-se definitivament Organització Internacional de Policia Criminal - Interpol (OIPC-Interpol).', null, '1b340bab7d8385adf01c73e7c91816ecf35ad06a1a52665bba608806032d345b', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '1b340bab7d8385adf01c73e7c91816ecf35ad06a1a52665bba608806032d345b')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', '1914.', false), ('B', '1956.', true), ('C', '1923.', false), ('D', '1946.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, en quins assumptes no ha d’intervenir l’OIPC-Interpol, d’acord amb l’article 3 del seu Estatut?', 'L’article 3 de l’Estatut de la Interpol exclou la seva intervenció en assumptes de caràcter polític, militar, religiós o racial.', 'mossos_c3_coordinacio_policial', (select id from public.topics where slug = 'mossos-c3-coordinacio-policial'), 2, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=205'), 'Guia p. 214, §4', 'L’article 3 de l’Estatut estableix que l’OIPC-Interpol no ha d’intervenir en assumptes de caràcter polític, militar, religiós o racial.', null, '2eb0f238456093480edb3c1934545a7a1967558ae11c5816c56574a36742dfde', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '2eb0f238456093480edb3c1934545a7a1967558ae11c5816c56574a36742dfde')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'En assumptes de delinqüència organitzada i terrorisme.', false), ('B', 'En assumptes de tràfic de drogues.', false), ('C', 'En assumptes de caràcter polític, militar, religiós o racial.', true), ('D', 'En assumptes de falsificació de moneda.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, on tenia la seu la Unitat de Drogues de l’Europol (EDU), que va iniciar l’activitat el 3 de gener de 1994?', 'L’EDU va començar a la Haia el 1994; el Conveni Europol es va signar el 1998 i l’organització va iniciar activitats l’1 de juliol de 1999.', 'mossos_c3_coordinacio_policial', (select id from public.topics where slug = 'mossos-c3-coordinacio-policial'), 3, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=205'), 'Guia p. 215, §3', 'El 3 de gener de 1994 va iniciar la seva activitat la Unitat de Drogues de l’Europol (EDU), amb seu a la Haia (Països Baixos).', null, 'f50a85cff80df8bffd46bf75e5c0240514beae98acf739044a332e774999ae8a', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'f50a85cff80df8bffd46bf75e5c0240514beae98acf739044a332e774999ae8a')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'A Brussel·les.', false), ('B', 'A Estrasburg.', false), ('C', 'A Lió.', false), ('D', 'A la Haia.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, com s’anomena la forma de cooperació de l’article 41 del CAAS que permet perseguir una persona que ha comès un delicte flagrant dins del territori d’un altre Estat Schengen amb frontera comuna?', 'L’article 41 regula la persecució transfronterera; l’article 40, la vigilància transfronterera dins d’una investigació judicial.', 'mossos_c3_coordinacio_policial', (select id from public.topics where slug = 'mossos-c3-coordinacio-policial'), 3, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=205'), 'Guia p. 217, §1', 'Persecució transfronterera (article 41): també anomenada “persecució en calent”', null, '19eb262174195efdacf203dc04ad06fb6e8092f7e16f16c234b60bf4267e6b3e', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '19eb262174195efdacf203dc04ad06fb6e8092f7e16f16c234b60bf4267e6b3e')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Vigilància transfronterera.', false), ('B', 'Persecució transfronterera o persecució en calent.', true), ('C', 'Informació incondicionada.', false), ('D', 'Lliurament vigilat.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, on està situat l’ordinador central del SIS (Central Schengen Information System)?', 'El SIS està integrat per un ordinador central situat a Estrasburg (CSIS) i els sistemes estatals (NSIS).', 'mossos_c3_coordinacio_policial', (select id from public.topics where slug = 'mossos-c3-coordinacio-policial'), 3, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=205'), 'Guia p. 217, §4', 'integrat perun ordinador central situat a Estrasburg (Central Schengen Information System, CSIS)', null, '5f6d2c9cf5793b400ad82bd10e8c9d1ce3eefcd7cc88e649b0e62bb23b8cdea4', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '5f6d2c9cf5793b400ad82bd10e8c9d1ce3eefcd7cc88e649b0e62bb23b8cdea4')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'A Estrasburg.', true), ('B', 'A Brussel·les.', false), ('C', 'A Luxemburg.', false), ('D', 'A la Haia.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
-- Lote mossos-c4-marc-legal-seguretat-guia-v1 (20 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Guia d''estudi per accedir a la PG-ME, 1a edició, juny de 2026 (convocatòria 46/26), tema C.4, pp. 223-237', 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=223', 'web_oficial'::public.source_kind, 'Generalitat de Catalunya · Mossos d''Esquadra (web oficial de la convocatòria 46/26)', '2026-06-01') on conflict (url) do nothing;
insert into public.topics (slug, title) values ('mossos-c4-marc-legal-seguretat', 'C.4 El marc legal de la seguretat') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug = 'mossos-esquadra' and t.slug = 'mossos-c4-marc-legal-seguretat' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, quin article de la Constitució desplega la Llei orgànica 2/1986, de forces i cossos de seguretat?', 'La LO 2/1986 desplega l’article 104 CE, que encomana a les FCS protegir el lliure exercici dels drets i llibertats i garantir la seguretat ciutadana.', 'mossos_c4_marc_legal_seguretat', (select id from public.topics where slug = 'mossos-c4-marc-legal-seguretat'), 2, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=223'), 'Guia p. 224, §1', 'La Llei orgànica 2/1986 és una llei que desplega el mandat constitucional explícit a l’article 104', null, '4b6b7f910913dfa286017da245111b0a7817fa68df062cf50db3c94266c0ef63', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '4b6b7f910913dfa286017da245111b0a7817fa68df062cf50db3c94266c0ef63')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'L’article 17.', false), ('B', 'L’article 104.', true), ('C', 'L’article 126.', false), ('D', 'L’article 149.1.29.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, com es defineixen els cossos autonòmics de policia?', 'Els cossos autonòmics de policia són instituts armats de naturalesa civil amb organització jerarquitzada.', 'mossos_c4_marc_legal_seguretat', (select id from public.topics where slug = 'mossos-c4-marc-legal-seguretat'), 2, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=223'), 'Guia p. 224, §6', 'els cossos autonòmics de policia són instituts armats de naturalesa civil amb organització jerarquitzada.', null, 'de200bddd4cca4fc6436bd495f9d839c4dd2ab932b53a29ff9ffc9c9123c8fbf', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'de200bddd4cca4fc6436bd495f9d839c4dd2ab932b53a29ff9ffc9c9123c8fbf')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Com a instituts armats de naturalesa militar.', false), ('B', 'Com a cossos no armats de naturalesa civil.', false), ('C', 'Com a serveis administratius de vigilància.', false), ('D', 'Com a instituts armats de naturalesa civil amb organització jerarquitzada.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, quina d’aquestes és una funció de caràcter propi de les policies autonòmiques d’acord amb l’article 38 de la LO 2/1986?', 'L’ús de la coacció per a l’execució forçosa d’actes de la comunitat és funció pròpia; l’auxili en catàstrofes és compartida, i la policia judicial i la vigilància d’espais públics són de col·laboració.', 'mossos_c4_marc_legal_seguretat', (select id from public.topics where slug = 'mossos-c4-marc-legal-seguretat'), 3, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=223'), 'Guia p. 225, §1', 'd) L’ús de la coacció amb vista a l’execució forçosa dels actes o disposicions de la mateixa comunitat autònoma.', null, 'e09d8aa84eae764274f963932a0182ab947320b5ee7fb49fbe0295a444bc38dd', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'e09d8aa84eae764274f963932a0182ab947320b5ee7fb49fbe0295a444bc38dd')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'L’ús de la coacció amb vista a l’execució forçosa dels actes o disposicions de la mateixa comunitat autònoma.', true), ('B', 'Participar en funcions de policia judicial.', false), ('C', 'Prestar auxili en accidents i catàstrofes.', false), ('D', 'Vigilar espais públics i protegir manifestacions.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, quina d’aquestes funcions exerceixen les policies autonòmiques amb caràcter compartit i indiferenciat amb les FCSE?', 'Les funcions compartides són la resolució amistosa de conflictes privats, l’auxili en accidents i catàstrofes i vetllar per la conservació de la natura i el medi ambient.', 'mossos_c4_marc_legal_seguretat', (select id from public.topics where slug = 'mossos-c4-marc-legal-seguretat'), 3, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=223'), 'Guia p. 225, §2', 'Les funcions amb caràcter compartit i indiferenciat amb les FCSE: a) Cooperació en la resolució amistosa de conflictes privats.', null, 'd57f0fb89ffc17701498b08ec663ab996e64a3bad1f6e8bf38befc5afc6530fe', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'd57f0fb89ffc17701498b08ec663ab996e64a3bad1f6e8bf38befc5afc6530fe')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'La vigilància i protecció dels edificis de la comunitat.', false), ('B', 'La inspecció d’activitats sota les competències de la comunitat.', false), ('C', 'La cooperació en la resolució amistosa de conflictes privats.', true), ('D', 'Participar en funcions de policia judicial.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, en quin article de la LO 2/1986 s’estableixen els principis bàsics d’actuació dels membres de les forces i cossos de seguretat?', 'L’article 5 de la LO 2/1986 recull els principis bàsics d’actuació; l’article 38 les funcions de les policies autonòmiques i el 53 les de la policia local.', 'mossos_c4_marc_legal_seguretat', (select id from public.topics where slug = 'mossos-c4-marc-legal-seguretat'), 3, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=223'), 'Guia p. 226, §2', 'Segons l’article 5 de la Llei orgànica 2/1986, de 13 de març, de forces i cossos de seguretat, són principis bàsics d’actuació', null, '37d803b47cb3d924d9a3fc3eed512893951ec3d81108e5e313b0d1f1ee79129d', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '37d803b47cb3d924d9a3fc3eed512893951ec3d81108e5e313b0d1f1ee79129d')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'L’article 3.', false), ('B', 'L’article 38.', false), ('C', 'L’article 5.', true), ('D', 'L’article 53.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, pot l’obediència deguda emparar ordres que comportin l’execució d’actes manifestament delictius?', 'Els principis de jerarquia i subordinació no permeten en cap cas que l’obediència deguda empari ordres manifestament delictives o contràries a la Constitució o a les lleis.', 'mossos_c4_marc_legal_seguretat', (select id from public.topics where slug = 'mossos-c4-marc-legal-seguretat'), 2, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=223'), 'Guia p. 226, §2', 'En cap cas l’obediència deguda no pot emparar ordres que comportin l’execució d’actes que constitueixin manifestament un delicte o siguin contraris a la Constitució o a les lleis.', null, '376b8f2848c318ca7fad37a128cc72497a0aa5cf6ef74efe47c47a48a122914d', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '376b8f2848c318ca7fad37a128cc72497a0aa5cf6ef74efe47c47a48a122914d')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Sí, si l’ordre prové d’un superior jeràrquic.', false), ('B', 'No, en cap cas.', true), ('C', 'Sí, si l’ordre consta per escrit.', false), ('D', 'Només en situacions d’urgència.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, per quins principis s’han de regir els membres de les FCS en la utilització dels mitjans al seu abast quan actuen per evitar un dany greu, immediat i irreparable?', 'Han d’actuar amb la decisió necessària i sense demora, d’acord amb els principis de congruència, oportunitat i proporcionalitat.', 'mossos_c4_marc_legal_seguretat', (select id from public.topics where slug = 'mossos-c4-marc-legal-seguretat'), 3, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=223'), 'Guia p. 226, §3', 's’han de regir pels principis de congruència, oportunitat i proporcionalitat en la utilització dels mitjans al seu abast.', null, '78865c87796526ded809c930a19492e54ba5c6e09569a98d30788105141a15fe', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '78865c87796526ded809c930a19492e54ba5c6e09569a98d30788105141a15fe')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Congruència, oportunitat i proporcionalitat.', true), ('B', 'Legalitat, jerarquia i disciplina.', false), ('C', 'Eficàcia, eficiència i economia.', false), ('D', 'Unitat, coordinació i cooperació.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, quina obligació tenen els membres de les FCS en el moment d’efectuar una detenció?', 'En el tractament de detinguts, s’han d’identificar degudament en el moment de la detenció i vetllar per la vida, la integritat, l’honor i la dignitat de les persones.', 'mossos_c4_marc_legal_seguretat', (select id from public.topics where slug = 'mossos-c4-marc-legal-seguretat'), 2, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=223'), 'Guia p. 226, §4', 'a) Els membres de les forces i cossos de seguretat s’han d’identificar degudament com a tals en el moment d’efectuar una detenció.', null, 'fbdc0342f7639907046ec27a932891bbac47f0e50bb616f274c802cbc72ecaf3', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'fbdc0342f7639907046ec27a932891bbac47f0e50bb616f274c802cbc72ecaf3')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Informar immediatament el Ministeri Fiscal.', false), ('B', 'Sol·licitar autorització judicial prèvia.', false), ('C', 'Fer-ho sempre uniformats.', false), ('D', 'Identificar-se degudament com a tals.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, què estableix el principi de dedicació professional dels membres de les FCS?', 'La dedicació professional obliga a intervenir sempre, de servei o no, en defensa de la llei i de la seguretat ciutadana.', 'mossos_c4_marc_legal_seguretat', (select id from public.topics where slug = 'mossos-c4-marc-legal-seguretat'), 2, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=223'), 'Guia p. 226, §5', 'han d’intervenir sempre, en qualsevol temps i lloc, tant si es troben de servei com si no, en defensa de la llei i de la seguretat ciutadana.', null, 'a2825f2efad8a53a3460f6170013e0e605ea2dc25b8a5d4b71d6ee271b6db2ca', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'a2825f2efad8a53a3460f6170013e0e605ea2dc25b8a5d4b71d6ee271b6db2ca')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Que han d’intervenir sempre, en qualsevol temps i lloc, tant si es troben de servei com si no, en defensa de la llei i de la seguretat ciutadana.', true), ('B', 'Que només han d’intervenir mentre es troben de servei.', false), ('C', 'Que no poden exercir cap altra activitat pública o privada.', false), ('D', 'Que han de residir al municipi on presten servei.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, estan obligats els membres de les FCS a revelar les fonts d’informació?', 'El secret professional obliga a guardar rigorós secret i no obliga a revelar les fonts, llevat que les funcions o la llei imposin el contrari.', 'mossos_c4_marc_legal_seguretat', (select id from public.topics where slug = 'mossos-c4-marc-legal-seguretat'), 3, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=223'), 'Guia p. 227, §1', 'No estan obligats a revelar les fonts d’informació, llevat que l’exercici de les seves funcions o les disposicions de la llei els imposin actuar d’una altra manera.', null, '771040fd21f2fbce08054e916102fbac7d56becf2880a068f85d498defa99ca8', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '771040fd21f2fbce08054e916102fbac7d56becf2880a068f85d498defa99ca8')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Sí, sempre que ho demani un superior.', false), ('B', 'No, llevat que l’exercici de les seves funcions o les disposicions de la llei els imposin actuar d’una altra manera.', true), ('C', 'Sí, sempre que ho demani qualsevol ciutadà afectat.', false), ('D', 'No, en cap cas, ni tan sols per disposició legal.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, quins articles de la LO 2/1986 s’han d’aplicar directament a la Policia de la Generalitat, d’acord amb la disposició final segona?', 'La disposició final segona determina l’aplicació directa a la PG-ME dels principis bàsics d’actuació i les disposicions estatutàries comunes dels articles 5, 6, 7 i 8.', 'mossos_c4_marc_legal_seguretat', (select id from public.topics where slug = 'mossos-c4-marc-legal-seguretat'), 3, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=223'), 'Guia p. 227, §3', 'que determina que s’han d’aplicar directament a la Policia de la Generalitat els principis bàsics d’actuació i les disposicions estatutàries comunes que estableixen els articles 5, 6, 7 i 8 de la Llei esmentada.', null, '97370eb8b1654e926a30f8ab982e510a38a390742b50ff3ddf9cc3cf2924d769', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '97370eb8b1654e926a30f8ab982e510a38a390742b50ff3ddf9cc3cf2924d769')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Els articles 1, 2, 3 i 4.', false), ('B', 'Els articles 37, 38, 39 i 40.', false), ('C', 'Els articles 51, 52, 53 i 54.', false), ('D', 'Els articles 5, 6, 7 i 8.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, quin article de l’Estatut d’autonomia de 1932 deixava al Govern català totes les funcions de policia i ordre interiors?', 'L’article 8 de l’Estatut de 1932 reservava a l’Estat només la seguretat pública extra i supracomunitària.', 'mossos_c4_marc_legal_seguretat', (select id from public.topics where slug = 'mossos-c4-marc-legal-seguretat'), 3, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=223'), 'Guia p. 227, §5', 'de conformitat amb l’article 8 de l’Estatut d’autonomia de Catalunya de 1932, segons les quals l’Estat només es reservava la seguretat pública de caràcter extra i supracomunitari', null, '711de4301868bd96abcf8fef435babd7336134caeb8daaa2cee3fdd14d3df380', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '711de4301868bd96abcf8fef435babd7336134caeb8daaa2cee3fdd14d3df380')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'L’article 1.', false), ('B', 'L’article 13.', false), ('C', 'L’article 8.', true), ('D', 'L’article 164.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, quin òrgan crea la Llei 10/1994, amb representació paritària de l’Administració de la Generalitat i dels membres de la Policia de la Generalitat?', 'La Llei 10/1994 crea el Consell de la Policia, amb representació paritària de l’Administració i dels membres del cos.', 'mossos_c4_marc_legal_seguretat', (select id from public.topics where slug = 'mossos-c4-marc-legal-seguretat'), 2, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=223'), 'Guia p. 229, §5', 'es crea el Consell de la Policia, amb representació paritària de l’Administració de la Generalitat i dels membres de la Policia de la Generalitat.', null, 'b23de0095e5867d10c54a30bc71d8ac1079930a7c55d8e0a0454d8d32b925081', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'b23de0095e5867d10c54a30bc71d8ac1079930a7c55d8e0a0454d8d32b925081')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'La Junta de Seguretat de Catalunya.', false), ('B', 'La Comissió de Policia de Catalunya.', false), ('C', 'El Consell de Seguretat de Catalunya.', false), ('D', 'El Consell de la Policia.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, quina d’aquestes és una funció de policia administrativa de la Policia de la Generalitat - Mossos d’Esquadra?', 'Vetllar pel patrimoni cultural és policia administrativa; l’ordre públic i la prevenció són seguretat ciutadana, i l’auxili judicial és policia judicial.', 'mossos_c4_marc_legal_seguretat', (select id from public.topics where slug = 'mossos-c4-marc-legal-seguretat'), 3, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=223'), 'Guia p. 230, §1', 'f) Vetllar pel compliment de la normativa sobre el patrimoni cultural català, pel que fa a la salvaguarda i la protecció d’aquest i per evitar-ne l’espoli o la destrucció.', null, '88bf3e889aa2cfb48d49e92d85d3a66698ffe024d5b1558caed0aad6567cb1f7', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '88bf3e889aa2cfb48d49e92d85d3a66698ffe024d5b1558caed0aad6567cb1f7')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Mantenir l’ordre públic.', false), ('B', 'Vetllar pel compliment de la normativa sobre el patrimoni cultural català.', true), ('C', 'Prevenir actes delictius.', false), ('D', 'Auxiliar els jutges en la investigació dels delictes.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, què pot fer la PG-ME en els municipis que no disposen de policia local, d’acord amb les funcions de cooperació amb les entitats locals?', 'La PG-ME pot exercir les funcions pròpies de les policies locals als municipis sense policia local, amb els convenis de cooperació corresponents.', 'mossos_c4_marc_legal_seguretat', (select id from public.topics where slug = 'mossos-c4-marc-legal-seguretat'), 3, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=223'), 'Guia p. 230, §3', 'b) Exercir, a més de les funcions assenyalades en aquest article, les pròpies de les policies locals en els municipis que no en disposin.', null, 'd3cbe439ac080a35b900813f188a3ebee9f8fc884d7c25c210e7c9e53e05ff61', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'd3cbe439ac080a35b900813f188a3ebee9f8fc884d7c25c210e7c9e53e05ff61')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Res, perquè correspon a la Guàrdia Civil.', false), ('B', 'Crear una policia local provisional.', false), ('C', 'Exercir les funcions pròpies de les policies locals, mitjançant els convenis de cooperació corresponents.', true), ('D', 'Delegar les funcions en vigilants municipals armats.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, pot una àrea bàsica policial (ABP) estar composta per parts de diferents comarques?', 'Una ABP pot abastar part d’una comarca, una comarca sencera o un conjunt de comarques, però mai parts de comarques diferents.', 'mossos_c4_marc_legal_seguretat', (select id from public.topics where slug = 'mossos-c4-marc-legal-seguretat'), 2, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=223'), 'Guia p. 231, §2', 'Una ABP pot abastar part d’una comarca, una comarca sencera o un conjunt de comarques, però en cap cas es composa de parts de diferents comarques.', null, '308aa55c4c15c9c17037cd25e383ae8a624086cab19faec47fafa237799bfa9e', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '308aa55c4c15c9c17037cd25e383ae8a624086cab19faec47fafa237799bfa9e')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'No, en cap cas es compon de parts de diferents comarques.', true), ('B', 'Sí, sempre que ho justifiquin criteris operatius.', false), ('C', 'Sí, a l’àmbit metropolità.', false), ('D', 'Només si ho acorda la Junta Local de Seguretat.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, quines categories comprèn l’escala intermèdia de la Policia de la Generalitat - Mossos d’Esquadra?', 'Escala bàsica: mosso i caporal; intermèdia: sergent i sotsinspector; executiva: inspector; superior: intendent, comissari i major; de suport: facultatiu i tècnic.', 'mossos_c4_marc_legal_seguretat', (select id from public.topics where slug = 'mossos-c4-marc-legal-seguretat'), 2, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=223'), 'Guia p. 231, §6', 'b) Escala intermèdia, que comprèn les categories de sergent i de sotsinspector.', null, '05f9f62fa44b14e2a318328c4b86def95ff93fc716f51dfc58907ed33fe6aa59', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '05f9f62fa44b14e2a318328c4b86def95ff93fc716f51dfc58907ed33fe6aa59')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Mosso i caporal.', false), ('B', 'Inspector.', false), ('C', 'Intendent, comissari i major.', false), ('D', 'Sergent i sotsinspector.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, a partir de quina població poden crear cossos de policia local els municipis?', 'Els municipis de més de 10.000 habitants poden crear policia local; no és obligatòria, i se n’admeten excepcions per autorització del conseller.', 'mossos_c4_marc_legal_seguretat', (select id from public.topics where slug = 'mossos-c4-marc-legal-seguretat'), 2, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=223'), 'Guia p. 232, §4', 'tots els municipis amb una població superior als 10.000 habitants poden crear cossos de policia local.', null, '49de9ee8f1dbc46f584a0cdcfb3a1fc83f8cb4422095a09fad892b188c258715', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '49de9ee8f1dbc46f584a0cdcfb3a1fc83f8cb4422095a09fad892b188c258715')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Més de 5.000 habitants.', false), ('B', 'Més de 10.000 habitants.', true), ('C', 'Més de 20.000 habitants.', false), ('D', 'Més de 50.000 habitants.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, quina escala de la policia local comprèn les categories de superintendent, intendent major i intendent?', 'A la policia local, l’escala superior comprèn superintendent, intendent major i intendent; l’executiva, inspector; la intermèdia, sotsinspector i sergent; la bàsica, caporal i agent.', 'mossos_c4_marc_legal_seguretat', (select id from public.topics where slug = 'mossos-c4-marc-legal-seguretat'), 3, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=223'), 'Guia p. 232, §5', 'Escala superior, que comprèn les categories de superintendent, d’intendent major i d’intendent.', null, '3ba4698a3d155113b630e0fec7221eb394dc5ff658bcf0ed00292c39da6db66d', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '3ba4698a3d155113b630e0fec7221eb394dc5ff658bcf0ed00292c39da6db66d')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'L’escala superior.', true), ('B', 'L’escala executiva.', false), ('C', 'L’escala intermèdia.', false), ('D', 'L’escala bàsica.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, en quines condicions pot actuar la policia local en municipis limítrofes?', 'La policia local només actua al seu municipi, excepte per emergència excepcional, i n’ha de donar compte al conseller competent.', 'mossos_c4_marc_legal_seguretat', (select id from public.topics where slug = 'mossos-c4-marc-legal-seguretat'), 2, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=223'), 'Guia p. 233, §1', 'La policia local només pot actuar en el territori del seu municipi, i excepcionalment, per raons d’emergència excepcional, i donant-ne compte al conseller o consellera del Departament amb competències en matèria de seguretat pública, pot actuar en els municipis limítrofes.', null, '898ffdf5b8c3c5070b80175aee35ffc5cabcfbf6e3eda72b7904858ae029aacd', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '898ffdf5b8c3c5070b80175aee35ffc5cabcfbf6e3eda72b7904858ae029aacd')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Sempre que ho sol·liciti l’alcalde del municipi veí.', false), ('B', 'Mai; només pot actuar en el territori del seu municipi.', false), ('C', 'Excepcionalment, per raons d’emergència excepcional i donant-ne compte al conseller competent en seguretat pública.', true), ('D', 'Quan ho autoritzi el cap de l’ABP de la PG-ME.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
-- Lote mossos-c5-codi-deontologic-guia-v1 (12 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Guia d''estudi per accedir a la PG-ME, 1a edició, juny de 2026 (convocatòria 46/26), tema C.5, pp. 238-242', 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=238', 'web_oficial'::public.source_kind, 'Generalitat de Catalunya · Mossos d''Esquadra (web oficial de la convocatòria 46/26)', '2026-06-01') on conflict (url) do nothing;
insert into public.topics (slug, title) values ('mossos-c5-codi-deontologic', 'C.5 El Codi deontològic policial') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug = 'mossos-esquadra' and t.slug = 'mossos-c5-codi-deontologic' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, què és la deontologia professional?', 'La deontologia professional és el conjunt de principis i regles ètiques que determinen els deures mínimament exigibles; solen sorgir del mateix col·lectiu.', 'mossos_c5_codi_deontologic', (select id from public.topics where slug = 'mossos-c5-codi-deontologic'), 1, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=238'), 'Guia p. 239, §1', 'La deontologia professional és el conjunt de principis i regles ètiques que regulen i guien una activitat professional.', null, 'a7eed2daea3bb8ca107d7be0f5fb1faca1038265049f37f9fc8e0a171734a880', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'a7eed2daea3bb8ca107d7be0f5fb1faca1038265049f37f9fc8e0a171734a880')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El conjunt de lleis penals aplicables a una professió.', false), ('B', 'El règim disciplinari d’un cos de funcionaris.', false), ('C', 'La formació tècnica exigida per accedir a una professió.', false), ('D', 'El conjunt de principis i regles ètiques que regulen i guien una activitat professional.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, d’on solen sorgir les normes deontològiques d’una professió?', 'Les normes deontològiques solen sorgir del mateix col·lectiu professional, que les recull en codis deontològics.', 'mossos_c5_codi_deontologic', (select id from public.topics where slug = 'mossos-c5-codi-deontologic'), 2, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=238'), 'Guia p. 239, §1', 'Per aquest motiu, solen sorgir del mateix col·lectiu professional, el qual s’encarrega de recollir-los per escrit en els codis deontològics.', null, '23fe418e42def89819f2f3c276c328d72aff477d9f298bab96bf6d16cf914f3c', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '23fe418e42def89819f2f3c276c328d72aff477d9f298bab96bf6d16cf914f3c')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Del Parlament, mitjançant una llei orgànica.', false), ('B', 'Dels tribunals, a través de la jurisprudència.', false), ('C', 'Del mateix col·lectiu professional, que les recull per escrit en codis deontològics.', true), ('D', 'Dels organismes internacionals de drets humans.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, per a qui és una garantia el codi de deontologia policial?', 'El codi és una garantia per al ciutadà i per a l’agent, que entén i accepta les regles amb què ha de treballar.', 'mossos_c5_codi_deontologic', (select id from public.topics where slug = 'mossos-c5-codi-deontologic'), 2, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=238'), 'Guia p. 239, §2', 'El Codi de deontologia policial és una garantia per al ciutadà, però també per al mateix agent de policia', null, 'c15bde79b0fdb1edceeb528eb01f73b15ed08732342af946f67609687ba86acd', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'c15bde79b0fdb1edceeb528eb01f73b15ed08732342af946f67609687ba86acd')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Per al ciutadà i també per al mateix agent de policia.', true), ('B', 'Només per a l’Administració.', false), ('C', 'Només per al ciutadà.', false), ('D', 'Només per als tribunals.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, quin paper han de tenir l’Estat i la policia respecte als drets humans en un sistema democràtic?', 'En un sistema democràtic, l’Estat i la policia han de respectar els drets humans i, a més, ser-ne garants i protectors.', 'mossos_c5_codi_deontologic', (select id from public.topics where slug = 'mossos-c5-codi-deontologic'), 2, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=238'), 'Guia p. 239, §4', 'en un sistema democràtic, l’Estat i la policia no només han de respectar els drets humans, sinó que n’han de ser els garants i protectors.', null, '6ea5ba1b0cbececcf1e85688cb16a957414585181b0ab86b3c0dc31dbc732953', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '6ea5ba1b0cbececcf1e85688cb16a957414585181b0ab86b3c0dc31dbc732953')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Només respectar-los quan no afectin la seguretat.', false), ('B', 'No només respectar-los, sinó ser-ne els garants i protectors.', true), ('C', 'Limitar-los quan ho consideri necessari el comandament.', false), ('D', 'Delegar-ne la protecció als organismes internacionals.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, en quina data el Comitè de Ministres del Consell d’Europa va adoptar la Recomanació REC(2001)10 sobre el Codi europeu d’ètica de la policia?', 'La Recomanació REC(2001)10 es va adoptar el 19 de setembre de 2001.', 'mossos_c5_codi_deontologic', (select id from public.topics where slug = 'mossos-c5-codi-deontologic'), 2, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=238'), 'Guia p. 239, §5', 'El Comitè de Ministres del Consell d’Europa, en la Recomanació REC(2001)10, sobre el Codi europeu d’ètica de la policia, adoptada el 19 de setembre de 2001', null, 'db2b0463af506833dc45f65c3ae74ec8e192a2eefe4ca32c4c428de355be6113', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'db2b0463af506833dc45f65c3ae74ec8e192a2eefe4ca32c4c428de355be6113')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El 10 de desembre de 2001.', false), ('B', 'El 19 de setembre de 2001.', true), ('C', 'El 14 de juny de 2004.', false), ('D', 'El 24 de febrer de 2015.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, en quin principi es basa el Codi europeu d’ètica de la policia?', 'El Codi es basa en la protecció de l’Estat de dret i considera que la policia, amb el sistema penal, hi té un paper determinant.', 'mossos_c5_codi_deontologic', (select id from public.topics where slug = 'mossos-c5-codi-deontologic'), 3, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=238'), 'Guia p. 239, §6', 'el Codi es basa en el principi de la protecció de l’Estat de dret com a base de qualsevol democràcia veritable', null, '3489284f43a7e8cfccb3d82e27c838aceb02729fe4f3d27a1da4538b27fe0623', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '3489284f43a7e8cfccb3d82e27c838aceb02729fe4f3d27a1da4538b27fe0623')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'En el principi de jerarquia policial.', false), ('B', 'En el principi de sobirania dels estats membres.', false), ('C', 'En el principi de la protecció de l’Estat de dret com a base de qualsevol democràcia veritable.', true), ('D', 'En el principi d’eficàcia de l’acció policial.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, a quins òrgans s’aplica el Codi europeu d’ètica de la policia?', 'S’aplica als serveis de policia i a altres òrgans autoritzats o controlats pels poders públics que tenen com a primer objectiu mantenir l’ordre i estan autoritzats a usar la força.', 'mossos_c5_codi_deontologic', (select id from public.topics where slug = 'mossos-c5-codi-deontologic'), 3, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=238'), 'Guia p. 239, §7', 'Aquest Codi s’aplica a les forces públiques de seguretat tradicionals o serveis de policia, o a altres òrgans autoritzats i/o controlats pels poders públics', null, '0b10b33662fb189af5e980a6afe36521fd0b4e4639d18c6b50e53878ceb6bb6f', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '0b10b33662fb189af5e980a6afe36521fd0b4e4639d18c6b50e53878ceb6bb6f')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Només als cossos de policia estatals.', false), ('B', 'Només a les empreses de seguretat privada.', false), ('C', 'Només a les policies dels estats membres de la Unió Europea.', false), ('D', 'A les forces públiques de seguretat o serveis de policia, o altres òrgans autoritzats pels poders públics per utilitzar la força per mantenir l’ordre.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, mitjançant quina resolució es va aprovar la Instrucció per incorporar el Codi europeu d’ètica de la policia a l’actuació de la PG-ME?', 'La Resolució INT/1828/2004 va aprovar la Instrucció d’incorporació del Codi europeu; el Codi d’ètica de la Policia de Catalunya es va aprovar per l’Acord GOV/25/2015.', 'mossos_c5_codi_deontologic', (select id from public.topics where slug = 'mossos-c5-codi-deontologic'), 3, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=238'), 'Guia p. 240, §1', 'Mitjançant la Resolució INT/1828/2004, de 14 de juny, es va aprovar la Instrucció per a la incorporació i l’aplicació del Codi europeu d’ètica de la policia', null, '33d89b5fbf561e83a2a3c5d20f559c2b12411454088740782fa20e398d63f859', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '33d89b5fbf561e83a2a3c5d20f559c2b12411454088740782fa20e398d63f859')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'La Resolució INT/1828/2004, de 14 de juny.', true), ('B', 'L’Acord GOV/25/2015, de 24 de febrer.', false), ('C', 'La Recomanació REC(2001)10.', false), ('D', 'El Decret 57/2023, de 21 de març.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, quin any es va crear el Comitè d’Ètica de la Policia de Catalunya?', 'El Comitè d’Ètica de la Policia de Catalunya es va crear el 2007 i va proposar el Codi aprovat el 2015.', 'mossos_c5_codi_deontologic', (select id from public.topics where slug = 'mossos-c5-codi-deontologic'), 2, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=238'), 'Guia p. 240, §2', 'Amb aquesta voluntat es va crear al 2007 el Comitè d’Ètica de la Policia de Catalunya', null, '287094418f6ce5257e3df0ef869602c225909a38a2b6d1dec24144223eb6f399', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '287094418f6ce5257e3df0ef869602c225909a38a2b6d1dec24144223eb6f399')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', '2001.', false), ('B', '2004.', false), ('C', '2015.', false), ('D', '2007.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, quin òrgan va proposar el Codi d’ètica de la Policia de Catalunya aprovat pel Govern?', 'El Codi el va proposar el Comitè d’Ètica de la Policia de Catalunya i el va aprovar el Govern per l’Acord GOV/25/2015.', 'mossos_c5_codi_deontologic', (select id from public.topics where slug = 'mossos-c5-codi-deontologic'), 2, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=238'), 'Guia p. 240, §3', 'Aquest Comitè va proposar el Codi d’ètica de la Policia de Catalunya, que va ser aprovat pel Govern a través de l’Acord GOV/25/2015', null, '3514872eef6d80aa22af0ee9d22d611c2eb00af53194719db20306d979266b57', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '3514872eef6d80aa22af0ee9d22d611c2eb00af53194719db20306d979266b57')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El Comitè d’Ètica de la Policia de Catalunya.', true), ('B', 'El Consell de Seguretat de Catalunya.', false), ('C', 'La Comissió de Policia de Catalunya.', false), ('D', 'El Consell de la Policia.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, per a qui fa extensiva el Codi d’ètica de la Policia de Catalunya, al seu preàmbul, la funció de marc de referència?', 'El preàmbul fa extensiva la funció del Codi com a marc de referència per als vigilants municipals.', 'mossos_c5_codi_deontologic', (select id from public.topics where slug = 'mossos-c5-codi-deontologic'), 3, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=238'), 'Guia p. 240, §4', 'Al seu preàmbul, fa extensiva la seva funció com a marc de referència per als vigilants municipals.', null, '181b82d5714c0f63aa29c4d635258824c0b5531509bd2bee30bb6d126d12f1c3', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '181b82d5714c0f63aa29c4d635258824c0b5531509bd2bee30bb6d126d12f1c3')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Per a les empreses de seguretat privada.', false), ('B', 'Per als vigilants municipals.', true), ('C', 'Per als agents rurals.', false), ('D', 'Per a les forces armades.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, quin caràcter atribueix el Codi d’ètica de la Policia de Catalunya a la funció policial?', 'El Codi atribueix a la funció policial proximitat i atenció a les persones, foment de la convivència i pràctica pedagògica.', 'mossos_c5_codi_deontologic', (select id from public.topics where slug = 'mossos-c5-codi-deontologic'), 2, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf#page=238'), 'Guia p. 240, §7', 'Atribueix a la funció policial el caràcter de proximitat i atenció a les persones, el foment de la convivència i la pràctica pedagògica.', null, 'ca4941e2fadb8a2e68f6aa079e1b7623cf637af5cb04d43a87f5ed804f1a373e', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'ca4941e2fadb8a2e68f6aa079e1b7623cf637af5cb04d43a87f5ed804f1a373e')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El caràcter de força militar i de defensa.', false), ('B', 'El caràcter exclusivament repressiu.', false), ('C', 'El caràcter de proximitat i atenció a les persones, el foment de la convivència i la pràctica pedagògica.', true), ('D', 'El caràcter de servei privat a les institucions.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
commit;
