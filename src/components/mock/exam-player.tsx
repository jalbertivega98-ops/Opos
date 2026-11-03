"use client";

import { useCallback, useEffect, useRef, useState, useTransition } from "react";
import { useTranslations } from "next-intl";
import { Clock } from "lucide-react";
import { useRouter } from "@/i18n/navigation";
import { Button } from "@/components/ui/button";
import { Card } from "@/components/ui/card";
import { Alert } from "@/components/ui/form";
import { cn } from "@/lib/utils";
import { saveMockAnswerAction, submitMockAction } from "@/lib/learning/mock/actions";
import type { PresentedQuestion } from "@/lib/learning/questions/schema";

const LETTERS = "ABCDEF";

function clock(totalSeconds: number) {
  const s = Math.max(0, totalSeconds);
  return `${Math.floor(s / 60)}:${String(s % 60).padStart(2, "0")}`;
}

/**
 * Simulacro como el examen real: todas las preguntas navegables, se puede
 * cambiar o dejar en blanco cualquier respuesta y no hay corrección hasta
 * entregar. El plazo lo marca la base de datos; aquí solo se muestra.
 */
export function MockExamPlayer({
  attemptId,
  items,
  initialChoices,
  remainingMs,
  penalty,
}: {
  attemptId: string;
  items: PresentedQuestion[];
  initialChoices: (number | null)[];
  remainingMs: number;
  penalty: number;
}) {
  const t = useTranslations("mock");
  const router = useRouter();
  const [choices, setChoices] = useState(initialChoices);
  const [index, setIndex] = useState(0);
  const [error, setError] = useState<string | null>(null);
  const [confirming, setConfirming] = useState(false);
  const [submitting, startSubmit] = useTransition();
  const [endAt] = useState(() => Date.now() + remainingMs);
  const [left, setLeft] = useState(Math.ceil(remainingMs / 1000));
  const submitted = useRef(false);
  const headingRef = useRef<HTMLHeadingElement>(null);

  const submit = useCallback(() => {
    if (submitted.current) return;
    submitted.current = true;
    startSubmit(async () => {
      await submitMockAction({ attemptId });
      router.refresh();
    });
  }, [attemptId, router]);

  useEffect(() => {
    const id = setInterval(() => {
      const s = Math.ceil((endAt - Date.now()) / 1000);
      setLeft(s);
      if (s <= 0) {
        clearInterval(id);
        submit();
      }
    }, 1000);
    return () => clearInterval(id);
  }, [submit, endAt]);

  async function choose(choice: number | null) {
    if (submitting) return;
    const pos = index;
    const before = choices[pos];
    if (before === choice) return;
    setChoices((c) => c.map((v, i) => (i === pos ? choice : v)));
    setError(null);
    const r = await saveMockAnswerAction({ attemptId, position: pos, choice });
    if (!r.ok) {
      setChoices((c) => c.map((v, i) => (i === pos ? before : v)));
      setError(r.error);
      if (r.error === "closed") router.refresh();
    }
  }

  function go(i: number) {
    setIndex(i);
    setConfirming(false);
    requestAnimationFrame(() => headingRef.current?.focus());
  }

  const item = items[index];
  const answered = choices.filter((c) => c !== null).length;
  const blank = items.length - answered;
  const low = left <= 300;

  return (
    <div className="space-y-4">
      <Card className="flex flex-wrap items-center justify-between gap-3">
        <p
          role="timer"
          aria-label={t("timeLeft")}
          className={cn(
            "inline-flex items-center gap-2 text-2xl font-bold tabular-nums",
            low && "text-danger",
          )}
          data-testid="mock-timer"
        >
          <Clock className="size-6" aria-hidden />
          {clock(left)}
        </p>
        <p className="text-muted-foreground text-sm" data-testid="mock-answered">
          {t("answered", { answered, total: items.length })}
        </p>
      </Card>

      <nav aria-label={t("navigator")} className="flex flex-wrap gap-1.5">
        {items.map((_, i) => (
          <button
            key={i}
            type="button"
            onClick={() => go(i)}
            aria-current={i === index ? "step" : undefined}
            aria-label={t(choices[i] === null ? "goBlank" : "goAnswered", { n: i + 1 })}
            className={cn(
              "border-border inline-flex size-9 items-center justify-center rounded-lg border text-sm tabular-nums",
              choices[i] !== null && "bg-accent-soft border-accent/40",
              i === index && "ring-accent ring-2",
            )}
          >
            {i + 1}
          </button>
        ))}
      </nav>

      <Card className="space-y-5">
        <h2 ref={headingRef} tabIndex={-1} className="font-semibold outline-none">
          {t("question", { n: index + 1, total: items.length })}
        </h2>
        <p className="text-lg leading-relaxed font-medium" data-testid="question-stem">
          {item.stem}
        </p>
        <div className="grid gap-3" role="radiogroup" aria-label={t("options")}>
          {item.options.map((opt, i) => (
            <button
              key={i}
              type="button"
              role="radio"
              aria-checked={choices[index] === i}
              onClick={() => choose(i)}
              disabled={submitting}
              data-testid="question-option"
              className={cn(
                "border-border hover:border-accent flex min-h-12 items-start gap-3 rounded-xl border px-4 py-3 text-left transition-colors",
                choices[index] === i && "border-accent bg-accent-soft font-medium",
              )}
            >
              <span className="bg-surface inline-flex size-7 shrink-0 items-center justify-center rounded-full text-sm font-semibold">
                {LETTERS[i]}
              </span>
              <span className="flex-1">{opt}</span>
            </button>
          ))}
        </div>
        {error && <Alert tone="error">{t(`errors.${error}` as never)}</Alert>}
        <div className="flex flex-wrap items-center justify-between gap-2">
          <Button
            variant="outline"
            size="sm"
            onClick={() => choose(null)}
            disabled={choices[index] === null || submitting}
          >
            {t("clear")}
          </Button>
          <div className="flex gap-2">
            <Button
              variant="outline"
              size="sm"
              onClick={() => go(index - 1)}
              disabled={index === 0}
            >
              {t("prev")}
            </Button>
            <Button size="sm" onClick={() => go(index + 1)} disabled={index + 1 >= items.length}>
              {t("next")}
            </Button>
          </div>
        </div>
      </Card>

      <Card className="space-y-3">
        <p className="text-muted-foreground text-sm">{t("rules", { penalty: penalty * 100 })}</p>
        {confirming ? (
          <div className="space-y-3" aria-live="polite">
            <p className="font-medium">
              {blank > 0 ? t("confirmBlank", { blank }) : t("confirmAll")}
            </p>
            <div className="flex flex-wrap gap-2">
              <Button
                variant="accent"
                onClick={submit}
                disabled={submitting}
                data-testid="mock-confirm"
              >
                {t("submitConfirm")}
              </Button>
              <Button variant="outline" onClick={() => setConfirming(false)} disabled={submitting}>
                {t("keepGoing")}
              </Button>
            </div>
          </div>
        ) : (
          <Button
            variant="accent"
            onClick={() => setConfirming(true)}
            disabled={submitting}
            data-testid="mock-submit"
          >
            {t("submit")}
          </Button>
        )}
      </Card>
    </div>
  );
}
