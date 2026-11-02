# Roadmap por hitos

| Hito              | Contenido                                                                           | Estado |
| ----------------- | ----------------------------------------------------------------------------------- | ------ |
| 0 · Preparación   | Entorno, CLAUDE.md, agentes, skills, hooks, docs, Git, backlog, arquitectura        | ✅     |
| 1 · Fundación     | Next.js, diseño, BD, auth, i18n, navegación                                         | ✅     |
| 2 · Usuarios      | Registro ✅, onboarding ✅, perfil, dashboard 🟡, admin de alumnos 🟡               | 🟡     |
| 3 · Contenido     | Catálogo ✅, temario, editor, banco de preguntas (BD ✅), flujo de revisión (BD ✅) | 🟡     |
| 4 · Entrenamiento | Motor de test, psicotécnicos, simulacros, estadísticas, repaso                      | ⬜     |
| 5 · Negocio       | Plan gratuito, Premium, Stripe test, control de acceso, analítica                   | ⬜     |
| 6 · Inteligencia  | Plan adaptativo, tutor IA, recomendaciones, automatizaciones                        | ⬜     |
| 7 · Calidad       | Seguridad, pruebas, rendimiento, accesibilidad, SEO, revisión legal/educativa       | ⬜     |
| 8 · Lanzamiento   | Despliegue de prueba, piloto, correcciones, producción (requiere autorización)      | ⬜     |

## Camino crítico

1. **Hito 2** perfil + RGPD (exportar/borrar) → admin de alumnos (búsqueda, ficha, CSV auditado).
2. **Hito 3** editor de preguntas e importación → flujo de revisión en el panel → primeros contenidos reales revisados de UNA oposición piloto.
3. **Hito 4** motor de test (sesiones de práctica + corrección en servidor) → psicotécnicos generados (no dependen de contenido externo) → simulacros.
4. **Hito 5** Stripe test + entitlements en servidor.

Los psicotécnicos generados (Hito 4) pueden adelantarse: son verificables matemáticamente y dan valor sin depender de investigación de temario.

## Bloqueos externos (requieren a joel)

- Elegir oposición piloto y revisor/a de contenido.
- Cuenta Supabase cloud, Stripe (test), dominio, SMTP, proveedor de despliegue.
- Datos del titular para textos legales y revisión profesional.
