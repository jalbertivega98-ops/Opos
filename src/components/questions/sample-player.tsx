"use client";

import { useRef, useState, useTransition } from "react";
import { useTranslations } from "next-intl";
import { Check, X } from "lucide-react";
import { Link } from "@/i18n/navigation";
import { Button } from "@/components/ui/button";
import { Card } from "@/components/ui/card";
import { Alert } from "@/components/ui/form";
import { cn } from "@/lib/utils";
import { checkSampleAnswerAction, type SampleAnswerResult } from "@/lib/learning/sample/actions";
import type { SampleQuestion } from "@/lib/learning/sample/schema";

const LETTERS = "ABCDEF";

/**
 * Test gratis sin registro (ADR-041): corrige cada pregunta en el servidor y
 * lleva la cuenta solo en el navegador. Al final invita a crear cuenta.
 */
export function SamplePlayer({ examSlug, items }: { examSlug: string; items: SampleQuestion[] }) {
  const t = useTranslations("questions");
  const ts = useTranslations("seo.sample");
  const [index, setIndex] = useState(0);
  const [score, setScore] = useState(0);
  const [done, setDone] = useState(false);
  const [choice, setChoice] = useState<number | null>(null);
  const [result, setResult] = useState<Extract<SampleAnswerResult, { ok: true }> | null>(null);
  const [error, setError] = useState(false);
  const [pending, start] = useTransition();
  const headingRef = useRef<HTMLHeadingElement>(null);
  const item = items[index];

  function answer(i: number) {
    if (result || pending) return;
    setChoice(i);
    setError(false);
    start(async () => {
      const r = await checkSampleAnswerAction({ exam: examSlug, questionId: item.id, choice: i });
      if (!r.ok) {
        setChoice(null);
        setError(true);
        return;
      }
      setResult(r);
      if (r.correct) setScore((s) => s + 1);
    });
  }

  function next() {
    if (index + 1 >= items.length) setDone(true);
    else {
      setIndex(index + 1);
      setChoice(null);
      setResult(null);
    }
    requestAnimationFrame(() => headingRef.current?.focus());
  }

  function restart() {
    setIndex(0);
    setScore(0);
    setDone(false);
    setChoice(null);
    setResult(null);
    requestAnimationFrame(() => headingRef.current?.focus());
  }

  if (done) {
    return (
      <Card className="space-y-4" data-testid="sample-result">
        <h2 ref={headingRef} tabIndex={-1} className="text-2xl font-bold outline-none">
          {ts("result", { correct: score, total: items.length })}
        </h2>
        <p className="text-muted-foreground">{ts("resultHint")}</p>
        <div className="flex flex-wrap gap-3">
          <Button asChild variant="accent" size="lg">
            <Link href="/registro">{ts("register")}</Link>
          </Button>
          <Button variant="outline" size="lg" onClick={restart}>
            {ts("again")}
          </Button>
        </div>
      </Card>
    );
  }

  return (
    <Card className="space-y-5">
      <div className="text-muted-foreground flex flex-wrap items-center justify-between gap-2 text-sm">
        <h2 ref={headingRef} tabIndex={-1} className="text-foreground font-semibold outline-none">
          {t("question", { n: index + 1, total: items.length })}
        </h2>
        {item.topic && <span>{ts("topic", { topic: item.topic })}</span>}
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

      <p
        className="text-lg leading-relaxed font-medium"
        lang={item.locale}
        data-testid="question-stem"
      >
        {item.stem}
      </p>

      <div className="grid gap-3" role="group" aria-label={t("options")} lang={item.locale}>
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

      {error && <Alert tone="error">{ts("error")}</Alert>}
      {result && (
        <div className="space-y-4" aria-live="polite">
          <Alert tone={result.correct ? "success" : "error"}>
            <p className="font-semibold">
              {result.correct ? t("correct") : t("wrong", { letter: LETTERS[result.answerIndex] })}
            </p>
            {result.explanation.text && (
              <p className="mt-1" lang={item.locale}>
                {result.explanation.text}
              </p>
            )}
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
      <p className="text-muted-foreground text-xs">{ts("notSaved")}</p>
    </Card>
  );
}
