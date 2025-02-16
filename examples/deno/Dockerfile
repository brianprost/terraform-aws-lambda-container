FROM public.ecr.aws/awsguru/aws-lambda-adapter:0.9.0 AS aws-lambda-adapter
FROM denoland/deno:bin-2.1.10 AS deno_bin
FROM debian:bookworm-slim AS deno_runtime
COPY --from=aws-lambda-adapter /lambda-adapter /opt/extensions/lambda-adapter
COPY --from=deno_bin /deno /usr/local/bin/deno
ENV PORT=8000
EXPOSE 8000
RUN mkdir /var/deno_dir
ENV DENO_DIR=/var/deno_dir

# Copy the function code
WORKDIR "/var/task"
COPY main.ts /var/task/main.ts

# Warmup caches
RUN timeout 10s deno run -A main.ts || [ $? -eq 124 ] || exit 1

CMD ["deno", "run", "-A", "main.ts"]
