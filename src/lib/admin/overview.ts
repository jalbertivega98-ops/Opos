/**
 * Cálculos del resumen del panel (ADR-072), sin dependencias de servidor para
 * poder probarlos: comparar una cifra con la del periodo anterior.
 */
export const OVERVIEW_PERIODS = [7, 30, 90] as const;
export type OverviewPeriod = (typeof OVERVIEW_PERIODS)[number];

/** Lee `?periodo=` (7, 30 o 90 días). Cualquier otra cosa vuelve a 30. */
export function parsePeriod(raw: string | string[] | undefined): OverviewPeriod {
  const v = Array.isArray(raw) ? raw[0] : raw;
  return OVERVIEW_PERIODS.find((d) => String(d) === v) ?? 30;
}

export type Trend = {
  /** Diferencia: % de cambio (o puntos, si se comparan porcentajes). null = no hay base. */
  delta: number | null;
  direction: "up" | "down" | "flat";
};

/**
 * Cambio de `current` frente a `previous`. Si `previous` es 0 no hay % posible:
 * delta null y la flecha indica solo si ha aparecido algo.
 */
export function trend(current: number, previous: number): Trend {
  if (current === previous) return { delta: 0, direction: "flat" };
  const direction = current > previous ? "up" : "down";
  if (previous === 0) return { delta: null, direction };
  return { delta: Math.round(((current - previous) / previous) * 1000) / 10, direction };
}

/** % de `part` sobre `total` con un decimal (0 si no hay total). */
export function rate(part: number, total: number): number {
  return total > 0 ? Math.round((part / total) * 1000) / 10 : 0;
}

/** Diferencia en puntos entre dos porcentajes (p. ej. conversión 2,1 % → 2,5 % = +0,4). */
export function pointsTrend(current: number, previous: number): Trend {
  const d = Math.round((current - previous) * 10) / 10;
  return { delta: d, direction: d > 0 ? "up" : d < 0 ? "down" : "flat" };
}

/** Media diaria con un decimal. */
export function dailyAverage(values: number[]): number {
  if (values.length === 0) return 0;
  return Math.round((values.reduce((a, b) => a + b, 0) / values.length) * 10) / 10;
}
