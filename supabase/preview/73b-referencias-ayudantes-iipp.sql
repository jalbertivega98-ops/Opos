-- Ayudantes IIPP: corrige el artículo citado en dos preguntas y las deja publicadas.
-- joel pidió «dejalo todo conforme deba de ir» (hilo del proyecto, 11/11/2026) tras avisarle de las dos referencias:
-- * A07 (Enfermería): el texto citado es del art. 312.c) RP 1981, no del 311.
-- * C17 (sustituto en la Junta Económico-Administrativa): es el art. 278.3 RP; se quita la nota de duda.
-- Respuestas, opciones y citas literales no cambian. Una pregunta publicada vuelve a revisión, se corrige y se
-- publica otra vez como titular. Busca por la huella antigua: idempotente. Requiere 54- y 55-.
begin;

do $$
declare
  v_owner uuid;
  r record;
  v_n int := 0;
begin
  select id into v_owner from public.profiles
   where role = 'owner' and status = 'active' order by created_at limit 1;
  if v_owner is null then
    raise notice 'No hay persona titular: no se corrige nada.';
    return;
  end if;
  perform set_config('request.jwt.claims',
    json_build_object('sub', v_owner, 'role', 'authenticated')::text, true);

  for r in
    select q.id, q.status, v.*
      from (values
        ('9e754a5fe6247c0a624b7bdf59747df9fb824cca1164e852e8c8c047437a739f',
         '5b2ff2b52a758ef185ee0b395da3d637ec5ce178ef8b3bc4def3695b1dcd1a41',
         'Art. 312 RP 1981',
         'Según el artículo 312 del Reglamento Penitenciario de 1981, corresponde al funcionario de servicio en Enfermería, además de las obligaciones de los encargados de galería:',
         'El art. 312.c) RP 1981 recoge esa obligación.'),
        ('43fb92538ac7c48e2aa20b119365a9a260d3d23dc25519d5c612ae9dfb09ec3c',
         'c8f6238197184867b46bfdee6ce76bc24e09010003e10ba16a485ef3d0ff965e',
         'Art. 278.3 RP',
         'Según el artículo 278 del Reglamento Penitenciario, el Presidente de la Junta Económico-Administrativa es sustituido en su ausencia por:',
         'La regla general del art. 269.1.1.ª RP (mayor jerarquía, antigüedad y edad) se exceptúa para la Junta Económico-Administrativa, cuyo sustituto es el Administrador (art. 278.3 RP).')
      ) as v(old_hash, new_hash, ref, stem, explanation)
      join public.questions q on q.content_hash = v.old_hash and q.locale = 'es' and q.is_test = false
  loop
    if r.status in ('published', 'approved', 'archived') then
      update public.questions set status = 'needs_review' where id = r.id;
    end if;
    update public.questions
       set stem = r.stem, explanation = r.explanation, source_ref = r.ref,
           review_note = null, content_hash = r.new_hash
     where id = r.id;
    if r.status = 'draft' then
      update public.questions set status = 'needs_review' where id = r.id;
    end if;
    update public.questions set status = 'approved' where id = r.id;
    update public.questions set status = 'published' where id = r.id;
    v_n := v_n + 1;
  end loop;

  if v_n > 0 then
    perform public.log_admin_action('content.fix_questions', 'exam_bodies',
      'ayudantes-instituciones-penitenciarias',
      jsonb_build_object('questions', v_n,
                         'motivo', 'Referencia de artículo corregida a petición de joel (11/11/2026)'));
  end if;
  perform set_config('request.jwt.claims', '', true);
  raise notice 'Ayudantes IIPP: % preguntas corregidas y publicadas', v_n;
end $$;

commit;
