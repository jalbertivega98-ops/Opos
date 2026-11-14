-- Copia de supabase/migrations/20261113000100_ambassadors.sql (ADR-054).
-- Programa de embajadoras: enlace /r/<código>, registros atribuidos y /admin/embajadoras. Idempotente.
begin;
-- =====================================================================
-- Programa de embajadoras (ADR-054)
--
--  * Opositoras con seguidores reciben el Premium de su oposición gratis
--    (se regala a mano desde la ficha del alumno) y comparten un enlace o
--    código propio: oposaprueba.com/r/<código>.
--  * ambassadors: alta y baja de embajadoras. Solo lee y escribe el personal admin.
--  * ambassador_visits_daily: visitas diarias por embajadora, contador agregado
--    sin cookies, IP ni identificadores (como traffic_daily, ADR-025). Escribe
--    el servidor con service_role mediante track_ambassador_visit().
--  * ambassador_referrals: qué cuenta llegó con qué código. Se apunta al crear
--    la cuenta por correo (metadato «ref» en handle_new_user) o, con Google, al
--    volver del login mediante claim_referral() en las 24 h siguientes al alta.
--    Nadie puede escribirla directamente; se borra con la cuenta.
-- =====================================================================

create table if not exists public.ambassadors (
  id uuid primary key default gen_random_uuid(),
  code text not null unique check (code ~ '^[a-z0-9-]{2,32}$'),
  name text not null check (char_length(trim(name)) between 1 and 80),
  network text not null default 'instagram' check (network in ('instagram', 'tiktok', 'youtube', 'otra')),
  handle text check (handle is null or char_length(handle) <= 80),
  exam_body_id uuid references public.exam_bodies (id) on delete set null,
  notes text check (notes is null or char_length(notes) <= 500),
  active boolean not null default true,
  created_by uuid references auth.users (id) on delete set null,
  created_at timestamptz not null default now()
);

comment on table public.ambassadors is 'Embajadoras: enlace propio /r/<code> y seguimiento en /admin/embajadoras (ADR-054).';

alter table public.ambassadors enable row level security;
revoke all on public.ambassadors from anon, authenticated;
grant select, insert, update on public.ambassadors to authenticated;

drop policy if exists "ambassadors: admin lee" on public.ambassadors;
create policy "ambassadors: admin lee" on public.ambassadors for select to authenticated
  using (public.is_admin());
drop policy if exists "ambassadors: admin crea" on public.ambassadors;
create policy "ambassadors: admin crea" on public.ambassadors for insert to authenticated
  with check (public.is_admin());
drop policy if exists "ambassadors: admin edita" on public.ambassadors;
create policy "ambassadors: admin edita" on public.ambassadors for update to authenticated
  using (public.is_admin()) with check (public.is_admin());

-- Visitas agregadas por día ---------------------------------------------------
create table if not exists public.ambassador_visits_daily (
  day date not null default current_date,
  ambassador_id uuid not null references public.ambassadors (id) on delete cascade,
  hits integer not null default 0 check (hits >= 0),
  primary key (day, ambassador_id)
);

alter table public.ambassador_visits_daily enable row level security;
revoke all on public.ambassador_visits_daily from anon, authenticated;
grant select on public.ambassador_visits_daily to authenticated;

drop policy if exists "ambassador visits: admin lee" on public.ambassador_visits_daily;
create policy "ambassador visits: admin lee" on public.ambassador_visits_daily for select
  to authenticated using (public.is_admin());

/** Suma una visita al enlace de una embajadora activa. Devuelve si el código existe. */
create or replace function public.track_ambassador_visit(p_code text)
returns boolean
language plpgsql security definer set search_path = '' as $$
declare
  v_id uuid;
begin
  select id into v_id from public.ambassadors
   where code = lower(trim(p_code)) and active;
  if v_id is null then
    return false;
  end if;
  insert into public.ambassador_visits_daily as t (day, ambassador_id, hits)
  values (current_date, v_id, 1)
  on conflict (day, ambassador_id) do update set hits = t.hits + 1;
  return true;
end $$;

revoke execute on function public.track_ambassador_visit(text) from public, anon, authenticated;
grant execute on function public.track_ambassador_visit(text) to service_role;

-- Registros atribuidos ---------------------------------------------------------
create table if not exists public.ambassador_referrals (
  user_id uuid primary key references auth.users (id) on delete cascade,
  ambassador_id uuid not null references public.ambassadors (id) on delete cascade,
  created_at timestamptz not null default now()
);

create index if not exists ambassador_referrals_ambassador_idx
  on public.ambassador_referrals (ambassador_id, created_at desc);

