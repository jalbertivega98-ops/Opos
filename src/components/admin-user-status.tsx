"use client";

import { useActionState } from "react";
import { useTranslations } from "next-intl";
import { Button } from "@/components/ui/button";
import { Alert } from "@/components/ui/form";
import { setUserStatusAction, type AdminActionState } from "@/lib/admin/actions";

export function UserStatusForm({ id, status }: { id: string; status: string }) {
  const t = useTranslations();
  const [state, action, pending] = useActionState<AdminActionState, FormData>(setUserStatusAction, {
    status: "idle",
  });
  const next = status === "active" ? "suspended" : "active";
  return (
    <form action={action} className="space-y-3">
      {state.message && (
        <Alert tone={state.status === "error" ? "error" : "success"}>{t(state.message)}</Alert>
      )}
      <input type="hidden" name="id" value={id} />
      <input type="hidden" name="status" value={next} />
      <Button type="submit" variant={next === "suspended" ? "danger" : "accent"} disabled={pending}>
        {next === "suspended" ? t("adminUsers.suspend") : t("adminUsers.reactivate")}
      </Button>
    </form>
  );
}
