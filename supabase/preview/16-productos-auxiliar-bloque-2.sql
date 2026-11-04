-- Auxiliar Administrativo del Estado · Bloque II (actividad administrativa y ofimática):
-- pack de test y simulacro de la parte 2 con el formato oficial (BOE 22/12/2025, Anexo I):
-- 50 preguntas, 4 respuestas, error −1/3. El ejercicio único dura 90 min para 110
-- preguntas; aquí 40 min para las 50 de la parte 2. Se añaden al pack completo.
-- Todo en BORRADOR; se publica con 17-. Idempotente. Requiere 12- y 14-.
begin;

insert into public.products (slug, type, status, title, title_ca, description, description_ca,
                             exam_body_id, is_free, included_in_premium, config)
select v.slug, v.type::public.product_type, 'draft', v.title, v.title_ca, v.descr, v.descr_ca,
       b.id, false, true, v.config::jsonb
  from public.exam_bodies b,
  (values
    ('age-aux-bloque-2-2026', 'question_pack',
     'Auxiliar del Estado · Bloque II: actividad administrativa y ofimática (test)',
     'Auxiliar de l''Estat · Bloc II: activitat administrativa i ofimàtica (test)',
     'Preguntas tipo test del Bloque II: atención al ciudadano, registro y archivo, administración electrónica, Windows 11, Word, Excel, Access, Outlook e Internet, con la cita literal de la norma o de la documentación oficial de Microsoft.',
     'Preguntes tipus test del Bloc II: atenció a la ciutadania, registre i arxiu, administració electrònica, Windows 11, Word, Excel, Access, Outlook i Internet, amb la cita literal de la norma o de la documentació oficial de Microsoft.',
     '{"topic_prefix":"age-aux-b2-","locale":"es"}'),
    ('age-aux-simulacro-bloque-2-2026', 'mock_exam',
     'Auxiliar del Estado · Simulacro parte 2: Bloque II (formato oficial)',
     'Auxiliar de l''Estat · Simulacre part 2: Bloc II (format oficial)',
     '50 preguntas del Bloque II, 4 respuestas, cada error resta 1/3 y en blanco no resta, 40 minutos. Nota sobre 10. Cada simulacro es distinto.',
     '50 preguntes del Bloc II, 4 respostes, cada error resta 1/3 i en blanc no resta, 40 minuts. Nota sobre 10. Cada simulacre és diferent.',
     '{"questions":50,"minutes":40,"penalty":0.3333,"pass_mark":5,"max_mark":10,"topic_prefix":"age-aux-b2-","locale":"es"}')
  ) as v(slug, type, title, title_ca, descr, descr_ca, config)
 where b.slug = 'auxiliar-administrativo-estado'
on conflict (slug) do nothing;

insert into public.product_items (product_id, position, question_id)
select p.id, row_number() over (partition by p.id order by t.slug, q.created_at), q.id
  from public.products p
  join public.topics t on t.slug like 'age-aux-b2-%'
  join public.questions q on q.topic_id = t.id and q.locale = 'es' and q.is_test = false
                         and q.status in ('approved', 'published')
 where p.slug = 'age-aux-bloque-2-2026'
on conflict do nothing;

-- El pack completo pasa a cubrir las dos partes del ejercicio único
insert into public.product_items (product_id, position, child_product_id)
select pk.id, 10 + row_number() over (order by c.slug), c.id
  from public.products pk
  join public.products c on c.slug in ('age-aux-bloque-2-2026', 'age-aux-simulacro-bloque-2-2026')
 where pk.slug = 'age-aux-pack-completo-2026'
on conflict do nothing;

update public.products
   set description = 'Todo para el ejercicio único: Bloque I y Bloque II completos en preguntas con su fuente literal, simulacros ilimitados de la parte 1 (Bloque I y psicotécnicos) y de la parte 2 (ofimática) con el formato oficial, repaso de errores y plan de estudio semanal.',
       description_ca = 'Tot per a l''exercici únic: Bloc I i Bloc II complets en preguntes amb la font literal, simulacres il·limitats de la part 1 (Bloc I i psicotècnics) i de la part 2 (ofimàtica) amb el format oficial, repàs d''errors i pla d''estudi setmanal.'
 where slug = 'age-aux-pack-completo-2026'
   and description is distinct from 'Todo para el ejercicio único: Bloque I y Bloque II completos en preguntas con su fuente literal, simulacros ilimitados de la parte 1 (Bloque I y psicotécnicos) y de la parte 2 (ofimática) con el formato oficial, repaso de errores y plan de estudio semanal.';

commit;
