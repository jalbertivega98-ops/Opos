"use client";

import { useEffect, useRef, useState, useTransition } from "react";
import { useTranslations } from "next-intl";
import { Check, Timer, X } from "lucide-react";
import { Link, useRouter } from "@/i18n/navigation";
import { Button } from "@/components/ui/button";
import { Card } from "@/components/ui/card";
import { Alert } from "@/components/ui/form";
import { cn } from "@/lib/utils";
import { checkSeriesAnswer, type SeriesCheck } from "@/lib/learning/psycho/actions";
import type { PublicSeriesItem, SeriesRule } from "@/lib/learning/psycho/series";

type Result = Extract<SeriesCheck, { ok: true }>;

export function SeriesTrainer({ items }: { items: PublicSeriesItem[] }) {
  const t = useTranslations("psycho");
  const router = useRouter();
  const [index, setIndex] = useState(0);
  const [choice, setChoice] = useState<number | null>(null);
  const [result, setResult] = useState<Result | null>(null);
  const [score, setScore] = useState(0);
  const [done, setDone] = useState(false);
  const [error, setError] = useState(false);
  const [pending, start] = useTransition();
  const [seconds, setSeconds] = useState(0);
  const startedAt = useRef<number>(0);
  const headingRef = useRef<HTMLHeadingElement>(null);

  useEffect(() => {
    startedAt.current = Date.now();
    const id = setInterval(() => {
      if (!done) setSeconds(Math.floor((Date.now() - startedAt.current) / 1000));
    }, 1000);
    return () => clearInterval(id);
  }, [done]);

  const item = items[index];

  function answer(i: number) {
    if (result || pending) return;
    setChoice(i);
    start(async () => {
      const r = await checkSeriesAnswer({
        seed: item.seed,
        difficulty: item.difficulty,
        choice: i,
      });
      if (!r.ok) return setError(true);
      setResult(r);
      if (r.correct) setScore((s) => s + 1);
    });
  }

  function next() {
    if (index + 1 >= items.length) {
      setDone(true);
      return;
    }
    setIndex(index + 1);
    setChoice(null);
    setResult(null);
    requestAnimationFrame(() => headingRef.current?.focus());
  }

  if (done) {
    return (
      <Card className="space-y-4 text-center" data-testid="series-result">
        <h2 className="text-2xl font-bold">{t("resultTitle")}</h2>
        <p className="text-lg">{t("result", { correct: score, total: items.length, seconds })}</p>
        <div className="flex flex-wrap justify-center gap-3">
          <Button variant="outline" onClick={() => router.refresh()}>
            {t("again")}
          </Button>
          <Button asChild variant="accent">
            <Link href="/registro">{t("ctaButton")}</Link>
          </Button>
        </div>
        <p className="text-muted-foreground text-sm">{t("ctaBody")}</p>
      </Card>
    );
  }

  return (
    <Card className="space-y-6">
      <div className="text-muted-foreground flex flex-wrap items-center justify-between gap-2 text-sm">
        <h2 ref={headingRef} tabIndex={-1} className="text-foreground font-semibold outline-none">
          {t("question", { n: index + 1, total: items.length })}
        </h2>
        <span>{t("difficulty", { level: item.difficulty })}</span>
        <span className="inline-flex items-center gap-1" aria-live="off">
          <Timer className="size-4" aria-hidden /> {t("time", { seconds })}
        </span>
      </div>
      <div
        className="bg-surface h-2 overflow-hidden rounded-full"
        role="progressbar"
        aria-valuemin={0}
        aria-valuemax={items.length}
        aria-valuenow={index}
      >
        <div
          className="bg-accent h-2 transition-all"
          style={{ width: `${(index / items.length) * 100}%` }}
        />
      </div>

      <p className="font-medium">{t("prompt")}</p>
      <p
        className="font-display text-2xl font-bold tracking-wide break-words sm:text-3xl"
        data-testid="series-terms"
      >
        {item.terms.join(", ")}, <span className="text-accent">?</span>
      </p>

      <div className="grid grid-cols-2 gap-3" role="group" aria-label={t("prompt")}>
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
              className={cn(
                "border-border hover:border-accent flex h-14 items-center justify-center gap-2 rounded-xl border text-lg font-semibold transition-colors disabled:cursor-default",
                isAnswer && "border-success bg-accent-soft",
                isWrongChoice && "border-danger bg-danger-soft",
              )}
            >
              {isAnswer && <Check className="text-success size-5" aria-hidden />}
              {isWrongChoice && <X className="text-danger size-5" aria-hidden />}
              {opt}
            </button>
          );
        })}
      </div>

      {error && <Alert tone="error">Error</Alert>}
      {result && (
        <div className="space-y-4" aria-live="polite">
          <Alert tone={result.correct ? "success" : "error"}>
            <p className="font-semibold">
              {result.correct
                ? t("correct")
                : t("wrong", { answer: item.options[result.answerIndex] })}
            </p>
            <p className="mt-1">{explain(t, result.rule)}</p>
          </Alert>
          <Button onClick={next} autoFocus>
            {index + 1 >= items.length ? t("finish") : t("next")}
          </Button>
        </div>
      )}
    </Card>
  );
}

function explain(t: ReturnType<typeof useTranslations<"psycho">>, rule: SeriesRule) {
  const sign = (n: number) => (n > 0 ? `+${n}` : String(n));
  switch (rule.kind) {
    case "arithmetic":
      return t("rules.arithmetic", { step: sign(rule.step) });
    case "geometric":
      return t("rules.geometric", { ratio: rule.ratio });
    case "alternating":
      return t("rules.alternating", { stepA: sign(rule.stepA), stepB: sign(rule.stepB) });
    case "second_order":
      return t("rules.second_order", { step: rule.step, delta: rule.delta });
    case "fibonacci":
      return t("rules.fibonacci");
    case "interleaved":
      return t("rules.interleaved", {
        startA: rule.startA,
        stepA: sign(rule.stepA),
        startB: rule.startB,
        stepB: sign(rule.stepB),
      });
  }
}
