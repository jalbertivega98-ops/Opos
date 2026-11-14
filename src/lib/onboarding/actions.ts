"use server";

import { redirect } from "@/i18n/navigation";
import { createClient } from "@/lib/supabase/server";
import { onboardingSchema } from "./schema";

export type OnboardingState = {
  status: "idle" | "error";
  errors?: Record<string, string>;
  message?: string;
};

export async function saveOnboardingAction(
  _: OnboardingState,
  formData: FormData,
): Promise<OnboardingState> {
  const parsed = onboardingSchema.safeParse({
    exam: formData.get("exam"),
    level: formData.get("level"),
    weeklyHours: formData.get("weeklyHours"),
    goals: formData.getAll("goals"),
    notifyConsent: formData.get("notifyConsent") === "on",
    displayName: formData.get("displayName") ?? undefined,
    locale: formData.get("locale"),
  });
  if (!parsed.success) {
    const errors: Record<string, string> = {};
    for (const i of parsed.error.issues) errors[String(i.path[0])] ??= i.code;
    return { status: "error", errors };
  }
  const d = parsed.data;
  const supabase = await createClient();
  const {
    data: { user },
  } = await supabase.auth.getUser();
  if (!user) return { status: "error", message: "errors.sessionExpired" };

  const { data: exam } = await supabase
    .from("exam_bodies")
    .select("id, availability")
    .eq("slug", d.exam)
    .eq("is_published", true)
    .maybeSingle();
  if (!exam) return { status: "error", errors: { exam: "invalid_value" } };

  // Solo una oposición principal por alumno (índice único parcial en BD).
  const clear = await supabase
    .from("user_exam_targets")
    .update({ is_primary: false })
    .eq("user_id", user.id)
    .neq("exam_body_id", exam.id);
  if (clear.error) return { status: "error", message: "errors.generic" };

  const { error } = await supabase.from("user_exam_targets").upsert({
    user_id: user.id,
    exam_body_id: exam.id,
    is_primary: true,
    follow_only: exam.availability === "coming_soon",
    notify_consent: d.notifyConsent,
    level: d.level,
    weekly_hours: d.weeklyHours,
    goals: d.goals,
  });
  if (error) return { status: "error", message: "errors.generic" };

  await supabase
    .from("profiles")
    .update({
      onboarding_completed_at: new Date().toISOString(),
      // Solo si lo ha escrito: no borramos el nombre que llega de Google.
      ...(d.displayName ? { display_name: d.displayName } : {}),
    })
    .eq("id", user.id);
  await supabase.rpc("track_activity", {
    p_kind: "onboarding.completed",
    p_metadata: { exam: d.exam },
  });
  redirect({ href: "/app?welcome=1", locale: d.locale });
  return { status: "idle" };
}
