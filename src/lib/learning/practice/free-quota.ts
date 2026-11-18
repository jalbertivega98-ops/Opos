import { PSYCHO_TYPES, type PsychoType } from "@/lib/learning/psycho/types";

/**
 * Muestra gratis de psicotécnicos (ADR-067): sin Premium, el alumno puede hacer
 * FREE_PSYCHO_PER_TYPE ejercicios de cada tipo, una sola vez, para probarlos todos.
 * Con un Premium (de cualquier oposición) o el pack completo, la práctica es ilimitada.
 * El repaso de fallos no gasta muestra.
 */
export const FREE_PSYCHO_PER_TYPE = 5;
export const FREE_PSYCHO_TOTAL = FREE_PSYCHO_PER_TYPE * PSYCHO_TYPES.length;

type LibraryLike = {
  type: string;
  source: string;
  is_test: boolean;
  attempts_left: number | null;
};

/** Premium o pack completo real (no de prueba ni gratuito): bundle sin límite de intentos. */
export function hasUnlimitedPsycho(library: LibraryLike[]) {
  return library.some(
    (i) => !i.is_test && i.source !== "free" && i.type === "bundle" && i.attempts_left === null,
  );
}

export type PsychoQuota =
  { unlimited: true } | { unlimited: false; left: Record<PsychoType, number>; totalLeft: number };

/** Cuántos ejercicios gratis le quedan por tipo, a partir de los que ya ha empezado. */
export function psychoQuota(
  unlimited: boolean,
  usedByType: Partial<Record<string, number>>,
): PsychoQuota {
  if (unlimited) return { unlimited: true };
  const left = Object.fromEntries(
    PSYCHO_TYPES.map((t) => [t, Math.max(0, FREE_PSYCHO_PER_TYPE - (usedByType[t] ?? 0))]),
  ) as Record<PsychoType, number>;
  const totalLeft = Object.values(left).reduce((a, b) => a + b, 0);
  return { unlimited: false, left, totalLeft };
}

/** Tamaño real de la sesión: el pedido, recortado a lo que quede de muestra. */
export function allowedCount(quota: PsychoQuota, type: PsychoType, requested: number) {
  return quota.unlimited ? requested : Math.min(requested, quota.left[type]);
}
