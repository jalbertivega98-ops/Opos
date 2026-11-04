import { getTranslations } from "next-intl/server";
import { Link } from "@/i18n/navigation";
import { Logo } from "@/components/logo";

export async function SiteFooter() {
  const t = await getTranslations("footer");
  return (
    <footer className="border-border bg-surface mt-auto border-t">
      <div className="mx-auto grid max-w-6xl gap-8 px-4 py-10 sm:grid-cols-[2fr_1fr]">
        <div className="space-y-3">
          <Logo />
          <p className="text-muted-foreground max-w-md text-sm">{t("tagline")}</p>
        </div>
        <nav aria-label={t("legal")} className="space-y-2 text-sm">
          <p className="font-semibold">{t("legal")}</p>
          <ul className="text-muted-foreground space-y-1">
            <li>
              <Link href="/legal/privacidad" className="hover:underline">
                {t("privacy")}
              </Link>
            </li>
            <li>
              <Link href="/legal/cookies" className="hover:underline">
                {t("cookies")}
              </Link>
            </li>
            <li>
              <Link href="/legal/condiciones" className="hover:underline">
                {t("terms")}
              </Link>
            </li>
          </ul>
        </nav>
      </div>
      <p className="border-border text-muted-foreground border-t px-4 py-4 text-center text-xs">
        © {new Date().getFullYear()} OPOSAPRUEBA · {t("draftNotice")}
      </p>
    </footer>
  );
}
