import { MailCheck } from "lucide-react";
import { getTranslations, setRequestLocale } from "next-intl/server";

export default async function VerifyPage({
  params,
  searchParams,
}: PageProps<"/[locale]/verifica-tu-correo">) {
  const { locale } = await params;
  setRequestLocale(locale);
  const { email } = await searchParams;
  const t = await getTranslations("auth.verify");
  const safeEmail = typeof email === "string" ? email.slice(0, 254) : "";
  return (
    <div className="space-y-4 text-center">
      <MailCheck className="text-accent mx-auto size-12" aria-hidden />
      <h1 className="text-2xl font-bold">{t("title")}</h1>
      <p className="text-muted-foreground">{t("body", { email: safeEmail })}</p>
      <p className="text-muted-foreground text-sm">{t("hint")}</p>
    </div>
  );
}
