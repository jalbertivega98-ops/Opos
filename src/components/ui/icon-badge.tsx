import type { LucideIcon } from "lucide-react";
import { cva, type VariantProps } from "class-variance-authority";
import { cn } from "@/lib/utils";

/** Icono lineal sobre fondo suave. El color indica el tipo de acción, no decora. */
const iconBadge = cva("inline-flex shrink-0 items-center justify-center rounded-xl", {
  variants: {
    tone: {
      accent: "bg-accent-soft text-accent",
      highlight: "bg-highlight-soft text-warning",
      ink: "bg-ink text-ink-foreground",
      neutral: "bg-surface-2 text-muted-foreground",
      onInk: "bg-white/10 text-highlight",
    },
    size: {
      sm: "size-9 [&_svg]:size-4",
      md: "size-11 [&_svg]:size-5",
      lg: "size-14 [&_svg]:size-7",
    },
  },
  defaultVariants: { tone: "accent", size: "md" },
});

export function IconBadge({
  icon: Icon,
  tone,
  size,
  className,
}: { icon: LucideIcon; className?: string } & VariantProps<typeof iconBadge>) {
  return (
    <span className={cn(iconBadge({ tone, size }), className)}>
      <Icon aria-hidden />
    </span>
  );
}
