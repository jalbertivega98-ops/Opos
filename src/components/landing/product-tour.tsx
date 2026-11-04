"use client";

import { useRef, useState, type KeyboardEvent, type ReactNode } from "react";
import { BarChart3, Check, ClipboardList, FileCheck2, Flame, RefreshCcw, X } from "lucide-react";
import { cn } from "@/lib/utils";

export type TourTab = {
  id: "training" | "results" | "progress";
  label: string;
  title: string;
  body: string;
  points: { title: string; body: string; soon?: string }[];
};

const ICONS = { training: ClipboardList, results: RefreshCcw, progress: BarChart3 } as const;

/**
 * Presentación del producto en pestañas (entrenamiento, resultados, progreso).
 * Pestañas accesibles: flechas, Inicio y Fin mueven el foco; cada panel lleva
 * una vista de ejemplo marcada como tal (no son datos de ningún alumno).
 */
export function ProductTour({
  tabs,
  exampleLabel,
  labels,
}: {
  tabs: TourTab[];
  exampleLabel: string;
  labels: Record<string, string>;
}) {
  const [active, setActive] = useState(0);
  const refs = useRef<(HTMLButtonElement | null)[]>([]);

  function onKey(e: KeyboardEvent) {
    const last = tabs.length - 1;
    const next =
      e.key === "ArrowRight"
        ? active === last
          ? 0
          : active + 1
        : e.key === "ArrowLeft"
          ? active === 0
            ? last
            : active - 1
          : e.key === "Home"
            ? 0
            : e.key === "End"
              ? last
              : null;
    if (next === null) return;
    e.preventDefault();
    setActive(next);
    refs.current[next]?.focus();
  }

  const tab = tabs[active];
  return (
    <div>
      <div
        role="tablist"
        aria-label={labels.tablist}
        onKeyDown={onKey}
        className="bg-background border-border mx-auto flex w-full max-w-xl gap-1 rounded-2xl border p-1.5"
      >
        {tabs.map((tb, i) => {
          const Icon = ICONS[tb.id];
          const selected = i === active;
          return (
            <button
              key={tb.id}
              ref={(el) => {
                refs.current[i] = el;
              }}
              role="tab"
              id={`tour-tab-${tb.id}`}
              aria-selected={selected}
              aria-controls={`tour-panel-${tb.id}`}
              tabIndex={selected ? 0 : -1}
              onClick={() => setActive(i)}
              className={cn(
                "press flex min-h-11 flex-1 items-center justify-center gap-2 rounded-xl px-2 text-sm font-semibold",
                selected
                  ? "bg-ink text-ink-foreground shadow"
                  : "text-muted-foreground hover:text-foreground",
              )}
            >
              <Icon className="size-4" aria-hidden />
              {tb.label}
            </button>
          );
        })}
      </div>

      <div
        key={tab.id}
        role="tabpanel"
        id={`tour-panel-${tab.id}`}
        aria-labelledby={`tour-tab-${tab.id}`}
        tabIndex={0}
        className="animate-fade-up mt-8 grid gap-8 rounded-3xl outline-none lg:grid-cols-[1fr_1.1fr] lg:items-center"
      >
        <div>
          <h3 className="text-2xl font-extrabold sm:text-3xl">{tab.title}</h3>
          <p className="text-muted-foreground mt-3 text-lg">{tab.body}</p>
          <ul className="mt-6 space-y-4">
            {tab.points.map((p) => (
              <li key={p.title} className="flex gap-3">
                <span className="bg-accent-soft text-accent mt-0.5 grid size-6 shrink-0 place-items-center rounded-full">
                  <Check className="size-3.5" aria-hidden />
                </span>
                <span>
                  <span className="flex flex-wrap items-center gap-2 font-semibold">
                    {p.title}
                    {p.soon && (
                      <span className="bg-surface-2 text-warning rounded-full px-2 py-0.5 text-[11px] font-bold">
                        {p.soon}
                      </span>
                    )}
                  </span>
                  <span className="text-muted-foreground block text-sm">{p.body}</span>
                </span>
              </li>
            ))}
          </ul>
        </div>
        <Mockup example={exampleLabel}>
          {tab.id === "training" ? (
            <TrainingView labels={labels} />
          ) : tab.id === "results" ? (
            <ResultsView labels={labels} />
          ) : (
            <ProgressView labels={labels} />
          )}
        </Mockup>
      </div>
    </div>
  );
}

function Mockup({ children, example }: { children: ReactNode; example: string }) {
  return (
    <figure className="bg-surface-2 relative rounded-3xl p-3 sm:p-5">
      <figcaption className="bg-highlight-soft text-highlight-foreground dark:text-highlight absolute -top-3 left-5 rounded-full px-3 py-1 text-[11px] font-bold">
        {example}
      </figcaption>
      <div aria-hidden className="border-border bg-background rounded-2xl border p-5 shadow-lg">
        {children}
      </div>
    </figure>
  );
}

