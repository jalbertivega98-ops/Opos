import type { User } from "@supabase/supabase-js";

/**
 * ¿La cuenta tiene contraseña de OPOSAPRUEBA? Las altas por correo tienen identidad «email»;
 * quien solo ha entrado con Google no tiene contraseña que pedir para reautenticarse.
 * Si alguien se registró con correo y luego usa Google con el mismo correo, Supabase
 * enlaza ambas identidades y sigue teniendo contraseña.
 */
export function hasPassword(user: Pick<User, "identities" | "app_metadata">): boolean {
  if (user.identities?.length) return user.identities.some((i) => i.provider === "email");
  const providers = user.app_metadata?.providers as unknown;
  if (Array.isArray(providers)) return providers.includes("email");
  return user.app_metadata?.provider !== "google";
}

/** Minutos que damos tras entrar con Google para acciones sensibles (borrar la cuenta). */
export const RECENT_SIGN_IN_MINUTES = 10;

export function signedInRecently(
  user: Pick<User, "last_sign_in_at">,
  now = Date.now(),
  minutes = RECENT_SIGN_IN_MINUTES,
): boolean {
  if (!user.last_sign_in_at) return false;
  const at = Date.parse(user.last_sign_in_at);
  return Number.isFinite(at) && now - at <= minutes * 60_000;
}
