import { getLocale, getTranslations } from "next-intl/server";
import { Link } from "@/i18n/navigation";
import { Logo } from "@/components/logo";
import { examGuides, examShortName } from "@/lib/seo/exam-guides";
import { psychoGuides } from "@/lib/seo/psycho-guides";

/**
 * Pie común. Enlaza todas las fichas de oposición y todos los tipos de
 * psicotécnico (ADR-050): así cada página pública recibe enlaces internos
 * desde toda la web y los buscadores las descubren y valoran antes.
 */
export async function SiteFooter() {
  const t = await getTranslations("footer");
  const tp = await getTranslations("psycho");
  const locale = await getLocale();
  const exams = examGuides()
    .map((g) => ({ slug: g.slug, name: examShortName(g, locale) }))
    .sort((a, b) => a.name.localeCompare(b.name, locale));
  const psycho = psychoGuides();
  const linkClass = "hover:text-foreground hover:underline";
  return (
    <footer className="border-border bg-surface mt-auto border-t">
      <div className="wrap grid gap-8 py-10 sm:grid-cols-2 lg:grid-cols-[1.5fr_1.2fr_1.2fr_0.8fr]">
        <div className="space-y-3">
          <Logo />
          <p className="text-muted-foreground max-w-md text-sm">{t("tagline")}</p>
        </div>
        <nav aria-label={t("exams")} className="space-y-2 text-sm">
          <p className="font-semibold">{t("exams")}</p>
          <ul className="text-muted-foreground space-y-1">
            {exams.map((e) => (
              <li key={e.slug}>
                <Link href={`/oposiciones/${e.slug}`} className={linkClass}>
                  {e.name}
                </Link>
              </li>
            ))}
            <li>
              <Link href="/oposiciones" className={`${linkClass} font-medium`}>
                {t("allExams")}
              </Link>
            </li>
          </ul>
        </nav>
        <nav aria-label={t("psycho")} className="space-y-2 text-sm">
          <p className="font-semibold">{t("psycho")}</p>
          <ul className="text-muted-foreground space-y-1">
            {psycho.map((g) => (
              <li key={g.slug}>
                <Link href={`/psicotecnicos/${g.slug}`} className={linkClass}>
                  {tp(`types.${g.type}.name`)}
                </Link>
              </li>
            ))}
            <li>
              <Link href="/psicotecnicos" className={`${linkClass} font-medium`}>
                {t("allPsycho")}
              </Link>
            </li>
          </ul>
        </nav>
        <nav aria-label={t("legal")} className="space-y-2 text-sm">
          <p className="font-semibold">{t("legal")}</p>
          <ul className="text-muted-foreground space-y-1">
            <li>
              <Link href="/legal/aviso-legal" className={linkClass}>
                {t("notice")}
              </Link>
            </li>
            <li>
              <Link href="/legal/privacidad" className={linkClass}>
                {t("privacy")}
              </Link>
            </li>
            <li>
              <Link href="/legal/cookies" className={linkClass}>
                {t("cookies")}
              </Link>
            </li>
            <li>
              <Link href="/legal/condiciones" className={linkClass}>
                {t("terms")}
              </Link>
            </li>
          </ul>
        </nav>
      </div>
      <p className="border-border text-muted-foreground border-t px-4 py-4 text-center text-xs">
        © {new Date().getFullYear()} OPOSAPRUEBA · {t("note")}
      </p>
    </footer>
  );
}
