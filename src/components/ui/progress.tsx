import { cn } from "@/lib/utils";

/** Anillo de porcentaje (SVG, sin dependencias). `label` da el texto accesible. */
export function ProgressRing({
  value,
  size = 112,
  stroke = 10,
  label,
  children,
  className,
}: {
  value: number | null;
  size?: number;
  stroke?: number;
  label: string;
  children?: React.ReactNode;
  className?: string;
}) {
  const r = (size - stroke) / 2;
  const c = 2 * Math.PI * r;
  const v = value === null ? 0 : Math.max(0, Math.min(100, value));
  return (
    <div
      role="img"
      aria-label={label}
      className={cn("relative inline-grid shrink-0 place-items-center", className)}
      style={{ width: size, height: size }}
    >
      <svg width={size} height={size} viewBox={`0 0 ${size} ${size}`} className="-rotate-90">
        <circle
          cx={size / 2}
          cy={size / 2}
          r={r}
          fill="none"
          strokeWidth={stroke}
          className="stroke-surface-2"
        />
        {value !== null && (
          <circle
            cx={size / 2}
            cy={size / 2}
            r={r}
            fill="none"
            strokeWidth={stroke}
            strokeLinecap="round"
            strokeDasharray={c}
            strokeDashoffset={c - (v / 100) * c}
            className="stroke-accent"
          />
        )}
      </svg>
      <div aria-hidden className="absolute inset-0 grid place-items-center text-center">
        {children}
      </div>
    </div>
  );
}

/** Barra de progreso horizontal. */
export function Meter({
  value,
  max,
  label,
  className,
  tone = "accent",
}: {
  value: number;
  max: number;
  label: string;
  className?: string;
  tone?: "accent" | "highlight" | "onInk";
}) {
  const pctValue = max > 0 ? Math.round((value / max) * 100) : 0;
  return (
    <div
      role="progressbar"
      aria-label={label}
      aria-valuemin={0}
      aria-valuemax={max}
      aria-valuenow={value}
      className={cn(
        "h-2 w-full overflow-hidden rounded-full",
        tone === "onInk" ? "bg-white/15" : "bg-surface-2",
        className,
      )}
    >
      <div
        className={cn(
          "h-full rounded-full",
          tone === "highlight" ? "bg-highlight" : tone === "onInk" ? "bg-highlight" : "bg-accent",
        )}
        style={{ width: `${pctValue}%` }}
      />
    </div>
  );
}

/**
 * Barras por día (respondidos y acertados). Los datos van también en una tabla
 * oculta para lectores de pantalla.
 */
export function DayBars({
  days,
  caption,
  answeredLabel,
  correctLabel,
  className,
}: {
  days: { key: string; label: string; answered: number; correct: number }[];
  caption: string;
  answeredLabel: string;
  correctLabel: string;
  className?: string;
}) {
  const max = Math.max(1, ...days.map((d) => d.answered));
  return (
    <figure className={className}>
      <div aria-hidden className="flex h-20 items-end gap-1.5">
        {days.map((d) => (
          <div key={d.key} className="flex h-full flex-1 flex-col justify-end">
            <div
              className="bg-accent-soft relative w-full overflow-hidden rounded-md"
              style={{ height: `${Math.max(d.answered ? 8 : 4, (d.answered / max) * 100)}%` }}
            >
              <div
                className="bg-accent absolute inset-x-0 bottom-0"
                style={{ height: d.answered ? `${(d.correct / d.answered) * 100}%` : 0 }}
              />
            </div>
          </div>
        ))}
      </div>
      <div aria-hidden className="text-muted-foreground mt-1.5 flex gap-1.5 text-[11px]">
        {days.map((d) => (
          <span key={d.key} className="flex-1 text-center">
            {d.label}
          </span>
        ))}
      </div>
      <figcaption className="sr-only">{caption}</figcaption>
      <div className="sr-only">
        <table>
          <caption>{caption}</caption>
          <thead>
            <tr>
              <th scope="col" />
              <th scope="col">{answeredLabel}</th>
              <th scope="col">{correctLabel}</th>
            </tr>
          </thead>
          <tbody>
            {days.map((d) => (
              <tr key={d.key}>
                <th scope="row">{d.label}</th>
                <td>{d.answered}</td>
                <td>{d.correct}</td>
              </tr>
            ))}
          </tbody>
        </table>
      </div>
    </figure>
  );
}
