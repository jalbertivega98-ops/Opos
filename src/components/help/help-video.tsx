"use client";

import { useRef, useState } from "react";
import Image from "next/image";
import { Play } from "lucide-react";
import { cn } from "@/lib/utils";

/**
 * Vídeo corto vertical (ADR-055). Hasta que se pulsa solo se carga la portada:
 * el .mp4 no se descarga en páginas que lo muestran pero nadie mira. Debajo, la
 * transcripción completa en un desplegable.
 */
export function HelpVideo({
  src,
  poster,
  title,
  transcript,
  transcriptLabel,
  playLabel,
  note,
  className,
  priority = false,
}: {
  src: string;
  poster: string;
  title: string;
  transcript: string;
  transcriptLabel: string;
  playLabel: string;
  /** Aviso corto bajo el título (p. ej. «Vídeo en castellano» en catalán). */
  note?: string;
  className?: string;
  priority?: boolean;
}) {
  const [playing, setPlaying] = useState(false);
  const ref = useRef<HTMLVideoElement>(null);

  return (
    <figure className={cn("flex flex-col", className)} data-testid="help-video">
      <div className="bg-ink relative aspect-[9/16] w-full overflow-hidden rounded-2xl shadow-lg">
        {playing ? (
          <video
            ref={ref}
            src={src}
            poster={poster}
            controls
            autoPlay
            playsInline
            preload="auto"
            className="absolute inset-0 size-full object-cover"
            aria-label={title}
          />
        ) : (
          <button
            type="button"
            onClick={() => setPlaying(true)}
            className="group focus-visible:outline-ring absolute inset-0 focus-visible:outline-2 focus-visible:outline-offset-2"
            aria-label={`${playLabel}: ${title}`}
          >
            <Image
              src={poster}
              alt=""
              fill
              sizes="(min-width: 1024px) 220px, (min-width: 640px) 30vw, 45vw"
              className="object-cover transition-transform duration-300 group-hover:scale-[1.03] motion-reduce:transition-none"
              priority={priority}
            />
            <span className="absolute inset-0 bg-gradient-to-t from-black/45 via-transparent to-transparent" />
            <span className="bg-accent text-accent-foreground absolute bottom-3 left-3 flex size-12 items-center justify-center rounded-full shadow-lg transition-transform group-hover:scale-110 motion-reduce:transition-none">
              <Play className="ml-0.5 size-5 fill-current" aria-hidden />
            </span>
          </button>
        )}
      </div>
      <figcaption className="mt-3">
        <span className="block leading-snug font-semibold">{title}</span>
        {note && <span className="text-muted-foreground block text-xs">{note}</span>}
        <details className="group/t mt-1 text-sm">
          <summary className="text-accent inline-flex min-h-8 cursor-pointer items-center font-medium hover:underline">
            {transcriptLabel}
          </summary>
          <p className="text-muted-foreground mt-1 text-sm" lang="es">
            {transcript}
          </p>
        </details>
      </figcaption>
    </figure>
  );
}
