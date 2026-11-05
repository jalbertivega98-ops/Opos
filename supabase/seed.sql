-- =====================================================================
-- Datos iniciales del catálogo (idempotente).
-- Solo nombres de organismos y cuerpos públicos. NO incluye convocatorias,
-- fechas, plazas, requisitos ni URLs: se añadirán desde administración
-- con fuentes oficiales verificadas (ver docs/CONTENT_POLICY.md).
-- Todas las oposiciones arrancan como 'coming_soon' (próxima incorporación).
-- =====================================================================

insert into public.regions (slug, name, level) values
  ('espana', 'España', 'estatal'),
  ('catalunya', 'Cataluña', 'autonomico'),
  ('comunidad-de-madrid', 'Comunidad de Madrid', 'autonomico')
on conflict (slug) do nothing;

insert into public.regions (slug, name, level, parent_id)
select 'barcelona', 'Barcelona', 'local', id from public.regions where slug = 'catalunya'
on conflict (slug) do nothing;

insert into public.organizations (slug, name, scope, region_id)
select v.slug, v.name, v.scope::public.scope_level, r.id
from (values
  ('direccion-general-policia', 'Dirección General de la Policía', 'estatal', 'espana'),
  ('direccion-general-guardia-civil', 'Dirección General de la Guardia Civil', 'estatal', 'espana'),
  ('instituciones-penitenciarias', 'Secretaría General de Instituciones Penitenciarias', 'estatal', 'espana'),
  ('administracion-general-estado', 'Administración General del Estado', 'estatal', 'espana'),
  ('administracion-justicia', 'Administración de Justicia', 'estatal', 'espana'),
  ('correos', 'Correos', 'estatal', 'espana'),
  ('generalitat-interior', 'Generalitat de Catalunya · Interior', 'autonomico', 'catalunya'),
  ('generalitat-justicia', 'Generalitat de Catalunya · Justícia', 'autonomico', 'catalunya'),
  ('ajuntament-barcelona', 'Ajuntament de Barcelona', 'local', 'barcelona'),
  ('ayuntamientos', 'Ayuntamientos (varios)', 'local', 'espana')
) as v(slug, name, scope, region_slug)
join public.regions r on r.slug = v.region_slug
on conflict (slug) do nothing;

insert into public.exam_bodies
  (slug, organization_id, name, name_ca, short_description, short_description_ca, category, availability, is_published, sort_order)
select v.slug, o.id, v.name, v.name_ca, v.descr, v.descr_ca, v.category::public.exam_category,
       'coming_soon', true, v.sort_order
from (values
  ('mossos-esquadra', 'generalitat-interior', 'Mossos d''Esquadra', 'Mossos d''Esquadra',
   'Policía de Cataluña. Escala básica.', 'Policia de Catalunya. Escala bàsica.', 'seguridad', 10),
  ('policia-nacional-basica', 'direccion-general-policia', 'Policía Nacional · Escala Básica', 'Policia Nacional · Escala Bàsica',
   'Acceso a la categoría de policía.', 'Accés a la categoria de policia.', 'seguridad', 20),
  ('guardia-civil-cabos-guardias', 'direccion-general-guardia-civil', 'Guardia Civil · Cabos y Guardias', 'Guàrdia Civil · Cabos i Guàrdies',
   'Acceso a la escala de cabos y guardias.', 'Accés a l''escala de caporals i guàrdies.', 'seguridad', 30),
  ('guardia-urbana-barcelona', 'ajuntament-barcelona', 'Guardia Urbana de Barcelona', 'Guàrdia Urbana de Barcelona',
   'Policía local de Barcelona.', 'Policia local de Barcelona.', 'seguridad', 40),
  ('policia-local', 'ayuntamientos', 'Policías locales', 'Policies locals',
   'Convocatorias municipales de policía local.', 'Convocatòries municipals de policia local.', 'seguridad', 50),
  ('bombers-generalitat', 'generalitat-interior', 'Bombers de la Generalitat', 'Bombers de la Generalitat',
   'Bomberos de Cataluña.', 'Bombers de Catalunya.', 'emergencias', 60),
  ('ayudantes-instituciones-penitenciarias', 'instituciones-penitenciarias', 'Ayudantes de Instituciones Penitenciarias', 'Ajudants d''Institucions Penitenciàries',
   'Cuerpo de Ayudantes de IIPP.', 'Cos d''Ajudants d''IIPP.', 'penitenciaria', 70),
  ('serveis-penitenciaris-catalunya', 'generalitat-justicia', 'Prisiones de Cataluña · Servicios Penitenciarios', 'Presons de Catalunya · Serveis Penitenciaris',
   'Cuerpo técnico de especialistas de la Generalitat, escala de servicios penitenciarios (C1).', 'Cos tècnic d''especialistes de la Generalitat, escala de serveis penitenciaris (C1).', 'penitenciaria', 75),
  ('auxiliar-administrativo-estado', 'administracion-general-estado', 'Auxiliar Administrativo del Estado', 'Auxiliar Administratiu de l''Estat',
   'Cuerpo General Auxiliar de la AGE.', 'Cos General Auxiliar de l''AGE.', 'administracion', 80),
  ('administrativo-estado', 'administracion-general-estado', 'Administrativo del Estado', 'Administratiu de l''Estat',
   'Cuerpo General Administrativo de la AGE.', 'Cos General Administratiu de l''AGE.', 'administracion', 90),
  ('tramitacion-procesal', 'administracion-justicia', 'Tramitación Procesal y Administrativa', 'Tramitació Processal i Administrativa',
   'Cuerpo de Justicia.', 'Cos de Justícia.', 'justicia', 100),
  ('auxilio-judicial', 'administracion-justicia', 'Auxilio Judicial', 'Auxili Judicial',
   'Cuerpo de Justicia.', 'Cos de Justícia.', 'justicia', 110),
  ('correos-personal-laboral', 'correos', 'Correos · Personal laboral', 'Correus · Personal laboral',
   'Ingreso de personal laboral fijo.', 'Ingrés de personal laboral fix.', 'correos', 120)
) as v(slug, org_slug, name, name_ca, descr, descr_ca, category, sort_order)
join public.organizations o on o.slug = v.org_slug
on conflict (slug) do nothing;
