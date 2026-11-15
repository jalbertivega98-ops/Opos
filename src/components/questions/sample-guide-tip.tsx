"use client";

import { useCallback, useEffect, useState } from "react";
import { useTranslations } from "next-intl";
import { Lightbulb, X } from "lucide-react";

export const TEST_GUIDE_KEY = "opa.testGuide";
export type SampleGuidePhase = "answer" | "feedback" | "keepGoing" | "finish";
const ORDER: SampleGuidePhase[] = ["answer", "feedback", "keepGoing", "finish"];

function readDone() {
  try {
    return window.localStorage.getItem(TEST_GUIDE_KEY) === "done";
  } catch {
    return false;
  }
}

function markDone() {
  try {
    window.localStorage.setItem(TEST_GUIDE_KEY, "done");
  } catch {
    // Sin almacenamiento: la guía volverá a salir, sin más.
  }
}

/**
 * Estado de las pistas del primer test gratis (ADR-057): activas la primera vez
 * en este navegador; quedan vistas al ocultarlas o al llegar al resultado.
 * Devuelve la fase que toca enseñar (o null) y cómo ocultarlas.
 */
export function useTestGuide(phase: SampleGuidePhase | null) {
  const [active, setActive] = useState(false);
  const [finished, setFinished] = useState(false);

  useEffect(() => {
    const raf = window.requestAnimationFrame(() => setActive(!readDone()));
    return () => window.cancelAnimationFrame(raf);
  }, []);

  useEffect(() => {
    if (!active || phase !== "finish") return;
    markDone();
    const raf = window.requestAnimationFrame(() => setFinished(true));
    return () => window.cancelAnimationFrame(raf);
  }, [active, phase]);

  const hide = useCallback(() => {
    markDone();
    setActive(false);
  }, []);

  // Tras terminar (p. ej. «Repetir test») no vuelve a empezar la guía.
  const shown = active && phase && !(finished && phase !== "finish") ? phase : null;
  return { phase: shown, hide };
}

/**
 * Pista del test gratis: qué pulsar, qué significa la corrección y qué viene al
 * terminar. No bloquea nada y se puede ocultar.
 */
export function SampleGuideTip({
  phase,
  onHide,
}: {
  phase: SampleGuidePhase | null;
  onHide: () => void;
}) {
  const t = useTranslations("testGuide");
  if (!phase) return null;
  const n = ORDER.indexOf(phase) + 1;

  return (
    <div
      role="status"
      className="border-accent/50 bg-accent-soft flex items-start gap-3 rounded-xl border-2 p-4"
      data-testid="test-guide"
      data-phase={phase}
    >
      <Lightbulb className="text-accent mt-0.5 size-5 shrink-0" aria-hidden />
      <div className="flex-1">
        <p className="text-accent text-xs font-bold tracking-wider uppercase">
          {t("stepOf", { n, total: ORDER.length })}
        </p>
        <p className="mt-1 font-semibold">{t(`${phase}.title`)}</p>
        <p className="text-muted-foreground mt-1 text-sm">{t(`${phase}.body`)}</p>
      </div>
      <button
        type="button"
        onClick={onHide}
        className="text-muted-foreground hover:bg-background -mt-1 -mr-1 rounded-md p-1.5"
        aria-label={t("hide")}
        data-testid="test-guide-hide"
      >
        <X className="size-4" aria-hidden />
      </button>
    </div>
  );
}
