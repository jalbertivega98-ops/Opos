-- Publica en la PREVIEW las cuatro oposiciones nuevas (Guardia Urbana de Barcelona, policía local de Cataluña,
-- Bombers de la Generalitat y Ayudantes de Instituciones Penitenciarias): preguntas, fichas y productos.
-- Lo pidió joel (06/11/2026): «Pon el temario completo, obviamente, y luego test de ese tema. Y luego, si tienen un
-- examen tal, simulacro de examen real».
-- * Las preguntas DUDOSAS (con nota de revisión) NO se publican: quedan en borrador.
-- * Los simulacros réplica sacan TODAS las preguntas publicadas de su examen (los cortes se ajustan en proporción).
-- * Premium de cada oposición, 3 temas gratis y pack de 10 simulacros, como el resto (ADR-035).
-- Idempotente. Requiere 50- a 54-. Equivale a «Aprobar lote» + «Publicar» como titular.
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
                 where slug like 'gub%' or slug like 'plcat%' or slug like 'bomb%' or slug like 'iipp%'
                 order by slug loop
    perform public.review_topic_batch(v_slug, 'approved', false);
    v_q := v_q + public.review_topic_batch(v_slug, 'published', false);
    perform public.review_topic_notes(v_slug, 'approved');
    v_n := v_n + public.review_topic_notes(v_slug, 'published');
  end loop;
  perform public.log_admin_action('content.publish_exam', 'exam_bodies',
    'guardia-urbana-barcelona,policia-local,bombers-generalitat,ayudantes-instituciones-penitenciarias',
    jsonb_build_object('questions', v_q, 'notes', v_n,
                       'motivo', 'Petición expresa de joel en el hilo del proyecto (06/11/2026)'));
  perform set_config('request.jwt.claims', '', true);
  raise notice 'Oposiciones nuevas: % preguntas y % fichas publicadas', v_q, v_n;
end $$;

-- Simulacros réplica: tantas preguntas como tenga publicadas su examen

update public.products set config = jsonb_build_object('topic_prefix', 'gubexamen-2025', 'locale', 'ca',
       'questions', (select count(*)::int from public.mock_prefix_pool('gubexamen-2025', 'ca', false)), 'minutes', greatest(10, ceil(1.17 * (select count(*)::int from public.mock_prefix_pool('gubexamen-2025', 'ca', false)))::int), 'penalty', 0.25,
       'max_mark', 10, 'pass_mark', 5,
       'quotas', jsonb_build_array(jsonb_build_object('topic_prefix', 'gubexamen-2025', 'questions', (select count(*)::int from public.mock_prefix_pool('gubexamen-2025', 'ca', false)))))
 where slug = 'gub-simulacre-examen-2025' and (select count(*)::int from public.mock_prefix_pool('gubexamen-2025', 'ca', false)) > 0;

update public.products set config = jsonb_build_object('topic_prefix', 'gubexamen-2023', 'locale', 'ca',
       'questions', (select count(*)::int from public.mock_prefix_pool('gubexamen-2023', 'ca', false)), 'minutes', greatest(10, ceil(1.17 * (select count(*)::int from public.mock_prefix_pool('gubexamen-2023', 'ca', false)))::int), 'penalty', 0.25,
       'max_mark', 10, 'pass_mark', 5,
       'quotas', jsonb_build_array(jsonb_build_object('topic_prefix', 'gubexamen-2023', 'questions', (select count(*)::int from public.mock_prefix_pool('gubexamen-2023', 'ca', false)))))
 where slug = 'gub-simulacre-examen-2023' and (select count(*)::int from public.mock_prefix_pool('gubexamen-2023', 'ca', false)) > 0;

update public.products set config = jsonb_build_object('topic_prefix', 'gubexamen-2022', 'locale', 'ca',
       'questions', (select count(*)::int from public.mock_prefix_pool('gubexamen-2022', 'ca', false)), 'minutes', greatest(10, ceil(1.2 * (select count(*)::int from public.mock_prefix_pool('gubexamen-2022', 'ca', false)))::int), 'penalty', 0.25,
       'max_mark', 12, 'pass_mark', 4,
       'quotas', jsonb_build_array(jsonb_build_object('topic_prefix', 'gubexamen-2022', 'questions', (select count(*)::int from public.mock_prefix_pool('gubexamen-2022', 'ca', false)))))
 where slug = 'gub-simulacre-examen-2022' and (select count(*)::int from public.mock_prefix_pool('gubexamen-2022', 'ca', false)) > 0;

