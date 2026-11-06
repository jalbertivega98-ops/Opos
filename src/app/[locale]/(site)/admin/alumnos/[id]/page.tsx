import type { Metadata } from "next";
import { notFound } from "next/navigation";
import { getFormatter, getTranslations, setRequestLocale } from "next-intl/server";
import { ArrowLeft } from "lucide-react";
import { Link } from "@/i18n/navigation";
import { Badge, Card } from "@/components/ui/card";
import { Alert } from "@/components/ui/form";
import { UserStatusForm } from "@/components/admin-user-status";
import { PromoCodeForm, UserGrantForm } from "@/components/admin/user-insight-forms";
import { Button } from "@/components/ui/button";
import { endUserPremiumAction, revokeUserGrantAction } from "@/lib/admin/actions";
import { getUserInsights } from "@/lib/admin/insights";
import { getUser } from "@/lib/admin/users";
import { getBillingConfig } from "@/lib/billing/stripe";
import { listProducts } from "@/lib/store/queries";
import { formatPrice } from "@/lib/store/schema";

/** 4500 s → «1 h 15 min»; menos de un minuto → «0 min». */
function formatDuration(seconds: number) {
  const m = Math.floor(seconds / 60);
  const h = Math.floor(m / 60);
  return h > 0 ? `${h} h ${m % 60} min` : `${m} min`;
}

export const metadata: Metadata = { title: "Alumno", robots: { index: false } };

