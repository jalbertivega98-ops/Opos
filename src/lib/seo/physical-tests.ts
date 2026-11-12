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
  goal: L;
  description: L[];
  rules: L[];
  attempts: L;
  scale: Record<Sex, Scale>;
};

export type PhysicalGuide = {
  examSlug: string;
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
  let points = 0;
  scale.steps.forEach((step, i) => {
    if (better(mark, step)) points = i + 1;
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

const GUIDES: Record<string, PhysicalGuide> = { [mossos.examSlug]: mossos };

export const getPhysicalGuide = (slug: string): PhysicalGuide | undefined => GUIDES[slug];
export const physicalGuides = (): PhysicalGuide[] => Object.values(GUIDES);
