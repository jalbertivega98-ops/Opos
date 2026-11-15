"use client";

import { Menu, X } from "lucide-react";
import { useEffect, useId, useRef, useState, type ReactNode } from "react";
import { Link, usePathname } from "@/i18n/navigation";
import { cn } from "@/lib/utils";

export type MenuLink = { href: string; label: string };

/** ¿Es este enlace la página actual? Los anclas (`/#precios`) nunca lo son. */
export function isCurrentPath(pathname: string, href: string) {
  if (href.includes("#")) return false;
  if (href === "/") return pathname === "/";
  return pathname === href || pathname.startsWith(`${href}/`);
}

/**
 * Menú desplegable del móvil (cabecera). Se cierra al elegir cualquier opción,
 * al pulsar fuera, con Escape y al cambiar de página; marca la página actual.
 * El panel se oculta (no se desmonta) para que el formulario de «Salir» llegue
 * a enviarse aunque el menú se cierre en el mismo clic.
 */
export function MobileMenu({
  label,
  closeLabel,
  links,
  footer,
}: {
  label: string;
  closeLabel: string;
  links: MenuLink[];
  footer?: ReactNode;
}) {
  const [open, setOpen] = useState(false);
  const pathname = usePathname();
  const rootRef = useRef<HTMLDivElement>(null);
  const buttonRef = useRef<HTMLButtonElement>(null);
  const panelId = useId();

  // Al cambiar de página (incluido el botón «atrás»), se cierra.
  const [lastPath, setLastPath] = useState(pathname);
  if (lastPath !== pathname) {
    setLastPath(pathname);
    setOpen(false);
  }

  useEffect(() => {
    if (!open) return;
    const onPointerDown = (e: PointerEvent) => {
      if (!rootRef.current?.contains(e.target as Node)) setOpen(false);
    };
    const onKeyDown = (e: KeyboardEvent) => {
      if (e.key === "Escape") {
        setOpen(false);
        buttonRef.current?.focus();
      }
    };
    document.addEventListener("pointerdown", onPointerDown);
    document.addEventListener("keydown", onKeyDown);
    return () => {
      document.removeEventListener("pointerdown", onPointerDown);
      document.removeEventListener("keydown", onKeyDown);
    };
  }, [open]);

  return (
    <div ref={rootRef} className="relative md:hidden">
      <button
        ref={buttonRef}
        type="button"
        aria-label={open ? closeLabel : label}
        aria-expanded={open}
        aria-controls={panelId}
        onClick={() => setOpen((v) => !v)}
        className={cn(
          "hover:bg-surface active:bg-surface inline-flex size-10 items-center justify-center rounded-lg transition-colors",
          open && "bg-surface",
        )}
      >
        {open ? <X className="size-5" aria-hidden /> : <Menu className="size-5" aria-hidden />}
      </button>
      <nav
        id={panelId}
        aria-label={label}
        hidden={!open}
        // Cualquier opción (enlace o botón, también el idioma) cierra el menú.
        onClick={(e) => {
          if ((e.target as HTMLElement).closest("a, button")) setOpen(false);
        }}
        className="border-border bg-background absolute top-12 right-0 w-60 space-y-1 rounded-xl border p-2 text-sm shadow-lg"
      >
        {links.map((l) => {
          const current = isCurrentPath(pathname, l.href);
          return (
            <Link
              key={l.href}
              href={l.href}
              aria-current={current ? "page" : undefined}
              className={cn(
                "block rounded-md px-3 py-2 transition-colors",
                current
                  ? "bg-ink text-ink-foreground font-semibold"
                  : "hover:bg-surface active:bg-surface",
              )}
            >
              {l.label}
            </Link>
          );
        })}
        {footer}
      </nav>
    </div>
  );
}

/** Enlaces de la cabecera de escritorio, con la página actual marcada. */
export function DesktopNavLinks({ links }: { links: MenuLink[] }) {
  const pathname = usePathname();
  return links.map((l) => {
    const current = isCurrentPath(pathname, l.href);
    return (
      <Link
        key={l.href}
        href={l.href}
        aria-current={current ? "page" : undefined}
        className={cn(
          "rounded-md px-3 py-2 transition-colors",
          current ? "bg-surface text-foreground font-semibold" : "hover:bg-surface",
        )}
      >
        {l.label}
      </Link>
    );
  });
}
