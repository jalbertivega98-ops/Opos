-- Guardia Civil, Escala de Cabos y Guardias: productos de lengua (inglés, ortografía y gramática) y
-- descripción del pack completo ahora que el temario está entero. En BORRADOR: se publica con 36-.
-- Idempotente. Requiere 34- (temas gcl-*).
--
-- Base 6.1.1 de la convocatoria (BOE-A-2026-9982): ortografía y gramática son apto/no apto (no apto con 6
-- o más errores) y la prueba de inglés tiene 20 preguntas de 4 alternativas (N=4) con mínimo de 8 sobre 20.
-- Los temas de lengua llevan el prefijo gcl- para que no entren en el simulacro de conocimientos (gc-).
-- La convocatoria no fija un tiempo propio para el inglés (140 minutos para toda la prueba): el simulacro
-- reserva 20 minutos.
begin;

insert into public.products (slug, type, status, title, title_ca, description, description_ca,
                             exam_body_id, is_free, included_in_premium, config)
select v.slug, v.type::public.product_type, 'draft', v.title, v.title_ca, v.descr, v.descr_ca,
       b.id, false, true, v.config::jsonb
  from (values
    ('guardia-civil-cabos-guardias', 'gcl-lengua-2026', 'question_pack',
     'Guardia Civil · Inglés, ortografía y gramática',
     'Guàrdia Civil · Anglès, ortografia i gramàtica',
     'Ejercicios de 4 opciones para las pruebas de lengua de la oposición: inglés, ortografía y gramática española (con la norma de la RAE citada en cada pregunta de ortografía y gramática).',
     'Exercicis de 4 opcions per a les proves de llengua: anglès, ortografia i gramàtica castellana.',
     '{"topic_prefix":"gcl-","locale":"es"}'),
    ('guardia-civil-cabos-guardias', 'gcl-simulacro-ingles-2026', 'mock_exam',
     'Guardia Civil · Simulacro de inglés (20 preguntas)',
     'Guàrdia Civil · Simulacre d''anglès (20 preguntes)',
     '20 preguntas de inglés de 4 alternativas, como la prueba oficial. Cada error resta un tercio de acierto. Nota de 0 a 20; el mínimo oficial es 8. 20 minutos.',
     '20 preguntes d''anglès de 4 alternatives. Cada error resta un terç d''encert. Nota de 0 a 20; el mínim oficial és 8. 20 minuts.',
     '{"questions":20,"minutes":20,"penalty":0.3333,"pass_mark":8,"max_mark":20,"topic_prefix":"gcl-24","locale":"es"}')
  ) as v(exam, slug, type, title, title_ca, descr, descr_ca, config)
  join public.exam_bodies b on b.slug = v.exam
on conflict (slug) do nothing;

insert into public.product_items (product_id, position, child_product_id)
select pk.id, 10 + row_number() over (partition by pk.id order by c.type, c.slug), c.id
  from public.products pk
  join public.products c on c.slug in ('gcl-lengua-2026', 'gcl-simulacro-ingles-2026')
 where pk.slug = 'gc-pack-completo-2026'
on conflict do nothing;

update public.products
   set description = 'Todo el temario oficial de ingreso en preguntas de 4 opciones con su fuente citada (incluidos instituciones internacionales, topografía e historia de la Guardia Civil), simulacros ilimitados de conocimientos y de inglés con el formato oficial, ejercicios de ortografía y gramática, repaso de errores y plan de estudio semanal.'
 where slug = 'gc-pack-completo-2026';

commit;
