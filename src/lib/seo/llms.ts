import { examGuides, tr } from "./exam-guides";
import { psychoGuides } from "./psycho-guides";
import { BRAND, absoluteUrl, siteUrl } from "./site";
import type { PublicExam } from "./catalog";

/**
 * /llms.txt (propuesta llmstxt.org): resumen en Markdown para asistentes de IA,
 * con enlaces a las páginas públicas y solo datos verificados (ADR-025).
 */
export function buildLlmsTxt(exams: PublicExam[]): string {
  const L: string[] = [];
  L.push(`# ${BRAND}`);
  L.push("");
  L.push(
    "> Academia digital independiente para preparar oposiciones en España (castellano y catalán): test de temario redactados a partir de fuentes oficiales y revisados por una persona, psicotécnicos interactivos gratuitos y simulacros con el formato del examen oficial. No está vinculada a ningún organismo convocante.",
  );
  L.push("");
  L.push(
    "Cada pregunta de temario cita el artículo o la página de la fuente oficial (BOE, DOGC, Guia d'estudi). Los psicotécnicos se generan y se verifican automáticamente: cada ejercicio tiene una única respuesta correcta y una explicación. Las oposiciones sin contenido revisado se marcan como «próximamente».",
  );
  L.push("");

  L.push("## Oposiciones con guía del examen");
  L.push("");
  for (const g of examGuides()) {
    const exam = exams.find((e) => e.slug === g.slug);
    const name = exam?.name ?? g.slug;
    L.push(
      `- [${name}](${absoluteUrl(`/oposiciones/${g.slug}`)}): ${tr(g.seoDescription, "es")} (datos verificados el ${g.verifiedOn})`,
    );
  }
  L.push("");

  const available = exams.filter((e) => e.availability !== "coming_soon");
  if (available.length) {
    L.push("## Preparaciones disponibles");
    L.push("");
    for (const e of available) {
      L.push(
        `- [${e.name}](${absoluteUrl(`/oposiciones/${e.slug}`)})${e.short_description ? `: ${e.short_description}` : ""}`,
      );
    }
    L.push("");
  }

  L.push("## Psicotécnicos gratuitos (sin registro)");
  L.push("");
  L.push(
    `- [Todos los psicotécnicos](${absoluteUrl("/psicotecnicos")}): 10 ejercicios de dificultad creciente con la solución explicada.`,
  );
  for (const g of psychoGuides()) {
    L.push(
      `- [${tr(g.title, "es")}](${absoluteUrl(`/psicotecnicos/${g.slug}`)}): ${tr(g.description, "es")}`,
    );
  }
  L.push("");

  L.push("## Otras páginas");
  L.push("");
  L.push(`- [Catálogo de oposiciones](${absoluteUrl("/oposiciones")})`);
  L.push(`- [Versión en catalán](${absoluteUrl("/", "ca")})`);
  L.push(`- [Mapa del sitio](${siteUrl()}/sitemap.xml)`);
  L.push("");
  return L.join("\n");
}
