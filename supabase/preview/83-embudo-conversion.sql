-- Copia de supabase/migrations/20261111000100_conversion_funnel.sql (ADR-047).
-- Embudo de conversión del panel de administración. Idempotente.
begin;
-- =====================================================================
-- Embudo de conversión del panel de administración (ADR-047)
--
--  * funnel_daily: contadores diarios agregados del test gratis sin registro
--    (empieza / termina), por oposición. Sin IP, sin cookies, sin usuario: igual
--    que traffic_daily (ADR-025), no necesita consentimiento.
--  * track_funnel(): solo service_role (lo llama el servidor). Pasos acotados.
--  * admin_funnel(p_days): SECURITY DEFINER + is_admin(). Devuelve los pasos
--    visitas → empiezan test → terminan test → crean cuenta → completan
--    onboarding → practican → pagan. Los pasos de cuenta son de la cohorte de
--    cuentas creadas en el periodo, para que los porcentajes tengan sentido.
--    «Pagan» = pedido pagado o suscripción con Stripe real (no regalos).
-- =====================================================================

create table if not exists public.funnel_daily (
  day date not null default current_date,
  step text not null check (step in ('sample_start', 'sample_finish')),
  exam text not null check (exam ~ '^[a-z0-9-]{2,80}$'),
  hits integer not null default 0 check (hits >= 0),
  primary key (day, step, exam)
);

alter table public.funnel_daily enable row level security;
revoke all on public.funnel_daily from anon, authenticated;

create or replace function public.track_funnel(p_step text, p_exam text)
returns void
language sql security definer set search_path = '' as $$
  insert into public.funnel_daily as f (day, step, exam, hits)
  values ((now() at time zone 'Europe/Madrid')::date, p_step, p_exam, 1)
  on conflict (day, step, exam) do update set hits = f.hits + 1;
$$;

revoke execute on function public.track_funnel(text, text) from public, anon, authenticated;
grant execute on function public.track_funnel(text, text) to service_role;

create or replace function public.admin_funnel(p_days integer default 30)
returns jsonb
language plpgsql stable security definer set search_path = '' as $$
declare
  v_days integer := least(greatest(coalesce(p_days, 30), 1), 90);
  v_end date := (now() at time zone 'Europe/Madrid')::date;
  v_start date := v_end - (v_days - 1);
  v_from timestamptz := v_start::timestamp at time zone 'Europe/Madrid';
  v_result jsonb;
begin
  if not public.is_admin() then
    raise exception 'Solo administradores' using errcode = '42501';
  end if;

  with cohort as (
    select u.id from auth.users u
     where u.created_at >= v_from and u.deleted_at is null
  ),
  sample as (
    select f.exam,
           sum(f.hits) filter (where f.step = 'sample_start')::bigint as starts,
           sum(f.hits) filter (where f.step = 'sample_finish')::bigint as finishes
      from public.funnel_daily f
     where f.day >= v_start
     group by f.exam
  )
  select jsonb_build_object(
    'days', v_days,
    'visits', coalesce((select sum(t.hits) from public.traffic_daily t
                         where t.kind = 'visit' and t.day >= v_start), 0),
    'sample_start', coalesce((select sum(s.starts) from sample s), 0),
    'sample_finish', coalesce((select sum(s.finishes) from sample s), 0),
    'signups', (select count(*) from cohort),
    'onboarded', (select count(*) from cohort c join public.profiles p on p.id = c.id
                   where p.onboarding_completed_at is not null),
    'practicing', (select count(*) from cohort c
                    where exists (select 1 from public.practice_sessions ps
                                   where ps.user_id = c.id and ps.answered_count > 0)
                       or exists (select 1 from public.mock_attempts m where m.user_id = c.id)),
    'paying', (select count(*) from cohort c
                where exists (select 1 from public.orders o
                               where o.user_id = c.id and o.status = 'paid' and o.provider = 'stripe')
                   or exists (select 1 from public.subscriptions s
                               where s.user_id = c.id and s.provider = 'stripe'
                                 and s.status in ('trialing', 'active', 'past_due', 'canceled'))),
    'by_exam', coalesce((select jsonb_agg(jsonb_build_object(
                           'exam', s.exam, 'starts', coalesce(s.starts, 0),
                           'finishes', coalesce(s.finishes, 0))
                         order by s.starts desc nulls last, s.exam)
                         from (select * from sample order by starts desc nulls last limit 10) s),
                        '[]'::jsonb)
  ) into v_result;
  return v_result;
end $$;

revoke execute on function public.admin_funnel(integer) from public, anon;
grant execute on function public.admin_funnel(integer) to authenticated;
commit;
