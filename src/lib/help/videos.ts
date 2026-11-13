/**
 * Vídeos cortos de ayuda (ADR-055). Verticales (9:16), 720 × 1280, H.264 + AAC,
 * en `public/videos/ayuda/<id>.mp4` con su portada `<id>.jpg`. Narración en
 * castellano (voz de ElevenLabs) con subtítulos incrustados; aquí va también la
 * transcripción para quien no puede o no quiere oír el audio (WCAG 1.2.1).
 *
 * - FAQ: dudas comunes de la academia, en «Cómo funciona» de la portada.
 * - EXAM: uno por oposición, en su ficha. Sus datos salen de las guías
 *   verificadas (src/lib/seo/exam-guides.ts): si cambia la convocatoria, hay
 *   que rehacer el vídeo (motor en la carpeta del proyecto TIKTOK_OPOSAPRUEBA/_motor).
 */
export type HelpVideo = { id: string; src: string; poster: string; transcript: string };

const video = (id: string, transcript: string): HelpVideo => ({
  id,
  src: `/videos/ayuda/${id}.mp4`,
  poster: `/videos/ayuda/${id}.jpg`,
  transcript,
});

/** Dudas comunes (el título de cada una está en messages: help.faq.<id>). */
export const FAQ_VIDEOS: HelpVideo[] = [
  video(
    "como-funciona",
    "Así funciona Oposaprueba. Elige tu oposición, abre tu plan y entra en el tema. Haz el test y mira tu nota al momento, con lo que has fallado y por qué. Empieza gratis en oposaprueba.com.",
  ),
  video(
    "que-es-gratis",
    "¿Sabías que puedes empezar a preparar tu oposición gratis? En Oposaprueba tienes el test de los tres primeros temas, con cada respuesta explicada, las fichas para repasar, tu plan de estudio y psicotécnicos para practicar, sin tarjeta. Empieza hoy en oposaprueba.com.",
  ),
  video(
    "plan-de-estudio",
    "¿No sabes por dónde empezar a estudiar? Elige tu oposición, pon cuántas horas tienes y la fecha del examen. Oposaprueba te reparte el temario semana a semana con simulacros al final y cada día sabes qué te toca. Pruébalo gratis en oposaprueba.com.",
  ),
  video(
    "simulacros",
    "¿Y si el examen fuera mañana? Practica con tests que te explican cada respuesta. Haz simulacros con el tiempo y la penalización del examen real. Mira tu nota y repasa tus fallos. Entrena como el día del examen en oposaprueba.com.",
  ),
  video(
    "repaso-errores",
    "¿Fallas siempre las mismas preguntas? En Oposaprueba, cada fallo se guarda en tu repaso de errores. Lo vuelves a practicar, y cuando lo aciertas, se marca como resuelto. Así no se te escapa ninguno. Empieza gratis en oposaprueba.com.",
  ),
  video(
    "calendario",
    "¿Sabes cuánto has estudiado esta semana? Tu calendario de estudio te lo dice: qué practicaste cada día, cuántas acertaste, y cuántas tareas del plan te quedan. Empieza gratis en oposaprueba.com.",
  ),
];

