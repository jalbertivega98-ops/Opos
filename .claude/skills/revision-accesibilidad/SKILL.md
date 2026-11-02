---
name: revision-accesibilidad
description: Revisa la accesibilidad (WCAG 2.2 AA) de páginas y componentes: semántica, teclado, contraste, formularios, idioma y lectores de pantalla.
argument-hint: "<rutas a revisar>"
---

# Revisión de accesibilidad

**Cuándo usarla:** al terminar una pantalla nueva y antes de cerrar cada hito.

**Entradas:** rutas (por defecto: /, /oposiciones, /registro, /entrar, /app, /admin).

## Procedimiento
1. Estructura: un h1 por página, jerarquía de encabezados, landmarks (header/nav/main/footer), enlace "saltar al contenido".
2. Formularios: label asociado, errores con `aria-invalid` + `aria-describedby`, mensajes con role alert/status.
3. Teclado: todo operable sin ratón, foco visible y orden lógico; nada atrapa el foco.
4. Contraste ≥ 4.5:1 (texto normal) en claro y oscuro; no depender solo del color (estado de disponibilidad lleva texto).
5. `lang` correcto (es/ca), textos alternativos, `prefers-reduced-motion` respetado.
6. Si está disponible, añadir comprobación automática con axe en Playwright (tarea QA-004).

## Validaciones
Lista de incidencias con ruta, criterio WCAG y corrección; capturas si procede.

## Resultado esperado y criterio de finalización
Incidencias críticas corregidas; el resto como tareas A11Y-xxx en TASKS.md.
