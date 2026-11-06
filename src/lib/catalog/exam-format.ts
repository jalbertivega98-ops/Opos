/**
 * Oposiciones cuyo proceso oficial incluye una prueba psicotécnica, comprobado en cada convocatoria
 * (docs/research): Mossos (aptituds), Auxiliar del Estado (30 preguntas psicotécnicas), Policía
 * Nacional (psicotécnicos), Guardia Civil (aptitudes intelectuales), Guardia Urbana de Barcelona (tests
 * aptitudinales, base 4.2) y policías locales de Cataluña (Decreto 233/2002, art. 18.1.a). Administrativo
 * del Estado, Auxilio Judicial, Tramitación Procesal, Prisiones de Cataluña (serveis penitenciaris),
 * Bombers de la Generalitat (evaluación psicológica de competencias, sin razonamiento) y Ayudantes de
 * Instituciones Penitenciarias (base 6.3) NO tienen psicotécnico: su plan y su ficha no deben ofrecerlo.
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
