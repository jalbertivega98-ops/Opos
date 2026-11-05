-- Publica en la PREVIEW las preguntas y fichas que cubren los huecos de los exámenes reales (41-).
-- Lo pidió joel (05/11/2026): «Revisa oposicion por oposicion, que tenemos y que es lo que realmente ha
-- entrado en cada oposicion para que los clientes tengan lo que se van a encontrar y practiquen con eso».
-- Informe: docs (Claude Doc «Lo que cae en cada oposición») y /mnt/project-files/aprobia/examenes-reales/.
-- * Las preguntas DUDOSAS (con nota de revisión) NO se publican: quedan en borrador.
-- * Solo toca los temas de 41-. Idempotente. Requiere 41-.
begin;

do $$
declare
  v_owner uuid;
  v_slug text;
  v_q int := 0;
  v_n int := 0;
begin
  select id into v_owner from public.profiles
   where role = 'owner' and status = 'active' order by created_at limit 1;
  if v_owner is null then
    raise notice 'No hay persona titular: no se publica nada.';
    return;
  end if;
  perform set_config('request.jwt.claims',
    json_build_object('sub', v_owner, 'role', 'authenticated')::text, true);

  for v_slug in select slug from public.topics
                 where slug in ('age-adm-33-procedimiento-revision',
                    'age-adm-44-situaciones-administrativas',
                    'age-adm-45-permisos-vacaciones',
                    'age-adm-46-regimen-disciplinario',
                    'age-adm-48-convenio-unico',
                    'age-adm-52-modificaciones-credito',
                    'age-adm-60-supuesto-practico',
                    'age-aux-b1-13-funcion-publica',
                    'age-aux-b1-14-derechos-deberes-funcionarios',
                    'age-aux-b2-05-informatica-basica',
                    'age-aux-b2-06-windows',
                    'gc-04-derecho-constitucional',
                    'gc-08a-penal-general',
                    'gc-08b-penal-especial',
                    'gc-09a-lecrim',
                    'gc-09b-lopj-policia-judicial',
                    'gc-10a-procedimiento-administrativo',
                    'gc-10b-regimen-juridico',
                    'gc-12-extranjeria',
                    'gc-13-seguridad-publica-privada',
                    'gc-15a-fuerzas-cuerpos-seguridad',
                    'gc-15b-personal-guardia-civil',
                    'gcl-24-ingles',
                    'jus-09-carta-derechos',
                    'jus-23-comunicacion-tribunales',
                    'jus-24-comunicacion-partes',
                    'jus-26-archivo-judicial',
                    'justra-09-plan-transparencia',
                    'justra-16-masc-declarativos',
                    'justra-17-ejecucion-cautelares',
                    'justra-18-procesos-especiales',
                    'justra-19-jurisdiccion-voluntaria',
                    'justra-20-penal-ordinario-abreviado-jurado',
                    'justra-21-leves-rapidos-ejecucion',
                    'justra-ofimatica-word',
                    'mossos-a1-historia-1',
                    'mossos-a2-historia-2',
                    'mossos-a4-sociolinguistic',
                    'mossos-a5-marc-geografic',
                    'mossos-b2-institucions-catalunya',
                    'mossos-b3-ordenament-juridic',
                    'mossos-b8-unio-europea',
                    'mossos-c2-departament-interior',
                    'mossos-c3-coordinacio-policial',
                    'mossos-c4-marc-legal-seguretat',
                    'pn-27-derechos-humanos',
                    'pn-30-etica-delitos-odio',
                    'pn-31-inmigracion',
                    'pn-32-geografia-demografia',
                    'pn-33-seguridad-delincuencia',
                    'pn-34-drogodependencias',
                    'pn-35-desarrollo-sostenible',
                    'pn-36-gramatica',
                    'pn-37-ortografia',
                    'pn-38-sistemas-operativos',
                    'pn-39-redes',
                    'pn-40-inteligencia-osint',
                    'pn-41-ciberdelincuencia',
                    'pn-42-armas',
                    'pn-43-vehiculo-prioritario',
                    'pn-44-seguridad-vehiculos',
                    'pn-45-prl-seguridad-vial')
                 order by slug loop
    perform public.review_topic_batch(v_slug, 'approved', false);
    v_q := v_q + public.review_topic_batch(v_slug, 'published', false);
    perform public.review_topic_notes(v_slug, 'approved');
    v_n := v_n + public.review_topic_notes(v_slug, 'published');
  end loop;

  perform public.open_exams_with_content();
  perform public.log_admin_action('content.publish_exam', 'exam_bodies', 'huecos-examenes-reales',
    jsonb_build_object('questions', v_q, 'notes', v_n,
                       'motivo', 'Petición expresa de joel en el hilo del proyecto (05/11/2026: practicar con lo que cae de verdad en cada examen)'));
  perform set_config('request.jwt.claims', '', true);
  raise notice 'Huecos de los exámenes reales: % preguntas y % fichas publicadas', v_q, v_n;
end $$;

-- Temario común: las preguntas nuevas de Auxiliar también son de Administrativo (bloques I-VI) y las de
-- ofimática, de Tramitación (temas 32-37). Mismo criterio que 28-.
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from public.questions q
  join public.topics t on t.id = q.topic_id and t.slug like 'age-aux-b_-%'
  cross join public.exam_bodies b
 where b.slug = 'administrativo-estado' and q.is_test = false
on conflict do nothing;

insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from public.questions q
  join public.topics t on t.id = q.topic_id
  cross join public.exam_bodies b
 where b.slug = 'tramitacion-procesal' and q.is_test = false
   and t.slug in ('age-aux-b2-05-informatica-basica', 'age-aux-b2-06-windows', 'age-aux-b2-07-explorador',
                  'age-aux-b2-08-word', 'age-aux-b2-11-outlook', 'age-aux-b2-12-internet')
on conflict do nothing;

-- El pack de ofimática de Tramitación no va por prefijo: se le añaden las preguntas publicadas de sus temas
-- (incluido el nuevo de Word 365, justra-ofimatica-word).
insert into public.product_items (product_id, position, question_id)
select p.id,
       coalesce((select max(position) from public.product_items x where x.product_id = p.id), 0)
         + row_number() over (order by t.slug, q.created_at),
       q.id
  from public.products p
  join public.topics t on t.slug in ('age-aux-b2-05-informatica-basica', 'age-aux-b2-06-windows',
                                     'age-aux-b2-07-explorador', 'age-aux-b2-08-word',
                                     'age-aux-b2-11-outlook', 'age-aux-b2-12-internet',
                                     'justra-ofimatica-word')
  join public.questions q on q.topic_id = t.id and q.locale = 'es' and q.is_test = false
                         and q.status = 'published'
 where p.slug = 'jus-tramitacion-ofimatica-2026'
   and not exists (select 1 from public.product_items i where i.product_id = p.id and i.question_id = q.id)
on conflict do nothing;

commit;
