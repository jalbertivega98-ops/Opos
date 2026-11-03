"use client";

import { useActionState } from "react";
import { useTranslations } from "next-intl";
import { Button } from "@/components/ui/button";
import { Alert } from "@/components/ui/form";
import { publishAllAction, type FormState } from "@/lib/admin/content/actions";
import type { TopicCounts } from "@/lib/admin/content/queries";

/** «Aprobar y publicar todo»: un clic de la titular (DEC-006). La BD revalida todo. */
export function PublishAllForm({
  counts,
  draftProducts,
}: {
  counts: TopicCounts;
  draftProducts: number;
}) {
  const t = useTranslations("adminContent");
  const [state, action, pending] = useActionState<FormState, FormData>(publishAllAction, {
    status: "idle",
  });
  const s = counts.byStatus;
  const toPublish = (s.draft ?? 0) + (s.needs_review ?? 0) + (s.approved ?? 0);
  const [questions, products] = String(state.detail ?? "0|0")
    .split("|")
    .map(Number);
  return (
    <form
      action={action}
      className="border-accent bg-accent-soft/40 space-y-3 rounded-xl border-2 p-5"
      data-testid="publish-all"
    >
      <p className="text-lg font-semibold">{t("publishAll.title")}</p>
      <p className="text-sm" data-testid="publish-all-counts">
        {t("publishAll.counts", {
          pending: toPublish,
          published: s.published ?? 0,
          products: draftProducts,
        })}
      </p>
      {state.message && (
        <Alert tone={state.status === "error" ? "error" : "success"}>
          {state.status === "error"
            ? t(`errors.${state.message}`)
            : t("publishAll.done", { questions, products })}
        </Alert>
      )}
      {(toPublish > 0 || draftProducts > 0) && (
        <>
          {counts.flaggedPending > 0 && (
            <label className="flex items-start gap-2 text-sm">
              <input type="checkbox" name="include_flagged" className="mt-1" defaultChecked />
              <span>{t("publishAll.includeFlagged", { count: counts.flaggedPending })}</span>
            </label>
          )}
          <label className="flex items-start gap-2 text-sm">
            <input type="checkbox" name="confirm" className="mt-1" required />
            <span>{t("publishAll.confirm")}</span>
          </label>
          <Button type="submit" variant="accent" disabled={pending}>
            {pending ? t("publishAll.working") : t("publishAll.button")}
          </Button>
        </>
      )}
    </form>
  );
}
