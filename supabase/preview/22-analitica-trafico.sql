-- Analítica de captación (ADR-025): migración 20261104000200_traffic_analytics.sql. Idempotente.
begin;
-- =====================================================================
-- 1600 · Analítica de captación: buscadores, asistentes de IA y rastreadores (ADR-025)
--
--  * Contadores diarios agregados, sin datos personales: ni IP, ni cookies, ni
--    identificador de usuario, ni la URL de origen completa. Solo día, tipo
--    (visita o rastreador), canal, fuente normalizada y ruta pública normalizada.
--    Por eso no requiere consentimiento de cookies.
--  * Escribe el servidor (proxy) con service_role mediante track_traffic(); anon y
--    authenticated no pueden escribir. Lo lee el personal (is_staff) en /admin/trafico.
--  * Valores acotados por CHECK para que la tabla no crezca sin control.
-- =====================================================================

create table if not exists public.traffic_daily (
  day date not null default current_date,
  kind text not null check (kind in ('visit', 'crawler')),
  channel text not null check (channel in ('search', 'ai', 'social', 'referral', 'direct')),
  source text not null check (source ~ '^[a-z0-9-]{2,32}$'),
  path text not null check (path ~ '^/[a-z0-9/-]{0,119}$'),
  hits integer not null default 0 check (hits >= 0),
  primary key (day, kind, channel, source, path)
);

create index if not exists traffic_daily_day_idx on public.traffic_daily (day desc);

alter table public.traffic_daily enable row level security;
revoke all on public.traffic_daily from anon, authenticated;
grant select on public.traffic_daily to authenticated;

drop policy if exists "traffic: staff lee" on public.traffic_daily;
create policy "traffic: staff lee" on public.traffic_daily for select to authenticated
  using (public.is_staff());

create or replace function public.track_traffic(
  p_kind text, p_channel text, p_source text, p_path text
) returns void
language sql security definer set search_path = '' as $$
  insert into public.traffic_daily as t (day, kind, channel, source, path, hits)
  values (current_date, p_kind, p_channel, p_source, p_path, 1)
  on conflict (day, kind, channel, source, path) do update set hits = t.hits + 1;
$$;

revoke execute on function public.track_traffic(text, text, text, text) from public, anon, authenticated;
grant execute on function public.track_traffic(text, text, text, text) to service_role;
commit;
