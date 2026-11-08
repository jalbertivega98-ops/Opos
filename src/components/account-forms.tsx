"use client";

import { useActionState } from "react";
import { useLocale, useTranslations } from "next-intl";
import { Button } from "@/components/ui/button";
import { Alert, FieldError, Input, Label } from "@/components/ui/form";
import {
  changeEmailAction,
  changePasswordAction,
  deleteAccountAction,
  updateProfileAction,
  type AccountState,
} from "@/lib/account/actions";

const initial: AccountState = { status: "idle" };

export function ProfileForm({
  displayName,
  locale: preferred,
  marketingConsent,
}: {
  displayName: string;
  locale: "es" | "ca";
  marketingConsent: boolean;
}) {
  const t = useTranslations();
  const current = useLocale();
  const [state, action, pending] = useActionState(updateProfileAction, initial);
  return (
    <form action={action} className="space-y-5">
      <input type="hidden" name="currentLocale" value={current} />
      {state.message && (
        <Alert tone={state.status === "error" ? "error" : "success"}>{t(state.message)}</Alert>
      )}
      <div className="space-y-2">
        <Label htmlFor="displayName">{t("auth.fields.displayName")}</Label>
        <Input
          id="displayName"
          name="displayName"
          defaultValue={displayName}
          maxLength={80}
          autoComplete="given-name"
          aria-invalid={state.errors?.displayName ? true : undefined}
          aria-describedby="displayName-error"
        />
        <FieldError id="displayName-error">
          {state.errors?.displayName && t(`validation.${state.errors.displayName}`)}
        </FieldError>
      </div>
      <div className="space-y-2">
        <Label htmlFor="locale">{t("profile.locale")}</Label>
        <select
          id="locale"
          name="locale"
          defaultValue={preferred}
          className="border-input bg-background h-11 w-full rounded-lg border px-3"
        >
          <option value="es">Castellano</option>
          <option value="ca">Català</option>
        </select>
      </div>
      <label className="flex items-start gap-3 text-sm">
        <input
          type="checkbox"
          name="marketingConsent"
          defaultChecked={marketingConsent}
          className="mt-0.5 size-4 accent-[var(--accent)]"
        />
        <span>{t("profile.marketingConsent")}</span>
      </label>
      <Button type="submit" disabled={pending}>
        {t("profile.save")}
      </Button>
    </form>
  );
}

export function DeleteAccountForm({ needsPassword = true }: { needsPassword?: boolean }) {
  const t = useTranslations();
  const locale = useLocale();
  const [state, action, pending] = useActionState(deleteAccountAction, initial);
  return (
    <form action={action} className="space-y-4">
      <input type="hidden" name="locale" value={locale} />
      {state.message && <Alert tone="error">{t(state.message)}</Alert>}
      {!needsPassword && (
        <p className="text-muted-foreground text-sm">{t("profile.deleteGoogleHint")}</p>
      )}
      {needsPassword && (
        <div className="space-y-2">
          <Label htmlFor="delete-password">{t("auth.fields.password")}</Label>
          <Input
            id="delete-password"
            name="password"
            type="password"
            autoComplete="current-password"
            required
            aria-invalid={state.errors?.password ? true : undefined}
            aria-describedby="delete-password-error"
          />
          <FieldError id="delete-password-error">
            {state.errors?.password &&
              t(
                `profile.errors.${state.errors.password === "wrongPassword" ? "wrongPassword" : "required"}`,
              )}
          </FieldError>
        </div>
      )}
      <div className="space-y-2">
        <Label htmlFor="delete-confirm">{t("profile.deleteConfirmLabel")}</Label>
        <Input
          id="delete-confirm"
          name="confirm"
          autoComplete="off"
          required
          aria-invalid={state.errors?.confirm ? true : undefined}
          aria-describedby="delete-confirm-error"
        />
        <FieldError id="delete-confirm-error">
          {state.errors?.confirm && t("profile.errors.confirmWord")}
        </FieldError>
      </div>
      <Button type="submit" variant="danger" disabled={pending}>
        {t("profile.deleteSubmit")}
      </Button>
    </form>
  );
}

function fieldMessage(t: ReturnType<typeof useTranslations>, key?: string) {
  if (!key) return undefined;
  if (key === "wrongPassword") return t("profile.errors.wrongPassword");
  if (key === "sameEmail") return t("profile.errors.sameEmail");
  return t(`validation.${key}`);
}

function Field({
  id,
  name,
  label,
  type = "text",
  autoComplete,
  error,
  hint,
}: {
  id: string;
  name: string;
  label: string;
  type?: string;
  autoComplete: string;
  error?: string;
  hint?: string;
}) {
  return (
    <div className="space-y-2">
      <Label htmlFor={id}>{label}</Label>
      <Input
        id={id}
        name={name}
        type={type}
        autoComplete={autoComplete}
        required
        aria-invalid={error ? true : undefined}
        aria-describedby={`${id}-error${hint ? ` ${id}-hint` : ""}`}
      />
      {hint && (
        <p id={`${id}-hint`} className="text-muted-foreground text-xs">
          {hint}
        </p>
      )}
      <FieldError id={`${id}-error`}>{error}</FieldError>
    </div>
  );
}

export function ChangePasswordForm() {
  const t = useTranslations();
  const [state, action, pending] = useActionState(changePasswordAction, initial);
  return (
    <form action={action} className="space-y-4" key={state.status === "success" ? "done" : "form"}>
      {state.message && (
        <Alert tone={state.status === "error" ? "error" : "success"}>{t(state.message)}</Alert>
      )}
      <Field
        id="pw-current"
        name="currentPassword"
        type="password"
        label={t("profile.currentPassword")}
        autoComplete="current-password"
        error={fieldMessage(t, state.errors?.currentPassword)}
      />
      <Field
        id="pw-new"
        name="password"
        type="password"
        label={t("profile.newPassword")}
        autoComplete="new-password"
        hint={t("profile.passwordHint")}
        error={fieldMessage(t, state.errors?.password)}
      />
      <Field
        id="pw-confirm"
        name="confirm"
        type="password"
        label={t("profile.confirmNewPassword")}
        autoComplete="new-password"
        error={fieldMessage(t, state.errors?.confirm)}
      />
      <Button type="submit" disabled={pending}>
        {t("profile.changePasswordSubmit")}
      </Button>
    </form>
  );
}

export function ChangeEmailForm() {
  const t = useTranslations();
  const locale = useLocale();
  const [state, action, pending] = useActionState(changeEmailAction, initial);
  return (
    <form action={action} className="space-y-4">
      <input type="hidden" name="locale" value={locale} />
      {state.message && (
        <Alert tone={state.status === "error" ? "error" : "success"}>{t(state.message)}</Alert>
      )}
      <Field
        id="email-new"
        name="email"
        type="email"
        label={t("profile.newEmail")}
        autoComplete="email"
        error={fieldMessage(t, state.errors?.email)}
      />
      <Field
        id="email-current-password"
        name="currentPassword"
        type="password"
        label={t("profile.currentPassword")}
        autoComplete="current-password"
        error={fieldMessage(t, state.errors?.currentPassword)}
      />
      <Button type="submit" variant="outline" disabled={pending}>
        {t("profile.changeEmailSubmit")}
      </Button>
    </form>
  );
}
