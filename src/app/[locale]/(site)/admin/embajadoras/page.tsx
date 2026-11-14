import type { Metadata } from "next";
import { getFormatter, getTranslations, setRequestLocale } from "next-intl/server";
import { Button } from "@/components/ui/button";
import { Badge, Card, EmptyState } from "@/components/ui/card";
import { AmbassadorForm } from "@/components/admin/ambassador-form";
import { Link } from "@/i18n/navigation";
import { examBodyOptions } from "@/lib/admin/content/queries";
import { toggleAmbassadorAction } from "@/lib/ambassadors/actions";
import { ambassadorUrl } from "@/lib/ambassadors/link";
import { listAmbassadors } from "@/lib/ambassadors/queries";
import { publicEnv } from "@/lib/env";

export const metadata: Metadata = { title: "Admin · Embajadoras", robots: { index: false } };

const DAYS = 30;

/** Programa de embajadoras (ADR-054): enlaces propios y cuántos alumnos trae cada una. */
export default async function AmbassadorsPage({
  params,
}: PageProps<"/[locale]/admin/embajadoras">) {
  const { locale } = await params;
  setRequestLocale(locale);
  const t = await getTranslations("adminAmbassadors");
  const format = await getFormatter();
  const [rows, exams] = await Promise.all([listAmbassadors(DAYS), examBodyOptions()]);
  const pair = (period: number, total: number) => (
    <>
      <span className="font-semibold">{period}</span>
      <span className="text-muted-foreground"> / {total}</span>
    </>
  );
  return (
    <div className="mx-auto max-w-6xl space-y-6 px-4 py-8">
      <div>
        <h1 className="text-3xl font-bold">{t("title")}</h1>
        <p className="text-muted-foreground mt-1 max-w-3xl text-sm">{t("subtitle")}</p>
      </div>

      <Card className="space-y-3">
        <h2 className="text-lg font-semibold">{t("newTitle")}</h2>
        <p className="text-muted-foreground text-sm">
          {t.rich("newHelp", {
            students: (c) => (
              <Link href="/admin/alumnos" className="text-accent underline">
                {c}
              </Link>
            ),
          })}
        </p>
        <AmbassadorForm exams={exams.map((e) => ({ id: e.id, name: e.name }))} />
      </Card>

      {rows.length === 0 ? (
        <EmptyState title={t("empty")} description={t("emptyHint")} />
      ) : (
        <Card className="overflow-x-auto p-0">
          <p className="text-muted-foreground border-border border-b px-4 py-3 text-xs">
            {t("periodHint", { days: DAYS })}
          </p>
          <table className="w-full min-w-[860px] text-left text-sm" data-testid="ambassadors-table">
            <thead className="text-muted-foreground border-border border-b">
              <tr>
                <th className="px-4 py-3 font-medium">{t("colName")}</th>
                <th className="px-4 py-3 font-medium">{t("colLink")}</th>
                <th className="px-4 py-3 text-right font-medium">{t("colVisits")}</th>
                <th className="px-4 py-3 text-right font-medium">{t("colSignups")}</th>
                <th className="px-4 py-3 text-right font-medium">{t("colPaid")}</th>
                <th className="px-4 py-3 font-medium">{t("colStatus")}</th>
              </tr>
            </thead>
            <tbody className="divide-border divide-y">
              {rows.map((r) => (
                <tr key={r.id} className={r.active ? undefined : "opacity-70"}>
                  <td className="px-4 py-3 align-top">
                    <div className="font-medium">{r.name}</div>
                    <div className="text-muted-foreground text-xs">
                      {t(`networks.${r.network}` as never)}
                      {r.handle ? ` · ${r.handle}` : ""}
                      {r.exam_name ? ` · ${r.exam_name}` : ""}
                    </div>
                    <div className="text-muted-foreground text-xs">
                      {t("since", {
                        date: format.dateTime(new Date(r.created_at), { dateStyle: "medium" }),
                      })}
                    </div>
                    {r.notes && <div className="mt-1 text-xs">{r.notes}</div>}
                  </td>
                  <td className="px-4 py-3 align-top">
                    <code className="bg-surface-2 rounded px-1.5 py-0.5 text-xs break-all select-all">
                      {ambassadorUrl(publicEnv.NEXT_PUBLIC_SITE_URL, r.code)}
                    </code>
                    <div className="text-muted-foreground mt-1 text-xs">
                      {t("codeLabel", { code: r.code })}
                    </div>
                  </td>
                  <td className="px-4 py-3 text-right align-top tabular-nums">
                    {pair(r.visitsPeriod, r.visitsTotal)}
                  </td>
                  <td className="px-4 py-3 text-right align-top tabular-nums">
                    {pair(r.signupsPeriod, r.signupsTotal)}
                  </td>
                  <td className="px-4 py-3 text-right align-top tabular-nums">
                    {pair(r.paidPeriod, r.paidTotal)}
                  </td>
                  <td className="px-4 py-3 align-top">
                    <form action={toggleAmbassadorAction} className="flex items-center gap-2">
                      <input type="hidden" name="id" value={r.id} />
                      <input type="hidden" name="active" value={r.active ? "false" : "true"} />
                      <Badge tone={r.active ? "success" : "neutral"}>
                        {r.active ? t("active") : t("paused")}
                      </Badge>
                      <Button type="submit" variant="outline" size="sm">
                        {r.active ? t("pause") : t("resume")}
                      </Button>
                    </form>
                  </td>
                </tr>
              ))}
            </tbody>
          </table>
        </Card>
      )}
    </div>
  );
}
