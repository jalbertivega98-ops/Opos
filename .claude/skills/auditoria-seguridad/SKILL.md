---
name: auditoria-seguridad
description: Auditoría de seguridad específica del proyecto (RLS, Server Actions, secretos, RGPD). Complementa la revisión nativa /security-review.
---

# Auditoría de seguridad del proyecto

**Cuándo usarla:** antes de cerrar un hito, tras tocar auth/RLS/pagos/datos personales, o antes de un despliegue.

**Entradas:** rama o rango de commits a auditar.

## Procedimiento
1. Ejecuta la revisión nativa `/security-review` sobre los cambios pendientes.
2. Delegar en el agente security-reviewer la checklist del proyecto (docs/SECURITY.md).
3. Comprobaciones automáticas:
   - `npm run test:db` (políticas RLS)
   - `git grep -nE "sk_live|sk_test_[0-9a-zA-Z]{20}|whsec_|SERVICE_ROLE" -- ':!*.md' ':!.env.example'`
   - `grep -rn "createClient\|service" src/lib --include=*.ts` para verificar que la service key solo aparece en server-only
   - `npm audit --omit=dev`
4. Listar tablas sin RLS: `select relname from pg_class c join pg_namespace n on n.oid=c.relnamespace where nspname='public' and relkind='r' and not relrowsecurity;`

## Validaciones
Cero hallazgos críticos/altos abiertos.

## Resultado esperado y criterio de finalización
Informe por severidad en el hilo + tareas SEC-xxx creadas en TASKS.md para lo pendiente.
