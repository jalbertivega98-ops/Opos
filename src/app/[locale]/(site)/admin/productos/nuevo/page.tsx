import type { Metadata } from "next";
import { getTranslations, setRequestLocale } from "next-intl/server";
import { Card } from "@/components/ui/card";
import { ProductForm } from "@/components/admin/store-forms";
import { examBodyOptions } from "@/lib/admin/content/queries";

export const metadata: Metadata = { title: "Admin · Nuevo producto", robots: { index: false } };

export default async function NewProductPage({
  params,
}: PageProps<"/[locale]/admin/productos/nuevo">) {
  const { locale } = await params;
  setRequestLocale(locale);
  const t = await getTranslations("store");
  const exams = await examBodyOptions();
  return (
    <div className="mx-auto max-w-3xl space-y-6 px-4 py-8">
      <h1 className="text-3xl font-bold">{t("admin.new")}</h1>
      <Card>
        <ProductForm
          exams={exams}
          initial={{
            slug: "",
            type: "question_pack",
            status: "draft",
            title: "",
            title_ca: "",
            description: "",
            description_ca: "",
            exam_body_id: "",
            is_free: false,
            included_in_premium: true,
            price: "",
            interval: "once",
          }}
        />
      </Card>
    </div>
  );
}
