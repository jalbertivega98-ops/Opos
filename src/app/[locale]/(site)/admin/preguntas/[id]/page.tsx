import type { Metadata } from "next";
import { notFound } from "next/navigation";
import { getFormatter, getTranslations, setRequestLocale } from "next-intl/server";
import { z } from "zod";
import { Badge, Card } from "@/components/ui/card";
import { Alert } from "@/components/ui/form";
import { Button } from "@/components/ui/button";
import { QuestionForm } from "@/components/admin/question-form";
import { TransitionForm } from "@/components/admin/transition-form";
import { getSession } from "@/lib/auth/session";
import { deleteDraftAction } from "@/lib/admin/content/actions";
import { examBodyOptions, getQuestion } from "@/lib/admin/content/queries";

export const metadata: Metadata = { title: "Admin · Pregunta", robots: { index: false } };

export default async function QuestionPage({
  params,
  searchParams,
}: PageProps<"/[locale]/admin/preguntas/[id]">) {
  const { locale, id } = await params;
  setRequestLocale(locale);
  if (!z.uuid().safeParse(id).success) notFound();
  const sp = await searchParams;
  const [q, exams, { profile }] = await Promise.all([
    getQuestion(id),
    examBodyOptions(),
    getSession(),
  ]);
  if (!q) notFound();
  const t = await getTranslations("adminContent");
  const format = await getFormatter();
  const editable = q.status === "draft" || q.status === "needs_review";

  return (
    <div className="mx-auto grid max-w-6xl gap-6 px-4 py-8 lg:grid-cols-[2fr_1fr]">
      <div className="space-y-4">
        <div className="flex flex-wrap items-center gap-2">
          <h1 className="text-3xl font-bold">{t("edit")}</h1>
          <Badge
            tone={q.status === "published" ? "success" : "neutral"}
            data-testid="question-status"
          >
            {t(`statuses.${q.status}`)}
          </Badge>
          <Badge>{t("version", { version: q.version })}</Badge>
        </div>
        {sp.saved === "1" && <Alert tone="success">{t("form.saved")}</Alert>}
        {!editable && (
          <Alert>{t("form.locked", { status: t(`statuses.${q.status}`).toLowerCase() })}</Alert>
        )}
        <Card>
          <QuestionForm
            key={`${q.version}-${q.status}`}
            disabled={!editable}
            exams={exams}
            initial={{
              id: q.id,
              stem: q.stem,
              explanation: q.explanation ?? "",
              category: q.category,
              difficulty: q.difficulty,
              locale: q.locale,
              is_free: q.is_free,
              ai_generated: q.ai_generated,
              options: q.options.map((o) => o.body),
              correct: Math.max(
                0,
                q.options.findIndex((o) => o.is_correct),
              ),
              exam_body_ids: q.exam_body_ids,
            }}
          />
        </Card>
        {q.status === "draft" && (
          <form action={deleteDraftAction}>
            <input type="hidden" name="id" value={q.id} />
            <Button type="submit" variant="ghost" size="sm" className="text-danger">
              {t("form.delete")}
            </Button>
          </form>
        )}
      </div>
      <aside className="space-y-4">
        <Card className="space-y-3">
          <h2 className="font-semibold">{t("workflow.title")}</h2>
          <TransitionForm id={q.id} status={q.status} isOwner={profile?.role === "owner"} />
        </Card>
        <Card>
          <h2 className="font-semibold">{t("workflow.history")}</h2>
          {q.reviews.length === 0 ? (
            <p className="text-muted-foreground mt-2 text-sm">{t("workflow.noHistory")}</p>
          ) : (
            <ol className="mt-2 space-y-2 text-sm" data-testid="review-history">
              {q.reviews.map((r, i) => (
                <li key={i}>
                  <span className="font-medium">
                    {t("workflow.transition", {
                      from: t(`statuses.${r.from_status}`),
                      to: t(`statuses.${r.to_status}`),
                    })}
                  </span>{" "}
                  <time className="text-muted-foreground" dateTime={r.created_at}>
                    {format.relativeTime(new Date(r.created_at))}
                  </time>
                  {r.comment && <p className="text-muted-foreground">«{r.comment}»</p>}
                </li>
              ))}
            </ol>
          )}
        </Card>
      </aside>
    </div>
  );
}
