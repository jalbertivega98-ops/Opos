"use server";

import { revalidatePath } from "next/cache";
import { getSession, isAdminRole } from "@/lib/auth/session";
import { createClient } from "@/lib/supabase/server";
import { ambassadorCreateSchema, ambassadorToggleSchema } from "./schemas";

export type AmbassadorActionState = {
  status: "idle" | "error" | "success";
  message?: string; // clave i18n
  errors?: Partial<Record<"code" | "name", string>>;
};

async function isAdmin() {
  const { user, profile } = await getSession();
  return Boolean(user && profile?.status === "active" && isAdminRole(profile.role));
}

const refresh = () => revalidatePath("/[locale]/admin/embajadoras", "page");

/** Alta de una embajadora con su código propio (ADR-054). */
export async function createAmbassadorAction(
  _: AmbassadorActionState,
  formData: FormData,
): Promise<AmbassadorActionState> {
  if (!(await isAdmin())) return { status: "error", message: "adminAmbassadors.notAllowed" };
  const parsed = ambassadorCreateSchema.safeParse(Object.fromEntries(formData));
  if (!parsed.success) {
    const errors: AmbassadorActionState["errors"] = {};
    for (const issue of parsed.error.issues) {
      const field = String(issue.path[0]);
      if (field === "code" || field === "name") errors[field] = `adminAmbassadors.errors.${field}`;
    }
    return { status: "error", message: "adminAmbassadors.errors.invalid", errors };
  }
  const { code, name, network, handle, exam, notes } = parsed.data;
  const supabase = await createClient();
  const {
    data: { user },
  } = await supabase.auth.getUser();
  const { error } = await supabase.from("ambassadors").insert({
    code,
    name,
    network,
    handle,
    exam_body_id: exam,
    notes,
    created_by: user?.id ?? null,
  });
  if (error) {
    return error.code === "23505"
      ? {
          status: "error",
          message: "adminAmbassadors.errors.taken",
          errors: { code: "adminAmbassadors.errors.taken" },
        }
      : { status: "error", message: "errors.generic" };
  }
  refresh();
  return { status: "success", message: "adminAmbassadors.created" };
}

/** Pausar o reactivar una embajadora: pausada, su enlace sigue llevando al registro pero no cuenta. */
export async function toggleAmbassadorAction(formData: FormData): Promise<void> {
  if (!(await isAdmin())) return;
  const parsed = ambassadorToggleSchema.safeParse(Object.fromEntries(formData));
  if (!parsed.success) return;
  const supabase = await createClient();
  await supabase
    .from("ambassadors")
    .update({ active: parsed.data.active })
    .eq("id", parsed.data.id);
  refresh();
}
