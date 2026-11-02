/**
 * Normaliza el término de búsqueda: solo letras, números, espacios y signos
 * habituales en nombres (' - · .). Elimina comodines y caracteres con
 * significado en la sintaxis de filtros de PostgREST (, ( ) " % _ *).
 */
export function sanitizeSearch(term: string) {
  return term
    .replace(/[^\p{L}\p{N}\s'\-·.]/gu, "")
    .replace(/\s+/g, " ")
    .trim()
    .slice(0, 80);
}
