import type { ReactNode } from "react";
import type { LegalOwner } from "@/lib/legal/owner";

/**
 * Textos legales de OPOSAPRUEBA (castellano). Redactados para una tienda de
 * contenido digital con suscripción; deben revisarse con una asesoría antes
 * de cobrar. Los datos del titular vienen de `legalOwner()` (variables de
 * entorno). Por decisión de joel solo se publica la marca y el correo; NIF y
 * domicilio aparecen únicamente si se configuran (nunca se inventan).
 */

const H2 = ({ children }: { children: ReactNode }) => (
  <h2 className="mt-8 text-xl font-semibold">{children}</h2>
);

function OwnerBlock({ owner }: { owner: LegalOwner }) {
  return (
    <ul className="list-none space-y-1 pl-0">
      <li>
        <strong>Titular:</strong> {owner.name}
      </li>
      {owner.taxId && (
        <li>
          <strong>NIF:</strong> {owner.taxId}
        </li>
      )}
      {owner.address && (
        <li>
          <strong>Domicilio:</strong> {owner.address}
        </li>
      )}
      <li>
        <strong>Correo electrónico:</strong> <a href={`mailto:${owner.email}`}>{owner.email}</a>
      </li>
      {owner.registry && (
        <li>
          <strong>Datos registrales:</strong> {owner.registry}
        </li>
      )}
      <li>
        <strong>Sitio web:</strong> oposaprueba.com
      </li>
    </ul>
  );
}

export function LegalNotice({ owner }: { owner: LegalOwner }) {
  return (
    <>
      <p>
        En cumplimiento del artículo 10 de la Ley 34/2002, de servicios de la sociedad de la
        información y de comercio electrónico (LSSI-CE), se informa de los datos del titular de este
        sitio web:
      </p>
      <OwnerBlock owner={owner} />
      <H2>Objeto</H2>
      <p>
        OPOSAPRUEBA es una academia digital privada e independiente para preparar oposiciones en
        España. No tiene ninguna vinculación con las administraciones ni con los órganos
        convocantes, y no garantiza la obtención de plaza.
      </p>
      <H2>Contenidos y propiedad intelectual</H2>
      <p>
        Las preguntas, explicaciones, simulacros, planes de estudio, textos, diseño y código son
        obra original del titular o se usan con licencia, y están protegidos por la normativa de
        propiedad intelectual. Las normas y documentos oficiales citados pertenecen a sus autores y
        se reproducen como fuente. Se permite el uso personal para estudiar. Está prohibido
        copiarlos, redistribuirlos, venderlos o extraerlos de forma masiva sin autorización escrita.
      </p>
      <H2>Responsabilidad</H2>
      <p>
        Los contenidos se elaboran a partir de fuentes oficiales y se revisan, pero la normativa y
        las convocatorias cambian. Lo que prevalece es siempre la publicación oficial (BOE, diarios
        autonómicos y bases de cada convocatoria). El titular no responde de los daños derivados de
        decisiones tomadas solo con estos contenidos, ni de las interrupciones técnicas ajenas a su
        control.
      </p>
      <H2>Legislación aplicable</H2>
      <p>
        Este sitio se rige por la legislación española. Si eres consumidor, son competentes los
        juzgados de tu domicilio.
      </p>
    </>
  );
}

