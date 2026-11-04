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
}: {
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
