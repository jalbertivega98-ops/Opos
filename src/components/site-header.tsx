import { Menu } from "lucide-react";
import { getTranslations } from "next-intl/server";
import { Link } from "@/i18n/navigation";
import { Logo } from "@/components/logo";
import { LocaleSwitcher } from "@/components/locale-switcher";
import { ThemeToggle } from "@/components/theme-provider";
import { Button } from "@/components/ui/button";
import { getSession, isAdminRole } from "@/lib/auth/session";
import { signOutAction } from "@/lib/auth/actions";

export async function SiteHeader() {
  const t = await getTranslations("nav");
  const { user, profile } = await getSession();

  return (
    <header className="border-border bg-background/85 sticky top-0 z-40 border-b backdrop-blur">
      <div className="mx-auto flex h-16 max-w-6xl items-center gap-2 px-4 sm:gap-4">
        <Link href="/" aria-label="Aprobia" className="shrink-0">
          <Logo />
        </Link>
        <nav
          aria-label="Principal"
          className="hidden items-center gap-1 text-sm font-medium md:flex"
        >
          <Link href="/oposiciones" className="hover:bg-surface rounded-md px-3 py-2">
            {t("catalog")}
          </Link>
          <Link href="/psicotecnicos" className="hover:bg-surface rounded-md px-3 py-2">
            {t("psycho")}
          </Link>
          <Link href="/#como-funciona" className="hover:bg-surface rounded-md px-3 py-2">
            {t("how")}
          </Link>
          <Link href="/#precios" className="hover:bg-surface rounded-md px-3 py-2">
            {t("pricing")}
          </Link>
        </nav>
        <div className="ml-auto flex items-center gap-1 sm:gap-2">
          <div className="hidden sm:block">
            <LocaleSwitcher label={t("language")} />
          </div>
          <ThemeToggle label={t("theme")} />
          {user ? (
            <>
              {profile && isAdminRole(profile.role) && (
                <Button asChild variant="ghost" size="sm" className="hidden sm:inline-flex">
                  <Link href="/admin">{t("admin")}</Link>
                </Button>
              )}
              <Button asChild size="sm">
                <Link href="/app">{t("dashboard")}</Link>
              </Button>
              <form action={signOutAction} className="hidden sm:block">
                <Button variant="ghost" size="sm" type="submit">
                  {t("signOut")}
                </Button>
              </form>
            </>
          ) : (
            <>
              <Button asChild variant="ghost" size="sm" className="hidden sm:inline-flex">
                <Link href="/entrar">{t("signIn")}</Link>
              </Button>
              <Button asChild variant="accent" size="sm">
                <Link href="/registro">{t("signUp")}</Link>
              </Button>
            </>
          )}
          <details className="relative md:hidden">
            <summary
              aria-label={t("menu")}
              className="hover:bg-surface inline-flex size-10 cursor-pointer list-none items-center justify-center rounded-lg [&::-webkit-details-marker]:hidden"
            >
              <Menu className="size-5" aria-hidden />
            </summary>
            <nav
              aria-label={t("menu")}
              className="border-border bg-background absolute top-12 right-0 w-60 space-y-1 rounded-xl border p-2 text-sm shadow-lg"
            >
              <Link href="/oposiciones" className="hover:bg-surface block rounded-md px-3 py-2">
                {t("catalog")}
              </Link>
              <Link href="/psicotecnicos" className="hover:bg-surface block rounded-md px-3 py-2">
                {t("psycho")}
              </Link>
              <Link href="/#como-funciona" className="hover:bg-surface block rounded-md px-3 py-2">
                {t("how")}
              </Link>
              <Link href="/#precios" className="hover:bg-surface block rounded-md px-3 py-2">
                {t("pricing")}
              </Link>
              {user ? (
                <form action={signOutAction}>
                  <button
                    type="submit"
                    className="hover:bg-surface block w-full rounded-md px-3 py-2 text-left"
                  >
                    {t("signOut")}
                  </button>
                </form>
              ) : (
                <Link href="/entrar" className="hover:bg-surface block rounded-md px-3 py-2">
                  {t("signIn")}
                </Link>
              )}
              <div className="px-3 py-2">
                <LocaleSwitcher label={t("language")} />
              </div>
            </nav>
          </details>
        </div>
      </div>
    </header>
  );
}
