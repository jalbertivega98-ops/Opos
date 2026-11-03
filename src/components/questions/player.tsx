"use client";

import { useRef, useState, useTransition } from "react";
import { useTranslations } from "next-intl";
import { Check, X } from "lucide-react";
import { useRouter } from "@/i18n/navigation";
import { Button } from "@/components/ui/button";
import { Card } from "@/components/ui/card";
import { Alert } from "@/components/ui/form";
import { cn } from "@/lib/utils";
import { answerQuestionAction, type QuestionAnswerResult } from "@/lib/learning/questions/actions";
import type { PresentedQuestion } from "@/lib/learning/questions/schema";

const LETTERS = "ABCDEF";

/** Test de preguntas del banco: responde, ve la corrección y la referencia legal. */
export function QuestionPlayer({
  items,
  sessionId,
  startAt,
}: {
  items: PresentedQuestion[];
  sessionId: string;
  startAt: number;
}) {
  const t = useTranslations("questions");
  const router = useRouter();
  const [index, setIndex] = useState(startAt);
  const [choice, setChoice] = useState<number | null>(null);
  const [result, setResult] = useState<Extract<QuestionAnswerResult, { ok: true }> | null>(null);
  const [error, setError] = useState<string | null>(null);
  const [pending, start] = useTransition();
  const headingRef = useRef<HTMLHeadingElement>(null);
  const item = items[index];

  function answer(i: number) {
    if (result || pending) return;
    setChoice(i);
    setError(null);
    start(async () => {
      const r = await answerQuestionAction({ sessionId, position: index, choice: i });
      if (!r.ok) {
        setChoice(null);
        setError(r.error);
        return;
      }
      setResult(r);
    });
  }

  function next() {
    if (index + 1 >= items.length) {
      router.refresh();
      return;
    }
    setIndex(index + 1);
    setChoice(null);
    setResult(null);
    requestAnimationFrame(() => headingRef.current?.focus());
  }

  return (
    <Card className="space-y-5">
      <div className="text-muted-foreground flex flex-wrap items-center justify-between gap-2 text-sm">
        <h2 ref={headingRef} tabIndex={-1} className="text-foreground font-semibold outline-none">
          {t("question", { n: index + 1, total: items.length })}
        </h2>
        {item.ref && <span>{item.ref}</span>}
      </div>
      <div
        className="bg-surface h-2 overflow-hidden rounded-full"
        role="progressbar"
        aria-label={t("progress")}
        aria-valuemin={0}
        aria-valuemax={items.length}
        aria-valuenow={index}
      >
        <div
          className="bg-accent h-2 transition-all"
          style={{ width: `${(index / items.length) * 100}%` }}
        />
      </div>

      <p className="text-lg leading-relaxed font-medium" data-testid="question-stem">
        {item.stem}
      </p>

      <div className="grid gap-3" role="group" aria-label={t("options")}>
        {item.options.map((opt, i) => {
          const isAnswer = result?.answerIndex === i;
          const isWrongChoice = result && choice === i && !result.correct;
          return (
            <button
              key={i}
              type="button"
              onClick={() => answer(i)}
              disabled={!!result || pending}
              aria-pressed={choice === i}
              data-testid="question-option"
              className={cn(
                "border-border hover:border-accent flex min-h-12 items-start gap-3 rounded-xl border px-4 py-3 text-left transition-colors disabled:cursor-default",
                isAnswer && "border-success bg-accent-soft",
                isWrongChoice && "border-danger bg-danger-soft",
              )}
            >
              <span className="bg-surface inline-flex size-7 shrink-0 items-center justify-center rounded-full text-sm font-semibold">
                {LETTERS[i]}
              </span>
              <span className="flex-1">{opt}</span>
              {isAnswer && <Check className="text-success size-5 shrink-0" aria-hidden />}
              {isWrongChoice && <X className="text-danger size-5 shrink-0" aria-hidden />}
            </button>
          );
        })}
      </div>

      {error && <Alert tone="error">{t(`errors.${error}` as never)}</Alert>}
      {result && (
        <div className="space-y-4" aria-live="polite">
          <Alert tone={result.correct ? "success" : "error"}>
            <p className="font-semibold">
              {result.correct ? t("correct") : t("wrong", { letter: LETTERS[result.answerIndex] })}
            </p>
            {result.explanation.text && <p className="mt-1">{result.explanation.text}</p>}
            {result.explanation.ref && (
              <p className="mt-1 text-sm opacity-80">
                {t("reference", { ref: result.explanation.ref })}
              </p>
            )}
          </Alert>
          <Button onClick={next} autoFocus>
            {index + 1 >= items.length ? t("finish") : t("next")}
          </Button>
        </div>
      )}
    </Card>
  );
}
