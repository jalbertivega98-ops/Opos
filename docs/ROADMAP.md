# Roadmap por hitos

| Hito              | Contenido                                                                                                      | Estado |
| ----------------- | -------------------------------------------------------------------------------------------------------------- | ------ |
| 0 · Preparación   | Entorno, CLAUDE.md, agentes, skills, hooks, docs, Git, backlog, arquitectura                                   | ✅     |
| 1 · Fundación     | Next.js, diseño, BD, auth, i18n, navegación                                                                    | ✅     |
| 2 · Usuarios      | Registro ✅, onboarding ✅, perfil ✅, dashboard con datos reales ✅, admin de alumnos ✅                      | 🟡     |
| 3 · Contenido     | Catálogo ✅, editor ✅, importación ✅, revisión de la titular ✅, temario ⬜, primer contenido ⬜             | 🟡     |
| 4 · Entrenamiento | Práctica guardada ✅, 7 psicotécnicos ✅, estadísticas ✅, repaso de fallos ✅, test del banco y simulacros ⬜ | 🟡     |
| 5 · Negocio       | Tienda (productos, precios, accesos, «Mis productos») ✅; Stripe test ⬜ (autorización); PDF ⬜                | 🟡     |
| 6 · Inteligencia  | Plan adaptativo, tutor IA, recomendaciones, automatizaciones                                                   | ⬜     |
| 7 · Calidad       | Seguridad, pruebas, rendimiento, accesibilidad, SEO, revisión legal/educativa                                  | ⬜     |
| 8 · Lanzamiento   | Despliegue de prueba, piloto, correcciones, producción (requiere autorización)                                 | ⬜     |

## Camino crítico

1. **Primer contenido piloto (CNT-007):** Claude investiga las bases de la convocatoria de Mossos y redacta preguntas con fuente → la titular las revisa en `/admin/revision`.
2. **Test del banco y simulacros (LRN-003, MOC-001, STO-006):** práctica `questions/mock` con corrección en SQL y acceso por `has_product_access`.
3. **Stripe test (STO-008, BIZ-002/003):** solo con autorización específica de joel.
4. **Calidad y despliegue de prueba** (requiere autorización).

## Tienda de productos digitales

Productos: PDF, packs de test interactivos, simulacros, packs combinados y Premium (14,99 €/mes, configurable). Un único banco de preguntas los alimenta. Acceso siempre por concesiones (ADR-016). Pagos reales desactivados.

## Bloqueos externos (requieren a joel)

- ~~Oposición piloto~~ (Mossos) y ~~revisión~~ (la titular) decididas.
- Cuenta Supabase cloud, Stripe (test), dominio, SMTP, proveedor de despliegue.
- Datos del titular para textos legales y revisión profesional.
