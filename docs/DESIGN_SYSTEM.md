# Sistema de diseño

## Tokens (src/app/globals.css)

| Token                          | Claro            | Oscuro            | Uso                             |
| ------------------------------ | ---------------- | ----------------- | ------------------------------- |
| `primary`                      | #0B2545 marino   | #E8EEF7           | Botones principales, marca      |
| `accent`                       | #0F9B8E turquesa | #2DD4BF           | CTA, progreso, enlaces, foco    |
| `background` / `foreground`    | #FFF / #0B1B33   | #07111F / #E8EEF7 | Base                            |
| `surface`, `surface-2`         | #F5F7FA, #EEF2F7 | #0C1A2E, #11233C  | Secciones, tarjetas secundarias |
| `muted-foreground`             | #4A5A72          | #9FB0C8           | Texto secundario (AA)           |
| `border`, `input`              | #DDE3EC, #CFD7E3 | #1D3150, #27406A  | Bordes                          |
| `danger`, `success`, `warning` |                  |                   | Estados                         |

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

- Mobile first; contenedor `max-w-6xl px-4`; tarjetas `rounded-xl border p-6`.
- Formularios: label visible, ayuda bajo el campo, error con `role=alert`, botón deshabilitado mientras envía.
- Estados: carga (Skeleton), vacío (EmptyState con acción), error (Alert).
- Modo oscuro por clase (`next-themes`), por defecto el del sistema.
- Movimiento: transiciones ≤ 200 ms, respeta `prefers-reduced-motion`.
- Gamificación sobria: números, barras y logros con iconografía lineal; sin mascotas ni confeti.

## Marca

Logo provisional: monograma "A" en cuadrado marino con barra turquesa (src/components/logo.tsx). Sin escudos, placas, uniformes ni logotipos oficiales.
