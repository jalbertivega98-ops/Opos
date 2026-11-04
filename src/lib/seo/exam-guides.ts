import type { PsychoType } from "@/lib/learning/psycho/types";

/**
 * Guías públicas de cada oposición (ADR-025). Solo datos de fuentes oficiales ya
 * verificadas en docs/research/ (fecha en `verifiedOn`). Si cambia la convocatoria,
 * se actualiza aquí y en el documento de investigación. No incluir cifras de
 * terceros, testimonios ni resultados de alumnos.
 */
type L = { es: string; ca: string };

export type ExamFact = { label: L; value: L };
export type ExamPart = { name: L; detail: L };
export type ExamFaq = { q: L; a: L };
export type ExamGuide = {
  slug: string;
  verifiedOn: string;
  seoTitle: L;
  /** Título visible (h1) de la ficha. */
  h1: L;
  seoDescription: L;
  intro: L;
  facts: ExamFact[];
  parts: ExamPart[];
  /** Fechas del calendario oficial (previsión) o hitos ya celebrados. */
  calendar: ExamFact[];
  calendarNote: L;
  /** Tipos de psicotécnico de OPOSAPRUEBA relacionados con el examen. */
  psychoTypes: PsychoType[];
  psychoNote: L;
  faq: ExamFaq[];
  sources: { title: string; url: string }[];
};

