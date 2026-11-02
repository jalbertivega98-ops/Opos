"use client";

import { useLocale } from "next-intl";
import { useTransition } from "react";
import { usePathname, useRouter } from "@/i18n/navigation";
import { routing } from "@/i18n/routing";

const names: Record<string, string> = { es: "ES", ca: "CA" };
const longNames: Record<string, string> = { es: "Castellano", ca: "Català" };

export function LocaleSwitcher({ label }: { label: string }) {
  const locale = useLocale();
  const pathname = usePathname();
  const router = useRouter();
  const [pending, start] = useTransition();

  return (
    <div role="group" aria-label={label} className="border-border flex rounded-lg border p-0.5">
      {routing.locales.map((l) => (
        <button
          key={l}
          type="button"
          lang={l}
          aria-pressed={l === locale}
          aria-label={longNames[l]}
          disabled={pending}
          onClick={() => start(() => router.replace(pathname, { locale: l }))}
          className="aria-pressed:bg-primary aria-pressed:text-primary-foreground rounded-md px-2 py-1 text-xs font-semibold"
        >
          {names[l]}
        </button>
      ))}
    </div>
  );
}
