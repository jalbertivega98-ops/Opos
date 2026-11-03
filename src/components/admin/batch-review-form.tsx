"use client";

import { useActionState } from "react";
import { useTranslations } from "next-intl";
import { Button } from "@/components/ui/button";
import { Alert } from "@/components/ui/form";
import { batchReviewAction, type FormState } from "@/lib/admin/content/actions";
import type { TopicCounts } from "@/lib/admin/content/queries";

/** Aprobación/publicación por lotes de un tema (DEC-006). La BD vuelve a comprobar permisos. */
export function BatchReviewForm({
  topic,
  title,
  counts,
  isOwner,
}: {
  topic: string;
  title: string;
  counts: TopicCounts;
  isOwner: boolean;
}) {
  const t = useTranslations("adminContent");
  const [state, action, pending] = useActionState<FormState, FormData>(batchReviewAction, {
    status: "idle",
  });
  const s = counts.byStatus;
  const pendingApproval = (s.draft ?? 0) + (s.needs_review ?? 0) - counts.flaggedPending;
  const approved = s.approved ?? 0;
  return (
    <form
      action={action}
      className="border-accent/40 bg-accent-soft/40 space-y-3 rounded-xl border p-4"
      data-testid="batch-review"
    >
      <input type="hidden" name="topic" value={topic} />
      <p className="font-semibold">{t("batch.title", { topic: title })}</p>
      <p className="text-sm" data-testid="batch-counts">
        {t("batch.counts", {
          pending: pendingApproval,
          flagged: counts.flaggedPending,
          approved,
          published: s.published ?? 0,
        })}
      </p>
      {state.message && (
        <Alert tone={state.status === "error" ? "error" : "success"}>
          {state.status === "error"
            ? t(`errors.${state.message}`)
            : t(`batch.${state.message}`, { count: Number(state.detail ?? 0) })}
          {state.status === "error" && state.detail ? ` (${state.detail})` : ""}
        </Alert>
      )}
      {isOwner ? (
        <>
          <label className="flex items-start gap-2 text-sm">
            <input type="checkbox" name="confirm" className="mt-1" required />
            <span>{t("batch.confirm")}</span>
          </label>
          {counts.flaggedPending > 0 && (
            <label className="flex items-start gap-2 text-sm">
              <input type="checkbox" name="include_flagged" className="mt-1" />
              <span>{t("batch.includeFlagged", { count: counts.flaggedPending })}</span>
            </label>
          )}
          <div className="flex flex-wrap gap-2">
            <Button
              type="submit"
              name="to"
              value="approved"
              size="sm"
              variant="accent"
              disabled={pending || pendingApproval + counts.flaggedPending === 0}
            >
              {t("batch.approve")}
            </Button>
            <Button
              type="submit"
              name="to"
              value="published"
              size="sm"
              variant="outline"
              disabled={pending || approved === 0}
            >
              {t("batch.publish")}
            </Button>
          </div>
        </>
      ) : (
        <p className="text-muted-foreground text-xs">{t("workflow.ownerOnly")}</p>
      )}
    </form>
  );
}
