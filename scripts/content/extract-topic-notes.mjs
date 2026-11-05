// Extrae de la Guia d'estudi (texto por temas, p. ej. guia-2026/A1.txt) la ficha de
// estudio de cada tema: índice, «Idees força» y «Glossari», tal cual aparecen en la
// guía y con sus páginas. No redacta nada: solo copia y ordena texto oficial.
//
//   node scripts/content/extract-topic-notes.mjs <carpeta-guia> <carpeta-preguntas> <salida>
//
// <carpeta-preguntas> es content/mossos: de cada lote se toman slug, título y fuente.
import { mkdirSync, readFileSync, readdirSync, writeFileSync } from "node:fs";
import { join } from "node:path";

const [guideDir, questionsDir, outDir] = process.argv.slice(2);
if (!guideDir || !questionsDir || !outDir) {
  console.error(
    "Uso: node scripts/content/extract-topic-notes.mjs <carpeta-guia> <carpeta-preguntas> <salida>",
  );
  process.exit(1);
}

const PAGE = /^\[\[p\.(\d+)\]\]$/;
// Cabeceras y pies repetidos en cada página de la guía
const isHeader = (l) =>
  /Guia d’estudi per accedir a la PG-ME/.test(l) || /^\d*[A-C]\.\d\. .+$/.test(l);
const ITEM = /^(\d+(?:\.\d+)*)\.\s+(.*)$/;
// En los índices algunos subapartados no llevan punto final («4.1 Transformacions…»)
const TOC_ITEM = /^(\d+(?:\.\d+)*\.|\d+(?:\.\d+)+)\s+(.*)$/;
// Artefactos de la extracción del PDF (no son del texto de la guía)
const PDF_FIXES = [["La c ompetència", "La competència"]];
// Términos del glosario que el PDF parte en dos líneas
const GLOSSARY_WRAPS = [
  ["Primer Congrés Internacional de la Llengua", "Catalana"],
  ["Servei Nacional d’Intel·ligència", "Criminal - Europol (SNIC-Europol)"],
];
const fixPdf = (s) => PDF_FIXES.reduce((acc, [a, b]) => acc.replaceAll(a, b), s);

// Une las líneas cortadas por el PDF: «poli-» + «cies» → «policies»; el resto con espacio.
const joinWrapped = (a, b) => (/[a-zà-ú]-$/i.test(a) ? a.slice(0, -1) + b : `${a} ${b}`);

function parsePages(text) {
  const lines = text.split("\n");
  const out = [];
  let page = null;
  for (const raw of lines) {
    const l = raw.trim();
    const m = l.match(PAGE);
    if (m) {
      page = Number(m[1]);
      continue;
    }
    out.push({ page, text: l });
  }
  return out;
}

function numberedList(lines, re = ITEM) {
  const items = [];
  for (const { text } of lines) {
    if (!text || isHeader(text)) continue;
    const m = text.match(re);
    if (m) items.push({ n: m[1], text: m[2] });
    else if (items.length) items.at(-1).text = joinWrapped(items.at(-1).text, text);
  }
  return items;
}

function extract(code, text) {
  const lines = parsePages(text);
  const temaIdx = lines.findIndex((l) => l.text === `Tema ${code}.`);
  if (temaIdx < 0) throw new Error(`${code}: no se encuentra «Tema ${code}.»`);
  // Índice: desde el primer «1. » tras el título hasta el cambio de página
  const tocPage = lines[temaIdx].page;
  let i = temaIdx + 1;
  while (i < lines.length && !/^1\.\s/.test(lines[i].text)) i++;
  const toc = [];
  while (i < lines.length && lines[i].page === tocPage) toc.push(lines[i++]);
  const outline = numberedList(toc, TOC_ITEM).map((it) => ({
    n: it.n.replace(/\.$/, ""),
    title: fixPdf(it.text.replace(/\s+/g, " ").trim()),
  }));

  const ideasIdx = lines.findIndex((l) => l.text === "Idees força");
  const glossIdx = lines.findIndex((l) => l.text === "Glossari");
  if (ideasIdx < 0 || glossIdx < ideasIdx) throw new Error(`${code}: sin Idees força/Glossari`);
  const keyIdeas = numberedList(lines.slice(ideasIdx + 1, glossIdx)).map((it) =>
    it.text.replace(/\s+/g, " ").trim(),
  );
  const glossary = [];
  for (const { text: l } of lines.slice(glossIdx + 1)) {
    if (!l || isHeader(l)) continue;
    if (/^\d[\d ]{8,}$/.test(l) || /^ISBN/.test(l)) break; // contraportada (código de barras)
    const wrap = GLOSSARY_WRAPS.find(([a, b]) => glossary.at(-1) === a && l === b);
    if (wrap) glossary[glossary.length - 1] = `${wrap[0]} ${wrap[1]}`;
    else glossary.push(l);
  }
  const pages = lines.map((l) => l.page).filter((p) => p !== null);
  return {
    outline,
    key_ideas: keyIdeas,
    key_ideas_page: lines[ideasIdx].page,
    glossary,
    page_from: Math.min(...pages),
    page_to: Math.max(...pages),
  };
}