function TrainingView({ labels }: { labels: Record<string, string> }) {
  return (
    <div className="space-y-4">
      <div className="flex items-center justify-between text-xs font-semibold">
        <span>{labels.trainingHeader}</span>
        <span className="bg-ink text-ink-foreground rounded-md px-2 py-1 tabular-nums">24:13</span>
      </div>
      <div className="bg-surface h-1.5 overflow-hidden rounded-full">
        <div className="bg-accent h-full w-2/5 rounded-full" />
      </div>
      <div className="space-y-2">
        <div className="bg-surface-2 h-3 w-11/12 rounded-full" />
        <div className="bg-surface-2 h-3 w-3/5 rounded-full" />
      </div>
      <div className="grid gap-2">
        {["A", "B", "C", "D"].map((l, i) => (
          <div
            key={l}
            className={cn(
              "flex items-center gap-3 rounded-xl border-2 px-3 py-2.5 text-sm",
              i === 2 ? "border-accent bg-accent-soft" : "border-border",
            )}
          >
            <span className="text-muted-foreground font-bold">{l}</span>
            <span className="bg-surface-2 h-2 rounded-full" style={{ width: `${45 + i * 9}%` }} />
          </div>
        ))}
      </div>
      <div className="flex justify-between text-xs">
        <span className="text-muted-foreground">{labels.blank}</span>
        <span className="text-accent font-semibold">{labels.next} →</span>
      </div>
    </div>
  );
}

function ResultsView({ labels }: { labels: Record<string, string> }) {
  const rows = [true, true, false, true, false];
  return (
    <div className="space-y-4">
      <div className="flex items-end justify-between">
        <div>
          <p className="text-muted-foreground text-xs font-semibold">{labels.resultsHeader}</p>
          <p className="font-display text-4xl font-extrabold tabular-nums">6,8</p>
        </div>
        <span className="bg-accent-soft text-success rounded-full px-3 py-1 text-xs font-bold">
          {labels.passed}
        </span>
      </div>
      <ul className="space-y-1.5">
        {rows.map((ok, i) => (
          <li
            key={i}
            className={cn(
              "flex items-center gap-2 rounded-lg px-3 py-2 text-xs",
              ok ? "bg-surface" : "bg-danger-soft",
            )}
          >
            {ok ? (
              <Check className="text-success size-3.5" />
            ) : (
              <X className="text-danger size-3.5" />
            )}
            <span className="bg-surface-2 h-1.5 flex-1 rounded-full" />
            {!ok && <span className="text-danger font-semibold">{labels.toReview}</span>}
          </li>
        ))}
      </ul>
      <div className="border-border flex items-start gap-2 rounded-xl border p-3 text-xs">
        <FileCheck2 className="text-accent size-4 shrink-0" />
        <span>
          <span className="block font-semibold">{labels.explanation}</span>
          <span className="text-muted-foreground">{labels.source}</span>
        </span>
      </div>
    </div>
  );
}

function ProgressView({ labels }: { labels: Record<string, string> }) {
  const bars = [30, 55, 40, 70, 62, 85, 78];
  const topics = [
    [labels.topicA, 82],
    [labels.topicB, 64],
    [labels.topicC, 38],
  ] as const;
  return (
    <div className="space-y-5">
      <div className="flex items-center justify-between">
        <p className="text-xs font-semibold">{labels.progressHeader}</p>
        <span className="text-warning inline-flex items-center gap-1 text-xs font-bold">
          <Flame className="size-3.5" /> {labels.streak}
        </span>
      </div>
      <div className="flex h-24 items-end gap-2">
        {bars.map((h, i) => (
          <div
            key={i}
            className="bg-accent-soft relative flex-1 overflow-hidden rounded-md"
            style={{ height: `${h}%` }}
          >
            <div className="bg-accent absolute inset-x-0 bottom-0 h-3/4" />
          </div>
        ))}
      </div>
      <ul className="space-y-2.5 text-xs">
        {topics.map(([name, v]) => (
          <li key={name} className="flex items-center gap-3">
            <span className="w-24 shrink-0 truncate font-medium">{name}</span>
            <span className="bg-surface-2 h-2 flex-1 overflow-hidden rounded-full">
              <span
                className={cn("block h-full rounded-full", v < 50 ? "bg-highlight" : "bg-accent")}
                style={{ width: `${v}%` }}
              />
            </span>
            <span className="w-8 text-right tabular-nums">{v}%</span>
          </li>
        ))}
      </ul>
    </div>
  );
}
