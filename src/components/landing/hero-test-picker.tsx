"use client";

import { useState } from "react";
import { useTranslations } from "next-intl";
import { ArrowRight } from "lucide-react";
import { useRouter } from "@/i18n/navigation";
import { Button } from "@/components/ui/button";

type Option = { slug: string; label: string };

/**
 * Acción principal de la portada (ADR-056): elegir la oposición y empezar el test
 * gratis sin registro en un solo paso. Casi nadie llegaba al test cuando era una
 * lista de enlaces debajo del botón de crear cuenta.
 */
export function HeroTestPicker({ options }: { options: Option[] }) {
  const t = useTranslations("landing.freeTests");
  const router = useRouter();
  const [slug, setSlug] = useState(options[0]?.slug ?? "");
  if (options.length === 0) return null;

  return (
    <form
      className="border-accent/40 bg-background mt-8 max-w-xl rounded-2xl border-2 p-4 shadow-lg shadow-black/5 sm:p-5"
      data-testid="hero-free-tests"
      onSubmit={(e) => {
        e.preventDefault();
        if (slug) router.push(`/oposiciones/${slug}/test`);
      }}
    >
      <label htmlFor="hero-test-exam" className="text-base font-bold">
        {t("title")}
      </label>
      <p className="text-muted-foreground mt-1 text-sm">{t("hint")}</p>
      <div className="mt-3 flex flex-col gap-2 sm:flex-row">
        <select
          id="hero-test-exam"
          value={slug}
          onChange={(e) => setSlug(e.target.value)}
          className="border-input bg-background h-12 w-full flex-1 rounded-lg border px-3 text-base"
        >
          {options.map((o) => (
            <option key={o.slug} value={o.slug}>
              {o.label}
            </option>
          ))}
        </select>
        <Button type="submit" variant="accent" size="lg" className="h-12 px-6 text-base">
          {t("start")}
          <ArrowRight aria-hidden />
        </Button>
      </div>
    </form>
  );
}
