-- Prisiones de Cataluña (cos tècnic d'especialistes, escala de serveis penitenciaris): packs de test, simulacro
-- del 1.r ejercicio, simulacro del supuesto práctico y pack completo. Todo en BORRADOR: se publica con 40-.
-- Idempotente. Requiere 37- (oposición) y 38- (temas pcat-* y pcatsup-*).
--
-- Formato oficial (JU033, Resolució JUS/2335/2025, base 7.1). Las pruebas se plantean en catalán:
-- * 1.r ejercicio, test de coneixements: 60 preguntas (15 de la parte general y 45 de la específica), 4 opciones,
--   1 h 30 min, nota de 0 a 15 y mínimo 7,5. Cada error resta 1/4 del valor de un acierto.
-- * 2.º ejercicio, supòsit pràctic tipus test: 25 preguntas sobre los temas 5, 6 y 8-18, 1 h 30 min, nota de 0 a
--   20 y mínimo 10, misma penalización.
-- Sin psicotécnico puntuable (base 4.7): la oposición no está en examHasPsycho (ADR-031).
begin;

insert into public.products (slug, type, status, title, title_ca, description, description_ca,
                             exam_body_id, is_free, included_in_premium, config)
select v.slug, v.type::public.product_type, 'draft', v.title, v.title_ca, v.descr, v.descr_ca,
       b.id, false, true, v.config::jsonb
  from (values
    ('serveis-penitenciaris-catalunya', 'pcat-coneixements-2026', 'question_pack',
     'Prisiones de Cataluña · Test de conocimientos (en catalán)',
     'Presons de Catalunya · Test de coneixements',
     'Preguntas tipo test de 4 opciones, en catalán como el examen, de los 25 temas oficiales: parte general (Constitución, Estatut, Generalitat, procedimiento y función pública) y parte específica (derecho penal y procesal, derecho penitenciario, criminología y RisCanvi), con la cita literal de la norma.',
     'Preguntes tipus test de 4 opcions dels 25 temes oficials: part general i part específica (dret penal i processal, dret penitenciari, criminologia i RisCanvi), amb la cita literal de la norma.',
     '{"topic_prefix":"pcat-","locale":"ca"}'),
    ('serveis-penitenciaris-catalunya', 'pcatsup-suposits-2026', 'question_pack',
     'Prisiones de Cataluña · Supuestos prácticos (en catalán)',
     'Presons de Catalunya · Supòsits pràctics',
     'Casos breves de un centro penitenciario catalán con preguntas de 4 opciones sobre ingresos, seguridad, medios coercitivos, clasificación, comunicaciones y procedimiento disciplinario, como el segundo ejercicio.',
     'Casos breus d''un centre penitenciari català amb preguntes de 4 opcions sobre ingressos, seguretat, mitjans coercitius, classificació, comunicacions i procediment disciplinari, com el segon exercici.',
     '{"topic_prefix":"pcatsup-","locale":"ca"}'),
    ('serveis-penitenciaris-catalunya', 'pcat-simulacre-test-2026', 'mock_exam',
     'Prisiones de Cataluña · Simulacro del test de conocimientos (60 preguntas)',
     'Presons de Catalunya · Simulacre del test de coneixements (60 preguntes)',
     '60 preguntas de 4 opciones de todo el temario, como el primer ejercicio. Cada error resta 1/4 de acierto y en blanco no resta. Nota de 0 a 15; el mínimo oficial es 7,5. 90 minutos.',
     '60 preguntes de 4 opcions de tot el temari, com el primer exercici. Cada error resta 1/4 d''encert i en blanc no resta. Nota de 0 a 15; el mínim oficial és 7,5. 90 minuts.',
     '{"questions":60,"minutes":90,"penalty":0.25,"pass_mark":7.5,"max_mark":15,"topic_prefix":"pcat-","locale":"ca"}'),
    ('serveis-penitenciaris-catalunya', 'pcatsup-simulacre-suposit-2026', 'mock_exam',
     'Prisiones de Cataluña · Simulacro del supuesto práctico (25 preguntas)',
     'Presons de Catalunya · Simulacre del supòsit pràctic (25 preguntes)',
     '25 preguntas de casos prácticos sobre régimen, seguridad y disciplina, como el segundo ejercicio. Cada error resta 1/4 de acierto. Nota de 0 a 20; el mínimo oficial es 10. 90 minutos.',
     '25 preguntes de casos pràctics sobre règim, seguretat i disciplina, com el segon exercici. Cada error resta 1/4 d''encert. Nota de 0 a 20; el mínim oficial és 10. 90 minuts.',
     '{"questions":25,"minutes":90,"penalty":0.25,"pass_mark":10,"max_mark":20,"topic_prefix":"pcatsup-","locale":"ca"}'),
    ('serveis-penitenciaris-catalunya', 'pcat-pack-complet-2026', 'bundle',
     'Prisiones de Cataluña 2026 · Pack de la primera prueba',
     'Presons de Catalunya 2026 · Paquet de la primera prova',
     'Los dos ejercicios de la primera prueba: test de conocimientos de los 25 temas y supuestos prácticos, en catalán y con su artículo, simulacros ilimitados con el formato oficial (60 + 25 preguntas, −1/4), repaso de errores y plan de estudio. La prueba física, el catalán y la prueba médica no se preparan aquí.',
     'Els dos exercicis de la primera prova: test de coneixements dels 25 temes i supòsits pràctics, amb el seu article, simulacres il·limitats amb el format oficial (60 + 25 preguntes, −1/4), repàs d''errors i pla d''estudi.',
     '{"publish_with_content":"true"}')
  ) as v(exam, slug, type, title, title_ca, descr, descr_ca, config)
  join public.exam_bodies b on b.slug = v.exam
on conflict (slug) do nothing;

insert into public.product_items (product_id, position, question_id)
select p.id, row_number() over (partition by p.id order by t.slug, q.created_at), q.id
  from public.products p
  join public.topics t on t.slug like (p.config->>'topic_prefix') || '%'
  join public.questions q on q.topic_id = t.id and q.locale = 'ca' and q.is_test = false
                         and q.status in ('approved', 'published')
 where p.slug in ('pcat-coneixements-2026', 'pcatsup-suposits-2026')
on conflict do nothing;

insert into public.product_items (product_id, position, child_product_id)
select pk.id, row_number() over (partition by pk.id order by c.type, c.slug), c.id
  from public.products pk
  join public.products c on c.slug in ('pcat-coneixements-2026', 'pcatsup-suposits-2026',
                                       'pcat-simulacre-test-2026', 'pcatsup-simulacre-suposit-2026')
 where pk.slug = 'pcat-pack-complet-2026'
on conflict do nothing;

commit;
