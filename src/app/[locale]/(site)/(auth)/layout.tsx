import type { Metadata } from "next";
import type { ReactNode } from "react";

/** Páginas de acceso: no se indexan, pero sus enlaces sí se siguen (ADR-025). */
export const metadata: Metadata = { robots: { index: false, follow: true } };

export default function AuthLayout({ children }: { children: ReactNode }) {
  return (
    <div className="mx-auto flex w-full max-w-md flex-col px-4 py-12 sm:py-16">
      <div className="border-border bg-background rounded-2xl border p-6 shadow-sm sm:p-8">
        {children}
      </div>
    </div>
  );
}
