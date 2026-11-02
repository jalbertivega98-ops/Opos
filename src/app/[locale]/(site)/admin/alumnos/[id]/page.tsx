import type { Metadata } from "next";
import { notFound } from "next/navigation";
import { getFormatter, getTranslations, setRequestLocale } from "next-intl/server";
import { ArrowLeft } from "lucide-react";
import { Link } from "@/i18n/navigation";
import { Badge, Card } from "@/components/ui/card";
import { Alert } from "@/components/ui/form";
import { UserStatusForm } from "@/components/admin-user-status";
import { getUser } from "@/lib/admin/users";

export const metadata: Metadata = { title: "Alumno", robots: { index: false } };

export default async function AdminUserPage({ params }: PageProps<"/[locale]/admin/alumnos/[id]">) {
  const { locale, id } = await params;
  setRequestLocale(locale);
  const u = await getUser(id);
  if (!u) notFound();
  const t = await getTranslations();
  const format = await getFormatter();
  const date = (v: string | null) =>
    v ? format.dateTime(new Date(v), { dateStyle: "medium", timeStyle: "short" }) : "—";

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
