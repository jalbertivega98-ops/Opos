import { getTranslations } from "next-intl/server";
import { Lock } from "lucide-react";
import { Link } from "@/i18n/navigation";
import { startCheckoutAction } from "@/lib/billing/actions";
import { cn } from "@/lib/utils";
import { SubmitButton } from "./submit-button";

/**
 * Formulario de compra: consentimiento legal + botón que lleva a Stripe Checkout.
 * El pago y la tarjeta se gestionan en Stripe; aquí no se guarda nada de eso.
 */
export async function BuyForm({
  slug,
  back,
  label,
  testMode,
  className,
  size = "md",
  intervals,
  intervalsLegend,
}: {
  /** Premium: opciones de pago (mensual / anual). La primera va marcada. */
  intervals?: { value: "month" | "year"; label: string }[];
  intervalsLegend?: string;
  slug: string;
  back: string;
  label: string;
  testMode: boolean;
  className?: string;
  size?: "sm" | "md";
}) {
  const t = await getTranslations("billing");
  const id = `consent-${slug}`;
  return (
    <form
      action={startCheckoutAction}
      className={cn("space-y-2", className)}
      data-testid="buy-form"
    >
      <input type="hidden" name="slug" value={slug} />
      <input type="hidden" name="back" value={back} />
      {intervals && intervals.length > 1 && (
        <fieldset className="space-y-1.5" data-testid="buy-intervals">
          {intervalsLegend && (
            <legend className="mb-1 text-sm font-medium">{intervalsLegend}</legend>
          )}
          {intervals.map((opt, i) => (
            <label
              key={opt.value}
              className="border-border has-[:checked]:border-accent has-[:checked]:bg-accent-soft flex cursor-pointer items-center gap-2 rounded-lg border px-3 py-2 text-sm"
            >
              <input
                type="radio"
                name="interval"
                value={opt.value}
                defaultChecked={i === 0}
                className="size-4 shrink-0"
              />
              <span>{opt.label}</span>
            </label>
          ))}
        </fieldset>
      )}
      {intervals && intervals.length === 1 && (
        <input type="hidden" name="interval" value={intervals[0].value} />
      )}
      <label htmlFor={id} className="text-muted-foreground flex items-start gap-2 text-xs">
        <input id={id} type="checkbox" name="consent" required className="mt-0.5 size-4 shrink-0" />
        <span>
          {t("consent")}{" "}
          <Link
            href="/legal/condiciones"
            className="text-accent underline-offset-2 hover:underline"
          >
            {t("terms")}
          </Link>
        </span>
      </label>
      <SubmitButton
        variant="accent"
        size={size}
        className="w-full"
        pendingLabel={t("redirecting")}
        data-testid="buy-button"
      >
        <Lock aria-hidden />
        {label}
      </SubmitButton>
      <p className="text-muted-foreground text-center text-xs">
        {testMode ? t("testNote") : t("secureNote")}
      </p>
    </form>
  );
}
