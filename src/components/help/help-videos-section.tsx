import { getTranslations } from "next-intl/server";
import { HelpVideo } from "@/components/help/help-video";
import { FAQ_VIDEOS } from "@/lib/help/videos";

/** «¿Tienes dudas?»: vídeos cortos con lo común de la academia (portada, ADR-055). */
export async function HelpVideosSection({ locale }: { locale: string }) {
  const t = await getTranslations("help");
  return (
    <div className="mt-14" data-testid="help-videos">
      <h3 className="text-2xl font-bold">{t("faqTitle")}</h3>
      <p className="text-muted-foreground mt-2 max-w-2xl">{t("faqSubtitle")}</p>
      <ul className="mt-6 grid grid-cols-2 gap-x-4 gap-y-8 sm:grid-cols-3 lg:grid-cols-6">
        {FAQ_VIDEOS.map((v) => (
          <li key={v.id}>
            <HelpVideo
              src={v.src}
              poster={v.poster}
              title={t(`faq.${v.id}`)}
              transcript={v.transcript}
              transcriptLabel={t("transcript")}
              playLabel={t("play")}
              note={locale === "ca" ? t("spanishNote") : undefined}
            />
          </li>
        ))}
      </ul>
    </div>
  );
}
