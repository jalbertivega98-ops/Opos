# Política de contenidos

## Fuentes

- Solo fuentes oficiales y primarias: BOE, DOGC y demás diarios oficiales autonómicos, BOP, webs oficiales de organismos convocantes, legislación consolidada.
- Cada dato de convocatoria (fechas, plazas, requisitos, pruebas, puntuación) se registra con su fuente (`sources`: URL, título, fecha de publicación, fecha de verificación, verificador).
- Lo no verificado no se muestra como dato: se indica "pendiente de verificación".

## Originalidad

- Prohibido copiar bancos de preguntas, temarios o materiales de academias o competidores.
- Se pueden citar textos legales públicos con referencia exacta (norma y artículo).
- Preguntas de exámenes oficiales publicados por la Administración: solo si su licencia/publicación lo permite y citando la convocatoria.

## Flujo editorial

`DRAFT → NEEDS_REVIEW → APPROVED → PUBLISHED → ARCHIVED`

- Todo contenido generado o asistido por IA entra como `draft` con `ai_generated = true`.
- La aprobación la realiza una persona con rol `editor`/`admin`; la BD impide publicar sin revisión (`reviewed_by`).
- Criterios de aprobación: respuesta correcta inequívoca y vigente, distractores claramente incorrectos, enunciado claro, explicación con referencia, sin sesgos ni lenguaje discriminatorio, idioma correcto.
- Cambios normativos → el contenido afectado vuelve a `needs_review`.

## Disponibilidad de una oposición

- `coming_soon`: sin contenido publicado suficiente. Se puede seguir y recibir avisos con consentimiento.
- `partial`: hay contenido publicado y revisado para parte de las pruebas/temario (indicar qué).
- `available`: temario completo publicado + banco de preguntas por tema + simulacro con la configuración vigente.
  Nunca marcar `available` sin cumplir lo anterior.

## Tutor IA

- Responde apoyándose en contenido publicado y fuentes oficiales; cita la referencia.
- Si no hay contenido revisado que lo respalde, lo dice y no inventa respuestas "oficiales".

## Marca e independencia

Sin escudos ni logotipos oficiales; texto visible: "Academia independiente, sin vinculación con organismos convocantes".
