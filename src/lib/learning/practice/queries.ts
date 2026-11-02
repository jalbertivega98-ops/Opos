import "server-only";
import { createClient } from "@/lib/supabase/server";
import type { Explanation, PublicPsychoItem } from "@/lib/learning/psycho/types";

export type PracticeSession = {
  id: string;
  mode: "psycho" | "questions" | "mock" | "review";
  item_type: string;
  status: "active" | "finished" | "abandoned";
  item_count: number;
  answered_count: number;
  correct_count: number;
  total_time_ms: number;
  started_at: string;
  finished_at: string | null;
};

export type PracticeItemRow = {
  position: number;
  item_type: string;
  difficulty: number;
  seed: number;
  presented: Pick<PublicPsychoItem, "presentation" | "options">;
  chosen_index: number | null;
  is_correct: boolean | null;
  answer_index: number | null;
  explanation: Explanation | null;
  time_ms: number | null;
  reviewed_at: string | null;
};

export type PracticeStats = {
  totals: { answered: number; correct: number; avg_time_ms: number; pending_review: number };
  sessions_finished: number;
  streak: number;
  by_type: { item_type: string; answered: number; correct: number; avg_time_ms: number }[];
  by_difficulty: { difficulty: number; answered: number; correct: number }[];
  daily: { day: string; answered: number; correct: number }[];
};

const SESSION_COLS =
  "id, mode, item_type, status, item_count, answered_count, correct_count, total_time_ms, started_at, finished_at";

/** Sesión + ítems del alumno actual. RLS garantiza que solo ve las suyas. */
export async function getPracticeSession(id: string) {
  const supabase = await createClient();
  const [{ data: session }, { data: items }] = await Promise.all([
    supabase
      .from("practice_sessions")
      .select(SESSION_COLS)
      .eq("id", id)
      .maybeSingle<PracticeSession>(),
    supabase
      .from("practice_items")
      .select(
        "position, item_type, difficulty, seed, presented, chosen_index, is_correct, answer_index, explanation, time_ms, reviewed_at",
      )
      .eq("session_id", id)
      .order("position")
      .returns<PracticeItemRow[]>(),
  ]);
  if (!session) return null;
  return { session, items: items ?? [] };
}

export async function listRecentSessions(limit = 10) {
  const supabase = await createClient();
  const { data } = await supabase
    .from("practice_sessions")
    .select(SESSION_COLS)
    .neq("status", "abandoned")
    .order("started_at", { ascending: false })
    .limit(limit)
    .returns<PracticeSession[]>();
  return data ?? [];
}

export async function getPracticeStats(days = 30): Promise<PracticeStats | null> {
  const supabase = await createClient();
  const { data, error } = await supabase.rpc("my_practice_stats", { p_days: days });
  if (error) {
    console.error("my_practice_stats", error.message);
    return null;
  }
  return data as PracticeStats;
}

/** Fallos pendientes de repaso (más recientes primero). */
export async function listPendingFailures(limit = 20) {
  const supabase = await createClient();
  const { data } = await supabase
    .from("practice_items")
    .select(
      "session_id, position, item_type, difficulty, presented, chosen_index, is_correct, answer_index, explanation, answered_at",
    )
    .eq("is_correct", false)
    .is("reviewed_at", null)
    .order("answered_at", { ascending: false })
    .limit(limit);
  return (data ?? []) as (Omit<PracticeItemRow, "seed" | "time_ms" | "reviewed_at"> & {
    session_id: string;
    answered_at: string;
  })[];
}
