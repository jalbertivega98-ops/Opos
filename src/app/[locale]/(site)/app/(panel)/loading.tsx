import { getTranslations } from "next-intl/server";
import { Skeleton } from "@/components/ui/card";

/** Estado de carga de la zona del alumno: mantiene la estructura del panel. */
export default async function AppLoading() {
  const t = await getTranslations("app");
  return (
    <div role="status" aria-live="polite" className="space-y-6">
      <span className="sr-only">{t("loading")}</span>
      <Skeleton className="h-4 w-40" />
      <Skeleton className="h-10 w-64" />
      <div className="grid gap-4 lg:grid-cols-3">
        <Skeleton className="h-64 rounded-3xl lg:col-span-2" />
        <Skeleton className="h-64 rounded-3xl" />
      </div>
      <div className="grid gap-4 lg:grid-cols-3">
        <Skeleton className="h-48 rounded-3xl" />
        <Skeleton className="h-48 rounded-3xl lg:col-span-2" />
      </div>
    </div>
  );
}
