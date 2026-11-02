-- =====================================================================
-- 0800 · Tienda de productos digitales (arquitectura, SIN pagos reales)
--
-- Un único banco de preguntas alimenta todos los productos:
--   question_pack  → test interactivos con preguntas del banco
--   mock_exam      → simulacro configurado (n.º de preguntas, tiempo, puntuación)
--   pdf            → archivo generado a partir de las mismas preguntas
--   bundle         → combinación de otros productos
--   subscription   → Premium (acceso a todo lo marcado included_in_premium)
--
-- Acceso: SIEMPRE por access_grants (concesiones). Una compra, una suscripción
-- o una concesión manual de administración crean concesiones; la app solo
-- consulta has_product_access(). Stripe (modo test) se conectará más adelante
-- rellenando orders/subscriptions desde el webhook; hoy solo existen las
-- columnas de referencia (DEC-003: no se conecta ninguna cuenta).
-- =====================================================================

create type public.product_type as enum ('pdf', 'question_pack', 'mock_exam', 'bundle', 'subscription');
create type public.product_status as enum ('draft', 'published', 'archived');
create type public.order_status as enum ('pending', 'paid', 'failed', 'refunded', 'cancelled');
create type public.subscription_status as enum ('trialing', 'active', 'past_due', 'canceled', 'expired');
create type public.grant_source as enum ('purchase', 'subscription', 'admin', 'free');

create table public.products (
  id uuid primary key default gen_random_uuid(),
  slug text not null unique check (slug ~ '^[a-z0-9]+(-[a-z0-9]+)*$' and char_length(slug) <= 80),
  type public.product_type not null,
  status public.product_status not null default 'draft',
  title text not null check (char_length(title) between 3 and 160),
  title_ca text check (char_length(title_ca) between 3 and 160),
  description text check (char_length(description) <= 4000),
  description_ca text check (char_length(description_ca) <= 4000),
  exam_body_id uuid references public.exam_bodies (id) on delete set null,
  is_free boolean not null default false,
  included_in_premium boolean not null default true,
  -- configuración específica (p. ej. simulacro: {"questions":100,"minutes":90,"penalty":0.33})
  config jsonb not null default '{}'::jsonb,
  stripe_product_id text, -- preparado; vacío hasta autorización (DEC-003)
  created_by uuid references auth.users (id) on delete set null,
  published_at timestamptz,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);
create trigger products_updated_at before update on public.products
  for each row execute function public.tg_set_updated_at();

create table public.product_prices (
  id uuid primary key default gen_random_uuid(),
  product_id uuid not null references public.products (id) on delete cascade,
  currency text not null default 'EUR' check (currency ~ '^[A-Z]{3}$'),
  amount_cents integer not null check (amount_cents >= 0 and amount_cents <= 100000),
  billing_interval text check (billing_interval in ('month', 'year')), -- null = pago único
  active boolean not null default true,
  stripe_price_id text,
  created_at timestamptz not null default now()
);
create unique index product_prices_one_active on public.product_prices (product_id, coalesce(billing_interval, 'once'))
  where active;

-- Contenido de cada producto (desde el banco común)
create table public.product_items (
  id bigint generated always as identity primary key,
  product_id uuid not null references public.products (id) on delete cascade,
  position int not null default 0,
  question_id uuid references public.questions (id) on delete restrict,
  child_product_id uuid references public.products (id) on delete restrict,
  check ((question_id is not null)::int + (child_product_id is not null)::int = 1),
  check (child_product_id is distinct from product_id)
);
create unique index product_items_question on public.product_items (product_id, question_id) where question_id is not null;
create unique index product_items_child on public.product_items (product_id, child_product_id) where child_product_id is not null;

-- Archivos descargables (PDF generados del banco). Ruta en Storage privado.
create table public.product_files (
  id uuid primary key default gen_random_uuid(),
  product_id uuid not null references public.products (id) on delete cascade,
  storage_path text not null unique,
  mime_type text not null default 'application/pdf',
  size_bytes integer check (size_bytes >= 0),
  version int not null default 1,
  -- huella de las preguntas usadas (para regenerar si cambian)
  source_hash text,
  created_at timestamptz not null default now()
);

-- Los pedidos se conservan (obligaciones contables) aunque la cuenta se borre:
-- quedan desvinculados de la persona (user_id null).
create table public.orders (
  id uuid primary key default gen_random_uuid(),
  user_id uuid references auth.users (id) on delete set null,
  status public.order_status not null default 'pending',
  currency text not null default 'EUR',
  total_cents integer not null check (total_cents >= 0),
  provider text not null default 'none' check (provider in ('none', 'stripe_test', 'stripe')),
  provider_ref text unique,
  created_at timestamptz not null default now(),
  paid_at timestamptz
);
create index orders_user_idx on public.orders (user_id, created_at desc);

