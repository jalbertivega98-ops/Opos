import { Plus } from "lucide-react";

/** Preguntas frecuentes desplegables (texto en el HTML aunque estén cerradas). */
export function FaqList({ items }: { items: { q: string; a: string }[] }) {
  return (
    <div className="divide-border border-border divide-y rounded-2xl border">
      {items.map(({ q, a }) => (
        <details key={q} className="group px-5">
          <summary className="flex min-h-14 cursor-pointer list-none items-center justify-between gap-4 py-4 font-semibold [&::-webkit-details-marker]:hidden">
            <h3 className="text-base">{q}</h3>
            <Plus
              className="text-accent size-5 shrink-0 transition-transform group-open:rotate-45"
              aria-hidden
            />
          </summary>
          <p className="text-muted-foreground pb-5 text-sm">{a}</p>
        </details>
      ))}
    </div>
  );
}
