import { getTranslations } from "next-intl/server";
import { BookOpen, ExternalLink } from "lucide-react";
import { Card } from "@/components/ui/card";
import type { LessonSection } from "@/lib/learning/notes-queries";

/**
 * Apuntes del tema (ADR-046): texto propio en el idioma del examen y, bajo cada
 * párrafo, la cita literal de la norma que lo respalda, plegada para no estorbar.
 */
export async function TopicLessons({
  sections,
  lang,
}: {
  sections: LessonSection[];
  lang: "es" | "ca";
}) {
  const t = await getTranslations("notes");
  return (
    <Card className="space-y-5" data-testid="topic-lessons">
      <div className="space-y-1">
        <h2 className="flex items-center gap-2 text-xl font-semibold">
          <BookOpen className="text-accent size-5" aria-hidden />
          {t("lessons")}
        </h2>
        <p className="text-muted-foreground text-sm">{t("lessonsHint")}</p>
      </div>
      <nav aria-label={t("lessonsIndex")} lang={lang}>
        <ol className="grid gap-1 text-sm sm:grid-cols-2">
          {sections.map((s) => (
            <li key={s.n}>
              <a href={`#apartat-${s.n}`} className="text-accent hover:underline">
                {s.n}. {s.title}
              </a>
            </li>
          ))}
        </ol>
      </nav>
      <div lang={lang} className="space-y-5">
        {sections.map((s) => (
          <section key={s.n} id={`apartat-${s.n}`} className="scroll-mt-20 space-y-3">
            <h3 className="text-lg font-semibold">
              <span className="tabular-nums">{s.n}.</span> {s.title}
            </h3>
            {s.blocks.map((b, i) => (
              <div key={i} className="space-y-1.5">
                <p className="leading-relaxed">{b.text}</p>
                {b.refs.length > 0 && (
                  <details className="text-muted-foreground text-sm">
                    <summary className="cursor-pointer select-none">
                      {b.refs.map((r) => r.ref).join(" · ")}
                    </summary>
                    <ul className="mt-2 space-y-2">
                      {b.refs.map((r) => (
                        <li
                          key={r.ref + r.quote.slice(0, 20)}
                          className="border-accent/40 border-l-2 pl-3"
                        >
                          <q className="italic">{r.quote}</q>{" "}
                          <span className="whitespace-nowrap">
                            — {r.ref}
                            {r.url && (
                              <>
                                {" "}
                                <a
                                  href={r.url}
                                  target="_blank"
                                  rel="noopener noreferrer"
                                  className="text-accent inline-flex items-center gap-1 underline"
                                >
                                  {r.law || t("sourceFallback")}
                                  <ExternalLink className="size-3" aria-hidden />
                                </a>
                              </>
                            )}
                          </span>
                        </li>
                      ))}
                    </ul>
                  </details>
                )}
              </div>
            ))}
          </section>
        ))}
      </div>
    </Card>
  );
}
