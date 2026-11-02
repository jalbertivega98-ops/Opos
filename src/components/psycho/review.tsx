"use client";

import { useTranslations } from "next-intl";
import { Check, X } from "lucide-react";
import { Badge } from "@/components/ui/card";
import type { Explanation, Presentation, PsychoType } from "@/lib/learning/psycho/types";
import { PsychoStem, useExplain } from "./stem";
import { Token } from "./token";

export type ReviewItem = {
  position: number;
  item_type: string;
  difficulty: number;
  presented: { presentation: Presentation; options: string[] };
  chosen_index: number | null;
  is_correct: boolean | null;
  answer_index: number | null;
  explanation: Explanation | null;
  time_ms?: number | null;
  reviewed_at?: string | null;
};

/** Lista de ejercicios respondidos con la solución y su explicación. */
export function PracticeReview({ items }: { items: ReviewItem[] }) {
  const t = useTranslations("practice");
  const tp = useTranslations("psycho");
  const explain = useExplain();
  return (
    <ol className="mt-3 space-y-3">
      {items.map((it, n) => (
        <li
          key={`${it.position}-${n}`}
          className="border-border space-y-3 rounded-xl border p-4"
          data-testid="review-item"
        >
          <div className="flex flex-wrap items-center gap-2 text-sm">
            {it.is_correct ? (
              <Check className="text-success size-5" aria-label={tp("correct")} />
            ) : (
              <X className="text-danger size-5" aria-label={tp("wrongShort")} />
            )}
            <span className="font-medium">
              {tp.has(`types.${it.item_type}.name`)
                ? tp(`types.${it.item_type}.name`)
                : it.item_type}
            </span>
            <Badge>{tp("difficulty", { level: it.difficulty })}</Badge>
            {it.reviewed_at && <Badge tone="success">{t("resolved")}</Badge>}
            {typeof it.time_ms === "number" && (
              <span className="text-muted-foreground">{Math.round(it.time_ms / 1000)} s</span>
            )}
          </div>
          <PsychoStem type={it.item_type as PsychoType} presentation={it.presented.presentation} />
          <dl className="grid gap-2 text-sm sm:grid-cols-2">
            {it.chosen_index !== null && (
              <div>
                <dt className="text-muted-foreground">{t("yourAnswer")}</dt>
                <dd className="font-semibold">
                  <Token value={it.presented.options[it.chosen_index]} />
                </dd>
              </div>
            )}
            {it.answer_index !== null && (
              <div>
                <dt className="text-muted-foreground">{t("rightAnswer")}</dt>
                <dd className="font-semibold">
                  <Token value={it.presented.options[it.answer_index]} />
                </dd>
              </div>
            )}
          </dl>
          {it.explanation && (
            <p className="text-muted-foreground text-sm">{explain(it.explanation)}</p>
          )}
        </li>
      ))}
    </ol>
  );
}
