import { getTranslations, setRequestLocale } from "next-intl/server";

export default async function SuspendedPage({ params }: PageProps<"/[locale]/cuenta-suspendida">) {
  const { locale } = await params;
  setRequestLocale(locale);
  const t = await getTranslations("auth.suspended");
  return (
    <div className="mx-auto max-w-md px-4 py-16 text-center">
      <h1 className="text-2xl font-bold">{t("title")}</h1>
      <p className="text-muted-foreground mt-3">{t("body")}</p>
    </div>
  );
}
