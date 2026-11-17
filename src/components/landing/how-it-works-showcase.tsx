"use client";

import { useCallback, useEffect, useId, useRef, useState, type CSSProperties } from "react";
import Image from "next/image";
import { CalendarCheck, Compass, RefreshCcw, Search, type LucideIcon } from "lucide-react";
import { useAuth } from "@/components/auth/use-auth";
import { openVisitorTour } from "@/components/landing/visitor-tour";
import { cn } from "@/lib/utils";

export type ShowcaseStep = {
  title: string;
  body: string;
  /** Captura real de la web (móvil), en `public/como-funciona/`. */
  image: string;
  alt: string;
  /** Etiqueta flotante junto al móvil. */
  chip: string;
};

const ICONS: LucideIcon[] = [Search, CalendarCheck, RefreshCcw];
/** Punto que «pulsa» sobre la captura: dónde tocaría el alumno en cada paso (% del marco). */
const TAPS: { x: number; y: number }[] = [
  { x: 50, y: 63 }, // la ficha de Mossos en el catálogo
  { x: 58, y: 68.5 }, // «Empezar test» del primer tema del plan
  { x: 50, y: 26 }, // la respuesta correcta del test
];
const STEP_MS = 5500;

/**
 * «Cómo funciona» en movimiento (ADR-062): tres pasos que avanzan solos mientras
 * la sección está a la vista, cada uno con una captura real de la web dentro de
 * un móvil. Pulsar un paso lo fija (y para el avance automático). Con «reducir
 * movimiento» no avanza solo ni anima. Para visitantes sin cuenta, «Ver la guía»
 * abre el recorrido guiado de la portada.
 */
