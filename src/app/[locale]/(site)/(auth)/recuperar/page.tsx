import type { Metadata } from "next";
import { getTranslations, setRequestLocale } from "next-intl/server";
import { ForgotForm } from "@/components/auth-forms";

export async function generateMetadata({
  params,
}: PageProps<"/[locale]/recuperar">): Promise<Metadata> {
  const { locale } = await params;
  const t = await getTranslations({ locale, namespace: "auth.forgot" });
  return { title: t("title"), robots: { index: false } };
}

export default async function ForgotPage({ params }: PageProps<"/[locale]/recuperar">) {
  const { locale } = await params;
  setRequestLocale(locale);
  const t = await getTranslations("auth.forgot");
  return (
    <>
      <h1 className="text-2xl font-bold">{t("title")}</h1>
      <p className="text-muted-foreground mt-1 mb-6 text-sm">{t("subtitle")}</p>
      <ForgotForm />
    </>
  );
}
