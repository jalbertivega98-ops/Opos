"use server";

import { revalidatePath } from "next/cache";
import { redirect } from "@/i18n/navigation";
import { createClient } from "@/lib/supabase/server";
import { authLimiter } from "@/lib/rate-limit";
import { fieldErrors } from "@/lib/auth/schemas";
import { hasPassword, signedInRecently } from "@/lib/auth/identity";
import { publicEnv } from "@/lib/env";
import {
  changeEmailSchema,
  changePasswordSchema,
  deleteAccountSchema,
  profileSchema,
} from "./schema";

export type AccountState = {
  status: "idle" | "error" | "success";
  message?: string;
  errors?: Record<string, string>;
};

export async function updateProfileAction(
  _: AccountState,
  formData: FormData,
): Promise<AccountState> {
  const parsed = profileSchema.safeParse({
    displayName: formData.get("displayName") ?? "",
    locale: formData.get("locale"),
    marketingConsent: formData.get("marketingConsent") === "on",
  });
  if (!parsed.success) {
    const errors: Record<string, string> = {};
    for (const i of parsed.error.issues) errors[String(i.path[0])] ??= i.code;
    return { status: "error", errors };
  }
  const supabase = await createClient();
  const {
    data: { user },
  } = await supabase.auth.getUser();
  if (!user) return { status: "error", message: "errors.sessionExpired" };

  const { displayName, locale, marketingConsent } = parsed.data;
  const { error } = await supabase
    .from("profiles")
    .update({ display_name: displayName || null, locale, marketing_consent: marketingConsent })
    .eq("id", user.id);
  if (error) return { status: "error", message: "errors.generic" };
  await supabase.rpc("track_activity", { p_kind: "profile.updated" });
  revalidatePath("/", "layout");
  // Si cambia el idioma preferido, llevamos al alumno a la interfaz en ese idioma.
  const current = String(formData.get("currentLocale") ?? "es");
  if (current !== locale) redirect({ href: "/app/perfil?saved=1", locale });
  return { status: "success", message: "profile.saved" };
}

export async function deleteAccountAction(
  _: AccountState,
  formData: FormData,
): Promise<AccountState> {
  const parsed = deleteAccountSchema.safeParse(Object.fromEntries(formData));
  if (!parsed.success) {
    const errors: Record<string, string> = {};
    for (const i of parsed.error.issues)
      errors[String(i.path[0])] ??= i.message === "confirmWord" ? "confirmWord" : i.code;
    return { status: "error", errors };
  }
  const supabase = await createClient();
  const {
    data: { user },
  } = await supabase.auth.getUser();
  if (!user?.email) return { status: "error", message: "errors.sessionExpired" };
  if (!authLimiter(`delete:${user.id}`).ok)
    return { status: "error", message: "errors.rateLimited" };

  if (hasPassword(user)) {
    // Reautenticación: confirma que quien borra conoce la contraseña.
    if (!parsed.data.password) return { status: "error", errors: { password: "too_small" } };
    const { error: authError } = await supabase.auth.signInWithPassword({
      email: user.email,
      password: parsed.data.password,
    });
    if (authError) return { status: "error", errors: { password: "wrongPassword" } };
  } else if (!signedInRecently(user)) {
    // Solo Google: no hay contraseña; pedimos haber entrado con Google hace poco.
    return { status: "error", message: "profile.errors.reauthGoogle" };
  }

  const { error } = await supabase.rpc("delete_my_account");
  if (error) return { status: "error", message: "errors.generic" };
  await supabase.auth.signOut();
  redirect({ href: "/?cuenta=eliminada", locale: parsed.data.locale });
  return { status: "success" };
}

/** Comprueba la contraseña actual antes de un cambio sensible. */
async function reauthenticate(
  action: string,
  currentPassword: string,
): Promise<
  | { error: AccountState }
  | { supabase: Awaited<ReturnType<typeof createClient>>; user: { email?: string } }
> {
  const supabase = await createClient();
  const {
    data: { user },
  } = await supabase.auth.getUser();
  if (!user?.email) return { error: { status: "error", message: "errors.sessionExpired" } };
  if (!authLimiter(`${action}:${user.id}`).ok)
    return { error: { status: "error", message: "errors.rateLimited" } };
  const { error } = await supabase.auth.signInWithPassword({
    email: user.email,
    password: currentPassword,
  });
  if (error)
    return {
      error: { status: "error", errors: { currentPassword: "wrongPassword" } },
    };
  return { supabase, user };
}

export async function changePasswordAction(
  _: AccountState,
  formData: FormData,
): Promise<AccountState> {
  const parsed = changePasswordSchema.safeParse(Object.fromEntries(formData));
  if (!parsed.success)
    return { status: "error", errors: fieldErrors(parsed.error) as Record<string, string> };
  const auth = await reauthenticate("password", parsed.data.currentPassword);
  if ("error" in auth) return auth.error;

  const { error } = await auth.supabase.auth.updateUser({ password: parsed.data.password });
  if (error) {
    const message = error.code === "same_password" ? "errors.samePassword" : "errors.generic";
    return { status: "error", message };
  }
  return { status: "success", message: "profile.passwordChanged" };
}

export async function changeEmailAction(
  _: AccountState,
  formData: FormData,
): Promise<AccountState> {
  const parsed = changeEmailSchema.safeParse(Object.fromEntries(formData));
  if (!parsed.success)
    return { status: "error", errors: fieldErrors(parsed.error) as Record<string, string> };
  const { email, currentPassword, locale } = parsed.data;
  const auth = await reauthenticate("email", currentPassword);
  if ("error" in auth) return auth.error;
  if (auth.user.email?.toLowerCase() === email)
    return { status: "error", errors: { email: "sameEmail" } };

  const next = locale === "es" ? "/app/perfil" : `/${locale}/app/perfil`;
  const { error } = await auth.supabase.auth.updateUser(
    { email },
    {
      emailRedirectTo: `${publicEnv.NEXT_PUBLIC_SITE_URL}/auth/callback?next=${encodeURIComponent(next)}`,
    },
  );
  // No revelamos si el correo ya pertenece a otra cuenta.
  if (error && error.code !== "email_exists") return { status: "error", message: "errors.generic" };
  return { status: "success", message: "profile.emailChangeSent" };
}
