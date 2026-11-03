-- Packs de práctica en BORRADOR con el temario de Mossos (Guia d'estudi 2026), uno por àmbit.
-- Cada pack lleva en config el prefijo de sus temas: al publicar un lote desde
-- /admin/revision/fuentes, sus preguntas se añaden solas al pack correspondiente.
-- El pack en sí se publica aparte desde /admin/productos.
-- Idempotente. Requiere 4- y 5a/5b/5c-.
begin;
insert into public.products (slug, type, status, title, title_ca, description, description_ca, exam_body_id, is_free, included_in_premium, config)
select v.slug, 'question_pack', 'draft', v.title, v.title_ca, v.descr, v.descr_ca, b.id, false, true,
       jsonb_build_object('topic_prefix', 'mossos-' || substr(v.slug, 14, 1), 'locale', 'ca')
  from public.exam_bodies b,
  (values
    ('mossos-ambit-a-guia-2026', 'Mossos · Ámbito A: sociedad (Guia 2026)', 'Mossos · Àmbit A: societat (Guia 2026)',
     'Preguntas de los temas A.1–A.7 de la Guia d''estudi oficial, en catalán.', 'Preguntes dels temes A.1–A.7 de la Guia d''estudi oficial.'),
    ('mossos-ambit-b-guia-2026', 'Mossos · Ámbito B: institucional (Guia 2026)', 'Mossos · Àmbit B: institucional (Guia 2026)',
     'Preguntas de los temas B.1–B.8 de la Guia d''estudi oficial, en catalán.', 'Preguntes dels temes B.1–B.8 de la Guia d''estudi oficial.'),
    ('mossos-ambit-c-guia-2026', 'Mossos · Ámbito C: seguridad y policía (Guia 2026)', 'Mossos · Àmbit C: seguretat i policia (Guia 2026)',
     'Preguntas de los temas C.1–C.5 de la Guia d''estudi oficial, en catalán.', 'Preguntes dels temes C.1–C.5 de la Guia d''estudi oficial.')
  ) as v(slug, title, title_ca, descr, descr_ca)
 where b.slug = 'mossos-esquadra'
on conflict (slug) do nothing;

insert into public.product_items (product_id, position, question_id)
select p.id, row_number() over (partition by p.id order by t.slug, q.created_at), q.id
  from public.products p
  join public.topics t on t.slug like 'mossos-' || substr(p.slug, 14, 1) || '%'
  join public.questions q on q.topic_id = t.id and q.locale = 'ca' and q.is_test = false
                         and q.status in ('approved', 'published')
 where p.slug in ('mossos-ambit-a-guia-2026', 'mossos-ambit-b-guia-2026', 'mossos-ambit-c-guia-2026')
on conflict do nothing;
commit;
