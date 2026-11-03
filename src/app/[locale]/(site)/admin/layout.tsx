import type { ReactNode } from "react";
import { getTranslations } from "next-intl/server";
import { Link } from "@/i18n/navigation";
import { requireAdmin } from "@/lib/auth/session";

/** Zona de administración: solo admin/owner (comprobado en servidor + RLS). */
export default async function AdminLayout({
  children,
  params,
}: {
  children: ReactNode;
  params: Promise<{ locale: string }>;
}) {
  const { locale } = await params;
  await requireAdmin(locale);
  const t = await getTranslations("adminUsers");
  const tc = await getTranslations("adminContent");
  const links = [
    { href: "/admin", label: t("overviewLink") },
    { href: "/admin/alumnos", label: t("title") },
    { href: "/admin/preguntas", label: tc("nav") },
    { href: "/admin/revision", label: tc("navReview") },
    { href: "/admin/revision/fuentes", label: tc("navSources") },
    { href: "/admin/productos", label: tc("navProducts") },
    { href: "/admin/compras", label: tc("navPurchases") },
  ];
  return (
    <div>
      <nav aria-label="Administración" className="border-border bg-surface border-b">
        <div className="mx-auto flex max-w-6xl gap-1 overflow-x-auto px-4 text-sm">
          {links.map((l) => (
            <Link
              key={l.href}
              href={l.href}
              className="hover:bg-surface-2 rounded-md px-3 py-3 font-medium whitespace-nowrap"
            >
              {l.label}
            </Link>
          ))}
        </div>
      </nav>
      {children}
    </div>
  );
}
