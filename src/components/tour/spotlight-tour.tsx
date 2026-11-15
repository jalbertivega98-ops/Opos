"use client";

import { useCallback, useEffect, useId, useLayoutEffect, useRef, useState } from "react";
import { useTranslations } from "next-intl";
import { X } from "lucide-react";
import { Button } from "@/components/ui/button";
import { cn } from "@/lib/utils";

/**
 * Paso de un recorrido guiado. `target` es el valor de `data-tour` del elemento
 * que se resalta (sin target, la tarjeta sale centrada). Con `interactive` el
 * elemento resaltado se puede pulsar (p. ej. el selector del test gratis); el
 * resto de la página sigue bloqueado.
 */
export type SpotlightStep = {
  key: string;
  target: string | null;
  interactive?: boolean;
};

type Rect = { top: number; left: number; width: number; height: number };
const PAD = 6;
const SHADE = "rgba(7, 17, 31, 0.62)";

/**
 * Recorrido con foco (ADR-055 y ADR-057): oscurece la página, resalta un
 * elemento y explica qué es en una tarjeta con Atrás/Siguiente. Lo usan el
 * tutorial del alumno (`WelcomeTour`) y la guía de la portada para visitantes
 * (`VisitorTour`). Textos en `<namespace>.steps.<key>.{title,body}`; los
 * botones comunes, en `tour`.
 */
