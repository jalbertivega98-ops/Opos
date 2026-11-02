import { getTranslations } from "next-intl/server";
import { Link } from "@/i18n/navigation";
import { Button } from "@/components/ui/button";

export default async function NotFound() {
  const t = await getTranslations("errors");
  return (
    <main
      id="main"
      className="mx-auto flex min-h-[70dvh] max-w-md flex-col items-center justify-center gap-4 px-4 text-center"
    >
      <p className="font-display text-accent text-6xl font-extrabold">404</p>
      <h1 className="text-2xl font-bold">{t("notFoundTitle")}</h1>
      <p className="text-muted-foreground">{t("notFoundBody")}</p>
      <Button asChild>
        <Link href="/">{t("home")}</Link>
      </Button>
    </main>
  );
}