// Esmenes oficials de setembre de 2026 (docs/research/mossos-46-26-fuentes.md §3):
// se muestran junto a la ficha porque algunas «idees força» quedaron desfasadas.
const AMENDMENTS = {
  "A.2": [
    "Esmena oficial (setembre 2026) a la llista de presidents de la Generalitat: Quim Torra, del 17/05/2018 al 28/09/2020; Pere Aragonès, del 24/05/2021 al 10/08/2024; Salvador Illa, des del 10/08/2024.",
  ],
  "A.5": [
    "Esmena oficial (setembre 2026): Catalunya té 42 comarques més l’Aran com a entitat territorial singular (p. 56 i punt 1 de la p. 64), 947 municipis i 8 vegueries.",
  ],
  "B.8": ["Esmena oficial (setembre 2026): el Parlament Europeu té 720 membres."],
};
const AMENDMENTS_SOURCE =
  "https://mossos.gencat.cat/web/.content/home/01_els_mossos_desquadra/ingres-cos/Escala-bAsica/convocatoria-46-26/Esmenes-edicio-PDF-guia-estudi-setembre-2026.pdf";

mkdirSync(outDir, { recursive: true });
let n = 0;
// Los lotes adicionales de un tema (-lot2, -idees-forca…) comparten ficha con el lote principal.
const isExtraLot = (f) => /-(lot\d+|idees-forca)\.json$/.test(f);
for (const f of readdirSync(questionsDir).filter(
  (f) => /^[abc]\d-.*\.json$/.test(f) && !isExtraLot(f),
)) {
  const meta = JSON.parse(readFileSync(join(questionsDir, f), "utf8")).meta;
  if (!meta?.topic_slug || meta.locale !== "ca") continue;
  const code = f
    .slice(0, 2)
    .toUpperCase()
    .replace(/^(.)(\d)$/, "$1.$2");
  const txt = readFileSync(join(guideDir, `${code.replace(".", "")}.txt`), "utf8");
  const note = extract(code, txt);
  const baseUrl = meta.source.url.replace(/#page=\d+$/, "");
  const data = {
    meta: {
      exam: meta.exam,
      topic: meta.topic,
      topic_slug: meta.topic_slug,
      locale: "ca",
      created: new Date().toISOString().slice(0, 10),
      author:
        "Extret automàticament de la Guia d'estudi (text literal, sense redacció pròpia); pendent de revisió humana",
      source: { ...meta.source, url: `${baseUrl}#page=${note.page_from}` },
    },
    ...note,
    amendments: (AMENDMENTS[code] ?? []).map((text) => ({ text, url: AMENDMENTS_SOURCE })),
  };
  writeFileSync(join(outDir, f.replace(/\.json$/, ".json")), JSON.stringify(data, null, 2) + "\n");
  console.log(
    `${code} ${meta.topic_slug}: índice ${note.outline.length}, idees ${note.key_ideas.length}, glossari ${note.glossary.length}, pp. ${note.page_from}-${note.page_to}`,
  );
  n++;
}
console.log(`${n} fichas escritas en ${outDir}`);
