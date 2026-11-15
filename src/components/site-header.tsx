import { getTranslations } from "next-intl/server";
import { Link } from "@/i18n/navigation";
import { Logo } from "@/components/logo";
import { LocaleSwitcher } from "@/components/locale-switcher";
import { ThemeToggle } from "@/components/theme-provider";
import { DesktopNavLinks } from "@/components/mobile-menu";
import { HeaderAccount } from "@/components/header-account";

/**
 * Cabecera común. No lee la sesión en el servidor (la mira `HeaderAccount` en el
 * navegador): así portada, catálogo, fichas y legales se sirven en caché (ADR-059).
 */
export async function SiteHeader() {
  const t = await getTranslations("nav");
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
          <HeaderAccount
            links={links}
            labels={{
              admin: t("admin"),
              dashboard: t("dashboard"),
              signOut: t("signOut"),
              signIn: t("signIn"),
              signUp: t("signUp"),
              menu: t("menu"),
              closeMenu: t("closeMenu"),
              language: t("language"),
            }}
          />
        </div>
      </div>
    </header>
  );
}
