"use client";

import { useCallback, useState } from "react";
import { useTranslations } from "next-intl";
import { Link } from "@/i18n/navigation";
import { SpotlightTour } from "@/components/tour/spotlight-tour";
import { completeWelcomeTourAction } from "@/lib/tour/actions";

/**
 * Pasos del tutorial. `target` es el `data-tour` del elemento que se resalta
 * (los enlaces de la navegación del alumno, ver AppNav); sin target, la tarjeta
 * sale centrada.
 */
export const TOUR_STEPS = [
  { key: "welcome", target: null },
  { key: "plan", target: "/app/plan" },
  { key: "syllabus", target: "/app/temario" },
  { key: "practice", target: "/app/practica" },
  { key: "mocks", target: "/app/simulacros" },
  { key: "progress", target: "/app/progreso" },
  { key: "profile", target: "/app/perfil" },
  { key: "done", target: null },
] as const;

/**
 * Tutorial guiado de la zona del alumno (ADR-055). Sale solo la primera vez
 * (`persist`: al cerrarlo o terminarlo se guarda en el perfil) o cuando el
 * alumno lo pide desde «Mi perfil» (`/app?tutorial=1`, sin guardar nada).
 */
export function WelcomeTour({ persist }: { persist: boolean }) {
  const t = useTranslations("tour");
  const [open, setOpen] = useState(true);

  const close = useCallback(() => {
    setOpen(false);
    if (persist) void completeWelcomeTourAction();
  }, [persist]);

  if (!open) return null;

  return (
    <SpotlightTour
      steps={TOUR_STEPS}
      namespace="tour"
      onClose={close}
      finishLabel={t("finish")}
      testId="welcome-tour"
      lastExtra={
        <p className="mt-3 text-sm">
          <Link
            href="/#como-funciona"
            className="text-accent font-semibold hover:underline"
            onClick={close}
          >
            {t("videosLink")}
          </Link>
        </p>
      }
    />
  );
}
