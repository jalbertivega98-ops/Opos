# Base de datos

PostgreSQL (Supabase). Migraciones en `supabase/migrations`, aplicadas en orden. Toda tabla de `public` tiene RLS.

## Roles de aplicación (`app_role`)

`student` (por defecto) · `editor` (contenido) · `admin` (gestión) · `owner` (único que gestiona admins).
Helpers: `current_role_rank()`, `is_staff()` (≥ editor), `is_admin()` (≥ admin). Todos SECURITY DEFINER, `search_path=''`.

## 0100 · Identidad

| Tabla             | Descripción                                                                                                                                       | RLS                                                                                                                               |
| ----------------- | ------------------------------------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------- |
| `profiles`        | 1:1 con `auth.users`: display_name, locale, role, status, onboarding_completed_at, last_active_at, marketing_consent(+_at), deletion_requested_at | Alumno: ve/edita el suyo. Admin: ve/edita todos. Trigger impide cambiar rol/estado sin ser admin y gestionar admins sin ser owner |
| `audit_log`       | Acciones administrativas sensibles (actor, acción, objetivo, metadata)                                                                            | Solo lectura admin; escritura vía `log_admin_action()`                                                                            |
| `activity_events` | Historial del alumno (kind validado)                                                                                                              | Alumno ve los suyos; admin todos; escritura vía `track_activity()`                                                                |

Triggers: `on_auth_user_created` → `handle_new_user()`; `profiles_protect`; `updated_at`.

## 0200 · Catálogo

`regions` (ámbito/territorio) → `organizations` (organismo) → `exam_bodies` (oposición: categoría, `availability`, `is_published`, nombres/descripciones es/ca) → `calls` (convocatorias: año, estado, plazas, fechas, fuente) → `exam_tests` (pruebas: tipo, nº preguntas, duración, `scoring` jsonb, eliminatoria) · `requirements` · `topics` (reutilizables, jerárquicos) + `exam_body_topics` · `sources` (fuentes oficiales verificadas) + `exam_body_sources`.

`user_exam_targets`: oposiciones de cada alumno (principal única por índice parcial, `follow_only`, `notify_consent`, nivel, horas/semana, objetivos).

RLS: lectura pública de lo publicado; escritura solo `is_staff()`; `user_exam_targets` privado del alumno (admin lee).

## 0300 · Banco de preguntas

| Tabla                                    | Notas                                                                                                                                                                                |
| ---------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| `questions`                              | stem, explanation, category, topic, difficulty 1–5, locale, `status` (content_status), version, is_free, ai_generated, source, `content_hash` (único por idioma), autoría y revisión |
| `question_options`                       | A–F, `is_correct` (índice único parcial ⇒ máx. 1 correcta)                                                                                                                           |
| `question_exam_bodies`, `question_calls` | Reutilización entre oposiciones/convocatorias                                                                                                                                        |
| `question_reviews`                       | Historial de transiciones de estado                                                                                                                                                  |

Reglas en BD:

- Transiciones válidas: draft→needs_review→approved→published→archived (y vueltas a revisión).
- Para aprobar/publicar: ≥ 2 opciones, exactamente 1 correcta, explicación ≥ 10 caracteres; publicar exige `reviewed_by`.
- Editar enunciado/explicación incrementa `version`; no se edita contenido aprobado/publicado sin devolverlo a revisión.
- Alumnos y anon no leen preguntas ni opciones. Acceso de demo: `get_demo_questions()` (sin `is_correct`) y `check_demo_answer()`.

## Planificado

- 0400 práctica: `practice_sessions`, `practice_answers`, `review_items` (SM-2), vistas de estadísticas.
- 0500 negocio: `plans`, `prices` (configurables), `subscriptions` (sincronizadas por webhook), `entitlements` (función `has_premium()`), `coupons`.
- 0600 contenido: `lessons`, `flashcards`, `favorites`.
- 0700 IA: `ai_usage` (límites por plan), `ai_conversations`.

## Operación

- Local: `npm run db:migrate`, `npm run db:reset` (borra todo, solo local).
- Asignar rol: `npm run admin:grant -- <email> admin` (local) o SQL en producción: `update public.profiles set role='owner' where id=(select id from auth.users where email='...');`
- Pruebas de RLS: `npm run test:db` (tests/db/rls.test.ts).
