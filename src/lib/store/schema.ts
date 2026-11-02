import { z } from "zod";

export const PRODUCT_TYPES = [
  "pdf",
  "question_pack",
  "mock_exam",
  "bundle",
  "subscription",
] as const;
export const PRODUCT_STATUSES = ["draft", "published", "archived"] as const;

const bool = z.preprocess((v) => v === true || v === "on" || v === "true", z.boolean());
const optText = (max: number) =>
  z
    .string()
    .trim()
    .max(max)
    .optional()
    .transform((v) => (v ? v : null));

export const productSchema = z.object({
  slug: z
    .string()
    .trim()
    .toLowerCase()
    .regex(/^[a-z0-9]+(-[a-z0-9]+)*$/, { error: "slug" })
    .max(80),
  type: z.enum(PRODUCT_TYPES),
  status: z.enum(PRODUCT_STATUSES).default("draft"),
  title: z.string().trim().min(3, { error: "title" }).max(160),
  title_ca: optText(160),
  description: optText(4000),
  description_ca: optText(4000),
  exam_body_id: z
    .union([z.uuid(), z.literal("")])
    .optional()
    .transform((v) => (v ? v : null)),
  is_free: bool.default(false),
  included_in_premium: bool.default(false),
  // precio en euros con coma o punto; vacío = sin precio
  price: z
    .string()
    .trim()
    .optional()
    .transform((v, ctx) => {
      if (!v) return null;
      const n = Number(v.replace(",", "."));
      if (!Number.isFinite(n) || n < 0 || n > 1000) {
        ctx.addIssue({ code: "custom", message: "price" });
        return z.NEVER;
      }
      return Math.round(n * 100);
    }),
  interval: z.enum(["once", "month", "year"]).default("once"),
});
export type ProductInput = z.infer<typeof productSchema>;

export const grantSchema = z.object({
  email: z.email({ error: "email" }),
  product: z.uuid(),
  days: z
    .union([z.literal(""), z.coerce.number().int().min(1).max(3650)])
    .optional()
    .transform((v) => (v === "" || v === undefined ? null : v)),
  note: z.string().trim().max(500).optional(),
});

export const formatPrice = (cents: number, locale = "es") =>
  new Intl.NumberFormat(locale === "ca" ? "ca-ES" : "es-ES", {
    style: "currency",
    currency: "EUR",
  }).format(cents / 100);
