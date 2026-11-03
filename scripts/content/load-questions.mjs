// Carga un lote de preguntas (JSON de content/) en la base de datos LOCAL.
//
//   node scripts/content/load-questions.mjs content/mossos/b1-estatut.json
//     → preguntas reales SIEMPRE como borrador (DEC-002: las aprueba la titular).
//
//   node scripts/content/load-questions.mjs content/test/pack-prueba.json --test --publish-as titular@x.test
//     → SOLO contenido de prueba (meta.is_test): se marca is_test, la cuenta titular
//       indicada lo aprueba y publica y se crea el producto de prueba. El script se
//       niega a publicar un lote que no sea de prueba.
//
// Idempotente: una pregunta con la misma huella (enunciado + opciones) no se duplica.
import { readFileSync } from "node:fs";
import { createHash } from "node:crypto";
import pg from "pg";

const args = process.argv.slice(2);
const file = args.find((a) => !a.startsWith("--") && args[args.indexOf(a) - 1] !== "--publish-as");
const isTestFlag = args.includes("--test");
const publishAs = args.includes("--publish-as") ? args[args.indexOf("--publish-as") + 1] : null;
if (!file) {
  console.error(
    "Uso: node scripts/content/load-questions.mjs <lote.json> [--test --publish-as <email>]",
  );
  process.exit(1);
}
const data = JSON.parse(readFileSync(file, "utf8"));
const meta = data.meta ?? {};
if (isTestFlag !== Boolean(meta.is_test)) {
  console.error("El flag --test debe coincidir con meta.is_test del lote. Nada cargado.");
  process.exit(1);
}
if (publishAs && !meta.is_test) {
  console.error("Solo el contenido de prueba se puede publicar desde el script (DEC-002).");
  process.exit(1);
}

const normalize = (s) =>
  s.normalize("NFKD").replace(/\p{M}/gu, "").toLowerCase().replace(/\s+/g, " ").trim();
const hash = (q) =>
  createHash("sha256")
    .update([normalize(q.stem), ...q.options.map(normalize).sort()].join("␟"))
    .digest("hex");

