/**
 * Guías de la prueba física por oposición (ADR-052). Solo datos de las bases
 * oficiales: cada guía cita su fuente y la fecha en que se comprobó. La
 * calculadora usa los baremos tal cual; la nota es orientativa.
 */

type L = { es: string; ca: string };
export type Sex = "men" | "women";

/**
 * Baremo de un ejercicio: marcas mínimas (o máximas, si menos es mejor) para
 * sacar de 1 a 9 puntos y la condición del 10. Una marca entre dos filas se
 * queda con la puntuación de la fila alcanzada.
 */
export type Scale = {
  /** Marcas para 1, 2, … 9 puntos, en el orden de la tabla oficial. */
  steps: number[];
  /** Marca del 10 y si la tabla la da como estricta («<16,3», «>42»). */
  top: { value: number; strict: boolean };
  /**
   * Puntos que sube cada escalón (1 por defecto). Con 0,5 los `steps` son las
   * marcas de 0,5, 1, 1,5… 9,5 puntos (Bombers).
   */
  pointStep?: number;
};

export type PhysicalExercise = {
  key: string;
  name: L;
  /** Unidad de la marca (segundos, repeticiones, periodos). */
  unit: L;
  /** true si una marca menor es mejor (tiempos). */
  lowerIsBetter: boolean;
  /** Paso del campo de la calculadora (0,1 s, 1 repetición, 0,5 periodos). */
  inputStep: number;
  /** Marca en segundos que se escribe y se muestra como minutos y segundos (4'30"). */
  time?: boolean;
  goal: L;
  description: L[];
  rules: L[];
  attempts: L;
  scale: Record<Sex, Scale>;
};

export type PhysicalGuide = {
  examSlug: string;
  /** Nombre de cada baremo si no es «Hombres» / «Mujeres» (Bombers: «Resto de personas»). */
  groups?: Record<Sex, L>;
  verifiedOn: string;
  h1: L;
  seoTitle: L;
  seoDescription: L;
  intro: L;
  facts: { label: L; value: L }[];
  scoring: L[];
  exercises: PhysicalExercise[];
  /** Mínimo por ejercicio y mínimo de la prueba (sobre 10). */
  minPerExercise: number;
  passMark: number;
  after: L;
  faq: { q: L; a: L }[];
  sources: { title: string; url: string }[];
};

/** Segundos como minutos y segundos del baremo: 275 → 4'35". */
export function formatTime(seconds: number): string {
  const m = Math.floor(seconds / 60);
  const s = Math.round(seconds - m * 60);
  return `${m}'${String(s).padStart(2, "0")}"`;
}

