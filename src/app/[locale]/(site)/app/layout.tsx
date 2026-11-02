import type { ReactNode } from "react";
import { requireUser } from "@/lib/auth/session";

/** Zona del alumno: comprobación de sesión en servidor (además del proxy). */
export default async function AppLayout({
  children,
  params,
}: {
  children: ReactNode;
  params: Promise<{ locale: string }>;
}) {
  const { locale } = await params;
  await requireUser(locale);
  return <div className="mx-auto w-full max-w-6xl px-4 py-8 sm:py-10">{children}</div>;
}
