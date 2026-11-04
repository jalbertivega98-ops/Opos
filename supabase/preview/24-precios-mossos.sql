-- Precios de Mossos elegidos por joel (2026-11-04, opción «Estándar»):
--   Premium 14,99 €/mes · pack completo 59 € · cada àmbit 19 € · cada simulacro 9 €.
-- Publica Premium para que se pueda contratar (en modo de pruebas mientras la
-- clave de Stripe sea sk_test_). Idempotente: conserva el histórico de precios y
-- solo cambia un precio si es distinto. Se editan después en /admin/productos.
begin;

create temporary table wanted_prices (slug text, amount_cents int, billing_interval text) on commit drop;
insert into wanted_prices values
  ('premium', 1499, 'month'),
  ('mossos-pack-complet-2026', 5900, null),
  ('mossos-ambit-a-guia-2026', 1900, null),
  ('mossos-ambit-b-guia-2026', 1900, null),
  ('mossos-ambit-c-guia-2026', 1900, null),
  ('mossos-simulacre-coneixements-2026', 900, null),
  ('mossos-simulacre-aptituds-2026', 900, null);

-- Solo los que cambian: se retira el precio vigente y se crea el nuevo
create temporary table changed_prices on commit drop as
select p.id as product_id, w.amount_cents, w.billing_interval
  from wanted_prices w join public.products p on p.slug = w.slug
 where not exists (select 1 from public.product_prices pr
                    where pr.product_id = p.id and pr.active
                      and pr.billing_interval is not distinct from w.billing_interval
                      and pr.amount_cents = w.amount_cents);

update public.product_prices pr set active = false
  from changed_prices c
 where pr.product_id = c.product_id and pr.active
   and pr.billing_interval is not distinct from c.billing_interval;

insert into public.product_prices (product_id, amount_cents, billing_interval)
select product_id, amount_cents, billing_interval from changed_prices;

update public.products set status = 'published', published_at = coalesce(published_at, now())
 where slug = 'premium' and status = 'draft';

commit;
