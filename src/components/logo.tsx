import { cn } from "@/lib/utils";

/**
 * Marca OPOSAPRUEBA: monograma de casilla marcada (el «apto» de quien entrena
 * con método). Neutra: no evoca a ningún cuerpo concreto ni a instituciones.
 */
export function Logo({ className, compact = false }: { className?: string; compact?: boolean }) {
  return (
    <span
      className={cn(
        "font-display inline-flex items-center gap-1.5 text-[15px] font-extrabold tracking-tight sm:gap-2 sm:text-lg",
        className,
      )}
    >
      <svg viewBox="0 0 32 32" className="size-7 shrink-0 sm:size-8" aria-hidden>
        <rect width="32" height="32" rx="9" className="fill-primary" />
        <rect
          x="7.5"
          y="7.5"
          width="17"
          height="17"
          rx="4.5"
          fill="none"
          strokeWidth="2.5"
          className="stroke-primary-foreground"
        />
        <path
          d="M11.5 16.5 L14.8 19.6 L21 12.6"
          fill="none"
          strokeWidth="3"
          strokeLinecap="round"
          strokeLinejoin="round"
          className="stroke-highlight"
        />
      </svg>
      {!compact && (
        <span className="leading-none">
          OPOS<span className="text-accent">APRUEBA</span>
        </span>
      )}
    </span>
  );
}
