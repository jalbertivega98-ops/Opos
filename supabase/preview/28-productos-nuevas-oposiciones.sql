-- Administrativo del Estado, Auxilio Judicial, Tramitación Procesal y Policía Nacional (Escala Básica):
-- reutilización del temario común, packs de test, simulacros con el formato oficial y packs completos.
-- Todo en BORRADOR: se publica con 29-. Idempotente. Requiere 25- a 27- (temarios) y 12-/13- (Auxiliar).
--
-- Formatos oficiales (leídos en el BOE):
-- * Administrativo (BOE-A-2025-26262, Anexo III): ejercicio único de 100 min; parte 1 = 70 preguntas
--   (40 de los bloques I-V y 30 del bloque VI); parte 2 = supuesto práctico de 20 preguntas. Error −1/3.
-- * Auxilio Judicial (Orden PJC/1549/2025, BOE-A-2025-27053, Anexo V.a): primer ejercicio de 100 preguntas
--   en 100 min, acierto 0,60 y error −0,15 (= −1/4 de acierto), de 0 a 60, mínimo 30.
-- * Tramitación Procesal (Anexo IV.a): primer ejercicio igual sobre los temas 1-31.
-- * Policía Nacional (BOE-A-2026-15055, base 6.1.1): 100 preguntas de 3 alternativas en 50 min,
--   fórmula [A–E/(n–1)]*10/P (error −1/2), de 0 a 10, mínimo 3.
-- Nota: un simulacro por partes admite como máximo 9 bloques de temas; en el de Administrativo los
-- bloques I-V salen de age-aux-b1- (bloque I, III.3, III.7, IV y V comunes), age-adm- (temas propios)
-- y age-aux-b2-04- (administración electrónica), y el bloque VI de los temas de ofimática.
begin;

-- 1. Temario común: los temas de Auxiliar están en el programa de Administrativo (bloques I, II, III.3,
--    III.7, IV, V y VI) y la ofimática de Auxiliar es la de Tramitación (temas 32-37).
insert into public.exam_body_topics (exam_body_id, topic_id)
select b.id, t.id from public.exam_bodies b, public.topics t
 where b.slug = 'administrativo-estado' and t.slug like 'age-aux-b_-%'
on conflict do nothing;

insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from public.questions q
  join public.topics t on t.id = q.topic_id and t.slug like 'age-aux-b_-%'
  cross join public.exam_bodies b
 where b.slug = 'administrativo-estado' and q.is_test = false
on conflict do nothing;

insert into public.exam_body_topics (exam_body_id, topic_id)
select b.id, t.id from public.exam_bodies b, public.topics t
 where b.slug = 'tramitacion-procesal'
   and t.slug in ('age-aux-b2-05-informatica-basica', 'age-aux-b2-06-windows', 'age-aux-b2-07-explorador',
                  'age-aux-b2-08-word', 'age-aux-b2-11-outlook', 'age-aux-b2-12-internet')
on conflict do nothing;

insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from public.questions q
  join public.topics t on t.id = q.topic_id
  cross join public.exam_bodies b
 where b.slug = 'tramitacion-procesal' and q.is_test = false
   and t.slug in ('age-aux-b2-05-informatica-basica', 'age-aux-b2-06-windows', 'age-aux-b2-07-explorador',
                  'age-aux-b2-08-word', 'age-aux-b2-11-outlook', 'age-aux-b2-12-internet')
on conflict do nothing;

-- 2. Productos
insert into public.products (slug, type, status, title, title_ca, description, description_ca,
                             exam_body_id, is_free, included_in_premium, config)
