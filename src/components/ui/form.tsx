import * as React from "react";
import * as LabelPrimitive from "@radix-ui/react-label";
import { cn } from "@/lib/utils";

export function Input({ className, ...props }: React.InputHTMLAttributes<HTMLInputElement>) {
  return (
    <input
      className={cn(
        "border-input bg-background text-foreground placeholder:text-muted-foreground/70 focus-visible:outline-ring aria-[invalid=true]:border-danger flex h-11 w-full rounded-lg border px-3 text-base focus-visible:outline-2 disabled:opacity-50 sm:text-sm",
        className,
      )}
      {...props}
    />
  );
}

export function Label({ className, ...props }: React.ComponentProps<typeof LabelPrimitive.Root>) {
  return (
    <LabelPrimitive.Root className={cn("text-sm leading-none font-medium", className)} {...props} />
  );
}

export function FieldError({ id, children }: { id: string; children?: React.ReactNode }) {
  if (!children) return null;
  return (
    <p id={id} role="alert" className="text-danger text-sm">
      {children}
    </p>
  );
}

export function Alert({
  tone = "info",
  children,
  className,
}: {
  tone?: "info" | "error" | "success";
  children: React.ReactNode;
  className?: string;
}) {
  const tones = {
    info: "bg-surface border-border",
    error: "bg-danger-soft border-danger/40 text-danger",
    success: "bg-accent-soft border-accent/40",
  } as const;
  return (
    <div
      role={tone === "error" ? "alert" : "status"}
      className={cn("rounded-lg border px-4 py-3 text-sm", tones[tone], className)}
    >
      {children}
    </div>
  );
}