alter table public.ambassador_referrals enable row level security;
revoke all on public.ambassador_referrals from anon, authenticated;
grant select on public.ambassador_referrals to authenticated;

drop policy if exists "ambassador referrals: admin lee" on public.ambassador_referrals;
create policy "ambassador referrals: admin lee" on public.ambassador_referrals for select
  to authenticated using (public.is_admin());

/** Apunta la cuenta a la embajadora del código (si existe, está activa y aún no tenía). */
create or replace function public.record_referral(p_user uuid, p_code text)
returns boolean
language plpgsql security definer set search_path = '' as $$
declare
  v_id uuid;
begin
  if p_user is null or p_code is null then
    return false;
  end if;
  select id into v_id from public.ambassadors
   where code = lower(trim(p_code)) and active;
  if v_id is null then
    return false;
  end if;
  insert into public.ambassador_referrals (user_id, ambassador_id)
  values (p_user, v_id)
  on conflict (user_id) do nothing;
  return found;
end $$;

revoke execute on function public.record_referral(uuid, text) from public, anon, authenticated;

/**
 * Para «Continuar con Google»: el alumno recién creado apunta su propio código.
 * Solo vale en las 24 h siguientes al alta, así una cuenta antigua no se atribuye.
 */
create or replace function public.claim_referral(p_code text)
returns boolean
language plpgsql security definer set search_path = '' as $$
begin
  if auth.uid() is null then
    return false;
  end if;
  if not exists (
    select 1 from public.profiles
     where id = auth.uid() and created_at > now() - interval '24 hours'
  ) then
    return false;
  end if;
  return public.record_referral(auth.uid(), p_code);
end $$;

revoke execute on function public.claim_referral(text) from public, anon;
grant execute on function public.claim_referral(text) to authenticated;

-- Alta por correo: el código viaja en raw_user_meta_data.ref ------------------
create or replace function public.handle_new_user()
returns trigger
language plpgsql
security definer
set search_path = ''
as $$
declare
  v_locale text := coalesce(new.raw_user_meta_data ->> 'locale', 'es');
  v_name text := coalesce(
    nullif(trim(new.raw_user_meta_data ->> 'display_name'), ''),
    nullif(trim(new.raw_user_meta_data ->> 'full_name'), ''),
    nullif(trim(new.raw_user_meta_data ->> 'name'), '')
  );
  v_ref text := nullif(trim(new.raw_user_meta_data ->> 'ref'), '');
begin
  if v_locale not in ('es', 'ca') then
    v_locale := 'es';
  end if;
  insert into public.profiles (id, display_name, locale)
  values (new.id, left(v_name, 80), v_locale::public.locale_code);
  if v_ref is not null then
    perform public.record_referral(new.id, left(v_ref, 64));
  end if;
  return new;
end $$;

-- Resumen para /admin/embajadoras ---------------------------------------------
/**
 * Por embajadora: visitas, registros y alumnos que pagan Premium (Stripe real o
 * de prueba; los Premium regalados no cuentan), en los últimos p_days días y en total.
 */
create or replace function public.admin_ambassador_stats(p_days integer default 30)
returns table (
  ambassador_id uuid,
  visits_period bigint,
  visits_total bigint,
  signups_period bigint,
  signups_total bigint,
  paid_period bigint,
  paid_total bigint
)
language plpgsql stable security definer set search_path = '' as $$
declare
  v_since date := current_date - greatest(1, least(coalesce(p_days, 30), 365)) + 1;
begin
  if not public.is_admin() then
    raise exception 'No autorizado' using errcode = '42501';
  end if;
  return query
  select
    a.id,
    coalesce((select sum(v.hits) from public.ambassador_visits_daily v
               where v.ambassador_id = a.id and v.day >= v_since), 0)::bigint,
    coalesce((select sum(v.hits) from public.ambassador_visits_daily v
               where v.ambassador_id = a.id), 0)::bigint,
    (select count(*) from public.ambassador_referrals r
      where r.ambassador_id = a.id and r.created_at >= v_since),
    (select count(*) from public.ambassador_referrals r where r.ambassador_id = a.id),
    (select count(distinct r.user_id) from public.ambassador_referrals r
       join public.subscriptions s on s.user_id = r.user_id and s.provider <> 'none'
      where r.ambassador_id = a.id and s.created_at >= v_since),
    (select count(distinct r.user_id) from public.ambassador_referrals r
       join public.subscriptions s on s.user_id = r.user_id and s.provider <> 'none'
      where r.ambassador_id = a.id)
  from public.ambassadors a;
end $$;

revoke execute on function public.admin_ambassador_stats(integer) from public, anon;
grant execute on function public.admin_ambassador_stats(integer) to authenticated;
commit;
