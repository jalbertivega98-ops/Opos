---
name: importar-preguntas
description: Importa preguntas desde CSV/JSON al banco central como borradores, con validación, detección de duplicados y trazabilidad de fuente.
argument-hint: "<ruta del archivo CSV/JSON>"
---

# Importar preguntas

**Cuándo usarla:** al cargar lotes de preguntas propias o redactadas (nunca de competidores).

**Entradas:** archivo con columnas `stem, options[A-F], correct, explanation, category, topic_slug, difficulty, locale, exam_slugs, source_url`.

## Procedimiento
1. Validar cada fila con Zod: 2–6 opciones, exactamente una correcta, explicación ≥ 10 caracteres, dificultad 1–5, idioma es/ca.
2. Normalizar texto y calcular `content_hash` (enunciado + opciones normalizados) para detectar duplicados (único por idioma).
3. Insertar SIEMPRE con `status = 'draft'` y `ai_generated` según origen; vincular oposiciones (`question_exam_bodies`) y fuente.
4. Informe: insertadas, duplicadas, rechazadas (con motivo y nº de fila).
5. Pasarlas a `needs_review` para el flujo de revisión.

## Validaciones
Dry-run primero; recuento final en BD = insertadas; ninguna pregunta publicada por la importación.

## Resultado esperado y criterio de finalización
Lote en `needs_review` con informe de importación guardado en docs/research/ o content/.