/** Lee «4:35», «4'35», «4'35"» o «4.35» como segundos; un número solo son segundos. */
export function parseTime(text: string): number | null {
  const t = text.trim();
  if (t === "") return null;
  const m = /^(\d{1,2})\s*[:'.,´’]\s*(\d{1,2})\s*["”]?$/.exec(t);
  if (m) {
    const sec = Number(m[2]);
    return sec < 60 ? Number(m[1]) * 60 + sec : null;
  }
  return /^\d+$/.test(t) ? Number(t) : null;
}

/** Puntos (0-10) de una marca según el baremo. */
export function exercisePoints(scale: Scale, mark: number, lowerIsBetter: boolean): number {
  if (!Number.isFinite(mark) || mark < 0) return 0;
  const better = (a: number, b: number) => (lowerIsBetter ? a <= b : a >= b);
  const { value, strict } = scale.top;
  const top = lowerIsBetter
    ? strict
      ? mark < value
      : mark <= value
    : strict
      ? mark > value
      : mark >= value;
  if (top) return 10;
  const unit = scale.pointStep ?? 1;
  let points = 0;
  scale.steps.forEach((step, i) => {
    if (better(mark, step)) points = (i + 1) * unit;
  });
  return points;
}

export type PhysicalResult = {
  points: number[];
  /** Nota de la prueba de 0 a 10 (media de los tres ejercicios). */
  total: number;
  passed: boolean;
  /** Ejercicios por debajo del mínimo (eliminan aunque la media llegue). */
  failedExercises: string[];
};

/** Nota de la prueba: cada ejercicio pesa lo mismo (33,33 %). */
export function physicalScore(
  guide: PhysicalGuide,
  sex: Sex,
  marks: (number | null)[],
): PhysicalResult {
  const points = guide.exercises.map((ex, i) => {
    const m = marks[i];
    return m === null || m === undefined ? 0 : exercisePoints(ex.scale[sex], m, ex.lowerIsBetter);
  });
  const total = Math.round((points.reduce((a, b) => a + b, 0) / points.length) * 100) / 100;
  const failedExercises = guide.exercises
    .filter((_, i) => points[i] < guide.minPerExercise)
    .map((e) => e.key);
  return {
    points,
    total,
    passed: failedExercises.length === 0 && total >= guide.passMark,
    failedExercises,
  };
}

const BASES_URL = "https://dogc.gencat.cat/ca/document-del-dogc/?documentId=1046460";

const mossos: PhysicalGuide = {
  examSlug: "mossos-esquadra",
  verifiedOn: "2026-11-12",
  h1: {
    es: "Prueba física de Mossos d'Esquadra 2026: ejercicios, baremos y calculadora",
    ca: "Prova física de Mossos d'Esquadra 2026: exercicis, barems i calculadora",
  },
  seoTitle: {
    es: "Prueba física Mossos 2026: baremos y calculadora de nota",
    ca: "Prova física Mossos 2026: barems i calculadora de nota",
  },
  seoDescription: {
    es: "Circuit d'agilitat, press de banca y course navette de la convocatoria 46/26: baremos oficiales de hombres y mujeres, normas y calculadora de tu nota.",
    ca: "Circuit d'agilitat, pressió sobre banc i cursa de llançadora de la convocatòria 46/26: barems oficials d'homes i dones, normes i calculadora de la nota.",
  },
  intro: {
    es: "La segunda prueba de la convocatoria 46/26 es la prueba física: obligatoria y eliminatoria, con tres ejercicios que puntúan lo mismo. Aquí tienes lo que dicen las bases (Resolución ISP/1763/2026, base 6.1.2 y anexo 2): cómo es cada ejercicio, sus normas, los baremos oficiales y una calculadora para saber qué nota sacarías con tus marcas.",
    ca: "La segona prova de la convocatòria 46/26 és la prova física: obligatòria i eliminatòria, amb tres exercicis que puntuen igual. Aquí tens el que diuen les bases (Resolució ISP/1763/2026, base 6.1.2 i annex 2): com és cada exercici, les normes, els barems oficials i una calculadora per saber quina nota trauries amb les teves marques.",
  },
  facts: [
    {
      label: { es: "Fechas previstas", ca: "Dates previstes" },
      value: {
        es: "Del 23 de noviembre al 21 de diciembre de 2026 (previsión de calendario oficial actualizada el 21/09/2026)",
        ca: "Del 23 de novembre al 21 de desembre de 2026 (previsió de calendari oficial actualitzada el 21/09/2026)",
      },
    },
    {
      label: { es: "Quién la hace", ca: "Qui la fa" },
      value: {
        es: "Las 3.466 mujeres y las 5.198 personas (plazas no reservadas) con mejor nota en la 1.ª prueba; los empates en la última posición también entran",
        ca: "Les 3.466 dones i les 5.198 persones (places no reservades) amb millor puntuació a la 1a prova; els empats en l'última posició també hi entren",
      },
    },
    {
      label: { es: "Ejercicios", ca: "Exercicis" },
      value: {
        es: "Circuit d'agilitat, press de banca (pressió sobre banc) y course navette (cursa de llançadora)",
        ca: "Circuit d'agilitat, pressió sobre banc i cursa de llançadora",
      },
    },
    {
      label: { es: "Para aprobar", ca: "Per aprovar" },
      value: {
        es: "Al menos 1 punto en cada ejercicio y 5 de 10 en total",
        ca: "Com a mínim 1 punt a cada exercici i 5 de 10 en total",
      },
    },
  ],
  scoring: [
    {
      es: "Cada ejercicio se puntúa de 0 a 10 con el baremo oficial, y cada uno pesa un 33,33 % de la nota: la nota de la prueba es la media de los tres, de 0 a 10.",
      ca: "Cada exercici es puntua de 0 a 10 amb el barem oficial, i cadascun pesa un 33,33 % de la nota: la nota de la prova és la mitjana dels tres, de 0 a 10.",
    },
    {
      es: "Hay que sacar como mínimo 1 punto en cada ejercicio; con un 0 en cualquiera de ellos quedas fuera aunque la media llegue a 5.",
      ca: "Cal treure com a mínim 1 punt a cada exercici; amb un 0 en qualsevol d'ells quedes fora encara que la mitjana arribi a 5.",
    },
    {
      es: "Para superar la prueba hace falta un 5. La nota cuenta: la suma de la 1.ª y la 2.ª prueba decide quién pasa a la prueba de adecuación psicoprofesional.",
      ca: "Per superar la prova cal un 5. La nota compta: la suma de la 1a i la 2a prova decideix qui passa a la prova d'adequació psicoprofessional.",
    },
  ],
  exercises: [
    {
      key: "agility",
      name: { es: "Circuit d'agilitat", ca: "Circuit d'agilitat" },
      unit: { es: "segundos", ca: "segons" },
      lowerIsBetter: true,
      inputStep: 0.1,
      goal: { es: "Valorar la agilidad.", ca: "Valorar l'agilitat." },
      description: [
        {
          es: "Empiezas sentado en el suelo detrás de la línea de salida, apoyando pies, manos y glúteos.",
          ca: "Comences assegut a terra darrere la línia de sortida, amb recolzament de peus, mans i glutis.",
        },
        {
          es: "A la señal sales corriendo y haces una voltereta sobre la colchoneta, apoyando las dos manos.",
          ca: "Al senyal surts corrent i fas una tombarella sobre el matalàs, amb recolzament de les dues mans.",
        },
        {
          es: "Pasas por debajo de la primera valla, superas el plinto de 1 metro por la parte central, pasas por debajo de la segunda valla y saltas la primera valla con los dos pies (80 cm mujeres, 90 cm hombres).",
          ca: "Passes per sota de la primera tanca, sobrepasses el plint d'1 metre per la part central, passes per sota de la segona tanca i saltes la primera tanca amb els dos peus (dones 80 cm, homes 90 cm).",
        },
        {
          es: "Coges un saco de unos 15 kg (mujeres) o 20 kg (hombres), lo llevas sobre los hombros 10 metros hasta un cono, lo rodeas por la izquierda y vuelves corriendo 10 metros hasta la llegada.",
          ca: "Agafes un sac d'uns 15 kg (dones) o 20 kg (homes), el portes sobre les espatlles 10 metres fins a un con, el rodeges per l'esquerra i tornes corrent 10 metres fins a l'arribada.",
        },
      ],
      rules: [
        {
          es: "No se puede pisar la línea ni salir antes de la señal.",
          ca: "No es pot trepitjar la línia ni sortir abans del senyal.",
        },
        {
          es: "La voltereta es sobre el eje transversal del tronco (no vale la de tipo judo).",
          ca: "La tombarella és sobre l'eix transversal del tronc (no val la de tipus judo).",
        },
        {
          es: "El saco debe ir apoyado en los hombros y cogido con las dos manos antes de cruzar la línea marcada.",
          ca: "El sac ha d'anar recolzat a les espatlles i agafat amb les dues mans abans de traspassar la línia marcada.",
        },
        {
          es: "No se puede mover ningún obstáculo ni cambiar el recorrido: si no, el intento es nulo.",
          ca: "No es pot moure cap obstacle ni canviar el recorregut: si no, l'intent és nul.",
        },
      ],
      attempts: {
        es: "Dos intentos no seguidos; cuenta el mejor tiempo (segundos y décimas).",
        ca: "Dos intents no consecutius; compta el millor temps (segons i dècimes).",
      },
      scale: {
        men: {
          steps: [21.5, 20.4, 19.9, 19.4, 18.9, 18.4, 17.8, 17.3, 16.8],
          top: { value: 16.3, strict: true },
        },
        women: {
          steps: [25.5, 24.4, 23.7, 23.0, 22.3, 21.6, 20.9, 20.2, 19.5],
          top: { value: 18.9, strict: true },
        },
      },
    },
    {
      key: "bench",
      name: { es: "Press de banca (pressió sobre banc)", ca: "Pressió sobre banc" },
      unit: { es: "repeticiones", ca: "repeticions" },
      lowerIsBetter: false,
      inputStep: 1,
      goal: {
        es: "Medir la fuerza y la resistencia de los brazos.",
        ca: "Mesurar la força i la resistència de l'extremitat superior.",
      },
      description: [
        {
          es: "Tumbado boca arriba en el banco, con los pies en el suelo y los brazos estirados.",
          ca: "Estirat de cap per amunt al banc, amb els peus a terra i els braços estirats.",
        },
        {
          es: "Levantas 40 kg (hombres) o 25 kg (mujeres) tantas veces como puedas en 45 segundos, con las manos algo más separadas que los hombros.",
          ca: "Aixeques 40 kg (homes) o 25 kg (dones) tantes vegades com puguis en 45 segons, amb les mans una mica més separades que les espatlles.",
        },
      ],
      rules: [
        {
          es: "La repetición no vale si no estiras del todo los codos o la barra no toca el pecho.",
          ca: "La repetició no és vàlida si no s'estenen del tot els colzes o la barra no toca el pit.",
        },
        {
          es: "No se puede rebotar la barra ni usar guantes ni magnesio.",
          ca: "No es pot fer rebots amb la barra ni fer servir guants ni magnèsia.",
        },
      ],
      attempts: {
        es: "Un solo intento; cuentan las repeticiones válidas en 45 segundos.",
        ca: "Un sol intent; compten les repeticions vàlides en 45 segons.",
      },
      scale: {
        men: { steps: [24, 27, 28, 30, 31, 33, 34, 36, 39], top: { value: 42, strict: true } },
        women: { steps: [10, 13, 16, 18, 20, 22, 24, 27, 30], top: { value: 34, strict: true } },
      },
    },
    {
      key: "shuttle",
      name: { es: "Course navette (cursa de llançadora)", ca: "Cursa de llançadora" },
      unit: { es: "periodos", ca: "períodes" },
      lowerIsBetter: false,
      inputStep: 0.5,
      goal: { es: "Valorar la resistencia aeróbica.", ca: "Valorar la resistència aeròbica." },
      description: [
        {
          es: "Corres entre dos líneas separadas 20 metros siguiendo una señal sonora cuyo ritmo sube cada minuto.",
          ca: "Corres entre dues línies separades 20 metres seguint un senyal sonor que va més ràpid cada minut.",
        },
        {
          es: "Acaba cuando no llegas a pisar la línea al sonar la señal. Se anota el último periodo (palier) anunciado.",
          ca: "S'acaba quan no arribes a trepitjar la línia en sentir el senyal. S'anota l'últim període (palier) anunciat.",
        },
      ],
      rules: [
        {
          es: "Hay que pisar la línea antes o en el momento de la señal, y no salir hasta oírla.",
          ca: "Cal trepitjar la línia abans o en el moment del senyal, i no sortir fins a sentir-lo.",
        },
        {
          es: "Hay que pivotar: no se permiten giros en círculo.",
          ca: "Cal pivotar: no es permeten girs circulars.",
        },
      ],
      attempts: { es: "Un solo intento.", ca: "Un sol intent." },
      scale: {
        men: {
          steps: [6.5, 7.5, 8, 8.5, 9, 9.5, 10.5, 11, 12],
          top: { value: 12.5, strict: false },
        },
        women: {
          steps: [3.5, 4.5, 5, 6, 6.5, 7, 7.5, 8, 9],
          top: { value: 10, strict: false },
        },
      },
    },
  ],
  minPerExercise: 1,
  passMark: 5,
  after: {
    es: "Después viene la prueba de adecuación psicoprofesional (un test de competencias y una entrevista). Se convoca a las 2.540 mujeres y a las 3.808 personas con mejor suma de la 1.ª y la 2.ª prueba, así que cada punto de la prueba física cuenta.",
    ca: "Després ve la prova d'adequació psicoprofessional (un test de competències i una entrevista). Hi són convocades les 2.540 dones i les 3.808 persones amb millor suma de la 1a i la 2a prova, així que cada punt de la prova física compta.",
  },
  faq: [
    {
      q: {
        es: "¿Qué nota hace falta en la prueba física de Mossos?",
        ca: "Quina nota cal a la prova física de Mossos?",
      },
      a: {
        es: "Un 5 de 10 en total y al menos 1 punto en cada uno de los tres ejercicios. La nota se suma a la de la 1.ª prueba para pasar a la siguiente fase.",
        ca: "Un 5 de 10 en total i com a mínim 1 punt a cadascun dels tres exercicis. La nota se suma a la de la 1a prova per passar a la fase següent.",
      },
    },
    {
      q: {
        es: "¿Cuánto peso se levanta en el press de banca de Mossos?",
        ca: "Quant pes s'aixeca a la pressió sobre banc de Mossos?",
      },
      a: {
        es: "40 kg los hombres y 25 kg las mujeres, todas las veces posibles en 45 segundos. Para el 5 hacen falta 31 repeticiones (hombres) o 20 (mujeres).",
        ca: "40 kg els homes i 25 kg les dones, totes les vegades possibles en 45 segons. Per al 5 calen 31 repeticions (homes) o 20 (dones).",
      },
    },
    {
      q: {
        es: "¿Qué periodo de course navette hace falta para aprobar?",
        ca: "Quin període de cursa de llançadora cal per aprovar?",
      },
      a: {
        es: "Para 1 punto, el periodo 6,5 (hombres) o 3,5 (mujeres); para un 5, el 9 (hombres) o el 6,5 (mujeres).",
        ca: "Per a 1 punt, el període 6,5 (homes) o 3,5 (dones); per a un 5, el 9 (homes) o el 6,5 (dones).",
      },
    },
    {
      q: {
        es: "¿Se puede aplazar la prueba física por embarazo?",
        ca: "Es pot ajornar la prova física per embaràs?",
      },
      a: {
        es: "Sí. Las participantes embarazadas o que no hayan cumplido 16 semanas desde el nacimiento pueden pedir el aplazamiento al tribunal antes de la prueba, con certificado médico (base 6.1.2).",
        ca: "Sí. Les participants embarassades o que no hagin complert setze setmanes des del naixement poden sol·licitar l'ajornament al tribunal abans de la prova, amb certificat mèdic (base 6.1.2).",
      },
    },
  ],
  sources: [
    {
      title: "Resolució ISP/1763/2026, de 3 de juny (DOGC): base 6.1.2 i annex 2",
      url: BASES_URL,
    },
    {
      title: "Mossos d'Esquadra · Convocatòria 46/26",
      url: "https://mossos.gencat.cat/ca/els_mossos_desquadra/acces_al_cos/Mosso_a/mosso-a-convocatoria-46-26/",
    },
  ],
};

/** Escalones de 0,5 puntos de Bombers: 17 filas que bajan de 6 en 6 s (0,5 a 8,5) y las del 9 y 9,5. */
function halfSteps(first: number, nine: number, nineHalf: number): number[] {
  return [...Array.from({ length: 17 }, (_, i) => first - 6 * i), nine, nineHalf];
}

const BOMBERS_URL = "https://dogc.gencat.cat/ca/document-del-dogc/?documentId=1054245";

const bombers: PhysicalGuide = {
  examSlug: "bombers-generalitat",
  verifiedOn: "2026-11-18",
  groups: {
    women: { es: "Mujeres", ca: "Dones" },
    men: { es: "Resto de personas", ca: "Resta de persones" },
  },
  h1: {
    es: "Pruebas físicas de Bombers de la Generalitat 2026: ejercicios, baremos y calculadora",
    ca: "Proves físiques de Bombers de la Generalitat 2026: exercicis, barems i calculadora",
  },
  seoTitle: {
    es: "Pruebas físicas Bombers Generalitat 81/26: baremos y calculadora",
    ca: "Proves físiques Bombers Generalitat 81/26: barems i calculadora",
  },
  seoDescription: {
    es: "Incendio de vegetación, incendio estructural y rescate acuático de la convocatoria 81/26: baremos oficiales de mujeres y resto de personas, normas, penalizaciones y calculadora de tu nota.",
    ca: "Incendi de vegetació, incendi estructural i rescat aquàtic de la convocatòria 81/26: barems oficials de dones i resta de persones, normes, penalitzacions i calculadora de la nota.",
  },
  intro: {
    es: "La segunda prueba de la convocatoria 81/26 de bombero/a de primera es la prueba física: obligatoria y eliminatoria, con tres ejercicios que simulan intervenciones reales. Aquí tienes lo que dicen las bases (Resolución ISP/3218/2026, base 6.1.2 y anexo 3): cómo es cada ejercicio, qué se penaliza, los baremos oficiales y una calculadora para saber qué nota sacarías con tus tiempos.",
    ca: "La segona prova de la convocatòria 81/26 de bomber/a de primera és la prova física: obligatòria i eliminatòria, amb tres exercicis que simulen intervencions reals. Aquí tens el que diuen les bases (Resolució ISP/3218/2026, base 6.1.2 i annex 3): com és cada exercici, què es penalitza, els barems oficials i una calculadora per saber quina nota trauries amb els teus temps.",
  },
  facts: [
    {
      label: { es: "Quién la hace", ca: "Qui la fa" },
      value: {
        es: "Las 360 mujeres y las 540 personas (plazas no reservadas) con mejor nota en la prueba de conocimientos; los empates en la última posición también entran",
        ca: "Les 360 dones i les 540 persones (places no reservades) amb millor puntuació a la prova de coneixements; els empats en l'última posició també hi entren",
      },
    },
    {
      label: { es: "Ejercicios", ca: "Exercicis" },
      value: {
        es: "Incendio de vegetación, incendio estructural y rescate acuático, siempre en este orden y con al menos 15 minutos de descanso entre uno y otro",
        ca: "Incendi de vegetació, incendi estructural i rescat aquàtic, sempre en aquest ordre i amb un mínim de 15 minuts de descans entre l'un i l'altre",
      },
    },
    {
      label: { es: "Intentos", ca: "Intents" },
      value: {
        es: "Uno solo en cada ejercicio. No se puede probar el material antes",
        ca: "Un de sol a cada exercici. No es pot provar el material abans",
      },
    },
    {
      label: { es: "Para aprobar", ca: "Per aprovar" },
      value: {
        es: "5 de 10 de media entre los tres ejercicios",
        ca: "5 de 10 de mitjana entre els tres exercicis",
      },
    },
  ],
  scoring: [
    {
      es: "Cada ejercicio se puntúa de 0 a 10, de medio en medio punto, según el tiempo final. La nota de la prueba es la suma de los tres dividida entre tres.",
      ca: "Cada exercici es puntua de 0 a 10, de mig en mig punt, segons el temps final. La nota de la prova és la suma dels tres dividida entre tres.",
    },
    {
      es: "El tiempo final incluye las penalizaciones: 10 segundos cada una en el incendio de vegetación y en el rescate acuático, y 5 segundos en el incendio estructural. Se acumulan.",
      ca: "El temps final inclou les penalitzacions: 10 segons cadascuna a l'incendi de vegetació i al rescat aquàtic, i 5 segons a l'incendi estructural. S'acumulen.",
    },
    {
      es: "Pasar del tiempo límite (la fila del 0 del baremo), abandonar, no seguir el orden de las fases o incumplir las normas de un ejercicio da 0 puntos en ese ejercicio.",
      ca: "Excedir el temps límit (la fila del 0 del barem), abandonar, no seguir l'ordre de les fases o incomplir les normes d'un exercici dona 0 punts en aquell exercici.",
    },
    {
      es: "Hace falta un 5 para superar la prueba. La nota cuenta: la fase de oposición suma la prueba de conocimientos (8), la física (10), la de oficios (12) y la psicológica (10).",
      ca: "Cal un 5 per superar la prova. La nota compta: la fase d'oposició suma la prova de coneixements (8), la física (10), la d'oficis (12) i la psicològica (10).",
    },
    {
      es: "Se va con ropa y calzado deportivos. No se permiten guantes, magnesio, rodilleras, muñequeras, tobilleras, fajas ni ropa con reflectantes. Puede haber control antidopaje.",
      ca: "S'hi va amb roba i calçat esportius. No es permeten guants, magnèsia, genolleres, canelleres, turmelleres, faixes ni roba amb elements reflectants. Hi pot haver control antidopatge.",
    },
  ],
  exercises: [
    {
      key: "vegetation",
      name: { es: "Incendio de vegetación", ca: "Incendi de vegetació" },
      unit: { es: "min:seg", ca: "min:seg" },
      lowerIsBetter: true,
      inputStep: 1,
      time: true,
      goal: {
        es: "Simula el esfuerzo de un incendio forestal: resistencia cardiovascular y lanzamientos repetidos con fatiga, como al usar herramientas.",
        ca: "Simula l'esforç d'un incendi de vegetació: resistència cardiovascular i llançaments repetits amb fatiga, com en fer servir eines.",
      },
      description: [
        {
          es: "Fase 1: 8 rectas de ida y vuelta de 20 metros y 16 lanzamientos contra el suelo con un balón medicinal de 6 kg.",
          ca: "Fase 1: 8 rectes d'anada i tornada de 20 metres i 16 llançaments contra el terra amb una pilota medicinal de 6 kg.",
        },
        {
          es: "Fase 2: 10 rectas y 20 lanzamientos.",
          ca: "Fase 2: 10 rectes i 20 llançaments.",
        },
        {
          es: "Fase 3: 12 rectas y 24 lanzamientos. El tiempo se para al volver a la zona de salida.",
          ca: "Fase 3: 12 rectes i 24 llançaments. El temps s'atura en tornar a la zona de sortida.",
        },
      ],
      rules: [
        {
          es: "En cada recta hay que pisar la línea junto al balón y girar 180° alrededor del cono del otro extremo.",
          ca: "A cada recta cal trepitjar la línia de la pilota i fer el gir de 180° al voltant del con de l'altre extrem.",
        },
        {
          es: "Un lanzamiento vale si el balón pasa por encima de la cabeza, sale de las manos antes de tocar el suelo, golpea el suelo y flexionas y vuelves a extender la cadera. Si no vale, no cuenta.",
          ca: "Un llançament és vàlid si la pilota sobrepassa el cap, surt de les mans abans de tocar a terra, colpeja el terra i flexiones i tornes a estendre el maluc. Si no és vàlid, no compta.",
        },
        {
          es: "Penalizan 10 segundos: no salir de la zona marcada, no pisar la línea, no girar alrededor del cono, mover o tirar un cono y no dejar el balón entero en su zona.",
          ca: "Penalitzen 10 segons: no sortir de la zona delimitada, no trepitjar la línia, no girar al voltant del con, desplaçar o tombar un con i no deixar tota la pilota a la seva zona.",
        },
      ],
      attempts: {
        es: "Un solo intento; cuenta el tiempo total de las tres fases más las penalizaciones.",
        ca: "Un sol intent; compta el temps total de les tres fases més les penalitzacions.",
      },
      scale: {
        women: {
          steps: halfSteps(365, 263, 252),
          top: { value: 236, strict: false },
          pointStep: 0.5,
        },
        men: {
          steps: halfSteps(329, 227, 216),
          top: { value: 200, strict: false },
          pointStep: 0.5,
        },
      },
    },
    {
      key: "structural",
      name: { es: "Incendio estructural", ca: "Incendi estructural" },
      unit: { es: "min:seg", ca: "min:seg" },
      lowerIsBetter: true,
      inputStep: 1,
      time: true,
      goal: {
        es: "Simula una intervención en un edificio: subir con peso, llevar material cansado, tirar de mangueras, empujar, moverse en espacios estrechos y arrastrar a una víctima.",
        ca: "Simula una intervenció en un edifici: pujar amb pes, transportar material amb fatiga, maniobrar mànegues, empènyer, moure's en espais confinats i arrossegar una víctima.",
      },
      description: [
        {
          es: "Todo el ejercicio se hace con un chaleco de 10 kg.",
          ca: "Tot l'exercici es fa amb una armilla de 10 kg.",
        },
        {
          es: "Fase 1: dos discos de 10 kg bajo los brazos durante 40 metros, pasando por una barra de equilibrio (3 m de largo, 21,5 cm de alto, 10 cm de ancho), y 10 subidas y bajadas a un cajón.",
          ca: "Fase 1: dos discos de 10 kg sota els braços durant 40 metres, passant per una barra d'equilibri (3 m de llarg, 21,5 cm d'alt, 10 cm d'ample), i 10 pujades i baixades a un calaix.",
        },
        {
          es: "Fase 2: lo mismo con una pesa rusa (kettlebell) de 12 kg en cada mano, sin subirlas por encima de la cintura.",
          ca: "Fase 2: el mateix amb un pes rus (kettlebell) de 12 kg a cada mà, sense pujar-los per damunt de la cintura.",
        },
        {
          es: "Fases 3 y 4: desde un cuadrado de 1 m², tirar con una cuerda de un trineo de unos 96 kg con freno magnético y después empujarlo 10 metros.",
          ca: "Fases 3 i 4: des d'un requadre d'1 m², estirar amb una corda un trineu d'uns 96 kg amb fre magnètic i després empènyer-lo 10 metres.",
        },
        {
          es: "Fase 5: recorrido en C de unos 10 metros a cuatro patas o reptando bajo vallas de 91 cm.",
          ca: "Fase 5: recorregut en C d'uns 10 metres de quatre grapes o reptant sota tanques de 91 cm.",
        },
        {
          es: "Fase 6: arrastrar de espaldas un maniquí de unos 50 kg durante 18 metros (9 en zigzag entre conos), con sus pies siempre en el suelo.",
          ca: "Fase 6: arrossegar d'esquena un maniquí d'uns 50 kg durant 18 metres (9 en ziga-zaga entre cons), amb els peus sempre a terra.",
        },
        {
          es: "Fase 7: correr 9 metros y pasar entre los dos conos finales, donde se para el tiempo.",
          ca: "Fase 7: córrer 9 metres i passar entre els dos cons finals, on s'atura el temps.",
        },
      ],
      rules: [
        {
          es: "Penalizan 5 segundos, entre otras: caerse de la barra, dejar caer un disco o una pesa, coger los discos por el agujero, saltar al cajón, no devolver el material, pisar fuera del cuadrado del trineo, tocar o pasar por encima de las vallas y que el maniquí toque el suelo con el tronco o levante un pie.",
          ca: "Penalitzen 5 segons, entre altres: caure de la barra, deixar caure un disc o un pes, agafar els discos pel forat, saltar al calaix, no tornar el material, trepitjar fora del requadre del trineu, tocar o sobrepassar les tanques i que el maniquí toqui a terra amb el tronc o aixequi un peu.",
        },
        {
          es: "Si caes de la barra, vuelves a empezarla. No se pasa a la fase siguiente sin superarla.",
          ca: "Si caus de la barra, la tornes a començar. No es passa a la fase següent sense superar-la.",
        },
        {
          es: "Mover o tirar la estructura de los discos, las pesas o el cajón, o volcar el trineo, da 0 puntos en el ejercicio.",
          ca: "Desplaçar o tombar l'estructura dels discos, els pesos o el calaix, o bolcar el trineu, dona 0 punts a l'exercici.",
        },
      ],
      attempts: {
        es: "Un solo intento; cuenta el tiempo de las siete fases más las penalizaciones.",
        ca: "Un sol intent; compta el temps de les set fases més les penalitzacions.",
      },
      scale: {
        women: {
          steps: halfSteps(257, 155, 144),
          top: { value: 128, strict: false },
          pointStep: 0.5,
        },
        men: {
          steps: halfSteps(215, 113, 102),
          top: { value: 86, strict: false },
          pointStep: 0.5,
        },
      },
    },
    {
      key: "water",
      name: { es: "Rescate acuático", ca: "Rescat aquàtic" },
      unit: { es: "min:seg", ca: "min:seg" },
      lowerIsBetter: true,
      inputStep: 1,
      time: true,
      goal: {
        es: "Simula un rescate en el agua: entrada segura, apnea, resistencia, natación de salvamento y remolque de una víctima.",
        ca: "Simula un rescat a l'aigua: entrada segura, apnea, resistència, natació de salvament i remolc d'una víctima.",
      },
      description: [
        {
          es: "Piscina de 25 metros. Bañador y gorro obligatorios; gafas opcionales.",
          ca: "Piscina de 25 metres. Vestit i casquet de bany obligatoris; ulleres opcionals.",
        },
        {
          es: "Fase 1: entrar al agua de pie, con la cabeza siempre fuera.",
          ca: "Fase 1: entrar a l'aigua de peus, amb el cap sempre fora.",
        },
        {
          es: "Fase 2: 15 metros buceando en apnea, pasando por debajo de una valla de 1 metro en el fondo.",
          ca: "Fase 2: 15 metres en immersió i apnea, passant per sota d'una tanca d'1 metre al fons.",
        },
        {
          es: "Fase 3: 30 segundos flotando con la cabeza y las dos manos (los cinco dedos) fuera del agua, sin tocar nada.",
          ca: "Fase 3: 30 segons a la superfície amb el cap i les dues mans (els cinc dits) fora de l'aigua, sense tocar res.",
        },
        {
          es: "Fase 4: dos largos a crol, tocando la pared con la mano y sin voltereta ni impulso.",
          ca: "Fase 4: dos trams a crol, tocant la paret amb la mà i sense tombarella ni impuls.",
        },
        {
          es: "Fase 5: 25 metros de crol de salvamento, con la cabeza fuera del agua.",
          ca: "Fase 5: 25 metres de crol de salvament, amb el cap fora de l'aigua.",
        },
        {
          es: "Fase 6: remolcar 25 metros un maniquí de unos 35 kg con tus vías respiratorias y las suyas fuera del agua. El tiempo se para al dejarlo en el borde.",
          ca: "Fase 6: remolcar 25 metres un maniquí d'uns 35 kg amb les teves vies aèries i les seves fora de l'aigua. El temps s'atura en deixar-lo a la vora.",
        },
      ],
      rules: [
        {
          es: "Penalizan 10 segundos, entre otras: tocar una corchera o la pared fuera de lo previsto, salir a respirar en la apnea, no pasar bajo la valla, sumergir la cabeza o un dedo en los 30 segundos, hacer voltereta, impulsarse en la pared y llevar la boca o la del maniquí bajo el agua.",
          ca: "Penalitzen 10 segons, entre altres: tocar una surada o la paret fora del previst, sortir a respirar a l'apnea, no passar per sota la tanca, submergir el cap o un dit durant els 30 segons, fer tombarella, impulsar-se a la paret i portar la via aèria o la del maniquí sota l'aigua.",
        },
        {
          es: "Al pasar bajo las corcheras, las vías respiratorias pueden estar como máximo 5 segundos bajo el agua.",
          ca: "En passar per sota les surades, les vies aèries poden estar com a màxim 5 segons sota l'aigua.",
        },
        {
          es: "Si no haces los 15 metros de apnea de una vez, tienes 10 segundos de penalización y sigues desde la zona final.",
          ca: "Si no fas els 15 metres d'apnea d'una tirada, tens 10 segons de penalització i continues des de la zona final.",
        },
      ],
      attempts: {
        es: "Un solo intento; cuenta el tiempo de las seis fases más las penalizaciones.",
        ca: "Un sol intent; compta el temps de les sis fases més les penalitzacions.",
      },
      scale: {
        women: {
          steps: halfSteps(281, 179, 168),
          top: { value: 152, strict: false },
          pointStep: 0.5,
        },
        men: {
          steps: halfSteps(257, 155, 144),
          top: { value: 128, strict: false },
          pointStep: 0.5,
        },
      },
    },
  ],
  minPerExercise: 0,
  passMark: 5,
  after: {
    es: "Después viene la prueba de oficios (sanitario, carpintería y construcción, fontanería y electricidad, y conducción de vehículos pesados), a la que se convoca a las 240 mujeres y a las 360 personas con mejor nota, así que cada medio punto de la prueba física cuenta.",
    ca: "Després ve la prova d'oficis (sanitari, fusteria i construcció, lampisteria i electricitat, i conducció de vehicles pesants), a la qual es convoca les 240 dones i les 360 persones amb millor puntuació, així que cada mig punt de la prova física compta.",
  },
  faq: [
    {
      q: {
        es: "¿Qué nota hace falta en las pruebas físicas de Bombers de la Generalitat?",
        ca: "Quina nota cal a les proves físiques de Bombers de la Generalitat?",
      },
      a: {
        es: "Un 5 de 10, que es la suma de los tres ejercicios dividida entre tres. Las bases no ponen un mínimo por ejercicio, pero un 0 en uno obliga a sacar 7,5 de media en los otros dos.",
        ca: "Un 5 de 10, que és la suma dels tres exercicis dividida entre tres. Les bases no posen un mínim per exercici, però un 0 en un obliga a treure 7,5 de mitjana en els altres dos.",
      },
    },
    {
      q: {
        es: "¿Qué tiempo hace falta para un 5 en cada ejercicio?",
        ca: "Quin temps cal per a un 5 a cada exercici?",
      },
      a: {
        es: "Mujeres: 5'11\" en el incendio de vegetación, 3'23\" en el estructural y 3'47\" en el rescate acuático. Resto de personas: 4'35\", 2'41\" y 3'23\".",
        ca: "Dones: 5'11\" a l'incendi de vegetació, 3'23\" a l'estructural i 3'47\" al rescat aquàtic. Resta de persones: 4'35\", 2'41\" i 3'23\".",
      },
    },
    {
      q: {
        es: "¿Cuánto pesa el balón medicinal y el chaleco?",
        ca: "Quant pesa la pilota medicinal i l'armilla?",
      },
      a: {
        es: "El balón medicinal pesa 6 kg y el chaleco del incendio estructural, 10 kg. En ese ejercicio también se llevan dos discos de 10 kg, dos pesas rusas de 12 kg, un trineo de unos 96 kg y un maniquí de unos 50 kg.",
        ca: "La pilota medicinal pesa 6 kg i l'armilla de l'incendi estructural, 10 kg. En aquest exercici també es porten dos discos de 10 kg, dos pesos russos de 12 kg, un trineu d'uns 96 kg i un maniquí d'uns 50 kg.",
      },
    },
    {
      q: {
        es: "¿Se puede aplazar la prueba física por embarazo?",
        ca: "Es pot ajornar la prova física per embaràs?",
      },
      a: {
        es: "Sí. Las participantes embarazadas o que no hayan cumplido 6 meses desde el nacimiento pueden pedir hacerla de forma individual, con certificado médico, o aplazarla y seguir con el resto de pruebas (base 6.1.2).",
        ca: "Sí. Les participants embarassades o que no hagin complert 6 mesos des del naixement poden demanar fer-la de forma individualitzada, amb certificat mèdic, o ajornar-la i continuar amb la resta de proves (base 6.1.2).",
      },
    },
  ],
  sources: [
    {
      title: "Resolució ISP/3218/2026, de 10 de setembre (DOGC): base 6.1.2 i annex 3",
      url: BOMBERS_URL,
    },
    {
      title: "Bombers de la Generalitat · Convocatòria 81/26",
      url: "https://interior.gencat.cat/ca/arees_dactuacio/bombers/convocatories/bombers-funcionaris/acces-a-bomber-a-de-1a-de-lescala-tecnica-81-26/",
    },
  ],
};

const GUIDES: Record<string, PhysicalGuide> = {
  [mossos.examSlug]: mossos,
  [bombers.examSlug]: bombers,
};

export const getPhysicalGuide = (slug: string): PhysicalGuide | undefined => GUIDES[slug];
export const physicalGuides = (): PhysicalGuide[] => Object.values(GUIDES);
