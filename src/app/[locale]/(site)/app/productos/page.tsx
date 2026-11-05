import { redirect } from "@/i18n/navigation";

/**
 * La antigua pestaña «Mis productos» ya no existe (ADR-036): los simulacros
 * están en «Simulacros» y la suscripción y las compras, en «Mi perfil». Se
 * redirige conservando la consulta (p. ej. la vuelta de un pago de Stripe).
 */
export default async function LegacyLibraryPage({
  params,
  searchParams,
}: PageProps<"/[locale]/app/productos">) {
  const { locale } = await params;
  const sp = await searchParams;
  const qs = new URLSearchParams();
  for (const [k, v] of Object.entries(sp)) if (typeof v === "string") qs.set(k, v);
  const query = qs.toString();
  const to = sp.error ? "/app/simulacros" : "/app/perfil";
  redirect({ href: query ? `${to}?${query}` : to, locale });
}
