import type { Metadata } from "next";
import { getTranslations, setRequestLocale } from "next-intl/server";
import { Link } from "@/i18n/navigation";
import { ResetForm } from "@/components/auth-forms";
import { Alert } from "@/components/ui/form";
import { getSession } from "@/lib/auth/session";

export async function generateMetadata({
  params,
}: PageProps<"/[locale]/restablecer">): Promise<Metadata> {
  const { locale } = await params;
  const t = await getTranslations({ locale, namespace: "auth.reset" });
  return { title: t("title"), robots: { index: false } };
}

export default async function ResetPage({ params }: PageProps<"/[locale]/restablecer">) {
  const { locale } = await params;
  setRequestLocale(locale);
  const t = await getTranslations("auth");
  const { user } = await getSession();
  return (
    <>
      <h1 className="text-2xl font-bold">{t("reset.title")}</h1>
      <p className="text-muted-foreground mt-1 mb-6 text-sm">{t("reset.subtitle")}</p>
      {user ? (
        <ResetForm />
      ) : (
        <Alert tone="error">
          {t("reset.noSession")}{" "}
          <Link href="/recuperar" className="underline">
            {t("forgot.title")}
          </Link>
        </Alert>
      )}
    </>
  );
}