update public.products set config = jsonb_build_object('topic_prefix', 'plcatexamen-2026-terrassa', 'locale', 'ca',
       'questions', (select count(*)::int from public.mock_prefix_pool('plcatexamen-2026-terrassa', 'ca', false)), 'minutes', greatest(10, ceil(1.2 * (select count(*)::int from public.mock_prefix_pool('plcatexamen-2026-terrassa', 'ca', false)))::int), 'penalty', 0.25,
       'max_mark', 12, 'pass_mark', 4,
       'quotas', jsonb_build_array(jsonb_build_object('topic_prefix', 'plcatexamen-2026-terrassa', 'questions', (select count(*)::int from public.mock_prefix_pool('plcatexamen-2026-terrassa', 'ca', false)))))
 where slug = 'plcat-simulacre-examen-2026-terrassa' and (select count(*)::int from public.mock_prefix_pool('plcatexamen-2026-terrassa', 'ca', false)) > 0;

update public.products set config = jsonb_build_object('topic_prefix', 'plcatexamen-2025-terrassa', 'locale', 'ca',
       'questions', (select count(*)::int from public.mock_prefix_pool('plcatexamen-2025-terrassa', 'ca', false)), 'minutes', greatest(10, ceil(1.2 * (select count(*)::int from public.mock_prefix_pool('plcatexamen-2025-terrassa', 'ca', false)))::int), 'penalty', 0.25,
       'max_mark', 12, 'pass_mark', 4,
       'quotas', jsonb_build_array(jsonb_build_object('topic_prefix', 'plcatexamen-2025-terrassa', 'questions', (select count(*)::int from public.mock_prefix_pool('plcatexamen-2025-terrassa', 'ca', false)))))
 where slug = 'plcat-simulacre-examen-2025-terrassa' and (select count(*)::int from public.mock_prefix_pool('plcatexamen-2025-terrassa', 'ca', false)) > 0;

update public.products set config = jsonb_build_object('topic_prefix', 'plcatexamen-2022-badalona', 'locale', 'ca',
       'questions', (select count(*)::int from public.mock_prefix_pool('plcatexamen-2022-badalona', 'ca', false)), 'minutes', greatest(10, ceil(1.17 * (select count(*)::int from public.mock_prefix_pool('plcatexamen-2022-badalona', 'ca', false)))::int), 'penalty', 0.25,
       'max_mark', 10, 'pass_mark', 5,
       'quotas', jsonb_build_array(jsonb_build_object('topic_prefix', 'plcatexamen-2022-badalona', 'questions', (select count(*)::int from public.mock_prefix_pool('plcatexamen-2022-badalona', 'ca', false)))))
 where slug = 'plcat-simulacre-examen-2022-badalona' and (select count(*)::int from public.mock_prefix_pool('plcatexamen-2022-badalona', 'ca', false)) > 0;

update public.products set config = jsonb_build_object('topic_prefix', 'bombexamen-2025', 'locale', 'ca',
       'questions', (select count(*)::int from public.mock_prefix_pool('bombexamen-2025', 'ca', false)), 'minutes', greatest(10, ceil(1.15 * (select count(*)::int from public.mock_prefix_pool('bombexamen-2025', 'ca', false)))::int), 'penalty', 0.25,
       'max_mark', 8, 'pass_mark', 4,
       'quotas', jsonb_build_array(jsonb_build_object('topic_prefix', 'bombexamen-2025', 'questions', (select count(*)::int from public.mock_prefix_pool('bombexamen-2025', 'ca', false)))))
 where slug = 'bomb-simulacre-examen-2025' and (select count(*)::int from public.mock_prefix_pool('bombexamen-2025', 'ca', false)) > 0;

update public.products set config = jsonb_build_object('topic_prefix', 'iipp-examen-2026-test', 'locale', 'es',
       'questions', (select count(*)::int from public.mock_prefix_pool('iipp-examen-2026-test', 'es', false)), 'minutes', greatest(10, ceil(0.875 * (select count(*)::int from public.mock_prefix_pool('iipp-examen-2026-test', 'es', false)))::int), 'penalty', 0.3333,
       'max_mark', (select count(*)::int from public.mock_prefix_pool('iipp-examen-2026-test', 'es', false)), 'pass_mark', round(67::numeric * (select count(*)::int from public.mock_prefix_pool('iipp-examen-2026-test', 'es', false)) / 120, 2),
       'quotas', jsonb_build_array(jsonb_build_object('topic_prefix', 'iipp-examen-2026-test', 'questions', (select count(*)::int from public.mock_prefix_pool('iipp-examen-2026-test', 'es', false)))))
 where slug = 'iipp-simulacro-examen-2026' and (select count(*)::int from public.mock_prefix_pool('iipp-examen-2026-test', 'es', false)) > 0;

