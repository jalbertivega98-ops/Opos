-- Guardia Civil, Escala de Cabos y Guardias: pack de test, simulacro de conocimientos y pack completo.
-- Todo en BORRADOR: se publica con 33-. Idempotente. Requiere 31- (temario gc-*).
--
-- Formato oficial (Resolución 160/38243/2026, BOE-A-2026-9982, bases 6.1.1 y 7.3-7.6): prueba de
-- conocimientos generales de 100 preguntas tipo test con 4 alternativas (N=4), los errores penalizan y la
-- nota va de 0 a 100 con un mínimo de 50. La prueba completa dura 140 minutos e incluye además ortografía,
-- gramática e inglés; el simulacro reserva 90 minutos para las 100 preguntas de conocimientos.
-- Penalización: la fórmula oficial (imagen en el BOE) usa aciertos, errores y N alternativas; con N=4,
-- cada error resta un tercio de acierto, como en el resto de oposiciones con esa fórmula.
begin;

insert into public.products (slug, type, status, title, title_ca, description, description_ca,
                             exam_body_id, is_free, included_in_premium, config)
select v.slug, v.type::public.product_type, 'draft', v.title, v.title_ca, v.descr, v.descr_ca,
       b.id, false, true, v.config::jsonb
  from (values
    ('guardia-civil-cabos-guardias', 'gc-conocimientos-2026', 'question_pack',
     'Guardia Civil · Conocimientos generales (test de 4 opciones)',
     'Guàrdia Civil · Coneixements generals (test de 4 opcions)',
     'Preguntas tipo test de 4 alternativas del temario oficial de ingreso: derechos humanos, igualdad, prevención de riesgos, Constitución, UE, Código Civil, Código Penal, LECrim, LOPJ, procedimiento administrativo, protección de datos, extranjería, seguridad ciudadana y privada, Interior, LO 2/1986, personal y derechos de la Guardia Civil, protección civil, TIC, código de conducta, menores, violencia de género, armas y explosivos y contrabando, con la cita literal del BOE.',
     'Preguntes tipus test de 4 alternatives del temari oficial d''ingrés, amb la cita literal del BOE.',
     '{"topic_prefix":"gc-","locale":"es"}'),
    ('guardia-civil-cabos-guardias', 'gc-simulacro-conocimientos-2026', 'mock_exam',
     'Guardia Civil · Simulacro de conocimientos generales (100 preguntas)',
     'Guàrdia Civil · Simulacre de coneixements generals (100 preguntes)',
     '100 preguntas de 4 alternativas de todo el temario, como la prueba de conocimientos generales. Cada error resta un tercio de acierto y en blanco no resta. Nota de 0 a 100; el aprobado oficial es 50. 90 minutos (la prueba real, de 140, incluye además ortografía, gramática e inglés).',
     '100 preguntes de 4 alternatives de tot el temari. Cada error resta un terç d''encert. Nota de 0 a 100; l''aprovat oficial és 50. 90 minuts.',
     '{"questions":100,"minutes":90,"penalty":0.3333,"pass_mark":50,"max_mark":100,"topic_prefix":"gc-","locale":"es"}'),
    ('guardia-civil-cabos-guardias', 'gc-pack-completo-2026', 'bundle',
     'Guardia Civil 2026 · Pack de conocimientos',
     'Guàrdia Civil 2026 · Paquet de coneixements',
     'Temario de conocimientos generales en preguntas de 4 opciones con su artículo, simulacros ilimitados con el formato oficial, repaso de errores y plan de estudio semanal. Los temas sin norma oficial publicada (instituciones internacionales, topografía, historia) se añadirán cuando tengan fuente verificable.',
     'Temari de coneixements generals en preguntes de 4 opcions, simulacres il·limitats, repàs d''errors i pla d''estudi setmanal.',
     '{"publish_with_content":"true"}')
  ) as v(exam, slug, type, title, title_ca, descr, descr_ca, config)
  join public.exam_bodies b on b.slug = v.exam
on conflict (slug) do nothing;

insert into public.product_items (product_id, position, question_id)
select p.id, row_number() over (partition by p.id order by t.slug, q.created_at), q.id
  from public.products p
  join public.topics t on t.slug like 'gc-%'
  join public.questions q on q.topic_id = t.id and q.locale = 'es' and q.is_test = false
                         and q.status in ('approved', 'published')
 where p.slug = 'gc-conocimientos-2026'
on conflict do nothing;

insert into public.product_items (product_id, position, child_product_id)
select pk.id, row_number() over (partition by pk.id order by c.type, c.slug), c.id
  from public.products pk
  join public.products c on c.slug in ('gc-conocimientos-2026', 'gc-simulacro-conocimientos-2026')
 where pk.slug = 'gc-pack-completo-2026'
on conflict do nothing;

commit;
