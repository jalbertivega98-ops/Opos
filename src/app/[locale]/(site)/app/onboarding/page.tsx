import type { Metadata } from "next";
import { getTranslations, setRequestLocale } from "next-intl/server";
import { OnboardingForm } from "@/components/onboarding-form";
import { listExamBodies, localized } from "@/lib/catalog/queries";

export async function generateMetadata({
  params,
}: PageProps<"/[locale]/app/onboarding">): Promise<Metadata> {
  const { locale } = await params;
  const t = await getTranslations({ locale, namespace: "onboarding" });
  return { title: t("title"), robots: { index: false } };
}

export default async function OnboardingPage({
  params,
  searchParams,
}: PageProps<"/[locale]/app/onboarding">) {
  const { locale } = await params;
  setRequestLocale(locale);
  const { exam } = await searchParams;
  const t = await getTranslations();
  const exams = await listExamBodies({}, 500);
  const options = exams.map((e) => ({
    slug: e.slug,
    label: localized(locale, e.name, e.name_ca),
    availability: e.availability,
    group: t(`category.${e.category}`),
  }));
  const initialExam =
    typeof exam === "string" && options.some((o) => o.slug === exam) ? exam : undefined;
  return (
    <div className="mx-auto max-w-2xl">
      <h1 className="text-3xl font-bold">{t("onboarding.title")}</h1>
      <div className="mt-8">
        <OnboardingForm exams={options} initialExam={initialExam} />
      </div>
    </div>
  );
}
