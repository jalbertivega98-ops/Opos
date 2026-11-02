---
name: revisar-contenido
description: Revisa contenido educativo (preguntas, lecciones) para corrección, ambigüedad, actualidad normativa y referencias antes de aprobarlo.
argument-hint: "<ids o filtro de contenido>"
---

# Revisión de contenido educativo

**Cuándo usarla:** sobre preguntas o lecciones en `needs_review`.

**Entradas:** lote a revisar.

## Procedimiento
1. Para cada ítem: ¿la respuesta correcta es inequívocamente correcta según la fuente citada y vigente? ¿Algún distractor podría ser también correcto? ¿El enunciado es claro? ¿La explicación justifica la respuesta y cita el artículo/norma?
2. Comprobar vigencia normativa (reformas recientes) con la fuente oficial.
3. Clasificar: aprobar / devolver a draft con comentario / archivar.
4. La aprobación final la hace una PERSONA (rol editor/admin) en el panel: Claude solo prepara el informe y las correcciones propuestas.

## Validaciones
Ningún ítem aprobado sin fuente; ningún ítem con dos respuestas defendibles.

## Resultado esperado y criterio de finalización
Informe por ítem con veredicto y motivo; correcciones aplicadas a los borradores.
