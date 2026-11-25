import { cn } from "@/lib/utils";

export type DailyPoint = { day: string; value: number };

/**
 * Gráfica de barras por día, sin dependencias (ADR-037, ADR-072). Marca la media
 * diaria con una línea discontinua, pone fechas al principio, en medio y al
 * final, y resalta el día con más. Cada barra lleva su valor en el título (al
 * pasar el ratón) y la tabla oculta da los mismos datos a los lectores de pantalla.
 */
export function DailyChart({
  title,
  points,
  total,
  average,
  averageLabel,
  formatDay,
  formatNumber,
  barClassName,
  testId,
}: {
  title: string;
  points: DailyPoint[];
  total: string;
  /** Media diaria (se dibuja como línea si es mayor que 0). */
  average?: number;
  /** Texto de la media, ya formateado («media 12 al día»). */
  averageLabel?: string;
  formatDay: (day: string) => string;
  formatNumber: (n: number) => string;
  barClassName: string;
  testId?: string;
}) {
  const max = Math.max(1, ...points.map((p) => p.value));
  const last = points.length - 1;
  const mid = Math.floor(last / 2);
  const best = points.reduce<DailyPoint | null>(
    (a, p) => (p.value > 0 && (!a || p.value >= a.value) ? p : a),
    null,
  );
  return (
    <figure data-testid={testId}>
      <figcaption>
        <span className="block font-semibold">{title}</span>
        <span className="text-muted-foreground block text-sm tabular-nums">
          {total}
          {averageLabel ? ` · ${averageLabel}` : ""}
        </span>
      </figcaption>
      <div className="relative mt-3" aria-hidden>
        <span className="text-muted-foreground absolute -top-1 left-0 text-[10px] tabular-nums">
          {formatNumber(max)}
        </span>
        <div className="border-border relative flex h-40 items-end gap-px border-b pt-3 sm:gap-0.5">
          {average !== undefined && average > 0 && (
            <div
              className="border-foreground/50 pointer-events-none absolute inset-x-0 z-10 border-t border-dashed"
              style={{ bottom: `calc(${average / max} * (100% - 12px))` }}
            />
          )}
          {points.map((p) => (
            <div
              key={p.day}
              title={`${formatDay(p.day)}: ${formatNumber(p.value)}`}
              className="group flex h-full min-w-0 flex-1 items-end"
            >
              <div
                className={cn(
                  "w-full rounded-t-sm group-hover:opacity-100",
                  best?.day === p.day ? "opacity-100" : "opacity-80",
                  barClassName,
                )}
                style={{ height: p.value === 0 ? "1px" : `${(p.value / max) * 100}%` }}
              />
            </div>
          ))}
        </div>
        <div className="text-muted-foreground mt-1 grid grid-cols-3 text-[10px]">
          <span>{points[0] ? formatDay(points[0].day) : ""}</span>
          <span className="text-center">
            {points[mid] && mid > 0 ? formatDay(points[mid].day) : ""}
          </span>
          <span className="text-right">{points[last] ? formatDay(points[last].day) : ""}</span>
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
