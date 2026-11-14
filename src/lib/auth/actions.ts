"use server";

import { headers } from "next/headers";
import { redirect as redirectExternal } from "next/navigation";
import { getLocale } from "next-intl/server";
import { redirect } from "@/i18n/navigation";
import { createClient } from "@/lib/supabase/server";
import { publicEnv } from "@/lib/env";
import { authLimiter } from "@/lib/rate-limit";
import { safeNextPath, stripLocale } from "@/lib/paths";
import {
  fieldErrors,
  forgotSchema,
  oauthSchema,
  resetSchema,
  signInSchema,
  signUpSchema,
  type FieldErrors,
} from "./schemas";

export type FormState = {
  status: "idle" | "error" | "success";
  message?: string; // clave i18n
  errors?: FieldErrors;
  values?: Record<string, string>;
};

async function clientKey(action: string) {
  const h = await headers();
  const ip = h.get("x-forwarded-for")?.split(",")[0]?.trim() || h.get("x-real-ip") || "local";
  return `${action}:${ip}`;
}

async function limited(action: string): Promise<FormState | null> {
  const r = authLimiter(await clientKey(action));
  return r.ok ? null : { status: "error", message: "errors.rateLimited" };
}

const localePath = (locale: string, path: string) => (locale === "es" ? path : `/${locale}${path}`);

export async function signUpAction(_: FormState, formData: FormData): Promise<FormState> {
  const raw = Object.fromEntries(formData) as Record<string, string>;
  const values = {
    email: raw.email ?? "",
    displayName: raw.displayName ?? "",
    ref: raw.ref ?? "",
  };
  const parsed = signUpSchema.safeParse(raw);
  if (!parsed.success) return { status: "error", errors: fieldErrors(parsed.error), values };
  const block = await limited("signup");
  if (block) return { ...block, values };

  const { email, password, displayName, next, ref, locale } = parsed.data;
  const supabase = await createClient();
  const { error } = await supabase.auth.signUp({
    email,
    password,
    options: {
      emailRedirectTo: `${publicEnv.NEXT_PUBLIC_SITE_URL}/auth/callback?next=${encodeURIComponent(
        localePath(locale, safeNextPath(next, "/app/onboarding")),
      )}`,
      // `ref`: código de embajadora; handle_new_user lo apunta si existe (ADR-054).
      data: { display_name: displayName, locale, ...(ref ? { ref } : {}) },
    },
  });
  if (error) {
    // No revelamos si el email existe: GoTrue ya devuelve éxito ofuscado en ese caso.
    const message = error.code === "weak_password" ? "errors.weakPassword" : "errors.generic";
    return { status: "error", message, values };
  }
  redirect({ href: `/verifica-tu-correo?email=${encodeURIComponent(email)}`, locale });
  return { status: "success" };
}

export async function signInAction(_: FormState, formData: FormData): Promise<FormState> {
  const raw = Object.fromEntries(formData) as Record<string, string>;
  const values = { email: raw.email ?? "" };
  const parsed = signInSchema.safeParse(raw);
  if (!parsed.success) return { status: "error", errors: fieldErrors(parsed.error), values };
  const block = await limited("signin");
  if (block) return { ...block, values };

  const { email, password, next, locale } = parsed.data;
  const supabase = await createClient();
  const { error } = await supabase.auth.signInWithPassword({ email, password });
  if (error) {
    const message =
      error.code === "email_not_confirmed"
        ? "errors.emailNotConfirmed"
        : "errors.invalidCredentials";
    return { status: "error", message, values };
  }
  await supabase.rpc("track_activity", { p_kind: "auth.sign_in" });
  redirect({ href: safeNextPath(next, "/app"), locale });
  return { status: "success" };
}

/**
 * «Continuar con Google»: pide a Supabase la URL de Google (flujo PKCE, el verificador
 * queda en una cookie) y manda allí al usuario. Google vuelve a /auth/callback, que
 * canjea el código por la sesión. Sirve tanto para entrar como para crear la cuenta.
 */
export async function googleSignInAction(_: FormState, formData: FormData): Promise<FormState> {
  const parsed = oauthSchema.safeParse(Object.fromEntries(formData));
  if (!parsed.success) return { status: "error", message: "errors.generic" };
  const block = await limited("oauth");
  if (block) return block;

  const { locale } = parsed.data;
  const target = safeNextPath(parsed.data.next, "/app");
  // `next` puede venir ya con prefijo de idioma (/ca/app/...): no lo duplicamos.
  const next = stripLocale(target) === target ? localePath(locale, target) : target;
  const callback = new URL("/auth/callback", publicEnv.NEXT_PUBLIC_SITE_URL);
  callback.searchParams.set("next", next);
  callback.searchParams.set("via", "google");
  if (parsed.data.ref) callback.searchParams.set("ref", parsed.data.ref);

  const supabase = await createClient();
  const { data, error } = await supabase.auth.signInWithOAuth({
    provider: "google",
    options: {
      redirectTo: callback.toString(),
      skipBrowserRedirect: true,
      queryParams: { prompt: "select_account" },
    },
  });
  if (error || !data.url) return { status: "error", message: "errors.oauth" };
  redirectExternal(data.url);
}

export async function forgotPasswordAction(_: FormState, formData: FormData): Promise<FormState> {
  const raw = Object.fromEntries(formData) as Record<string, string>;
  const parsed = forgotSchema.safeParse(raw);
  if (!parsed.success)
    return {
      status: "error",
      errors: fieldErrors(parsed.error),
      values: { email: raw.email ?? "" },
    };
  const block = await limited("forgot");
  if (block) return block;

  const { email, locale } = parsed.data;
  const supabase = await createClient();
  await supabase.auth.resetPasswordForEmail(email, {
    redirectTo: `${publicEnv.NEXT_PUBLIC_SITE_URL}/auth/callback?next=${encodeURIComponent(
      localePath(locale, "/restablecer"),
    )}`,
  });
  // Respuesta idéntica exista o no la cuenta (evita enumeración de usuarios).
  return { status: "success", message: "auth.forgot.sent" };
}

export async function resetPasswordAction(_: FormState, formData: FormData): Promise<FormState> {
  const raw = Object.fromEntries(formData) as Record<string, string>;
  const parsed = resetSchema.safeParse(raw);
  if (!parsed.success) return { status: "error", errors: fieldErrors(parsed.error) };
  const supabase = await createClient();
  const {
    data: { user },
  } = await supabase.auth.getUser();
  if (!user) return { status: "error", message: "errors.sessionExpired" };
  const { error } = await supabase.auth.updateUser({ password: parsed.data.password });
  if (error) {
    const message = error.code === "same_password" ? "errors.samePassword" : "errors.generic";
    return { status: "error", message };
  }
  redirect({ href: "/app?pw=updated", locale: parsed.data.locale });
  return { status: "success" };
}

export async function signOutAction() {
  const supabase = await createClient();
  await supabase.auth.signOut();
  redirect({ href: "/", locale: await getLocale() });
}
