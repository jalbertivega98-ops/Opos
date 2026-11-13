import { z } from "zod";

/** Código de embajadora: minúsculas, cifras y guiones (como en la URL /r/<código>). */
export const ambassadorCodeSchema = z
  .string()
  .trim()
  .toLowerCase()
  .regex(/^[a-z0-9-]{2,32}$/, { error: "code" });

/** Código opcional que llega en un formulario o en ?ref=: si no es válido, se ignora. */
export const optionalRefSchema = z
  .string()
  .optional()
  .transform((v) => {
    const parsed = ambassadorCodeSchema.safeParse(v ?? "");
    return parsed.success ? parsed.data : undefined;
  });

export const ambassadorNetworks = ["instagram", "tiktok", "youtube", "otra"] as const;

const optionalText = (max: number) =>
  z
    .string()
    .trim()
    .max(max)
    .optional()
    .transform((v) => (v ? v : null));

/** Alta de una embajadora desde /admin/embajadoras. */
export const ambassadorCreateSchema = z.object({
  code: ambassadorCodeSchema,
  name: z.string().trim().min(1, { error: "name" }).max(80, { error: "name" }),
  network: z.enum(ambassadorNetworks),
  handle: optionalText(80),
  exam: z
    .union([z.literal(""), z.uuid()])
    .optional()
    .transform((v) => (v ? v : null)),
  notes: optionalText(500),
});

/** Activar o pausar una embajadora. */
export const ambassadorToggleSchema = z.object({
  id: z.uuid(),
  active: z.enum(["true", "false"]).transform((v) => v === "true"),
});
