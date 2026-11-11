-- Publica en la PREVIEW la ampliación a 40 preguntas por tema de Policía local de Cataluña (85-) y de
-- Auxiliar Administrativo del Estado (85a-). Lo aprobó joel (11/11/2026): «al final tenemos el contenido, solo
-- tenemos que generar preguntas y simulacros nosotros. dale adelante».
-- Equivale a «Aprobar lote» + «Publicar» como titular en los temas plcat-t*, age-aux-b1-* y age-aux-b2-*.
-- * Las preguntas DUDOSAS (con nota de revisión) NO se publican: quedan en borrador para joel.
-- * Los simulacros toman las preguntas por prefijo de tema, así que las nuevas entran solas.
-- * Las nuevas publicadas entran en los packs de test por prefijo (también lo hace el trigger questions_autopack).
-- Idempotente. Requiere 52- a 56- (Policía local), 12- a 17- (Auxiliar), 85- y 85a-.
begin;

do $$
declare
  v_owner uuid;
  v_slug text;
  v_q int := 0;
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
                 where slug like 'plcat-t%' or slug like 'age-aux-b1-%' or slug like 'age-aux-b2-%'
                 order by slug loop
    perform public.review_topic_batch(v_slug, 'approved', false);
    v_q := v_q + public.review_topic_batch(v_slug, 'published', false);
  end loop;

  perform public.log_admin_action('content.publish_exam', 'exam_bodies',
    'policia-local,auxiliar-administrativo-estado',
    jsonb_build_object('questions', v_q,
                       'motivo', 'Ampliación a 40 preguntas por tema aprobada por joel (11/11/2026: «dale adelante»)'));
  perform set_config('request.jwt.claims', '', true);
  raise notice 'Ampliación Policía local + Auxiliar: % preguntas publicadas', v_q;
end $$;

-- Las preguntas publicadas entran en los packs de test cuyo prefijo de tema las cubre
insert into public.product_items (product_id, position, question_id)
select p.id, (select coalesce(max(position), 0) from public.product_items where product_id = p.id)
             + row_number() over (partition by p.id order by t.slug, q.created_at), q.id
  from public.products p
  join public.topics t on t.slug like (p.config->>'topic_prefix') || '%'
  join public.questions q on q.topic_id = t.id and q.is_test = false and q.status = 'published'
                         and q.locale::text = coalesce(p.config->>'locale', q.locale::text)
 where p.type = 'question_pack' and p.is_test = false
   and p.slug in ('plcat-temari-2026', 'age-aux-bloque-1-boe-2026', 'age-aux-bloque-2-2026')
   and not exists (select 1 from public.product_items i where i.product_id = p.id and i.question_id = q.id);

commit;
