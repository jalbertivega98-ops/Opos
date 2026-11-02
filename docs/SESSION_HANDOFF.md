# SESSION HANDOFF

**Última actualización:** 2026-11-02 · Sesión 2

## Estado exacto

- **Hitos 0 y 1** completados. **Hito 2** casi completo (faltan USR-004/005/010, ADM-004).
- **P1 hecho (LRN-001, LRN-005):** la práctica de psicotécnicos de alumnos registrados se guarda (sesiones, respuestas, acierto, tiempo medido en BD, tipo, dificultad). `/app/practica` (nueva práctica y repaso de fallos), `/app/practica/[id]` (continúa donde se dejó; resumen con detalle y explicaciones), `/app/progreso` (KPIs, actividad diaria, por tipo y dificultad, fallos pendientes). El panel principal y el admin muestran datos reales. Cada alumno solo ve lo suyo (RLS + E2E). La demo `/psicotecnicos` sigue anónima, no guarda nada e invita a registrarse.
- **P2 hecho:** 7 tipos de psicotécnicos verificables (series, letras con Ñ, numérico, analogías es/ca, matrices, espacial, atención). Tests de manipulación de soluciones, duplicados, reparto de posiciones y textos es/ca.
- **P3 hecho (arquitectura + base):** tienda sin pagos reales: productos, precios, contenido desde el banco, pedidos, suscripciones, concesiones de acceso, «Mis productos», gestión de productos y compras en admin, concesión manual auditada. Premium 14,99 €/mes en borrador.
- **P4 hecho:** editor de preguntas, cola de revisión (aprobar/rechazar/publicar/archivar solo la titular), importación CSV/JSON validada (todo como borrador), duplicados detectados.
- **Repositorio:** `https://github.com/jalbertivega98-ops/Opos` (rama `main`). Copia también en `/mnt/project-files/aprobia/` y en el PC de joel (`C:\Users\34644\Desktop\Claude\OPOS`).

## Cómo reanudar

```bash
git clone https://github.com/jalbertivega98-ops/Opos.git academia && cd academia
npm ci && npm run stack:setup
npm run stack:start -- --seed
node scripts/stack/keys.mjs   # crear .env.local según .env.example (+ AUTH_RATE_LIMIT_MAX=1000 para E2E)
npm run dev
npm run admin:grant -- tu@email.test owner
```

Contenedor cloud: E2E con `PW_CHROMIUM_PATH=/opt/pw-browsers/chromium npx playwright test`. Si un servicio de la pila queda colgado: `pkill -x postgrest` / `pkill -x auth`, borrar su `.local-stack/*.pid` y `npm run stack:start`. **No usar `pkill -f`** (mata la propia shell).

## Pruebas (último run, sesión 2)

typecheck ✅ · lint ✅ · build ✅ · unitarias 70/70 ✅ · BD 51/51 ✅ · E2E 28/28 ✅ (escritorio + móvil)

## Bloqueos (TASKS.md › Bloqueos)

- DEC-003: Supabase cloud, Stripe test, despliegue, SMTP y dominio requieren autorización específica (preparado en DEPLOYMENT.md).
- DEC-004: datos legales del titular pendientes (no inventar).
- DEC-005: "Aprobia" provisional.

## Siguiente fase

1. **CNT-007** primer contenido Mossos: content-researcher localiza bases oficiales vigentes (DOGC) → preguntas con fuente como borrador → la titular revisa en `/admin/revision`.
2. **STO-006 / LRN-003 / MOC-001** práctica con preguntas del banco y simulacros (`mode = questions/mock`, corrección en SQL, `has_product_access`).
3. **STO-005** PDF de un pack desde el banco; **STO-007** tienda pública.
4. **STO-008** Stripe test (con autorización).
5. Mejoras: pausa en el entrenador (PSY-005), cambio de rol en UI (ADM-004), SM-2 para preguntas (LRN-004).

## Notas técnicas

- Next 16: middleware = `src/proxy.ts`; leer `node_modules/next/dist/docs` antes de usar APIs nuevas.
- next-intl no admite puntos en claves de mensajes.
- jsonb reordena claves: comparar presentaciones con `canonical()` (types.ts).
- En tests de BD, un error dentro de la transacción la aborta: usar `savepoint` (helper `fails`).
- Archivos "use server" solo exportan funciones async (esquemas en archivos aparte); `hash.ts` usa `node:crypto` y es server-only.
