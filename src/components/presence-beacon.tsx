"use client";

import { useEffect } from "react";

const MINUTE = 60_000;
/** Sin tocar el ratón, el teclado ni la pantalla en 5 minutos, no cuenta. */
const IDLE = 5 * MINUTE;

/**
 * Cuenta el tiempo con la zona del alumno abierta (ADR-038): cada minuto, si
 * la pestaña está visible y ha habido actividad reciente, avisa al servidor.
 */
export function PresenceBeacon() {
  useEffect(() => {
    let lastInput = Date.now();
    const onInput = () => {
      lastInput = Date.now();
    };
    const events = ["pointerdown", "keydown", "scroll", "touchstart", "mousemove"] as const;
    events.forEach((e) => window.addEventListener(e, onInput, { passive: true }));
    const beat = () => {
      if (document.visibilityState !== "visible" || Date.now() - lastInput > IDLE) return;
      void fetch("/api/account/presence", { method: "POST", keepalive: true }).catch(() => {});
    };
    beat();
    const timer = window.setInterval(beat, MINUTE);
    return () => {
      window.clearInterval(timer);
      events.forEach((e) => window.removeEventListener(e, onInput));
    };
  }, []);
  return null;
}
