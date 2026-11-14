"use client";

import { useActionState } from "react";
import { useTranslations } from "next-intl";
import { Button } from "@/components/ui/button";
import { Alert, FieldError, Input, Label } from "@/components/ui/form";
import { createAmbassadorAction, type AmbassadorActionState } from "@/lib/ambassadors/actions";
import { ambassadorNetworks } from "@/lib/ambassadors/schemas";

const sel = "border-input bg-background h-11 w-full rounded-lg border px-3 text-base sm:text-sm";

/** Alta de una embajadora (ADR-054). */
export function AmbassadorForm({ exams }: { exams: { id: string; name: string }[] }) {
  const t = useTranslations("adminAmbassadors");
  const tr = useTranslations();
  const [state, action, pending] = useActionState<AmbassadorActionState, FormData>(
    createAmbassadorAction,
    { status: "idle" },
  );
  return (
    <form action={action} className="space-y-4" data-testid="ambassador-form">
      {state.message && (
        <Alert tone={state.status === "error" ? "error" : "success"}>{tr(state.message)}</Alert>
      )}
      <div className="grid gap-4 sm:grid-cols-2">
        <div className="space-y-1.5">
          <Label htmlFor="amb-name">{t("fields.name")}</Label>
          <Input
            id="amb-name"
            name="name"
            required
            maxLength={80}
            aria-invalid={state.errors?.name ? true : undefined}
            aria-describedby={state.errors?.name ? "amb-name-error" : undefined}
          />
          <FieldError id="amb-name-error">
            {state.errors?.name ? tr(state.errors.name) : undefined}
          </FieldError>
        </div>
        <div className="space-y-1.5">
          <Label htmlFor="amb-code">{t("fields.code")}</Label>
          <Input
            id="amb-code"
            name="code"
            required
            maxLength={32}
            pattern="[A-Za-z0-9-]{2,32}"
            autoComplete="off"
            aria-invalid={state.errors?.code ? true : undefined}
            aria-describedby={state.errors?.code ? "amb-code-error" : "amb-code-hint"}
          />
          <p id="amb-code-hint" className="text-muted-foreground text-xs">
            {t("fields.codeHint")}
          </p>
          <FieldError id="amb-code-error">
            {state.errors?.code ? tr(state.errors.code) : undefined}
          </FieldError>
        </div>
        <div className="space-y-1.5">
          <Label htmlFor="amb-network">{t("fields.network")}</Label>
          <select id="amb-network" name="network" className={sel} defaultValue="instagram">
            {ambassadorNetworks.map((n) => (
              <option key={n} value={n}>
                {t(`networks.${n}`)}
              </option>
            ))}
          </select>
        </div>
        <div className="space-y-1.5">
          <Label htmlFor="amb-handle">{t("fields.handle")}</Label>
          <Input id="amb-handle" name="handle" maxLength={80} placeholder="@" />
        </div>
        <div className="space-y-1.5">
          <Label htmlFor="amb-exam">{t("fields.exam")}</Label>
          <select id="amb-exam" name="exam" className={sel} defaultValue="">
            <option value="">{t("fields.examNone")}</option>
            {exams.map((e) => (
              <option key={e.id} value={e.id}>
                {e.name}
              </option>
            ))}
          </select>
        </div>
        <div className="space-y-1.5">
          <Label htmlFor="amb-notes">{t("fields.notes")}</Label>
          <Input id="amb-notes" name="notes" maxLength={500} />
        </div>
      </div>
      <Button type="submit" disabled={pending}>
        {t("create")}
      </Button>
    </form>
  );
}
