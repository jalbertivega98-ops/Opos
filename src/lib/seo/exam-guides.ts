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

const administrativo: ExamGuide = {
  slug: "administrativo-estado",
  verifiedOn: "2026-11-05",
  h1: {
    es: "Oposiciones a Administrativo del Estado",
    ca: "Oposicions a Administratiu de l'Estat",
  },
  seoTitle: {
    es: "Administrativo del Estado: examen, temario, supuesto y notas de corte",
    ca: "Administratiu de l'Estat: examen, temari, supòsit i notes de tall",
  },
  seoDescription: {
    es: "Convocatoria BOE-A-2025-26262 del Cuerpo General Administrativo: ejercicio único de 100 minutos con 70 preguntas y un supuesto práctico de 20, cada error resta 1/3. Notas de corte reales y fuentes oficiales.",
    ca: "Convocatòria BOE-A-2025-26262 del Cos General Administratiu: exercici únic de 100 minuts amb 70 preguntes i un supòsit pràctic de 20, cada error resta 1/3. Notes de tall reals i fonts oficials.",
  },
  intro: {
    es: "Resumen de la última convocatoria de ingreso libre en el Cuerpo General Administrativo de la Administración del Estado (BOE-A-2025-26262) y de los exámenes publicados por el INAP. Nuestros simulacros siguen el reparto por temas de los exámenes de 2020 a 2025 y repiten pregunta a pregunta los de 2025 y 2024.",
    ca: "Resum de l'última convocatòria d'ingrés lliure al Cos General Administratiu de l'Administració de l'Estat (BOE-A-2025-26262) i dels exàmens publicats per l'INAP. Els nostres simulacres segueixen el repartiment per temes dels exàmens del 2020 al 2025 i repeteixen pregunta a pregunta els del 2025 i el 2024.",
  },
  facts: [
    {
      label: { es: "Convocatoria", ca: "Convocatòria" },
      value: { es: "BOE-A-2025-26262, Anexo III", ca: "BOE-A-2025-26262, Annex III" },
    },
    { label: { es: "Plazas", ca: "Places" }, value: { es: "2.512", ca: "2.512" } },
    {
      label: { es: "Programa", ca: "Programa" },
      value: {
        es: "Seis bloques: organización del Estado, organización de oficinas, derecho administrativo, gestión de personal, gestión financiera e informática y ofimática",
        ca: "Sis blocs: organització de l'Estat, organització d'oficines, dret administratiu, gestió de personal, gestió financera i informàtica i ofimàtica",
      },
    },
  ],
  parts: [
    {
      name: { es: "Primera parte", ca: "Primera part" },
      detail: {
        es: "70 preguntas: 40 de los bloques I a V y 30 de informática y ofimática (bloque VI), más 5 de reserva. Se califica de 0 a 50 y hay que llegar a 25.",
        ca: "70 preguntes: 40 dels blocs I a V i 30 d'informàtica i ofimàtica (bloc VI), més 5 de reserva. Es qualifica de 0 a 50 i cal arribar a 25.",
      },
    },
    {
      name: { es: "Segunda parte (supuesto práctico)", ca: "Segona part (supòsit pràctic)" },
      detail: {
        es: "Un supuesto a elegir entre dos, con 20 preguntas (más 5 de reserva) sobre los bloques III, IV y V. Se califica de 0 a 50 y hay que llegar a 25.",
        ca: "Un supòsit a triar entre dos, amb 20 preguntes (més 5 de reserva) sobre els blocs III, IV i V. Es qualifica de 0 a 50 i cal arribar a 25.",
      },
    },
    {
      name: { es: "Formato común", ca: "Format comú" },
      detail: {
        es: "Ejercicio único de 100 minutos con las dos partes. 4 respuestas y una correcta; cada error resta 1/3 y en blanco no resta.",
        ca: "Exercici únic de 100 minuts amb les dues parts. 4 respostes i una de correcta; cada error resta 1/3 i en blanc no resta.",
      },
    },
  ],
  calendar: [
    {
      label: { es: "Examen de la convocatoria 2025", ca: "Examen de la convocatòria 2025" },
      value: { es: "Mayo de 2026", ca: "Maig de 2026" },
    },
    {
      label: { es: "Nota de corte 2025, primera parte", ca: "Nota de tall 2025, primera part" },
      value: {
        es: "31,67 netas de 70 (sistema general)",
        ca: "31,67 netes de 70 (sistema general)",
      },
    },
    {
      label: { es: "Nota de corte 2025, segunda parte", ca: "Nota de tall 2025, segona part" },
      value: {
        es: "12,67 netas de 20 (sistema general)",
        ca: "12,67 netes de 20 (sistema general)",
      },
    },
  ],
  calendarNote: {
    es: "Puntuaciones mínimas publicadas por el INAP. En 2021-2025 el corte de la primera parte estuvo entre 31,3 y 33,3 netas; cambia en cada convocatoria.",
    ca: "Puntuacions mínimes publicades per l'INAP. Del 2021 al 2025 el tall de la primera part va estar entre 31,3 i 33,3 netes; canvia a cada convocatòria.",
  },
  psychoTypes: [],
  psychoNote: { es: "", ca: "" },
  faq: [
    {
      q: {
        es: "¿Cómo es el examen de Administrativo del Estado?",
        ca: "Com és l'examen d'Administratiu de l'Estat?",
      },
      a: {
        es: "Un ejercicio único de 100 minutos: 70 preguntas de test (40 de los bloques I a V y 30 de ofimática) y un supuesto práctico de 20 preguntas. Cada error resta 1/3 y cada parte se califica de 0 a 50, con un mínimo de 25.",
        ca: "Un exercici únic de 100 minuts: 70 preguntes de test (40 dels blocs I a V i 30 d'ofimàtica) i un supòsit pràctic de 20 preguntes. Cada error resta 1/3 i cada part es qualifica de 0 a 50, amb un mínim de 25.",
      },
    },
    {
      q: {
        es: "¿Hay psicotécnicos en Administrativo del Estado?",
        ca: "Hi ha psicotècnics a Administratiu de l'Estat?",
      },
      a: {
        es: "No. A diferencia de Auxiliar, la convocatoria de Administrativo no tiene preguntas psicotécnicas.",
        ca: "No. A diferència d'Auxiliar, la convocatòria d'Administratiu no té preguntes psicotècniques.",
      },
    },
    {
      q: {
        es: "¿Qué nota de corte hubo en Administrativo del Estado en 2025?",
        ca: "Quina nota de tall hi va haver a Administratiu de l'Estat el 2025?",
      },
      a: {
        es: "En el sistema general, 31,67 netas en la primera parte y 12,67 en la segunda, según la nota de puntuaciones mínimas del INAP.",
        ca: "Al sistema general, 31,67 netes a la primera part i 12,67 a la segona, segons la nota de puntuacions mínimes de l'INAP.",
      },
    },
  ],
  sources: [
    {
      title: "Resolución de 18 de diciembre de 2025 (BOE-A-2025-26262)",
      url: "https://www.boe.es/diario_boe/txt.php?id=BOE-A-2025-26262",
    },
    {
      title: "Sede del INAP · Cuerpo General Administrativo",
      url: "https://sede.inap.gob.es/es/procedimientos-y-servicios/seleccion/procesos-selectivos-de-cuerpos-y-escalas-generales/cuerpo-general-administrativo-de-la-administracion-del-estado",
    },
  ],
};