update public.products set config = jsonb_build_object('topic_prefix', 'iipp-examen-2026-casos', 'locale', 'es',
       'questions', (select count(*)::int from public.mock_prefix_pool('iipp-examen-2026-casos', 'es', false)), 'minutes', greatest(10, ceil(2.0 * (select count(*)::int from public.mock_prefix_pool('iipp-examen-2026-casos', 'es', false)))::int), 'penalty', 0.3333,
       'max_mark', (select count(*)::int from public.mock_prefix_pool('iipp-examen-2026-casos', 'es', false)), 'pass_mark', round(26.6667::numeric * (select count(*)::int from public.mock_prefix_pool('iipp-examen-2026-casos', 'es', false)) / 40, 2),
       'quotas', jsonb_build_array(jsonb_build_object('topic_prefix', 'iipp-examen-2026-casos', 'questions', (select count(*)::int from public.mock_prefix_pool('iipp-examen-2026-casos', 'es', false)))))
 where slug = 'iipp-simulacro-examen-2026-casos' and (select count(*)::int from public.mock_prefix_pool('iipp-examen-2026-casos', 'es', false)) > 0;

-- Packs de preguntas (con alguna publicada) y simulacros con todos sus cupos cubiertos
update public.products p set status = 'published', published_at = coalesce(p.published_at, now())
 where p.status = 'draft' and p.is_test = false
   and p.exam_body_id in (select id from public.exam_bodies where slug in
       ('guardia-urbana-barcelona', 'policia-local', 'bombers-generalitat', 'ayudantes-instituciones-penitenciarias'))
   and ((p.type = 'question_pack' and exists (
          select 1 from public.topics t join public.questions q on q.topic_id = t.id
           where t.slug like (p.config->>'topic_prefix') || '%' and q.status = 'published' and q.is_test = false))
        or (p.type = 'mock_exam' and (p.config->>'questions')::int > 0 and public.mock_quotas_ready(p.id)));

insert into public.product_items (product_id, position, question_id)
select p.id, row_number() over (partition by p.id order by t.slug, q.created_at), q.id
  from public.products p
  join public.topics t on t.slug like (p.config->>'topic_prefix') || '%'
  join public.questions q on q.topic_id = t.id and q.is_test = false and q.status = 'published'
 where p.type = 'question_pack' and p.slug in ('gub-temari-2026', 'plcat-temari-2026', 'bomb-temari-2026',
                                               'iipp-temario-2026', 'iippsup-supuestos-2026')
on conflict do nothing;

-- Modelo de venta de ADR-035: Premium de la oposición, 3 primeros temas gratis y pack de 10 simulacros
create temporary table opo_model (exam text, pfx text, free_topics jsonb, locale text) on commit drop;
insert into opo_model values
  ('guardia-urbana-barcelona', 'gub', '["gub-t01-constitucio","gub-t02-estatut-autonomia","gub-t03-regim-local"]', 'ca'),
  ('policia-local', 'plcat', '["plcat-t01-constitucio-drets","plcat-t02-constitucio-organitzacio-territorial","plcat-t03-estatut-autonomia"]', 'ca'),
  ('bombers-generalitat', 'bomb', '["bomb-t01-constitucio-estatut-generalitat","bomb-t02-funcio-publica","bomb-t03-prevencio-riscos-laborals-epi"]', 'ca'),
  ('ayudantes-instituciones-penitenciarias', 'iipp', '["iipp-a01-constitucion-corona-cortes","iipp-a02-poder-judicial-tc-fiscal","iipp-a03-gobierno-periferica"]', 'es');

-- Premium de cada oposición (suscripción mensual)
insert into public.products (slug, type, status, title, title_ca, description, description_ca,
                             exam_body_id, is_free, included_in_premium, config, published_at)
