"use client";

import { useActionState } from "react";
import { useLocale, useTranslations } from "next-intl";
import { Link } from "@/i18n/navigation";
import { Button } from "@/components/ui/button";
import { Alert, FieldError, Input, Label } from "@/components/ui/form";
import {
  forgotPasswordAction,
  resetPasswordAction,
  signInAction,
  signUpAction,
  type FormState,
} from "@/lib/auth/actions";

const initial: FormState = { status: "idle" };

/** Devuelve traductores: `field` para errores de campo y `msg` para mensajes del formulario. */
function useErrorText() {
  const t = useTranslations();
  const field = (key?: string) => (key ? t(`validation.${key}`) : undefined);
  const msg = (key?: string) => (key ? t(key) : undefined);
  return Object.assign(field, { msg });
}

function Field({
  name,
  label,
  type = "text",
  autoComplete,
  error,
  defaultValue,
  hint,
  required = true,
}: {
  name: string;
  label: string;
  type?: string;
  autoComplete?: string;
  error?: string;
  defaultValue?: string;
  hint?: string;
  required?: boolean;
}) {
  const errorId = `${name}-error`;
  const hintId = `${name}-hint`;
  return (
    <div className="space-y-2">
      <Label htmlFor={name}>{label}</Label>
      <Input
        id={name}
        name={name}
        type={type}
        autoComplete={autoComplete}
        defaultValue={defaultValue}
        required={required}
        aria-invalid={error ? true : undefined}
        aria-describedby={[error && errorId, hint && hintId].filter(Boolean).join(" ") || undefined}
      />
      {hint && !error && (
        <p id={hintId} className="text-muted-foreground text-xs">
          {hint}
        </p>
      )}
      <FieldError id={errorId}>{error}</FieldError>
    </div>
  );
}

export function SignInForm({ next, linkError }: { next?: string; linkError?: boolean }) {
  const t = useTranslations("auth");
  const err = useErrorText();
  const locale = useLocale();
  const [state, action, pending] = useActionState(signInAction, initial);
  return (
    <form action={action} className="space-y-4" noValidate>
      {linkError && state.status === "idle" && <Alert tone="error">{t("signIn.linkError")}</Alert>}
      {state.message && <Alert tone="error">{err.msg(state.message)}</Alert>}
      <input type="hidden" name="locale" value={locale} />
      {next && <input type="hidden" name="next" value={next} />}
      <Field
        name="email"
        type="email"
        autoComplete="email"
        label={t("fields.email")}
        error={err(state.errors?.email)}
        defaultValue={state.values?.email}
      />
      <Field
        name="password"
        type="password"
        autoComplete="current-password"
        label={t("fields.password")}
        error={err(state.errors?.password)}
      />
      <div className="text-right text-sm">
        <Link href="/recuperar" className="text-accent hover:underline">
          {t("signIn.forgot")}
        </Link>
      </div>
      <Button type="submit" className="w-full" disabled={pending}>
        {t("signIn.submit")}
      </Button>
      <p className="text-muted-foreground text-center text-sm">
        {t("signIn.noAccount")}{" "}
        <Link href="/registro" className="text-accent font-semibold hover:underline">
          {t("signIn.createOne")}
        </Link>
      </p>
    </form>
  );
}

export function SignUpForm() {
  const t = useTranslations("auth");
  const err = useErrorText();
  const locale = useLocale();
  const [state, action, pending] = useActionState(signUpAction, initial);
  return (
    <form action={action} className="space-y-4" noValidate>
      {state.message && <Alert tone="error">{err.msg(state.message)}</Alert>}
      <input type="hidden" name="locale" value={locale} />
      <Field
        name="displayName"
        autoComplete="given-name"
        label={t("fields.displayName")}
        required={false}
        defaultValue={state.values?.displayName}
        error={err(state.errors?.displayName)}
      />
      <Field
        name="email"
        type="email"
        autoComplete="email"
        label={t("fields.email")}
        error={err(state.errors?.email)}
        defaultValue={state.values?.email}
      />
      <Field
        name="password"
        type="password"
        autoComplete="new-password"
        label={t("fields.password")}
        hint={t("signUp.passwordHint")}
        error={err(state.errors?.password)}
      />
      <div className="space-y-2">
        <label className="flex items-start gap-3 text-sm">
          <input
            type="checkbox"
            name="acceptTerms"
            required
            className="mt-0.5 size-4 accent-[var(--accent)]"
            aria-invalid={state.errors?.acceptTerms ? true : undefined}
            aria-describedby={state.errors?.acceptTerms ? "acceptTerms-error" : undefined}
          />
          <span>
            {t.rich("signUp.terms", {
              terms: (c) => (
                <Link href="/legal/condiciones" className="text-accent underline" target="_blank">
                  {c}
                </Link>
              ),
              privacy: (c) => (
                <Link href="/legal/privacidad" className="text-accent underline" target="_blank">
                  {c}
                </Link>
              ),
            })}
          </span>
        </label>
        <FieldError id="acceptTerms-error">{err(state.errors?.acceptTerms)}</FieldError>
      </div>
      <Button type="submit" variant="accent" className="w-full" disabled={pending}>
        {t("signUp.submit")}
      </Button>
      <p className="text-muted-foreground text-center text-sm">
        {t("signUp.hasAccount")}{" "}
        <Link href="/entrar" className="text-accent font-semibold hover:underline">
          {t("signUp.signIn")}
        </Link>
      </p>
    </form>
  );
}

export function ForgotForm() {
  const t = useTranslations("auth");
  const err = useErrorText();
  const locale = useLocale();
  const [state, action, pending] = useActionState(forgotPasswordAction, initial);
  if (state.status === "success") {
    return <Alert tone="success">{t("forgot.sent")}</Alert>;
  }
  return (
    <form action={action} className="space-y-4" noValidate>
      {state.message && <Alert tone="error">{err.msg(state.message)}</Alert>}
      <input type="hidden" name="locale" value={locale} />
      <Field
        name="email"
        type="email"
        autoComplete="email"
        label={t("fields.email")}
        error={err(state.errors?.email)}
        defaultValue={state.values?.email}
      />
      <Button type="submit" className="w-full" disabled={pending}>
        {t("forgot.submit")}
      </Button>
      <p className="text-center text-sm">
        <Link href="/entrar" className="text-accent hover:underline">
          {t("forgot.back")}
        </Link>
      </p>
    </form>
  );
}

export function ResetForm() {
  const t = useTranslations("auth");
  const err = useErrorText();
  const locale = useLocale();
  const [state, action, pending] = useActionState(resetPasswordAction, initial);
  return (
    <form action={action} className="space-y-4" noValidate>
      {state.message && <Alert tone="error">{err.msg(state.message)}</Alert>}
      <input type="hidden" name="locale" value={locale} />
      <Field
        name="password"
        type="password"
        autoComplete="new-password"
        label={t("fields.password")}
        hint={t("signUp.passwordHint")}
        error={err(state.errors?.password)}
      />
      <Field
        name="confirm"
        type="password"
        autoComplete="new-password"
        label={t("fields.confirm")}
        error={err(state.errors?.confirm)}
      />
      <Button type="submit" className="w-full" disabled={pending}>
        {t("reset.submit")}
      </Button>
    </form>
  );
}