const auxilio: ExamGuide = {
  slug: "auxilio-judicial",
  verifiedOn: "2026-11-05",
  h1: { es: "Oposiciones a Auxilio Judicial", ca: "Oposicions a Auxili Judicial" },
  seoTitle: {
    es: "Auxilio Judicial: examen, temario, casos prácticos y notas",
    ca: "Auxili Judicial: examen, temari, casos pràctics i notes",
  },
  seoDescription: {
    es: "Convocatoria de Auxilio Judicial (Orden PJC/1549/2025): test de 100 preguntas y dos casos prácticos de 40 preguntas, con su puntuación oficial. Temario y fuentes oficiales.",
    ca: "Convocatòria d'Auxili Judicial (Ordre PJC/1549/2025): test de 100 preguntes i dos casos pràctics de 40 preguntes, amb la puntuació oficial. Temari i fonts oficials.",
  },
  intro: {
    es: "Resumen de la convocatoria del Cuerpo de Auxilio Judicial (Orden PJC/1549/2025, BOE-A-2025-27053) y del examen del 3 de octubre de 2026 publicado por el Ministerio de Justicia. Nuestros simulacros repiten pregunta a pregunta los dos ejercicios de 2026.",
    ca: "Resum de la convocatòria del Cos d'Auxili Judicial (Ordre PJC/1549/2025, BOE-A-2025-27053) i de l'examen del 3 d'octubre de 2026 publicat pel Ministeri de Justícia. Els nostres simulacres repeteixen pregunta a pregunta els dos exercicis del 2026.",
  },
  facts: [
    {
      label: { es: "Convocatoria", ca: "Convocatòria" },
      value: {
        es: "Orden PJC/1549/2025 (BOE-A-2025-27053)",
        ca: "Ordre PJC/1549/2025 (BOE-A-2025-27053)",
      },
    },
    { label: { es: "Plazas", ca: "Places" }, value: { es: "425", ca: "425" } },
    {
      label: { es: "Programa", ca: "Programa" },
      value: {
        es: "26 temas: organización del Estado y de la Justicia, cuerpos de funcionarios, procedimientos, actos de comunicación, Registro Civil y archivo",
        ca: "26 temes: organització de l'Estat i de la Justícia, cossos de funcionaris, procediments, actes de comunicació, Registre Civil i arxiu",
      },
    },
  ],
  parts: [
    {
      name: { es: "Primer ejercicio (test)", ca: "Primer exercici (test)" },
      detail: {
        es: "100 preguntas de 4 opciones (más 4 de reserva) en 100 minutos. Cada acierto vale 0,60 y cada error resta 0,15. Nota de 0 a 60; mínimo 30.",
        ca: "100 preguntes de 4 opcions (més 4 de reserva) en 100 minuts. Cada encert val 0,60 i cada error resta 0,15. Nota de 0 a 60; mínim 30.",
      },
    },
    {
      name: { es: "Segundo ejercicio (casos prácticos)", ca: "Segon exercici (casos pràctics)" },
      detail: {
        es: "Dos casos con 40 preguntas en total (más 2 de reserva) en 60 minutos. Cada acierto vale 1 y cada error resta 0,25. Nota de 0 a 40; mínimo 20.",
        ca: "Dos casos amb 40 preguntes en total (més 2 de reserva) en 60 minuts. Cada encert val 1 i cada error resta 0,25. Nota de 0 a 40; mínim 20.",
      },
    },
  ],
  calendar: [
    {
      label: { es: "Examen de la convocatoria", ca: "Examen de la convocatòria" },
      value: { es: "3 de octubre de 2026", ca: "3 d'octubre de 2026" },
    },
  ],
  calendarNote: {
    es: "Datos de la convocatoria y de las plantillas definitivas publicadas por el Ministerio de Justicia.",
    ca: "Dades de la convocatòria i de les plantilles definitives publicades pel Ministeri de Justícia.",
  },
  psychoTypes: [],
  psychoNote: { es: "", ca: "" },
  faq: [
    {
      q: {
        es: "¿Cómo es el examen de Auxilio Judicial?",
        ca: "Com és l'examen d'Auxili Judicial?",
      },
      a: {
        es: "Dos ejercicios el mismo día: un test de 100 preguntas en 100 minutos (0,60 por acierto, −0,15 por error, mínimo 30 de 60) y dos casos prácticos con 40 preguntas en 60 minutos (1 por acierto, −0,25 por error, mínimo 20 de 40).",
        ca: "Dos exercicis el mateix dia: un test de 100 preguntes en 100 minuts (0,60 per encert, −0,15 per error, mínim 30 de 60) i dos casos pràctics amb 40 preguntes en 60 minuts (1 per encert, −0,25 per error, mínim 20 de 40).",
      },
    },
    {
      q: {
        es: "¿Hay psicotécnicos en Auxilio Judicial?",
        ca: "Hi ha psicotècnics a Auxili Judicial?",
      },
      a: {
        es: "No. La convocatoria no incluye ninguna prueba psicotécnica.",
        ca: "No. La convocatòria no inclou cap prova psicotècnica.",
      },
    },
  ],
  sources: [
    {
      title: "Orden PJC/1549/2025 (BOE-A-2025-27053)",
      url: "https://www.boe.es/diario_boe/txt.php?id=BOE-A-2025-27053",
    },
    {
      title: "Ministerio de Justicia · Auxilio Judicial (PJC/1549/2025)",
      url: "https://www.mjusticia.gob.es/es/ciudadania/empleo-publico/acceso-libre/Auxilio-Judicial-PJC15492025",
    },
  ],
};

