# PRD · Requisitos de producto

Estado: vivo. Los IDs enlazan con TASKS.md. Leyenda: ✅ hecho · 🟡 parcial · ⬜ pendiente.

## 1. Catálogo multioposición

- ✅ Jerarquía ámbito → organismo → cuerpo/especialidad → convocatoria → pruebas → temario (BD).
- ✅ Estados de disponibilidad visibles (disponible / parcial / próximamente).
- ✅ Buscador y filtro por categoría; ficha de oposición con convocatorias, pruebas y fuentes (solo verificadas).
- ⬜ Editor en el panel (CNT-001..003). ⬜ Búsqueda sin acentos (CAT-003).

## 2. Usuarios

- ✅ Registro con email + verificación, inicio de sesión, recuperación de contraseña, cierre de sesión.
- ✅ Perfil mínimo (nombre opcional, idioma, rol, estado, fecha de alta, última actividad, consentimiento marketing).
- ✅ Onboarding: oposición, nivel, horas/semana, objetivos, aviso con consentimiento si es "próximamente".
- 🟡 Varias oposiciones por alumno (BD lista; UI de gestión USR-005). ⬜ Selección de convocatoria (USR-006).
- ⬜ Perfil editable, exportación de datos y eliminación de cuenta (USR-007..009).
- ✅ Historial de actividad (eventos) en el dashboard.

## 3. Panel de administración

- ✅ Acceso restringido por rol (admin/owner) en servidor + RLS.
- ✅ KPIs reales: registrados, nuevos 7 días, activos 7 días, onboarding completado, oposiciones más seleccionadas, últimos registros.
- ⬜ Búsqueda/filtros/ficha de alumno, exportación CSV auditada, acciones de suspensión (ADM-001..004).
- ⬜ Métricas de negocio (Premium, ingresos, conversiones, cancelaciones, retención) tras Stripe (BIZ-*).
- ⬜ Gestión educativa, marketing (cupones, promociones), sistema (logs, uso IA, roles, auditoría).

## 4. Experiencia del alumno

- ✅ Landing: presentación, buscador, funcionalidades, catálogo, precios, FAQ, registro. ⬜ Demo gratuita (LRN-002), recursos gratuitos.
- 🟡 Dashboard: plan diario (pendiente de contenido), oposiciones, progreso (sin datos), actividad reciente.
- ⬜ Temario (lecciones, esquemas, flashcards, test por tema, favoritos).
- ⬜ Psicotécnicos (numéricos, verbales, abstractos, espaciales, matrices, cubos, atención, series, lógica) con temporizador.
- ⬜ Simulacros con configuración de la convocatoria, corrección, penalización, historial, repetición de errores.
- ⬜ Tutor IA con referencias a contenido revisado y límites de consumo.
- ⬜ Gamificación: rachas, XP, niveles, logros, retos.

## 5. Motor educativo

- ✅ Banco central de preguntas con estados DRAFT→NEEDS_REVIEW→APPROVED→PUBLISHED→ARCHIVED, versión, fuente, hash anti-duplicados, una sola correcta, publicación solo tras revisión humana.
- ✅ Respuestas correctas inaccesibles para alumnos; corrección vía función de servidor.
- ⬜ Importación CSV/JSON, generadores de psicotécnicos verificables, repetición espaciada.

## 6. Monetización

- ⬜ Stripe en modo test: checkout, portal, webhooks, renovaciones, cancelaciones, pagos fallidos; precio configurable; control de acceso en servidor.

## 7. Requisitos no funcionales

- Seguridad: RLS, validación Zod, rate limiting, cabeceras, sin secretos en repo.
- Accesibilidad WCAG 2.2 AA; mobile first; modo oscuro; es/ca.
- Rendimiento: LCP < 2,5 s en 4G para landing; consultas indexadas.
- Legal: privacidad, cookies, condiciones de contratación (borradores para revisión profesional), RGPD.
