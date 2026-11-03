"use client";

import { useEffect } from "react";
import { useTranslations } from "next-intl";
import { AlertTriangle, RotateCcw } from "lucide-react";
import { Button } from "@/components/ui/button";

/** Error inesperado en la zona del alumno: mensaje claro y opción de reintentar. */
export default function AppError({ error, retry }: { error: unknown; retry: () => void }) {
  const t = useTranslations("app");
  useEffect(() => {
    console.error(error);
  }, [error]);
  return (
    <div
      role="alert"
      className="border-danger/40 bg-danger-soft mx-auto flex max-w-xl flex-col items-center gap-3 rounded-3xl border px-6 py-12 text-center"
    >
      <AlertTriangle className="text-danger size-8" aria-hidden />
      <h1 className="text-xl font-bold">{t("errorTitle")}</h1>
      <p className="text-muted-foreground text-sm">{t("errorBody")}</p>
      <Button onClick={() => retry()} className="mt-2">
        <RotateCcw aria-hidden /> {t("errorRetry")}
      </Button>
    </div>
  );
}
