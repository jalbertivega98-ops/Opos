-- Publica en la PREVIEW lo nuevo de Auxiliar Administrativo del Estado (temas I.6 y I.10 y Bloque II).
-- Lo pidió joel expresamente (hilo «Elegir y montar la siguiente oposición», 04/11/2026):
-- «Una vez tengas todos los puntos, súbelos y publícalos» y, para la ampliación, «Sigue y sube todo». Equivale a pulsar, como titular,
-- «Aprobar lote» + «Publicar» en cada tema age-aux-*, publicar sus fichas y sus productos.
--
-- * Las preguntas DUDOSAS (con nota de revisión) NO se publican: quedan en borrador
--   para que joel las mire en /admin/revision/fuentes.
-- * Cada cambio pasa por el guardián de estados y queda en la auditoría a nombre de la
--   persona titular, con el comentario de este archivo.
-- * Solo toca contenido age-aux-*; Mossos no cambia. Idempotente.
-- Requiere 12- a 14- y 16-. Las dudosas siguen fuera hasta que joel las revise.
begin;

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

  for v_slug in select slug from public.topics where slug like 'age-aux-%' order by slug loop
    perform public.review_topic_batch(v_slug, 'approved', false);
    v_q := v_q + public.review_topic_batch(v_slug, 'published', false);
    perform public.review_topic_notes(v_slug, 'approved');
    v_n := v_n + public.review_topic_notes(v_slug, 'published');
  end loop;

  with pub as (
    update public.products p set status = 'published'
     where p.status = 'draft' and p.is_test = false and p.slug like 'age-aux-%'
       and (p.type <> 'question_pack'
            or exists (select 1 from public.product_items i join public.questions q on q.id = i.question_id
                        where i.product_id = p.id and q.status = 'published'))
       and (p.type <> 'mock_exam' or p.config->>'kind' = 'psycho'
            or (select count(*) from public.mock_pool(p.id)) >= (public.mock_config(p.config)->>'questions')::int)
    returning 1)
  select count(*) into v_p from pub;

  perform public.open_exams_with_content();
  perform public.log_admin_action('content.publish_exam', 'exam_bodies', 'auxiliar-administrativo-estado',
    jsonb_build_object('questions', v_q, 'notes', v_n, 'products', v_p,
                       'motivo', 'Petición expresa de joel en el hilo del proyecto (04/11/2026, ampliación)'));
  perform set_config('request.jwt.claims', '', true);
  raise notice 'Auxiliar del Estado: % preguntas, % fichas y % productos publicados', v_q, v_n, v_p;
end $$;

commit;
