import type { ReactNode } from "react";
import { getTranslations } from "next-intl/server";
import { Link } from "@/i18n/navigation";
import { requireUser } from "@/lib/auth/session";

/** Zona del alumno: comprobación de sesión en servidor (además del proxy). */
export default async function AppLayout({
  children,
  params,
}: {
  children: ReactNode;
  params: Promise<{ locale: string }>;
}) {
  const { locale } = await params;
  await requireUser(locale);
  const t = await getTranslations("nav");
  const links = [
    { href: "/app", label: t("dashboard") },
    { href: "/app/plan", label: t("plan") },
    { href: "/app/practica", label: t("practice") },
    { href: "/app/progreso", label: t("progress") },
    { href: "/app/productos", label: t("library") },
    { href: "/app/perfil", label: t("profile") },
  ];
  return (
    <div className="mx-auto w-full max-w-6xl px-4 py-6 sm:py-8">
      <nav aria-label={t("dashboard")} className="mb-6 flex gap-1 overflow-x-auto text-sm">
        {links.map((l) => (
          <Link
            key={l.href}
            href={l.href}
            className="hover:bg-surface text-muted-foreground hover:text-foreground rounded-md px-3 py-2 whitespace-nowrap"
          >
            {l.label}
          </Link>
        ))}
      </nav>
      {children}
    </div>
  );
}
