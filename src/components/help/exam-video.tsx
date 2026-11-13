import { getTranslations } from "next-intl/server";
import { HelpVideo } from "@/components/help/help-video";
import { getExamVideo } from "@/lib/help/videos";

/** Vídeo de la oposición en su ficha: lo propio de su examen (ADR-055). */
export async function ExamVideo({
  slug,
  examName,
  locale,
}: {
  slug: string;
  examName: string;
  locale: string;
}) {
  const v = getExamVideo(slug);
  if (!v) return null;
  const t = await getTranslations("help");
  return (
    <section
      aria-labelledby="exam-video-title"
      className="border-border mt-8 grid items-center gap-6 rounded-2xl border p-5 sm:grid-cols-[200px_1fr] sm:p-6"
      data-testid="exam-video"
    >
      <HelpVideo
        className="mx-auto w-44 sm:w-full"
        src={v.src}
        poster={v.poster}
        title={t("examVideoCaption", { exam: examName })}
        transcript={v.transcript}
        transcriptLabel={t("transcript")}
        playLabel={t("play")}
        note={locale === "ca" ? t("spanishNote") : undefined}
      />
      <div className="order-first sm:order-none">
        <h2 id="exam-video-title" className="text-xl font-bold sm:text-2xl">
          {t("examVideoTitle")}
        </h2>
        <p className="text-muted-foreground mt-2">{t("examVideoBody", { exam: examName })}</p>
      </div>
    </section>
  );
}
