"use client";

import { useRef, useState, useTransition } from "react";
import { useTranslations } from "next-intl";
import { Check, Minus, X } from "lucide-react";
import { Link } from "@/i18n/navigation";
import { Button } from "@/components/ui/button";
import { Card } from "@/components/ui/card";
import { Alert } from "@/components/ui/form";
import { cn } from "@/lib/utils";
import { signUpPath } from "@/lib/paths";
import { SignupPitch } from "@/components/signup-pitch";
import {
  checkSampleAnswerAction,
  trackSampleStepAction,
  type SampleAnswerResult,
} from "@/lib/learning/sample/actions";
import type { SampleQuestion } from "@/lib/learning/sample/schema";
import {
  SampleGuideTip,
  useTestGuide,
  type SampleGuidePhase,
} from "@/components/questions/sample-guide-tip";

const LETTERS = "ABCDEF";

/** Lo que el alumno falló, para repasarlo al terminar sin volver a pedirlo al servidor. */
type Miss = {
  id: string;
  stem: string;
  locale: string;
  /** null = la dejó en blanco. */
  chosen: string | null;
  answer: string;
  answerLetter: string;
  explanation: string | null;
  reference: string | null;
};

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
  const [misses, setMisses] = useState<Miss[]>([]);
  const [pending, start] = useTransition();
  const headingRef = useRef<HTMLHeadingElement>(null);
  const item = items[index];
  const guidePhase: SampleGuidePhase | null = done
    ? "finish"
    : index === 0
      ? result
        ? "feedback"
        : "answer"
      : index === 1 && !result
        ? "keepGoing"
        : null;
  const guide = useTestGuide(guidePhase);
  // La pista de la corrección va junto a la corrección (en el móvil la de
  // arriba queda fuera de la pantalla); las demás, encima de la pregunta.
  const topTip = guide.phase === "feedback" ? null : guide.phase;

  /** `null` deja la pregunta en blanco: no suma acierto y enseña la solución. */
  function answer(i: number | null) {
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
      if (index === 0) trackSampleStepAction({ exam: examSlug, step: "start" }).catch(() => {});
      if (r.correct) setScore((s) => s + 1);
      else
        setMisses((m) => [
          ...m,
          {
            id: item.id,
            stem: item.stem,
            locale: item.locale,
            chosen: i === null ? null : (item.options[i] ?? ""),
            answer: item.options[r.answerIndex] ?? "",
            answerLetter: LETTERS[r.answerIndex] ?? "",
            explanation: r.explanation.text ?? null,
            reference: r.explanation.ref ?? null,
          },
        ]);
    });
  }

  function next() {
    if (index + 1 >= items.length) {
      setDone(true);
      trackSampleStepAction({ exam: examSlug, step: "finish" }).catch(() => {});
    } else {
      setIndex(index + 1);
      setChoice(null);
      setResult(null);
    }
    requestAnimationFrame(() => headingRef.current?.focus());
  }

  /** Embudo (ADR-070): pulsa «Crear cuenta» desde el test gratis. */
  function trackSignup() {
    trackSampleStepAction({ exam: examSlug, step: "signup" }).catch(() => {});
  }

  function restart() {
    setIndex(0);
    setScore(0);
    setDone(false);
    setChoice(null);
    setResult(null);
    setMisses([]);
    requestAnimationFrame(() => headingRef.current?.focus());
  }

  if (done) {
    const grade = Math.round((score / items.length) * 100) / 10;
    return (
      <div className="space-y-6">
        <SampleGuideTip phase={topTip} onHide={guide.hide} />
        <Card className="space-y-4" data-testid="sample-result">
          <h2 ref={headingRef} tabIndex={-1} className="text-2xl font-bold outline-none">
            {ts("result", { correct: score, total: items.length })}
          </h2>
          {misses.some((m) => m.chosen === null) && (
            <p className="text-muted-foreground" data-testid="sample-blank">
              {ts("blankCount", { count: misses.filter((m) => m.chosen === null).length })}
            </p>
          )}
          <p className="text-lg">
            {ts("grade", { grade: grade.toLocaleString(item?.locale === "ca" ? "ca" : "es") })}
          </p>
          <SignupPitch href={signUpPath(examSlug)} onClick={trackSignup} testId="sample-register" />
          <Button variant="outline" onClick={restart}>
            {ts("again")}
          </Button>
        </Card>

        {misses.length > 0 && (
          <section aria-labelledby="sample-misses" className="space-y-3">
            <h2 id="sample-misses" className="text-xl font-bold">
              {ts("missesTitle", { count: misses.length })}
            </h2>
            <ol className="space-y-3" data-testid="sample-misses">
              {misses.map((m) => (
                <li key={m.id}>
                  <Card className="space-y-2">
                    <p className="font-medium" lang={m.locale}>
                      {m.stem}
                    </p>
                    {m.chosen === null ? (
                      <p className="text-muted-foreground text-sm">
                        <Minus className="mr-1 inline size-4" aria-hidden />
                        {ts("yourAnswer")}: {t("blank")}
                      </p>
                    ) : (
                      <p className="text-danger text-sm" lang={m.locale}>
                        <X className="mr-1 inline size-4" aria-hidden />
                        {ts("yourAnswer")}: {m.chosen}
                      </p>
                    )}
                    <p className="text-success text-sm font-semibold" lang={m.locale}>
                      <Check className="mr-1 inline size-4" aria-hidden />
                      {ts("rightAnswer")}: {m.answerLetter}. {m.answer}
                    </p>
                    {m.explanation && (
                      <p className="text-muted-foreground text-sm" lang={m.locale}>
                        {m.explanation}
                      </p>
                    )}
                    {m.reference && (
                      <p className="text-muted-foreground text-xs">
                        {t("reference", { ref: m.reference })}
                      </p>
                    )}
                  </Card>
                </li>
              ))}
            </ol>
          </section>
        )}
        {misses.length > 0 && (
          <SignupPitch
            compact
            href={signUpPath(examSlug)}
            onClick={trackSignup}
            testId="sample-register-bottom"
          />
        )}
      </div>
    );
  }

  return (
    <div className="space-y-4">
      <SampleGuideTip phase={topTip} onHide={guide.hide} />
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

        {!result && (
          <Button
            variant="outline"
            size="sm"
            onClick={() => answer(null)}
            disabled={pending}
            data-testid="question-skip"
          >
            <Minus aria-hidden /> {t("skip")}
          </Button>
        )}

        {error && <Alert tone="error">{ts("error")}</Alert>}
        {result && (
          <div className="space-y-4" aria-live="polite">
            <Alert tone={result.correct ? "success" : choice === null ? "info" : "error"}>
              <p className="font-semibold">
                {result.correct
                  ? t("correct")
                  : choice === null
                    ? t("blankResult", { letter: LETTERS[result.answerIndex] })
                    : t("wrong", { letter: LETTERS[result.answerIndex] })}
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
            <SampleGuideTip
              phase={guide.phase === "feedback" ? "feedback" : null}
              onHide={guide.hide}
            />
            <Button onClick={next} autoFocus>
              {index + 1 >= items.length ? t("finish") : t("next")}
            </Button>
          </div>
        )}
        <p className="text-muted-foreground text-xs">
          {ts("notSaved")}{" "}
          {index >= 2 && (
            <Link
              href={signUpPath(examSlug)}
              onClick={trackSignup}
              className="text-accent font-semibold hover:underline"
              data-testid="sample-save-progress"
            >
              {ts("saveProgress")}
            </Link>
          )}
        </p>
      </Card>
    </div>
  );
}
