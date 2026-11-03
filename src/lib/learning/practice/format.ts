export const pct = (correct: number, total: number) =>
  total > 0 ? Math.round((correct / total) * 100) : 0;

export const secondsOf = (ms: number) => Math.round(ms / 100) / 10;

export function duration(ms: number) {
  const s = Math.round(ms / 1000);
  const m = Math.floor(s / 60);
  return m > 0 ? `${m} min ${s % 60} s` : `${s} s`;
}

/** Los últimos `n` días (incluido hoy), del más antiguo al más reciente, con su clave AAAA-MM-DD. */
export function lastDays(n: number, now: number = Date.now()) {
  return Array.from({ length: n }, (_, i) => {
    const date = new Date(now - (n - 1 - i) * 86_400_000);
    return { date, key: date.toISOString().slice(0, 10) };
  });
}
