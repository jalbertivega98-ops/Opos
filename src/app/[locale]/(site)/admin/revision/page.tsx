import type { Metadata } from "next";
import { getTranslations, setRequestLocale } from "next-intl/server";
import { Check } from "lucide-react";
import { Link } from "@/i18n/navigation";
import { Badge, Card, EmptyState } from "@/components/ui/card";
import { Alert } from "@/components/ui/form";
import { TransitionForm } from "@/components/admin/transition-form";
import { getSession } from "@/lib/auth/session";
import { reviewQueue } from "@/lib/admin/content/queries";

export const metadata: Metadata = { title: "Admin · Revisión", robots: { index: false } };

export default async function ReviewPage({ params }: PageProps<"/[locale]/admin/revision">) {
  const { locale } = await params;
  setRequestLocale(locale);
  const t = await getTranslations("adminContent");
  const [queue, { profile }] = await Promise.all([reviewQueue(), getSession()]);
  const isOwner = profile?.role === "owner";
  return (
    <div className="mx-auto max-w-4xl space-y-6 px-4 py-8">
      <div>
        <h1 className="text-3xl font-bold">{t("review.title")}</h1>
        <p className="text-muted-foreground mt-1 text-sm">{t("review.subtitle")}</p>
      </div>
      {!isOwner && <Alert>{t("workflow.ownerOnly")}</Alert>}
      {queue.length === 0 ? (
        <EmptyState title={t("review.empty")} />
      ) : (
        <ol className="space-y-4">
          {queue.map((q) => (
            <li key={q.id}>
              <Card className="space-y-4" data-testid="review-card">
                <div className="flex flex-wrap items-center gap-2 text-sm">
                  <Badge>{q.category}</Badge>
                  <Badge>
                    {t("difficulty")} {q.difficulty}
                  </Badge>
                  <Badge>{q.locale.toUpperCase()}</Badge>
                  <Badge>{t("version", { version: q.version })}</Badge>
                  {q.ai_generated && <Badge tone="warning">{t("ai")}</Badge>}
                  <Link
                    href={`/admin/preguntas/${q.id}`}
                    className="text-accent ml-auto hover:underline"
                  >
                    {t("review.open")}
                  </Link>
                </div>
                <p className="text-lg font-medium">{q.stem}</p>
                <ul className="space-y-1 text-sm">
                  {q.options.map((o) => (
                    <li
                      key={o.label}
                      className={`flex gap-2 rounded-md px-2 py-1 ${o.is_correct ? "bg-accent-soft font-semibold" : ""}`}
                    >
                      <span>{o.label}.</span> {o.body}
                      {o.is_correct && (
                        <Check
                          className="text-success ml-auto size-4"
                          aria-label={t("review.correct")}
                        />
                      )}
                    </li>
                  ))}
                </ul>
                {q.explanation ? (
                  <p className="text-muted-foreground text-sm">{q.explanation}</p>
                ) : (
                  <Alert tone="error">{t("review.noExplanation")}</Alert>
                )}
                <TransitionForm id={q.id} status={q.status} isOwner={isOwner} />
              </Card>
            </li>
          ))}
        </ol>
      )}
    </div>
  );
}
