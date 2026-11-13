-- =====================================================================
-- Tutorial de bienvenida (13/11/2026, ADR-055)
-- El tutorial guiado de la zona del alumno sale solo la primera vez.
-- `profiles.tour_completed_at` guarda cuándo lo terminó o lo cerró, en la
-- base de datos (no en el navegador) para que no vuelva a salir en otro
-- dispositivo. Los perfiles que ya existían se marcan como vistos: el
-- tutorial es para quien entra por primera vez.
-- El alumno no puede escribir la columna directamente (UPDATE por columnas,
-- ADR de 0400); solo vía complete_welcome_tour(), que marca su propio perfil.
-- =====================================================================
alter table public.profiles add column if not exists tour_completed_at timestamptz;

update public.profiles set tour_completed_at = now() where tour_completed_at is null;

create or replace function public.complete_welcome_tour()
returns void
language plpgsql security definer set search_path = '' as $$
begin
  if auth.uid() is null then
    raise exception 'Sesión requerida' using errcode = '42501';
  end if;
  update public.profiles
     set tour_completed_at = coalesce(tour_completed_at, now())
   where id = auth.uid();
end $$;

revoke execute on function public.complete_welcome_tour() from public, anon;
grant execute on function public.complete_welcome_tour() to authenticated;
