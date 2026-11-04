import type { Metadata } from "next";
import { notFound } from "next/navigation";
import { getTranslations, setRequestLocale } from "next-intl/server";
import { Alert } from "@/components/ui/form";

const DOCS = { privacidad: "privacy", cookies: "cookies", condiciones: "terms" } as const;

export async function generateMetadata({
  params,
}: PageProps<"/[locale]/legal/[doc]">): Promise<Metadata> {
  const { locale, doc } = await params;
  if (!(doc in DOCS)) return {};
  const t = await getTranslations({ locale, namespace: "footer" });
  // Borradores sin revisar: no se indexan hasta tener el texto definitivo (DEC-004).
  return { title: t(DOCS[doc as keyof typeof DOCS]), robots: { index: false, follow: true } };
}

/**
 * Páginas legales: BORRADOR pendiente de revisión profesional (docs/legal/).
 * No se inventan datos fiscales: los campos del titular quedan marcados como pendientes.
 */
export default async function LegalPage({ params }: PageProps<"/[locale]/legal/[doc]">) {
  const { locale, doc } = await params;
  setRequestLocale(locale);
  if (!(doc in DOCS)) notFound();
  const t = await getTranslations("footer");
  return (
    <article className="mx-auto max-w-3xl px-4 py-12">
      <h1 className="text-3xl font-bold">{t(DOCS[doc as keyof typeof DOCS])}</h1>
      <Alert className="mt-6">{t("draftNotice")}</Alert>
    </article>
  );
}
