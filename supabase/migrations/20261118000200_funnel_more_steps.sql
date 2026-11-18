-- =====================================================================
-- Embudo: más pasos del primer contacto (ADR-069)
--
--  * funnel_daily admite tres pasos nuevos, igual de anónimos (contador diario,
--    sin IP ni usuario):
--      - psycho_start:  responden el primer ejercicio de un psicotécnico de
--                       prueba sin cuenta (exam = tipo de psicotécnico).
--      - sample_signup: pulsan «Crear cuenta» dentro del test gratis
--                       (exam = oposición).
--      - psycho_signup: pulsan «Crear cuenta» al acabar un psicotécnico de
--                       prueba (exam = tipo de psicotécnico).
--  * admin_funnel() devuelve además psycho_start, signup_clicks (suma de los dos
--    clics), by_exam con los clics y by_psycho (empiezan por tipo).
-- =====================================================================

alter table public.funnel_daily drop constraint if exists funnel_daily_step_check;
alter table public.funnel_daily add constraint funnel_daily_step_check
  check (step in ('sample_start', 'sample_finish', 'sample_signup', 'psycho_start', 'psycho_signup'));

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
  steps as (
    select f.step, f.exam, sum(f.hits)::bigint as hits
      from public.funnel_daily f
     where f.day >= v_start
     group by f.step, f.exam
  ),
  sample as (
    select s.exam,
           sum(s.hits) filter (where s.step = 'sample_start')::bigint as starts,
           sum(s.hits) filter (where s.step = 'sample_finish')::bigint as finishes,
           sum(s.hits) filter (where s.step = 'sample_signup')::bigint as signups
      from steps s
     where s.step like 'sample\_%'
     group by s.exam
  ),
  psycho as (
    select s.exam as type,
           sum(s.hits) filter (where s.step = 'psycho_start')::bigint as starts,
           sum(s.hits) filter (where s.step = 'psycho_signup')::bigint as signups
      from steps s
     where s.step like 'psycho\_%'
     group by s.exam
  )
  select jsonb_build_object(
    'days', v_days,
    'visits', coalesce((select sum(t.hits) from public.traffic_daily t
                         where t.kind = 'visit' and t.day >= v_start), 0),
    'sample_start', coalesce((select sum(s.starts) from sample s), 0),
    'sample_finish', coalesce((select sum(s.finishes) from sample s), 0),
    'psycho_start', coalesce((select sum(p.starts) from psycho p), 0),
    'signup_clicks', coalesce((select sum(s.hits) from steps s
                                where s.step in ('sample_signup', 'psycho_signup')), 0),
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
                           'finishes', coalesce(s.finishes, 0),
                           'signups', coalesce(s.signups, 0))
                         order by s.starts desc nulls last, s.exam)
                         from (select * from sample order by starts desc nulls last limit 10) s),
                        '[]'::jsonb),
    'by_psycho', coalesce((select jsonb_agg(jsonb_build_object(
                             'type', p.type, 'starts', coalesce(p.starts, 0),
                             'signups', coalesce(p.signups, 0))
                           order by p.starts desc nulls last, p.type)
                           from (select * from psycho order by starts desc nulls last limit 12) p),
                          '[]'::jsonb)
  ) into v_result;
  return v_result;
end $$;

revoke execute on function public.admin_funnel(integer) from public, anon;
grant execute on function public.admin_funnel(integer) to authenticated;
