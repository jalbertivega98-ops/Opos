import * as React from "react";
import { cva, type VariantProps } from "class-variance-authority";
import { cn } from "@/lib/utils";

/**
 * Bloque de página con fondo según su importancia:
 * - plain: fondo base (contenido principal)
 * - surface: gris claro (contenido de apoyo, listados)
 * - grid: papel cuadriculado (zonas de entrenamiento)
 * - ink: franja marina (mensajes clave, llamadas a la acción)
 */
const sectionVariants = cva("relative", {
  variants: {
    tone: {
      plain: "bg-background",
      surface: "bg-surface border-y border-border",
      grid: "bg-surface bg-grid border-b border-border",
      ink: "bg-ink text-ink-foreground",
    },
    space: {
      md: "py-14 sm:py-20",
      lg: "py-16 sm:py-24",
    },
  },
  defaultVariants: { tone: "plain", space: "md" },
});

export function Section({
  className,
  tone,
  space,
  children,
  ...props
}: React.HTMLAttributes<HTMLElement> & VariantProps<typeof sectionVariants>) {
  return (
    <section className={cn(sectionVariants({ tone, space }), className)} {...props}>
      <div className="wrap">{children}</div>
    </section>
  );
}

/** Antetítulo + título + explicación. Jerarquía fija para que se lean de un vistazo. */
export function SectionHeader({
  eyebrow,
  title,
  description,
  action,
  id,
  align = "start",
  onInk = false,
}: {
  eyebrow?: React.ReactNode;
  title: React.ReactNode;
  description?: React.ReactNode;
  action?: React.ReactNode;
  id?: string;
  align?: "start" | "center";
  onInk?: boolean;
}) {
  return (
    <div
      className={cn(
        "flex flex-wrap items-end justify-between gap-4",
        align === "center" && "flex-col items-center text-center",
      )}
    >
      <div className={cn("max-w-2xl", align === "center" && "mx-auto")}>
        {eyebrow && <Eyebrow onInk={onInk}>{eyebrow}</Eyebrow>}
        <h2 id={id} className="mt-2 text-3xl font-extrabold sm:text-4xl">
          {title}
        </h2>
        {description && (
          <p
            className={cn(
              "mt-3 text-base sm:text-lg",
              onInk ? "text-ink-muted" : "text-muted-foreground",
            )}
          >
            {description}
          </p>
        )}
      </div>
      {action}
    </div>
  );
}

export function Eyebrow({
  children,
  onInk = false,
  className,
}: {
  children: React.ReactNode;
  onInk?: boolean;
  className?: string;
}) {
  return (
    <p
      className={cn(
        "text-xs font-bold tracking-[0.14em] uppercase",
        onInk ? "text-highlight" : "text-accent",
        className,
      )}
    >
      {children}
    </p>
  );
}