export function HowItWorksShowcase({
  steps,
  labels,
}: {
  steps: ShowcaseStep[];
  labels: { guide: string; guideHint: string; stepsLabel: string; stepN: string[] };
}) {
  const [active, setActive] = useState(0);
  const [visible, setVisible] = useState(false);
  const [paused, setPaused] = useState(false);
  const rootRef = useRef<HTMLDivElement>(null);
  const tabRefs = useRef<(HTMLButtonElement | null)[]>([]);
  const { status } = useAuth();
  const base = useId();

  // Solo avanza solo si se ve la sección y no se ha pedido reducir movimiento.
  useEffect(() => {
    const el = rootRef.current;
    if (!el || typeof IntersectionObserver === "undefined") return;
    if (window.matchMedia("(prefers-reduced-motion: reduce)").matches) return;
    const io = new IntersectionObserver(([entry]) => setVisible(entry.isIntersecting), {
      threshold: 0.35,
    });
    io.observe(el);
    return () => io.disconnect();
  }, []);

  const running = visible && !paused;

  useEffect(() => {
    if (!running) return;
    const id = window.setTimeout(() => setActive((a) => (a + 1) % steps.length), STEP_MS);
    return () => window.clearTimeout(id);
  }, [running, active, steps.length]);

  const choose = useCallback((i: number) => {
    setActive(i);
    setPaused(true);
  }, []);

  const onKeyDown = (e: React.KeyboardEvent) => {
    const fwd = e.key === "ArrowDown" || e.key === "ArrowRight";
    const back = e.key === "ArrowUp" || e.key === "ArrowLeft";
    if (!fwd && !back) return;
    e.preventDefault();
    const next = (active + (fwd ? 1 : -1) + steps.length) % steps.length;
    choose(next);
    tabRefs.current[next]?.focus();
  };

  return (
    <div
      ref={rootRef}
      className="mt-10 grid items-center gap-10 lg:grid-cols-2 lg:gap-16 2xl:gap-24"
      data-testid="how-showcase"
    >
      <div className="max-w-2xl">
        <div
          role="tablist"
          aria-label={labels.stepsLabel}
          aria-orientation="vertical"
          data-tour="v-how"
          className="grid gap-3"
          onKeyDown={onKeyDown}
        >
          {steps.map((s, i) => {
            const Icon = ICONS[i] ?? Search;
            const on = i === active;
            return (
              <button
                key={s.title}
                ref={(n) => {
                  tabRefs.current[i] = n;
                }}
                type="button"
                role="tab"
                id={`${base}-tab-${i}`}
                aria-selected={on}
                aria-controls={`${base}-panel`}
                tabIndex={on ? 0 : -1}
                onClick={() => choose(i)}
                data-testid={`how-step-${i + 1}`}
                className={cn(
                  "relative overflow-hidden rounded-2xl border p-4 text-left transition-[background-color,border-color,box-shadow] duration-300 sm:p-5",
                  on
                    ? "border-accent/50 bg-background shadow-lg shadow-black/5"
                    : "hover:bg-surface border-transparent",
                )}
              >
                <span className="flex items-start gap-4">
                  <span
                    className={cn(
                      "font-display grid size-11 shrink-0 place-items-center rounded-xl text-xl font-extrabold tabular-nums transition-colors",
                      on ? "bg-accent text-accent-foreground" : "bg-surface text-muted-foreground",
                    )}
                    aria-hidden
                  >
                    {i + 1}
                  </span>
                  <span className="min-w-0 flex-1">
                    <span className="text-muted-foreground flex items-center gap-1.5 text-xs font-semibold tracking-wider uppercase">
                      <Icon className="size-3.5" aria-hidden />
                      {labels.stepN[i]}
                    </span>
                    <span className="mt-1 block text-lg font-bold sm:text-xl">{s.title}</span>
                    <span
                      className={cn(
                        "text-muted-foreground grid transition-[grid-template-rows,opacity,margin] duration-500 motion-reduce:transition-none",
                        on ? "mt-1.5 grid-rows-[1fr] opacity-100" : "grid-rows-[0fr] opacity-0",
                      )}
                    >
                      <span className="overflow-hidden">{s.body}</span>
                    </span>
                  </span>
                </span>
                {/* Barra de tiempo del paso activo mientras avanza solo. */}
                {on && running && (
                  <span
                    key={`bar-${active}`}
                    aria-hidden
                    className="how-progress bg-accent absolute bottom-0 left-0 h-1 w-full"
                    style={{ "--how-ms": `${STEP_MS}ms` } as CSSProperties}
                  />
                )}
              </button>
            );
          })}
        </div>

        {status === "anon" && (
          <div className="mt-6 flex flex-col gap-2 sm:flex-row sm:items-center sm:gap-4">
            <button
              type="button"
              onClick={openVisitorTour}
              className="bg-ink text-ink-foreground hover:bg-ink/90 inline-flex min-h-12 shrink-0 items-center justify-center gap-2 rounded-xl px-5 font-semibold whitespace-nowrap transition-colors"
              data-testid="how-guide"
            >
              <Compass className="size-5" aria-hidden />
              {labels.guide}
            </button>
            <p className="text-muted-foreground text-sm">{labels.guideHint}</p>
          </div>
        )}
      </div>

      {/* Móvil con la captura del paso activo. */}
      <div
        id={`${base}-panel`}
        role="tabpanel"
        aria-labelledby={`${base}-tab-${active}`}
        className="relative mx-auto w-full max-w-[240px] sm:max-w-[280px] lg:w-[290px] lg:max-w-none 2xl:w-[330px]"
      >
        <div
          aria-hidden
          className="bg-accent/20 dark:bg-accent/10 absolute -inset-6 -z-10 rounded-[3rem] blur-3xl"
        />
        <div className="border-ink bg-background relative aspect-[9/18.5] overflow-hidden rounded-[2.4rem] border-[10px] shadow-2xl shadow-black/20 dark:border-neutral-700">
          {steps.map((s, i) => (
            <div
              key={s.image}
              className={cn(
                "absolute inset-0 transition-[opacity,transform] duration-700 ease-out motion-reduce:transition-none",
                i === active ? "translate-y-0 opacity-100" : "translate-y-6 opacity-0",
              )}
              aria-hidden={i !== active}
            >
              <Image
                src={s.image}
                alt={i === active ? s.alt : ""}
                fill
                sizes="(min-width: 1536px) 330px, (min-width: 640px) 290px, 240px"
                className="object-cover object-top"
              />
            </div>
          ))}
          {/* Toque animado: dónde pulsarías en este paso. */}
          <span
            key={`tap-${active}`}
            aria-hidden
            className="how-tap pointer-events-none absolute z-10 size-10 rounded-full"
            style={{ left: `${TAPS[active]?.x ?? 50}%`, top: `${TAPS[active]?.y ?? 50}%` }}
          />
        </div>
        <span
          key={`chip-${active}`}
          aria-hidden
          className="how-chip border-border bg-background absolute bottom-20 -left-6 z-10 inline-flex max-w-[14rem] items-center gap-2 rounded-xl border px-3 py-2 text-xs font-semibold shadow-lg sm:-left-16"
        >
          <span className="bg-success size-2 shrink-0 rounded-full" />
          {steps[active]?.chip}
        </span>
      </div>
    </div>
  );
}
