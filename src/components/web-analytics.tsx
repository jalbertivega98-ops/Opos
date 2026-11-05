"use client";

import { Analytics, type BeforeSendEvent } from "@vercel/analytics/next";

/**
 * Vercel Web Analytics (ADR-037): cuenta páginas vistas y visitantes sin
 * cookies. Antes de enviar se quitan los parámetros de la URL (pueden llevar
 * códigos de acceso o correos) salvo los utm_*, que sirven para saber de qué
 * campaña viene la visita.
 */
export function stripUrl(url: string): string {
  try {
    const u = new URL(url);
    const keep = new URLSearchParams();
    u.searchParams.forEach((v, k) => {
      if (k.startsWith("utm_")) keep.set(k, v);
    });
    u.search = keep.toString();
    u.hash = "";
    return u.toString();
  } catch {
    return url;
  }
}

function beforeSend(event: BeforeSendEvent): BeforeSendEvent | null {
  return { ...event, url: stripUrl(event.url) };
}

export function WebAnalytics() {
  return <Analytics beforeSend={beforeSend} />;
}
