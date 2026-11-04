"use client";

import { useTranslations } from "next-intl";
import type { Presentation, PsychoType } from "@/lib/learning/psycho/types";
import { Token, useTokenText } from "./token";

/** Enunciado de un psicotécnico según su presentación. */
export function PsychoStem({
  type,
  presentation,
}: {
  type: PsychoType;
  presentation: Presentation;
}) {
  const t = useTranslations("psycho");
  const text = useTokenText();
  const values = (v?: Record<string, string | number>) =>
    Object.fromEntries(Object.entries(v ?? {}).map(([k, x]) => [k, text(x)]));

  switch (presentation.kind) {
    case "sequence":
      return (
        <div className="space-y-3">
          <p className="font-medium">{t(`types.${type}.prompt`)}</p>
          <p
            className="font-display text-2xl font-bold tracking-wide break-words sm:text-3xl"
            data-testid="psycho-stem"
          >
            {presentation.terms.join(", ")}, <span className="text-accent">?</span>
          </p>
        </div>
      );
    case "text":
      return (
        <p className="text-lg" data-testid="psycho-stem">
          {t(`problems.${presentation.key}`, values(presentation.values))}
        </p>
      );
    case "analogy":
      return (
        <div className="space-y-3">
          <p className="font-medium">{t(`types.${type}.prompt`)}</p>
          <p className="font-display text-xl font-bold sm:text-2xl" data-testid="psycho-stem">
            <Token value={presentation.a} /> <span className="text-muted-foreground">→</span>{" "}
            <Token value={presentation.b} />
            <span className="text-muted-foreground"> · </span>
            <Token value={presentation.c} /> <span className="text-muted-foreground">→</span>{" "}
            <span className="text-accent">?</span>
          </p>
        </div>
      );
    case "matrix":
      return (
        <div className="space-y-3">
          <p className="font-medium">{t(`types.${type}.prompt`)}</p>
          <div
            className="border-border mx-auto grid w-fit gap-1 rounded-xl border p-2"
            style={{ gridTemplateColumns: `repeat(${presentation.size}, minmax(0, 1fr))` }}
            data-testid="psycho-stem"
          >
            {presentation.cells.map((c, i) => (
              <div
                key={i}
                className="bg-surface flex size-20 items-center justify-center rounded-lg sm:size-24"
              >
                {c ? (
                  <Token value={c} />
                ) : (
                  <span className="text-accent text-2xl font-bold">?</span>
                )}
              </div>
            ))}
          </div>
        </div>
      );
    case "figure":
      return (
        <div className="space-y-3">
          <p className="font-medium">{t(`figures.${presentation.key}`)}</p>
          <div className="flex justify-center" data-testid="psycho-stem">
            <Token value={presentation.figure} className="scale-125 p-3" />
          </div>
        </div>
      );
    case "grid":
      return (
        <div className="space-y-3">
          <p className="font-medium">
            {t(`problems.${presentation.key}`, values(presentation.values))}
          </p>
          <div
            className="bg-surface overflow-x-auto rounded-xl p-3 font-mono text-lg tracking-[0.3em] sm:text-xl"
            data-testid="psycho-stem"
          >
            {presentation.rows.map((r, i) => (
              <div key={i}>{r}</div>
            ))}
          </div>
        </div>
      );
    case "table":
      return (
        <div className="space-y-3">
          <p className="font-medium">
            {t(`problems.${presentation.key}`, values(presentation.values))}
          </p>
          <div
            className="border-border overflow-x-auto rounded-xl border"
            data-testid="psycho-stem"
          >
            <table className="w-full text-sm">
              <caption className="sr-only">
                {text(String(presentation.values?.table ?? ""))}
              </caption>
              <thead className="bg-surface">
                <tr>
                  {presentation.header.map((h) => (
                    <th key={h} scope="col" className="px-2 py-1.5 text-left font-semibold">
                      <Token value={h} />
                    </th>
                  ))}
                </tr>
              </thead>
              <tbody>
                {presentation.rows.map((r, i) => (
                  <tr key={i} className="border-border border-t">
                    {r.map((c, j) => (
                      <td key={j} className="px-2 py-1 whitespace-nowrap tabular-nums">
                        <Token value={c} />
                      </td>
                    ))}
                  </tr>
                ))}
              </tbody>
            </table>
          </div>
        </div>
      );
  }
}

export function useExplain() {
  const t = useTranslations("psycho");
  const text = useTokenText();
  return (e: { key: string; values?: Record<string, string | number> }) =>
    t(
      `rules.${e.key}`,
      Object.fromEntries(Object.entries(e.values ?? {}).map(([k, v]) => [k, text(v)])),
    );
}
