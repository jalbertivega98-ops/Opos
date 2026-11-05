"use server";

import { getLocale } from "next-intl/server";
import { redirect } from "@/i18n/navigation";
import { getSession } from "@/lib/auth/session";
import { createServiceClient } from "@/lib/supabase/service";
import { answerQuestionSchema, startTopicSchema, type QuestionExplanation } from "./schema";

async function activeUserOrRedirect(next: string) {
  const locale = await getLocale();
  const { user, profile } = await getSession();
  if (!user || !profile) redirect({ href: `/entrar?next=${encodeURIComponent(next)}`, locale });
  if (profile!.status !== "active") redirect({ href: "/cuenta-suspendida", locale });
  return { user: user!, locale };
}

/**
 * Test de un tema del plan o del temario. El acceso (3 temas gratis, Premium de la
 * oposición o pack comprado), la selección al azar y la vista sin solución se
 * resuelven en SQL (practice_start_topic, ADR-036).
 */
export async function startTopicPracticeAction(formData: FormData) {
  const { user, locale } = await activeUserOrRedirect("/app/plan");
  const parsed = startTopicSchema.safeParse(Object.fromEntries(formData));
  if (!parsed.success) {
    redirect({ href: "/app/temario?error=invalid", locale });
    return;
  }
  const { topic, count, back } = parsed.data;
  const { data, error } = await createServiceClient().rpc("practice_start_topic", {
    p_user: user.id,
    p_topic_slug: topic,
    p_count: count,
  });
  if (error || !data) {
    const key = error?.code === "42501" ? "access" : "start";
    redirect({ href: `${back}?error=${key}`, locale });
    return;
  }
  redirect({ href: `/app/practica/${data}`, locale });
}

/** Repaso de las preguntas falladas y aún sin resolver. */
export async function startQuestionReviewAction() {
  const { user, locale } = await activeUserOrRedirect("/app/practica");
  const { data, error } = await createServiceClient().rpc("practice_start_question_review", {
    p_user: user.id,
    p_limit: 10,
  });
  if (error) {
    redirect({ href: "/app/practica?error=start", locale });
    return;
  }
  if (!data) {
    redirect({ href: "/app/practica?review=empty", locale });
    return;
  }
  redirect({ href: `/app/practica/${data}`, locale });
}

export type QuestionAnswerResult =
  | {
      ok: true;
      correct: boolean;
      answerIndex: number;
      explanation: QuestionExplanation;
      finished: boolean;
    }
  | { ok: false; error: "invalid" | "auth" | "changed" | "state" };

/** Corrige en la base de datos (la solución nunca llega antes al navegador). */
export async function answerQuestionAction(input: unknown): Promise<QuestionAnswerResult> {
  const parsed = answerQuestionSchema.safeParse(input);
  if (!parsed.success) return { ok: false, error: "invalid" };
  const { user, profile } = await getSession();
  if (!user || profile?.status !== "active") return { ok: false, error: "auth" };
  const { sessionId, position, choice } = parsed.data;
  const { data, error } = await createServiceClient()
    .rpc("practice_answer_question", {
      p_user: user.id,
      p_session: sessionId,
      p_position: position,
      p_chosen: choice,
    })
    .single<{
      finished: boolean;
      is_correct: boolean;
      answer_index: number;
      explanation: QuestionExplanation;
    }>();
  if (error || !data) {
    return { ok: false, error: error?.message.includes("cambiado") ? "changed" : "state" };
  }
  return {
    ok: true,
    correct: data.is_correct,
    answerIndex: data.answer_index,
    explanation: data.explanation,
    finished: data.finished,
  };
}
