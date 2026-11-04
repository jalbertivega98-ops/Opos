import type { Metadata, Viewport } from "next";
import type { ReactNode } from "react";
import { Inter, Source_Serif_4 } from "next/font/google";
import { notFound } from "next/navigation";
import { hasLocale, NextIntlClientProvider } from "next-intl";
import { getTranslations, setRequestLocale } from "next-intl/server";
import { routing } from "@/i18n/routing";
import { ThemeProvider } from "@/components/theme-provider";
import { publicEnv } from "@/lib/env";
import "../globals.css";

const sans = Inter({ subsets: ["latin"], variable: "--font-sans", display: "swap" });
const display = Source_Serif_4({
  subsets: ["latin"],
  variable: "--font-display",
  weight: ["600", "700", "800"],
  display: "swap",
});

export function generateStaticParams() {
  return routing.locales.map((locale) => ({ locale }));
}

export async function generateMetadata({ params }: LayoutProps<"/[locale]">): Promise<Metadata> {
  const { locale } = await params;
  const t = await getTranslations({ locale, namespace: "meta" });
  return {
    metadataBase: new URL(publicEnv.NEXT_PUBLIC_SITE_URL),
    title: { default: t("title"), template: `%s · OPOSAPRUEBA` },
    description: t("description"),
    alternates: { languages: { es: "/", ca: "/ca" } },
    manifest: "/manifest.webmanifest",
  };
}

export const viewport: Viewport = {
  themeColor: [
    { media: "(prefers-color-scheme: light)", color: "#ffffff" },
    { media: "(prefers-color-scheme: dark)", color: "#07111f" },
  ],
};

export default async function LocaleLayout({ children, params }: LayoutProps<"/[locale]">) {
  const { locale } = await params;
  if (!hasLocale(routing.locales, locale)) notFound();
  setRequestLocale(locale);
  const t = await getTranslations("nav");

  return (
    <html lang={locale} suppressHydrationWarning className={`${sans.variable} ${display.variable}`}>
      <body className="flex min-h-dvh flex-col antialiased">
        <a
          href="#main"
          className="focus:bg-background sr-only focus:not-sr-only focus:fixed focus:top-4 focus:left-4 focus:z-50 focus:rounded-md focus:px-4 focus:py-2"
        >
          {t("skip")}
        </a>
        <ThemeProvider>
          <NextIntlClientProvider>{children as ReactNode}</NextIntlClientProvider>
        </ThemeProvider>
      </body>
    </html>
  );
}
