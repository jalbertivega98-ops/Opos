---
name: anadir-oposicion
description: Da de alta una nueva oposición en el catálogo (organismo, cuerpo, convocatoria, pruebas, requisitos, temario) con fuentes oficiales verificadas.
argument-hint: "<nombre de la oposición>"
---

# Añadir una oposición

**Cuándo usarla:** para incorporar un cuerpo/especialidad nuevo o una convocatoria nueva.

**Entradas:** nombre, organismo, ámbito; fuentes oficiales (BOE/diario autonómico/BOP).

## Procedimiento
1. Investigación (agente content-researcher): localizar la convocatoria vigente y las bases. Anotar URL, fecha y fecha de consulta.
2. Crear/reusar `regions` y `organizations`; crear `exam_bodies` con `availability = 'coming_soon'` y `is_published = true` solo si la ficha básica es correcta.
3. Registrar `sources` y vincular (`exam_body_sources`). Crear `calls`, `exam_tests` (nº preguntas, duración, puntuación/penalización), `requirements` y `exam_body_topics` SOLO con datos verificados.
4. Reutilizar `topics` existentes (p. ej. Constitución) antes de crear nuevos.
5. Cambiar `availability` a `partial`/`available` únicamente cuando haya contenido publicado y revisado suficiente (docs/CONTENT_POLICY.md).
6. Mientras no exista el editor del panel admin, hacerlo con una migración de datos o seed revisado.

## Validaciones
Ficha visible en /oposiciones/<slug>, enlaces de fuentes funcionando, nada sin fuente.

## Resultado esperado y criterio de finalización
Oposición en catálogo con su estado de disponibilidad honesto y todas las cifras respaldadas por una fuente oficial.
