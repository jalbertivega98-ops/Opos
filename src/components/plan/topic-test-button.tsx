import type { ReactNode } from "react";
import { Button, type ButtonProps } from "@/components/ui/button";
import { startTopicPracticeAction } from "@/lib/learning/questions/actions";

/** Botón que empieza un test de N preguntas de un tema (ADR-036). */
export function TopicTestButton({
  topic,
  count = 10,
  back = "/app/temario",
  children,
  className,
  formClassName,
  variant = "accent",
  size = "sm",
}: {
  topic: string;
  count?: number;
  back?: "/app" | "/app/plan" | "/app/temario";
  children: ReactNode;
  className?: string;
  formClassName?: string;
  variant?: ButtonProps["variant"];
  size?: ButtonProps["size"];
}) {
  const n = Math.min(40, Math.max(5, Math.round(count)));
  return (
    <form action={startTopicPracticeAction} className={formClassName}>
      <input type="hidden" name="topic" value={topic} />
      <input type="hidden" name="count" value={n} />
      <input type="hidden" name="back" value={back} />
      <Button
        type="submit"
        variant={variant}
        size={size}
        className={className}
        data-testid="topic-test"
      >
        {children}
      </Button>
    </form>
  );
}
