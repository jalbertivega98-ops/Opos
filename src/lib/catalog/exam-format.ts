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

/**
 * Oposiciones con simulacro de psicotécnicos propio (formato oficial publicado) y su pack de
 * 10 intentos (ADR-035): solo Mossos (aptituds) y Auxiliar del Estado. En el resto el plan no
 * pide simulacros de psicotécnicos, porque no hay ninguno que hacer ni que comprar; la práctica
 * de psicotécnicos sí se mantiene.
 */
const WITH_PSYCHO_MOCK = new Set(["mossos-esquadra", "auxiliar-administrativo-estado"]);

export const examHasPsychoMock = (slug: string | null | undefined) =>
  !!slug && WITH_PSYCHO_MOCK.has(slug);
