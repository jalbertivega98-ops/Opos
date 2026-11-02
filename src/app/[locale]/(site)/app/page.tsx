import type { Metadata } from "next";
import { getFormatter, getTranslations, setRequestLocale } from "next-intl/server";
import { Activity, CalendarCheck, Flame, Target, TrendingUp } from "lucide-react";
import { Link } from "@/i18n/navigation";
import { Button } from "@/components/ui/button";
import { Alert } from "@/components/ui/form";
import { Badge, Card, EmptyState } from "@/components/ui/card";
import { requireUser } from "@/lib/auth/session";
import { createClient } from "@/lib/supabase/server";
import { localized } from "@/lib/catalog/queries";

export async function generateMetadata({ params }: PageProps<"/[locale]/app">): Promise<Metadata> {
  const { locale } = await params;
  const t = await getTranslations({ locale, namespace: "nav" });
  return { title: t("dashboard"), robots: { index: false } };
}

type Target = {
  is_primary: boolean;
  follow_only: boolean;
  exam: { slug: string; name: string; name_ca: string | null; availability: string } | null;
};

export default async function Dashboard({ params, searchParams }: PageProps<"/[locale]/app">) {
  const { locale } = await params;
  setRequestLocale(locale);
  const sp = await searchParams;
  const { user, profile } = await requireUser(locale);
  const t = await getTranslations();
  const format = await getFormatter();
  const supabase = await createClient();

  const [{ data: targets }, { data: activity }] = await Promise.all([
    supabase
      .from("user_exam_targets")
      .select("is_primary, follow_only, exam:exam_bodies(slug, name, name_ca, availability)")
      .eq("user_id", user.id)
      .order("is_primary", { ascending: false })
      .returns<Target[]>(),
    supabase
      .from("activity_events")
      .select("id, kind, created_at")
      .eq("user_id", user.id)
      .order("created_at", { ascending: false })
      .limit(8),
  ]);

  const name = profile.display_name;
  const stats = [
    { icon: Flame, label: t("app.streak") },
    { icon: Target, label: t("app.accuracy") },
    { icon: TrendingUp, label: t("app.tests") },
  ];

  return (
    <div className="space-y-8">
      <div>
        <h1 className="text-3xl font-bold">
          {name ? t("app.greeting", { name }) : t("app.greetingAnon")}
        </h1>
        <p className="text-muted-foreground mt-1">{t("app.subtitle")}</p>
      </div>

      {sp.pw === "updated" && <Alert tone="success">{t("app.passwordUpdated")}</Alert>}
      {sp.welcome === "1" && <Alert tone="success">{t("onboarding.saved")}</Alert>}

      {!profile.onboarding_completed_at && (
        <Card className="border-accent bg-accent-soft flex flex-col gap-4 sm:flex-row sm:items-center sm:justify-between">
          <div>
            <h2 className="text-lg font-semibold">{t("app.onboardingTitle")}</h2>
            <p className="text-muted-foreground text-sm">{t("app.onboardingBody")}</p>
          </div>
          <Button asChild variant="accent">
            <Link href="/app/onboarding">{t("app.onboardingCta")}</Link>
          </Button>
        </Card>
      )}

      <div className="grid gap-4 lg:grid-cols-3">
        <Card className="lg:col-span-2">
          <h2 className="flex items-center gap-2 text-lg font-semibold">
            <CalendarCheck className="text-accent size-5" aria-hidden /> {t("app.plan")}
          </h2>
          <p className="text-muted-foreground mt-3 text-sm">{t("app.planEmpty")}</p>
        </Card>
        <Card>
          <h2 className="text-lg font-semibold">{t("app.myExams")}</h2>
          {targets && targets.length > 0 ? (
            <ul className="mt-3 space-y-2">
              {targets.map((tg) =>
                tg.exam ? (
                  <li key={tg.exam.slug} className="flex flex-wrap items-center gap-2 text-sm">
                    <Link
                      href={`/oposiciones/${tg.exam.slug}`}
                      className="font-medium hover:underline"
                    >
                      {localized(locale, tg.exam.name, tg.exam.name_ca)}
                    </Link>
                    {tg.is_primary && <Badge tone="accent">{t("app.primary")}</Badge>}
                    {tg.follow_only && <Badge tone="warning">{t("app.following")}</Badge>}
                  </li>
                ) : null,
              )}
            </ul>
          ) : (
            <p className="text-muted-foreground mt-3 text-sm">{t("app.noData")}</p>
          )}
          <Button asChild variant="outline" size="sm" className="mt-4">
            <Link href="/oposiciones">{t("app.addExam")}</Link>
          </Button>
        </Card>
      </div>

      <section aria-labelledby="progress-title">
        <h2 id="progress-title" className="text-lg font-semibold">
          {t("app.progress")}
        </h2>
        <div className="mt-3 grid gap-4 sm:grid-cols-3">
          {stats.map(({ icon: Icon, label }) => (
            <Card key={label} className="flex items-center gap-4">
              <span className="bg-surface-2 text-muted-foreground inline-flex size-10 items-center justify-center rounded-lg">
                <Icon className="size-5" aria-hidden />
              </span>
              <div>
                <p className="text-muted-foreground text-sm">{label}</p>
                <p className="font-semibold">{t("app.noData")}</p>
              </div>
            </Card>
          ))}
        </div>
      </section>

      <section aria-labelledby="activity-title">
        <h2 id="activity-title" className="flex items-center gap-2 text-lg font-semibold">
          <Activity className="text-accent size-5" aria-hidden /> {t("app.activity")}
        </h2>
        <div className="mt-3">
          {activity && activity.length > 0 ? (
            <ul className="divide-border border-border divide-y rounded-xl border">
              {activity.map((a) => (
                <li key={a.id} className="flex justify-between gap-4 px-4 py-3 text-sm">
                  <span>
                    {t.has(`app.activityKinds.${a.kind.replace(".", "_")}`)
                      ? t(`app.activityKinds.${a.kind.replace(".", "_")}`)
                      : a.kind}
                  </span>
                  <time dateTime={a.created_at} className="text-muted-foreground">
                    {format.relativeTime(new Date(a.created_at))}
                  </time>
                </li>
              ))}
            </ul>
          ) : (
            <EmptyState title={t("app.activityEmpty")} />
          )}
        </div>
      </section>
    </div>
  );
}
