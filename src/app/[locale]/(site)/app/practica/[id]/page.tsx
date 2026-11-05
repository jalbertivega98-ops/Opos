import type { Metadata } from "next";
import { notFound } from "next/navigation";
import { getTranslations, setRequestLocale } from "next-intl/server";
import { z } from "zod";
import { Link } from "@/i18n/navigation";
import { Button } from "@/components/ui/button";
import { Card } from "@/components/ui/card";
import { PsychoTrainer } from "@/components/psycho/trainer";
import { PracticeReview } from "@/components/psycho/review";
import { QuestionPlayer } from "@/components/questions/player";
import { QuestionReview, type AnsweredQuestion } from "@/components/questions/review";
import type { PresentedQuestion } from "@/lib/learning/questions/schema";
import { requireUser } from "@/lib/auth/session";
import { getPracticeSession } from "@/lib/learning/practice/queries";
import { duration, pct, secondsOf } from "@/lib/learning/practice/format";
import type { PublicPsychoItem, PsychoType, Difficulty } from "@/lib/learning/psycho/types";

export async function generateMetadata({
  params,
}: PageProps<"/[locale]/app/practica/[id]">): Promise<Metadata> {
  const { locale } = await params;
  const t = await getTranslations({ locale, namespace: "practice" });
  return { title: t("title"), robots: { index: false } };
}

export default async function PracticeSessionPage({
  params,
}: PageProps<"/[locale]/app/practica/[id]">) {
  const { locale, id } = await params;
  setRequestLocale(locale);
  await requireUser(locale, `/app/practica/${id}`);
  if (!z.uuid().safeParse(id).success) notFound();
  const data = await getPracticeSession(id);
  if (!data) notFound(); // RLS: una sesión ajena es indistinguible de una inexistente
  const { session, items } = data;
  const t = await getTranslations("practice");

  const isQuestions = session.item_type === "question";

  if (session.status === "active" && isQuestions) {
    return (
      <div className="mx-auto max-w-2xl space-y-4">
        <h1 className="text-2xl font-bold">{t(`modes.${session.mode}`)}</h1>
        <QuestionPlayer
          key={session.answered_count}
          items={items.map((it) => it.presented as unknown as PresentedQuestion)}
          sessionId={session.id}
          startAt={session.answered_count}
        />
      </div>
    );
  }

  if (session.status === "active") {
    const pub: PublicPsychoItem[] = items.map((it) => ({
      type: it.item_type as PsychoType,
      seed: Number(it.seed),
      difficulty: it.difficulty as Difficulty,
      version: 0,
      presentation: it.presented.presentation,
      options: it.presented.options,
    }));
    return (
      <div className="mx-auto max-w-2xl space-y-4">
        <h1 className="text-2xl font-bold">{t(`modes.${session.mode}`)}</h1>
        <PsychoTrainer
          key={session.answered_count}
          items={pub}
          mode={{ kind: "session", sessionId: session.id, startAt: session.answered_count }}
        />
      </div>
    );
  }

  const answered = items.filter((i) => i.is_correct !== null);
  return (
    <div className="mx-auto max-w-3xl space-y-6">
      <Card className="space-y-3 text-center" data-testid="practice-summary">
        <h1 className="text-2xl font-bold">{t("summaryTitle")}</h1>
        <p className="text-lg">
          {t("summary", {
            correct: session.correct_count,
            total: session.item_count,
            pct: pct(session.correct_count, session.item_count),
            time: duration(session.total_time_ms),
          })}
        </p>
        {session.answered_count > 0 && (
          <p className="text-muted-foreground text-sm">
            {t("avgTime", { seconds: secondsOf(session.total_time_ms / session.answered_count) })}
          </p>
        )}
        <div className="flex flex-wrap justify-center gap-3 pt-2">
          <Button asChild variant="accent">
            <Link href={isQuestions ? "/app/temario" : "/app/practica"}>{t("again")}</Link>
          </Button>
          <Button asChild variant="outline">
            <Link href="/app/progreso">{t("toProgress")}</Link>
          </Button>
        </div>
      </Card>
      <section aria-labelledby="items-title">
        <h2 id="items-title" className="text-lg font-semibold">
          {t("itemsTitle")}
        </h2>
        {isQuestions ? (
          <QuestionReview items={answered as unknown as AnsweredQuestion[]} />
        ) : (
          <PracticeReview items={answered} />
        )}
      </section>
    </div>
  );
}
