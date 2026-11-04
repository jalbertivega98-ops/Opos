import { cn } from "@/lib/utils";

/** Marca OPOSAPRUEBA (la «A» de aprueba). Neutra: no evoca a ningún cuerpo concreto ni a instituciones. */
export function Logo({ className }: { className?: string }) {
  return (
    <span
      className={cn(
        "font-display inline-flex items-center gap-1.5 text-[15px] font-bold tracking-tight sm:gap-2 sm:text-lg",
        className,
      )}
    >
      <svg viewBox="0 0 32 32" className="size-7 shrink-0 sm:size-8" aria-hidden>
        <rect width="32" height="32" rx="9" className="fill-primary" />
        <path
          d="M9 22 L16 9 L23 22"
          fill="none"
          strokeWidth="3"
          strokeLinecap="round"
          strokeLinejoin="round"
          className="stroke-primary-foreground"
        />
        <path
          d="M12.5 17.5 H19.5"
          strokeWidth="3"
          strokeLinecap="round"
          className="stroke-accent"
        />
      </svg>
      <span className="leading-none">
        OPOS<span className="text-accent">APRUEBA</span>
      </span>
    </span>
  );
}
