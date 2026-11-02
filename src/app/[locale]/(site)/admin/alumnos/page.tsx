import type { Metadata } from "next";
import { getFormatter, getTranslations, setRequestLocale } from "next-intl/server";
import { Download } from "lucide-react";
import { Link } from "@/i18n/navigation";
import { Button } from "@/components/ui/button";
import { Badge, Card, EmptyState } from "@/components/ui/card";
import { listExamBodies } from "@/lib/catalog/queries";
import { PAGE_SIZE, listUsers, userFilterSchema } from "@/lib/admin/users";

export const metadata: Metadata = { title: "Alumnos", robots: { index: false } };

const selectCls = "border-input bg-background h-11 rounded-lg border px-3 text-sm";

export default async function AdminUsersPage({
  params,
  searchParams,
}: PageProps<"/[locale]/admin/alumnos">) {
  const { locale } = await params;
  setRequestLocale(locale);
  const t = await getTranslations("adminUsers");
  const tAdmin = await getTranslations("admin");
  const format = await getFormatter();
  const filter = userFilterSchema.parse(await searchParams);
  const [{ rows, total }, exams] = await Promise.all([listUsers(filter), listExamBodies({}, 500)]);
  const pages = Math.max(1, Math.ceil(total / PAGE_SIZE));

  const qs = (extra: Record<string, string | number | undefined>) => {
    const p = new URLSearchParams();
    for (const [k, v] of Object.entries({ ...filter, ...extra })) {
      if (v !== undefined && v !== "" && !(k === "page" && v === 1)) p.set(k, String(v));
    }
    const s = p.toString();
    return s ? `?${s}` : "";
  };
  const exportQs = qs({ page: undefined });

  return (
    <div className="mx-auto max-w-6xl space-y-6 px-4 py-8">
      <div className="flex flex-wrap items-end justify-between gap-4">
        <h1 className="text-3xl font-bold">{t("title")}</h1>
        <div className="text-right">
          <Button asChild variant="outline" size="sm">
            <a href={`/api/admin/users${exportQs}`} download>
              <Download aria-hidden /> {t("export")}
            </a>
          </Button>
          <p className="text-muted-foreground mt-1 text-xs">{t("exportNote")}</p>
        </div>
      </div>

      <form
        role="search"
        className="grid gap-2 sm:grid-cols-2 lg:grid-cols-[2fr_1fr_1fr_1fr_1fr_auto]"
      >
        <label htmlFor="q" className="sr-only">
          {t("search")}
        </label>
        <input
          id="q"
          name="q"
          type="search"
          defaultValue={filter.q}
          placeholder={t("search")}
          className="border-input bg-background h-11 rounded-lg border px-3"
        />
        <label htmlFor="status" className="sr-only">
          {t("allStatus")}
        </label>
        <select id="status" name="status" defaultValue={filter.status ?? ""} className={selectCls}>
          <option value="">{t("allStatus")}</option>
          {(["active", "suspended", "pending_deletion"] as const).map((s) => (
            <option key={s} value={s}>
              {t(`status.${s}`)}
            </option>
          ))}
        </select>
        <label htmlFor="role" className="sr-only">
          {t("allRoles")}
        </label>
        <select id="role" name="role" defaultValue={filter.role ?? ""} className={selectCls}>
          <option value="">{t("allRoles")}</option>
          {(["student", "editor", "admin", "owner"] as const).map((r) => (
            <option key={r} value={r}>
              {t(`role.${r}`)}
            </option>
          ))}
        </select>
        <label htmlFor="exam" className="sr-only">
          {t("allExams")}
        </label>
        <select id="exam" name="exam" defaultValue={filter.exam ?? ""} className={selectCls}>
          <option value="">{t("allExams")}</option>
          {exams.map((e) => (
            <option key={e.slug} value={e.slug}>
              {e.name}
            </option>
          ))}
        </select>
        <label htmlFor="onboarded" className="sr-only">
          {t("onboarding")}
        </label>
        <select
          id="onboarded"
          name="onboarded"
          defaultValue={filter.onboarded ?? ""}
          className={selectCls}
        >
          <option value="">
            {t("onboarding")}: {t("any")}
          </option>
          <option value="yes">{t("yes")}</option>
          <option value="no">{t("no")}</option>
        </select>
        <Button type="submit">{t("filter")}</Button>
      </form>

      <p className="text-muted-foreground text-sm" aria-live="polite">
        {t("results", { count: total })}
      </p>

      {rows.length === 0 ? (
        <EmptyState title={t("empty")} />
      ) : (
        <Card className="overflow-x-auto p-0">
          <table className="w-full min-w-[760px] text-left text-sm">
            <thead className="text-muted-foreground border-border border-b">
              <tr>
                <th scope="col" className="px-4 py-3 font-medium">
                  {t("email")}
                </th>
                <th scope="col" className="px-4 py-3 font-medium">
                  {t("exam")}
                </th>
                <th scope="col" className="px-4 py-3 font-medium">
                  {t("onboarding")}
                </th>
                <th scope="col" className="px-4 py-3 font-medium">
                  {tAdmin("columns.status")}
                </th>
                <th scope="col" className="px-4 py-3 font-medium">
                  {tAdmin("columns.createdAt")}
                </th>
                <th scope="col" className="px-4 py-3 font-medium">
                  {tAdmin("columns.lastActive")}
                </th>
              </tr>
            </thead>
            <tbody className="divide-border divide-y">
              {rows.map((u) => (
                <tr key={u.id}>
                  <td className="px-4 py-3">
                    <Link
                      href={`/admin/alumnos/${u.id}`}
                      className="text-accent font-medium hover:underline"
                    >
                      {u.email}
                    </Link>
                    <div className="text-muted-foreground text-xs">
                      {u.display_name ?? "—"} · {t(`role.${u.role}`)}
                    </div>
                  </td>
                  <td className="px-4 py-3">{u.primary_exam ?? "—"}</td>
                  <td className="px-4 py-3">
                    {u.onboarding_completed_at ? t("yesShort") : t("noShort")}
                  </td>
                  <td className="px-4 py-3">
                    <Badge tone={u.status === "active" ? "success" : "warning"}>
                      {t(`status.${u.status}`)}
                    </Badge>
                  </td>
                  <td className="px-4 py-3">
                    {format.dateTime(new Date(u.created_at), { dateStyle: "medium" })}
                  </td>
                  <td className="px-4 py-3">
                    {u.last_active_at ? format.relativeTime(new Date(u.last_active_at)) : "—"}
                  </td>
                </tr>
              ))}
            </tbody>
          </table>
        </Card>
      )}

      {pages > 1 && (
        <nav aria-label="Paginación" className="flex items-center justify-between gap-4 text-sm">
          {filter.page > 1 ? (
            <Link
              href={`/admin/alumnos${qs({ page: filter.page - 1 })}`}
              className="text-accent hover:underline"
            >
              ← {t("prev")}
            </Link>
          ) : (
            <span />
          )}
          <span>{t("page", { page: filter.page, pages })}</span>
          {filter.page < pages ? (
            <Link
              href={`/admin/alumnos${qs({ page: filter.page + 1 })}`}
              className="text-accent hover:underline"
            >
              {t("next")} →
            </Link>
          ) : (
            <span />
          )}
        </nav>
      )}
    </div>
  );
}
