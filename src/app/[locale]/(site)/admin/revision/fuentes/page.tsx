import type { Metadata } from "next";
import { getTranslations, setRequestLocale } from "next-intl/server";
import { ExternalLink } from "lucide-react";
import { Link } from "@/i18n/navigation";
import { Button } from "@/components/ui/button";
import { Badge, Card, EmptyState } from "@/components/ui/card";
import { Alert } from "@/components/ui/form";
import { TransitionForm } from "@/components/admin/transition-form";
import { BatchReviewForm } from "@/components/admin/batch-review-form";
import { PublishAllForm } from "@/components/admin/publish-all-form";
import { getSession } from "@/lib/auth/session";
import {
  contentStatusCounts,
  draftContentProducts,
  listSourcedQuestions,
  topicStatusCounts,
  topicsWithQuestions,
} from "@/lib/admin/content/queries";
import { CONTENT_STATUSES } from "@/lib/admin/content/schema";
import { cn } from "@/lib/utils";

export const metadata: Metadata = {
  title: "Admin · Revisión con fuente",
  robots: { index: false },
};

const selectCls = "border-input bg-background h-10 rounded-lg border px-2 text-sm";

export default async function SourceReviewPage({
  params,
  searchParams,
}: PageProps<"/[locale]/admin/revision/fuentes">) {
  const { locale } = await params;
  setRequestLocale(locale);
  const sp = await searchParams;
  const topic = typeof sp.tema === "string" ? sp.tema : undefined;
  const status =
    typeof sp.estado === "string" && (CONTENT_STATUSES as readonly string[]).includes(sp.estado)
      ? sp.estado
      : undefined;
  const t = await getTranslations("adminContent");
  const [rows, topics, { profile }, counts, allCounts, draftProducts] = await Promise.all([
    listSourcedQuestions({ topic, status }),
    topicsWithQuestions(),
    getSession(),
    topic ? topicStatusCounts(topic) : Promise.resolve(null),
    topic ? Promise.resolve(null) : contentStatusCounts(),
    topic ? Promise.resolve(0) : draftContentProducts(),
  ]);
  const topicTitle = topics.find((tp) => tp.slug === topic)?.title ?? topic ?? "";
  const isOwner = profile?.role === "owner";

  return (
    <div className="mx-auto max-w-6xl space-y-6 px-4 py-8">
      <div>
        <h1 className="text-3xl font-bold">{t("sources.title")}</h1>
        <p className="text-muted-foreground mt-1 text-sm">{t("sources.subtitle")}</p>
      </div>
      {!isOwner && <Alert>{t("workflow.ownerOnly")}</Alert>}
      {isOwner && allCounts && allCounts.total > 0 && (
        <PublishAllForm counts={allCounts} draftProducts={draftProducts} />
      )}

      <form className="flex flex-wrap items-end gap-3" method="get">
        <label className="space-y-1 text-sm font-medium">
          <span className="block">{t("sources.topic")}</span>
          <select name="tema" defaultValue={topic ?? ""} className={selectCls}>
            <option value="">{t("sources.allTopics")}</option>
            {topics.map((tp) => (
              <option key={tp.slug} value={tp.slug}>
                {tp.title}
              </option>
            ))}
          </select>
        </label>
        <label className="space-y-1 text-sm font-medium">
          <span className="block">{t("status")}</span>
          <select name="estado" defaultValue={status ?? ""} className={selectCls}>
            <option value="">{t("all")}</option>
            {CONTENT_STATUSES.map((s) => (
              <option key={s} value={s}>
                {t(`statuses.${s}`)}
              </option>
            ))}
          </select>
        </label>
        <Button type="submit" variant="outline" size="sm">
          {t("filter")}
        </Button>
        <span className="text-muted-foreground text-sm" data-testid="sources-count">
          {t("sources.count", { count: rows.length })}
        </span>
      </form>

      {topic && counts && counts.total > 0 && (
        <BatchReviewForm topic={topic} title={topicTitle} counts={counts} isOwner={isOwner} />
      )}

      {rows.length === 0 ? (
        <EmptyState title={t("sources.empty")} />
      ) : (
        <ol className="space-y-5">
          {rows.map((q, n) => (
            <li key={q.id}>
              <Card className="grid gap-5 lg:grid-cols-2" data-testid="source-card">
                <div className="space-y-3">
                  <div className="flex flex-wrap items-center gap-2 text-sm">
                    <span className="font-semibold">#{n + 1}</span>
                    <Badge>{t(`statuses.${q.status}`)}</Badge>
                    <Badge>
                      {t("difficulty")} {q.difficulty}
                    </Badge>
                    {q.ai_generated && <Badge tone="warning">{t("sources.aiBadge")}</Badge>}
                  </div>
                  <p className="font-medium">{q.stem}</p>
                  <ul className="space-y-1 text-sm">
                    {q.options.map((o) => (
                      <li
                        key={o.label}
                        className={cn(
                          "flex gap-2 rounded-lg px-2 py-1",
                          o.is_correct && "bg-accent-soft font-semibold",
                        )}
                      >
                        <span>{o.label})</span>
                        <span className="flex-1">{o.body}</span>
                        {o.is_correct && (
                          <span className="text-success text-xs">{t("sources.correctMark")}</span>
                        )}
                      </li>
                    ))}
                  </ul>
                  <div className="text-sm">
                    <p className="font-semibold">{t("sources.explanation")}</p>
                    <p className="text-muted-foreground">{q.explanation}</p>
                  </div>
                </div>

                <div className="bg-surface space-y-3 rounded-xl p-4 text-sm">
                  <div className="flex flex-wrap items-center gap-2">
                    <span className="font-semibold">{t("sources.ref")}:</span>
                    <Badge tone="accent">{q.source_ref}</Badge>
                    {q.review_note?.startsWith("EXTRACTO PARCIAL") && (
                      <Badge tone="warning">{t("sources.partial")}</Badge>
                    )}
                  </div>
                  <div>
                    <p className="font-semibold">{t("sources.excerpt")}</p>
                    {q.source_excerpt ? (
                      <blockquote
                        className="border-accent mt-1 border-l-4 pl-3 italic"
                        data-testid="source-excerpt"
                      >
                        {q.source_excerpt}
                      </blockquote>
                    ) : (
                      <p className="text-muted-foreground">{t("sources.noExcerpt")}</p>
                    )}
                  </div>
                  {q.review_note && (
                    <div>
                      <p className="font-semibold">{t("sources.note")}</p>
                      <p>{q.review_note.replace(/^EXTRACTO PARCIAL\.\s*/, "")}</p>
                    </div>
                  )}
                  {q.source && (
                    <p>
                      <span className="font-semibold">{t("sources.source")}:</span>{" "}
                      <a
                        href={q.source.url}
                        target="_blank"
                        rel="noopener noreferrer"
                        className="text-accent inline-flex items-center gap-1 underline"
                      >
                        {q.source.title}
                        <ExternalLink className="size-3" aria-hidden />
                      </a>
                    </p>
                  )}
                  <div className="flex flex-wrap items-center gap-2 pt-1">
                    <TransitionForm id={q.id} status={q.status} isOwner={isOwner} />
                    <Button asChild size="sm" variant="ghost">
                      <Link href={`/admin/preguntas/${q.id}`}>{t("sources.open")}</Link>
                    </Button>
                  </div>
                </div>
              </Card>
            </li>
          ))}
        </ol>
      )}
    </div>
  );
}
