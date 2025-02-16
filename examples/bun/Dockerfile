FROM public.ecr.aws/awsguru/aws-lambda-adapter:0.9.0 AS aws-lambda-adapter
FROM oven/bun:distroless AS bun_distroless

FROM debian:bookworm-slim AS runtime
COPY --from=aws-lambda-adapter /lambda-adapter /opt/extensions/lambda-adapter
COPY --from=bun_distroless /usr/local/bin/bun /usr/local/bin/bun

ENV PORT=8080
EXPOSE 8080

WORKDIR "/var/task"

ADD package.json /var/task/package.json
ADD bun.lock /var/task/bun.lock

RUN bun install --omit=dev

COPY index.ts /var/task/index.ts

CMD [ "bun", "run", "index.ts" ]