import { getFormatter, getTranslations } from "next-intl/server";
import { ArrowRight, ExternalLink } from "lucide-react";
import { Link } from "@/i18n/navigation";
import { Card } from "@/components/ui/card";
import { FaqList } from "@/components/seo/faq-list";
import { JsonLd, faqLd } from "@/lib/seo/json-ld";
import { tr, type ExamGuide } from "@/lib/seo/exam-guides";
import { psychoGuideByType } from "@/lib/seo/psycho-guides";

/**
 * Guía pública del examen oficial (ADR-025): datos verificados con sus fuentes,
 * renderizados en el servidor para buscadores y asistentes de IA.
 */
export async function ExamGuideSection({
  guide,
  locale,
  topics,
}: {
  guide: ExamGuide;
  locale: string;
  topics: { slug: string; title: string; title_ca: string | null }[];
}) {
  const t = await getTranslations("seo.guide");
  const tp = await getTranslations("psycho.types");
  const format = await getFormatter();
  const faq = guide.faq.map(({ q, a }) => ({ q: tr(q, locale), a: tr(a, locale) }));
  const verified = format.dateTime(new Date(`${guide.verifiedOn}T12:00:00Z`), {
    day: "numeric",
    month: "long",
    year: "numeric",
  });

  return (
    <div className="mt-10 grid gap-8">
      <JsonLd data={faqLd(faq)} />
      <p className="text-muted-foreground max-w-3xl">{tr(guide.intro, locale)}</p>

      <section aria-labelledby="guide-facts">
        <h2 id="guide-facts" className="text-2xl font-bold">
          {t("facts")}
        </h2>
        <dl className="border-border mt-4 divide-y rounded-2xl border">
          {guide.facts.map((f) => (
            <div key={f.label.es} className="grid gap-1 px-5 py-3 sm:grid-cols-[14rem_1fr]">
              <dt className="text-muted-foreground text-sm font-medium">{tr(f.label, locale)}</dt>
              <dd>{tr(f.value, locale)}</dd>
            </div>
          ))}
        </dl>
      </section>

      <section aria-labelledby="guide-parts">
        <h2 id="guide-parts" className="text-2xl font-bold">
          {t("parts")}
        </h2>
        <div className="mt-4 grid gap-4 md:grid-cols-3">
          {guide.parts.map((p) => (
            <Card key={p.name.es} className="rounded-2xl">
              <h3 className="font-semibold">{tr(p.name, locale)}</h3>
              <p className="text-muted-foreground mt-2 text-sm">{tr(p.detail, locale)}</p>
            </Card>
          ))}
        </div>
      </section>

      <section aria-labelledby="guide-calendar">
        <h2 id="guide-calendar" className="text-2xl font-bold">
          {t("calendar")}
        </h2>
        <dl className="border-border mt-4 divide-y rounded-2xl border">
          {guide.calendar.map((f) => (
            <div key={f.label.es} className="grid gap-1 px-5 py-3 sm:grid-cols-[14rem_1fr]">
              <dt className="text-muted-foreground text-sm font-medium">{tr(f.label, locale)}</dt>
              <dd>{tr(f.value, locale)}</dd>
            </div>
          ))}
        </dl>
        <p className="text-muted-foreground mt-2 text-sm">{tr(guide.calendarNote, locale)}</p>
      </section>

      {topics.length > 0 && (
        <section aria-labelledby="guide-syllabus">
          <h2 id="guide-syllabus" className="text-2xl font-bold">
            {t("syllabus")}
          </h2>
          <p className="text-muted-foreground mt-1 text-sm">{t("syllabusNote")}</p>
          <ol className="mt-4 grid gap-x-8 gap-y-1.5 text-sm md:grid-cols-2">
            {topics.map((tp2) => (
              <li key={tp2.slug}>{(locale === "ca" && tp2.title_ca) || tp2.title}</li>
            ))}
          </ol>
        </section>
      )}

      {guide.psychoTypes.length > 0 && (
        <section aria-labelledby="guide-psycho">
          <h2 id="guide-psycho" className="text-2xl font-bold">
            {t("psycho")}
          </h2>
          <p className="text-muted-foreground mt-1 max-w-3xl text-sm">
            {tr(guide.psychoNote, locale)}
          </p>
          <ul className="mt-4 flex flex-wrap gap-2">
            {guide.psychoTypes.map((type) => {
              const g = psychoGuideByType(type);
              if (!g) return null;
              return (
                <li key={type}>
                  <Link
                    href={`/psicotecnicos/${g.slug}`}
                    className="border-border hover:border-accent hover:text-accent inline-flex items-center gap-1 rounded-full border px-3 py-1.5 text-sm"
                  >
                    {tp(`${type}.name`)} <ArrowRight className="size-3.5" aria-hidden />
                  </Link>
                </li>
              );
            })}
          </ul>
        </section>
      )}

      <section aria-labelledby="guide-faq">
        <h2 id="guide-faq" className="text-2xl font-bold">
          {t("faq")}
        </h2>
        <div className="mt-4">
          <FaqList items={faq} />
        </div>
      </section>

      <section aria-labelledby="guide-sources">
        <h2 id="guide-sources" className="text-2xl font-bold">
          {t("sources")}
        </h2>
        <ul className="mt-3 space-y-1 text-sm">
          {guide.sources.map((s) => (
            <li key={s.url}>
              <a
                href={s.url}
                target="_blank"
                rel="noopener noreferrer"
                className="text-accent inline-flex items-center gap-1 hover:underline"
              >
                {s.title} <ExternalLink className="size-3" aria-hidden />
              </a>
            </li>
          ))}
        </ul>
        <p className="text-muted-foreground mt-4 text-xs">{t("verified", { date: verified })}</p>
      </section>
    </div>
  );
}
