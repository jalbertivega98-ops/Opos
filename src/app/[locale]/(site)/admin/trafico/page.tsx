import type { Metadata } from "next";
import { getTranslations, setRequestLocale } from "next-intl/server";
import { Card, EmptyState } from "@/components/ui/card";
import { listTraffic, sumBy, type TrafficRow } from "@/lib/analytics/queries";

export const metadata: Metadata = { title: "Admin · Tráfico", robots: { index: false } };

const CHANNELS = ["search", "ai", "social", "referral", "direct"] as const;

function Table({
  title,
  rows,
  colA,
  colB,
  testId,
}: {
  title: string;
  rows: { key: string; hits: number }[];
  colA: string;
  colB: string;
  testId: string;
}) {
  return (
    <Card className="overflow-x-auto p-0">
      <h2 className="px-4 pt-4 text-lg font-semibold">{title}</h2>
      <table className="mt-2 w-full text-left text-sm" data-testid={testId}>
        <thead className="text-muted-foreground border-border border-b">
          <tr>
            <th className="px-4 py-2 font-medium">{colA}</th>
            <th className="px-4 py-2 text-right font-medium">{colB}</th>
          </tr>
        </thead>
        <tbody className="divide-border divide-y">
          {rows.slice(0, 15).map((r) => (
            <tr key={r.key}>
              <td className="px-4 py-2">{r.key}</td>
              <td className="px-4 py-2 text-right tabular-nums">{r.hits}</td>
            </tr>
          ))}
        </tbody>
      </table>
    </Card>
  );
}

export default async function TrafficPage({ params }: PageProps<"/[locale]/admin/trafico">) {
  const { locale } = await params;
  setRequestLocale(locale);
  const t = await getTranslations("adminTraffic");
  const rows = await listTraffic(30);
  const visits = rows.filter((r) => r.kind === "visit");
  const crawls = rows.filter((r) => r.kind === "crawler");
  const label = (r: TrafficRow) => `${t(`channel.${r.channel}`)} · ${r.source}`;
  const byChannel = sumBy(visits, (r) => r.channel);

  return (
    <div className="mx-auto max-w-6xl space-y-6 px-4 py-8">
      <div>
        <h1 className="text-3xl font-bold">{t("title")}</h1>
        <p className="text-muted-foreground mt-1 max-w-3xl text-sm">{t("subtitle")}</p>
      </div>
      {rows.length === 0 ? (
        <EmptyState title={t("empty")} description={t("emptyBody")} />
      ) : (
        <>
          <ul className="grid gap-3 sm:grid-cols-5" data-testid="traffic-channels">
            {CHANNELS.map((c) => (
              <li key={c}>
                <Card className="rounded-2xl p-4">
                  <p className="text-muted-foreground text-xs font-medium">{t(`channel.${c}`)}</p>
                  <p className="mt-1 text-2xl font-bold tabular-nums">
                    {byChannel.find((x) => x.key === c)?.hits ?? 0}
                  </p>
                </Card>
              </li>
            ))}
          </ul>
          <div className="grid gap-6 lg:grid-cols-2">
            <Table
              title={t("bySource")}
              rows={sumBy(visits, label)}
              colA={t("source")}
              colB={t("visits")}
              testId="traffic-sources"
            />
            <Table
              title={t("byLanding")}
              rows={sumBy(
                visits.filter((r) => r.channel === "search" || r.channel === "ai"),
                (r) => `${r.path} · ${r.source}`,
              )}
              colA={t("landing")}
              colB={t("visits")}
              testId="traffic-landings"
            />
            <Table
              title={t("crawlers")}
              rows={sumBy(crawls, label)}
              colA={t("crawler")}
              colB={t("requests")}
              testId="traffic-crawlers"
            />
            <Table
              title={t("crawledPaths")}
              rows={sumBy(crawls, (r) => r.path)}
              colA={t("path")}
              colB={t("requests")}
              testId="traffic-crawled"
            />
          </div>
        </>
      )}
      <p className="text-muted-foreground text-xs">{t("privacy")}</p>
    </div>
  );
}
