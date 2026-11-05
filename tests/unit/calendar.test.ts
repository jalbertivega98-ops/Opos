import { describe, expect, it } from "vitest";
import {
  dayKey,
  groupByDay,
  studyWeek,
  taskProgress,
  type StudyEntry,
} from "@/lib/learning/calendar";

const entry = (over: Partial<StudyEntry> = {}): StudyEntry => ({
  kind: "practice",
  id: "x",
  startedAt: "2026-11-05T10:00:00Z",
  finishedAt: null,
  status: "completed",
  mode: "questions",
  itemType: "question",
  answered: 10,
  correct: 7,
  total: 10,
  topicSlug: "t1",
  topicTitle: "Tema 1",
  topicTitleCa: null,
  title: null,
  titleCa: null,
  mark: null,
  maxMark: null,
  passed: null,
  mockKind: null,
  ...over,
});

describe("semana del calendario", () => {
  it("va de lunes a domingo en hora peninsular", () => {
    // jueves 5/11/2026, 18:00 en Madrid (UTC+1)
    const w = studyWeek(new Date("2026-11-05T17:00:00Z"));
    expect(w.days.map((d) => d.key)).toEqual([
      "2026-11-02",
      "2026-11-03",
      "2026-11-04",
      "2026-11-05",
      "2026-11-06",
      "2026-11-07",
      "2026-11-08",
    ]);
    expect(w.days[3].today).toBe(true);
    expect(w.start.toISOString()).toBe("2026-11-01T23:00:00.000Z");
    expect(w.end.toISOString()).toBe("2026-11-08T23:00:00.000Z");
  });
  it("el domingo a las 23:30 de Madrid sigue en la misma semana", () => {
    const w = studyWeek(new Date("2026-11-08T22:30:00Z"));
    expect(w.days[0].key).toBe("2026-11-02");
    expect(w.days[6].today).toBe(true);
  });
  it("con desplazamiento muestra semanas anteriores (y respeta el horario de verano)", () => {
    const w = studyWeek(new Date("2026-11-05T17:00:00Z"), -2);
    expect(w.days[0].key).toBe("2026-10-19");
    expect(w.start.toISOString()).toBe("2026-10-18T22:00:00.000Z");
    expect(w.days.some((d) => d.today)).toBe(false);
  });
  it("reparte por día con la hora de Madrid", () => {
    const w = studyWeek(new Date("2026-11-05T17:00:00Z"));
    // 23:30 UTC del miércoles = 00:30 del jueves en Madrid
    const days = groupByDay(w.days, [entry({ startedAt: "2026-11-04T23:30:00Z" })]);
    expect(days[2].entries).toHaveLength(0);
    expect(days[3].entries).toHaveLength(1);
    expect(dayKey(new Date("2026-11-04T23:30:00Z"))).toBe("2026-11-05");
  });
});

describe("progreso de las tareas del plan", () => {
  const topic = {
    kind: "topic",
    topic: { slug: "t1", title: "Tema 1" },
    questions: 20,
    status: "new",
  } as const;
  it("suma las preguntas respondidas de ese tema", () => {
    expect(taskProgress(topic, [])).toEqual({ done: 0, target: 20, state: "pending" });
    expect(taskProgress(topic, [entry(), entry({ topicSlug: "t2" })])).toEqual({
      done: 10,
      target: 20,
      state: "partial",
    });
    expect(taskProgress(topic, [entry({ answered: 15 }), entry({ answered: 15 })]).state).toBe(
      "done",
    );
  });
  it("cuenta sesiones de psicotécnicos y simulacros por tipo", () => {
    const psycho = entry({ mode: "psycho", topicSlug: null });
    expect(taskProgress({ kind: "psycho", sessions: 2 }, [psycho])).toMatchObject({
      done: 1,
      state: "partial",
    });
    const mock = entry({ kind: "mock", mode: "mock", mockKind: "knowledge" });
    expect(taskProgress({ kind: "mock", mock: "knowledge", count: 1 }, [mock]).state).toBe("done");
    expect(taskProgress({ kind: "mock", mock: "psycho", count: 1 }, [mock]).state).toBe("pending");
  });
});
