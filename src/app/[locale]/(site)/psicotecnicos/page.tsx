import type { Metadata } from "next";
import { randomInt } from "node:crypto";
import { getTranslations, setRequestLocale } from "next-intl/server";
import { SeriesTrainer } from "@/components/series-trainer";
import { generateSeries, toPublic, type Difficulty } from "@/lib/learning/psycho/series";

export async function generateMetadata({
  params,
}: PageProps<"/[locale]/psicotecnicos">): Promise<Metadata> {
  const { locale } = await params;
  const t = await getTranslations({ locale, namespace: "psycho" });
  return { title: t("title"), description: t("subtitle") };
}

const PLAN: Difficulty[] = [1, 1, 2, 2, 3, 3, 4, 4, 5, 5];

export default async function PsychoDemoPage({ params }: PageProps<"/[locale]/psicotecnicos">) {
  const { locale } = await params;
  setRequestLocale(locale);
  const t = await getTranslations("psycho");
  // Semillas aleatorias en servidor; al cliente solo llega la vista pública (sin respuesta).
  const items = PLAN.map((d) => toPublic(generateSeries(randomInt(0, 2 ** 31), d)));
  return (
    <div className="mx-auto max-w-2xl px-4 py-10 sm:py-14">
      <h1 className="text-3xl font-bold">{t("title")}</h1>
      <p className="text-muted-foreground mt-2">{t("subtitle")}</p>
      <div className="mt-8">
        <SeriesTrainer items={items} />
      </div>
    </div>
  );
}