create table public.order_items (
  id bigint generated always as identity primary key,
  order_id uuid not null references public.orders (id) on delete cascade,
  product_id uuid not null references public.products (id) on delete restrict,
  price_id uuid references public.product_prices (id) on delete set null,
  amount_cents integer not null check (amount_cents >= 0)
);

create table public.subscriptions (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users (id) on delete cascade,
  product_id uuid not null references public.products (id) on delete restrict,
  price_id uuid references public.product_prices (id) on delete set null,
  status public.subscription_status not null,
  current_period_end timestamptz,
  cancel_at_period_end boolean not null default false,
  provider text not null default 'none' check (provider in ('none', 'stripe_test', 'stripe')),
  provider_ref text unique,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);
create index subscriptions_user_idx on public.subscriptions (user_id);
create trigger subscriptions_updated_at before update on public.subscriptions
  for each row execute function public.tg_set_updated_at();

create table public.access_grants (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users (id) on delete cascade,
  product_id uuid not null references public.products (id) on delete cascade,
  source public.grant_source not null,
  order_id uuid references public.orders (id) on delete set null,
  subscription_id uuid references public.subscriptions (id) on delete cascade,
  granted_by uuid references auth.users (id) on delete set null,
  note text check (char_length(note) <= 500),
  starts_at timestamptz not null default now(),
  ends_at timestamptz,
  revoked_at timestamptz,
  created_at timestamptz not null default now()
);
create index access_grants_user_idx on public.access_grants (user_id, product_id);

-- ---------------------------------------------------------------------
-- RLS
-- ---------------------------------------------------------------------
alter table public.products enable row level security;
alter table public.product_prices enable row level security;
alter table public.product_items enable row level security;
alter table public.product_files enable row level security;
alter table public.orders enable row level security;
alter table public.order_items enable row level security;
alter table public.subscriptions enable row level security;
alter table public.access_grants enable row level security;

-- Catálogo: publicados para todos; staff ve todo y admin edita
create policy "products: publicados" on public.products for select to anon, authenticated
  using (status = 'published' or public.is_staff());
create policy "products: admin escribe" on public.products for all to authenticated
  using (public.is_admin()) with check (public.is_admin());
create policy "prices: de productos visibles" on public.product_prices for select to anon, authenticated
  using (exists (select 1 from public.products p where p.id = product_id
                 and (p.status = 'published' or public.is_staff())));
create policy "prices: admin escribe" on public.product_prices for all to authenticated
  using (public.is_admin()) with check (public.is_admin());
-- El contenido (qué preguntas incluye) no es público
create policy "items: staff" on public.product_items for select to authenticated using (public.is_staff());
create policy "items: admin escribe" on public.product_items for all to authenticated
  using (public.is_admin()) with check (public.is_admin());
create policy "files: staff" on public.product_files for select to authenticated using (public.is_staff());
create policy "files: admin escribe" on public.product_files for all to authenticated
  using (public.is_admin()) with check (public.is_admin());

-- Datos de compra: cada alumno los suyos; administración, todos. Nadie escribe con su JWT.
create policy "orders: propios o admin" on public.orders for select to authenticated
  using (user_id = (select auth.uid()) or public.is_admin());
create policy "order_items: propios o admin" on public.order_items for select to authenticated
  using (exists (select 1 from public.orders o where o.id = order_id
                 and (o.user_id = (select auth.uid()) or public.is_admin())));
create policy "subscriptions: propias o admin" on public.subscriptions for select to authenticated
  using (user_id = (select auth.uid()) or public.is_admin());
create policy "grants: propias o admin" on public.access_grants for select to authenticated
  using (user_id = (select auth.uid()) or public.is_admin());

revoke all on public.orders, public.order_items, public.subscriptions, public.access_grants,
  public.product_items, public.product_files from anon;
revoke insert, update, delete, truncate on public.orders, public.order_items, public.subscriptions,
  public.access_grants from authenticated;
revoke insert, update, delete, truncate on public.products, public.product_prices from anon;

-- ---------------------------------------------------------------------
-- Acceso
-- ---------------------------------------------------------------------
create or replace function public.has_product_access(p_product uuid, p_user uuid default null)
returns boolean
language sql stable security definer set search_path = '' as $$
  with u as (select coalesce(p_user, auth.uid()) as id)
  select exists (
    select 1 from public.products p, u
    where p.id = p_product and p.status = 'published'
      and u.id is not null
      and (
        p.is_free
        -- concesión directa vigente
        or exists (select 1 from public.access_grants g
                    where g.user_id = u.id and g.product_id = p.id and g.revoked_at is null
                      and g.starts_at <= now() and (g.ends_at is null or g.ends_at > now()))
        -- incluido en un pack (bundle) concedido
        or exists (select 1 from public.product_items i
                     join public.access_grants g on g.product_id = i.product_id
                    where i.child_product_id = p.id and g.user_id = u.id and g.revoked_at is null
                      and g.starts_at <= now() and (g.ends_at is null or g.ends_at > now()))
        -- Premium activo
        or (p.included_in_premium and exists (
              select 1 from public.subscriptions s
               where s.user_id = u.id and s.status in ('active', 'trialing')
                 and (s.current_period_end is null or s.current_period_end > now())))
      )
  )
