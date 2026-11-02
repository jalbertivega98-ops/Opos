---
name: nuevo-psicotecnico
description: Añade un nuevo tipo de ejercicio psicotécnico con generador determinista y solución verificable matemáticamente.
argument-hint: "<tipo: series-numericas | matrices | cubos | ...>"
---

# Nuevo tipo de psicotécnico

**Cuándo usarla:** al incorporar un tipo de psicotécnico (numérico, verbal, abstracto, espacial, atención, lógica…).

**Entradas:** tipo, reglas de generación, niveles de dificultad, tiempo orientativo.

## Procedimiento
1. Define en src/lib/learning/psycho/<tipo>.ts: `generate(seed, difficulty) → { stem, options, correctIndex, explanation, meta }` puro y determinista (PRNG con semilla).
2. Implementa `verify(item)` que recalcula la respuesta y comprueba: una única opción correcta, distractores distintos entre sí y de la correcta, enunciado sin ambigüedad.
3. Tests en tests/unit: misma semilla ⇒ mismo ítem; 1.000 semillas ⇒ `verify` siempre true; casos límite por dificultad.
4. Registra el tipo en el catálogo de generadores y su renderizado en UI (componente accesible, temporizador opcional).
5. Los ítems que se guarden en BD entran como `draft` hasta revisión humana de la plantilla.

## Validaciones
`npm run test` con los property tests; revisión de 10 ítems de muestra por una persona.

## Resultado esperado y criterio de finalización
Generador + verificador + tests en verde + UI jugable + documentación del algoritmo.
