"use client";

import { useActionState } from "react";
import { useLocale, useTranslations } from "next-intl";
import { Link } from "@/i18n/navigation";
import { examFromNext, signUpPath } from "@/lib/paths";
import { Button } from "@/components/ui/button";
import { Alert, FieldError, Input, Label } from "@/components/ui/form";
import {
  forgotPasswordAction,
  googleSignInAction,
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

/** Logotipo «G» de Google (obligatorio en el botón según sus normas de marca). */
function GoogleMark() {
  return (
    <svg viewBox="0 0 48 48" aria-hidden className="size-5 shrink-0">
      <path
        fill="#FFC107"
        d="M43.6 20.5H42V20H24v8h11.3C33.7 32.7 29.2 36 24 36c-6.6 0-12-5.4-12-12s5.4-12 12-12c3.1 0 5.8 1.2 7.9 3.1l5.7-5.7C34 6.1 29.3 4 24 4 12.9 4 4 12.9 4 24s8.9 20 20 20 20-8.9 20-20c0-1.3-.1-2.4-.4-3.5z"
      />
      <path
        fill="#FF3D00"
        d="m6.3 14.7 6.6 4.8C14.7 15.1 19 12 24 12c3.1 0 5.8 1.2 7.9 3.1l5.7-5.7C34 6.1 29.3 4 24 4 16.3 4 9.7 8.3 6.3 14.7z"
      />
      <path
        fill="#4CAF50"
        d="M24 44c5.2 0 9.9-2 13.4-5.2l-6.2-5.2C29.2 35.1 26.7 36 24 36c-5.2 0-9.6-3.3-11.3-7.9l-6.5 5C9.5 39.6 16.2 44 24 44z"
      />
      <path
        fill="#1976D2"
        d="M43.6 20.5H42V20H24v8h11.3c-.8 2.2-2.2 4.2-4.1 5.6l6.2 5.2C37 39.2 44 34 44 24c0-1.3-.1-2.4-.4-3.5z"
      />
    </svg>
  );
}

/**
 * «Continuar con Google» + separador. Formulario propio (no se pueden anidar formularios).
 * Al usarlo se crea la cuenta si no existe, así que mostramos el aviso de condiciones.
 */
export function GoogleSignIn({ next }: { next?: string }) {
  const t = useTranslations("auth");
  const err = useErrorText();
  const locale = useLocale();
  const [state, action, pending] = useActionState(googleSignInAction, initial);
  return (
    <div className="mb-6 space-y-4">
      <form action={action} className="space-y-3">
        {state.message && <Alert tone="error">{err.msg(state.message)}</Alert>}
        <input type="hidden" name="locale" value={locale} />
        {next && <input type="hidden" name="next" value={next} />}
        <Button type="submit" variant="outline" className="w-full gap-3" disabled={pending}>
          <GoogleMark />
          {t("google.button")}
        </Button>
        <p className="text-muted-foreground text-center text-xs">
          {t.rich("google.terms", {
            terms: (c) => (
              <Link href="/legal/condiciones" className="underline" target="_blank">
                {c}
              </Link>
            ),
            privacy: (c) => (
              <Link href="/legal/privacidad" className="underline" target="_blank">
                {c}
              </Link>
            ),
          })}
        </p>
      </form>
      <div className="text-muted-foreground flex items-center gap-3 text-xs" aria-hidden>
        <span className="bg-border h-px flex-1" />
        {t("google.or")}
        <span className="bg-border h-px flex-1" />
      </div>
    </div>
  );
}

export function SignInForm({
  next,
  linkError,
  oauthError,
}: {
  next?: string;
  linkError?: boolean;
  oauthError?: boolean;
}) {
  const t = useTranslations("auth");
  const err = useErrorText();
  const locale = useLocale();
  const [state, action, pending] = useActionState(signInAction, initial);
  return (
    <form action={action} className="space-y-4" noValidate>
      {linkError && state.status === "idle" && <Alert tone="error">{t("signIn.linkError")}</Alert>}
      {oauthError && state.status === "idle" && <Alert tone="error">{t("google.error")}</Alert>}
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
        <Link
          href={signUpPath(examFromNext(next))}
          className="text-accent font-semibold hover:underline"
        >
          {t("signIn.createOne")}
        </Link>
      </p>
    </form>
  );
}

export function SignUpForm({ next }: { next?: string }) {
  const t = useTranslations("auth");
  const err = useErrorText();
  const locale = useLocale();
  const [state, action, pending] = useActionState(signUpAction, initial);
  return (
    <form action={action} className="space-y-4" noValidate>
      {state.message && <Alert tone="error">{err.msg(state.message)}</Alert>}
      <input type="hidden" name="locale" value={locale} />
      {next && <input type="hidden" name="next" value={next} />}
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
        <Link
          href={next ? `/entrar?next=${encodeURIComponent(next)}` : "/entrar"}
          className="text-accent font-semibold hover:underline"
        >
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
