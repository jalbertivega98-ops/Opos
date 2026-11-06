-- «Continuar con Google» (ADR-040): las cuentas creadas con Google traen el nombre en
-- raw_user_meta_data.full_name / name (no en display_name, que solo pone el alta por correo).
-- Se usa como nombre visible si existe; el resto del alta no cambia.
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
begin
  if v_locale not in ('es', 'ca') then
    v_locale := 'es';
  end if;
  insert into public.profiles (id, display_name, locale)
  values (new.id, left(v_name, 80), v_locale::public.locale_code);
  return new;
end $$;
