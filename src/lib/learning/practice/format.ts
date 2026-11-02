export const pct = (correct: number, total: number) =>
  total > 0 ? Math.round((correct / total) * 100) : 0;

export const secondsOf = (ms: number) => Math.round(ms / 100) / 10;

export function duration(ms: number) {
  const s = Math.round(ms / 1000);
  const m = Math.floor(s / 60);
  return m > 0 ? `${m} min ${s % 60} s` : `${s} s`;
}