const mossos: ExamGuide = {
  slug: "mossos-esquadra",
  verifiedOn: "2026-11-03",
  h1: {
    es: "Oposiciones a Mossos d'Esquadra (convocatoria 46/26)",
    ca: "Oposicions a Mossos d'Esquadra (convocatòria 46/26)",
  },
  seoTitle: {
    es: "Oposiciones Mossos d'Esquadra 2026: examen, temario y test",
    ca: "Oposicions Mossos d'Esquadra 2026: examen, temari i tests",
  },
  seoDescription: {
    es: "Convocatoria 46/26 de Mossos d'Esquadra: 1.587 plazas, cómo es la primera prueba (30 preguntas de conocimientos y 80 de aptitudes), temario de la Guia d'estudi y fuentes oficiales.",
    ca: "Convocatòria 46/26 de Mossos d'Esquadra: 1.587 places, com és la primera prova (30 preguntes de coneixements i 80 d'aptituds), temari de la Guia d'estudi i fonts oficials.",
  },
  intro: {
    es: "Resumen de la convocatoria 46/26 de la escala básica de Mossos d'Esquadra con los datos de las bases oficiales (Resolució ISP/1763/2026) y de la web oficial de la convocatoria. El examen de conocimientos se hace en catalán y sus preguntas salen de la Guia d'estudi de junio de 2026.",
    ca: "Resum de la convocatòria 46/26 de l'escala bàsica de Mossos d'Esquadra amb les dades de les bases oficials (Resolució ISP/1763/2026) i del web oficial de la convocatòria. L'examen de coneixements es fa en català i les preguntes surten de la Guia d'estudi de juny de 2026.",
  },
  facts: [
    {
      label: { es: "Bases", ca: "Bases" },
      value: {
        es: "Resolució ISP/1763/2026, de 3 de junio (DOGC 08/06/2026)",
        ca: "Resolució ISP/1763/2026, de 3 de juny (DOGC 08/06/2026)",
      },
    },
    {
      label: { es: "Plazas", ca: "Places" },
      value: {
        es: "1.587, de las cuales 634 reservadas a mujeres",
        ca: "1.587, de les quals 634 reservades a dones",
      },
    },
    {
      label: { es: "Puntuación de la 1.ª prueba", ca: "Puntuació de la 1a prova" },
      value: { es: "De 0 a 23 puntos", ca: "De 0 a 23 punts" },
    },
    {
      label: { es: "Temario", ca: "Temari" },
      value: {
        es: "Guia d'estudi, 1.ª edición, junio de 2026: 20 temas en los àmbits A, B y C, más actualidad (àmbit D)",
        ca: "Guia d'estudi, 1a edició, juny de 2026: 20 temes als àmbits A, B i C, més actualitat (àmbit D)",
      },
    },
  ],
  parts: [
    {
      name: { es: "Conocimientos", ca: "Coneixements" },
      detail: {
        es: "30 preguntas con 4 opciones y una correcta, 35 minutos. Cada error resta 1/4 y en blanco no resta. Nota de 0 a 10, mínimo 4.",
        ca: "30 preguntes amb 4 opcions i una de correcta, 35 minuts. Cada error resta 1/4 i en blanc no resta. Nota de 0 a 10, mínim 4.",
      },
    },
    {
      name: { es: "Aptitudes (psicotécnico)", ca: "Aptituds (psicotècnic)" },
      detail: {
        es: "80 preguntas en 35 minutos, sin penalización. Evalúa razonamiento abstracto y espacial y aptitud verbal, numérica y perceptiva. Nota de 0 a 10, mínimo 5.",
        ca: "80 preguntes en 35 minuts, sense penalització. Avalua raonament abstracte i espacial i aptitud verbal, numèrica i perceptiva. Nota de 0 a 10, mínim 5.",
      },
    },
    {
      name: { es: "Idiomas (voluntaria)", ca: "Idiomes (voluntària)" },
      detail: {
        es: "6 preguntas por idioma; cada error resta 1/4. 0,25 puntos por acierto, hasta 3 puntos.",
        ca: "6 preguntes per idioma; cada error resta 1/4. 0,25 punts per encert, fins a 3 punts.",
      },
    },
  ],
  calendar: [
    {
      label: { es: "Solicitudes", ca: "Sol·licituds" },
      value: { es: "Del 9 al 22 de junio de 2026", ca: "Del 9 al 22 de juny de 2026" },
    },
    {
      label: { es: "Primera prueba", ca: "Primera prova" },
      value: { es: "17 de octubre de 2026", ca: "17 d'octubre de 2026" },
    },
    {
      label: { es: "Resultados de la 1.ª prueba", ca: "Resultats de la 1a prova" },
      value: {
        es: "Previstos el 17 de noviembre de 2026",
        ca: "Previstos el 17 de novembre de 2026",
      },
    },
    {
      label: { es: "Prueba física", ca: "Prova física" },
      value: {
        es: "Del 23 de noviembre al 21 de diciembre de 2026",
        ca: "Del 23 de novembre al 21 de desembre de 2026",
      },
    },
  ],
  calendarNote: {
    es: "Previsión de calendario oficial actualizada el 21/09/2026. Las fechas pueden cambiar: consulta siempre la web oficial.",
    ca: "Previsió de calendari oficial actualitzada el 21/09/2026. Les dates poden canviar: consulta sempre el web oficial.",
  },
  psychoTypes: ["series", "letters", "numeric", "analogies", "matrices", "spatial", "attention"],
  psychoNote: {
    es: "Nuestro simulacro de aptitudes para Mossos combina estos siete tipos, que entrenan las aptitudes que evalúan las bases: abstracta, espacial, verbal, numérica y perceptiva.",
    ca: "El nostre simulacre d'aptituds per a Mossos combina aquests set tipus, que entrenen les aptituds que avaluen les bases: abstracta, espacial, verbal, numèrica i perceptiva.",
  },
  faq: [
    {
      q: {
        es: "¿Cuántas plazas tiene la convocatoria 46/26 de Mossos d'Esquadra?",
        ca: "Quantes places té la convocatòria 46/26 de Mossos d'Esquadra?",
      },
      a: {
        es: "1.587 plazas, de las cuales 634 están reservadas a mujeres, según la Resolució ISP/1763/2026.",
        ca: "1.587 places, de les quals 634 estan reservades a dones, segons la Resolució ISP/1763/2026.",
      },
    },
    {
      q: {
        es: "¿Cómo es el examen de conocimientos de Mossos?",
        ca: "Com és l'examen de coneixements de Mossos?",
      },
      a: {
        es: "Son 30 preguntas en catalán con 4 opciones y una correcta, en 35 minutos. Cada error resta 1/4 y hay que sacar al menos un 4 sobre 10. Las preguntas salen de la Guia d'estudi de junio de 2026.",
        ca: "Són 30 preguntes en català amb 4 opcions i una de correcta, en 35 minuts. Cada error resta 1/4 i cal treure com a mínim un 4 sobre 10. Les preguntes surten de la Guia d'estudi de juny de 2026.",
      },
    },
    {
      q: {
        es: "¿Qué evalúa el psicotécnico de Mossos?",
        ca: "Què avalua el psicotècnic de Mossos?",
      },
      a: {
        es: "La subprueba de aptitudes tiene 80 preguntas en 35 minutos, sin penalización, y evalúa razonamiento abstracto y espacial y aptitud verbal, numérica y perceptiva. Hay que sacar al menos un 5 sobre 10.",
        ca: "La subprova d'aptituds té 80 preguntes en 35 minuts, sense penalització, i avalua raonament abstracte i espacial i aptitud verbal, numèrica i perceptiva. Cal treure com a mínim un 5 sobre 10.",
      },
    },
    {
      q: {
        es: "¿Cuándo es la prueba física de Mossos 2026?",
        ca: "Quan és la prova física de Mossos 2026?",
      },
      a: {
        es: "Según la previsión oficial de calendario (21/09/2026), del 23 de noviembre al 21 de diciembre de 2026.",
        ca: "Segons la previsió oficial de calendari (21/09/2026), del 23 de novembre al 21 de desembre de 2026.",
      },
    },
  ],
  sources: [
    {
      title: "Web oficial de la convocatòria 46/26 (Mossos d'Esquadra)",
      url: "https://mossos.gencat.cat/ca/els_mossos_desquadra/acces_al_cos/Mosso_a/mosso-a-convocatoria-46-26/",
    },
    {
      title: "Resolució ISP/1763/2026, de 3 de juny (DOGC)",
      url: "https://dogc.gencat.cat/ca/document-del-dogc/?documentId=1046460",
    },
    {
      title: "Guia d'estudi, 1a edició, juny de 2026",
      url: "https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Guia_Mossos_Edicio_Juny_2026.pdf",
    },
    {
      title: "Resolució INT/1219/2017 (temari, DOGC 7382)",
      url: "https://dogc.gencat.cat/ca/document-del-dogc/?documentId=788502",
    },
  ],
};

