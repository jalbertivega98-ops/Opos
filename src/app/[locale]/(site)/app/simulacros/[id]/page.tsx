import type { Metadata } from "next";
import { notFound } from "next/navigation";
import { getTranslations, setRequestLocale } from "next-intl/server";
import { z } from "zod";
import { Link } from "@/i18n/navigation";
import { Button } from "@/components/ui/button";
import { Badge, Card } from "@/components/ui/card";
import { MockExamPlayer, type MockPlayerItem } from "@/components/mock/exam-player";
import { PracticeReview, type ReviewItem } from "@/components/psycho/review";
import { QuestionReview, type AnsweredQuestion } from "@/components/questions/review";
import { requireUser } from "@/lib/auth/session";
import { localized } from "@/lib/catalog/queries";
import { getMockAttempt } from "@/lib/learning/mock/queries";
import { duration } from "@/lib/learning/practice/format";
import { createServiceClient } from "@/lib/supabase/service";

export async function generateMetadata({
  params,
}: PageProps<"/[locale]/app/simulacros/[id]">): Promise<Metadata> {
  const { locale } = await params;
  const t = await getTranslations({ locale, namespace: "mock" });
  return { title: t("title"), robots: { index: false } };
}

export default async function MockAttemptPage({
  params,
}: PageProps<"/[locale]/app/simulacros/[id]">) {
  const { locale, id } = await params;
  setRequestLocale(locale);
  const { user } = await requireUser(locale, `/app/simulacros/${id}`);
  if (!z.uuid().safeParse(id).success) notFound();
  let data = await getMockAttempt(id);
  if (!data) notFound(); // RLS: un intento ajeno es indistinguible de uno inexistente

  // Tiempo agotado sin entregar (p. ej. se cerró la pestaña): se corrige lo guardado.
  if (data.timeUp) {
    await createServiceClient().rpc("mock_submit", { p_user: user.id, p_attempt: id });
    data = await getMockAttempt(id);
    if (!data) notFound();
  }
  const { attempt, items } = data;
  const t = await getTranslations("mock");
  const title = localized(locale, attempt.title, attempt.title_ca);

  if (attempt.status === "active") {
    return (
      <div className="mx-auto max-w-3xl space-y-4">
        <h1 className="text-2xl font-bold">{title}</h1>
        <MockExamPlayer
          attemptId={attempt.id}
          items={items.map((it): MockPlayerItem =>
            it.item_type
              ? ({ kind: "psycho", type: it.item_type, ...it.presented } as MockPlayerItem)
              : ({ kind: "question", ...it.presented } as MockPlayerItem),
          )}
          initialChoices={items.map((it) => it.chosen_index)}
          remainingMs={data.remainingMs}
          penalty={attempt.config.penalty}
        />
      </div>
    );
  }

  const cfg = attempt.config;
  const used =
    new Date(attempt.submitted_at ?? attempt.deadline).getTime() -
    new Date(attempt.started_at).getTime();
  return (
    <div className="mx-auto max-w-3xl space-y-6">
      <Card className="space-y-3 text-center" data-testid="mock-result">
        <h1 className="text-2xl font-bold">{title}</h1>
        <p className="text-5xl font-bold tabular-nums" data-testid="mock-mark">
          {t("mark", { mark: attempt.mark ?? 0, max: cfg.max_mark })}
        </p>
        <div className="flex justify-center">
          <Badge tone={attempt.passed ? "success" : "warning"}>
            {cfg.kind === "sections"
              ? t(attempt.passed ? "sectionsPassed" : "sectionsFailed")
              : attempt.passed
                ? t("passed", { min: cfg.pass_mark })
                : t("failed", { min: cfg.pass_mark })}
          </Badge>
        </div>
        {cfg.kind === "sections" && attempt.part_results && (
          <ul className="mx-auto grid max-w-md gap-2 text-left text-sm" data-testid="mock-parts">
            {attempt.part_results.map((p) => (
              <li
                key={p.part}
                className="border-border flex items-center justify-between gap-3 rounded-lg border px-3 py-2"
              >
                <span>
                  <span className="font-medium">{t("partTitle", { part: p.part })}</span>
                  <br />
                  <span className="text-muted-foreground">
                    {t("partDetail", {
                      direct: p.direct,
                      valid: p.valid,
                      cut: p.cut,
                      grade: p.grade,
                    })}
                  </span>
                </span>
                <Badge tone={p.passed ? "success" : "warning"}>
                  {p.passed ? t("partPassed") : t("partFailed")}
                </Badge>
              </li>
            ))}
          </ul>
        )}
        <p data-testid="mock-breakdown">
          {t("breakdown", {
            correct: attempt.correct_count ?? 0,
            wrong: attempt.wrong_count ?? 0,
            blank: attempt.blank_count ?? 0,
          })}
        </p>
        {(attempt.void_count ?? 0) > 0 && (
          <p className="text-muted-foreground text-sm">
            {t("voided", { count: attempt.void_count ?? 0 })}
          </p>
        )}
        <p className="text-muted-foreground text-sm">
          {t("formula", {
            score: attempt.score ?? 0,
            penalty: cfg.penalty,
            time: duration(Math.min(used, cfg.minutes * 60_000)),
          })}
        </p>
        {attempt.status === "expired" && (
          <p className="text-muted-foreground text-sm">{t("expired")}</p>
        )}
        {cfg.kind === "sections" && (
          <p className="text-muted-foreground text-xs">{t("sectionsDisclaimer")}</p>
        )}
        <p className="text-muted-foreground text-xs">{t("disclaimer")}</p>
        <div className="flex flex-wrap justify-center gap-3 pt-2">
          <Button asChild variant="accent">
            <Link href="/app/simulacros">{t("again")}</Link>
          </Button>
          <Button asChild variant="outline">
            <Link href="/app/progreso">{t("toProgress")}</Link>
          </Button>
        </div>
      </Card>
      <section aria-labelledby="mock-items-title">
        <h2 id="mock-items-title" className="text-lg font-semibold">
          {t("itemsTitle")}
        </h2>
        {attempt.config.kind === "psycho" ? (
          <PracticeReview items={items as unknown as ReviewItem[]} />
        ) : attempt.config.kind === "sections" ? (
          (attempt.config.parts ?? []).map((part, i, all) => {
            const start = all.slice(0, i).reduce((n, p) => n + p.questions, 0);
            const slice = items.filter(
              (it) => it.position >= start && it.position < start + part.questions,
            );
            return (
              <div key={i} className="mt-4">
                <h3 className="font-semibold">
                  {t(part.psycho ? "partPsycho" : "partSyllabus", { part: part.part })}
                </h3>
                {part.psycho ? (
                  <PracticeReview items={slice as unknown as ReviewItem[]} />
                ) : (
                  <QuestionReview items={slice as unknown as AnsweredQuestion[]} />
                )}
              </div>
            );
          })
        ) : (
          <QuestionReview items={items as unknown as AnsweredQuestion[]} />
        )}
      </section>
    </div>
  );
}
