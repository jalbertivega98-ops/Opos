"use client";

import { useCallback, useEffect, useState } from "react";
import { useTranslations } from "next-intl";
import { Compass } from "lucide-react";
import { SpotlightTour, type SpotlightStep } from "@/components/tour/spotlight-tour";

/** Recordado solo en este navegador: la guía sale una vez por visitante. */
export const VISITOR_TOUR_KEY = "opa.visitorTour";
const OPEN_EVENT = "opa:visitor-tour";
const TEST_FORM = '[data-testid="hero-free-tests"]';

/**
 * Pasos de la guía de la portada. `target` = `data-tour` del elemento de la
 * portada que se resalta; el del test gratis es interactivo (se puede elegir
 * la oposición y pulsar «Empezar test» sin salir de la guía).
 */
export const VISITOR_TOUR_STEPS: readonly SpotlightStep[] = [
  { key: "welcome", target: null },
  { key: "test", target: "v-test", interactive: true },
  { key: "search", target: "v-search" },
  { key: "how", target: "v-how" },
  { key: "pricing", target: "v-pricing" },
  { key: "signup", target: "v-signup", interactive: true },
];

function readDone(): boolean {
  try {
    return window.localStorage.getItem(VISITOR_TOUR_KEY) === "done";
  } catch {
    return false;
  }
}

function markDone() {
  try {
    window.localStorage.setItem(VISITOR_TOUR_KEY, "done");
  } catch {
    // Navegación privada sin almacenamiento: volverá a salir, sin más.
  }
}

/**
 * Guía paso a paso para quien entra por primera vez sin cuenta (ADR-057): le
 * señala dónde pulsar para empezar (el test gratis), dónde buscar su oposición,
 * los vídeos de «Cómo funciona», los precios y cómo crear la cuenta. Sale sola
 * la primera vez (recordado en el navegador), con `?guia=1` o con el botón
 * «¿Primera vez aquí?». Los alumnos con sesión no la ven (tienen WelcomeTour).
 */
export function VisitorTour({ force = false }: { force?: boolean }) {
  const t = useTranslations("visitorTour");
  const [open, setOpen] = useState(false);

  useEffect(() => {
    const show = () => setOpen(true);
    window.addEventListener(OPEN_EVENT, show);
    const id = force || !readDone() ? window.setTimeout(show, 700) : undefined;
    return () => {
      window.removeEventListener(OPEN_EVENT, show);
      if (id) window.clearTimeout(id);
    };
  }, [force]);

  const close = useCallback(() => {
    markDone();
    setOpen(false);
  }, []);

  // Si empieza el test desde el paso interactivo, la guía ya ha cumplido.
  useEffect(() => {
    if (!open) return;
    const form = document.querySelector<HTMLFormElement>(TEST_FORM);
    const onSubmit = () => close();
    form?.addEventListener("submit", onSubmit);
    return () => form?.removeEventListener("submit", onSubmit);
  }, [open, close]);

  if (!open) return null;

  const hasTest = Boolean(document.querySelector(TEST_FORM));
  const startTest = () => {
    const form = document.querySelector<HTMLFormElement>(TEST_FORM);
    close();
    form?.requestSubmit();
  };

  return (
    <SpotlightTour
      steps={VISITOR_TOUR_STEPS}
      namespace="visitorTour"
      onClose={close}
      finishLabel={t("finish")}
      scrollBlock="center"
      testId="visitor-tour"
      lastExtra={
        hasTest && (
          <p className="mt-3 text-sm">
            <button
              type="button"
              onClick={startTest}
              className="text-accent font-semibold hover:underline"
              data-testid="visitor-tour-test"
            >
              {t("startTest")}
            </button>
          </p>
        )
      }
    />
  );
}

/** Botón discreto de la portada para volver a abrir la guía. */
export function VisitorTourLauncher() {
  const t = useTranslations("visitorTour");
  return (
    <button
      type="button"
      onClick={() => window.dispatchEvent(new Event(OPEN_EVENT))}
      className="text-muted-foreground hover:text-accent inline-flex items-center gap-1.5 text-sm font-medium underline-offset-4 hover:underline"
      data-testid="visitor-tour-launch"
    >
      <Compass className="size-4" aria-hidden />
      {t("launch")}
    </button>
  );
}
