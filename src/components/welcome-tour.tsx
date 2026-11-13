"use client";

import { useCallback, useEffect, useId, useLayoutEffect, useRef, useState } from "react";
import { useTranslations } from "next-intl";
import { X } from "lucide-react";
import { Button } from "@/components/ui/button";
import { Link } from "@/i18n/navigation";
import { completeWelcomeTourAction } from "@/lib/tour/actions";
import { cn } from "@/lib/utils";

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

type Rect = { top: number; left: number; width: number; height: number };
const PAD = 6;

/**
 * Tutorial guiado de la zona del alumno (ADR-055). Sale solo la primera vez
 * (`persist`: al cerrarlo o terminarlo se guarda en el perfil) o cuando el
 * alumno lo pide desde «Mi perfil» (`/app?tutorial=1`, sin guardar nada).
 */
export function WelcomeTour({ persist }: { persist: boolean }) {
  const t = useTranslations("tour");
  const [open, setOpen] = useState(true);
  const [step, setStep] = useState(0);
  const [rect, setRect] = useState<Rect | null>(null);
  const [wide, setWide] = useState(false);
  const cardRef = useRef<HTMLDivElement>(null);
  const titleId = useId();
  const bodyId = useId();
  const current = TOUR_STEPS[step];
  const last = step === TOUR_STEPS.length - 1;

  const close = useCallback(() => {
    setOpen(false);
    if (persist) void completeWelcomeTourAction();
  }, [persist]);

  // Posición del elemento resaltado (se recalcula al cambiar de paso, al
  // desplazar y al redimensionar).
  const measure = useCallback(() => {
    if (!current.target) return setRect(null);
    const node = document.querySelector<HTMLElement>(`[data-tour="${current.target}"]`);
    if (!node) return setRect(null);
    const r = node.getBoundingClientRect();
    if (r.width === 0 && r.height === 0) return setRect(null);
    setRect({ top: r.top, left: r.left, width: r.width, height: r.height });
  }, [current.target]);

  useLayoutEffect(() => {
    if (!open) return;
    if (current.target) {
      const node = document.querySelector<HTMLElement>(`[data-tour="${current.target}"]`);
      const reduce = window.matchMedia("(prefers-reduced-motion: reduce)").matches;
      node?.scrollIntoView({
        block: "nearest",
        inline: "center",
        behavior: reduce ? "auto" : "smooth",
      });
    }
    const raf = window.requestAnimationFrame(measure);
    const id = window.setTimeout(measure, 350);
    return () => {
      window.cancelAnimationFrame(raf);
      window.clearTimeout(id);
    };
  }, [open, current.target, measure]);

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
    if (!open) return;
    window.addEventListener("resize", measure);
    window.addEventListener("scroll", measure, true);
    return () => {
      window.removeEventListener("resize", measure);
      window.removeEventListener("scroll", measure, true);
    };
  }, [open, measure]);

  // Foco en la tarjeta en cada paso; Escape cierra; Tab no sale del diálogo.
  useEffect(() => {
    if (!open) return;
    cardRef.current?.focus();
  }, [open, step]);

  const onKeyDown = (e: React.KeyboardEvent<HTMLDivElement>) => {
    if (e.key === "Escape") {
      e.preventDefault();
      close();
    } else if (e.key === "Tab" && cardRef.current) {
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

  if (!open) return null;

  // Tarjeta: debajo del elemento resaltado en pantallas anchas; abajo del todo
  // en el móvil (los enlaces de la navegación están arriba).
  const cardTop = rect
    ? Math.min(rect.top + rect.height + PAD + 14, window.innerHeight - 280)
    : null;

  return (
    <div className="fixed inset-0 z-[60]" data-testid="welcome-tour">
      {rect ? (
        <div
          aria-hidden
          className="ring-accent pointer-events-none fixed rounded-xl ring-4 transition-all duration-300 motion-reduce:transition-none"
          style={{
            top: rect.top - PAD,
            left: rect.left - PAD,
            width: rect.width + PAD * 2,
            height: rect.height + PAD * 2,
            boxShadow: "0 0 0 9999px rgba(7, 17, 31, 0.62)",
          }}
        />
      ) : (
        <div aria-hidden className="fixed inset-0 bg-[rgba(7,17,31,0.62)]" />
      )}
      <div
        ref={cardRef}
        role="dialog"
        aria-modal="true"
        aria-labelledby={titleId}
        aria-describedby={bodyId}
        tabIndex={-1}
        onKeyDown={onKeyDown}
        className={cn(
          "bg-background border-border fixed inset-x-4 bottom-4 mx-auto max-w-md rounded-2xl border p-5 shadow-2xl outline-none sm:p-6",
          rect ? "sm:bottom-auto" : "sm:top-1/2 sm:bottom-auto sm:-translate-y-1/2",
        )}
        style={wide && cardTop !== null ? { top: cardTop } : undefined}
      >
        <div className="flex items-start justify-between gap-3">
          <p className="text-accent text-xs font-bold tracking-wider uppercase">
            {t("stepOf", { n: step + 1, total: TOUR_STEPS.length })}
          </p>
          <button
            type="button"
            onClick={close}
            className="text-muted-foreground hover:bg-surface -mt-1 -mr-1 rounded-md p-1.5"
            aria-label={t("close")}
            data-testid="tour-close"
          >
            <X className="size-4" aria-hidden />
          </button>
        </div>
        <h2 id={titleId} className="mt-2 text-xl font-extrabold">
          {t(`steps.${current.key}.title`)}
        </h2>
        <p id={bodyId} className="text-muted-foreground mt-2">
          {t(`steps.${current.key}.body`)}
        </p>
        {last && (
          <p className="mt-3 text-sm">
            <Link
              href="/#como-funciona"
              className="text-accent font-semibold hover:underline"
              onClick={close}
            >
              {t("videosLink")}
            </Link>
          </p>
        )}
        <div className="mt-5 flex items-center justify-between gap-2">
          <div className="flex gap-1.5" aria-hidden>
            {TOUR_STEPS.map((s, i) => (
              <span
                key={s.key}
                className={cn("size-2 rounded-full", i === step ? "bg-accent" : "bg-border")}
              />
            ))}
          </div>
          <div className="flex gap-2">
            {step === 0 ? (
              <Button variant="ghost" size="sm" onClick={close}>
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
              onClick={() => (last ? close() : setStep(step + 1))}
              data-testid="tour-next"
            >
              {last ? t("finish") : step === 0 ? t("start") : t("next")}
            </Button>
          </div>
        </div>
      </div>
    </div>
  );
}
