import { describe, expect, it } from "vitest";
import { createRateLimiter } from "@/lib/rate-limit";

describe("createRateLimiter", () => {
  it("bloquea al superar el límite y libera al pasar la ventana", () => {
    let t = 0;
    const check = createRateLimiter({ limit: 2, windowMs: 1000, now: () => t });
    expect(check("a").ok).toBe(true);
    expect(check("a").ok).toBe(true);
    const blocked = check("a");
    expect(blocked.ok).toBe(false);
    expect(blocked.retryAfterSeconds).toBe(1);
    expect(check("b").ok).toBe(true); // claves independientes
    t = 1001;
    expect(check("a").ok).toBe(true);
  });
});
