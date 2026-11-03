import { getTranslations } from "next-intl/server";
import { TriangleAlert, ExternalLink, Lightbulb, ListTree, BookA } from "lucide-react";
import { Card } from "@/components/ui/card";
import type { TopicNote } from "@/lib/learning/notes-queries";

/**
 * Ficha de estudio: índice, «Idees força», esmenes y glosario, tal como aparecen en
 * la fuente oficial. El texto se muestra en su idioma original (la guía es en catalán).
 */
export async function TopicNoteView({ note }: { note: TopicNote }) {
  const t = await getTranslations("notes");
  const pages =
    note.pageFrom && note.pageTo ? t("pages", { from: note.pageFrom, to: note.pageTo }) : null;
  return (
    <div className="space-y-5" lang={note.locale} data-testid="topic-note">
      {note.amendments.length > 0 && (
        <Card className="border-warning/50 bg-warning-soft space-y-2" data-testid="note-amendments">
          <h2 className="flex items-center gap-2 font-semibold">
            <TriangleAlert className="text-warning size-5" aria-hidden />
            {t("amendments")}
          </h2>
          <ul className="space-y-2 text-sm">
            {note.amendments.map((a) => (
              <li key={a.text}>
                {a.text}{" "}
                {a.url && (
                  <a
                    href={a.url}
                    target="_blank"
                    rel="noopener noreferrer"
                    className="text-accent inline-flex items-center gap-1 underline"
                  >
                    {t("amendmentsSource")}
                    <ExternalLink className="size-3" aria-hidden />
                  </a>
                )}
              </li>
            ))}
          </ul>
        </Card>
      )}

      <div className="grid gap-5 lg:grid-cols-[minmax(0,1fr)_minmax(0,2fr)]">
        <Card className="space-y-3 self-start">
          <h2 className="flex items-center gap-2 font-semibold">
            <ListTree className="text-accent size-5" aria-hidden />
            {t("outline")}
          </h2>
          <ol className="space-y-1.5 text-sm" data-testid="note-outline">
            {note.outline.map((o) => (
              <li
                key={`${o.n}-${o.title}`}
                className={o.n.includes(".") ? "text-muted-foreground pl-6" : "font-medium"}
              >
                <span className="tabular-nums">{o.n}.</span> {o.title}
              </li>
            ))}
          </ol>
        </Card>

        <Card className="space-y-3">
          <h2 className="flex items-center gap-2 font-semibold">
            <Lightbulb className="text-accent size-5" aria-hidden />
            {t("keyIdeas")}
            {note.keyIdeasPage && (
              <span className="text-muted-foreground text-xs font-normal">
                {t("page", { page: note.keyIdeasPage })}
              </span>
            )}
          </h2>
          <ol className="space-y-3" data-testid="note-key-ideas">
            {note.keyIdeas.map((idea, i) => (
              <li key={i} className="flex gap-3 text-sm leading-relaxed">
                <span
                  className="bg-accent-soft text-accent flex size-6 shrink-0 items-center justify-center rounded-full text-xs font-bold tabular-nums"
                  aria-hidden
                >
                  {i + 1}
                </span>
                <span>{idea}</span>
              </li>
            ))}
          </ol>
        </Card>
      </div>

      {note.glossary.length > 0 && (
        <Card className="space-y-3">
          <h2 className="flex items-center gap-2 font-semibold">
            <BookA className="text-accent size-5" aria-hidden />
            {t("glossary")}
          </h2>
          <p className="text-muted-foreground text-xs">{t("glossaryHint")}</p>
          <ul className="flex flex-wrap gap-2 text-sm" data-testid="note-glossary">
            {note.glossary.map((g) => (
              <li key={g} className="border-border bg-surface rounded-full border px-3 py-1">
                {g}
              </li>
            ))}
          </ul>
        </Card>
      )}

      <p className="text-muted-foreground text-xs">
        {t("sourceLine")}{" "}
        {note.sourceUrl ? (
          <a
            href={note.sourceUrl}
            target="_blank"
            rel="noopener noreferrer"
            className="text-accent inline-flex items-center gap-1 underline"
          >
            {note.sourceTitle ?? t("sourceFallback")}
            <ExternalLink className="size-3" aria-hidden />
          </a>
        ) : (
          (note.sourceTitle ?? t("sourceFallback"))
        )}
        {pages ? ` · ${pages}` : ""}
      </p>
    </div>
  );
}