/** Un vídeo por oposición (clave = slug de exam_bodies). */
const EXAM_VIDEOS: Record<string, HelpVideo> = {
  "mossos-esquadra": video(
    "mossos-esquadra",
    "Así es el examen de Mossos d'Esquadra. La primera prueba tiene treinta preguntas de conocimientos, en catalán, en las que cada error resta un cuarto. Y ochenta preguntas de aptitudes en treinta y cinco minutos. En Oposaprueba tienes el temario de la Guia d'estudi, psicotécnicos de siete tipos y la calculadora de la prueba física. Empieza gratis en oposaprueba.com.",
  ),
  "auxiliar-administrativo-estado": video(
    "auxiliar-administrativo-estado",
    "Así es el examen de Auxiliar Administrativo del Estado. Un único ejercicio de noventa minutos con dos partes: sesenta preguntas, la mitad psicotécnicas, y cincuenta de actividad administrativa y ofimática. Cada error resta un tercio. En Oposaprueba tienes los dos bloques del programa, psicotécnicos de tablas, series y porcentajes, y simulacros. Empieza gratis en oposaprueba.com.",
  ),
  "administrativo-estado": video(
    "administrativo-estado",
    "Así es el examen de Administrativo del Estado. Un ejercicio de cien minutos: setenta preguntas de test, treinta de ellas de informática y ofimática, y un supuesto práctico de veinte preguntas. Cada error resta un tercio, y en cada parte necesitas la mitad de la nota. En Oposaprueba tienes los seis bloques del programa y simulacros. Empieza gratis en oposaprueba.com.",
  ),
  "auxilio-judicial": video(
    "auxilio-judicial",
    "Así es el examen de Auxilio Judicial. Primero, un test de cien preguntas en cien minutos: cada acierto suma cero coma sesenta, y cada error resta cero coma quince. Después, dos casos prácticos con cuarenta preguntas. Y no hay psicotécnico. En Oposaprueba tienes los veintiséis temas del programa y simulacros. Empieza gratis en oposaprueba.com.",
  ),
  "tramitacion-procesal": video(
    "tramitacion-procesal",
    "Así es el examen de Tramitación Procesal. Son tres ejercicios: un test de cien preguntas en cien minutos, un caso práctico de diez preguntas y una prueba de ofimática de veinte preguntas sobre Windows y Microsoft trescientos sesenta y cinco. En los tres, los errores restan. En Oposaprueba tienes los treinta y siete temas del programa y simulacros. Empieza gratis en oposaprueba.com.",
  ),
  "policia-nacional-basica": video(
    "policia-nacional-basica",
    "Así es el examen de Policía Nacional, escala básica. Cien preguntas con tres respuestas en solo cincuenta minutos: medio minuto por pregunta. Cada error resta medio acierto. Y el mismo día haces el test psicotécnico. En Oposaprueba tienes los cuarenta y cinco temas del programa, psicotécnicos y simulacros. Empieza gratis en oposaprueba.com.",
  ),
  "guardia-civil-cabos-guardias": video(
    "guardia-civil-cabos-guardias",
    "Así es el examen de Guardia Civil. Cien preguntas de conocimientos, donde cada error resta un tercio. Una prueba de ortografía en la que seis errores te dejan fuera. Veinte preguntas de inglés. Y ochenta preguntas de aptitudes en cincuenta y cinco minutos. En Oposaprueba tienes el temario, psicotécnicos y simulacros. Empieza gratis en oposaprueba.com.",
  ),
  "guardia-urbana-barcelona": video(
    "guardia-urbana-barcelona",
    "Así es la oposición a Guardia Urbana de Barcelona. La primera prueba tiene hasta noventa preguntas en catalán, de temario, cultura general y actualidad, en ciento cinco minutos. Cada error resta un cuarto. Después vienen los tests de aptitudes, el idioma y las pruebas físicas. En Oposaprueba tienes los treinta y ocho temas y psicotécnicos de razonamiento. Empieza gratis en oposaprueba.com.",
  ),
  "policia-local": video(
    "policia-local",
    "Así es la oposición a policía local en Cataluña. Cada ayuntamiento publica sus bases, pero el temario se parece mucho. En Terrassa, por ejemplo, son cien preguntas en ciento veinte minutos, y cada error resta un cuarto. Y el psicotécnico es obligatorio. En Oposaprueba tienes un temario tipo de veintitrés temas y psicotécnicos. Empieza gratis en oposaprueba.com.",
  ),
  "bombers-generalitat": video(
    "bombers-generalitat",
    "Así es el examen de Bombers de la Generalitat. El test de conocimientos tiene setenta preguntas en ochenta minutos, y cada error resta un cuarto. El temario son treinta y cuatro temas, del fuego y la hidráulica al rescate. Después vienen las pruebas físicas y los oficios. En Oposaprueba tienes los treinta y cuatro temas y simulacros. Empieza gratis en oposaprueba.com.",
  ),
  "ayudantes-instituciones-penitenciarias": video(
    "ayudantes-instituciones-penitenciarias",
    "Así es el examen de Ayudantes de Instituciones Penitenciarias. Ciento veinte preguntas de test en una hora y cuarenta y cinco minutos, y después ocho supuestos prácticos. En las dos partes, cada error resta un tercio. Y no hay psicotécnico. En Oposaprueba tienes los cuatro bloques del programa y simulacros. Empieza gratis en oposaprueba.com.",
  ),
};

export const getExamVideo = (slug: string): HelpVideo | undefined => EXAM_VIDEOS[slug];
export const examVideoSlugs = (): string[] => Object.keys(EXAM_VIDEOS);
