import type { Metadata } from "next";
import { notFound } from "next/navigation";
import { getTranslations, setRequestLocale } from "next-intl/server";
import { ArrowLeft } from "lucide-react";
import { Link } from "@/i18n/navigation";
import { Button } from "@/components/ui/button";
import { TopicNoteView } from "@/components/notes/topic-note-view";
import { requireUser } from "@/lib/auth/session";
import { localized } from "@/lib/catalog/queries";
import { getTopicNote } from "@/lib/learning/notes-queries";

const SLUG = /^[a-z0-9-]{2,120}$/;

export async function generateMetadata({
  params,
}: PageProps<"/[locale]/app/temario/[slug]">): Promise<Metadata> {
  const { locale } = await params;
  const t = await getTranslations({ locale, namespace: "notes" });
  return { title: t("title"), robots: { index: false } };
}

export default async function TopicNotePage({ params }: PageProps<"/[locale]/app/temario/[slug]">) {
  const { locale, slug } = await params;
  setRequestLocale(locale);
  await requireUser(locale, `/app/temario/${slug}`);
  if (!SLUG.test(slug)) notFound();
  const note = await getTopicNote(slug);
  // RLS: el alumnado solo lee fichas publicadas; el staff ve también borradores aquí
  if (!note || note.status !== "published") notFound();
  const t = await getTranslations("notes");
  return (
    <div className="space-y-6">
      <div className="space-y-2">
        <Button asChild variant="ghost" size="sm" className="-ml-2">
          <Link href="/app/temario">
            <ArrowLeft className="size-4" aria-hidden />
            {t("back")}
          </Link>
        </Button>
        <h1 className="text-3xl font-bold">{localized(locale, note.title, note.titleCa)}</h1>
        <p className="text-muted-foreground text-sm">{t("literalNotice")}</p>
      </div>
      <TopicNoteView note={note} />
      <div className="flex flex-wrap gap-2">
        <Button asChild variant="accent">
          <Link href="/app/productos">{t("practiceCta")}</Link>
        </Button>
        <Button asChild variant="outline">
          <Link href="/app/plan">{t("planCta")}</Link>
        </Button>
      </div>
    </div>
  );
}
