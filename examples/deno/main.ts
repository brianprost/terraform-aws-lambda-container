import { Logger } from "npm:@aws-lambda-powertools/logger";

const logger = new Logger({ serviceName: "dino-greeter" });

Deno.serve(async (req) => {
  logger.info(`Method: ${req.method}, URL: ${req.url}`);
  if (req.body) {
    const body = await req.json();
    logger.info(body);
  }
  return new Response(
    JSON.stringify({
      statusCode: 200,
      message: "🦕 Hello, from Jurrasic World!",
    }),
  );
});

Deno.addSignalListener("SIGINT", () => {
  logger.info("interrupted!");
  Deno.exit();
});

Deno.addSignalListener("SIGTERM", () => {
  logger.info("terminated!");
  Deno.exit();
});
