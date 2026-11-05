import "server-only";

/**
 * Datos del titular para los textos legales (LSSI-CE art. 10, RGPD art. 13).
 * Por decisión de joel (4/11/2026) se publica solo la marca OPOSAPRUEBA y
 * el correo del proyecto. NIF y domicilio solo aparecen si se configuran en
 * Vercel (LEGAL_OWNER_*); nunca se inventan ni se guardan en el repo (DEC-004).
 */
export type LegalOwner = {
  name: string; // nombre y apellidos o razón social
  taxId: string | null; // NIF / DNI
  address: string | null; // domicilio
  email: string; // contacto
  registry: string | null; // inscripción registral (solo sociedades)
};

export function legalOwner(): LegalOwner {
  const v = (k: string) => process.env[k]?.trim() || null;
  return {
    name: v("LEGAL_OWNER_NAME") ?? "OPOSAPRUEBA",
    taxId: v("LEGAL_OWNER_TAX_ID"),
    address: v("LEGAL_OWNER_ADDRESS"),
    email: v("LEGAL_OWNER_EMAIL") ?? "oposaprueba@gmail.com",
    registry: v("LEGAL_OWNER_REGISTRY"),
  };
}
