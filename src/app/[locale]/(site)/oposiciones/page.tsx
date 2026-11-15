import type { Metadata } from "next";
import { Suspense } from "react";
import { getTranslations, setRequestLocale } from "next-intl/server";
import { ExamCard } from "@/components/exam-card";
import {
  CatalogBrowser,
  CatalogView,
  type CatalogItem,
} from "@/components/catalog/catalog-browser";
import { pageMetadata } from "@/lib/seo/site";
import { CATEGORIES, listExamBodies } from "@/lib/catalog/queries";

/** Catálogo estático; las búsquedas (`?q=`, `?category=`) se filtran en el navegador (ADR-060). */
export const revalidate = 600;

export async function generateMetadata({
  params,
}: PageProps<"/[locale]/oposiciones">): Promise<Metadata> {
  const { locale } = await params;
  const t = await getTranslations({ locale, namespace: "seo.catalog" });
  // Las búsquedas apuntan al catálogo completo (canonical) y el proxy les pone noindex.
  return pageMetadata({
    path: "/oposiciones",
    locale,
    title: t("title"),
    description: t("description"),
  });
}

export default async function CatalogPage({ params }: PageProps<"/[locale]/oposiciones">) {
  const { locale } = await params;
  setRequestLocale(locale);
  const t = await getTranslations();
  const exams = await listExamBodies();
  const items: CatalogItem[] = exams.map((e) => ({
    id: e.id,
    category: e.category,
    text: [e.name, e.name_ca, e.short_description].filter(Boolean).join(" ").toLocaleLowerCase(),
    card: <ExamCard exam={e} />,
  }));

  return (
    <div className="wrap py-10 sm:py-14">
      <h1 className="text-3xl font-bold sm:text-4xl">{t("catalog.title")}</h1>
      <p className="text-muted-foreground mt-2 max-w-2xl">{t("catalog.subtitle")}</p>
      <Suspense fallback={<CatalogView items={items} all={items} categories={CATEGORIES} />}>
        <CatalogBrowser items={items} categories={CATEGORIES} />
      </Suspense>
    </div>
  );
}
