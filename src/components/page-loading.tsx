import { getTranslations } from "next-intl/server";
import { Skeleton } from "@/components/ui/card";

/**
 * Esqueleto genérico para `loading.tsx`: se muestra al instante al pulsar un
 * enlace mientras el servidor prepara la página (ADR-053).
 */
export async function PageLoading() {
  const t = await getTranslations("app");
  return (
    <div role="status" aria-live="polite" className="space-y-6">
      <span className="sr-only">{t("loadingPage")}</span>
      <Skeleton className="h-4 w-40" />
      <Skeleton className="h-10 w-72 max-w-full" />
      <Skeleton className="h-5 w-full max-w-xl" />
      <div className="grid gap-4 sm:grid-cols-2 lg:grid-cols-3">
        <Skeleton className="h-40 rounded-3xl" />
        <Skeleton className="h-40 rounded-3xl" />
        <Skeleton className="h-40 rounded-3xl" />
      </div>
    </div>
  );
}
