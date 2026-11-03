import type { Metadata } from "next";
import { notFound } from "next/navigation";
import { getTranslations, setRequestLocale } from "next-intl/server";
import { z } from "zod";
import { Card } from "@/components/ui/card";
import { Alert } from "@/components/ui/form";
import { ProductForm, ProductQuestionsForm } from "@/components/admin/store-forms";
import { examBodyOptions } from "@/lib/admin/content/queries";
import { getProduct, reviewedQuestions } from "@/lib/store/queries";

export const metadata: Metadata = { title: "Admin · Producto", robots: { index: false } };

export default async function ProductPage({
  params,
  searchParams,
}: PageProps<"/[locale]/admin/productos/[id]">) {
  const { locale, id } = await params;
  setRequestLocale(locale);
  if (!z.uuid().safeParse(id).success) notFound();
  const sp = await searchParams;
  const [data, exams] = await Promise.all([getProduct(id), examBodyOptions()]);
  if (!data) notFound();
  const { product: p, questionIds } = data;
  const t = await getTranslations("store");
  const usesQuestions = p.type === "question_pack" || p.type === "mock_exam" || p.type === "pdf";
  const questions = usesQuestions ? await reviewedQuestions(p.is_test) : [];
  const price = p.prices.find((x) => x.active);
  return (
    <div className="mx-auto max-w-3xl space-y-6 px-4 py-8">
      <h1 className="text-3xl font-bold">{t("admin.edit")}</h1>
      {sp.saved === "1" && <Alert tone="success">{t("admin.saved")}</Alert>}
      <Card>
        <ProductForm
          key={p.updated_at}
          exams={exams}
          initial={{
            id: p.id,
            slug: p.slug,
            type: p.type,
            status: p.status,
            title: p.title,
            title_ca: p.title_ca ?? "",
            description: p.description ?? "",
            description_ca: p.description_ca ?? "",
            exam_body_id: p.exam_body_id ?? "",
            is_free: p.is_free,
            included_in_premium: p.included_in_premium,
            price: price ? (price.amount_cents / 100).toFixed(2) : "",
            interval: price?.billing_interval ?? "once",
          }}
        />
      </Card>
      {usesQuestions && (
        <Card className="space-y-3">
          <h2 className="text-lg font-semibold">{t("admin.itemsTitle")}</h2>
          <p className="text-muted-foreground text-sm">{t("admin.itemsHelp")}</p>
          <ProductQuestionsForm productId={p.id} questions={questions} selected={questionIds} />
        </Card>
      )}
    </div>
  );
}
