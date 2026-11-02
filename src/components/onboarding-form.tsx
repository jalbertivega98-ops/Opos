"use client";

import { useActionState, useState } from "react";
import { useLocale, useTranslations } from "next-intl";
import { Button } from "@/components/ui/button";
import { Alert, FieldError } from "@/components/ui/form";
import { saveOnboardingAction, type OnboardingState } from "@/lib/onboarding/actions";
import { GOALS } from "@/lib/onboarding/schema";

type ExamOption = { slug: string; label: string; availability: string; group: string };

export function OnboardingForm({
  exams,
  initialExam,
}: {
  exams: ExamOption[];
  initialExam?: string;
}) {
  const t = useTranslations();
  const locale = useLocale();
  const [state, action, pending] = useActionState<OnboardingState, FormData>(saveOnboardingAction, {
    status: "idle",
  });
  const [exam, setExam] = useState(initialExam ?? "");
  const [hours, setHours] = useState(8);
  const selected = exams.find((e) => e.slug === exam);
  const groups = [...new Set(exams.map((e) => e.group))];

  return (
    <form action={action} className="space-y-8">
      <input type="hidden" name="locale" value={locale} />
      {state.message && <Alert tone="error">{t(state.message)}</Alert>}

      <fieldset className="space-y-3">
        <legend className="text-lg font-semibold">1. {t("onboarding.step1")}</legend>
        <label htmlFor="exam" className="sr-only">
          {t("onboarding.step1")}
        </label>
        <select
          id="exam"
          name="exam"
          required
          value={exam}
          onChange={(e) => setExam(e.target.value)}
          aria-invalid={state.errors?.exam ? true : undefined}
          aria-describedby="exam-error"
          className="border-input bg-background h-11 w-full rounded-lg border px-3"
        >
          <option value="">{t("onboarding.selectExam")}</option>
          {groups.map((g) => (
            <optgroup key={g} label={g}>
              {exams
                .filter((e) => e.group === g)
                .map((e) => (
                  <option key={e.slug} value={e.slug}>
                    {e.label} · {t(`availability.${e.availability}`)}
                  </option>
                ))}
            </optgroup>
          ))}
        </select>
        <FieldError id="exam-error">{state.errors?.exam && t("onboarding.selectExam")}</FieldError>
        {selected?.availability === "coming_soon" && (
          <Alert>{t("onboarding.comingSoonNotice")}</Alert>
        )}
      </fieldset>

      <fieldset className="space-y-3">
        <legend className="text-lg font-semibold">2. {t("onboarding.step2")}</legend>
        <div className="grid gap-2 sm:grid-cols-3">
          {(["beginner", "intermediate", "advanced"] as const).map((lvl, i) => (
            <label
              key={lvl}
              className="border-border has-[:checked]:border-accent has-[:checked]:bg-accent-soft flex cursor-pointer items-center gap-3 rounded-lg border p-3"
            >
              <input
                type="radio"
                name="level"
                value={lvl}
                defaultChecked={i === 0}
                className="accent-[var(--accent)]"
              />
              <span className="text-sm">{t(`onboarding.levels.${lvl}`)}</span>
            </label>
          ))}
        </div>
      </fieldset>

      <fieldset className="space-y-3">
        <legend className="text-lg font-semibold">3. {t("onboarding.step3")}</legend>
        <input
          type="range"
          name="weeklyHours"
          min={1}
          max={40}
          value={hours}
          onChange={(e) => setHours(Number(e.target.value))}
          aria-valuetext={t("onboarding.hours", { count: hours })}
          aria-label={t("onboarding.step3")}
          className="w-full accent-[var(--accent)]"
        />
        <p className="font-semibold">{t("onboarding.hours", { count: hours })}</p>
      </fieldset>

      <fieldset className="space-y-3" aria-describedby="goals-error">
        <legend className="text-lg font-semibold">4. {t("onboarding.step4")}</legend>
        <div className="grid gap-2 sm:grid-cols-2">
          {GOALS.map((g) => (
            <label
              key={g}
              className="border-border has-[:checked]:border-accent has-[:checked]:bg-accent-soft flex cursor-pointer items-center gap-3 rounded-lg border p-3"
            >
              <input
                type="checkbox"
                name="goals"
                value={g}
                className="size-4 accent-[var(--accent)]"
              />
              <span className="text-sm">{t(`onboarding.goals.${g}`)}</span>
            </label>
          ))}
        </div>
        <FieldError id="goals-error">
          {state.errors?.goals && t("onboarding.selectGoal")}
        </FieldError>
      </fieldset>

      <label className="flex items-start gap-3 text-sm">
        <input
          type="checkbox"
          name="notifyConsent"
          className="mt-0.5 size-4 accent-[var(--accent)]"
        />
        <span>{t("onboarding.notify")}</span>
      </label>

      <Button
        type="submit"
        variant="accent"
        size="lg"
        className="w-full sm:w-auto"
        disabled={pending}
      >
        {t("onboarding.submit")}
      </Button>
    </form>
  );
}
