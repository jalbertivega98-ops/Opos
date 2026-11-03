# Pagos con Stripe

Estado (2026-11-03): **código listo en modo de pruebas**. No hay ninguna cuenta de Stripe conectada ni se cobra nada. Sin `STRIPE_SECRET_KEY` los botones de compra siguen desactivados («Pago próximamente»).

## Cómo funciona

1. El alumno pulsa **Comprar** (pack, simulacro, pack completo) o **Hazte Premium**, marcando la casilla de acceso inmediato (renuncia al desistimiento de 14 días, art. 103.m TRLGDCU).
2. El servidor (`startCheckoutAction`) comprueba sesión, producto publicado con precio activo y que no lo tenga ya, y crea una sesión de **Stripe Checkout** con el importe de **nuestra BD** (`price_data`): no hace falta crear productos ni precios en Stripe.
3. El alumno paga en la página de Stripe (la tarjeta nunca pasa por Aprobia).
4. Stripe avisa a `POST /api/stripe/webhook` (firma verificada con `STRIPE_WEBHOOK_SECRET`). Al volver a `/app/productos?compra=ok` también se confirma la compra, por si el aviso tarda. Las dos vías son idempotentes.
5. Las funciones `billing_*` (solo `service_role`) crean pedido + concesión, o sincronizan la suscripción. `has_product_access()` hace el resto: el candado desaparece.

| Aviso de Stripe                                 | Efecto                                                           |
| ----------------------------------------------- | ---------------------------------------------------------------- |
| `checkout.session.completed` (pago único)       | Pedido `paid` + `access_grants` (source `purchase`)              |
| `checkout.session.async_payment_succeeded`      | Igual, para métodos de pago diferidos                            |
| `checkout.session.completed` (suscripción)      | Alta de Premium                                                  |
| `customer.subscription.created/updated/deleted` | Estado de Premium (se relee en Stripe: los avisos se desordenan) |
| `charge.refunded` (total)                       | Pedido `refunded` y acceso retirado                              |

Premium: renovación, cancelación y pago fallido llegan como `customer.subscription.updated/deleted`. Solo `active`/`trialing` dan acceso; impagado pasa a `past_due` y lo pierde. El alumno gestiona tarjeta, facturas y baja en el **portal de Stripe** («Gestionar suscripción»).

## Seguridad

- Clave real (`sk_live_`) **bloqueada** salvo `STRIPE_LIVE_ENABLED=true` (solo con autorización de joel).
- Un aviso real nunca se procesa con clave de pruebas ni al revés.
- Metadatos (`user_id`, `product_id`, `price_id`) los pone el servidor; se validan como UUID.
- `/api` queda fuera de la contraseña de la preview para que Stripe pueda avisar; sin firma válida responde 400.

## Pasos de joel (modo de pruebas)

1. Crear cuenta en <https://dashboard.stripe.com/register> (solo email; para pruebas no hacen falta datos fiscales ni banco).
2. Con **Modo de prueba** activado: _Desarrolladores → Claves de API_ → copiar la **clave secreta** `sk_test_…`.
3. _Desarrolladores → Webhooks → Añadir destino_: URL `https://opos-indol.vercel.app/api/stripe/webhook`, eventos de la tabla de arriba → copiar el **secreto de firma** `whsec_…`.
4. _Configuración → Facturación → Portal de clientes_ → **Guardar** (activa el portal en pruebas).
5. Vercel → proyecto → _Settings → Environment Variables_: `STRIPE_SECRET_KEY` y `STRIPE_WEBHOOK_SECRET` → **Redeploy**. Las claves no se pegan en el chat.
6. En `/admin/productos`: precio y estado **Publicado** de cada producto que se vaya a vender (Premium incluido).
7. Probar con la tarjeta `4242 4242 4242 4242`, fecha futura y CVC cualquiera.

## Antes de cobrar de verdad (requiere autorización expresa)

- Activar la cuenta en Stripe con los datos reales del titular (DNI o empresa, IBAN, alta de autónomo). Claude no los rellena (DEC-004).
- Aviso legal, condiciones de venta, privacidad (Stripe como encargado) revisados.
- Decidir facturación/IVA (Stripe Tax o facturas propias).
- Claves `sk_live_`, webhook real y `STRIPE_LIVE_ENABLED=true`.

## Pruebas

`tests/unit/billing.test.ts` (configuración, Checkout, avisos, firma), `tests/db/billing.test.ts` (funciones y permisos) y `tests/e2e/billing.spec.ts` (aviso firmado → acceso; botón con consentimiento). Las E2E arrancan con una clave ficticia `sk_test_e2e_dummy` y el secreto `whsec_e2e_local` (`playwright.config.ts`): no necesitan cuenta.

Local con Stripe real de pruebas: `stripe listen --forward-to localhost:3000/api/stripe/webhook` y poner el `whsec_` que imprime en `.env.local`.
