import type { Metadata } from "next";
import { getTranslations, setRequestLocale } from "next-intl/server";
import { GoogleSignIn, SignUpForm } from "@/components/auth-forms";
import { isGoogleAuthEnabled } from "@/lib/auth/providers";

export async function generateMetadata({
  params,
}: PageProps<"/[locale]/registro">): Promise<Metadata> {
  const { locale } = await params;
  const t = await getTranslations({ locale, namespace: "auth.signUp" });
  return { title: t("title") };
}

export default async function SignUpPage({ params }: PageProps<"/[locale]/registro">) {
  const { locale } = await params;
  setRequestLocale(locale);
  const t = await getTranslations("auth.signUp");
  const google = await isGoogleAuthEnabled();
  return (
    <>
      <h1 className="text-2xl font-bold">{t("title")}</h1>
      <p className="text-muted-foreground mt-1 mb-6 text-sm">{t("subtitle")}</p>
      {google && <GoogleSignIn />}
      <SignUpForm />
    </>
  );
}
