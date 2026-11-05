import { getFormatter, getLocale, getTranslations } from "next-intl/server";
import { Brain, CalendarDays, ChevronLeft, ChevronRight, ListChecks, Timer } from "lucide-react";
import { Link } from "@/i18n/navigation";
import { Badge } from "@/components/ui/card";
import { IconBadge } from "@/components/ui/icon-badge";
import { localized } from "@/lib/catalog/queries";
import { pct } from "@/lib/learning/practice/format";
import { STUDY_TZ, type CalendarDay, type StudyEntry } from "@/lib/learning/calendar";
import { cn } from "@/lib/utils";

/**
 * Calendario semanal del panel (ADR-036): qué hizo el alumno cada día, a qué
 * hora y con qué resultado. En la semana actual, además, cuántas tareas del
 * plan quedan pendientes. Se puede ir a semanas anteriores con «?semana=-N».
 */
export async function StudyCalendar({
  days,
  offset,
  pending,
}: {
  days: CalendarDay[];
  offset: number;
  /** Tareas del plan aún sin terminar (solo en la semana actual). */
  pending: number | null;
}) {
  const t = await getTranslations();
  const format = await getFormatter();
  const locale = await getLocale();
  const all = days.flatMap((d) => d.entries);
  const answered = all.reduce((n, e) => n + e.answered, 0);
  const correct = all.reduce((n, e) => n + e.correct, 0);
  const activeDays = days.filter((d) => d.entries.length > 0).length;
  const range = format.dateTimeRange(days[0].date, days[6].date, {
    day: "numeric",
    month: "long",
    timeZone: STUDY_TZ,
  });
  const weekHref = (o: number) => (o === 0 ? "/app#calendario" : `/app?semana=${o}#calendario`);

  const what = (e: StudyEntry) => {
    if (e.kind === "mock") return localized(locale, e.title ?? "", e.titleCa);
    if (e.topicTitle) return localized(locale, e.topicTitle, e.topicTitleCa);
    if (e.mode === "psycho" && e.itemType && t.has(`psycho.types.${e.itemType}.name`))
      return t(`psycho.types.${e.itemType}.name`);
    return t.has(`practice.modes.${e.mode}`) ? t(`practice.modes.${e.mode}`) : e.mode;
  };
  const Icon = (e: StudyEntry) =>
    e.kind === "mock" ? Timer : e.mode === "psycho" ? Brain : ListChecks;

  return (
    <section
      id="calendario"
      aria-labelledby="calendar-title"
      className="border-border bg-background scroll-mt-28 rounded-3xl border p-6"
      data-testid="study-calendar"
    >
      <div className="flex flex-wrap items-center justify-between gap-3">
        <div className="flex items-center gap-3">
          <IconBadge icon={CalendarDays} />
          <div>
            <h2 id="calendar-title" className="text-lg font-bold">
              {t("calendar.title")}
            </h2>
            <p className="text-muted-foreground text-xs first-letter:uppercase">{range}</p>
          </div>
        </div>
        <nav aria-label={t("calendar.nav")} className="flex items-center gap-1">
          <Link
            href={weekHref(offset - 1)}
            className="hover:bg-surface inline-flex size-10 items-center justify-center rounded-lg"
            aria-label={t("calendar.prev")}
            data-testid="calendar-prev"
          >
            <ChevronLeft className="size-4" aria-hidden />
          </Link>
          {offset < 0 && (
            <Link
              href={weekHref(0)}
              className="hover:bg-surface inline-flex min-h-10 items-center rounded-lg px-3 text-sm font-semibold"
            >
              {t("calendar.thisWeek")}
            </Link>
          )}
          {offset < 0 && (
            <Link
              href={weekHref(offset + 1)}
              className="hover:bg-surface inline-flex size-10 items-center justify-center rounded-lg"
              aria-label={t("calendar.next")}
            >
              <ChevronRight className="size-4" aria-hidden />
            </Link>
          )}
        </nav>
      </div>

      <p className="text-muted-foreground mt-3 text-sm" data-testid="calendar-summary">
        {all.length === 0
          ? t(offset === 0 ? "calendar.emptyThisWeek" : "calendar.emptyWeek")
          : t("calendar.summary", {
              sessions: all.length,
              days: activeDays,
              answered,
              pct: answered ? pct(correct, answered) : 0,
            })}
        {pending !== null && (
          <>
            {" · "}
            <span className={cn(pending > 0 ? "text-foreground font-medium" : "text-success")}>
              {pending > 0 ? t("calendar.pending", { count: pending }) : t("calendar.allDone")}
            </span>
          </>
        )}
      </p>

      <ol className="mt-4 grid gap-2 md:grid-cols-7">
        {days.map((d) => (
          <li
            key={d.key}
            className={cn(
              "border-border rounded-xl border p-2.5",
              d.today && "border-accent bg-accent-soft/30",
              d.entries.length === 0 && "max-md:hidden",
              d.today && "max-md:block",
            )}
            data-testid="calendar-day"
          >
            <p className="flex items-baseline justify-between gap-1 text-xs">
              <span className="font-semibold first-letter:uppercase">
                {format.dateTime(d.date, { weekday: "short", timeZone: STUDY_TZ })}
              </span>
              <span className="text-muted-foreground tabular-nums">
                {format.dateTime(d.date, { day: "numeric", month: "short", timeZone: STUDY_TZ })}
              </span>
            </p>
            {d.entries.length === 0 ? (
              <p className="text-muted-foreground mt-2 text-xs">{t("calendar.nothing")}</p>
            ) : (
              <ul className="mt-2 grid gap-1.5">
                {d.entries.map((e) => {
                  const EntryIcon = Icon(e);
                  const active = e.status === "active";
                  return (
                    <li key={e.id}>
                      <Link
                        href={
                          e.kind === "mock" ? `/app/simulacros/${e.id}` : `/app/practica/${e.id}`
                        }
                        className="bg-surface hover:bg-surface-2 block rounded-lg px-2 py-1.5 text-xs"
                        data-testid="calendar-entry"
                      >
                        <span className="text-muted-foreground flex items-center gap-1 tabular-nums">
                          <EntryIcon className="size-3 shrink-0" aria-hidden />
                          {format.dateTime(new Date(e.startedAt), {
                            hour: "2-digit",
                            minute: "2-digit",
                            timeZone: STUDY_TZ,
                          })}
                        </span>
                        <span className="mt-0.5 line-clamp-2 font-medium">{what(e)}</span>
                        <span className="mt-1 flex flex-wrap gap-1">
                          {active ? (
                            <Badge tone="accent">{t("calendar.inProgress")}</Badge>
                          ) : e.kind === "mock" ? (
                            <Badge tone={e.passed ? "success" : "warning"}>
                              {format.number(e.mark ?? 0)} / {format.number(e.maxMark ?? 10)}
                            </Badge>
                          ) : (
                            <Badge
                              tone={
                                e.answered && pct(e.correct, e.answered) >= 70
                                  ? "success"
                                  : "warning"
                              }
                            >
                              {t("calendar.score", {
                                correct: e.correct,
                                answered: e.answered,
                              })}
                            </Badge>
                          )}
                        </span>
                      </Link>
                    </li>
                  );
                })}
              </ul>
            )}
          </li>
        ))}
      </ol>
    </section>
  );
}
