import { getFormatter, getTranslations } from "next-intl/server";
import { Badge, Card } from "@/components/ui/card";
import { Link } from "@/i18n/navigation";
import type { RankedUser, UserRanking } from "@/lib/admin/metrics";
import { hoursMinutes } from "@/lib/admin/overview";

/**
 * Alumnos que más usan la web en el periodo y últimos en usarla (ADR-072).
 * Cada nombre lleva a su ficha en /admin/alumnos.
 */
export async function UserRankingCards({ ranking }: { ranking: UserRanking }) {
  const t = await getTranslations("admin.ranking");
  const format = await getFormatter();

  const time = (s: number) => {
    const { h, m } = hoursMinutes(s);
    return h > 0 ? t("hours", { h, m }) : t("minutes", { m });
  };

  const who = (u: RankedUser) => (
    <span className="min-w-0">
      <Link
        href={`/admin/alumnos/${u.id}`}
        className="text-primary block truncate font-medium underline-offset-2 hover:underline"
      >
        {u.name ?? u.email}
      </Link>
      {u.name && <span className="text-muted-foreground block truncate text-xs">{u.email}</span>}
    </span>
  );

  const lists = [
    {
      key: "top",
      rows: ranking.top,
      detail: (u: RankedUser) =>
        t("topDetail", { time: time(u.seconds), answers: u.answers, days: u.days }),
    },
    {
      key: "recent",
      rows: ranking.recent,
      detail: (u: RankedUser) =>
        u.lastSeen ? format.relativeTime(new Date(u.lastSeen)) : t("never"),
    },
  ] as const;

  return (
    <section aria-labelledby="ranking-title" data-testid="admin-ranking">
      <h2 id="ranking-title" className="text-lg font-semibold">
        {t("title")}
      </h2>
      <div className="mt-3 grid gap-4 lg:grid-cols-2">
        {lists.map((l) => (
          <Card key={l.key} data-testid={`ranking-${l.key}`}>
            <h3 className="font-semibold">
              {l.key === "top" ? t("topTitle", { n: ranking.days }) : t("recentTitle")}
            </h3>
            <p className="text-muted-foreground mt-1 text-xs">{t(`${l.key}Hint`)}</p>
            {l.rows.length === 0 ? (
              <p className="text-muted-foreground mt-4 text-sm">{t("empty")}</p>
            ) : (
              <ol className="divide-border mt-3 divide-y text-sm">
                {l.rows.map((u, i) => (
                  <li key={u.id} className="flex flex-wrap items-center gap-x-3 gap-y-1 py-2">
                    <span className="text-muted-foreground w-5 shrink-0 text-right tabular-nums">
                      {i + 1}.
                    </span>
                    {who(u)}
                    {u.premium && (
                      <Badge tone="success" className="shrink-0">
                        Premium
                      </Badge>
                    )}
                    <span className="text-muted-foreground w-full pl-8 tabular-nums sm:ml-auto sm:w-auto sm:shrink-0 sm:pl-0 sm:text-right">
                      {l.detail(u)}
                    </span>
                  </li>
                ))}
              </ol>
            )}
          </Card>
        ))}
      </div>
    </section>
  );
}
