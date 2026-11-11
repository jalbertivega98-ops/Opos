"use client";

import { useTranslations } from "next-intl";
import type { Explanation, Presentation, PsychoType } from "@/lib/learning/psycho/types";
import { PsychoStem, useExplain } from "./stem";
import { Token } from "./token";

export type WorkedExample = {
  presentation: Presentation;
  options: string[];
  /** Índice de la opción correcta (son ejemplos fijos, no los del entrenador). */
  solution: number;
  explanation: Explanation;
};

/** Ejemplos resueltos de un tipo de psicotécnico: enunciado, opciones, solución y explicación. */
export function WorkedExamples({ type, items }: { type: PsychoType; items: WorkedExample[] }) {
  const t = useTranslations("seo.psychoType");
  const explain = useExplain();
  return (
    <ol className="mt-6 space-y-4">
      {items.map((it, n) => (
        <li key={n} className="border-border space-y-3 rounded-2xl border p-4 sm:p-5">
          <p className="text-accent text-sm font-semibold">{t("exampleN", { n: n + 1 })}</p>
          <PsychoStem type={type} presentation={it.presentation} testId={null} />
          <ul className="flex flex-wrap gap-2 text-sm" aria-label={t("options")}>
            {it.options.map((o, i) => (
              <li
                key={i}
                className={
                  i === it.solution
                    ? "border-success rounded-lg border-2 px-3 py-1.5 font-semibold"
                    : "border-border rounded-lg border px-3 py-1.5"
                }
              >
                <span className="text-muted-foreground mr-1">{String.fromCharCode(65 + i)}.</span>
                <Token value={o} />
              </li>
            ))}
          </ul>
          <p className="text-sm">
            <span className="font-semibold">
              {t("solution", { letter: String.fromCharCode(65 + it.solution) })}
            </span>{" "}
            <span className="text-muted-foreground">{explain(it.explanation)}</span>
          </p>
        </li>
      ))}
    </ol>
  );
}
