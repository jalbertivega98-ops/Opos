"use client";

import { useActionState } from "react";
import { useTranslations } from "next-intl";
import { Button } from "@/components/ui/button";
import { Alert } from "@/components/ui/form";
import { reviewNotesAction, type FormState } from "@/lib/admin/content/actions";
import type { ContentStatus } from "@/lib/admin/content/schema";

/**
 * Aprobar/publicar fichas de estudio (CNT-011). Sin `topic`, actúa sobre todas las
 * pendientes de un clic. La BD vuelve a comprobar que es la titular.
 */
export function NotesReviewForm({
  topic,
  status,
  pending: pendingCount,
}: {
  topic?: string;
  status?: ContentStatus;
  pending?: number;
}) {
  const t = useTranslations("adminContent.notes");
  const te = useTranslations("adminContent.errors");
  const [state, action, pending] = useActionState<FormState, FormData>(reviewNotesAction, {
    status: "idle",
  });
  // Una ficha: aprobar si está pendiente, publicar si está aprobada. Todas: ambos pasos.
  const to = !topic ? "both" : status === "approved" ? "published" : "approved";
  const result = state.message && (
    <Alert tone={state.status === "error" ? "error" : "success"}>
      {state.status === "error"
        ? te(state.message)
        : t(state.message.replace(/^notes_/, "done_"), { count: Number(state.detail ?? 0) })}
      {state.status === "error" && state.detail ? ` (${state.detail})` : ""}
    </Alert>
  );
  // Ya publicada (o nada pendiente): solo queda el resultado de la última acción
  if (
    (topic && status && !["draft", "needs_review", "approved"].includes(status)) ||
    (!topic && !pendingCount)
  )
    return result || null;
  return (
    <form
      action={action}
      className="flex flex-wrap items-center gap-3"
      data-testid={topic ? "note-review" : "notes-review-all"}
    >
      {topic && <input type="hidden" name="topic" value={topic} />}
      <input type="hidden" name="to" value={to} />
      <label className="flex items-center gap-2 text-sm">
        <input type="checkbox" name="confirm" required />
        <span>{topic ? t("confirmOne") : t("confirmAll", { count: pendingCount ?? 0 })}</span>
      </label>
      <Button type="submit" size="sm" variant="accent" disabled={pending}>
        {pending ? t("working") : t(`button_${to}`)}
      </Button>
      {result}
    </form>
  );
}
