"use server";

import { revalidatePath } from "next/cache";
import { redirect } from "@/i18n/navigation";
import { createClient } from "@/lib/supabase/server";
import { authLimiter } from "@/lib/rate-limit";
import { deleteAccountSchema, profileSchema } from "./schema";

export type AccountState = {
  status: "idle" | "error" | "success";
  message?: string;
  errors?: Record<string, string>;
};

export async function updateProfileAction(_: AccountState, formData: FormData): Promise<AccountState> {
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

export async function deleteAccountAction(_: AccountState, formData: FormData): Promise<AccountState> {
  const parsed = deleteAccountSchema.safeParse(Object.fromEntries(formData));
  if (!parsed.success) {
    const errors: Record<string, string> = {};
    for (const i of parsed.error.issues) errors[String(i.path[0])] ??= i.message === "confirmWord" ? "confirmWord" : i.code;
    return { status: "error", errors };
  }
  const supabase = await createClient();
  const {
    data: { user },
  } = await supabase.auth.getUser();
  if (!user?.email) return { status: "error", message: "errors.sessionExpired" };
  if (!authLimiter(`delete:${user.id}`).ok) return { status: "error", message: "errors.rateLimited" };

  // Reautenticación: confirma que quien borra conoce la contraseña.
  const { error: authError } = await supabase.auth.signInWithPassword({
    email: user.email,
    password: parsed.data.password,
  });
  if (authError) return { status: "error", errors: { password: "wrongPassword" } };

  const { error } = await supabase.rpc("delete_my_account");
  if (error) return { status: "error", message: "errors.generic" };
  await supabase.auth.signOut();
  redirect({ href: "/?cuenta=eliminada", locale: parsed.data.locale });
  return { status: "success" };
}
