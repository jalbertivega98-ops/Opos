import type { ReactNode } from "react";
import { getTranslations } from "next-intl/server";
import { AppNav } from "@/components/app-nav";
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
    { href: "/app/temario", label: t("syllabus") },
    { href: "/app/practica", label: t("practice") },
    { href: "/app/progreso", label: t("progress") },
    { href: "/app/productos", label: t("library") },
    { href: "/app/perfil", label: t("profile") },
  ];
  return (
    <div className="wrap py-6 sm:py-8">
      <AppNav label={t("dashboard")} links={links} />
      {children}
    </div>
  );
}
