import { getLocale, getTranslations } from "next-intl/server";
import { Link } from "@/i18n/navigation";
import { Badge } from "@/components/ui/card";
import { localized, type ExamBodyCard } from "@/lib/catalog/queries";

const toneFor = { available: "success", partial: "accent", coming_soon: "warning" } as const;

export async function ExamCard({ exam }: { exam: ExamBodyCard }) {
  const locale = await getLocale();
  const t = await getTranslations();
  return (
    <Link
      href={`/oposiciones/${exam.slug}`}
      className="group border-border bg-background hover:border-accent flex h-full flex-col gap-3 rounded-2xl border p-5 transition-colors"
      data-testid="exam-card"
    >
      <div className="flex flex-wrap items-center gap-2">
        <Badge tone={toneFor[exam.availability]}>{t(`availability.${exam.availability}`)}</Badge>
        <Badge>{t(`category.${exam.category}`)}</Badge>
      </div>
      <h3 className="group-hover:text-accent text-base font-semibold">
        {localized(locale, exam.name, exam.name_ca)}
      </h3>
      <p className="text-muted-foreground text-sm">
        {localized(locale, exam.short_description, exam.short_description_ca)}
      </p>
      {exam.organization && (
        <p className="text-muted-foreground mt-auto text-xs">
          {exam.organization.name} · {t(`scope.${exam.organization.scope}`)}
        </p>
      )}
    </Link>
  );
}