const tramitacion: ExamGuide = {
  slug: "tramitacion-procesal",
  verifiedOn: "2026-11-05",
  h1: {
    es: "Oposiciones a Tramitación Procesal y Administrativa",
    ca: "Oposicions a Tramitació Processal i Administrativa",
  },
  seoTitle: {
    es: "Tramitación Procesal: examen, temario, caso práctico y ofimática",
    ca: "Tramitació Processal: examen, temari, cas pràctic i ofimàtica",
  },
  seoDescription: {
    es: "Convocatoria de Tramitación Procesal y Administrativa (Orden PJC/1549/2025): test de 100 preguntas, caso práctico de 10 y ofimática de 20, con su puntuación oficial.",
    ca: "Convocatòria de Tramitació Processal i Administrativa (Ordre PJC/1549/2025): test de 100 preguntes, cas pràctic de 10 i ofimàtica de 20, amb la puntuació oficial.",
  },
  intro: {
    es: "Resumen de la convocatoria del Cuerpo de Tramitación Procesal y Administrativa (Orden PJC/1549/2025, BOE-A-2025-27053) y del examen del 3 de octubre de 2026 publicado por el Ministerio de Justicia. Nuestros simulacros siguen el reparto por temas de ese examen y repiten pregunta a pregunta sus tres ejercicios.",
    ca: "Resum de la convocatòria del Cos de Tramitació Processal i Administrativa (Ordre PJC/1549/2025, BOE-A-2025-27053) i de l'examen del 3 d'octubre de 2026 publicat pel Ministeri de Justícia. Els nostres simulacres segueixen el repartiment per temes d'aquell examen i en repeteixen pregunta a pregunta els tres exercicis.",
  },
  facts: [
    {
      label: { es: "Convocatoria", ca: "Convocatòria" },
      value: {
        es: "Orden PJC/1549/2025 (BOE-A-2025-27053)",
        ca: "Ordre PJC/1549/2025 (BOE-A-2025-27053)",
      },
    },
    { label: { es: "Plazas", ca: "Places" }, value: { es: "1.155", ca: "1.155" } },
    {
      label: { es: "Programa", ca: "Programa" },
      value: {
        es: "37 temas: 31 de organización y derecho procesal y 6 de ofimática (Windows y Microsoft 365)",
        ca: "37 temes: 31 d'organització i dret processal i 6 d'ofimàtica (Windows i Microsoft 365)",
      },
    },
  ],
  parts: [
    {
      name: { es: "Primer ejercicio (test)", ca: "Primer exercici (test)" },
      detail: {
        es: "100 preguntas de 4 opciones sobre los temas 1 a 31 (más 4 de reserva) en 100 minutos. Cada acierto vale 0,60 y cada error resta 0,15. Nota de 0 a 60; mínimo 30.",
        ca: "100 preguntes de 4 opcions sobre els temes 1 a 31 (més 4 de reserva) en 100 minuts. Cada encert val 0,60 i cada error resta 0,15. Nota de 0 a 60; mínim 30.",
      },
    },
    {
      name: { es: "Segundo ejercicio (caso práctico)", ca: "Segon exercici (cas pràctic)" },
      detail: {
        es: "Un caso con 10 preguntas (más 2 de reserva) en 30 minutos. Cada acierto vale 2 y cada error resta 0,50. Nota de 0 a 20; mínimo 10.",
        ca: "Un cas amb 10 preguntes (més 2 de reserva) en 30 minuts. Cada encert val 2 i cada error resta 0,50. Nota de 0 a 20; mínim 10.",
      },
    },
    {
      name: { es: "Tercer ejercicio (ofimática)", ca: "Tercer exercici (ofimàtica)" },
      detail: {
        es: "20 preguntas tipo test (más 4 de reserva) sobre Windows y Microsoft 365 en 40 minutos. Cada acierto vale 1 y cada error resta 0,25. Nota de 0 a 20; mínimo 10.",
        ca: "20 preguntes tipus test (més 4 de reserva) sobre Windows i Microsoft 365 en 40 minuts. Cada encert val 1 i cada error resta 0,25. Nota de 0 a 20; mínim 10.",
      },
    },
  ],
  calendar: [
    {
      label: { es: "Examen de la convocatoria", ca: "Examen de la convocatòria" },
      value: { es: "3 de octubre de 2026", ca: "3 d'octubre de 2026" },
    },
  ],
  calendarNote: {
    es: "Datos de la convocatoria y de las plantillas definitivas publicadas por el Ministerio de Justicia.",
    ca: "Dades de la convocatòria i de les plantilles definitives publicades pel Ministeri de Justícia.",
  },
  psychoTypes: [],
  psychoNote: { es: "", ca: "" },
  faq: [
    {
      q: {
        es: "¿Cómo es el examen de Tramitación Procesal?",
        ca: "Com és l'examen de Tramitació Processal?",
      },
      a: {
        es: "Tres ejercicios: un test de 100 preguntas en 100 minutos (mínimo 30 de 60), un caso práctico de 10 preguntas en 30 minutos (mínimo 10 de 20) y un test de ofimática de 20 preguntas en 40 minutos (mínimo 10 de 20).",
        ca: "Tres exercicis: un test de 100 preguntes en 100 minuts (mínim 30 de 60), un cas pràctic de 10 preguntes en 30 minuts (mínim 10 de 20) i un test d'ofimàtica de 20 preguntes en 40 minuts (mínim 10 de 20).",
      },
    },
    {
      q: {
        es: "¿La ofimática de Tramitación es práctica con ordenador?",
        ca: "L'ofimàtica de Tramitació és pràctica amb ordinador?",
      },
      a: {
        es: "No. En 2026 fue un test de 20 preguntas sobre Windows y Microsoft 365, sobre todo Word (atajos de teclado y rutas de menús).",
        ca: "No. El 2026 va ser un test de 20 preguntes sobre Windows i Microsoft 365, sobretot Word (dreceres de teclat i rutes de menús).",
      },
    },
    {
      q: {
        es: "¿Hay psicotécnicos en Tramitación Procesal?",
        ca: "Hi ha psicotècnics a Tramitació Processal?",
      },
      a: {
        es: "No. La convocatoria no incluye ninguna prueba psicotécnica.",
        ca: "No. La convocatòria no inclou cap prova psicotècnica.",
      },
    },
  ],
  sources: [
    {
      title: "Orden PJC/1549/2025 (BOE-A-2025-27053)",
      url: "https://www.boe.es/diario_boe/txt.php?id=BOE-A-2025-27053",
    },
    {
      title: "Ministerio de Justicia · Tramitación Procesal (PJC/1549/2025)",
      url: "https://www.mjusticia.gob.es/es/ciudadania/empleo-publico/acceso-libre/Tramitaci%C3%B3n-PA-PJC15492025",
    },
  ],
};

