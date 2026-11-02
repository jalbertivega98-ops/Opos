import type { Metadata } from "next";
import { getTranslations, setRequestLocale } from "next-intl/server";
import { SignInForm } from "@/components/auth-forms";
import { safeNextPath } from "@/lib/paths";

export async function generateMetadata({
  params,
}: PageProps<"/[locale]/entrar">): Promise<Metadata> {
  const { locale } = await params;
  const t = await getTranslations({ locale, namespace: "auth.signIn" });
  return { title: t("title"), robots: { index: false } };
}

export default async function SignInPage({ params, searchParams }: PageProps<"/[locale]/entrar">) {
  const { locale } = await params;
  setRequestLocale(locale);
  const sp = await searchParams;
  const t = await getTranslations("auth.signIn");
  const next = typeof sp.next === "string" ? safeNextPath(sp.next) : undefined;
  return (
    <>
      <h1 className="text-2xl font-bold">{t("title")}</h1>
      <p className="text-muted-foreground mt-1 mb-6 text-sm">{t("subtitle")}</p>
      <SignInForm next={next} linkError={sp.error === "link"} />
    </>
  );
}
