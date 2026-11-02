"use client";

import { useActionState, useState } from "react";
import { useTranslations } from "next-intl";
import { Plus, Trash2 } from "lucide-react";
import { Button } from "@/components/ui/button";
import { Alert, Input, Label } from "@/components/ui/form";
import { saveQuestionAction, type FormState } from "@/lib/admin/content/actions";

export type QuestionFormValues = {
  id?: string;
  stem: string;
  explanation: string;
  category: string;
  difficulty: number;
  locale: "es" | "ca";
  is_free: boolean;
  ai_generated: boolean;
  options: string[];
  correct: number;
  exam_body_ids: string[];
};

const LABELS = ["A", "B", "C", "D", "E", "F"];
const area =
  "border-input bg-background w-full rounded-lg border px-3 py-2 text-base focus-visible:ring-2 focus-visible:ring-[var(--ring)] focus-visible:outline-none";

export function QuestionForm({
  initial,
  exams,
  disabled,
}: {
  initial: QuestionFormValues;
  exams: { id: string; name: string }[];
  disabled?: boolean;
}) {
  const t = useTranslations("adminContent");
  const [state, action, pending] = useActionState<FormState, FormData>(saveQuestionAction, {
    status: "idle",
  });
  const [options, setOptions] = useState<string[]>(
    initial.options.length ? initial.options : ["", "", "", ""],
  );
  const [correct, setCorrect] = useState(initial.correct);
  const err = (k: string) =>
    state.fields?.[k]
      ? t.has(`errors.${state.fields[k]}`)
        ? t(`errors.${state.fields[k]}`)
        : state.fields[k]
      : null;

  return (
    <form action={action} className="space-y-6" aria-describedby="form-status">
      <div id="form-status">
        {state.status === "error" && state.message && (
          <Alert tone="error">
            {t(`errors.${state.message}`)}
            {state.detail ? ` (${state.detail})` : ""}
          </Alert>
        )}
      </div>
      {initial.id && <input type="hidden" name="id" value={initial.id} />}
      <fieldset disabled={disabled || pending} className="space-y-6">
        <div className="space-y-1.5">
          <Label htmlFor="stem">{t("form.stem")}</Label>
          <textarea
            id="stem"
            name="stem"
            rows={3}
            required
            defaultValue={initial.stem}
            className={area}
            aria-invalid={!!err("stem")}
          />
          {err("stem") && <p className="text-danger text-sm">{err("stem")}</p>}
        </div>

        <fieldset className="space-y-3">
          <legend className="text-sm font-medium">{t("form.options")}</legend>
          {options.map((opt, i) => (
            <div key={i} className="flex items-center gap-2">
              <input
                type="radio"
                name="correct"
                value={i}
                checked={correct === i}
                onChange={() => setCorrect(i)}
                aria-label={`${t("form.correct")}: ${LABELS[i]}`}
                className="size-5 accent-[var(--accent)]"
              />
              <Input
                name="option"
                aria-label={t("form.option", { label: LABELS[i] })}
                value={opt}
                onChange={(e) => setOptions(options.map((o, j) => (j === i ? e.target.value : o)))}
              />
              {options.length > 2 && (
                <Button
                  type="button"
                  variant="ghost"
                  size="icon"
                  aria-label={t("form.removeOption", { label: LABELS[i] })}
                  onClick={() => {
                    setOptions(options.filter((_, j) => j !== i));
                    if (correct >= i && correct > 0) setCorrect(correct === i ? 0 : correct - 1);
                  }}
                >
                  <Trash2 className="size-4" aria-hidden />
                </Button>
              )}
            </div>
          ))}
          {(err("options") || err("option") || err("correct")) && (
            <p className="text-danger text-sm">
              {err("options") ?? err("option") ?? err("correct")}
            </p>
          )}
          {options.length < 6 && (
            <Button
              type="button"
              variant="outline"
              size="sm"
              onClick={() => setOptions([...options, ""])}
            >
              <Plus className="size-4" aria-hidden /> {t("form.addOption")}
            </Button>
          )}
        </fieldset>

        <div className="space-y-1.5">
          <Label htmlFor="explanation">{t("form.explanation")}</Label>
          <textarea
            id="explanation"
            name="explanation"
            rows={3}
            defaultValue={initial.explanation}
            className={area}
          />
        </div>

        <div className="grid gap-4 sm:grid-cols-3">
          <div className="space-y-1.5">
            <Label htmlFor="category">{t("form.category")}</Label>
            <Input
              id="category"
              name="category"
              required
              defaultValue={initial.category}
              aria-invalid={!!err("category")}
            />
            {err("category") && <p className="text-danger text-sm">{err("category")}</p>}
          </div>
          <div className="space-y-1.5">
            <Label htmlFor="difficulty">{t("form.difficulty")}</Label>
            <select
              id="difficulty"
              name="difficulty"
              defaultValue={initial.difficulty}
              className={`${area} h-11`}
            >
              {[1, 2, 3, 4, 5].map((d) => (
                <option key={d}>{d}</option>
              ))}
            </select>
          </div>
          <div className="space-y-1.5">
            <Label htmlFor="locale">{t("form.locale")}</Label>
            <select
              id="locale"
              name="locale"
              defaultValue={initial.locale}
              className={`${area} h-11`}
            >
              <option value="es">Castellano</option>
              <option value="ca">Català</option>
            </select>
          </div>
        </div>

        <div className="space-y-2 text-sm">
          <label className="flex items-center gap-2">
            <input
              type="checkbox"
              name="is_free"
              defaultChecked={initial.is_free}
              className="size-4"
            />{" "}
            {t("form.isFree")}
          </label>
          <label className="flex items-center gap-2">
            <input
              type="checkbox"
              name="ai_generated"
              defaultChecked={initial.ai_generated}
              className="size-4"
            />{" "}
            {t("form.ai")}
          </label>
        </div>

        {exams.length > 0 && (
          <fieldset className="space-y-2">
            <legend className="text-sm font-medium">{t("form.exams")}</legend>
            <div className="grid max-h-56 gap-1 overflow-y-auto rounded-lg border p-3 text-sm sm:grid-cols-2">
              {exams.map((e) => (
                <label key={e.id} className="flex items-center gap-2">
                  <input
                    type="checkbox"
                    name="exam"
                    value={e.id}
                    defaultChecked={initial.exam_body_ids.includes(e.id)}
                    className="size-4"
                  />
                  {e.name}
                </label>
              ))}
            </div>
          </fieldset>
        )}

        <Button type="submit" variant="accent" disabled={disabled || pending}>
          {pending ? t("form.saving") : t("form.save")}
        </Button>
      </fieldset>
    </form>
  );
}
