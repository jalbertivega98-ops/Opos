"use client";

import { useActionState, useState } from "react";
import { useTranslations } from "next-intl";
import { Button } from "@/components/ui/button";
import { Alert, Input, Label } from "@/components/ui/form";
import {
  grantAccessAction,
  saveProductAction,
  setProductQuestionsAction,
  type StoreState,
} from "@/lib/store/actions";
import { PRODUCT_STATUSES, PRODUCT_TYPES } from "@/lib/store/schema";

const sel = "border-input bg-background h-11 w-full rounded-lg border px-3 text-base sm:text-sm";
const area = "border-input bg-background w-full rounded-lg border px-3 py-2 text-base sm:text-sm";

function StateAlert({ state }: { state: StoreState }) {
  const t = useTranslations("store");
  if (!state.message) return null;
  return (
    <Alert tone={state.status === "error" ? "error" : "success"}>
      {state.status === "error"
        ? t(`errors.${state.message}`)
        : t(`admin.${state.message}` as never)}
      {state.field && t.has(`errors.${state.field}`) ? ` ${t(`errors.${state.field}`)}` : ""}
    </Alert>
  );
}

export type ProductFormValues = {
  id?: string;
  slug: string;
  type: string;
  status: string;
  title: string;
  title_ca: string;
  description: string;
  description_ca: string;
  exam_body_id: string;
  is_free: boolean;
  included_in_premium: boolean;
  price: string;
  interval: string;
};

export function ProductForm({
  initial,
  exams,
}: {
  initial: ProductFormValues;
  exams: { id: string; name: string }[];
}) {
  const t = useTranslations("store");
  const [state, action, pending] = useActionState<StoreState, FormData>(saveProductAction, {
    status: "idle",
  });
  return (
    <form action={action} className="space-y-4">
      <StateAlert state={state} />
      {initial.id && <input type="hidden" name="id" value={initial.id} />}
      <div className="grid gap-4 sm:grid-cols-2">
        <div className="space-y-1.5">
          <Label htmlFor="title">{t("form.title")}</Label>
          <Input id="title" name="title" required defaultValue={initial.title} />
        </div>
        <div className="space-y-1.5">
          <Label htmlFor="title_ca">{t("form.titleCa")}</Label>
          <Input id="title_ca" name="title_ca" defaultValue={initial.title_ca} />
        </div>
        <div className="space-y-1.5">
          <Label htmlFor="slug">{t("form.slug")}</Label>
          <Input id="slug" name="slug" required defaultValue={initial.slug} />
        </div>
        <div className="space-y-1.5">
          <Label htmlFor="type">{t("form.type")}</Label>
          <select id="type" name="type" defaultValue={initial.type} className={sel}>
            {PRODUCT_TYPES.map((ty) => (
              <option key={ty} value={ty}>
                {t(`types.${ty}`)}
              </option>
            ))}
          </select>
        </div>
        <div className="space-y-1.5 sm:col-span-2">
          <Label htmlFor="description">{t("form.description")}</Label>
          <textarea
            id="description"
            name="description"
            rows={3}
            defaultValue={initial.description}
            className={area}
          />
        </div>
        <div className="space-y-1.5 sm:col-span-2">
          <Label htmlFor="description_ca">{t("form.descriptionCa")}</Label>
          <textarea
            id="description_ca"
            name="description_ca"
            rows={3}
            defaultValue={initial.description_ca}
            className={area}
          />
        </div>
        <div className="space-y-1.5">
          <Label htmlFor="exam_body_id">{t("form.exam")}</Label>
          <select
            id="exam_body_id"
            name="exam_body_id"
            defaultValue={initial.exam_body_id}
            className={sel}
          >
            <option value="">{t("form.none")}</option>
            {exams.map((e) => (
              <option key={e.id} value={e.id}>
                {e.name}
              </option>
            ))}
          </select>
        </div>
        <div className="space-y-1.5">
          <Label htmlFor="status">{t("form.status")}</Label>
          <select id="status" name="status" defaultValue={initial.status} className={sel}>
            {PRODUCT_STATUSES.map((s) => (
              <option key={s} value={s}>
                {t(`statuses.${s}`)}
              </option>
            ))}
          </select>
        </div>
        <div className="space-y-1.5">
          <Label htmlFor="price">{t("form.price")}</Label>
          <Input id="price" name="price" inputMode="decimal" defaultValue={initial.price} />
        </div>
        <div className="space-y-1.5">
          <Label htmlFor="interval">{t("form.interval")}</Label>
          <select id="interval" name="interval" defaultValue={initial.interval} className={sel}>
            {(["once", "month", "year"] as const).map((i) => (
              <option key={i} value={i}>
                {t(`intervals.${i}`)}
              </option>
            ))}
          </select>
        </div>
      </div>
      <div className="space-y-2 text-sm">
        <label className="flex items-center gap-2">
          <input
            type="checkbox"
            name="is_free"
            defaultChecked={initial.is_free}
            className="size-4"
          />{" "}
          {t("form.isFree")}
        </label>
        <label className="flex items-center gap-2">
          <input
            type="checkbox"
            name="included_in_premium"
            defaultChecked={initial.included_in_premium}
            className="size-4"
          />{" "}
          {t("form.premium")}
        </label>
      </div>
      <p className="text-muted-foreground text-xs">{t("form.paymentsOff")}</p>
      <Button type="submit" variant="accent" disabled={pending}>
        {t("form.save")}
      </Button>
    </form>
  );
}