export function SaleTerms({ owner }: { owner: LegalOwner }) {
  return (
    <>
      <p>
        Estas condiciones regulan el uso de OPOSAPRUEBA y la compra de sus productos digitales. Al
        crear una cuenta o comprar, las aceptas. Puedes guardarlas o imprimirlas desde esta página.
      </p>
      <OwnerBlock owner={owner} />
      <H2>1. Cuenta</H2>
      <p>
        Para usar la plataforma necesitas una cuenta personal con datos veraces. Si tienes menos de
        14 años, necesitas el consentimiento de tus padres o tutores, y para comprar debes ser mayor
        de edad o contar con su autorización. La cuenta es personal e intransferible: no se puede
        compartir.
      </p>
      <H2>2. Productos y precios</H2>
      <ul>
        <li>
          <strong>Gratis:</strong> preguntas tipo test de 3 temas de cada oposición, fichas de
          estudio, plan de estudio, psicotécnicos de práctica y estadísticas.
        </li>
        <li>
          <strong>Productos de pago único</strong> (packs de intentos de simulacro): dan el número
          de intentos indicado, desde el momento del pago y sin fecha de caducidad mientras
          OPOSAPRUEBA preste el servicio. Cada simulacro que empiezas gasta un intento.
        </li>
        <li>
          <strong>Premium</strong> (suscripción mensual por oposición): acceso a todo el contenido
          incluido en Premium de la oposición contratada mientras la suscripción esté activa. Cada
          oposición tiene su propia suscripción.
        </li>
      </ul>
      <p>
        Los precios se muestran en euros, con todos los impuestos incluidos, antes de pagar. Se
        aplica el precio vigente en el momento de la compra.
      </p>
      <H2>3. Compra y pago</H2>
      <p>
        El pago se hace en la pasarela segura de Stripe (tarjeta u otros métodos que ofrezca).
        OPOSAPRUEBA no ve ni guarda los datos de tu tarjeta. Al completar el pago recibes la
        confirmación por correo electrónico y el producto aparece en tu cuenta («Mi perfil»).
      </p>
      <H2>4. Suscripción Premium</H2>
      <p>
        Se renueva automáticamente cada mes y se cobra en la misma fecha. Puedes cancelarla cuando
        quieras desde «Mi perfil → Gestionar suscripción»: seguirás teniendo acceso hasta el final
        del periodo ya pagado y no se te cobrará más. Si un cobro falla, Premium se suspende hasta
        que actualices el método de pago. Si cambiamos el precio, te avisaremos con antelación y
        podrás cancelar antes de que se aplique.
      </p>
      <H2>5. Derecho de desistimiento</H2>
      <p>
        Como consumidor tienes, en general, 14 días naturales para desistir de una compra a
        distancia. Pero los productos de OPOSAPRUEBA son contenido digital que se entrega al
        momento. Por eso, antes de pagar te pedimos que marques que quieres el acceso inmediato y
        que sabes que así pierdes el derecho de desistimiento (artículo 103.m del Real Decreto
        Legislativo 1/2007, texto refundido de la Ley General para la Defensa de los Consumidores y
        Usuarios). Te enviamos esa confirmación junto con la de la compra.
      </p>
      <p>
        Aun así, si el contenido no funciona o no corresponde con lo descrito, escríbenos a{" "}
        <a href={`mailto:${owner.email}`}>{owner.email}</a>: lo arreglaremos y, si no es posible, te
        devolveremos el importe.
      </p>
      <H2>6. Uso aceptable</H2>
      <p>
        No está permitido compartir la cuenta, revender o publicar los contenidos, extraerlos de
        forma automatizada ni eludir las medidas técnicas. Si esto ocurre, podemos suspender la
        cuenta sin reembolso, después de avisarte.
      </p>
      <H2>7. Responsabilidad</H2>
      <p>
        OPOSAPRUEBA te ayuda a prepararte, pero no garantiza que apruebes. Lo que prevalece siempre
        es la publicación oficial de cada convocatoria. Nada de esto limita los derechos que te da
        la ley como consumidor.
      </p>
      <H2>8. Reclamaciones, ley y jurisdicción</H2>
      <p>
        Puedes reclamar escribiendo a <a href={`mailto:${owner.email}`}>{owner.email}</a>, y te
        responderemos en el plazo más breve posible (como máximo, un mes). También puedes acudir a
        las oficinas de consumo o al arbitraje de consumo. Estas condiciones se rigen por la ley
        española, y son competentes los juzgados de tu domicilio.
      </p>
    </>
  );
}

