import type { Metadata } from "next";
import { getFormatter, getTranslations, setRequestLocale } from "next-intl/server";
import { Link } from "@/i18n/navigation";
import { Button } from "@/components/ui/button";
import { Badge, Card, EmptyState } from "@/components/ui/card";
import { Alert } from "@/components/ui/form";
import { listQuestions, statusCounts } from "@/lib/admin/content/queries";
import { CONTENT_STATUSES } from "@/lib/admin/content/schema";

export const metadata: Metadata = { title: "Admin · Preguntas", robots: { index: false } };

const inputCls = "border-input bg-background h-10 rounded-lg border px-3 text-sm";

export default async function QuestionsPage({
  params,
  searchParams,
}: PageProps<"/[locale]/admin/preguntas">) {
  const { locale } = await params;
  setRequestLocale(locale);
  const sp = await searchParams;
  const one = (v: unknown) => (typeof v === "string" ? v : undefined);
  const status = CONTENT_STATUSES.includes(one(sp.estado) as never) ? one(sp.estado) : undefined;
  const page = Number(one(sp.p) ?? 1) || 1;
  const t = await getTranslations("adminContent");
  const format = await getFormatter();
  const [list, counts] = await Promise.all([
    listQuestions({ status, category: one(sp.cat), q: one(sp.q), page }),
    statusCounts(),
  ]);
  const pages = Math.max(1, Math.ceil(list.total / list.pageSize));
  const qs = (p: number) =>
    `/admin/preguntas?${new URLSearchParams({
      ...(status ? { estado: status } : {}),
      ...(one(sp.cat) ? { cat: one(sp.cat)! } : {}),
      ...(one(sp.q) ? { q: one(sp.q)! } : {}),
      p: String(p),
    })}`;

  return (
    <div className="mx-auto max-w-6xl space-y-6 px-4 py-8">
      <div className="flex flex-wrap items-start justify-between gap-4">
        <div>
          <h1 className="text-3xl font-bold">{t("title")}</h1>
          <p className="text-muted-foreground mt-1 max-w-2xl text-sm">{t("subtitle")}</p>
        </div>
        <div className="flex gap-2">
          <Button asChild variant="outline">
            <Link href="/admin/preguntas/importar">{t("import")}</Link>
          </Button>
          <Button asChild variant="accent">
            <Link href="/admin/preguntas/nueva">{t("new")}</Link>
          </Button>
        </div>
      </div>
      {sp.deleted === "1" && <Alert tone="success">{t("deleted")}</Alert>}

      <nav aria-label={t("status")} className="flex flex-wrap gap-2 text-sm">
        <Link
          href="/admin/preguntas"
          className={`rounded-full border px-3 py-1 ${!status ? "bg-accent text-accent-foreground border-accent" : ""}`}
        >
          {t("all")}
        </Link>
        {CONTENT_STATUSES.map((s) => (
          <Link
            key={s}
            href={`/admin/preguntas?estado=${s}`}
            aria-current={status === s ? "page" : undefined}
            className={`rounded-full border px-3 py-1 ${status === s ? "bg-accent text-accent-foreground border-accent" : ""}`}
          >
            {t(`statuses.${s}`)} ({counts[s] ?? 0})
          </Link>
        ))}
      </nav>

      <form className="flex flex-wrap gap-2" role="search">
        {status && <input type="hidden" name="estado" value={status} />}
        <input
          name="q"
          defaultValue={one(sp.q)}
          placeholder={t("search")}
          aria-label={t("search")}
          className={`${inputCls} min-w-56 flex-1`}
        />
        <input
          name="cat"
          defaultValue={one(sp.cat)}
          placeholder={t("category")}
          aria-label={t("category")}
          className={inputCls}
        />
        <Button type="submit" variant="outline" size="sm" className="h-10">
          {t("filter")}
        </Button>
      </form>

      <p className="text-muted-foreground text-sm">{t("total", { count: list.total })}</p>
      {list.rows.length === 0 ? (
        <EmptyState title={t("empty")} />
      ) : (
        <Card className="overflow-x-auto p-0">
          <table className="w-full min-w-[720px] text-left text-sm" data-testid="questions-table">
            <thead className="text-muted-foreground border-border border-b">
              <tr>
                <th className="px-4 py-3 font-medium">{t("form.stem")}</th>
                <th className="px-4 py-3 font-medium">{t("category")}</th>
                <th className="px-4 py-3 font-medium">{t("difficulty")}</th>
                <th className="px-4 py-3 font-medium">{t("status")}</th>
                <th className="px-4 py-3 font-medium">{t("locale")}</th>
              </tr>
            </thead>
            <tbody className="divide-border divide-y">
              {list.rows.map((q) => (
                <tr key={q.id}>
                  <td className="max-w-md px-4 py-3">
                    <Link
                      href={`/admin/preguntas/${q.id}`}
                      className="line-clamp-2 font-medium hover:underline"
                    >
                      {q.stem}
                    </Link>
                    <span className="text-muted-foreground text-xs">
                      {t("version", { version: q.version })} ·{" "}
                      {format.relativeTime(new Date(q.updated_at))}
                    </span>
                  </td>
                  <td className="px-4 py-3">{q.category}</td>
                  <td className="px-4 py-3">{q.difficulty}</td>
                  <td className="space-x-1 px-4 py-3 whitespace-nowrap">
                    <Badge
                      tone={
                        q.status === "published"
                          ? "success"
                          : q.status === "needs_review"
                            ? "warning"
                            : "neutral"
                      }
                    >
                      {t(`statuses.${q.status}`)}
                    </Badge>
                    {q.ai_generated && <Badge>{t("ai")}</Badge>}
                    {q.is_free && <Badge tone="accent">{t("free")}</Badge>}
                  </td>
                  <td className="px-4 py-3 uppercase">{q.locale}</td>
                </tr>
              ))}
            </tbody>
          </table>
        </Card>
      )}
      {pages > 1 && (
        <div className="flex items-center justify-between text-sm">
          {page > 1 ? <Link href={qs(page - 1)}>{t("prev")}</Link> : <span />}
          <span>{t("page", { page, pages })}</span>
          {page < pages ? <Link href={qs(page + 1)}>{t("next")}</Link> : <span />}
        </div>
      )}
    </div>
  );
}
