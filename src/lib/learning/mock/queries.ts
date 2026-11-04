import "server-only";
import { createClient } from "@/lib/supabase/server";
import type { MockAttempt, MockConfig, MockItem } from "./schema";

const ATTEMPT_COLS =
  "id, product_id, title, title_ca, config, item_count, status, started_at, deadline, submitted_at, correct_count, wrong_count, blank_count, void_count, score, mark, passed, part_results";

/** Intento + preguntas del alumno actual (RLS: solo los suyos). */
export async function getMockAttempt(id: string) {
  const supabase = await createClient();
  const [{ data: attempt }, { data: items }] = await Promise.all([
    supabase.from("mock_attempts").select(ATTEMPT_COLS).eq("id", id).maybeSingle<MockAttempt>(),
    supabase
      .from("mock_attempt_items")
      .select(
        "position, part, item_type, difficulty, presented, chosen_index, is_correct, answer_index, explanation",
      )
      .eq("attempt_id", id)
      .order("position")
      .returns<MockItem[]>(),
  ]);
  if (!attempt) return null;
  const remainingMs = new Date(attempt.deadline).getTime() - Date.now();
  return {
    attempt: { ...attempt, score: num(attempt.score), mark: num(attempt.mark) },
    items: items ?? [],
    remainingMs,
    // margen de 15 s igual que en la base de datos
    timeUp: attempt.status === "active" && remainingMs < -15_000,
  };
}

/** Últimos intentos del alumno, para la biblioteca. */
export async function myMockAttempts(limit = 10) {
  const supabase = await createClient();
  const { data } = await supabase
    .from("mock_attempts")
    .select(ATTEMPT_COLS)
    .order("started_at", { ascending: false })
    .limit(limit)
    .returns<MockAttempt[]>();
  const now = Date.now();
  return (data ?? []).map((a) => ({
    ...a,
    score: num(a.score),
    mark: num(a.mark),
    inProgress: a.status === "active" && new Date(a.deadline).getTime() > now,
  }));
}

// numeric llega como texto desde PostgREST
function num(v: unknown) {
  return v === null || v === undefined ? null : Number(v);
}

/** Formato de los simulacros publicados indicados (para mostrarlo antes de empezar). */
export async function mockFormats(productIds: string[]) {
  if (productIds.length === 0) return new Map<string, Partial<MockConfig>>();
  const supabase = await createClient();
  const { data } = await supabase
    .from("products")
    .select("id, config")
    .in("id", productIds)
    .returns<{ id: string; config: Partial<MockConfig> }[]>();
  return new Map((data ?? []).map((p) => [p.id, p.config]));
}
