---
name: componente-ui
description: Crea o modifica un componente de interfaz siguiendo el sistema de diseño (tokens, modo oscuro, accesibilidad, i18n).
argument-hint: "<nombre del componente y propósito>"
---

# Componente UI

**Cuándo usarla:** al crear un componente reutilizable en src/components o src/components/ui.

**Entradas:** nombre, propósito, variantes, dónde se usa.

## Procedimiento
1. Revisa docs/DESIGN_SYSTEM.md y los componentes existentes en src/components/ui (no dupliques).
2. Server Component por defecto; "use client" solo si hay estado/eventos.
3. Variantes con `class-variance-authority`, clases con `cn()`; solo colores de los tokens (bg-primary, text-accent, bg-surface…), nunca hex sueltos.
4. Accesibilidad: rol/semántica correctos, nombre accesible, foco visible, `aria-*` en estados.
5. Textos vía props o next-intl.

## Validaciones
Lint + typecheck. Si es visual, captura con Playwright a 390 px y 1280 px en claro y oscuro.

## Resultado esperado y criterio de finalización
Componente documentado en DESIGN_SYSTEM.md (si es primitivo), usado al menos en un sitio, sin errores de lint/tipos.