$$;
-- solo la propia comprobación para usuarios (p_user lo usa el servidor con service_role)
revoke execute on function public.has_product_access(uuid, uuid) from anon, public;
grant execute on function public.has_product_access(uuid, uuid) to authenticated, service_role;

-- Impide consultar el acceso de otra persona desde la API
create or replace function public.my_product_access(p_product uuid)
returns boolean language sql stable security definer set search_path = '' as $$
  select public.has_product_access(p_product, auth.uid())
$$;
revoke execute on function public.my_product_access(uuid) from anon, public;
grant execute on function public.my_product_access(uuid) to authenticated;
revoke execute on function public.has_product_access(uuid, uuid) from authenticated;

-- Biblioteca «Mis productos»
create or replace function public.my_library()
returns table (product_id uuid, slug text, type public.product_type, title text, title_ca text,
               source text, ends_at timestamptz)
language sql stable security definer set search_path = '' as $$
  with me as (select auth.uid() as id)
  select p.id, p.slug, p.type, p.title, p.title_ca,
         coalesce(g.source::text, case when p.is_free then 'free' else 'subscription' end),
         g.ends_at
    from public.products p
    cross join me
    left join lateral (
      select g.source, g.ends_at from public.access_grants g
       where g.user_id = me.id and g.product_id = p.id and g.revoked_at is null
         and g.starts_at <= now() and (g.ends_at is null or g.ends_at > now())
       order by g.created_at desc limit 1) g on true
   where me.id is not null and p.status = 'published' and p.type <> 'subscription'
     and public.has_product_access(p.id, me.id)
     and (g.source is not null
          or exists (select 1 from public.subscriptions s where s.user_id = me.id
                       and s.status in ('active', 'trialing')
                       and (s.current_period_end is null or s.current_period_end > now())))
   order by p.title
$$;
revoke execute on function public.my_library() from anon, public;
grant execute on function public.my_library() to authenticated;

-- Concesión manual (administración, auditada). No implica cobro.
create or replace function public.admin_grant_access(p_user uuid, p_product uuid, p_days int default null,
                                                     p_note text default null)
returns uuid
language plpgsql security definer set search_path = '' as $$
declare
  v_id uuid;
begin
  if not public.is_admin() then
    raise exception 'Solo administradores' using errcode = '42501';
  end if;
  if not exists (select 1 from public.products where id = p_product and status <> 'archived') then
    raise exception 'Producto no disponible' using errcode = '22023';
  end if;
  insert into public.access_grants (user_id, product_id, source, granted_by, note, ends_at)
  values (p_user, p_product, 'admin', auth.uid(), p_note,
          case when p_days is null then null else now() + make_interval(days => p_days) end)
  returning id into v_id;
  perform public.log_admin_action('access.granted', 'profile', p_user::text,
          jsonb_build_object('product', p_product, 'days', p_days));
  return v_id;
end $$;

create or replace function public.admin_revoke_access(p_grant uuid)
returns void
language plpgsql security definer set search_path = '' as $$
declare
  v_user uuid;
begin
  if not public.is_admin() then
    raise exception 'Solo administradores' using errcode = '42501';
  end if;
  update public.access_grants set revoked_at = now()
   where id = p_grant and revoked_at is null returning user_id into v_user;
  if v_user is null then
    raise exception 'Concesión no encontrada' using errcode = '22023';
  end if;
  perform public.log_admin_action('access.revoked', 'profile', v_user::text,
          jsonb_build_object('grant', p_grant));
end $$;
revoke execute on function public.admin_grant_access(uuid, uuid, int, text) from anon, public;
revoke execute on function public.admin_revoke_access(uuid) from anon, public;
grant execute on function public.admin_grant_access(uuid, uuid, int, text) to authenticated;
grant execute on function public.admin_revoke_access(uuid) to authenticated;

-- Listado de compras/accesos para administración (con email, auditado como consulta)
create or replace function public.admin_list_purchases(p_limit int default 100, p_offset int default 0)
returns table (kind text, id uuid, user_id uuid, email text, product_title text, status text,
               amount_cents integer, source text, created_at timestamptz, ends_at timestamptz)