const auxiliar: ExamGuide = {
  slug: "auxiliar-administrativo-estado",
  verifiedOn: "2026-11-04",
  h1: {
    es: "Oposiciones a Auxiliar Administrativo del Estado",
    ca: "Oposicions a Auxiliar Administratiu de l'Estat",
  },
  seoTitle: {
    es: "Auxiliar Administrativo del Estado: examen, temario y psicotécnicos",
    ca: "Auxiliar Administratiu de l'Estat: examen, temari i psicotècnics",
  },
  seoDescription: {
    es: "Convocatoria BOE-A-2025-26262: 1.700 plazas, ejercicio único de 90 minutos con 30 preguntas del Bloque I, 30 psicotécnicas y 50 del Bloque II. Notas de corte de 2025 y fuentes oficiales.",
    ca: "Convocatòria BOE-A-2025-26262: 1.700 places, exercici únic de 90 minuts amb 30 preguntes del Bloc I, 30 psicotècniques i 50 del Bloc II. Notes de tall del 2025 i fonts oficials.",
  },
  intro: {
    es: "Resumen de la última convocatoria de ingreso libre en el Cuerpo General Auxiliar de la Administración del Estado (Resolución de 18 de diciembre de 2025, BOE de 22/12/2025) y de los criterios publicados por el INAP para el examen del 23 de mayo de 2026.",
    ca: "Resum de l'última convocatòria d'ingrés lliure al Cos General Auxiliar de l'Administració de l'Estat (Resolució de 18 de desembre de 2025, BOE de 22/12/2025) i dels criteris publicats per l'INAP per a l'examen del 23 de maig de 2026.",
  },
  facts: [
    {
      label: { es: "Convocatoria", ca: "Convocatòria" },
      value: {
        es: "BOE-A-2025-26262 (BOE núm. 306, 22/12/2025), Anexo I",
        ca: "BOE-A-2025-26262 (BOE núm. 306, 22/12/2025), Annex I",
      },
    },
    {
      label: { es: "Plazas", ca: "Places" },
      value: {
        es: "1.700 (156 reservadas a personas con discapacidad)",
        ca: "1.700 (156 reservades a persones amb discapacitat)",
      },
    },
    {
      label: { es: "Titulación", ca: "Titulació" },
      value: { es: "Graduado en ESO", ca: "Graduat en ESO" },
    },
    {
      label: { es: "Tasa", ca: "Taxa" },
      value: { es: "11,66 €", ca: "11,66 €" },
    },
    {
      label: { es: "Programa", ca: "Programa" },
      value: {
        es: "Bloque I (16 temas, organización pública) y Bloque II (12 temas, actividad administrativa y ofimática)",
        ca: "Bloc I (16 temes, organització pública) i Bloc II (12 temes, activitat administrativa i ofimàtica)",
      },
    },
  ],
  parts: [
    {
      name: { es: "Parte 1", ca: "Part 1" },
      detail: {
        es: "30 preguntas del Bloque I y 30 psicotécnicas (aptitudes administrativas, numéricas o verbales), más 5 de reserva. Se califica de 0 a 50.",
        ca: "30 preguntes del Bloc I i 30 psicotècniques (aptituds administratives, numèriques o verbals), més 5 de reserva. Es qualifica de 0 a 50.",
      },
    },
    {
      name: { es: "Parte 2", ca: "Part 2" },
      detail: {
        es: "50 preguntas del Bloque II (Windows 11 y Microsoft 365 de escritorio, entre otros temas), más 5 de reserva. Se califica de 0 a 50.",
        ca: "50 preguntes del Bloc II (Windows 11 i Microsoft 365 d'escriptori, entre altres temes), més 5 de reserva. Es qualifica de 0 a 50.",
      },
    },
    {
      name: { es: "Formato común", ca: "Format comú" },
      detail: {
        es: "Ejercicio único de 90 minutos con las dos partes a la vez, obligatorias y eliminatorias. 4 respuestas y una correcta; cada error resta 1/3 y en blanco no resta.",
        ca: "Exercici únic de 90 minuts amb les dues parts alhora, obligatòries i eliminatòries. 4 respostes i una de correcta; cada error resta 1/3 i en blanc no resta.",
      },
    },
  ],
  calendar: [
    {
      label: { es: "Examen de la convocatoria 2025", ca: "Examen de la convocatòria 2025" },
      value: { es: "23 de mayo de 2026", ca: "23 de maig de 2026" },
    },
    {
      label: { es: "Nota de corte 2025, parte 1", ca: "Nota de tall 2025, part 1" },
      value: {
        es: "29,00 de 60 (sistema general)",
        ca: "29,00 de 60 (sistema general)",
      },
    },
    {
      label: { es: "Nota de corte 2025, parte 2", ca: "Nota de tall 2025, part 2" },
      value: {
        es: "21,33 de 50 (sistema general)",
        ca: "21,33 de 50 (sistema general)",
      },
    },
  ],
  calendarNote: {
    es: "Puntuaciones directas mínimas publicadas por el INAP el 15/10/2026. Cambian en cada convocatoria.",
    ca: "Puntuacions directes mínimes publicades per l'INAP el 15/10/2026. Canvien a cada convocatòria.",
  },
  psychoTypes: ["tables", "percentages", "equations", "series", "probability", "codes"],
  psychoNote: {
    es: "En los exámenes de 2024 y 2025 salieron tablas (12 preguntas cada año), porcentajes y fracciones, series numéricas, ecuaciones, probabilidad y codificación, además de ortografía y sinónimos.",
    ca: "Als exàmens del 2024 i el 2025 van sortir taules (12 preguntes cada any), percentatges i fraccions, sèries numèriques, equacions, probabilitat i codificació, a més d'ortografia i sinònims.",
  },
  faq: [
    {
      q: {
        es: "¿Cuántas plazas tiene la última convocatoria de Auxiliar Administrativo del Estado?",
        ca: "Quantes places té l'última convocatòria d'Auxiliar Administratiu de l'Estat?",
      },
      a: {
        es: "1.700 plazas de ingreso libre, de las cuales 156 están reservadas a personas con discapacidad (BOE-A-2025-26262).",
        ca: "1.700 places d'ingrés lliure, de les quals 156 estan reservades a persones amb discapacitat (BOE-A-2025-26262).",
      },
    },
    {
      q: {
        es: "¿Cómo es el examen de Auxiliar Administrativo del Estado?",
        ca: "Com és l'examen d'Auxiliar Administratiu de l'Estat?",
      },
      a: {
        es: "Es un ejercicio único de 90 minutos con dos partes: la primera tiene 30 preguntas del Bloque I y 30 psicotécnicas, y la segunda 50 preguntas del Bloque II. Cada pregunta tiene 4 opciones y cada error resta 1/3.",
        ca: "És un exercici únic de 90 minuts amb dues parts: la primera té 30 preguntes del Bloc I i 30 psicotècniques, i la segona 50 preguntes del Bloc II. Cada pregunta té 4 opcions i cada error resta 1/3.",
      },
    },
    {
      q: {
        es: "¿Qué nota de corte hubo en Auxiliar Administrativo del Estado en 2025?",
        ca: "Quina nota de tall hi va haver a Auxiliar Administratiu de l'Estat el 2025?",
      },
      a: {
        es: "En el sistema general, 29,00 puntos directos de 60 en la parte 1 y 21,33 de 50 en la parte 2, según la nota del INAP de 15/10/2026.",
        ca: "Al sistema general, 29,00 punts directes de 60 a la part 1 i 21,33 de 50 a la part 2, segons la nota de l'INAP de 15/10/2026.",
      },
    },
    {
      q: {
        es: "¿Qué psicotécnicos salen en Auxiliar Administrativo del Estado?",
        ca: "Quins psicotècnics surten a Auxiliar Administratiu de l'Estat?",
      },
      a: {
        es: "En 2024 y 2025: interpretación de tablas (12 preguntas), porcentajes y fracciones, series numéricas, ecuaciones de primer grado, probabilidad, codificación, ortografía y sinónimos y antónimos.",
        ca: "El 2024 i el 2025: interpretació de taules (12 preguntes), percentatges i fraccions, sèries numèriques, equacions de primer grau, probabilitat, codificació, ortografia i sinònims i antònims.",
      },
    },
  ],
  sources: [
    {
      title: "Resolución de 18 de diciembre de 2025 (BOE-A-2025-26262)",
      url: "https://www.boe.es/diario_boe/txt.php?id=BOE-A-2025-26262",
    },
    {
      title: "Sede electrónica del INAP · procesos selectivos",
      url: "https://sede.inap.gob.es/",
    },
  ],
};

const GUIDES: Record<string, ExamGuide> = {
  [mossos.slug]: mossos,
  [auxiliar.slug]: auxiliar,
};

export const getExamGuide = (slug: string): ExamGuide | undefined => GUIDES[slug];
export const examGuides = (): ExamGuide[] => Object.values(GUIDES);
export { tr } from "./psycho-guides";
