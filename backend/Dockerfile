FROM golang:1.20.0-buster as builder

WORKDIR /app

COPY . .
RUN go mod download

ADD https://github.com/benbjohnson/litestream/releases/download/v0.3.8/litestream-v0.3.8-linux-amd64-static.tar.gz /tmp/litestream.tar.gz
RUN tar -C /usr/local/bin -xzf /tmp/litestream.tar.gz

COPY . ./

RUN CGO_ENABLED=1 go build -mod=readonly -v -o server ./cmd/server/main.go

FROM debian:buster-slim
RUN set -x && apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y \
    ca-certificates && \
    rm -rf /var/lib/apt/lists/*

COPY --from=builder /app/server /app/server
COPY --from=builder /usr/local/bin/litestream /usr/local/bin/litestream
COPY --from=builder /app/litestream.yaml /app/litestream.yaml
COPY --from=builder /app/db/estock.db /app/db/estock.db
COPY --from=builder /app/run.sh /app/run.sh

CMD ["sh", "/app/run.sh"]
