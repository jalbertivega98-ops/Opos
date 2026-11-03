-- =====================================================================
-- Aprobia · PREVIEW PRIVADA · paso 2/2: cuenta titular y pack de PRUEBA
-- Antes: crea en Authentication › Users › Add user › Create new user
--   admin@aprobia.test y alumna@aprobia.test (marca «Auto Confirm User»).
-- Después pega esto en el SQL Editor y pulsa Run. Es idempotente.
-- =====================================================================
do $$
declare
  v_owner uuid;
  v_product uuid;
  r record;
begin
  select id into v_owner from auth.users where lower(email) = 'admin@aprobia.test';
  if v_owner is null then
    raise exception 'Crea primero el usuario admin@aprobia.test en Authentication › Users';
  end if;
  if not exists (select 1 from auth.users where lower(email) = 'alumna@aprobia.test') then
    raise exception 'Crea primero el usuario alumna@aprobia.test en Authentication › Users';
  end if;

  update public.profiles set role = 'owner', display_name = 'Admin Prueba' where id = v_owner;
  update public.profiles p set display_name = 'Alumna Prueba'
    from auth.users u where u.id = p.id and lower(u.email) = 'alumna@aprobia.test';

  -- la titular de prueba aprueba y publica SOLO el contenido de prueba (is_test)
  perform set_config('request.jwt.claims', json_build_object('sub', v_owner, 'role', 'authenticated')::text, true);
  perform set_config('request.jwt.claim.sub', v_owner::text, true);
  for r in select id, status from public.questions where is_test and status <> 'published' loop
    if r.status = 'draft' then update public.questions set status = 'needs_review' where id = r.id; end if;
    if r.status in ('draft', 'needs_review') then update public.questions set status = 'approved' where id = r.id; end if;
    update public.questions set status = 'published' where id = r.id;
  end loop;

  insert into public.products (slug, type, status, title, title_ca, description, exam_body_id,
                               is_free, included_in_premium, is_test, created_by)
  values ('prueba-pack-demo', 'question_pack', 'published', '[PRUEBA] Pack de demostración',
          '[PROVA] Paquet de demostració',
          'Contenido de prueba para comprobar el recorrido del alumno. No es material de la oposición.',
          (select id from public.exam_bodies where slug = 'mossos-esquadra'), false, false, true, v_owner)
  on conflict (slug) do nothing;
  select id into v_product from public.products where slug = 'prueba-pack-demo';

  insert into public.product_items (product_id, position, question_id)
  select v_product, row_number() over (order by q.created_at), q.id
    from public.questions q where q.is_test and q.status = 'published'
  on conflict do nothing;
end $$;

select 'Listo: ' || (select count(*) from public.questions where is_test and status = 'published')
       || ' preguntas de prueba publicadas; ' || (select count(*) from public.questions where not is_test and status = 'draft')
       || ' preguntas reales en borrador.' as resultado;
