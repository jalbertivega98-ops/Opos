"use client";

import { useActionState } from "react";
import { useTranslations } from "next-intl";
import { Button } from "@/components/ui/button";
import { Alert } from "@/components/ui/form";
import { transitionAction, type FormState } from "@/lib/admin/content/actions";
import type { ContentStatus } from "@/lib/admin/content/schema";

type Move = {
  to: ContentStatus;
  label: string;
  owner: boolean;
  variant: "accent" | "outline" | "danger";
};

const MOVES: Record<ContentStatus, Move[]> = {
  draft: [{ to: "needs_review", label: "toReview", owner: false, variant: "accent" }],
  needs_review: [
    { to: "approved", label: "approve", owner: true, variant: "accent" },
    { to: "draft", label: "reject", owner: true, variant: "danger" },
  ],
  approved: [
    { to: "published", label: "publish", owner: true, variant: "accent" },
    { to: "needs_review", label: "reopen", owner: false, variant: "outline" },
  ],
  published: [
    { to: "needs_review", label: "reopen", owner: false, variant: "outline" },
    { to: "archived", label: "archive", owner: true, variant: "danger" },
  ],
  archived: [{ to: "needs_review", label: "reopen", owner: false, variant: "outline" }],
};

/** Botones del flujo de revisión. La BD vuelve a comprobar los permisos. */
export function TransitionForm({
  id,
  status,
  isOwner,
}: {
  id: string;
  status: ContentStatus;
  isOwner: boolean;
}) {
  const t = useTranslations("adminContent");
  const [state, action, pending] = useActionState<FormState, FormData>(transitionAction, {
    status: "idle",
  });
  const moves = MOVES[status];
  const needsComment = moves.some((m) => m.to === "draft");
  return (
    <form action={action} className="space-y-3">
      {state.message && (
        <Alert tone={state.status === "error" ? "error" : "success"}>
          {state.status === "error" ? t(`errors.${state.message}`) : t(`workflow.${state.message}`)}
          {state.detail ? ` (${state.detail})` : ""}
        </Alert>
      )}
      <input type="hidden" name="id" value={id} />
      {needsComment && isOwner && (
        <label className="block space-y-1.5 text-sm">
          <span className="font-medium">{t("workflow.comment")}</span>
          <textarea
            name="comment"
            rows={2}
            maxLength={2000}
            className="border-input bg-background w-full rounded-lg border px-3 py-2"
          />
        </label>
      )}
      <div className="flex flex-wrap gap-2">
        {moves.map((m) => (
          <Button
            key={m.to}
            type="submit"
            name="to"
            value={m.to}
            variant={m.variant}
            size="sm"
            disabled={pending || (m.owner && !isOwner)}
          >
            {t(`workflow.${m.label}`)}
          </Button>
        ))}
      </div>
      {!isOwner && moves.some((m) => m.owner) && (
        <p className="text-muted-foreground text-xs">{t("workflow.ownerOnly")}</p>
      )}
    </form>
  );
}
