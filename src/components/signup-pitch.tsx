"use client";

import { useTranslations } from "next-intl";
import { ArrowRight, BrainCircuit, CalendarCheck, ClipboardList, Timer } from "lucide-react";
import { Link } from "@/i18n/navigation";
import { Button } from "@/components/ui/button";
import { cn } from "@/lib/utils";

const ITEMS = [
  { key: "plan", icon: CalendarCheck },
  { key: "topics", icon: ClipboardList },
  { key: "mock", icon: Timer },
  { key: "psycho", icon: BrainCircuit },
] as const;

/**
 * Qué se gana con la cuenta gratis, al acabar una prueba sin registro (ADR-073).
 * En el embudo, 12 personas terminaron el test gratis y ninguna pulsó «Crear
 * cuenta»: el botón solo no explicaba para qué. Lo que se lista es el plan
 * gratuito real (ADR-035, ADR-048, ADR-067); no promete guardar el resultado
 * anónimo, que nunca se asocia a la cuenta (ADR-041).
 */
export function SignupPitch({
  href,
  onClick,
  testId,
  compact = false,
  className,
}: {
  href: string;
  onClick?: () => void;
  testId: string;
  /** Solo el botón y la nota, para repetirlo al final de la página. */
  compact?: boolean;
  className?: string;
}) {
  const t = useTranslations("signupPitch");
  const button = (
    <div className="space-y-2">
      <Button asChild variant="accent" size="lg" className="w-full sm:w-auto">
        <Link href={href} onClick={onClick} data-testid={testId}>
          {t("cta")}
          <ArrowRight aria-hidden />
        </Link>
      </Button>
      <p className="text-muted-foreground text-sm">{t("note")}</p>
    </div>
  );
  if (compact) {
    return (
      <div className={cn("border-accent/40 bg-accent-soft rounded-xl border p-4", className)}>
        <p className="mb-3 font-semibold">{t("compactTitle")}</p>
        {button}
      </div>
    );
  }
  return (
    <div
      className={cn(
        "border-accent/40 bg-accent-soft space-y-4 rounded-xl border-2 p-4 sm:p-5",
        className,
      )}
      data-testid="signup-pitch"
    >
      <p className="text-lg font-bold">{t("title")}</p>
      <ul className="space-y-2">
        {ITEMS.map(({ key, icon: Icon }) => (
          <li key={key} className="flex items-start gap-2">
            <Icon className="text-accent mt-0.5 size-5 shrink-0" aria-hidden />
            <span>{t(`items.${key}`)}</span>
          </li>
        ))}
      </ul>
      {button}
    </div>
  );
}
