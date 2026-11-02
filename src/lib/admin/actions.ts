"use server";

import { revalidatePath } from "next/cache";
import { z } from "zod";
import { createClient } from "@/lib/supabase/server";

const schema = z.object({
  id: z.uuid(),
  status: z.enum(["active", "suspended"]),
});

export type AdminActionState = { status: "idle" | "error" | "success"; message?: string };

export async function setUserStatusAction(
  _: AdminActionState,
  formData: FormData,
): Promise<AdminActionState> {
  const parsed = schema.safeParse(Object.fromEntries(formData));
  if (!parsed.success) return { status: "error", message: "errors.generic" };
  const supabase = await createClient();
  const { error } = await supabase.rpc("admin_set_user_status", {
    p_id: parsed.data.id,
    p_status: parsed.data.status,
  });
  if (error) {
    return {
      status: "error",
      message: error.code === "42501" ? "adminUsers.notAllowed" : "errors.generic",
    };
  }
  revalidatePath("/[locale]/admin/alumnos/[id]", "page");
  return { status: "success", message: "adminUsers.statusSaved" };
}