select m.pfx || '-premium', 'subscription', 'published',
       'Premium · ' || b.name, 'Premium · ' || coalesce(b.name_ca, b.name),
       'Todo lo de ' || b.name || ': temario completo en test, simulacros con el formato oficial, exámenes réplica, repaso de errores y plan semanal. Cancela cuando quieras.',
       'Tot el de ' || coalesce(b.name_ca, b.name) || ': temari complet en test, simulacres amb el format oficial, exàmens rèplica, repàs d''errors i pla setmanal. Cancel·la quan vulguis.',
       b.id, false, false, '{}'::jsonb, now()
  from opo_model m join public.exam_bodies b on b.slug = m.exam
on conflict (slug) do nothing;

-- 3 temas gratis (preguntas publicadas de esos temas, también las futuras)
insert into public.products (slug, type, status, title, title_ca, description, description_ca,
                             exam_body_id, is_free, included_in_premium, config, published_at)
select m.pfx || '-temas-gratis', 'question_pack', 'published',
       b.name || ' · 3 temas gratis', coalesce(b.name_ca, b.name) || ' · 3 temes gratis',
       'Preguntas tipo test de los 3 primeros temas, con explicación y fuente, para empezar a practicar gratis.',
       'Preguntes tipus test dels 3 primers temes, amb explicació i font, per començar a practicar gratis.',
       b.id, true, true, jsonb_build_object('topic_slugs', m.free_topics, 'locale', m.locale), now()
  from opo_model m join public.exam_bodies b on b.slug = m.exam
on conflict (slug) do update set config = excluded.config, is_free = true;

-- Packs de 10 intentos: simulacros de examen (todos menos los de psicotécnicos)
insert into public.products (slug, type, status, title, title_ca, description, description_ca,
                             exam_body_id, is_free, included_in_premium, config, published_at)
select m.pfx || '-10-simulacros', 'bundle', 'published',
       b.name || ' · 10 simulacros', coalesce(b.name_ca, b.name) || ' · 10 simulacres',
       '10 intentos de simulacro con el formato oficial, exámenes réplica incluidos, a tu ritmo y sin suscripción.',
       '10 intents de simulacre amb el format oficial, exàmens rèplica inclosos, al teu ritme i sense subscripció.',
       b.id, false, false, '{"attempts":10}'::jsonb, now()
  from opo_model m join public.exam_bodies b on b.slug = m.exam
 where exists (select 1 from public.products c where c.exam_body_id = b.id and c.type = 'mock_exam'
                 and c.status = 'published' and c.is_test = false
                 and coalesce(c.config->>'kind', '') <> 'psycho')
on conflict (slug) do nothing;

-- Packs de 10 intentos de simulacro de psicotécnicos (solo donde hay uno con formato oficial)
insert into public.products (slug, type, status, title, title_ca, description, description_ca,
                             exam_body_id, is_free, included_in_premium, config, published_at)
select m.pfx || '-10-psicotecnicos', 'bundle', 'published',
       b.name || ' · 10 simulacros de psicotécnicos',
       coalesce(b.name_ca, b.name) || ' · 10 simulacres de psicotècnics',
       '10 intentos del simulacro de psicotécnicos con el formato y el tiempo del examen oficial.',
       '10 intents del simulacre de psicotècnics amb el format i el temps de l''examen oficial.',
       b.id, false, false, '{"attempts":10}'::jsonb, now()
  from opo_model m join public.exam_bodies b on b.slug = m.exam
 where exists (select 1 from public.products c where c.exam_body_id = b.id and c.type = 'mock_exam'
                 and c.status = 'published' and c.is_test = false and c.config->>'kind' = 'psycho')
on conflict (slug) do nothing;

insert into public.product_items (product_id, position, child_product_id)
select p.id, row_number() over (partition by p.id order by c.slug), c.id
  from opo_model m
  join public.products p on p.slug in (m.pfx || '-10-simulacros', m.pfx || '-10-psicotecnicos')
  join public.products c on c.exam_body_id = p.exam_body_id and c.type = 'mock_exam'
                        and c.status = 'published' and c.is_test = false
                        and (coalesce(c.config->>'kind', '') = 'psycho') = (p.slug like '%-10-psicotecnicos')
on conflict do nothing;

-- Precios (provisionales)
insert into public.product_prices (product_id, amount_cents, billing_interval)
select p.id, v.cents, v.intv
  from opo_model m
  cross join (values ('-premium', 1299, 'month'), ('-10-simulacros', 999, null),
                     ('-10-psicotecnicos', 699, null)) v(suffix, cents, intv)
  join public.products p on p.slug = m.pfx || v.suffix
 where not exists (select 1 from public.product_prices x where x.product_id = p.id and x.active)
on conflict do nothing;


select public.open_exams_with_content();

commit;