language plpgsql stable security definer set search_path = '' as $$
begin
  if not public.is_admin() then
    raise exception 'Solo administradores' using errcode = '42501';
  end if;
  return query
  select * from (
    select 'order'::text, o.id, o.user_id, u.email::text,
           (select string_agg(p.title, ', ') from public.order_items oi
              join public.products p on p.id = oi.product_id where oi.order_id = o.id),
           o.status::text, o.total_cents, o.provider, o.created_at, null::timestamptz
      from public.orders o left join auth.users u on u.id = o.user_id
    union all
    select 'grant', g.id, g.user_id, u.email::text, p.title,
           case when g.revoked_at is not null then 'revoked'
                when g.ends_at is not null and g.ends_at <= now() then 'expired' else 'active' end,
           null::integer, g.source::text, g.created_at, g.ends_at
      from public.access_grants g join auth.users u on u.id = g.user_id
      join public.products p on p.id = g.product_id
    union all
    select 'subscription', s.id, s.user_id, u.email::text, p.title, s.status::text, null::integer,
           s.provider, s.created_at, s.current_period_end
      from public.subscriptions s join auth.users u on u.id = s.user_id
      join public.products p on p.id = s.product_id
  ) x
  order by 9 desc
  limit least(greatest(p_limit, 1), 500) offset greatest(p_offset, 0);
end $$;
revoke execute on function public.admin_list_purchases(int, int) from anon, public;
grant execute on function public.admin_list_purchases(int, int) to authenticated;

-- Producto Premium inicial (borrador, precio configurable en el panel)
insert into public.products (slug, type, status, title, title_ca, description, description_ca, included_in_premium)
values ('premium', 'subscription', 'draft', 'Aprobia Premium', 'Aprobia Premium',
        'Acceso a todos los test, simulacros y psicotécnicos incluidos en Premium.',
        'Accés a tots els tests, simulacres i psicotècnics inclosos a Premium.', false);
insert into public.product_prices (product_id, amount_cents, billing_interval)
select id, 1499, 'month' from public.products where slug = 'premium';

-- Exportación RGPD: añadir compras, suscripciones y accesos
create or replace function public.export_my_data()
returns jsonb
language plpgsql stable security definer set search_path = '' as $$
declare
  v_uid uuid := auth.uid();
begin
  if v_uid is null then
    raise exception 'Sesión requerida' using errcode = '42501';
  end if;
  return jsonb_build_object(
    'generated_at', now(),
    'account', (select jsonb_build_object('id', u.id, 'email', u.email, 'created_at', u.created_at,
                                          'email_confirmed_at', u.email_confirmed_at,
                                          'last_sign_in_at', u.last_sign_in_at)
                from auth.users u where u.id = v_uid),
    'profile', (select to_jsonb(p) - 'id' from public.profiles p where p.id = v_uid),
    'exam_targets', coalesce((select jsonb_agg(jsonb_build_object(
                       'exam', b.slug, 'name', b.name, 'is_primary', t.is_primary,
                       'follow_only', t.follow_only, 'notify_consent', t.notify_consent,
                       'level', t.level, 'weekly_hours', t.weekly_hours, 'goals', t.goals,
                       'created_at', t.created_at))
                     from public.user_exam_targets t join public.exam_bodies b on b.id = t.exam_body_id
                     where t.user_id = v_uid), '[]'::jsonb),
    'activity', coalesce((select jsonb_agg(jsonb_build_object('kind', a.kind, 'metadata', a.metadata,
                                                              'created_at', a.created_at) order by a.created_at)
                          from public.activity_events a where a.user_id = v_uid), '[]'::jsonb),
    'practice_sessions', coalesce((select jsonb_agg(to_jsonb(s) - 'user_id' order by s.started_at)
                          from public.practice_sessions s where s.user_id = v_uid), '[]'::jsonb),
    'practice_answers', coalesce((select jsonb_agg(to_jsonb(i) - 'user_id' order by i.answered_at)
                          from public.practice_items i where i.user_id = v_uid and i.answered_at is not null),
                          '[]'::jsonb),
    'orders', coalesce((select jsonb_agg(to_jsonb(o) - 'user_id' order by o.created_at)
                          from public.orders o where o.user_id = v_uid), '[]'::jsonb),
    'subscriptions', coalesce((select jsonb_agg(to_jsonb(s) - 'user_id' order by s.created_at)
                          from public.subscriptions s where s.user_id = v_uid), '[]'::jsonb),
    'access_grants', coalesce((select jsonb_agg((to_jsonb(g) - 'user_id' - 'granted_by') order by g.created_at)
                          from public.access_grants g where g.user_id = v_uid), '[]'::jsonb)
  );
end $$;
revoke execute on function public.export_my_data() from anon, public;
grant execute on function public.export_my_data() to authenticated;
