"use client";

import { useState, useTransition } from "react";
import { useTranslations } from "next-intl";
import { ArrowRight, Check, RotateCcw, X } from "lucide-react";
import { Link } from "@/i18n/navigation";
import { checkDemoAnswer } from "@/lib/learning/practice/actions";
import type { Explanation, PsychoType, PublicPsychoItem } from "@/lib/learning/psycho/types";
import { PsychoStem, useExplain } from "@/components/psycho/stem";
import { Token, useTokenText } from "@/components/psycho/token";
import { cn } from "@/lib/utils";

type Result = { correct: boolean; answerIndex: number; explanation: Explanation };

/**
 * «¿Qué quieres practicar?»: elige un tipo de psicotécnico y resuélvelo aquí mismo.
 * Son ejercicios reales del generador, corregidos en el servidor; es una
 * demostración y no se guarda en ninguna cuenta.
 */
export function PracticePicker({ items }: { items: PublicPsychoItem[] }) {
  const t = useTranslations("landing.picker");
  const tp = useTranslations("psycho");
  const explain = useExplain();
  const text = useTokenText();
  const [type, setType] = useState<PsychoType>(items[0].type);
  const [choice, setChoice] = useState<number | null>(null);
  const [result, setResult] = useState<Result | null>(null);
  const [failed, setFailed] = useState(false);
  const [pending, start] = useTransition();
  const item = items.find((i) => i.type === type) ?? items[0];
  const isVisual = item.options.some((o) => o.startsWith("g:") || o.startsWith("p:"));

  function pick(next: PsychoType) {
    setType(next);
    setChoice(null);
    setResult(null);
    setFailed(false);
  }

  function answer(i: number) {
    if (result || pending) return;
    setChoice(i);
    setFailed(false);
    start(async () => {
      const r = await checkDemoAnswer({
        type: item.type,
        seed: item.seed,
        difficulty: item.difficulty,
        choice: i,
      });
      if (!r.ok) {
        setChoice(null);
        setFailed(true);
        return;
      }
      setResult(r);
    });
  }

  return (
    <div>
      <p id="picker-label" className="text-sm font-semibold">
        {t("label")}
      </p>
      <div
        role="group"
        aria-labelledby="picker-label"
        className="-mx-4 mt-3 flex [scrollbar-width:none] gap-2 overflow-x-auto px-4 pb-1 sm:mx-0 sm:flex-wrap sm:px-0"
      >
        {items.map((it) => (
          <button
            key={it.type}
            type="button"
            aria-pressed={it.type === type}
            onClick={() => pick(it.type)}
            className={cn(
              "press min-h-10 shrink-0 rounded-full border px-4 text-sm font-semibold whitespace-nowrap",
              it.type === type
                ? "bg-ink text-ink-foreground border-transparent"
                : "border-border bg-background hover:border-accent",
            )}
          >
            {tp(`types.${it.type}.name`)}
          </button>
        ))}
      </div>

      {/* Marco de móvil: la vista del producto, con un ejercicio real dentro */}
      <div className="bg-ink mx-auto mt-5 w-full max-w-md rounded-[2.25rem] p-2.5 shadow-2xl shadow-black/20 sm:p-3">
        <div className="bg-background relative overflow-hidden rounded-[1.75rem]">
          <div className="border-border flex items-center justify-between gap-2 border-b px-5 py-3">
            <span className="text-sm font-semibold">{tp(`types.${item.type}.name`)}</span>
            <span className="bg-highlight-soft text-highlight-foreground dark:text-highlight rounded-full px-2.5 py-0.5 text-[11px] font-bold">
              {t("demo")}
            </span>
          </div>
          <div key={item.type} className="animate-fade-up space-y-5 p-5">
            <p className="text-muted-foreground text-sm">{tp(`types.${item.type}.description`)}</p>
            <PsychoStem type={item.type} presentation={item.presentation} />
            <div
              role="group"
              aria-label={tp("options")}
              className={cn("grid gap-2", isVisual ? "grid-cols-2 sm:grid-cols-4" : "grid-cols-2")}
            >
              {item.options.map((opt, i) => {
                const isAnswer = result?.answerIndex === i;
                const isWrong = result && choice === i && !result.correct;
                return (
                  <button
                    key={i}
                    type="button"
                    onClick={() => answer(i)}
                    disabled={!!result || pending}
                    aria-pressed={choice === i}
                    aria-label={text(opt)}
                    data-testid="picker-option"
                    className={cn(
                      "press flex min-h-14 items-center justify-center gap-2 rounded-xl border-2 px-2 py-2 text-lg font-bold disabled:cursor-default",
                      !result && "border-border hover:border-accent hover:bg-accent-soft",
                      !result && choice === i && "border-accent bg-accent-soft",
                      isAnswer && "border-success bg-accent-soft text-success animate-pop",
                      isWrong && "border-danger bg-danger-soft text-danger",
                      result && !isAnswer && !isWrong && "border-border opacity-60",
                    )}
                  >
                    {isAnswer && <Check className="size-5 shrink-0" aria-hidden />}
                    {isWrong && <X className="size-5 shrink-0" aria-hidden />}
                    <Token value={opt} />
                  </button>
                );
              })}
            </div>
            <div role="status" aria-live="polite">
              {failed && <p className="text-danger text-sm">{t("error")}</p>}
              {result ? (
                <div className="bg-surface animate-fade-up space-y-2 rounded-xl p-4 text-sm">
                  <p className="font-semibold">
                    {result.correct
                      ? tp("correct")
                      : tp("wrong", { answer: text(item.options[result.answerIndex]) })}
                  </p>
                  <p className="text-muted-foreground">{explain(result.explanation)}</p>
                  <div className="flex flex-wrap gap-x-4 gap-y-1 pt-1">
                    <button
                      type="button"
                      onClick={() => {
                        setChoice(null);
                        setResult(null);
                      }}
                      className="text-accent inline-flex min-h-10 items-center gap-1.5 font-semibold hover:underline"
                    >
                      <RotateCcw className="size-4" aria-hidden /> {t("retry")}
                    </button>
                    <Link
                      href={
                        item.type === "series"
                          ? "/psicotecnicos"
                          : `/psicotecnicos?tipo=${item.type}`
                      }
                      className="text-accent inline-flex min-h-10 items-center gap-1.5 font-semibold hover:underline"
                    >
                      {t("more")} <ArrowRight className="size-4" aria-hidden />
                    </Link>
                  </div>
                </div>
              ) : (
                !failed && <p className="text-muted-foreground text-xs">{t("hint")}</p>
              )}
            </div>
          </div>
        </div>
      </div>
      <p className="text-muted-foreground mt-3 text-center text-xs">{t("notSaved")}</p>
    </div>
  );
}
