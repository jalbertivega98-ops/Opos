-- Prisiones de Cataluña: 11 de las 19 preguntas dudosas, verificadas y publicadas.
-- joel pidió «fusionalas y subelo todo» (10/11/2026). Cada duda se revisó contra su fuente:
-- * CP 22.8, 234.2 y 235.1.10.º: texto consolidado vigente con la LO 1/2026 (en vigor, como en 30-).
-- * LOGP 77 y 79, RD 1436/1984 art. 5.1, LOGP 15 bis.2, LPAC 24.1, TREBEP 97.1, Llei 21/1987 art. 5.1 y la
--   fecha de la Rec(2006)2 en la Circular 2/2011: la pregunta dice «segons…» y la respuesta es literal del
--   texto vigente; se añade a la explicación el matiz que motivaba la duda cuando hace falta.
-- Siguen en BORRADOR (8): Circular 1/2022 disp. transitoria y adicional 2.ª (ya agotadas), Llei 23/2009 del
-- CIRE arts. 1.1, 2.1, 4 y 16 (sin texto consolidado posterior a 2012) y DL 1/1997 arts. 86.2.a y 91
-- (vigencia frente al TREBEP sin confirmar).
-- Idempotente. Requiere 66- y 67-.
begin;

update public.questions q
   set review_note = null,
       explanation = case when v.extra = '' or q.explanation like '%' || v.extra then q.explanation
                          else q.explanation || ' ' || v.extra end
  from (values
  ('64ea79cd80ce30dce58ab6ec6f27d991e59cc0b266e1f300b0212fa42fd6ada8', 'Redacció vigent després de la LO 1/2026.'),
  ('7272cfa0a6135d66b58b6a88f3c3c885882c79a24c1e80b83f5e7b32b28c42af', 'Redacció vigent després de la LO 1/2026.'),
  ('b289c44bc8ca5588c4243d2b037493ee53530ce4f848db54611e08bd7734d529', 'Numeral afegit per la LO 1/2026.'),
  ('9145576d58795b63b74ec73302ddc2dc2f88d6d15d0d8992600d877aeb7aa4b6', 'A Catalunya aquestes funcions corresponen al Departament de Justícia, que té traspassada l''execució penitenciària.'),
  ('84ef88f041bf541d9ee45a785b8c01f8995a8e0973ee4c3422bcb00fbedeff4c', 'Les Normes penitenciàries europees es van revisar el 2020.'),
  ('1648dd19a2f17dc24d8bdb1fd81df16cd8809c7aadbcd9d4d2dc82ef0a487d6b', ''),
  ('6a2a26bfbc4b5f204faba9cc05d309608c2cf6f8b6761593f8556aa638215704', 'A Catalunya, l''òrgan equivalent és la direcció general competent en serveis penitenciaris del Departament de Justícia.'),
  ('e1b2433d9e0ed73234b02bc7695b896be3d6c14bf99a6bbd20c2c31e217b9896', ''),
  ('caf1a37384747ff3cd0b13af41573f38fb7b620c01d00838d8b46b0018964ea9', ''),
  ('00657ff6d1a495e8b5d5cfdb2058b12667c4827f71a78fbbcb5fec6f38416976', 'Atenció: el Decret 243/1995 (art. 22) fixa uns altres terminis per als funcionaris de la Generalitat; la pregunta es refereix al TREBEP.'),
  ('3302180210eb716e77c5631093ca340e43291a69a981f9dd2691802369970a45', 'La llei utilitza la classificació antiga per grups (A-E).')
  ) as v(content_hash, extra)
 where q.content_hash = v.content_hash and q.locale = 'ca' and q.is_test = false
   and q.status in ('draft', 'needs_review');

do $$
declare
  v_owner uuid;
  v_slug text;
  v_q int := 0;
  v_n int := 0;
  v_p int := 0;
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
                 where slug like 'pcat%'
                 order by slug loop
    perform public.review_topic_batch(v_slug, 'approved', false);
    v_q := v_q + public.review_topic_batch(v_slug, 'published', false);
    perform public.review_topic_notes(v_slug, 'approved');
    v_n := v_n + public.review_topic_notes(v_slug, 'published');
  end loop;

  with pub as (
    update public.products p set status = 'published'
     where p.status = 'draft' and p.is_test = false
       and p.slug like 'pcat%'
       and p.type <> 'bundle'
       and (p.type <> 'question_pack'
            or exists (select 1 from public.product_items i join public.questions q on q.id = i.question_id
                        where i.product_id = p.id and q.status = 'published'))
       and (p.type <> 'mock_exam'
            or (p.config->>'kind' = 'sections' and public.mock_sections_ready(p.id))
            or (coalesce(p.config->>'kind', '') <> 'sections'
                and (select count(*) from public.mock_pool(p.id)) >= (public.mock_config(p.config)->>'questions')::int))
    returning 1)
  select count(*) into v_p from pub;

  -- Los packs completos solo se publican si ya tienen algún producto publicado dentro
  with pub as (
    update public.products p set status = 'published'
     where p.status = 'draft' and p.is_test = false and p.type = 'bundle'
       and p.slug like 'pcat%'
       and exists (select 1 from public.product_items i join public.products c on c.id = i.child_product_id
                    where i.product_id = p.id and c.status = 'published')
    returning 1)
  select v_p + count(*) into v_p from pub;

  perform public.open_exams_with_content();
  perform public.log_admin_action('content.publish_exam', 'exam_bodies',
    'serveis-penitenciaris-catalunya',
    jsonb_build_object('questions', v_q, 'notes', v_n, 'products', v_p,
                       'motivo', 'Dudosas verificadas por petición de joel (10/11/2026: «fusionalas y subelo todo»)'));
  perform set_config('request.jwt.claims', '', true);
  raise notice 'Prisiones de Cataluña: % preguntas, % fichas y % productos publicados', v_q, v_n, v_p;
end $$;

-- Las preguntas nuevas entran en el pack de test (el de supuestos no cambia)
insert into public.product_items (product_id, position, question_id)
select p.id, (select coalesce(max(position), 0) from public.product_items where product_id = p.id)
             + row_number() over (order by t.slug, q.created_at), q.id
  from public.products p
  join public.topics t on t.slug like 'pcat-%' and t.slug not like 'pcatsup-%'
  join public.questions q on q.topic_id = t.id and q.locale = 'ca' and q.is_test = false
                         and q.status = 'published'
 where p.slug = 'pcat-coneixements-2026'
   and not exists (select 1 from public.product_items i where i.product_id = p.id and i.question_id = q.id);

commit;
