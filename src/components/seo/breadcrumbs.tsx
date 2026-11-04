import { ChevronRight } from "lucide-react";
import { Link } from "@/i18n/navigation";
import { JsonLd, breadcrumbLd } from "@/lib/seo/json-ld";

/** Migas de pan visibles + BreadcrumbList (Schema.org). El último elemento es la página actual. */
export function Breadcrumbs({
  items,
  locale,
  label,
}: {
  items: { name: string; path: string }[];
  locale: string;
  label: string;
}) {
  return (
    <>
      <JsonLd data={breadcrumbLd(items, locale)} />
      <nav aria-label={label} className="text-muted-foreground text-sm">
        <ol className="flex flex-wrap items-center gap-1">
          {items.map((it, i) => (
            <li key={it.path} className="flex items-center gap-1">
              {i > 0 && <ChevronRight className="size-3.5" aria-hidden />}
              {i === items.length - 1 ? (
                <span aria-current="page" className="text-foreground">
                  {it.name}
                </span>
              ) : (
                <Link href={it.path} className="hover:underline">
                  {it.name}
                </Link>
              )}
            </li>
          ))}
        </ol>
      </nav>
    </>
  );
}
