-- =====================================================================
-- 1800 · Cobros con Stripe (STO-008, BIZ-002/003)
--
-- La app nunca toca tarjetas: el pago ocurre en Stripe Checkout y Stripe
-- avisa por webhook firmado. El servidor (service_role) traduce cada aviso
-- en pedidos, concesiones y suscripciones con estas funciones, todas
-- idempotentes: el mismo aviso repetido no duplica nada.
--
--  * billing_customers: cliente de Stripe de cada alumno (test y real aparte).
--  * billing_events: avisos de Stripe ya procesados (auditoría + reintentos).
--  * billing_record_payment(): pago único → pedido pagado + concesión.
--  * billing_refund_payment(): reembolso total → pedido reembolsado + acceso retirado.
--  * billing_sync_subscription(): estado de Premium tal y como lo tiene Stripe.
--
-- Nada de esto es accesible con el JWT del alumno: solo service_role.
-- =====================================================================

create table public.billing_customers (
  user_id uuid not null references auth.users (id) on delete cascade,
  provider text not null check (provider in ('stripe_test', 'stripe')),
  customer_ref text not null unique,
  created_at timestamptz not null default now(),
  primary key (user_id, provider)
);

create table public.billing_events (
  id text primary key,
  type text not null,
  livemode boolean not null,
  received_at timestamptz not null default now()
);

alter table public.billing_customers enable row level security;
alter table public.billing_events enable row level security;
revoke all on public.billing_customers, public.billing_events from anon, authenticated;

-- ---------------------------------------------------------------------
-- Pago único (packs, simulacros, pack completo)
-- ---------------------------------------------------------------------
create or replace function public.billing_record_payment(
  p_user uuid, p_product uuid, p_price uuid, p_ref text, p_amount integer,
  p_currency text, p_provider text)
returns uuid
language plpgsql security definer set search_path = '' as $$
declare
  v_order uuid;
begin
  if p_provider not in ('stripe_test', 'stripe') then
    raise exception 'Proveedor no válido' using errcode = '22023';
  end if;
  -- idempotente: el mismo pago (payment_intent) solo crea un pedido
  select id into v_order from public.orders where provider_ref = p_ref;
  if v_order is not null then
    return v_order;
  end if;
  if not exists (select 1 from public.products where id = p_product and type <> 'subscription') then
    raise exception 'Producto no válido para pago único' using errcode = '22023';
  end if;
  if not exists (select 1 from auth.users where id = p_user) then
    raise exception 'Usuario no encontrado' using errcode = '22023';
  end if;
  insert into public.orders (user_id, status, currency, total_cents, provider, provider_ref, paid_at)
  values (p_user, 'paid', upper(p_currency), p_amount, p_provider, p_ref, now())
  returning id into v_order;
  insert into public.order_items (order_id, product_id, price_id, amount_cents)
  values (v_order, p_product,
          (select id from public.product_prices where id = p_price and product_id = p_product),
          p_amount);
  insert into public.access_grants (user_id, product_id, source, order_id)
  values (p_user, p_product, 'purchase', v_order);
  return v_order;
end $$;

create or replace function public.billing_refund_payment(p_ref text)
returns boolean
language plpgsql security definer set search_path = '' as $$
declare
  v_order uuid;
begin
  update public.orders set status = 'refunded'
   where provider_ref = p_ref and status <> 'refunded'
  returning id into v_order;
  if v_order is null then
    return false;
  end if;
  update public.access_grants set revoked_at = now()
   where order_id = v_order and revoked_at is null;
  return true;
end $$;

-- ---------------------------------------------------------------------
-- Suscripción (Premium)
-- ---------------------------------------------------------------------
create or replace function public.billing_sync_subscription(
  p_user uuid, p_product uuid, p_price uuid, p_ref text, p_status public.subscription_status,
  p_period_end timestamptz, p_cancel_at_period_end boolean, p_provider text)
returns uuid
language plpgsql security definer set search_path = '' as $$
declare
  v_id uuid;
begin
  if p_provider not in ('stripe_test', 'stripe') then
    raise exception 'Proveedor no válido' using errcode = '22023';
  end if;
  if not exists (select 1 from public.products where id = p_product and type = 'subscription') then
    raise exception 'Producto no válido para suscripción' using errcode = '22023';
  end if;
  insert into public.subscriptions (user_id, product_id, price_id, status, current_period_end,
                                    cancel_at_period_end, provider, provider_ref)
  values (p_user, p_product,
          (select id from public.product_prices where id = p_price and product_id = p_product),
          p_status, p_period_end, p_cancel_at_period_end, p_provider, p_ref)
  on conflict (provider_ref) do update
     set status = excluded.status,
         current_period_end = excluded.current_period_end,
         cancel_at_period_end = excluded.cancel_at_period_end,
         price_id = coalesce(excluded.price_id, public.subscriptions.price_id)
  returning id into v_id;
  return v_id;
end $$;

revoke execute on function public.billing_record_payment(uuid, uuid, uuid, text, integer, text, text)
  from public, anon, authenticated;
revoke execute on function public.billing_refund_payment(text) from public, anon, authenticated;
revoke execute on function public.billing_sync_subscription(uuid, uuid, uuid, text,
  public.subscription_status, timestamptz, boolean, text) from public, anon, authenticated;
grant execute on function public.billing_record_payment(uuid, uuid, uuid, text, integer, text, text)
  to service_role;
grant execute on function public.billing_refund_payment(text) to service_role;
grant execute on function public.billing_sync_subscription(uuid, uuid, uuid, text,
  public.subscription_status, timestamptz, boolean, text) to service_role;
grant select, insert on public.billing_customers, public.billing_events to service_role;