const policiaNacional: ExamGuide = {
  slug: "policia-nacional-basica",
  verifiedOn: "2026-11-05",
  h1: {
    es: "Oposiciones a Policía Nacional (Escala Básica)",
    ca: "Oposicions a Policia Nacional (Escala Bàsica)",
  },
  seoTitle: {
    es: "Policía Nacional Escala Básica: examen, temario y nota de corte",
    ca: "Policia Nacional Escala Bàsica: examen, temari i nota de tall",
  },
  seoDescription: {
    es: "Convocatoria BOE-A-2026-15055 de Policía Nacional: prueba de conocimientos de 100 preguntas con 3 alternativas en 50 minutos, cada error resta medio acierto. Nota de corte 2026: 7,05.",
    ca: "Convocatòria BOE-A-2026-15055 de Policia Nacional: prova de coneixements de 100 preguntes amb 3 alternatives en 50 minuts, cada error resta mig encert. Nota de tall 2026: 7,05.",
  },
  intro: {
    es: "Resumen de la convocatoria de la Escala Básica de Policía Nacional (Resolución de 7 de julio de 2026, BOE-A-2026-15055). La Policía no publica los cuestionarios, así que nuestros simulacros siguen el reparto por temas del programa oficial y la nota de corte real.",
    ca: "Resum de la convocatòria de l'Escala Bàsica de Policia Nacional (Resolució de 7 de juliol de 2026, BOE-A-2026-15055). La Policia no publica els qüestionaris, de manera que els nostres simulacres segueixen el repartiment per temes del programa oficial i la nota de tall real.",
  },
  facts: [
    {
      label: { es: "Convocatoria", ca: "Convocatòria" },
      value: { es: "BOE-A-2026-15055 (10/07/2026)", ca: "BOE-A-2026-15055 (10/07/2026)" },
    },
    { label: { es: "Plazas", ca: "Places" }, value: { es: "2.704", ca: "2.704" } },
    {
      label: { es: "Programa", ca: "Programa" },
      value: {
        es: "45 temas: Ciencias Jurídicas (1-26), Ciencias Sociales (27-37) y Materias Técnico-Científicas (38-45)",
        ca: "45 temes: Ciències Jurídiques (1-26), Ciències Socials (27-37) i Matèries Tècnico-Científiques (38-45)",
      },
    },
  ],
  parts: [
    {
      name: { es: "Conocimientos", ca: "Coneixements" },
      detail: {
        es: "100 preguntas con 3 alternativas en 50 minutos. Cada error resta medio acierto (fórmula de la convocatoria). Nota de 0 a 10; el mínimo de las bases es 3, pero pasa quien supera la nota de corte (7,05 en 2026).",
        ca: "100 preguntes amb 3 alternatives en 50 minuts. Cada error resta mig encert (fórmula de la convocatòria). Nota de 0 a 10; el mínim de les bases és 3, però passa qui supera la nota de tall (7,05 el 2026).",
      },
    },
    {
      name: { es: "El mismo día", ca: "El mateix dia" },
      detail: {
        es: "Test psicotécnico de aptitudes, perfil de personalidad y cuestionario biográfico, que cuentan en la tercera prueba. Después, pruebas físicas, entrevista y reconocimiento médico.",
        ca: "Test psicotècnic d'aptituds, perfil de personalitat i qüestionari biogràfic, que compten a la tercera prova. Després, proves físiques, entrevista i reconeixement mèdic.",
      },
    },
  ],
  calendar: [
    {
      label: { es: "Prueba de conocimientos (EB43)", ca: "Prova de coneixements (EB43)" },
      value: { es: "26 de septiembre de 2026", ca: "26 de setembre de 2026" },
    },
    {
      label: { es: "Nota de corte 2026", ca: "Nota de tall 2026" },
      value: { es: "7,05 sobre 10", ca: "7,05 sobre 10" },
    },
    {
      label: { es: "Nota de corte 2025 (aproximada)", ca: "Nota de tall 2025 (aproximada)" },
      value: { es: "7,17 sobre 10", ca: "7,17 sobre 10" },
    },
  ],
  calendarNote: {
    es: "Acuerdos del Tribunal publicados en el Portal del Aspirante. El corte depende de las plazas y del número de aspirantes.",
    ca: "Acords del Tribunal publicats al Portal de l'Aspirant. El tall depèn de les places i del nombre d'aspirants.",
  },
  psychoTypes: [],
  psychoNote: { es: "", ca: "" },
  faq: [
    {
      q: {
        es: "¿Cómo es el examen de Policía Nacional?",
        ca: "Com és l'examen de Policia Nacional?",
      },
      a: {
        es: "La prueba de conocimientos tiene 100 preguntas con 3 alternativas en 50 minutos y cada error resta medio acierto. En 2026 pasó a la siguiente fase quien sacó al menos un 7,05 sobre 10.",
        ca: "La prova de coneixements té 100 preguntes amb 3 alternatives en 50 minuts i cada error resta mig encert. El 2026 va passar a la fase següent qui va treure com a mínim un 7,05 sobre 10.",
      },
    },
    {
      q: {
        es: "¿Se publican los exámenes de Policía Nacional?",
        ca: "Es publiquen els exàmens de Policia Nacional?",
      },
      a: {
        es: "No. La hoja de respuestas es individual y el cuestionario no se publica en la web oficial, por eso practicamos con el reparto por temas del programa.",
        ca: "No. El full de respostes és individual i el qüestionari no es publica al web oficial; per això practiquem amb el repartiment per temes del programa.",
      },
    },
  ],
  sources: [
    {
      title: "Resolución de 7 de julio de 2026 (BOE-A-2026-15055)",
      url: "https://www.boe.es/diario_boe/txt.php?id=BOE-A-2026-15055",
    },
    {
      title: "Portal del Aspirante · Acuerdo del Tribunal BAS43",
      url: "https://www.policia.es/portalaspirantes/web/escala-basica-ejecutiva/-/bas43-acuerdo-del-tribunal-calificador",
    },
  ],
};