export function ProductQuestionsForm({
  productId,
  questions,
  selected,
}: {
  productId: string;
  questions: { id: string; stem: string; category: string }[];
  selected: string[];
}) {
  const t = useTranslations("store");
  const [state, action, pending] = useActionState<StoreState, FormData>(setProductQuestionsAction, {
    status: "idle",
  });
  const [chosen, setChosen] = useState(new Set(selected));
  if (questions.length === 0)
    return <p className="text-muted-foreground text-sm">{t("admin.itemsEmpty")}</p>;
  return (
    <form action={action} className="space-y-3">
      <StateAlert state={state} />
      <input type="hidden" name="id" value={productId} />
      <p className="text-sm">{t("admin.selected", { count: chosen.size })}</p>
      <div className="max-h-96 space-y-1 overflow-y-auto rounded-lg border p-3 text-sm">
        {questions.map((q) => (
          <label key={q.id} className="flex items-start gap-2">
            <input
              type="checkbox"
              name="question"
              value={q.id}
              checked={chosen.has(q.id)}
              onChange={(e) => {
                const next = new Set(chosen);
                if (e.target.checked) next.add(q.id);
                else next.delete(q.id);
                setChosen(next);
              }}
              className="mt-0.5 size-4"
            />
            <span>
              <span className="text-muted-foreground">[{q.category}]</span> {q.stem}
            </span>
          </label>
        ))}
      </div>
      <Button type="submit" variant="outline" disabled={pending}>
        {t("admin.itemsSave")}
      </Button>
    </form>
  );
}

export function GrantForm({ products }: { products: { id: string; title: string }[] }) {
  const t = useTranslations("store");
  const [state, action, pending] = useActionState<StoreState, FormData>(grantAccessAction, {
    status: "idle",
  });
  return (
    <form action={action} className="space-y-4">
      {state.message && (
        <Alert tone={state.status === "error" ? "error" : "success"}>
          {state.status === "error" ? t(`errors.${state.message}`) : t("purchases.granted")}
        </Alert>
      )}
      <div className="grid gap-4 sm:grid-cols-2">
        <div className="space-y-1.5">
          <Label htmlFor="g-email">{t("purchases.email")}</Label>
          <Input id="g-email" name="email" type="email" required />
        </div>
        <div className="space-y-1.5">
          <Label htmlFor="g-product">{t("purchases.product")}</Label>
          <select id="g-product" name="product" required className={sel}>
            {products.map((p) => (
              <option key={p.id} value={p.id}>
                {p.title}
              </option>
            ))}
          </select>
        </div>
        <div className="space-y-1.5">
          <Label htmlFor="g-days">{t("purchases.days")}</Label>
          <Input id="g-days" name="days" type="number" min={1} max={3650} />
        </div>
        <div className="space-y-1.5">
          <Label htmlFor="g-note">{t("purchases.note")}</Label>
          <Input id="g-note" name="note" maxLength={500} />
        </div>
      </div>
      <Button type="submit" variant="accent" disabled={pending || products.length === 0}>
        {t("purchases.grant")}
      </Button>
    </form>
  );
}
