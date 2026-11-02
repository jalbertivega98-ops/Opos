import type { Metadata } from "next";
import { getTranslations, setRequestLocale } from "next-intl/server";
import { Card } from "@/components/ui/card";
import { QuestionForm } from "@/components/admin/question-form";
import { examBodyOptions } from "@/lib/admin/content/queries";

export const metadata: Metadata = { title: "Admin · Nueva pregunta", robots: { index: false } };

export default async function NewQuestionPage({
  params,
}: PageProps<"/[locale]/admin/preguntas/nueva">) {
  const { locale } = await params;
  setRequestLocale(locale);
  const t = await getTranslations("adminContent");
  const exams = await examBodyOptions();
  return (
    <div className="mx-auto max-w-3xl space-y-6 px-4 py-8">
      <h1 className="text-3xl font-bold">{t("new")}</h1>
      <Card>
        <QuestionForm
          exams={exams}
          initial={{
            stem: "",
            explanation: "",
            category: "",
            difficulty: 3,
            locale: locale === "ca" ? "ca" : "es",
            is_free: false,
            ai_generated: false,
            options: [],
            correct: 0,
            exam_body_ids: [],
          }}
        />
      </Card>
    </div>
  );
}
