-- Nuevas oposiciones: las 23 preguntas dudosas, verificadas y publicadas.
-- joel pidió «Sube todo y verifica las dudosas» (hilo «Preparar temarios de nuevas oposiciones», 05/11/2026).
-- Cada duda se comprobó contra el texto consolidado vigente del BOE: RD 240/2007 sin cambios desde 2015;
-- LO 1/2026 (Código Penal) en vigor desde el día siguiente a su publicación; Ley 4/2026 (dependencia) en
-- vigor el 1/11/2026; equivalencias de grupos (disp. trans. 3.ª TREBEP); LO 1/2025 (disp. adic. 1.ª) para
-- las denominaciones de juzgados; RD 796/2005 art. 22.1; RD 725/1989 art. 6.3. Se añade a la explicación la
-- aclaración que motivaba la duda, se quita la nota de revisión y se publica como en 29-.
-- Idempotente. Requiere 25- a 29-.
begin;

update public.questions q
   set explanation = v.explanation, review_note = null
  from (values
  ('46391765eaa27fd3eb1842d8af3fbb47d252fb883f28b9a797ce09103e45e2de', 'La disposición adicional novena del RD 364/1995 permite suplir la titulación con diez años de antigüedad en el Grupo D, o con cinco años más un curso específico de formación al que se accede por criterios objetivos. El RD 364/1995 usa la clasificación anterior al TREBEP: según su disposición transitoria tercera, el antiguo Grupo C equivale hoy al Subgrupo C1 y el Grupo D al Subgrupo C2.'),
  ('021706e05dc888b51fbcbbb985e3b9618e497714a5048d902da86ed47873c90c', 'El art. 16.4 de la Ley 53/1984 fija el límite en el 30 % de la retribución básica, sin computar los conceptos derivados de la antigüedad, y mantiene las limitaciones de los arts. 1.3, 11, 12 y 13. La nueva redacción del art. 16.1 (disp. final 3.ª TREBEP) solo surtirá efectos con las leyes de Función Pública de desarrollo (disp. final 4.ª TREBEP); hasta entonces rige el texto citado.'),
  ('5f9d3198cfdc435f8003cb79ce909ec08da78ff6e3f7414f6bb30da1cc34d3ff', 'El art. 5.1 configura MUFACE como organismo público con personalidad jurídica diferenciada, patrimonio y tesorería propios y autonomía de gestión, al que se aplican las previsiones de los organismos autónomos. El precepto remite aún a la Ley 6/1997 (LOFAGE), derogada por la Ley 40/2015; la configuración de MUFACE como organismo autónomo no cambia.'),
  ('89ca5b9dbea9f4f12c21690206a26c02b12110ae97615becdb4e8649b08c900a', 'El art. 6.1 del RD 725/1989 exige cheques nominativos o transferencias con firmas mancomunadas; la tarjeta bancaria solo cabe de manera excepcional y justificada (art. 6.3). El régimen ordinario sigue siendo el del art. 6.1; la tarjeta bancaria (art. 6.3, añadido por el RD 813/2026) es un medio excepcional en los términos de una Orden ministerial.'),
  ('c7515a4374b14556f7d6f65bfb7ed9f1c7c93425e552fa8de29acfcfc965043f', 'El art. 38.2 LGS fija como interés de demora el interés legal del dinero incrementado en un 25 %, salvo que la Ley de Presupuestos establezca otro. La Ley de Presupuestos de cada ejercicio suele fijar el tipo concreto; la pregunta recoge la regla supletoria de la LGS.'),
  ('98d60922686484009a28376033ea83f65189b27739ec6f318284540065491428', 'El art. 77 del RD 1451/2005 atribuye la resolución de la rehabilitación al Ministro de Justicia y su instrucción a la Secretaría de Estado de Justicia, a través de la Dirección General de Relaciones con la Administración de Justicia. Son las denominaciones que conserva el reglamento; los nombres del Ministerio y de la Dirección General han cambiado con las reestructuraciones posteriores.'),
  ('6a03db8b96cf7ace557488cb5e1c1860fecb5827e1e69812ed2f8262255de453', 'El art. 511.3.b) LOPJ limita a seis meses la suspensión provisional acordada por la autoridad que ordenó la incoación del expediente, salvo paralización imputable al interesado. Para el personal de los Cuerpos Generales, el art. 22.1 del RD 796/2005 mantiene seis meses para la falta muy grave y lo reduce a tres meses para la falta grave.'),
  ('fbedee234c14cdc48655a8cbed3b59823adca1784ec9bf79973547e59875ff3f', 'El art. 7.2 del RDL 17/1977 califica de actos ilícitos o abusivos las huelgas rotatorias, las de sectores estratégicos para interrumpir el proceso productivo, las de celo o reglamento y cualquier alteración colectiva distinta de la huelga. La STC 11/1981 no anuló el precepto, pero lo interpretó en el sentido de que estas modalidades se presumen abusivas salvo prueba en contrario.'),
  ('a543037d1449837efeedcd6ce421e6e13f2bcbade3ef20b718865605cc45d6f5', 'El art. 172 LECrim ordena entregar la cédula al pariente, familiar o criado mayor de catorce años que se halle en el domicilio y, si no hay nadie, a uno de los vecinos más próximos. El art. 166 LECrim remite además, para practicar las notificaciones, a la forma prevista en la LEC; la regla del art. 172 sigue en el texto vigente.'),
  ('7b3d1e449c86e39693bb4d9696c6a4ad94d21a6eb2f7b0c62af3a9ad1ffcc733', 'El art. 85.1 LRC fija un mes para recurrir ante la Dirección General las decisiones de los Encargados. El precepto aún nombra a la «Dirección General de los Registros y del Notariado», hoy Dirección General de Seguridad Jurídica y Fe Pública.'),
  ('5adaeec0bd5515261572e49bcd81dbe528963d0fe0f35799b0e2a16c1fa7664c', 'El art. 216 LECrim enumera los recursos de reforma, apelación y queja frente a las resoluciones del Juez de Instrucción. Tras la LO 1/2025 (disp. adic. 1.ª), las menciones a los Juzgados de Instrucción se entienden hechas a las Secciones de Instrucción de los Tribunales de Instancia.'),
  ('c25e2e02fb744490fe4d3ce31f78ddc74b6fd1c6f2ac70d8092cef32ddf31d76', 'El art. 790.1 LECrim atribuye la apelación de las sentencias del Juez de lo Penal a la Audiencia Provincial (y las del Juez Central de lo Penal a la Sala de lo Penal de la Audiencia Nacional), con un plazo de diez días. Tras la LO 1/2025 (disp. adic. 1.ª), las menciones a los Juzgados de lo Penal se entienden hechas a las Secciones de lo Penal de los Tribunales de Instancia.'),
  ('c206e9a5a63e5d688ab726128410d5e7fc2b0dd1f1f8f4edbe300005d2baf270', 'El art. 6.1 RD 240/2007 solo exige pasaporte o documento de identidad en vigor para estancias inferiores a tres meses, que no computan a efectos de residencia.'),
  ('aa8fdbb36ba69fc56c9730263dc5efada6866a611a3a84a49159db76b87fa955', 'El art. 7.5 RD 240/2007 fija tres meses desde la entrada para solicitar personalmente la inscripción ante la oficina de extranjeros o, en su defecto, la Comisaría de Policía; el certificado de registro se expide de forma inmediata.'),
  ('00f73f2e6bf5776a5b29cdebad39b68687ab2f734b9b9e135bbc2f08853a7b33', 'El art. 8.5 RD 240/2007 fija cinco años de validez, o el período previsto de residencia del ciudadano de la Unión si fuera inferior.'),
  ('6d84c1e51dbf2650f3683990a8d7db9aa72119a20382a35c1ca3782b81c2e73a', 'El art. 10.1 RD 240/2007 exige cinco años de residencia legal continuada; el derecho se pierde por ausencia del territorio español durante más de dos años consecutivos (art. 10.7).'),
  ('6a83cacb8ff130db42c19b82e37f0b506621b176f5a63fe6470032e222e8f66c', 'El art. 234.2 CP castiga el hurto de hasta 400 euros con multa de uno a tres meses, pero impone la pena del apartado 1 si el culpable tiene al menos tres condenas ejecutorias por delitos de la misma naturaleza de este Título y al menos una es leve; no se computan los antecedentes cancelados. Redacción dada por la LO 1/2026, de 8 de abril (multirreincidencia), en vigor desde el día siguiente a su publicación.'),
  ('6fcdc6233bed44631b4629612aea8cecdeed1382ff5ad5d950ed513482d3d2be', 'El art. 235.1.10.º CP incluye entre los hurtos agravados la sustracción de teléfonos móviles y otros dispositivos móviles de comunicación o almacenamiento de datos personales, excluidos los que están a la venta, en almacén o en exposición en comercios. El numeral 10.º lo añadió la LO 1/2026, de 8 de abril, en vigor desde el día siguiente a su publicación.'),
  ('dd13fcc25c0595c9b35a47f61389a99fafced9653755d19fee34cb862fac8e80', 'El art. 248 CP define la estafa por el engaño bastante que produce error e induce a un acto de disposición perjudicial; las otras conductas son la apropiación indebida (art. 253) y la extorsión (art. 243).'),
  ('54edc242d9de92f94c5ecb3e31b0777692d42960f5e83c000efbc9cc675defc8', 'El art. 88.1.a) LOPJ, en la redacción dada por la LO 1/2025 (Tribunales de Instancia), atribuye a las Secciones de Instrucción y a las Secciones Únicas la instrucción de estas causas, salvo las que correspondan a las Secciones de Violencia sobre la Mujer o de Violencia contra la Infancia y la Adolescencia. También conocen, entre otras materias, de los juicios por delito leve y del habeas corpus. Antes de la LO 1/2025 eran los Juzgados de Instrucción, denominación que aún usan otras leyes del temario.'),
  ('27eb41238a98e677ae2f1fe3fb3659f20b8d3dce0eee63e37723ba55744e08b8', 'El art. 24.1.a) EVD atribuye la decisión en fase de investigación al Juez de Instrucción o de Violencia sobre la Mujer; el Fiscal y la policía pueden hacer una evaluación y adoptar medidas provisionales. En la fase de enjuiciamiento corresponde al Juez o Tribunal de la causa. La Ley 4/2015 conserva esas denominaciones; tras la LO 1/2025 son Secciones de los Tribunales de Instancia.'),
  ('74c870a798e06b5466af0f79df7da5026c3f272d2933468759aca6803197931a', 'El art. 26.1 de la Ley 39/2006 clasifica la dependencia en Grado I (moderada), Grado II (severa) y Grado III (gran dependencia).'),
  ('c896ae8746080608148d5a0914a87a1b158ecc297b2dc4a9124a64b3f83795c0', 'El art. 28.1 de la Ley 39/2006 fija un plazo máximo de 3 meses para resolver el procedimiento, que se inicia a instancia de la persona interesada o de su representante. Redacción vigente tras la Ley 4/2026, de 1 de octubre.')
  ) as v(content_hash, explanation)
 where q.content_hash = v.content_hash and q.locale = 'es' and q.is_test = false
   and q.status in ('draft', 'needs_review')
   and (q.explanation is distinct from v.explanation or q.review_note is not null);

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
                 where slug like 'age-adm-%' or slug like 'jus-%' or slug like 'justra-%' or slug like 'pn-%'
                 order by slug loop
    perform public.review_topic_batch(v_slug, 'approved', false);
    v_q := v_q + public.review_topic_batch(v_slug, 'published', false);
    perform public.review_topic_notes(v_slug, 'approved');
    v_n := v_n + public.review_topic_notes(v_slug, 'published');
  end loop;

  with pub as (
    update public.products p set status = 'published'
     where p.status = 'draft' and p.is_test = false
       and (p.slug like 'age-adm-%' or p.slug like 'jus-%' or p.slug like 'pn-%')
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
       and (p.slug like 'age-adm-%' or p.slug like 'jus-%' or p.slug like 'pn-%')
       and exists (select 1 from public.product_items i join public.products c on c.id = i.child_product_id
                    where i.product_id = p.id and c.status = 'published')
    returning 1)
  select v_p + count(*) into v_p from pub;

  perform public.open_exams_with_content();
  perform public.log_admin_action('content.publish_exam', 'exam_bodies',
    'administrativo-estado, auxilio-judicial, tramitacion-procesal, policia-nacional-basica',
    jsonb_build_object('questions', v_q, 'notes', v_n, 'products', v_p,
                       'motivo', 'Petición expresa de joel en el hilo del proyecto (05/11/2026, dudosas verificadas)'));
  perform set_config('request.jwt.claims', '', true);
  raise notice 'Nuevas oposiciones: % preguntas, % fichas y % productos publicados', v_q, v_n, v_p;
end $$;

commit;
