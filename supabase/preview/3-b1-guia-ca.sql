-- Lote mossos-b1-estatut-guia-v1 (30 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Guia d''estudi per accedir a la PG-ME, 1a edició, juny de 2026 (convocatòria 46/26), tema B.1, pp. 94-106', 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf', 'web_oficial'::public.source_kind, 'Generalitat de Catalunya · Mossos d''Esquadra (web oficial de la convocatòria 46/26)', '2026-06-01') on conflict (url) do nothing;
insert into public.topics (slug, title) values ('mossos-b1-estatut', 'B.1 L''Estatut d''autonomia de Catalunya') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug = 'mossos-esquadra' and t.slug = 'mossos-b1-estatut' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, per quin procediment constitucional va accedir Catalunya a l’autonomia amb l’Estatut de 1979?', 'La guia explica que Catalunya va accedir a l’autonomia pel procediment de l’article 151.2 CE, amb l’Estatut aprovat per la Llei orgànica 4/1979, de 18 de desembre.', 'mossos_b1_estatut', (select id from public.topics where slug = 'mossos-b1-estatut'), 2, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf'), 'Guia p. 97, §1.1', 'En el marc de la Constitució espanyola de 1978 (CE), Catalunya accedia a l’autonomia pel procediment establert al seu article 151.2, mitjançant l’aprovació de l’Estatut d’autonomia de 1979 (Llei orgànica 4/1979, de 18 de desembre).', null, 'c99f9f265b41dab7fb103342ed00ccabb0f9cc75a006905d280f30dae1d9e71d', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'c99f9f265b41dab7fb103342ed00ccabb0f9cc75a006905d280f30dae1d9e71d')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Pel de l’article 143 CE, amb un període transitori de cinc anys.', false), ('B', 'Pel de l’article 151.2 CE.', true), ('C', 'Pel de la disposició addicional primera CE, relativa als drets històrics.', false), ('D', 'Pel de l’article 150.2 CE, mitjançant una llei orgànica de transferència.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, en quina data va aprovar el Ple del Parlament de Catalunya la proposta de reforma de l’Estatut?', 'El Ple del Parlament va aprovar la proposta el 30 de setembre de 2005 (120 vots a favor i 15 en contra). Les altres dates corresponen a l’aprovació al Congrés (30/03/2006), al Senat (10/05/2006) i al referèndum (18/06/2006).', 'mossos_b1_estatut', (select id from public.topics where slug = 'mossos-b1-estatut'), 3, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf'), 'Guia p. 97, §1.1', 'el text de la proposta fou aprovat pel Ple del Parlament el 30 de setembre de 2005 (amb 120 vots a favor i 15 en contra).', null, '99c7861b816c84302681f7efc47fdd796b01bfca83900b29590d3cbb2c8650ff', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '99c7861b816c84302681f7efc47fdd796b01bfca83900b29590d3cbb2c8650ff')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El 30 de setembre de 2005.', true), ('B', 'El 30 de març de 2006.', false), ('C', 'El 10 de maig de 2006.', false), ('D', 'El 18 de juny de 2006.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, quin òrgan va emetre el Dictamen núm. 269, que es va pronunciar sobre la constitucionalitat de la proposta de reforma de l’Estatut?', 'El Dictamen núm. 269 (5 de setembre de 2005) el va emetre el Consell Consultiu, entre la tramitació a la Comissió i l’aprovació pel Ple del Parlament.', 'mossos_b1_estatut', (select id from public.topics where slug = 'mossos-b1-estatut'), 2, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf'), 'Guia p. 97, §1.1', 'Entre les dues darreres etapes hi hagué el Dictamen núm. 269 del Consell Consultiu (5 de setembre de 2005), que va pronunciar-se sobre la constitucionalitat de la proposta.', null, '035431c6a3ba4944ab8171df00b049a3a4ea0e0bf6a0bfee2cd9875eb83b22ab', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '035431c6a3ba4944ab8171df00b049a3a4ea0e0bf6a0bfee2cd9875eb83b22ab')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El Tribunal Constitucional.', false), ('B', 'La Comissió Constitucional del Congrés dels Diputats.', false), ('C', 'El Consell d’Estat.', false), ('D', 'El Consell Consultiu.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, quin paper va tenir el Senat en la tramitació de la reforma de l’Estatut?', 'La guia indica que el Senat va tramitar el text i el va aprovar el 10 de maig de 2006 sense introduir-hi modificacions.', 'mossos_b1_estatut', (select id from public.topics where slug = 'mossos-b1-estatut'), 2, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf'), 'Guia p. 97, §1.1', 'i tramitació del text pel Senat, que l’aprovà el 10 de maig de 2006, sense introduir-hi modificacions.', null, '4e23fca567911dede163661843ec12837f59085a55f2c3bc07f895642a601520', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '4e23fca567911dede163661843ec12837f59085a55f2c3bc07f895642a601520')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Hi va introduir esmenes que van obligar a una segona votació al Congrés.', false), ('B', 'No hi va intervenir, perquè la reforma només l’havia d’aprovar el Congrés.', false), ('C', 'Va aprovar el text el 10 de maig de 2006 sense introduir-hi modificacions.', true), ('D', 'El va rebutjar, i el Congrés el va aprovar finalment per majoria absoluta.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, quan va entrar en vigor la reforma de l’Estatut aprovada per la Llei orgànica 6/2006?', 'La LO 6/2006 és de 19 de juliol, però l’Estatut va entrar en vigor el 9 d’agost de 2006. El 18 de juny de 2006 es va fer el referèndum i el 28 de juny de 2010 és la data de la STC 31/2010.', 'mossos_b1_estatut', (select id from public.topics where slug = 'mossos-b1-estatut'), 2, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf'), 'Guia p. 97, §1.1', 'la reforma de l’Estatut d’autonomia de Catalunya (EAC), aprovada per la Llei orgànica 6/2006, de 19 de juliol, va entrar en vigor el dia 9 d’agost de 2006.', null, '763c3667e245ab75e04a52070d0fcef6c7fade782b4e12732c778a7af4108982', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '763c3667e245ab75e04a52070d0fcef6c7fade782b4e12732c778a7af4108982')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El 18 de juny de 2006.', false), ('B', 'El 19 de juliol de 2006.', false), ('C', 'El 9 d’agost de 2006.', true), ('D', 'El 28 de juny de 2010.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, quina d’aquestes matèries es troba entre els articles de l’EAC que la Sentència 31/2010 del Tribunal Constitucional va declarar inconstitucionals?', 'Entre els articles declarats inconstitucionals, la guia destaca els referits a la llengua catalana, el Consell de Garanties Estatutàries, el Síndic de Greuges, el Consell de Justícia de Catalunya, l’Administració de justícia, la participació en els tributs estatals i les finances locals.', 'mossos_b1_estatut', (select id from public.topics where slug = 'mossos-b1-estatut'), 3, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf'), 'Guia p. 97, §1.1', 'El Tribunal Constitucional, en la Sentència 31/2010, de 28 de juny, va declarar inconstitucionals alguns articles de l’EAC, entre els quals destaquen els referits a la llengua catalana, el Consell de Garanties Estatutàries, el Síndic de Greuges, el Consell de Justícia de Catalunya, les competències sobre l’Administració de justícia, la participació en els tributs estatals i les finances dels governs locals.', 'DUBTOSA (2a revisió de Claude): la guia simplifica; la STC 31/2010 va anul·lar apartats concrets, no la institució sencera. L’enunciat diu «articles referits a», com la guia. Comprova que t’agrada la formulació.', 'e5e61e3b61b5a658a3bc4cae10ed91b551604b339a53f7682c97d234572378e0', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'e5e61e3b61b5a658a3bc4cae10ed91b551604b339a53f7682c97d234572378e0')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Els símbols nacionals de Catalunya.', false), ('B', 'El Consell de Garanties Estatutàries.', true), ('C', 'La capitalitat de Barcelona.', false), ('D', 'El control i la vigilància del trànsit.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, en quin principi es basa la transformació de l’Estat unitari en un Estat descentralitzat políticament prevista al títol VIII de la Constitució?', 'És el principi dispositiu: són els mateixos territoris (nacionalitats i regions de l’article 2 CE) els que decideixen exercir el dret a l’autonomia i com es configura la seva comunitat autònoma.', 'mossos_b1_estatut', (select id from public.topics where slug = 'mossos-b1-estatut'), 2, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf'), 'Guia p. 98, §1.2', 'Aquesta transformació es basa en el principi dispositiu, d’acord amb el qual són els mateixos territoris interessats, identificats com a nacionalitats i regions (article 2 CE), els que decideixen exercir el dret a l’autonomia i la configuració concreta que tindrà la respectiva comunitat autònoma.', null, 'e9bbb2965e78521916d515551c98da3a4a55ae68128bafa32fd7029e6e4cdc2b', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'e9bbb2965e78521916d515551c98da3a4a55ae68128bafa32fd7029e6e4cdc2b')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'En el principi de jerarquia normativa.', false), ('B', 'En el principi de solidaritat interterritorial.', false), ('C', 'En el principi de competència.', false), ('D', 'En el principi dispositiu.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, quina doble naturalesa jurídica té l’Estatut d’autonomia de Catalunya?', 'L’EAC és, d’una banda, la llei primera i fonamental de l’ordenament català (norma institucional bàsica) i, de l’altra, una llei orgànica aprovada per les Corts Generals.', 'mossos_b1_estatut', (select id from public.topics where slug = 'mossos-b1-estatut'), 1, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf'), 'Guia p. 98, §1.2', 'l’EAC té una doble naturalesa jurídica: d’una banda, és la llei primera i fonamental de l’ordenament jurídic català i, de l’altra, és una llei orgànica estatal.', null, 'a224ffc836532d39ab25fce006686a6fe07e07fa7edf877070b37d9809247ea6', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'a224ffc836532d39ab25fce006686a6fe07e07fa7edf877070b37d9809247ea6')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'És la llei primera i fonamental de l’ordenament jurídic català i, alhora, una llei orgànica estatal.', true), ('B', 'És una constitució autonòmica i, alhora, un tractat internacional entre l’Estat i Catalunya.', false), ('C', 'És una llei ordinària del Parlament de Catalunya i, alhora, un reglament estatal.', false), ('D', 'És una norma de dret comunitari i, alhora, una llei orgànica estatal.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, per què es diu que l’Estatut és una norma de caràcter paccionat?', 'És paccionat perquè tant l’aprovació com la reforma requereixen dues voluntats: l’autonòmica (Parlament de Catalunya) i l’estatal (Corts Generals).', 'mossos_b1_estatut', (select id from public.topics where slug = 'mossos-b1-estatut'), 2, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf'), 'Guia p. 98, §1.2', 'L’EAC és una norma de caràcter paccionat, ja que tant la seva aprovació com la seva reforma exigeixen la concurrència de dues voluntats, l’autonòmica i l’estatal.', null, '7ce29c7172a9fe62213aeb426b09bea2201e01affda3ee711effa1360e3cddee', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '7ce29c7172a9fe62213aeb426b09bea2201e01affda3ee711effa1360e3cddee')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Perquè el van pactar tots els grups del Parlament de Catalunya.', false), ('B', 'Perquè la seva aprovació i la seva reforma exigeixen la concurrència de la voluntat autonòmica i de la voluntat estatal.', true), ('C', 'Perquè només es pot reformar amb l’acord de totes les comunitats autònomes.', false), ('D', 'Perquè l’han de ratificar les institucions de la Unió Europea.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, quina majoria s’exigeix al Congrés dels Diputats per aprovar l’Estatut com a llei orgànica?', 'Com a llei orgànica, l’Estatut requereix la majoria absoluta del Congrés dels Diputats.', 'mossos_b1_estatut', (select id from public.topics where slug = 'mossos-b1-estatut'), 1, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf'), 'Guia p. 98, §1.2', 'Però l’Estatut és també una norma estatal, que revesteix la forma de llei orgànica aprovada per les Corts Generals (amb l’exigència d’una majoria absoluta de la cambra en el cas del Congrés dels Diputats).', null, 'e5144441c69b9524550430d56d0d845a487666143c315310e6e74b914144383c', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'e5144441c69b9524550430d56d0d845a487666143c315310e6e74b914144383c')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'La majoria simple.', false), ('B', 'La majoria de tres cinquenes parts.', false), ('C', 'La majoria absoluta.', true), ('D', 'La majoria de dues terceres parts.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, quina posició ocupa l’Estatut en l’ordenament jurídic?', 'L’EAC està per sota de la Constitució però per sobre de la resta de normes estatals i autonòmiques, per la funció constitucional que compleix (no per una simple relació de jerarquia).', 'mossos_b1_estatut', (select id from public.topics where slug = 'mossos-b1-estatut'), 2, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf'), 'Guia p. 98, §1.2', 'L’EAC ocupa una posició especial en l’ordenament jurídic, ja que està subordinat a la Constitució però està supraordenat a la resta de normes de l’ordenament, tant estatals com autonòmiques.', null, 'd6b4bac1f29f605f45e52d1a6554d1c06c0aec4eb96ef2d6713955b66bb4de67', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'd6b4bac1f29f605f45e52d1a6554d1c06c0aec4eb96ef2d6713955b66bb4de67')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Té el mateix rang que la Constitució.', false), ('B', 'Està subordinat a les lleis orgàniques estatals i supraordenat a les lleis del Parlament.', false), ('C', 'Està subordinat a la Constitució i supraordenat a la resta de normes, tant estatals com autonòmiques.', true), ('D', 'Està subordinat a qualsevol llei estatal posterior.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, quina conseqüència té la integració de l’Estatut en l’anomenat bloc de la constitucionalitat?', 'En formar part del bloc de la constitucionalitat, l’Estatut intervé en la delimitació de competències i serveix per comprovar si les lleis estatals i autonòmiques respecten el seu àmbit competencial.', 'mossos_b1_estatut', (select id from public.topics where slug = 'mossos-b1-estatut'), 3, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf'), 'Guia p. 98, §1.2', 'D’una banda, la integració en l’anomenat bloc de la constitucionalitat converteix l’Estatut en la principal norma que, a més de la mateixa Constitució, intervé en la delimitació de les competències entre l’Estat i la comunitat autònoma. D’aquesta manera, actua com a paràmetre de constitucionalitat de les lleis estatals i autonòmiques', null, '2605adfc1ed4f25028007aaacf8f0bc4f26c46b0ceae4bc2dce3f4d5e19c070a', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '2605adfc1ed4f25028007aaacf8f0bc4f26c46b0ceae4bc2dce3f4d5e19c070a')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Que actua com a paràmetre de constitucionalitat de les lleis estatals i autonòmiques.', true), ('B', 'Que es pot modificar per una llei ordinària de les Corts Generals.', false), ('C', 'Que substitueix la Constitució dins del territori de Catalunya.', false), ('D', 'Que queda exclòs del control del Tribunal Constitucional.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, quina conseqüència té la rigidesa de l’Estatut?', 'Com que només es pot reformar pels procediments que el mateix Estatut preveu, ni l’Estat ni la Generalitat el poden modificar pel seu compte.', 'mossos_b1_estatut', (select id from public.topics where slug = 'mossos-b1-estatut'), 2, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf'), 'Guia p. 98, §1.2', 'ja que només pot ser reformat pels procediments específics que s’hi preveuen (article 152.2 CE). Per tant, és indisponible unilateralment tant per al legislador estatal com per al legislador autonòmic.', null, '483bb1d9ec4d58682439a8cd761a1871fa78352cc57c20d9626f80cc54c939b4', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '483bb1d9ec4d58682439a8cd761a1871fa78352cc57c20d9626f80cc54c939b4')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Que només el pot modificar el Parlament de Catalunya per majoria de dos terços.', false), ('B', 'Que és indisponible unilateralment tant per al legislador estatal com per al legislador autonòmic.', true), ('C', 'Que no es pot reformar en cap cas.', false), ('D', 'Que el Govern de l’Estat el pot suspendre per decret llei.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, quin article de la Constitució estableix el contingut mínim o obligatori de tots els estatuts d’autonomia?', 'L’article 147.2 CE fixa la reserva estatutària: denominació, territori, institucions pròpies i competències assumides.', 'mossos_b1_estatut', (select id from public.topics where slug = 'mossos-b1-estatut'), 2, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf'), 'Guia p. 99, §2.1', 'L’article 147.2 CE estableix un contingut mínim o obligatori de tots els estatuts. Aquest precepte estableix una reserva estatutària, de manera que les matèries que esmenta han de ser necessàriament regulades pels estatuts', null, 'e0a97a95cef81504f27fad975e3a791409f619a197d9dc6baf6830b1dac69be0', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'e0a97a95cef81504f27fad975e3a791409f619a197d9dc6baf6830b1dac69be0')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'L’article 2 CE.', false), ('B', 'L’article 149.1 CE.', false), ('C', 'L’article 150 CE.', false), ('D', 'L’article 147.2 CE.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, quina de les matèries següents forma part del contingut que l’article 147.2 CE obliga a regular als estatuts?', 'El contingut obligatori és la denominació, la delimitació del territori, les institucions pròpies i les competències. La hisenda, els ens locals o el catàleg de drets són matèries que els estatuts han afegit, però no formen part de la reserva de l’article 147.2 CE.', 'mossos_b1_estatut', (select id from public.topics where slug = 'mossos-b1-estatut'), 2, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf'), 'Guia p. 99, §2.1', 'a) La denominació de la comunitat autònoma que s’ajusti millor a la seva identitat històrica (article 1 EAC). b) La delimitació del territori de la comunitat autònoma (article 9 EAC). c) La denominació, l’organització i la seu de les institucions autònomes pròpies (títol II EAC). d) Les competències assumides dins del marc establert per la Constitució i les bases per al traspàs dels serveis corresponents (títol IV EAC).', null, '06879197f686331c0ce21aebf8e1c70315e645ac52bdfcaef7e46d28ab7cab44', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '06879197f686331c0ce21aebf8e1c70315e645ac52bdfcaef7e46d28ab7cab44')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'La hisenda pròpia.', false), ('B', 'El catàleg de drets i deures dels ciutadans.', false), ('C', 'La delimitació del territori de la comunitat autònoma.', true), ('D', 'L’organització dels ens locals.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, a més de l’Estatut, per mitjà de quines lleis estatals pot rebre la comunitat autònoma noves competències?', 'La guia assenyala que la comunitat autònoma pot rebre noves competències a través de les lleis de l’article 150 CE: la llei marc i la llei orgànica de transferència o delegació.', 'mossos_b1_estatut', (select id from public.topics where slug = 'mossos-b1-estatut'), 2, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf'), 'Guia p. 99, §2.1', 'la comunitat autònoma pot rebre noves competències en virtut de les lleis estatals de l’article 150 CE (llei marc i llei orgànica de transferència o delegació).', null, 'a23e0f4866d946ff89c28ab2ed540e65e90289b63142bc4f21f8baa5caf6482e', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'a23e0f4866d946ff89c28ab2ed540e65e90289b63142bc4f21f8baa5caf6482e')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Per mitjà de les lleis de l’article 150 CE (llei marc i llei orgànica de transferència o delegació).', true), ('B', 'Per mitjà de les lleis de bases de l’article 149.1 CE.', false), ('C', 'Per mitjà dels decrets llei del Govern de l’Estat.', false), ('D', 'Per mitjà de les lleis d’harmonització aprovades només pel Senat.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, quina llei va desplegar en detall la regulació de les institucions d’autogovern de l’Estatut de 1979?', 'L’Estatut de 1979 deixava espai perquè la Llei 3/1982 regulés en detall el Parlament, el president i el Consell Executiu, enllaçant amb la tradició de l’Estatut interior de 1933.', 'mossos_b1_estatut', (select id from public.topics where slug = 'mossos-b1-estatut'), 3, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf'), 'Guia p. 99, §2.1', 'Així, pel que fa a les institucions d’autogovern, l’Estatut de 1979 deixava un espai per a una regulació de detall per la Llei 3/1982, de 23 de març, del Parlament, el president i el Consell Executiu (enllaçant amb la tradició de l’anomenat Estatut interior de 1933).', null, 'd58d47c8a6baf896dd9b6dd3d3cd8dc74dd5c2204580d3ff681be0c8781d590f', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'd58d47c8a6baf896dd9b6dd3d3cd8dc74dd5c2204580d3ff681be0c8781d590f')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'La Llei orgànica 4/1979, de 18 de desembre.', false), ('B', 'La Llei orgànica 6/2006, de 19 de juliol.', false), ('C', 'L’Estatut interior de 1933.', false), ('D', 'La Llei 3/1982, de 23 de març, del Parlament, el president i el Consell Executiu.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, quins elements formen la part orgànica de l’Estatut?', 'La guia distingeix una part dogmàtica (principis, drets i deures, principis rectors) i una part orgànica (institucions, competències, relacions institucionals, finançament i reforma).', 'mossos_b1_estatut', (select id from public.topics where slug = 'mossos-b1-estatut'), 2, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf'), 'Guia pp. 99-100, §2.2', 'dins del text estatutari es pot distingir una part dogmàtica (principis generals, drets i deures dels ciutadans i principis rectors) i una part orgànica (institucions, competències, relacions institucionals i finançament, a més del procediment de reforma).', null, 'ec1e7c610e68c74306af81995d76daa8269571064dc85b23ed94df017eb7815a', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'ec1e7c610e68c74306af81995d76daa8269571064dc85b23ed94df017eb7815a')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Els principis generals, els drets i deures dels ciutadans i els principis rectors.', false), ('B', 'El preàmbul i les disposicions addicionals.', false), ('C', 'Les institucions, les competències, les relacions institucionals i el finançament, a més del procediment de reforma.', true), ('D', 'Només el títol dedicat a les institucions.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, quin valor té el preàmbul de l’Estatut?', 'El preàmbul recull les motivacions de l’Estatut. No és normatiu, però serveix per interpretar-lo.', 'mossos_b1_estatut', (select id from public.topics where slug = 'mossos-b1-estatut'), 1, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf'), 'Guia p. 100, §2.2', 'Recull el conjunt de motivacions que fonamenten la regulació estatutària. No té valor normatiu, però és un element important per a la interpretació del text.', null, 'bebe4a2fbede3feec013d4dac29745a491a52b9171c3eba0eb9774735a0ae6f2', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'bebe4a2fbede3feec013d4dac29745a491a52b9171c3eba0eb9774735a0ae6f2')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'No té valor normatiu, però és un element important per interpretar el text.', true), ('B', 'Té el mateix valor normatiu que l’articulat.', false), ('C', 'Només té valor normatiu en matèria de drets històrics.', false), ('D', 'No té cap rellevància jurídica i no es pot invocar en cap cas.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, quins òrgans de rellevància estatutària integren el sistema institucional de la Generalitat, juntament amb les institucions polítiques bàsiques i els ens locals?', 'El sistema institucional de la Generalitat el formen el Parlament, la Presidència i el Govern; els òrgans de rellevància estatutària (Síndic de Greuges i Consell de Garanties Estatutàries), i els ens locals (municipis, vegueries i comarques).', 'mossos_b1_estatut', (select id from public.topics where slug = 'mossos-b1-estatut'), 2, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf'), 'Guia p. 100, §2.2', 'Integren aquest sistema, a més de les institucions polítiques bàsiques (Parlament, Presidència i Govern), els òrgans de rellevància estatutària (Síndic de Greuges, Consell de Garanties Estatutàries) i els ens locals (municipis, vegueries i comarques).', 'La guia només cita aquests dos òrgans en aquest paràgraf. He evitat posar com a distractor altres institucions del capítol V (Sindicatura de Comptes, CAC) perquè podrien semblar correctes.', 'd24f98938fe22cb1d019db6008b4b9c07e1f0fb70746ff89b03517d662b7a6fa', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'd24f98938fe22cb1d019db6008b4b9c07e1f0fb70746ff89b03517d662b7a6fa')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El Tribunal Superior de Justícia i el fiscal o la fiscal superior de Catalunya.', false), ('B', 'La Delegació del Govern de l’Estat i les subdelegacions.', false), ('C', 'Les Corts Generals i el Defensor del Poble.', false), ('D', 'El Síndic de Greuges i el Consell de Garanties Estatutàries.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, a qui reconeix l’Estatut la condició política de catalans o ciutadans de Catalunya?', 'La condició política de catalans depèn del veïnatge administratiu a Catalunya dels ciutadans espanyols, i s’estén als espanyols residents a l’estranger que l’han tingut darrerament i ho sol·liciten.', 'mossos_b1_estatut', (select id from public.topics where slug = 'mossos-b1-estatut'), 2, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf'), 'Guia p. 100, §2.2', 'Pel que fa a l’element personal, la condició política de catalans o ciutadans de Catalunya es reconeix als ciutadans espanyols que tenen veïnatge administratiu a Catalunya, així com als espanyols residents a l’estranger que han tingut darrerament aquest veïnatge i ho sol·licitin (articles 7, 9 i 14 EAC).', null, '58df12547d475ae353f767e617283e4f414e23e36af57190c6e7d601b7815d52', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '58df12547d475ae353f767e617283e4f414e23e36af57190c6e7d601b7815d52')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'A totes les persones nascudes a Catalunya, sigui quina sigui la seva nacionalitat.', false), ('B', 'Als ciutadans espanyols amb veïnatge administratiu a Catalunya i als espanyols residents a l’estranger que l’han tingut darrerament i ho sol·liciten.', true), ('C', 'A qualsevol persona que hagi residit a Catalunya durant més de deu anys.', false), ('D', 'Només als ciutadans espanyols que acreditin el coneixement del català.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, què permet l’establiment del deure de conèixer les dues llengües oficials?', 'L’article 3.1 CE estableix el deure de conèixer el castellà. En fixar també el deure de conèixer el català, l’Estatut equipara jurídicament les dues llengües oficials.', 'mossos_b1_estatut', (select id from public.topics where slug = 'mossos-b1-estatut'), 3, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf'), 'Guia p. 100, §2.2', 'De l’oficialitat deriven els drets d’utilitzar i conèixer i el deure de coneixement de les dues llengües oficials. L’establiment del darrer deure permet l’equiparació jurídica del català respecte del que estableix l’article 3.1 CE per al castellà (article 6 EAC).', null, '848b573f079e414c96eaa25393455ec581dae95bccd659f90fae0e34b9094682', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '848b573f079e414c96eaa25393455ec581dae95bccd659f90fae0e34b9094682')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'L’equiparació jurídica del català respecte del que l’article 3.1 CE estableix per al castellà.', true), ('B', 'L’exclusió del castellà de l’ensenyament.', false), ('C', 'L’oficialitat de l’aranès a tot l’Estat.', false), ('D', 'Que el català sigui l’única llengua oficial de Catalunya.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons les idees força de la Guia d’estudi, quina és la llengua d’ús normal i preferent de les administracions públiques a Catalunya?', 'La tercera idea força del tema diu que el català és la llengua d’ús normal i preferent de les administracions públiques.', 'mossos_b1_estatut', (select id from public.topics where slug = 'mossos-b1-estatut'), 1, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf'), 'Guia p. 106, idees força 3', '3. El català és la llengua d’ús normal i preferent de les administracions públiques.', null, '987bd235dccf78cbb17035c73c0ed3e1309c9aa3694bbc816928686b58d8effa', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '987bd235dccf78cbb17035c73c0ed3e1309c9aa3694bbc816928686b58d8effa')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El castellà.', false), ('B', 'La que triï cada administració.', false), ('C', 'El català.', true), ('D', 'El català i l’aranès, indistintament.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, quin estatus atribueix l’Estatut a l’aranès?', 'L’aranès, nom que rep la llengua occitana a l’Aran, és llengua pròpia d’aquest territori i oficial a tot Catalunya, d’acord amb l’Estatut i les lleis.', 'mossos_b1_estatut', (select id from public.topics where slug = 'mossos-b1-estatut'), 2, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf'), 'Guia pp. 100-101, §2.2', 'L’aranès, denominació que rep la llengua occitana a l’Aran, es declara llengua pròpia d’aquest territori i oficial a Catalunya, d’acord amb l’Estatut i les lleis (article 11 EAC).', null, 'dff97f4a3966382c14008e0d532e58b0b67e71fac851cb3ad6c92b3908f7ecce', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'dff97f4a3966382c14008e0d532e58b0b67e71fac851cb3ad6c92b3908f7ecce')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'És llengua oficial només dins de l’Aran.', false), ('B', 'És una varietat dialectal del català sense oficialitat.', false), ('C', 'És llengua cooficial a tot l’Estat.', false), ('D', 'És llengua pròpia de l’Aran i oficial a Catalunya.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, quin títol de l’Estatut regula les competències de la Generalitat?', 'El títol quart («De les competències») comprèn els articles 110 a 173. El primer tracta dels drets, el cinquè de les relacions institucionals i el sisè del finançament.', 'mossos_b1_estatut', (select id from public.topics where slug = 'mossos-b1-estatut'), 2, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf'), 'Guia p. 101, §2.2', 'Títol quart: «De les competències» (articles del 110 al 173) – Capítol I: «Tipologia de les competències» – Capítol II: «Les matèries de les competències»', null, '1ee6f802fcd3b6262c312a1bdd79163d5e925e40f03f9efa198d1898a26291c1', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '1ee6f802fcd3b6262c312a1bdd79163d5e925e40f03f9efa198d1898a26291c1')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El títol primer.', false), ('B', 'El títol quart.', true), ('C', 'El títol cinquè.', false), ('D', 'El títol sisè.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, davant de quin òrgan es preveu la garantia jurisdiccional específica dels drets estatutaris?', 'El capítol IV del títol primer preveu un recurs davant el Tribunal Superior de Justícia de Catalunya com a garantia jurisdiccional específica dels drets.', 'mossos_b1_estatut', (select id from public.topics where slug = 'mossos-b1-estatut'), 2, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf'), 'Guia p. 102, §3', 'Finalment, es preveu una garantia jurisdiccional específica, per mitjà d’un recurs davant el Tribunal Superior de Justícia de Catalunya (capítol IV).', null, '65cad11a0ce4515d62de4ef4e2b875f35c2e81032f71383602e232b33506daaf', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '65cad11a0ce4515d62de4ef4e2b875f35c2e81032f71383602e232b33506daaf')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Davant del Tribunal Constitucional.', false), ('B', 'Davant del Consell de Garanties Estatutàries.', false), ('C', 'Davant del Síndic de Greuges.', false), ('D', 'Davant del Tribunal Superior de Justícia de Catalunya.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, què atribueixen a la Generalitat les competències exclusives?', 'Les exclusives donen a la Generalitat totes les potestats (legislativa, reglamentària i executiva). Les compartides actuen dins de les bases estatals i les executives no inclouen la potestat legislativa.', 'mossos_b1_estatut', (select id from public.topics where slug = 'mossos-b1-estatut'), 1, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf'), 'Guia p. 102, §4.1', 'a) Les competències exclusives atribueixen de manera íntegra la potestat legislativa, la potestat reglamentària i la funció executiva, de manera que correspon únicament a la Generalitat l’exercici d’aquestes potestats en els àmbits de competència exclusiva.', null, 'abb21b127d26ce84e6b296aebfc289becca74b1f69536145b8327530b2b7c1d2', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'abb21b127d26ce84e6b296aebfc289becca74b1f69536145b8327530b2b7c1d2')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'De manera íntegra, la potestat legislativa, la potestat reglamentària i la funció executiva.', true), ('B', 'Només la potestat reglamentària i la funció executiva.', false), ('C', 'La potestat legislativa en el marc de les bases que fixi l’Estat.', false), ('D', 'Només l’execució de la normativa estatal.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, en les competències compartides la Generalitat exerceix la potestat legislativa, la reglamentària i la funció executiva:', 'En les compartides, la Generalitat legisla, reglamenta i executa dins de les bases estatals, que no han de ser regles detallades ni fixar-se per reglament.', 'mossos_b1_estatut', (select id from public.topics where slug = 'mossos-b1-estatut'), 1, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf'), 'Guia p. 103, §4.1', 'b) Les competències compartides atribueixen a la Generalitat la potestat legislativa, la potestat reglamentària i la funció executiva, en el marc de les bases que fixi l’Estat.', null, 'f8679bc83035a691620da2a0108aefd6f60319548bf1c33b9687a72e1a5feebd', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'f8679bc83035a691620da2a0108aefd6f60319548bf1c33b9687a72e1a5feebd')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Sense cap límit per part de l’Estat.', false), ('B', 'Només per delegació expressa del Govern de l’Estat.', false), ('C', 'En el marc de les bases que fixi l’Estat.', true), ('D', 'Únicament per executar els reglaments estatals.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, quina de les funcions següents correspon a la Generalitat, d’acord amb la legislació estatal, en virtut de l’article 164 de l’Estatut?', 'L’article 164 EAC atribueix a la Generalitat, d’acord amb la legislació estatal, la planificació del sistema de seguretat pública i l’ordenació de les policies locals, la creació i organització de la PG-ME i el control i la vigilància del trànsit.', 'mossos_b1_estatut', (select id from public.topics where slug = 'mossos-b1-estatut'), 2, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf'), 'Guia p. 104, §5', 'Segons aquest precepte, correspon a la Generalitat, d’acord amb la legislació estatal: a) La planificació i la regulació del sistema de seguretat pública de Catalunya i l’ordenació de les policies locals. b) La creació i l’organització de la Policia de la Generalitat - Mossos d’Esquadra. c) El control i la vigilància del trànsit.', null, 'c239c5d46cba686f0453077b18e88f2a7ca1b476e3702e7a6f01f98af722dc56', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = 'c239c5d46cba686f0453077b18e88f2a7ca1b476e3702e7a6f01f98af722dc56')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El control de fronteres, ports i aeroports.', false), ('B', 'El control i la vigilància del trànsit.', true), ('C', 'L’expedició del document nacional d’identitat.', false), ('D', 'La regulació del règim general d’estrangeria.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Segons la Guia d’estudi, com està composta i qui presideix la Junta de Seguretat?', 'La Junta de Seguretat té composició paritària entre la Generalitat i l’Estat i la presideix el president o presidenta de la Generalitat. Per mitjà d’ella, la Generalitat participa en la coordinació de les polítiques de seguretat.', 'mossos_b1_estatut', (select id from public.topics where slug = 'mossos-b1-estatut'), 2, 'ca', true, (select id from public.sources where url = 'https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf'), 'Guia p. 105, §5', 'La Junta de Seguretat és un òrgan de composició paritària entre la Generalitat i l’Estat i és presidida pel/per la president/a de la Generalitat.', null, '4ce431bd0f233c175f00e09d5b441681b7a58dcfc1823f728322d9a71af1c069', false
  where not exists (select 1 from public.questions where locale = 'ca' and content_hash = '4ce431bd0f233c175f00e09d5b441681b7a58dcfc1823f728322d9a71af1c069')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'És un òrgan del Ministeri de l’Interior presidit pel delegat del Govern a Catalunya.', false), ('B', 'És un òrgan municipal presidit per l’alcalde de Barcelona.', false), ('C', 'És un òrgan consultiu del Parlament format per experts independents.', false), ('D', 'És un òrgan paritari entre la Generalitat i l’Estat, presidit pel president o presidenta de la Generalitat.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'mossos-esquadra';
