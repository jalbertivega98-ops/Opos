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

## 0400 · Derechos RGPD

- `profiles`: el rol `authenticated` solo puede actualizar `display_name, locale, marketing_consent, onboarding_completed_at, role, status` (los dos últimos siguen protegidos por trigger).
- `export_my_data()` → JSON con cuenta, perfil, oposiciones y actividad del propio usuario.
- `delete_my_account()` → borra `auth.users` (cascada) y deja `account.deleted_by_user` anónimo en auditoría. El owner no puede borrarse desde la app.

## 0500 · Gestión de alumnos

- `admin_list_users(q, status, role, exam, onboarded, limit, offset)` con total (`count(*) over()`), búsqueda con comodines escapados.
- `admin_get_user(id)` ficha + objetivos + 20 últimos eventos; audita `user.viewed`.
- `admin_set_user_status(id, status)` audita `user.status_changed`; solo el owner suspende a admins; nadie a sí mismo.

## 0600 · Práctica (LRN-001, ADR-014)

| Tabla               | Descripción                                                                                                  | RLS                    |
| ------------------- | ------------------------------------------------------------------------------------------------------------ | ---------------------- |
| `practice_sessions` | Sesión (modo `psycho/questions/mock/review`, tipo, nº ítems, aciertos, tiempo total, estado)                 | Lectura de las propias |
| `practice_items`    | Ítem mostrado (`presented` sin solución), semilla/versión o `question_id`, elección, acierto, tiempo, repaso | Lectura de las propias |

- Nadie escribe con su JWT. `practice_start()` y `practice_record_answer()` solo los ejecuta `service_role`, desde Server Actions que corrigen en el servidor regenerando el ítem desde la semilla.
- `practice_record_answer` exige responder en orden y una sola vez; el tiempo lo mide la BD (tope 10 min por ítem). Al acertar un ítem de repaso, marca `reviewed_at` en el fallo original.
- `my_practice_stats(days)` (invoker, RLS): totales, racha (hora de Madrid), por tipo, por dificultad y serie diaria. `admin_practice_metrics()` agregado sin datos personales.
- `export_my_data()` incluye sesiones y respuestas.

## 0700 · Revisión de contenido (DEC-002)

- Aprobar, rechazar (`needs_review → draft`), publicar y archivar: solo `owner` (`is_owner()`), cuando la petición viene de la API con usuario.
- `review_question(id, to, comment)` guarda el comentario en `question_reviews`.
- Opciones bloqueadas si la pregunta está aprobada/publicada/archivada; solo se borran borradores. `question_status_counts()`.

## 0800 · Tienda (sin pagos reales)

`products` (tipo `pdf/question_pack/mock_exam/bundle/subscription`, estado, `_ca`, `included_in_premium`, `config`, `stripe_product_id` vacío) · `product_prices` (céntimos, intervalo, histórico: un activo por intervalo) · `product_items` (preguntas o productos hijos) · `product_files` (Storage privado, `source_hash`) · `orders`/`order_items` (se conservan sin `user_id` al borrar la cuenta) · `subscriptions` · `access_grants` (compra, suscripción, admin, gratis; caducidad y revocación).

- Catálogo publicado legible por todos; contenido (`product_items`, `product_files`) solo staff; pedidos, suscripciones y accesos: el propio alumno o admin, sin escritura por JWT.
- `has_product_access(product, user)` (solo servidor) y `my_product_access(product)`: gratis, concesión, pack, pack de intentos con intentos (`mock_credits_left`) o Premium de la oposición del producto (ADR-035; una suscripción sin oposición vale para todo); `my_library()`; `admin_grant_access()` / `admin_revoke_access()` auditadas; `admin_list_purchases()`.
- Semilla: producto `premium` en borrador con precio 14,99 €/mes (editable en el panel).

## 0900 · Editor de preguntas

- `upsert_question(id, payload)` crea/edita pregunta + opciones + oposiciones en una transacción (solo staff, solo borrador o en revisión). Duplicados por `content_hash` (enunciado + opciones normalizados).
- `product_items` solo admite preguntas aprobadas o publicadas; solo los `bundle` contienen otros productos.

## Planificado

- 1000 contenido: `lessons`, `flashcards`, `favorites`; `review_items` (SM-2) para preguntas del banco.
- 1100 IA: `ai_usage` (límites por plan), `ai_conversations`.

## Operación

- Local: `npm run db:migrate`, `npm run db:reset` (borra todo, solo local).
- Asignar rol: `npm run admin:grant -- <email> admin` (local) o SQL en producción: `update public.profiles set role='owner' where id=(select id from auth.users where email='...');`
- Pruebas de BD: `npm run test:db` (`tests/db/rls.test.ts`, `practice.test.ts`, `content-store.test.ts`).
