-- Auxiliar Administrativo del Estado: pack de test del Bloque I, simulacros con el formato
-- oficial (Resolución de 18/12/2025, BOE 22/12/2025, Anexo I) y pack completo.
-- Todo en BORRADOR: se publica con el contenido («Aprobar y publicar todo» o 15-).
-- Idempotente. Requiere 12- (temario) y las migraciones de simulacros (7- y 9-).
--
-- Formato oficial del ejercicio único: parte 1 = 30 preguntas del Bloque I + 30
-- psicotécnicas; parte 2 = 50 del Bloque II. 4 respuestas, error −1/3, 90 minutos.
-- Aquí se entrena la parte 1 por separado, con el tiempo proporcional (unos 25 min
-- por cada 30 preguntas). Nota sobre 10; aprobado orientativo 5 (la parte se supera
-- con 25 sobre 50).
begin;

insert into public.products (slug, type, status, title, title_ca, description, description_ca,
                             exam_body_id, is_free, included_in_premium, config)
select v.slug, v.type::public.product_type, 'draft', v.title, v.title_ca, v.descr, v.descr_ca,
       b.id, false, true, v.config::jsonb
  from public.exam_bodies b,
  (values
    ('age-aux-bloque-1-boe-2026', 'question_pack',
     'Auxiliar del Estado · Bloque I: organización pública (test)',
     'Auxiliar de l''Estat · Bloc I: organització pública (test)',
     'Preguntas tipo test de los temas del Bloque I del programa oficial, redactadas a partir de la Constitución y las leyes del BOE, con la cita literal del artículo en cada corrección.',
     'Preguntes tipus test dels temes del Bloc I del programa oficial, redactades a partir de la Constitució i les lleis del BOE, amb la cita literal de l''article a cada correcció.',
     '{"topic_prefix":"age-aux-b1-","locale":"es"}'),
    ('age-aux-simulacro-bloque-1-2026', 'mock_exam',
     'Auxiliar del Estado · Simulacro Bloque I (formato oficial)',
     'Auxiliar de l''Estat · Simulacre Bloc I (format oficial)',
     '30 preguntas del Bloque I, 4 respuestas, cada error resta 1/3 y en blanco no resta, 25 minutos. Nota sobre 10. Cada simulacro es distinto.',
     '30 preguntes del Bloc I, 4 respostes, cada error resta 1/3 i en blanc no resta, 25 minuts. Nota sobre 10. Cada simulacre és diferent.',
     '{"questions":30,"minutes":25,"penalty":0.3333,"pass_mark":5,"max_mark":10,"topic_prefix":"age-aux-b1-","locale":"es"}'),
    ('age-aux-simulacro-psicotecnicos-2026', 'mock_exam',
     'Auxiliar del Estado · Simulacro de psicotécnicos (formato oficial)',
     'Auxiliar de l''Estat · Simulacre de psicotècnics (format oficial)',
     '30 ejercicios de aptitudes administrativas, numéricas y verbales (series, cálculo, analogías y atención), cada error resta 1/3, 25 minutos. Nota sobre 10.',
     '30 exercicis d''aptituds administratives, numèriques i verbals (sèries, càlcul, analogies i atenció), cada error resta 1/3, 25 minuts. Nota sobre 10.',
     '{"kind":"psycho","questions":30,"minutes":25,"penalty":0.3333,"pass_mark":5,"max_mark":10,"item_types":["series","letters","numeric","analogies","attention"],"publish_with_content":"true"}'),
    ('age-aux-pack-completo-2026', 'bundle',
     'Auxiliar del Estado 2026 · Pack completo',
     'Auxiliar de l''Estat 2026 · Paquet complet',
     'Primera parte del ejercicio único: todo el Bloque I en preguntas con su artículo, simulacros ilimitados del Bloque I y de psicotécnicos con el formato oficial, repaso de errores y plan de estudio semanal. El Bloque II (ofimática) se añadirá al pack cuando esté revisado.',
     'Primera part de l''exercici únic: tot el Bloc I en preguntes amb el seu article, simulacres il·limitats del Bloc I i de psicotècnics amb el format oficial, repàs d''errors i pla d''estudi setmanal. El Bloc II (ofimàtica) s''afegirà al paquet quan estigui revisat.',
     '{"publish_with_content":"true"}')
  ) as v(slug, type, title, title_ca, descr, descr_ca, config)
 where b.slug = 'auxiliar-administrativo-estado'
on conflict (slug) do nothing;

-- Preguntas ya aprobadas o publicadas del Bloque I entran en el pack
-- (las que se publiquen después entran solas: trigger questions_autopack)
insert into public.product_items (product_id, position, question_id)
select p.id, row_number() over (partition by p.id order by t.slug, q.created_at), q.id
  from public.products p
  join public.topics t on t.slug like 'age-aux-b1-%'
  join public.questions q on q.topic_id = t.id and q.locale = 'es' and q.is_test = false
                         and q.status in ('approved', 'published')
 where p.slug = 'age-aux-bloque-1-boe-2026'
on conflict do nothing;

insert into public.product_items (product_id, position, child_product_id)
select pk.id, row_number() over (order by c.type, c.slug), c.id
  from public.products pk
  join public.products c on c.slug in ('age-aux-bloque-1-boe-2026', 'age-aux-simulacro-bloque-1-2026',
                                       'age-aux-simulacro-psicotecnicos-2026')
 where pk.slug = 'age-aux-pack-completo-2026'
on conflict do nothing;

commit;
