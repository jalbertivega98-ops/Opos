"use client";

import {
  CalendarCheck,
  LayoutDashboard,
  Library,
  Shapes,
  TrendingUp,
  UserRound,
  type LucideIcon,
} from "lucide-react";
import { Link, usePathname } from "@/i18n/navigation";
import { cn } from "@/lib/utils";

const ICONS: Record<string, LucideIcon> = {
  "/app": LayoutDashboard,
  "/app/plan": CalendarCheck,
  "/app/practica": Shapes,
  "/app/progreso": TrendingUp,
  "/app/productos": Library,
  "/app/perfil": UserRound,
};

/** Navegación de la zona del alumno, con la sección actual marcada. */
export function AppNav({
  label,
  links,
}: {
  label: string;
  links: { href: string; label: string }[];
}) {
  const pathname = usePathname();
  const isActive = (href: string) =>
    href === "/app" ? pathname === "/app" : pathname === href || pathname.startsWith(`${href}/`);
  return (
    <nav
      aria-label={label}
      className="border-border bg-background/90 z-30 -mx-4 mb-6 border-b px-4 backdrop-blur sm:sticky sm:top-20 sm:mx-0 sm:mb-8 sm:rounded-2xl sm:border sm:px-2"
    >
      <ul className="flex [scrollbar-width:none] gap-1 overflow-x-auto py-2 text-sm">
        {links.map((l) => {
          const Icon = ICONS[l.href] ?? LayoutDashboard;
          const active = isActive(l.href);
          return (
            <li key={l.href}>
              <Link
                href={l.href}
                aria-current={active ? "page" : undefined}
                className={cn(
                  "inline-flex min-h-10 items-center gap-2 rounded-xl px-3 font-medium whitespace-nowrap transition-colors",
                  active
                    ? "bg-ink text-ink-foreground"
                    : "text-muted-foreground hover:bg-surface hover:text-foreground",
                )}
              >
                <Icon className="size-4" aria-hidden />
                {l.label}
              </Link>
            </li>
          );
        })}
      </ul>
    </nav>
  );
}