const db = new pg.Client({
  connectionString: process.env.LOCAL_DB_URL ?? "postgres://postgres@127.0.0.1:54322/academia",
});
await db.connect();
await db.query("begin");
try {
  const exam = meta.exam
    ? (await db.query("select id from public.exam_bodies where slug = $1", [meta.exam])).rows[0]?.id
    : null;

  let sourceId = null;
  if (meta.source) {
    const s = meta.source;
    sourceId = (
      await db.query(
        `insert into public.sources (title, url, kind, publisher, published_on, notes)
         values ($1, $2, $3::public.source_kind, $4, $5, $6)
         on conflict (url) do update set title = excluded.title returning id`,
        [
          s.title,
          s.url,
          s.kind ?? "web_oficial",
          s.publisher ?? null,
          s.published_on ?? null,
          s.notes ?? null,
        ],
      )
    ).rows[0].id;
  }

  let topicId = null;
  if (meta.topic_slug) {
    topicId = (
      await db.query(
        `insert into public.topics (slug, title) values ($1, $2)
         on conflict (slug) do update set title = excluded.title returning id`,
        [meta.topic_slug, meta.topic],
      )
    ).rows[0].id;
    if (exam)
      await db.query(
        `insert into public.exam_body_topics (exam_body_id, topic_id) values ($1, $2) on conflict do nothing`,
        [exam, topicId],
      );
  }

  let ownerId = null;
  if (publishAs) {
    ownerId = (
      await db.query(
        `select p.id from public.profiles p join auth.users u on u.id = p.id
          where lower(u.email) = lower($1) and p.role = 'owner'`,
        [publishAs],
      )
    ).rows[0]?.id;
    if (!ownerId) throw new Error(`${publishAs} no existe o no es la titular`);
  }

  const ids = [];
  let created = 0;
  for (const q of data.questions) {
    if (q.options.length < 2 || q.correct < 0 || q.correct >= q.options.length)
      throw new Error(`Pregunta mal formada: ${q.stem}`);
    const h = hash(q);
    const locale = q.locale ?? meta.locale ?? "es";
    const found = await db.query(
      "select id from public.questions where locale = $1::public.locale_code and content_hash = $2",
      [locale, h],
    );
    let id = found.rows[0]?.id;
    if (!id) {
      id = (
        await db.query(
          `insert into public.questions (stem, explanation, category, topic_id, difficulty, locale,
             ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
           values ($1,$2,$3,$4,$5,$6::public.locale_code,$7,$8,$9,$10,$11,$12,$13) returning id`,
          [
            q.stem,
            q.explanation,
            q.category ?? meta.category,
            topicId,
            q.difficulty ?? 2,
            locale,
            !meta.is_test,
            sourceId,
            q.ref ?? null,
            q.excerpt ?? null,
            [q.excerpt_status === "parcial" ? "EXTRACTO PARCIAL." : null, q.review_note ?? null]
              .filter(Boolean)
              .join(" ") || null,
            h,
            Boolean(meta.is_test),
          ],
        )
      ).rows[0].id;
      for (const [i, body] of q.options.entries())
        await db.query(
          "insert into public.question_options (question_id, label, body, is_correct) values ($1,$2,$3,$4)",
          [id, String.fromCharCode(65 + i), body, i === q.correct],
        );
      if (exam)
        await db.query(
          "insert into public.question_exam_bodies (question_id, exam_body_id) values ($1,$2) on conflict do nothing",
          [id, exam],
        );
      created++;
    }
    ids.push(id);
  }

  if (ownerId) {
    // la titular de prueba aprueba y publica (el trigger exige auth.uid() = titular)
    await db.query("select set_config('request.jwt.claims', $1, true)", [
      JSON.stringify({ sub: ownerId, role: "authenticated" }),
    ]);
    await db.query("select set_config('request.jwt.claim.sub', $1, true)", [ownerId]);
    for (const id of ids) {
      const { status } = (await db.query("select status from public.questions where id = $1", [id]))
        .rows[0];
      const path =
        {
          draft: ["needs_review", "approved", "published"],
          needs_review: ["approved", "published"],
          approved: ["published"],
        }[status] ?? [];
      for (const to of path)
        await db.query(
          "update public.questions set status = $2::public.content_status where id = $1",
          [id, to],
        );
    }
    if (meta.product) {
      const p = meta.product;
      const productId = (
        await db.query(
          `insert into public.products (slug, type, status, title, title_ca, description, exam_body_id,
             is_free, included_in_premium, is_test, created_by)
           values ($1, 'question_pack', 'published', $2, $3, $4, $5, false, false, true, $6)
           on conflict (slug) do update set title = excluded.title returning id, is_test`,
          [p.slug, p.title, p.title_ca ?? null, p.description ?? null, exam, ownerId],
        )
      ).rows[0];
      if (!productId.is_test) throw new Error(`El producto ${p.slug} existe y no es de prueba`);
      for (const [pos, id] of ids.entries())
        await db.query(
          `insert into public.product_items (product_id, position, question_id) values ($1,$2,$3)
           on conflict do nothing`,
          [productId.id, pos, id],
        );
      console.log(`Producto de prueba: ${p.slug}`);
    }
    if (meta.mock) {
      // Simulacro de prueba: toma las preguntas publicadas del tema del lote
      if (!meta.topic_slug) throw new Error("meta.mock necesita meta.topic_slug");
      const m = meta.mock;
      const mock = (
        await db.query(
          `insert into public.products (slug, type, status, title, title_ca, description, exam_body_id,
             is_free, included_in_premium, is_test, created_by, config)
           values ($1, 'mock_exam', 'published', $2, $3, $4, $5, false, false, true, $6, $7)
           on conflict (slug) do update set title = excluded.title, config = excluded.config
           returning id, is_test`,
          [
            m.slug,
            m.title,
            m.title_ca ?? null,
            m.description ?? null,
            exam,
            ownerId,
            { ...m.config, topic_prefix: meta.topic_slug },
          ],
        )
      ).rows[0];
      if (!mock.is_test) throw new Error(`El producto ${m.slug} existe y no es de prueba`);
      console.log(`Simulacro de prueba: ${m.slug}`);
    }
  }
  await db.query("commit");
  console.log(
    `${file}: ${data.questions.length} preguntas, ${created} nuevas${ownerId ? " (prueba, publicadas)" : " (borrador)"}`,
  );
} catch (e) {
  await db.query("rollback");
  console.error(e.message);
  process.exitCode = 1;
} finally {
  await db.end();
}
