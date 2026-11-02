import { defineRouting } from "next-intl/routing";

export const locales = ["es", "ca"] as const;
export type Locale = (typeof locales)[number];

export const routing = defineRouting({
  locales,
  defaultLocale: "es",
  localePrefix: "as-needed",
});
