"use client";

import { useActionState, useState } from "react";
import { useTranslations } from "next-intl";
import { Button } from "@/components/ui/button";
import { Alert, Input, Label } from "@/components/ui/form";
import {
  createPromoCodeAction,
  grantUserProductAction,
  type AdminActionState,
} from "@/lib/admin/actions";

const sel = "border-input bg-background h-11 w-full rounded-lg border px-3 text-base sm:text-sm";

function StateAlert({ state }: { state: AdminActionState }) {
  const t = useTranslations();
  if (!state.message) return null;
  return <Alert tone={state.status === "error" ? "error" : "success"}>{t(state.message)}</Alert>;
}

export type GrantableProduct = { id: string; title: string; type: string };

/** Asignar un pack o un Premium a este alumno (sin cobro, auditado). */
export function UserGrantForm({ user, products }: { user: string; products: GrantableProduct[] }) {
  const t = useTranslations("adminUsers.insights");
  const [state, action, pending] = useActionState<AdminActionState, FormData>(
    grantUserProductAction,
    { status: "idle" },
  );
  const premium = products.filter((p) => p.type === "subscription");
  const packs = products.filter((p) => p.type !== "subscription");
  return (
    <form action={action} className="space-y-3" data-testid="user-grant-form">
      <StateAlert state={state} />
      <input type="hidden" name="user" value={user} />
      <div className="grid gap-3 sm:grid-cols-[2fr_1fr]">
        <div className="space-y-1.5">
          <Label htmlFor="grant-product">{t("product")}</Label>
          <select id="grant-product" name="product" required className={sel} defaultValue="">
            <option value="" disabled>
              {t("choose")}
            </option>
            {premium.length > 0 && (
              <optgroup label={t("premiumGroup")}>
                {premium.map((p) => (
                  <option key={p.id} value={p.id}>
                    {p.title}
                  </option>
                ))}
              </optgroup>
            )}
            <optgroup label={t("packsGroup")}>
              {packs.map((p) => (
                <option key={p.id} value={p.id}>
                  {p.title}
                </option>
              ))}
            </optgroup>
          </select>
        </div>
        <div className="space-y-1.5">
          <Label htmlFor="grant-days">{t("days")}</Label>
          <Input
            id="grant-days"
            name="days"
            type="number"
            min={1}
            max={3650}
            placeholder={t("daysPlaceholder")}
          />
        </div>
      </div>
      <div className="space-y-1.5">
        <Label htmlFor="grant-note">{t("note")}</Label>
        <Input id="grant-note" name="note" maxLength={500} placeholder={t("notePlaceholder")} />
      </div>
      <p className="text-muted-foreground text-xs">{t("grantHelp")}</p>
      <Button type="submit" disabled={pending}>
        {t("grant")}
      </Button>
    </form>
  );
}

/** Crear un código promocional de Stripe que solo puede usar este alumno. */
export function PromoCodeForm({ user, live }: { user: string; live: boolean }) {
  const t = useTranslations("adminUsers.promo");
  const [state, action, pending] = useActionState<AdminActionState, FormData>(
    createPromoCodeAction,
    { status: "idle" },
  );
  const [kind, setKind] = useState<"percent" | "amount">("percent");
  const [duration, setDuration] = useState<"once" | "repeating" | "forever">("once");
  return (
    <form action={action} className="space-y-3" data-testid="promo-form">
      <StateAlert state={state} />
      {live && <Alert>{t("liveWarning")}</Alert>}
      <input type="hidden" name="user" value={user} />
      <div className="grid gap-3 sm:grid-cols-3">
        <div className="space-y-1.5">
          <Label htmlFor="promo-code">{t("code")}</Label>
          <Input
            id="promo-code"
            name="code"
            required
            minLength={3}
            maxLength={40}
            pattern="[A-Za-z0-9\-]{3,40}"
            placeholder="BIENVENIDA20"
            className="uppercase"
          />
        </div>
        <div className="space-y-1.5">
          <Label htmlFor="promo-kind">{t("kind")}</Label>
          <select
            id="promo-kind"
            name="kind"
            className={sel}
            value={kind}
            onChange={(e) => setKind(e.target.value as "percent" | "amount")}
          >
            <option value="percent">{t("kinds.percent")}</option>
            <option value="amount">{t("kinds.amount")}</option>
          </select>
        </div>
        <div className="space-y-1.5">
          <Label htmlFor="promo-value">
            {kind === "percent" ? t("valuePercent") : t("valueAmount")}
          </Label>
          <Input
            id="promo-value"
            name="value"
            type="number"
            required
            min={kind === "percent" ? 1 : 0.5}
            max={kind === "percent" ? 100 : 1000}
            step={kind === "percent" ? 1 : 0.01}
          />
        </div>
      </div>
      <div className="grid gap-3 sm:grid-cols-3">
        <div className="space-y-1.5">
          <Label htmlFor="promo-duration">{t("duration")}</Label>
          <select
            id="promo-duration"
            name="duration"
            className={sel}
            value={duration}
            onChange={(e) => setDuration(e.target.value as "once" | "repeating" | "forever")}
          >
            <option value="once">{t("durations.once")}</option>
            <option value="repeating">{t("durations.repeating")}</option>
            <option value="forever">{t("durations.forever")}</option>
          </select>
        </div>
        {duration === "repeating" && (
          <div className="space-y-1.5">
            <Label htmlFor="promo-months">{t("months")}</Label>
            <Input id="promo-months" name="months" type="number" min={1} max={36} required />
          </div>
        )}
        <div className="space-y-1.5">
          <Label htmlFor="promo-expires">{t("expiresDays")}</Label>
          <Input
            id="promo-expires"
            name="expiresDays"
            type="number"
            min={1}
            max={365}
            placeholder={t("expiresPlaceholder")}
          />
        </div>
      </div>
      <div className="space-y-1.5">
        <Label htmlFor="promo-note">{t("note")}</Label>
        <Input id="promo-note" name="note" maxLength={500} />
      </div>
      <p className="text-muted-foreground text-xs">{t("help")}</p>
      <Button type="submit" variant="accent" disabled={pending}>
        {t("create")}
      </Button>
    </form>
  );
}
