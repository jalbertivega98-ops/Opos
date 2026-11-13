import type { Metadata } from "next";
import { getTranslations, setRequestLocale } from "next-intl/server";
import { ChevronRight, Lock, Play } from "lucide-react";
import { Link } from "@/i18n/navigation";
import { Button } from "@/components/ui/button";
import { EmptyState } from "@/components/ui/card";
import { requireUser } from "@/lib/auth/session";
import { localized } from "@/lib/catalog/queries";
import { myExamNotes } from "@/lib/learning/notes-queries";
import { myOpenTopics } from "@/lib/learning/plan-queries";
import { Alert } from "@/components/ui/form";
import { TopicTestButton } from "@/components/plan/topic-test-button";

export async function generateMetadata({
  params,
}: PageProps<"/[locale]/app/temario">): Promise<Metadata> {
  const { locale } = await params;
  const t = await getTranslations({ locale, namespace: "notes" });
  return { title: t("title"), robots: { index: false } };
}

/** Temario: fichas de estudio publicadas de la oposición principal (CNT-011). */
export default async function SyllabusPage({
  params,
  searchParams,
}: PageProps<"/[locale]/app/temario">) {
  const { locale } = await params;
  const sp = await searchParams;
  setRequestLocale(locale);
  await requireUser(locale, "/app/temario");
  const t = await getTranslations("notes");
  const { exam, notes } = await myExamNotes();
  if (!exam || notes.length === 0) {
    return (
      <EmptyState
        title={t("emptyTitle")}
        description={t(exam ? "empty" : "emptyNoTarget")}
        action={
          exam ? undefined : (
            <Button asChild variant="accent">
              <Link href="/app/onboarding">{t("emptyCta")}</Link>
            </Button>
          )
        }
      />
    );
  }
  const open = new Set(await myOpenTopics(exam.slug));
  const tp = await getTranslations("plan");
  const errorKey =
    sp.error === "access" || sp.error === "start" || sp.error === "invalid" ? sp.error : null;
  // Agrupa por àmbit (letra del código del tema: «A.1 …» → A)
  const groups = new Map<string, typeof notes>();
  for (const n of notes) {
    const key = /^([A-Z])\.\d/.exec(n.title)?.[1] ?? "";
    groups.set(key, [...(groups.get(key) ?? []), n]);
  }
  return (
    <div className="space-y-6">
      <div>
        <h1 className="text-3xl font-bold">{t("title")}</h1>
        <p className="text-muted-foreground mt-1">
          {t("subtitle", { exam: localized(locale, exam.name, exam.name_ca) })}
        </p>
      </div>
      {errorKey && <Alert tone="error">{tp(`errors.${errorKey}`)}</Alert>}
      {[...groups.entries()].map(([key, items]) => (
        <section key={key || "other"} className="space-y-3">
          {key && (
            <h2 className="text-lg font-semibold">
              {/* Mossos agrupa por «àmbit» (A, B, C); las demás, por bloque del programa (I, II) */}
              {t(exam.slug.startsWith("mossos") ? "area" : "block", { area: key })}
            </h2>
          )}
          <ul className="grid gap-2 sm:grid-cols-2" data-testid="notes-list">
            {items.map((n) => (
              <li
                key={n.slug}
                className="border-border flex min-h-14 items-center gap-2 rounded-xl border pr-2 text-sm"
              >
                <Link
                  href={`/app/temario/${n.slug}`}
                  className="hover:bg-surface flex min-h-14 flex-1 items-center justify-between gap-3 rounded-l-xl px-4 py-3 transition-colors"
                >
                  <span>
                    <span className="block font-medium">
                      {localized(locale, n.title, n.titleCa)}
                    </span>
                    <span className="text-muted-foreground text-xs">
                      {t("ideasCount", { count: n.keyIdeas })}
                      {n.pageFrom && n.pageTo
                        ? ` · ${t("pages", { from: n.pageFrom, to: n.pageTo })}`
                        : ""}
                    </span>
                  </span>
                  <ChevronRight className="text-muted-foreground size-4 shrink-0" aria-hidden />
                </Link>
                {open.has(n.slug) ? (
                  <TopicTestButton topic={n.slug} variant="outline">
                    <Play aria-hidden />
                    {tp("test")}
                  </TopicTestButton>
                ) : (
                  <Link
                    href={`/oposiciones/${exam.slug}`}
                    className="text-muted-foreground hover:text-foreground inline-flex min-h-9 items-center gap-1 px-2 text-xs font-semibold"
                  >
                    <Lock className="size-3" aria-hidden />
                    {tp("premium")}
                  </Link>
                )}
              </li>
            ))}
          </ul>
        </section>
      ))}
      <p className="text-muted-foreground text-xs">{t("literalNotice")}</p>
    </div>
  );
}
