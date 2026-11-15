"use client";

import type { ReactNode } from "react";
import { useSearchParams } from "next/navigation";
import { useAuth } from "@/components/auth/use-auth";
import { VisitorTour } from "@/components/landing/visitor-tour";

/**
 * Partes de la portada que dependen de quién mira o de la URL, resueltas en el
 * navegador para que la portada se sirva en caché (ADR-059). Van dentro de
 * `<Suspense>` porque leen `useSearchParams`.
 */
export function VisitorTourGate() {
  const { status } = useAuth();
  const force = useSearchParams().get("guia") === "1";
  return status === "anon" ? <VisitorTour force={force} /> : null;
}

/** Aviso tras borrar la cuenta (`/?cuenta=eliminada`). */
export function DeletedAccountNotice({ children }: { children: ReactNode }) {
  return useSearchParams().get("cuenta") === "eliminada" ? (
    <div
      role="status"
      className="bg-accent-soft border-border border-b px-4 py-3 text-center text-sm"
    >
      {children}
    </div>
  ) : null;
}
