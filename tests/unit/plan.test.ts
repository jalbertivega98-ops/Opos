import { describe, expect, it } from "vitest";
import { buildWeekPlan, phaseFor, type PlanInput } from "@/lib/learning/plan";
import { examHasPsycho } from "@/lib/catalog/exam-format";

const topics = Array.from({ length: 20 }, (_, i) => ({
  slug: `t${i + 1}`,
  title: `Tema ${i + 1}`,
}));
const base: PlanInput = {
  weeklyHours: 6,
  level: "intermediate",
  today: new Date("2026-11-03"),
  startedAt: new Date("2026-11-03"),
  examDate: null,
  topics,
  progress: {},
};

describe("plan de estudio", () => {
  it("sin fecha: ciclo de 16 semanas empezando por los primeros temas", () => {
    const p = buildWeekPlan(base);
    expect(p).toMatchObject({ week: 1, totalWeeks: 16, phase: "syllabus", covered: 0 });
    const topicTasks = p.tasks.filter((t) => t.kind === "topic");
    expect(topicTasks.map((t) => t.kind === "topic" && t.topic.slug)).toEqual(["t1", "t2"]);
    expect(p.tasks.some((t) => t.kind === "psycho")).toBe(true);
    expect(p.minutes.syllabus + p.minutes.psycho + p.minutes.mocks).toBe(360);
  });

  it("con fecha de examen cerca entra en fase de simulacros", () => {
    const p = buildWeekPlan({ ...base, examDate: new Date("2026-11-12") });
    expect(p).toMatchObject({ week: 1, totalWeeks: 2, phase: "mocks" });
    expect(p.tasks.filter((t) => t.kind === "mock").length).toBe(2);
  });

  it("salta los temas ya dominados y repasa primero los más flojos", () => {
    const progress = {
      t1: { answered: 20, correct: 18 },
      t2: { answered: 20, correct: 8 },
      t3: { answered: 10, correct: 9 },
    };
    const p = buildWeekPlan({
      ...base,
      progress,
      today: new Date("2027-01-12"), // semana 11 de 16 → repaso
    });
    expect(p.phase).toBe("review");
    expect(p.covered).toBe(1);
    const first = p.tasks[0];
    expect(first.kind === "topic" && first.topic.slug).toBe("t2");
    expect(first.kind === "topic" && first.status).toBe("weak");
  });

  it("las fases respetan el nivel", () => {
    expect(phaseFor(10, 16, "beginner")).toBe("syllabus");
    expect(phaseFor(10, 16, "advanced")).toBe("review");
    expect(phaseFor(16, 16, "beginner")).toBe("mocks");
  });

  it("sin psicotécnico en la oposición: ni tareas ni simulacros de psicotécnicos", () => {
    const p = buildWeekPlan({ ...base, psycho: false, today: new Date("2027-02-20") });
    expect(p.minutes.psycho).toBe(0);
    expect(p.minutes.syllabus + p.minutes.mocks).toBe(360);
    expect(p.tasks.some((t) => t.kind === "psycho")).toBe(false);
    expect(p.tasks.some((t) => t.kind === "mock" && t.mock === "psycho")).toBe(false);
    expect(p.tasks.some((t) => t.kind === "mock" && t.mock === "knowledge")).toBe(true);
  });

  it("solo las oposiciones con prueba psicotécnica oficial la ofrecen", () => {
    expect(examHasPsycho("auxilio-judicial")).toBe(false);
    expect(examHasPsycho("tramitacion-procesal")).toBe(false);
    expect(examHasPsycho("administrativo-estado")).toBe(false);
    expect(examHasPsycho("mossos-esquadra")).toBe(true);
    expect(examHasPsycho("auxiliar-administrativo-estado")).toBe(true);
    expect(examHasPsycho("guardia-civil-cabos-guardias")).toBe(true);
  });
});
