import type { Metadata } from "next";
import { getFormatter, getTranslations, setRequestLocale } from "next-intl/server";
import { Download } from "lucide-react";
import { Button } from "@/components/ui/button";
import { Card } from "@/components/ui/card";
import { Alert } from "@/components/ui/form";
import {
  ChangeEmailForm,
  ChangePasswordForm,
  DeleteAccountForm,
  ProfileForm,
} from "@/components/account-forms";
import { requireUser } from "@/lib/auth/session";
import { createClient } from "@/lib/supabase/server";

export async function generateMetadata({
  params,
}: PageProps<"/[locale]/app/perfil">): Promise<Metadata> {
  const { locale } = await params;
  const t = await getTranslations({ locale, namespace: "profile" });
  return { title: t("title"), robots: { index: false } };
}

export default async function ProfilePage({
  params,
  searchParams,
}: PageProps<"/[locale]/app/perfil">) {
  const { locale } = await params;
  setRequestLocale(locale);
  const sp = await searchParams;
  const { user, profile } = await requireUser(locale, "/app/perfil");
  const t = await getTranslations("profile");
  const format = await getFormatter();
  const supabase = await createClient();
  const { data: consent } = await supabase
    .from("profiles")
    .select("marketing_consent")
    .eq("id", user.id)
    .single();

  return (
    <div className="mx-auto max-w-2xl space-y-6">
      <div>
        <h1 className="text-3xl font-bold">{t("title")}</h1>
        <p className="text-muted-foreground mt-1 text-sm">
          {user.email} ·{" "}
          {t("memberSince", {
            date: format.dateTime(new Date(profile.created_at), { dateStyle: "long" }),
          })}
        </p>
      </div>
      {sp.saved === "1" && <Alert tone="success">{t("saved")}</Alert>}

      <Card>
        <h2 className="mb-4 text-lg font-semibold">{t("personal")}</h2>
        <ProfileForm
          displayName={profile.display_name ?? ""}
          locale={profile.locale}
          marketingConsent={consent?.marketing_consent ?? false}
        />
      </Card>

      <Card>
        <h2 className="text-lg font-semibold">{t("securityTitle")}</h2>
        <p className="text-muted-foreground mt-1 mb-4 text-sm">{t("securityBody")}</p>
        <ChangePasswordForm />
      </Card>

      <Card>
        <h2 className="text-lg font-semibold">{t("emailTitle")}</h2>
        <p className="text-muted-foreground mt-1 mb-4 text-sm">
          {t("emailBody", { email: user.email ?? "" })}
        </p>
        <ChangeEmailForm />
      </Card>

      <Card>
        <h2 className="text-lg font-semibold">{t("exportTitle")}</h2>
        <p className="text-muted-foreground mt-1 text-sm">{t("exportBody")}</p>
        <Button asChild variant="outline" className="mt-4">
          <a href="/api/account/export" download>
            <Download aria-hidden /> {t("exportCta")}
          </a>
        </Button>
      </Card>

      <Card className="border-danger/40">
        <h2 className="text-danger text-lg font-semibold">{t("deleteTitle")}</h2>
        <p className="text-muted-foreground mt-1 mb-4 text-sm">{t("deleteBody")}</p>
        {profile.role === "owner" ? <Alert>{t("ownerCannotDelete")}</Alert> : <DeleteAccountForm />}
      </Card>
    </div>
  );
}
