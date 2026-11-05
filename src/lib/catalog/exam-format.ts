/**
 * Oposiciones cuyo proceso oficial incluye una prueba psicotécnica, comprobado en cada convocatoria
 * (docs/research): Mossos (aptituds), Auxiliar del Estado (30 preguntas psicotécnicas), Policía
 * Nacional (psicotécnicos), Guardia Civil (aptitudes intelectuales) y policías locales. Administrativo
 * del Estado, Auxilio Judicial, Tramitación Procesal y Prisiones de Cataluña (serveis penitenciaris)
 * NO tienen psicotécnico: su plan y su ficha no deben ofrecerlo.
 */
const WITH_PSYCHO = new Set([
  "mossos-esquadra",
  "auxiliar-administrativo-estado",
  "policia-nacional-basica",
  "guardia-civil-cabos-guardias",
  "guardia-urbana-barcelona",
  "policia-local",
]);

export const examHasPsycho = (slug: string | null | undefined) => !!slug && WITH_PSYCHO.has(slug);
