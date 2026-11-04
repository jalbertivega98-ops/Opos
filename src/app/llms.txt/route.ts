import { listPublicExams } from "@/lib/seo/catalog";
import { buildLlmsTxt } from "@/lib/seo/llms";
import { isIndexable } from "@/lib/seo/site";

export const revalidate = 3600;

export async function GET() {
  const body = buildLlmsTxt(await listPublicExams());
  return new Response(body, {
    headers: {
      "content-type": "text/plain; charset=utf-8",
      ...(isIndexable() ? {} : { "x-robots-tag": "noindex, nofollow" }),
    },
  });
}
