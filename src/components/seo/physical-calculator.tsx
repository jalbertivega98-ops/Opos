"use client";

import { useId, useState } from "react";
import { useLocale, useTranslations } from "next-intl";
import { getPhysicalGuide, physicalScore, type Sex } from "@/lib/seo/physical-tests";

const tr = (l: { es: string; ca: string }, locale: string) => (locale === "ca" ? l.ca : l.es);

/** Calculadora orientativa de la nota de la prueba física con los baremos oficiales (ADR-052). */
export function PhysicalCalculator({ examSlug }: { examSlug: string }) {
  const t = useTranslations("seo.physical");
  const locale = useLocale();
  const id = useId();
  const guide = getPhysicalGuide(examSlug);
  const [sex, setSex] = useState<Sex>("women");
  const [marks, setMarks] = useState<string[]>(() => guide?.exercises.map(() => "") ?? []);
  if (!guide) return null;

  const parsed = marks.map((m) => {
    const n = Number(m.replace(",", "."));
    return m.trim() === "" || !Number.isFinite(n) ? null : n;
  });
  const complete = parsed.every((m) => m !== null);
  const result = physicalScore(guide, sex, parsed);
  const fmt = (n: number) =>
    n.toLocaleString(locale === "ca" ? "ca-ES" : "es-ES", { maximumFractionDigits: 2 });

  return (
    <div className="border-border rounded-2xl border p-5" data-testid="physical-calculator">
      <fieldset>
        <legend className="font-semibold">{t("sex")}</legend>
        <div className="mt-2 flex gap-2">
          {(["women", "men"] as const).map((s) => (
            <label
              key={s}
              className="border-input has-[:checked]:border-accent has-[:checked]:bg-accent/10 flex min-h-11 cursor-pointer items-center gap-2 rounded-lg border px-4"
            >
              <input
                type="radio"
                name={`${id}-sex`}
                value={s}
                checked={sex === s}
                onChange={() => setSex(s)}
              />
              {t(s)}
            </label>
          ))}
        </div>
      </fieldset>

      <div className="mt-5 grid gap-4 sm:grid-cols-3">
        {guide.exercises.map((ex, i) => (
          <div key={ex.key}>
            <label htmlFor={`${id}-${ex.key}`} className="block text-sm font-medium">
              {tr(ex.name, locale)}
            </label>
            <div className="mt-1 flex items-center gap-2">
              <input
                id={`${id}-${ex.key}`}
                inputMode="decimal"
                type="number"
                min={0}
                step={ex.inputStep}
                value={marks[i]}
                onChange={(e) => setMarks((m) => m.map((v, j) => (j === i ? e.target.value : v)))}
                className="border-input bg-background h-11 w-full rounded-lg border px-3"
                data-testid={`physical-mark-${ex.key}`}
              />
              <span className="text-muted-foreground text-sm">{tr(ex.unit, locale)}</span>
            </div>
            {parsed[i] !== null && (
              <p className="mt-1 text-sm" data-testid={`physical-points-${ex.key}`}>
                {t("points", { points: result.points[i] })}
              </p>
            )}
          </div>
        ))}
      </div>

      <div className="bg-surface-2 mt-5 rounded-xl p-4" aria-live="polite">
        {complete ? (
          <>
            <p className="text-lg font-semibold" data-testid="physical-total">
              {t("total", { total: fmt(result.total) })}
            </p>
            <p className={result.passed ? "text-success mt-1" : "text-danger mt-1"}>
              {result.passed
                ? t("passed")
                : result.failedExercises.length > 0
                  ? t("failedMin")
                  : t("failed", { pass: guide.passMark })}
            </p>
          </>
        ) : (
          <p className="text-muted-foreground">{t("fillAll")}</p>
        )}
      </div>
      <p className="text-muted-foreground mt-3 text-xs">{t("calculatorNote")}</p>
    </div>
  );
}
