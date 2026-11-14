import type { Metadata } from "next";
import { getTranslations, setRequestLocale } from "next-intl/server";
import { GoogleSignIn, SignUpForm } from "@/components/auth-forms";
import { isGoogleAuthEnabled } from "@/lib/auth/providers";
import { examFromNext, onboardingPath } from "@/lib/paths";
import { optionalRefSchema } from "@/lib/ambassadors/schemas";

export async function generateMetadata({
  params,
}: PageProps<"/[locale]/registro">): Promise<Metadata> {
  const { locale } = await params;
  const t = await getTranslations({ locale, namespace: "auth.signUp" });
  return { title: t("title") };
}

export default async function SignUpPage({
  params,
  searchParams,
}: PageProps<"/[locale]/registro">) {
  const { locale } = await params;
  setRequestLocale(locale);
  const sp = await searchParams;
  // La oposición llega como ?exam= (enlaces de la web) o dentro de ?next= (redirección
  // del proxy). Tras crear la cuenta, el onboarding la trae ya elegida.
  const exam =
    typeof sp.exam === "string"
      ? sp.exam
      : typeof sp.next === "string"
        ? examFromNext(sp.next)
        : undefined;
  const next = exam ? onboardingPath(exam) : undefined;
  // Código de embajadora (enlace /r/<código>, ADR-054). Si no es válido, se ignora.
  const ref = optionalRefSchema.parse(typeof sp.ref === "string" ? sp.ref : undefined);
  const t = await getTranslations("auth.signUp");
  const google = await isGoogleAuthEnabled();
  return (
    <>
      <h1 className="text-2xl font-bold">{t("title")}</h1>
      <p className="text-muted-foreground mt-1 mb-6 text-sm">{t("subtitle")}</p>
      {google && <GoogleSignIn next={next} refCode={ref} />}
      <SignUpForm next={next} refCode={ref} />
    </>
  );
}
