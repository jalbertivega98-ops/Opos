"use client";

import { useEffect, useRef, useState, useTransition } from "react";
import { useTranslations } from "next-intl";
import { Check, Timer, X } from "lucide-react";
import { Link, useRouter } from "@/i18n/navigation";
import { Button } from "@/components/ui/button";
import { Card } from "@/components/ui/card";
import { Alert } from "@/components/ui/form";
import { cn } from "@/lib/utils";
import {
  answerPracticeAction,
  checkDemoAnswer,
  type AnswerResult,
} from "@/lib/learning/practice/actions";
import type { Explanation, PublicPsychoItem } from "@/lib/learning/psycho/types";
import { PsychoStem, useExplain } from "./stem";
import { Token, useTokenText } from "./token";

type Result = { correct: boolean; answerIndex: number; explanation: Explanation };

type Mode =
  { kind: "demo"; signedIn: boolean } | { kind: "session"; sessionId: string; startAt: number };

/**
 * Entrenador de psicotécnicos. En modo `demo` corrige sin guardar nada
 * (anónimo); en modo `session` corrige y guarda en la sesión del alumno.
 */
export function PsychoTrainer({ items, mode }: { items: PublicPsychoItem[]; mode: Mode }) {
  const t = useTranslations("psycho");
  const explain = useExplain();
  const text = useTokenText();
  const router = useRouter();
  const first = mode.kind === "session" ? mode.startAt : 0;
  const [index, setIndex] = useState(first);
  const [choice, setChoice] = useState<number | null>(null);
  const [result, setResult] = useState<Result | null>(null);
  const [score, setScore] = useState(0);
  const [done, setDone] = useState(false);
  const [error, setError] = useState<string | null>(null);
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
    setError(null);
    start(async () => {
      let r: AnswerResult | Awaited<ReturnType<typeof checkDemoAnswer>>;
      if (mode.kind === "session") {
        r = await answerPracticeAction({ sessionId: mode.sessionId, position: index, choice: i });
      } else {
        r = await checkDemoAnswer({
          type: item.type,
          seed: item.seed,
          difficulty: item.difficulty,
          choice: i,
        });
      }
      if (!r.ok) {
        setChoice(null);
        setError("error" in r ? r.error : "invalid");
        return;
      }
      setResult(r);
      if (r.correct) setScore((s) => s + 1);
    });
  }

  function next() {
    if (index + 1 >= items.length) {
      if (mode.kind === "session") {
        router.refresh(); // el servidor muestra el resumen guardado
      } else {
        setDone(true);
      }
      return;
    }
    setIndex(index + 1);
    setChoice(null);
    setResult(null);
    requestAnimationFrame(() => headingRef.current?.focus());
  }

  if (done && mode.kind === "demo") {
    return (
      <Card className="space-y-4 text-center" data-testid="series-result">
        <h2 className="text-2xl font-bold">{t("resultTitle")}</h2>
        <p className="text-lg">{t("result", { correct: score, total: items.length, seconds })}</p>
        <p className="text-muted-foreground text-sm">{t("demoNotSaved")}</p>
        <div className="flex flex-wrap justify-center gap-3">
          <Button variant="outline" onClick={() => router.refresh()}>
            {t("again")}
          </Button>
          {mode.signedIn ? (
            <Button asChild variant="accent">
              <Link href="/app/practica">{t("ctaPractice")}</Link>
            </Button>
          ) : (
            <Button asChild variant="accent">
              <Link href="/registro">{t("ctaButton")}</Link>
            </Button>
          )}
        </div>
        {!mode.signedIn && <p className="text-muted-foreground text-sm">{t("ctaBody")}</p>}
      </Card>
    );
  }

  const isVisual = item.options.some((o) => o.startsWith("g:") || o.startsWith("p:"));

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

      <PsychoStem type={item.type} presentation={item.presentation} />

      <div
        className={cn("grid gap-3", isVisual ? "grid-cols-2 sm:grid-cols-4" : "grid-cols-2")}
        role="group"
        aria-label={t("options")}
      >
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
              aria-label={text(opt)}
              data-testid="psycho-option"
              className={cn(
                "border-border hover:border-accent flex min-h-14 items-center justify-center gap-2 rounded-xl border px-2 py-2 text-lg font-semibold transition-colors disabled:cursor-default",
                isAnswer && "border-success bg-accent-soft",
                isWrongChoice && "border-danger bg-danger-soft",
              )}
            >
              {isAnswer && <Check className="text-success size-5 shrink-0" aria-hidden />}
              {isWrongChoice && <X className="text-danger size-5 shrink-0" aria-hidden />}
              <Token value={opt} />
            </button>
          );
        })}
      </div>

      {error && (
        <Alert tone="error">
          {t.has(`errors.${error}`) ? t(`errors.${error}`) : t("errors.invalid")}
        </Alert>
      )}
      {result && (
        <div className="space-y-4" aria-live="polite">
          <Alert tone={result.correct ? "success" : "error"}>
            <p className="font-semibold">
              {result.correct
                ? t("correct")
                : t("wrong", { answer: text(item.options[result.answerIndex]) })}
            </p>
            <p className="mt-1">{explain(result.explanation)}</p>
          </Alert>
          <Button onClick={next} autoFocus>
            {index + 1 >= items.length ? t("finish") : t("next")}
          </Button>
        </div>
      )}
    </Card>
  );
}
