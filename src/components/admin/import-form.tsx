"use client";

import { useActionState } from "react";
import { useTranslations } from "next-intl";
import { Button } from "@/components/ui/button";
import { Alert, Label } from "@/components/ui/form";
import { importQuestionsAction, type ImportState } from "@/lib/admin/content/actions";

export function ImportForm() {
  const t = useTranslations("adminContent");
  const [state, action, pending] = useActionState<ImportState, FormData>(importQuestionsAction, {
    status: "idle",
  });
  const r = state.report;
  return (
    <form action={action} className="space-y-4">
      {state.status === "error" && state.message && (
        <Alert tone="error">{t(`errors.${state.message}`)}</Alert>
      )}
      {state.status === "success" && r && (
        <Alert tone={r.invalid.length || r.duplicates.length ? "info" : "success"}>
          <p className="font-semibold">{t(`importPage.${state.message}`)}</p>
          <p data-testid="import-report">
            {t("importPage.report", { valid: r.valid, total: r.total, imported: r.imported })}
          </p>
          {r.duplicates.length > 0 && (
            <p>{t("importPage.duplicates", { lines: r.duplicates.join(", ") })}</p>
          )}
          {r.invalid.length > 0 && (
            <ul className="mt-2 list-disc pl-5">
              {r.invalid.slice(0, 50).map((i) => (
                <li key={i.line}>
                  {t("importPage.invalid", { line: i.line, errors: i.errors.join(", ") })}
                </li>
              ))}
            </ul>
          )}
        </Alert>
      )}
      <div className="space-y-1.5">
        <Label htmlFor="file">{t("importPage.file")}</Label>
        <input
          id="file"
          name="file"
          type="file"
          accept=".csv,.json,text/csv,application/json"
          required
          className="block w-full text-sm"
        />
      </div>
      <label className="flex items-center gap-2 text-sm">
        <input type="checkbox" name="dry_run" className="size-4" /> {t("importPage.dryRun")}
      </label>
      <Button type="submit" variant="accent" disabled={pending}>
        {t("importPage.submit")}
      </Button>
    </form>
  );
}
