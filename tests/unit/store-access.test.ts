import { describe, expect, it } from "vitest";
import { isAttemptsPack, planAccess, taskUnlocked } from "@/lib/store/access";

const item = (over: Partial<Parameters<typeof planAccess>[0][number]> = {}) => ({
  type: "question_pack",
  source: "purchase",
  is_test: false,
  attempts_left: null,
  ...over,
});
const topic = (slug: string) =>
  ({ kind: "topic", topic: { slug, title: slug }, questions: 10, status: "new" }) as const;
const mock = { kind: "mock", mock: "knowledge", count: 1 } as const;

describe("acceso del plan (ADR-035)", () => {
  it("reconoce los packs de intentos", () => {
    expect(isAttemptsPack({ type: "bundle", config: { attempts: 10 } })).toBe(true);
    expect(isAttemptsPack({ type: "bundle", config: {} })).toBe(false);
    expect(isAttemptsPack({ type: "mock_exam", config: { attempts: 10 } })).toBe(false);
  });

  it("un alumno gratis solo abre los temas gratis y los psicotécnicos", () => {
    const access = planAccess([item({ source: "free" })], ["t1", "t2", "t3"]);
    expect(taskUnlocked(topic("t1"), access)).toBe(true);
    expect(taskUnlocked(topic("t4"), access)).toBe(false);
    expect(taskUnlocked(mock, access)).toBe(false);
    expect(taskUnlocked({ kind: "psycho", sessions: 1 }, access)).toBe(true);
  });

  it("un pack de intentos abre los simulacros pero no el temario", () => {
    const access = planAccess([item({ type: "bundle", attempts_left: 5 })]);
    expect(taskUnlocked(mock, access)).toBe(true);
    expect(taskUnlocked(topic("t4"), access)).toBe(false);
  });

  it("con Premium o un pack de preguntas se abre todo el temario", () => {
    const access = planAccess([item({ source: "subscription" })]);
    expect(taskUnlocked(topic("t9"), access)).toBe(true);
  });
});

describe("packs de intentos agotados", () => {
  it("no abren los simulacros del plan", () => {
    const access = planAccess([item({ type: "bundle", attempts_left: 0 })]);
    expect(taskUnlocked(mock, access)).toBe(false);
  });
});

describe("simulacros del plan por tipo", () => {
  const psychoMock = { kind: "mock", mock: "psycho", count: 1 } as const;

  it("el pack de psicotécnicos abre solo el simulacro de psicotécnicos", () => {
    const access = planAccess(
      [
        item({ type: "bundle", slug: "mossos-10-psicotecnicos", attempts_left: 10 }),
        item({ type: "mock_exam", product_id: "apt", source: "bundle" }),
      ],
      [],
      new Map([["apt", "psycho"]]),
    );
    expect(taskUnlocked(psychoMock, access)).toBe(true);
    expect(taskUnlocked(mock, access)).toBe(false);
  });

  it("el pack de simulacros abre solo los de conocimientos", () => {
    const access = planAccess([
      item({ type: "bundle", slug: "mossos-10-simulacros", attempts_left: 10 }),
    ]);
    expect(taskUnlocked(mock, access)).toBe(true);
    expect(taskUnlocked(psychoMock, access)).toBe(false);
  });

  it("Premium abre los dos", () => {
    const access = planAccess([item({ type: "bundle", source: "subscription" })]);
    expect(taskUnlocked(mock, access)).toBe(true);
    expect(taskUnlocked(psychoMock, access)).toBe(true);
  });
});
