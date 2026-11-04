/**
 * Formato numérico de las opciones (castellano y catalán usan la coma decimal).
 * Las opciones se guardan ya formateadas: la corrección compara cadenas.
 */
export function dec(n: number, decimals = 2): string {
  const r = round(n, decimals);
  const s = Math.abs(r).toFixed(decimals).replace(".", ",");
  return (r < 0 ? "-" : "") + s;
}

/** Redondeo «comercial» (mitad hacia fuera), sin errores de coma flotante en .5. */
export function round(n: number, decimals = 2): number {
  const f = 10 ** decimals;
  const v = Math.round(Math.abs(n) * f + 1e-9) / f;
  return n < 0 ? -v : v;
}

export const euros = (n: number) => `${dec(n, 2)} €`;
export const percent = (n: number) => `${dec(n, 2)} %`;

/** Lee un número escrito con coma decimal ("40,64", "1425"). */
export const parseDec = (s: string) => Number(s.replace(/\s|€|%/g, "").replace(",", "."));
