"use server";

import { revalidatePath } from "next/cache";
import { z } from "zod";
import { getSession } from "@/lib/auth/session";
import { createClient } from "@/lib/supabase/server";

export type PlanFormState = { status: "idle" | "success" | "error"; message?: string };

const schema = z.object({
  weeklyHours: z.coerce.number().int().min(1).max(80),
  level: z.enum(["beginner", "intermediate", "advanced"]),
  targetDate: z
    .string()
    .regex(/^\d{4}-\d{2}-\d{2}$/)
    .or(z.literal(""))
    .transform((v) => v || null),
});

/** Ajustes del plan: horas por semana, nivel y fecha objetivo (opcional). */
export async function savePlanSettingsAction(
  _: PlanFormState,
  formData: FormData,
): Promise<PlanFormState> {
  const { user, profile } = await getSession();
  if (!user || profile?.status !== "active") return { status: "error", message: "auth" };
  const parsed = schema.safeParse(Object.fromEntries(formData));
  if (!parsed.success) return { status: "error", message: "invalid" };
  const { weeklyHours, level, targetDate } = parsed.data;
  if (targetDate && new Date(targetDate) <= new Date()) return { status: "error", message: "past" };
  const supabase = await createClient();
  const { error } = await supabase
    .from("user_exam_targets")
    .update({ weekly_hours: weeklyHours, level, target_date: targetDate })
    .eq("user_id", user.id)
    .eq("is_primary", true);
  if (error) return { status: "error", message: "invalid" };
  revalidatePath("/[locale]/app", "layout");
  return { status: "success", message: "saved" };
}
