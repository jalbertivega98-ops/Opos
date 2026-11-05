-- Nueva oposición: prisiones de la Generalitat de Catalunya (cos tècnic d'especialistes, escala de serveis
-- penitenciaris, grupo C1). No es la de Ayudantes de Instituciones Penitenciarias del Estado: en Cataluña las
-- prisiones están transferidas (RD 3482/1983) y el personal es funcionario de la Generalitat.
-- Convocatoria de referencia: JU033 (Resolució JUS/2335/2025, DOGC 9439, 23/06/2025). OOP 2026 (Acord
-- GOV/61/2026): 133 plazas pendientes de convocar. Fuentes en docs/research/prisiones-catalunya-programa.md.
-- Arranca como «próximamente»: pasa a «disponible» al publicar su temario (40-). Idempotente.
begin;

insert into public.organizations (slug, name, scope, region_id)
select 'generalitat-justicia', 'Generalitat de Catalunya · Justícia', 'autonomico'::public.scope_level, r.id
  from public.regions r where r.slug = 'catalunya'
on conflict (slug) do nothing;

insert into public.exam_bodies
  (slug, organization_id, name, name_ca, short_description, short_description_ca, category, availability,
   is_published, sort_order)
select 'serveis-penitenciaris-catalunya', o.id,
       'Prisiones de Cataluña · Servicios Penitenciarios', 'Presons de Catalunya · Serveis Penitenciaris',
       'Cuerpo técnico de especialistas de la Generalitat, escala de servicios penitenciarios (C1).',
       'Cos tècnic d''especialistes de la Generalitat, escala de serveis penitenciaris (C1).',
       'penitenciaria'::public.exam_category, 'coming_soon', true, 75
  from public.organizations o where o.slug = 'generalitat-justicia'
on conflict (slug) do nothing;

commit;
