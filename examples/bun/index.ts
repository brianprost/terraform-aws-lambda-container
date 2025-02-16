import { Logger } from "@aws-lambda-powertools/logger";
import Bun from "bun";

const logger = new Logger({ serviceName: "bun-greeter" });

Bun.serve({
    async fetch(req) {
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
    },
});

process.on("SIGINT", () => {
    console.log("Received SIGINT");
    process.exit();
});

process.on("SIGTERM", () => {
    console.log("Received SIGTERM");
    process.exit();
});
