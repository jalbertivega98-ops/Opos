import { getTranslations } from "next-intl/server";
import { Check, Minus, X } from "lucide-react";
import { Badge } from "@/components/ui/card";
import { cn } from "@/lib/utils";
import type { PresentedQuestion, QuestionExplanation } from "@/lib/learning/questions/schema";

const LETTERS = "ABCDEF";

export type AnsweredQuestion = {
  position: number;
  presented: PresentedQuestion;
  chosen_index: number | null;
  is_correct: boolean | null;
  answer_index: number | null;
  explanation: QuestionExplanation | null;
  reviewed_at?: string | null;
};

/** Corrección de una sesión de preguntas, con explicación y referencia. */
export async function QuestionReview({ items }: { items: AnsweredQuestion[] }) {
  const t = await getTranslations("questions");
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
              <Check className="text-success size-5" aria-label={t("correct")} />
            ) : it.chosen_index === null ? (
              <Minus className="text-muted-foreground size-5" aria-label={t("blank")} />
            ) : (
              <X className="text-danger size-5" aria-label={t("wrongShort")} />
            )}
            <span className="font-medium">{t("item", { n: n + 1 })}</span>
            {it.presented.ref && <Badge>{it.presented.ref}</Badge>}
            {it.reviewed_at && <Badge tone="success">{t("resolved")}</Badge>}
          </div>
          <p className="font-medium">{it.presented.stem}</p>
          <ul className="space-y-1 text-sm">
            {it.presented.options.map((o, i) => (
              <li
                key={i}
                className={cn(
                  "flex gap-2 rounded-lg px-2 py-1",
                  i === it.answer_index && "bg-accent-soft font-semibold",
                  i === it.chosen_index && !it.is_correct && "bg-danger-soft line-through",
                )}
              >
                <span>{LETTERS[i]})</span> <span>{o}</span>
              </li>
            ))}
          </ul>
          {it.explanation?.text && (
            <p className="text-muted-foreground text-sm">{it.explanation.text}</p>
          )}
        </li>
      ))}
    </ol>
  );
}