select v.slug, v.type::public.product_type, 'draft', v.title, v.title_ca, v.descr, v.descr_ca,
       b.id, false, true, v.config::jsonb
  from (values
    -- Administrativo del Estado
    ('administrativo-estado', 'age-adm-temas-propios-2026', 'question_pack',
     'Administrativo del Estado · Derecho administrativo, personal y gestión financiera (test)',
     'Administratiu de l''Estat · Dret administratiu, personal i gestió financera (test)',
     'Preguntas tipo test de los temas propios del Administrativo (bloques III, IV y V: fuentes, acto administrativo, contratos, responsabilidad patrimonial, selección y provisión, incompatibilidades, MUFACE, Seguridad Social, presupuesto, gasto y pagos), con la cita literal del BOE en cada corrección.',
     'Preguntes tipus test dels temes propis de l''Administratiu (blocs III, IV i V), amb la cita literal del BOE a cada correcció.',
     '{"topic_prefix":"age-adm-","locale":"es"}'),
    ('administrativo-estado', 'age-adm-temario-comun-2026', 'question_pack',
     'Administrativo del Estado · Organización del Estado, oficinas públicas y ofimática (test)',
     'Administratiu de l''Estat · Organització de l''Estat, oficines públiques i ofimàtica (test)',
     'Bloques I, II y VI del programa del Administrativo, que coinciden con el temario de Auxiliar: Constitución, Gobierno, AGE, UE, procedimiento, protección de datos, atención al público, registro y archivo, administración electrónica, Windows 11 y Microsoft 365.',
     'Blocs I, II i VI del programa de l''Administratiu, que coincideixen amb el temari d''Auxiliar.',
     '{"topic_prefix":"age-aux-","locale":"es"}'),
    ('administrativo-estado', 'age-adm-simulacro-parte-1-2026', 'mock_exam',
     'Administrativo del Estado · Simulacro de la primera parte (70 preguntas)',
     'Administratiu de l''Estat · Simulacre de la primera part (70 preguntes)',
     'Como la primera parte del ejercicio único: 40 preguntas de los bloques I a V y 30 de informática y ofimática (bloque VI). Cada error resta 1/3 y en blanco no resta. 78 minutos (la parte proporcional de los 100 del examen, que incluye además el supuesto práctico). Cada simulacro es distinto.',
     'Com la primera part de l''exercici únic: 40 preguntes dels blocs I a V i 30 d''informàtica i ofimàtica (bloc VI). Cada error resta 1/3. 78 minuts.',
     '{"kind":"sections","questions":70,"minutes":78,"penalty":0.3333,"pass_mark":25,"max_mark":50,"locale":"es",
       "parts":[{"part":1,"questions":16,"topic_prefix":"age-aux-b1-"},
                {"part":1,"questions":20,"topic_prefix":"age-adm-"},
                {"part":1,"questions":4,"topic_prefix":"age-aux-b2-04-"},
                {"part":1,"questions":5,"topic_prefix":"age-aux-b2-05-"},
                {"part":1,"questions":3,"topic_prefix":"age-aux-b2-06-"},
                {"part":1,"questions":3,"topic_prefix":"age-aux-b2-07-"},
                {"part":1,"questions":6,"topic_prefix":"age-aux-b2-08-"},
                {"part":1,"questions":6,"topic_prefix":"age-aux-b2-09-"},
                {"part":1,"questions":7,"topic_prefix":"age-aux-b2-1"}]}'),
    ('administrativo-estado', 'age-adm-pack-completo-2026', 'bundle',
     'Administrativo del Estado 2026 · Pack completo',
     'Administratiu de l''Estat 2026 · Paquet complet',
     'Todo el programa del Cuerpo General Administrativo (BOE 22/12/2025) en preguntas con su artículo, simulacros ilimitados de la primera parte con el formato oficial, repaso de errores y plan de estudio semanal.',
     'Tot el programa del Cos General Administratiu en preguntes amb el seu article, simulacres il·limitats de la primera part, repàs d''errors i pla d''estudi setmanal.',
     '{"publish_with_content":"true"}'),
    -- Auxilio Judicial
    ('auxilio-judicial', 'jus-auxilio-temario-2026', 'question_pack',
     'Auxilio Judicial · Temario completo (test)',
     'Auxili Judicial · Temari complet (test)',
     'Preguntas tipo test de los 26 temas del programa oficial (Orden PJC/1549/2025): Constitución, igualdad, organización judicial tras la LO 1/2025, Letrados, cuerpos generales, LEC, LECrim, contencioso, laboral, actos de comunicación, Registro Civil y archivo, con la cita literal del BOE.',
     'Preguntes tipus test dels 26 temes del programa oficial, amb la cita literal del BOE.',
     '{"topic_prefix":"jus-","locale":"es"}'),
    ('auxilio-judicial', 'jus-auxilio-simulacro-2026', 'mock_exam',
     'Auxilio Judicial · Simulacro del primer ejercicio (formato oficial)',
     'Auxili Judicial · Simulacre del primer exercici (format oficial)',
     '100 preguntas de todo el temario, 4 respuestas, 100 minutos. Cada acierto vale 0,60 y cada error resta 0,15; en blanco no puntúa. Nota de 0 a 60; se supera con 30. Cada simulacro es distinto.',
     '100 preguntes de tot el temari, 4 respostes, 100 minuts. Cada encert val 0,60 i cada error resta 0,15. Nota de 0 a 60; s''aprova amb 30.',
     '{"questions":100,"minutes":100,"penalty":0.25,"pass_mark":30,"max_mark":60,"topic_prefix":"jus-","locale":"es"}'),
    ('auxilio-judicial', 'jus-auxilio-pack-completo-2026', 'bundle',
     'Auxilio Judicial 2026 · Pack completo',
     'Auxili Judicial 2026 · Paquet complet',
     'Todo el temario oficial en preguntas con su artículo, simulacros ilimitados del primer ejercicio con el formato oficial, repaso de errores y plan de estudio semanal.',
     'Tot el temari oficial en preguntes amb el seu article, simulacres il·limitats del primer exercici, repàs d''errors i pla d''estudi setmanal.',
     '{"publish_with_content":"true"}'),
    -- Tramitación Procesal
    ('tramitacion-procesal', 'jus-tramitacion-temario-2026', 'question_pack',
     'Tramitación Procesal · Temario jurídico y procesal (test)',
     'Tramitació Processal · Temari jurídic i processal (test)',
     'Preguntas tipo test de los temas 1 a 31 del programa oficial (Orden PJC/1549/2025), incluidos los recursos civiles y penales, con la cita literal del BOE.',
     'Preguntes tipus test dels temes 1 a 31 del programa oficial, amb la cita literal del BOE.',
     '{"topic_prefix":"jus","locale":"es"}'),
    ('tramitacion-procesal', 'jus-tramitacion-simulacro-2026', 'mock_exam',
     'Tramitación Procesal · Simulacro del primer ejercicio (formato oficial)',
     'Tramitació Processal · Simulacre del primer exercici (format oficial)',
     '100 preguntas de los temas 1 a 31, 4 respuestas, 100 minutos. Cada acierto vale 0,60 y cada error resta 0,15. Nota de 0 a 60; se supera con 30.',
     '100 preguntes dels temes 1 a 31, 4 respostes, 100 minuts. Cada encert val 0,60 i cada error resta 0,15.',
     '{"questions":100,"minutes":100,"penalty":0.25,"pass_mark":30,"max_mark":60,"topic_prefix":"jus","locale":"es"}'),
    ('tramitacion-procesal', 'jus-tramitacion-ofimatica-2026', 'question_pack',
     'Tramitación Procesal · Informática y ofimática (test)',
     'Tramitació Processal · Informàtica i ofimàtica (test)',
     'Temas 32 a 37 del programa (informática básica, Windows, Explorador, Word 365, Outlook 365 e Internet) con la documentación oficial de Microsoft.',
     'Temes 32 a 37 del programa amb la documentació oficial de Microsoft.',
     '{"locale":"es"}'),
    ('tramitacion-procesal', 'jus-tramitacion-pack-completo-2026', 'bundle',
     'Tramitación Procesal 2026 · Pack completo',
     'Tramitació Processal 2026 · Paquet complet',
     'Temario jurídico y procesal y ofimática en preguntas con su fuente oficial, simulacros ilimitados del primer ejercicio, repaso de errores y plan de estudio semanal.',
     'Temari jurídic i processal i ofimàtica en preguntes amb la seva font oficial, simulacres il·limitats, repàs d''errors i pla d''estudi setmanal.',
     '{"publish_with_content":"true"}'),
    -- Policía Nacional
    ('policia-nacional-basica', 'pn-ciencias-juridicas-2026', 'question_pack',
     'Policía Nacional · Ciencias Jurídicas (test de 3 opciones)',
     'Policia Nacional · Ciències Jurídiques (test de 3 opcions)',
     'Preguntas tipo test de 3 alternativas de los temas 1 a 26 del programa oficial (BOE 10/07/2026): Constitución, Interior y Policía Nacional, LO 2/1986, extranjería, seguridad ciudadana, Código Penal, LECrim, víctima, igualdad, prevención de riesgos y protección de datos, con la cita literal del BOE.',
     'Preguntes tipus test de 3 alternatives dels temes 1 a 26 del programa oficial, amb la cita literal del BOE.',
     '{"topic_prefix":"pn-","locale":"es"}'),
    ('policia-nacional-basica', 'pn-simulacro-ciencias-juridicas-2026', 'mock_exam',
     'Policía Nacional · Simulacro de Ciencias Jurídicas (formato oficial)',
     'Policia Nacional · Simulacre de Ciències Jurídiques (format oficial)',
     '60 preguntas de Ciencias Jurídicas con 3 alternativas en 30 minutos, el mismo ritmo que el examen real (100 preguntas en 50 minutos). Cada error resta medio acierto, como en la fórmula oficial. Nota de 0 a 10.',
     '60 preguntes de Ciències Jurídiques amb 3 alternatives en 30 minuts, el mateix ritme que l''examen real. Cada error resta mig encert. Nota de 0 a 10.',
     '{"questions":60,"minutes":30,"penalty":0.5,"pass_mark":5,"max_mark":10,"topic_prefix":"pn-","locale":"es"}'),
    ('policia-nacional-basica', 'pn-pack-completo-2026', 'bundle',
     'Policía Nacional 2026 · Pack de conocimientos',
     'Policia Nacional 2026 · Paquet de coneixements',
     'Ciencias Jurídicas (temas 1 a 26) en preguntas de 3 opciones con su artículo, simulacros ilimitados con el ritmo del examen real, repaso de errores y plan de estudio semanal. Ciencias Sociales y Técnico-Científicas se añadirán cuando estén revisadas con fuente oficial.',
     'Ciències Jurídiques (temes 1 a 26) en preguntes de 3 opcions, simulacres il·limitats, repàs d''errors i pla d''estudi setmanal.',
     '{"publish_with_content":"true"}')
  ) as v(exam, slug, type, title, title_ca, descr, descr_ca, config)
  join public.exam_bodies b on b.slug = v.exam
