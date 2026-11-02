---
name: preparar-despliegue
description: Prepara (sin ejecutar) un despliegue de prueba o producción: checklist, variables, migraciones, plantillas de email y verificación. Nunca despliega sin autorización.
disable-model-invocation: true
---

# Preparar despliegue

**Cuándo usarla:** solo cuando joel lo pida explícitamente.

**Entradas:** entorno destino (preview/staging/producción) y proveedor (por defecto Vercel + Supabase).

## Procedimiento
1. Regresión completa (skill pruebas-regresion) y `npm run build` en verde.
2. Revisar docs/DEPLOYMENT.md: variables de entorno requeridas, plantillas de email de Supabase (usar /auth/confirm con token_hash), URLs permitidas de redirección, SMTP propio.
3. Listar migraciones pendientes para el proyecto remoto.
4. Preparar checklist de verificación post-despliegue (registro, login, recuperación, catálogo, admin).
5. PARAR y pedir autorización a joel para: crear/conectar cuentas, aplicar migraciones remotas, desplegar, configurar dominio o SMTP.

## Validaciones
Ningún secreto en el repo; variables documentadas; plan de rollback.

## Resultado esperado y criterio de finalización
Checklist completa entregada a joel con los pasos que requieren su autorización claramente marcados.
