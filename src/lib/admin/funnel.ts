/**
 * Cálculos del embudo del panel (ADR-047), sin dependencias de servidor para
 * poder probarlos. `rate` es el % que llega desde su paso de referencia (`base`):
 * por defecto el anterior, pero se puede indicar otro (crear cuenta no exige
 * hacer antes el test gratis, así que se compara con las visitas).
 * Si la referencia es 0, `rate` es null: no hay nada que comparar.
 */
export type FunnelRow<K extends string = string> = {
  key: K;
  value: number;
  base: K | null;
  rate: number | null;
  share: number;
};

export function funnelRows<K extends string>(
  steps: { key: K; value: number }[],
  bases: Partial<Record<K, K>> = {},
): FunnelRow<K>[] {
  const byKey = new Map(steps.map((s) => [s.key, s.value]));
  return steps.map((s, i) => {
    const base = bases[s.key] ?? (i > 0 ? steps[i - 1].key : null);
    if (base === null) return { key: s.key, value: s.value, base, rate: null, share: 100 };
    const from = byKey.get(base) ?? 0;
    const rate = from > 0 ? Math.round((s.value / from) * 1000) / 10 : null;
    return {
      key: s.key,
      value: s.value,
      base,
      rate,
      share: rate === null ? 0 : Math.min(rate, 100),
    };
  });
}

/** Paso con menor % respecto a su referencia, entre los que tienen datos. */
export function biggestDrop<K extends string>(rows: FunnelRow<K>[]): K | null {
  let worst: FunnelRow<K> | null = null;
  for (const r of rows) {
    if (r.rate === null) continue;
    if (!worst || r.rate < (worst.rate ?? Infinity)) worst = r;
  }
  return worst?.key ?? null;
}
