import type { Metadata } from "next";
import { getTranslations, setRequestLocale } from "next-intl/server";
import { Badge, Card, EmptyState } from "@/components/ui/card";
import { Alert } from "@/components/ui/form";
import { NotesReviewForm } from "@/components/admin/notes-review-form";
import { TopicNoteView } from "@/components/notes/topic-note-view";
import { getSession } from "@/lib/auth/session";
import { listTopicNotes } from "@/lib/learning/notes-queries";

export const metadata: Metadata = {
  title: "Admin · Fichas de estudio",
  robots: { index: false },
};

/** Revisión de las fichas de estudio (CNT-011): texto literal de la guía + aprobación. */
export default async function NotesReviewPage({
  params,
}: PageProps<"/[locale]/admin/revision/fichas">) {
  const { locale } = await params;
  setRequestLocale(locale);
  const t = await getTranslations("adminContent");
  const [notes, { profile }] = await Promise.all([listTopicNotes(), getSession()]);
  const isOwner = profile?.role === "owner";
  const pending = notes.filter((n) => ["draft", "needs_review", "approved"].includes(n.status));
  const published = notes.filter((n) => n.status === "published").length;

  return (
    <div className="mx-auto max-w-6xl space-y-6 px-4 py-8">
      <div>
        <h1 className="text-3xl font-bold">{t("notes.title")}</h1>
        <p className="text-muted-foreground mt-1 text-sm">{t("notes.subtitle")}</p>
      </div>
      {!isOwner && <Alert>{t("workflow.ownerOnly")}</Alert>}
      <p className="text-sm" data-testid="notes-counts">
        {t("notes.counts", { total: notes.length, pending: pending.length, published })}
      </p>
      {isOwner && (
        <div className="border-accent bg-accent-soft/40 rounded-xl border-2 p-4">
          <NotesReviewForm pending={pending.length} />
        </div>
      )}

      {notes.length === 0 ? (
        <EmptyState title={t("notes.empty")} />
      ) : (
        <ul className="space-y-3">
          {notes.map((n) => (
            <li key={n.id}>
              <Card className="p-0" data-testid="note-card">
                <details>
                  <summary className="flex cursor-pointer flex-wrap items-center gap-2 px-5 py-4">
                    <span className="font-semibold">{n.title}</span>
                    <Badge tone={n.status === "published" ? "success" : "neutral"}>
                      {t(`statuses.${n.status}`)}
                    </Badge>
                    {n.amendments.length > 0 && (
                      <Badge tone="warning">{t("notes.hasAmendments")}</Badge>
                    )}
                    <span className="text-muted-foreground text-xs">
                      {t("notes.summary", {
                        ideas: n.keyIdeas.length,
                        terms: n.glossary.length,
                        sections: n.outline.length,
                      })}
                    </span>
                  </summary>
                  <div className="border-border space-y-4 border-t px-5 py-4">
                    {n.reviewNote && <Alert>{n.reviewNote}</Alert>}
                    {isOwner && <NotesReviewForm topic={n.slug} status={n.status} />}
                    <TopicNoteView note={n} />
                  </div>
                </details>
              </Card>
            </li>
          ))}
        </ul>
      )}
    </div>
  );
}
