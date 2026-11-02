"use client";

import { useTranslations } from "next-intl";
import { cn } from "@/lib/utils";

/**
 * Renderiza un token de psicotécnico (ver `Presentation` en types.ts):
 * "w:<id>" palabra traducida, "g:..." figura SVG, "p:..." pieza, o literal.
 */
export function Token({ value, className }: { value: string; className?: string }) {
  const t = useTranslations("psycho");
  if (value.startsWith("w:")) {
    const id = value.slice(2);
    return <span className={className}>{t.has(`words.${id}`) ? t(`words.${id}`) : id}</span>;
  }
  if (value.startsWith("g:")) return <Glyph token={value} className={className} />;
  if (value.startsWith("p:")) return <Piece token={value} className={className} />;
  return <span className={className}>{value}</span>;
}

/** Texto plano de un token (para aria-label y explicaciones). */
export function useTokenText() {
  const t = useTranslations("psycho");
  return (value: string | number): string => {
    if (typeof value !== "string") return String(value);
    if (value.startsWith("w:")) {
      const id = value.slice(2);
      return t.has(`words.${id}`) ? t(`words.${id}`) : id;
    }
    if (value.startsWith("g:")) {
      const [, shape, count, fill, rot] = value.split(":");
      return t("glyph", {
        count: Number(count),
        shape: t(`shapes.${shape}`),
        fill: t(`fills.${fill}`),
        rot: Number(rot),
      });
    }
    if (value.startsWith("p:")) return t("piece");
    return value;
  };
}

const SHAPES: Record<string, string> = {
  circle: "M12 3a9 9 0 1 0 0.001 0Z",
  square: "M4 4h16v16H4Z",
  triangle: "M12 3 21 20H3Z",
  diamond: "M12 2 22 12 12 22 2 12Z",
  arrow: "M12 2 20 11h-5v11H9V11H4Z",
};

export function Glyph({ token, className }: { token: string; className?: string }) {
  const text = useTokenText()(token);
  const [, shape, countRaw, fill, rotRaw] = token.split(":");
  const count = Math.max(1, Math.min(4, Number(countRaw) || 1));
  const rot = Number(rotRaw) || 0;
  const d = SHAPES[shape] ?? SHAPES.circle;
  const id = `h-${token.replace(/[^a-z0-9]/gi, "")}`;
  return (
    <span
      role="img"
      aria-label={text}
      className={cn("inline-flex items-center justify-center gap-0.5", className)}
    >
      {Array.from({ length: count }, (_, i) => (
        <svg key={i} viewBox="0 0 24 24" className="size-6 sm:size-7" aria-hidden>
          {fill === "h" && (
            <defs>
              <pattern id={id} width="4" height="4" patternUnits="userSpaceOnUse">
                <path d="M0 4 4 0" stroke="currentColor" strokeWidth="1.2" />
              </pattern>
            </defs>
          )}
          <path
            d={d}
            transform={`rotate(${rot} 12 12)`}
            fill={fill === "f" ? "currentColor" : fill === "h" ? `url(#${id})` : "none"}
            stroke="currentColor"
            strokeWidth="1.6"
            strokeLinejoin="round"
          />
        </svg>
      ))}
    </span>
  );
}

export function Piece({ token, className }: { token: string; className?: string }) {
  const t = useTranslations("psycho");
  const [, nRaw, bits] = token.split(":");
  const n = Number(nRaw) || 4;
  return (
    <span
      role="img"
      aria-label={t("piece")}
      className={cn("inline-grid gap-px", className)}
      style={{ gridTemplateColumns: `repeat(${n}, 0.9rem)` }}
    >
      {Array.from({ length: n * n }, (_, i) => (
        <span
          key={i}
          className={cn(
            "size-[0.9rem] rounded-[2px]",
            bits?.[i] === "1" ? "bg-foreground" : "bg-surface-2",
          )}
        />
      ))}
    </span>
  );
}
