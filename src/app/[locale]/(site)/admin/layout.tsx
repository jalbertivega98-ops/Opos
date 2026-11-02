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
  return (
    <div>
      <nav aria-label="Administración" className="border-border bg-surface border-b">
        <div className="mx-auto flex max-w-6xl gap-1 overflow-x-auto px-4 text-sm">
          <Link href="/admin" className="hover:bg-surface-2 rounded-md px-3 py-3 font-medium">
            {t("overviewLink")}
          </Link>
          <Link
            href="/admin/alumnos"
            className="hover:bg-surface-2 rounded-md px-3 py-3 font-medium"
          >
            {t("title")}
          </Link>
        </div>
      </nav>
      {children}
    </div>
  );
}
