import type { Metadata } from "next";
import { randomInt } from "node:crypto";
import { getTranslations, setRequestLocale } from "next-intl/server";
import { Link } from "@/i18n/navigation";
import { PsychoTrainer } from "@/components/psycho/trainer";
import { getSession } from "@/lib/auth/session";
import { availableTypes, difficultyPlan, generateItem } from "@/lib/learning/psycho/registry";
import { toPublicItem, type PsychoType } from "@/lib/learning/psycho/types";
import { cn } from "@/lib/utils";

export async function generateMetadata({
  params,
}: PageProps<"/[locale]/psicotecnicos">): Promise<Metadata> {
  const { locale } = await params;
  const t = await getTranslations({ locale, namespace: "psycho" });
  return { title: t("title"), description: t("subtitle") };
}

const DEMO_SIZE = 10;

export default async function PsychoDemoPage({
  params,
  searchParams,
}: PageProps<"/[locale]/psicotecnicos">) {
  const { locale } = await params;
  setRequestLocale(locale);
  const { tipo } = await searchParams;
  const t = await getTranslations("psycho");
  const { user } = await getSession();
  const types = availableTypes();
  const type: PsychoType = types.includes(tipo as PsychoType) ? (tipo as PsychoType) : "series";

  // Semillas aleatorias en servidor; al cliente solo llega la vista pública (sin respuesta).
  const items = difficultyPlan(DEMO_SIZE).map((d) =>
    toPublicItem(generateItem(type, randomInt(0, 2 ** 32), d)),
  );
  return (
    <div className="mx-auto max-w-2xl px-4 py-10 sm:py-14">
      <h1 className="text-3xl font-bold">{t("title")}</h1>
      <p className="text-muted-foreground mt-2">{t("subtitle")}</p>
      {types.length > 1 && (
        <nav aria-label={t("typesLabel")} className="mt-6 flex flex-wrap gap-2">
          {types.map((ty) => (
            <Link
              key={ty}
              href={ty === "series" ? "/psicotecnicos" : `/psicotecnicos?tipo=${ty}`}
              aria-current={ty === type ? "page" : undefined}
              className={cn(
                "border-border rounded-full border px-3 py-1 text-sm",
                ty === type ? "bg-accent text-accent-foreground border-accent" : "hover:bg-surface",
              )}
            >
              {t(`types.${ty}.name`)}
            </Link>
          ))}
        </nav>
      )}
      <div className="mt-8">
        <PsychoTrainer key={type} items={items} mode={{ kind: "demo", signedIn: !!user }} />
      </div>
    </div>
  );
}
