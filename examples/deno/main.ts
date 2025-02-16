import { Logger } from "npm:@aws-lambda-powertools/logger";

const logger = new Logger({ serviceName: "dino-greeter" });

Deno.serve((req) => {
  const message = "🦕 Hello, from Jurrasic World!";
  logger.info(message);
  return (new Response(message));
});