export default async function AdminUserPage({ params }: PageProps<"/[locale]/admin/alumnos/[id]">) {
  const { locale, id } = await params;
  setRequestLocale(locale);
  const [u, ins, products] = await Promise.all([getUser(id), getUserInsights(id), listProducts()]);
  if (!u || !ins) notFound();
  const billing = getBillingConfig();
  const grantable = products
    .filter((p) => p.status !== "archived" && !p.is_test && !p.is_free)
    .map((p) => ({ id: p.id, title: p.title, type: p.type }));
  const activeSubs = ins.subscriptions.filter((s) => s.active);
  const activeGrants = ins.grants.filter((g) => g.status === "active");
  const t = await getTranslations();
  const format = await getFormatter();
  const date = (v: string | null) =>
    v ? format.dateTime(new Date(v), { dateStyle: "medium", timeStyle: "short" }) : "—";
  const time = (v: string) => format.dateTime(new Date(v), { timeStyle: "short" });
  const day = (v: string) =>
    format.dateTime(new Date(`${v}T12:00:00`), {
      weekday: "short",
      day: "numeric",
      month: "short",
    });
  const ti = (k: string, values?: Record<string, string | number>) =>
    t(`adminUsers.insights.${k}` as never, values as never);

  return (
    <div className="mx-auto max-w-4xl space-y-6 px-4 py-8">
      <Link
        href="/admin/alumnos"
        className="text-muted-foreground inline-flex items-center gap-1 text-sm hover:underline"
      >
        <ArrowLeft className="size-4" aria-hidden /> {t("adminUsers.back")}
      </Link>
      <div className="flex flex-wrap items-start justify-between gap-4">
        <div>
          <h1 className="text-2xl font-bold break-all">{u.email}</h1>
          <p className="text-muted-foreground text-sm">
            {u.display_name ?? "—"} · {t(`adminUsers.role.${u.role}`)} · {u.locale.toUpperCase()}
          </p>
        </div>
        <Badge tone={u.status === "active" ? "success" : "warning"}>
          {t(`adminUsers.status.${u.status}`)}
        </Badge>
      </div>
      <Alert>{t("adminUsers.auditNote")}</Alert>

      <Card>
        <h2 className="sr-only">{t("adminUsers.detail")}</h2>
        <dl className="grid gap-x-6 gap-y-3 text-sm sm:grid-cols-2">
          <div>
            <dt className="text-muted-foreground">{t("admin.columns.createdAt")}</dt>
            <dd>{date(u.created_at)}</dd>
          </div>
          <div>
            <dt className="text-muted-foreground">{t("adminUsers.emailConfirmed")}</dt>
            <dd>
              {u.email_confirmed_at ? date(u.email_confirmed_at) : t("adminUsers.notConfirmed")}
            </dd>
          </div>
          <div>
            <dt className="text-muted-foreground">{t("adminUsers.lastSignIn")}</dt>
            <dd>{date(u.last_sign_in_at)}</dd>
          </div>
          <div>
            <dt className="text-muted-foreground">{t("admin.columns.lastActive")}</dt>
            <dd>{date(u.last_active_at)}</dd>
          </div>
          <div>
            <dt className="text-muted-foreground">{t("adminUsers.onboarding")}</dt>
            <dd>{date(u.onboarding_completed_at)}</dd>
          </div>
          <div>
            <dt className="text-muted-foreground">{t("adminUsers.marketing")}</dt>
            <dd>{u.marketing_consent ? t("adminUsers.yesShort") : t("adminUsers.noShort")}</dd>
          </div>
        </dl>
      </Card>

      <Card>
        <h2 className="text-lg font-semibold">{t("adminUsers.targets")}</h2>
        {u.targets.length === 0 ? (
          <p className="text-muted-foreground mt-2 text-sm">{t("adminUsers.noTargets")}</p>
        ) : (
          <ul className="mt-3 space-y-2 text-sm">
            {u.targets.map((tg) => (
              <li key={tg.exam} className="flex flex-wrap items-center gap-2">
                <span className="font-medium">{tg.name}</span>
                {tg.is_primary && <Badge tone="accent">{t("app.primary")}</Badge>}
                {tg.level && <Badge>{t(`onboarding.levels.${tg.level}`)}</Badge>}
                {tg.weekly_hours && (
                  <Badge>{t("onboarding.hours", { count: tg.weekly_hours })}</Badge>
                )}
              </li>
            ))}
          </ul>
        )}
      </Card>

      {/* Accesos: lo que tiene ahora */}
      <Card className="space-y-4" data-testid="user-access">
        <h2 className="text-lg font-semibold">{ti("accessTitle")}</h2>
        {activeSubs.length === 0 && activeGrants.length === 0 ? (
          <p className="text-muted-foreground text-sm">{ti("noAccess")}</p>
        ) : (
          <ul className="divide-border divide-y text-sm">
            {activeSubs.map((s) => (
              <li key={s.id} className="flex flex-wrap items-center justify-between gap-3 py-2">
                <div className="space-y-0.5">
                  <p className="font-medium">
                    {s.product} <Badge tone="accent">{ti("premium")}</Badge>{" "}
                    <Badge>{ti(`providers.${s.provider}`)}</Badge>
                  </p>
                  <p className="text-muted-foreground text-xs">
                    {s.current_period_end
                      ? ti(
                          s.cancel_at_period_end || s.provider === "none" ? "endsOn" : "renewsOn",
                          {
                            date: date(s.current_period_end),
                          },
                        )
                      : ti("noEnd")}
                  </p>
                </div>
                {s.provider === "none" ? (
                  <form action={endUserPremiumAction}>
                    <input type="hidden" name="id" value={s.id} />
                    <Button type="submit" size="sm" variant="outline">
                      {ti("endPremium")}
                    </Button>
                  </form>
                ) : (
                  <span className="text-muted-foreground text-xs">{ti("stripeManaged")}</span>
                )}
              </li>
            ))}
            {activeGrants.map((g) => (
              <li key={g.id} className="flex flex-wrap items-center justify-between gap-3 py-2">
                <div className="space-y-0.5">
                  <p className="font-medium">
                    {g.product} <Badge>{ti(`sources.${g.source}`)}</Badge>
                    {g.attempts ? (
                      <Badge tone="accent">{ti("attempts", { count: g.attempts })}</Badge>
                    ) : null}
                  </p>
                  <p className="text-muted-foreground text-xs">
                    {ti("since", { date: date(g.starts_at) })}
                    {" · "}
                    {g.ends_at ? ti("endsOn", { date: date(g.ends_at) }) : ti("noEnd")}
                    {g.note ? ` · ${g.note}` : ""}
                  </p>
                </div>
                <form action={revokeUserGrantAction}>
                  <input type="hidden" name="id" value={g.id} />
                  <Button type="submit" size="sm" variant="outline">
                    {ti("revoke")}
                  </Button>
                </form>
              </li>
            ))}
          </ul>
        )}
        <details className="text-sm">
          <summary className="text-accent cursor-pointer font-medium">{ti("historyTitle")}</summary>
          {ins.orders.length === 0 &&
          ins.subscriptions.length === activeSubs.length &&
          ins.grants.length === activeGrants.length ? (
            <p className="text-muted-foreground mt-2">{ti("noHistory")}</p>
          ) : (
            <ul className="divide-border mt-2 divide-y">
              {ins.orders.map((o) => (
                <li key={o.id} className="flex flex-wrap justify-between gap-2 py-2">
                  <span>
                    {o.products ?? "—"} · {formatPrice(o.total_cents, locale)}{" "}
                    <Badge>{ti(`orderStatus.${o.status}`)}</Badge>
                  </span>
                  <time className="text-muted-foreground">{date(o.created_at)}</time>
                </li>
              ))}
              {ins.subscriptions
                .filter((s) => !s.active)
                .map((s) => (
                  <li key={s.id} className="flex flex-wrap justify-between gap-2 py-2">
                    <span>
                      {s.product} <Badge>{ti(`subStatus.${s.status}`)}</Badge>
                    </span>
                    <time className="text-muted-foreground">{date(s.created_at)}</time>
                  </li>
                ))}
              {ins.grants
                .filter((g) => g.status !== "active")
                .map((g) => (
                  <li key={g.id} className="flex flex-wrap justify-between gap-2 py-2">
                    <span>
                      {g.product} <Badge>{ti(`grantStatus.${g.status}`)}</Badge>
                    </span>
                    <time className="text-muted-foreground">{date(g.created_at)}</time>
                  </li>
                ))}
            </ul>
          )}
        </details>
      </Card>

      <Card className="space-y-3">
        <h2 className="text-lg font-semibold">{ti("grantTitle")}</h2>
        <UserGrantForm user={u.id} products={grantable} />
      </Card>

      <Card className="space-y-3" data-testid="user-promo">
        <h2 className="text-lg font-semibold">{t("adminUsers.promo.title")}</h2>
        {ins.promo_codes.length > 0 && (
          <ul className="divide-border divide-y text-sm">
            {ins.promo_codes.map((c) => (
              <li key={c.id} className="flex flex-wrap justify-between gap-2 py-2">
                <span>
                  <code className="bg-surface-2 rounded px-1.5 py-0.5 font-mono">{c.code}</code>{" "}
                  {c.percent_off !== null
                    ? `−${Number(c.percent_off)} %`
                    : `−${formatPrice(c.amount_off_cents ?? 0, locale)}`}{" "}
                  · {t(`adminUsers.promo.durations.${c.duration}`)}
                  {c.duration_in_months ? ` (${c.duration_in_months})` : ""}
                  {c.provider === "stripe_test" ? ` · ${ti("providers.stripe_test")}` : ""}
                </span>
                <span className="text-muted-foreground">
                  {c.expires_at
                    ? t("adminUsers.promo.expires", { date: date(c.expires_at) })
                    : date(c.created_at)}
                </span>
              </li>
            ))}
          </ul>
        )}
        {billing.enabled ? (
          <PromoCodeForm user={u.id} live={billing.provider === "stripe"} />
        ) : (
          <p className="text-muted-foreground text-sm">{t("adminUsers.promo.errors.billingOff")}</p>
        )}
      </Card>

      {/* Tiempo dentro y entradas */}
      <div className="grid gap-6 lg:grid-cols-2">
        <Card className="space-y-3" data-testid="user-presence">
          <h2 className="text-lg font-semibold">{ti("timeTitle")}</h2>
          <dl className="grid grid-cols-3 gap-3 text-center">
            {(
              [
                ["today", ins.presence.today_seconds],
                ["last7", ins.presence.last7_seconds],
                ["last30", ins.presence.last30_seconds],
              ] as const
            ).map(([k, v]) => (
              <div key={k} className="bg-surface rounded-lg p-3">
                <dt className="text-muted-foreground text-xs">{ti(k)}</dt>
                <dd className="text-lg font-semibold">{formatDuration(v)}</dd>
              </div>
            ))}
          </dl>
          {ins.presence.days.length === 0 ? (
            <p className="text-muted-foreground text-sm">{ti("noTime")}</p>
          ) : (
            <ul className="divide-border divide-y text-sm">
              {ins.presence.days.slice(0, 10).map((d) => (
                <li key={d.day} className="flex justify-between gap-3 py-1.5">
                  <span>{day(d.day)}</span>
                  <span className="text-muted-foreground">
                    {time(d.first_seen)}–{time(d.last_seen)} · {formatDuration(d.seconds)}
                  </span>
                </li>
              ))}
            </ul>
          )}
          <p className="text-muted-foreground text-xs">{ti("timeHelp")}</p>
        </Card>

        <Card className="space-y-3" data-testid="user-sessions">
          <h2 className="text-lg font-semibold">{ti("sessionsTitle")}</h2>
          {ins.sessions.length === 0 ? (
            <p className="text-muted-foreground text-sm">{ti("noSessions")}</p>
          ) : (
            <ul className="divide-border divide-y text-sm">
              {ins.sessions.slice(0, 15).map((s, i) => (
                <li key={i} className="flex justify-between gap-3 py-1.5">
                  <span>{ti(`authActions.${s.action}`)}</span>
                  <time dateTime={s.created_at} className="text-muted-foreground">
                    {date(s.created_at)}
                  </time>
                </li>
              ))}
            </ul>
          )}
          <p className="text-muted-foreground text-xs">{ti("sessionsHelp")}</p>
        </Card>
      </div>

      {/* Estudio */}
      <Card className="space-y-3" data-testid="user-study">
        <h2 className="text-lg font-semibold">{ti("studyTitle")}</h2>
        <dl className="grid grid-cols-2 gap-3 text-center sm:grid-cols-4">
          <div className="bg-surface rounded-lg p-3">
            <dt className="text-muted-foreground text-xs">{ti("tests")}</dt>
            <dd className="text-lg font-semibold">{ins.study.practice_count}</dd>
          </div>
          <div className="bg-surface rounded-lg p-3">
            <dt className="text-muted-foreground text-xs">{ti("mocks")}</dt>
            <dd className="text-lg font-semibold">{ins.study.mock_count}</dd>
          </div>
          <div className="bg-surface rounded-lg p-3">
            <dt className="text-muted-foreground text-xs">{ti("answered")}</dt>
            <dd className="text-lg font-semibold">
              {ins.study.answered}
              {ins.study.answered > 0 && (
                <span className="text-muted-foreground text-xs font-normal">
                  {" "}
                  ({Math.round((ins.study.correct / ins.study.answered) * 100)} %)
                </span>
              )}
            </dd>
          </div>
          <div className="bg-surface rounded-lg p-3">
            <dt className="text-muted-foreground text-xs">{ti("answerTime")}</dt>
            <dd className="text-lg font-semibold">{formatDuration(ins.study.answer_seconds)}</dd>
          </div>
        </dl>
        {ins.study.recent.length === 0 ? (
          <p className="text-muted-foreground text-sm">{ti("noStudy")}</p>
        ) : (
          <ul className="divide-border divide-y text-sm">
            {ins.study.recent.map((r, i) => (
              <li key={i} className="flex flex-wrap justify-between gap-2 py-2">
                <span>
                  <Badge>{ti(`studyKinds.${r.kind === "mock" ? "mock" : r.mode}`)}</Badge>{" "}
                  {r.title ?? (r.item_type && r.item_type !== "question" ? r.item_type : "—")}
                  {" · "}
                  {r.kind === "mock" && r.mark !== null
                    ? ti("mark", { mark: Number(r.mark), max: Number(r.max_mark ?? 10) })
                    : ti("score", { correct: r.correct, total: r.total })}
                  {r.status === "active" ? ` · ${ti("inProgress")}` : ""}
                </span>
                <time dateTime={r.started_at} className="text-muted-foreground">
                  {date(r.started_at)}
                </time>
              </li>
            ))}
          </ul>
        )}
      </Card>

      <Card>
        <h2 className="text-lg font-semibold">{t("adminUsers.activity")}</h2>
        {u.activity.length === 0 ? (
          <p className="text-muted-foreground mt-2 text-sm">{t("app.activityEmpty")}</p>
        ) : (
          <ul className="divide-border mt-3 divide-y text-sm">
            {u.activity.map((a, i) => {
              const key = `app.activityKinds.${a.kind.replace(".", "_")}`;
              return (
                <li key={i} className="flex justify-between gap-4 py-2">
                  <span>{t.has(key) ? t(key) : a.kind}</span>
                  <time dateTime={a.created_at} className="text-muted-foreground">
                    {date(a.created_at)}
                  </time>
                </li>
              );
            })}
          </ul>
        )}
      </Card>

      {u.role !== "owner" && <UserStatusForm id={u.id} status={u.status} />}
    </div>
  );
}
