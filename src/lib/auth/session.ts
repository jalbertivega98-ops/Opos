import "server-only";
import { cache } from "react";
import { createClient } from "@/lib/supabase/server";
import { redirect } from "@/i18n/navigation";

export type Profile = {
  id: string;
  display_name: string | null;
  locale: "es" | "ca";
  role: "student" | "editor" | "admin" | "owner";
  status: "active" | "suspended" | "pending_deletion";
  onboarding_completed_at: string | null;
  created_at: string;
};

/** Usuario + perfil de la petición actual (memoizado por petición). */
export const getSession = cache(async () => {
  const supabase = await createClient();
  const {
    data: { user },
  } = await supabase.auth.getUser();
  if (!user) return { user: null, profile: null } as const;
  const { data: profile } = await supabase
    .from("profiles")
    .select("id, display_name, locale, role, status, onboarding_completed_at, created_at")
    .eq("id", user.id)
    .single<Profile>();
  return { user, profile } as const;
});

export async function requireUser(locale: string, next = "/app") {
  const session = await getSession();
  if (!session.user || !session.profile) {
    redirect({ href: `/entrar?next=${encodeURIComponent(next)}`, locale });
  }
  if (session.profile!.status !== "active") {
    redirect({ href: "/cuenta-suspendida", locale });
  }
  return { user: session.user!, profile: session.profile! };
}

export const isAdminRole = (role: Profile["role"]) => role === "admin" || role === "owner";
export const isStaffRole = (role: Profile["role"]) => role !== "student";

/** Solo administración. Comprobación en servidor además de RLS. */
export async function requireAdmin(locale: string) {
  const session = await requireUser(locale, "/admin");
  if (!isAdminRole(session.profile.role)) {
    redirect({ href: "/app", locale });
  }
  return session;
}