export function SpotlightTour({
  steps,
  namespace,
  onClose,
  finishLabel,
  lastExtra,
  scrollBlock = "nearest",
  testId,
}: {
  steps: readonly SpotlightStep[];
  namespace: string;
  onClose: () => void;
  finishLabel: string;
  /** Contenido extra del último paso (enlaces a la siguiente acción). */
  lastExtra?: React.ReactNode;
  scrollBlock?: ScrollLogicalPosition;
  testId: string;
}) {
  const t = useTranslations("tour");
  const ts = useTranslations(namespace);
  const [step, setStep] = useState(0);
  const [rect, setRect] = useState<Rect | null>(null);
  const [wide, setWide] = useState(false);
  const [cardH, setCardH] = useState(260);
  const cardRef = useRef<HTMLDivElement>(null);
  const titleId = useId();
  const bodyId = useId();
  const current = steps[step];
  const last = step === steps.length - 1;
  const interactive = Boolean(current.interactive && rect);

  // Posición del elemento resaltado (se recalcula al cambiar de paso, al
  // desplazar y al redimensionar).
  const measure = useCallback(() => {
    if (cardRef.current) setCardH(cardRef.current.offsetHeight);
    if (!current.target) return setRect(null);
    const node = document.querySelector<HTMLElement>(`[data-tour="${current.target}"]`);
    if (!node) return setRect(null);
    const r = node.getBoundingClientRect();
    if (r.width === 0 && r.height === 0) return setRect(null);
    setRect({ top: r.top, left: r.left, width: r.width, height: r.height });
  }, [current.target]);

  useLayoutEffect(() => {
    if (current.target) {
      const node = document.querySelector<HTMLElement>(`[data-tour="${current.target}"]`);
      const reduce = window.matchMedia("(prefers-reduced-motion: reduce)").matches;
      node?.scrollIntoView({
        block: scrollBlock,
        inline: "center",
        behavior: reduce ? "auto" : "smooth",
      });
    }
    // Sigue midiendo mientras dura el desplazamiento suave y las animaciones
    // de entrada de la portada, para que el resaltado no se quede atrás.
    let raf = 0;
    const until = performance.now() + 1500;
    const tick = () => {
      measure();
      if (performance.now() < until) raf = window.requestAnimationFrame(tick);
    };
    raf = window.requestAnimationFrame(tick);
    return () => window.cancelAnimationFrame(raf);
  }, [current.target, measure, scrollBlock]);

  useEffect(() => {
    const mq = window.matchMedia("(min-width: 640px)");
    const update = () => setWide(mq.matches);
    const raf = window.requestAnimationFrame(update);
    mq.addEventListener("change", update);
    return () => {
      window.cancelAnimationFrame(raf);
      mq.removeEventListener("change", update);
    };
  }, []);

  useEffect(() => {
    window.addEventListener("resize", measure);
    window.addEventListener("scroll", measure, true);
    return () => {
      window.removeEventListener("resize", measure);
      window.removeEventListener("scroll", measure, true);
    };
  }, [measure]);

  // Foco en la tarjeta en cada paso; Escape cierra; Tab no sale del diálogo
  // (salvo en los pasos interactivos, donde el elemento resaltado es usable).
  useEffect(() => {
    cardRef.current?.focus();
  }, [step]);

  const onKeyDown = (e: React.KeyboardEvent<HTMLDivElement>) => {
    if (e.key === "Escape") {
      e.preventDefault();
      onClose();
    } else if (e.key === "Tab" && cardRef.current && !interactive) {
      const items = cardRef.current.querySelectorAll<HTMLElement>(
        "a[href], button:not([disabled])",
      );
      if (!items.length) return;
      const first = items[0];
      const lastItem = items[items.length - 1];
      if (
        e.shiftKey &&
        (document.activeElement === first || document.activeElement === cardRef.current)
      ) {
        e.preventDefault();
        lastItem.focus();
      } else if (!e.shiftKey && document.activeElement === lastItem) {
        e.preventDefault();
        first.focus();
      }
    }
  };

  // Tarjeta: debajo del elemento resaltado si cabe; si no, encima o al lado
  // (pantallas anchas); en el móvil, abajo o arriba según dónde quede el hueco.
  // Nunca tapa el elemento resaltado.
  let cardStyle: React.CSSProperties | undefined;
  if (rect) {
    const vh = window.innerHeight;
    const vw = window.innerWidth;
    const gap = PAD + 14;
    const below = rect.top + rect.height + gap;
    const above = rect.top - gap - cardH;
    const cardW = Math.min(448, vw - 32);
    if (below + cardH <= vh - 8) {
      cardStyle = wide ? { top: below } : { top: below, bottom: "auto" };
    } else if (above >= 72) {
      cardStyle = { top: above, bottom: "auto" };
    } else if (wide && vw - (rect.left + rect.width + gap) >= cardW + 16) {
      cardStyle = {
        top: Math.min(Math.max(72, rect.top), vh - cardH - 16),
        bottom: "auto",
        left: rect.left + rect.width + gap,
        right: "auto",
        width: cardW,
      };
    } else if (wide && rect.left - gap >= cardW + 16) {
      cardStyle = {
        top: Math.min(Math.max(72, rect.top), vh - cardH - 16),
        bottom: "auto",
        left: rect.left - gap - cardW,
        right: "auto",
        width: cardW,
      };
    } else if (wide) {
      cardStyle = { top: Math.max(72, vh - cardH - 16) };
    }
  }

  return (
    <div
      className={cn("fixed inset-0 z-[60]", interactive && "pointer-events-none")}
      data-testid={testId}
    >
      {rect ? (
        <div
          aria-hidden
          className="ring-accent pointer-events-none fixed rounded-xl ring-4 transition-all duration-300 motion-reduce:transition-none"
          style={{
            top: rect.top - PAD,
            left: rect.left - PAD,
            width: rect.width + PAD * 2,
            height: rect.height + PAD * 2,
            boxShadow: `0 0 0 9999px ${SHADE}`,
          }}
        />
      ) : (
        <div aria-hidden className="fixed inset-0" style={{ background: SHADE }} />
      )}
      {interactive && rect && (
        // Cuatro bloques transparentes alrededor del hueco: el elemento
        // resaltado se puede pulsar, el resto de la página no.
        <div aria-hidden>
          <div
            className="pointer-events-auto fixed inset-x-0 top-0"
            style={{ height: rect.top - PAD }}
          />
          <div
            className="pointer-events-auto fixed inset-x-0 bottom-0"
            style={{ top: rect.top + rect.height + PAD }}
          />
          <div
            className="pointer-events-auto fixed left-0"
            style={{ top: rect.top - PAD, height: rect.height + PAD * 2, width: rect.left - PAD }}
          />
          <div
            className="pointer-events-auto fixed right-0"
            style={{
              top: rect.top - PAD,
              height: rect.height + PAD * 2,
              left: rect.left + rect.width + PAD,
            }}
          />
        </div>
      )}
      <div
        ref={cardRef}
        role="dialog"
        aria-modal={!interactive}
        aria-labelledby={titleId}
        aria-describedby={bodyId}
        tabIndex={-1}
        onKeyDown={onKeyDown}
        className={cn(
          "bg-background border-border pointer-events-auto fixed inset-x-4 bottom-4 mx-auto max-w-md rounded-2xl border p-5 shadow-2xl outline-none sm:p-6",
          rect ? "sm:bottom-auto" : "sm:top-1/2 sm:bottom-auto sm:-translate-y-1/2",
        )}
        style={cardStyle}
      >
        <div className="flex items-start justify-between gap-3">
          <p className="text-accent text-xs font-bold tracking-wider uppercase">
            {t("stepOf", { n: step + 1, total: steps.length })}
          </p>
          <button
            type="button"
            onClick={onClose}
            className="text-muted-foreground hover:bg-surface -mt-1 -mr-1 rounded-md p-1.5"
            aria-label={t("close")}
            data-testid="tour-close"
          >
            <X className="size-4" aria-hidden />
          </button>
        </div>
        <h2 id={titleId} className="mt-2 text-xl font-extrabold">
          {ts(`steps.${current.key}.title`)}
        </h2>
        <p id={bodyId} className="text-muted-foreground mt-2">
          {ts(`steps.${current.key}.body`)}
        </p>
        {last && lastExtra}
        <div className="mt-5 flex items-center justify-between gap-2">
          <div className="flex gap-1.5" aria-hidden>
            {steps.map((s, i) => (
              <span
                key={s.key}
                className={cn("size-2 rounded-full", i === step ? "bg-accent" : "bg-border")}
              />
            ))}
          </div>
          <div className="flex gap-2">
            {step === 0 ? (
              <Button variant="ghost" size="sm" onClick={onClose}>
                {t("skip")}
              </Button>
            ) : (
              <Button variant="outline" size="sm" onClick={() => setStep(step - 1)}>
                {t("back")}
              </Button>
            )}
            <Button
              variant="accent"
              size="sm"
              onClick={() => (last ? onClose() : setStep(step + 1))}
              data-testid="tour-next"
            >
              {last ? finishLabel : step === 0 ? t("start") : t("next")}
            </Button>
          </div>
        </div>
      </div>
    </div>
  );
}
