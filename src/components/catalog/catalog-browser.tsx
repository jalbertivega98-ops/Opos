"use client";

import type { ReactNode } from "react";
import { useSearchParams } from "next/navigation";
import { useTranslations } from "next-intl";
import { Button } from "@/components/ui/button";
import { EmptyState } from "@/components/ui/card";

export type CatalogItem = {
  id: string;
  category: string;
  /** Nombre (es/ca) y descripción, ya en minúsculas: lo que antes buscaba `ilike`. */
  text: string;
  card: ReactNode;
};

/** Misma limpieza que `sanitizeSearch` en servidor (sin comodines ni sintaxis de filtros). */
function cleanQuery(q: string) {
  return q
    .replace(/[^\p{L}\p{N}\s'\-·.]/gu, "")
    .replace(/\s+/g, " ")
    .trim()
    .slice(0, 80)
    .toLocaleLowerCase();
}

/**
 * Buscador y filtro del catálogo. Recibe todas las fichas ya pintadas en el servidor
 * y filtra en el navegador según `?q=` y `?category=`: la página es estática y se
 * sirve en caché (ADR-059). Sin JavaScript se ve el catálogo completo.
 */
export function CatalogBrowser({
  items,
  categories,
}: {
  items: CatalogItem[];
  categories: readonly string[];
}) {
  const params = useSearchParams();
  const rawQ = (params.get("q") ?? "").slice(0, 80);
  const q = cleanQuery(rawQ);
  const wanted = params.get("category") ?? "";
  const category = categories.includes(wanted) ? wanted : "";
  const shown = items.filter(
    (i) => (!category || i.category === category) && (!q || i.text.includes(q)),
  );
  return (
    <CatalogView items={shown} all={items} q={rawQ} category={category} categories={categories} />
  );
}

/** Vista sin filtros (respaldo del `<Suspense>` en el HTML estático). */
export function CatalogView({
  items,
  all,
  q = "",
  category = "",
  categories,
}: {
  items: CatalogItem[];
  all: CatalogItem[];
  q?: string;
  category?: string;
  categories: readonly string[];
}) {
  const t = useTranslations();
  // Solo las categorías que tienen alguna oposición publicada (y la elegida, si la hay).
  const used = new Set(all.map((e) => e.category));
  const options = categories.filter((c) => used.has(c) || c === category);
  return (
    <>
      <form role="search" className="mt-8 flex flex-col gap-2 sm:flex-row" key={`${q}|${category}`}>
        <label htmlFor="q" className="sr-only">
          {t("catalog.search")}
        </label>
        <input
          id="q"
          name="q"
          type="search"
          defaultValue={q}
          placeholder={t("catalog.search")}
          className="border-input bg-background h-11 flex-1 rounded-lg border px-3"
        />
        <label htmlFor="category" className="sr-only">
          {t("catalog.allCategories")}
        </label>
        <select
          id="category"
          name="category"
          defaultValue={category}
          className="border-input bg-background h-11 rounded-lg border px-3"
        >
          <option value="">{t("catalog.allCategories")}</option>
          {options.map((c) => (
            <option key={c} value={c}>
              {t(`category.${c}`)}
            </option>
          ))}
        </select>
        <Button type="submit">{t("catalog.filter")}</Button>
      </form>

      <p className="text-muted-foreground mt-6 text-sm" aria-live="polite">
        {t("catalog.results", { count: items.length })}
      </p>
      {items.length === 0 ? (
        <div className="mt-4">
          <EmptyState title={t("catalog.empty")} description={t("catalog.emptyHint")} />
        </div>
      ) : (
        <div className="mt-4 grid gap-4 sm:grid-cols-2 lg:grid-cols-3">
          {items.map((i) => (
            <div key={i.id} className="contents">
              {i.card}
            </div>
          ))}
        </div>
      )}
    </>
  );
}
