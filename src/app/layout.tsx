import type { ReactNode } from "react";

// El layout raíz real vive en app/[locale]/layout.tsx (next-intl).
export default function RootLayout({ children }: { children: ReactNode }) {
  return children;
}
