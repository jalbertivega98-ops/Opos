import type { Metadata } from "next";
import { getTranslations, setRequestLocale } from "next-intl/server";
import { Card } from "@/components/ui/card";
import { ImportForm } from "@/components/admin/import-form";

export const metadata: Metadata = { title: "Admin · Importar preguntas", robots: { index: false } };

const CSV_EXAMPLE = `stem,explanation,category,difficulty,locale,option_a,option_b,option_c,option_d,correct,exams
"¿Cuántos artículos tiene la Constitución española de 1978?","La Constitución tiene 169 artículos.",constitucion,2,es,150,169,180,200,B,`;

const JSON_EXAMPLE = `[
  {
    "stem": "¿Cuántos artículos tiene la Constitución española de 1978?",
    "explanation": "La Constitución tiene 169 artículos.",
    "category": "constitucion",
    "difficulty": 2,
    "locale": "es",
    "options": ["150", "169", "180", "200"],
    "correct": "B",
    "exams": []
  }
]`;

export default async function ImportPage({
  params,
}: PageProps<"/[locale]/admin/preguntas/importar">) {
  const { locale } = await params;
  setRequestLocale(locale);
  const t = await getTranslations("adminContent.importPage");
  return (
    <div className="mx-auto max-w-3xl space-y-6 px-4 py-8">
      <div>
        <h1 className="text-3xl font-bold">{t("title")}</h1>
        <p className="text-muted-foreground mt-2 text-sm">{t("intro")}</p>
      </div>
      <Card>
        <ImportForm />
      </Card>
      <Card className="space-y-3 text-sm">
        <h2 className="font-semibold">{t("csvTitle")}</h2>
        <p className="text-muted-foreground">{t("csvHelp")}</p>
        <pre className="bg-surface overflow-x-auto rounded-lg p-3 text-xs">{CSV_EXAMPLE}</pre>
        <h2 className="font-semibold">{t("jsonTitle")}</h2>
        <pre className="bg-surface overflow-x-auto rounded-lg p-3 text-xs">{JSON_EXAMPLE}</pre>
      </Card>
    </div>
  );
}
