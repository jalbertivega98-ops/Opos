import { cn } from "@/lib/utils";

/** Marca provisional neutra: no evoca a ningún cuerpo concreto ni a instituciones. */
export function Logo({ className }: { className?: string }) {
  return (
    <span
      className={cn(
        "font-display inline-flex items-center gap-2 text-lg font-extrabold",
        className,
      )}
    >
      <svg viewBox="0 0 32 32" className="size-8" aria-hidden>
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
      <span>
        Aprob<span className="text-accent">ia</span>
      </span>
    </span>
  );
}
