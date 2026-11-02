/**
 * Limitador de peticiones en memoria (ventana deslizante simple).
 *
 * Primera línea de defensa para Server Actions sensibles. GoTrue ya aplica
 * sus propios límites a los endpoints de Auth. En producción con varias
 * instancias hay que sustituir el almacén por uno compartido (ver TASKS.md SEC-004).
 */
export interface RateLimitResult {
  ok: boolean;
  remaining: number;
  retryAfterSeconds: number;
}

export function createRateLimiter(opts: { limit: number; windowMs: number; now?: () => number }) {
  const hits = new Map<string, number[]>();
  const now = opts.now ?? Date.now;

  return function check(key: string): RateLimitResult {
    const t = now();
    const windowStart = t - opts.windowMs;
    const recent = (hits.get(key) ?? []).filter((ts) => ts > windowStart);
    if (recent.length >= opts.limit) {
      hits.set(key, recent);
      const retryAfterSeconds = Math.ceil((recent[0] + opts.windowMs - t) / 1000);
      return { ok: false, remaining: 0, retryAfterSeconds };
    }
    recent.push(t);
    hits.set(key, recent);
    if (hits.size > 10_000) {
      for (const [k, v] of hits) if (v.every((ts) => ts <= windowStart)) hits.delete(k);
    }
    return { ok: true, remaining: opts.limit - recent.length, retryAfterSeconds: 0 };
  };
}

/**
 * 10 intentos / 10 min por IP+acción para formularios de autenticación.
 * AUTH_RATE_LIMIT_MAX permite subirlo SOLO en local/E2E (nunca en producción).
 */
const authMax = Number(process.env.AUTH_RATE_LIMIT_MAX) || 10;
export const authLimiter = createRateLimiter({ limit: authMax, windowMs: 10 * 60 * 1000 });