export function PrivacyPolicy({ owner }: { owner: LegalOwner }) {
  return (
    <>
      <H2>Responsable del tratamiento</H2>
      <OwnerBlock owner={owner} />
      <H2>Qué datos tratamos</H2>
      <ul>
        <li>
          <strong>Cuenta:</strong> correo electrónico, contraseña (cifrada, nadie puede verla),
          nombre si lo das e idioma.
        </li>
        <li>
          <strong>Estudio:</strong> oposiciones que sigues, nivel, horas, objetivos, respuestas,
          resultados y progreso.
        </li>
        <li>
          <strong>Uso de la plataforma:</strong> cuándo entras y sales de tu cuenta y cuántos
          minutos al día tienes abierta la zona del alumno (solo el total diario, sin registrar qué
          páginas ves). Lo guardamos 12 meses.
        </li>
        <li>
          <strong>Compras:</strong> qué compraste, importe y estado del pago o de la suscripción.
          Los datos de la tarjeta los trata solo Stripe.
        </li>
        <li>
          <strong>Técnicos:</strong> registros de seguridad para prevenir abusos. La analítica de
          visitas es agregada, sin cookies ni identificadores personales: la contamos nosotros y con
          Vercel Web Analytics, que tampoco usa cookies y no guarda tu dirección IP.
        </li>
      </ul>
      <H2>Para qué y con qué base legal</H2>
      <ul>
        <li>Darte el servicio, la cuenta y los productos que compras: ejecución del contrato.</li>
        <li>Cobrar, facturar y cumplir obligaciones contables y fiscales: obligación legal.</li>
        <li>Avisos sobre las oposiciones que sigues: tu consentimiento, que puedes retirar.</li>
        <li>Seguridad y prevención del fraude: interés legítimo.</li>
        <li>
          Atenderte cuando nos escribes, gestionar accesos y descuentos y mejorar el servicio con el
          uso de la plataforma: interés legítimo. Puedes oponerte escribiéndonos.
        </li>
      </ul>
      <H2>Cuánto tiempo los guardamos</H2>
      <p>
        Mientras tengas la cuenta. Si la borras, eliminamos tus datos. Solo conservamos, sin
        vincularlos a tu perfil, los datos de compras que exige la ley (6 años, según el artículo 30
        del Código de Comercio, y los plazos de la normativa tributaria).
      </p>
      <H2>Con quién los compartimos</H2>
      <p>Solo con proveedores que los tratan por cuenta nuestra y con contrato de encargo:</p>
      <ul>
        <li>Supabase: base de datos y cuentas, en servidores de la UE (Frankfurt).</li>
        <li>Vercel: alojamiento de la web y estadística de visitas (sin cookies).</li>
        <li>Stripe: pagos (Stripe Payments Europe, Irlanda).</li>
        <li>Resend: envío de correos de la cuenta, en servidores de la UE.</li>
      </ul>
      <p>
        Si algún proveedor accede a datos desde fuera del Espacio Económico Europeo, lo hace con las
        garantías del RGPD: Marco de Privacidad de Datos UE-EE. UU. o cláusulas contractuales tipo.
        No vendemos tus datos ni los usamos para publicidad.
      </p>
      <H2>Tus derechos</H2>
      <p>
        Puedes acceder a tus datos, rectificarlos, suprimirlos, oponerte, limitar su tratamiento y
        llevártelos (portabilidad). Desde «Mi perfil» puedes descargar tus datos y borrar la cuenta,
        o escribir a <a href={`mailto:${owner.email}`}>{owner.email}</a>. Si crees que no los
        tratamos bien, puedes reclamar ante la Agencia Española de Protección de Datos (aepd.es).
      </p>
    </>
  );
}

export function CookiePolicy() {
  return (
    <>
      <p>
        OPOSAPRUEBA solo usa cookies técnicas, necesarias para que la web funcione. No requieren
        consentimiento (artículo 22.2 LSSI-CE). No usamos cookies de analítica ni de publicidad: la
        estadística de visitas se cuenta de forma agregada y sin cookies (con nuestro propio
        contador y con Vercel Web Analytics, que no usa cookies ni guarda tu dirección IP).
      </p>
      <table className="mt-4 w-full text-sm">
        <thead>
          <tr className="text-left">
            <th className="py-1 pr-4">Nombre</th>
            <th className="py-1 pr-4">Para qué</th>
            <th className="py-1">Duración</th>
          </tr>
        </thead>
        <tbody>
          <tr>
            <td className="py-1 pr-4">
              <code>sb-*-auth-token</code>
            </td>
            <td className="py-1 pr-4">Mantener tu sesión iniciada</td>
            <td className="py-1">Sesión y renovación</td>
          </tr>
          <tr>
            <td className="py-1 pr-4">
              <code>NEXT_LOCALE</code>
            </td>
            <td className="py-1 pr-4">Recordar el idioma</td>
            <td className="py-1">1 año</td>
          </tr>
          <tr>
            <td className="py-1 pr-4">Tema (almacenamiento local)</td>
            <td className="py-1 pr-4">Recordar el modo claro u oscuro</td>
            <td className="py-1">Persistente</td>
          </tr>
        </tbody>
      </table>
      <p className="mt-4">
        Cuando pagas, lo haces en la página de Stripe (checkout.stripe.com), que usa sus propias
        cookies para la seguridad del pago, según su política. Si algún día añadimos cookies que no
        sean técnicas, te pediremos antes el consentimiento.
      </p>
    </>
  );
}
