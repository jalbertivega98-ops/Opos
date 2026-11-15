"use client";

import type { ReactNode } from "react";
import { useLocale } from "next-intl";
import { Link } from "@/i18n/navigation";
import { Button } from "@/components/ui/button";
import { MobileMenu, type MenuLink } from "@/components/mobile-menu";
import { LocaleSwitcher } from "@/components/locale-switcher";
import { signOutInBrowser, useAuth } from "@/components/auth/use-auth";
import { cn } from "@/lib/utils";

type Labels = {
  admin: string;
  dashboard: string;
  signOut: string;
  signIn: string;
  signUp: string;
  menu: string;
  closeMenu: string;
  language: string;
};

function useHome() {
  return useLocale() === "ca" ? "/ca" : "/";
}

/**
 * Botones de cuenta y menú móvil de la cabecera. La sesión se mira en el
 * navegador para que la cabecera no haga dinámicas las páginas públicas (ADR-060).
 * Mientras no se sabe, se reserva el hueco de «Entrar / Crear cuenta» sin mostrarlo.
 */
export function HeaderAccount({ labels, links }: { labels: Labels; links: MenuLink[] }) {
  const { status, isAdmin } = useAuth();
  const home = useHome();
  const signedIn = status === "user";

  return (
    <>
      {signedIn ? (
        <>
          {isAdmin && (
            <Button asChild variant="ghost" size="sm" className="hidden sm:inline-flex">
              <Link href="/admin">{labels.admin}</Link>
            </Button>
          )}
          <Button asChild size="sm">
            <Link href="/app">{labels.dashboard}</Link>
          </Button>
          <Button
            variant="ghost"
            size="sm"
            type="button"
            className="hidden sm:inline-flex"
            onClick={() => void signOutInBrowser(home)}
          >
            {labels.signOut}
          </Button>
        </>
      ) : (
        <div
          className={cn("flex items-center gap-1 sm:gap-2", status === "unknown" && "invisible")}
          aria-hidden={status === "unknown" || undefined}
        >
          <Button asChild variant="ghost" size="sm" className="hidden sm:inline-flex">
            <Link href="/entrar">{labels.signIn}</Link>
          </Button>
          <Button asChild variant="accent" size="sm">
            <Link href="/registro">{labels.signUp}</Link>
          </Button>
        </div>
      )}
      <MobileMenu
        label={labels.menu}
        closeLabel={labels.closeMenu}
        links={signedIn && isAdmin ? [...links, { href: "/admin", label: labels.admin }] : links}
        footer={
          <>
            {signedIn ? (
              <button
                type="button"
                onClick={() => void signOutInBrowser(home)}
                className="hover:bg-surface active:bg-surface block w-full rounded-md px-3 py-2 text-left transition-colors"
              >
                {labels.signOut}
              </button>
            ) : (
              <Link
                href="/entrar"
                className="hover:bg-surface active:bg-surface block rounded-md px-3 py-2 transition-colors"
              >
                {labels.signIn}
              </Link>
            )}
            <div className="px-3 py-2">
              <LocaleSwitcher label={labels.language} />
            </div>
          </>
        }
      />
    </>
  );
}

/** Muestra su contenido solo a quien no ha iniciado sesión (una vez se sabe). */
export function AnonOnly({ children }: { children: ReactNode }) {
  const { status } = useAuth();
  return status === "anon" ? <>{children}</> : null;
}