on conflict (slug) do nothing;

-- 3. Preguntas que ya estén aprobadas o publicadas entran en sus packs
--    (las que se publiquen después entran solas: trigger questions_autopack)
insert into public.product_items (product_id, position, question_id)
select p.id, row_number() over (partition by p.id order by t.slug, q.created_at), q.id
  from public.products p
  join public.topics t on t.slug like (p.config->>'topic_prefix') || '%'
  join public.questions q on q.topic_id = t.id and q.locale = 'es' and q.is_test = false
                         and q.status in ('approved', 'published')
 where p.slug in ('age-adm-temas-propios-2026', 'age-adm-temario-comun-2026', 'jus-auxilio-temario-2026',
                  'jus-tramitacion-temario-2026', 'pn-ciencias-juridicas-2026')
on conflict do nothing;

insert into public.product_items (product_id, position, question_id)
select p.id, row_number() over (partition by p.id order by t.slug, q.created_at), q.id
  from public.products p
  join public.topics t on t.slug in ('age-aux-b2-05-informatica-basica', 'age-aux-b2-06-windows',
                                     'age-aux-b2-07-explorador', 'age-aux-b2-08-word',
                                     'age-aux-b2-11-outlook', 'age-aux-b2-12-internet')
  join public.questions q on q.topic_id = t.id and q.locale = 'es' and q.is_test = false
                         and q.status in ('approved', 'published')
 where p.slug = 'jus-tramitacion-ofimatica-2026'
on conflict do nothing;

-- 4. Packs completos
insert into public.product_items (product_id, position, child_product_id)
select pk.id, row_number() over (partition by pk.id order by c.type, c.slug), c.id
  from (values
    ('age-adm-pack-completo-2026', array['age-adm-temas-propios-2026', 'age-adm-temario-comun-2026', 'age-adm-simulacro-parte-1-2026']),
    ('jus-auxilio-pack-completo-2026', array['jus-auxilio-temario-2026', 'jus-auxilio-simulacro-2026']),
    ('jus-tramitacion-pack-completo-2026', array['jus-tramitacion-temario-2026', 'jus-tramitacion-ofimatica-2026', 'jus-tramitacion-simulacro-2026']),
    ('pn-pack-completo-2026', array['pn-ciencias-juridicas-2026', 'pn-simulacro-ciencias-juridicas-2026'])
  ) as v(pack, children)
  join public.products pk on pk.slug = v.pack
  join public.products c on c.slug = any (v.children)
on conflict do nothing;

commit;
