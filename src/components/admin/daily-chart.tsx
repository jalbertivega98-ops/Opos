import { cn } from "@/lib/utils";

export type DailyPoint = { day: string; value: number };

/**
 * Gráfica de barras por día, sin dependencias (ADR-037). Cada barra lleva su
 * valor en el título (al pasar el ratón) y la tabla oculta da los mismos datos
 * a los lectores de pantalla.
 */
export function DailyChart({
  title,
  points,
  total,
  formatDay,
  formatNumber,
  barClassName,
  testId,
}: {
  title: string;
  points: DailyPoint[];
  total: string;
  formatDay: (day: string) => string;
  formatNumber: (n: number) => string;
  barClassName: string;
  testId?: string;
}) {
  const max = Math.max(1, ...points.map((p) => p.value));
  const last = points.length - 1;
  return (
    <figure data-testid={testId}>
      <figcaption>
        <span className="block font-semibold">{title}</span>
        <span className="text-muted-foreground block text-sm tabular-nums">{total}</span>
      </figcaption>
      <div className="relative mt-3" aria-hidden>
        <span className="text-muted-foreground absolute -top-1 left-0 text-[10px] tabular-nums">
          {formatNumber(max)}
        </span>
        <div className="border-border flex h-32 items-end gap-px border-b pt-3 sm:gap-0.5">
          {points.map((p) => (
            <div
              key={p.day}
              title={`${formatDay(p.day)}: ${formatNumber(p.value)}`}
              className="group flex h-full min-w-0 flex-1 items-end"
            >
              <div
                className={cn("w-full rounded-t-sm group-hover:opacity-80", barClassName)}
                style={{ height: p.value === 0 ? "1px" : `${(p.value / max) * 100}%` }}
              />
            </div>
          ))}
        </div>
        <div className="text-muted-foreground mt-1 flex justify-between text-[10px]">
          <span>{points[0] ? formatDay(points[0].day) : ""}</span>
          <span>{points[last] ? formatDay(points[last].day) : ""}</span>
        </div>
      </div>
      <table className="sr-only">
        <caption>{title}</caption>
        <tbody>
          {points.map((p) => (
            <tr key={p.day}>
              <th scope="row">{formatDay(p.day)}</th>
              <td>{formatNumber(p.value)}</td>
            </tr>
          ))}
        </tbody>
      </table>
    </figure>
  );
}
