"use client";

import { useEffect, useSyncExternalStore } from "react";
import type { Session } from "@supabase/supabase-js";
import { usePathname } from "@/i18n/navigation";
import { createClient } from "@/lib/supabase/client";

/**
 * Estado de sesión en el navegador, solo para la interfaz pública (cabecera,
 * «Entrar» o «Mi panel», guía del visitante). Así las páginas públicas no leen
 * cookies en el servidor y se pueden servir en caché (ADR-060). Nunca decide
 * permisos: los datos siguen protegidos por RLS y `requireUser` en servidor.
 */
export type AuthState = { status: "unknown" | "anon" | "user"; isAdmin: boolean };

const UNKNOWN: AuthState = { status: "unknown", isAdmin: false };
let state: AuthState = UNKNOWN;
let userId: string | null = null;
let client: ReturnType<typeof createClient> | null = null;
const listeners = new Set<() => void>();

function emit(next: AuthState) {
  if (next.status === state.status && next.isAdmin === state.isAdmin) return;
  state = next;
  listeners.forEach((l) => l());
}

async function apply(session: Session | null) {
  if (!session) {
    userId = null;
    return emit({ status: "anon", isAdmin: false });
  }
  if (session.user.id === userId && state.status === "user") return;
  userId = session.user.id;
  emit({ status: "user", isAdmin: false });
  const { data } = await client!
    .from("profiles")
    .select("role")
    .eq("id", session.user.id)
    .maybeSingle<{ role: string }>();
  if (userId === session.user.id) {
    emit({ status: "user", isAdmin: data?.role === "admin" || data?.role === "owner" });
  }
}

function start() {
  if (client) return;
  client = createClient();
  client.auth.onAuthStateChange((_event, session) => {
    // Fuera del callback: supabase-js no admite otra llamada suya dentro de él.
    setTimeout(() => void apply(session), 0);
  });
}

/** Vuelve a leer la cookie (p. ej. tras entrar o salir en el servidor). */
export async function recheckAuth() {
  start();
  const { data } = await client!.auth.getSession();
  await apply(data.session);
}

function subscribe(listener: () => void) {
  start();
  listeners.add(listener);
  return () => listeners.delete(listener);
}

export function useAuth(): AuthState {
  const pathname = usePathname();
  useEffect(() => {
    void recheckAuth();
  }, [pathname]);
  return useSyncExternalStore(
    subscribe,
    () => state,
    () => UNKNOWN,
  );
}

/** Cierra la sesión en el navegador (borra las cookies) y recarga la portada. */
export async function signOutInBrowser(home: string) {
  start();
  await client!.auth.signOut();
  window.location.assign(home);
}
