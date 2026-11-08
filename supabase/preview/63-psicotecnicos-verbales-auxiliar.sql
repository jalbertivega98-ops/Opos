-- Auxiliar del Estado: bloque verbal de los psicotécnicos (ADR-043).
-- Sinónimos, antónimos y ortografía con un banco comprobado en el DLE de la RAE.
-- El simulacro de psicotécnicos pasa al reparto del examen real (2024-2025):
-- 3 ortografía + 6 sinónimos/antónimos + 9 numéricos + 12 de tablas.
-- El simulacro completo y las réplicas no cambian: ya llevan 8 preguntas
-- verbales del tema age-aux-psicotecnicos-verbales (46-). Idempotente.
begin;

update public.products
   set config = config - 'item_types' || jsonb_build_object('item_types', '{"spelling":3,"synonyms":3,"antonyms":3,"series":2,"percentages":3,"equations":2,"probability":1,"codes":1,"tables":12}'::jsonb),
       description = '30 ejercicios con el reparto del examen real de la AGE: ortografía, sinónimos y antónimos (según el diccionario de la RAE), series, porcentajes, ecuaciones, probabilidad, codificación y 12 preguntas de interpretación de tablas. Cada error resta 1/3, 25 minutos. Nota sobre 10.',
       description_ca = '30 exercicis amb el repartiment de l''examen real de l''AGE: ortografia, sinònims i antònims en castellà (segons el diccionari de la RAE), sèries, percentatges, equacions, probabilitat, codificació i 12 preguntes d''interpretació de taules. Cada error resta 1/3, 25 minuts. Nota sobre 10.'
 where slug = 'age-aux-simulacro-psicotecnicos-2026'
   and config->'item_types' is distinct from '{"spelling":3,"synonyms":3,"antonyms":3,"series":2,"percentages":3,"equations":2,"probability":1,"codes":1,"tables":12}'::jsonb;

commit;
