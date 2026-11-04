import type { Metadata } from "next";
import { notFound } from "next/navigation";
import { getTranslations, setRequestLocale } from "next-intl/server";
import { CookiePolicy, LegalNotice, PrivacyPolicy, SaleTerms } from "@/components/legal/legal-docs";
import { legalOwner } from "@/lib/legal/owner";

const DOCS = {
  "aviso-legal": { key: "notice", Body: LegalNotice },
  condiciones: { key: "terms", Body: SaleTerms },
  privacidad: { key: "privacy", Body: PrivacyPolicy },
  cookies: { key: "cookies", Body: CookiePolicy },
} as const;
type DocSlug = keyof typeof DOCS;
const isDoc = (d: string): d is DocSlug => d in DOCS;

export async function generateMetadata({
  params,
}: PageProps<"/[locale]/legal/[doc]">): Promise<Metadata> {
  const { locale, doc } = await params;
  if (!isDoc(doc)) return {};
  const t = await getTranslations({ locale, namespace: "footer" });
  return { title: t(DOCS[doc].key) };
}

/**
 * Textos legales (src/components/legal/legal-docs.tsx). Los datos del titular
 * vienen de `legalOwner()` (marca OPOSAPRUEBA por defecto).
 */
export default async function LegalPage({ params }: PageProps<"/[locale]/legal/[doc]">) {
  const { locale, doc } = await params;
  setRequestLocale(locale);
  if (!isDoc(doc)) notFound();
  const t = await getTranslations("footer");
  const owner = legalOwner();
  const { key, Body } = DOCS[doc];
  return (
    <article className="text-foreground/90 mx-auto max-w-3xl px-4 py-12 leading-relaxed [&_a]:underline [&_li]:mt-1 [&_ol]:list-decimal [&_ol]:pl-6 [&_p]:mt-3 [&_ul]:list-disc [&_ul]:pl-6">
      <h1 className="text-foreground text-3xl font-bold">{t(key)}</h1>
      {locale === "ca" && <p className="text-muted-foreground text-sm">{t("spanishOnly")}</p>}
      <Body owner={owner} />
      <p className="text-muted-foreground mt-10 text-sm">{t("updated")}</p>
    </article>
  );
}
