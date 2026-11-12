import type { Metadata } from "next";
import { getTranslations, setRequestLocale } from "next-intl/server";
import { Button } from "@/components/ui/button";
import { EmptyState } from "@/components/ui/card";
import { ExamCard } from "@/components/exam-card";
import { pageMetadata } from "@/lib/seo/site";
import { CATEGORIES, catalogFilterSchema, listExamBodies } from "@/lib/catalog/queries";

export async function generateMetadata({
  params,
  searchParams,
}: PageProps<"/[locale]/oposiciones">): Promise<Metadata> {
  const { locale } = await params;
  const t = await getTranslations({ locale, namespace: "seo.catalog" });
  const { q, category } = await searchParams;
  // Las búsquedas y filtros apuntan al catálogo completo y no se indexan.
  return pageMetadata({
    path: "/oposiciones",
    locale,
    title: t("title"),
    description: t("description"),
    index: !q && !category,
  });
}

export default async function CatalogPage({
  params,
  searchParams,
}: PageProps<"/[locale]/oposiciones">) {
  const { locale } = await params;
  setRequestLocale(locale);
  const t = await getTranslations();
  const filter = catalogFilterSchema.parse(await searchParams);
  const filtered = Boolean(filter.q || filter.category);
  const [exams, all] = await Promise.all([
    listExamBodies(filter),
    filtered ? listExamBodies() : Promise.resolve(null),
  ]);
  // Solo las categorías que tienen alguna oposición publicada (y la elegida, si la hay).
  const used = new Set((all ?? exams).map((e) => e.category));
  const categories = CATEGORIES.filter((c) => used.has(c) || c === filter.category);

  return (
    <div className="wrap py-10 sm:py-14">
      <h1 className="text-3xl font-bold sm:text-4xl">{t("catalog.title")}</h1>
      <p className="text-muted-foreground mt-2 max-w-2xl">{t("catalog.subtitle")}</p>

      <form role="search" className="mt-8 flex flex-col gap-2 sm:flex-row">
        <label htmlFor="q" className="sr-only">
          {t("catalog.search")}
        </label>
        <input
          id="q"
          name="q"
          type="search"
          defaultValue={filter.q}
          placeholder={t("catalog.search")}
          className="border-input bg-background h-11 flex-1 rounded-lg border px-3"
        />
        <label htmlFor="category" className="sr-only">
          {t("catalog.allCategories")}
        </label>
        <select
          id="category"
          name="category"
          defaultValue={filter.category ?? ""}
          className="border-input bg-background h-11 rounded-lg border px-3"
        >
          <option value="">{t("catalog.allCategories")}</option>
          {categories.map((c) => (
            <option key={c} value={c}>
              {t(`category.${c}`)}
            </option>
          ))}
        </select>
        <Button type="submit">{t("catalog.filter")}</Button>
      </form>

      <p className="text-muted-foreground mt-6 text-sm" aria-live="polite">
        {t("catalog.results", { count: exams.length })}
      </p>
      {exams.length === 0 ? (
        <div className="mt-4">
          <EmptyState title={t("catalog.empty")} description={t("catalog.emptyHint")} />
        </div>
      ) : (
        <div className="mt-4 grid gap-4 sm:grid-cols-2 lg:grid-cols-3">
          {exams.map((exam) => (
            <ExamCard key={exam.id} exam={exam} />
          ))}
        </div>
      )}
    </div>
  );
}
