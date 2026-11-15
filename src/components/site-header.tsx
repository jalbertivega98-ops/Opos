import { getTranslations } from "next-intl/server";
import { Link } from "@/i18n/navigation";
import { Logo } from "@/components/logo";
import { LocaleSwitcher } from "@/components/locale-switcher";
import { ThemeToggle } from "@/components/theme-provider";
import { Button } from "@/components/ui/button";
import { DesktopNavLinks, MobileMenu } from "@/components/mobile-menu";
import { getSession, isAdminRole } from "@/lib/auth/session";
import { signOutAction } from "@/lib/auth/actions";

export async function SiteHeader() {
  const t = await getTranslations("nav");
  const { user, profile } = await getSession();
  const links = [
    { href: "/oposiciones", label: t("catalog") },
    { href: "/psicotecnicos", label: t("psycho") },
    { href: "/#como-funciona", label: t("how") },
    { href: "/#precios", label: t("pricing") },
  ];

  return (
    <header className="border-border bg-background/85 sticky top-0 z-40 border-b backdrop-blur">
      <div className="wrap flex h-16 items-center gap-2 sm:gap-4">
        <Link href="/" aria-label="OPOSAPRUEBA" className="shrink-0">
          <Logo />
        </Link>
        <nav
          aria-label="Principal"
          className="hidden items-center gap-1 text-sm font-medium md:flex"
        >
          <DesktopNavLinks links={links} />
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
          <MobileMenu
            label={t("menu")}
            closeLabel={t("closeMenu")}
            links={
              user && profile && isAdminRole(profile.role)
                ? [...links, { href: "/admin", label: t("admin") }]
                : links
            }
            footer={
              <>
                {user ? (
                  <form action={signOutAction}>
                    <button
                      type="submit"
                      className="hover:bg-surface active:bg-surface block w-full rounded-md px-3 py-2 text-left transition-colors"
                    >
                      {t("signOut")}
                    </button>
                  </form>
                ) : (
                  <Link
                    href="/entrar"
                    className="hover:bg-surface active:bg-surface block rounded-md px-3 py-2 transition-colors"
                  >
                    {t("signIn")}
                  </Link>
                )}
                <div className="px-3 py-2">
                  <LocaleSwitcher label={t("language")} />
                </div>
              </>
            }
          />
        </div>
      </div>
    </header>
  );
}
