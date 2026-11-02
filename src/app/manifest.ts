import type { MetadataRoute } from "next";

export default function manifest(): MetadataRoute.Manifest {
  return {
    name: "Aprobia · Academia digital de oposiciones",
    short_name: "Aprobia",
    start_url: "/app",
    display: "standalone",
    background_color: "#ffffff",
    theme_color: "#0b2545",
    lang: "es",
    icons: [{ src: "/icon.svg", sizes: "any", type: "image/svg+xml", purpose: "any" }],
  };
}