const guardiaCivil: ExamGuide = {
  slug: "guardia-civil-cabos-guardias",
  verifiedOn: "2026-11-05",
  h1: {
    es: "Oposiciones a Guardia Civil (Cabos y Guardias)",
    ca: "Oposicions a Guàrdia Civil (Caporals i Guàrdies)",
  },
  seoTitle: {
    es: "Guardia Civil Cabos y Guardias: examen, temario, ortografía e inglés",
    ca: "Guàrdia Civil Caporals i Guàrdies: examen, temari, ortografia i anglès",
  },
  seoDescription: {
    es: "Convocatoria BOE-A-2026-9982: 3.240 plazas. Ortografía, gramática, 100 preguntas de conocimientos e inglés en 140 minutos, y la prueba de aptitudes intelectuales.",
    ca: "Convocatòria BOE-A-2026-9982: 3.240 places. Ortografia, gramàtica, 100 preguntes de coneixements i anglès en 140 minuts, i la prova d'aptituds intel·lectuals.",
  },
  intro: {
    es: "Resumen de la convocatoria de ingreso en la Escala de Cabos y Guardias de la Guardia Civil (Resolución 160/38243/2026, BOE-A-2026-9982) y de las plantillas de 2026. La Guardia Civil publica las plantillas pero no los cuestionarios, así que nuestro simulacro sigue el reparto por temas del programa.",
    ca: "Resum de la convocatòria d'ingrés a l'Escala de Caporals i Guàrdies de la Guàrdia Civil (Resolució 160/38243/2026, BOE-A-2026-9982) i de les plantilles del 2026. La Guàrdia Civil publica les plantilles però no els qüestionaris; per això el nostre simulacre segueix el repartiment per temes del programa.",
  },
  facts: [
    {
      label: { es: "Convocatoria", ca: "Convocatòria" },
      value: {
        es: "Resolución 160/38243/2026 (BOE-A-2026-9982, 08/05/2026)",
        ca: "Resolució 160/38243/2026 (BOE-A-2026-9982, 08/05/2026)",
      },
    },
    { label: { es: "Plazas", ca: "Places" }, value: { es: "3.240", ca: "3.240" } },
    {
      label: { es: "Programa", ca: "Programa" },
      value: {
        es: "25 temas: 23 de conocimientos, más lengua española e inglés",
        ca: "25 temes: 23 de coneixements, més llengua castellana i anglès",
      },
    },
  ],
  parts: [
    {
      name: { es: "Conocimientos", ca: "Coneixements" },
      detail: {
        es: "100 preguntas de 4 opciones (más 5 de reserva); cada error resta 1/3. Nota de 0 a 100 y mínimo 50 (en 2026, la mediana de quienes pasaron fue 60).",
        ca: "100 preguntes de 4 opcions (més 5 de reserva); cada error resta 1/3. Nota de 0 a 100 i mínim 50 (el 2026, la mediana de qui va passar va ser 60).",
      },
    },
    {
      name: { es: "Ortografía y gramática", ca: "Ortografia i gramàtica" },
      detail: {
        es: "Dos rejillas de 20 casillas en las que se marcan las palabras o frases incorrectas. Apto o no apto: 6 o más errores es no apto. En 2026 solo el 56 % superó la gramática.",
        ca: "Dues graelles de 20 caselles on es marquen les paraules o frases incorrectes. Apte o no apte: 6 errors o més és no apte. El 2026 només el 56 % va superar la gramàtica.",
      },
    },
    {
      name: { es: "Inglés", ca: "Anglès" },
      detail: {
        es: "20 preguntas de 4 opciones; mínimo 8 de 20.",
        ca: "20 preguntes de 4 opcions; mínim 8 de 20.",
      },
    },
    {
      name: { es: "Aptitudes intelectuales", ca: "Aptituds intel·lectuals" },
      detail: {
        es: "80 preguntas en 55 minutos, el mismo día y por separado. Nota de 0 a 30; mínimo 12.",
        ca: "80 preguntes en 55 minuts, el mateix dia i per separat. Nota de 0 a 30; mínim 12.",
      },
    },
  ],
  calendar: [
    {
      label: { es: "Pruebas escritas de 2026", ca: "Proves escrites del 2026" },
      value: { es: "11 de julio de 2026", ca: "11 de juliol de 2026" },
    },
  ],
  calendarNote: {
    es: "Ortografía, gramática, conocimientos e inglés se hacen en una sola sesión de 140 minutos.",
    ca: "Ortografia, gramàtica, coneixements i anglès es fan en una sola sessió de 140 minuts.",
  },
  psychoTypes: [],
  psychoNote: { es: "", ca: "" },
  faq: [
    {
      q: { es: "¿Cómo es el examen de Guardia Civil?", ca: "Com és l'examen de Guàrdia Civil?" },
      a: {
        es: "Una sesión de 140 minutos con ortografía y gramática (apto o no apto), 100 preguntas de conocimientos (mínimo 50 de 100, cada error resta 1/3) e inglés (20 preguntas, mínimo 8). La prueba de aptitudes intelectuales va aparte.",
        ca: "Una sessió de 140 minuts amb ortografia i gramàtica (apte o no apte), 100 preguntes de coneixements (mínim 50 de 100, cada error resta 1/3) i anglès (20 preguntes, mínim 8). La prova d'aptituds intel·lectuals va a part.",
      },
    },
    {
      q: {
        es: "¿Qué nota hace falta en conocimientos de Guardia Civil?",
        ca: "Quina nota cal a coneixements de Guàrdia Civil?",
      },
      a: {
        es: "El mínimo es 50 de 100, pero en 2026 la mediana de las personas convocadas a las pruebas siguientes fue 60.",
        ca: "El mínim és 50 de 100, però el 2026 la mediana de les persones convocades a les proves següents va ser 60.",
      },
    },
  ],
  sources: [
    {
      title: "Resolución 160/38243/2026 (BOE-A-2026-9982)",
      url: "https://www.boe.es/diario_boe/txt.php?id=BOE-A-2026-9982",
    },
    {
      title: "Guardia Civil · Plantillas de las pruebas de 2026",
      url: "https://web.guardiacivil.es/export/sites/guardiaCivil/documentos/pdfs/2026/PLANTILLAS-INGRESO_CABOS_-Y_GUARDIAS.-2026-2.pdf",
    },
  ],
};

const GUIDES: Record<string, ExamGuide> = {
  [mossos.slug]: mossos,
  [auxiliar.slug]: auxiliar,
  [administrativo.slug]: administrativo,
  [auxilio.slug]: auxilio,
  [tramitacion.slug]: tramitacion,
  [policiaNacional.slug]: policiaNacional,
  [guardiaCivil.slug]: guardiaCivil,
};

export const getExamGuide = (slug: string): ExamGuide | undefined => GUIDES[slug];
export const examGuides = (): ExamGuide[] => Object.values(GUIDES);
export { tr } from "./psycho-guides";
