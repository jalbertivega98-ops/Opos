"use client";

import { useActionState } from "react";
import { useTranslations } from "next-intl";
import { Button } from "@/components/ui/button";
import { Alert } from "@/components/ui/form";
import { savePlanSettingsAction, type PlanFormState } from "@/lib/learning/plan-actions";
import type { PlanSettings } from "@/lib/learning/plan-queries";

const field = "border-input bg-background block h-10 w-full rounded-lg border px-3 text-sm";

export function PlanSettingsForm({ settings }: { settings: PlanSettings }) {
  const t = useTranslations("plan");
  const [state, action, pending] = useActionState<PlanFormState, FormData>(savePlanSettingsAction, {
    status: "idle",
  });
  return (
    <form action={action} className="grid gap-4 sm:grid-cols-3" data-testid="plan-settings">
      <label className="space-y-1 text-sm font-medium">
        <span>{t("settings.hours")}</span>
        <input
          type="number"
          name="weeklyHours"
          min={1}
          max={80}
          defaultValue={settings.weeklyHours}
          className={field}
          required
        />
      </label>
      <label className="space-y-1 text-sm font-medium">
        <span>{t("settings.level")}</span>
        <select name="level" defaultValue={settings.level} className={field}>
          {(["beginner", "intermediate", "advanced"] as const).map((l) => (
            <option key={l} value={l}>
              {t(`levels.${l}`)}
            </option>
          ))}
        </select>
      </label>
      <label className="space-y-1 text-sm font-medium">
        <span>{t("settings.date")}</span>
        <input
          type="date"
          name="targetDate"
          defaultValue={settings.targetDate ?? ""}
          className={field}
        />
      </label>
      <p className="text-muted-foreground text-xs sm:col-span-3">{t("settings.dateHelp")}</p>
      {state.message && (
        <Alert tone={state.status === "error" ? "error" : "success"} className="sm:col-span-3">
          {t(`settings.messages.${state.message}` as never)}
        </Alert>
      )}
      <div className="sm:col-span-3">
        <Button type="submit" disabled={pending}>
          {t("settings.save")}
        </Button>
      </div>
    </form>
  );
}
