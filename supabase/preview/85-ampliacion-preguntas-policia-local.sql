-- Ampliació de Policia local de Catalunya: 40 preguntes per tema (460 noves): preguntas en BORRADOR con cita literal de la fuente oficial y fichas de estudio.
-- Generado: bash scripts/content/preview-sql.sh content/policia-local-cat supabase/preview/85-ampliacion-preguntas-policia-local.sql. Idempotente. Solo trae las preguntas nuevas (las de «// Ampliación 11/11/2026» en fuentes-oficiales); las ya cargadas no se tocan.
begin;
-- Lote plcat-t01-constitucio-drets-ce-v1 (20 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Constitución Española (texto consolidado, BOE)', 'https://www.boe.es/buscar/act.php?id=BOE-A-1978-31229', 'boe'::public.source_kind, 'Agencia Estatal Boletín Oficial del Estado', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('plcat-t01-constitucio-drets', 'Tema 1. La Constitució espanyola: títol preliminar i drets i deures fonamentals') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('policia-local') and t.slug = 'plcat-t01-constitucio-drets' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 1.2 de la Constitució, la sobirania nacional resideix:', 'L''article 1.2 CE disposa que la sobirania nacional resideix en el poble espanyol, del qual emanen els poders de l''Estat.', 'plcat_t01_constitucio_drets', (select id from public.topics where slug = 'plcat-t01-constitucio-drets'), 1, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1978-31229'), 'Art. 1.2 CE', '2. La soberanía nacional reside en el pueblo español, del que emanan los poderes del Estado.', null, '4d0b256719b6d10d9dc9d07dee1351bc18681d5ba26d46854fe50a61ecbb04fc', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '4d0b256719b6d10d9dc9d07dee1351bc18681d5ba26d46854fe50a61ecbb04fc')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'En el poble espanyol, del qual emanen els poders de l''Estat.', true), ('B', 'En les Corts Generals, que representen el poble espanyol.', false), ('C', 'En la Corona, com a símbol de la unitat i permanència de l''Estat.', false), ('D', 'En la Nació espanyola i en les nacionalitats i regions que la integren.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 4.1 de la Constitució, la bandera d''Espanya està formada per tres franges horitzontals, vermella, groga i vermella, en què:', 'L''article 4.1 CE estableix que la franja groga és de doble amplada que cadascuna de les vermelles.', 'plcat_t01_constitucio_drets', (select id from public.topics where slug = 'plcat-t01-constitucio-drets'), 1, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1978-31229'), 'Art. 4.1 CE', '1. La bandera de España está formada por tres franjas horizontales, roja, amarilla y roja, siendo la amarilla de doble anchura que cada una de las rojas.', null, '6cf7889b89096b2bbc6690be1c67d8b42801ed0ccde4661adb77e68625b18599', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '6cf7889b89096b2bbc6690be1c67d8b42801ed0ccde4661adb77e68625b18599')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Les tres franges tenen la mateixa amplada.', false), ('B', 'Cadascuna de les vermelles té el doble d''amplada que la groga.', false), ('C', 'La groga té el triple d''amplada que cadascuna de les vermelles.', false), ('D', 'La groga té el doble d''amplada que cadascuna de les vermelles.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'D''acord amb l''article 6 de la Constitució, els partits polítics:', 'L''article 6 CE: els partits expressen el pluralisme polític, concorren a la formació de la voluntat popular i són instrument fonamental per a la participació política. La defensa d''interessos econòmics i socials propis és dels sindicats i associacions empresarials (art. 7).', 'plcat_t01_constitucio_drets', (select id from public.topics where slug = 'plcat-t01-constitucio-drets'), 2, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1978-31229'), 'Art. 6 CE', 'Los partidos políticos expresan el pluralismo político, concurren a la formación y manifestación de la voluntad popular y son instrumento fundamental para la participación política.', null, 'eff40e8473585147ac250f7818973dc00a3eaaccd24bf402d046fee17c1bd921', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'eff40e8473585147ac250f7818973dc00a3eaaccd24bf402d046fee17c1bd921')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Contribueixen a la defensa i promoció dels interessos econòmics i socials que els són propis.', false), ('B', 'Expressen el pluralisme polític i són instrument fonamental per a la participació política.', true), ('C', 'Es poden crear lliurement, però només després de la inscripció en un registre judicial.', false), ('D', 'Han de tenir una estructura interna democràtica només si reben finançament públic.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 8.1 de la Constitució, les Forces Armades estan constituïdes per:', 'L''article 8.1 CE enumera l''Exèrcit de Terra, l''Armada i l''Exèrcit de l''Aire; la Guàrdia Civil és un cos de seguretat, no una branca de les Forces Armades.', 'plcat_t01_constitucio_drets', (select id from public.topics where slug = 'plcat-t01-constitucio-drets'), 1, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1978-31229'), 'Art. 8.1 CE', '1. Las Fuerzas Armadas, constituidas por el Ejército de Tierra, la Armada y el Ejército del Aire, tienen como misión garantizar la soberanía e independencia de España, defender su integridad territorial y el ordenamiento constitucional.', null, '2c926a2c6e244ea5c3a7d293dcdeed70bd3127239b56f4244b5e61a2fe49380b', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '2c926a2c6e244ea5c3a7d293dcdeed70bd3127239b56f4244b5e61a2fe49380b')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'L''Exèrcit de Terra, l''Armada, l''Exèrcit de l''Aire i la Guàrdia Civil.', false), ('B', 'L''Exèrcit de Terra, l''Armada i el Cos Nacional de Policia.', false), ('C', 'L''Exèrcit de Terra, l''Armada i l''Exèrcit de l''Aire.', true), ('D', 'L''Exèrcit de Terra, l''Exèrcit de l''Aire i la Guàrdia Reial.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 9.2 de la Constitució, promoure les condicions perquè la llibertat i la igualtat de l''individu i dels grups en què s''integra siguin reals i efectives correspon:', 'L''article 9.2 CE atribueix als poders públics promoure aquestes condicions, remoure els obstacles i facilitar la participació de tots els ciutadans.', 'plcat_t01_constitucio_drets', (select id from public.topics where slug = 'plcat-t01-constitucio-drets'), 2, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1978-31229'), 'Art. 9.2 CE', '2. Corresponde a los poderes públicos promover las condiciones para que la libertad y la igualdad del individuo y de los grupos en que se integra sean reales y efectivas', null, '342a07a155f039cde7605ae86ef8dc2c1cbdc332623c4e90a90383f22009dee9', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '342a07a155f039cde7605ae86ef8dc2c1cbdc332623c4e90a90383f22009dee9')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Exclusivament a l''Estat.', false), ('B', 'Als ciutadans i als grups socials.', false), ('C', 'Als poders públics.', true), ('D', 'Al Defensor del Poble.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 11.2 de la Constitució:', 'L''article 11.2 CE prohibeix privar de la nacionalitat els espanyols d''origen; per a la resta, l''adquisició, conservació i pèrdua es regeix per la llei (art. 11.1).', 'plcat_t01_constitucio_drets', (select id from public.topics where slug = 'plcat-t01-constitucio-drets'), 2, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1978-31229'), 'Art. 11.2 CE', '2. Ningún español de origen podrá ser privado de su nacionalidad.', null, 'c99743eafe703e4dec51e0da10396e43d035ba39ffdcd97f485b24d2fdfa6391', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'c99743eafe703e4dec51e0da10396e43d035ba39ffdcd97f485b24d2fdfa6391')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Cap espanyol, d''origen o no, no pot perdre la nacionalitat espanyola.', false), ('B', 'Els espanyols d''origen només poden ser privats de la nacionalitat per resolució judicial.', false), ('C', 'Els espanyols d''origen perden la nacionalitat si adquireixen voluntàriament una altra.', false), ('D', 'Cap espanyol d''origen no pot ser privat de la nacionalitat.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 12 de la Constitució, els espanyols són majors d''edat:', 'L''article 12 CE fixa directament la majoria d''edat als divuit anys.', 'plcat_t01_constitucio_drets', (select id from public.topics where slug = 'plcat-t01-constitucio-drets'), 1, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1978-31229'), 'Art. 12 CE', 'Los españoles son mayores de edad a los dieciocho años.', null, '91660e66516468cacd940b09a32f68f72b64d03acb75feae7e5a49c16a5714b4', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '91660e66516468cacd940b09a32f68f72b64d03acb75feae7e5a49c16a5714b4')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Als divuit anys.', true), ('B', 'Als setze anys.', false), ('C', 'Als vint-i-un anys.', false), ('D', 'A l''edat que fixi el Codi civil.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 13.2 de la Constitució, els drets de l''article 23 són exclusius dels espanyols, excepte el que, atenent criteris de reciprocitat, es pugui establir per tractat o llei per al dret de sufragi:', 'L''article 13.2 CE, reformat el 1992, permet per tractat o llei, amb reciprocitat, el sufragi actiu i passiu dels estrangers en les eleccions municipals.', 'plcat_t01_constitucio_drets', (select id from public.topics where slug = 'plcat-t01-constitucio-drets'), 3, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1978-31229'), 'Art. 13.2 CE', '2. Solamente los españoles serán titulares de los derechos reconocidos en el artículo 23, salvo lo que, atendiendo a criterios de reciprocidad, pueda establecerse por tratado o ley para el derecho de sufragio activo y pasivo en las elecciones municipales.', null, '4aa2d291275e34da02a4c844067f1724fa0dff050fea593bbb4d82497d5172ed', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '4aa2d291275e34da02a4c844067f1724fa0dff050fea593bbb4d82497d5172ed')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Només actiu en les eleccions municipals.', false), ('B', 'Actiu i passiu en les eleccions municipals.', true), ('C', 'Actiu i passiu en les eleccions municipals i autonòmiques.', false), ('D', 'Actiu en les eleccions municipals i al Parlament Europeu.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 13.3 de la Constitució, pel que fa a l''extradició:', 'L''article 13.3 CE exigeix tractat o llei i reciprocitat, i exclou els delictes polítics, sense considerar com a tals els actes de terrorisme.', 'plcat_t01_constitucio_drets', (select id from public.topics where slug = 'plcat-t01-constitucio-drets'), 2, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1978-31229'), 'Art. 13.3 CE', 'Quedan excluidos de la extradición los delitos políticos, no considerándose como tales los actos de terrorismo.', null, 'd90acb8bae1ca3dd534b34d4f7448e1cb2a7020c21e409693b5239467007930e', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'd90acb8bae1ca3dd534b34d4f7448e1cb2a7020c21e409693b5239467007930e')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'En queden exclosos els delictes polítics, inclosos els actes de terrorisme.', false), ('B', 'Es pot concedir sense tractat ni llei si hi ha reciprocitat.', false), ('C', 'Només la pot concedir el Tribunal Constitucional.', false), ('D', 'En queden exclosos els delictes polítics, però no es consideren com a tals els actes de terrorisme.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Quin d''aquests motius de discriminació NO esmenta expressament l''article 14 de la Constitució (encara que quedi inclòs en la clàusula general de «qualsevol altra condició»)?', 'L''article 14 CE esmenta el naixement, la raça, el sexe, la religió i l''opinió, i després hi afegeix «qualsevol altra condició o circumstància personal o social».', 'plcat_t01_constitucio_drets', (select id from public.topics where slug = 'plcat-t01-constitucio-drets'), 2, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1978-31229'), 'Art. 14 CE', 'sin que pueda prevalecer discriminación alguna por razón de nacimiento, raza, sexo, religión, opinión o cualquier otra condición o circunstancia personal o social.', null, 'ebc5e70cd26abe30e2a848097bf2e4027cd5faedaf040404056c4312cf308d07', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'ebc5e70cd26abe30e2a848097bf2e4027cd5faedaf040404056c4312cf308d07')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'L''edat.', true), ('B', 'El naixement.', false), ('C', 'La religió.', false), ('D', 'L''opinió.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 16.3 de la Constitució:', 'L''article 16.3 CE declara que cap confessió no té caràcter estatal, si bé els poders públics mantenen relacions de cooperació amb l''Església catòlica i les altres confessions.', 'plcat_t01_constitucio_drets', (select id from public.topics where slug = 'plcat-t01-constitucio-drets'), 1, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1978-31229'), 'Art. 16.3 CE', '3. Ninguna confesión tendrá carácter estatal.', null, '009c915fe1e2ab66cce94863151d974778a60129013474d65802ee29a6a1608a', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '009c915fe1e2ab66cce94863151d974778a60129013474d65802ee29a6a1608a')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'La religió catòlica és la religió oficial de l''Estat.', false), ('B', 'Cap confessió no té caràcter estatal.', true), ('C', 'Els poders públics no poden mantenir relacions de cooperació amb cap confessió.', false), ('D', 'Només les confessions inscrites tenen caràcter estatal.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 17.4 de la Constitució, el procediment d''«habeas corpus» té per finalitat:', 'L''article 17.4 CE remet a la llei un procediment d''habeas corpus per posar immediatament a disposició judicial qui hagi estat detingut il·legalment.', 'plcat_t01_constitucio_drets', (select id from public.topics where slug = 'plcat-t01-constitucio-drets'), 2, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1978-31229'), 'Art. 17.4 CE', '4. La ley regulará un procedimiento de «habeas corpus» para producir la inmediata puesta a disposición judicial de toda persona detenida ilegalmente.', null, '925c11ae182f8096755127f6b0befa50caaead046ff8bc762d056e378f1c35e7', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '925c11ae182f8096755127f6b0befa50caaead046ff8bc762d056e378f1c35e7')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Fixar el termini màxim de la presó provisional.', false), ('B', 'Garantir l''assistència d''advocat al detingut en les diligències policials.', false), ('C', 'Produir la posada immediata a disposició judicial de tota persona detinguda il·legalment.', true), ('D', 'Permetre al detingut recórrer en empara davant el Tribunal Constitucional.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 18.3 de la Constitució, es garanteix el secret de les comunicacions, especialment de les postals, telegràfiques i telefòniques:', 'L''article 18.3 CE només admet la intervenció de les comunicacions per resolució judicial; el flagrant delicte és una excepció a la inviolabilitat del domicili (art. 18.2).', 'plcat_t01_constitucio_drets', (select id from public.topics where slug = 'plcat-t01-constitucio-drets'), 1, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1978-31229'), 'Art. 18.3 CE', '3. Se garantiza el secreto de las comunicaciones y, en especial, de las postales, telegráficas y telefónicas, salvo resolución judicial.', null, '78373dabc58b69021aa3b7859bbc0ddd55f9c8a7e38291d98e082f7eb09ea80b', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '78373dabc58b69021aa3b7859bbc0ddd55f9c8a7e38291d98e082f7eb09ea80b')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Llevat d''ordre del ministre de l''Interior.', false), ('B', 'Llevat de resolució judicial.', true), ('C', 'Llevat de cas de flagrant delicte.', false), ('D', 'Llevat d''autorització del Ministeri Fiscal.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 20.5 de la Constitució, el segrest de publicacions, enregistraments i altres mitjans d''informació:', 'L''article 20.5 CE reserva el segrest de publicacions i altres mitjans d''informació a la resolució judicial.', 'plcat_t01_constitucio_drets', (select id from public.topics where slug = 'plcat-t01-constitucio-drets'), 2, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1978-31229'), 'Art. 20.5 CE', '5. Sólo podrá acordarse el secuestro de publicaciones, grabaciones y otros medios de información en virtud de resolución judicial.', null, '0e238ca1b9f6c8fd2e6f9e7a27ef1a9488cbcd905b2cef72258b0ed4bc0c6bd2', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '0e238ca1b9f6c8fd2e6f9e7a27ef1a9488cbcd905b2cef72258b0ed4bc0c6bd2')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El pot acordar l''autoritat governativa per raons d''ordre públic.', false), ('B', 'Està prohibit en tot cas.', false), ('C', 'El pot acordar el Govern amb comunicació posterior a les Corts.', false), ('D', 'Només es pot acordar en virtut de resolució judicial.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 22.5 de la Constitució, queden prohibides:', 'L''article 22.5 CE prohibeix les associacions secretes i les paramilitars; la inscripció registral és només a efectes de publicitat (art. 22.3).', 'plcat_t01_constitucio_drets', (select id from public.topics where slug = 'plcat-t01-constitucio-drets'), 2, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1978-31229'), 'Art. 22.5 CE', '5. Se prohíben las asociaciones secretas y las de carácter paramilitar.', null, '2870e7c41eaf86629fedd3b814b78c76e2896537dacccae31f6088ef84943d97', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '2870e7c41eaf86629fedd3b814b78c76e2896537dacccae31f6088ef84943d97')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Les associacions secretes i les de caràcter paramilitar.', true), ('B', 'Les associacions no inscrites en un registre.', false), ('C', 'Les associacions de caràcter religiós.', false), ('D', 'Les associacions de membres de cossos de seguretat.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 22.3 de la Constitució, les associacions s''han d''inscriure en un registre:', 'L''article 22.3 CE exigeix la inscripció a l''únic efecte de publicitat.', 'plcat_t01_constitucio_drets', (select id from public.topics where slug = 'plcat-t01-constitucio-drets'), 3, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1978-31229'), 'Art. 22.3 CE', '3. Las asociaciones constituidas al amparo de este artículo deberán inscribirse en un registro a los solos efectos de publicidad.', null, 'c032d3bb8bbb15067d965ab76f967e282b6b57cd9a5003bdce670d85d2fae6c4', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'c032d3bb8bbb15067d965ab76f967e282b6b57cd9a5003bdce670d85d2fae6c4')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Com a requisit per adquirir existència legal.', false), ('B', 'A efectes de control de la legalitat dels seus fins.', false), ('C', 'Només a efectes de publicitat.', true), ('D', 'Només si persegueixen fins d''interès general.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Quin d''aquests drets NO figura entre els que reconeix l''article 24.2 de la Constitució?', 'L''article 24.2 CE enumera, entre altres, el jutge ordinari predeterminat per la llei, la defensa, no declarar contra si mateix i la presumpció d''innocència; el jurat no hi figura.', 'plcat_t01_constitucio_drets', (select id from public.topics where slug = 'plcat-t01-constitucio-drets'), 2, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1978-31229'), 'Art. 24.2 CE', 'Asimismo, todos tienen derecho al Juez ordinario predeterminado por la ley, a la defensa y a la asistencia de letrado, a ser informados de la acusación formulada contra ellos, a un proceso público sin dilaciones indebidas y con todas las garantías, a utilizar los medios de prueba pertinentes para su defensa, a no declarar contra sí mismos, a no confesarse culpables y a la presunción de inocencia.', null, 'fe77a5c1efc30a2e6ec869a6c96c99468733998c61c5abc1cc1aa3bb4255df26', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'fe77a5c1efc30a2e6ec869a6c96c99468733998c61c5abc1cc1aa3bb4255df26')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El dret al jutge ordinari predeterminat per la llei.', false), ('B', 'El dret a no declarar contra si mateix.', false), ('C', 'El dret a ser jutjat per un jurat popular.', true), ('D', 'El dret a la presumpció d''innocència.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 26 de la Constitució, els tribunals d''honor estan prohibits:', 'L''article 26 CE prohibeix els tribunals d''honor en l''Administració civil i en les organitzacions professionals.', 'plcat_t01_constitucio_drets', (select id from public.topics where slug = 'plcat-t01-constitucio-drets'), 3, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1978-31229'), 'Art. 26 CE', 'Se prohíben los Tribunales de Honor en el ámbito de la Administración civil y de las organizaciones profesionales.', null, '509a49e4136b6e4ccb3e66b30ec13bf0c25c451ae7a5780f7e8b4b843fea866f', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '509a49e4136b6e4ccb3e66b30ec13bf0c25c451ae7a5780f7e8b4b843fea866f')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'En l''àmbit de les Forces Armades i de l''Administració civil.', false), ('B', 'En qualsevol àmbit, sense excepció.', false), ('C', 'Només en l''àmbit dels col·legis professionals.', false), ('D', 'En l''àmbit de l''Administració civil i de les organitzacions professionals.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 53.1 de la Constitució, l''exercici dels drets i llibertats del capítol segon del títol I:', 'L''article 53.1 CE estableix la reserva de llei i el respecte al contingut essencial dels drets i llibertats del capítol segon.', 'plcat_t01_constitucio_drets', (select id from public.topics where slug = 'plcat-t01-constitucio-drets'), 3, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1978-31229'), 'Art. 53.1 CE', 'Sólo por ley, que en todo caso deberá respetar su contenido esencial, podrá regularse el ejercicio de tales derechos y libertades', null, '59358d826cf2968d8327eca5f831af0df307854168d815150f1fd7113b29c260', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '59358d826cf2968d8327eca5f831af0df307854168d815150f1fd7113b29c260')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Es pot regular per llei o per reglament, sempre que se''n respecti el contingut essencial.', false), ('B', 'Només es pot regular per llei, que n''ha de respectar en tot cas el contingut essencial.', true), ('C', 'Només es pot regular per llei orgànica aprovada per majoria de tres cinquenes parts.', false), ('D', 'Es pot regular per decret llei en cas d''extraordinària i urgent necessitat.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 53.3 de la Constitució, els principis rectors de la política social i econòmica del capítol tercer:', 'L''article 53.3 CE: els principis del capítol tercer informen la legislació, la pràctica judicial i l''actuació dels poders públics, i només es poden al·legar davant la jurisdicció ordinària segons les lleis que els despleguin.', 'plcat_t01_constitucio_drets', (select id from public.topics where slug = 'plcat-t01-constitucio-drets'), 3, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1978-31229'), 'Art. 53.3 CE', 'Sólo podrán ser alegados ante la Jurisdicción ordinaria de acuerdo con lo que dispongan las leyes que los desarrollen.', null, '179685cf2cbf79f947dabe989f0657255caba6faad4f3d5544aa8f75607c69d9', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '179685cf2cbf79f947dabe989f0657255caba6faad4f3d5544aa8f75607c69d9')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Només es poden al·legar davant la jurisdicció ordinària d''acord amb el que disposin les lleis que els despleguin.', true), ('B', 'Es poden al·legar directament davant els tribunals ordinaris pel procediment preferent i sumari.', false), ('C', 'Són tutelables mitjançant el recurs d''empara davant el Tribunal Constitucional.', false), ('D', 'No vinculen la pràctica judicial ni l''actuació dels poders públics.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
-- Lote plcat-t02-constitucio-organitzacio-territorial-ce-v1 (20 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Constitución Española (texto consolidado, BOE)', 'https://www.boe.es/buscar/act.php?id=BOE-A-1978-31229', 'boe'::public.source_kind, 'Agencia Estatal Boletín Oficial del Estado', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('plcat-t02-constitucio-organitzacio-territorial', 'Tema 2. La Constitució espanyola: organització territorial, administració local i forces i cossos de seguretat') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('policia-local') and t.slug = 'plcat-t02-constitucio-organitzacio-territorial' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 140 de la Constitució, els municipis:', 'L''article 140 CE garanteix l''autonomia dels municipis i els reconeix personalitat jurídica plena; el govern i l''administració corresponen als ajuntaments.', 'plcat_t02_constitucio_organitzacio_territorial', (select id from public.topics where slug = 'plcat-t02-constitucio-organitzacio-territorial'), 1, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1978-31229'), 'Art. 140 CE', 'La Constitución garantiza la autonomía de los municipios. Estos gozarán de personalidad jurídica plena.', null, 'cb7086f4dd8bc7ca733664fa77883fd72ef6a60515bd648d2b91bccaf670b58a', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'cb7086f4dd8bc7ca733664fa77883fd72ef6a60515bd648d2b91bccaf670b58a')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Gaudeixen de personalitat jurídica plena.', true), ('B', 'Gaudeixen de personalitat jurídica delegada de la província.', false), ('C', 'No tenen personalitat jurídica pròpia, que correspon a l''ajuntament.', false), ('D', 'Tenen personalitat jurídica limitada a la gestió dels serveis obligatoris.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 141.4 de la Constitució, als arxipèlags les illes tenen, a més, administració pròpia en forma de:', 'L''article 141.4 CE preveu que, als arxipèlags, les illes tinguin administració pròpia en forma de cabildos o consells.', 'plcat_t02_constitucio_organitzacio_territorial', (select id from public.topics where slug = 'plcat-t02-constitucio-organitzacio-territorial'), 1, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1978-31229'), 'Art. 141.4 CE', '4. En los archipiélagos, las islas tendrán además su administración propia en forma de Cabildos o Consejos.', null, '522cf25a4a7ded7008ffed7df87ac7ccd7f8bae2f6864cd48d03fdc4cf94c8bd', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '522cf25a4a7ded7008ffed7df87ac7ccd7f8bae2f6864cd48d03fdc4cf94c8bd')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Diputacions insulars o vegueries.', false), ('B', 'Mancomunitats insulars.', false), ('C', 'Cabildos o consells.', true), ('D', 'Comarques o àrees metropolitanes.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 154 de la Constitució, qui dirigeix l''Administració de l''Estat en el territori de la comunitat autònoma?', 'L''article 154 CE: un delegat nomenat pel Govern dirigeix l''Administració de l''Estat al territori de la comunitat i la coordina, quan escaigui, amb l''administració autonòmica.', 'plcat_t02_constitucio_organitzacio_territorial', (select id from public.topics where slug = 'plcat-t02-constitucio-organitzacio-territorial'), 1, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1978-31229'), 'Art. 154 CE', 'Un Delegado nombrado por el Gobierno dirigirá la Administración del Estado en el territorio de la Comunidad Autónoma', null, '54bafd2d4e1d4af1981afb2e47bc740ef060ca5ab9bd82106140c8c217296c8d', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '54bafd2d4e1d4af1981afb2e47bc740ef060ca5ab9bd82106140c8c217296c8d')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El president de la comunitat autònoma, com a representant ordinari de l''Estat.', false), ('B', 'Un delegat nomenat pel Govern.', true), ('C', 'Un delegat elegit pel Parlament autonòmic.', false), ('D', 'El subdelegat del Govern de la província capital.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 147.1 de la Constitució, els estatuts d''autonomia són:', 'L''article 147.1 CE defineix els estatuts com la norma institucional bàsica de cada comunitat, que l''Estat reconeix i empara com a part del seu ordenament.', 'plcat_t02_constitucio_organitzacio_territorial', (select id from public.topics where slug = 'plcat-t02-constitucio-organitzacio-territorial'), 1, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1978-31229'), 'Art. 147.1 CE', 'los Estatutos serán la norma institucional básica de cada Comunidad Autónoma', null, '6645175663526f8bdf38184f92b4419a66ff2665caeeb9fcd998f7a674ba4aeb', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '6645175663526f8bdf38184f92b4419a66ff2665caeeb9fcd998f7a674ba4aeb')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Lleis ordinàries de les Corts Generals sense cap rang especial.', false), ('B', 'Normes reglamentàries aprovades pel Govern de l''Estat.', false), ('C', 'Tractats entre l''Estat i cada comunitat autònoma.', false), ('D', 'La norma institucional bàsica de cada comunitat autònoma.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 139.1 de la Constitució, tots els espanyols:', 'L''article 139.1 CE consagra la igualtat de drets i obligacions de tots els espanyols en tot el territori de l''Estat.', 'plcat_t02_constitucio_organitzacio_territorial', (select id from public.topics where slug = 'plcat-t02-constitucio-organitzacio-territorial'), 1, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1978-31229'), 'Art. 139.1 CE', '1. Todos los españoles tienen los mismos derechos y obligaciones en cualquier parte del territorio del Estado.', null, '1e9e50f6ff9f01f2322733c30c7c4c938df34e1038eb47e05a97a8d3ebebdda4', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '1e9e50f6ff9f01f2322733c30c7c4c938df34e1038eb47e05a97a8d3ebebdda4')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Tenen els drets que els reconegui l''estatut de la comunitat on resideixen.', false), ('B', 'Tenen els mateixos drets, però les obligacions varien segons la comunitat autònoma.', false), ('C', 'Han de residir a la comunitat autònoma on estan empadronats.', false), ('D', 'Tenen els mateixos drets i obligacions en qualsevol part del territori de l''Estat.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 149.1.26a de la Constitució, el règim de producció, comerç, tinença i ús d''armes i explosius és:', 'L''article 149.1.26a CE reserva a l''Estat, en exclusiva, el règim d''armes i explosius.', 'plcat_t02_constitucio_organitzacio_territorial', (select id from public.topics where slug = 'plcat-t02-constitucio-organitzacio-territorial'), 1, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1978-31229'), 'Art. 149.1.26 CE', '26.ª Régimen de producción, comercio, tenencia y uso de armas y explosivos.', null, '74a6e2024f304eed1dfdd99dcd92b83fe5ffa0c95a26ece95ac0a018794064e0', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '74a6e2024f304eed1dfdd99dcd92b83fe5ffa0c95a26ece95ac0a018794064e0')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Competència exclusiva de l''Estat.', true), ('B', 'Competència compartida entre l''Estat i les comunitats autònomes.', false), ('C', 'Competència que poden assumir les comunitats autònomes.', false), ('D', 'Competència dels municipis en l''àmbit de la seguretat ciutadana.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 103.1 de la Constitució, l''Administració pública:', 'L''article 103.1 CE estableix que l''Administració serveix amb objectivitat els interessos generals i actua amb submissió plena a la llei i al dret.', 'plcat_t02_constitucio_organitzacio_territorial', (select id from public.topics where slug = 'plcat-t02-constitucio-organitzacio-territorial'), 2, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1978-31229'), 'Art. 103.1 CE', '1. La Administración Pública sirve con objetividad los intereses generales y actúa de acuerdo con los principios de eficacia, jerarquía, descentralización, desconcentración y coordinación, con sometimiento pleno a la ley y al Derecho.', null, 'e2f2b0008bf7735a9810bd9cd34938cd91831965c2b8192cd39cdb35fa27b4d9', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'e2f2b0008bf7735a9810bd9cd34938cd91831965c2b8192cd39cdb35fa27b4d9')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Serveix els interessos del Govern, amb submissió plena a les seves directrius.', false), ('B', 'Serveix amb neutralitat els interessos dels ciutadans, amb submissió a la Constitució.', false), ('C', 'Serveix amb objectivitat els interessos generals, amb submissió plena a la llei i al dret.', true), ('D', 'Serveix amb eficàcia els interessos públics, amb submissió als reglaments.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 105.b) de la Constitució, quina d''aquestes matèries NO s''esmenta com a excepció a l''accés dels ciutadans als arxius i registres administratius?', 'L''article 105.b) CE exceptua de l''accés la seguretat i defensa de l''Estat, l''averiguació dels delictes i la intimitat de les persones; no esmenta les relacions internacionals.', 'plcat_t02_constitucio_organitzacio_territorial', (select id from public.topics where slug = 'plcat-t02-constitucio-organitzacio-territorial'), 2, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1978-31229'), 'Art. 105.b CE', 'b) El acceso de los ciudadanos a los archivos y registros administrativos, salvo en lo que afecte a la seguridad y defensa del Estado, la averiguación de los delitos y la intimidad de las personas.', null, '86e12be26ef622c6136bfc7cc5569b8ba3499ebb41e6881638dbdc9483e551fd', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '86e12be26ef622c6136bfc7cc5569b8ba3499ebb41e6881638dbdc9483e551fd')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'La seguretat i defensa de l''Estat.', false), ('B', 'Les relacions internacionals.', true), ('C', 'L''averiguació dels delictes.', false), ('D', 'La intimitat de les persones.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 106.1 de la Constitució, qui controla la potestat reglamentària i la legalitat de l''actuació administrativa?', 'L''article 106.1 CE atribueix als tribunals el control de la potestat reglamentària, de la legalitat de l''actuació administrativa i de la seva submissió als fins que la justifiquen.', 'plcat_t02_constitucio_organitzacio_territorial', (select id from public.topics where slug = 'plcat-t02-constitucio-organitzacio-territorial'), 2, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1978-31229'), 'Art. 106.1 CE', '1. Los Tribunales controlan la potestad reglamentaria y la legalidad de la actuación administrativa, así como el sometimiento de ésta a los fines que la justifican.', null, 'e40637a4cf267e1b31029932e6c98abf636ca7dde8384a55ba00db3825cadeca', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'e40637a4cf267e1b31029932e6c98abf636ca7dde8384a55ba00db3825cadeca')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El Defensor del Poble.', false), ('B', 'Els tribunals.', true), ('C', 'El Consell d''Estat.', false), ('D', 'El Tribunal de Comptes.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 116.4 de la Constitució, l''estat de setge el declara:', 'L''article 116.4 CE: l''estat de setge el declara la majoria absoluta del Congrés, a proposta exclusiva del Govern; el Congrés en determina l''àmbit, la durada i les condicions.', 'plcat_t02_constitucio_organitzacio_territorial', (select id from public.topics where slug = 'plcat-t02-constitucio-organitzacio-territorial'), 2, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1978-31229'), 'Art. 116.4 CE', '4. El estado de sitio será declarado por la mayoría absoluta del Congreso de los Diputados, a propuesta exclusiva del Gobierno.', null, 'c0cdcbc7df875dcb37ddcb826080532b737f691cd5a10edc5147032d7e49c6a8', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'c0cdcbc7df875dcb37ddcb826080532b737f691cd5a10edc5147032d7e49c6a8')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El Govern mitjançant decret, amb l''autorització prèvia del Congrés.', false), ('B', 'Les Corts Generals per majoria de tres cinquenes parts, a proposta del Rei.', false), ('C', 'El Congrés dels Diputats per majoria absoluta, a proposta exclusiva del Govern.', true), ('D', 'El Senat per majoria absoluta, a proposta del Govern.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 140 de la Constitució, la regulació de les condicions en què escau el règim de consell obert correspon:', 'L''article 140 CE remet a la llei la regulació de les condicions en què escau el règim de consell obert («concejo abierto»).', 'plcat_t02_constitucio_organitzacio_territorial', (select id from public.topics where slug = 'plcat-t02-constitucio-organitzacio-territorial'), 2, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1978-31229'), 'Art. 140 CE', 'La ley regulará las condiciones en las que proceda el régimen del concejo abierto.', null, '0a5b57fddef1c8e70e1343fa10143a018718862657352d6bb6baf07120f6f71b', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '0a5b57fddef1c8e70e1343fa10143a018718862657352d6bb6baf07120f6f71b')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Al reglament orgànic de cada ajuntament.', false), ('B', 'Al ple de l''ajuntament per majoria absoluta.', false), ('C', 'A l''estatut d''autonomia de cada comunitat.', false), ('D', 'A la llei.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 141.3 de la Constitució:', 'L''article 141.3 CE admet la creació d''agrupacions de municipis diferents de la província.', 'plcat_t02_constitucio_organitzacio_territorial', (select id from public.topics where slug = 'plcat-t02-constitucio-organitzacio-territorial'), 2, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1978-31229'), 'Art. 141.3 CE', '3. Se podrán crear agrupaciones de municipios diferentes de la provincia.', null, 'a407c65066298506071b5a88ff19255233704d652dc61f7878bff81684dc2432', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'a407c65066298506071b5a88ff19255233704d652dc61f7878bff81684dc2432')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Es poden crear agrupacions de municipis diferents de la província.', true), ('B', 'Les agrupacions de municipis han de coincidir amb els límits provincials.', false), ('C', 'Només les comunitats uniprovincials poden crear agrupacions de municipis.', false), ('D', 'Les agrupacions de municipis requereixen una llei orgànica de les Corts Generals.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 148.2 de la Constitució, les comunitats autònomes poden ampliar successivament les seves competències dins el marc de l''article 149:', 'L''article 148.2 CE exigeix el transcurs de cinc anys i la reforma estatutària per ampliar competències.', 'plcat_t02_constitucio_organitzacio_territorial', (select id from public.topics where slug = 'plcat-t02-constitucio-organitzacio-territorial'), 2, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1978-31229'), 'Art. 148.2 CE', '2. Transcurridos cinco años, y mediante la reforma de sus Estatutos, las Comunidades Autónomas podrán ampliar sucesivamente sus competencias dentro del marco establecido en el artículo 149.', null, '1795945d85e248209a56f8b6571024f7ac5a206f2afed8c7a9d956729d973667', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '1795945d85e248209a56f8b6571024f7ac5a206f2afed8c7a9d956729d973667')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Un cop transcorreguts tres anys i mitjançant llei orgànica de transferència.', false), ('B', 'Un cop transcorreguts cinc anys i mitjançant la reforma dels seus estatuts.', true), ('C', 'En qualsevol moment, mitjançant llei del Parlament autonòmic.', false), ('D', 'Un cop transcorreguts deu anys i mitjançant referèndum.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Quina d''aquestes matèries NO és competència exclusiva de l''Estat segons l''article 149.1 de la Constitució, sinó una de les que poden assumir les comunitats autònomes segons l''article 148.1?', 'L''assistència social és a l''article 148.1.20a CE; el trànsit i la circulació de vehicles de motor (149.1.21a), la nacionalitat i l''estrangeria (149.1.2a) i l''Administració de justícia (149.1.5a) són competències exclusives de l''Estat.', 'plcat_t02_constitucio_organitzacio_territorial', (select id from public.topics where slug = 'plcat-t02-constitucio-organitzacio-territorial'), 2, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1978-31229'), 'Art. 148.1.20 i 149.1 CE', '20.ª Asistencia social. […] tráfico y circulación de vehículos a motor […] 2.ª Nacionalidad, inmigración, emigración, extranjería y derecho de asilo. […] 5.ª Administración de Justicia.', null, 'd9b80d6ec3b1ac2062ec18d29795c9331444676150fa0468eb7bd8a00958795b', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'd9b80d6ec3b1ac2062ec18d29795c9331444676150fa0468eb7bd8a00958795b')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El trànsit i la circulació de vehicles de motor.', false), ('B', 'La nacionalitat, la immigració i l''estrangeria.', false), ('C', 'L''assistència social.', true), ('D', 'L''Administració de justícia.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 153 de la Constitució, el control de l''administració autònoma i de les seves normes reglamentàries l''exerceix:', 'L''article 153.c) CE atribueix aquest control a la jurisdicció contenciosa administrativa; el Tribunal Constitucional controla les normes amb força de llei, el Govern les funcions delegades i el Tribunal de Comptes l''econòmic i pressupostari.', 'plcat_t02_constitucio_organitzacio_territorial', (select id from public.topics where slug = 'plcat-t02-constitucio-organitzacio-territorial'), 2, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1978-31229'), 'Art. 153.c CE', 'c) Por la jurisdicción contencioso-administrativa, el de la administración autónoma y sus normas reglamentarias.', null, '372deeb056a555834cf07825acb66bed4b4d461a689c9b96f1ee031ba0374f04', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '372deeb056a555834cf07825acb66bed4b4d461a689c9b96f1ee031ba0374f04')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El Tribunal Constitucional.', false), ('B', 'El Govern, amb el dictamen previ del Consell d''Estat.', false), ('C', 'El Tribunal de Comptes.', false), ('D', 'La jurisdicció contenciosa administrativa.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 143.2 de la Constitució, la iniciativa del procés autonòmic correspon a totes les diputacions interessades o a l''òrgan interinsular corresponent i a:', 'L''article 143.2 CE exigeix les dues terceres parts dels municipis que representin la majoria del cens de cada província o illa, en el termini de sis mesos; les tres quartes parts i el referèndum són de la via de l''article 151.', 'plcat_t02_constitucio_organitzacio_territorial', (select id from public.topics where slug = 'plcat-t02-constitucio-organitzacio-territorial'), 3, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1978-31229'), 'Art. 143.2 CE', '2. La iniciativa del proceso autonómico corresponde a todas las Diputaciones interesadas o al órgano interinsular correspondiente y a las dos terceras partes de los municipios cuya población represente, al menos, la mayoría del censo electoral de cada provincia o isla.', null, 'eb51d884124f330f619f81b3394fc8fc7065ebd64165ad1099e1513850e3c343', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'eb51d884124f330f619f81b3394fc8fc7065ebd64165ad1099e1513850e3c343')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Les dues terceres parts dels municipis la població dels quals representi, almenys, la majoria del cens electoral de cada província o illa.', true), ('B', 'Les tres quartes parts dels municipis de cada província, amb ratificació en referèndum.', false), ('C', 'La majoria absoluta dels municipis, sigui quina sigui la població que representin.', false), ('D', 'Les dues terceres parts dels diputats i senadors elegits a les províncies afectades.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 150.3 de la Constitució, la necessitat de dictar lleis d''harmonització de les disposicions normatives de les comunitats autònomes l''aprecien:', 'L''article 150.3 CE atribueix a les Corts Generals, per majoria absoluta de cada cambra, l''apreciació de la necessitat d''harmonitzar quan ho exigeixi l''interès general.', 'plcat_t02_constitucio_organitzacio_territorial', (select id from public.topics where slug = 'plcat-t02-constitucio-organitzacio-territorial'), 3, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1978-31229'), 'Art. 150.3 CE', 'Corresponde a las Cortes Generales, por mayoría absoluta de cada Cámara, la apreciación de esta necesidad.', null, '85e67d479961e6a0256d663b2d4b482d8f23f69270b83a1a9404f195bd917b2e', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '85e67d479961e6a0256d663b2d4b482d8f23f69270b83a1a9404f195bd917b2e')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El Congrés dels Diputats, per majoria simple.', false), ('B', 'El Senat, per majoria de tres cinquenes parts.', false), ('C', 'Les Corts Generals, per majoria absoluta de cada cambra.', true), ('D', 'El Govern, amb el dictamen previ del Consell d''Estat.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 151.1 de la Constitució, per no haver d''esperar el termini de cinc anys de l''article 148.2, la iniciativa autonòmica ha de ser ratificada mitjançant referèndum:', 'L''article 151.1 CE, a més de les tres quartes parts dels municipis, exigeix la ratificació en referèndum per majoria absoluta dels electors de cada província.', 'plcat_t02_constitucio_organitzacio_territorial', (select id from public.topics where slug = 'plcat-t02-constitucio-organitzacio-territorial'), 3, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1978-31229'), 'Art. 151.1 CE', 'dicha iniciativa sea ratificada mediante referéndum por el voto afirmativo de la mayoría absoluta de los electores de cada provincia', null, '0647b5dde975c0b4d8ae7869b5dda30ad0ee3323bbe1b168df92c03d56ecb52a', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '0647b5dde975c0b4d8ae7869b5dda30ad0ee3323bbe1b168df92c03d56ecb52a')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Pel vot afirmatiu de la majoria dels vots vàlidament emesos en el conjunt del territori.', false), ('B', 'Pel vot afirmatiu de la majoria absoluta dels electors de cada província.', true), ('C', 'Pel vot afirmatiu de les dues terceres parts dels electors de cada província.', false), ('D', 'Pel vot afirmatiu de la majoria simple dels votants de cada municipi.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 155.2 de la Constitució, per executar les mesures previstes a l''apartat 1, el Govern:', 'L''article 155.2 CE permet al Govern donar instruccions a totes les autoritats de les comunitats autònomes per executar les mesures aprovades.', 'plcat_t02_constitucio_organitzacio_territorial', (select id from public.topics where slug = 'plcat-t02-constitucio-organitzacio-territorial'), 3, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1978-31229'), 'Art. 155.2 CE', '2. Para la ejecución de las medidas previstas en el apartado anterior, el Gobierno podrá dar instrucciones a todas las autoridades de las Comunidades Autónomas.', null, '7a021feb911b346f1b6f5452382ce5e7fa487e6e0323af74fd10e4ccc867e883', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '7a021feb911b346f1b6f5452382ce5e7fa487e6e0323af74fd10e4ccc867e883')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Pot donar instruccions a totes les autoritats de les comunitats autònomes.', true), ('B', 'Només pot donar instruccions al president de la comunitat autònoma.', false), ('C', 'Ha de sol·licitar l''autorització del Tribunal Constitucional per a cada instrucció.', false), ('D', 'Pot dissoldre el Parlament autonòmic sense aprovació del Senat.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 116.5 de la Constitució, si el Congrés està dissolt o ha expirat el seu mandat i es produeix una situació que dona lloc a algun dels estats d''alarma, d''excepció o de setge, les competències del Congrés:', 'L''article 116.5 CE preveu que, dissolt el Congrés o expirat el seu mandat, n''assumeixi les competències la Diputació Permanent.', 'plcat_t02_constitucio_organitzacio_territorial', (select id from public.topics where slug = 'plcat-t02-constitucio-organitzacio-territorial'), 3, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1978-31229'), 'Art. 116.5 CE', 'Disuelto el Congreso o expirado su mandato, si se produjere alguna de las situaciones que dan lugar a cualquiera de dichos estados, las competencias del Congreso serán asumidas por su Diputación Permanente.', null, '11a810a86ecf1c7188d1bbdce6d3d54594a12a0878988c44c8c605a478ab7e09', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '11a810a86ecf1c7188d1bbdce6d3d54594a12a0878988c44c8c605a478ab7e09')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Les assumeix el Senat.', false), ('B', 'Les assumeix el Govern en funcions.', false), ('C', 'Queden en suspens fins a la constitució del nou Congrés.', false), ('D', 'Les assumeix la seva Diputació Permanent.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
-- Lote plcat-t03-estatut-autonomia-eac-v1 (20 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Ley Orgánica 6/2006, de 19 de julio, de reforma del Estatuto de Autonomía de Cataluña (texto consolidado, BOE)', 'https://www.boe.es/buscar/act.php?id=BOE-A-2006-13087', 'boe'::public.source_kind, 'Agencia Estatal Boletín Oficial del Estado', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('plcat-t03-estatut-autonomia', 'Tema 3. L''Estatut d''autonomia de Catalunya: drets, deures i principis rectors, govern local i seguretat pública') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('policia-local') and t.slug = 'plcat-t03-estatut-autonomia' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 8.4 de l''Estatut d''autonomia de Catalunya, l''himne de Catalunya és:', 'L''article 8.4 EAC estableix que l''himne de Catalunya és «Els segadors»; amb la bandera i la festa, és un dels símbols nacionals (art. 8.1).', 'plcat_t03_estatut_autonomia', (select id from public.topics where slug = 'plcat-t03-estatut-autonomia'), 1, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2006-13087'), 'Art. 8.4 EAC', '4. El himno de Cataluña es «Els segadors».', null, '539aff3d0f2ad316c04b4e8c391379b3bbfde44a031b3be6795a05e49a917f11', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '539aff3d0f2ad316c04b4e8c391379b3bbfde44a031b3be6795a05e49a917f11')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', '«Els segadors».', true), ('B', '«El cant de la senyera».', false), ('C', '«La santa espina».', false), ('D', '«El cant dels ocells».', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 6.5 de l''Estatut, la llengua occitana, denominada aranès a l''Aran:', 'L''article 6.5 EAC declara l''occità (aranès a l''Aran) llengua pròpia d''aquest territori i oficial a Catalunya.', 'plcat_t03_estatut_autonomia', (select id from public.topics where slug = 'plcat-t03-estatut-autonomia'), 1, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2006-13087'), 'Art. 6.5 EAC', '5. La lengua occitana, denominada aranés en Arán, es la lengua propia de este territorio y es oficial en Cataluña', null, 'e03f6c87a203befef5d76eb18d36c80dcd49afd525a8991421e458b7466b31d1', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'e03f6c87a203befef5d76eb18d36c80dcd49afd525a8991421e458b7466b31d1')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'És oficial només a l''Aran i no a la resta de Catalunya.', false), ('B', 'És la llengua pròpia d''aquest territori i és oficial a Catalunya.', true), ('C', 'És llengua pròpia de l''Aran, però no té caràcter oficial.', false), ('D', 'És cooficial amb el català i el castellà només als ajuntaments aranesos.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 83.2 de l''Estatut, l''àmbit supramunicipal està constituït, en tot cas, per:', 'L''article 83.2 EAC: l''àmbit supramunicipal el constitueixen, en tot cas, les comarques, regulades per llei del Parlament; l''organització territorial bàsica és en municipis i vegueries (art. 83.1).', 'plcat_t03_estatut_autonomia', (select id from public.topics where slug = 'plcat-t03-estatut-autonomia'), 1, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2006-13087'), 'Art. 83.2 EAC', '2. El ámbito supramunicipal está constituido, en todo caso, por las comarcas, que debe regular una ley del Parlamento.', null, 'bf71321e80ce4004ef56ade7565fd4a3934c63758fad16edf87159314d034cfe', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'bf71321e80ce4004ef56ade7565fd4a3934c63758fad16edf87159314d034cfe')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Les vegueries.', false), ('B', 'Les províncies.', false), ('C', 'Les comarques.', true), ('D', 'Les àrees metropolitanes.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 164.1 de l''Estatut, en matèria de seguretat pública correspon a la Generalitat, d''acord amb la legislació estatal:', 'L''article 164.1.c) EAC inclou el control i la vigilància del trànsit entre les competències de la Generalitat en seguretat pública.', 'plcat_t03_estatut_autonomia', (select id from public.topics where slug = 'plcat-t03-estatut-autonomia'), 1, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2006-13087'), 'Art. 164.1.c EAC', 'c) El control y la vigilancia del tráfico.', null, 'cf19bd975e3fc587cfd21eee16341c2632e4046c8aaba24d3f1867a6ba5d4c94', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'cf19bd975e3fc587cfd21eee16341c2632e4046c8aaba24d3f1867a6ba5d4c94')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'La regulació del règim d''armes i explosius.', false), ('B', 'L''expedició del document nacional d''identitat.', false), ('C', 'El control d''entrada i sortida del territori nacional.', false), ('D', 'El control i la vigilància del trànsit.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 89 de l''Estatut, el municipi de Barcelona:', 'L''article 89 EAC atribueix a Barcelona un règim especial per llei del Parlament, amb iniciativa de l''Ajuntament per proposar-ne la modificació.', 'plcat_t03_estatut_autonomia', (select id from public.topics where slug = 'plcat-t03-estatut-autonomia'), 1, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2006-13087'), 'Art. 89 EAC', 'El municipio de Barcelona dispone de un régimen especial establecido por ley del Parlamento.', null, '1e9d689f2f4f181de5218f5ace58abb89ee85c4926f709b395add3823eb85332', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '1e9d689f2f4f181de5218f5ace58abb89ee85c4926f709b395add3823eb85332')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Té un règim especial establert per llei orgànica de les Corts Generals.', false), ('B', 'Es regeix pel mateix règim que la resta de municipis, sense especialitats.', false), ('C', 'Té un règim especial aprovat per la seva carta municipal sense intervenció del Parlament.', false), ('D', 'Disposa d''un règim especial establert per llei del Parlament.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 92.1 de l''Estatut, la comarca es configura com:', 'L''article 92.1 EAC defineix la comarca com a ens local amb personalitat jurídica pròpia, format per municipis; l''ens local bàsic és el municipi (art. 86.1).', 'plcat_t03_estatut_autonomia', (select id from public.topics where slug = 'plcat-t03-estatut-autonomia'), 1, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2006-13087'), 'Art. 92.1 EAC', '1. La comarca se configura como ente local con personalidad jurídica propia y está formada por municipios para la gestión de competencias y servicios locales.', null, '0eab6a6ed4c6157a1a2cb8edbdf904a2806323e8eb33153264483e08aa4efb23', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '0eab6a6ed4c6157a1a2cb8edbdf904a2806323e8eb33153264483e08aa4efb23')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Un ens local amb personalitat jurídica pròpia format per municipis per a la gestió de competències i serveis locals.', true), ('B', 'Una divisió territorial de la Generalitat sense personalitat jurídica.', false), ('C', 'L''ens local bàsic de l''organització territorial de Catalunya.', false), ('D', 'L''òrgan de govern de la vegueria.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 7.1 de l''Estatut, gaudeixen de la condició política de catalans o ciutadans de Catalunya:', 'L''article 7.1 EAC vincula la condició política de catalans a la nacionalitat espanyola i al veïnatge administratiu a Catalunya.', 'plcat_t03_estatut_autonomia', (select id from public.topics where slug = 'plcat-t03-estatut-autonomia'), 2, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2006-13087'), 'Art. 7.1 EAC', '1. Gozan de la condición política de catalanes o ciudadanos de Cataluña los ciudadanos españoles que tienen vecindad administrativa en Cataluña.', null, '21681482fcc0bbb5322438d4a9203d9d52d861496eee12d2801f7423c1dbd5bf', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '21681482fcc0bbb5322438d4a9203d9d52d861496eee12d2801f7423c1dbd5bf')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Totes les persones nascudes a Catalunya, independentment de la nacionalitat.', false), ('B', 'Els ciutadans espanyols que tenen veïnatge administratiu a Catalunya.', true), ('C', 'Les persones estrangeres amb residència legal a Catalunya.', false), ('D', 'Els ciutadans espanyols que hagin residit a Catalunya durant deu anys.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 20.2 de l''Estatut, totes les persones tenen dret a expressar de manera anticipada la seva voluntat per deixar constància de les instruccions sobre les intervencions i els tractaments mèdics que puguin rebre, instruccions que:', 'L''article 20.2 EAC reconeix les voluntats anticipades, que s''han de respectar d''acord amb les lleis, especialment pel personal sanitari.', 'plcat_t03_estatut_autonomia', (select id from public.topics where slug = 'plcat-t03-estatut-autonomia'), 2, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2006-13087'), 'Art. 20.2 EAC', 'que deben ser respetadas en los términos que establecen las leyes, especialmente por el personal sanitario cuando no estén en condiciones de expresar personalmente su voluntad.', null, '9cb8f2a1e914747e223a49873f682cebfe7e854e32e77e9ef184e6d2b0aca3df', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '9cb8f2a1e914747e223a49873f682cebfe7e854e32e77e9ef184e6d2b0aca3df')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Només vinculen el personal sanitari si la persona les ratifica davant notari cada any.', false), ('B', 'Són merament orientatives per al personal sanitari.', false), ('C', 'S''han de respectar en els termes que estableixen les lleis, especialment pel personal sanitari quan no estiguin en condicions d''expressar personalment la seva voluntat.', true), ('D', 'Requereixen autorització judicial per poder-se aplicar.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 31 de l''Estatut, el respecte del dret a la protecció de les dades personals contingudes en els fitxers de competència de la Generalitat l''ha de vetllar:', 'L''article 31 EAC encomana a una autoritat independent designada pel Parlament vetllar pel respecte del dret a la protecció de dades personals.', 'plcat_t03_estatut_autonomia', (select id from public.topics where slug = 'plcat-t03-estatut-autonomia'), 2, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2006-13087'), 'Art. 31 EAC', 'Una autoridad independiente, designada por el Parlamento, debe velar por el respeto de estos derechos en los términos que establecen las leyes.', null, 'cd740699c430ea5265c12210063b2038e0184482b751c7864bf6f2aeadd46c8f', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'cd740699c430ea5265c12210063b2038e0184482b751c7864bf6f2aeadd46c8f')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El Síndic de Greuges.', false), ('B', 'El Consell de Garanties Estatutàries.', false), ('C', 'L''Agència Espanyola de Protecció de Dades exclusivament.', false), ('D', 'Una autoritat independent designada pel Parlament.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 37.3 de l''Estatut, la regulació essencial i el desenvolupament directe dels drets reconeguts pels capítols I, II i III del títol I s''han de fer:', 'L''article 37.3 EAC reserva a la llei del Parlament la regulació essencial i el desenvolupament directe d''aquests drets.', 'plcat_t03_estatut_autonomia', (select id from public.topics where slug = 'plcat-t03-estatut-autonomia'), 2, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2006-13087'), 'Art. 37.3 EAC', '3. La regulación esencial y el desarrollo directo de los derechos reconocidos por los capítulos I, II y III del presente Título deben realizarse por ley del Parlamento.', null, '80b5958a3efaa1906c496b05df18de044d2fff9d3b6c4763c3801f42eca26a78', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '80b5958a3efaa1906c496b05df18de044d2fff9d3b6c4763c3801f42eca26a78')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Per decret del Govern de la Generalitat.', false), ('B', 'Per llei orgànica de les Corts Generals.', false), ('C', 'Per llei del Parlament.', true), ('D', 'Per reglament del Parlament.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 38.2 de l''Estatut, els actes que vulnerin els drets reconeguts pels capítols I, II i III del títol I i per la Carta dels drets i deures dels ciutadans de Catalunya són objecte de recurs davant:', 'L''article 38.2 EAC preveu el recurs davant el Tribunal Superior de Justícia de Catalunya, d''acord amb els procediments establerts a les lleis.', 'plcat_t03_estatut_autonomia', (select id from public.topics where slug = 'plcat-t03-estatut-autonomia'), 2, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2006-13087'), 'Art. 38.2 EAC', 'serán objeto de recurso ante el Tribunal Superior de Justicia de Cataluña, de acuerdo con los procedimientos establecidos en las leyes.', null, '0f3062c00e43720bf7e67b7b3eeb758ed1d41ed15508974fa3635cd0c7d3a408', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '0f3062c00e43720bf7e67b7b3eeb758ed1d41ed15508974fa3635cd0c7d3a408')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El Tribunal Superior de Justícia de Catalunya.', true), ('B', 'El Tribunal Constitucional, mitjançant recurs d''empara.', false), ('C', 'El Síndic de Greuges.', false), ('D', 'El Tribunal Suprem.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Quina d''aquestes matèries NO figura entre les competències pròpies que l''article 84.2 de l''Estatut garanteix, en tot cas, als governs locals?', 'L''article 84.2 EAC inclou, entre d''altres, la protecció civil i la prevenció d''incendis (f), la circulació i la mobilitat (h) i la vigilància de platges, rius, llacs i muntanya (n); la policia judicial i la investigació criminal són àmbits de la Policia de la Generalitat (art. 164.5).', 'plcat_t03_estatut_autonomia', (select id from public.topics where slug = 'plcat-t03-estatut-autonomia'), 2, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2006-13087'), 'Art. 84.2 EAC', 'f) La protección civil y la prevención de incendios. […] h) La circulación y los servicios de movilidad y la gestión del transporte de viajeros municipal. […] n) La regulación, la gestión y la vigilancia de las actividades y los usos que se llevan a cabo en las playas, los ríos, los lagos y la montaña.', null, 'fba72b35ec2141631841e5818dd06bc8ef6e78100a6af4bac30feaaf9297c5d5', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'fba72b35ec2141631841e5818dd06bc8ef6e78100a6af4bac30feaaf9297c5d5')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'La protecció civil i la prevenció d''incendis.', false), ('B', 'La investigació criminal i la policia judicial.', true), ('C', 'La circulació i els serveis de mobilitat i la gestió del transport de viatgers municipal.', false), ('D', 'La regulació, la gestió i la vigilància de les activitats i els usos a les platges, els rius, els llacs i la muntanya.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 86.7 de l''Estatut, les concentracions de població que dins d''un municipi constitueixin nuclis separats es poden constituir en:', 'L''article 86.7 EAC preveu que els nuclis separats d''un municipi es puguin constituir en entitats municipals descentralitzades.', 'plcat_t03_estatut_autonomia', (select id from public.topics where slug = 'plcat-t03-estatut-autonomia'), 2, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2006-13087'), 'Art. 86.7 EAC', '7. Las concentraciones de población que dentro de un municipio constituyan núcleos separados pueden constituirse en entidades municipales descentralizadas.', null, 'dd6e21b2a42d30ababdd70567a9952059932568cfe1105d8ee2dbf0cde73548f', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'dd6e21b2a42d30ababdd70567a9952059932568cfe1105d8ee2dbf0cde73548f')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Entitats municipals descentralitzades.', true), ('B', 'Municipis independents.', false), ('C', 'Comarques.', false), ('D', 'Mancomunitats.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 90.1 de l''Estatut, la vegueria és:', 'L''article 90.1 EAC defineix la vegueria com a àmbit de govern intermunicipal de cooperació local amb personalitat jurídica pròpia i com a divisió territorial de la Generalitat per organitzar els seus serveis.', 'plcat_t03_estatut_autonomia', (select id from public.topics where slug = 'plcat-t03-estatut-autonomia'), 2, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2006-13087'), 'Art. 90.1 EAC', '1. La veguería es el ámbito territorial específico para el ejercicio del gobierno intermunicipal de cooperación local y tiene personalidad jurídica propia.', null, '5616ac64389d1f3cf04765f1a096aa05c8c8339397376e749267b9c37b41189a', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '5616ac64389d1f3cf04765f1a096aa05c8c8339397376e749267b9c37b41189a')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Una agrupació voluntària de comarques sense personalitat jurídica.', false), ('B', 'L''ens local bàsic de l''organització territorial de Catalunya.', false), ('C', 'Una divisió territorial de l''Estat per a l''organització dels seus serveis perifèrics.', false), ('D', 'L''àmbit territorial específic per a l''exercici del govern intermunicipal de cooperació local, amb personalitat jurídica pròpia.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 164.3 de l''Estatut, correspon en tot cas a la Generalitat, en el marc de la legislació estatal sobre seguretat:', 'L''article 164.3.a) EAC atribueix a la Generalitat les funcions governatives sobre l''exercici dels drets de reunió i manifestació.', 'plcat_t03_estatut_autonomia', (select id from public.topics where slug = 'plcat-t03-estatut-autonomia'), 2, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2006-13087'), 'Art. 164.3.a EAC', 'a) Las funciones gubernativas sobre el ejercicio de los derechos de reunión y manifestación.', null, '9df0da86a2c10a6edc33d22e5d194be99ad2e69a96a247c391e761e377dd6c4b', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '9df0da86a2c10a6edc33d22e5d194be99ad2e69a96a247c391e761e377dd6c4b')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'La regulació de les condicions d''exercici del dret de reunió.', false), ('B', 'Les funcions governatives sobre l''exercici dels drets de reunió i manifestació.', true), ('C', 'La declaració de l''estat d''alarma a Catalunya.', false), ('D', 'El comandament de les unitats de la Guàrdia Civil destinades a Catalunya.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 38.1 de l''Estatut, els drets reconeguts pels capítols I, II i III del títol I i per la Carta dels drets i deures dels ciutadans de Catalunya són tutelats per:', 'L''article 38.1 EAC encarrega la tutela d''aquests drets al Consell de Garanties Estatutàries, d''acord amb l''article 76.2.b) i c).', 'plcat_t03_estatut_autonomia', (select id from public.topics where slug = 'plcat-t03-estatut-autonomia'), 3, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2006-13087'), 'Art. 38.1 EAC', 'son tutelados por el Consejo de Garantías Estatutarias', null, '957176b5419e2680f1891c9191eeaa74dfc75f368cbc60b51f64409fa63ced9b', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '957176b5419e2680f1891c9191eeaa74dfc75f368cbc60b51f64409fa63ced9b')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El Síndic de Greuges.', false), ('B', 'La Sindicatura de Comptes.', false), ('C', 'El Consell de Garanties Estatutàries.', true), ('D', 'La Comissió Jurídica Assessora.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 91.2 de l''Estatut, el president o presidenta de vegueria:', 'L''article 91.2 EAC disposa que el president de vegueria l''escullen els consellers de vegueria d''entre els seus membres.', 'plcat_t03_estatut_autonomia', (select id from public.topics where slug = 'plcat-t03-estatut-autonomia'), 3, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2006-13087'), 'Art. 91.2 EAC', '2. El Presidente o Presidenta de veguería es escogido por los Consejeros de veguería de entre sus miembros.', null, '19403894d5e3b98c92403d96bbba6a5cfc4db780c0659bc4dab9eff5e47cb6e2', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '19403894d5e3b98c92403d96bbba6a5cfc4db780c0659bc4dab9eff5e47cb6e2')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'L''escullen els consellers de vegueria d''entre els seus membres.', true), ('B', 'El nomena el Govern de la Generalitat.', false), ('C', 'L''elegeixen directament els veïns de la vegueria.', false), ('D', 'És l''alcalde del municipi capital de la vegueria.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 85 de l''Estatut, l''òrgan de representació de municipis i vegueries en les institucions de la Generalitat és:', 'L''article 85 EAC configura el Consell de Governs Locals com a òrgan de representació de municipis i vegueries, que ha de ser escoltat en la tramitació de les iniciatives que afecten específicament les administracions locals.', 'plcat_t03_estatut_autonomia', (select id from public.topics where slug = 'plcat-t03-estatut-autonomia'), 3, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2006-13087'), 'Art. 85 EAC', 'El Consejo de Gobiernos Locales es el órgano de representación de municipios y veguerías en las instituciones de la Generalitat.', null, '435fd583abca8102298ec14892ee0ba472d3f044aad78668861be51a37a254fd', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '435fd583abca8102298ec14892ee0ba472d3f044aad78668861be51a37a254fd')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'La Comissió de Govern Local de Catalunya.', false), ('B', 'El Consell de Vegueria.', false), ('C', 'La Junta de Seguretat de Catalunya.', false), ('D', 'El Consell de Governs Locals.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 160.3 de l''Estatut, la Generalitat té competència exclusiva en matèria de règim electoral:', 'L''article 160.3 EAC limita la competència exclusiva sobre règim electoral als ens locals creats per la Generalitat, excloent-ne els constitucionalment garantits (municipis i províncies).', 'plcat_t03_estatut_autonomia', (select id from public.topics where slug = 'plcat-t03-estatut-autonomia'), 3, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2006-13087'), 'Art. 160.3 EAC', '3. Corresponde a la Generalitat la competencia exclusiva en materia de régimen electoral de los entes locales creados por aquélla, con la excepción de los constitucionalmente garantizados.', null, 'f16fb3053b1afe9c81f79dd42401b35b68b246f786c11bf5423cac81f4a1ba90', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'f16fb3053b1afe9c81f79dd42401b35b68b246f786c11bf5423cac81f4a1ba90')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'De tots els ens locals de Catalunya, inclosos els municipis.', false), ('B', 'Dels ens locals creats per ella, amb l''excepció dels constitucionalment garantits.', true), ('C', 'Només dels municipis de menys de 5.000 habitants.', false), ('D', 'Dels ens locals constitucionalment garantits.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 84.3 de l''Estatut, quin d''aquests principis NO s''esmenta com a criteri que regeix la distribució de responsabilitats administratives entre les diferents administracions locals?', 'L''article 84.3 EAC esmenta el principi de subsidiarietat, el de diferenciació i el de suficiència financera, a més de les lleis del Parlament; no s''hi esmenta la jerarquia.', 'plcat_t03_estatut_autonomia', (select id from public.topics where slug = 'plcat-t03-estatut-autonomia'), 3, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2006-13087'), 'Art. 84.3 EAC', 'por el principio de subsidiariedad, de acuerdo con lo establecido por la Carta Europea de la Autonomía Local, por el principio de diferenciación, de acuerdo con las características que presenta la realidad municipal, y por el principio de suficiencia financiera.', null, '964aa3fed5f7b0e6728ef9665e445b856e15dd719ce72f5bc1e844d124148c7b', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '964aa3fed5f7b0e6728ef9665e445b856e15dd719ce72f5bc1e844d124148c7b')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El principi de subsidiarietat.', false), ('B', 'El principi de diferenciació.', false), ('C', 'El principi de jerarquia.', true), ('D', 'El principi de suficiència financera.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
-- Lote plcat-t04-regim-local-lbrl-v1 (20 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Ley 7/1985, de 2 de abril, Reguladora de las Bases del Régimen Local (texto consolidado, BOE)', 'https://www.boe.es/buscar/act.php?id=BOE-A-1985-5392', 'boe'::public.source_kind, 'Agencia Estatal Boletín Oficial del Estado', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('plcat-t04-regim-local', 'Tema 4. Règim local: el municipi, l''organització municipal i les ordenances (Llei 7/1985)') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('policia-local') and t.slug = 'plcat-t04-regim-local' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 11.1 de la Llei 7/1985, reguladora de les bases del règim local, el municipi:', 'L''article 11.1 LBRL defineix el municipi com a entitat local bàsica de l''organització territorial de l''Estat, amb personalitat jurídica i plena capacitat.', 'plcat_t04_regim_local', (select id from public.topics where slug = 'plcat-t04-regim-local'), 1, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1985-5392'), 'Art. 11.1 LBRL', '1. El Municipio es la entidad local básica de la organización territorial del Estado. Tiene personalidad jurídica y plena capacidad para el cumplimiento de sus fines.', null, 'cf91c736d0b00fc3e63dc60a1bfbce065b5c2af35201d2ca733e131ee9decf41', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'cf91c736d0b00fc3e63dc60a1bfbce065b5c2af35201d2ca733e131ee9decf41')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'És una divisió territorial de la província sense personalitat jurídica pròpia.', false), ('B', 'És l''entitat local bàsica, però la seva personalitat jurídica correspon a la comunitat autònoma.', false), ('C', 'És l''entitat local bàsica de l''organització territorial de l''Estat, amb personalitat jurídica i plena capacitat per complir les seves finalitats.', true), ('D', 'És un òrgan desconcentrat de l''Administració de l''Estat en el territori.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 16.1 de la LBRL, les certificacions que s''expedeixen de les dades del padró municipal:', 'L''article 16.1 LBRL disposa que les dades del padró fan prova de la residència i del domicili habitual, i que les certificacions tenen caràcter de document públic i fefaent.', 'plcat_t04_regim_local', (select id from public.topics where slug = 'plcat-t04-regim-local'), 1, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1985-5392'), 'Art. 16.1 LBRL', 'Las certificaciones que de dichos datos se expidan tendrán carácter de documento público y fehaciente para todos los efectos administrativos.', null, '9af7519f48dfbb3fc327b057a0eeefd888fc9ab46a040292d71ea3f2bc29006c', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '9af7519f48dfbb3fc327b057a0eeefd888fc9ab46a040292d71ea3f2bc29006c')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Només tenen valor informatiu i no fan prova de la residència.', false), ('B', 'Tenen caràcter de document privat amb efectes només estadístics.', false), ('C', 'Només fan prova de la residència legal de les persones estrangeres.', false), ('D', 'Tenen caràcter de document públic i fefaent per a tots els efectes administratius.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 22.1 de la LBRL, el Ple de l''ajuntament:', 'L''article 22.1 LBRL estableix que el Ple el formen tots els regidors i el presideix l''alcalde; la Junta de Govern Local la integren l''alcalde i fins a un terç dels regidors (art. 23.1).', 'plcat_t04_regim_local', (select id from public.topics where slug = 'plcat-t04-regim-local'), 1, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1985-5392'), 'Art. 22.1 LBRL', '1. El Pleno, integrado por todos los Concejales, es presidido por el Alcalde.', null, 'fe18a3793ee1896d5c8f12b280e3eafda92fd5befd677bb9ed4366dfeb3fddd3', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'fe18a3793ee1896d5c8f12b280e3eafda92fd5befd677bb9ed4366dfeb3fddd3')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Està integrat pels tinents d''alcalde i el presideix l''alcalde.', false), ('B', 'Està integrat per tots els regidors i el presideix l''alcalde.', true), ('C', 'Està integrat per tots els regidors i el presideix el regidor de més edat.', false), ('D', 'Està integrat per l''alcalde i un terç dels regidors.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 21.2 de la LBRL, el nomenament dels tinents d''alcalde correspon:', 'L''article 21.2 LBRL atribueix a l''alcalde el nomenament dels tinents d''alcalde.', 'plcat_t04_regim_local', (select id from public.topics where slug = 'plcat-t04-regim-local'), 1, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1985-5392'), 'Art. 21.2 LBRL', '2. Corresponde asimismo al Alcalde el nombramiento de los Tenientes de Alcalde.', null, '2327d49027bb6425ac4a2f50f71cf28a76424e4670c2acf24cf6d8d99c968af8', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '2327d49027bb6425ac4a2f50f71cf28a76424e4670c2acf24cf6d8d99c968af8')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'A l''alcalde.', true), ('B', 'Al Ple, per majoria absoluta.', false), ('C', 'A la Junta de Govern Local.', false), ('D', 'Al secretari de la corporació.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 26.1 de la LBRL, quin d''aquests serveis s''ha de prestar en TOTS els municipis?', 'L''article 26.1.a) LBRL inclou l''enllumenat públic entre els serveis de tots els municipis; el parc i la biblioteca públics són obligatoris a partir de 5.000 habitants i les instal·lacions esportives, a partir de 20.000.', 'plcat_t04_regim_local', (select id from public.topics where slug = 'plcat-t04-regim-local'), 1, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1985-5392'), 'Art. 26.1.a LBRL', 'a) En todos los Municipios: alumbrado público, cementerio, recogida de residuos, limpieza viaria, abastecimiento domiciliario de agua potable, alcantarillado, acceso a los núcleos de población y pavimentación de las vías públicas.', null, 'f891deedde14537040cecb38cc5fd0d5db618ff79d98563666594ae8321810f6', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'f891deedde14537040cecb38cc5fd0d5db618ff79d98563666594ae8321810f6')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'L''enllumenat públic.', true), ('B', 'La biblioteca pública.', false), ('C', 'Les instal·lacions esportives d''ús públic.', false), ('D', 'El parc públic.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 141 de la LBRL, llevat de previsió legal diferent, la multa per una infracció LLEU d''una ordenança local pot arribar fins a:', 'L''article 141 LBRL fixa els límits: fins a 3.000 euros les molt greus, fins a 1.500 euros les greus i fins a 750 euros les lleus.', 'plcat_t04_regim_local', (select id from public.topics where slug = 'plcat-t04-regim-local'), 1, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1985-5392'), 'Art. 141 LBRL', 'Infracciones leves: hasta 750 euros.', null, '26500be78bc41e5d3b8ab4671b99990985004ba45f7171463dfb8029b9d19281', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '26500be78bc41e5d3b8ab4671b99990985004ba45f7171463dfb8029b9d19281')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', '300 euros.', false), ('B', '1.500 euros.', false), ('C', '750 euros.', true), ('D', '600 euros.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Quina d''aquestes potestats NO figura entre les que l''article 4.1 de la LBRL atribueix als municipis, les províncies i les illes?', 'L''article 4.1 LBRL enumera, entre d''altres, les potestats reglamentària i d''autoorganització, d''execució forçosa i sancionadora i de revisió d''ofici; la potestat jurisdiccional és pròpia dels jutges i tribunals.', 'plcat_t04_regim_local', (select id from public.topics where slug = 'plcat-t04-regim-local'), 2, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1985-5392'), 'Art. 4.1 LBRL', 'a) Las potestades reglamentaria y de autoorganización. […] f) Las potestades de ejecución forzosa y sancionadora. […] g) La potestad de revisión de oficio de sus actos y acuerdos.', null, '3be251ad43f4d0b3a7d76f35fe790b74640c847019757680db933be61008bc1a', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '3be251ad43f4d0b3a7d76f35fe790b74640c847019757680db933be61008bc1a')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'La potestat reglamentària i d''autoorganització.', false), ('B', 'La potestat d''execució forçosa i sancionadora.', false), ('C', 'La potestat de revisió d''ofici dels seus actes i acords.', false), ('D', 'La potestat jurisdiccional.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 13.2 de la LBRL, la creació de nous municipis només es pot fer sobre la base de nuclis de població territorialment diferenciats d''almenys:', 'L''article 13.2 LBRL exigeix nuclis diferenciats d''almenys 4.000 habitants i que els municipis resultants siguin financerament sostenibles.', 'plcat_t04_regim_local', (select id from public.topics where slug = 'plcat-t04-regim-local'), 2, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1985-5392'), 'Art. 13.2 LBRL', '2. La creación de nuevos municipios solo podrá realizarse sobre la base de núcleos de población territorialmente diferenciados, de al menos 4.000 habitantes', null, '9914846cdb07459557d1d03450dd7402b185a351d19505d8fb18470565cf512f', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '9914846cdb07459557d1d03450dd7402b185a351d19505d8fb18470565cf512f')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', '2.000 habitants.', false), ('B', '4.000 habitants.', true), ('C', '5.000 habitants.', false), ('D', '10.000 habitants.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 18.1 de la LBRL, quin d''aquests és un dret o deure dels veïns?', 'L''article 18.1.d) LBRL inclou entre els drets i deures dels veïns contribuir amb les prestacions econòmiques i personals legalment previstes.', 'plcat_t04_regim_local', (select id from public.topics where slug = 'plcat-t04-regim-local'), 2, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1985-5392'), 'Art. 18.1 LBRL', 'd) Contribuir mediante las prestaciones económicas y personales legalmente previstas a la realización de las competencias municipales.', null, '34d672bbefb224b7f6355c66ff470e7b1db481caa9a6163497c50ddd79e8594a', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '34d672bbefb224b7f6355c66ff470e7b1db481caa9a6163497c50ddd79e8594a')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Assistir obligatòriament a les sessions del Ple municipal.', false), ('B', 'Aprovar per votació directa les ordenances municipals.', false), ('C', 'Contribuir mitjançant les prestacions econòmiques i personals legalment previstes a la realització de les competències municipals.', true), ('D', 'Elegir directament els tinents d''alcalde.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 18.2 de la LBRL, la inscripció de les persones estrangeres en el padró municipal:', 'L''article 18.2 LBRL precisa que l''empadronament dels estrangers no prova la residència legal ni els atribueix drets no previstos per la legislació vigent.', 'plcat_t04_regim_local', (select id from public.topics where slug = 'plcat-t04-regim-local'), 2, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1985-5392'), 'Art. 18.2 LBRL', '2. La inscripción de los extranjeros en el padrón municipal no constituirá prueba de su residencia legal en España ni les atribuirá ningún derecho que no les confiera la legislación vigente', null, '598c1e1dcc84e8722c2232b6764ef6c0aaa818a56e114a5f3a42e115d2d03329', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '598c1e1dcc84e8722c2232b6764ef6c0aaa818a56e114a5f3a42e115d2d03329')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Constitueix prova de la seva residència legal a Espanya.', false), ('B', 'Els atribueix el dret de sufragi en totes les eleccions.', false), ('C', 'Requereix l''autorització prèvia de la Delegació del Govern.', false), ('D', 'No constitueix prova de la seva residència legal a Espanya ni els atribueix cap dret que no els confereixi la legislació vigent.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 20.1.b) de la LBRL, la Junta de Govern Local existeix necessàriament en els municipis de població:', 'L''article 20.1.b) LBRL: la Junta de Govern Local existeix en els municipis de més de 5.000 habitants i en els de menys si ho disposa el reglament orgànic o ho acorda el Ple.', 'plcat_t04_regim_local', (select id from public.topics where slug = 'plcat-t04-regim-local'), 2, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1985-5392'), 'Art. 20.1.b LBRL', 'b) La Junta de Gobierno Local existe en todos los municipios con población superior a 5.000 habitantes y en los de menos, cuando así lo disponga su reglamento orgánico o así lo acuerde el Pleno de su ayuntamiento.', null, 'f3ed7d49d37aa592fbd48fdfa726b181df6c366cef8c509aa64ed8a556eb5bc3', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'f3ed7d49d37aa592fbd48fdfa726b181df6c366cef8c509aa64ed8a556eb5bc3')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Superior a 20.000 habitants.', false), ('B', 'Superior a 5.000 habitants.', true), ('C', 'Superior a 50.000 habitants.', false), ('D', 'Superior a 1.000 habitants.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 20.1 de la LBRL, quin d''aquests òrgans existeix en TOTS els municipis?', 'L''article 20.1.e) LBRL estableix que la Comissió Especial de Comptes existeix en tots els municipis; la Junta de Govern Local depèn de la població i la Comissió de Suggeriments i Reclamacions, del títol X o de l''acord del Ple.', 'plcat_t04_regim_local', (select id from public.topics where slug = 'plcat-t04-regim-local'), 2, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1985-5392'), 'Art. 20.1.e LBRL', 'e) La Comisión Especial de Cuentas existe en todos los municipios, de acuerdo con la estructura prevista en el artículo 116.', null, '1495ba13a1ceafcb3b437c8ac5551a3bcb76d44d0df934f75b051ac409b027af', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '1495ba13a1ceafcb3b437c8ac5551a3bcb76d44d0df934f75b051ac409b027af')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'La Comissió Especial de Comptes.', true), ('B', 'La Junta de Govern Local.', false), ('C', 'La Comissió Especial de Suggeriments i Reclamacions.', false), ('D', 'Els òrgans territorials de gestió desconcentrada.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 21.1 de la LBRL, sancionar les faltes de desobediència a la seva autoritat o per infracció de les ordenances municipals correspon, llevat que la facultat estigui atribuïda a altres òrgans:', 'L''article 21.1.n) LBRL atribueix a l''alcalde sancionar les faltes de desobediència a la seva autoritat o per infracció de les ordenances, llevat que la facultat correspongui a altres òrgans.', 'plcat_t04_regim_local', (select id from public.topics where slug = 'plcat-t04-regim-local'), 2, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1985-5392'), 'Art. 21.1.n LBRL', 'n) Sancionar las faltas de desobediencia a su autoridad o por infracción de las ordenanzas municipales, salvo en los casos en que tal facultad esté atribuida a otros órganos.', null, '96e98ca58965db8c74797b620452795a452b07662baefe777859d876077582b0', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '96e98ca58965db8c74797b620452795a452b07662baefe777859d876077582b0')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'A l''alcalde.', true), ('B', 'Al Ple de l''ajuntament.', false), ('C', 'A la Junta de Govern Local.', false), ('D', 'Al cap de la policia local.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 47.1 de la LBRL, com a regla general, els acords de les corporacions locals s''adopten:', 'L''article 47.1 LBRL estableix la majoria simple dels membres presents com a regla general i la defineix com més vots afirmatius que negatius.', 'plcat_t04_regim_local', (select id from public.topics where slug = 'plcat-t04-regim-local'), 2, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1985-5392'), 'Art. 47.1 LBRL', '1. Los acuerdos de las corporaciones locales se adoptan, como regla general, por mayoría simple de los miembros presentes. Existe mayoría simple cuando los votos afirmativos son más que los negativos.', null, 'd2593b38d170208d16e7604ada22c908dd87631df8ae9ffe0f2a1a0ba5fd6bea', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'd2593b38d170208d16e7604ada22c908dd87631df8ae9ffe0f2a1a0ba5fd6bea')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Per majoria absoluta del nombre legal de membres.', false), ('B', 'Per majoria simple del nombre legal de membres de la corporació.', false), ('C', 'Per majoria simple dels membres presents, que existeix quan els vots afirmatius són més que els negatius.', true), ('D', 'Per majoria de dos terços dels membres presents.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 70.1 de la LBRL, quina afirmació sobre la publicitat de les sessions és correcta?', 'L''article 70.1 LBRL declara públiques les sessions del Ple (amb possibilitat de debat i votació secrets en assumptes que afectin l''art. 18.1 CE, per majoria absoluta) i no públiques les de la Junta de Govern Local.', 'plcat_t04_regim_local', (select id from public.topics where slug = 'plcat-t04-regim-local'), 2, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1985-5392'), 'Art. 70.1 LBRL', '1. Las sesiones del Pleno de las corporaciones locales son públicas. […] No son públicas las sesiones de la Junta de Gobierno Local.', null, '00d31e88bb98d23aa217f7e4a6bf1c589e1643644b7ac8900f78f115a473c699', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '00d31e88bb98d23aa217f7e4a6bf1c589e1643644b7ac8900f78f115a473c699')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Les sessions del Ple i de la Junta de Govern Local són sempre públiques.', false), ('B', 'Les sessions del Ple només són públiques si ho acorda la majoria absoluta.', false), ('C', 'Les sessions de la Junta de Govern Local són públiques quan tracten assumptes delegats pel Ple.', false), ('D', 'Les sessions del Ple són públiques, però les de la Junta de Govern Local no ho són.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 46.2.a) de la LBRL, el Ple d''un ajuntament d''un municipi de 12.000 habitants ha de celebrar sessió ordinària, com a mínim:', 'L''article 46.2.a) LBRL fixa sessió ordinària mensual en municipis de més de 20.000 habitants, cada dos mesos en els de 5.001 a 20.000 i cada tres mesos en els de fins a 5.000.', 'plcat_t04_regim_local', (select id from public.topics where slug = 'plcat-t04-regim-local'), 3, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1985-5392'), 'Art. 46.2.a LBRL', 'cada dos meses en los Ayuntamientos de los municipios de una población entre 5.001 habitantes y 20.000 habitantes', null, 'c8c44e70821057b4c35cb9219d0d920a031e3ca999d9d9ba2a06d7a4b4e253a8', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'c8c44e70821057b4c35cb9219d0d920a031e3ca999d9d9ba2a06d7a4b4e253a8')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Cada mes.', false), ('B', 'Cada dos mesos.', true), ('C', 'Cada tres mesos.', false), ('D', 'Cada sis mesos.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 46.2.c) de la LBRL, el Ple es constitueix vàlidament amb l''assistència de:', 'L''article 46.2.c) LBRL exigeix l''assistència d''un terç del mínim legal de membres, mai inferior a tres, quòrum que s''ha de mantenir durant tota la sessió.', 'plcat_t04_regim_local', (select id from public.topics where slug = 'plcat-t04-regim-local'), 3, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1985-5392'), 'Art. 46.2.c LBRL', 'c) El Pleno se constituye válidamente con la asistencia de un tercio del mínimo legal de miembros del mismo, que nunca podrá ser inferior a tres.', null, '49a64e8c20eca2dcdb0eed7aebbef041d5cb0fc3b4f7b836ad1663b56fb1a9ea', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '49a64e8c20eca2dcdb0eed7aebbef041d5cb0fc3b4f7b836ad1663b56fb1a9ea')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Un terç del mínim legal de membres, que mai no pot ser inferior a tres.', true), ('B', 'La majoria absoluta del nombre legal de membres.', false), ('C', 'Un quart del nombre legal de membres, que mai no pot ser inferior a dos.', false), ('D', 'Dos terços del nombre legal de membres en primera convocatòria.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 29.2 de la LBRL, la constitució en consell obert d''un municipi en què ho facin aconsellable la seva localització geogràfica o la millor gestió dels interessos municipals requereix:', 'L''article 29.2 LBRL exigeix tres requisits: petició de la majoria dels veïns, majoria de dos terços de l''ajuntament i aprovació de la comunitat autònoma.', 'plcat_t04_regim_local', (select id from public.topics where slug = 'plcat-t04-regim-local'), 3, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1985-5392'), 'Art. 29.2 LBRL', '2. La constitución en concejo abierto de los municipios a que se refiere el apartado b) del número anterior, requiere petición de la mayoría de los vecinos, decisión favorable por mayoría de dos tercios de los miembros del Ayuntamiento y aprobación por la Comunidad Autónoma.', null, '80e6e101b40fb5a3a1c943f52a51f962598afe817e846efbe7e871ec576c8963', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '80e6e101b40fb5a3a1c943f52a51f962598afe817e846efbe7e871ec576c8963')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Petició de la quarta part dels veïns i acord del Ple per majoria absoluta.', false), ('B', 'Petició de la majoria dels veïns, decisió favorable per majoria de dos terços dels membres de l''ajuntament i aprovació per la comunitat autònoma.', true), ('C', 'Acord del Ple per majoria simple i aprovació per la diputació provincial.', false), ('D', 'Petició de la majoria dels veïns i aprovació per llei de les Corts Generals.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 47.2 de la LBRL, quin d''aquests acords requereix el vot favorable de la majoria absoluta del nombre legal de membres de la corporació?', 'L''article 47.2.e) LBRL inclou l''adopció o modificació de bandera, ensenya o escut entre les matèries que exigeixen majoria absoluta del nombre legal de membres; la resta segueix la regla general de majoria simple (art. 47.1).', 'plcat_t04_regim_local', (select id from public.topics where slug = 'plcat-t04-regim-local'), 3, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1985-5392'), 'Art. 47.2.e LBRL', '2. Se requiere el voto favorable de la mayoría absoluta del número legal de miembros de las corporaciones para la adopción de acuerdos en las siguientes materias: […] e) Adopción o modificación de su bandera, enseña o escudo.', null, '999333d434d4cc8a681c1b38bafb68d7e4cddf634c203bbbb0b579d85604db0a', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '999333d434d4cc8a681c1b38bafb68d7e4cddf634c203bbbb0b579d85604db0a')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'L''aprovació inicial d''una ordenança de circulació.', false), ('B', 'La resolució d''una moció ordinària d''un grup municipal.', false), ('C', 'L''adopció o modificació de la bandera, l''ensenya o l''escut del municipi.', true), ('D', 'L''aprovació de l''acta de la sessió anterior.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 70.2 de la LBRL, les ordenances locals es publiquen al butlletí oficial de la província i entren en vigor:', 'L''article 70.2 LBRL condiciona l''entrada en vigor de les ordenances a la publicació completa del text al butlletí oficial de la província i al transcurs del termini de l''article 65.', 'plcat_t04_regim_local', (select id from public.topics where slug = 'plcat-t04-regim-local'), 3, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1985-5392'), 'Art. 70.2 LBRL', 'se publicarán en el "Boletín Oficial" de la Provincia y no entrarán en vigor hasta que se haya publicado completamente su texto y haya transcurrido el plazo previsto en el artículo 65.', null, 'df25ffb8678bf04aa18192478eaa2348b617c4977a907f9ece2dd49140860148', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'df25ffb8678bf04aa18192478eaa2348b617c4977a907f9ece2dd49140860148')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'L''endemà de l''aprovació definitiva pel Ple.', false), ('B', 'Als vint dies de la publicació de l''anunci d''aprovació inicial.', false), ('C', 'Quan ho decideixi l''alcalde mitjançant ban.', false), ('D', 'Quan se n''ha publicat completament el text i ha transcorregut el termini previst a l''article 65.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
-- Lote plcat-t05-procediment-administratiu-lpac-v1 (20 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Ley 39/2015, de 1 de octubre, del Procedimiento Administrativo Común de las Administraciones Públicas (texto consolidado, BOE)', 'https://www.boe.es/buscar/act.php?id=BOE-A-2015-10565', 'boe'::public.source_kind, 'Agencia Estatal Boletín Oficial del Estado', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('plcat-t05-procediment-administratiu', 'Tema 5. El procediment administratiu comú: interessats, activitat de les administracions i actes (Llei 39/2015)') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('policia-local') and t.slug = 'plcat-t05-procediment-administratiu' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 13 de la Llei 39/2015, les persones amb capacitat d''obrar tenen dret, en les seves relacions amb les administracions públiques:', 'L''article 13.e) LPAC reconeix el dret a ser tractat amb respecte i deferència per les autoritats i els empleats públics, que han de facilitar l''exercici dels drets i el compliment de les obligacions.', 'plcat_t05_procediment_administratiu', (select id from public.topics where slug = 'plcat-t05-procediment-administratiu'), 1, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2015-10565'), 'Art. 13.e Llei 39/2015', 'e) A ser tratados con respeto y deferencia por las autoridades y empleados públicos, que habrán de facilitarles el ejercicio de sus derechos y el cumplimiento de sus obligaciones.', null, '9f84d06577f740546cf0b6ec5ba64435cf67f2c9f049f8e096ce8bbf6ad206eb', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '9f84d06577f740546cf0b6ec5ba64435cf67f2c9f049f8e096ce8bbf6ad206eb')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'A obtenir resolució favorable en un termini màxim de deu dies.', false), ('B', 'A no aportar mai cap document en un procediment.', false), ('C', 'A ser tractades amb respecte i deferència per les autoritats i els empleats públics.', true), ('D', 'A triar l''empleat públic que tramitarà el seu expedient.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 29 de la Llei 39/2015, els termes i terminis establerts en aquesta o en altres lleis obliguen:', 'L''article 29 LPAC declara que els termes i terminis obliguen tant les autoritats i el personal de l''Administració com els interessats.', 'plcat_t05_procediment_administratiu', (select id from public.topics where slug = 'plcat-t05-procediment-administratiu'), 1, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2015-10565'), 'Art. 29 Llei 39/2015', 'Los términos y plazos establecidos en ésta u otras leyes obligan a las autoridades y personal al servicio de las Administraciones Públicas competentes para la tramitación de los asuntos, así como a los interesados en los mismos.', null, '0a7320e2676384a5c0b715429571a3829c1ddecab6a5c9e9cf1763e78da84434', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '0a7320e2676384a5c0b715429571a3829c1ddecab6a5c9e9cf1763e78da84434')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Només els interessats en el procediment.', false), ('B', 'Només les autoritats i el personal de l''Administració.', false), ('C', 'Només els òrgans que resolen, però no els que tramiten.', false), ('D', 'Les autoritats i el personal al servei de les administracions competents i també els interessats.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 30.5 de la Llei 39/2015, quan l''últim dia d''un termini és inhàbil:', 'L''article 30.5 LPAC prorroga el termini fins al primer dia hàbil següent quan l''últim dia és inhàbil.', 'plcat_t05_procediment_administratiu', (select id from public.topics where slug = 'plcat-t05-procediment-administratiu'), 1, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2015-10565'), 'Art. 30.5 Llei 39/2015', '5. Cuando el último día del plazo sea inhábil, se entenderá prorrogado al primer día hábil siguiente.', null, 'd3182724f29456612be3d5e305bf574144df8ba329ed6cbd35ca829356d9bed0', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'd3182724f29456612be3d5e305bf574144df8ba329ed6cbd35ca829356d9bed0')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El termini venç el dia hàbil immediatament anterior.', false), ('B', 'S''entén prorrogat al primer dia hàbil següent.', true), ('C', 'El termini venç igualment aquell dia.', false), ('D', 'S''entén prorrogat tres dies hàbils.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 38 de la Llei 39/2015, els actes de les administracions públiques subjectes al dret administratiu:', 'L''article 38 LPAC estableix el principi d''executivitat dels actes administratius.', 'plcat_t05_procediment_administratiu', (select id from public.topics where slug = 'plcat-t05-procediment-administratiu'), 1, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2015-10565'), 'Art. 38 Llei 39/2015', 'Los actos de las Administraciones Públicas sujetos al Derecho Administrativo serán ejecutivos con arreglo a lo dispuesto en esta Ley.', null, 'c7faec0a1cdc4a8ebfd3bd1a97ea9ccddbc3660bbfbe7e28c473792ce3493b5a', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'c7faec0a1cdc4a8ebfd3bd1a97ea9ccddbc3660bbfbe7e28c473792ce3493b5a')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Són executius d''acord amb el que disposa aquesta llei.', true), ('B', 'Només són executius quan són ferms en via judicial.', false), ('C', 'Necessiten l''aprovació d''un jutge per ser executius.', false), ('D', 'Només són executius si l''interessat no hi ha presentat recurs.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 40.2 de la Llei 39/2015, tota notificació s''ha de cursar dins el termini de:', 'L''article 40.2 LPAC fixa deu dies per cursar la notificació, que ha de contenir el text íntegre de la resolució i la indicació dels recursos procedents.', 'plcat_t05_procediment_administratiu', (select id from public.topics where slug = 'plcat-t05-procediment-administratiu'), 1, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2015-10565'), 'Art. 40.2 Llei 39/2015', '2. Toda notificación deberá ser cursada dentro del plazo de diez días a partir de la fecha en que el acto haya sido dictado', null, 'b9844c2ea676836a9d072b300436304ca6c9ae05dbf7bd2a3b58c510bfbcd532', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'b9844c2ea676836a9d072b300436304ca6c9ae05dbf7bd2a3b58c510bfbcd532')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Quinze dies a partir de la data en què s''ha dictat l''acte.', false), ('B', 'Un mes a partir de la data en què s''ha dictat l''acte.', false), ('C', 'Cinc dies a partir de la data en què s''ha dictat l''acte.', false), ('D', 'Deu dies a partir de la data en què s''ha dictat l''acte.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 44 de la Llei 39/2015, quan els interessats són desconeguts, s''ignora el lloc de la notificació o, intentada, no s''ha pogut practicar, la notificació es fa:', 'L''article 44 LPAC exigeix l''anunci al BOE; la publicació prèvia en altres butlletins o en el tauler d''edictes de l''ajuntament és facultativa.', 'plcat_t05_procediment_administratiu', (select id from public.topics where slug = 'plcat-t05-procediment-administratiu'), 1, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2015-10565'), 'Art. 44 Llei 39/2015', 'la notificación se hará por medio de un anuncio publicado en el «Boletín Oficial del Estado».', null, '2fc32c9cd4d3348f9f5d808d8536d983b695c8a0919f2420d8bb2f301f71313d', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '2fc32c9cd4d3348f9f5d808d8536d983b695c8a0919f2420d8bb2f301f71313d')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Mitjançant un anunci publicat només al tauler d''edictes de l''ajuntament.', false), ('B', 'Per mitjà de la policia local al darrer domicili conegut.', false), ('C', 'Mitjançant un anunci publicat al «Boletín Oficial del Estado».', true), ('D', 'Mitjançant un anunci en un diari de gran difusió.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 3.b) de la Llei 39/2015, els menors d''edat tenen capacitat d''obrar davant les administracions públiques:', 'L''article 3.b) LPAC reconeix capacitat d''obrar als menors per als drets i interessos que l''ordenament els permet exercir sense assistència dels representants legals.', 'plcat_t05_procediment_administratiu', (select id from public.topics where slug = 'plcat-t05-procediment-administratiu'), 2, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2015-10565'), 'Art. 3.b Llei 39/2015', 'b) Los menores de edad para el ejercicio y defensa de aquellos de sus derechos e intereses cuya actuación esté permitida por el ordenamiento jurídico sin la asistencia de la persona que ejerza la patria potestad, tutela o curatela.', null, '87957fbcfc5aa724ab93c62ad9c1af59d71b849761d1981aad94781de55c0290', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '87957fbcfc5aa724ab93c62ad9c1af59d71b849761d1981aad94781de55c0290')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'En cap cas, ja que sempre han d''actuar per mitjà dels seus representants legals.', false), ('B', 'Per a l''exercici i la defensa dels drets i interessos l''actuació dels quals permeti l''ordenament jurídic sense l''assistència de qui exerceix la pàtria potestat, la tutela o la curatela.', true), ('C', 'En tots els procediments a partir dels catorze anys.', false), ('D', 'Només en els procediments sancionadors en què siguin interessats.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 5.3 de la Llei 39/2015, per als actes i les gestions de mer tràmit en nom d''una altra persona:', 'L''article 5.3 LPAC exigeix acreditar la representació per formular sol·licituds, interposar recursos, desistir o renunciar, però la presumeix per als actes i gestions de mer tràmit.', 'plcat_t05_procediment_administratiu', (select id from public.topics where slug = 'plcat-t05-procediment-administratiu'), 2, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2015-10565'), 'Art. 5.3 Llei 39/2015', 'Para los actos y gestiones de mero trámite se presumirá aquella representación.', null, '0b7cbc3167c7f5d7ffb327aff671b819e79f266dde259a29fbf5768d4440fabe', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '0b7cbc3167c7f5d7ffb327aff671b819e79f266dde259a29fbf5768d4440fabe')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Es presumeix la representació.', true), ('B', 'S''ha d''acreditar la representació mitjançant poder notarial.', false), ('C', 'S''ha d''acreditar la representació amb inscripció al registre electrònic d''apoderaments.', false), ('D', 'No es pot actuar per mitjà de representant.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 5.6 de la Llei 39/2015, la manca d''acreditació de la representació o una acreditació insuficient:', 'L''article 5.6 LPAC permet esmenar la representació en el termini de deu dies (o superior si les circumstàncies ho requereixen) sense que l''acte deixi de tenir-se per fet.', 'plcat_t05_procediment_administratiu', (select id from public.topics where slug = 'plcat-t05-procediment-administratiu'), 2, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2015-10565'), 'Art. 5.6 Llei 39/2015', '6. La falta o insuficiente acreditación de la representación no impedirá que se tenga por realizado el acto de que se trate, siempre que se aporte aquélla o se subsane el defecto dentro del plazo de diez días que deberá conceder al efecto el órgano administrativo', null, '8e61d2fdd7e94278d4cdfc5f3f74ecbc4a2948d7085d1c62d0ec7a7987c6734e', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '8e61d2fdd7e94278d4cdfc5f3f74ecbc4a2948d7085d1c62d0ec7a7987c6734e')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'No impedeix tenir per fet l''acte si s''aporta l''acreditació o s''esmena el defecte en el termini de deu dies que ha de concedir l''òrgan administratiu.', true), ('B', 'Comporta la nul·litat de ple dret de l''acte.', false), ('C', 'Comporta l''arxivament immediat del procediment sense possibilitat d''esmena.', false), ('D', 'Es pot esmenar en el termini de quinze dies hàbils, improrrogable.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 25.1.b) de la Llei 39/2015, en un procediment sancionador iniciat d''ofici, el venciment del termini màxim sense que s''hagi dictat i notificat resolució expressa produeix:', 'L''article 25.1.b) LPAC preveu la caducitat en els procediments en què l''Administració exerceix potestats sancionadores o d''intervenció susceptibles de produir efectes desfavorables.', 'plcat_t05_procediment_administratiu', (select id from public.topics where slug = 'plcat-t05-procediment-administratiu'), 2, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2015-10565'), 'Art. 25.1.b Llei 39/2015', 'b) En los procedimientos en que la Administración ejercite potestades sancionadoras o, en general, de intervención, susceptibles de producir efectos desfavorables o de gravamen, se producirá la caducidad.', null, '13af801b06ffe7f1b0f3865fc762602374a18231c52dcb74c0b535f58ea61f98', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '13af801b06ffe7f1b0f3865fc762602374a18231c52dcb74c0b535f58ea61f98')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'L''estimació per silenci administratiu.', false), ('B', 'La prescripció de la infracció.', false), ('C', 'La desestimació per silenci administratiu.', false), ('D', 'La caducitat.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 30.4 de la Llei 39/2015, quan un termini fixat en mesos comença a comptar a partir d''una notificació i en el mes de venciment no hi ha dia equivalent, el termini expira:', 'L''article 30.4 LPAC disposa que el termini conclou el mateix dia de la notificació en el mes de venciment i, si no hi ha dia equivalent, expira l''últim dia del mes.', 'plcat_t05_procediment_administratiu', (select id from public.topics where slug = 'plcat-t05-procediment-administratiu'), 2, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2015-10565'), 'Art. 30.4 Llei 39/2015', 'Si en el mes de vencimiento no hubiera día equivalente a aquel en que comienza el cómputo, se entenderá que el plazo expira el último día del mes.', null, '7c2aa3cc6bcf6537fa3a361778fdec938b82d37fba98cd2237c2b2f92ab43d22', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '7c2aa3cc6bcf6537fa3a361778fdec938b82d37fba98cd2237c2b2f92ab43d22')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El primer dia del mes següent.', false), ('B', 'El dia hàbil anterior a l''últim dia del mes.', false), ('C', 'L''últim dia del mes.', true), ('D', 'Trenta dies naturals després de la notificació.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 32.1 de la Llei 39/2015, l''Administració pot concedir, d''ofici o a petició dels interessats, una ampliació dels terminis establerts que no excedeixi:', 'L''article 32.1 LPAC limita l''ampliació a la meitat del termini, si les circumstàncies ho aconsellen i no es perjudiquen drets de tercers.', 'plcat_t05_procediment_administratiu', (select id from public.topics where slug = 'plcat-t05-procediment-administratiu'), 2, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2015-10565'), 'Art. 32.1 Llei 39/2015', 'una ampliación de los plazos establecidos, que no exceda de la mitad de los mismos, si las circunstancias lo aconsejan y con ello no se perjudican derechos de tercero.', null, '958365a5b9f16b8bde76d911f9ee7dfda4aeb7b00c2a170aded85a6ea67b8ac9', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '958365a5b9f16b8bde76d911f9ee7dfda4aeb7b00c2a170aded85a6ea67b8ac9')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El doble dels terminis.', false), ('B', 'La meitat dels terminis.', true), ('C', 'Un terç dels terminis.', false), ('D', 'Deu dies hàbils.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 35.1 de la Llei 39/2015, quin d''aquests actes s''ha de motivar, amb una referència succinta de fets i fonaments de dret?', 'L''article 35.1.f) LPAC exigeix motivar els actes que rebutgen proves proposades pels interessats, entre altres supòsits (actes que limiten drets, sancionadors, discrecionals, etc.).', 'plcat_t05_procediment_administratiu', (select id from public.topics where slug = 'plcat-t05-procediment-administratiu'), 2, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2015-10565'), 'Art. 35.1 Llei 39/2015', 'f) Los actos que rechacen pruebas propuestas por los interesados.', null, 'b0270444a700fa5c558a86abdab71363d9b515b08d1324b5424468d70383246f', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'b0270444a700fa5c558a86abdab71363d9b515b08d1324b5424468d70383246f')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Les citacions per comparèixer en un tràmit.', false), ('B', 'Els actes de remissió de l''expedient a un altre òrgan.', false), ('C', 'La notificació de l''acord d''inici a l''interessat.', false), ('D', 'Els actes que rebutgin proves proposades pels interessats.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 42.2 de la Llei 39/2015, quan es practica una notificació en paper al domicili de l''interessat i aquest no hi és, se''n pot fer càrrec:', 'L''article 42.2 LPAC admet que se''n faci càrrec qualsevol persona major de catorze anys que sigui al domicili i que faci constar la seva identitat.', 'plcat_t05_procediment_administratiu', (select id from public.topics where slug = 'plcat-t05-procediment-administratiu'), 2, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2015-10565'), 'Art. 42.2 Llei 39/2015', 'podrá hacerse cargo de la misma cualquier persona mayor de catorce años que se encuentre en el domicilio y haga constar su identidad.', null, 'fa09aca054988eb03292afba93263d38390d4d3dc61abb5e8203ebabfaae1860', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'fa09aca054988eb03292afba93263d38390d4d3dc61abb5e8203ebabfaae1860')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Només una persona major d''edat que sigui familiar de l''interessat.', false), ('B', 'Qualsevol persona major de catorze anys que es trobi al domicili i faci constar la seva identitat.', true), ('C', 'Qualsevol persona major de setze anys que visqui habitualment al domicili.', false), ('D', 'Només el representant legal acreditat de l''interessat.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 43.2 de la Llei 39/2015, quan la notificació electrònica és obligatòria o l''ha triada expressament l''interessat, s''entén rebutjada quan han transcorregut sense accedir-hi:', 'L''article 43.2 LPAC fixa deu dies naturals des de la posada a disposició; la notificació electrònica s''entén practicada en el moment d''accedir-hi.', 'plcat_t05_procediment_administratiu', (select id from public.topics where slug = 'plcat-t05-procediment-administratiu'), 2, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2015-10565'), 'Art. 43.2 Llei 39/2015', 'se entenderá rechazada cuando hayan transcurrido diez días naturales desde la puesta a disposición de la notificación sin que se acceda a su contenido.', null, '95d2a3a136ccb3c853a6c017466c2d42ef1b6c2d788f115d0676cfddb26641fd', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '95d2a3a136ccb3c853a6c017466c2d42ef1b6c2d788f115d0676cfddb26641fd')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Deu dies hàbils des de la posada a disposició.', false), ('B', 'Quinze dies naturals des de la posada a disposició.', false), ('C', 'Deu dies naturals des de la posada a disposició.', true), ('D', 'Cinc dies hàbils des de la posada a disposició.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 30.6 de la Llei 39/2015, si un dia és hàbil al municipi on resideix l''interessat però inhàbil a la seu de l''òrgan administratiu:', 'L''article 30.6 LPAC disposa que, si el dia és hàbil en un lloc i inhàbil en l''altre (o a la inversa), es considera inhàbil en tot cas.', 'plcat_t05_procediment_administratiu', (select id from public.topics where slug = 'plcat-t05-procediment-administratiu'), 3, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2015-10565'), 'Art. 30.6 Llei 39/2015', '6. Cuando un día fuese hábil en el municipio o Comunidad Autónoma en que residiese el interesado, e inhábil en la sede del órgano administrativo, o a la inversa, se considerará inhábil en todo caso.', null, 'e5851d9a10421d7a73fef8ea701936cc8a167caba43cbed359c66ed0620ec04c', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'e5851d9a10421d7a73fef8ea701936cc8a167caba43cbed359c66ed0620ec04c')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Es considera inhàbil en tot cas.', true), ('B', 'Es considera hàbil en tot cas.', false), ('C', 'Es considera hàbil per a l''interessat i inhàbil per a l''Administració.', false), ('D', 'Prevaleix el calendari de la comunitat autònoma de l''interessat.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Sobre l''ampliació de terminis de l''article 32.3 de la Llei 39/2015, quina afirmació és INCORRECTA?', 'L''article 32.3 LPAC prohibeix ampliar un termini ja vençut; la petició i la decisió han de ser anteriors al venciment, i els acords d''ampliació o de denegació no són recurribles, sens perjudici del recurs contra la resolució final.', 'plcat_t05_procediment_administratiu', (select id from public.topics where slug = 'plcat-t05-procediment-administratiu'), 3, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2015-10565'), 'Art. 32.3 Llei 39/2015', 'Tanto la petición de los interesados como la decisión sobre la ampliación deberán producirse, en todo caso, antes del vencimiento del plazo de que se trate. En ningún caso podrá ser objeto de ampliación un plazo ya vencido.', null, 'bc771f3562a8291e6e8e537594379c753c3a1ca82394896524275c82a46f90b1', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'bc771f3562a8291e6e8e537594379c753c3a1ca82394896524275c82a46f90b1')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'La petició i la decisió sobre l''ampliació s''han de produir abans del venciment del termini.', false), ('B', 'Els acords sobre ampliació de terminis o la seva denegació no són susceptibles de recurs.', false), ('C', 'Es pot ampliar un termini ja vençut si l''interessat ho sol·licita de manera motivada.', true), ('D', 'Es pot recórrer contra la resolució que posi fi al procediment.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 39.3 de la Llei 39/2015, excepcionalment es pot atorgar eficàcia retroactiva als actes:', 'L''article 39.3 LPAC admet la retroactivitat d''actes dictats en substitució d''actes anul·lats i d''actes favorables, si els fets ja existien i no es lesionen drets o interessos legítims d''altri.', 'plcat_t05_procediment_administratiu', (select id from public.topics where slug = 'plcat-t05-procediment-administratiu'), 3, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2015-10565'), 'Art. 39.3 Llei 39/2015', '3. Excepcionalmente, podrá otorgarse eficacia retroactiva a los actos cuando se dicten en sustitución de actos anulados, así como cuando produzcan efectos favorables al interesado', null, '358883d7f941742ca3041b086830ac278e9f653452411942d9e0243655c515a4', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '358883d7f941742ca3041b086830ac278e9f653452411942d9e0243655c515a4')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Quan es dictin en substitució d''actes anul·lats, i quan produeixin efectes favorables a l''interessat, si concorren els requisits que s''hi estableixen.', true), ('B', 'Quan imposin sancions, sempre que ho acordi l''òrgan superior jeràrquic.', false), ('C', 'Sempre que ho sol·liciti l''interessat, encara que lesionin drets de terceres persones.', false), ('D', 'Només quan ho autoritzi una resolució judicial.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 42.2 de la Llei 39/2015, si ningú no es fa càrrec d''una notificació en paper practicada al domicili, l''intent s''ha de repetir:', 'L''article 42.2 LPAC exigeix un segon i únic intent en hora diferent dins els tres dies següents (abans i després de les quinze hores), amb un marge d''almenys tres hores.', 'plcat_t05_procediment_administratiu', (select id from public.topics where slug = 'plcat-t05-procediment-administratiu'), 3, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2015-10565'), 'Art. 42.2 Llei 39/2015', 'intento que se repetirá por una sola vez y en una hora distinta dentro de los tres días siguientes. […] dejando en todo caso al menos un margen de diferencia de tres horas entre ambos intentos de notificación.', null, '70d0f832901c8db496d92f811d2ceebf23ee0652aa51a0f2126940debc857f6d', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '70d0f832901c8db496d92f811d2ceebf23ee0652aa51a0f2126940debc857f6d')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Dues vegades més dins els cinc dies següents, a la mateixa hora.', false), ('B', 'Una sola vegada l''endemà, a la mateixa hora del primer intent.', false), ('C', 'Una sola vegada dins els deu dies següents, en qualsevol hora.', false), ('D', 'Una sola vegada i en una hora diferent dins els tres dies següents, amb un marge mínim de tres hores entre tots dos intents.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 48.2 de la Llei 39/2015, el defecte de forma només determina l''anul·labilitat de l''acte quan:', 'L''article 48.2 LPAC limita l''anul·labilitat per defecte de forma als casos en què falten requisits formals indispensables o es produeix indefensió.', 'plcat_t05_procediment_administratiu', (select id from public.topics where slug = 'plcat-t05-procediment-administratiu'), 3, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2015-10565'), 'Art. 48.2 Llei 39/2015', '2. No obstante, el defecto de forma sólo determinará la anulabilidad cuando el acto carezca de los requisitos formales indispensables para alcanzar su fin o dé lugar a la indefensión de los interesados.', null, '46e71938630e4bdf3c09936f4bb1fe65651934b9e87198d9351f85b026bad80c', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '46e71938630e4bdf3c09936f4bb1fe65651934b9e87198d9351f85b026bad80c')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'L''acte s''ha dictat fora del termini establert, sigui quina sigui la naturalesa del termini.', false), ('B', 'L''acte no té els requisits formals indispensables per assolir la seva finalitat o dona lloc a la indefensió dels interessats.', true), ('C', 'L''acte no esmenta el peu de recursos, encara que contingui el text íntegre.', false), ('D', 'Ho declari el mateix òrgan que el va dictar en el termini d''un mes.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
-- Lote plcat-t06-forces-cossos-seguretat-lofcs-v1 (20 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Ley Orgánica 2/1986, de 13 de marzo, de Fuerzas y Cuerpos de Seguridad (texto consolidado, BOE)', 'https://www.boe.es/buscar/act.php?id=BOE-A-1986-6859', 'boe'::public.source_kind, 'Agencia Estatal Boletín Oficial del Estado', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('plcat-t06-forces-cossos-seguretat', 'Tema 6. La Llei orgànica 2/1986 de forces i cossos de seguretat: principis bàsics d''actuació i policies locals') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('policia-local') and t.slug = 'plcat-t06-forces-cossos-seguretat' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 1.4 de la LO 2/1986, les diferents administracions públiques exerceixen el manteniment de la seguretat pública:', 'L''article 1.4 LOFCS disposa que el manteniment de la seguretat pública l''exerceixen les administracions públiques per mitjà de les forces i cossos de seguretat.', 'plcat_t06_forces_cossos_seguretat', (select id from public.topics where slug = 'plcat-t06-forces-cossos-seguretat'), 1, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1986-6859'), 'Art. 1.4 LO 2/1986', '4. El mantenimiento de la Seguridad Pública se ejercerá por las distintas Administraciones Públicas a través de las Fuerzas y Cuerpos de Seguridad.', null, '83da7e95b33d0a023768c2d6f4343ace00c9a721a74425ec2a7df0ea191a98e0', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '83da7e95b33d0a023768c2d6f4343ace00c9a721a74425ec2a7df0ea191a98e0')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'A través de les Forces Armades.', false), ('B', 'A través de les empreses de seguretat privada.', false), ('C', 'A través dels serveis de protecció civil.', false), ('D', 'A través de les forces i cossos de seguretat.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 4.1 de la LO 2/1986, el deure de prestar a les forces i cossos de seguretat l''auxili necessari en la investigació i la persecució dels delictes correspon:', 'L''article 4.1 LOFCS estableix un deure general: tothom ha de prestar l''auxili necessari en la investigació i persecució dels delictes.', 'plcat_t06_forces_cossos_seguretat', (select id from public.topics where slug = 'plcat-t06-forces-cossos-seguretat'), 1, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1986-6859'), 'Art. 4.1 LO 2/1986', '1. Todos tienen el deber de prestar a las Fuerzas y Cuerpos de Seguridad el auxilio necesario en la investigación y persecución de los delitos en los términos previstos legalmente.', null, '962dcaf379d9511905513bc99aa6d477e6b3934bade74c725c334f33b800a68e', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '962dcaf379d9511905513bc99aa6d477e6b3934bade74c725c334f33b800a68e')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'A tothom, en els termes previstos legalment.', true), ('B', 'Només als funcionaris públics.', false), ('C', 'Només al personal de seguretat privada.', false), ('D', 'Només a les persones que hagin presenciat el delicte.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 5.2.d) de la LO 2/1986, els membres de les forces i cossos de seguretat només han d''utilitzar les armes:', 'L''article 5.2.d) LOFCS limita l''ús de les armes a situacions de risc racionalment greu per a la vida o la integritat pròpia o de tercers, o de greu risc per a la seguretat ciutadana, d''acord amb els principis de congruència, oportunitat i proporcionalitat.', 'plcat_t06_forces_cossos_seguretat', (select id from public.topics where slug = 'plcat-t06-forces-cossos-seguretat'), 1, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1986-6859'), 'Art. 5.2.d LO 2/1986', 'd) Solamente deberán utilizar las armas en las situaciones en que exista un riesgo racionalmente grave para su vida, su integridad física o las de terceras personas, o en aquellas circunstancias que puedan suponer un grave riesgo para la seguridad ciudadana', null, 'feeffb7511a1cfe427bcf5e11cdbb367bf722b5fb8394e199015cea3506eb817', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'feeffb7511a1cfe427bcf5e11cdbb367bf722b5fb8394e199015cea3506eb817')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Sempre que el detingut intenti fugir, sigui quin sigui el delicte.', false), ('B', 'Quan ho autoritzi prèviament el comandament superior jeràrquic.', false), ('C', 'En situacions de risc racionalment greu per a la seva vida, la seva integritat física o la de terceres persones, o de greu risc per a la seguretat ciutadana.', true), ('D', 'En qualsevol intervenció en què el ciutadà desobeeixi una ordre.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 6.8 de la LO 2/1986, els membres de les forces i cossos de seguretat:', 'L''article 6.8 LOFCS prohibeix en tot cas la vaga i les accions substitutives o concertades per alterar el funcionament normal dels serveis.', 'plcat_t06_forces_cossos_seguretat', (select id from public.topics where slug = 'plcat-t06-forces-cossos-seguretat'), 1, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1986-6859'), 'Art. 6.8 LO 2/1986', '8. Los miembros de las Fuerzas y Cuerpos de Seguridad no podrán ejercer en ningún caso el derecho de huelga, ni acciones sustitutivas del mismo o concertadas con el fin de alterar el normal funcionamiento de los servicios.', null, '53484d39313031c039c2c73602ea040a785eafb02edabdc23f56af36a59694b4', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '53484d39313031c039c2c73602ea040a785eafb02edabdc23f56af36a59694b4')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Poden exercir el dret de vaga si garanteixen uns serveis mínims del 50 %.', false), ('B', 'No poden exercir en cap cas el dret de vaga ni accions substitutives o concertades per alterar el funcionament normal dels serveis.', true), ('C', 'Poden exercir el dret de vaga amb autorització prèvia del Ministeri de l''Interior.', false), ('D', 'Només poden fer vaga els membres dels cossos de policia local.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 7.1 de la LO 2/1986, en l''exercici de les seves funcions, els membres de les forces i cossos de seguretat tenen, a tots els efectes legals, el caràcter de:', 'L''article 7.1 LOFCS els atribueix el caràcter d''agents de l''autoritat; només a efectes de protecció penal i en els atemptats de l''article 7.2 tenen la consideració d''autoritat.', 'plcat_t06_forces_cossos_seguretat', (select id from public.topics where slug = 'plcat-t06-forces-cossos-seguretat'), 1, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1986-6859'), 'Art. 7.1 LO 2/1986', '1. En el ejercicio de sus funciones, los miembros de las Fuerzas y Cuerpos de Seguridad tendrán a todos los efectos legales el carácter de agentes de la autoridad.', null, '1b4580d5f94bfdbfc324294da2635ef0ba869f03b72e7efd6b0628548d39fc6a', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '1b4580d5f94bfdbfc324294da2635ef0ba869f03b72e7efd6b0628548d39fc6a')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Agents de l''autoritat.', true), ('B', 'Autoritat.', false), ('C', 'Funcionaris de carrera de l''Estat.', false), ('D', 'Personal militar.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 52.1 de la LO 2/1986, els cossos de policia local són:', 'L''article 52.1 LOFCS defineix les policies locals com a instituts armats de naturalesa civil amb estructura i organització jerarquitzada.', 'plcat_t06_forces_cossos_seguretat', (select id from public.topics where slug = 'plcat-t06-forces-cossos-seguretat'), 1, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1986-6859'), 'Art. 52.1 LO 2/1986', '1. Los Cuerpos de Policía Local son Institutos armados, de naturaleza civil con estructura y organización jerarquizada', null, 'd38fb3f939c754b8d7bfcddd335aa9f77177f700bc7996b4eb34277cdc06ef2a', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'd38fb3f939c754b8d7bfcddd335aa9f77177f700bc7996b4eb34277cdc06ef2a')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Instituts armats de naturalesa militar, amb estructura jerarquitzada.', false), ('B', 'Instituts armats de naturalesa civil, amb estructura i organització jerarquitzada.', true), ('C', 'Cossos civils no armats, de naturalesa administrativa.', false), ('D', 'Unitats adscrites a la Policia de la comunitat autònoma.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 3 de la LO 2/1986, els membres de les forces i cossos de seguretat han d''ajustar la seva actuació al principi de:', 'L''article 3 LOFCS imposa el principi de cooperació recíproca, i la coordinació s''efectua pels òrgans que estableix la llei.', 'plcat_t06_forces_cossos_seguretat', (select id from public.topics where slug = 'plcat-t06-forces-cossos-seguretat'), 2, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1986-6859'), 'Art. 3 LO 2/1986', 'Los miembros de las Fuerzas y Cuerpos de Seguridad ajustarán su actuación al principio de cooperación recíproca y su coordinación se efectuará a través de los órganos que a tal efecto establece esta Ley.', null, '737554ef71d05dfefc9c5491356e279a85d1c1d4167e9168eab0f1bbfb2dadd1', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '737554ef71d05dfefc9c5491356e279a85d1c1d4167e9168eab0f1bbfb2dadd1')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Subsidiarietat.', false), ('B', 'Competència exclusiva.', false), ('C', 'Cooperació recíproca.', true), ('D', 'Autonomia funcional.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 4.2 de la LO 2/1986, tenen una obligació especial d''auxiliar o col·laborar en tot moment amb les forces i cossos de seguretat:', 'L''article 4.2 LOFCS estableix l''obligació especial d''auxili i col·laboració de qui exerceix funcions de vigilància, seguretat o custòdia.', 'plcat_t06_forces_cossos_seguretat', (select id from public.topics where slug = 'plcat-t06-forces-cossos-seguretat'), 2, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1986-6859'), 'Art. 4.2 LO 2/1986', '2. Las personas y entidades que ejerzan funciones de vigilancia, seguridad o custodia referidas a personal y bienes o servicios de titularidad pública o privada tienen especial obligación de auxiliar o colaborar en todo momento con las Fuerzas y Cuerpos de Seguridad.', null, 'b257b2b3f7059abe1facc7bc4182d0fd3a2beaf02bfe29aad2ccbc821b19c542', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'b257b2b3f7059abe1facc7bc4182d0fd3a2beaf02bfe29aad2ccbc821b19c542')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Només els membres de les Forces Armades.', false), ('B', 'Els titulars d''establiments oberts al públic.', false), ('C', 'Els funcionaris de l''Administració de justícia.', false), ('D', 'Les persones i entitats que exerceixen funcions de vigilància, seguretat o custòdia de personal, béns o serveis de titularitat pública o privada.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 5.1.d) de la LO 2/1986, en relació amb els principis de jerarquia i subordinació:', 'L''article 5.1.d) LOFCS subjecta els agents als principis de jerarquia i subordinació, però l''obediència deguda no empara ordres manifestament delictives o contràries a la Constitució o a les lleis.', 'plcat_t06_forces_cossos_seguretat', (select id from public.topics where slug = 'plcat-t06-forces-cossos-seguretat'), 2, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1986-6859'), 'Art. 5.1.d LO 2/1986', 'En ningún caso, la obediencia debida podrá amparar órdenes que entrañen la ejecución de actos que manifiestamente constituyan delito o sean contrarios a la Constitución o a las Leyes.', null, 'b6602d60b1d477eb6f8eac03ec9e0633026df1471b0bdfb644e6cd846a5bbfd4', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'b6602d60b1d477eb6f8eac03ec9e0633026df1471b0bdfb644e6cd846a5bbfd4')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'L''obediència deguda no pot emparar en cap cas ordres que comportin l''execució d''actes manifestament constitutius de delicte o contraris a la Constitució o a les lleis.', true), ('B', 'L''obediència deguda exonera de responsabilitat l''agent que compleix qualsevol ordre del superior.', false), ('C', 'L''agent pot desobeir qualsevol ordre que consideri inoportuna.', false), ('D', 'L''obediència deguda només es pot invocar en situacions d''estat d''excepció.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Dins el principi de tractament de detinguts, l''article 5.3.b) de la LO 2/1986 estableix que els agents:', 'L''article 5.3.b) LOFCS obliga a vetllar per la vida i la integritat física de les persones detingudes o sota custòdia i a respectar-ne l''honor i la dignitat.', 'plcat_t06_forces_cossos_seguretat', (select id from public.topics where slug = 'plcat-t06-forces-cossos-seguretat'), 2, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1986-6859'), 'Art. 5.3.b LO 2/1986', 'b) Velarán por la vida e integridad física de las personas a quienes detuvieren o que se encuentren bajo su custodia y respetarán el honor y la dignidad de las personas.', null, '56be963805d62eb63d533db0d30252047a46940bf89467b6995c18aa97223378', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '56be963805d62eb63d533db0d30252047a46940bf89467b6995c18aa97223378')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Han de posar el detingut a disposició judicial en un termini màxim de vint-i-quatre hores.', false), ('B', 'Han de demanar sempre la presència d''un advocat abans d''identificar-se.', false), ('C', 'Han de vetllar per la vida i la integritat física de les persones que detinguin o que estiguin sota la seva custòdia i respectar-ne l''honor i la dignitat.', true), ('D', 'Poden limitar la comunicació del detingut amb la família durant les primeres quaranta-vuit hores.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 6.7 de la LO 2/1986, la pertinença a les forces i cossos de seguretat:', 'L''article 6.7 LOFCS estableix la incompatibilitat amb qualsevol altra activitat pública o privada, excepte les exceptuades per la legislació d''incompatibilitats.', 'plcat_t06_forces_cossos_seguretat', (select id from public.topics where slug = 'plcat-t06-forces-cossos-seguretat'), 2, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1986-6859'), 'Art. 6.7 LO 2/1986', '7. La pertenencia a las fuerzas y Cuerpos de Seguridad es causa de incompatibilidad para el desempeño de cualquier otra actividad pública o privada, salvo aquellas actividades exceptuadas de la legislación sobre incompatibilidades.', null, '9754a6e1e37150807d0a5506482c9384819606a1cad4e99dd46247197fb555c9', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '9754a6e1e37150807d0a5506482c9384819606a1cad4e99dd46247197fb555c9')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'És compatible amb qualsevol activitat privada fora de l''horari de servei.', false), ('B', 'És causa d''incompatibilitat per exercir qualsevol altra activitat pública o privada, llevat de les exceptuades de la legislació sobre incompatibilitats.', true), ('C', 'Només és incompatible amb activitats de seguretat privada.', false), ('D', 'És compatible amb altres activitats públiques si ho autoritza l''alcalde.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 7.3 de la LO 2/1986, la Guàrdia Civil té la consideració de força armada:', 'L''article 7.3 LOFCS limita la consideració de força armada de la Guàrdia Civil al compliment de missions de caràcter militar.', 'plcat_t06_forces_cossos_seguretat', (select id from public.topics where slug = 'plcat-t06-forces-cossos-seguretat'), 2, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1986-6859'), 'Art. 7.3 LO 2/1986', '3. La Guardia Civil sólo tendrá consideración de fuerza armada en el cumplimiento de las misiones de carácter militar que se le encomienden, de acuerdo con el ordenamiento jurídico.', null, '1bc4fff310aa6343c6c602b77de46f5bbccf2216294c62174868284e4e49f70f', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '1bc4fff310aa6343c6c602b77de46f5bbccf2216294c62174868284e4e49f70f')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'En totes les seves actuacions.', false), ('B', 'Només durant l''estat d''alarma.', false), ('C', 'Només quan actua com a policia judicial.', false), ('D', 'Només en el compliment de les missions de caràcter militar que se li encomanin.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 8.2 de la LO 2/1986, els membres de les forces i cossos de seguretat compleixen la presó preventiva i les penes privatives de llibertat:', 'L''article 8.2 LOFCS preveu el compliment en establiments penitenciaris ordinaris, separats de la resta de detinguts o presos.', 'plcat_t06_forces_cossos_seguretat', (select id from public.topics where slug = 'plcat-t06-forces-cossos-seguretat'), 2, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1986-6859'), 'Art. 8.2 LO 2/1986', 'se realizarán en establecimientos penitenciarios ordinarios, con separación del resto de detenidos o presos.', null, '72131d4db9b3737f6110f194604f3f5d0200bdbbb8b7a200d8dafeb4bf5a9fa4', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '72131d4db9b3737f6110f194604f3f5d0200bdbbb8b7a200d8dafeb4bf5a9fa4')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'En establiments penitenciaris militars.', false), ('B', 'En establiments penitenciaris ordinaris, amb separació de la resta de detinguts o presos.', true), ('C', 'En dependències policials habilitades a aquest efecte.', false), ('D', 'En establiments ordinaris, sense cap règim de separació.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 51.2 de la LO 2/1986, en els municipis on no hi ha policia municipal, les seves tasques les exerceix:', 'L''article 51.2 LOFCS atribueix aquestes tasques al personal de custòdia i vigilància (guardes, vigilants, agents, agutzils o anàlegs).', 'plcat_t06_forces_cossos_seguretat', (select id from public.topics where slug = 'plcat-t06-forces-cossos-seguretat'), 2, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1986-6859'), 'Art. 51.2 LO 2/1986', '2. En los municipios donde no exista policía municipal, los cometidos de ésta serán ejercidos por el personal que desempeñe funciones de custodia y vigilancia de bienes, servicios e instalaciones, con la denominación de guardas, vigilantes, agentes, alguaciles o análogos.', null, '8cddd0fe613dc7fdc6f9e274462c5de046e7dc0100f44d7c6c11df96cfb15114', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '8cddd0fe613dc7fdc6f9e274462c5de046e7dc0100f44d7c6c11df96cfb15114')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'La Guàrdia Civil, de manera exclusiva.', false), ('B', 'La policia local del municipi més proper, mitjançant conveni.', false), ('C', 'El personal que fa funcions de custòdia i vigilància de béns, serveis i instal·lacions, amb la denominació de guardes, vigilants, agents, agutzils o anàlogues.', true), ('D', 'L''alcalde personalment, amb l''ajuda dels regidors.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 10.1 de la LO 2/1986, l''administració general de la seguretat ciutadana i el comandament superior de les forces i cossos de seguretat de l''Estat corresponen:', 'L''article 10.1 LOFCS atribueix al ministre de l''Interior l''administració general de la seguretat ciutadana i el comandament superior; el director de la Seguretat de l''Estat l''exerceix sota la seva autoritat immediata (art. 10.2).', 'plcat_t06_forces_cossos_seguretat', (select id from public.topics where slug = 'plcat-t06-forces-cossos-seguretat'), 2, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1986-6859'), 'Art. 10.1 LO 2/1986', '1. Corresponde al Ministro del Interior la administración general de la seguridad ciudadana y el mando superior de las Fuerzas y Cuerpos de Seguridad del Estado', null, '43f9a015ad16fa918dd0243601dc9276481466379deee723b13248a673292b44', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '43f9a015ad16fa918dd0243601dc9276481466379deee723b13248a673292b44')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Al president del Govern.', false), ('B', 'Al director de la Seguretat de l''Estat.', false), ('C', 'Al ministre de Defensa.', false), ('D', 'Al ministre de l''Interior.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 8.3 de la LO 2/1986, quan s''inicia un procediment penal contra un membre de les forces i cossos de seguretat, l''expedient disciplinari pels mateixos fets:', 'L''article 8.3 LOFCS permet incoar i tramitar l''expedient, però la resolució definitiva espera la sentència penal ferma, els fets provats de la qual vinculen l''Administració.', 'plcat_t06_forces_cossos_seguretat', (select id from public.topics where slug = 'plcat-t06-forces-cossos-seguretat'), 3, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1986-6859'), 'Art. 8.3 LO 2/1986', '3. La iniciación de procedimiento penal contra miembros de las Fuerzas y Cuerpos de Seguridad, no impedirá la incoación y tramitación de expedientes gubernativos o disciplinarios por los mismos hechos. No obstante, la resolución definitiva del expediente sólo podrá producirse cuando la sentencia recaída en el ámbito penal sea firme, y la declaración de hechos probados vinculará a la administración.', null, 'b55da3239ac968e5fd4a5279d2cc10160d3318d4e8623b44341a7ce76f4921c0', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'b55da3239ac968e5fd4a5279d2cc10160d3318d4e8623b44341a7ce76f4921c0')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Es pot incoar i tramitar, però la resolució definitiva només es pot produir quan la sentència penal sigui ferma, i la declaració de fets provats vincula l''Administració.', true), ('B', 'No es pot incoar fins que la sentència penal sigui ferma.', false), ('C', 'S''ha de resoldre abans que el procés penal per no perjudicar el servei.', false), ('D', 'S''arxiva automàticament, perquè regeix el principi non bis in idem.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 6.6 de la LO 2/1986, els llocs de servei en les respectives categories es proveeixen d''acord amb els principis de:', 'L''article 6.6 LOFCS fixa els principis de mèrit, capacitat i antiguitat per a la provisió dels llocs de servei.', 'plcat_t06_forces_cossos_seguretat', (select id from public.topics where slug = 'plcat-t06-forces-cossos-seguretat'), 3, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1986-6859'), 'Art. 6.6 LO 2/1986', '6. Los puestos de servicio en las respectivas categorías se proveerán conforme a los principios de mérito, capacidad y antigüedad', null, '346fda55fa975c65329384b29b175aa6286a14cc677ccccbbd4fe329f431111a', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '346fda55fa975c65329384b29b175aa6286a14cc677ccccbbd4fe329f431111a')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Mèrit, capacitat i antiguitat.', true), ('B', 'Igualtat, mèrit i publicitat.', false), ('C', 'Mèrit, capacitat i lliure designació.', false), ('D', 'Antiguitat, formació i disponibilitat.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 39.c) de la LO 2/1986, en fixar els criteris de selecció, formació, promoció i mobilitat de les policies locals, les comunitats autònomes han de determinar els nivells educatius exigibles per a cada categoria, que en cap cas no poden ser inferiors a:', 'L''article 39.c) LOFCS estableix que el nivell educatiu exigible no pot ser inferior al de graduat escolar.', 'plcat_t06_forces_cossos_seguretat', (select id from public.topics where slug = 'plcat-t06-forces-cossos-seguretat'), 3, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1986-6859'), 'Art. 39.c LO 2/1986', 'determinando los distintos niveles educativos exigibles para cada categoría, sin que, en ningún caso, el nivel pueda ser inferior a graduado escolar.', null, 'e6900cc7b3f9529bf1aac0441a199dfe30475d96184514f04f63eecdae21a4e3', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'e6900cc7b3f9529bf1aac0441a199dfe30475d96184514f04f63eecdae21a4e3')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Batxillerat.', false), ('B', 'Graduat escolar.', true), ('C', 'Títol de tècnic superior.', false), ('D', 'Certificat d''estudis primaris.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 53.3 de la LO 2/1986, en els municipis de gran població, el Ple pot assignar a part dels funcionaris l''exercici exclusiu de la funció d''ordenar, senyalitzar i dirigir el trànsit al casc urbà. Aquests funcionaris:', 'L''article 53.3 LOFCS els configura com a agents de l''autoritat subordinats a la policia local, sense integrar-se en les forces i cossos de seguretat.', 'plcat_t06_forces_cossos_seguretat', (select id from public.topics where slug = 'plcat-t06-forces-cossos-seguretat'), 3, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1986-6859'), 'Art. 53.3 LO 2/1986', 'que tendrán la consideración de agentes de la autoridad, subordinados a los miembros de los respectivos Cuerpos de Policía Local, sin integrarse en las Fuerzas y Cuerpos de Seguridad', null, 'a20ee9e32646da9c66c47165f9ba6851dd11f055fb910ef3236194c1e8ddb663', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'a20ee9e32646da9c66c47165f9ba6851dd11f055fb910ef3236194c1e8ddb663')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'S''integren a tots els efectes en el cos de policia local.', false), ('B', 'Tenen la consideració d''autoritat i depenen directament de l''alcalde.', false), ('C', 'Tenen la consideració d''agents de l''autoritat, subordinats als membres del cos de policia local, sense integrar-se en les forces i cossos de seguretat.', true), ('D', 'S''integren en les forces i cossos de seguretat de l''Estat.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 50.1 de la LO 2/1986, la Junta de Seguretat que es pot constituir a les comunitats autònomes amb cossos de policia propis està integrada per:', 'L''article 50.1 LOFCS preveu una Junta de Seguretat paritària, amb igual nombre de representants de l''Estat i de la comunitat, per coordinar l''actuació de les policies estatals i autonòmiques.', 'plcat_t06_forces_cossos_seguretat', (select id from public.topics where slug = 'plcat-t06-forces-cossos-seguretat'), 3, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1986-6859'), 'Art. 50.1 LO 2/1986', '1. En las Comunidades Autónomas que dispongan de Cuerpos de Policía propios podrá constituirse una Junta de Seguridad, integrada por igual número de representantes del Estado y de las Comunidades Autónomas', null, 'b59f9d97f160101df9b3f907e008bdc0b1334947f9f9335b518caed7bcce3a09', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'b59f9d97f160101df9b3f907e008bdc0b1334947f9f9335b518caed7bcce3a09')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Una majoria de representants de l''Estat.', false), ('B', 'Una majoria de representants de la comunitat autònoma.', false), ('C', 'Representants dels ajuntaments amb policia local i de la comunitat autònoma.', false), ('D', 'Un nombre igual de representants de l''Estat i de la comunitat autònoma.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
-- Lote plcat-t07-policies-locals-funcions-lpl-v1 (20 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Ley 16/1991, de 10 de julio, de las Policías Locales (Cataluña) (texto consolidado, BOE)', 'https://www.boe.es/buscar/act.php?id=BOE-A-1991-20343', 'boe'::public.source_kind, 'Agencia Estatal Boletín Oficial del Estado', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('plcat-t07-policies-locals-funcions', 'Tema 7. La Llei 16/1991 de les policies locals: naturalesa, funcions, coordinació, estructura i accés') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('policia-local') and t.slug = 'plcat-t07-policies-locals-funcions' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 3.1 de la Llei 16/1991, a partir de quina població pot existir policia local en un municipi sense necessitat de cap autorització especial?', 'L''article 3.1 admet la policia local als municipis de més de 10.000 habitants; per sota d''aquesta xifra cal l''acord de la majoria absoluta i l''autorització del conseller (art. 3.2).', 'plcat_t07_policies_locals_funcions', (select id from public.topics where slug = 'plcat-t07-policies-locals-funcions'), 1, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1991-20343'), 'Art. 3.1 Llei 16/1991', '1. Puede existir Policía local en los Municipios de más de 10.000 habitantes.', null, 'caf4df3dfa188d3dccea8ecc11a545ca5d137d7a68add529fa11fec9d5e8d39f', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'caf4df3dfa188d3dccea8ecc11a545ca5d137d7a68add529fa11fec9d5e8d39f')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Als municipis de més de 10.000 habitants.', true), ('B', 'Als municipis de més de 5.000 habitants.', false), ('C', 'Als municipis de més de 20.000 habitants.', false), ('D', 'Als municipis de més de 50.000 habitants.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Com s''organitza la policia local de cada municipi segons l''article 4.1 de la Llei 16/1991?', 'L''article 4.1 estableix que la policia local de cada municipi s''integra en un cos únic, sens perjudici de l''organització interna que es fixi per reglament.', 'plcat_t07_policies_locals_funcions', (select id from public.topics where slug = 'plcat-t07-policies-locals-funcions'), 1, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1991-20343'), 'Art. 4.1 Llei 16/1991', '1. La Policía local de cada Municipio se integrará en un Cuerpo único, sin perjuicio de la organización interna que se adopte por Reglamento.', null, '2c7f9469d626dc0a7659d6d06a29a4c1e1bdc05ee2ab4c3edd687780e7435298', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '2c7f9469d626dc0a7659d6d06a29a4c1e1bdc05ee2ab4c3edd687780e7435298')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'En tants cossos com districtes tingui el municipi.', false), ('B', 'En dos cossos separats: un d''uniformat i un altre de paisà.', false), ('C', 'S''integra en un cos únic, sens perjudici de l''organització interna que s''adopti per reglament.', true), ('D', 'En un cos únic de caràcter comarcal compartit amb els municipis veïns.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Pel que fa a les armes de foc, l''article 8.3 de la Llei 16/1991 estableix que els vigilants municipals de l''article 1.2:', 'L''article 8.3 prohibeix de manera absoluta que els vigilants de l''article 1.2 portin armes de foc.', 'plcat_t07_policies_locals_funcions', (select id from public.topics where slug = 'plcat-t07-policies-locals-funcions'), 1, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1991-20343'), 'Art. 8.3 Llei 16/1991', '3. Los vigilantes a que se refiere el artículo 1.2 no pueden llevar armas de fuego.', null, '2364f9de890b0f1ad1ee4339ca578c97a19adb1d7d0324c7822e9f111f4f6139', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '2364f9de890b0f1ad1ee4339ca578c97a19adb1d7d0324c7822e9f111f4f6139')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Poden portar armes de foc si ho autoritza l''alcalde.', false), ('B', 'No poden portar armes de foc.', true), ('C', 'Només poden portar armes de foc en el servei nocturn.', false), ('D', 'Poden portar armes de foc si han superat un curs a l''Escola de Policia.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons els principis bàsics d''actuació de l''article 10 de la Llei 16/1991, en relació amb el tractament de detinguts, els policies locals han de:', 'L''article 10.1, tercer, a), imposa als policies locals el deure d''identificar-se degudament com a agents en el moment d''efectuar una detenció.', 'plcat_t07_policies_locals_funcions', (select id from public.topics where slug = 'plcat-t07-policies-locals-funcions'), 1, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1991-20343'), 'Art. 10.1 tercer Llei 16/1991', 'a) Identificarse debidamente como agentes en el momento de efectuar una detención.', null, '439f8cdaf84d21612d3e369a15ee447623f7d3aad1ea79cfa7dc3dd035402007', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '439f8cdaf84d21612d3e369a15ee447623f7d3aad1ea79cfa7dc3dd035402007')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Identificar-se com a agents només si la persona detinguda ho demana.', false), ('B', 'Identificar-se davant del jutge, però no davant de la persona detinguda.', false), ('C', 'Identificar-se un cop arribin a la dependència policial.', false), ('D', 'Identificar-se degudament com a agents en el moment d''efectuar una detenció.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Quina categoria comprèn l''escala executiva dels cossos de policia local, segons l''article 24.1 de la Llei 16/1991?', 'L''article 24.1.b) estableix que l''escala executiva comprèn la categoria d''inspector; sotsinspector i sergent són de l''escala intermèdia i intendent, intendent major i superintendent, de la superior.', 'plcat_t07_policies_locals_funcions', (select id from public.topics where slug = 'plcat-t07-policies-locals-funcions'), 1, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1991-20343'), 'Art. 24.1 Llei 16/1991', 'b) Escala ejecutiva, que comprende la categoría de Inspector.', null, '8f6c4f19d44205263d409f158e36f2f73b627f195e1bc16ea7d4fbe8c5f6dbc2', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '8f6c4f19d44205263d409f158e36f2f73b627f195e1bc16ea7d4fbe8c5f6dbc2')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Les de sotsinspector i sergent.', false), ('B', 'Les d''intendent i intendent major.', false), ('C', 'La d''inspector.', true), ('D', 'La de superintendent.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'On s''han de publicar les convocatòries d''accés a la categoria d''agent, segons l''article 29.4 de la Llei 16/1991?', 'L''article 29.4 disposa que les convocatòries es publiquen al DOGC i vinculen l''Administració, els tribunals i els aspirants.', 'plcat_t07_policies_locals_funcions', (select id from public.topics where slug = 'plcat-t07-policies-locals-funcions'), 1, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1991-20343'), 'Art. 29.4 Llei 16/1991', '4. Las convocatorias, que se publicarán en el «Diario Oficial de la Generalidad de Cataluña», vinculan a la Administración, a los Tribunales que puntuarán las pruebas selectivas y a quienes tomen parte en ellas.', null, '1ae3ab6ae3aa20069fdd971654d5bcd57ccb932bfbe8cfb474c8ed719ff40c9b', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '1ae3ab6ae3aa20069fdd971654d5bcd57ccb932bfbe8cfb474c8ed719ff40c9b')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Al Diari Oficial de la Generalitat de Catalunya.', true), ('B', 'Només al tauler d''anuncis de l''ajuntament.', false), ('C', 'Al Butlletí Oficial de l''Estat exclusivament.', false), ('D', 'Al Butlletí Oficial de la Província corresponent exclusivament.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 9.2 de la Llei 16/1991, quan l''alcalde autoritza que determinats serveis es prestin sense l''uniforme reglamentari, els policies locals:', 'L''article 9.2 permet a l''alcalde autoritzar serveis sense uniforme, però els policies que actuïn així han de portar la documentació acreditativa de la seva condició.', 'plcat_t07_policies_locals_funcions', (select id from public.topics where slug = 'plcat-t07-policies-locals-funcions'), 2, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1991-20343'), 'Art. 9.2 Llei 16/1991', 'en cualquier caso, los Policías locales que actúen sin el uniforme reglamentario llevarán la documentación acreditativa de su condición.', null, '2169e89d479003e34e4538188e3f18472a653e6d552c3361cd72e1b7627adbb2', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '2169e89d479003e34e4538188e3f18472a653e6d552c3361cd72e1b7627adbb2')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Han de portar visible el braçalet identificatiu del cos.', false), ('B', 'No poden exercir cap funció d''agent de l''autoritat durant aquest servei.', false), ('C', 'Han d''anar sempre acompanyats d''un agent uniformat.', false), ('D', 'Han de portar la documentació acreditativa de la seva condició.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Pel que fa a la dedicació professional, l''article 10 de la Llei 16/1991 estableix que els policies locals han d''intervenir en defensa de la llei i de la seguretat ciutadana:', 'L''article 10.1, quart, exigeix una dedicació total: els policies locals han d''intervenir sempre, en qualsevol moment i lloc, estiguin o no de servei.', 'plcat_t07_policies_locals_funcions', (select id from public.topics where slug = 'plcat-t07-policies-locals-funcions'), 2, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1991-20343'), 'Art. 10.1 quart Llei 16/1991', 'Cuarto. En cuanto a la dedicación profesional, los Policías locales deben llevar a cabo sus funciones con total dedicación, debiendo intervenir siempre, en cualquier momento y lugar, se hallen o no de servicio, en defensa de la ley y de la seguridad ciudadana.', null, '63be4450f74df62afc8bad80d8e89ec5a2a2f57abfbc54510efe03f21f33eea3', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '63be4450f74df62afc8bad80d8e89ec5a2a2f57abfbc54510efe03f21f33eea3')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Només durant la jornada de servei i dins del terme municipal.', false), ('B', 'Sempre, en qualsevol moment i lloc, tant si estan de servei com si no.', true), ('C', 'Fora de servei, només si porten l''arma reglamentària.', false), ('D', 'Fora de servei, només quan ho ordeni el cap del cos.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Sobre el secret professional, quina afirmació és correcta segons l''article 10 de la Llei 16/1991?', 'L''article 10.1, cinquè, imposa un rigorós secret sobre les informacions conegudes per raó del càrrec i no obliga a revelar les fonts, excepte quan ho exigeixin l''exercici de les funcions o les disposicions legals.', 'plcat_t07_policies_locals_funcions', (select id from public.topics where slug = 'plcat-t07-policies-locals-funcions'), 2, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1991-20343'), 'Art. 10.1 cinquè Llei 16/1991', 'no estando obligados a revelar las fuentes de información, salvo cuando se lo impongan el desempeño de sus funciones o las disposiciones legales.', null, '8ef09f819ea394d2b276f062b571cd5fc82a32cd1589e88824f1803dc0037dd2', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '8ef09f819ea394d2b276f062b571cd5fc82a32cd1589e88824f1803dc0037dd2')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Els policies locals han de revelar les fonts d''informació sempre que ho demani l''alcalde.', false), ('B', 'El secret professional només afecta les informacions classificades com a reservades.', false), ('C', 'Els policies locals no estan obligats a revelar les fonts d''informació, llevat que ho imposin l''exercici de les seves funcions o les disposicions legals.', true), ('D', 'El secret professional s''extingeix quan el policia deixa de prestar servei actiu.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'L''article 11.d) de la Llei 16/1991 atribueix a les policies locals la funció de policia administrativa amb la finalitat de:', 'L''article 11.d) configura la policia administrativa com la que assegura el compliment de reglaments, ordenances, bans, resolucions i altres disposicions i actes municipals.', 'plcat_t07_policies_locals_funcions', (select id from public.topics where slug = 'plcat-t07-policies-locals-funcions'), 2, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1991-20343'), 'Art. 11.d Llei 16/1991', 'd) Ejercer como Policía administrativa, a fin de asegurar el cumplimiento de Reglamentos, Ordenanzas, Bandos, Resoluciones y demás disposiciones y actos municipales, de acuerdo con la normativa vigente.', null, '56abe0d92dbee19d65bc934f9b9e871351a5a24f780108567478a0e6c57216ef', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '56abe0d92dbee19d65bc934f9b9e871351a5a24f780108567478a0e6c57216ef')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Investigar els delictes i descobrir-ne els autors per encàrrec del jutge.', false), ('B', 'Tramitar i resoldre els expedients sancionadors de trànsit.', false), ('C', 'Controlar l''activitat de les empreses de seguretat privada del municipi.', false), ('D', 'Assegurar el compliment dels reglaments, ordenances, bans, resolucions i altres disposicions i actes municipals.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 20.1 de la Llei 16/1991, quan han d''enviar al departament i fer pública la memòria dels serveis prestats l''any anterior les corporacions locals que tenen policia local o vigilants?', 'L''article 20.1 obliga a enviar i fer pública, en el primer trimestre de cada any, la memòria dels serveis de l''any anterior i la dotació de recursos humans i materials.', 'plcat_t07_policies_locals_funcions', (select id from public.topics where slug = 'plcat-t07-policies-locals-funcions'), 2, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1991-20343'), 'Art. 20.1 Llei 16/1991', 'enviarán al Departamento de Gobernación y harán pública, en el primer trimestre de cada año, de acuerdo con los criterios de elaboración determinados por reglamento, la siguiente documentación: a) La Memoria de los servicios prestados el año anterior. b) La dotación de recursos humanos y materiales.', null, '635bf20938ef11701f2fe8181afc782a469df6441d8f04116d87c1aa9e55f398', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '635bf20938ef11701f2fe8181afc782a469df6441d8f04116d87c1aa9e55f398')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'En el primer semestre de cada any.', false), ('B', 'En el primer trimestre de cada any.', true), ('C', 'Abans del 31 de desembre de l''any a què es refereix la memòria.', false), ('D', 'Dins del mes següent a l''aprovació del pressupost municipal.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'En casos de necessitat, els municipis limítrofs poden subscriure acords de cooperació entre les seves policies, segons l''article 23.3 de la Llei 16/1991, amb quin requisit?', 'L''article 23.3 permet els acords de cooperació entre policies de municipis limítrofs en casos de necessitat, amb l''autorització prèvia del conseller (el text esmenta el de Governació; avui, el departament competent en seguretat).', 'plcat_t07_policies_locals_funcions', (select id from public.topics where slug = 'plcat-t07-policies-locals-funcions'), 2, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1991-20343'), 'Art. 23.3 Llei 16/1991', '3. En casos de necesidad, los Municipios limítrofes, previa autorización del Consejero de Gobernación, pueden suscribir acuerdos de cooperación entre sus Policías.', null, '2ced1fe072c102e7aa6980117d4bced66250f72c8da465517c4b8b6a65465282', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '2ced1fe072c102e7aa6980117d4bced66250f72c8da465517c4b8b6a65465282')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'L''autorització prèvia del conseller competent.', true), ('B', 'L''acord unànime de la Junta Local de Seguretat de cada municipi.', false), ('C', 'La conformitat del delegat del Govern de l''Estat.', false), ('D', 'L''aprovació prèvia del consell comarcal.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Quina d''aquestes funcions correspon al cap del cos de la policia local segons l''article 27 de la Llei 16/1991?', 'L''article 27.c) atribueix al cap del cos transformar en ordres concretes les directrius rebudes de l''alcalde. Aprovar la plantilla correspon al municipi (art. 25.1) i decidir sobre les armes, a l''alcalde (art. 8.2).', 'plcat_t07_policies_locals_funcions', (select id from public.topics where slug = 'plcat-t07-policies-locals-funcions'), 2, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1991-20343'), 'Art. 27 Llei 16/1991', 'c) Transformar en órdenes concretas las directrices de los objetivos a conseguir, recibidas del Alcalde o del cargo en quien éste delegue.', null, '15ff4794c608eea105575db03fb8306943d90fcb2145495af94647bdbb03a7d0', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '15ff4794c608eea105575db03fb8306943d90fcb2145495af94647bdbb03a7d0')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Aprovar la plantilla del cos de policia local.', false), ('B', 'Determinar de forma motivada els serveis en què no es portaran armes de foc.', false), ('C', 'Transformar en ordres concretes les directrius dels objectius que rep de l''alcalde o del càrrec en qui delegui.', true), ('D', 'Autoritzar l''actuació de la policia local fora del terme municipal.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 30.1 de la Llei 16/1991, quina antiguitat mínima a la categoria immediatament inferior cal per accedir per promoció interna a les categories de caporal, sergent i sotsinspector?', 'L''article 30.1 exigeix un mínim de dos anys d''antiguitat a la categoria immediatament inferior, la titulació adequada i el curs específic de l''Escola de Policia de Catalunya (avui, l''ISPC).', 'plcat_t07_policies_locals_funcions', (select id from public.topics where slug = 'plcat-t07-policies-locals-funcions'), 2, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1991-20343'), 'Art. 30.1 Llei 16/1991', 'entre los miembros del Cuerpo que tengan un mínimo de dos años de antigüedad en la categoría inmediatamente inferior respectiva', null, 'eb27d97f0f43bd88c9fe868f3d8cb986ab6200f2c274fcb2ba49ab5f5fb4baa6', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'eb27d97f0f43bd88c9fe868f3d8cb986ab6200f2c274fcb2ba49ab5f5fb4baa6')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Un any.', false), ('B', 'Dos anys.', true), ('C', 'Tres anys.', false), ('D', 'Cinc anys.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 32.1 de la Llei 16/1991, com es reparteixen els membres dels tribunals d''oposició de la policia local?', 'L''article 32.1 divideix el tribunal en terços: corporació, personal tècnic especialitzat i representants del departament (amb almenys un de l''Escola de Policia i un de la Direcció General de Seguretat Ciutadana).', 'plcat_t07_policies_locals_funcions', (select id from public.topics where slug = 'plcat-t07-policies-locals-funcions'), 2, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1991-20343'), 'Art. 32.1 Llei 16/1991', 'a) Un tercio será integrado por miembros o funcionarios de la misma Corporación. b) Otro tercio será integrado por personal técnico especializado en la materia. c) El tercio restante estará integrado por representantes del Departamento de Gobernación', null, 'a580abd35114ad1addb31cfb62e6b9b492f5dfc0d0cc5417191749429e80d7a3', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'a580abd35114ad1addb31cfb62e6b9b492f5dfc0d0cc5417191749429e80d7a3')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'La meitat de membres de la corporació i la meitat de representants del departament de la Generalitat.', false), ('B', 'Un terç de membres de la corporació, un terç de representants sindicals i un terç de representants de l''Escola de Policia.', false), ('C', 'Tots els membres són designats per l''Escola de Policia de Catalunya.', false), ('D', 'Un terç de membres o funcionaris de la corporació, un terç de personal tècnic especialitzat i un terç de representants del departament de la Generalitat.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 10.2 de la Llei 16/1991, quan un policia local infringeix en l''exercici de les seves funcions les normes legals o els principis d''actuació:', 'L''article 10.2 fa els policies locals responsables personalment i directament dels actes, per acció o omissió, que infringeixin les normes o els principis d''actuació, sens perjudici de la responsabilitat patrimonial de l''Administració.', 'plcat_t07_policies_locals_funcions', (select id from public.topics where slug = 'plcat-t07-policies-locals-funcions'), 3, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1991-20343'), 'Art. 10.2 Llei 16/1991', '2. Los Policías locales son responsables personal y directamente por los actos en que, en el desempeño de su funciones, infrinjan o vulneren, por acción u omisión, las normas legales, las normas reglamentarias que rigen su profesión y los principios enunciados en el apartado 1, sin perjuicio de la responsabilidad patrimonial que pueda corresponder a las administraciones públicas.', null, '66f52d067fdea567b59f4b019974e43efbcdb3b88250e838aac36d4a0a252449', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '66f52d067fdea567b59f4b019974e43efbcdb3b88250e838aac36d4a0a252449')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'N''és responsable personalment i directament, sens perjudici de la responsabilitat patrimonial que pugui correspondre a les administracions públiques.', true), ('B', 'Només en respon l''ajuntament, que després pot repetir contra el policia.', false), ('C', 'N''és responsable el cap del cos, com a comandament immediat.', false), ('D', 'Només hi ha responsabilitat si l''actuació constitueix delicte.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Com defineix la coordinació l''article 14 de la Llei 16/1991?', 'L''article 14 defineix la coordinació com la determinació dels mitjans i sistemes de relació que fan possible l''acció conjunta de les policies locals, per integrar-ne les actuacions en el sistema de seguretat ciutadana, sempre respectant l''autonomia local (art. 15.2).', 'plcat_t07_policies_locals_funcions', (select id from public.topics where slug = 'plcat-t07-policies-locals-funcions'), 3, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1991-20343'), 'Art. 14 Llei 16/1991', 'se entiende por coordinación la determinación de los medios y sistemas de relación que posibilitan la acción conjunta de las Policias locales, a través de las autoridades competentes, en orden a conseguir la integración de las respectivas actuaciones particulares en el conjunto del sistema de seguridad ciudadana que tienen confiado.', null, 'a5cf1487c23037435a17d89e572caf3ac1c5a0e117f9fa60b07289a32f6b535d', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'a5cf1487c23037435a17d89e572caf3ac1c5a0e117f9fa60b07289a32f6b535d')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Com la direcció operativa de les policies locals pel cos de Mossos d''Esquadra.', false), ('B', 'Com la facultat del departament de donar ordres directes als caps dels cossos de policia local.', false), ('C', 'Com la integració orgànica de totes les policies locals en un cos únic de la Generalitat.', false), ('D', 'Com la determinació dels mitjans i sistemes de relació que possibiliten l''acció conjunta de les policies locals per integrar-ne les actuacions en el conjunt del sistema de seguretat ciutadana.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 17.2 de la Llei 16/1991, en quin cas és preceptiva la participació de representants del departament de la Generalitat a la Junta Local de Seguretat?', 'L''article 17.1 fa potestativa la integració de representants del departament a la Junta Local de Seguretat, però l''article 17.2 la fa preceptiva als municipis amb presència operativa de la policia autonòmica.', 'plcat_t07_policies_locals_funcions', (select id from public.topics where slug = 'plcat-t07-policies-locals-funcions'), 3, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1991-20343'), 'Art. 17.2 Llei 16/1991', '2. La participación de representantes del Departamento de Gobernación en la Junta Local de Seguridad es preceptiva en los Municipios en que haya una presencia operativa de la Policía autonómica.', null, '5bf6c96abc62bb7d8d63a4a6bc8183675d70316a84ff775a60854c16054c2993', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '5bf6c96abc62bb7d8d63a4a6bc8183675d70316a84ff775a60854c16054c2993')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'En tots els municipis de més de 10.000 habitants.', false), ('B', 'Només als municipis que són capital de comarca.', false), ('C', 'En els municipis en què hi hagi presència operativa de la policia autonòmica.', true), ('D', 'Només quan ho sol·liciti l''alcalde per majoria absoluta del Ple.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 25.3 de la Llei 16/1991, la categoria de superintendent només es pot crear als municipis de:', 'L''article 25.3 reserva la categoria de superintendent als municipis de més de 200.000 habitants; les d''intendent major i intendent, als de més de 100.000, amb l''excepció per nombre d''agents (més de 250 o de 100).', 'plcat_t07_policies_locals_funcions', (select id from public.topics where slug = 'plcat-t07-policies-locals-funcions'), 3, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1991-20343'), 'Art. 25.3 Llei 16/1991', 'La categoría de Superintendente solamente puede crearse en los Municipios que tienen más de 200.000 habitantes', null, '51104d054f3e6a0bd2a0a1fdf731d67a25d42b9917a1ae73c7c64c9980e8e3e0', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '51104d054f3e6a0bd2a0a1fdf731d67a25d42b9917a1ae73c7c64c9980e8e3e0')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Més de 200.000 habitants.', true), ('B', 'Més de 100.000 habitants.', false), ('C', 'Més de 50.000 habitants.', false), ('D', 'Més de 250.000 habitants.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'En l''accés a les categories d''inspector, intendent, intendent major i superintendent per concurs oposició lliure, quin percentatge màxim de places es pot reservar a promoció interna segons l''article 31 de la Llei 16/1991?', 'L''article 31 permet reservar fins a un 50 % de les places per a promoció interna de membres del cos amb un mínim de dos anys d''antiguitat a la categoria inferior, titulació adequada i curs específic.', 'plcat_t07_policies_locals_funcions', (select id from public.topics where slug = 'plcat-t07-policies-locals-funcions'), 3, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1991-20343'), 'Art. 31 Llei 16/1991', 'Puede reservarse hasta un 50 por 100 de las plazas de cada convocatoria para la promoción interna', null, 'f6dc11e37c603b518794679cd95bcffce63b2cf1025a99c5ff5e6501a40bfcd3', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'f6dc11e37c603b518794679cd95bcffce63b2cf1025a99c5ff5e6501a40bfcd3')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Fins a un 25 per cent de les places de cada convocatòria.', false), ('B', 'Fins a un 50 per cent de les places de cada convocatòria.', true), ('C', 'Fins a un 33 per cent de les places de cada convocatòria.', false), ('D', 'Totes les places, si hi ha prou aspirants interns.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
-- Lote plcat-t08-policies-locals-estatut-disciplina-lpl-v1 (20 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Ley 16/1991, de 10 de julio, de las Policías Locales (Cataluña) (texto consolidado, BOE)', 'https://www.boe.es/buscar/act.php?id=BOE-A-1991-20343', 'boe'::public.source_kind, 'Agencia Estatal Boletín Oficial del Estado', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('plcat-t08-policies-locals-estatut-disciplina', 'Tema 8. La Llei 16/1991 de les policies locals: drets i deures, situacions i règim disciplinari') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('policia-local') and t.slug = 'plcat-t08-policies-locals-estatut-disciplina' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 34 de la Llei 16/1991, qui fixa el règim de jornada, horari, vacances i permisos dels membres de la policia local?', 'L''article 34 atribueix a cada entitat local la fixació del règim de jornada, horari, vacances i permisos, adaptat a les especificitats del servei.', 'plcat_t08_policies_locals_estatut_disciplina', (select id from public.topics where slug = 'plcat-t08-policies-locals-estatut-disciplina'), 1, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1991-20343'), 'Art. 34 Llei 16/1991', 'Cada Entidad local, de acuerdo con las disposiciones reglamentarias que se determinen, fijará el régimen de jornada, horario, vacaciones y permisos para los miembros de la Policía local', null, 'c4fbfbeec351d7d51ad8737db9ad438811794d36f2de727b096a0b1ab6794002', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'c4fbfbeec351d7d51ad8737db9ad438811794d36f2de727b096a0b1ab6794002')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El departament de la Generalitat competent en seguretat, per a tots els cossos.', false), ('B', 'El cap del cos, d''acord amb les necessitats del servei.', false), ('C', 'La Comissió de Policia de Catalunya, per a tots els municipis.', false), ('D', 'Cada entitat local, d''acord amb les disposicions reglamentàries que es determinin.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 39 de la Llei 16/1991, quin règim de previsió social s''aplica als policies locals?', 'L''article 39 acull els policies locals al mateix règim de previsió social que els altres funcionaris de la seva corporació.', 'plcat_t08_policies_locals_estatut_disciplina', (select id from public.topics where slug = 'plcat-t08-policies-locals-estatut-disciplina'), 1, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1991-20343'), 'Art. 39 Llei 16/1991', 'Los Policías locales están acogidos al mismo régimen de previsión social que los demás funcionarios de la Corporación local a la que pertenecen.', null, 'd53ec4e6c71749e76acc67905f64684c4a2fc5dfa8ae860ccaf8d535e20b3a0d', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'd53ec4e6c71749e76acc67905f64684c4a2fc5dfa8ae860ccaf8d535e20b3a0d')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Un règim especial propi de les forces i cossos de seguretat de l''Estat.', false), ('B', 'El mateix que als altres funcionaris de la corporació local a què pertanyen.', true), ('C', 'El règim de mutualitat de la Generalitat de Catalunya.', false), ('D', 'El que fixi cada any el Ple de la corporació, diferent del dels altres funcionaris.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'En matèria de seguretat i higiene en el treball, l''article 42.3 de la Llei 16/1991 obliga les corporacions locals a adoptar les mesures necessàries per a:', 'L''article 42 preveu mitjans i instal·lacions adequats (42.1), una revisió mèdica anual (42.2) i mesures per prevenir malalties contagioses (42.3).', 'plcat_t08_policies_locals_estatut_disciplina', (select id from public.topics where slug = 'plcat-t08-policies-locals-estatut-disciplina'), 1, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1991-20343'), 'Art. 42.3 Llei 16/1991', '3. Las Corporaciones Locales adoptarán las medidas necesarias para la prevención de enfermedades contagiosas.', null, 'b9a2dd990502fbe7fd53cd152719dd5679af75f600c93886704f1c24f89c5cf9', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'b9a2dd990502fbe7fd53cd152719dd5679af75f600c93886704f1c24f89c5cf9')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'La prevenció de malalties contagioses.', true), ('B', 'La vacunació obligatòria de tots els agents cada any.', false), ('C', 'L''adquisició d''armilles antibala per a cada agent.', false), ('D', 'La contractació d''una assegurança de vida per a cada agent.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Llei 16/1991, com es qualifica la participació d''un policia local en una vaga?', 'L''article 48.1.k) qualifica de falta molt greu la participació en vagues, en accions substitutives o en actuacions concertades per alterar el funcionament normal dels serveis, coherentment amb la prohibició de l''article 38.', 'plcat_t08_policies_locals_estatut_disciplina', (select id from public.topics where slug = 'plcat-t08-policies-locals-estatut-disciplina'), 1, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1991-20343'), 'Art. 48.1.k Llei 16/1991', 'k) La participación en huelgas, en acciones sustitutivas de éstas o en actuaciones concertadas con la finalidad de alterar el funcionamiento normal de los servicios.', null, 'e402c8d98aa8dcae907abe27189f9e864e1e5d917042db4420edf45a302db419', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'e402c8d98aa8dcae907abe27189f9e864e1e5d917042db4420edf45a302db419')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Com a falta greu.', false), ('B', 'Com a falta lleu.', false), ('C', 'Com a falta molt greu.', true), ('D', 'No és sancionable si la vaga és legal.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 52.4 de la Llei 16/1991, per a quin període es pot imposar la suspensió de funcions per una falta lleu?', 'L''article 52.4.a) preveu per a les faltes lleus la suspensió de funcions d''un a quinze dies amb pèrdua de retribucions, a més del trasllat, la deducció proporcional i l''amonestació.', 'plcat_t08_policies_locals_estatut_disciplina', (select id from public.topics where slug = 'plcat-t08-policies-locals-estatut-disciplina'), 1, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1991-20343'), 'Art. 52.4 Llei 16/1991', 'a) La suspensión de funciones, por un período de uno a quince días, con pérdida de las retribuciones.', null, 'bc9fbb29243e863a81f3831722d22ae4ec5e551232d8a33ae568d8b247a89b73', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'bc9fbb29243e863a81f3831722d22ae4ec5e551232d8a33ae568d8b247a89b73')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'De quinze dies a un mes, amb pèrdua de les retribucions.', false), ('B', 'D''un a quinze dies, amb pèrdua de les retribucions.', true), ('C', 'D''un a tres dies, sense pèrdua de retribucions.', false), ('D', 'La suspensió de funcions no es pot imposar mai per una falta lleu.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Quina d''aquestes NO és una causa d''extinció de la responsabilitat disciplinària segons l''article 58.1 de la Llei 16/1991?', 'L''article 58.1 enumera com a causes d''extinció el compliment de la sanció, la mort, l''indult, l''amnistia i la prescripció; el pas a segona activitat no hi és.', 'plcat_t08_policies_locals_estatut_disciplina', (select id from public.topics where slug = 'plcat-t08-policies-locals-estatut-disciplina'), 1, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1991-20343'), 'Art. 58.1 Llei 16/1991', '1. La responsabilidad disciplinaria se extingue por el cumplimiento de la sanción, muerte, indulto, amnistía y prescripción de la falta o sanción.', null, 'dfe7f53e31c16f2c06143a9f19a98d231614f939b5ce8931566a1c17aedef7dc', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'dfe7f53e31c16f2c06143a9f19a98d231614f939b5ce8931566a1c17aedef7dc')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El compliment de la sanció.', false), ('B', 'L''indult o l''amnistia.', false), ('C', 'El pas a la situació de segona activitat.', true), ('D', 'La prescripció de la falta o de la sanció.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 35.2 de la Llei 16/1991, les retribucions bàsiques dels policies locals:', 'L''article 35.2 iguala l''estructura i la quantia de les retribucions bàsiques a les generals de la funció pública; el Ple només fixa les complementàries (art. 35.3).', 'plcat_t08_policies_locals_estatut_disciplina', (select id from public.topics where slug = 'plcat-t08-policies-locals-estatut-disciplina'), 2, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1991-20343'), 'Art. 35.2 Llei 16/1991', '2. Las retribuciones básicas tendrán la misma estructura e idéntica cuantía que las establecidas en general para el personal al servicio de la función pública.', null, 'cfd76ade416ea883a4358fb282e94ae5f0053f51d9f3420882a7d74fdcb8bfa6', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'cfd76ade416ea883a4358fb282e94ae5f0053f51d9f3420882a7d74fdcb8bfa6')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Les fixa lliurement el Ple de cada corporació.', false), ('B', 'Són superiors a les de la resta de funcionaris pel risc de la professió.', false), ('C', 'Depenen del nombre d''habitants del municipi.', false), ('D', 'Tenen la mateixa estructura i idèntica quantia que les establertes en general per al personal de la funció pública.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'D''acord amb l''article 36 de la Llei 16/1991, les situacions administratives dels policies locals es regulen:', 'L''article 36 remet a la normativa dels funcionaris locals, tenint sempre en compte les peculiaritats del cos de policia local.', 'plcat_t08_policies_locals_estatut_disciplina', (select id from public.topics where slug = 'plcat-t08-policies-locals-estatut-disciplina'), 2, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1991-20343'), 'Art. 36 Llei 16/1991', 'Las situaciones administrativas de los Policías locales se regulan de acuerdo con la normativa aplicable a los funcionarios locales, teniendo siempre en cuenta las peculiaridades del Cuerpo a que pertenecen.', null, 'd86f35cbd017717220cf914dd46d8b7e0ff1c8ec966fb3088ed49898372b6e81', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'd86f35cbd017717220cf914dd46d8b7e0ff1c8ec966fb3088ed49898372b6e81')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'D''acord amb la normativa aplicable als funcionaris locals, tenint en compte les peculiaritats del cos.', true), ('B', 'Per la normativa de situacions del personal militar.', false), ('C', 'Exclusivament pel reglament de cada cos aprovat pel cap del cos.', false), ('D', 'Per la Llei orgànica de forces i cossos de seguretat de manera exclusiva.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 40.1 de la Llei 16/1991, què han d''assegurar les corporacions locals a qui participa en els cursos de selecció per accedir a la categoria d''agent?', 'L''article 40.1 garanteix als aspirants en curs de selecció els ingressos dels funcionaris en pràctiques i la cotització a la Seguretat Social; el sistema de beques el regula la Generalitat (art. 40.2).', 'plcat_t08_policies_locals_estatut_disciplina', (select id from public.topics where slug = 'plcat-t08-policies-locals-estatut-disciplina'), 2, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1991-20343'), 'Art. 40.1 Llei 16/1991', '1. Las Corporaciones Locales asegurarán a quienes participan en los cursos de selección para el acceso a la categoría de Agente los ingresos económicos correspondientes a los funcionarios en prácticas', null, '96f8d37c6e5bee3cfed78eaa69242d8171f4ceb3bf95628619b0b08ac0dcf46e', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '96f8d37c6e5bee3cfed78eaa69242d8171f4ceb3bf95628619b0b08ac0dcf46e')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Els ingressos econòmics corresponents als funcionaris en pràctiques.', true), ('B', 'Una beca de la Generalitat equivalent al salari mínim.', false), ('C', 'Les retribucions íntegres d''un agent amb destinació definitiva.', false), ('D', 'Cap retribució fins que no obtinguin la plaça.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'On desenvolupen, per regla general, la segona activitat els policies locals, segons l''article 43.2 de la Llei 16/1991?', 'L''article 43.2 fixa com a regla general la segona activitat dins del mateix cos; només si no és possible (per manca de places o per incapacitat) es passa a altres llocs de la mateixa corporació.', 'plcat_t08_policies_locals_estatut_disciplina', (select id from public.topics where slug = 'plcat-t08-policies-locals-estatut-disciplina'), 2, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1991-20343'), 'Art. 43.2 Llei 16/1991', '2. Por regla general los Policías locales desarrollan la segunda actividad en el mismo Cuerpo al que pertenecen, desempeñando otras funciones, de acuerdo con su categoría', null, '2a0be59f3dc905af3b1a3fdd110ef5f94e68a5aa9fde52d7bac421496bde5d0e', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '2a0be59f3dc905af3b1a3fdd110ef5f94e68a5aa9fde52d7bac421496bde5d0e')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Sempre en un altre departament de l''ajuntament, fora del cos de policia.', false), ('B', 'En el cos de Mossos d''Esquadra, en tasques administratives.', false), ('C', 'En el mateix cos al qual pertanyen, fent altres funcions d''acord amb la seva categoria.', true), ('D', 'A l''Institut de Seguretat Pública de Catalunya, com a formadors.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 45.2 de la Llei 16/1991, les distincions i recompenses atorgades als policies locals:', 'L''article 45.2 disposa que les distincions i recompenses consten a l''expedient personal i poden valorar-se com a mèrit en els concursos de provisió.', 'plcat_t08_policies_locals_estatut_disciplina', (select id from public.topics where slug = 'plcat-t08-policies-locals-estatut-disciplina'), 2, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1991-20343'), 'Art. 45.2 Llei 16/1991', '2. Las distinciones y recompensas constarán en el expediente personal del funcionario y podrán ser valoradas como mérito en los concursos de provisión de puestos de trabajo.', null, '01d05c2ad179e832e5acdd4759efa2771617c6c2136c7c8cd4a9e6f2b42cafa3', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '01d05c2ad179e832e5acdd4759efa2771617c6c2136c7c8cd4a9e6f2b42cafa3')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Comporten automàticament un ascens de categoria.', false), ('B', 'Donen dret a un complement retributiu vitalici fixat per la llei.', false), ('C', 'No tenen cap efecte administratiu i són purament honorífiques.', false), ('D', 'Consten a l''expedient personal i es poden valorar com a mèrit en els concursos de provisió de llocs de treball.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 51.1 de la Llei 16/1991, el policia local que indueix un altre a cometer una conducta constitutiva de falta disciplinària:', 'L''article 51.1 equipara la responsabilitat de qui indueix i dels comandaments que toleren la conducta; l''encobriment, en canvi, és una falta d''un grau inferior (art. 51.2).', 'plcat_t08_policies_locals_estatut_disciplina', (select id from public.topics where slug = 'plcat-t08-policies-locals-estatut-disciplina'), 2, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1991-20343'), 'Art. 51.1 Llei 16/1991', '1. Los Policías locales que induzcan a otros a cometer actos o tener conductas constitutivos de falta disciplinaria incurren en la misma responsabilidad; también incurren en ella los mandos que las toleran.', null, '4161b3ef17b2e4a9156d65a55f78e23be2d3ff0983e1bbd0cca54ebd036bb4b7', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '4161b3ef17b2e4a9156d65a55f78e23be2d3ff0983e1bbd0cca54ebd036bb4b7')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Incorre en una falta d''un grau inferior.', false), ('B', 'Incorre en la mateixa responsabilitat, igual que els comandaments que la toleren.', true), ('C', 'Només respon si la falta induïda és molt greu.', false), ('D', 'No incorre en responsabilitat, que recau només en l''autor material.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Quin d''aquests criteris NO esmenta l''article 53 de la Llei 16/1991 per graduar les sancions disciplinàries?', 'L''article 53 enumera la intencionalitat, la pertorbació dels serveis, els danys i perjudicis, la reincidència, el grau de participació i la transcendència per a la seguretat pública; l''antiguitat no hi figura.', 'plcat_t08_policies_locals_estatut_disciplina', (select id from public.topics where slug = 'plcat-t08-policies-locals-estatut-disciplina'), 2, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1991-20343'), 'Art. 53 Llei 16/1991', 'a) La intencionalidad. b) La perturbación de los servicios. c) Los daños y perjuicios producidos a la Administración o a los administrados. d) La reincidencia en la comisión de faltas. e) El grado de participación en la comisión u omisión. f) La trascendencia para la seguridad pública.', null, '020c4960a65901639e3776c0bd088084513f809061e66de7c62ff43ef6fd6fae', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '020c4960a65901639e3776c0bd088084513f809061e66de7c62ff43ef6fd6fae')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'La intencionalitat.', false), ('B', 'La pertorbació dels serveis.', false), ('C', 'La transcendència per a la seguretat pública.', false), ('D', 'L''antiguitat del policia al cos.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 54.2 de la Llei 16/1991, a qui correspon la incoació de l''expedient disciplinari i el nomenament de l''instructor?', 'L''article 54.2 atribueix a l''alcalde, o a la persona en qui delegui, la incoació de l''expedient i el nomenament de l''instructor i, si escau, del secretari.', 'plcat_t08_policies_locals_estatut_disciplina', (select id from public.topics where slug = 'plcat-t08-policies-locals-estatut-disciplina'), 2, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1991-20343'), 'Art. 54.2 Llei 16/1991', '2. Corresponden al Alcalde, o a la persona en quien éste delegue, la incoación del expediente disciplinario y el nombramiento del instructor y, en su caso, del Secretario.', null, '5b7bc48abb965f8f1a4198d40998c1b883642db08fb81de720529b1d1c383e05', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '5b7bc48abb965f8f1a4198d40998c1b883642db08fb81de720529b1d1c383e05')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Al cap del cos de policia local.', false), ('B', 'A l''alcalde o a la persona en qui delegui.', true), ('C', 'Al Ple de la corporació.', false), ('D', 'Al conseller competent en seguretat pública.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Quina d''aquestes NO és una de les mesures preventives que preveu l''article 55 de la Llei 16/1991 durant un procediment judicial o disciplinari?', 'L''article 55 preveu com a mesures preventives la suspensió provisional, el trasllat o l''adscripció a un lloc intern sense uniforme, arma ni credencial, en resolució motivada. L''amonestació és una sanció (art. 52.1.e).', 'plcat_t08_policies_locals_estatut_disciplina', (select id from public.topics where slug = 'plcat-t08-policies-locals-estatut-disciplina'), 2, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1991-20343'), 'Art. 55 Llei 16/1991', 'puede acordar como medidas preventivas la suspensión provisional, el traslado o la adscripción a un puesto de trabajo interno, sin uniforme, sin arma ni credencial del Policía expedientado o procesado. La resolución en la que se acuerde la imposición o prórroga de las medidas preventivas será motivada.', null, '975256cb19ae2ca8460cb70c0edde4e4ab520006a5a72baeec615b1a8650c88a', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '975256cb19ae2ca8460cb70c0edde4e4ab520006a5a72baeec615b1a8650c88a')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'L''amonestació.', true), ('B', 'La suspensió provisional.', false), ('C', 'El trasllat.', false), ('D', 'L''adscripció a un lloc de treball intern, sense uniforme, arma ni credencial.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Un agent consumeix begudes alcohòliques durant el servei, sense arribar a embriagar-se ni fer-ho habitualment. Segons la Llei 16/1991, aquesta conducta és:', 'L''article 49.j) qualifica de falta greu el consum de begudes alcohòliques durant el servei (i negar-se a les comprovacions tècniques); embriagar-se durant el servei o habitualment és falta molt greu (art. 48.1.r).', 'plcat_t08_policies_locals_estatut_disciplina', (select id from public.topics where slug = 'plcat-t08-policies-locals-estatut-disciplina'), 3, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1991-20343'), 'Art. 49.j i 48.1.r Llei 16/1991', 'j) El consumo de bebidas alcohólicas durante el servicio, así como negarse a las pertinentes comprobaciones técnicas.', null, '179a9c2bce99d26c56c4c3f3862d27ad49f365e7a28f4874f9c91d7db9db3dea', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '179a9c2bce99d26c56c4c3f3862d27ad49f365e7a28f4874f9c91d7db9db3dea')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Una falta molt greu.', false), ('B', 'Una falta lleu.', false), ('C', 'Una falta greu.', true), ('D', 'Una falta molt greu només si es nega a les comprovacions tècniques.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 58.3 de la Llei 16/1991, les sancions imposades per faltes lleus prescriuen:', 'L''article 58.3 fixa la prescripció de les sancions (sis anys les molt greus, dos les greus i un mes les lleus) comptada des de la notificació; la de les faltes es compta des de la comissió (art. 58.2).', 'plcat_t08_policies_locals_estatut_disciplina', (select id from public.topics where slug = 'plcat-t08-policies-locals-estatut-disciplina'), 3, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1991-20343'), 'Art. 58.3 Llei 16/1991', 'las impuestas por faltas leves al cabo de un mes, desde la fecha de notificación de las sanciones.', null, '8b761e96fa5ad43b83a6c9ae54b58b3c2ed5332fb256891c34f57f492dce9394', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '8b761e96fa5ad43b83a6c9ae54b58b3c2ed5332fb256891c34f57f492dce9394')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Al cap d''un mes des de la data de notificació de la sanció.', true), ('B', 'Al cap d''un mes des de la data de comissió de la falta.', false), ('C', 'Al cap de sis mesos des de la data de notificació de la sanció.', false), ('D', 'Al cap de dos anys des de la data de notificació de la sanció.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Quines retribucions perd el policia local mentre dura la suspensió provisional, segons l''article 56.2 de la Llei 16/1991?', 'L''article 56.2 limita la pèrdua al complement específic i a les gratificacions per serveis extraordinaris; el temps de suspensió provisional es computa per complir, si escau, la sanció de suspensió de funcions.', 'plcat_t08_policies_locals_estatut_disciplina', (select id from public.topics where slug = 'plcat-t08-policies-locals-estatut-disciplina'), 3, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1991-20343'), 'Art. 56.2 Llei 16/1991', '2. La suspensión provisional implica, mientras dura, la pérdida de las retribuciones correspondientes al complemento específico y a las gratificaciones por servicios extraordinarios.', null, '27206dd36c8812e726052abf196e18044f168ed3de80f52548a578cdd483219d', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '27206dd36c8812e726052abf196e18044f168ed3de80f52548a578cdd483219d')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Totes les retribucions, bàsiques i complementàries.', false), ('B', 'Les corresponents al complement específic i a les gratificacions per serveis extraordinaris.', true), ('C', 'Només les retribucions bàsiques.', false), ('D', 'Cap retribució, fins que hi hagi una sanció ferma.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Fins a quin grau de parentiu poden ser recusats els metges del tribunal que dictamina el pas a segona activitat, segons l''article 44.2 de la Llei 16/1991?', 'L''article 44.2 permet recusar els metges per parentiu fins al quart grau de consanguinitat o el segon d''afinitat, per amistat íntima o enemistat manifesta, o per manca d''idoneïtat.', 'plcat_t08_policies_locals_estatut_disciplina', (select id from public.topics where slug = 'plcat-t08-policies-locals-estatut-disciplina'), 3, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1991-20343'), 'Art. 44.2 Llei 16/1991', '2. Los Médicos del Tribunal pueden ser recusados por motivos de parentesco con el interesado, hasta el cuarto grado de consanguinidad o hasta el segundo grado de afinidad, por amistad íntima o manifiesta enemistad con el interesado o por falta de la idoneidad requerida.', null, 'f212302e3f841c4e3e7f2bb75cb99e91e0ae71e493e157b6980ed20aba34fe1d', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'f212302e3f841c4e3e7f2bb75cb99e91e0ae71e493e157b6980ed20aba34fe1d')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Fins al segon grau de consanguinitat o fins al primer grau d''afinitat.', false), ('B', 'Fins al tercer grau de consanguinitat o d''afinitat.', false), ('C', 'Fins al quart grau de consanguinitat o fins al segon grau d''afinitat.', true), ('D', 'Fins al quart grau de consanguinitat o d''afinitat.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 48.2 de la Llei 16/1991, la manipulació d''imatges i sons gravats amb videocàmeres de la policia en llocs públics, sempre que no constitueixi delicte, és:', 'L''article 48.2.a), afegit per la Llei 25/1998, qualifica de falta molt greu l''alteració, manipulació o destrucció d''imatges i sons gravats, d''acord amb la LO 4/1997 de videocàmeres; les altres infraccions d''aquesta llei no tipificades com a molt greus són greus (art. 49.p).', 'plcat_t08_policies_locals_estatut_disciplina', (select id from public.topics where slug = 'plcat-t08-policies-locals-estatut-disciplina'), 3, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1991-20343'), 'Art. 48.2 Llei 16/1991', 'a) La alteración, manipulación o destrucción de imágenes y sonidos grabados, siempre que no constituyan delito.', null, '7cc600aed6a6fc00eb9a0807245a1abd2dc258486bb99438b3ba49cae620120c', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '7cc600aed6a6fc00eb9a0807245a1abd2dc258486bb99438b3ba49cae620120c')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Una falta greu.', false), ('B', 'Una falta lleu.', false), ('C', 'Una infracció de la normativa de protecció de dades, no disciplinària.', false), ('D', 'Una falta molt greu.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
-- Lote plcat-t09-sistema-seguretat-catalunya-lispc-v1 (5 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Ley 10/2007, de 30 de julio, del Instituto de Seguridad Pública de Cataluña (texto consolidado, BOE)', 'https://www.boe.es/buscar/act.php?id=BOE-A-2007-15546', 'boe'::public.source_kind, 'Agencia Estatal Boletín Oficial del Estado', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('plcat-t09-sistema-seguretat-catalunya', 'Tema 9. La Llei 4/2003 d''ordenació del sistema de seguretat pública de Catalunya i l''Institut de Seguretat Pública') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('policia-local') and t.slug = 'plcat-t09-sistema-seguretat-catalunya' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la disposició addicional primera de la Llei 10/2007, com s''han d''entendre les referències que la legislació vigent fa a l''Escola de Policia de Catalunya?', 'La disposició addicional primera de la Llei 10/2007 estableix que les referències a l''Escola de Policia de Catalunya (i a l''Escola de Bombers) s''entenen fetes a l''ISPC.', 'plcat_t09_sistema_seguretat_catalunya', (select id from public.topics where slug = 'plcat-t09-sistema-seguretat-catalunya'), 1, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2007-15546'), 'Disposició addicional primera Llei 10/2007', 'Las referencias que la legislación vigente hace a la Escuela de Policía de Cataluña y a la Escuela de Bomberos y Seguridad Civil de Cataluña se entienden hechas al Instituto de Seguridad Pública de Cataluña.', null, 'eb5ce5e13b72c60fbbb3d9f47d6d5a24a936b23f4ac3e35f6523b7d933e97f4d', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'eb5ce5e13b72c60fbbb3d9f47d6d5a24a936b23f4ac3e35f6523b7d933e97f4d')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Com a fetes al departament competent en seguretat pública.', false), ('B', 'Com a fetes a la Direcció General de la Policia.', false), ('C', 'Com a derogades, sense cap òrgan successor.', false), ('D', 'Com a fetes a l''Institut de Seguretat Pública de Catalunya.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Qui nomena i cessa el director o directora de l''Institut de Seguretat Pública de Catalunya, segons l''article 11 de la Llei 10/2007?', 'L''article 11.1 atribueix el nomenament i el cessament al Govern, a proposta del conseller; el director té rang de director general (art. 11.2).', 'plcat_t09_sistema_seguretat_catalunya', (select id from public.topics where slug = 'plcat-t09-sistema-seguretat-catalunya'), 1, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2007-15546'), 'Art. 11 Llei 10/2007', '1. El Gobierno, a propuesta del consejero o consejera del departamento competente en materia de seguridad pública, nombra y cesa al director o directora del Instituto de Seguridad Pública de Cataluña.', null, '3eda5918f5804254f08860d66e5fae13c1e8873969e066b21aafbbb4dd28e71c', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '3eda5918f5804254f08860d66e5fae13c1e8873969e066b21aafbbb4dd28e71c')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El Parlament de Catalunya, per majoria absoluta.', false), ('B', 'El Govern, a proposta del conseller competent en seguretat pública.', true), ('C', 'El Consell de Direcció de l''Institut, per majoria simple.', false), ('D', 'El president de la Generalitat, a proposta de la Comissió de Policia de Catalunya.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Quantes vegades l''any es reuneix en sessió ordinària el Consell de Direcció de l''Institut de Seguretat Pública de Catalunya, segons l''article 10.2 de la Llei 10/2007?', 'L''article 10.2 fixa dues sessions ordinàries anuals, convocades pel president, i sessions extraordinàries quan ho decideixi el president o ho demani un terç dels membres.', 'plcat_t09_sistema_seguretat_catalunya', (select id from public.topics where slug = 'plcat-t09-sistema-seguretat-catalunya'), 2, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2007-15546'), 'Art. 10.2 Llei 10/2007', '2. El Consejo de Dirección se reúne en sesión ordinaria dos veces al año, convocado por el presidente o presidenta, y en sesión extraordinaria siempre que lo decida el presidente o presidenta o a instancia de una tercera parte de sus miembros.', null, 'ad02b2e57bb3074bd468e3e7fe72a6cc584a24cee4cfbfea66fd7fdc400a9b25', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'ad02b2e57bb3074bd468e3e7fe72a6cc584a24cee4cfbfea66fd7fdc400a9b25')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Una vegada l''any.', false), ('B', 'Quatre vegades l''any.', false), ('C', 'Una vegada al mes.', false), ('D', 'Dues vegades l''any.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Quina d''aquestes funcions atribueix a l''Institut de Seguretat Pública de Catalunya l''article 4.1.c) de la Llei 10/2007?', 'L''article 4.1.c) encarrega a l''ISPC definir els protocols d''avaluació per portar una arma de foc, coordinar-ne l''aplicació i avaluar les condicions psicològiques dels policies per portar-la.', 'plcat_t09_sistema_seguretat_catalunya', (select id from public.topics where slug = 'plcat-t09-sistema-seguretat-catalunya'), 2, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2007-15546'), 'Art. 4.1.c Llei 10/2007', 'c) Estudiar, identificar y definir los protocolos de evaluación para llevar un arma de fuego, coordinar su aplicación y evaluar las condiciones psicológicas que deben cumplir los miembros de los cuerpos de policía de Cataluña para llevar un arma de fuego.', null, '2c0ffeacf9505d7a88a57d167fc21168cb1ae2fecc31bbfc44be2fdb97b24bb5', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '2c0ffeacf9505d7a88a57d167fc21168cb1ae2fecc31bbfc44be2fdb97b24bb5')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Expedir les llicències d''armes de foc als membres de les policies locals.', false), ('B', 'Avaluar les condicions psicològiques que han de complir els membres dels cossos de policia de Catalunya per portar una arma de foc.', true), ('C', 'Autoritzar els dipòsits d''armes de cada cos de policia local.', false), ('D', 'Imposar les sancions per pèrdua de l''arma reglamentària.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 7.2.e) de la Llei 10/2007, al president de l''Institut de Seguretat Pública de Catalunya li correspon disposar les despeses i ordenar els pagaments quan la quantia:', 'L''article 7.2.e) reserva al president les despeses i els pagaments de quantia superior al 20 % del pressupost; el director autoritza les despeses dins dels límits establerts (art. 12.g).', 'plcat_t09_sistema_seguretat_catalunya', (select id from public.topics where slug = 'plcat-t09-sistema-seguretat-catalunya'), 3, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2007-15546'), 'Art. 7.2.e Llei 10/2007', 'e) Disponer los gastos y ordenar los pagos si su cuantía excede del 20% de los presupuestos del Instituto.', null, '908c370c1dced51fb9e7dc74b109d0aadf70ebf8dc4841e809ded7296e5256cc', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '908c370c1dced51fb9e7dc74b109d0aadf70ebf8dc4841e809ded7296e5256cc')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Excedeix del 10 % dels pressupostos de l''Institut.', false), ('B', 'Excedeix del 20 % dels pressupostos de l''Institut.', true), ('C', 'Excedeix del 50 % dels pressupostos de l''Institut.', false), ('D', 'Sigui quina sigui, perquè el director no té cap competència de despesa.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
-- Lote plcat-t09-sistema-seguretat-catalunya-lssp-v1 (15 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Ley 4/2003, de 7 de abril, de Ordenación del Sistema de Seguridad Pública de Cataluña (texto consolidado, BOE)', 'https://www.boe.es/buscar/act.php?id=BOE-A-2003-9620', 'boe'::public.source_kind, 'Agencia Estatal Boletín Oficial del Estado', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('plcat-t09-sistema-seguretat-catalunya', 'Tema 9. La Llei 4/2003 d''ordenació del sistema de seguretat pública de Catalunya i l''Institut de Seguretat Pública') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('policia-local') and t.slug = 'plcat-t09-sistema-seguretat-catalunya' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 4.3 de la Llei 4/2003, a qui correspon exercir el comandament superior de la Policia de la Generalitat-Mossos d''Esquadra?', 'L''article 4.3.c) atribueix al conseller competent en seguretat pública el comandament superior dels Mossos d''Esquadra, a més de coordinar les policies locals (lletra d).', 'plcat_t09_sistema_seguretat_catalunya', (select id from public.topics where slug = 'plcat-t09-sistema-seguretat-catalunya'), 1, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2003-9620'), 'Art. 4.3 Llei 4/2003', 'c) Ejercer el mando superior de la Policía de la Generalidad-Mossos d''Esquadra.', null, 'd90fd9ff6d34e700c23745088295cbbdc13af5c0f1de24ec7d4f449ff9769874', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'd90fd9ff6d34e700c23745088295cbbdc13af5c0f1de24ec7d4f449ff9769874')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Al president de la Generalitat.', false), ('B', 'Al director general de la Policia, en exclusiva.', false), ('C', 'Al conseller del departament competent en matèria de seguretat pública.', true), ('D', 'Al delegat del Govern de l''Estat a Catalunya.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Amb quina periodicitat s''ha de reunir en sessió ordinària la junta local de seguretat, segons l''article 9.7 de la Llei 4/2003?', 'L''article 9.7 fixa sessions ordinàries trimestrals convocades pel president; una de les sessions anuals ha de ser plenària, per conèixer el pla de seguretat local.', 'plcat_t09_sistema_seguretat_catalunya', (select id from public.topics where slug = 'plcat-t09-sistema-seguretat-catalunya'), 1, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2003-9620'), 'Art. 9.7 Llei 4/2003', '7. La junta local de seguridad debe reunirse en sesión ordinaria, convocada por el presidente o presidenta, con carácter trimestral.', null, 'd7c2a40013c3fff24b3f7afe66a55d8cddd2e85497f0e4e588c7bc43aebefc0a', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'd7c2a40013c3fff24b3f7afe66a55d8cddd2e85497f0e4e588c7bc43aebefc0a')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Mensualment.', false), ('B', 'Trimestralment.', true), ('C', 'Semestralment.', false), ('D', 'Anualment.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Quina periodicitat té el Pla general de seguretat de Catalunya, segons l''article 15.3 de la Llei 4/2003?', 'L''article 15.3 dona al Pla general de seguretat una periodicitat quadriennal, tot i que es pot modificar abans per urgència o necessitat. L''aprova el Govern i s''ha de presentar al Parlament (art. 15.1 i 15.5).', 'plcat_t09_sistema_seguretat_catalunya', (select id from public.topics where slug = 'plcat-t09-sistema-seguretat-catalunya'), 1, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2003-9620'), 'Art. 15.3 Llei 4/2003', '3. El Plan de seguridad de Cataluña tiene periodicidad cuatrienal, sin perjuicio de que, por razones de urgencia o de necesidad, deba modificarse antes de haber transcurrido dicho plazo.', null, '6a7b3432736814fce1a3bd744833a51e4398d4fe39d38f3cffc746f6d29b95b6', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '6a7b3432736814fce1a3bd744833a51e4398d4fe39d38f3cffc746f6d29b95b6')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Anual, coincidint amb l''exercici pressupostari.', false), ('B', 'Biennal, sense possibilitat de modificació anticipada.', false), ('C', 'Sexennal, coincidint amb dues legislatures municipals.', false), ('D', 'Quadriennal, sens perjudici que s''hagi de modificar abans per raons d''urgència o de necessitat.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Quina d''aquestes funcions és pròpia de les policies locals segons l''article 28.3 de la Llei 4/2003?', 'L''article 28.3.b) atribueix a les policies locals la policia de trànsit urbà; el trànsit interurbà, la protecció de les autoritats de la Generalitat i la seguretat ciutadana i l''ordre públic són funcions pròpies dels Mossos d''Esquadra (art. 28.2).', 'plcat_t09_sistema_seguretat_catalunya', (select id from public.topics where slug = 'plcat-t09-sistema-seguretat-catalunya'), 1, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2003-9620'), 'Art. 28.3 Llei 4/2003', 'b) Las de policía de tráfico urbano.', null, 'fe723868563916cb672b32374fa6fdcf62e664be94f8fe3dfcc6fdb46871f695', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'fe723868563916cb672b32374fa6fdcf62e664be94f8fe3dfcc6fdb46871f695')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Les de policia de trànsit urbà.', true), ('B', 'Les de policia de trànsit interurbà.', false), ('C', 'La protecció de les autoritats de la Generalitat.', false), ('D', 'Les de policia de seguretat ciutadana i l''ordre públic, amb caràcter exclusiu.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Qui presideix la Comissió del Govern per a la Seguretat, segons l''article 7.1 de la Llei 4/2003?', 'L''article 7.1 fa presidir la Comissió del Govern per a la Seguretat al president de la Generalitat o, si escau, al conseller primer, i la integren els consellers de diversos departaments relacionats amb la seguretat.', 'plcat_t09_sistema_seguretat_catalunya', (select id from public.topics where slug = 'plcat-t09-sistema-seguretat-catalunya'), 2, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2003-9620'), 'Art. 7.1 Llei 4/2003', '1. La Comisión del Gobierno para la Seguridad está integrada por el presidente o presidenta de la Generalidad o, en su caso, por el consejero o consejera jefe, que la preside', null, '7df5338fb4df94942093d72bf4eee962853641a18efd4105d1a60cd74ffd389b', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '7df5338fb4df94942093d72bf4eee962853641a18efd4105d1a60cd74ffd389b')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El conseller competent en seguretat pública.', false), ('B', 'El conseller competent en justícia.', false), ('C', 'El president de la Generalitat o, si escau, el conseller primer.', true), ('D', 'El director general de la Policia.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'En qui pot delegar excepcionalment l''alcalde la presidència de les sessions de la junta local de seguretat, segons l''article 9.6 de la Llei 4/2003?', 'L''article 9.6 permet a l''alcalde delegar excepcionalment la presidència de les sessions en el regidor de seguretat ciutadana.', 'plcat_t09_sistema_seguretat_catalunya', (select id from public.topics where slug = 'plcat-t09-sistema-seguretat-catalunya'), 2, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2003-9620'), 'Art. 9.6 Llei 4/2003', '6. El alcalde o la alcalde puede delegar excepcionalmente la presidencia de las sesiones de la junta local de seguridad al concejal o concejala de seguridad ciudadana.', null, 'd485cb084285e7861376a596fb36433dba4594ff556830424773f20297300b95', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'd485cb084285e7861376a596fb36433dba4594ff556830424773f20297300b95')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'En el regidor de seguretat ciutadana.', true), ('B', 'En el cap de la policia local.', false), ('C', 'En el cap de la comissaria dels Mossos d''Esquadra.', false), ('D', 'En el delegat territorial del Govern.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 20.1 de la Llei 4/2003, què és una regió policial?', 'L''article 20.1 defineix la regió policial com l''agrupació de diverses àrees bàsiques policials; cada regió ha de tenir una comissaria regional amb seu a la comissaria de l''àrea bàsica que determini el Govern.', 'plcat_t09_sistema_seguretat_catalunya', (select id from public.topics where slug = 'plcat-t09-sistema-seguretat-catalunya'), 2, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2003-9620'), 'Art. 20.1 Llei 4/2003', '1. La agrupación de varias áreas básicas policiales, de acuerdo con criterios del Plan territorial general de Cataluña, forma una región policial. Cada región policial debe tener una comisaría regional', null, 'ac3e1b864ac7f2c36678ccad56c5d5f1a87d65d8b9ec631821ae6d170a403dbf', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'ac3e1b864ac7f2c36678ccad56c5d5f1a87d65d8b9ec631821ae6d170a403dbf')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'La unitat mínima, geogràfica i poblacional, del mapa policial.', false), ('B', 'El conjunt de municipis que comparteixen un mateix cos de policia local.', false), ('C', 'La demarcació territorial de cada delegació territorial del Govern, sense comissaria pròpia.', false), ('D', 'L''agrupació de diverses àrees bàsiques policials, amb una comissaria regional.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 24.6 de la Llei 4/2003, quina documentació han d''enviar al departament i fer pública, dins el primer trimestre de cada any, les corporacions locals que disposen de policia local?', 'L''article 24.6 exigeix enviar i publicar, en el primer trimestre, la memòria de serveis de l''any anterior, les dades registrals de delictes, faltes i incidències i les dotacions de recursos.', 'plcat_t09_sistema_seguretat_catalunya', (select id from public.topics where slug = 'plcat-t09-sistema-seguretat-catalunya'), 2, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2003-9620'), 'Art. 24.6 Llei 4/2003', 'a) La memoria de los servicios prestados en el año anterior. b) Los datos registrales de delitos, faltas e incidencias diversas. c) Las dotaciones de recursos humanos y materiales.', null, '4f30aa3e32da7740b7747bd62c79526b7463534933162ea38268797d7be35589', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '4f30aa3e32da7740b7747bd62c79526b7463534933162ea38268797d7be35589')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Només el pressupost del cos de policia local per a l''any en curs.', false), ('B', 'El pla de seguretat local i l''acta de totes les reunions de la junta local.', false), ('C', 'La memòria dels serveis de l''any anterior, les dades registrals de delictes, faltes i incidències i les dotacions de recursos humans i materials.', true), ('D', 'La relació nominal de tots els agents amb les seves sancions disciplinàries.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Quines dades han de figurar, com a mínim, en el document d''acreditació professional dels policies locals, segons l''article 25 ter de la Llei 4/2003?', 'L''article 25 ter exigeix que el document d''acreditació, expedit per l''autoritat municipal, contingui com a mínim el municipi, la categoria professional i el número de registre individual, i que se''n garanteixi la visibilitat.', 'plcat_t09_sistema_seguretat_catalunya', (select id from public.topics where slug = 'plcat-t09-sistema-seguretat-catalunya'), 2, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2003-9620'), 'Art. 25 ter Llei 4/2003', 'En este documento debe figurar, como mínimo, el municipio de pertenencia, la identificación de la categoría profesional y el número de registro individual.', null, '78f838d6aa27b671f6b5b303c966e1a6f62665719350c0b411c5e69939f03980', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '78f838d6aa27b671f6b5b303c966e1a6f62665719350c0b411c5e69939f03980')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El municipi de pertinença, la identificació de la categoria professional i el número de registre individual.', true), ('B', 'El nom i cognoms, el DNI i el grup sanguini de l''agent.', false), ('C', 'La fotografia, l''adreça del domicili i la data d''ingrés al cos.', false), ('D', 'El número de l''arma assignada i la data de la darrera revisió mèdica.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'En quin termini s''han de publicar al DOGC els convenis en matèria de seguretat entre el departament i els ajuntaments, segons l''article 27.7 de la Llei 4/2003?', 'L''article 27.7 obliga a publicar els convenis al DOGC dins d''un mes des que es signen; els signen el conseller i l''alcalde (art. 27.6).', 'plcat_t09_sistema_seguretat_catalunya', (select id from public.topics where slug = 'plcat-t09-sistema-seguretat-catalunya'), 2, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2003-9620'), 'Art. 27.7 Llei 4/2003', '7. Los convenios deben publicarse en el Diari Oficial de la Generalitat de Catalunya en el plazo de un mes a contar del momento en que se firmen.', null, '6ef0bd043051638b2a85db83b3db54ec1c8e1ae5d9634ee40ff1cfbc2e47ade4', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '6ef0bd043051638b2a85db83b3db54ec1c8e1ae5d9634ee40ff1cfbc2e47ade4')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'En el termini de quinze dies a comptar de la signatura.', false), ('B', 'En el termini d''un mes a comptar de la signatura.', true), ('C', 'En el termini de tres mesos a comptar de la signatura.', false), ('D', 'No s''han de publicar, només s''han de comunicar a la junta local.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Quina d''aquestes és una funció COMPARTIDA entre la Policia de la Generalitat-Mossos d''Esquadra i les policies locals, segons l''article 28.4 de la Llei 4/2003?', 'L''article 28.4 considera compartides la policia de proximitat i l''auxili als ciutadans, la resolució amistosa de conflictes privats (si hi són requerides) i la vigilància d''espais públics. La policia comunitària i la protecció de les autoritats locals són pròpies de la policia local (art. 28.3).', 'plcat_t09_sistema_seguretat_catalunya', (select id from public.topics where slug = 'plcat-t09-sistema-seguretat-catalunya'), 2, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2003-9620'), 'Art. 28.4 Llei 4/2003', '4. Son funciones compartidas entre la Policía de la Generalidad-Mossos d''Esquadra y las policías locales: a) Las de policía de proximidad y el auxilio y asistencia a los ciudadanos. b) La intervención en la resolución amistosa de conflictos privados, si son requeridas para ello. c) La vigilancia de espacios públicos.', null, '0d2618108822fdfe75ed044520f62650dfb5316c14c1e89c7617ea5c3967bb8d', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '0d2618108822fdfe75ed044520f62650dfb5316c14c1e89c7617ea5c3967bb8d')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'La vigilància d''espais públics.', true), ('B', 'La policia de trànsit interurbà.', false), ('C', 'La protecció de les autoritats de la corporació local.', false), ('D', 'La policia comunitària en l''àmbit de la convivència veïnal.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 9.8 de la Llei 4/2003, com s''han d''adoptar els acords de la junta local de seguretat?', 'L''article 9.8 exigeix la unanimitat per adoptar els acords de la junta local de seguretat i els dona caràcter executiu.', 'plcat_t09_sistema_seguretat_catalunya', (select id from public.topics where slug = 'plcat-t09-sistema-seguretat-catalunya'), 3, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2003-9620'), 'Art. 9.8 Llei 4/2003', '8. Los acuerdos de la junta local de seguridad deben adoptarse por unanimidad y tienen carácter ejecutivo.', null, '767d2962ec4a96270ec32188c8ba3e454a766f72fb082a7d071bef18c0915c99', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '767d2962ec4a96270ec32188c8ba3e454a766f72fb082a7d071bef18c0915c99')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Per majoria absoluta dels membres, i tenen caràcter consultiu.', false), ('B', 'Per majoria simple, amb vot de qualitat de l''alcalde.', false), ('C', 'Per unanimitat, i tenen caràcter executiu.', true), ('D', 'Per majoria de dos terços, i requereixen la ratificació del Ple municipal.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'En matèria d''organització i estructura interna de les policies locals i d''accés, formació i promoció dels seus membres, quin informe ha d''emetre la Comissió de Policia de Catalunya segons l''article 8.3.c) de la Llei 4/2003?', 'L''article 8.3.c) encarrega a la Comissió de Policia de Catalunya un informe preceptiu no vinculant sobre organització i estructura interna, i sobre accés, formació i promoció; també informa preceptivament, sense vincular, sobre uniformitat (lletra e).', 'plcat_t09_sistema_seguretat_catalunya', (select id from public.topics where slug = 'plcat-t09-sistema-seguretat-catalunya'), 3, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2003-9620'), 'Art. 8.3 Llei 4/2003', 'c) Emitir un informe preceptivo no vinculante en materia de organización y estructura interna al cual deben ajustarse las policías locales, y de acceso, formación y promoción de sus miembros.', null, 'f081a1be010b9f8d9b11cd7ddcbcff8ecd4c00fabf5da9bdad3cdb9c04e733e4', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'f081a1be010b9f8d9b11cd7ddcbcff8ecd4c00fabf5da9bdad3cdb9c04e733e4')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Un informe preceptiu no vinculant.', true), ('B', 'Un informe preceptiu i vinculant.', false), ('C', 'Un informe facultatiu i vinculant.', false), ('D', 'Cap informe: la matèria és competència exclusiva de cada ajuntament.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 25 bis de la Llei 4/2003, l''àmbit del Registre de les policies locals de Catalunya comprèn:', 'L''article 25 bis.2 inclou en el Registre tots els membres dels cossos de policia local, qualsevol que sigui la vinculació, i els vigilants municipals; els ajuntaments n''han de mantenir les dades actualitzades (25 bis.4).', 'plcat_t09_sistema_seguretat_catalunya', (select id from public.topics where slug = 'plcat-t09-sistema-seguretat-catalunya'), 3, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2003-9620'), 'Art. 25 bis Llei 4/2003', '2. El ámbito de este registro comprende todos los miembros de los cuerpos de policía local, cualquiera que sea su vinculación, así como los vigilantes municipales.', null, '62a847d584e967466b7fdc3ec39a05afb68ef853939a76929721946dce7a355c', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '62a847d584e967466b7fdc3ec39a05afb68ef853939a76929721946dce7a355c')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Només els funcionaris de carrera de les policies locals, excloent-ne els interins.', false), ('B', 'Només els comandaments de les escales superior i executiva.', false), ('C', 'Tots els membres dels cossos de policia local, sigui quina sigui la seva vinculació, i també els vigilants municipals.', true), ('D', 'Els membres de les policies locals i dels Mossos d''Esquadra que hi presten servei conjunt.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'A qui correspon la direcció tècnica dels serveis unificats o de gestió conjunta entre els Mossos d''Esquadra i les policies locals, segons l''article 29.4 de la Llei 4/2003?', 'L''article 29.4 atribueix la direcció tècnica al cos que tingui com a pròpia la competència sobre l''activitat objecte del conveni, i inclou els estàndards i les regles de procediment operatiu.', 'plcat_t09_sistema_seguretat_catalunya', (select id from public.topics where slug = 'plcat-t09-sistema-seguretat-catalunya'), 3, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2003-9620'), 'Art. 29.4 Llei 4/2003', '4. La dirección técnica de los servicios unificados o de gestión conjunta corresponde al cuerpo que tenga como propia la competencia sobre la actividad objeto del acuerdo o convenio.', null, 'e093ce893e73a3ae7395c564e6ae6145facf383ce13d5d76f03c473a9a7400ee', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'e093ce893e73a3ae7395c564e6ae6145facf383ce13d5d76f03c473a9a7400ee')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Sempre a la Policia de la Generalitat-Mossos d''Esquadra.', false), ('B', 'Sempre a la policia local del municipi on es presta el servei.', false), ('C', 'A la junta local de seguretat, per torns anuals entre els cossos.', false), ('D', 'Al cos que tingui com a pròpia la competència sobre l''activitat objecte de l''acord o conveni.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
-- Lote plcat-t10-armament-d219-v1 (15 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Decret 219/1996, de 12 de juny, pel qual s''aprova el Reglament d''armament de les policies locals (text consolidat)', 'https://portaljuridic.gencat.cat/ca/document-del-pjur/?documentId=129214', 'diario_autonomico'::public.source_kind, 'Generalitat de Catalunya · Portal Jurídic de Catalunya', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('plcat-t10-armament', 'Tema 10. La policia local com a cos armat: Reglament d''armament de les policies locals i Reglament d''armes') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('policia-local') and t.slug = 'plcat-t10-armament' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 8.1 del Decret 219/1996, amb quin model d''arma reglamentària estan dotats, amb caràcter general, els membres de la policia local?', 'L''article 8.1 fixa com a dotació general el revòlver de calibre 0.38 SPL amb canó d''entre 3'' i 4''; la pistola de 9 mm parabellum és opcional en els termes de l''article 8.2.', 'plcat_t10_armament', (select id from public.topics where slug = 'plcat-t10-armament'), 1, 'ca', true, (select id from public.sources where url = 'https://portaljuridic.gencat.cat/ca/document-del-pjur/?documentId=129214'), 'Art. 8.1 Decret 219/1996', '8.1 Els membres de la policia local estaran dotats d''un revòlver de calibre 0.38 SPL amb una longitud de canó entre 3'' i 4''.', null, 'bf1ac47b82b256cd253505333f4e01ffd2b3f2511a7990c31ddda0682f04f71e', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'bf1ac47b82b256cd253505333f4e01ffd2b3f2511a7990c31ddda0682f04f71e')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Una pistola semiautomàtica de calibre 9 mm parabellum amb canó de 15 cm.', false), ('B', 'Un revòlver de calibre .357 Magnum amb canó de 6''.', false), ('C', 'Un revòlver de calibre 0.38 SPL amb una longitud de canó entre 3'' i 4''.', true), ('D', 'Una pistola semiautomàtica de calibre .22 amb canó de 3''.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 11 del Decret 219/1996, què han d''obrir els ajuntaments a cadascun dels membres de la policia local en relació amb les armes?', 'L''article 11 obliga els ajuntaments a obrir a cada policia un expedient amb totes les dades de conservació, tinença i ús de les armes i municions, i també les revisions periòdiques, pràctiques i cursos de formació.', 'plcat_t10_armament', (select id from public.topics where slug = 'plcat-t10-armament'), 1, 'ca', true, (select id from public.sources where url = 'https://portaljuridic.gencat.cat/ca/document-del-pjur/?documentId=129214'), 'Art. 11 Decret 219/1996', 'Els ajuntaments obriran a cadascun dels membres de la policia local un expedient on constaran totes les dades referents a la conservació, la tinença i l''ús de les armes i de les municions de què reglamentàriament estigui dotat', null, 'e2f6af7cce73e40fa2551165edf3ecba67679275609d5ded87524d065b80b819', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'e2f6af7cce73e40fa2551165edf3ecba67679275609d5ded87524d065b80b819')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Un compte bancari per abonar les despeses de manteniment de l''arma.', false), ('B', 'Un expedient amb totes les dades sobre la conservació, la tinença i l''ús de les armes i municions, incloses les revisions, pràctiques i cursos.', true), ('C', 'Una pòlissa d''assegurança de responsabilitat civil per l''ús de l''arma.', false), ('D', 'Un registre de les sortides de l''arma fora del terme municipal, exclusivament.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 15 del Decret 219/1996, qui passa revista d''armes als membres de la policia local?', 'L''article 15 encarrega al cap del cos passar revista d''armes, d''acord amb la legislació vigent sobre aquesta matèria.', 'plcat_t10_armament', (select id from public.topics where slug = 'plcat-t10-armament'), 1, 'ca', true, (select id from public.sources where url = 'https://portaljuridic.gencat.cat/ca/document-del-pjur/?documentId=129214'), 'Art. 15 Decret 219/1996', 'El cap del cos passarà revista d''armes, d''acord amb el que preveu la legislació vigent sobre aquesta matèria.', null, 'dff3f1e728a89fa5cead2cfb32e468d432992eae77f1fee93617ce2319d30619', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'dff3f1e728a89fa5cead2cfb32e468d432992eae77f1fee93617ce2319d30619')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'L''alcalde personalment.', false), ('B', 'La Intervenció d''Armes de la Guàrdia Civil, en exclusiva.', false), ('C', 'Un instructor de tir de l''Institut de Seguretat Pública de Catalunya.', false), ('D', 'El cap del cos.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Quan es retira l''arma de foc a un policia local, segons l''article 18 del Decret 219/1996:', 'L''article 18 disposa que, en retirar l''arma, també es retira la guia i es lliura un rebut justificatiu, que es retorna en recollir l''arma i la guia.', 'plcat_t10_armament', (select id from public.topics where slug = 'plcat-t10-armament'), 1, 'ca', true, (select id from public.sources where url = 'https://portaljuridic.gencat.cat/ca/document-del-pjur/?documentId=129214'), 'Art. 18 Decret 219/1996', 'Quan es procedeixi a la retirada d''una arma de foc es retirarà també la guia de pertinença i es lliurarà al titular d''aquesta un rebut justificatiu de l''entrega, que serà retornat en recollir l''arma i la guia.', null, '999b811643fadf677526e480dab0609c02043fac2f2a605db87c1970ed1dbccf', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '999b811643fadf677526e480dab0609c02043fac2f2a605db87c1970ed1dbccf')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Es retira també la guia de pertinença i es lliura al titular un rebut justificatiu de l''entrega.', true), ('B', 'Es retira només l''arma i el titular conserva la guia de pertinença.', false), ('C', 'Es retira l''arma i es destrueix la guia de pertinença.', false), ('D', 'Es retira l''arma sense cap document justificatiu per al titular.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'A més de les armes que els agents hi dipositen en acabar el servei, quines altres armes s''han de dipositar a l''armer segons l''article 19.2 del Decret 219/1996?', 'L''article 19.2 hi afegeix les armes retirades o no assignades i les que s''hagin de reparar o verificar.', 'plcat_t10_armament', (select id from public.topics where slug = 'plcat-t10-armament'), 1, 'ca', true, (select id from public.sources where url = 'https://portaljuridic.gencat.cat/ca/document-del-pjur/?documentId=129214'), 'Art. 19.2 Decret 219/1996', '19.2 També s''hi dipositaran les armes que estiguin retirades o no assignades i les que calgui reparar o verificar.', null, 'f69882bfa41b28876dac6c3901d82ec08e11d5128f3249ddf0e8755ab6fd7921', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'f69882bfa41b28876dac6c3901d82ec08e11d5128f3249ddf0e8755ab6fd7921')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Només les armes particulars dels agents amb segona arma autoritzada.', false), ('B', 'Les armes intervingudes en actuacions policials pendents de lliurar al jutjat.', false), ('C', 'Les que estiguin retirades o no assignades i les que calgui reparar o verificar.', true), ('D', 'Cap altra: l''armer és d''ús exclusiu per a les armes en servei.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 20.2 del Decret 219/1996, qui disposa de la clau de cada compartiment individual de l''armer?', 'L''article 20.2 dona a cada titular la clau del seu compartiment i preveu una còpia precintada a disposició del cap del cos o del comandament delegat en cas de necessitat.', 'plcat_t10_armament', (select id from public.topics where slug = 'plcat-t10-armament'), 2, 'ca', true, (select id from public.sources where url = 'https://portaljuridic.gencat.cat/ca/document-del-pjur/?documentId=129214'), 'Art. 20.2 Decret 219/1996', '20.2 El titular de cada guia disposarà de la clau del seu compartiment, però hi haurà també una còpia precintada de la qual, en cas de necessitat, podrà disposar el cap del cos o el comandament delegat.', null, '5aa0d4f5cc0b275aa41a52ea845ac0f5a4d117a9ac02a78fdbb9135c48d2df4f', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '5aa0d4f5cc0b275aa41a52ea845ac0f5a4d117a9ac02a78fdbb9135c48d2df4f')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El titular de cada guia, i hi ha també una còpia precintada de la qual pot disposar en cas de necessitat el cap del cos o el comandament delegat.', true), ('B', 'Només el cap del cos, que obre el compartiment a l''inici i al final de cada servei.', false), ('C', 'L''alcalde, que en custodia totes les claus a l''alcaldia.', false), ('D', 'El comandament de torn, sense cap còpia per evitar-ne l''ús indegut.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'On s''han d''ubicar els armers segons l''article 21 del Decret 219/1996?', 'L''article 21 exigeix ubicar els armers en dependències policíaques d''accés exclusiu per a la plantilla i amb control visual; si no hi ha aquestes garanties, cal un espai protegit amb accés blindat.', 'plcat_t10_armament', (select id from public.topics where slug = 'plcat-t10-armament'), 2, 'ca', true, (select id from public.sources where url = 'https://portaljuridic.gencat.cat/ca/document-del-pjur/?documentId=129214'), 'Art. 21 Decret 219/1996', 'Els armers s''ubicaran en aquelles dependències policíaques on únicament puguin tenir accés els membres de la plantilla i en un lloc on sigui possible el control visual.', null, 'ed8720b378841e0bb74ee5db1632f171601a3766ea482876cdc5a06640498e9d', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'ed8720b378841e0bb74ee5db1632f171601a3766ea482876cdc5a06640498e9d')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'En una dependència municipal qualsevol, sempre que tingui alarma connectada.', false), ('B', 'En dependències policíaques on només puguin accedir-hi els membres de la plantilla i en un lloc on sigui possible el control visual.', true), ('C', 'A la caserna de la Guàrdia Civil més propera.', false), ('D', 'Al domicili del cap del cos, en una caixa forta homologada.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 24 del Decret 219/1996, quina circumstància detectada en les revisions mèdiques és causa de retirada de l''arma de foc?', 'L''article 24 fixa revisions mèdiques com a mínim cada dos anys i fa causa de retirada de l''arma les malalties o defectes físics que la legislació d''armes considera causa de denegació de llicències.', 'plcat_t10_armament', (select id from public.topics where slug = 'plcat-t10-armament'), 2, 'ca', true, (select id from public.sources where url = 'https://portaljuridic.gencat.cat/ca/document-del-pjur/?documentId=129214'), 'Art. 24 Decret 219/1996', 'serà causa de retirada de l''arma de foc l''existència de qualsevol de les malalties o dels defectes físics considerats causa de denegació de llicències, permís o tarja d''armes a la legislació vigent sobre armament.', null, '88a7706fca4eabf6393a1b9ab69b9d473fea6cce8081e4886d9f99945528b776', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '88a7706fca4eabf6393a1b9ab69b9d473fea6cce8081e4886d9f99945528b776')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Qualsevol baixa mèdica superior a quinze dies.', false), ('B', 'La no superació de les pràctiques de tir de l''any anterior.', false), ('C', 'Haver complert cinquanta-set anys.', false), ('D', 'L''existència de qualsevol de les malalties o defectes físics considerats causa de denegació de llicències, permís o targeta d''armes a la legislació sobre armament.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 7 del Decret 219/1996, quan s''han de comunicar al departament de la Generalitat les variacions en el nombre i les característiques de les armes de foc de què disposen les corporacions locals?', 'L''article 7 obliga, a efectes estadístics, a comunicar les variacions de les dotacions d''armes juntament amb la memòria dels serveis prestats, dins el primer trimestre de cada any.', 'plcat_t10_armament', (select id from public.topics where slug = 'plcat-t10-armament'), 2, 'ca', true, (select id from public.sources where url = 'https://portaljuridic.gencat.cat/ca/document-del-pjur/?documentId=129214'), 'Art. 7 Decret 219/1996', 'seran comunicades al Departament de Governació, conjuntament amb la memòria dels serveis prestats, dins el primer trimestre de cada any.', null, '2cc63e81a26066450da12302e92675affee9d68f7a56979c91fbb9b20e8ce7bc', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '2cc63e81a26066450da12302e92675affee9d68f7a56979c91fbb9b20e8ce7bc')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Dins dels deu dies següents a cada adquisició o baixa.', false), ('B', 'Cada cinc anys, quan es renoven les guies de pertinença.', false), ('C', 'Conjuntament amb la memòria dels serveis prestats, dins el primer trimestre de cada any.', true), ('D', 'Abans del 31 de desembre, juntament amb el pressupost municipal.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 9.1 del Decret 219/1996, els alcaldes poden dotar els membres de la policia local d''altres mitjans de defensa amb quin requisit?', 'L''article 9.1 condiciona els altres mitjans de defensa al fet que siguin previstos en els reglaments interns i homologats per les autoritats competents; poden ser de dotació personal o d''unitats específiques (art. 9.2).', 'plcat_t10_armament', (select id from public.topics where slug = 'plcat-t10-armament'), 2, 'ca', true, (select id from public.sources where url = 'https://portaljuridic.gencat.cat/ca/document-del-pjur/?documentId=129214'), 'Art. 9.1 Decret 219/1996', '9.1 Els alcaldes podran dotar els membres de la seva policia local d''altres mitjans de defensa quan aquests estiguin previstos en els reglaments interns i homologats per les autoritats competents.', null, '0f6b695b3b0c6b53df0db399362bb93df291c612ae7d3479cf713039d95dffa4', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '0f6b695b3b0c6b53df0db399362bb93df291c612ae7d3479cf713039d95dffa4')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Que estiguin previstos en els reglaments interns i homologats per les autoritats competents.', true), ('B', 'Que ho autoritzi prèviament el Ple municipal per majoria absoluta.', false), ('C', 'Que els hagi aprovat la junta local de seguretat per unanimitat.', false), ('D', 'Cap: l''alcalde els pot adquirir lliurement.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 13.1 del Decret 219/1996, quan un agent perd l''arma de foc, què ha de fer i què s''instrueix?', 'L''article 13.1 obliga a comunicar immediatament la pèrdua, sostracció, destrucció o modificació al comandament i preveu un expedient d''informació per determinar la responsabilitat i proposar, si escau, mesures disciplinàries.', 'plcat_t10_armament', (select id from public.topics where slug = 'plcat-t10-armament'), 2, 'ca', true, (select id from public.sources where url = 'https://portaljuridic.gencat.cat/ca/document-del-pjur/?documentId=129214'), 'Art. 13.1 Decret 219/1996', 'l''interessat haurà de comunicar-ho immediatament al comandament de qui depengui, i s''instruirà un expedient d''informació als efectes de determinar la possible responsabilitat del titular', null, '2b9af44e5129944c5bfa5514ae188355ba7e0ba1539fb9c842ff9e433ad5dd9a', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '2b9af44e5129944c5bfa5514ae188355ba7e0ba1539fb9c842ff9e433ad5dd9a')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Denunciar-ho al jutjat de guàrdia en el termini de 48 hores; s''instrueix directament un expedient disciplinari per falta molt greu.', false), ('B', 'Comunicar-ho immediatament al comandament de qui depengui; s''instrueix un expedient d''informació per determinar la possible responsabilitat del titular.', true), ('C', 'Comunicar-ho a l''alcalde en el termini de deu dies; no s''instrueix cap expedient.', false), ('D', 'Adquirir una arma nova del mateix model; s''instrueix un expedient de reintegrament de despeses.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 25 del Decret 219/1996, quantes vegades l''any, com a mínim, les pràctiques de tir s''han de fer d''acord amb el programa general establert per l''Escola de Policia de Catalunya (avui, l''ISPC)?', 'Les pràctiques les organitzen els ajuntaments (art. 25.2) i s''han de fer com a mínim dues vegades l''any (art. 25.1), però almenys una vegada l''any s''han de fer segons el programa general de l''Escola de Policia de Catalunya (art. 25.3).', 'plcat_t10_armament', (select id from public.topics where slug = 'plcat-t10-armament'), 2, 'ca', true, (select id from public.sources where url = 'https://portaljuridic.gencat.cat/ca/document-del-pjur/?documentId=129214'), 'Art. 25.3 Decret 219/1996', '25.3 Un cop l''any, com a mínim, les pràctiques es realitzaran d''acord amb el programa que, amb caràcter general, establirà l''Escola de Policia de Catalunya.', null, 'e2b665c8f67113afc0944e715531a9de9094a53cbdfcab9d8ad9b8be7ce90a2c', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'e2b665c8f67113afc0944e715531a9de9094a53cbdfcab9d8ad9b8be7ce90a2c')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Una vegada l''any.', true), ('B', 'Dues vegades l''any.', false), ('C', 'Quatre vegades l''any.', false), ('D', 'Cada dos anys.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Un policia local ha obtingut el resultat de no apte en les proves psicotècniques. Segons l''article 23.4 del Decret 219/1996, quan pot sol·licitar fer noves proves?', 'L''article 23.4 permet sol·licitar noves proves un cop passats sis mesos des de les anteriors, tant en cas de no apte com quan els peritatges desaconsellin l''ús de l''arma.', 'plcat_t10_armament', (select id from public.topics where slug = 'plcat-t10-armament'), 3, 'ca', true, (select id from public.sources where url = 'https://portaljuridic.gencat.cat/ca/document-del-pjur/?documentId=129214'), 'Art. 23.4 Decret 219/1996', 'podran sol·licitar la realització de noves proves un cop transcorreguts sis mesos des de la realització de l''anterior.', null, '9432da6e8bb5fd3a92596f4f78a4a6eb4f07c8841a7860bbd8d9310af738b479', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '9432da6e8bb5fd3a92596f4f78a4a6eb4f07c8841a7860bbd8d9310af738b479')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Un cop transcorreguts tres mesos des de la realització de l''anterior.', false), ('B', 'Un cop transcorreguts sis mesos des de la realització de l''anterior.', true), ('C', 'Un cop transcorregut un any des de la realització de l''anterior.', false), ('D', 'No pot sol·licitar-les: ha d''esperar a la revisió ordinària dels dos anys.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 8.2 del Decret 219/1996, quan ho estableixi el reglament del cos i les pràctiques de tir palesin una major preparació, els ajuntaments poden dotar els agents de:', 'L''article 8.2 preveu opcionalment la pistola semiautomàtica de 9 mm parabellum amb canó d''entre 7 i 12,5 cm, si ho estableix el reglament del cos i les pràctiques de tir de l''article 25 en palesen una major preparació.', 'plcat_t10_armament', (select id from public.topics where slug = 'plcat-t10-armament'), 3, 'ca', true, (select id from public.sources where url = 'https://portaljuridic.gencat.cat/ca/document-del-pjur/?documentId=129214'), 'Art. 8.2 Decret 219/1996', 'els ajuntaments podran dotar els membres del cos citat d''una pistola semiautomàtica del calibre 9 mm parabellum amb una longitud de canó entre 7 i 12,5 cm.', null, '8af6c0b3cc53c60c47f24a8ce2ec7d1034a26cb09f9878f705ec0e7af5a89abf', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '8af6c0b3cc53c60c47f24a8ce2ec7d1034a26cb09f9878f705ec0e7af5a89abf')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Una pistola semiautomàtica de calibre 9 mm parabellum amb una longitud de canó entre 7 i 12,5 cm.', true), ('B', 'Una pistola semiautomàtica de calibre 9 mm parabellum amb una longitud de canó entre 3 i 4 cm.', false), ('C', 'Un revòlver de calibre 0.38 SPL amb una longitud de canó de 6''.', false), ('D', 'Una arma llarga de vigilància i guarderia.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 27.2 del Decret 219/1996, sota la custòdia de qui queden els informes i continguts de les proves psicotècniques i mèdiques que justifiquen el resultat d''apte o no apte?', 'L''article 27.1 incorpora els resultats a l''expedient personal de l''article 11, però l''article 27.2 reserva els informes i continguts de les proves a la custòdia exclusiva dels tècnics.', 'plcat_t10_armament', (select id from public.topics where slug = 'plcat-t10-armament'), 3, 'ca', true, (select id from public.sources where url = 'https://portaljuridic.gencat.cat/ca/document-del-pjur/?documentId=129214'), 'Art. 27.2 Decret 219/1996', '27.2 Els informes i els continguts de les proves psicotècniques i mèdiques que justifiquen el resultat d''apte o no apte quedaran sota la custòdia exclusiva dels tècnics que les realitzin.', null, '58a9ebbff5b21468170dab12dbd6f467d8c9202513f5cff3c2b8e77652cd092e', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '58a9ebbff5b21468170dab12dbd6f467d8c9202513f5cff3c2b8e77652cd092e')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Sota la custòdia del cap del cos, a l''expedient d''armes.', false), ('B', 'Sota la custòdia exclusiva dels tècnics que les realitzin.', true), ('C', 'Sota la custòdia de l''alcalde, a l''arxiu de l''alcaldia.', false), ('D', 'Sota la custòdia de la Intervenció d''Armes de la Guàrdia Civil.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
-- Lote plcat-t10-armament-rarm-v1 (5 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Real Decreto 137/1993, de 29 de enero, por el que se aprueba el Reglamento de Armas (texto consolidado, BOE)', 'https://www.boe.es/buscar/act.php?id=BOE-A-1993-6202', 'boe'::public.source_kind, 'Agencia Estatal Boletín Oficial del Estado', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('plcat-t10-armament', 'Tema 10. La policia local com a cos armat: Reglament d''armament de les policies locals i Reglament d''armes') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('policia-local') and t.slug = 'plcat-t10-armament' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 3 del Reglament d''armes, en quina categoria s''inclouen les armes blanques i, en general, les de fulla tallant o punxant no prohibides?', 'L''article 3 del Reglament d''armes inclou a la 5a categoria les armes blanques i, en general, les de fulla tallant o punxant no prohibides, i els ganivets o matxets d''ús militar o les seves imitacions.', 'plcat_t10_armament', (select id from public.topics where slug = 'plcat-t10-armament'), 1, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1993-6202'), 'Art. 3 RD 137/1993', '5.ª categoría: 1. Las armas blancas y en general las de hoja cortante o punzante no prohibidas.', null, '07af382967c0cb090c16700fb4361b05388e7fd273b0a9f68734e2abab326589', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '07af382967c0cb090c16700fb4361b05388e7fd273b0a9f68734e2abab326589')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', '1a categoria.', false), ('B', '4a categoria.', false), ('C', '7a categoria.', false), ('D', '5a categoria.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 4.1 del Reglament d''armes, quina d''aquestes armes està prohibida?', 'L''article 4.1.c) prohibeix les pistoles i revòlvers amb culatí adaptat. Les escopetes de caça són de 3a categoria i les ballestes de 7a (art. 3).', 'plcat_t10_armament', (select id from public.topics where slug = 'plcat-t10-armament'), 2, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1993-6202'), 'Art. 4.1 RD 137/1993', 'c) Las pistolas y revólveres que lleven adaptado un culatín.', null, 'a50b01e963ec2d859d42e63352c0d80fca33e49b67ed1ddcc5d3c850941cb0c0', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'a50b01e963ec2d859d42e63352c0d80fca33e49b67ed1ddcc5d3c850941cb0c0')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Les escopetes de caça marcades amb punxó pels bancs de proves.', false), ('B', 'Els revòlvers de calibre 0.38 SPL.', false), ('C', 'Les ballestes.', false), ('D', 'Les pistoles i els revòlvers que portin adaptat un culatí.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Amb la llicència A, quantes armes curtes pot posseir el personal dels cossos de policia de les corporacions locals a part de la dotació reglamentària, segons l''article 118.2 del Reglament d''armes?', 'L''article 118.2 limita a una arma curta, a part de la dotació reglamentària, el personal de les policies locals; tres armes curtes només s''admeten per als oficials i suboficials i per a les escales superiors (art. 118.1).', 'plcat_t10_armament', (select id from public.topics where slug = 'plcat-t10-armament'), 2, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1993-6202'), 'Art. 118.2 RD 137/1993', 'el personal de los Cuerpos de Policía de las Corporaciones locales, así como los funcionarios del Servicio de Vigilancia Aduanera, sólo podrán poseer un arma corta, aparte de las que reciban como dotación reglamentaria para el ejercicio de sus funciones.', null, '077a96797c5d12fcffb524bdc5a44d9c4bf7d90c128283df2f71c9c4244391d6', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '077a96797c5d12fcffb524bdc5a44d9c4bf7d90c128283df2f71c9c4244391d6')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Dues armes curtes.', false), ('B', 'Tres armes curtes.', false), ('C', 'Només una arma curta.', true), ('D', 'Cap: només pot tenir l''arma de dotació reglamentària.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'A l''efecte de la prohibició de l''article 4.1.f) del Reglament d''armes, què es considera un punyal?', 'L''article 4.1.f) prohibeix els bastons estoc, els punyals de qualsevol classe i les navalles automàtiques, i considera punyals les armes blanques de fulla menor d''11 cm, de dos talls i punxegudes.', 'plcat_t10_armament', (select id from public.topics where slug = 'plcat-t10-armament'), 3, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1993-6202'), 'Art. 4.1.f RD 137/1993', 'Se considerarán puñales a estos efectos las armas blancas de hoja menor de 11 centímetros, de dos filos y puntiaguda.', null, '703d5304a0666e0638b0ef4ba8eebb51eeea5c4ba2442c6c562d589138f5a5a5', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '703d5304a0666e0638b0ef4ba8eebb51eeea5c4ba2442c6c562d589138f5a5a5')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'L''arma blanca de fulla de més d''11 centímetres, d''un sol tall.', false), ('B', 'Qualsevol ganivet de fulla superior a 20 centímetres.', false), ('C', 'L''arma blanca de fulla de menys d''11 centímetres, de dos talls i punxeguda.', true), ('D', 'L''arma blanca de fulla de menys de 5 centímetres, d''un sol tall.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 5.1.a) del Reglament d''armes, les armes de foc curtes semiautomàtiques de percussió central amb una capacitat de càrrega superior a vint-i-un cartutxos (inclòs el de la recambra):', 'L''article 5.1 prohibeix la publicitat, compravenda, tinença i ús d''aquestes armes, excepte per a funcionaris especialment habilitats i d''acord amb les normes reglamentàries respectives.', 'plcat_t10_armament', (select id from public.topics where slug = 'plcat-t10-armament'), 3, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1993-6202'), 'Art. 5.1.a RD 137/1993', '1. Queda prohibida la publicidad, compraventa, tenencia y uso, salvo por funcionarios especialmente habilitados, y de acuerdo con lo que dispongan las respectivas normas reglamentarias de: a) Las armas de fuego cortas semiautomáticas de percusión central cuya capacidad de carga sea superior a veintiún cartuchos, incluido el alojado en la recámara.', null, 'a7a3efa88777b57ccfd75c36cbf099300ceb21ef968b6f21ae574c1f0364f495', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'a7a3efa88777b57ccfd75c36cbf099300ceb21ef968b6f21ae574c1f0364f495')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Estan permeses amb llicència B per a qualsevol ciutadà.', false), ('B', 'Estan permeses amb llicència F per a tiradors esportius.', false), ('C', 'Estan prohibides en tots els casos, també per als funcionaris policials.', false), ('D', 'Estan prohibides, llevat per a funcionaris especialment habilitats i d''acord amb les seves normes reglamentàries.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
-- Lote plcat-t11-seguretat-ciutadana-1-lopsc-v1 (20 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Ley Orgánica 4/2015, de 30 de marzo, de protección de la seguridad ciudadana (texto consolidado, BOE)', 'https://www.boe.es/buscar/act.php?id=BOE-A-2015-3442', 'boe'::public.source_kind, 'Agencia Estatal Boletín Oficial del Estado', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('plcat-t11-seguretat-ciutadana-1', 'Tema 11. La Llei orgànica 4/2015 de protecció de la seguretat ciutadana (I): disposicions generals, documentació i identificació') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('policia-local') and t.slug = 'plcat-t11-seguretat-ciutadana-1' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Quin d''aquests és un dels fins de la LO 4/2015 segons el seu article 3?', 'L''article 3 enumera, entre altres fins, la protecció del lliure exercici dels drets, la garantia del funcionament normal de les institucions, la preservació de la seguretat i la convivència i la protecció de persones i béns.', 'plcat_t11_seguretat_ciutadana_1', (select id from public.topics where slug = 'plcat-t11-seguretat-ciutadana-1'), 1, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2015-3442'), 'Art. 3 LO 4/2015', 'b) La garantía del normal funcionamiento de las instituciones.', null, 'c322ca7d35f73b68e6ce43154a9c1a924964bcda9ecc6a5693330530ee8c747c', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'c322ca7d35f73b68e6ce43154a9c1a924964bcda9ecc6a5693330530ee8c747c')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'La recaptació de tributs locals.', false), ('B', 'La regulació del dret de vaga dels treballadors.', false), ('C', 'La garantia del funcionament normal de les institucions.', true), ('D', 'L''organització de les eleccions municipals.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 10 de la LO 4/2015, quin òrgan exerceix la competència sobre la confecció i l''expedició del DNI i custodia els arxius i fitxers que hi estan relacionats?', 'L''article 10 atribueix al Ministeri de l''Interior la competència exclusiva sobre el DNI, que exerceix la Direcció General de la Policia, a la qual correspon també la custòdia dels arxius i fitxers.', 'plcat_t11_seguretat_ciutadana_1', (select id from public.topics where slug = 'plcat-t11-seguretat-ciutadana-1'), 1, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2015-3442'), 'Art. 10 LO 4/2015', '2. La competencia a que se refiere el apartado anterior será ejercida por la Dirección General de la Policía, a la que corresponderá también la custodia y responsabilidad de los archivos y ficheros relacionados con el Documento Nacional de Identidad.', null, '7d91abc3379d624ec23eaa6159742f4fdce40071d90b69d64d5fbc454d6ad85e', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '7d91abc3379d624ec23eaa6159742f4fdce40071d90b69d64d5fbc454d6ad85e')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'La Direcció General de la Guàrdia Civil.', false), ('B', 'La Direcció General de la Policia.', true), ('C', 'El Registre Civil.', false), ('D', 'Els ajuntaments, mitjançant l''oficina del padró.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 12.1 de la LO 4/2015, a qui correspon l''expedició del passaport a l''estranger?', 'L''article 12.1 atribueix l''expedició del passaport a la Direcció General de la Policia en territori nacional i a les representacions diplomàtiques i consulars a l''estranger.', 'plcat_t11_seguretat_ciutadana_1', (select id from public.topics where slug = 'plcat-t11-seguretat-ciutadana-1'), 1, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2015-3442'), 'Art. 12.1 LO 4/2015', 'b) En el extranjero, a las Representaciones Diplomáticas y Consulares de España.', null, '18c4196122267832f531aa0b4f47d9519d353b0256c3dae72884bcc59c87eb65', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '18c4196122267832f531aa0b4f47d9519d353b0256c3dae72884bcc59c87eb65')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'A les representacions diplomàtiques i consulars d''Espanya.', true), ('B', 'A la Direcció General de la Policia, en exclusiva.', false), ('C', 'Al Ministeri de Justícia.', false), ('D', 'A la Delegació del Govern de la comunitat autònoma de residència.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 13.1 de la LO 4/2015, els estrangers que es troben en territori espanyol:', 'L''article 13.1 imposa als estrangers el dret i l''obligació de conservar i portar la documentació d''identitat del país d''origen i la que acrediti la seva situació regular a Espanya.', 'plcat_t11_seguretat_ciutadana_1', (select id from public.topics where slug = 'plcat-t11-seguretat-ciutadana-1'), 1, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2015-3442'), 'Art. 13.1 LO 4/2015', '1. Los extranjeros que se encuentren en territorio español tienen el derecho y la obligación de conservar y portar consigo la documentación que acredite su identidad expedida por las autoridades competentes del país de origen o de procedencia, así como la que acredite su situación regular en España.', null, 'dad1f41e671ea82dabb730a45579ae73ce5daec1b6f50a028bb363d300271490', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'dad1f41e671ea82dabb730a45579ae73ce5daec1b6f50a028bb363d300271490')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Només han de portar documentació si són majors de divuit anys.', false), ('B', 'No estan obligats a portar cap documentació si són ciutadans de la Unió Europea.', false), ('C', 'Han de lliurar el passaport a la comissaria de policia mentre dura la seva estada.', false), ('D', 'Tenen el dret i l''obligació de conservar i portar la documentació que acrediti la seva identitat i la seva situació regular a Espanya.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Quan les forces i cossos de seguretat entren en un domicili particular per les causes previstes a l''article 15 de la LO 4/2015, què han de fer amb l''acta o l''atestat que instrueixin?', 'L''article 15.4 obliga a remetre sense dilació l''acta o atestat a l''autoritat judicial competent quan s''entra en un domicili per causa d''extrema i urgent necessitat.', 'plcat_t11_seguretat_ciutadana_1', (select id from public.topics where slug = 'plcat-t11-seguretat-ciutadana-1'), 1, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2015-3442'), 'Art. 15.4 LO 4/2015', '4. Cuando por las causas previstas en este artículo las Fuerzas y Cuerpos de Seguridad entren en un domicilio particular, remitirán sin dilación el acta o atestado que instruyan a la autoridad judicial competente.', null, '17d86f659027cb485ad64470b755d52817bf0039180b1ab0ada889185287d449', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '17d86f659027cb485ad64470b755d52817bf0039180b1ab0ada889185287d449')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Remetre''ls al Ministeri Fiscal en el termini d''un mes.', false), ('B', 'Remetre''ls sense dilació a l''autoritat judicial competent.', true), ('C', 'Arxivar-los a la dependència policial i comunicar-los només si el titular ho demana.', false), ('D', 'Lliurar-los a l''alcalde del municipi.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Si un registre corporal extern exigeix deixar a la vista parts del cos normalment cobertes per la roba, l''article 20.2 de la LO 4/2015 estableix que s''ha de fer:', 'L''article 20.2.b) exigeix fer-lo en un lloc reservat i fora de la vista de tercers, i deixar constància escrita de la diligència, les causes i la identitat de l''agent que la va adoptar.', 'plcat_t11_seguretat_ciutadana_1', (select id from public.topics where slug = 'plcat-t11-seguretat-ciutadana-1'), 1, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2015-3442'), 'Art. 20.2 LO 4/2015', 'b) Y si exigiera dejar a la vista partes del cuerpo normalmente cubiertas por ropa, se efectuará en un lugar reservado y fuera de la vista de terceros. Se dejará constancia escrita de esta diligencia, de sus causas y de la identidad del agente que la adoptó.', null, 'e8e38f43d9d0b88ac2cf54232bf36b64f0e52bd5572634a6582068be53b23aab', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'e8e38f43d9d0b88ac2cf54232bf36b64f0e52bd5572634a6582068be53b23aab')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Necessàriament en presència d''un advocat.', false), ('B', 'Només amb autorització judicial prèvia.', false), ('C', 'A la via pública, perquè hi hagi testimonis.', false), ('D', 'En un lloc reservat i fora de la vista de tercers, deixant-ne constància escrita.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Quin d''aquests NO és una autoritat o òrgan competent en matèria de seguretat ciutadana en l''àmbit de l''Administració General de l''Estat, segons l''article 5.2 de la LO 4/2015?', 'L''article 5.2 enumera el ministre de l''Interior, el secretari d''Estat de Seguretat, els titulars d''òrgans directius de l''Interior que en tinguin la condició, els delegats del Govern i els subdelegats del Govern i directors insulars.', 'plcat_t11_seguretat_ciutadana_1', (select id from public.topics where slug = 'plcat-t11-seguretat-ciutadana-1'), 2, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2015-3442'), 'Art. 5.2 LO 4/2015', 'a) El Ministro del Interior. b) El Secretario de Estado de Seguridad. c) Los titulares de los órganos directivos del Ministerio del Interior que tengan atribuida tal condición, en virtud de disposiciones legales o reglamentarias. d) Los Delegados del Gobierno en las comunidades autónomas y en las Ciudades de Ceuta y Melilla. e) Los Subdelegados del Gobierno en las provincias y los Directores Insulares.', null, 'bfdb88b71561a949771b34cd8abfa658a76d832d54a5260f8ac98a924ee79133', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'bfdb88b71561a949771b34cd8abfa658a76d832d54a5260f8ac98a924ee79133')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El ministre de l''Interior.', false), ('B', 'El secretari d''Estat de Seguretat.', false), ('C', 'El cap superior de policia de cada província.', true), ('D', 'Els subdelegats del Govern a les províncies.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 7.1 de la LO 4/2015, quan una autoritat o un funcionari públic coneix, per raó del càrrec, fets que pertorben greument la seguretat ciutadana:', 'L''article 7.1 obliga totes les autoritats i funcionaris a col·laborar i, si coneixen per raó del càrrec fets que pertorbin greument la seguretat ciutadana, a comunicar-ho immediatament a l''autoritat competent.', 'plcat_t11_seguretat_ciutadana_1', (select id from public.topics where slug = 'plcat-t11-seguretat-ciutadana-1'), 2, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2015-3442'), 'Art. 7.1 LO 4/2015', 'Cuando, por razón de su cargo, tengan conocimiento de hechos que perturben gravemente la seguridad ciudadana o de los que racionalmente pueda inferirse que pueden producir una perturbación grave, estarán obligados a ponerlo inmediatamente en conocimiento de la autoridad competente.', null, 'b160e30ee975b80fd2e7261cfa68fbedf4fa3a02b7ac2118c384954f0ca55579', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'b160e30ee975b80fd2e7261cfa68fbedf4fa3a02b7ac2118c384954f0ca55579')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Està obligat a posar-ho immediatament en coneixement de l''autoritat competent.', true), ('B', 'Ho pot comunicar si ho considera oportú, sense cap obligació.', false), ('C', 'Ho ha de comunicar en el termini de deu dies al seu superior jeràrquic.', false), ('D', 'Només ho ha de comunicar si li ho requereix l''autoritat judicial.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 7.3 de la LO 4/2015, qui té un especial deure d''auxiliar les forces i cossos de seguretat, prestar-los la col·laboració que necessitin i seguir-ne les instruccions?', 'L''article 7.3 imposa aquest especial deure a les empreses de seguretat privada, els despatxos de detectius i el personal de seguretat privada, en els termes de la seva normativa.', 'plcat_t11_seguretat_ciutadana_1', (select id from public.topics where slug = 'plcat-t11-seguretat-ciutadana-1'), 2, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2015-3442'), 'Art. 7.3 LO 4/2015', '3. Las empresas de seguridad privada, los despachos de detectives privados y el personal de seguridad privada tienen un especial deber de auxiliar a las Fuerzas y Cuerpos de Seguridad en el ejercicio de sus funciones, prestarles la colaboración que precisen y seguir sus instrucciones', null, 'c17787ea9ed6fd83ca9fd3e9975ad47f72bfaa6abe3acf8249099b2710f244ee', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'c17787ea9ed6fd83ca9fd3e9975ad47f72bfaa6abe3acf8249099b2710f244ee')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Els mitjans de comunicació social.', false), ('B', 'Les empreses de seguretat privada, els despatxos de detectius privats i el personal de seguretat privada.', true), ('C', 'Les associacions de veïns.', false), ('D', 'Els titulars d''establiments d''hostaleria.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 8.3 de la LO 4/2015, qui pot utilitzar el DNI per a la identificació electrònica i la signatura electrònica de documents?', 'L''article 8.3 permet la identificació i la signatura electròniques als espanyols majors d''edat que gaudeixin de plena capacitat d''obrar i als menors emancipats.', 'plcat_t11_seguretat_ciutadana_1', (select id from public.topics where slug = 'plcat-t11-seguretat-ciutadana-1'), 2, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2015-3442'), 'Art. 8.3 LO 4/2015', '3. El Documento Nacional de Identidad permite a los españoles mayores de edad que gocen de plena capacidad de obrar y a los menores emancipados la identificación electrónica de su titular, así como la firma electrónica de documentos', null, 'dd86fc748e5ecdcc59dc8c72e0ee912dab34fea5ad3b64fc2feeadb2b70e3763', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'dd86fc748e5ecdcc59dc8c72e0ee912dab34fea5ad3b64fc2feeadb2b70e3763')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Tots els titulars del DNI a partir dels catorze anys.', false), ('B', 'Només els funcionaris públics en l''exercici de les seves funcions.', false), ('C', 'Els espanyols majors d''edat amb plena capacitat d''obrar i els menors emancipats.', true), ('D', 'Els majors de setze anys amb autorització dels pares.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 9.1 de la LO 4/2015, el titular del DNI pot ser privat del document:', 'L''article 9.1 disposa que el DNI és personal i intransferible i que el titular no en pot ser privat, ni tan sols temporalment, llevat que d''acord amb la llei s''hagi de substituir per un altre document.', 'plcat_t11_seguretat_ciutadana_1', (select id from public.topics where slug = 'plcat-t11-seguretat-ciutadana-1'), 2, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2015-3442'), 'Art. 9.1 LO 4/2015', 'No podrá ser privado del mismo, ni siquiera temporalmente, sino en los supuestos en que, conforme a lo previsto por la ley, haya de ser sustituido por otro documento.', null, '3ebf7f86dd1d9b1ca1e254dd00d6963abd8a92b5d854a17b27027cd3ed524ad0', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '3ebf7f86dd1d9b1ca1e254dd00d6963abd8a92b5d854a17b27027cd3ed524ad0')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Temporalment, quan ho ordeni un agent durant una identificació.', false), ('B', 'Quan sigui detingut, mentre duri la detenció.', false), ('C', 'Quan tingui sancions administratives pendents de pagament.', false), ('D', 'Només en els supòsits en què, d''acord amb la llei, hagi de ser substituït per un altre document.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 11.3 de la LO 4/2015, l''obtenció del passaport per part d''un ciutadà subjecte a pàtria potestat està condicionada a:', 'L''article 11.3 condiciona el passaport dels menors subjectes a pàtria potestat o tutela al consentiment exprés de qui n''exerceixi la potestat o, en el seu defecte, de l''òrgan judicial.', 'plcat_t11_seguretat_ciutadana_1', (select id from public.topics where slug = 'plcat-t11-seguretat-ciutadana-1'), 2, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2015-3442'), 'Art. 11.3 LO 4/2015', '3. La obtención del pasaporte por los ciudadanos sujetos a patria potestad o a tutela estará condicionada al consentimiento expreso de las personas u órgano que tenga encomendado su ejercicio o, en su defecto, del órgano judicial competente.', null, '7ad618c6aa29af615478f1f4264eae0deacec06ffffb41fad9f0683cb622187e', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '7ad618c6aa29af615478f1f4264eae0deacec06ffffb41fad9f0683cb622187e')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El consentiment exprés de les persones o l''òrgan que en tinguin encomanat l''exercici o, si no, de l''òrgan judicial competent.', true), ('B', 'L''autorització prèvia del Ministeri Fiscal en tots els casos.', false), ('C', 'Haver complert setze anys.', false), ('D', 'L''autorització de la Direcció General de la Policia, després d''un informe dels serveis socials.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 13.2 de la LO 4/2015, els estrangers poden ser privats de la seva documentació d''origen:', 'L''article 13.2 prohibeix privar els estrangers de la seva documentació d''origen, llevat en el curs d''investigacions judicials de caràcter penal.', 'plcat_t11_seguretat_ciutadana_1', (select id from public.topics where slug = 'plcat-t11-seguretat-ciutadana-1'), 2, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2015-3442'), 'Art. 13.2 LO 4/2015', '2. Los extranjeros no podrán ser privados de su documentación de origen, salvo en el curso de investigaciones judiciales de carácter penal.', null, '52fbc0b7a95a5dd0f84c0587d05076833f1ea9852bbda46a5392c0d5a6a86f38', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '52fbc0b7a95a5dd0f84c0587d05076833f1ea9852bbda46a5392c0d5a6a86f38')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Sempre que es trobin en situació irregular a Espanya.', false), ('B', 'Quan ho acordi la Delegació del Govern per resolució motivada.', false), ('C', 'Només en el curs d''investigacions judicials de caràcter penal.', true), ('D', 'Durant el temps que duri una diligència d''identificació a dependències policials.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 14 de la LO 4/2015, les autoritats competents poden dictar ordres i prohibicions i disposar les actuacions policials estrictament necessàries per assolir els fins de la llei:', 'L''article 14 exigeix que les ordres, prohibicions i actuacions policials estrictament necessàries es dictin, d''acord amb les lleis i els reglaments, mitjançant resolució degudament motivada.', 'plcat_t11_seguretat_ciutadana_1', (select id from public.topics where slug = 'plcat-t11-seguretat-ciutadana-1'), 2, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2015-3442'), 'Art. 14 LO 4/2015', 'podrán dictar las órdenes y prohibiciones y disponer las actuaciones policiales estrictamente necesarias para asegurar la consecución de los fines previstos en esta Ley, mediante resolución debidamente motivada.', null, '7869d68a907da6a99c62b1f75595198f1989c1fbcf92c5d8219c5fe66f29e2ae', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '7869d68a907da6a99c62b1f75595198f1989c1fbcf92c5d8219c5fe66f29e2ae')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Mitjançant una resolució degudament motivada.', true), ('B', 'Verbalment i sense necessitat de motivació.', false), ('C', 'Només amb autorització judicial prèvia.', false), ('D', 'Només si ho autoritza el Consell de Ministres.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 17.1 de la LO 4/2015, en supòsits d''alteració de la seguretat ciutadana o de la convivència pacífica, els agents poden:', 'L''article 17.1 permet limitar o restringir la circulació o la permanència en vies o llocs públics i establir zones de seguretat, pel temps imprescindible, i ocupar preventivament efectes o instruments que es puguin utilitzar per a accions il·legals.', 'plcat_t11_seguretat_ciutadana_1', (select id from public.topics where slug = 'plcat-t11-seguretat-ciutadana-1'), 2, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2015-3442'), 'Art. 17.1 LO 4/2015', '1. Los agentes de las Fuerzas y Cuerpos de Seguridad podrán limitar o restringir la circulación o permanencia en vías o lugares públicos y establecer zonas de seguridad en supuestos de alteración de la seguridad ciudadana o de la pacífica convivencia', null, 'ba9a29264f64cf829f0ae5baeec5c7e5b1bb35b678a70d7e3809205a2d160dda', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'ba9a29264f64cf829f0ae5baeec5c7e5b1bb35b678a70d7e3809205a2d160dda')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Decretar el toc de queda a tot el municipi durant un màxim de quinze dies.', false), ('B', 'Limitar o restringir la circulació o permanència en vies o llocs públics i establir zones de seguretat, pel temps imprescindible.', true), ('C', 'Ordenar el tancament de tots els establiments públics durant un mes.', false), ('D', 'Suspendre el dret de reunió fins que ho autoritzi el jutge.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 4.1 de la LO 4/2015, com s''han d''interpretar i aplicar, en particular, les disposicions dels capítols III i V de la llei?', 'L''article 4.1, segon paràgraf, obliga a interpretar i aplicar els capítols III (actuacions de manteniment de la seguretat) i V (règim sancionador) de la manera més favorable a la plena efectivitat dels drets fonamentals i les llibertats públiques.', 'plcat_t11_seguretat_ciutadana_1', (select id from public.topics where slug = 'plcat-t11-seguretat-ciutadana-1'), 3, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2015-3442'), 'Art. 4.1 LO 4/2015', 'En particular, las disposiciones de los capítulos III y V deberán interpretarse y aplicarse del modo más favorable a la plena efectividad de los derechos fundamentales y libertades públicas, singularmente de los derechos de reunión y manifestación, las libertades de expresión e información, la libertad sindical y el derecho de huelga.', null, '69065ee6ad8ef362cf4687740ff32917b19884ed7835888628788a33be8f9f4c', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '69065ee6ad8ef362cf4687740ff32917b19884ed7835888628788a33be8f9f4c')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'De manera restrictiva, sempre en favor de la preservació de l''ordre públic.', false), ('B', 'D''acord amb el criteri de l''agent actuant, que gaudeix de discrecionalitat plena.', false), ('C', 'De la manera més favorable a l''eficàcia de l''actuació policial, encara que limiti els drets fonamentals.', false), ('D', 'De la manera més favorable a la plena efectivitat dels drets fonamentals i les llibertats públiques, singularment els de reunió i manifestació, d''expressió i d''informació, la llibertat sindical i el dret de vaga.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 4.3 de la LO 4/2015, què justifica l''activitat d''intervenció dels poders públics en matèria de seguretat ciutadana?', 'L''article 4.3 justifica la intervenció per una amenaça concreta o un comportament objectivament perillós susceptible de provocar un perjudici real per a la seguretat ciutadana, i remet al capítol III per a les intervencions concretes.', 'plcat_t11_seguretat_ciutadana_1', (select id from public.topics where slug = 'plcat-t11-seguretat-ciutadana-1'), 3, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2015-3442'), 'Art. 4.3 LO 4/2015', '3. La actividad de intervención se justifica por la existencia de una amenaza concreta o de un comportamiento objetivamente peligroso que, razonablemente, sea susceptible de provocar un perjuicio real para la seguridad ciudadana', null, '7da19db64e4469261a5bf7b7293b4e878032eea032662962d272fd96bab561a8', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '7da19db64e4469261a5bf7b7293b4e878032eea032662962d272fd96bab561a8')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Qualsevol sospita genèrica de l''agent sobre la conducta d''una persona.', false), ('B', 'L''existència d''una amenaça concreta o d''un comportament objectivament perillós que, raonablement, pugui provocar un perjudici real per a la seguretat ciutadana.', true), ('C', 'L''existència d''una denúncia prèvia d''un particular, en tots els casos.', false), ('D', 'La simple presència de persones en grup a la via pública.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Quin d''aquests supòsits NO és una de les circumstàncies en què es pot exceptuar el dret a l''expedició del passaport, segons l''article 11.2 de la LO 4/2015?', 'L''article 11.2 només exceptua el dret al passaport per condemnes privatives de llibertat no extingides, retirada judicial del passaport, llibertat vigilada amb prohibició de sortir o prohibició judicial de sortida o d''expedició per a menors o persones amb capacitat modificada. Els deutes per sancions no hi són.', 'plcat_t11_seguretat_ciutadana_1', (select id from public.topics where slug = 'plcat-t11-seguretat-ciutadana-1'), 3, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2015-3442'), 'Art. 11.2 LO 4/2015', 'a) Haber sido condenado a penas o medidas de seguridad privativas de libertad, mientras no se hayan extinguido, salvo que obtenga autorización del órgano judicial competente. b) Haber sido acordada por el órgano judicial competente la retirada de su pasaporte de acuerdo con lo previsto por la ley. c) Haberle sido impuesta una medida de libertad vigilada con prohibición de abandonar el territorio nacional', null, 'aa6e18a762c1f1ce8561de667053ead41541bc6a2d878fddde4662e7621e3cc0', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'aa6e18a762c1f1ce8561de667053ead41541bc6a2d878fddde4662e7621e3cc0')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Tenir sancions administratives per infraccions greus de la LO 4/2015 pendents de pagament.', true), ('B', 'Haver estat condemnat a penes o mesures de seguretat privatives de llibertat no extingides, llevat d''autorització judicial.', false), ('C', 'Haver acordat l''òrgan judicial la retirada del passaport d''acord amb la llei.', false), ('D', 'Tenir imposada una mesura de llibertat vigilada amb prohibició d''abandonar el territori nacional, llevat d''autorització judicial.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 18.2 de la LO 4/2015, per prevenir la comissió de qualsevol delicte, els agents de l''autoritat poden ocupar temporalment:', 'L''article 18.2 permet l''ocupació temporal de qualsevol objecte, instrument o mitjà d''agressió, fins i tot les armes portades amb llicència, si es considera necessari per prevenir delictes o quan hi ha perill per a persones o béns.', 'plcat_t11_seguretat_ciutadana_1', (select id from public.topics where slug = 'plcat-t11-seguretat-ciutadana-1'), 3, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2015-3442'), 'Art. 18.2 LO 4/2015', '2. Los agentes de la autoridad podrán proceder a la ocupación temporal de cualesquiera objetos, instrumentos o medios de agresión, incluso de las armas que se porten con licencia, permiso o autorización si se estima necesario', null, '704712220323457858dcd94f32422b40649e5a7a795bb7d079b2cdd1bbceb830', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '704712220323457858dcd94f32422b40649e5a7a795bb7d079b2cdd1bbceb830')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Només les armes que es portin sense llicència.', false), ('B', 'Només els objectes que constitueixin cos del delicte, amb autorització judicial.', false), ('C', 'Només els vehicles estacionats en zones de seguretat.', false), ('D', 'Qualsevol objecte, instrument o mitjà d''agressió, fins i tot les armes que es portin amb llicència, permís o autorització.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 20.4 de la LO 4/2015, els registres corporals externs es poden fer contra la voluntat de la persona afectada?', 'L''article 20.4 permet fer el registre corporal extern contra la voluntat de l''afectat amb les mesures de compulsió indispensables, segons els principis d''idoneïtat, necessitat i proporcionalitat; a més, s''ha de respectar la injerència mínima (art. 20.3).', 'plcat_t11_seguretat_ciutadana_1', (select id from public.topics where slug = 'plcat-t11-seguretat-ciutadana-1'), 3, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2015-3442'), 'Art. 20.4 LO 4/2015', '4. Los registros a los que se refiere este artículo podrán llevarse a cabo contra la voluntad del afectado, adoptando las medidas de compulsión indispensables, conforme a los principios de idoneidad, necesidad y proporcionalidad.', null, '901c35f82b5cb68049672740a3ba3508df82bae9c73ae8b4d22bbd7dbafe3464', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '901c35f82b5cb68049672740a3ba3508df82bae9c73ae8b4d22bbd7dbafe3464')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'No, en cap cas: si la persona s''hi nega, cal autorització judicial.', false), ('B', 'Només si la persona és menor d''edat i hi consent el Ministeri Fiscal.', false), ('C', 'Sí, adoptant les mesures de compulsió indispensables, d''acord amb els principis d''idoneïtat, necessitat i proporcionalitat.', true), ('D', 'Només si hi ha present un advocat designat per la persona afectada.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
-- Lote plcat-t12-seguretat-ciutadana-2-lopsc-v1 (20 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Ley Orgánica 4/2015, de 30 de marzo, de protección de la seguridad ciudadana (texto consolidado, BOE)', 'https://www.boe.es/buscar/act.php?id=BOE-A-2015-3442', 'boe'::public.source_kind, 'Agencia Estatal Boletín Oficial del Estado', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('plcat-t12-seguretat-ciutadana-2', 'Tema 12. La Llei orgànica 4/2015 (II): potestats de policia de seguretat, reunions i manifestacions i règim sancionador') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('policia-local') and t.slug = 'plcat-t12-seguretat-ciutadana-2' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 22 de la LO 4/2015, qui pot gravar persones, llocs o objectes mitjançant càmeres de videovigilància fixes o mòbils legalment autoritzades?', 'L''article 22 permet a l''autoritat governativa i, si escau, a les forces i cossos de seguretat gravar amb càmeres de videovigilància legalment autoritzades, d''acord amb la legislació específica.', 'plcat_t12_seguretat_ciutadana_2', (select id from public.topics where slug = 'plcat-t12-seguretat-ciutadana-2'), 1, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2015-3442'), 'Art. 22 LO 4/2015', 'La autoridad gubernativa y, en su caso, las Fuerzas y Cuerpos de Seguridad podrán proceder a la grabación de personas, lugares u objetos mediante cámaras de videovigilancia fijas o móviles legalmente autorizadas, de acuerdo con la legislación vigente en la materia.', null, '20d0d1612aac2530332775e3cd021abf9c2f49704122f352f69984d1a3985962', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '20d0d1612aac2530332775e3cd021abf9c2f49704122f352f69984d1a3985962')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Qualsevol particular, sense limitacions, a la via pública.', false), ('B', 'Només l''autoritat judicial en el marc d''una instrucció penal.', false), ('C', 'Només les empreses de seguretat privada contractades per l''ajuntament.', false), ('D', 'L''autoritat governativa i, si escau, les forces i cossos de seguretat, d''acord amb la legislació vigent en la matèria.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 28.2 de la LO 4/2015, la intervenció d''armes, explosius, cartutxeria i articles pirotècnics correspon al Ministeri de l''Interior, que l''exerceix a través de:', 'L''article 28.2 atribueix la intervenció d''armes i explosius al Ministeri de l''Interior, que l''exerceix per mitjà de la Direcció General de la Guàrdia Civil, amb facultats d''inspecció en qualsevol moment.', 'plcat_t12_seguretat_ciutadana_2', (select id from public.topics where slug = 'plcat-t12-seguretat-ciutadana-2'), 1, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2015-3442'), 'Art. 28.2 LO 4/2015', '2. La intervención de armas, explosivos, cartuchería y artículos pirotécnicos corresponde al Ministerio del Interior, que la ejerce a través de la Dirección General de la Guardia Civil', null, '41ddd5cde1d629c8e4c27895bdc0a4963b2310df23f16cf8a65f910b51ddf0a6', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '41ddd5cde1d629c8e4c27895bdc0a4963b2310df23f16cf8a65f910b51ddf0a6')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'La Direcció General de la Policia.', false), ('B', 'Les policies locals de cada municipi.', false), ('C', 'La Direcció General de la Guàrdia Civil.', true), ('D', 'El Ministeri de Defensa.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la LO 4/2015, portar, exhibir o usar armes prohibides, quan no constitueixi infracció penal, és una infracció:', 'L''article 36.10 qualifica de greu portar, exhibir o usar armes prohibides, i també fer-ho amb armes de manera negligent, temerària o intimidatòria o fora dels llocs habilitats, si no és infracció penal.', 'plcat_t12_seguretat_ciutadana_2', (select id from public.topics where slug = 'plcat-t12-seguretat-ciutadana-2'), 1, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2015-3442'), 'Art. 36.10 LO 4/2015', '10. Portar, exhibir o usar armas prohibidas, así como portar, exhibir o usar armas de modo negligente, temerario o intimidatorio, o fuera de los lugares habilitados para su uso, aún cuando en este último caso se tuviera licencia, siempre que dichas conductas no constituyan infracción penal.', null, '91b17b9d957e0f3f1bef3d3c1cf9e75a750dda99ba1643d06097cfb874d60850', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '91b17b9d957e0f3f1bef3d3c1cf9e75a750dda99ba1643d06097cfb874d60850')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Molt greu.', false), ('B', 'Greu.', true), ('C', 'Lleu.', false), ('D', 'No és infracció administrativa, només penal.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la LO 4/2015, el consum de begudes alcohòliques en llocs, vies, establiments o transports públics quan pertorbi greument la tranquil·litat ciutadana és una infracció:', 'L''article 37.17 tipifica com a lleu el consum de begudes alcohòliques en llocs, vies, establiments o transports públics quan pertorbi greument la tranquil·litat ciutadana; en canvi, el consum de drogues en aquests llocs és greu (art. 36.16).', 'plcat_t12_seguretat_ciutadana_2', (select id from public.topics where slug = 'plcat-t12-seguretat-ciutadana-2'), 1, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2015-3442'), 'Art. 37.17 LO 4/2015', '17. El consumo de bebidas alcohólicas en lugares, vías, establecimientos o transportes públicos cuando perturbe gravemente la tranquilidad ciudadana.', null, '7ed2bc432e75cdd0fac90daca2af908cd2bbb86e078b1b1d24e2f5c8eb53b326', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '7ed2bc432e75cdd0fac90daca2af908cd2bbb86e078b1b1d24e2f5c8eb53b326')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Lleu.', true), ('B', 'Greu.', false), ('C', 'Molt greu.', false), ('D', 'No és infracció de la LO 4/2015.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 39.1 de la LO 4/2015, amb quina multa se sancionen les infraccions molt greus?', 'L''article 39.1 fixa multes de 30.001 a 600.000 euros per a les molt greus, de 601 a 30.000 per a les greus i de 100 a 600 per a les lleus.', 'plcat_t12_seguretat_ciutadana_2', (select id from public.topics where slug = 'plcat-t12-seguretat-ciutadana-2'), 1, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2015-3442'), 'Art. 39.1 LO 4/2015', '1. Las infracciones muy graves se sancionarán con multa de 30.001 a 600.000 euros', null, 'be8d265fd3b683c14bcbe2def71d2b9e85dd24060b421001d9023d1f0b2d2502', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'be8d265fd3b683c14bcbe2def71d2b9e85dd24060b421001d9023d1f0b2d2502')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'De 601 a 30.000 euros.', false), ('B', 'De 10.401 a 300.000 euros.', false), ('C', 'De 30.001 a 1.000.000 d''euros.', false), ('D', 'De 30.001 a 600.000 euros.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'En el procediment sancionador abreujat de la LO 4/2015, quina reducció s''aplica a la multa si l''interessat la paga voluntàriament dins del termini, segons l''article 54.3?', 'L''article 54.3 preveu que el pagament voluntari dins de quinze dies comporta la reducció del 50 % de la multa, la renúncia a formular al·legacions i l''acabament del procediment.', 'plcat_t12_seguretat_ciutadana_2', (select id from public.topics where slug = 'plcat-t12-seguretat-ciutadana-2'), 1, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2015-3442'), 'Art. 54.3 LO 4/2015', 'a) La reducción del 50 por ciento del importe de la sanción de multa.', null, 'e3ff453d5d0580e87bfeb9920424f4d15819485b7d22332f481daca306ecce4b', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'e3ff453d5d0580e87bfeb9920424f4d15819485b7d22332f481daca306ecce4b')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Un 25 per cent.', false), ('B', 'Un 30 per cent.', false), ('C', 'Un 50 per cent.', true), ('D', 'Un 75 per cent.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'En l''àmbit de l''Administració General de l''Estat, quin òrgan és competent per sancionar les infraccions greus i lleus de la LO 4/2015, segons l''article 32.1?', 'L''article 32.1 atribueix al ministre de l''Interior les molt greus en grau màxim, al secretari d''Estat de Seguretat les molt greus en grau mitjà i mínim, i als delegats del Govern les greus i lleus.', 'plcat_t12_seguretat_ciutadana_2', (select id from public.topics where slug = 'plcat-t12-seguretat-ciutadana-2'), 2, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2015-3442'), 'Art. 32.1 LO 4/2015', 'c) Los Delegados del Gobierno en las comunidades autónomas y en las Ciudades de Ceuta y Melilla, para la sanción de las infracciones graves y leves.', null, '058957bd27c0f6c4bfa911af53739b0a5c4be197a2af796ef562ceec6eb980e7', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '058957bd27c0f6c4bfa911af53739b0a5c4be197a2af796ef562ceec6eb980e7')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Els delegats del Govern a les comunitats autònomes i a les ciutats de Ceuta i Melilla.', true), ('B', 'El ministre de l''Interior.', false), ('C', 'El secretari d''Estat de Seguretat.', false), ('D', 'Els directors generals de la Policia i de la Guàrdia Civil.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 52 de la LO 4/2015, quin valor tenen en el procediment sancionador les denúncies, atestats o actes dels agents de l''autoritat que han presenciat els fets?', 'L''article 52 dona a les denúncies, atestats o actes dels agents que han presenciat els fets el valor de base suficient per resoldre, llevat de prova en contra, amb ratificació prèvia si el denunciat els nega i sens perjudici d''aportar tots els elements probatoris disponibles.', 'plcat_t12_seguretat_ciutadana_2', (select id from public.topics where slug = 'plcat-t12-seguretat-ciutadana-2'), 2, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2015-3442'), 'Art. 52 LO 4/2015', 'las denuncias, atestados o actas formulados por los agentes de la autoridad en ejercicio de sus funciones que hubiesen presenciado los hechos, previa ratificación en el caso de haber sido negados por los denunciados, constituirán base suficiente para adoptar la resolución que proceda, salvo prueba en contrario', null, '6c414f705974b9d98a9385589b43c6f81cacd796101d24893163a0651d478ec0', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '6c414f705974b9d98a9385589b43c6f81cacd796101d24893163a0651d478ec0')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Tenen valor de prova plena que no admet prova en contra.', false), ('B', 'Constitueixen base suficient per adoptar la resolució que correspongui, llevat de prova en contra i amb ratificació prèvia si el denunciat els nega.', true), ('C', 'Són un simple indici que sempre requereix la declaració d''un testimoni independent.', false), ('D', 'No tenen cap valor si l''agent no aporta una gravació en vídeo dels fets.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 23.3 de la LO 4/2015, en quin cas les forces i cossos de seguretat poden dissoldre una reunió o manifestació sense avís previ?', 'L''article 23.3 exigeix, com a regla general, avisar prèviament les persones afectades, però permet dissoldre sense avís previ quan hi ha una alteració de la seguretat ciutadana amb armes, explosius o objectes contundents o perillosos.', 'plcat_t12_seguretat_ciutadana_2', (select id from public.topics where slug = 'plcat-t12-seguretat-ciutadana-2'), 2, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2015-3442'), 'Art. 23.3 LO 4/2015', 'En caso de que se produzca una alteración de la seguridad ciudadana con armas, artefactos explosivos u objetos contundentes o de cualquier otro modo peligrosos, las Fuerzas y Cuerpos de Seguridad podrán disolver la reunión o manifestación o retirar los vehículos y obstáculos sin necesidad de previo aviso.', null, 'e9e9e6d9d604fed7351bcfbd9ffd1ecd14cf305dadaf3b46fb0b87d6b735c969', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'e9e9e6d9d604fed7351bcfbd9ffd1ecd14cf305dadaf3b46fb0b87d6b735c969')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Sempre que la reunió no hagi estat comunicada prèviament.', false), ('B', 'Quan els participants superen el nombre previst a la comunicació.', false), ('C', 'Quan es produeix una alteració de la seguretat ciutadana amb armes, artefactes explosius o objectes contundents o perillosos d''una altra manera.', true), ('D', 'Quan la manifestació es fa fora de l''horari comunicat.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'A l''efecte de la LO 4/2015, qui es consideren organitzadors o promotors d''una reunió en un lloc de trànsit públic o d''una manifestació, segons l''article 30.3?', 'L''article 30.3 considera organitzadors o promotors els qui han subscrit la comunicació preceptiva i, encara que no l''hagin subscrit, els qui de fet presideixin, dirigeixin o exerceixin actes semblants, o que raonablement se''n puguin considerar directors.', 'plcat_t12_seguretat_ciutadana_2', (select id from public.topics where slug = 'plcat-t12-seguretat-ciutadana-2'), 2, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2015-3442'), 'Art. 30.3 LO 4/2015', 'se considerarán organizadores o promotores de las reuniones en lugares de tránsito público o manifestaciones las personas físicas o jurídicas que hayan suscrito la preceptiva comunicación. Asimismo, aun no habiendo suscrito o presentado la comunicación, también se considerarán organizadores o promotores quienes de hecho las presidan, dirijan o ejerzan actos semejantes', null, '94268604d538ac2ef41ce57aaa9dcf367deb163a5186fff49932ae95162b98d2', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '94268604d538ac2ef41ce57aaa9dcf367deb163a5186fff49932ae95162b98d2')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Només les persones jurídiques que han presentat la comunicació.', false), ('B', 'Les persones que han subscrit la comunicació preceptiva i també els qui de fet la presideixen, dirigeixen o hi exerceixen actes semblants.', true), ('C', 'Tots els assistents a la reunió o manifestació.', false), ('D', 'Només el primer signant de la comunicació, en exclusiva.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 40.1 de la LO 4/2015, en quin termini prescriuen les sancions imposades per infraccions molt greus?', 'L''article 40.1 fixa la prescripció de les sancions en tres anys (molt greus), dos anys (greus) i un any (lleus), comptats des de l''endemà de la fermesa en via administrativa. Les infraccions prescriuen en dos anys, un any i sis mesos (art. 38.1).', 'plcat_t12_seguretat_ciutadana_2', (select id from public.topics where slug = 'plcat-t12-seguretat-ciutadana-2'), 2, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2015-3442'), 'Art. 40.1 LO 4/2015', '1. Las sanciones impuestas por infracciones muy graves prescribirán a los tres años, las impuestas por infracciones graves, a los dos años, y las impuestas por infracciones leves al año, computados desde el día siguiente a aquel en que adquiera firmeza en vía administrativa la resolución por la que se impone la sanción.', null, '84fa9167cde094c5017f79786daeef0553cbf5c635f45e4a45619a1b71c85b34', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '84fa9167cde094c5017f79786daeef0553cbf5c635f45e4a45619a1b71c85b34')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Als dos anys, des de la comissió de la infracció.', false), ('B', 'Als cinc anys, des de la notificació de la sanció.', false), ('C', 'A l''any, des de l''endemà de la fermesa de la resolució.', false), ('D', 'Als tres anys, des de l''endemà que la resolució sancionadora adquireixi fermesa en via administrativa.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 50.1 de la LO 4/2015, quan caduca el procediment sancionador?', 'L''article 50.1 fixa la caducitat en un any des de la incoació sense notificació de la resolució, tenint en compte les paralitzacions imputables a l''interessat o la suspensió per procediment penal. Els procediments caducats no interrompen la prescripció (art. 50.2).', 'plcat_t12_seguretat_ciutadana_2', (select id from public.topics where slug = 'plcat-t12-seguretat-ciutadana-2'), 2, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2015-3442'), 'Art. 50.1 LO 4/2015', '1. El procedimiento caducará transcurrido un año desde su incoación sin que se haya notificado la resolución', null, '6cc6fb79feab15a6f9b8e4473903cb3c8181d3543bcb765a2b364f3bc37a695d', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '6cc6fb79feab15a6f9b8e4473903cb3c8181d3543bcb765a2b364f3bc37a695d')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Quan transcorre un any des de la incoació sense que s''hagi notificat la resolució.', true), ('B', 'Quan transcorren sis mesos des de la incoació sense que s''hagi notificat la resolució.', false), ('C', 'Quan transcorren tres mesos des de la comissió dels fets.', false), ('D', 'Quan transcorren dos anys des de la notificació de l''acord d''incoació.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Un cop notificat l''acord d''incoació d''un procediment per una infracció greu o lleu de la LO 4/2015, de quin termini disposa l''interessat per fer el pagament voluntari amb reducció o formular al·legacions, segons l''article 54.1?', 'L''article 54.1 dona quinze dies per pagar voluntàriament amb reducció (procediment abreujat) o per formular al·legacions (procediment ordinari). L''abreujat no s''aplica a les infraccions molt greus (art. 54.2).', 'plcat_t12_seguretat_ciutadana_2', (select id from public.topics where slug = 'plcat-t12-seguretat-ciutadana-2'), 2, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2015-3442'), 'Art. 54.1 LO 4/2015', 'el interesado dispondrá de un plazo de quince días para realizar el pago voluntario con reducción de la sanción de multa, o para formular las alegaciones y proponer o aportar las pruebas que estime oportunas.', null, '34999f910439ffc6bef593d7e5fbca05b0a0897b903d1b97faf2fa0b53f3e405', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '34999f910439ffc6bef593d7e5fbca05b0a0897b903d1b97faf2fa0b53f3e405')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Deu dies.', false), ('B', 'Vint dies.', false), ('C', 'Quinze dies.', true), ('D', 'Un mes.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 45.1 de la LO 4/2015, no es poden sancionar els fets que ja hagin estat sancionats penalment o administrativament quan s''aprecia identitat de:', 'L''article 45.1 recull el principi non bis in idem: no es poden sancionar fets ja sancionats penalment o administrativament si hi ha identitat de subjecte, fet i fonament.', 'plcat_t12_seguretat_ciutadana_2', (select id from public.topics where slug = 'plcat-t12-seguretat-ciutadana-2'), 2, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2015-3442'), 'Art. 45.1 LO 4/2015', '1. No podrán sancionarse los hechos que hayan sido sancionados penal o administrativamente cuando se aprecie identidad de sujeto, de hecho y de fundamento.', null, 'd789aabc2e69db0ac31d71ec2e87faa619c51212fe2e03eeb994e5b6229a50d8', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'd789aabc2e69db0ac31d71ec2e87faa619c51212fe2e03eeb994e5b6229a50d8')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Subjecte, lloc i data.', false), ('B', 'Subjecte, fet i fonament.', true), ('C', 'Fet, autoritat i procediment.', false), ('D', 'Subjecte, sanció i òrgan sancionador.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 27.2 de la LO 4/2015, les autoritats poden prohibir o, si ja s''estan celebrant, suspendre els espectacles i activitats recreatives:', 'L''article 27.2 permet prohibir o suspendre espectacles i activitats recreatives quan hi ha un perill cert per a persones i béns o es produeixen o preveuen alteracions greus de la seguretat ciutadana.', 'plcat_t12_seguretat_ciutadana_2', (select id from public.topics where slug = 'plcat-t12-seguretat-ciutadana-2'), 2, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2015-3442'), 'Art. 27.2 LO 4/2015', 'En particular, podrán prohibir y, en caso de estar celebrándose, suspender los espectáculos y actividades recreativas cuando exista un peligro cierto para personas y bienes, o acaecieran o se previeran graves alteraciones de la seguridad ciudadana.', null, 'b9579e7288748cb75957c707f39c8644da405749884ca50bde8b70db21bf18bf', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'b9579e7288748cb75957c707f39c8644da405749884ca50bde8b70db21bf18bf')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Sempre que ho demanin els veïns afectats per sorolls.', false), ('B', 'Només amb autorització judicial prèvia.', false), ('C', 'Només si l''organitzador no ha pagat les taxes municipals.', false), ('D', 'Quan hi ha un perill cert per a persones i béns o s''hi produeixen o es preveuen alteracions greus de la seguretat ciutadana.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 31.2 de la LO 4/2015, quan un sol fet constitueix dues o més infraccions, o quan una és el mitjà necessari per cometre l''altra, la conducta se sanciona:', 'L''article 31.2 estableix que en el concurs d''infraccions (un sol fet o infracció mitjà per a una altra) s''aplica la infracció que comporta més sanció; l''article 31.1 fixa les regles d''especialitat, consumpció i alternativitat.', 'plcat_t12_seguretat_ciutadana_2', (select id from public.topics where slug = 'plcat-t12-seguretat-ciutadana-2'), 3, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2015-3442'), 'Art. 31.2 LO 4/2015', '2. En el caso de que un solo hecho constituya dos o más infracciones, o cuando una de ellas sea medio necesario para cometer la otra, la conducta será sancionada por aquella infracción que aplique una mayor sanción.', null, 'f7f7ff3b51b36fb3829ee1d19d92c5ac6c372bdf039cad8bd9b8b8c37ec61802', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'f7f7ff3b51b36fb3829ee1d19d92c5ac6c372bdf039cad8bd9b8b8c37ec61802')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Per la infracció que aplica una sanció més gran.', true), ('B', 'Per totes les infraccions, sumant-ne les multes.', false), ('C', 'Per la infracció que aplica la sanció menor.', false), ('D', 'Per la infracció comesa en primer lloc.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 43.3 de la LO 4/2015, quan es cancel·len d''ofici els assentaments del Registre Central d''Infraccions contra la Seguretat Ciutadana corresponents a infraccions greus?', 'L''article 43.3 fixa la cancel·lació d''ofici als tres anys (molt greus), dos anys (greus) i un any (lleus) des de la fermesa de la sanció. El Registre serveix exclusivament per apreciar la reincidència (art. 43.1).', 'plcat_t12_seguretat_ciutadana_2', (select id from public.topics where slug = 'plcat-t12-seguretat-ciutadana-2'), 3, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2015-3442'), 'Art. 43.3 LO 4/2015', 'Los asientos se cancelarán de oficio transcurridos tres años cuando se trate de infracciones muy graves, dos años en el caso de infracciones graves y uno en el de infracciones leves, a contar desde la firmeza de la sanción.', null, '4856c292637c4029b6a2970047aab7181fe06bb7731b8feb7d3e8061d4ff6d76', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '4856c292637c4029b6a2970047aab7181fe06bb7731b8feb7d3e8061d4ff6d76')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Transcorreguts dos anys des de la fermesa de la sanció.', true), ('B', 'Transcorreguts tres anys des de la fermesa de la sanció.', false), ('C', 'Transcorregut un any des de la comissió de la infracció.', false), ('D', 'Transcorreguts cinc anys des del pagament de la multa.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Quan, excepcionalment, els agents de l''autoritat adopten directament mesures provisionals abans d''iniciar el procediment sancionador per un risc greu o un perill imminent, en quin termini màxim s''han de ratificar, modificar o revocar en l''acord d''incoació, segons l''article 47.2 de la LO 4/2015?', 'L''article 47.2 permet als agents adoptar les mesures provisionals de l''article 49.1 (llevat de la lletra f) en casos de risc greu o perill imminent, i obliga a ratificar-les, modificar-les o revocar-les en l''acord d''incoació en quinze dies com a màxim; si no, queden sense efecte.', 'plcat_t12_seguretat_ciutadana_2', (select id from public.topics where slug = 'plcat-t12-seguretat-ciutadana-2'), 3, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2015-3442'), 'Art. 47.2 LO 4/2015', 'debiendo ser ratificadas, modificadas o revocadas en el acuerdo de incoación en el plazo máximo de quince días.', null, '66780a201434531e29ed35b87783d05cf2ddeb4626ac5dd02467b9b55d51a37b', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '66780a201434531e29ed35b87783d05cf2ddeb4626ac5dd02467b9b55d51a37b')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Quaranta-vuit hores.', false), ('B', 'Deu dies.', false), ('C', 'Quinze dies.', true), ('D', 'Un mes.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 42.3 de la LO 4/2015, quan l''autor dels fets és un menor de divuit anys no emancipat, qui respon dels danys i perjudicis ocasionats?', 'L''article 42.3 fa respondre solidàriament amb el menor no emancipat (o la persona amb capacitat modificada judicialment) els pares, tutors, curadors, acollidors o guardadors; a més, la responsabilitat civil és sempre solidària entre tots els causants (art. 42.2).', 'plcat_t12_seguretat_ciutadana_2', (select id from public.topics where slug = 'plcat-t12-seguretat-ciutadana-2'), 3, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2015-3442'), 'Art. 42.3 LO 4/2015', '3. Cuando sea declarado autor de los hechos cometidos un menor de dieciocho años no emancipado o una persona con la capacidad modificada judicialmente, responderán, solidariamente con él, de los daños y perjuicios ocasionados sus padres, tutores, curadores, acogedores o guardadores legales o de hecho, según proceda.', null, '3a3cafabd2ff226d4cb8d1261dc4e7ee4166e05b68513b5c3167fd04e73e1a29', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '3a3cafabd2ff226d4cb8d1261dc4e7ee4166e05b68513b5c3167fd04e73e1a29')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Només el menor, quan arribi a la majoria d''edat.', false), ('B', 'Solidàriament amb el menor, els seus pares, tutors, curadors, acollidors o guardadors legals o de fet, segons escaigui.', true), ('C', 'Subsidiàriament, l''Administració que hagi imposat la sanció.', false), ('D', 'Només els pares, i el menor queda exempt de tota responsabilitat civil.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 49.3 de la LO 4/2015, quina durada màxima poden tenir, com a regla general, les mesures de caràcter provisional adoptades en el procediment sancionador?', 'L''article 49.3 limita la durada de les mesures provisionals a la meitat del termini previst per a la sanció que correspongui, llevat d''acord degudament motivat de l''òrgan competent. Les mesures no poden tenir caràcter sancionador (art. 49.1).', 'plcat_t12_seguretat_ciutadana_2', (select id from public.topics where slug = 'plcat-t12-seguretat-ciutadana-2'), 3, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2015-3442'), 'Art. 49.3 LO 4/2015', '3. La duración de las medidas de carácter provisional no podrá exceder de la mitad del plazo previsto en esta Ley para la sanción que pudiera corresponder a la infracción cometida, salvo acuerdo debidamente motivado adoptado por el órgano competente.', null, 'cbaff53a65ac76a9386523a33bfd507addde23af93eebcfa510ac262a12b856a', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'cbaff53a65ac76a9386523a33bfd507addde23af93eebcfa510ac262a12b856a')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El mateix termini previst per a la sanció que pugui correspondre.', false), ('B', 'Sis mesos en tots els casos.', false), ('C', 'Un terç del termini de prescripció de la infracció.', false), ('D', 'La meitat del termini previst a la llei per a la sanció que pugui correspondre a la infracció.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
-- Lote plcat-t13-policia-judicial-detencio-lecrim-v1 (20 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Real Decreto de 14 de septiembre de 1882, Ley de Enjuiciamiento Criminal (texto consolidado, BOE)', 'https://www.boe.es/buscar/act.php?id=BOE-A-1882-6036', 'boe'::public.source_kind, 'Agencia Estatal Boletín Oficial del Estado', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('plcat-t13-policia-judicial-detencio', 'Tema 13. La Llei d''enjudiciament criminal: policia judicial, detenció i drets de la persona detinguda') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('policia-local') and t.slug = 'plcat-t13-policia-judicial-detencio' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 283 de la LECrim, els agents municipals de policia urbana o rural:', 'L''article 283 LECrim inclou, en el número cinquè, els agents municipals de policia urbana o rural entre els qui constitueixen la policia judicial, obligats a seguir les instruccions dels jutges, tribunals i fiscals.', 'plcat_t13_policia_judicial_detencio', (select id from public.topics where slug = 'plcat-t13-policia-judicial-detencio'), 1, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1882-6036'), 'Art. 283 LECrim', 'Constituirán la Policía judicial y serán auxiliares de los Jueces y Tribunales competentes en materia penal y del Ministerio fiscal […] Quinto. Los Serenos, Celadores y cualesquiera otros Agentes municipales de policía urbana o rural.', null, 'd0ec0d18a5a12bfc5d91e260c7c4f37b26b4a903fe0e0e085ed7beba51119acb', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'd0ec0d18a5a12bfc5d91e260c7c4f37b26b4a903fe0e0e085ed7beba51119acb')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'No formen part de la policia judicial en cap cas.', false), ('B', 'Només formen part de la policia judicial quan ho acorda el ple de l''ajuntament.', false), ('C', 'Formen part de la policia judicial com a auxiliars dels jutges i tribunals competents en matèria penal i del Ministeri Fiscal.', true), ('D', 'Formen part de la policia judicial, però a efectes d''investigació només reben instruccions de l''alcalde.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Quin d''aquests col·lectius NO apareix a l''enumeració de l''article 283 de la LECrim com a integrant de la policia judicial?', 'L''article 283 LECrim enumera, entre d''altres, els alcaldes i tinents d''alcalde (3r), els funcionaris del cos especial de presons (7è) i el personal de la Jefatura Central de Trànsit que investiga els accidents (9è); no hi esmenta la seguretat privada.', 'plcat_t13_policia_judicial_detencio', (select id from public.topics where slug = 'plcat-t13-policia-judicial-detencio'), 2, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1882-6036'), 'Art. 283 LECrim', 'Tercero. Los Alcaldes, Tenientes de Alcalde y Alcaldes de barrio. […] Séptimo. Los funcionarios del Cuerpo especial de Prisiones. […] Noveno. El personal dependiente de la Jefatura Central de Tráfico, encargado de la investigación técnica de los accidentes.', null, '506f16f82498157de66c49073e11aca445ead5f40665d6bdad1a5d61961464c0', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '506f16f82498157de66c49073e11aca445ead5f40665d6bdad1a5d61961464c0')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Els alcaldes, tinents d''alcalde i alcaldes de barri.', false), ('B', 'Els funcionaris del cos especial de presons.', false), ('C', 'El personal de la Jefatura Central de Trànsit encarregat de la investigació tècnica dels accidents.', false), ('D', 'Els vigilants de seguretat privada de les empreses autoritzades.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 284.1 de la LECrim, quan els funcionaris de policia judicial tenen coneixement d''un delicte públic, ho han de comunicar a l''autoritat judicial o al Ministeri Fiscal:', 'L''article 284.1 LECrim obliga a participar el delicte immediatament, si es pot fer sense aturar les diligències de prevenció; si no, en acabar-les.', 'plcat_t13_policia_judicial_detencio', (select id from public.topics where slug = 'plcat-t13-policia-judicial-detencio'), 2, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1882-6036'), 'Art. 284.1 LECrim', 'Inmediatamente que los funcionarios de la Policía judicial tuvieren conocimiento de un delito público o fueren requeridos para prevenir la instrucción de diligencias por razón de algún delito privado, lo participarán a la autoridad judicial o al representante del Ministerio Fiscal, si pudieren hacerlo sin cesar en la práctica de las diligencias de prevención. En otro caso, lo harán así que las hubieren terminado.', null, '07cf4399cee96d3f397c5eedfdddf47fcd260a3fb6c2445f758889bdbdfeb709', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '07cf4399cee96d3f397c5eedfdddf47fcd260a3fb6c2445f758889bdbdfeb709')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'En tot cas dins de les setanta-dues hores següents.', false), ('B', 'Immediatament, si ho poden fer sense deixar de practicar les diligències de prevenció; altrament, tan bon punt les hagin acabat.', true), ('C', 'Només quan hagin identificat l''autor dels fets.', false), ('D', 'Únicament si el denunciant ho demana expressament.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 284.2.b) de la LECrim, l''atestat sense autor conegut s''ha de remetre a l''autoritat judicial si s''hi practica alguna diligència, amb algun resultat, un cop transcorregut quant temps des de l''obertura de l''atestat?', 'L''article 284.2.b) LECrim exceptua de la regla de conservació l''atestat en què es practica qualsevol diligència amb resultat després de setanta-dues hores des de la seva obertura.', 'plcat_t13_policia_judicial_detencio', (select id from public.topics where slug = 'plcat-t13-policia-judicial-detencio'), 3, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1882-6036'), 'Art. 284.2.b LECrim', 'b) Que se practique cualquier diligencia después de transcurridas setenta y dos horas desde la apertura del atestado y éstas hayan tenido algún resultado', null, 'efd48ceea4228c5cd91cfc4ff250737a3d75cbc13a2b96d93fb068f1df513fea', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'efd48ceea4228c5cd91cfc4ff250737a3d75cbc13a2b96d93fb068f1df513fea')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Setanta-dues hores.', true), ('B', 'Vint-i-quatre hores.', false), ('C', 'Quaranta-vuit hores.', false), ('D', 'Deu dies.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 284.2 de la LECrim, què ha de comunicar la policia judicial al denunciant d''un delicte sense autor conegut?', 'L''article 284.2 LECrim, d''acord amb l''Estatut de la víctima, obliga a informar el denunciant que sense autor identificat en 72 hores no es remetran les actuacions, però que pot reiterar la denúncia.', 'plcat_t13_policia_judicial_detencio', (select id from public.topics where slug = 'plcat-t13-policia-judicial-detencio'), 2, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1882-6036'), 'Art. 284.2 LECrim', 'la Policía Judicial comunicará al denunciante que en caso de no ser identificado el autor en el plazo de setenta y dos horas, las actuaciones no se remitirán a la autoridad judicial, sin perjuicio de su derecho a reiterar la denuncia ante la fiscalía o el juzgado de instrucción.', null, 'bcb2edd8421044d2269021a4f7d7006030a2ca109a3289c9196b09a123a6e680', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'bcb2edd8421044d2269021a4f7d7006030a2ca109a3289c9196b09a123a6e680')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Que l''atestat s''arxivarà definitivament i ja no podrà reiterar la denúncia.', false), ('B', 'Que, si l''autor no és identificat en setanta-dues hores, les actuacions no es remetran a l''autoritat judicial, sens perjudici del seu dret a reiterar la denúncia davant la fiscalia o el jutjat d''instrucció.', true), ('C', 'Que haurà de ratificar la denúncia davant notari en el termini de deu dies.', false), ('D', 'Que les actuacions es remetran en tot cas al jutjat de guàrdia dins de les vint-i-quatre hores.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 284.3 de la LECrim, la diligència que descriu les armes, els instruments o els efectes recollits relacionats amb el delicte:', 'L''article 284.3 LECrim exigeix una diligència amb el lloc, el temps i l''ocasió de la troballa i una descripció minuciosa, substituïble per reportatge gràfic, signada per qui tenia els objectes.', 'plcat_t13_policia_judicial_detencio', (select id from public.topics where slug = 'plcat-t13-policia-judicial-detencio'), 2, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1882-6036'), 'Art. 284.3 LECrim', 'que podrá ser sustituida por un reportaje gráfico. La diligencia será firmada por la persona en cuyo poder fueren hallados.', null, 'e1f2902fc8efb1081897313ed6daca7747607fcbaedb1a0f5e3a1320c887c1aa', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'e1f2902fc8efb1081897313ed6daca7747607fcbaedb1a0f5e3a1320c887c1aa')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'L''ha de signar en tot cas el jutge d''instrucció, i no es pot substituir per cap altre mitjà de documentació.', false), ('B', 'No es pot substituir mai per fotografies.', false), ('C', 'Només s''estén si el Ministeri Fiscal ho demana.', false), ('D', 'Es pot substituir per un reportatge gràfic i l''ha de signar la persona en poder de la qual s''han trobat.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 285 de la LECrim, si es presenta un funcionari de policia judicial de categoria superior a la del que està actuant, aquest últim:', 'L''article 285 LECrim obliga el funcionari que actua a informar el de categoria superior que hi concorre i a posar-se a la seva disposició.', 'plcat_t13_policia_judicial_detencio', (select id from public.topics where slug = 'plcat-t13-policia-judicial-detencio'), 1, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1882-6036'), 'Art. 285 LECrim', 'Si concurriere algún funcionario de Policía judicial de categoría superior a la del que estuviese actuando, deberá éste darle conocimiento de cuanto hubiese practicado, poniéndose desde luego a su disposición.', null, '69475ffefb75662b3152cb71cfb869fc2cc62fc0106a333a2ca49c0f4514c020', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '69475ffefb75662b3152cb71cfb869fc2cc62fc0106a333a2ca49c0f4514c020')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Li ha de donar coneixement de tot el que ha practicat i posar-se a la seva disposició.', true), ('B', 'Ha de continuar les diligències sense informar-lo.', false), ('C', 'Ha de suspendre immediatament totes les diligències iniciades i esperar que el jutge d''instrucció es personi al lloc dels fets.', false), ('D', 'Ha de demanar autorització al fiscal per continuar actuant.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 286 de la LECrim, quan el jutge d''instrucció es presenta per formar el sumari, les diligències de prevenció que practica la policia:', 'L''article 286 LECrim disposa que, quan el jutge es presenta a formar el sumari, cessen les diligències de prevenció i se li lliuren, amb els efectes i els detinguts.', 'plcat_t13_policia_judicial_detencio', (select id from public.topics where slug = 'plcat-t13-policia-judicial-detencio'), 2, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1882-6036'), 'Art. 286 LECrim', 'cesarán las diligencias de prevención que estuviere practicando cualquier Autoridad o agente de policía; debiendo éstos entregarlas en el acto a dicho Juez, así como los efectos relativos al delito que se hubiesen recogido, y poniendo a su disposición a los detenidos, si los hubiese.', null, '5c26120af891bf13f9c2a30f807c96108674cac83b3d98186ad3d10db0844f66', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '5c26120af891bf13f9c2a30f807c96108674cac83b3d98186ad3d10db0844f66')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Continuen sota la direcció del cap policial fins que s''acabi l''atestat.', false), ('B', 'Passen a dependre del Ministeri Fiscal.', false), ('C', 'Cessen, i la policia les ha de lliurar en l''acte al jutge, juntament amb els efectes recollits i els detinguts, si n''hi ha.', true), ('D', 'Es mantenen vint-i-quatre hores més i després es lliuren al jutge.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 288 de la LECrim, quan el fiscal o el jutge d''instrucció exigeixen un servei a un funcionari de policia judicial i aquest servei admet espera:', 'L''article 288 LECrim permet que fiscal i jutges s''entenguin directament amb la policia judicial, però si el servei admet espera han d''acudir al superior del funcionari.', 'plcat_t13_policia_judicial_detencio', (select id from public.topics where slug = 'plcat-t13-policia-judicial-detencio'), 3, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1882-6036'), 'Art. 288 LECrim', 'pero si el servicio que de ellos exigiesen admitiese espera, deberán acudir al superior respectivo del funcionario de Policía judicial, mientras no necesitasen del inmediato auxilio de éste.', null, '643dd2de3f72c8d731a4657f0cf0be06dad82e99f4c61b72925a59f5a5babee3', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '643dd2de3f72c8d731a4657f0cf0be06dad82e99f4c61b72925a59f5a5babee3')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Es poden adreçar sempre directament al funcionari, sense passar pel superior, perquè la llei no distingeix si el servei admet espera o no.', false), ('B', 'Han d''acudir al superior respectiu del funcionari, mentre no en necessitin l''auxili immediat.', true), ('C', 'Han de sol·licitar-lo al Ministeri de l''Interior.', false), ('D', 'Necessiten l''autorització prèvia de l''alcalde.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 289 de la LECrim, el funcionari de policia judicial que per qualsevol causa no pot complir el requeriment o l''ordre rebuda del jutge d''instrucció:', 'L''article 289 LECrim obliga a comunicar immediatament la impossibilitat a qui va donar l''ordre perquè la faci executar d''una altra manera.', 'plcat_t13_policia_judicial_detencio', (select id from public.topics where slug = 'plcat-t13-policia-judicial-detencio'), 2, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1882-6036'), 'Art. 289 LECrim', 'lo pondrá inmediatamente en conocimiento del que haya hecho el requerimiento o dado la orden para que provea de otro modo a su ejecución.', null, '552adf39d4f4e58dddba25bcdfa3a3d1e3ca5a45f0c89b90f2bb871a3d7ec21b', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '552adf39d4f4e58dddba25bcdfa3a3d1e3ca5a45f0c89b90f2bb871a3d7ec21b')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Queda exempt de fer cap comunicació.', false), ('B', 'Ho ha de comunicar al seu superior jeràrquic en el termini de setanta-dues hores.', false), ('C', 'Ho ha de posar immediatament en coneixement de qui ha fet el requeriment o ha donat l''ordre, perquè en proveeixi l''execució d''una altra manera.', true), ('D', 'N''ha d''encarregar l''execució a un particular.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 293 de la LECrim, l''atestat l''ha de signar:', 'L''article 293 LECrim exigeix la signatura de qui estén l''atestat i convida a signar-lo les persones presents, els pèrits i els testimonis; si no ho fan, se n''ha d''expressar la raó.', 'plcat_t13_policia_judicial_detencio', (select id from public.topics where slug = 'plcat-t13-policia-judicial-detencio'), 1, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1882-6036'), 'Art. 293 LECrim', 'El atestado será firmado por el que lo haya extendido […] Las personas presentes, peritos y testigos que hubieren intervenido en las diligencias relacionadas en el atestado serán invitadas a firmarlo en la parte a ellos referente.', null, '13749782a26875cb6202c640c3ec7ffd4de2bb3062a38fcaf59bac420855adbe', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '13749782a26875cb6202c640c3ec7ffd4de2bb3062a38fcaf59bac420855adbe')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Únicament el cap del cos policial.', false), ('B', 'El jutge d''instrucció i el fiscal.', false), ('C', 'Necessàriament el detingut i el seu advocat.', false), ('D', 'Qui l''ha estès; les persones presents, els pèrits i els testimonis que hi han intervingut són convidats a signar-lo en la part que els afecta.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 294 de la LECrim, si el funcionari a qui correspon redactar l''atestat no el pot redactar:', 'L''article 294 LECrim preveu la relació verbal circumstanciada, que el fiscal o el jutge posa per escrit, fent constar el motiu de no haver redactat l''atestat en la forma ordinària.', 'plcat_t13_policia_judicial_detencio', (select id from public.topics where slug = 'plcat-t13-policia-judicial-detencio'), 3, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1882-6036'), 'Art. 294 LECrim', 'se sustituirá por una relación verbal circunstanciada, que reducirá a escrito de un modo fehaciente el funcionario del Ministerio fiscal, el Juez de instrucción o el municipal a quien deba presentarse el atestado', null, 'a0aa5989389643bb69d93362f797b7948e3d19d4373d0acc53854d88e3f6e3e2', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'a0aa5989389643bb69d93362f797b7948e3d19d4373d0acc53854d88e3f6e3e2')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Se substitueix per una relació verbal circumstanciada, que el fiscal o el jutge a qui s''ha de presentar redueix a escrit de manera fefaent.', true), ('B', 'L''ha de redactar un dels testimonis presencials.', false), ('C', 'No cal estendre cap atestat.', false), ('D', 'L''ha de redactar l''advocat del detingut.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 295 de la LECrim, si no mereix la qualificació de delicte, la infracció de l''obligació de no deixar passar més de vint-i-quatre hores sense donar coneixement de les diligències es considera, a efectes disciplinaris:', 'L''article 295 LECrim castiga la superació de les 24 hores amb multa i la considera falta greu la primera vegada i molt greu les següents.', 'plcat_t13_policia_judicial_detencio', (select id from public.topics where slug = 'plcat-t13-policia-judicial-detencio'), 3, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1882-6036'), 'Art. 295 LECrim', 'al propio tiempo será considerada dicha infracción como falta grave la primera vez y como falta muy grave las siguientes.', null, '709a355f49a202c89d6073fe192f78bdd503bc8660153da6e0e9ebd2beb026bd', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '709a355f49a202c89d6073fe192f78bdd503bc8660153da6e0e9ebd2beb026bd')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Falta greu la primera vegada i falta molt greu les següents.', true), ('B', 'Falta lleu la primera vegada, greu les dues següents i molt greu les restants.', false), ('C', 'Falta molt greu sempre.', false), ('D', 'Falta lleu sempre.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 296 de la LECrim, quan la policia judicial ha practicat diligències per ordre o requeriment de l''autoritat judicial o del Ministeri Fiscal, n''ha de comunicar el resultat:', 'L''article 296 LECrim remet als terminis que fixi la mateixa ordre o requeriment.', 'plcat_t13_policia_judicial_detencio', (select id from public.topics where slug = 'plcat-t13-policia-judicial-detencio'), 2, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1882-6036'), 'Art. 296 LECrim', 'Cuando hubieren practicado diligencias por orden o requerimiento de la Autoridad judicial o del Ministerio fiscal, comunicarán el resultado obtenido en los plazos que en la orden o en el requerimiento se hubiesen fijado.', null, 'd89dd5b49dbc1c2a3e5dc80ebcb38ce27cd2fdb6222e219ba16fef5d371dbcf3', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'd89dd5b49dbc1c2a3e5dc80ebcb38ce27cd2fdb6222e219ba16fef5d371dbcf3')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Sempre dins de les setanta-dues hores següents a la recepció de l''ordre, amb independència del que s''hi indiqui.', false), ('B', 'Quan s''acabi la instrucció.', false), ('C', 'En el termini d''un mes.', false), ('D', 'En els terminis fixats en l''ordre o en el requeriment.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 297 de la LECrim, les altres declaracions que presten els funcionaris de policia judicial, diferents de l''atestat, han de ser signades i tenen el valor de:', 'L''article 297 LECrim atribueix a l''atestat valor de denúncia, i a les altres declaracions signades dels funcionaris, valor de declaració testifical sobre fets de coneixement propi.', 'plcat_t13_policia_judicial_detencio', (select id from public.topics where slug = 'plcat-t13-policia-judicial-detencio'), 2, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1882-6036'), 'Art. 297 LECrim', 'Las demás declaraciones que prestaren deberán ser firmadas, y tendrán el valor de declaraciones testificales en cuanto se refieran a hechos de conocimiento propio.', null, 'a4d8ca8f217a905bed94518fdbe5b65975b1a16f6d766da6f60bfdef3ef644bc', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'a4d8ca8f217a905bed94518fdbe5b65975b1a16f6d766da6f60bfdef3ef644bc')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Prova pericial.', false), ('B', 'Document públic amb valor de prova plena, que vincula el jutge o tribunal en la valoració dels fets.', false), ('C', 'Declaracions testificals, en tant que es refereixin a fets de coneixement propi.', true), ('D', 'Simple denúncia.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 298 de la LECrim, amb quina periodicitat els jutges d''instrucció i els fiscals comuniquen als superiors dels funcionaris de policia judicial la qualificació raonada del seu comportament?', 'L''article 298 LECrim preveu un registre reservat del comportament dels funcionaris i una comunicació semestral de la qualificació als seus superiors.', 'plcat_t13_policia_judicial_detencio', (select id from public.topics where slug = 'plcat-t13-policia-judicial-detencio'), 3, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1882-6036'), 'Art. 298 LECrim', 'cada semestre, con referencia a dicho registro, comunicarán a los superiores de cada uno de aquéllos, para los efectos a que hubiere lugar, la calificación razonada de su comportamiento.', null, '3d4edbc43ad958256e80df4a52adf59aa57871e2edaef2134405853edccd706c', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '3d4edbc43ad958256e80df4a52adf59aa57871e2edaef2134405853edccd706c')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Cada any.', false), ('B', 'Cada semestre.', true), ('C', 'Cada trimestre.', false), ('D', 'Cada mes.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 491 de la LECrim, el particular que deté una altra persona, si aquesta ho exigeix, ha de justificar:', 'L''article 491 LECrim obliga el particular que deté a justificar, si el detingut ho exigeix, que tenia motius racionalment suficients.', 'plcat_t13_policia_judicial_detencio', (select id from public.topics where slug = 'plcat-t13-policia-judicial-detencio'), 1, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1882-6036'), 'Art. 491 LECrim', 'El particular que detuviere a otro justificará, si éste lo exigiere, haber obrado en virtud de motivos racionalmente suficientes para creer que el detenido se hallaba comprendido en alguno de los casos del artículo anterior.', null, '093814d6eec089f38df5b6de82d7a13a590a345de0bfa11d4660003297bbd60a', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '093814d6eec089f38df5b6de82d7a13a590a345de0bfa11d4660003297bbd60a')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Que té llicència d''armes.', false), ('B', 'Que ha actuat en virtut de motius racionalment suficients per creure que el detingut es trobava en algun dels casos de l''article 490.', true), ('C', 'Que és agent de l''autoritat.', false), ('D', 'Que disposa d''una autorització judicial prèvia.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 493 de la LECrim, quan l''agent de policia judicial no deté un delinqüent perquè no es troba en cap dels casos de l''article 492, ha de:', 'L''article 493 LECrim obliga a prendre nota de les dades d''identificació de qui no és detingut i a lliurar-la oportunament al jutge o tribunal de la causa.', 'plcat_t13_policia_judicial_detencio', (select id from public.topics where slug = 'plcat-t13-policia-judicial-detencio'), 1, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1882-6036'), 'Art. 493 LECrim', 'La Autoridad o agente de Policía judicial tomará nota del nombre, apellido, domicilio y demás circunstancias bastantes para la averiguación e identificación de la persona del procesado o del delincuente […] Esta nota será oportunamente entregada al Juez o Tribunal que conozca o deba conocer de la causa.', null, '477dbed51fcb4cb605f074844c63bed9c973b2da97f64035b5571a59cb46c69c', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '477dbed51fcb4cb605f074844c63bed9c973b2da97f64035b5571a59cb46c69c')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Deixar-lo marxar sense fer cap actuació.', false), ('B', 'Retenir-lo fins a vint-i-quatre hores.', false), ('C', 'Exigir-li en tot cas una fiança.', false), ('D', 'Prendre nota del nom, el cognom, el domicili i altres circumstàncies per identificar-lo, i lliurar la nota al jutge o tribunal.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 497 de la LECrim, el jutge o tribunal propi de la causa al qual es lliura el detingut ha d''elevar la detenció a presó o deixar-la sense efecte en el termini de:', 'L''article 497 LECrim fixa setanta-dues hores, comptades des del lliurament del detingut, perquè el jutge elevi la detenció a presó o la deixi sense efecte.', 'plcat_t13_policia_judicial_detencio', (select id from public.topics where slug = 'plcat-t13-policia-judicial-detencio'), 2, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1882-6036'), 'Art. 497 LECrim', 'elevará la detención a prisión, o la dejará sin efecto, en el término de setenta y dos horas, a contar desde que el detenido le hubiese sido entregado.', null, '3e3848f855453b073dc767f61eb5abac395edcab51aeb83471a375153e887f69', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '3e3848f855453b073dc767f61eb5abac395edcab51aeb83471a375153e887f69')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Setanta-dues hores des que li ha estat lliurat el detingut.', true), ('B', 'Vint-i-quatre hores des de la detenció.', false), ('C', 'Quaranta-vuit hores des de la detenció.', false), ('D', 'Cinc dies hàbils comptats des de l''endemà del lliurament del detingut al jutjat.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 520.2.h) de la LECrim, el detingut estranger que no comprèn o no parla el castellà o la llengua oficial de l''actuació té dret a:', 'L''article 520.2.h) LECrim reconeix el dret a intèrpret gratuït a l''estranger que no entén la llengua i a les persones sordes o amb dificultats del llenguatge.', 'plcat_t13_policia_judicial_detencio', (select id from public.topics where slug = 'plcat-t13-policia-judicial-detencio'), 1, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1882-6036'), 'Art. 520.2.h LECrim', 'h) Derecho a ser asistido gratuitamente por un intérprete, cuando se trate de extranjero que no comprenda o no hable el castellano o la lengua oficial de la actuación de que se trate', null, 'd5ed76a48c918d8254d219688bfb69cc87310392c0d4235409c11640cebdecd6', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'd5ed76a48c918d8254d219688bfb69cc87310392c0d4235409c11640cebdecd6')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Ser assistit per un intèrpret, però amb les despeses al seu càrrec si no acredita insuficiència de recursos.', false), ('B', 'Ser posat en llibertat immediatament.', false), ('C', 'Ser assistit gratuïtament per un intèrpret.', true), ('D', 'Declarar només per escrit.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
-- Lote plcat-t14-entrada-registre-habeas-corpus-ce-v1 (1 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Constitución Española (texto consolidado, BOE)', 'https://www.boe.es/buscar/act.php?id=BOE-A-1978-31229', 'boe'::public.source_kind, 'Agencia Estatal Boletín Oficial del Estado', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('plcat-t14-entrada-registre-habeas-corpus', 'Tema 14. Entrada i registre en lloc tancat i procediment d''habeas corpus') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('policia-local') and t.slug = 'plcat-t14-entrada-registre-habeas-corpus' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 18.2 de la Constitució, sense consentiment del titular ni resolució judicial, només es pot entrar o registrar un domicili en cas de:', 'L''article 18.2 CE declara inviolable el domicili i només admet l''entrada o el registre amb consentiment del titular, resolució judicial o en cas de flagrant delicte.', 'plcat_t14_entrada_registre_habeas_corpus', (select id from public.topics where slug = 'plcat-t14-entrada-registre-habeas-corpus'), 1, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1978-31229'), 'Art. 18.2 CE', 'El domicilio es inviolable. Ninguna entrada o registro podrá hacerse en él sin consentimiento del titular o resolución judicial, salvo en caso de flagrante delito.', null, '64fdb7b866503a0787ebd70df3b0278125fac380261cceb377630d21ca923b58', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '64fdb7b866503a0787ebd70df3b0278125fac380261cceb377630d21ca923b58')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Denúncia anònima.', false), ('B', 'Flagrant delicte.', true), ('C', 'Ordre de l''alcalde.', false), ('D', 'Requeriment del Ministeri Fiscal.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
-- Lote plcat-t14-entrada-registre-habeas-corpus-lecrim-v1 (14 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Real Decreto de 14 de septiembre de 1882, Ley de Enjuiciamiento Criminal (texto consolidado, BOE)', 'https://www.boe.es/buscar/act.php?id=BOE-A-1882-6036', 'boe'::public.source_kind, 'Agencia Estatal Boletín Oficial del Estado', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('plcat-t14-entrada-registre-habeas-corpus', 'Tema 14. Entrada i registre en lloc tancat i procediment d''habeas corpus') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('policia-local') and t.slug = 'plcat-t14-entrada-registre-habeas-corpus' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 546 de la LECrim, el jutge o tribunal que coneix de la causa pot decretar l''entrada i registre en els edificis i llocs públics:', 'L''article 546 LECrim permet decretar l''entrada i registre en edificis i llocs públics, de dia o de nit i en qualsevol territori, si hi ha indicis de trobar-hi el processat, efectes, instruments o altres objectes útils per a la causa.', 'plcat_t14_entrada_registre_habeas_corpus', (select id from public.topics where slug = 'plcat-t14-entrada-registre-habeas-corpus'), 2, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1882-6036'), 'Art. 546 LECrim', 'El Juez o Tribunal que conociere de la causa podrá decretar la entrada y registro, de día o de noche, en todos los edificios y lugares públicos, sea cualquiera el territorio en que radiquen, cuando hubiere indicios de encontrarse allí el procesado o efectos o instrumentos del delito', null, 'ef671db07920dd8e71680b42cd99219f8c21fd0a89c4133f67956e4a2f7b7d55', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'ef671db07920dd8e71680b42cd99219f8c21fd0a89c4133f67956e4a2f7b7d55')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Només de dia i dins del seu partit judicial.', false), ('B', 'Només amb el consentiment del responsable de l''edifici.', false), ('C', 'Només si el Ministeri Fiscal ho sol·licita per escrit.', false), ('D', 'De dia o de nit, sigui quin sigui el territori on es troben, quan hi hagi indicis que s''hi troba el processat o efectes o instruments del delicte.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 547 de la LECrim, un edifici destinat a un servei oficial del municipi en el qual viu l''encarregat de custodiar-lo es reputa, a l''efecte de l''entrada i registre:', 'L''article 547.1r LECrim reputa públics els edificis destinats a servei oficial de l''Estat, la província o el municipi, encara que hi habitin els encarregats del servei o de la custòdia.', 'plcat_t14_entrada_registre_habeas_corpus', (select id from public.topics where slug = 'plcat-t14-entrada-registre-habeas-corpus'), 2, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1882-6036'), 'Art. 547 LECrim', '1.º Los que estuvieren destinados a cualquier servicio oficial, militar o civil del Estado, de la Provincia o del Municipio, aunque habiten allí los encargados de dicho servicio o los de la conservación y custodia del edificio o lugar.', null, '1eda535f9760dcae9aabbb0aa31c883c2528fed9a9fa601d6e91eec345a36bb7', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '1eda535f9760dcae9aabbb0aa31c883c2528fed9a9fa601d6e91eec345a36bb7')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Edifici o lloc públic, encara que hi visqui l''encarregat de la custòdia.', true), ('B', 'Domicili de l''encarregat en tot cas.', false), ('C', 'Domicili de l''encarregat només durant la nit.', false), ('D', 'Lloc privat, de manera que per entrar-hi cal el consentiment previ de l''alcalde o del regidor responsable del servei.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 547 de la LECrim, un establiment de reunió o d''esbarjo, a l''efecte de l''entrada i registre, es reputa:', 'L''article 547.2n LECrim considera llocs públics els destinats a qualsevol establiment de reunió o esbarjo, siguin lícits o no.', 'plcat_t14_entrada_registre_habeas_corpus', (select id from public.topics where slug = 'plcat-t14-entrada-registre-habeas-corpus'), 1, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1882-6036'), 'Art. 547 LECrim', '2.º Los que estuvieren destinados a cualquier establecimiento de reunión o recreo, fueren o no lícitos.', null, 'd816170d4024a54458a9bbc7f1259f1ec775a9d93bb1d7a6bb65e77b78fa5ab9', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'd816170d4024a54458a9bbc7f1259f1ec775a9d93bb1d7a6bb65e77b78fa5ab9')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Domicili del titular de l''establiment.', false), ('B', 'Lloc públic només si disposa de llicència municipal d''activitat; si és il·lícit, es reputa domicili del titular.', false), ('C', 'Edifici o lloc públic, tant si és lícit com si no ho és.', true), ('D', 'Domicili, si el titular hi resideix.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 548 de la LECrim, per a l''entrada i registre al palau de qualsevol de les cambres legislatives (cossos colegisladors), el jutge necessita:', 'L''article 548 LECrim exigeix l''autorització del president de la cambra corresponent.', 'plcat_t14_entrada_registre_habeas_corpus', (select id from public.topics where slug = 'plcat-t14-entrada-registre-habeas-corpus'), 2, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1882-6036'), 'Art. 548 LECrim', 'El Juez necesitará para la entrada y registro en el Palacio de cualquiera de los Cuerpos Colegisladores la autorización del Presidente respectivo.', null, 'e6b3fa534f4822ae1efccddb8071dda25ddd710b9d6a4ba67e36b8f369fbea33', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'e6b3fa534f4822ae1efccddb8071dda25ddd710b9d6a4ba67e36b8f369fbea33')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'L''autorització del ministre de Justícia.', false), ('B', 'L''autorització del Tribunal Suprem.', false), ('C', 'L''autorització del president respectiu.', true), ('D', 'L''autorització del fiscal general de l''Estat.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 549 de la LECrim, per a l''entrada i registre en temples i altres llocs religiosos:', 'L''article 549 LECrim només exigeix passar avís d''atenció (recado de atención) als encarregats del temple.', 'plcat_t14_entrada_registre_habeas_corpus', (select id from public.topics where slug = 'plcat-t14-entrada-registre-habeas-corpus'), 2, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1882-6036'), 'Art. 549 LECrim', 'Para la entrada y registro en los templos y demás lugares religiosos bastará pasar recado de atención a las personas a cuyo cargo estuvieren.', null, '1a82628aa7d681d5fc4587ef6df2f6a768f3e1b0dc17a7b86b13a2facc3bc363', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '1a82628aa7d681d5fc4587ef6df2f6a768f3e1b0dc17a7b86b13a2facc3bc363')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'N''hi ha prou de passar avís d''atenció a les persones que en tenen cura.', true), ('B', 'Cal l''autorització prèvia i per escrit de l''autoritat religiosa superior de la confessió corresponent.', false), ('C', 'Cal una resolució del Tribunal Suprem.', false), ('D', 'Cal el consentiment del Ministeri de Justícia.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 559 de la LECrim, per entrar i registrar els edificis destinats a habitatge o oficina dels representants de nacions estrangeres acreditats a Espanya, el jutge els demana la vènia per ofici i els prega que contestin en el termini de:', 'L''article 559 LECrim fixa un termini de dotze hores perquè el representant diplomàtic contesti la petició de vènia.', 'plcat_t14_entrada_registre_habeas_corpus', (select id from public.topics where slug = 'plcat-t14-entrada-registre-habeas-corpus'), 3, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1882-6036'), 'Art. 559 LECrim', 'les pedirá su venia el Juez, por medio de atento oficio, en el que les rogará que contesten en el término de doce horas.', null, 'e2d60a7cd1180abdbc77c505ece11def5db9b8dc013f60ab225911a6741f1f9f', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'e2d60a7cd1180abdbc77c505ece11def5db9b8dc013f60ab225911a6741f1f9f')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Vint-i-quatre hores.', false), ('B', 'Dotze hores.', true), ('C', 'Quaranta-vuit hores.', false), ('D', 'Setanta-dues hores.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 551 de la LECrim, s''entén que presta el consentiment per a l''entrada i registre qui:', 'L''article 551 LECrim admet el consentiment tàcit: el de qui, requerit, fa el que cal perquè l''entrada tingui lloc sense invocar la inviolabilitat del domicili.', 'plcat_t14_entrada_registre_habeas_corpus', (select id from public.topics where slug = 'plcat-t14-entrada-registre-habeas-corpus'), 1, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1882-6036'), 'Art. 551 LECrim', 'Se entenderá que presta su consentimiento aquel que, requerido por quien hubiere de efectuar la entrada y registro para que los permita, ejecuta por su parte los actos necesarios que de él dependan para que puedan tener efecto, sin invocar la inviolabilidad que reconoce al domicilio', null, '540d2d243e4a2dcd3f0ca3254da88fc5d7b2f9de66f553ddafffb2e2663c8403', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '540d2d243e4a2dcd3f0ca3254da88fc5d7b2f9de66f553ddafffb2e2663c8403')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Signa necessàriament un document davant notari.', false), ('B', 'Ho manifesta per escrit davant el jutge.', false), ('C', 'No s''hi oposa per escrit dins de les vint-i-quatre hores següents.', false), ('D', 'Requerit per qui ha de fer l''entrada, executa els actes necessaris que depenen d''ell perquè tingui efecte, sense invocar la inviolabilitat del domicili.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 552 de la LECrim, en practicar els registres cal:', 'L''article 552 LECrim imposa el principi de mínima intervenció en el registre i la protecció de la reputació i els secrets de l''interessat.', 'plcat_t14_entrada_registre_habeas_corpus', (select id from public.topics where slug = 'plcat-t14-entrada-registre-habeas-corpus'), 1, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1882-6036'), 'Art. 552 LECrim', 'Al practicar los registros deberán evitarse las inspecciones inútiles, procurando no perjudicar ni importunar al interesado más de lo necesario, y se adoptarán todo género de precauciones para no comprometer su reputación, respetando sus secretos si no interesaren a la instrucción.', null, '94d663247f17557a4209fef28b145d6d3422450589a3cfa59483b04e4e4e0776', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '94d663247f17557a4209fef28b145d6d3422450589a3cfa59483b04e4e4e0776')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Inspeccionar totes les dependències sense excepció.', false), ('B', 'Fer-los sempre de nit per evitar l''alarma social.', false), ('C', 'Fotografiar tots els documents personals de l''interessat.', false), ('D', 'Evitar les inspeccions inútils, no perjudicar ni importunar l''interessat més del necessari i respectar els seus secrets si no interessen a la instrucció.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 563 de la LECrim, si el lloc tancat que s''ha de registrar és al territori propi del jutge instructor, aquest pot encomanar l''entrada i registre:', 'L''article 563 LECrim permet al jutge instructor delegar l''entrada i registre en el jutge municipal o en autoritats o agents de policia judicial.', 'plcat_t14_entrada_registre_habeas_corpus', (select id from public.topics where slug = 'plcat-t14-entrada-registre-habeas-corpus'), 2, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1882-6036'), 'Art. 563 LECrim', 'Si el edificio o lugar cerrado estuviese en el territorio propio del Juez instructor, podrá encomendar la entrada y registro al Juez municipal del territorio en que el edificio o lugar cerrado radiquen, o a cualquier Autoridad o agente de Policía judicial.', null, 'c48222e99cbb033d71264b8ef07bd8afa05691b247fe932014249443d87b6bb4', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'c48222e99cbb033d71264b8ef07bd8afa05691b247fe932014249443d87b6bb4')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Només al lletrat de l''Administració de justícia.', false), ('B', 'Exclusivament al Ministeri Fiscal.', false), ('C', 'Al jutge municipal del territori o a qualsevol autoritat o agent de policia judicial.', true), ('D', 'Únicament a un jutge de la seva mateixa categoria, que no la pot delegar en cap autoritat ni agent de policia judicial.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 566 de la LECrim, si per a una entrada i registre en domicili particular no es troba ni l''interessat ni el seu encarregat, la interlocutòria es notifica:', 'L''article 566 LECrim fixa l''ordre: interessat, encarregat i, si no, qualsevol persona major d''edat del domicili, amb preferència pels familiars.', 'plcat_t14_entrada_registre_habeas_corpus', (select id from public.topics where slug = 'plcat-t14-entrada-registre-habeas-corpus'), 3, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1882-6036'), 'Art. 566 LECrim', 'Si no fuere tampoco habido el encargado, se hará la notificación a cualquier otra persona mayor de edad que se hallare en el domicilio, prefiriendo para esto a los individuos de la familia del interesado.', null, 'f71f8340164b8a862d0d5d05fa7be00470ecc5125aca9bc7bf1a5bbc6102d722', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'f71f8340164b8a862d0d5d05fa7be00470ecc5125aca9bc7bf1a5bbc6102d722')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'A qualsevol altra persona major d''edat que es trobi al domicili, preferint els membres de la família de l''interessat.', true), ('B', 'Al veí més pròxim.', false), ('C', 'A l''administrador de la finca.', false), ('D', 'Per edicte al butlletí oficial.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 568 de la LECrim, un cop practicades les diligències prèvies, es procedeix a l''entrada i registre emprant-hi, si cal:', 'L''article 568 LECrim autoritza l''ús de la força, si és necessari, per fer efectiva l''entrada i registre.', 'plcat_t14_entrada_registre_habeas_corpus', (select id from public.topics where slug = 'plcat-t14-entrada-registre-habeas-corpus'), 1, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1882-6036'), 'Art. 568 LECrim', 'Practicadas las diligencias que se establecen en los artículos anteriores, se procederá a la entrada y registro, empleando para ello, si fuere necesario, el auxilio de la fuerza.', null, '9086b4b526f017106e78d61060c5c27af871453528ccaa5267b4ae64a198d6b7', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '9086b4b526f017106e78d61060c5c27af871453528ccaa5267b4ae64a198d6b7')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'L''autorització del veïnat.', false), ('B', 'L''auxili de la força.', true), ('C', 'Un serraller designat pel col·legi professional.', false), ('D', 'El consentiment del Ministeri Fiscal.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 569 de la LECrim, la resistència de l''interessat, del seu representant, dels familiars o dels testimonis a presenciar el registre:', 'L''article 569 LECrim equipara la resistència a presenciar el registre a la desobediència greu, i el registre es fa igualment.', 'plcat_t14_entrada_registre_habeas_corpus', (select id from public.topics where slug = 'plcat-t14-entrada-registre-habeas-corpus'), 3, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1882-6036'), 'Art. 569 LECrim', 'La resistencia del interesado, de su representante, de los individuos de la familia y de los testigos a presenciar el registro producirá la responsabilidad declarada en el Código Penal a los reos del delito de desobediencia grave a la Autoridad, sin perjuicio de que la diligencia se practique.', null, '5899a53cc9d3bc7aebbb1eb46312b2e7bedd7d916bc4268b0f1dc17f13f427ba', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '5899a53cc9d3bc7aebbb1eb46312b2e7bedd7d916bc4268b0f1dc17f13f427ba')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Obliga a suspendre el registre fins a una nova interlocutòria.', false), ('B', 'Comporta únicament una sanció administrativa lleu.', false), ('C', 'Fa nul el registre practicat.', false), ('D', 'Genera la responsabilitat que el Codi penal estableix per als reus de desobediència greu a l''autoritat, sens perjudici que la diligència es practiqui.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 569 de la LECrim, si en el registre no es troben les persones o els objectes que es cercaven ni apareixen indicis sospitosos:', 'L''article 569 LECrim preveu lliurar a l''interessat, si ho demana, una certificació de l''acta del registre negatiu.', 'plcat_t14_entrada_registre_habeas_corpus', (select id from public.topics where slug = 'plcat-t14-entrada-registre-habeas-corpus'), 2, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1882-6036'), 'Art. 569 LECrim', 'Si no se encontrasen las personas u objetos que se busquen ni apareciesen indicios sospechosos, se expedirá una certificación del acta a la parte interesada si la reclamare.', null, '866041c517f6039a1ee84bea369448252bf5b3f4c6e2f5e7e731db49ed8a579e', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '866041c517f6039a1ee84bea369448252bf5b3f4c6e2f5e7e731db49ed8a579e')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'S''ha de repetir el registre dins de les vint-i-quatre hores següents, amb la presència obligatòria del Ministeri Fiscal.', false), ('B', 'S''expedeix una certificació de l''acta a la part interessada, si la reclama.', true), ('C', 'S''ha d''indemnitzar d''ofici l''interessat.', false), ('D', 'No s''estén cap acta.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 570 de la LECrim, quan el registre en el domicili d''un particular no s''ha acabat en expirar el dia i l''interessat s''oposa que continuï durant la nit:', 'L''article 570 LECrim preveu la suspensió del registre davant l''oposició de l''interessat, amb tancament i segellament per evitar fugues o sostraccions.', 'plcat_t14_entrada_registre_habeas_corpus', (select id from public.topics where slug = 'plcat-t14-entrada-registre-habeas-corpus'), 3, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1882-6036'), 'Art. 570 LECrim', 'Si se opusiere, se suspenderá la diligencia, salvo lo dispuesto en los artículos 546 y 550, cerrando y sellando el local o los muebles en que hubiere de continuarse', null, '2ea2a44b4a1b14f045ae7e8b53a8e575e5aa823772ca569a01be14cd6f29927f', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '2ea2a44b4a1b14f045ae7e8b53a8e575e5aa823772ca569a01be14cd6f29927f')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Se suspèn la diligència, llevat dels casos dels articles 546 i 550, i es tanquen i segellen el local o els mobles si cal.', true), ('B', 'El registre continua igualment durant la nit.', false), ('C', 'Es dona per acabat i s''estén acta negativa.', false), ('D', 'Cal demanar l''endemà una nova interlocutòria d''entrada.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
-- Lote plcat-t14-entrada-registre-habeas-corpus-lohc-v1 (3 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Ley Orgánica 6/1984, de 24 de mayo, reguladora del procedimiento de «Habeas Corpus» (texto consolidado, BOE)', 'https://www.boe.es/buscar/act.php?id=BOE-A-1984-11620', 'boe'::public.source_kind, 'Agencia Estatal Boletín Oficial del Estado', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('plcat-t14-entrada-registre-habeas-corpus', 'Tema 14. Entrada i registre en lloc tancat i procediment d''habeas corpus') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('policia-local') and t.slug = 'plcat-t14-entrada-registre-habeas-corpus' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 2 de la LO 6/1984, en l''àmbit de la jurisdicció militar és competent per conèixer de la sol·licitud d''habeas corpus:', 'L''article 2 LOHC atribueix la competència, en la jurisdicció militar, al jutge togat militar d''instrucció de la capçalera de la circumscripció on es va detenir.', 'plcat_t14_entrada_registre_habeas_corpus', (select id from public.topics where slug = 'plcat-t14-entrada-registre-habeas-corpus'), 3, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1984-11620'), 'Art. 2 LO 6/1984', 'En el ámbito de la Jurisdicción Militar será competente para conocer de la solicitud de «Habeas Corpus» el Juez Togado Militar de Instrucción constituido en la cabecera de la circunscripción jurisdiccional en la que se efectuó la detención.', null, 'df38bfdb7a2a66873539f314e0e11af48b0b9b1174e763cd6ace91537d769524', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'df38bfdb7a2a66873539f314e0e11af48b0b9b1174e763cd6ace91537d769524')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El jutge central d''instrucció.', false), ('B', 'El jutge d''instrucció ordinari del lloc on es troba el detingut.', false), ('C', 'El jutge togat militar d''instrucció constituït a la capçalera de la circumscripció jurisdiccional on es va fer la detenció.', true), ('D', 'La Sala Militar del Tribunal Suprem.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 8.1 de la LO 6/1984, si el jutge estima que no es dona cap de les circumstàncies de detenció il·legal de l''article 1:', 'L''article 8.1 LOHC preveu l''arxiu, amb declaració que la privació de llibertat és conforme a dret.', 'plcat_t14_entrada_registre_habeas_corpus', (select id from public.topics where slug = 'plcat-t14-entrada-registre-habeas-corpus'), 2, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1984-11620'), 'Art. 8.1 LO 6/1984', 'Si estima que no se da ninguna de las circunstancias a que se refiere el artículo primero de esta ley, acordará el archivo de las actuaciones, declarando ser conforme a Derecho la privación de libertad y las circunstancias en que se está realizando.', null, '84c7c8aa2cbe51d00be368a42e2e06ffbb528868d1d1ade5525d4cf1cdc1936d', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '84c7c8aa2cbe51d00be368a42e2e06ffbb528868d1d1ade5525d4cf1cdc1936d')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Acorda l''arxiu de les actuacions i declara conforme a dret la privació de llibertat i les circumstàncies en què es fa.', true), ('B', 'Acorda en tot cas la posada en llibertat del detingut.', false), ('C', 'Remet les actuacions al Tribunal Constitucional.', false), ('D', 'Ordena que la privació de llibertat continuï, però en un altre establiment o sota la custòdia de persones diferents.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 9 de la LO 6/1984, si s''aprecia temeritat o mala fe en el sol·licitant de l''habeas corpus:', 'L''article 9 LOHC condemna en costes el sol·licitant temerari o de mala fe; si no, les costes es declaren d''ofici.', 'plcat_t14_entrada_registre_habeas_corpus', (select id from public.topics where slug = 'plcat-t14-entrada-registre-habeas-corpus'), 2, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1984-11620'), 'Art. 9 LO 6/1984', 'En todo caso, si se apreciase temeridad o mala fe, será condenado el solicitante al pago de las costas del procedimiento, en caso contrario, éstas se declararán de oficio.', null, 'c913ba64f07481f86978c7478ab3e12dfca81c8991c7d54f28880b93e07270fc', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'c913ba64f07481f86978c7478ab3e12dfca81c8991c7d54f28880b93e07270fc')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Se li imposa una multa administrativa fixa.', false), ('B', 'Se''l condemna al pagament de les costes del procediment.', true), ('C', 'Se''l deté per desobediència.', false), ('D', 'No té cap conseqüència, perquè les costes es declaren sempre d''ofici.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
-- Lote plcat-t14-entrada-registre-habeas-corpus-lopsc-v1 (2 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Ley Orgánica 4/2015, de 30 de marzo, de protección de la seguridad ciudadana (texto consolidado, BOE)', 'https://www.boe.es/buscar/act.php?id=BOE-A-2015-3442', 'boe'::public.source_kind, 'Agencia Estatal Boletín Oficial del Estado', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('plcat-t14-entrada-registre-habeas-corpus', 'Tema 14. Entrada i registre en lloc tancat i procediment d''habeas corpus') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('policia-local') and t.slug = 'plcat-t14-entrada-registre-habeas-corpus' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 15.2 de la LO 4/2015, de protecció de la seguretat ciutadana, és causa legítima suficient per a l''entrada en un domicili:', 'L''article 15.2 LOPSC admet l''entrada en domicili per evitar danys imminents i greus en situacions d''extrema i urgent necessitat.', 'plcat_t14_entrada_registre_habeas_corpus', (select id from public.topics where slug = 'plcat-t14-entrada-registre-habeas-corpus'), 1, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2015-3442'), 'Art. 15.2 LOPSC', 'Será causa legítima suficiente para la entrada en domicilio la necesidad de evitar daños inminentes y graves a las personas y a las cosas, en supuestos de catástrofe, calamidad, ruina inminente u otros semejantes de extrema y urgente necesidad.', null, '5c711468a10f28a3a1af68d976cef947f63d5bdfeaa676e3dbfa315b4387c6f6', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '5c711468a10f28a3a1af68d976cef947f63d5bdfeaa676e3dbfa315b4387c6f6')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'La sospita d''un delicte lleu.', false), ('B', 'La negativa d''un morador a identificar-se.', false), ('C', 'La necessitat d''evitar danys imminents i greus a les persones i a les coses en supòsits de catàstrofe, calamitat, ruïna imminent o altres d''extrema i urgent necessitat.', true), ('D', 'L''ordre verbal de l''alcalde.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 15.3 de la LO 4/2015, de protecció de la seguretat ciutadana, per entrar en edificis ocupats per organismes oficials o entitats públiques:', 'L''article 15.3 LOPSC dispensa del consentiment de l''autoritat o funcionari responsable de l''edifici oficial.', 'plcat_t14_entrada_registre_habeas_corpus', (select id from public.topics where slug = 'plcat-t14-entrada-registre-habeas-corpus'), 2, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2015-3442'), 'Art. 15.3 LOPSC', 'Para la entrada en edificios ocupados por organismos oficiales o entidades públicas, no será preciso el consentimiento de la autoridad o funcionario que los tuviere a su cargo.', null, '760e38476bc8bf243fd03cace5504b9f583267f8186f267c3311269fd4b5b39b', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '760e38476bc8bf243fd03cace5504b9f583267f8186f267c3311269fd4b5b39b')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Cal sempre una resolució judicial.', false), ('B', 'Cal el consentiment escrit de l''autoritat o el funcionari que els té al seu càrrec, o bé una resolució judicial.', false), ('C', 'Cal l''autorització del delegat del Govern.', false), ('D', 'No cal el consentiment de l''autoritat o el funcionari que els té al seu càrrec.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
-- Lote plcat-t15-codi-penal-persones-cp-v1 (20 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Ley Orgánica 10/1995, de 23 de noviembre, del Código Penal (texto consolidado, BOE)', 'https://www.boe.es/buscar/act.php?id=BOE-A-1995-25444', 'boe'::public.source_kind, 'Agencia Estatal Boletín Oficial del Estado', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('plcat-t15-codi-penal-persones', 'Tema 15. Codi penal (I): lesions, delictes contra la llibertat, tortures i delictes contra la llibertat sexual') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('policia-local') and t.slug = 'plcat-t15-codi-penal-persones' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 147.2 del Codi penal, qui causa a un altre una lesió que no requereix tractament mèdic o quirúrgic (no inclosa en l''apartat 1) és castigat amb:', 'L''article 147.2 CP castiga la lesió lleu, no inclosa en l''apartat 1, amb multa d''un a tres mesos; el maltractament d''obra sense lesió (147.3) té multa d''un a dos mesos.', 'plcat_t15_codi_penal_persones', (select id from public.topics where slug = 'plcat-t15-codi-penal-persones'), 1, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1995-25444'), 'Art. 147.2 CP', 'El que, por cualquier medio o procedimiento, causare a otro una lesión no incluida en el apartado anterior, será castigado con la pena de multa de uno a tres meses.', null, '471b04c9857c94249ca15b3549511bef0e9634c1b99396379eb382df708c1ebf', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '471b04c9857c94249ca15b3549511bef0e9634c1b99396379eb382df708c1ebf')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Multa d''un a dos mesos.', false), ('B', 'Presó de tres mesos a tres anys.', false), ('C', 'Multa d''un a tres mesos.', true), ('D', 'Localització permanent de cinc a trenta dies.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 152.1 del Codi penal, qui per imprudència greu causa les lesions del tipus bàsic de l''article 147.1 és castigat amb:', 'L''article 152.1 CP gradua la imprudència greu: 147.1, presó de tres a sis mesos o multa de sis a divuit mesos; 149, presó d''un a tres anys; 150, presó de sis mesos a dos anys.', 'plcat_t15_codi_penal_persones', (select id from public.topics where slug = 'plcat-t15-codi-penal-persones'), 2, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1995-25444'), 'Art. 152.1 CP', '1.° Con la pena de prisión de tres a seis meses o multa de seis a dieciocho meses, si se tratare de las lesiones del apartado 1 del artículo 147.', null, 'c97e83e57aeee893f450cfd64a19ca59beeeb896cfab06e819c6f072ff5caf2a', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'c97e83e57aeee893f450cfd64a19ca59beeeb896cfab06e819c6f072ff5caf2a')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Presó de tres a sis mesos o multa de sis a divuit mesos.', true), ('B', 'Presó d''un a tres anys.', false), ('C', 'Presó de sis mesos a dos anys.', false), ('D', 'Multa d''un a dos mesos.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 150 del Codi penal, causar a una altra persona la pèrdua o la inutilitat d''un òrgan o membre NO principal, o una deformitat, es castiga amb presó de:', 'L''article 150 CP castiga amb presó de tres a sis anys la pèrdua o inutilitat d''òrgan o membre no principal i la deformitat; si el membre és principal, s''aplica l''article 149 (sis a dotze anys).', 'plcat_t15_codi_penal_persones', (select id from public.topics where slug = 'plcat-t15-codi-penal-persones'), 2, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1995-25444'), 'Art. 150 CP', 'El que causare a otro la pérdida o la inutilidad de un órgano o miembro no principal, o la deformidad, será castigado con la pena de prisión de tres a seis años.', null, '8b9acbad0d61cc371c9ee3057d6df7def261808b1c60e9db44940375e3f26a0b', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '8b9acbad0d61cc371c9ee3057d6df7def261808b1c60e9db44940375e3f26a0b')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Sis a dotze anys.', false), ('B', 'Dos a cinc anys.', false), ('C', 'Un a tres anys.', false), ('D', 'Tres a sis anys.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 152.1 del Codi penal, si les lesions per imprudència greu s''han comès utilitzant un vehicle de motor o un ciclomotor, s''imposa també la privació del dret a conduir per un temps de:', 'L''article 152.1 CP afegeix la privació del dret a conduir d''un a quatre anys en la imprudència greu amb vehicle; en la menys greu (152.2) és de tres a divuit mesos.', 'plcat_t15_codi_penal_persones', (select id from public.topics where slug = 'plcat-t15-codi-penal-persones'), 3, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1995-25444'), 'Art. 152.1 CP', 'Si los hechos se hubieran cometido utilizando un vehículo a motor o un ciclomotor, se impondrá asimismo la pena de privación del derecho a conducir vehículos a motor y ciclomotores de uno a cuatro años.', null, 'b4cade6046d40aa6c183f59fa8eafe04a751cf773c9cd9893ddde167ee247fb3', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'b4cade6046d40aa6c183f59fa8eafe04a751cf773c9cd9893ddde167ee247fb3')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Tres a divuit mesos.', false), ('B', 'Un a quatre anys.', true), ('C', 'Sis mesos a dos anys.', false), ('D', 'Sis a deu anys.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 153.1 del Codi penal, qui colpeja o maltracta d''obra sense causar lesió la dona que és o ha estat la seva esposa o parella és castigat amb:', 'L''article 153.1 CP castiga el maltractament ocasional a la dona parella o exparella, o a persona especialment vulnerable que hi convisqui, amb presó de sis mesos a un any o TBC, més la privació del dret a armes.', 'plcat_t15_codi_penal_persones', (select id from public.topics where slug = 'plcat-t15-codi-penal-persones'), 2, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1995-25444'), 'Art. 153.1 CP', 'será castigado con la pena de prisión de seis meses a un año o de trabajos en beneficios de la comunidad de treinta y uno a ochenta días y, en todo caso, privación del derecho a la tenencia y porte de armas de un año y un día a tres años', null, '30da778bf70b78c71cb2d12514cb18bb1106dbc9c5fb0d06fff90293b5a3a616', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '30da778bf70b78c71cb2d12514cb18bb1106dbc9c5fb0d06fff90293b5a3a616')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Multa d''un a dos mesos, només perseguible per denúncia.', false), ('B', 'Presó de dos a cinc anys.', false), ('C', 'Presó de sis mesos a un any o treballs en benefici de la comunitat de trenta-un a vuitanta dies i, en tot cas, privació del dret a la tinença i portada d''armes.', true), ('D', 'Localització permanent de cinc a trenta dies.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 180.3 del Codi penal, en les agressions sexuals, quan el culpable s''ha prevalgut de la seva condició d''autoritat, agent o funcionari públic, s''hi imposa a més:', 'L''article 180.3 CP afegeix la inhabilitació absoluta de sis a dotze anys; la de vuit a dotze anys és la de la tortura (art. 174.1).', 'plcat_t15_codi_penal_persones', (select id from public.topics where slug = 'plcat-t15-codi-penal-persones'), 3, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1995-25444'), 'Art. 180.3 CP', 'cuando el culpable se hubiera prevalido de su condición de autoridad, agente de ésta o funcionario público, se impondrá, además, la pena de inhabilitación absoluta de seis a doce años.', null, '76921ed8412b297c279c37dc88ca8460b5b7333e2f91d72df28791196ba2cb79', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '76921ed8412b297c279c37dc88ca8460b5b7333e2f91d72df28791196ba2cb79')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Inhabilitació absoluta de sis a dotze anys.', true), ('B', 'Inhabilitació absoluta de vuit a dotze anys.', false), ('C', 'Inhabilitació especial de dos a quatre anys.', false), ('D', 'Suspensió d''ocupació o càrrec públic de sis mesos a dos anys.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 154 del Codi penal, els qui es barallen entre ells escometent-se tumultuàriament i utilitzant mitjans que posen en perill la vida o la integritat de les persones són castigats per la seva participació en la baralla amb:', 'L''article 154 CP tipifica la baralla tumultuària amb mitjans perillosos i la castiga amb presó de tres mesos a un any o multa de sis a 24 mesos.', 'plcat_t15_codi_penal_persones', (select id from public.topics where slug = 'plcat-t15-codi-penal-persones'), 1, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1995-25444'), 'Art. 154 CP', 'Quienes riñeren entre sí, acometiéndose tumultuariamente, y utilizando medios o instrumentos que pongan en peligro la vida o integridad de las personas, serán castigados por su participación en la riña con la pena de prisión de tres meses a un año o multa de seis a 24 meses.', null, '3236e0bc0b129f302cd63c2e6915d9f4423e8315ce8af3a737a88cadb0912c5e', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '3236e0bc0b129f302cd63c2e6915d9f4423e8315ce8af3a737a88cadb0912c5e')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Presó de dos a cinc anys.', false), ('B', 'Multa d''un a tres mesos.', false), ('C', 'Presó de sis mesos a tres anys.', false), ('D', 'Presó de tres mesos a un any o multa de sis a vint-i-quatre mesos.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 155 del Codi penal, en els delictes de lesions, si hi ha hagut el consentiment vàlid, lliure, espontani i expressament emès de l''ofès:', 'L''article 155 CP atenua la pena (un o dos graus) si hi ha consentiment vàlid, i declara invàlid el del menor o la persona amb discapacitat necessitada d''especial protecció.', 'plcat_t15_codi_penal_persones', (select id from public.topics where slug = 'plcat-t15-codi-penal-persones'), 2, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1995-25444'), 'Art. 155 CP', 'En los delitos de lesiones, si ha mediado el consentimiento válida, libre, espontánea y expresamente emitido del ofendido, se impondrá la pena inferior en uno o dos grados. No será válido el consentimiento otorgado por un menor de edad o una persona con discapacidad necesitada de especial protección.', null, '3131e451001269615d37b43c70cca7d64d11cf21e60f93d392e1fe0939070418', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '3131e451001269615d37b43c70cca7d64d11cf21e60f93d392e1fe0939070418')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Queda exclosa en tot cas la responsabilitat penal.', false), ('B', 'S''imposa la pena inferior en un o dos graus, però no és vàlid el consentiment d''un menor d''edat o d''una persona amb discapacitat necessitada d''especial protecció.', true), ('C', 'S''imposa la pena en la meitat inferior.', false), ('D', 'No té cap efecte sobre la pena.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 156 del Codi penal, el consentiment vàlid, lliure, conscient i expressament emès EXIMEIX de responsabilitat penal, entre altres supòsits, en:', 'L''article 156 CP eximeix en el trasplantament d''òrgans conforme a la llei, les esterilitzacions i la cirurgia transsexual fetes per facultatiu, llevat de consentiment viciat, a canvi de preu o de menors.', 'plcat_t15_codi_penal_persones', (select id from public.topics where slug = 'plcat-t15-codi-penal-persones'), 2, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1995-25444'), 'Art. 156 CP', 'el consentimiento válida, libre, consciente y expresamente emitido exime de responsabilidad penal en los supuestos de trasplante de órganos efectuado con arreglo a lo dispuesto en la ley, esterilizaciones y cirugía transexual realizadas por facultativo', null, 'b85d3defe77e524f1a36e725dfc0856a01fe0e13db2bc4411da0082fed87ae02', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'b85d3defe77e524f1a36e725dfc0856a01fe0e13db2bc4411da0082fed87ae02')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Les lesions causades en una baralla consentida.', false), ('B', 'Les esterilitzacions fetes per facultatiu.', true), ('C', 'Qualsevol lesió, si qui consent és major d''edat.', false), ('D', 'Les lesions causades per un tatuatge fet per una persona no autoritzada.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 163.3 del Codi penal, si el tancament o la detenció il·legal comesa per un particular ha durat més de quinze dies, la pena és de presó de:', 'L''article 163 CP castiga la detenció il·legal amb presó de quatre a sis anys (163.1), i de cinc a vuit si dura més de quinze dies (163.3).', 'plcat_t15_codi_penal_persones', (select id from public.topics where slug = 'plcat-t15-codi-penal-persones'), 2, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1995-25444'), 'Art. 163.3 CP', 'Se impondrá la pena de prisión de cinco a ocho años si el encierro o detención ha durado más de quince días.', null, 'd17893f586911e407860876133059471ff6be41042a40b4a51579c3a0b95503f', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'd17893f586911e407860876133059471ff6be41042a40b4a51579c3a0b95503f')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Cinc a vuit anys.', true), ('B', 'Quatre a sis anys.', false), ('C', 'Sis a deu anys.', false), ('D', 'Deu a quinze anys.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 164 del Codi penal, el segrest d''una persona exigint alguna condició per posar-la en llibertat es castiga amb presó de:', 'L''article 164 CP castiga el segrest (detenció amb exigència d''una condició) amb presó de sis a deu anys.', 'plcat_t15_codi_penal_persones', (select id from public.topics where slug = 'plcat-t15-codi-penal-persones'), 1, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1995-25444'), 'Art. 164 CP', 'El secuestro de una persona exigiendo alguna condición para ponerla en libertad, será castigado con la pena de prisión de seis a diez años.', null, '348ec5eb0250a0f60ccadf34a6cca9c38367483e99927c96508b7b311d9d95ed', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '348ec5eb0250a0f60ccadf34a6cca9c38367483e99927c96508b7b311d9d95ed')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Quatre a sis anys.', false), ('B', 'Cinc a vuit anys.', false), ('C', 'Quinze a vint anys.', false), ('D', 'Sis a deu anys.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Quina d''aquestes circumstàncies NO determina, segons l''article 165 del Codi penal, que les penes de detenció il·legal o segrest s''imposin en la meitat superior?', 'L''article 165 CP agreuja la pena per simulació d''autoritat o funció pública, o per ser la víctima menor, persona amb discapacitat necessitada d''especial protecció o funcionari en exercici; la nocturnitat no hi figura.', 'plcat_t15_codi_penal_persones', (select id from public.topics where slug = 'plcat-t15-codi-penal-persones'), 3, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1995-25444'), 'Art. 165 CP', 'si la detención ilegal o secuestro se ha ejecutado con simulación de autoridad o función pública, o la víctima fuere menor de edad o persona con discapacidad necesitada de especial protección o funcionario público en el ejercicio de sus funciones.', null, 'b63a74e1bd87ebf128b7fd7d57013baff345098e0cdfdfbf1ab5f88488a799c4', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'b63a74e1bd87ebf128b7fd7d57013baff345098e0cdfdfbf1ab5f88488a799c4')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Que s''hagi executat simulant autoritat o funció pública.', false), ('B', 'Que la víctima sigui menor d''edat.', false), ('C', 'Que la detenció s''hagi fet durant la nit.', true), ('D', 'Que la víctima sigui un funcionari públic en l''exercici de les seves funcions.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 166.1 del Codi penal, el reu de detenció il·legal que no dona raó del parador de la persona detinguda és castigat amb presó de:', 'L''article 166.1 CP castiga no donar raó del parador amb presó de deu a quinze anys en la detenció il·legal i de quinze a vint en el segrest.', 'plcat_t15_codi_penal_persones', (select id from public.topics where slug = 'plcat-t15-codi-penal-persones'), 3, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1995-25444'), 'Art. 166.1 CP', 'El reo de detención ilegal o secuestro que no dé razón del paradero de la persona detenida será castigado con una pena de prisión de diez a quince años, en el caso de la detención ilegal, y de quince a veinte años en el de secuestro.', null, '52eaec5d60c3a0118727c53699ae7c0c4338b73bfaeea60adfa62e502138bc73', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '52eaec5d60c3a0118727c53699ae7c0c4338b73bfaeea60adfa62e502138bc73')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Quinze a vint anys.', false), ('B', 'Deu a quinze anys.', true), ('C', 'Sis a deu anys.', false), ('D', 'Vint a vint-i-cinc anys.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 167.3 del Codi penal, quan la detenció il·legal la comet una autoritat o un funcionari públic, a més de la pena de presó se li imposa:', 'L''article 167.3 CP imposa, en tots els casos en què el fet el comet autoritat o funcionari, la inhabilitació absoluta de vuit a dotze anys.', 'plcat_t15_codi_penal_persones', (select id from public.topics where slug = 'plcat-t15-codi-penal-persones'), 2, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1995-25444'), 'Art. 167.3 CP', 'En todos los casos en los que los hechos a que se refiere este artículo hubieran sido cometidos por autoridad o funcionario público, se les impondrá, además, la pena de inhabilitación absoluta por tiempo de ocho a doce años.', null, '1fda702020b86ae39829b79eca187adef493ce21bb04f0507fbadac0353cbf3c', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '1fda702020b86ae39829b79eca187adef493ce21bb04f0507fbadac0353cbf3c')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Inhabilitació absoluta de vuit a dotze anys.', true), ('B', 'Inhabilitació especial de dos a quatre anys.', false), ('C', 'Suspensió d''ocupació de sis mesos a dos anys.', false), ('D', 'Inhabilitació absoluta de sis a deu anys.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 179.2 del Codi penal, si la violació es comet emprant violència o intimidació o quan la víctima té anul·lada per qualsevol causa la voluntat, la pena és de presó de:', 'L''article 179 CP castiga la violació amb presó de quatre a dotze anys i, amb violència, intimidació o voluntat anul·lada, de sis a dotze anys.', 'plcat_t15_codi_penal_persones', (select id from public.topics where slug = 'plcat-t15-codi-penal-persones'), 2, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1995-25444'), 'Art. 179.2 CP', 'Si la agresión a la que se refiere el apartado anterior se cometiere empleando violencia o intimidación o cuando la víctima tuviera anulada por cualquier causa su voluntad, se impondrá la pena de prisión de seis a doce años.', null, 'fa1032173530531e7980c813f5ef331de964c257df0a7b22225c46f76151d105', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'fa1032173530531e7980c813f5ef331de964c257df0a7b22225c46f76151d105')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Quatre a dotze anys.', false), ('B', 'Set a quinze anys.', false), ('C', 'Sis a dotze anys.', true), ('D', 'Dotze a quinze anys.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 171.7 del Codi penal, fora dels casos anteriors, qui amenaça un altre de manera lleu és castigat amb:', 'L''article 171.7 CP castiga l''amenaça lleu amb multa d''un a tres mesos i exigeix denúncia de l''agreujat, llevat que l''ofès sigui una de les persones de l''article 173.2.', 'plcat_t15_codi_penal_persones', (select id from public.topics where slug = 'plcat-t15-codi-penal-persones'), 1, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1995-25444'), 'Art. 171.7 CP', 'Fuera de los casos anteriores, el que de modo leve amenace a otro será castigado con la pena de multa de uno a tres meses. Este hecho sólo será perseguible mediante denuncia de la persona agraviada o de su representante legal.', null, '90d6f6b9b644ad62b8ee16f0f4d92694dd7de1e8643026c9c58e9f5b2a750da9', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '90d6f6b9b644ad62b8ee16f0f4d92694dd7de1e8643026c9c58e9f5b2a750da9')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Presó de sis mesos a dos anys, perseguible d''ofici.', false), ('B', 'Presó de tres mesos a un any.', false), ('C', 'Multa de sis a vint-i-quatre mesos, perseguible d''ofici.', false), ('D', 'Multa d''un a tres mesos, i el fet només és perseguible per denúncia de la persona agreujada o del seu representant legal.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Quina d''aquestes conductes, feta de manera insistent i reiterada, sense estar legítimament autoritzat i alterant el desenvolupament normal de la vida quotidiana de la víctima, constitueix el delicte d''assetjament de l''article 172 ter del Codi penal?', 'L''article 172 ter CP castiga qui assetja una persona amb conductes insistents i reiterades com vigilar-la, perseguir-la o buscar-ne la proximitat física, o contactar-hi per qualsevol mitjà.', 'plcat_t15_codi_penal_persones', (select id from public.topics where slug = 'plcat-t15-codi-penal-persones'), 1, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1995-25444'), 'Art. 172 ter CP', 'el que acose a una persona llevando a cabo de forma insistente y reiterada, y sin estar legítimamente autorizado, alguna de las conductas siguientes y, de esta forma, altere el normal desarrollo de su vida cotidiana: 1.ª La vigile, la persiga o busque su cercanía física.', null, 'e86e19cf7b13926437e0ca1bb66476d68d4eaadd3f6f90308fe2f80533cdd3c1', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'e86e19cf7b13926437e0ca1bb66476d68d4eaadd3f6f90308fe2f80533cdd3c1')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Vigilar-la, perseguir-la o buscar-ne la proximitat física.', true), ('B', 'Saludar-la una sola vegada pel carrer.', false), ('C', 'Enviar-li una única reclamació comercial per escrit.', false), ('D', 'Presentar contra ella una denúncia fundada.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 173.3 del Codi penal, per apreciar l''habitualitat en el delicte de violència habitual de l''article 173.2 s''atén:', 'L''article 173.3 CP defineix l''habitualitat pel nombre i la proximitat temporal dels actes, amb independència de les víctimes i d''un enjudiciament previ.', 'plcat_t15_codi_penal_persones', (select id from public.topics where slug = 'plcat-t15-codi-penal-persones'), 3, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1995-25444'), 'Art. 173.3 CP', 'Para apreciar la habitualidad a que se refiere el apartado anterior, se atenderá al número de actos de violencia que resulten acreditados, así como a la proximidad temporal de los mismos, con independencia de que dicha violencia se haya ejercido sobre la misma o diferentes víctimas de las comprendidas en este artículo, y de que los actos violentos hayan sido o no objeto de enjuiciamiento en procesos anteriores.', null, '8afcbe7a4dd9cf241e4bff85fa13b8b8f8b6fae27e994c12a05fe66906a75254', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '8afcbe7a4dd9cf241e4bff85fa13b8b8f8b6fae27e994c12a05fe66906a75254')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Només als actes que hagin estat objecte de sentència condemnatòria ferma.', false), ('B', 'Exclusivament als actes comesos sobre una mateixa víctima en l''últim any.', false), ('C', 'A l''existència d''un mínim de tres denúncies prèvies.', false), ('D', 'Al nombre d''actes de violència acreditats i a la seva proximitat temporal, tant si s''han exercit sobre la mateixa víctima com sobre víctimes diferents i tant si han estat jutjats com si no.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 176 del Codi penal, l''autoritat o el funcionari que, faltant als deures del càrrec, permet que altres persones executin tortures o altres atemptats contra la integritat moral:', 'L''article 176 CP equipara en la pena el funcionari que permet la tortura o l''atemptat a la integritat moral a qui l''executa.', 'plcat_t15_codi_penal_persones', (select id from public.topics where slug = 'plcat-t15-codi-penal-persones'), 2, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1995-25444'), 'Art. 176 CP', 'Se impondrán las penas respectivamente establecidas en los artículos precedentes a la autoridad o funcionario que, faltando a los deberes de su cargo, permitiere que otras personas ejecuten los hechos previstos en ellos.', null, 'aac37b2e62322e3111139ed4755ff95942a408f05f4dbdffb216533ee906f211', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'aac37b2e62322e3111139ed4755ff95942a408f05f4dbdffb216533ee906f211')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Només respon disciplinàriament.', false), ('B', 'És castigat amb les mateixes penes establertes per als qui executen els fets.', true), ('C', 'És castigat amb la pena inferior en dos graus.', false), ('D', 'Queda exempt de pena si no hi ha participat materialment.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 184.1 del Codi penal, qui sol·licita favors de naturalesa sexual en l''àmbit d''una relació laboral, docent o de prestació de serveis i provoca a la víctima una situació objectivament i greument intimidatòria, hostil o humiliant comet un delicte de:', 'L''article 184.1 CP tipifica l''assetjament sexual en l''àmbit laboral, docent, de serveis o anàleg, i el castiga amb presó de sis a dotze mesos o multa i inhabilitació especial.', 'plcat_t15_codi_penal_persones', (select id from public.topics where slug = 'plcat-t15-codi-penal-persones'), 1, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1995-25444'), 'Art. 184.1 CP', 'El que solicitare favores de naturaleza sexual, para sí o para un tercero, en el ámbito de una relación laboral, docente, de prestación de servicios o análoga, continuada o habitual, y con tal comportamiento provocare a la víctima una situación objetiva y gravemente intimidatoria, hostil o humillante, será castigado, como autor de acoso sexual', null, '7604fa80742b1b66b3bac947b3ce023ddeb04f008d351fd1a05082586f108847', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '7604fa80742b1b66b3bac947b3ce023ddeb04f008d351fd1a05082586f108847')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Agressió sexual.', false), ('B', 'Coaccions lleus.', false), ('C', 'Assetjament sexual.', true), ('D', 'Exhibicionisme.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
-- Lote plcat-t16-codi-penal-patrimoni-salut-seguretat-viaria-cp-v1 (20 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Ley Orgánica 10/1995, de 23 de noviembre, del Código Penal (texto consolidado, BOE)', 'https://www.boe.es/buscar/act.php?id=BOE-A-1995-25444', 'boe'::public.source_kind, 'Agencia Estatal Boletín Oficial del Estado', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('plcat-t16-codi-penal-patrimoni-salut-seguretat-viaria', 'Tema 16. Codi penal (II): patrimoni, medi ambient, salut pública i seguretat viària') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('policia-local') and t.slug = 'plcat-t16-codi-penal-patrimoni-salut-seguretat-viaria' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 234.3 del Codi penal, les penes del furt s''imposen en la meitat superior quan en la comissió del fet:', 'L''article 234.3 CP agreuja el furt (meitat superior) quan s''han neutralitzat, eliminat o inutilitzat les alarmes o els dispositius de seguretat de les coses sostretes.', 'plcat_t16_codi_penal_patrimoni_salut_seguretat_viaria', (select id from public.topics where slug = 'plcat-t16-codi-penal-patrimoni-salut-seguretat-viaria'), 1, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1995-25444'), 'Art. 234.3 CP', 'Las penas establecidas en los apartados anteriores se impondrán en su mitad superior cuando en la comisión del hecho se hubieran neutralizado, eliminado o inutilizado, por cualquier medio, los dispositivos de alarma o seguridad instalados en las cosas sustraídas.', null, '3063f07de33f19317b4cd4981bd520e410f7348d501fe6a108c6f914e24d7587', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '3063f07de33f19317b4cd4981bd520e410f7348d501fe6a108c6f914e24d7587')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'La quantia sostreta supera els 400 euros.', false), ('B', 'S''han neutralitzat, eliminat o inutilitzat els dispositius d''alarma o seguretat instal·lats en les coses sostretes.', true), ('C', 'El fet s''ha comès en un establiment obert al públic.', false), ('D', 'L''autor és reincident en una infracció administrativa.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 235.1 del Codi penal, el furt es castiga amb presó d''un a tres anys, entre altres casos, quan:', 'L''article 235.1.10è CP agreuja el furt de telèfons mòbils i altres dispositius que puguin contenir dades personals, llevat dels que són a la venda o en exposició en establiments comercials.', 'plcat_t16_codi_penal_patrimoni_salut_seguretat_viaria', (select id from public.topics where slug = 'plcat-t16-codi-penal-patrimoni-salut-seguretat-viaria'), 1, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1995-25444'), 'Art. 235.1 CP', '10.º Cuando los objetos sustraídos fueran teléfonos móviles.', null, '2cd93a1195905032302fe50297df11a519a327ae2bcd45d5132301ec3452383a', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '2cd93a1195905032302fe50297df11a519a327ae2bcd45d5132301ec3452383a')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'La cosa sostreta val més de 200 euros.', false), ('B', 'El furt es comet de nit.', false), ('C', 'Els objectes sostrets són telèfons mòbils.', true), ('D', 'La víctima és una persona jurídica.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 235.2 del Codi penal, quan en un furt concorren dues o més de les circumstàncies agreujants de l''apartat 1:', 'L''article 235.2 CP preveu la meitat superior de la pena del furt agreujat si concorren dues o més circumstàncies.', 'plcat_t16_codi_penal_patrimoni_salut_seguretat_viaria', (select id from public.topics where slug = 'plcat-t16-codi-penal-patrimoni-salut-seguretat-viaria'), 3, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1995-25444'), 'Art. 235.2 CP', 'La pena señalada en el apartado anterior se impondrá en su mitad superior cuando concurrieran dos o más de las circunstancias previstas en el mismo.', null, '151e372201d77f8dd460de2a667c3d75142f8173a2ac352216f23067861bbe21', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '151e372201d77f8dd460de2a667c3d75142f8173a2ac352216f23067861bbe21')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'La pena de presó d''un a tres anys s''imposa en la meitat superior.', true), ('B', 'S''imposa la pena superior en grau.', false), ('C', 'La pena passa a ser de presó de dos a cinc anys.', false), ('D', 'No hi ha cap efecte addicional sobre la pena.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 236.1 del Codi penal, el propietari d''una cosa moble que la sostreu de qui la té legítimament en el seu poder, amb perjudici d''aquest o d''un tercer, és castigat amb:', 'L''article 236 CP castiga el propietari (o qui actua amb el seu consentiment) que sostreu la cosa a qui la posseeix legítimament: multa de tres a dotze mesos, o d''un a tres si no excedeix de 400 euros.', 'plcat_t16_codi_penal_patrimoni_salut_seguretat_viaria', (select id from public.topics where slug = 'plcat-t16-codi-penal-patrimoni-salut-seguretat-viaria'), 2, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1995-25444'), 'Art. 236 CP', 'Será castigado con multa de tres a doce meses el que, siendo dueño de una cosa mueble o actuando con el consentimiento de éste, la sustrajere de quien la tenga legítimamente en su poder, con perjuicio del mismo o de un tercero.', null, 'e8b051675a810c4365a030d71954471a6a895f41144d3306bb3ac2a49544651d', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'e8b051675a810c4365a030d71954471a6a895f41144d3306bb3ac2a49544651d')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Presó de sis a divuit mesos.', false), ('B', 'Multa d''un a tres mesos en tot cas.', false), ('C', 'No comet cap delicte, perquè la cosa és seva.', false), ('D', 'Multa de tres a dotze mesos.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Quina d''aquestes NO es considera clau falsa segons l''article 239 del Codi penal?', 'L''article 239 CP considera claus falses les ganzúes, les claus legítimes perdudes o obtingudes il·lícitament i qualssevol altres que no siguin les destinades pel propietari a obrir el pany.', 'plcat_t16_codi_penal_patrimoni_salut_seguretat_viaria', (select id from public.topics where slug = 'plcat-t16-codi-penal-patrimoni-salut-seguretat-viaria'), 2, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1995-25444'), 'Art. 239 CP', 'Se considerarán llaves falsas: 1. Las ganzúas u otros instrumentos análogos. 2. Las llaves legítimas perdidas por el propietario u obtenidas por un medio que constituya infracción penal. 3. Cualesquiera otras que no sean las destinadas por el propietario para abrir la cerradura violentada por el reo.', null, '337fb1e599c9b3a80105b78aeefa2b8e59e414e2c2ad7d041d6d1c00b47a0382', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '337fb1e599c9b3a80105b78aeefa2b8e59e414e2c2ad7d041d6d1c00b47a0382')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Les ganzúes o altres instruments anàlegs.', false), ('B', 'La clau destinada pel propietari a obrir el pany forçat pel reu.', true), ('C', 'Les claus legítimes perdudes pel propietari.', false), ('D', 'Les claus legítimes obtingudes per un mitjà que constitueix infracció penal.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 241.1 del Codi penal, el robatori comès en casa habitada, edifici o local obert al públic, o en qualsevol de les seves dependències, es castiga amb presó de:', 'L''article 241.1 CP castiga amb presó de dos a cinc anys el robatori en casa habitada o en edifici o local oberts al públic.', 'plcat_t16_codi_penal_patrimoni_salut_seguretat_viaria', (select id from public.topics where slug = 'plcat-t16-codi-penal-patrimoni-salut-seguretat-viaria'), 1, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1995-25444'), 'Art. 241.1 CP', 'El robo cometido en casa habitada, edificio o local abiertos al público, o en cualquiera de sus dependencias, se castigará con una pena de prisión de dos a cinco años.', null, '06c4a3f3cadf42ee1679e54b6a494ff8946ca102ce8a8e3d65561b4aecd7329c', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '06c4a3f3cadf42ee1679e54b6a494ff8946ca102ce8a8e3d65561b4aecd7329c')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Dos a cinc anys.', true), ('B', 'Un a tres anys.', false), ('C', 'Tres anys i sis mesos a cinc anys.', false), ('D', 'Sis mesos a dos anys.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 241.2 del Codi penal, es considera casa habitada:', 'L''article 241.2 CP defineix la casa habitada com a morada d''una o més persones, encara que estiguin absents accidentalment.', 'plcat_t16_codi_penal_patrimoni_salut_seguretat_viaria', (select id from public.topics where slug = 'plcat-t16-codi-penal-patrimoni-salut-seguretat-viaria'), 2, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1995-25444'), 'Art. 241.2 CP', 'Se considera casa habitada todo albergue que constituya morada de una o más personas, aunque accidentalmente se encuentren ausentes de ella cuando el robo tenga lugar.', null, '5177996b79830dcb36e8060b80f27e1d0145636d96d50301bd0bef2cc42b91f1', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '5177996b79830dcb36e8060b80f27e1d0145636d96d50301bd0bef2cc42b91f1')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Només l''habitatge on hi ha persones en el moment del robatori.', false), ('B', 'Qualsevol immoble inscrit al registre de la propietat.', false), ('C', 'Només el domicili habitual empadronat de la víctima.', false), ('D', 'Tot alberg que constitueix morada d''una o més persones, encara que accidentalment no hi siguin quan té lloc el robatori.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 241.3 del Codi penal, es consideren dependències de casa habitada:', 'L''article 241.3 CP exigeix que les dependències siguin tancades, contigües, en comunicació interior i formin una unitat física amb l''edifici.', 'plcat_t16_codi_penal_patrimoni_salut_seguretat_viaria', (select id from public.topics where slug = 'plcat-t16-codi-penal-patrimoni-salut-seguretat-viaria'), 3, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1995-25444'), 'Art. 241.3 CP', 'Se consideran dependencias de casa habitada o de edificio o local abiertos al público, sus patios, garajes y demás departamentos o sitios cercados y contiguos al edificio y en comunicación interior con él, y con el cual formen una unidad física.', null, 'e7cbe923b2aff197446139497bba21fa68b6e95613365da2b0bf850f2dee03fa', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'e7cbe923b2aff197446139497bba21fa68b6e95613365da2b0bf850f2dee03fa')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Qualsevol finca situada al mateix municipi que l''habitatge.', false), ('B', 'Els trasters situats en un altre edifici.', false), ('C', 'Els patis, els garatges i altres departaments o llocs tancats i contigus a l''edifici, en comunicació interior amb ell i formant-hi una unitat física.', true), ('D', 'Únicament les habitacions interiors de l''habitatge.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 243 del Codi penal, qui, amb ànim de lucre, obliga un altre amb violència o intimidació a fer o ometre un acte o negoci jurídic en perjudici del seu patrimoni o del d''un tercer és castigat amb:', 'L''article 243 CP (extorsió) castiga amb presó d''un a cinc anys, a més de les penes que corresponguin per la violència física exercida.', 'plcat_t16_codi_penal_patrimoni_salut_seguretat_viaria', (select id from public.topics where slug = 'plcat-t16-codi-penal-patrimoni-salut-seguretat-viaria'), 2, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1995-25444'), 'Art. 243 CP', 'El que, con ánimo de lucro, obligare a otro, con violencia o intimidación, a realizar u omitir un acto o negocio jurídico en perjuicio de su patrimonio o del de un tercero, será castigado con la pena de prisión de uno a cinco años, sin perjuicio de las que pudieran imponerse por los actos de violencia física realizados.', null, 'b2df7f1a948bbd0d11d8ceb2b3473ce53973a0e6bdbeacb976ef7fb7d58c970c', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'b2df7f1a948bbd0d11d8ceb2b3473ce53973a0e6bdbeacb976ef7fb7d58c970c')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Presó de sis a divuit mesos.', false), ('B', 'Multa de tres a dotze mesos.', false), ('C', 'Presó de dos a cinc anys, absorbint les violències.', false), ('D', 'Presó d''un a cinc anys, sens perjudici de les penes pels actes de violència física.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 244.3 del Codi penal, si qui ha sostret un vehicle de motor aliè sense ànim d''apropiar-se''l no el restitueix en el termini de quaranta-vuit hores:', 'L''article 244 CP exigeix la restitució en 48 hores per aplicar el furt d''ús; si no hi ha restitució, es castiga com a furt o robatori.', 'plcat_t16_codi_penal_patrimoni_salut_seguretat_viaria', (select id from public.topics where slug = 'plcat-t16-codi-penal-patrimoni-salut-seguretat-viaria'), 2, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1995-25444'), 'Art. 244.3 CP', 'De no efectuarse la restitución en el plazo señalado, se castigará el hecho como hurto o robo en sus respectivos casos.', null, 'ae1d607378976d80f022f79070d4ad747388175405ad29f92be87bd81a058362', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'ae1d607378976d80f022f79070d4ad747388175405ad29f92be87bd81a058362')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El fet es castiga com a furt o robatori, segons el cas.', true), ('B', 'Es manté la pena de treballs en benefici de la comunitat.', false), ('C', 'Només hi ha una infracció administrativa de trànsit.', false), ('D', 'S''imposa la pena en la meitat superior, però continua sent furt d''ús.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 245.1 del Codi penal, qui amb violència o intimidació en les persones ocupa una cosa immoble aliena és castigat, a més de les penes per les violències, amb:', 'L''article 245.1 CP castiga la usurpació violenta amb presó d''un a dos anys; l''ocupació no violenta d''immoble que no és morada (245.2) es castiga amb multa de tres a sis mesos.', 'plcat_t16_codi_penal_patrimoni_salut_seguretat_viaria', (select id from public.topics where slug = 'plcat-t16-codi-penal-patrimoni-salut-seguretat-viaria'), 2, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1995-25444'), 'Art. 245.1 CP', 'Al que con violencia o intimidación en las personas ocupare una cosa inmueble o usurpare un derecho real inmobiliario de pertenencia ajena, se le impondrá, además de las penas en que incurriere por las violencias ejercidas, la pena de prisión de uno a dos años', null, 'b684da59e89076a8c21292437f84498c09db14f133c468180a7f25d6980424a7', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'b684da59e89076a8c21292437f84498c09db14f133c468180a7f25d6980424a7')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Multa de tres a sis mesos.', false), ('B', 'Presó d''un a dos anys.', true), ('C', 'Presó de dos a cinc anys.', false), ('D', 'Multa d''un a tres mesos.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 268 del Codi penal, estan exempts de responsabilitat criminal, i subjectes només a la civil, pels delictes patrimonials que es causin entre si sense violència, intimidació ni abús de la vulnerabilitat de la víctima:', 'L''article 268 CP estableix l''excusa absolutòria entre parents pròxims per als delictes patrimonials no violents; no s''aplica als estranys que hi participen.', 'plcat_t16_codi_penal_patrimoni_salut_seguretat_viaria', (select id from public.topics where slug = 'plcat-t16-codi-penal-patrimoni-salut-seguretat-viaria'), 3, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1995-25444'), 'Art. 268 CP', 'Están exentos de responsabilidad criminal y sujetos únicamente a la civil los cónyuges que no estuvieren separados legalmente o de hecho o en proceso judicial de separación, divorcio o nulidad de su matrimonio y los ascendientes, descendientes y hermanos por naturaleza o por adopción, así como los afines en primer grado si viviesen juntos', null, 'a8d66330af8919dff52dc4a381649afb111073cc0cc73f51eccf9ca9664d8b27', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'a8d66330af8919dff52dc4a381649afb111073cc0cc73f51eccf9ca9664d8b27')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Tots els parents fins al quart grau, convisquin o no.', false), ('B', 'Els veïns i els companys de feina.', false), ('C', 'Els cònjuges no separats i els ascendents, descendents i germans per naturalesa o adopció, així com els afins en primer grau si viuen junts.', true), ('D', 'Els cònjuges separats legalment i els seus fills.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 267 del Codi penal, els danys causats per imprudència greu són delicte quan la seva quantia supera:', 'L''article 267 CP castiga amb multa de tres a nou mesos els danys per imprudència greu de més de 80.000 euros; només són perseguibles per denúncia i el perdó de l''ofès extingeix l''acció penal.', 'plcat_t16_codi_penal_patrimoni_salut_seguretat_viaria', (select id from public.topics where slug = 'plcat-t16-codi-penal-patrimoni-salut-seguretat-viaria'), 3, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1995-25444'), 'Art. 267 CP', 'Los daños causados por imprudencia grave en cuantía superior a 80.000 euros, serán castigados con la pena de multa de tres a nueve meses, atendiendo a la importancia de los mismos.', null, '3917c2770f72aafa1a88625bdbad16713b7e97d0f96fd9ae34e33556da3d2d1b', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '3917c2770f72aafa1a88625bdbad16713b7e97d0f96fd9ae34e33556da3d2d1b')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', '400 euros.', false), ('B', '50.000 euros.', false), ('C', '120.000 euros.', false), ('D', '80.000 euros.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 264.1 del Codi penal, qui sense autorització i de manera greu esborra, danya o fa inaccessibles dades, programes informàtics o documents electrònics aliens, quan el resultat és greu, és castigat amb:', 'L''article 264.1 CP castiga els danys informàtics greus amb presó de sis mesos a tres anys; les circumstàncies de l''apartat 2 eleven la pena a dos a cinc anys.', 'plcat_t16_codi_penal_patrimoni_salut_seguretat_viaria', (select id from public.topics where slug = 'plcat-t16-codi-penal-patrimoni-salut-seguretat-viaria'), 2, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1995-25444'), 'Art. 264.1 CP', 'El que por cualquier medio, sin autorización y de manera grave borrase, dañase, deteriorase, alterase, suprimiese o hiciese inaccesibles datos informáticos, programas informáticos o documentos electrónicos ajenos, cuando el resultado producido fuera grave, será castigado con la pena de prisión de seis meses a tres años.', null, '28221978836e323e9b2873c6c3ae177a39accb348ea755ebaa42716d1653dc69', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '28221978836e323e9b2873c6c3ae177a39accb348ea755ebaa42716d1653dc69')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Multa d''un a tres mesos.', false), ('B', 'Presó de dos a cinc anys i multa del tant al dècuple del perjudici.', false), ('C', 'Presó de sis mesos a tres anys.', true), ('D', 'Presó d''un a tres anys.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 331 del Codi penal, els delictes contra els recursos naturals i el medi ambient comesos per imprudència greu:', 'L''article 331 CP preveu la pena inferior en grau per als fets del capítol comesos per imprudència greu.', 'plcat_t16_codi_penal_patrimoni_salut_seguretat_viaria', (select id from public.topics where slug = 'plcat-t16-codi-penal-patrimoni-salut-seguretat-viaria'), 2, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1995-25444'), 'Art. 331 CP', 'Los hechos previstos en este capítulo serán sancionados, en su caso, con la pena inferior en grado, en sus respectivos supuestos, cuando se hayan cometido por imprudencia grave.', null, 'a22b0ad62b513b1d554549208f0a13c3b56a22b8631301b9b4d29b5efadc1ae1', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'a22b0ad62b513b1d554549208f0a13c3b56a22b8631301b9b4d29b5efadc1ae1')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Es castiguen amb la pena inferior en grau.', true), ('B', 'No són punibles.', false), ('C', 'Es castiguen amb la mateixa pena que els dolosos.', false), ('D', 'Només comporten una sanció administrativa.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 340 bis.1 del Codi penal, qui, fora de les activitats legalment regulades, causa a un animal domèstic una lesió que requereix tractament veterinari és castigat amb:', 'L''article 340 bis.1 CP castiga el maltractament amb lesió que requereix tractament veterinari; si causa la mort de l''animal domèstic, la presó és de dotze a vint-i-quatre mesos (340 bis.3).', 'plcat_t16_codi_penal_patrimoni_salut_seguretat_viaria', (select id from public.topics where slug = 'plcat-t16-codi-penal-patrimoni-salut-seguretat-viaria'), 1, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1995-25444'), 'Art. 340 bis CP', 'Será castigado con la pena de prisión de tres a dieciocho meses o multa de seis a doce meses y con la pena de inhabilitación especial de uno a tres años para el ejercicio de profesión, oficio o comercio que tenga relación con los animales y para la tenencia de animales', null, '80be30f54f8e7b747de1f1616f96b9471eacad3e7d546fb80c52edd98de9522e', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '80be30f54f8e7b747de1f1616f96b9471eacad3e7d546fb80c52edd98de9522e')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Només una sanció administrativa.', false), ('B', 'Presó de tres a divuit mesos o multa de sis a dotze mesos, i inhabilitació especial per a professions relacionades amb animals i per a la tinença d''animals.', true), ('C', 'Multa d''un a dos mesos en tot cas.', false), ('D', 'Presó de dotze a vint-i-quatre mesos.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Quina d''aquestes circumstàncies comporta, segons l''article 369 del Codi penal, les penes superiors en grau en el delicte de tràfic de drogues?', 'L''article 369.1.4a CP agreuja el tràfic quan les drogues es faciliten a menors de 18 anys, a disminuïts psíquics o a persones en tractament de deshabituació.', 'plcat_t16_codi_penal_patrimoni_salut_seguretat_viaria', (select id from public.topics where slug = 'plcat-t16-codi-penal-patrimoni-salut-seguretat-viaria'), 1, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1995-25444'), 'Art. 369 CP', '4.ª Las sustancias a que se refiere el artículo anterior se faciliten a menores de 18 años, a disminuidos psíquicos o a personas sometidas a tratamiento de deshabituación o rehabilitación.', null, 'f8237332d3372dde6028f29d9e72a8aeb60b48bf9b1128e25159d98abf7ad6b3', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'f8237332d3372dde6028f29d9e72a8aeb60b48bf9b1128e25159d98abf7ad6b3')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Que el culpable sigui consumidor habitual.', false), ('B', 'Que les substàncies es facilitin a menors de 18 anys.', true), ('C', 'Que la venda es faci a plena llum del dia.', false), ('D', 'Que la substància sigui de les que no causen greu dany a la salut.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 382 del Codi penal, quan amb els fets dels articles 379, 380 i 381 es causa, a més del risc, un resultat lesiu constitutiu de delicte:', 'L''article 382 CP resol el concurs entre el delicte de risc i el resultat lesiu apreciant només la infracció més greu en la meitat superior.', 'plcat_t16_codi_penal_patrimoni_salut_seguretat_viaria', (select id from public.topics where slug = 'plcat-t16-codi-penal-patrimoni-salut-seguretat-viaria'), 3, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1995-25444'), 'Art. 382 CP', 'los Jueces o Tribunales apreciarán tan sólo la infracción más gravemente penada, aplicando la pena en su mitad superior y condenando, en todo caso, al resarcimiento de la responsabilidad civil que se hubiera originado.', null, '19c518ca97df34daa908c6b4a9c7c615a59d7c032f529b22b384a7af5fd10c10', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '19c518ca97df34daa908c6b4a9c7c615a59d7c032f529b22b384a7af5fd10c10')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Es castiguen sempre per separat les dues infraccions.', false), ('B', 'S''aplica només el delicte contra la seguretat viària.', false), ('C', 'S''aprecia només la infracció més greument penada, amb la pena en la meitat superior, i es condemna en tot cas al rescabalament de la responsabilitat civil.', true), ('D', 'S''imposa la pena superior en grau del delicte de lesions.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 382 bis del Codi penal, el conductor que voluntàriament i sense risc propi o de tercers abandona el lloc d''un accident causat per una acció imprudent seva, amb morts o lesions greus, és castigat amb:', 'L''article 382 bis CP tipifica l''abandonament del lloc de l''accident; si l''origen és imprudent, presó de sis mesos a quatre anys; si és fortuït, de tres a sis mesos.', 'plcat_t16_codi_penal_patrimoni_salut_seguretat_viaria', (select id from public.topics where slug = 'plcat-t16-codi-penal-patrimoni-salut-seguretat-viaria'), 2, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1995-25444'), 'Art. 382 bis CP', 'Los hechos contemplados en este artículo que tuvieran su origen en una acción imprudente del conductor, serán castigados con la pena de prisión de seis meses a cuatro años y privación del derecho a conducir vehículos a motor y ciclomotores de uno a cuatro años.', null, '449d86d91587615ffb540d85abc6f6331247a9ed72d7579fbcffba1f1a895e90', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '449d86d91587615ffb540d85abc6f6331247a9ed72d7579fbcffba1f1a895e90')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Presó de tres a sis mesos i privació del dret a conduir de sis mesos a dos anys.', false), ('B', 'Multa de tres a dotze mesos.', false), ('C', 'Presó de dos a cinc anys i privació del dret a conduir de sis a deu anys.', false), ('D', 'Presó de sis mesos a quatre anys i privació del dret a conduir d''un a quatre anys.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 385 bis del Codi penal, el vehicle de motor o ciclomotor utilitzat en els delictes contra la seguretat viària es considera:', 'L''article 385 bis CP qualifica el vehicle com a instrument del delicte a efectes dels articles 127 i 128 CP.', 'plcat_t16_codi_penal_patrimoni_salut_seguretat_viaria', (select id from public.topics where slug = 'plcat-t16-codi-penal-patrimoni-salut-seguretat-viaria'), 1, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1995-25444'), 'Art. 385 bis CP', 'El vehículo a motor o ciclomotor utilizado en los hechos previstos en este Capítulo se considerará instrumento del delito a los efectos de los artículos 127 y 128.', null, '6d3539478e9480ed7e386194f5ddcbc5bf678c898f28fab03884672304441bf6', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '6d3539478e9480ed7e386194f5ddcbc5bf678c898f28fab03884672304441bf6')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Instrument del delicte, a l''efecte del comís (articles 127 i 128).', true), ('B', 'Prova documental.', false), ('C', 'Bé inembargable.', false), ('D', 'Objecte que s''ha de retornar sempre al titular.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
-- Lote plcat-t17-codi-penal-ordre-public-funcionaris-cp-v1 (20 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Ley Orgánica 10/1995, de 23 de noviembre, del Código Penal (texto consolidado, BOE)', 'https://www.boe.es/buscar/act.php?id=BOE-A-1995-25444', 'boe'::public.source_kind, 'Agencia Estatal Boletín Oficial del Estado', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('plcat-t17-codi-penal-ordre-public-funcionaris', 'Tema 17. Codi penal (III): ordre públic, delictes dels funcionaris, garanties constitucionals, omissió del deure d''impedir delictes i delictes d''odi') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('policia-local') and t.slug = 'plcat-t17-codi-penal-ordre-public-funcionaris' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 510.1.a) del Codi penal, el delicte d''incitació a l''odi castiga els qui fomenten, promouen o inciten directament o indirectament a l''odi, l''hostilitat, la discriminació o la violència contra un grup o una persona per raó de la seva pertinença al grup, sempre que ho facin:', 'L''article 510.1.a) CP exigeix que la incitació a l''odi sigui pública i la castiga amb presó d''un a quatre anys i multa de sis a dotze mesos.', 'plcat_t17_codi_penal_ordre_public_funcionaris', (select id from public.topics where slug = 'plcat-t17-codi-penal-ordre-public-funcionaris'), 1, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1995-25444'), 'Art. 510.1.a CP', 'Quienes públicamente fomenten, promuevan o inciten directa o indirectamente al odio, hostilidad, discriminación o violencia contra un grupo, una parte del mismo o contra una persona determinada por razón de su pertenencia a aquel', null, '2ddec33c2be5b7d3487823c96c698755fadd43afc57f4fe32f9b4c72e39cb309', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '2ddec33c2be5b7d3487823c96c698755fadd43afc57f4fe32f9b4c72e39cb309')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'En l''àmbit estrictament familiar.', false), ('B', 'Només per escrit i signant-ho.', false), ('C', 'Públicament.', true), ('D', 'Només si són funcionaris públics.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 510.3 del Codi penal, les penes dels delictes d''odi s''imposen en la meitat superior quan els fets:', 'L''article 510.3 CP agreuja els delictes d''odi difosos per mitjans de comunicació, internet o TIC amb accés d''un nombre elevat de persones.', 'plcat_t17_codi_penal_ordre_public_funcionaris', (select id from public.topics where slug = 'plcat-t17-codi-penal-ordre-public-funcionaris'), 3, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1995-25444'), 'Art. 510.3 CP', 'Las penas previstas en los apartados anteriores se impondrán en su mitad superior cuando los hechos se hubieran llevado a cabo a través de un medio de comunicación social, por medio de internet o mediante el uso de tecnologías de la información, de modo que, aquel se hiciera accesible a un elevado número de personas.', null, '76b65af63dcc644e280188888d3fbf80246b06744dbaed229c69a5c4eaf50f5b', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '76b65af63dcc644e280188888d3fbf80246b06744dbaed229c69a5c4eaf50f5b')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'S''han comès de nit.', false), ('B', 'S''han dut a terme a través d''un mitjà de comunicació social, d''internet o de tecnologies de la informació, de manera que han estat accessibles a un nombre elevat de persones.', true), ('C', 'S''han comès per un menor d''edat.', false), ('D', 'S''han dirigit contra una sola persona.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 511.1 del Codi penal, el particular encarregat d''un servei públic que denega a una persona una prestació a la qual té dret per raó, entre altres, de la seva religió, origen nacional o discapacitat és castigat amb:', 'L''article 511.1 CP castiga la denegació discriminatòria de prestacions per part del particular encarregat d''un servei públic.', 'plcat_t17_codi_penal_ordre_public_funcionaris', (select id from public.topics where slug = 'plcat-t17-codi-penal-ordre-public-funcionaris'), 2, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1995-25444'), 'Art. 511.1 CP', 'Incurrirá en la pena de prisión de seis meses a dos años, multa de doce a veinticuatro meses e inhabilitación especial para empleo o cargo público por tiempo de uno a tres años el particular encargado de un servicio público que deniegue a una persona una prestación a la que tenga derecho', null, '4624ad74666003c256848d2594e1fa37e4db1727e3c0cc2913b155209392ac64', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '4624ad74666003c256848d2594e1fa37e4db1727e3c0cc2913b155209392ac64')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Només inhabilitació especial per a l''exercici de la professió d''un a quatre anys.', false), ('B', 'Multa d''un a tres mesos.', false), ('C', 'Presó d''un a quatre anys i multa de sis a dotze mesos.', false), ('D', 'Presó de sis mesos a dos anys, multa de dotze a vint-i-quatre mesos i inhabilitació especial per a ocupació o càrrec públic d''un a tres anys.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 511.3 del Codi penal, quan la denegació discriminatòria d''una prestació pública la comet un funcionari públic:', 'L''article 511.3 CP agreuja la pena quan l''autor és funcionari públic (meitat superior i inhabilitació especial de dos a quatre anys).', 'plcat_t17_codi_penal_ordre_public_funcionaris', (select id from public.topics where slug = 'plcat-t17-codi-penal-ordre-public-funcionaris'), 3, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1995-25444'), 'Art. 511.3 CP', 'Los funcionarios públicos que cometan alguno de los hechos previstos en este artículo, incurrirán en las mismas penas en su mitad superior y en la de inhabilitación especial para empleo o cargo público por tiempo de dos a cuatro años.', null, '86e337b64cdb933134759b0d76b19ebd00d7c9b4203596aae81f8937b536734f', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '86e337b64cdb933134759b0d76b19ebd00d7c9b4203596aae81f8937b536734f')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Incorre en les mateixes penes en la meitat superior i en inhabilitació especial per a ocupació o càrrec públic de dos a quatre anys.', true), ('B', 'Incorre en la pena superior en grau i, a més, en inhabilitació absoluta per a ocupació o càrrec públic de sis a deu anys.', false), ('C', 'Només respon disciplinàriament.', false), ('D', 'Incorre en la pena inferior en grau.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'L''article 450.1 del Codi penal castiga qui, podent fer-ho amb la seva intervenció immediata i sense risc propi o aliè, no impedeix la comissió d''un delicte que afecti les persones. Quin d''aquests delictes NO hi està inclòs?', 'L''article 450.1 CP es limita als delictes contra la vida, la integritat o la salut, la llibertat o la llibertat sexual de les persones.', 'plcat_t17_codi_penal_ordre_public_funcionaris', (select id from public.topics where slug = 'plcat-t17-codi-penal-ordre-public-funcionaris'), 1, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1995-25444'), 'Art. 450.1 CP', 'El que, pudiendo hacerlo con su intervención inmediata y sin riesgo propio o ajeno, no impidiere la comisión de un delito que afecte a las personas en su vida, integridad o salud, libertad o libertad sexual', null, '908bf6cac997b8c81b25cd98c038dd031eecdf4d9bcf84cc1b59ac384c571f5e', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '908bf6cac997b8c81b25cd98c038dd031eecdf4d9bcf84cc1b59ac384c571f5e')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Un delicte contra la vida.', false), ('B', 'Un delicte contra el patrimoni, com ara un furt.', true), ('C', 'Un delicte contra la llibertat sexual.', false), ('D', 'Un delicte contra la integritat o la salut.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 450.2 del Codi penal, incorre en les mateixes penes que qui no impedeix un delicte contra la vida, la integritat, la llibertat o la llibertat sexual:', 'L''article 450.2 CP castiga també qui no avisa l''autoritat o els seus agents per impedir un delicte d''aquests que sap que es cometrà o s''està cometent.', 'plcat_t17_codi_penal_ordre_public_funcionaris', (select id from public.topics where slug = 'plcat-t17-codi-penal-ordre-public-funcionaris'), 2, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1995-25444'), 'Art. 450.2 CP', 'En las mismas penas incurrirá quien, pudiendo hacerlo, no acuda a la autoridad o a sus agentes para que impidan un delito de los previstos en el apartado anterior y de cuya próxima o actual comisión tenga noticia.', null, 'f7b4118bf7b7188ede57e4474a88e1e5038713c2d62583f6b9c36b0cc9706e04', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'f7b4118bf7b7188ede57e4474a88e1e5038713c2d62583f6b9c36b0cc9706e04')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Qui no denuncia un delicte ja comès fa anys.', false), ('B', 'Qui no declara com a testimoni en el judici.', false), ('C', 'Qui, podent fer-ho, no acudeix a l''autoritat o als seus agents perquè l''impedeixin, si té notícia de la seva comissió pròxima o actual.', true), ('D', 'Qui no col·labora en una campanya de prevenció del delicte.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 407.1 del Codi penal, l''autoritat o el funcionari que abandona el seu destí amb el propòsit de no impedir o no perseguir els delictes dels títols XXI, XXII, XXIII i XXIV és castigat amb:', 'L''article 407.1 CP castiga l''abandonament de destí per no perseguir aquests delictes amb presó i inhabilitació absoluta; si es tracta de qualsevol altre delicte, amb inhabilitació especial d''un a tres anys.', 'plcat_t17_codi_penal_ordre_public_funcionaris', (select id from public.topics where slug = 'plcat-t17-codi-penal-ordre-public-funcionaris'), 3, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1995-25444'), 'Art. 407.1 CP', 'A la autoridad o funcionario público que abandonare su destino con el propósito de no impedir o no perseguir cualquiera de los delitos comprendidos en los Títulos XXI, XXII, XXIII y XXIV se le castigará con la pena de prisión de uno a cuatro años e inhabilitación absoluta para empleo o cargo público por tiempo de seis a diez años.', null, '8ebf3d82602556e5980f4ba558f16d142c97e0fc283d1848ef012ab062e96d72', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '8ebf3d82602556e5980f4ba558f16d142c97e0fc283d1848ef012ab062e96d72')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Presó d''un a quatre anys i inhabilitació absoluta de sis a deu anys.', true), ('B', 'Inhabilitació especial d''un a tres anys.', false), ('C', 'Multa de tres a dotze mesos i suspensió d''ocupació o càrrec públic per un temps de sis mesos a dos anys.', false), ('D', 'Inhabilitació especial de sis mesos a dos anys.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 405 del Codi penal, l''autoritat o funcionari que, sabent-ne la il·legalitat, nomena o dona possessió d''un càrrec públic a qui no reuneix els requisits legals és castigat amb:', 'L''article 405 CP castiga els nomenaments il·legals; la mateixa multa s''imposa a qui accepta el nomenament sabent que no compleix els requisits (art. 406).', 'plcat_t17_codi_penal_ordre_public_funcionaris', (select id from public.topics where slug = 'plcat-t17-codi-penal-ordre-public-funcionaris'), 2, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1995-25444'), 'Art. 405 CP', 'se le castigará con las penas de multa de tres a ocho meses y suspensión de empleo o cargo público por tiempo de uno a tres años.', null, '7f29f88d503d63bb8305b6119e911105c4f9fdd41c4d5925c4ba62a8b31f15a5', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '7f29f88d503d63bb8305b6119e911105c4f9fdd41c4d5925c4ba62a8b31f15a5')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Multa de dotze a vint-i-quatre mesos i inhabilitació especial per a ocupació o càrrec públic de tres a sis anys.', false), ('B', 'Inhabilitació especial de nou a quinze anys.', false), ('C', 'Multa d''un a tres mesos.', false), ('D', 'Multa de tres a vuit mesos i suspensió d''ocupació o càrrec públic d''un a tres anys.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 410.1 del Codi penal, les autoritats o funcionaris que es neguen obertament a donar el degut compliment a resolucions judicials o ordres de l''autoritat superior dictades dins de la seva competència i amb les formalitats legals incorren en:', 'L''article 410.1 CP tipifica la desobediència dels funcionaris i la castiga amb multa i inhabilitació especial.', 'plcat_t17_codi_penal_ordre_public_funcionaris', (select id from public.topics where slug = 'plcat-t17-codi-penal-ordre-public-funcionaris'), 2, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1995-25444'), 'Art. 410.1 CP', 'Las autoridades o funcionarios públicos que se negaren abiertamente a dar el debido cumplimiento a resoluciones judiciales, decisiones u órdenes de la autoridad superior, dictadas dentro del ámbito de su respectiva competencia y revestidas de las formalidades legales, incurrirán en la pena de multa de tres a doce meses e inhabilitación especial para empleo o cargo público por tiempo de seis meses a dos años.', null, 'a1bf8ff6bd8ae64c2ec44c2f11530f0148fcb082c202808948699e1b5fbffb4d', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'a1bf8ff6bd8ae64c2ec44c2f11530f0148fcb082c202808948699e1b5fbffb4d')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Presó de sis mesos a un any.', false), ('B', 'Multa de tres a dotze mesos i inhabilitació especial per a ocupació o càrrec públic de sis mesos a dos anys.', true), ('C', 'Multa de dotze a divuit mesos i suspensió d''ocupació o càrrec públic per un temps de dos a tres anys, si és agent.', false), ('D', 'Multa de dotze a divuit mesos.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 410.2 del Codi penal, les autoritats o funcionaris NO incorren en responsabilitat criminal per no complir un manament quan aquest:', 'L''article 410.2 CP exclou la responsabilitat per desobeir mandats manifestament il·legals.', 'plcat_t17_codi_penal_ordre_public_funcionaris', (select id from public.topics where slug = 'plcat-t17-codi-penal-ordre-public-funcionaris'), 1, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1995-25444'), 'Art. 410.2 CP', 'no incurrirán en responsabilidad criminal las autoridades o funcionarios por no dar cumplimiento a un mandato que constituya una infracción manifiesta, clara y terminante de un precepto de Ley o de cualquier otra disposición general.', null, '3b694e25632dfec78de99a990f59cf3cc4eb9901ee5101474b72a1ce65f7e30b', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '3b694e25632dfec78de99a990f59cf3cc4eb9901ee5101474b72a1ce65f7e30b')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Els resulta desagradable o incòmode.', false), ('B', 'Prové d''un superior d''un altre cos.', false), ('C', 'Constitueix una infracció manifesta, clara i terminant d''un precepte de llei o de qualsevol altra disposició general.', true), ('D', 'Els ha estat comunicat verbalment.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 412.3 del Codi penal, l''autoritat o funcionari que, requerit per un particular, s''absté de prestar l''auxili a què està obligat per evitar un delicte contra la VIDA de les persones és castigat amb:', 'L''article 412.3 CP gradua la pena segons el delicte que calia evitar: contra la vida, multa de 18 a 24 mesos i inhabilitació de 3 a 6 anys; contra la integritat, llibertat sexual, salut o llibertat, multa de 12 a 18 mesos i suspensió.', 'plcat_t17_codi_penal_ordre_public_funcionaris', (select id from public.topics where slug = 'plcat-t17-codi-penal-ordre-public-funcionaris'), 3, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1995-25444'), 'Art. 412.3 CP', 'La autoridad o funcionario público que, requerido por un particular a prestar algún auxilio a que venga obligado por razón de su cargo para evitar un delito contra la vida de las personas, se abstuviera de prestarlo, será castigado con la pena de multa de dieciocho a veinticuatro meses e inhabilitación especial para empleo o cargo público por tiempo de tres a seis años.', null, '59c2641449e964561a50092cadceb86ad441f35d43aa91e765fc14cbc3f7fc1a', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '59c2641449e964561a50092cadceb86ad441f35d43aa91e765fc14cbc3f7fc1a')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Multa de divuit a vint-i-quatre mesos i inhabilitació especial per a ocupació o càrrec públic de tres a sis anys.', true), ('B', 'Multa de dotze a divuit mesos i suspensió d''un a tres anys.', false), ('C', 'Multa de tres a dotze mesos i suspensió de sis mesos a dos anys.', false), ('D', 'Presó d''un a quatre anys i inhabilitació absoluta per a ocupació o càrrec públic de sis a deu anys.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 417.1 del Codi penal, l''autoritat o funcionari que revela secrets o informacions que coneix per raó del càrrec i que no s''han de divulgar, sense que en resulti greu dany, és castigat amb:', 'L''article 417.1 CP castiga la revelació de secrets amb multa i inhabilitació; si en resulta greu dany, presó d''un a tres anys; si són secrets d''un particular, presó de dos a quatre anys (417.2).', 'plcat_t17_codi_penal_ordre_public_funcionaris', (select id from public.topics where slug = 'plcat-t17-codi-penal-ordre-public-funcionaris'), 2, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1995-25444'), 'Art. 417.1 CP', 'La autoridad o funcionario público que revelare secretos o informaciones de los que tenga conocimiento por razón de su oficio o cargo y que no deban ser divulgados, incurrirá en la pena de multa de doce a dieciocho meses e inhabilitación especial para empleo o cargo público por tiempo de uno a tres años.', null, '5e84d1f5aaadedfd5b1dfd84e6da70dd562a9fa8c0a9c9e6b467843e0ddc30a7', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '5e84d1f5aaadedfd5b1dfd84e6da70dd562a9fa8c0a9c9e6b467843e0ddc30a7')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Presó de dos a quatre anys, multa de dotze a divuit mesos i suspensió d''ocupació o càrrec públic d''un a tres anys.', false), ('B', 'Presó d''un a tres anys i inhabilitació especial de tres a cinc anys.', false), ('C', 'Multa de sis a dotze mesos.', false), ('D', 'Multa de dotze a divuit mesos i inhabilitació especial per a ocupació o càrrec públic d''un a tres anys.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 422 del Codi penal, l''autoritat o funcionari que admet una dàdiva o un regal que se li ofereix en consideració al seu càrrec o funció és castigat amb:', 'L''article 422 CP castiga el suborn impropi (admetre regals en consideració al càrrec) amb presó de sis mesos a un any i suspensió.', 'plcat_t17_codi_penal_ordre_public_funcionaris', (select id from public.topics where slug = 'plcat-t17-codi-penal-ordre-public-funcionaris'), 2, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1995-25444'), 'Art. 422 CP', 'La autoridad o funcionario público que, en provecho propio o de un tercero, admitiera, por sí o por persona interpuesta, dádiva o regalo que le fueren ofrecidos en consideración a su cargo o función, incurrirá en la pena de prisión de seis meses a un año y suspensión de empleo y cargo público de uno a tres años.', null, '829f801959b28ecf2ebd89280454bbf0f870fe4242464e710515e652e5e206b7', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '829f801959b28ecf2ebd89280454bbf0f870fe4242464e710515e652e5e206b7')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Presó de tres a sis anys, multa de dotze a vint-i-quatre mesos i inhabilitació especial de nou a dotze anys.', false), ('B', 'Presó de dos a quatre anys.', false), ('C', 'Només una sanció disciplinària.', false), ('D', 'Presó de sis mesos a un any i suspensió d''ocupació i càrrec públic d''un a tres anys.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 426 del Codi penal, queda exempt de pena pel delicte de suborn el particular que ha accedit ocasionalment a la sol·licitud de dàdiva d''un funcionari si denuncia el fet abans de l''obertura del procediment i sempre que no hagin passat més de:', 'L''article 426 CP preveu l''exempció del particular que denuncia el suborn sol·licitat abans del procediment i dins dels dos mesos següents als fets.', 'plcat_t17_codi_penal_ordre_public_funcionaris', (select id from public.topics where slug = 'plcat-t17-codi-penal-ordre-public-funcionaris'), 2, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1995-25444'), 'Art. 426 CP', 'siempre que no haya transcurrido más de dos meses desde la fecha de los hechos.', null, 'd22c83029c99ab73ddee6f85e406dcfa869f938e5f5c10b6a78e5234d5f5eb3f', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'd22c83029c99ab73ddee6f85e406dcfa869f938e5f5c10b6a78e5234d5f5eb3f')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Dos mesos des de la data dels fets.', true), ('B', 'Sis mesos des de la data dels fets.', false), ('C', 'Un any des de la data dels fets.', false), ('D', 'Quinze dies des de la data dels fets.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 530 del Codi penal, l''autoritat o funcionari que, mediant causa per delicte, acorda, practica o prolonga una privació de llibertat amb violació dels terminis o altres garanties constitucionals o legals és castigat amb:', 'L''article 530 CP castiga amb inhabilitació especial de quatre a vuit anys la privació de llibertat que vulnera terminis o garanties quan hi ha causa per delicte.', 'plcat_t17_codi_penal_ordre_public_funcionaris', (select id from public.topics where slug = 'plcat-t17-codi-penal-ordre-public-funcionaris'), 2, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1995-25444'), 'Art. 530 CP', 'La autoridad o funcionario público que, mediando causa por delito, acordare, practicare o prolongare cualquier privación de libertad de un detenido, preso o sentenciado, con violación de los plazos o demás garantías constitucionales o legales, será castigado con la pena de inhabilitación especial para empleo o cargo público por tiempo de cuatro a ocho años.', null, '020523d3a446b4c5fb94a3d2a264000191a528e7bec8edfbcef93ff3e4e1a85d', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '020523d3a446b4c5fb94a3d2a264000191a528e7bec8edfbcef93ff3e4e1a85d')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Presó de quatre a sis anys.', false), ('B', 'Inhabilitació especial per a ocupació o càrrec públic de quatre a vuit anys.', true), ('C', 'Inhabilitació absoluta de vuit a dotze anys.', false), ('D', 'Multa de quatre a deu mesos.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 532 del Codi penal, si la privació de llibertat o la incomunicació il·legals dels articles 530 i 531 es cometen per imprudència greu, es castiguen amb:', 'L''article 532 CP castiga la modalitat imprudent greu d''aquests delictes amb suspensió de sis mesos a dos anys.', 'plcat_t17_codi_penal_ordre_public_funcionaris', (select id from public.topics where slug = 'plcat-t17-codi-penal-ordre-public-funcionaris'), 3, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1995-25444'), 'Art. 532 CP', 'Si los hechos descritos en los dos artículos anteriores fueran cometidos por imprudencia grave, se castigarán con la pena de suspensión de empleo o cargo público por tiempo de seis meses a dos años.', null, 'f97bcd243c1c17f6cc3b8e6723c72659555a8a51324b782dd56ffb1e928b0b9e', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'f97bcd243c1c17f6cc3b8e6723c72659555a8a51324b782dd56ffb1e928b0b9e')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Inhabilitació especial de dos a sis anys.', false), ('B', 'Multa d''un a tres mesos.', false), ('C', 'Suspensió d''ocupació o càrrec públic de sis mesos a dos anys.', true), ('D', 'No són punibles per imprudència.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 537 del Codi penal, comet delicte l''autoritat o el funcionari que, respecte d''un detingut:', 'L''article 537 CP castiga amb multa i inhabilitació especial qui impedeix l''assistència lletrada, en procura la renúncia o no informa el detingut dels seus drets.', 'plcat_t17_codi_penal_ordre_public_funcionaris', (select id from public.topics where slug = 'plcat-t17-codi-penal-ordre-public-funcionaris'), 1, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1995-25444'), 'Art. 537 CP', 'La autoridad o funcionario público que impida u obstaculice el derecho a la asistencia de abogado al detenido o preso, procure o favorezca la renuncia del mismo a dicha asistencia o no le informe de forma inmediata y de modo que le sea comprensible de sus derechos y de las razones de su detención', null, '697bc119429ccd079cec146852236cef5e89d8b781db884a651e6a9d57e621e0', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '697bc119429ccd079cec146852236cef5e89d8b781db884a651e6a9d57e621e0')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Impedeix o obstaculitza el seu dret a l''assistència d''advocat o no l''informa de manera immediata i comprensible dels seus drets i de les raons de la detenció.', true), ('B', 'L''informa per escrit dels seus drets en una llengua que comprèn.', false), ('C', 'Comunica la detenció a la família amb el consentiment del detingut.', false), ('D', 'El trasllada a dependències separades dels altres detinguts.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 540 del Codi penal, l''autoritat o funcionari que prohibeix una reunió pacífica o la dissol fora dels casos expressament permesos per les lleis és castigat amb:', 'L''article 540 CP protegeix el dret de reunió davant la prohibició o dissolució il·legal per part d''autoritats o funcionaris.', 'plcat_t17_codi_penal_ordre_public_funcionaris', (select id from public.topics where slug = 'plcat-t17-codi-penal-ordre-public-funcionaris'), 2, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1995-25444'), 'Art. 540 CP', 'La autoridad o funcionario público que prohiba una reunión pacífica o la disuelva fuera de los casos expresamente permitidos por las Leyes, será castigado con la pena de inhabilitación especial para empleo o cargo público de cuatro a ocho años y multa de seis a nueve meses.', null, 'c3dcb98ddc28c20db52d11dd95e0c14ee96866558f73252bfbc4a29c10d5fa60', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'c3dcb98ddc28c20db52d11dd95e0c14ee96866558f73252bfbc4a29c10d5fa60')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Inhabilitació absoluta de sis a deu anys, multa de dotze a vint-i-quatre mesos i suspensió d''ocupació o càrrec.', false), ('B', 'Inhabilitació especial per a ocupació o càrrec públic de quatre a vuit anys i multa de sis a nou mesos.', true), ('C', 'Inhabilitació especial d''un a quatre anys.', false), ('D', 'Presó de sis mesos a tres anys.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 554.3 del Codi penal, s''imposen les penes de l''atemptat a qui escomet, empra violència o intimida greument:', 'L''article 554.3 CP estén la protecció de l''atemptat als bombers, sanitaris i equips de socors en emergències i a la seguretat privada identificada que coopera amb les FCS.', 'plcat_t17_codi_penal_ordre_public_funcionaris', (select id from public.topics where slug = 'plcat-t17-codi-penal-ordre-public-funcionaris'), 1, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1995-25444'), 'Art. 554.3 CP', 'b) Al personal de seguridad privada, debidamente identificado, que desarrolle actividades de seguridad privada en cooperación y bajo el mando de las Fuerzas y Cuerpos de Seguridad.', null, '93def2011fe4447a9b6d252ccb71d7fae88abaf17212fb492755455632128c55', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '93def2011fe4447a9b6d252ccb71d7fae88abaf17212fb492755455632128c55')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Qualsevol ciutadà que reclama educadament els seus drets.', false), ('B', 'Els periodistes que cobreixen una manifestació.', false), ('C', 'Els vigilants d''aparcament sense identificació.', false), ('D', 'El personal de seguretat privada degudament identificat que actua en cooperació i sota el comandament de les forces i cossos de seguretat.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 557.5 del Codi penal, qui en un lloc concorregut provoca una allau, una estampida o una reacció anàloga en el públic que posa en perill la vida o la salut de les persones és castigat amb:', 'L''article 557.5 CP tipifica la provocació d''allaus o estampides en llocs concorreguts.', 'plcat_t17_codi_penal_ordre_public_funcionaris', (select id from public.topics where slug = 'plcat-t17-codi-penal-ordre-public-funcionaris'), 1, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1995-25444'), 'Art. 557.5 CP', 'Será castigado con pena de prisión de seis meses a dos años quien en lugar concurrido provocara avalancha, estampida u otra reacción análoga en el público que pongan en situación de peligro la vida o la salud de las personas.', null, 'f423de71e6d4d4d0baa324e83b43e5010e547fe16c9d3661fa900c82dc7b717c', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'f423de71e6d4d4d0baa324e83b43e5010e547fe16c9d3661fa900c82dc7b717c')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Presó de tres a cinc anys.', false), ('B', 'Multa d''un a tres mesos.', false), ('C', 'Presó de sis mesos a dos anys.', true), ('D', 'Presó de tres a sis mesos o multa de sis a dotze mesos.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
-- Lote plcat-t18-menors-lorpm-v1 (20 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Ley Orgánica 5/2000, de 12 de enero, reguladora de la responsabilidad penal de los menores (texto consolidado, BOE)', 'https://www.boe.es/buscar/act.php?id=BOE-A-2000-641', 'boe'::public.source_kind, 'Agencia Estatal Boletín Oficial del Estado', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('plcat-t18-menors', 'Tema 18. La Llei orgànica 5/2000 de responsabilitat penal dels menors: la detenció de menors') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('policia-local') and t.slug = 'plcat-t18-menors' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 17.1 de la LO 5/2000, les autoritats i els funcionaris que intervenen en la detenció d''un menor l''han de practicar:', 'L''article 17.1 LORPM exigeix practicar la detenció del menor de la manera menys perjudicial i informar-lo immediatament, en llenguatge clar, dels fets, les raons i els drets (especialment els de l''article 520 LECrim).', 'plcat_t18_menors', (select id from public.topics where slug = 'plcat-t18-menors'), 1, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2000-641'), 'Art. 17.1 LO 5/2000', 'Las autoridades y funcionarios que intervengan en la detención de un menor deberán practicarla en la forma que menos perjudique a éste y estarán obligados a informarle, en un lenguaje claro y comprensible y de forma inmediata, de los hechos que se le imputan, de las razones de su detención y de los derechos que le asisten', null, '3c225a4d393002dbb445a1b9db89eeec8fffe7f6a882c5be75a43c5aae0eda0b', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '3c225a4d393002dbb445a1b9db89eeec8fffe7f6a882c5be75a43c5aae0eda0b')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Sempre amb emmanillament, per garantir la seguretat.', false), ('B', 'Només en presència dels seus pares o tutors.', false), ('C', 'De la manera que menys el perjudiqui, i l''han d''informar en un llenguatge clar i comprensible i de manera immediata dels fets, de les raons de la detenció i dels seus drets.', true), ('D', 'Sense informar-lo de res fins que arribi el fiscal.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 17.1 de la LO 5/2000, si el menor detingut és estranger, el fet de la detenció es notifica a les autoritats consulars:', 'L''article 17.1 LORPM limita la notificació consular als menors amb residència habitual fora d''Espanya o als casos en què ho demanen ells o els seus representants.', 'plcat_t18_menors', (select id from public.topics where slug = 'plcat-t18-menors'), 2, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2000-641'), 'Art. 17.1 LO 5/2000', 'Si el menor detenido fuera extranjero, el hecho de la detención se notificará a las correspondientes autoridades consulares cuando el menor tuviera su residencia habitual fuera de España o cuando así lo solicitaran el propio menor o sus representantes legales.', null, 'f66e034f2f1b041aa55aebe5ba17d2aa17310954de8cfe9f9782cfd0a076b14d', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'f66e034f2f1b041aa55aebe5ba17d2aa17310954de8cfe9f9782cfd0a076b14d')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'En tots els casos i sense excepció.', false), ('B', 'Només si ho autoritza el jutge de menors.', false), ('C', 'Mai d''ofici: només si ho acorda el jutge de menors a sol·licitud escrita del Ministeri Fiscal dins de les vint-i-quatre hores.', false), ('D', 'Quan el menor té la residència habitual fora d''Espanya o quan ho sol·liciten el menor mateix o els seus representants legals.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 17.2 de la LO 5/2000, el menor detingut té dret a l''entrevista reservada amb el seu advocat:', 'L''article 17.2 LORPM garanteix l''entrevista reservada amb l''advocat abans i al final de la presa de declaració.', 'plcat_t18_menors', (select id from public.topics where slug = 'plcat-t18-menors'), 2, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2000-641'), 'Art. 17.2 LO 5/2000', 'El menor detenido tendrá derecho a la entrevista reservada con su abogado con anterioridad y al término de la práctica de la diligencia de toma de declaración.', null, '6ecff8d9f4ad3bd06c69145542195109765766870c0fd9523bf242da1afba40b', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '6ecff8d9f4ad3bd06c69145542195109765766870c0fd9523bf242da1afba40b')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Només després de declarar davant el jutge de menors.', false), ('B', 'Abans i en acabar la diligència de presa de declaració.', true), ('C', 'Només si ho autoritza el Ministeri Fiscal.', false), ('D', 'Només un cop transcorregudes vint-i-quatre hores de detenció i sempre que el fiscal no s''hi oposi.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 17.2 de la LO 5/2000, si no hi ha cap persona que exerceixi la pàtria potestat, la tutela o la guarda del menor, la seva declaració es fa en presència:', 'L''article 17.2 LORPM exigeix l''advocat i els qui exerceixen la pàtria potestat, tutela o guarda; en defecte d''aquests, el fiscal, representat per persona diferent de l''instructor.', 'plcat_t18_menors', (select id from public.topics where slug = 'plcat-t18-menors'), 3, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2000-641'), 'Art. 17.2 LO 5/2000', 'En defecto de estos últimos la declaración se llevará a cabo en presencia del Ministerio Fiscal, representado por persona distinta del instructor del expediente.', null, '5b63944296db810e4e92b9c5af9ffa6058cbf169375e88b811484f42a697980c', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '5b63944296db810e4e92b9c5af9ffa6058cbf169375e88b811484f42a697980c')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Del Ministeri Fiscal, representat per una persona diferent de l''instructor de l''expedient.', true), ('B', 'Del jutge de menors.', false), ('C', 'D''un treballador social de l''ajuntament.', false), ('D', 'Només del seu advocat.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 17.3 de la LO 5/2000, mentre dura la detenció, els menors han de rebre:', 'L''article 17.3 LORPM obliga a custodiar els menors separats dels adults i a prestar-los l''assistència que necessitin segons l''edat, el sexe i les característiques individuals.', 'plcat_t18_menors', (select id from public.topics where slug = 'plcat-t18-menors'), 1, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2000-641'), 'Art. 17.3 LO 5/2000', 'recibirán los cuidados, protección y asistencia social, psicológica, médica y física que requieran, habida cuenta de su edad, sexo y características individuales.', null, '3fcc5c286152f8f21ea0458a261d4729bf3bebee0101f16b40abddc7474997f2', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '3fcc5c286152f8f21ea0458a261d4729bf3bebee0101f16b40abddc7474997f2')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Només assistència mèdica d''urgència.', false), ('B', 'La mateixa atenció que els detinguts majors d''edat, sense cap diferència.', false), ('C', 'Les cures, la protecció i l''assistència social, psicològica, mèdica i física que requereixin, tenint en compte la seva edat, el sexe i les característiques individuals.', true), ('D', 'Únicament assistència jurídica.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 17.4 de la LO 5/2000, quan s''aplica a un menor detingut el règim de l''article 520 bis de la LECrim (pròrroga de la detenció i incomunicació), la competència per a les resolucions judicials correspon:', 'L''article 17.4 LORPM remet a l''article 520 bis LECrim i atribueix al jutge de menors les resolucions judicials que preveu.', 'plcat_t18_menors', (select id from public.topics where slug = 'plcat-t18-menors'), 3, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2000-641'), 'Art. 17.4 LO 5/2000', 'Se aplicará, en su caso, lo dispuesto en el artículo 520 bis de la Ley de Enjuiciamiento Criminal, atribuyendo la competencia para las resoluciones judiciales previstas en dicho precepto al Juez de Menores.', null, 'a8cec67f201cd04ebf8c9d3396d749368071c30c4deb7ee17aa97b0990226fe7', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'a8cec67f201cd04ebf8c9d3396d749368071c30c4deb7ee17aa97b0990226fe7')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Al jutge d''instrucció de guàrdia.', false), ('B', 'Al jutge central d''instrucció.', false), ('C', 'Al Ministeri Fiscal.', false), ('D', 'Al jutge de menors.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 17.6 de la LO 5/2000, el jutge competent per al procediment d''habeas corpus en relació amb un menor és:', 'L''article 17.6 LORPM atribueix l''habeas corpus del menor al jutge d''instrucció del lloc on es troba; si no consta, al del lloc de la detenció, i en darrer terme al de les últimes notícies.', 'plcat_t18_menors', (select id from public.topics where slug = 'plcat-t18-menors'), 1, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2000-641'), 'Art. 17.6 LO 5/2000', 'El Juez competente para el procedimiento de hábeas corpus en relación a un menor será el Juez de Instrucción del lugar en el que se encuentre el menor privado de libertad', null, 'ad20b867720bc22f411177e6bb25675fb9b182fd088101828113de8151a5db00', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'ad20b867720bc22f411177e6bb25675fb9b182fd088101828113de8151a5db00')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El jutge d''instrucció del lloc on es troba el menor privat de llibertat.', true), ('B', 'El jutge de menors del lloc on resideixen habitualment els pares o els representants legals del menor.', false), ('C', 'El jutge central de menors de l''Audiència Nacional.', false), ('D', 'El jutge de pau del municipi on es va cometre el fet.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 3 de la LO 5/2000, quan l''autor dels fets és menor de catorze anys, el Ministeri Fiscal ha de remetre testimoni dels particulars que consideri necessaris:', 'L''article 3 LORPM exclou la responsabilitat penal del menor de catorze anys i encarrega a l''entitat pública de protecció de menors la valoració i les mesures de protecció.', 'plcat_t18_menors', (select id from public.topics where slug = 'plcat-t18-menors'), 2, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2000-641'), 'Art. 3 LO 5/2000', 'El Ministerio Fiscal deberá remitir a la entidad pública de protección de menores testimonio de los particulares que considere precisos respecto al menor, a fin de valorar su situación, y dicha entidad habrá de promover las medidas de protección adecuadas', null, 'ccaba63214d1b574185b7a8a11a942b527cca9ecaf12b22e153629081f3dec7e', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'ccaba63214d1b574185b7a8a11a942b527cca9ecaf12b22e153629081f3dec7e')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Al jutge de menors, perquè li imposi la mesura educativa més adequada a les seves circumstàncies personals i familiars.', false), ('B', 'A l''entitat pública de protecció de menors, perquè en valori la situació i promogui les mesures de protecció adequades.', true), ('C', 'Al jutge d''instrucció, perquè obri diligències penals.', false), ('D', 'Al centre escolar del menor.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 2.4 de la LO 5/2000, la competència per conèixer dels delictes de terrorisme (articles 571 a 580 del Codi penal) comesos per menors correspon:', 'L''article 2.4 LORPM atribueix al Jutjat Central de Menors de l''Audiència Nacional els delictes dels articles 571 a 580 CP i els comesos per menors a l''estranger que corresponguin a la jurisdicció espanyola.', 'plcat_t18_menors', (select id from public.topics where slug = 'plcat-t18-menors'), 2, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2000-641'), 'Art. 2.4 LO 5/2000', 'La competencia para conocer de los delitos previstos en los artículos 571 a 580 del Código Penal corresponderá al Juzgado Central de Menores de la Audiencia Nacional.', null, 'dbd90ac7aae55adf27d571d18018a844ed5bd8bafe1ec43c554f1ad02895b455', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'dbd90ac7aae55adf27d571d18018a844ed5bd8bafe1ec43c554f1ad02895b455')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Al Jutjat Central de Menors de l''Audiència Nacional.', true), ('B', 'Al jutge de menors del lloc dels fets.', false), ('C', 'A la Sala Penal de l''Audiència Nacional, constituïda en secció especial de menors.', false), ('D', 'Al jutge central d''instrucció.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 6 de la LO 5/2000, en el procediment de menors, qui dirigeix personalment la investigació dels fets i ordena a la policia judicial les actuacions necessàries?', 'L''article 6 LORPM encarrega al Ministeri Fiscal la defensa dels drets dels menors i la direcció personal de la investigació, ordenant a la policia judicial les actuacions de comprovació.', 'plcat_t18_menors', (select id from public.topics where slug = 'plcat-t18-menors'), 1, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2000-641'), 'Art. 6 LO 5/2000', 'para lo cual dirigirá personalmente la investigación de los hechos y ordenará que la policía judicial practique las actuaciones necesarias para la comprobación de aquéllos y de la participación del menor en los mismos', null, '314ad6cc07b44c29b215b7614630ca6eeac4ab3f57f9f92c737a8b0546292c7e', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '314ad6cc07b44c29b215b7614630ca6eeac4ab3f57f9f92c737a8b0546292c7e')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El jutge de menors.', false), ('B', 'El jutge d''instrucció.', false), ('C', 'El Ministeri Fiscal.', true), ('D', 'L''equip tècnic.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 16.2 de la LO 5/2000, qui té notícia d''un fet delictiu presumptament comès per un menor de divuit anys ho ha de posar en coneixement de:', 'L''article 16 LORPM atribueix la instrucció al Ministeri Fiscal, que és qui rep la notícia del fet i n''admet o no la denúncia.', 'plcat_t18_menors', (select id from public.topics where slug = 'plcat-t18-menors'), 1, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2000-641'), 'Art. 16.2 LO 5/2000', 'Quienes tuvieren noticia de algún hecho de los indicados en el apartado anterior, presuntamente cometido por un menor de dieciocho años, deberán ponerlo en conocimiento del Ministerio Fiscal', null, '5b4cc3236bb43616b219356e5fc35e9e83faa7f78e6bac66f0154ff7d30ef036', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '5b4cc3236bb43616b219356e5fc35e9e83faa7f78e6bac66f0154ff7d30ef036')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El jutge de menors.', false), ('B', 'L''entitat pública de protecció de menors.', false), ('C', 'El director del centre educatiu.', false), ('D', 'El Ministeri Fiscal.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 7.1.k) de la LO 5/2000, la mesura de prestacions en benefici de la comunitat:', 'L''article 7.1.k) LORPM defineix aquesta mesura com a activitats no retribuïdes d''interès social que no es poden imposar sense consentiment del menor.', 'plcat_t18_menors', (select id from public.topics where slug = 'plcat-t18-menors'), 2, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2000-641'), 'Art. 7.1.k LO 5/2000', 'k) Prestaciones en beneficio de la comunidad. La persona sometida a esta medida, que no podrá imponerse sin su consentimiento, ha de realizar las actividades no retribuidas que se le indiquen', null, 'a068cb760c567f491bfd519b173c08303a2aae0186b59e73491ec9c21909705c', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'a068cb760c567f491bfd519b173c08303a2aae0186b59e73491ec9c21909705c')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'S''imposa sempre, encara que el menor s''hi oposi.', false), ('B', 'No es pot imposar sense el consentiment del menor.', true), ('C', 'Només es pot imposar a menors de setze o disset anys i per un màxim de cinquanta hores.', false), ('D', 'Consisteix en activitats retribuïdes.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 7.1.m) de la LO 5/2000, en què consisteix la mesura d''amonestació?', 'L''article 7.1.m) LORPM defineix l''amonestació com la reprensió feta pel jutge de menors per fer comprendre al menor la gravetat dels fets.', 'plcat_t18_menors', (select id from public.topics where slug = 'plcat-t18-menors'), 1, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2000-641'), 'Art. 7.1.m LO 5/2000', 'm) Amonestación. Esta medida consiste en la reprensión de la persona llevada a cabo por el Juez de Menores y dirigida a hacerle comprender la gravedad de los hechos cometidos', null, '3546dfe9cae9466bfa42822ff5731836d3fa11fb243147a61c94d9e7cd94f9ae', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '3546dfe9cae9466bfa42822ff5731836d3fa11fb243147a61c94d9e7cd94f9ae')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'En una multa econòmica imposada als pares.', false), ('B', 'En la reprensió del menor per part del jutge de menors perquè comprengui la gravetat dels fets i les seves conseqüències.', true), ('C', 'En la permanència al domicili durant un cap de setmana.', false), ('D', 'En una advertència escrita de la policia local.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 7.1.b) de la LO 5/2000, en la mesura d''internament en règim semiobert, el menor:', 'L''article 7.1.b) LORPM distingeix el semiobert (resideix al centre i fa fora algunes activitats) del tancat (tot dins del centre) i de l''obert (activitats a l''entorn).', 'plcat_t18_menors', (select id from public.topics where slug = 'plcat-t18-menors'), 2, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2000-641'), 'Art. 7.1.b LO 5/2000', 'b) Internamiento en régimen semiabierto. Las personas sometidas a esta medida residirán en el centro, pero podrán realizar fuera del mismo alguna o algunas de las actividades formativas, educativas, laborales y de ocio', null, '8b47424e869b1a85e4439cb004b9b7b987e7be106a434e5ef9e7bd9e16afbce1', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '8b47424e869b1a85e4439cb004b9b7b987e7be106a434e5ef9e7bd9e16afbce1')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Resideix al seu domicili i acudeix al centre durant el dia.', false), ('B', 'Fa totes les activitats dins del centre.', false), ('C', 'Resideix amb una altra família seleccionada.', false), ('D', 'Resideix al centre, però pot fer fora d''aquest algunes de les activitats formatives, educatives, laborals i d''oci.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'En quin d''aquests casos NO es pot imposar mai la mesura d''internament en règim tancat, segons l''article 9 de la LO 5/2000?', 'L''article 9.2 LORPM admet l''internament tancat en delictes greus, menys greus violents o comesos en grup o banda; l''article 9.4 l''exclou per a les accions o omissions imprudents.', 'plcat_t18_menors', (select id from public.topics where slug = 'plcat-t18-menors'), 2, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2000-641'), 'Art. 9.4 LO 5/2000', 'Las acciones u omisiones imprudentes no podrán ser sancionadas con medidas de internamiento en régimen cerrado.', null, '11e9a2748f4ec12678ac241b4bc964bd6db7b2877f6645f0ad2ad529399d13b7', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '11e9a2748f4ec12678ac241b4bc964bd6db7b2877f6645f0ad2ad529399d13b7')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Quan els fets són accions o omissions imprudents.', true), ('B', 'Quan els fets estan tipificats com a delicte greu.', false), ('C', 'Quan és un delicte menys greu comès amb violència o intimidació en les persones.', false), ('D', 'Quan els fets delictius es cometen en grup.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 9.3 de la LO 5/2000, amb caràcter general, la mesura de prestacions en benefici de la comunitat no pot superar:', 'L''article 9.3 LORPM limita en general les mesures a dos anys, les prestacions en benefici de la comunitat a cent hores i la permanència de cap de setmana a vuit caps de setmana.', 'plcat_t18_menors', (select id from public.topics where slug = 'plcat-t18-menors'), 3, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2000-641'), 'Art. 9.3 LO 5/2000', 'La medida de prestaciones en beneficio de la comunidad no podrá superar las cien horas.', null, '0307c8924fca1871b7bb92a41ee952b977008864d9148c87eff22a2230df3430', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '0307c8924fca1871b7bb92a41ee952b977008864d9148c87eff22a2230df3430')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Cinquanta hores.', false), ('B', 'Cent cinquanta hores.', false), ('C', 'Cent hores.', true), ('D', 'Dues-centes hores.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 15.1 de la LO 5/2000, els fets delictius comesos per menors que constitueixen un delicte menys greu prescriuen:', 'L''article 15.1 LORPM fixa la prescripció: cinc anys (delicte greu amb pena superior a deu anys), tres anys (altres greus), un any (menys greus) i tres mesos (faltes).', 'plcat_t18_menors', (select id from public.topics where slug = 'plcat-t18-menors'), 3, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2000-641'), 'Art. 15.1 LO 5/2000', '4.º Al año, cuando se trate de un delito menos grave.', null, '6a48376c8b9e69359253569000715e09adaaef8ee5e6feb1803bc69c9e033165', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '6a48376c8b9e69359253569000715e09adaaef8ee5e6feb1803bc69c9e033165')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Als tres mesos.', false), ('B', 'Als tres anys.', false), ('C', 'A l''any.', true), ('D', 'Als cinc anys.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 28.3 de la LO 5/2000, el temps màxim de la mesura cautelar d''internament és de:', 'L''article 28.3 LORPM limita l''internament cautelar a sis mesos, prorrogables per un màxim de tres mesos a instància del fiscal i per interlocutòria motivada.', 'plcat_t18_menors', (select id from public.topics where slug = 'plcat-t18-menors'), 2, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2000-641'), 'Art. 28.3 LO 5/2000', 'El tiempo máximo de la medida cautelar de internamiento será de seis meses, y podrá prorrogarse, a instancia del Ministerio Fiscal, previa audiencia del letrado del menor y mediante auto motivado, por otros tres meses como máximo.', null, '04c775ee39e71b02ddede24a8f3bdc2026d01171dd37f0740a4a94de36b808d7', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '04c775ee39e71b02ddede24a8f3bdc2026d01171dd37f0740a4a94de36b808d7')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Sis mesos, prorrogables per tres mesos més com a màxim.', true), ('B', 'Tres mesos, prorrogables successivament per períodes iguals mentre duri la instrucció.', false), ('C', 'Un any, sense pròrroga.', false), ('D', 'Quaranta-vuit hores.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 18 de la LO 5/2000, el Ministeri Fiscal NO pot desistir de la incoació de l''expedient, i l''ha d''incoar, quan:', 'L''article 18 LORPM permet el desistiment en delictes menys greus sense violència o lleus, però obliga a incoar l''expedient si el menor ja ha comès fets de la mateixa naturalesa.', 'plcat_t18_menors', (select id from public.topics where slug = 'plcat-t18-menors'), 2, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2000-641'), 'Art. 18 LO 5/2000', 'No obstante, cuando conste que el menor ha cometido con anterioridad otros hechos de la misma naturaleza, el Ministerio Fiscal deberá incoar el expediente', null, 'a0209624b4e4a1864e8d51801b94d216e5605b06d8c3c7939b45ab14ea69895e', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'a0209624b4e4a1864e8d51801b94d216e5605b06d8c3c7939b45ab14ea69895e')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Els fets constitueixen un delicte lleu.', false), ('B', 'Consta que el menor ha comès amb anterioritat altres fets de la mateixa naturalesa.', true), ('C', 'La víctima no s''ha personat a l''expedient.', false), ('D', 'El menor té catorze o quinze anys.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 14.3 de la LO 5/2000, quan la mesura d''internament en règim tancat no ha acabat en complir la persona vint-i-un anys, el jutge de menors, amb caràcter general:', 'L''article 14.3 LORPM preveu el pas a centre penitenciari als vint-i-un anys, llevat que excepcionalment el jutge consideri procedent mantenir-la o modificar-la.', 'plcat_t18_menors', (select id from public.topics where slug = 'plcat-t18-menors'), 3, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2000-641'), 'Art. 14.3 LO 5/2000', 'cuando las medidas de internamiento en régimen cerrado sean impuestas a quien haya cumplido veintiún años de edad o, habiendo sido impuestas con anterioridad, no hayan finalizado su cumplimiento al alcanzar la persona dicha edad, el Juez de Menores, oídos el Ministerio Fiscal, el letrado del menor, el equipo técnico y la entidad pública de protección o reforma de menores, ordenará su cumplimiento en centro penitenciario conforme al régimen general previsto en la Ley Orgánica General Penitenciaria', null, '9713a01f92bc62964b17e07ef5f44d2c8d9520cfbf4c874ba58356c84cd05c27', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '9713a01f92bc62964b17e07ef5f44d2c8d9520cfbf4c874ba58356c84cd05c27')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'La declara extingida automàticament.', false), ('B', 'La substitueix sempre per llibertat vigilada.', false), ('C', 'N''ordena el compliment en un centre de menors fins als vint-i-cinc anys.', false), ('D', 'N''ordena el compliment en un centre penitenciari conforme al règim general de la Llei orgànica general penitenciària.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
-- Lote plcat-t19-violencia-masclista-cp-v1 (1 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Ley Orgánica 10/1995, de 23 de noviembre, del Código Penal (texto consolidado, BOE)', 'https://www.boe.es/buscar/act.php?id=BOE-A-1995-25444', 'boe'::public.source_kind, 'Agencia Estatal Boletín Oficial del Estado', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('plcat-t19-violencia-masclista', 'Tema 19. Violència masclista i domèstica: Llei 5/2008, LO 1/2004 i ordre de protecció') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('policia-local') and t.slug = 'plcat-t19-violencia-masclista' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 153.3 del Codi penal, quina d''aquestes circumstàncies NO comporta imposar les penes dels apartats 1 i 2 en la meitat superior?', 'L''article 153.3 CP agreuja la pena quan el fet es comet en presència de menors, amb armes, al domicili comú o de la víctima, o trencant una pena o mesura de l''article 48 CP.', 'plcat_t19_violencia_masclista', (select id from public.topics where slug = 'plcat-t19-violencia-masclista'), 2, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1995-25444'), 'Art. 153.3 CP', 'Las penas previstas en los apartados 1 y 2 se impondrán en su mitad superior cuando el delito se perpetre en presencia de menores, o utilizando armas, o tenga lugar en el domicilio común o en el domicilio de la víctima', null, '24bab78ee0409542073fc9071967b2be6da6dc4ada7d4716a1af17d8cb3fae73', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '24bab78ee0409542073fc9071967b2be6da6dc4ada7d4716a1af17d8cb3fae73')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Que el delicte es cometi en presència de menors.', false), ('B', 'Que l''autor sigui reincident en delictes contra el patrimoni.', true), ('C', 'Que es cometi utilitzant armes.', false), ('D', 'Que tingui lloc en el domicili comú o en el de la víctima.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
-- Lote plcat-t19-violencia-masclista-lecrim-v1 (2 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Real Decreto de 14 de septiembre de 1882, Ley de Enjuiciamiento Criminal (texto consolidado, BOE)', 'https://www.boe.es/buscar/act.php?id=BOE-A-1882-6036', 'boe'::public.source_kind, 'Agencia Estatal Boletín Oficial del Estado', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('plcat-t19-violencia-masclista', 'Tema 19. Violència masclista i domèstica: Llei 5/2008, LO 1/2004 i ordre de protecció') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('policia-local') and t.slug = 'plcat-t19-violencia-masclista' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 544 ter.4 de la LECrim, l''audiència urgent per resoldre la sol·licitud d''ordre de protecció s''ha de celebrar en un termini màxim de:', 'L''article 544 ter.4 LECrim estableix que, si no es pot fer durant el servei de guàrdia, l''audiència s''ha de convocar com més aviat millor i, en tot cas, en setanta-dues hores.', 'plcat_t19_violencia_masclista', (select id from public.topics where slug = 'plcat-t19-violencia-masclista'), 1, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1882-6036'), 'Art. 544 ter.4 LECrim', 'En cualquier caso la audiencia habrá de celebrarse en un plazo máximo de setenta y dos horas desde la presentación de la solicitud.', null, 'd72cf56b541fa4f6d5d62403663cb96777f58732326fcf522d35d0b2e207c7c1', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'd72cf56b541fa4f6d5d62403663cb96777f58732326fcf522d35d0b2e207c7c1')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Vint-i-quatre hores des de la presentació de la sol·licitud.', false), ('B', 'Quaranta-vuit hores des de la detenció del presumpte agressor.', false), ('C', 'Cinc dies hàbils des de la presentació de la sol·licitud.', false), ('D', 'Setanta-dues hores des de la presentació de la sol·licitud.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 544 ter.7 de la LECrim, les mesures de caràcter civil contingudes en l''ordre de protecció tenen una vigència temporal de:', 'L''article 544 ter.7 LECrim fixa trenta dies; si dins d''aquest termini s''inicia un procés de família, les mesures es mantenen trenta dies més des de la demanda, fins que el jutge civil les ratifiqui, modifiqui o deixi sense efecte.', 'plcat_t19_violencia_masclista', (select id from public.topics where slug = 'plcat-t19-violencia-masclista'), 3, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1882-6036'), 'Art. 544 ter.7 LECrim', 'Las medidas de carácter civil contenidas en la orden de protección tendrán una vigencia temporal de treinta días.', null, 'eb689c97279ce0aba1299a824c1b2952c293c07ff9a146688828ccb288c53d28', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'eb689c97279ce0aba1299a824c1b2952c293c07ff9a146688828ccb288c53d28')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Seixanta dies.', false), ('B', 'Quinze dies.', false), ('C', 'Trenta dies.', true), ('D', 'Sis mesos.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
-- Lote plcat-t19-violencia-masclista-lovg-v1 (1 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Ley Orgánica 1/2004, de 28 de diciembre, de Medidas de Protección Integral contra la Violencia de Género (texto consolidado, BOE)', 'https://www.boe.es/buscar/act.php?id=BOE-A-2004-21760', 'boe'::public.source_kind, 'Agencia Estatal Boletín Oficial del Estado', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('plcat-t19-violencia-masclista', 'Tema 19. Violència masclista i domèstica: Llei 5/2008, LO 1/2004 i ordre de protecció') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('policia-local') and t.slug = 'plcat-t19-violencia-masclista' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 20.1 de la LO 1/2004, les víctimes de violència de gènere tenen dret a rebre assessorament jurídic gratuït:', 'L''article 20.1 LOVG reconeix l''assessorament jurídic gratuït just abans de denunciar i la defensa i representació gratuïtes en tots els processos que hi tinguin causa.', 'plcat_t19_violencia_masclista', (select id from public.topics where slug = 'plcat-t19-violencia-masclista'), 2, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2004-21760'), 'Art. 20.1 LO 1/2004', 'Las víctimas de violencia de género tienen derecho a recibir asesoramiento jurídico gratuito en el momento inmediatamente previo a la interposición de la denuncia', null, '96cc1e57e57a8484ca96d685d1732b3af0b8a1c55930566db9374218e0ac5bb4', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '96cc1e57e57a8484ca96d685d1732b3af0b8a1c55930566db9374218e0ac5bb4')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'En el moment immediatament previ a la interposició de la denúncia.', true), ('B', 'Només un cop admesa a tràmit la denúncia.', false), ('C', 'Només si acrediten insuficiència de recursos per litigar.', false), ('D', 'Només en la fase de judici oral.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
-- Lote plcat-t19-violencia-masclista-lvm-v1 (16 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Ley 5/2008, de 24 de abril, del derecho de las mujeres a erradicar la violencia machista (Cataluña) (texto consolidado, BOE)', 'https://www.boe.es/buscar/act.php?id=BOE-A-2008-9294', 'boe'::public.source_kind, 'Agencia Estatal Boletín Oficial del Estado', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('plcat-t19-violencia-masclista', 'Tema 19. Violència masclista i domèstica: Llei 5/2008, LO 1/2004 i ordre de protecció') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('policia-local') and t.slug = 'plcat-t19-violencia-masclista' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 2.1 de la Llei 5/2008, tenen garantits els drets que reconeix la llei les dones en situació de violència masclista que viuen o treballen a Catalunya:', 'L''article 2.1 de la Llei 5/2008 garanteix els drets a totes les dones (i als seus fills i filles dependents) que viuen o treballen a Catalunya, sense perjudici de la legislació d''estrangeria i dels requisits de cada prestació.', 'plcat_t19_violencia_masclista', (select id from public.topics where slug = 'plcat-t19-violencia-masclista'), 1, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2008-9294'), 'Art. 2.1 Llei 5/2008', 'que vivan o trabajen en Cataluña y con independencia de la vecindad civil, la nacionalidad o la situación administrativa y personal, tienen garantizados los derechos que la presente ley les reconoce', null, '7b65a18a2b48ebdbd69f5bf78303a399ff8814c66fee38a05a3bcaee1b387d05', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '7b65a18a2b48ebdbd69f5bf78303a399ff8814c66fee38a05a3bcaee1b387d05')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Només si tenen la nacionalitat espanyola o la d''un altre Estat membre de la Unió Europea.', false), ('B', 'Amb independència de el veïnatge civil, la nacionalitat o la situació administrativa i personal.', true), ('C', 'Només si tenen veïnatge civil català.', false), ('D', 'Només si estan empadronades a Catalunya i acrediten una residència legal d''un any com a mínim.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 2.2 de la Llei 5/2008, les referències a les dones que fa la llei s''entén que inclouen:', 'L''article 2.2 de la Llei 5/2008, modificat per la Llei 17/2020, estén les referències a les dones a les nenes i adolescents, incloses les persones transgènere.', 'plcat_t19_violencia_masclista', (select id from public.topics where slug = 'plcat-t19-violencia-masclista'), 2, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2008-9294'), 'Art. 2.2 Llei 5/2008', 'Las referencias a las mujeres incluidas en la presente ley se entiende que incluyen a las niñas y las adolescentes, y, por lo tanto, también a las mujeres, niñas y adolescentes transgénero.', null, 'c49deb2c1c7fd72897c1d8fc9a5c065d26806fd03f385097199531f7876ed229', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'c49deb2c1c7fd72897c1d8fc9a5c065d26806fd03f385097199531f7876ed229')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Les nenes i les adolescents, incloses les transgènere.', true), ('B', 'Només les dones majors d''edat.', false), ('C', 'Només les dones majors de setze anys.', false), ('D', 'Les dones majors d''edat i, si conviuen amb elles, els seus fills i filles.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 3 de la Llei 5/2008, el maltractament addicional exercit contra les dones en situació de violència masclista com a conseqüència dels dèficits de les intervencions dels organismes responsables s''anomena:', 'L''article 3.i) de la Llei 5/2008 defineix la victimització secundària o revictimització; la violència de segon ordre (art. 4.2.g) és la que s''exerceix contra les persones que donen suport a les víctimes.', 'plcat_t19_violencia_masclista', (select id from public.topics where slug = 'plcat-t19-violencia-masclista'), 3, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2008-9294'), 'Art. 3.i Llei 5/2008', 'i) Victimización secundaria o revictimización: el maltrato adicional ejercido contra las mujeres que se hallan en situaciones de violencia machista y sus hijos e hijas, como consecuencia directa o indirecta de los déficits cuantitativos y cualitativos de las intervenciones llevadas a cabo por los organismos responsables', null, 'ea17e34e1e688a7c38809f4b070a5752f2b9f3f694afa199f2b670f02ad21e64', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'ea17e34e1e688a7c38809f4b070a5752f2b9f3f694afa199f2b670f02ad21e64')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Violència de segon ordre.', false), ('B', 'Violència ambiental.', false), ('C', 'Victimització secundària o revictimització.', true), ('D', 'Violència institucional per manca de diligència deguda.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 4.2 de la Llei 5/2008, la violència física o psicològica, les represàlies, les humiliacions i la persecució exercides contra les persones que donen suport a les víctimes de violència masclista és:', 'L''article 4.2.g) de la Llei 5/2008 defineix la violència de segon ordre i hi inclou els actes que impedeixen la prevenció, la detecció, l''atenció i la recuperació de les dones.', 'plcat_t19_violencia_masclista', (select id from public.topics where slug = 'plcat-t19-violencia-masclista'), 2, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2008-9294'), 'Art. 4.2.g Llei 5/2008', 'g) Violencia de segundo orden: consiste en la violencia física o psicológica, las represalias, las humillaciones y la persecución ejercidas contra las personas que apoyan a las víctimas de violencia machista.', null, '2a237fed6daea7810963c9d964ca7d4a8ab9c9ef956f989bcd0c9144e96b74ab', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '2a237fed6daea7810963c9d964ca7d4a8ab9c9ef956f989bcd0c9144e96b74ab')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Violència vicària.', false), ('B', 'Violència institucional.', false), ('C', 'Violència psicològica ambiental.', false), ('D', 'Violència de segon ordre.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 4.2.h) de la Llei 5/2008, la violència vicària consisteix en:', 'L''article 4.2.h) de la Llei 5/2008 defineix la violència vicària; la violència sobre béns, propietats o animals és la violència ambiental, inclosa en la psicològica (art. 4.2.b).', 'plcat_t19_violencia_masclista', (select id from public.topics where slug = 'plcat-t19-violencia-masclista'), 1, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2008-9294'), 'Art. 4.2.h Llei 5/2008', 'h) Violencia vicaria: consiste en cualquier tipo de violencia ejercida contra los hijos e hijas con el fin de provocar daño psicológico a la madre.', null, 'c046f0c75ea7bffae445a1503f27a6119efe6d018b370c4461f8a50de43c2e49', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'c046f0c75ea7bffae445a1503f27a6119efe6d018b370c4461f8a50de43c2e49')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'La violència exercida sobre els béns i propietats de la dona.', false), ('B', 'La violència contra els fills i filles per provocar dany psicològic a la mare.', true), ('C', 'La violència, les represàlies i la persecució exercides contra les persones que donen suport a la víctima.', false), ('D', 'La violència exercida per mitjans digitals.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 4.2 de la Llei 5/2008, l''impagament reiterat i injustificat de pensions alimentàries estipulades en cas de separació o divorci és una forma de:', 'L''article 4.2.e) de la Llei 5/2008 inclou en la violència econòmica la privació intencionada de recursos, l''impagament reiterat de pensions, l''obstaculització de la disposició dels recursos i l''apropiació il·legítima de béns.', 'plcat_t19_violencia_masclista', (select id from public.topics where slug = 'plcat-t19-violencia-masclista'), 1, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2008-9294'), 'Art. 4.2.e Llei 5/2008', 'e) Violencia económica: consiste en la privación intencionada y no justificada de recursos para el bienestar físico o psicológico de una mujer y, si procede, de sus hijos o hijas, en el impago reiterado e injustificado de pensiones alimenticias estipuladas en caso de separación o divorcio', null, '02fa44956fbd058b388820217e4f24b68537c494b7ff7a1d58c485ca6208de83', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '02fa44956fbd058b388820217e4f24b68537c494b7ff7a1d58c485ca6208de83')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Violència psicològica.', false), ('B', 'Violència institucional.', false), ('C', 'Violència econòmica.', true), ('D', 'Violència de segon ordre.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 5 de la Llei 5/2008, la utilització de la síndrome d''alienació parental és una manifestació de violència:', 'L''article 5, sisè, de la Llei 5/2008 regula la violència en l''àmbit institucional (accions i omissions d''autoritats i personal públic) i hi inclou expressament la utilització de la síndrome d''alienació parental.', 'plcat_t19_violencia_masclista', (select id from public.topics where slug = 'plcat-t19-violencia-masclista'), 3, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2008-9294'), 'Art. 5, sisè, Llei 5/2008', 'La utilización del síndrome de alienación parental también es violencia institucional.', null, '3feb0ad533c9ffeae4f8ae649bb684ab5dfd5515ffc734037cb441cebb17df22', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '3feb0ad533c9ffeae4f8ae649bb684ab5dfd5515ffc734037cb441cebb17df22')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'En l''àmbit institucional.', true), ('B', 'En l''àmbit familiar.', false), ('C', 'En l''àmbit de la parella.', false), ('D', 'En l''àmbit social o comunitari.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Entre els principis orientadors de les intervencions dels poders públics, l''article 7 de la Llei 5/2008 estableix, quan hi ha implicada una dona que pateix o ha patit violència masclista en l''àmbit de la parella o familiar:', 'L''article 7.u) de la Llei 5/2008 prohibeix la mediació en aquests casos; l''article 61.2 també impedeix aplicar tècniques de mediació als punts de trobada quan hi ha violència acreditada.', 'plcat_t19_violencia_masclista', (select id from public.topics where slug = 'plcat-t19-violencia-masclista'), 2, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2008-9294'), 'Art. 7.u Llei 5/2008', 'u) La prohibición de la mediación si está implicada una mujer que ha sufrido o sufre cualquier forma de violencia machista en el ámbito de la pareja o en el ámbito familiar.', null, '7767ac7c4381a7de3f74754e611fbb08c11be16974b87c8665fa7824b3990d07', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '7767ac7c4381a7de3f74754e611fbb08c11be16974b87c8665fa7824b3990d07')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'La mediació obligatòria abans de qualsevol procediment judicial.', false), ('B', 'La mediació voluntària, si la dona hi consent per escrit.', false), ('C', 'La mediació només quan hi ha fills menors d''edat.', false), ('D', 'La prohibició de la mediació.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 30.3 de la Llei 5/2008, quin dels següents NO és un dels objectius dels dispositius de protecció destinats a les dones en risc o en situació de violència masclista?', 'L''article 30.3 de la Llei 5/2008 fixa tres objectius dels dispositius de protecció: localització i comunicació permanent, atenció immediata a distància i protecció immediata en emergències.', 'plcat_t19_violencia_masclista', (select id from public.topics where slug = 'plcat-t19-violencia-masclista'), 2, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2008-9294'), 'Art. 30.3 Llei 5/2008', 'a) Facilitar la localización y la comunicación permanente. b) Proporcionar una atención inmediata a distancia. c) Facilitar la protección inmediata y adecuada ante situaciones de emergencia.', null, 'b72e0b21d61c979c0f891faef9d7a16890f528da9f4997bf8e56631cfa3e31c0', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'b72e0b21d61c979c0f891faef9d7a16890f528da9f4997bf8e56631cfa3e31c0')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Facilitar la localització i la comunicació permanent.', false), ('B', 'Proporcionar una atenció immediata a distància.', false), ('C', 'Facilitar la protecció immediata i adequada davant situacions d''emergència.', false), ('D', 'Substituir la denúncia judicial per una comunicació policial.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 31.5 de la Llei 5/2008, l''avaluació de risc que fa la Policia de la Generalitat-Mossos d''Esquadra:', 'L''article 31.5 de la Llei 5/2008 exigeix una avaluació individualitzada que tingui en compte, entre d''altres, la percepció subjectiva de risc de la dona, la relació amb l''agressor i els procediments judicials en curs, i que inclogui el risc per als fills i filles.', 'plcat_t19_violencia_masclista', (select id from public.topics where slug = 'plcat-t19-violencia-masclista'), 3, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2008-9294'), 'Art. 31.5 Llei 5/2008', 'La evaluación de riesgo por parte de la Policía de la Generalidad-Mossos d’Esquadra debe ser individualizada y adaptada al tipo de violencia concreta. […] La evaluación de riesgo debe incluir el riesgo sufrido por los hijos e hijas de la mujer.', null, '3d4768eb785dc85c1743e15ffc9d22e67710d2f0b22a89ea8a81ae813565fe0c', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '3d4768eb785dc85c1743e15ffc9d22e67710d2f0b22a89ea8a81ae813565fe0c')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Ha de ser estandarditzada i idèntica per a tots els tipus de violència, per garantir la igualtat de tracte.', false), ('B', 'Ha de ser individualitzada i incloure el risc per als fills i filles.', true), ('C', 'Només ha de tenir en compte la duració de les violències patides.', false), ('D', 'Només s''ha de fer si hi ha un procediment judicial en curs entre la dona i l''agressor.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 31.6 de la Llei 5/2008, quan una dona va a una comissaria de la policia local a denunciar violència masclista, els agents han de:', 'L''article 31.6 de la Llei 5/2008 obliga els agents dels Mossos d''Esquadra o de les policies locals a requerir un lletrat al col·legi d''advocats des de l''inici de la denúncia.', 'plcat_t19_violencia_masclista', (select id from public.topics where slug = 'plcat-t19-violencia-masclista'), 1, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2008-9294'), 'Art. 31.6 Llei 5/2008', 'los agentes de la Policía de la Generalidad-Mossos d’Esquadra o de las policías locales de Cataluña deben requerir al colegio de abogados la presencia de un letrado para garantizar la asistencia letrada desde el momento inicial de la denuncia.', null, '17104cd946d7c5c5a7c1c864f4aff419d330fc7c71a6d6fcdd09921ae7d6d969', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '17104cd946d7c5c5a7c1c864f4aff419d330fc7c71a6d6fcdd09921ae7d6d969')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Derivar-la sempre als Mossos d''Esquadra, que són els únics competents per recollir aquest tipus de denúncies.', false), ('B', 'Recollir la denúncia i informar-la que pot designar advocat en la fase judicial.', false), ('C', 'Requerir al col·legi d''advocats la presència d''un lletrat des de l''inici de la denúncia.', true), ('D', 'Requerir la presència del Ministeri Fiscal a la comissaria.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 33 de la Llei 5/2008, l''atestat elaborat per les forces i cossos de seguretat que han presenciat directament alguna manifestació de violència masclista és, a efectes d''accedir als drets de reparació:', 'L''article 33.1 considera mitjans de prova qualificats la sentència, l''ordre de protecció vigent i l''informe de la Inspecció de Treball; l''atestat policial és un mitjà específic de l''apartat 2.b).', 'plcat_t19_violencia_masclista', (select id from public.topics where slug = 'plcat-t19-violencia-masclista'), 3, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2008-9294'), 'Art. 33.2.b Llei 5/2008', 'En ausencia de alguno de los medios establecidos por el apartado 1, son medios específicos de identificación de las situaciones de violencia machista […] b) El atestado elaborado por las fuerzas y cuerpos de seguridad que han presenciado directamente alguna manifestación de violencia machista.', null, '2ea9c70b0e7a150144b3ad2045e7652d977084f5fb2621edb071ce601a78207e', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '2ea9c70b0e7a150144b3ad2045e7652d977084f5fb2621edb071ce601a78207e')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Un mitjà específic d''identificació, a falta dels mitjans de prova qualificats.', true), ('B', 'Un mitjà de prova qualificat, equiparable a l''ordre de protecció vigent.', false), ('C', 'Un mitjà que no té cap valor si no hi ha sentència ferma.', false), ('D', 'Un mitjà vàlid només si el ratifica l''Institut Català de les Dones en un informe posterior.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 55.2 de la Llei 5/2008, el Servei d''Atenció Telefònica Especialitzada ha de funcionar:', 'L''article 55.2 de la Llei 5/2008 exigeix el funcionament ininterromput del servei telefònic i la plena coordinació amb el 112 Catalunya.', 'plcat_t19_violencia_masclista', (select id from public.topics where slug = 'plcat-t19-violencia-masclista'), 1, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2008-9294'), 'Art. 55.2 Llei 5/2008', 'El Servicio de Atención Telefónica Especializada debe funcionar las veinticuatro horas todos los días del año, y debe coordinarse con los servicios de emergencia en los casos necesarios.', null, 'd0b0dcca5d8e3669e2c6569abbe8e465d077708ae92c72e28492c83f1e19978b', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'd0b0dcca5d8e3669e2c6569abbe8e465d077708ae92c72e28492c83f1e19978b')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'En horari d''oficina, de dilluns a divendres.', false), ('B', 'Les vint-i-quatre hores els dies laborables i en horari diürn els festius.', false), ('C', 'Les vint-i-quatre hores tots els dies de l''any.', true), ('D', 'Només en horari nocturn i els caps de setmana.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 57.2 de la Llei 5/2008, l''estada en els serveis d''atenció i acolliment d''urgències no pot ser superior a:', 'L''article 57.2 de la Llei 5/2008 limita l''estada a la durada mínima indispensable per activar recursos estables i, en tot cas, a quinze dies.', 'plcat_t19_violencia_masclista', (select id from public.topics where slug = 'plcat-t19-violencia-masclista'), 2, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2008-9294'), 'Art. 57.2 Llei 5/2008', 'La estancia en estos servicios debe tener la duración mínima indispensable para activar recursos estables, que en cualquier caso no puede ser superior a los quince días.', null, 'b5b5ba8c3dbbb29d6a6841feb30ed0ce47f807c2f60c4deb0475f3c35d417fc6', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'b5b5ba8c3dbbb29d6a6841feb30ed0ce47f807c2f60c4deb0475f3c35d417fc6')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Trenta dies.', false), ('B', 'Set dies.', false), ('C', 'Tres mesos.', false), ('D', 'Quinze dies.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 63 de la Llei 5/2008, els serveis d''atenció policial de la Xarxa d''Atenció i Recuperació Integral són:', 'L''article 63 de la Llei 5/2008 configura els serveis d''atenció policial com a recursos especialitzats de la Policia de la Generalitat, que formen part de la Xarxa (art. 54.2.i).', 'plcat_t19_violencia_masclista', (select id from public.topics where slug = 'plcat-t19-violencia-masclista'), 2, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2008-9294'), 'Art. 63 Llei 5/2008', 'Los servicios de atención policial son los recursos especializados de la Policía de la Generalidad que tienen como finalidad garantizar el derecho de las mujeres que se hallen en situaciones de violencia machista', null, 'b612962f10456966fa7704479e4c1d55faa93966ef586839105171f1b547e2f9', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'b612962f10456966fa7704479e4c1d55faa93966ef586839105171f1b547e2f9')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Recursos especialitzats de la Policia de la Generalitat.', true), ('B', 'Les unitats de les policies locals dels municipis de més de 20.000 habitants.', false), ('C', 'Les oficines d''atenció a la víctima del delicte que depenen dels jutjats.', false), ('D', 'Els serveis municipals d''informació i atenció a les dones.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 83 de la Llei 5/2008, correspon als municipis programar, prestar i gestionar els serveis d''informació i atenció a les dones, i els municipis amb una població inferior a 20.000 habitants:', 'L''article 83.1.a) de la Llei 5/2008 atribueix als municipis els serveis d''informació i atenció a les dones i l''apartat 2 permet als de menys de 20.000 habitants delegar-los.', 'plcat_t19_violencia_masclista', (select id from public.topics where slug = 'plcat-t19-violencia-masclista'), 2, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2008-9294'), 'Art. 83 Llei 5/2008', 'Los municipios con una población inferior a 20.000 habitantes pueden delegar sus competencias a una mancomunidad de municipios u otros entes locales.', null, '96326aeaef53541eacc18533f3c173ef59fbe7b9449c3de206c8864f22e69213', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '96326aeaef53541eacc18533f3c173ef59fbe7b9449c3de206c8864f22e69213')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Han de traspassar obligatòriament aquestes competències a la Generalitat.', false), ('B', 'Poden delegar-les a una mancomunitat o a altres ens locals.', true), ('C', 'Estan exempts de prestar cap servei en aquesta matèria.', false), ('D', 'Han de crear una unitat policial especialitzada pròpia en violència masclista.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
-- Lote plcat-t20-transit-seguretat-viaria-ltsv-v1 (14 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Real Decreto Legislativo 6/2015, de 30 de octubre, texto refundido de la Ley sobre Tráfico, Circulación de Vehículos a Motor y Seguridad Vial (texto consolidado, BOE)', 'https://www.boe.es/buscar/act.php?id=BOE-A-2015-11722', 'boe'::public.source_kind, 'Agencia Estatal Boletín Oficial del Estado', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('plcat-t20-transit-seguretat-viaria', 'Tema 20. Trànsit i seguretat viària: text refós de la Llei de trànsit, Reglament general de circulació i Reglament general de conductors') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('policia-local') and t.slug = 'plcat-t20-transit-seguretat-viaria' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 7.c) del TRLTSV, les bicicletes només es poden retirar i portar al dipòsit municipal:', 'L''article 7.c) TRLTSV atribueix als municipis la retirada de vehicles de les vies urbanes, però limita la de bicicletes als casos d''abandonament o d''obstaculització o dany al mobiliari urbà.', 'plcat_t20_transit_seguretat_viaria', (select id from public.topics where slug = 'plcat-t20-transit-seguretat-viaria'), 2, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2015-11722'), 'Art. 7.c TRLTSV', 'Las bicicletas sólo podrán ser retiradas y llevadas al correspondiente depósito si están abandonadas o si, estando amarradas, dificultan la circulación de vehículos o personas o dañan el mobiliario urbano.', null, '8c3a98483b6e06832708937ebebdb943fe562c750e951be78369e94dca63b0fd', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '8c3a98483b6e06832708937ebebdb943fe562c750e951be78369e94dca63b0fd')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'En qualsevol cas en què estiguin amarrades a un element del mobiliari urbà.', false), ('B', 'Només si estan estacionades en zona d''estacionament limitat sense títol habilitant.', false), ('C', 'Si estan abandonades o, amarrades, dificulten la circulació o danyen el mobiliari urbà.', true), ('D', 'Només si han estat amarrades més de quaranta-vuit hores al mateix lloc de la via pública.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 7.d) del TRLTSV, correspon als municipis autoritzar les proves esportives:', 'L''article 7.d) TRLTSV reserva als municipis l''autorització de proves esportives que transcorren només pel casc urbà, amb exclusió de les travesseres.', 'plcat_t20_transit_seguretat_viaria', (select id from public.topics where slug = 'plcat-t20-transit-seguretat-viaria'), 2, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2015-11722'), 'Art. 7.d TRLTSV', 'd) La autorización de pruebas deportivas cuando discurran íntegra y exclusivamente por el casco urbano, exceptuadas las travesías.', null, '6c35cbcc71de5bedee6ac183a292f5eb7fb8b6cc1af404504512c1c7e0753381', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '6c35cbcc71de5bedee6ac183a292f5eb7fb8b6cc1af404504512c1c7e0753381')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Quan discorrin per qualsevol via del terme municipal, incloses les interurbanes.', false), ('B', 'Quan discorrin íntegrament i exclusivament pel casc urbà, exceptuades les travesseres.', true), ('C', 'Només si discorren per travesseres.', false), ('D', 'Mai: l''autorització correspon sempre a la Jefatura Provincial de Tráfico.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Quina d''aquestes competències atribueix l''article 7 del TRLTSV als municipis?', 'L''article 7.f) i g) TRLTSV permet als municipis tancar vies urbanes quan calgui i restringir la circulació de determinats vehicles per motius mediambientals.', 'plcat_t20_transit_seguretat_viaria', (select id from public.topics where slug = 'plcat-t20-transit-seguretat-viaria'), 1, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2015-11722'), 'Art. 7.g TRLTSV', 'g) La restricción de la circulación a determinados vehículos en vías urbanas por motivos medioambientales.', null, '667ddae65198c9840960803b1ba1433c12ee1aaa8b4a042039a1f22e0fff74ee', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '667ddae65198c9840960803b1ba1433c12ee1aaa8b4a042039a1f22e0fff74ee')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'L''expedició dels permisos i llicències de conducció dels veïns del municipi.', false), ('B', 'La sanció de les infraccions comeses en vies interurbanes.', false), ('C', 'L''homologació dels etilòmetres que fan servir els agents de la policia local.', false), ('D', 'Restringir la circulació de determinats vehicles en vies urbanes per motius mediambientals.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 14.3 del TRLTSV, la prova per detectar la presència de drogues en l''organisme consisteix en:', 'L''article 14.3 TRLTSV preveu l''aire espirat per a l''alcohol i la prova salival per a les drogues; si hi ha raons justificades que ho impedeixin, es pot ordenar un reconeixement mèdic o anàlisis clíniques.', 'plcat_t20_transit_seguretat_viaria', (select id from public.topics where slug = 'plcat-t20-transit-seguretat-viaria'), 2, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2015-11722'), 'Art. 14.3 TRLTSV', 'para la detección de la presencia de drogas en el organismo, en una prueba salival mediante un dispositivo autorizado y en un posterior análisis de una muestra salival en cantidad suficiente.', null, '3d25488498449bce9e4d08b3bd224197aef26d1b106cc9a20d14383e7b439f24', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '3d25488498449bce9e4d08b3bd224197aef26d1b106cc9a20d14383e7b439f24')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Una prova salival amb dispositiu autoritzat i una anàlisi posterior de mostra salival.', true), ('B', 'Una anàlisi d''orina practicada sempre en un centre sanitari.', false), ('C', 'La verificació de l''aire espirat mitjançant etilòmetres autoritzats i, si és positiva, una anàlisi d''orina.', false), ('D', 'Una anàlisi de sang practicada al centre sanitari més proper al lloc del control.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 14.5 del TRLTSV, les proves de contrast que es repeteixen a petició de l''interessat:', 'L''article 14.5 TRLTSV preveu el contrast preferentment amb anàlisi de sang, llevat de causes excepcionals justificades, i en fa pagar el cost a l''interessat quan surt positiu.', 'plcat_t20_transit_seguretat_viaria', (select id from public.topics where slug = 'plcat-t20-transit-seguretat-viaria'), 3, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2015-11722'), 'Art. 14.5 TRLTSV', 'A efectos de contraste, a petición del interesado, se podrán repetir las pruebas para la detección de alcohol o de drogas, que consistirán preferentemente en análisis de sangre, salvo causas excepcionales debidamente justificadas. Cuando la prueba de contraste arroje un resultado positivo será abonada por el interesado.', null, 'dceefb2ef839b995f139d08d47edc91d86ee6a2b6e9e1c41f63892093be3304e', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'dceefb2ef839b995f139d08d47edc91d86ee6a2b6e9e1c41f63892093be3304e')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Són preferentment anàlisis de sang, a càrrec de l''interessat si surten positives.', true), ('B', 'Consisteixen sempre en una segona prova d''aire espirat i són gratuïtes.', false), ('C', 'Consisteixen preferentment en anàlisis d''orina i les paga sempre l''Administració.', false), ('D', 'Només es poden fer per ordre judicial.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 63.2 del TRLTSV, el titular d''un permís de conducció amb una antiguitat no superior a tres anys té assignat un crèdit inicial de:', 'L''article 63 TRLTSV assigna amb caràcter general dotze punts i, excepcionalment, vuit als conductors novells (antiguitat no superior a tres anys) i als qui recuperen el permís després de perdre tots els punts.', 'plcat_t20_transit_seguretat_viaria', (select id from public.topics where slug = 'plcat-t20-transit-seguretat-viaria'), 1, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2015-11722'), 'Art. 63.2 TRLTSV', '2. Excepcionalmente se asignará un crédito inicial de ocho puntos en los siguientes casos: a) Titular de un permiso o licencia de conducción con una antigüedad no superior a tres años', null, 'ff00866a6b577102b41bbe79f54e398ffa75b11f97ca346f093a755a9d369eae', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'ff00866a6b577102b41bbe79f54e398ffa75b11f97ca346f093a755a9d369eae')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Sis punts.', false), ('B', 'Dotze punts.', false), ('C', 'Deu punts.', false), ('D', 'Vuit punts.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 63.4 del TRLTSV, els conductors que mantenen la totalitat dels punts per no haver estat sancionats en ferm poden arribar a acumular un màxim de:', 'L''article 63.4 TRLTSV preveu una bonificació de dos punts durant els tres primers anys i d''un punt pels tres següents, fins a un màxim de quinze.', 'plcat_t20_transit_seguretat_viaria', (select id from public.topics where slug = 'plcat-t20-transit-seguretat-viaria'), 2, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2015-11722'), 'Art. 63.4 TRLTSV', 'recibirán como bonificación dos puntos durante los tres primeros años y un punto por los tres siguientes, pudiendo llegar a acumular hasta un máximo de quince puntos en lugar de los doce iniciales.', null, 'dfe2af25afab6758699ed507f01dc74f207295d277fab6f9d9ad6e821be2b7c5', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'dfe2af25afab6758699ed507f01dc74f207295d277fab6f9d9ad6e821be2b7c5')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Catorze punts.', false), ('B', 'Divuit punts.', false), ('C', 'Quinze punts.', true), ('D', 'Vint punts.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 65.4 del TRLTSV, superant un curs de sensibilització i reeducació vial, el titular d''un permís que ha perdut part dels punts pot recuperar-ne:', 'L''article 65.4 TRLTSV regula la recuperació parcial per curs (màxim sis punts cada dos anys; anual per a professionals) i limita la durada del curs a quinze hores.', 'plcat_t20_transit_seguretat_viaria', (select id from public.topics where slug = 'plcat-t20-transit-seguretat-viaria'), 2, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2015-11722'), 'Art. 65.4 TRLTSV', 'podrá optar a su recuperación parcial, hasta un máximo de seis puntos, por una sola vez cada dos años, realizando y superando con aprovechamiento un curso de sensibilización y reeducación vial, con la excepción de los conductores profesionales que podrán realizar el citado curso con frecuencia anual.', null, '23a674e24047bca71372387e0288357fcc693d838f1eda08b0a891ac4ace883c', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '23a674e24047bca71372387e0288357fcc693d838f1eda08b0a891ac4ace883c')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Fins a quatre punts, una vegada l''any, sigui o no conductor professional.', false), ('B', 'La totalitat dels dotze punts, però només una vegada en tota la vida del permís.', false), ('C', 'Fins a sis punts, una vegada cada dos anys (anualment, si és professional).', true), ('D', 'Fins a un màxim de vuit punts, una vegada cada tres anys.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 80.2.a) del TRLTSV, la multa de 1.000 euros per conduir amb una taxa d''alcohol superior a la reglamentària només s''imposa:', 'L''article 80.2.a) TRLTSV fixa 1.000 euros per a les infraccions de l''article 77.c) i d), però en el cas de l''alcohol la reserva a la reincidència en l''any anterior o al doble de la taxa; altrament, s''aplica la multa ordinària de 500 euros de les molt greus.', 'plcat_t20_transit_seguretat_viaria', (select id from public.topics where slug = 'plcat-t20-transit-seguretat-viaria'), 3, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2015-11722'), 'Art. 80.2.a TRLTSV', 'En el supuesto de conducción con tasas de alcohol superiores a las que reglamentariamente se establezcan, esta sanción únicamente se impondrá al conductor que ya hubiera sido sancionado en el año inmediatamente anterior por exceder la tasa de alcohol permitida, así como al que circule con una tasa que supere el doble de la permitida.', null, '37616cb20ed5766d4314750c54802719c4af89e77e959658b885ba88cc915d88', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '37616cb20ed5766d4314750c54802719c4af89e77e959658b885ba88cc915d88')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'A tots els conductors que superen la taxa permesa, sigui quina sigui la taxa i encara que sigui la primera vegada.', false), ('B', 'Només als conductors professionals i als titulars d''un permís amb menys de dos anys d''antiguitat.', false), ('C', 'Només quan hi ha hagut un accident amb víctimes.', false), ('D', 'Si hi ha sanció per alcohol l''any anterior o si la taxa supera el doble de la permesa.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 84.4 del TRLTSV, la competència per sancionar les infraccions a normes de circulació comeses en vies urbanes correspon:', 'L''article 84.4 TRLTSV atribueix la sanció en vies urbanes als alcaldes i n''exclou les infraccions del títol IV; l''autoritat estatal o autonòmica n''assumeix la competència si els serveis municipals no la poden exercir.', 'plcat_t20_transit_seguretat_viaria', (select id from public.topics where slug = 'plcat-t20-transit-seguretat-viaria'), 2, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2015-11722'), 'Art. 84.4 TRLTSV', '4. La sanción por infracción a normas de circulación cometidas en vías urbanas corresponderá a los respectivos Alcaldes, los cuales podrán delegar esta competencia de acuerdo con la normativa aplicable. Quedan excluidas de la competencia sancionadora municipal las infracciones a los preceptos del título IV, incluyendo las relativas a las condiciones técnicas de los vehículos y al seguro obligatorio.', null, '7c601fd3d1e59cfaa986b2939d043b7de22a4ffe6eba05d34b2e79fe2c46530e', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '7c601fd3d1e59cfaa986b2939d043b7de22a4ffe6eba05d34b2e79fe2c46530e')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Al cap de la policia local, inclosa la sanció per manca d''assegurança obligatòria.', false), ('B', 'A l''alcalde, que la pot delegar, excepte les del títol IV.', true), ('C', 'Al cap provincial de trànsit, que la pot delegar en l''alcalde per conveni.', false), ('D', 'Al ple de l''ajuntament, per majoria absoluta.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 94 del TRLTSV, si el denunciat paga voluntàriament la multa en l''acte o dins dels vint dies naturals següents a la notificació, obté:', 'L''article 94 TRLTSV (procediment abreujat) vincula el pagament voluntari a la reducció del 50 %, la renúncia a al·legacions i l''esgotament de la via administrativa.', 'plcat_t20_transit_seguretat_viaria', (select id from public.topics where slug = 'plcat-t20-transit-seguretat-viaria'), 1, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2015-11722'), 'Art. 94 TRLTSV', 'a) La reducción del 50 por ciento del importe de la sanción.', null, '51b8ab70676e2ddb50ea25c0357993a1e79c023deabef191c86c6d8278a90f70', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '51b8ab70676e2ddb50ea25c0357993a1e79c023deabef191c86c6d8278a90f70')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Una reducció del 50 per cent de l''import de la sanció.', true), ('B', 'Una reducció del 30 per cent de l''import de la sanció.', false), ('C', 'Una reducció del 25 per cent de l''import de la sanció.', false), ('D', 'L''anul·lació de la pèrdua de punts.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 105.3 del TRLTSV, l''Administració ha de comunicar la retirada i el dipòsit del vehicle al titular en el termini de:', 'L''article 105.3 TRLTSV fixa vint-i-quatre hores i preveu que la comunicació es faci per la Direcció Electrònica Viària si el titular en té.', 'plcat_t20_transit_seguretat_viaria', (select id from public.topics where slug = 'plcat-t20-transit-seguretat-viaria'), 1, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2015-11722'), 'Art. 105.3 TRLTSV', '3. La Administración deberá comunicar la retirada y depósito del vehículo al titular en el plazo de veinticuatro horas.', null, '2fb8af70d6a3d51fbce58ca3e682a5d95e8aa44a97b031c71bbb8ea2292e539b', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '2fb8af70d6a3d51fbce58ca3e682a5d95e8aa44a97b031c71bbb8ea2292e539b')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Vint-i-quatre hores.', true), ('B', 'Quaranta-vuit hores.', false), ('C', 'Tres dies hàbils.', false), ('D', 'Deu dies naturals.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 106.1.a) del TRLTSV, l''Administració pot ordenar el trasllat a un centre autoritzat de tractament d''un vehicle immobilitzat o retirat i dipositat quan:', 'L''article 106.1.a) TRLTSV fixa més de dos mesos sense al·legacions; abans de la tramitació, l''Administració ha de requerir el titular perquè el retiri en el termini d''un mes.', 'plcat_t20_transit_seguretat_viaria', (select id from public.topics where slug = 'plcat-t20-transit-seguretat-viaria'), 3, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2015-11722'), 'Art. 106.1.a TRLTSV', 'a) Cuando hayan transcurrido más de dos meses desde que el vehículo fuera inmovilizado o retirado de la vía pública y depositado por la Administración y su titular no hubiera formulado alegaciones.', null, '9fce4c4cc1e51ab320ffb1e31e5820d3900043039f51b7b52b122a1bfed4af16', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '9fce4c4cc1e51ab320ffb1e31e5820d3900043039f51b7b52b122a1bfed4af16')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Ha passat més d''un mes des de la retirada, encara que el titular hagi formulat al·legacions.', false), ('B', 'Han passat més de dos mesos i el titular no ha formulat al·legacions.', true), ('C', 'Han passat més de sis mesos des de la retirada, encara que el titular n''hagi demanat la devolució.', false), ('D', 'El titular no ha pagat la taxa de dipòsit en quinze dies.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Quina d''aquestes conductes NO és una infracció molt greu segons l''article 77 del TRLTSV, sinó greu segons l''article 76?', 'L''article 76.m) TRLTSV qualifica de greu la conducció negligent, mentre que l''article 77.e), f) i g) qualifica de molt greus la conducció temerària, el sentit contrari i les curses no autoritzades.', 'plcat_t20_transit_seguretat_viaria', (select id from public.topics where slug = 'plcat-t20-transit-seguretat-viaria'), 2, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2015-11722'), 'Art. 76 i 77 TRLTSV', 'm) Conducción negligente.', null, '60cc71a89a1f6df7288d4bdb1f77470fc022ca9a074620217de666398aafb8c7', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '60cc71a89a1f6df7288d4bdb1f77470fc022ca9a074620217de666398aafb8c7')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'La conducció temerària.', false), ('B', 'Circular en sentit contrari a l''establert.', false), ('C', 'Participar en competicions i curses de vehicles no autoritzades.', false), ('D', 'La conducció negligent.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
-- Lote plcat-t20-transit-seguretat-viaria-rgc-v1 (5 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Real Decreto 1428/2003, de 21 de noviembre, Reglamento General de Circulación (texto consolidado, BOE)', 'https://www.boe.es/buscar/act.php?id=BOE-A-2003-23514', 'boe'::public.source_kind, 'Agencia Estatal Boletín Oficial del Estado', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('plcat-t20-transit-seguretat-viaria', 'Tema 20. Trànsit i seguretat viària: text refós de la Llei de trànsit, Reglament general de circulació i Reglament general de conductors') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('policia-local') and t.slug = 'plcat-t20-transit-seguretat-viaria' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 23.2 del RGC, entre la primera i la segona prova de detecció alcohòlica per aire espirat hi ha d''haver un temps mínim de:', 'L''article 23.2 RGC obliga l''agent a advertir la persona examinada del dret a controlar que entre les dues proves passin com a mínim 10 minuts.', 'plcat_t20_transit_seguretat_viaria', (select id from public.topics where slug = 'plcat-t20-transit-seguretat-viaria'), 1, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2003-23514'), 'Art. 23.2 RGC', 'que entre la realización de la primera y de la segunda prueba medie un tiempo mínimo de 10 minutos.', null, '4035aab7e947e1267b992885fbdd6d39728ba026d2256affd9eeaaee41adcf33', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '4035aab7e947e1267b992885fbdd6d39728ba026d2256affd9eeaaee41adcf33')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', '5 minuts.', false), ('B', '15 minuts.', false), ('C', '10 minuts.', true), ('D', '30 minuts.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 23.4 del RGC, quan l''interessat decideix fer les anàlisis de contrast (sang, orina o anàlogues), l''import d''aquestes anàlisis:', 'L''article 23.4 RGC exigeix el dipòsit previ: si el contrast és positiu serveix per pagar les anàlisis; si és negatiu, el cost és a càrrec de l''Administració competent i es retorna el dipòsit.', 'plcat_t20_transit_seguretat_viaria', (select id from public.topics where slug = 'plcat-t20-transit-seguretat-viaria'), 3, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2003-23514'), 'Art. 23.4 RGC', 'El importe de dichos análisis deberá ser previamente depositado por el interesado y con él se atenderá al pago cuando el resultado de la prueba de contraste sea positivo', null, 'b146b678a4780a04922b8d5f56e0e84fe3284ff9d8dfedf91badc27c1e04db0b', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'b146b678a4780a04922b8d5f56e0e84fe3284ff9d8dfedf91badc27c1e04db0b')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'L''assumeix sempre l''Administració, sigui quin sigui el resultat.', false), ('B', 'El paga l''interessat només un cop la sanció és ferma en via administrativa.', false), ('C', 'El paga el centre sanitari, que el repercuteix a l''asseguradora.', false), ('D', 'L''interessat l''ha de dipositar prèviament.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 50.1 del RGC, el límit genèric de velocitat en vies urbanes de dos o més carrils per sentit de circulació és de:', 'L''article 50.1 RGC fixa 20 km/h (plataforma única), 30 km/h (un carril per sentit) i 50 km/h (dos o més carrils per sentit); no es compten els carrils reservats.', 'plcat_t20_transit_seguretat_viaria', (select id from public.topics where slug = 'plcat-t20-transit-seguretat-viaria'), 1, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2003-23514'), 'Art. 50.1.c RGC', 'c) 50 km/h en vías de dos o más carriles por sentido de circulación.', null, 'c8e928abade388cbf3872af9f2208498a9f85be4eeb4670ae6b4ae669d1d6479', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'c8e928abade388cbf3872af9f2208498a9f85be4eeb4670ae6b4ae669d1d6479')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', '30 km/h.', false), ('B', '50 km/h.', true), ('C', '40 km/h.', false), ('D', '60 km/h.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 50.4 del RGC, en vies urbanes de dos o més carrils per sentit i en travesseres, els vehicles que transporten mercaderies perilloses circulen com a màxim a:', 'L''article 50.4 RGC limita a 40 km/h els vehicles de mercaderies perilloses en aquestes vies; el límit genèric en travesseres és de 50 km/h (art. 50.5).', 'plcat_t20_transit_seguretat_viaria', (select id from public.topics where slug = 'plcat-t20-transit-seguretat-viaria'), 2, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2003-23514'), 'Art. 50.4 RGC', '4. En las vías urbanas a las que se refiere el apartado 1 c) y en travesías, los vehículos que transporten mercancías peligrosas circularán como máximo a 40 km/h.', null, 'c537a7e2da325a698b7005640b9cb63d9093ab8038b57d1d509ba10eff05eb33', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'c537a7e2da325a698b7005640b9cb63d9093ab8038b57d1d509ba10eff05eb33')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', '40 km/h.', true), ('B', '30 km/h.', false), ('C', '50 km/h.', false), ('D', '20 km/h.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 50.6 del RGC, el límit genèric de velocitat en autopistes i autovies que transcorren dins de poblat és de:', 'L''article 50.6 RGC fixa 80 km/h en autopistes i autovies dins de poblat, ampliables amb senyalització específica per acord entre l''autoritat municipal i el titular de la via.', 'plcat_t20_transit_seguretat_viaria', (select id from public.topics where slug = 'plcat-t20-transit-seguretat-viaria'), 3, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2003-23514'), 'Art. 50.6 RGC', '6. El límite genérico de velocidad en autopistas y autovías que transcurren dentro de poblado será de 80 km/h', null, '72a2a0b95f42ab983f5454de380c5101b513dc683a0949e0b6f150628598bcde', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '72a2a0b95f42ab983f5454de380c5101b513dc683a0949e0b6f150628598bcde')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', '50 km/h, sense possibilitat d''ampliació.', false), ('B', '80 km/h.', true), ('C', '100 km/h, reduïble per l''autoritat municipal.', false), ('D', '120 km/h, com fora de poblat.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
-- Lote plcat-t20-transit-seguretat-viaria-rgcond-v1 (1 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Real Decreto 818/2009, de 8 de mayo, Reglamento General de Conductores (texto consolidado, BOE)', 'https://www.boe.es/buscar/act.php?id=BOE-A-2009-9481', 'boe'::public.source_kind, 'Agencia Estatal Boletín Oficial del Estado', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('plcat-t20-transit-seguretat-viaria', 'Tema 20. Trànsit i seguretat viària: text refós de la Llei de trànsit, Reglament general de circulació i Reglament general de conductors') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('policia-local') and t.slug = 'plcat-t20-transit-seguretat-viaria' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 4.2 del Reglament general de conductors, l''edat mínima per obtenir el permís de la classe A2 (motocicletes de potència màxima de 35 kW) és de:', 'L''article 4.2 RGCond fixa 15 anys per a l''AM, 16 per a l''A1, 18 per a l''A2 i 20 per a l''A.', 'plcat_t20_transit_seguretat_viaria', (select id from public.topics where slug = 'plcat-t20-transit-seguretat-viaria'), 2, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2009-9481'), 'Art. 4.2 RGCond', '| A2 | Motocicletas con una potencia máxima de 35 kW y una relación potencia/peso máxima de 0,2 kW/kg y no derivadas de un vehículo con más del doble de su potencia. | 18 |', null, '4cdec1e57f47e890841afbff7c29e00414d29f3c57c9e74126b0e540bc1d01b0', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '4cdec1e57f47e890841afbff7c29e00414d29f3c57c9e74126b0e540bc1d01b0')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', '16 anys.', false), ('B', '20 anys.', false), ('C', '18 anys.', true), ('D', '21 anys.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
-- Lote plcat-t21-espectacles-publics-lesp-v1 (20 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Ley 11/2009, de 6 de julio, de regulación administrativa de los espectáculos públicos y las actividades recreativas (Cataluña) (texto consolidado, BOE)', 'https://www.boe.es/buscar/act.php?id=BOE-A-2009-12856', 'boe'::public.source_kind, 'Agencia Estatal Boletín Oficial del Estado', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('plcat-t21-espectacles-publics', 'Tema 21. La Llei 11/2009 d''espectacles públics i activitats recreatives: competències, control i règim sancionador') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('policia-local') and t.slug = 'plcat-t21-espectacles-publics' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 3.1.d) de la Llei 11/2009, els llocs de domini públic, inclosa la via pública, o de propietat privada on ocasionalment es fan espectacles públics o activitats recreatives i que no disposen d''infraestructures ni instal·lacions fixes per fer-ho són:', 'L''article 3.1.d) de la Llei 11/2009 defineix els espais oberts al públic; els establiments oberts al públic (lletra c) són locals, instal·lacions o recintes dedicats a aquestes activitats.', 'plcat_t21_espectacles_publics', (select id from public.topics where slug = 'plcat-t21-espectacles-publics'), 1, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2009-12856'), 'Art. 3.1.d Llei 11/2009', 'd) Espacios abiertos al público: los lugares de dominio público, incluida la vía pública, o de propiedad privada donde ocasionalmente se llevan a cabo espectáculos públicos o actividades recreativas, y que no disponen de infraestructuras ni instalaciones fijas para hacerlo.', null, 'b830cf64f82996de35f0e0d03f2b8588fc2980045c66fb0a1b1b8ce65385edae', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'b830cf64f82996de35f0e0d03f2b8588fc2980045c66fb0a1b1b8ce65385edae')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Espais oberts al públic.', true), ('B', 'Establiments oberts al públic.', false), ('C', 'Locals no permanents desmuntables.', false), ('D', 'Recintes de gran magnitud.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 3.1 de la Llei 11/2009, una activitat que es fa en un establiment obert al públic que té llicència per a una activitat diferent de la que s''hi vol fer és una activitat:', 'L''article 3.1 de la Llei 11/2009 distingeix les activitats ordinàries (habituals en establiments amb títol per a aquella activitat) de les extraordinàries (en establiments amb títol per a una altra activitat, en espais oberts al públic o en altres establiments no regulats).', 'plcat_t21_espectacles_publics', (select id from public.topics where slug = 'plcat-t21-espectacles-publics'), 2, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2009-12856'), 'Art. 3.1 Llei 11/2009', '– Extraordinarias: Actividades que se realizan en establecimientos abiertos al público que disponen de autorización, licencia o comunicación previa para una actividad distinta a la que se quiere llevar a cabo', null, '8ef4c6f41520aee6a4260014c8839495f9829aa3f52f4e7a354c478c94a2a708', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '8ef4c6f41520aee6a4260014c8839495f9829aa3f52f4e7a354c478c94a2a708')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Ordinària.', false), ('B', 'Exclosa de la llei.', false), ('C', 'Clandestina.', false), ('D', 'Extraordinària.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 4.5 de la Llei 11/2009, queden excloses de l''àmbit d''aplicació de la llei:', 'L''article 4.5.b) de la Llei 11/2009 exclou les activitats fetes en exercici dels drets de reunió i manifestació; l''apartat 1 aplica la llei amb independència del caràcter públic o privat, lucratiu o no i esporàdic o habitual.', 'plcat_t21_espectacles_publics', (select id from public.topics where slug = 'plcat-t21-espectacles-publics'), 1, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2009-12856'), 'Art. 4.5.b Llei 11/2009', 'b) Las actividades efectuadas en ejercicio de los derechos fundamentales de reunión y de manifestación.', null, '6d856205928a82a8cb2a2713ec561dc5fc06be21aa9f76f03adfb79aaa8a6ed6', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '6d856205928a82a8cb2a2713ec561dc5fc06be21aa9f76f03adfb79aaa8a6ed6')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Les activitats recreatives sense ànim de lucre organitzades per entitats veïnals.', false), ('B', 'Les activitats fetes en exercici dels drets fonamentals de reunió i de manifestació.', true), ('C', 'Els espectacles organitzats per administracions públiques.', false), ('D', 'Les activitats esporàdiques fetes en la via pública, sigui quin sigui el seu aforament.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 5.2 de la Llei 11/2009, és una obligació dels espectadors i usuaris:', 'L''article 5.2.e) de la Llei 11/2009 imposa als espectadors i usuaris l''obligació de no portar armes ni objectes que es puguin fer servir amb finalitats violentes; assistir-hi amb aquests objectes és falta greu (art. 48.p).', 'plcat_t21_espectacles_publics', (select id from public.topics where slug = 'plcat-t21-espectacles-publics'), 1, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2009-12856'), 'Art. 5.2.e Llei 11/2009', 'e) No llevar armas de ninguna naturaleza ni otros objetos que puedan ser utilizados con finalidades violentas.', null, 'dfb3e974c4b0d9ac6070ac84c794defd928a37fdd4637e18edec7dde3e69928c', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'dfb3e974c4b0d9ac6070ac84c794defd928a37fdd4637e18edec7dde3e69928c')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Presentar el document d''identitat a l''entrada de qualsevol establiment obert al públic.', false), ('B', 'Contractar una assegurança de responsabilitat civil per a la durada de l''espectacle.', false), ('C', 'No portar armes ni objectes que es puguin fer servir amb finalitats violentes.', true), ('D', 'Comunicar a la policia qualsevol incidència abans de sortir del local.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 13.1.d) de la Llei 11/2009, perquè un ajuntament pugui inspeccionar i sancionar els establiments i activitats sotmesos a llicència municipal cal:', 'L''article 13.1.d) de la Llei 11/2009 condiciona aquesta competència a l''acord del ple; si l''ajuntament no l''assumeix, inspecciona i sanciona la Generalitat (art. 11.1.e).', 'plcat_t21_espectacles_publics', (select id from public.topics where slug = 'plcat-t21-espectacles-publics'), 3, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2009-12856'), 'Art. 13.1.d Llei 11/2009', 'd) Inspeccionar y sancionar los establecimientos abiertos al público, espectáculos públicos y actividades recreativas sometidos a licencia municipal, en los supuestos de que, mediante un acuerdo del pleno municipal, se haya acordado asumir conjuntamente el ejercicio de estas competencias', null, 'a66644187252a636cf3fdff0bbb2205a0c69fb82d7fdd2b5ba6a14e070312db4', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'a66644187252a636cf3fdff0bbb2205a0c69fb82d7fdd2b5ba6a14e070312db4')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Una resolució de l''alcalde, sense necessitat de comunicar-la a cap altra administració.', false), ('B', 'Una autorització prèvia del Parlament de Catalunya.', false), ('C', 'Que el municipi tingui més de 20.000 habitants i un cos de policia local propi.', false), ('D', 'Un acord del ple municipal d''assumir-les, comunicat a la Generalitat.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 15 de la Llei 11/2009, si un ajuntament que ha assumit les competències d''inspecció i sanció no les exerceix i això posa en risc la convivència, la seguretat o la salut dels ciutadans:', 'L''article 15 de la Llei 11/2009 declara obligatori l''exercici de les competències assumides i permet la subrogació de la Generalitat d''acord amb el text refós de la Llei municipal i de règim local de Catalunya.', 'plcat_t21_espectacles_publics', (select id from public.topics where slug = 'plcat-t21-espectacles-publics'), 3, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2009-12856'), 'Art. 15 Llei 11/2009', 'El ejercicio de las competencias asumidas de acuerdo con el artículo 13.1.d tiene carácter obligatorio. En el caso de que un ayuntamiento que las ha asumido no las ejerza, y como consecuencia del mismo hecho se pongan en riesgo la convivencia, la seguridad o la salud de los ciudadanos, la Administración de la Generalidad puede ejercerlas subsidiariamente', null, 'f2879d79727749e062060fb728c2d8fa8d07480933d795fea6fa49664d6797a0', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'f2879d79727749e062060fb728c2d8fa8d07480933d795fea6fa49664d6797a0')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'L''Administració de la Generalitat les pot exercir subsidiàriament.', true), ('B', 'La competència passa automàticament al consell comarcal.', false), ('C', 'L''alcalde incorre automàticament en una falta molt greu.', false), ('D', 'La competència queda en suspens fins que el ple la reassumeixi.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 20.1 de la Llei 11/2009, l''horari general dels establiments oberts al públic, dels espectacles públics i de les activitats recreatives es determina:', 'L''article 20 de la Llei 11/2009 atribueix l''horari general a una ordre del conseller; aquestes ordres fixen els criteris perquè la Generalitat o els municipis acordin, motivadament, ampliacions o reduccions.', 'plcat_t21_espectacles_publics', (select id from public.topics where slug = 'plcat-t21-espectacles-publics'), 2, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2009-12856'), 'Art. 20.1 Llei 11/2009', 'Por orden del consejero o consejera del departamento competente en la materia, una vez escuchado el Consejo Asesor de Espectáculos Públicos y de Actividades Recreativas, debe determinarse el horario general', null, '3d45816d591694455df7a5a023ddc088b303516809fef75c7a5379ec9acbd66b', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '3d45816d591694455df7a5a023ddc088b303516809fef75c7a5379ec9acbd66b')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Per ordenança de cada ajuntament, sense intervenció de la Generalitat, amb l''informe de la junta local de seguretat.', false), ('B', 'Per decret del Govern, a proposta de les associacions empresarials del sector de l''oci.', false), ('C', 'Per ordre del conseller competent, escoltat el Consell Assessor.', true), ('D', 'Per resolució del cap de la policia local.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 21.2 de la Llei 11/2009, quan es detecta la venda o revenda d''entrades en llocs físics no autoritzats pels titulars o organitzadors:', 'L''article 21.2 de la Llei 11/2009 prohibeix la venda i revenda no autoritzada i preveu la retirada i el decomís immediats, sens perjudici del procediment sancionador; l''article 65.5 permet als agents decomissar les entrades de la revenda.', 'plcat_t21_espectacles_publics', (select id from public.topics where slug = 'plcat-t21-espectacles-publics'), 2, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2009-12856'), 'Art. 21.2 Llei 11/2009', 'En estos supuestos debe procederse de oficio, como medida cautelar, a la retirada inmediata y al decomiso de las entradas y abonos y del dinero objeto de la transacción, sin perjuicio de la iniciación de un procedimiento sancionador.', null, 'b7b384e2bd4061f6a764133213efb58075f19f7ac10e499ae57bfdd117e5d4b4', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'b7b384e2bd4061f6a764133213efb58075f19f7ac10e499ae57bfdd117e5d4b4')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Només es pot aixecar acta, sense cap altra mesura, i remetre-la a l''òrgan sancionador.', false), ('B', 'S''han de retirar i decomissar d''ofici les entrades i els diners.', true), ('C', 'S''ha de detenir el venedor i posar-lo a disposició judicial.', false), ('D', 'S''ha de requerir el venedor perquè cessi l''activitat en un termini de deu dies, amb advertiment de sanció.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 23.3 de la Llei 11/2009, la manca de l''assegurança de responsabilitat civil exigible comporta:', 'L''article 23 de la Llei 11/2009 obliga titulars i organitzadors a tenir pla d''emergència i assegurança de responsabilitat civil, que ha d''estar vigent mentre duri l''activitat.', 'plcat_t21_espectacles_publics', (select id from public.topics where slug = 'plcat-t21-espectacles-publics'), 2, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2009-12856'), 'Art. 23.3 Llei 11/2009', 'La falta de seguro conlleva la clausura del establecimiento abierto al público o la suspensión inmediata del espectáculo público o la actividad recreativa.', null, '116000790d0eb4fe028dcaeb34b0d46b1973972fada17e66761706f4a50ca88f', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '116000790d0eb4fe028dcaeb34b0d46b1973972fada17e66761706f4a50ca88f')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Només una advertència, sense cap altra conseqüència si s''esmena en el termini de deu dies.', false), ('B', 'Una multa fixa de 300 euros.', false), ('C', 'La clausura de l''establiment o la suspensió immediata de l''activitat.', true), ('D', 'La pèrdua de la condició de titular o organitzador durant un període de deu anys.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 25.4 de la Llei 11/2009, si el comportament dels espectadors pot provocar problemes greus de seguretat i d''ordre públic i el personal de vigilància no pot afrontar la situació de manera apropiada, aquest personal ha de:', 'L''article 25.4 de la Llei 11/2009 obliga el personal de vigilància a demanar l''auxili dels cossos i forces de seguretat perquè adoptin les mesures oportunes.', 'plcat_t21_espectacles_publics', (select id from public.topics where slug = 'plcat-t21-espectacles-publics'), 1, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2009-12856'), 'Art. 25.4 Llei 11/2009', 'debe solicitar el auxilio de los cuerpos y fuerzas de seguridad para que adopten las medidas oportunas.', null, 'f2dcc28fbf7bc8c2e345e703631f3267df59c6fb6dd52f78d8ceb8081cfbe854', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'f2dcc28fbf7bc8c2e345e703631f3267df59c6fb6dd52f78d8ceb8081cfbe854')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Desallotjar l''establiment pel seu compte.', false), ('B', 'Sol·licitar l''auxili dels cossos i forces de seguretat.', true), ('C', 'Retenir els espectadors fins que arribi el titular.', false), ('D', 'Tancar l''establiment i comunicar-ho a l''ajuntament l''endemà.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 29.7 de la Llei 11/2009, llevat que les ordenances ho estableixin excepcionalment, estan exempts de llicència municipal:', 'L''article 29.7 de la Llei 11/2009 eximeix de llicència municipal, entre d''altres, els establiments de titularitat municipal, les activitats extraordinàries municipals de festes i revetlles, les de petit aforament d''interès artístic o cultural i les activitats esportives esporàdiques.', 'plcat_t21_espectacles_publics', (select id from public.topics where slug = 'plcat-t21-espectacles-publics'), 2, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2009-12856'), 'Art. 29.7 Llei 11/2009', 'b) Los espectáculos públicos y actividades recreativas de carácter extraordinario organizados por los municipios con motivo de fiestas y verbenas populares, con independencia de la titularidad del establecimiento o espacio abierto al público donde se llevan a cabo.', null, '84796b46ef944c8008d9fe6573f80da9c57f8da45b198b8278b91c46cdcc6ad2', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '84796b46ef944c8008d9fe6573f80da9c57f8da45b198b8278b91c46cdcc6ad2')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Les activitats extraordinàries municipals de festes i revetlles populars.', true), ('B', 'Tots els espectacles organitzats per entitats sense ànim de lucre, sigui quin sigui l''espai on es fan.', false), ('C', 'Els establiments de règim especial.', false), ('D', 'Les activitats recreatives musicals en locals privats amb aforament superior a 500 persones.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 47.e) de la Llei 11/2009, l''incompliment dels horaris d''inici o de finalització d''un espectacle és falta molt greu quan és greu i reiterat, com a mínim:', 'L''article 47.e) de la Llei 11/2009 qualifica de molt greu l''incompliment greu i reiterat (mínim tres vegades en sis mesos); l''incompliment simple dels horaris és falta greu (art. 48.j).', 'plcat_t21_espectacles_publics', (select id from public.topics where slug = 'plcat-t21-espectacles-publics'), 3, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2009-12856'), 'Art. 47.e Llei 11/2009', 'e) Incumplir de forma grave y reiterada, como mínimo tres veces en un período de seis meses, los horarios de inicio o finalización de un espectáculo público o una actividad recreativa', null, 'a7ea8198bb63d8bd8fab56271b6973afd215619e600f09b913bc6915e6f9c926', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'a7ea8198bb63d8bd8fab56271b6973afd215619e600f09b913bc6915e6f9c926')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Dues vegades en un període de tres mesos.', false), ('B', 'Tres vegades en un període d''un any.', false), ('C', 'Cinc vegades en un període de sis mesos.', false), ('D', 'Tres vegades en un període de sis mesos.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Llei 11/2009, trencar els precintes fixats per una mesura provisional mentre és vigent és una falta:', 'L''article 47.h) de la Llei 11/2009 qualifica de molt greu trencar els precintes o incomplir les prohibicions d''una mesura provisional o d''una resolució sancionadora.', 'plcat_t21_espectacles_publics', (select id from public.topics where slug = 'plcat-t21-espectacles-publics'), 2, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2009-12856'), 'Art. 47.h Llei 11/2009', 'h) Romper los precintos o incumplir las prohibiciones fijadas por una medida provisional, mientras dure su vigencia, o por las resoluciones sancionadoras.', null, '96b187beab4757ff5d7ff52223b24fb73bab4203c7e70b3acdfa0609c5944f10', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '96b187beab4757ff5d7ff52223b24fb73bab4203c7e70b3acdfa0609c5944f10')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Greu.', false), ('B', 'Molt greu.', true), ('C', 'Lleu.', false), ('D', 'No és infracció administrativa, sinó només penal.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Llei 11/2009, admetre menors, de manera NO reiterada, en un establiment obert al públic on tenen prohibida l''entrada és una falta:', 'L''article 48.m) de la Llei 11/2009 qualifica de greu admetre menors on tenen prohibida l''entrada; si es fa de forma reiterada és falta molt greu (art. 47.g).', 'plcat_t21_espectacles_publics', (select id from public.topics where slug = 'plcat-t21-espectacles-publics'), 2, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2009-12856'), 'Art. 48.m i 47.g Llei 11/2009', 'm) Admitir a menores en establecimientos abiertos al público, espectáculos públicos o actividades recreativas donde estos tengan prohibida la entrada.', null, '2d2a0ee88e2eee287f389e4fffd5b3b89c3f5762dd6cecc1795e5c51c7cf905e', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '2d2a0ee88e2eee287f389e4fffd5b3b89c3f5762dd6cecc1795e5c51c7cf905e')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Greu.', true), ('B', 'Molt greu.', false), ('C', 'Lleu.', false), ('D', 'No és infracció si el menor va acompanyat d''un adult.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 49.1 de la Llei 11/2009, exercir el dret d''admissió sense haver-lo comunicat a l''autoritat competent és una falta:', 'L''article 49.1.d) de la Llei 11/2009 qualifica de lleu aquesta conducta; en canvi, incomplir la prohibició de discriminació de l''article 10 és falta molt greu (art. 47.i).', 'plcat_t21_espectacles_publics', (select id from public.topics where slug = 'plcat-t21-espectacles-publics'), 1, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2009-12856'), 'Art. 49.1.d Llei 11/2009', 'd) Ejercer el derecho de admisión sin haberlo comunicado a la autoridad competente.', null, '4a137e666963908e008146f68e667e0b9957f84739e15677675e0e1a3f4a1dd4', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '4a137e666963908e008146f68e667e0b9957f84739e15677675e0e1a3f4a1dd4')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Greu.', false), ('B', 'Molt greu.', false), ('C', 'No és infracció.', false), ('D', 'Lleu.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 51.j) de la Llei 11/2009, si els infractors d''una falta greu són espectadors o usuaris, la multa és de:', 'L''article 51.j) de la Llei 11/2009 fixa la multa per a espectadors i usuaris autors de faltes greus; per als titulars i organitzadors la multa és de 1.001 a 10.000 euros (art. 51.a).', 'plcat_t21_espectacles_publics', (select id from public.topics where slug = 'plcat-t21-espectacles-publics'), 2, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2009-12856'), 'Art. 51.j Llei 11/2009', 'j) Si los infractores son espectadores o usuarios, una multa de 151 a 500 euros y, en caso de reincidencia en la comisión de infracciones graves, de hasta 1.000 euros.', null, '1fd30134bf9477cbce7319e83bf36eab9f69c26799ba2cf59dcb9f1c747cab0e', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '1fd30134bf9477cbce7319e83bf36eab9f69c26799ba2cf59dcb9f1c747cab0e')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', '50 a 150 euros, i fins a 300 euros en cas de reincidència.', false), ('B', '1.001 a 10.000 euros, i fins a 20.000 euros en cas de reincidència.', false), ('C', '151 a 500 euros, i fins a 1.000 euros en cas de reincidència en infraccions greus.', true), ('D', '501 a 1.000 euros, i fins a 2.000 euros en cas de reincidència.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 57.3 de la Llei 11/2009, les sancions imposades per faltes lleus prescriuen al cap de:', 'L''article 57.3 de la Llei 11/2009 fixa la prescripció de les sancions en tres anys (molt greus), dos anys (greus) i un any (lleus); les faltes lleus, en canvi, prescriuen als sis mesos (art. 57.1).', 'plcat_t21_espectacles_publics', (select id from public.topics where slug = 'plcat-t21-espectacles-publics'), 3, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2009-12856'), 'Art. 57.3 Llei 11/2009', '3. Las sanciones por la comisión de faltas muy graves prescriben al cabo de tres años; por la comisión de faltas graves, al cabo de dos años, y por la comisión de faltas leves, al cabo de un año.', null, '42a24093402ee896b61ad836ef299c6c921f93de9612cf8083550340dbd646f1', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '42a24093402ee896b61ad836ef299c6c921f93de9612cf8083550340dbd646f1')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Un any.', true), ('B', 'Sis mesos.', false), ('C', 'Dos anys.', false), ('D', 'Tres mesos.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 57.5 de la Llei 11/2009, el procediment sancionador s''ha de resoldre i notificar en el termini màxim de:', 'L''article 57.5 de la Llei 11/2009 fixa nou mesos, llevat d''interrupció del còmput; un cop vençut el termini, es produeix la caducitat.', 'plcat_t21_espectacles_publics', (select id from public.topics where slug = 'plcat-t21-espectacles-publics'), 1, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2009-12856'), 'Art. 57.5 Llei 11/2009', 'El procedimiento sancionador debe ser resuelto y notificada su resolución en el plazo máximo de nueve meses desde su apertura', null, '684f14fe41e08cb37c9690e9b4c54878de7c7a333779fd7f114063b8bda349bb', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '684f14fe41e08cb37c9690e9b4c54878de7c7a333779fd7f114063b8bda349bb')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Sis mesos des de la seva obertura.', false), ('B', 'Nou mesos des de la seva obertura.', true), ('C', 'Tres mesos des de la seva obertura.', false), ('D', 'Un any des de la comissió de la falta.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 59.2 de la Llei 11/2009, l''òrgan municipal competent per exercir les potestats sancionadores que la llei atribueix als ajuntaments és:', 'L''article 59.2 de la Llei 11/2009 atribueix la potestat sancionadora municipal a l''alcalde, amb possibilitat de delegació segons la legislació de règim local.', 'plcat_t21_espectacles_publics', (select id from public.topics where slug = 'plcat-t21-espectacles-publics'), 2, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2009-12856'), 'Art. 59.2 Llei 11/2009', '2. El órgano municipal competente para ejercer las potestades sancionadoras que la presente ley atribuye a los ayuntamientos es el alcalde o alcaldesa, que puede delegar la competencia de acuerdo con el régimen establecido por la legislación de régimen local.', null, '38b908408f330b468e22dec56f54de1212e0f76c00713f5a7ce534d47e206d9e', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '38b908408f330b468e22dec56f54de1212e0f76c00713f5a7ce534d47e206d9e')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El ple de l''ajuntament, de manera indelegable.', false), ('B', 'La junta de govern local, en tot cas.', false), ('C', 'L''alcalde o alcaldessa, que pot delegar la competència.', true), ('D', 'El cap de la policia local.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 64.c) de la Llei 11/2009, les mesures provisionals prèvies s''han de confirmar, modificar o revocar en l''acord d''iniciació del procediment sancionador, que s''ha de fer en el termini màxim de:', 'L''article 64.c) de la Llei 11/2009 fixa quinze dies per a les mesures provisionals prèvies; no s''ha de confondre amb els cinc dies per confirmar les mesures provisionals immediates dels agents (art. 65.2).', 'plcat_t21_espectacles_publics', (select id from public.topics where slug = 'plcat-t21-espectacles-publics'), 3, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2009-12856'), 'Art. 64.c Llei 11/2009', 'c) Las medidas provisionales previas tienen que ser confirmadas, modificadas o revocadas en el acuerdo de iniciación del procedimiento sancionador correspondiente, que debe efectuarse en el plazo máximo de quince días desde la adopción de las medidas provisionales.', null, '2da477d889aaa335cdf120bee9a0395e7ee49a390ace06ca87a881ce14750966', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '2da477d889aaa335cdf120bee9a0395e7ee49a390ace06ca87a881ce14750966')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Cinc dies des de l''adopció de les mesures.', false), ('B', 'Quaranta-vuit hores des de l''adopció de les mesures.', false), ('C', 'Un mes des de l''adopció de les mesures.', false), ('D', 'Quinze dies des de l''adopció de les mesures.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
-- Lote plcat-t22-etica-policial-codietic-v1 (11 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Acord GOV/25/2015, de 24 de febrer, pel qual s''aprova el Codi d''ètica de la Policia de Catalunya (DOGC núm. 6821, 26/02/2015)', 'https://portaljuridic.gencat.cat/ca/document-del-pjur/?documentId=685656', 'diario_autonomico'::public.source_kind, 'Generalitat de Catalunya · Portal Jurídic de Catalunya', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('plcat-t22-etica-policial', 'Tema 22. Ètica i deontologia policial: Codi d''ètica de la Policia de Catalunya i Comitè d''Ètica') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('policia-local') and t.slug = 'plcat-t22-etica-policial' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons el seu preàmbul, el Codi d''ètica de la Policia de Catalunya s''inspira en diversos textos internacionals. Quin dels següents NO hi és esmentat?', 'El preàmbul del Codi cita la Declaració universal dels drets humans (1948), el Conveni europeu de drets humans (1950), el Pacte internacional de drets civils i polítics (1966) i el Codi europeu d''ètica de la policia (2001).', 'plcat_t22_etica_policial', (select id from public.topics where slug = 'plcat-t22-etica-policial'), 3, 'ca', true, (select id from public.sources where url = 'https://portaljuridic.gencat.cat/ca/document-del-pjur/?documentId=685656'), 'Codi d''ètica, preàmbul', 'Aquest Codi d''ètica, que s’inspira en l’esperit i la lletra de la Declaració universal dels drets humans (10.12.1948), en el Conveni europeu de drets humans (1950), en el Pacte internacional de drets civils i polítics (16.12.1966) i en el Codi europeu d’ètica de la policia (2001) del Consell d’Europa', null, '5bbe35cd8f1ef7b88378e25b611a88dca0092b2c95dde16987b64f4f7a0fef77', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '5bbe35cd8f1ef7b88378e25b611a88dca0092b2c95dde16987b64f4f7a0fef77')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'La Declaració universal dels drets humans.', false), ('B', 'El Pacte internacional de drets civils i polítics.', false), ('C', 'La Carta social europea.', true), ('D', 'El Codi europeu d''ètica de la policia del Consell d''Europa.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons el preàmbul del Codi d''ètica de la Policia de Catalunya, a més dels agents de policia, el Codi vol servir com a marc de referència per a:', 'El preàmbul del Codi preveu que serveixi de marc de referència per als vigilants municipals, en reconeixement a la seva tasca en defensa dels drets i llibertats.', 'plcat_t22_etica_policial', (select id from public.topics where slug = 'plcat-t22-etica-policial'), 2, 'ca', true, (select id from public.sources where url = 'https://portaljuridic.gencat.cat/ca/document-del-pjur/?documentId=685656'), 'Codi d''ètica, preàmbul', 'Així mateix, aquest Codi també vol servir com a marc de referència per als vigilants municipals d’acord amb les seves competències', null, '8847393f1e1f3edd9aa66ae18a6e030b72e45e4e49c68d9f949038cc28230af1', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '8847393f1e1f3edd9aa66ae18a6e030b72e45e4e49c68d9f949038cc28230af1')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Els vigilants municipals.', true), ('B', 'El personal de seguretat privada que presta serveis en espais públics.', false), ('C', 'Els agents rurals i els bombers de la Generalitat.', false), ('D', 'Els funcionaris de presons.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons el Codi d''ètica de la Policia de Catalunya, els valors de la voluntat de servei i de la transparència s''inclouen en l''àrea de:', 'El capítol I del Codi agrupa en l''àrea A (funció pública) la voluntat de servei i la transparència; la proximitat, la professionalitat o la temprança pertanyen a l''àrea B (professió).', 'plcat_t22_etica_policial', (select id from public.topics where slug = 'plcat-t22-etica-policial'), 2, 'ca', true, (select id from public.sources where url = 'https://portaljuridic.gencat.cat/ca/document-del-pjur/?documentId=685656'), 'Codi d''ètica, cap. I.A', 'A. Funció pública Voluntat de servei […] Transparència La transparència és un valor inherent a les institucions democràtiques.', null, '12a1d15ae819f9dee65423d936629fb94969e3cb1c9c9fabe11246b5335fe9d7', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '12a1d15ae819f9dee65423d936629fb94969e3cb1c9c9fabe11246b5335fe9d7')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'La professió.', false), ('B', 'La funció pública.', true), ('C', 'L''orientació a les persones.', false), ('D', 'Les relacions institucionals.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons el Codi d''ètica de la Policia de Catalunya, la qualitat humana que mou a la pràctica del discerniment abans d''emprendre les decisions és:', 'El Codi defineix el seny com el discerniment previ a les decisions, avaluant-ne les conseqüències; la temprança és l''autodomini i el control emocional.', 'plcat_t22_etica_policial', (select id from public.topics where slug = 'plcat-t22-etica-policial'), 1, 'ca', true, (select id from public.sources where url = 'https://portaljuridic.gencat.cat/ca/document-del-pjur/?documentId=685656'), 'Codi d''ètica, Seny', 'El seny és aquella qualitat humana que mou a la pràctica del discerniment abans d’emprendre les decisions.', null, '46235e58f7e97e6fbf1aad1ba65584b44e6637fc72cc00ada7b0221541b2b8a5', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '46235e58f7e97e6fbf1aad1ba65584b44e6637fc72cc00ada7b0221541b2b8a5')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'La temprança.', false), ('B', 'El coratge.', false), ('C', 'El seny.', true), ('D', 'L''exemplaritat.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons el Codi d''ètica de la Policia de Catalunya, la qualitat humana que predisposa l''agent a confiar en les seves pròpies forces i en les dels membres del cos per respondre a situacions difícils i vèncer els obstacles és:', 'El Codi defineix el coratge com la capacitat d''afrontar situacions difícils o incertes, fins i tot posant en perill la pròpia integritat física en benefici del bé comú.', 'plcat_t22_etica_policial', (select id from public.topics where slug = 'plcat-t22-etica-policial'), 1, 'ca', true, (select id from public.sources where url = 'https://portaljuridic.gencat.cat/ca/document-del-pjur/?documentId=685656'), 'Codi d''ètica, Coratge', 'El coratge és la qualitat humana que predisposa l''agent de policia a confiar en les seves pròpies forces i en les dels membres del cossos per respondre a situacions difícils i per vèncer els obstacles', null, 'ca5adc4afe17c335568e3e637055249dcec1d16b86381c576df7abd7057ceee5', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'ca5adc4afe17c335568e3e637055249dcec1d16b86381c576df7abd7057ceee5')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El seny.', false), ('B', 'La responsabilitat.', false), ('C', 'El sentiment de pertinença.', false), ('D', 'El coratge.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons el punt 1 del Codi d''ètica de la Policia de Catalunya, quina d''aquestes NO és una de les funcions primordials de la Policia de Catalunya?', 'El punt 1 enumera les funcions primordials (defensar llibertats i drets, protegir persones i béns, defensar l''interès general, els grups vulnerables, garantir l''ordre, prevenir infraccions, resoldre conflictes i respectar i fer respectar la llei); el valor de la imparcialitat recorda que no correspon a l''agent jutjar.', 'plcat_t22_etica_policial', (select id from public.topics where slug = 'plcat-t22-etica-policial'), 1, 'ca', true, (select id from public.sources where url = 'https://portaljuridic.gencat.cat/ca/document-del-pjur/?documentId=685656'), 'Codi d''ètica, punt 1', 'd. Defensar els grups més vulnerables de la societat. e. Garantir l’ordre i la pau social. f. Prevenir i combatre infraccions penals i administratives. g. Resoldre els conflictes.', null, 'e512c6d5e9630cdb179d917ebb04aff7d6c127dc61dc8bb9e045eecdb410d5cf', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'e512c6d5e9630cdb179d917ebb04aff7d6c127dc61dc8bb9e045eecdb410d5cf')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Defensar els grups més vulnerables de la societat.', false), ('B', 'Jutjar les persones infractores.', true), ('C', 'Resoldre els conflictes.', false), ('D', 'Prevenir i combatre infraccions penals i administratives.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons el punt 5 del Codi d''ètica de la Policia de Catalunya, si un agent observa de manera manifesta una disminució de les capacitats d''un altre agent per desenvolupar la funció policial:', 'El punt 5 del Codi obliga a comunicar al superior tant la pròpia incapacitat per exercir correctament la funció com la disminució manifesta de capacitats d''un company.', 'plcat_t22_etica_policial', (select id from public.topics where slug = 'plcat-t22-etica-policial'), 2, 'ca', true, (select id from public.sources where url = 'https://portaljuridic.gencat.cat/ca/document-del-pjur/?documentId=685656'), 'Codi d''ètica, punt 5', 'Igualment, si un agent de la Policia de Catalunya observa de manera manifesta una disminució de les capacitats d''un altre agent per desenvolupar la funció policial ho ha de comunicar al seu superior per evitar mals innecessaris.', null, '35174a7ce2e057adf35c0278092837dc27d7f00c7190e3568f94ddec9a439d9e', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '35174a7ce2e057adf35c0278092837dc27d7f00c7190e3568f94ddec9a439d9e')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Ho ha de comunicar al seu superior per evitar mals innecessaris.', true), ('B', 'Ho ha de comunicar directament al Comitè d''Ètica.', false), ('C', 'Ha de guardar-ne reserva pel deure de lleialtat al cos.', false), ('D', 'Ho ha de denunciar davant el jutjat de guàrdia.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons el punt 11 del Codi d''ètica de la Policia de Catalunya, s''entén per grup vulnerable:', 'El punt 11 defineix el grup vulnerable i demana una atenció especial a les persones físicament, psicològicament, socialment i econòmicament vulnerables; el punt 12 hi afegeix la col·laboració amb els serveis comunitaris.', 'plcat_t22_etica_policial', (select id from public.topics where slug = 'plcat-t22-etica-policial'), 2, 'ca', true, (select id from public.sources where url = 'https://portaljuridic.gencat.cat/ca/document-del-pjur/?documentId=685656'), 'Codi d''ètica, punt 11', 'S''entén per grup vulnerable aquell conjunt de persones que, per les seves característiques o circumstàncies, pateixen una situació de fragilitat que exigeix cura i protecció.', null, '6897b8252de45f11bb75fcd36cdd1a9b08d55379ea3adf54d1110a3e1844f034', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '6897b8252de45f11bb75fcd36cdd1a9b08d55379ea3adf54d1110a3e1844f034')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El conjunt de persones que han estat víctimes d''un delicte violent en els darrers cinc anys.', false), ('B', 'Exclusivament les persones menors d''edat i les persones grans.', false), ('C', 'Persones en situació de fragilitat que exigeix cura i protecció.', true), ('D', 'El conjunt de persones que no tenen la nacionalitat espanyola ni la residència legal a Catalunya.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons el punt 28 del Codi d''ètica de la Policia de Catalunya, els comandaments s''han de responsabilitzar de les accions que fan els membres de l''equip que dirigeixen:', 'El punt 28 fa els comandaments responsables de les ordres que donen, de la seva execució i de les conseqüències, i de les accions de l''equip quan s''ajusten a les seves ordres i instruccions.', 'plcat_t22_etica_policial', (select id from public.topics where slug = 'plcat-t22-etica-policial'), 3, 'ca', true, (select id from public.sources where url = 'https://portaljuridic.gencat.cat/ca/document-del-pjur/?documentId=685656'), 'Codi d''ètica, punt 28', 's’han de responsabilitzar de les accions que fan els membres de l’equip que dirigeixen, sempre que aquests actuïn de conformitat amb les ordres, les pautes i les instruccions que els comandaments han donat.', null, '36c78c4789c95f19ec912404ae54ece090af7ea19929f5b88627eeaee4b42224', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '36c78c4789c95f19ec912404ae54ece090af7ea19929f5b88627eeaee4b42224')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'En tot cas, fins i tot si els agents actuen al marge de les ordres rebudes.', false), ('B', 'Només si les accions comporten responsabilitat penal o disciplinària per falta molt greu.', false), ('C', 'Mai: cada agent respon exclusivament dels seus propis actes.', false), ('D', 'Sempre que actuïn d''acord amb les seves ordres i instruccions.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons el punt 39 del Codi d''ètica de la Policia de Catalunya, en l''ús de la força, la necessitat de valorar la conveniència d''actuar en el moment i l''espai propici perquè no ocasioni un mal més greu del que es vol evitar és el principi de:', 'El punt 39 del Codi defineix els tres principis bàsics de l''ús de la força: oportunitat (moment i espai propici), congruència (mitjà més idoni) i proporcionalitat (graduació segons l''agressió).', 'plcat_t22_etica_policial', (select id from public.topics where slug = 'plcat-t22-etica-policial'), 1, 'ca', true, (select id from public.sources where url = 'https://portaljuridic.gencat.cat/ca/document-del-pjur/?documentId=685656'), 'Codi d''ètica, punt 39', 'Per oportunitat s’entén la necessitat de valorar la conveniència d’actuar en el moment i en l’espai propici per tal que no ocasioni un mal més greu del que es vol evitar.', null, 'd621a8affeb3516683ad39a6f020affe33768f1a8ee5d93de7395bc16bcce157', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'd621a8affeb3516683ad39a6f020affe33768f1a8ee5d93de7395bc16bcce157')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Oportunitat.', true), ('B', 'Congruència.', false), ('C', 'Proporcionalitat.', false), ('D', 'Seguretat.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''epíleg del Codi d''ètica de la Policia de Catalunya (punt 62), a qui correspon discernir quin seguiment cal fer de l''aplicació del Codi i crear els organismes oportuns per vetllar per la seva difusió, seguiment i compliment?', 'El punt 62 atribueix aquesta tasca al Departament d''Interior, mentre que el punt 61 encarrega al Comitè d''Ètica vetllar perquè el Codi s''actualitzi quan convingui.', 'plcat_t22_etica_policial', (select id from public.topics where slug = 'plcat-t22-etica-policial'), 3, 'ca', true, (select id from public.sources where url = 'https://portaljuridic.gencat.cat/ca/document-del-pjur/?documentId=685656'), 'Codi d''ètica, punt 62', 'Correspon al Departament d''Interior de la Generalitat de Catalunya discernir quin seguiment cal fer de l’aplicació d’aquest Codi d’ètica i crear els organismes oportuns per vetllar per la seva difusió, seguiment i compliment.', null, '95414e9fe021ecd013b87f41be636c292c51fb489e30f346ed139806506dc105', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '95414e9fe021ecd013b87f41be636c292c51fb489e30f346ed139806506dc105')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Al Comitè d''Ètica de la Policia de Catalunya.', false), ('B', 'Al Departament d''Interior de la Generalitat de Catalunya.', true), ('C', 'A cada ajuntament amb cos de policia local.', false), ('D', 'Al Parlament de Catalunya.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
-- Lote plcat-t22-etica-policial-d222-v1 (9 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Decret 222/2013, de 3 de setembre, del Reglament d''organització i funcionament del Comitè d''Ètica de la Policia de Catalunya', 'https://portaljuridic.gencat.cat/ca/document-del-pjur/?documentId=643826', 'diario_autonomico'::public.source_kind, 'Generalitat de Catalunya · Portal Jurídic de Catalunya', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('plcat-t22-etica-policial', 'Tema 22. Ètica i deontologia policial: Codi d''ètica de la Policia de Catalunya i Comitè d''Ètica') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('policia-local') and t.slug = 'plcat-t22-etica-policial' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 1.2 del Decret 222/2013, el Comitè d''Ètica de la Policia de Catalunya s''adscriu:', 'L''article 1.2 del Decret 222/2013 adscriu el Comitè al departament competent en seguretat pública, que li assigna els mitjans personals i materials necessaris.', 'plcat_t22_etica_policial', (select id from public.topics where slug = 'plcat-t22-etica-policial'), 1, 'ca', true, (select id from public.sources where url = 'https://portaljuridic.gencat.cat/ca/document-del-pjur/?documentId=643826'), 'D222/2013 art. 1.2', '1.2 El Comitè d''Ètica de la Policia de Catalunya s''adscriu al departament competent en matèria de seguretat pública', null, '804e96cf6d1d8affbb68a2786a11442d005319a88df042fc39794cf56bfc91fb', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '804e96cf6d1d8affbb68a2786a11442d005319a88df042fc39794cf56bfc91fb')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Al departament competent en matèria de seguretat pública.', true), ('B', 'Al Parlament de Catalunya.', false), ('C', 'A la Comissió de Policia de Catalunya.', false), ('D', 'A l''Institut de Seguretat Pública de Catalunya.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 2.3 del Decret 222/2013, en l''exercici de les funcions del Comitè d''Ètica, els seus membres actuen d''acord amb els principis de:', 'L''article 2.3 del Decret 222/2013 enumera aquests quatre principis; l''apartat 2.2 imposa als membres dels cossos de policia un deure general de col·laboració amb el Comitè.', 'plcat_t22_etica_policial', (select id from public.topics where slug = 'plcat-t22-etica-policial'), 2, 'ca', true, (select id from public.sources where url = 'https://portaljuridic.gencat.cat/ca/document-del-pjur/?documentId=643826'), 'D222/2013 art. 2.3', '2.3 En l''exercici de les funcions atribuïdes al Comitè d''Ètica de la Policia de Catalunya, els seus membres actuen d''acord amb els principis d’independència, objectivitat, imparcialitat i integritat personal.', null, 'd84c6a7cf490314f7f8fa4d38de643fab4c297309cef1de99b9674fda648b656', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'd84c6a7cf490314f7f8fa4d38de643fab4c297309cef1de99b9674fda648b656')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Jerarquia, disciplina, lleialtat i obediència.', false), ('B', 'Legalitat, eficàcia, economia, celeritat i publicitat de les deliberacions.', false), ('C', 'Independència, objectivitat, imparcialitat i integritat personal.', true), ('D', 'Proximitat, temprança, seny i coratge.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 3.1 del Decret 222/2013, la persona que ocupa la presidència del Comitè d''Ètica de la Policia de Catalunya és designada:', 'L''article 3.1 del Decret 222/2013 atribueix al titular del departament el nomenament dels deu membres i la designació de la presidència d''entre ells.', 'plcat_t22_etica_policial', (select id from public.topics where slug = 'plcat-t22-etica-policial'), 3, 'ca', true, (select id from public.sources where url = 'https://portaljuridic.gencat.cat/ca/document-del-pjur/?documentId=643826'), 'D222/2013 art. 3.1', 'd’entre els quals el conseller o consellera del departament esmentat ha de designar la persona que ocupi la presidència. La designació dels membres del Comitè es comunicarà posteriorment al Consell de Seguretat de Catalunya.', null, '027a123d3d9c2509d2bb6624fb714d9d604084aec22d4a6847bbfefe09e5cdfc', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '027a123d3d9c2509d2bb6624fb714d9d604084aec22d4a6847bbfefe09e5cdfc')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Pel Govern, a proposta del Parlament, per majoria de tres cinquenes parts dels diputats.', false), ('B', 'Pel conseller competent en seguretat pública, d''entre els membres.', true), ('C', 'Pels mateixos membres del Comitè, per majoria absoluta.', false), ('D', 'Pel director general de la Policia, d''entre els comandaments dels Mossos d''Esquadra amb més de deu anys d''antiguitat.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 3.2 del Decret 222/2013, quants membres del Comitè d''Ètica es designen entre membres de la Policia de la Generalitat-Mossos d''Esquadra?', 'L''article 3.2 del Decret 222/2013 reparteix els deu membres en cinc persones dels àmbits acadèmic o professional, tres dels Mossos d''Esquadra i dos de les policies locals, aquests darrers també amb deu anys d''antiguitat.', 'plcat_t22_etica_policial', (select id from public.topics where slug = 'plcat-t22-etica-policial'), 2, 'ca', true, (select id from public.sources where url = 'https://portaljuridic.gencat.cat/ca/document-del-pjur/?documentId=643826'), 'D222/2013 art. 3.2.b', 'b) Tres entre els membres de la Policia de la Generalitat – Mossos d''Esquadra, que tinguin una antiguitat mínima de deu anys en el cos', null, 'df9481ac2fbb0f5f7cad066ba7f769766dd632c387dbae9de54f74b06becdbec', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'df9481ac2fbb0f5f7cad066ba7f769766dd632c387dbae9de54f74b06becdbec')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Cinc, amb una antiguitat mínima de cinc anys en el cos.', false), ('B', 'Dos, amb una antiguitat mínima de quinze anys en el cos.', false), ('C', 'Quatre, sense requisit d''antiguitat.', false), ('D', 'Tres, amb una antiguitat mínima de deu anys en el cos.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 3.4 del Decret 222/2013, el càrrec de membre del Comitè d''Ètica de la Policia de Catalunya:', 'L''article 3.4 del Decret 222/2013 declara el càrrec no retribuït i reconeix les indemnitzacions per raó del servei als membres que no són personal públic.', 'plcat_t22_etica_policial', (select id from public.topics where slug = 'plcat-t22-etica-policial'), 1, 'ca', true, (select id from public.sources where url = 'https://portaljuridic.gencat.cat/ca/document-del-pjur/?documentId=643826'), 'D222/2013 art. 3.4', '3.4 El càrrec de membre del Comitè no és retribuït.', null, '636c32ec2bf93958fb40810f946edcd389d0eb9a4ad3f68610b5d6d4522955c6', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '636c32ec2bf93958fb40810f946edcd389d0eb9a4ad3f68610b5d6d4522955c6')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'És retribuït amb un sou fix mensual a càrrec del departament d''adscripció.', false), ('B', 'No és retribuït.', true), ('C', 'És retribuït només per a la presidència i la secretaria.', false), ('D', 'És incompatible amb qualsevol indemnització.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 3.5 del Decret 222/2013, altres persones expertes, assessors externs o entitats de defensa dels drets humans poden assistir a les sessions del Comitè d''Ètica:', 'L''article 3.5 del Decret 222/2013 permet l''assistència d''experts i entitats amb veu però sense vot, prèvia invitació del president; l''apartat 3.6 demana respectar la paritat de gènere en la composició.', 'plcat_t22_etica_policial', (select id from public.topics where slug = 'plcat-t22-etica-policial'), 2, 'ca', true, (select id from public.sources where url = 'https://portaljuridic.gencat.cat/ca/document-del-pjur/?documentId=643826'), 'D222/2013 art. 3.5', '3.5 Poden assistir a les sessions del Comitè, amb veu però sense vot, i sempre amb la invitació prèvia del seu president', null, 'ad82b1e5887e5c7c7fc589e6f29df65ced1f54a54a57b902c837319adb5dcb03', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'ad82b1e5887e5c7c7fc589e6f29df65ced1f54a54a57b902c837319adb5dcb03')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Amb veu i vot, si ho acorda la majoria dels membres.', false), ('B', 'Sense veu ni vot, només com a observadors, i sense necessitat d''invitació.', false), ('C', 'Amb veu però sense vot, si el president els convida.', true), ('D', 'Amb vot de qualitat en cas d''empat.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 4.2 del Decret 222/2013, en els supòsits d''absència, malaltia o vacant, el president o presidenta del Comitè d''Ètica és substituït per:', 'L''article 4.2 del Decret 222/2013 preveu la substitució de la presidència per la persona membre de més edat.', 'plcat_t22_etica_policial', (select id from public.topics where slug = 'plcat-t22-etica-policial'), 2, 'ca', true, (select id from public.sources where url = 'https://portaljuridic.gencat.cat/ca/document-del-pjur/?documentId=643826'), 'D222/2013 art. 4.2', '4.2 En els supòsits d’absència, malaltia o vacant, el president o presidenta del Comitè és substituït per la persona membre de més edat.', null, '604cda43ffd1419f1b1f0c4703bd98cdacc12a7e18e4b9765151d8ba2a41d6d8', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '604cda43ffd1419f1b1f0c4703bd98cdacc12a7e18e4b9765151d8ba2a41d6d8')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'La persona membre de més edat.', true), ('B', 'La persona membre de menys edat.', false), ('C', 'El secretari o secretària del Comitè.', false), ('D', 'La persona membre amb més antiguitat en un cos policial.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 6.3 del Decret 222/2013, el quòrum de constitució del Comitè d''Ètica de la Policia de Catalunya és:', 'L''article 6.3 del Decret 222/2013 exigeix la majoria absoluta dels membres i la presència de la presidència o de qui la substitueixi.', 'plcat_t22_etica_policial', (select id from public.topics where slug = 'plcat-t22-etica-policial'), 3, 'ca', true, (select id from public.sources where url = 'https://portaljuridic.gencat.cat/ca/document-del-pjur/?documentId=643826'), 'D222/2013 art. 6.3', '6.3 El quòrum de constitució del Comitè és el de l''assistència de la majoria absoluta dels membres, entre els quals es compta el/la president/a o la persona que el substitueix.', null, 'd5715349dfaa0c28480c3d3c8dab6b507f84af4591c359a331dcc74f7d82c718', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'd5715349dfaa0c28480c3d3c8dab6b507f84af4591c359a331dcc74f7d82c718')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'L''assistència de dos terços dels membres.', false), ('B', 'L''assistència de la meitat dels membres, sense que calgui la presència del president ni del seu substitut.', false), ('C', 'L''assistència de tres membres qualssevol.', false), ('D', 'La majoria absoluta dels membres, inclòs el president o el seu substitut.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 6.4 del Decret 222/2013, els informes del Comitè d''Ètica de la Policia de Catalunya s''emeten:', 'L''article 6.4 del Decret 222/2013 estableix la majoria dels vots dels assistents i el vot de qualitat de la presidència; l''article 6.2 fixa una antelació mínima de cinc dies per trametre l''ordre del dia.', 'plcat_t22_etica_policial', (select id from public.topics where slug = 'plcat-t22-etica-policial'), 2, 'ca', true, (select id from public.sources where url = 'https://portaljuridic.gencat.cat/ca/document-del-pjur/?documentId=643826'), 'D222/2013 art. 6.4', '6.4 Els informes del Comitè s''emetran amb la majoria dels vots dels assistents, sens perjudici de l’emissió d’opinions particulars, si s’escau, i la presidència té vot de qualitat.', null, '9f9943a4f5ca72a293800a38f0508f8286c14bb188a849ade52f39d6f5855f40', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '9f9943a4f5ca72a293800a38f0508f8286c14bb188a849ade52f39d6f5855f40')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Per unanimitat dels membres presents.', false), ('B', 'Per majoria de dos terços dels membres, sense que es puguin emetre opinions particulars.', false), ('C', 'Per decisió exclusiva de la presidència.', false), ('D', 'Per majoria dels vots dels assistents, amb vot de qualitat de la presidència.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
-- Lote plcat-t23-igualtat-no-discriminacio-ligcat-v1 (10 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Ley 17/2015, de 21 de julio, de igualdad efectiva de mujeres y hombres (Cataluña) (texto consolidado, BOE)', 'https://www.boe.es/buscar/act.php?id=BOE-A-2015-9676', 'boe'::public.source_kind, 'Agencia Estatal Boletín Oficial del Estado', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('plcat-t23-igualtat-no-discriminacio', 'Tema 23. Igualtat efectiva de dones i homes (Llei 17/2015) i igualtat de tracte i no-discriminació (Llei 19/2020)') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('policia-local') and t.slug = 'plcat-t23-igualtat-no-discriminacio' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 2 de la Llei 17/2015, qualsevol instrucció que impliqui la discriminació, directa o indirecta, per raó de sexe s''anomena:', 'L''article 2.n) de la Llei 17/2015 defineix l''ordre de discriminar; l''article 4.w) de la Llei 19/2020 en fa una definició paral·lela referida a tots els motius de discriminació.', 'plcat_t23_igualtat_no_discriminacio', (select id from public.topics where slug = 'plcat-t23-igualtat-no-discriminacio'), 2, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2015-9676'), 'Art. 2.n Llei 17/2015', 'n) Orden de discriminar: cualquier instrucción que implique la discriminación, directa o indirecta, por razón de sexo.', null, '3395df6e50c104a8f416d5268f9fa5b7d87df653214b78aaf9541c3186e5ee22', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '3395df6e50c104a8f416d5268f9fa5b7d87df653214b78aaf9541c3186e5ee22')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Discriminació indirecta.', false), ('B', 'Ordre de discriminar.', true), ('C', 'Assetjament per raó de sexe.', false), ('D', 'Estereotip de gènere.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 2.j) de la Llei 17/2015, les imatges simplificades que atribueixen uns rols fixats sobre els comportaments suposadament «correctes» o «normals» de les persones en funció del sexe són:', 'L''article 2.j) de la Llei 17/2015 defineix els estereotips de gènere i afirma que són a la base de la discriminació entre homes i dones.', 'plcat_t23_igualtat_no_discriminacio', (select id from public.topics where slug = 'plcat-t23-igualtat-no-discriminacio'), 1, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2015-9676'), 'Art. 2.j Llei 17/2015', 'j) Estereotipos de género: las imágenes simplificadas que atribuyen unos roles fijados sobre los comportamientos supuestamente «correctos» o «normales» de las personas en un contexto determinado en función del sexo al que pertenecen.', null, '6a69f718ff0d8e2e0f25c4cdaa4f083b8f9b9ada4025973f73a19e1a52851f9c', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '6a69f718ff0d8e2e0f25c4cdaa4f083b8f9b9ada4025973f73a19e1a52851f9c')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Perspectiva de gènere.', false), ('B', 'Equitat de gènere.', false), ('C', 'Estereotips de gènere.', true), ('D', 'Coeducació.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 7.2 de la Llei 17/2015, són òrgans consultius de l''Administració de la Generalitat en matèria de polítiques d''igualtat de gènere:', 'L''article 7.2 de la Llei 17/2015 cita aquests dos òrgans consultius; l''Institut Català de les Dones és l''organisme a través del qual la Generalitat exerceix les competències (art. 7.1.a).', 'plcat_t23_igualtat_no_discriminacio', (select id from public.topics where slug = 'plcat-t23-igualtat-no-discriminacio'), 3, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2015-9676'), 'Art. 7.2 Llei 17/2015', '2. Son órganos consultivos de la Administración de la Generalidad en materia de políticas de igualdad de género: a) El Consejo Nacional de las Mujeres de Cataluña […] b) La Comisión Nacional para una Intervención Coordinada contra la Violencia Machista', null, 'b07d6e9a8db5b09476bd104de1fbbc1a954be812405f6265554841a602200dfe', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'b07d6e9a8db5b09476bd104de1fbbc1a954be812405f6265554841a602200dfe')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El Consell Nacional de les Dones de Catalunya i la Comissió Nacional contra la Violència Masclista.', true), ('B', 'L''Institut Català de les Dones i el Síndic de Greuges, com a defensor de la igualtat de gènere.', false), ('C', 'L''Observatori de la Igualtat de Gènere i la Comissió Jurídica Assessora de la Generalitat de Catalunya.', false), ('D', 'El Consell de Seguretat de Catalunya i el Comitè d''Ètica de la Policia de Catalunya.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 12 de la Llei 17/2015, les mesures de representació paritària en els òrgans col·legiats de les administracions públiques NO tenen efecte:', 'L''article 12.1 de la Llei 17/2015 imposa el principi de representació paritària en tota mena d''òrgans col·legiats i l''apartat 2 n''exceptua els que promouen els drets d''un dels dos sexes.', 'plcat_t23_igualtat_no_discriminacio', (select id from public.topics where slug = 'plcat-t23-igualtat-no-discriminacio'), 2, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2015-9676'), 'Art. 12.2 Llei 17/2015', '2. Las medidas de representación paritaria no tienen efecto para los órganos constituidos para la promoción de los derechos e intereses de uno de los dos sexos.', null, 'be240fbeeacc136312c79ed3ea80065fc6eda1f1960af9de56552aad1be997b6', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'be240fbeeacc136312c79ed3ea80065fc6eda1f1960af9de56552aad1be997b6')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'En els òrgans col·legiats de les administracions locals de menys de 20.000 habitants.', false), ('B', 'En els tribunals de selecció de personal.', false), ('C', 'En els òrgans col·legiats de menys de deu membres.', false), ('D', 'En els òrgans que promouen els drets d''un dels dos sexes.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 15.4 de la Llei 17/2015, els plans d''igualtat de dones i homes del sector públic han d''incloure mesures específiques per al personal dels cossos i forces de seguretat, i la seva avaluació ha de ser:', 'L''article 15.4 de la Llei 17/2015 exigeix, entre altres requisits, mesures específiques per a col·lectius com bombers, agents rurals i cossos i forces de seguretat (lletra c) i una avaluació quadriennal regulada en el mateix pla (lletra e).', 'plcat_t23_igualtat_no_discriminacio', (select id from public.topics where slug = 'plcat-t23-igualtat-no-discriminacio'), 3, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2015-9676'), 'Art. 15.4 Llei 17/2015', 'así como de bomberos, agentes rurales y cuerpos y fuerzas de seguridad. […] e) Regular en el articulado la propia evaluación, que debe ser cuatrienal.', null, '7861fe66c52ac3bea5285e7f4f377b1e26c8959d0314f8e3892074ee76278ba2', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '7861fe66c52ac3bea5285e7f4f377b1e26c8959d0314f8e3892074ee76278ba2')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Anual.', false), ('B', 'Biennal.', false), ('C', 'Quadriennal.', true), ('D', 'Quinquennal.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 16.2 de la Llei 17/2015, les administracions públiques de Catalunya han d''impulsar la representació paritària de dones i homes en:', 'L''article 16 de la Llei 17/2015 regula la igualtat en la funció pública: criteris per a les bases de les convocatòries, paritat en els tribunals, temaris amb continguts d''igualtat i formació del personal.', 'plcat_t23_igualtat_no_discriminacio', (select id from public.topics where slug = 'plcat-t23-igualtat-no-discriminacio'), 1, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2015-9676'), 'Art. 16.2 Llei 17/2015', '2. Las administraciones públicas de Cataluña deben impulsar la representación paritaria de mujeres y hombres en la composición de los tribunales u órganos técnicos de selección.', null, '2ca70fdc028cb0c434a9fa39b24c5314e182fa5d460aa665198ceab3c1ab1cc2', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '2ca70fdc028cb0c434a9fa39b24c5314e182fa5d460aa665198ceab3c1ab1cc2')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'La composició dels tribunals o òrgans tècnics de selecció.', true), ('B', 'Les plantilles de tots els cossos policials, mitjançant quotes obligatòries.', false), ('C', 'Els òrgans de govern dels partits polítics.', false), ('D', 'Les juntes directives de les empreses privades.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 55.1 de la Llei 17/2015, el departament competent en matèria de seguretat, a més d''incloure la perspectiva de gènere en les enquestes i diagnosis, ha de:', 'L''article 55.1 de la Llei 17/2015 obliga el departament de seguretat a incorporar la perspectiva de gènere, adoptar mesures per erradicar la violència masclista a nivell comunitari i promoure el treball amb els homes.', 'plcat_t23_igualtat_no_discriminacio', (select id from public.topics where slug = 'plcat-t23-igualtat-no-discriminacio'), 2, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2015-9676'), 'Art. 55.1.c Llei 17/2015', 'c) Promover el trabajo con los hombres a fin de que no ejerzan ningún tipo de violencia machista.', null, '58eef7772faab2a09e60d26927f89ff61d4aea588324d6196d939468ba1cc663', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '58eef7772faab2a09e60d26927f89ff61d4aea588324d6196d939468ba1cc663')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Crear unitats policials integrades exclusivament per dones en totes les comissaries.', false), ('B', 'Promoure el treball amb els homes perquè no exerceixin violència masclista.', true), ('C', 'Aprovar el pla d''igualtat de cada ajuntament.', false), ('D', 'Gestionar els serveis d''acollida de les víctimes.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 58.1 de la Llei 17/2015, l''Observatori de la Igualtat de Gènere:', 'L''article 58 de la Llei 17/2015 crea l''Observatori, adscrit a l''Institut Català de les Dones, i prioritza en els seus estudis la violència de gènere, la situació laboral i la imatge pública de les dones.', 'plcat_t23_igualtat_no_discriminacio', (select id from public.topics where slug = 'plcat-t23-igualtat-no-discriminacio'), 2, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2015-9676'), 'Art. 58.1 Llei 17/2015', 'Se crea el Observatorio de la Igualdad de Género adscrito al Instituto Catalán de las Mujeres, como órgano asesor del Gobierno', null, 'be0bfc3f3e573d820d8018fc47940663922c475e7655b7d55c4402da10e603af', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'be0bfc3f3e573d820d8018fc47940663922c475e7655b7d55c4402da10e603af')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'S''adscriu al Síndic de Greuges com a òrgan sancionador.', false), ('B', 'S''adscriu al Parlament com a òrgan de control polític.', false), ('C', 'És un òrgan de la Comissió Nacional per a una Intervenció Coordinada contra la Violència Masclista.', false), ('D', 'S''adscriu a l''Institut Català de les Dones com a òrgan assessor del Govern.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 59 de la Llei 17/2015, negar-se a col·laborar amb els serveis d''inspecció de la Generalitat és una infracció:', 'L''article 59.2 de la Llei 17/2015 qualifica de lleu negar-se a col·laborar amb la inspecció; en canvi, obstruir-ne l''actuació o negar-se totalment a col·laborar és greu (art. 59.3.a).', 'plcat_t23_igualtat_no_discriminacio', (select id from public.topics where slug = 'plcat-t23-igualtat-no-discriminacio'), 1, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2015-9676'), 'Art. 59.2 Llei 17/2015', '2. Son infracciones leves: a) Negarse a colaborar con los servicios de inspección de la Generalidad.', null, 'b0411670b8bf96fa1f4badffe80fc83640961ba9e9b1abd7a55d3b8519b00144', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'b0411670b8bf96fa1f4badffe80fc83640961ba9e9b1abd7a55d3b8519b00144')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Greu.', false), ('B', 'Molt greu.', false), ('C', 'Lleu.', true), ('D', 'No és infracció administrativa.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 62.1 de la Llei 17/2015, la competència per incoar els expedients sancionadors i imposar les sancions previstes en aquesta llei correspon a:', 'L''article 62.1 de la Llei 17/2015 atribueix la potestat sancionadora a la secretaria general del departament competent; el Síndic de Greuges fa funcions de defensa i investigació (art. 57), no sanciona.', 'plcat_t23_igualtat_no_discriminacio', (select id from public.topics where slug = 'plcat-t23-igualtat-no-discriminacio'), 3, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2015-9676'), 'Art. 62.1 Llei 17/2015', '1. La competencia para incoar los expedientes administrativos del régimen sancionador de la presente ley y la imposición de las sanciones corresponde a la persona titular de la secretaría general del departamento competente en materia de igualdad de mujeres y hombres.', null, '3888cd0f245ed842799ba62dd601b03c8df92ddc4daf30c28b668b5943c48981', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '3888cd0f245ed842799ba62dd601b03c8df92ddc4daf30c28b668b5943c48981')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El Síndic de Greuges.', false), ('B', 'La direcció de l''Institut Català de les Dones, amb informe previ de l''Observatori.', false), ('C', 'L''alcalde del municipi on s''ha comès la infracció, que la pot delegar.', false), ('D', 'La secretaria general del departament competent en igualtat.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
-- Lote plcat-t23-igualtat-no-discriminacio-ltracte-v1 (10 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Ley 19/2020, de 30 de diciembre, de igualdad de trato y no discriminación (Cataluña) (texto consolidado, BOE)', 'https://www.boe.es/buscar/act.php?id=BOE-A-2021-1663', 'boe'::public.source_kind, 'Agencia Estatal Boletín Oficial del Estado', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('plcat-t23-igualtat-no-discriminacio', 'Tema 23. Igualtat efectiva de dones i homes (Llei 17/2015) i igualtat de tracte i no-discriminació (Llei 19/2020)') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('policia-local') and t.slug = 'plcat-t23-igualtat-no-discriminacio' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 1.3 de la Llei 19/2020, la islamofòbia, la cristianofòbia o la judeofòbia s''inclouen en el motiu de discriminació de:', 'L''article 1.3.g) de la Llei 19/2020 inclou en les conviccions religioses qualsevol manifestació d''islamofòbia, cristianofòbia o judeofòbia; l''antisemitisme i l''antigitanisme s''esmenten com a formes de racisme (lletra d).', 'plcat_t23_igualtat_no_discriminacio', (select id from public.topics where slug = 'plcat-t23-igualtat-no-discriminacio'), 1, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2021-1663'), 'Art. 1.3.g Llei 19/2020', 'g) Convicciones religiosas, y cualquier manifestación de islamofobia, de cristianofobia o de judeofobia.', null, 'b159d10de3304758e2fedae936869537c86d180083a92e7d727e692be59d8b94', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'b159d10de3304758e2fedae936869537c86d180083a92e7d727e692be59d8b94')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Origen territorial o nacional.', false), ('B', 'Conviccions religioses.', true), ('C', 'Llengua o identitat cultural.', false), ('D', 'Aspecte físic o indumentària.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 2 de la Llei 19/2020, la llei s''aplica a les persones físiques i jurídiques situades o que actuen a Catalunya:', 'L''article 2 de la Llei 19/2020 estableix un àmbit subjectiu (sector públic i privat), objectiu (tots els àmbits) i territorial ampli, que inclou l''entorn digital.', 'plcat_t23_igualtat_no_discriminacio', (select id from public.topics where slug = 'plcat-t23-igualtat-no-discriminacio'), 2, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2021-1663'), 'Art. 2 Llei 19/2020', 'con independencia de que operen de forma personal, presencial y directa, en el entorno de las redes sociales o por medios telemáticos con origen o destino en el ámbito territorial de Cataluña.', null, 'bf437e669149d8b229d59bfdceb0227919594a54795fe000f6dfed46f28ef2af', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'bf437e669149d8b229d59bfdceb0227919594a54795fe000f6dfed46f28ef2af')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'També quan actuen a les xarxes socials o per mitjans telemàtics.', true), ('B', 'Només quan actuen de manera presencial i directa dins del territori de Catalunya.', false), ('C', 'Només si pertanyen al sector públic o gestionen serveis públics.', false), ('D', 'Només quan l''acte discriminatori constitueix delicte.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 4 de la Llei 19/2020, el maltractament exercit contra persones o grups pel fet de defensar persones o grups discriminats s''anomena:', 'L''article 4.k) de la Llei 19/2020 defineix la discriminació de segon ordre; la represàlia discriminatòria (4.y) és el tracte advers de l''Administració per haver presentat una queixa o denúncia.', 'plcat_t23_igualtat_no_discriminacio', (select id from public.topics where slug = 'plcat-t23-igualtat-no-discriminacio'), 2, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2021-1663'), 'Art. 4.k Llei 19/2020', 'k) Discriminación de segundo orden: El maltrato ejercido contra personas o grupos de personas por el hecho de defender a personas o grupos discriminados.', null, '7f933ed1a5cdb332b655dd9ff97ed678efdf68c5313586cfaf70c620f88a986b', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '7f933ed1a5cdb332b655dd9ff97ed678efdf68c5313586cfaf70c620f88a986b')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Discriminació per associació.', false), ('B', 'Discriminació de segon ordre.', true), ('C', 'Represàlia discriminatòria.', false), ('D', 'Victimització secundària.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Una persona és discriminada perquè se li atribueix erròniament una religió que no professa. Segons l''article 4 de la Llei 19/2020, és un cas de:', 'L''article 4.p) de la Llei 19/2020 defineix la discriminació per error com la que pateix qui és objecte de discriminació perquè se li ha atribuït erròniament una característica, circumstància o condició.', 'plcat_t23_igualtat_no_discriminacio', (select id from public.topics where slug = 'plcat-t23-igualtat-no-discriminacio'), 1, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2021-1663'), 'Art. 4.p Llei 19/2020', 'p) Discriminación por error: La discriminación que se produce cuando una persona es objeto de ella por el hecho de haberle atribuido erróneamente alguna característica, circunstancia o condición.', null, '498f44dfeaa431139acbefc164bb175d3a49ff7ee4abc9e454441de104c88ad4', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '498f44dfeaa431139acbefc164bb175d3a49ff7ee4abc9e454441de104c88ad4')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Discriminació per error.', true), ('B', 'Discriminació per associació.', false), ('C', 'Discriminació indirecta.', false), ('D', 'Discriminació per estigmatització.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 4 de la Llei 19/2020, l''estereotipació i la discriminació contra persones o grups sobre la base de la seva edat s''anomena:', 'L''article 4.s) de la Llei 19/2020 defineix l''edatisme; el capacitisme (4.g) és l''aversió o discriminació contra les persones amb diversitat funcional.', 'plcat_t23_igualtat_no_discriminacio', (select id from public.topics where slug = 'plcat-t23-igualtat-no-discriminacio'), 1, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2021-1663'), 'Art. 4.s Llei 19/2020', 's) Edadismo: La estereotipación y la discriminación contra personas o grupos en base a su edad.', null, 'b701fef26b1f9025fd27d5d9c81c967f417da514cf2ba9e48db5b7d067fe5d4d', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'b701fef26b1f9025fd27d5d9c81c967f417da514cf2ba9e48db5b7d067fe5d4d')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Capacitisme.', false), ('B', 'Aporofòbia.', false), ('C', 'Edatisme.', true), ('D', 'Estigmatització.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 21.5 de la Llei 19/2020, els subjectes responsables del compliment de la llei en l''àmbit dels cossos i forces de seguretat han d''establir:', 'L''article 21 de la Llei 19/2020 prohibeix els perfils racials (apartat 4) i obliga a establir un sistema de registre i vigilància d''incidents racistes, homofòbics i transfòbics (apartat 5), a més de programes de formació (apartat 6).', 'plcat_t23_igualtat_no_discriminacio', (select id from public.topics where slug = 'plcat-t23-igualtat-no-discriminacio'), 3, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2021-1663'), 'Art. 21.5 Llei 19/2020', '5. Los sujetos responsables del cumplimiento de la Ley deben establecer un sistema de registro y vigilancia de incidentes racistas, homofóbicos y transfóbicos, así como del grado en que estos incidentes son tratados judicialmente', null, '92ae2aae1a340f634f5287e560c43d219110e7f97362e08845742be3057793f7', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '92ae2aae1a340f634f5287e560c43d219110e7f97362e08845742be3057793f7')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Un registre públic, consultable per tothom, de les persones denunciades per discriminació.', false), ('B', 'Una unitat de mediació obligatòria en cada comissaria.', false), ('C', 'Un règim disciplinari propi i diferent del de la resta de funcionaris.', false), ('D', 'Un sistema de registre i vigilància d''incidents racistes, homofòbics i transfòbics.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 22.4 de la Llei 19/2020, en el procediment administratiu d''instrucció d''un cas de discriminació, si la persona que al·lega haver-la patit aporta indicis racionals i fonamentats:', 'L''article 22.4 de la Llei 19/2020 estableix la inversió de la càrrega de la prova quan hi ha indicis racionals i fonamentats de discriminació.', 'plcat_t23_igualtat_no_discriminacio', (select id from public.topics where slug = 'plcat-t23-igualtat-no-discriminacio'), 2, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2021-1663'), 'Art. 22.4 Llei 19/2020', 'si la persona que alega haberla sufrido aporta indicios racionales y fundamentados, se debe aplicar la inversión de la carga de la prueba sobre cuya base corresponde a la parte que ha infligido la discriminación probar que su comportamiento no ha sido discriminatorio.', null, '9333ef1030a1a6c24c0542891a402806cdb1d5184ed5453b1d36d3ee9bcbf975', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '9333ef1030a1a6c24c0542891a402806cdb1d5184ed5453b1d36d3ee9bcbf975')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'S''inverteix la càrrega de la prova.', true), ('B', 'La persona que l''al·lega ha d''aportar sempre una prova plena dels fets.', false), ('C', 'El procediment s''ha de suspendre fins que hi hagi sentència penal.', false), ('D', 'L''Administració ha d''arxivar el cas si no hi ha testimonis.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 45.1 de la Llei 19/2020, les infraccions molt greus en matèria d''igualtat de tracte i no-discriminació se sancionen amb multa de:', 'L''article 45.1 de la Llei 19/2020 fixa multes de 300 a 10.000 euros (lleus), de 10.001 a 40.000 (greus) i de 40.001 a 500.000 (molt greus).', 'plcat_t23_igualtat_no_discriminacio', (select id from public.topics where slug = 'plcat-t23-igualtat-no-discriminacio'), 2, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2021-1663'), 'Art. 45.1.c Llei 19/2020', 'c) Infracciones muy graves, entre 40.001 y 500.000 euros.', 'El text consolidat del BOE de la Llei 19/2020 consta com a «Desactualizado» (última actualització 2022): comprovar la quantia vigent al Portal Jurídic de Catalunya.', '9a1ad042ab3860d273300cd52f3ef5a257bdd48cfe9bd545d5e6d330f118c46c', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '9a1ad042ab3860d273300cd52f3ef5a257bdd48cfe9bd545d5e6d330f118c46c')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Entre 10.001 i 40.000 euros.', false), ('B', 'Entre 300 i 10.000 euros.', false), ('C', 'Entre 100.001 i 1.000.000 d''euros.', false), ('D', 'Entre 40.001 i 500.000 euros.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 47.1 de la Llei 19/2020, la sanció imposada per una infracció lleu o greu es pot substituir per la cooperació no retribuïda de l''infractor en activitats d''utilitat pública o per l''assistència a cursos de formació:', 'L''article 47.1 de la Llei 19/2020 permet la substitució de les sancions lleus o greus per mesures alternatives de conscienciació i reparació, sempre amb el consentiment de la persona sancionada.', 'plcat_t23_igualtat_no_discriminacio', (select id from public.topics where slug = 'plcat-t23-igualtat-no-discriminacio'), 2, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2021-1663'), 'Art. 47.1 Llei 19/2020', 'La sanción impuesta por la comisión de una infracción leve o de una infracción grave puede ser sustituida por el órgano que resuelva el expediente sancionador, con el consentimiento de la persona sancionada', null, '7f679c6b81bd5b2daa335d139e0f91ef375974f0b2102b6f0eba6b919e45e375', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '7f679c6b81bd5b2daa335d139e0f91ef375974f0b2102b6f0eba6b919e45e375')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'En tot cas, encara que la persona sancionada s''hi oposi.', false), ('B', 'Només si la infracció és molt greu.', false), ('C', 'Amb el consentiment de la persona sancionada.', true), ('D', 'Només per decisió judicial.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons l''article 48.2 de la Llei 19/2020, les sancions imposades per infraccions greus prescriuen al cap de:', 'L''article 48.2 de la Llei 19/2020 fixa la prescripció de les sancions en un any (lleus), quatre anys (greus) i cinc anys (molt greus); les infraccions greus prescriuen als tres anys (art. 48.1).', 'plcat_t23_igualtat_no_discriminacio', (select id from public.topics where slug = 'plcat-t23-igualtat-no-discriminacio'), 3, 'ca', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2021-1663'), 'Art. 48.2 Llei 19/2020', '2. Las sanciones impuestas al amparo de la presente ley prescriben al cabo de un año, si son leves; al cabo de cuatro años, si son graves, y al cabo de cinco años, si son muy graves.', 'El text consolidat del BOE de la Llei 19/2020 consta com a «Desactualizado» (última actualització 2022): comprovar el termini vigent al Portal Jurídic de Catalunya.', 'ac7353528f567d281f502b2970fc19266ea355e21ee7f2969f10fbe0398922bc', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'ac7353528f567d281f502b2970fc19266ea355e21ee7f2969f10fbe0398922bc')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Tres anys.', false), ('B', 'Quatre anys.', true), ('C', 'Cinc anys.', false), ('D', 'Un any.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('policia-local');
commit;
