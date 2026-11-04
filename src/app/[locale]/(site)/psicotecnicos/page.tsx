import type { Metadata } from "next";
import { randomInt } from "node:crypto";
import { getTranslations, setRequestLocale } from "next-intl/server";
import { ArrowRight } from "lucide-react";
import { Link } from "@/i18n/navigation";
import { PsychoTrainer } from "@/components/psycho/trainer";
import { getSession } from "@/lib/auth/session";
import { availableTypes, difficultyPlan, generateItem } from "@/lib/learning/psycho/registry";
import { toPublicItem, type PsychoType } from "@/lib/learning/psycho/types";
import { psychoGuideByType, tr } from "@/lib/seo/psycho-guides";
import { pageMetadata } from "@/lib/seo/site";
import { cn } from "@/lib/utils";

export async function generateMetadata({
  params,
  searchParams,
}: PageProps<"/[locale]/psicotecnicos">): Promise<Metadata> {
  const { locale } = await params;
  const { tipo } = await searchParams;
  const t = await getTranslations({ locale, namespace: "seo.psycho" });
  // ?tipo=… sigue funcionando, pero su versión canónica es la página del tipo.
  const guide = typeof tipo === "string" ? psychoGuideByType(tipo) : undefined;
  const meta = pageMetadata({
    path: "/psicotecnicos",
    locale,
    title: t("title"),
    description: t("description"),
    absoluteTitle: false,
  });
  if (guide && guide.type !== "series") {
    const path = `/psicotecnicos/${guide.slug}`;
    return { ...meta, alternates: { canonical: locale === "ca" ? `/ca${path}` : path } };
  }
  return meta;
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
  const ts = await getTranslations("seo.psychoType");
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

      {/* Guías por tipo: contenido rastreable y enlaces internos (ADR-025). */}
      <section aria-labelledby="psycho-types" className="mt-14">
        <h2 id="psycho-types" className="text-2xl font-bold">
          {ts("allTypes")}
        </h2>
        <ul className="mt-4 grid gap-3 sm:grid-cols-2">
          {types.map((ty) => {
            const g = psychoGuideByType(ty);
            if (!g) return null;
            return (
              <li key={ty}>
                <Link
                  href={`/psicotecnicos/${g.slug}`}
                  className="group border-border hover:border-accent flex h-full flex-col gap-1 rounded-2xl border p-4"
                >
                  <span className="group-hover:text-accent inline-flex items-center gap-1 font-semibold">
                    {tr(g.title, locale)} <ArrowRight className="size-4" aria-hidden />
                  </span>
                  <span className="text-muted-foreground text-sm">
                    {t(`types.${ty}.description`)}
                  </span>
                </Link>
              </li>
            );
          })}
        </ul>
      </section>
    </div>
  );
}
