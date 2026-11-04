# Sistema de diseño

## Tokens (src/app/globals.css)

| Token                          | Claro            | Oscuro            | Uso                             |
| ------------------------------ | ---------------- | ----------------- | ------------------------------- |
| `primary`                      | #0B2545 marino   | #E8EEF7           | Botones principales, marca      |
| `accent`                       | #0A7A70 turquesa | #2DD4BF           | CTA, progreso, enlaces, foco    |
| `background` / `foreground`    | #FFF / #0B1B33   | #07111F / #E8EEF7 | Base                            |
| `surface`, `surface-2`         | #F5F7FA, #EEF2F7 | #0C1A2E, #11233C  | Secciones, tarjetas secundarias |
| `muted-foreground`             | #4A5A72          | #9FB0C8           | Texto secundario (AA)           |
| `border`, `input`              | #DDE3EC, #CFD7E3 | #1D3150, #27406A  | Bordes                          |
| `danger`, `success`, `warning` |                  |                   | Estados                         |
| `highlight` (+ `-soft`)        | #FFD166 marcador | #F2C14E           | Resaltar lo importante, repaso  |
| `ink` (+ `-2`, `-muted`)       | #0B2545 tinta    | #0E2A4F           | Franjas y tarjeta principal     |

El turquesa se oscureció de #0F9B8E a #0A7A70 (rediseño 2026-11-03): el anterior no llegaba a 4,5:1 con texto blanco ni como texto sobre blanco.

Uso en Tailwind: `bg-primary`, `text-accent`, `bg-surface`, `border-border`… Nunca colores hex sueltos en componentes.

## Tipografía

- Texto: Inter (`font-sans`). Titulares: Plus Jakarta Sans 600–800 (`font-display`), tracking −0.02em.
- Escala: h1 36–48 px, h2 30 px, h3 18 px, cuerpo 16 px (14 px en tablas/ayudas).

## Componentes base (src/components/ui)

- `Button` (variants: primary, accent, outline, ghost, danger, link · sizes: sm, md, lg, icon · `asChild`).
- `Input`, `Label`, `FieldError`, `Alert` (info/error/success).
- `Card`, `Badge` (neutral/accent/warning/success), `Skeleton`, `EmptyState`.
- Patrón shadcn/ui (CVA + `cn`) escrito a mano: el registro de shadcn no es accesible desde el entorno (ADR-005).

## Patrones

- Mobile first; contenedor `max-w-6xl px-4`; tarjetas ver «Radios y espaciado».
- Formularios: label visible, ayuda bajo el campo, error con `role=alert`, botón deshabilitado mientras envía.
- Estados: carga (Skeleton), vacío (EmptyState con acción), error (Alert).
- Modo oscuro por clase (`next-themes`), por defecto el del sistema.
- Movimiento: transiciones ≤ 200 ms en controles (`.press`, escala 0,97 al pulsar), aparición de pestañas y resultados con `.animate-fade-up` (260 ms) y `.animate-pop`, y entrada de secciones de la portada con `Reveal` (500 ms, una sola vez). Con `prefers-reduced-motion` todo aparece sin animar. Nada se mueve solo: sin bucles, carruseles automáticos ni sonido.
- Gamificación sobria: números, barras y logros con iconografía lineal; sin mascotas ni confeti.

## Identidad visual (rediseño 2026-11-03, ADR-018)

Idea: **cuaderno de estudio con método**. Tres recursos propios, usados con moderación:

- **Marcador** (`.marker`, color `highlight`): subraya una palabra clave del titular y señala lo que hay que repasar. Nunca más de uno por pantalla en titulares.
- **Papel cuadriculado** (`.bg-grid`): fondo de las zonas de entrenamiento (hero de la portada, tarjeta «Continuar practicando»).
- **Tinta** (`bg-ink`): franjas marinas para mensajes clave y la acción principal del panel. Texto `ink-foreground`, secundario `ink-muted`, antetítulo `highlight`.

### Jerarquía de secciones (`src/components/ui/section.tsx`)

`Section tone`: `plain` (contenido principal), `surface` (apoyo y listados), `grid` (entrenamiento), `ink` (mensaje clave). Alternar tonos entre secciones consecutivas para que se distingan.
`SectionHeader`: antetítulo (`Eyebrow`, mayúsculas espaciadas) → título `text-3xl/4xl font-extrabold` → explicación `text-lg muted` → acción a la derecha. Títulos, explicaciones y acciones se distinguen siempre por tamaño, peso y color.

### Componentes visuales

- `IconBadge` (icono lineal sobre fondo suave; tonos accent, highlight, ink, neutral, onInk).
- `ProgressRing` (anillo SVG con `aria-label`), `Meter` (barra con `role=progressbar`), `DayBars` (barras por día con tabla oculta para lectores de pantalla).
- `AppNav` (navegación del alumno con iconos y sección activa `aria-current`).
- Portada interactiva (ADR-023):
  - `landing/practice-picker.tsx`: selector «¿Qué quieres practicar?» con un psicotécnico **real** por categoría, generado en servidor y corregido con `checkDemoAnswer`. Va en un marco de móvil con la etiqueta «Demostración» y no se guarda en ninguna cuenta.
  - `landing/product-tour.tsx`: pestañas Entrenamiento / Resultados / Progreso (ARIA tabs, flechas, Inicio y Fin). Cada vista esquemática lleva «Vista de ejemplo · no son datos de ningún alumno».
  - Catálogo: las oposiciones con contenido muestran cifras reales publicadas (`exam_offer`); las demás, en una lista de «próximamente».
  - Ilustraciones propias en SVG (trazos de cuaderno, camino de los tres pasos), decorativas (`aria-hidden`).
- Las pantallas de ejercicio no usan estas animaciones ni decoración: solo el enunciado, las opciones y la corrección.

### Panel del alumno: dos niveles

1. Nivel 1: «Continuar practicando» (práctica a medias → siguiente tarea del plan → psicotécnicos) con acceso rápido «Repasar mis N errores» cuando hay pendientes, progreso de 7 días, repaso de errores y plan de la semana.
2. Nivel 2 («Más opciones», tarjetas `surface` pequeñas): mis oposiciones, actividad reciente, accesos a práctica, productos y perfil.

Estados: carga (`app/loading.tsx`, esqueleto con la misma estructura), error (`app/error.tsx`, con reintentar) y vacío (texto que explica qué hacer para que aparezcan datos).

### Radios y espaciado

Tarjetas principales `rounded-3xl p-6/8`, secundarias `rounded-2xl p-5`, controles `rounded-xl`, objetivos táctiles ≥ 44 px (`min-h-11`). Secciones `py-14 sm:py-20`.

## Marca

**OPOSAPRUEBA** (antes «Aprobia», ADR-023). Logo (`src/components/logo.tsx`, `src/app/icon.svg`): casilla marcada en amarillo marcador dentro de un cuadrado marino, el «apto» de quien entrena con método. Palabra en dos tonos: «OPOS» en tinta y «APRUEBA» en turquesa. En móvil el logo baja a 15 px para que la cabecera quepa en 390 px. Sin escudos, placas, uniformes ni logotipos oficiales.
