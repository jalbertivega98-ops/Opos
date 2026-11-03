"use client";

import { useState } from "react";
import { useTranslations } from "next-intl";
import { Check, RotateCcw, Timer, X } from "lucide-react";
import { cn } from "@/lib/utils";

const SERIES = [2, 6, 12, 20, 30];
const OPTIONS = [36, 40, 42, 44];
const ANSWER = 2;

/**
 * Muestra real del entrenamiento: un ejercicio de series que se puede resolver
 * en la portada (no guarda nada). La explicación es la misma que verías al practicar.
 */
export function ExerciseSample() {
  const t = useTranslations("landing.sample");
  const [chosen, setChosen] = useState<number | null>(null);
  const done = chosen !== null;

  return (
    <div className="border-border bg-background relative rounded-2xl border shadow-xl shadow-black/5">
      <div className="border-border flex items-center justify-between gap-3 border-b px-5 py-3">
        <p className="text-sm font-semibold">{t("kind")}</p>
        <span className="text-muted-foreground inline-flex items-center gap-1.5 text-xs font-medium tabular-nums">
          <Timer className="size-4" aria-hidden />
          {t("progress")}
        </span>
      </div>
      <div className="space-y-5 p-5">
        <div>
          <p className="text-muted-foreground text-sm">{t("prompt")}</p>
          <p
            className="font-display mt-3 flex flex-wrap items-center gap-2 text-2xl font-extrabold tabular-nums sm:text-3xl"
            aria-label={t("seriesLabel", { series: SERIES.join(", ") })}
          >
            {SERIES.map((n) => (
              <span key={n} className="bg-surface rounded-lg px-2.5 py-1">
                {n}
              </span>
            ))}
            <span className="border-accent text-accent rounded-lg border-2 border-dashed px-2.5 py-0.5">
              ?
            </span>
          </p>
        </div>
        <div role="group" aria-label={t("options")} className="grid grid-cols-2 gap-2">
          {OPTIONS.map((o, i) => {
            const isAnswer = i === ANSWER;
            const isChosen = i === chosen;
            return (
              <button
                key={o}
                type="button"
                disabled={done}
                aria-pressed={isChosen}
                onClick={() => setChosen(i)}
                className={cn(
                  "flex min-h-12 items-center justify-between rounded-xl border-2 px-4 text-left text-lg font-bold tabular-nums transition-colors",
                  !done && "border-border hover:border-accent hover:bg-accent-soft",
                  done && isAnswer && "border-success bg-accent-soft text-success",
                  done && isChosen && !isAnswer && "border-danger bg-danger-soft text-danger",
                  done && !isAnswer && !isChosen && "border-border opacity-60",
                )}
              >
                <span>
                  <span className="text-muted-foreground mr-2 text-sm font-semibold">
                    {String.fromCharCode(65 + i)}
                  </span>
                  {o}
                </span>
                {done && isAnswer && <Check className="size-5" aria-hidden />}
                {done && isChosen && !isAnswer && <X className="size-5" aria-hidden />}
              </button>
            );
          })}
        </div>
        <div role="status" aria-live="polite">
          {done ? (
            <div className="bg-surface space-y-2 rounded-xl p-4 text-sm">
              <p className="font-semibold">{chosen === ANSWER ? t("right") : t("wrong")}</p>
              <p className="text-muted-foreground">{t("explanation")}</p>
              <button
                type="button"
                onClick={() => setChosen(null)}
                className="text-accent inline-flex min-h-10 items-center gap-1.5 font-semibold hover:underline"
              >
                <RotateCcw className="size-4" aria-hidden />
                {t("retry")}
              </button>
            </div>
          ) : (
            <p className="text-muted-foreground text-xs">{t("hint")}</p>
          )}
        </div>
      </div>
    </div>
  );
}
