FROM golang:1.20.0-buster as builder

WORKDIR /app

COPY . .
RUN go mod download

ADD https://github.com/benbjohnson/litestream/releases/download/v0.3.8/litestream-v0.3.8-linux-amd64-static.tar.gz /tmp/litestream.tar.gz
RUN tar -C /usr/local/bin -xzf /tmp/litestream.tar.gz

RUN CGO_ENABLED=1 go build -mod=readonly -v -o server ./cmd/server/main.go

FROM debian:buster-slim
RUN set -x && apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y \
    ca-certificates && \
    rm -rf /var/lib/apt/lists/*

COPY --from=builder /app/server /server
COPY --from=builder /usr/local/bin/litestream /usr/local/bin/litestream
COPY --from=builder /app/estock.db /estock.db
COPY --from=builder /app/litestream.yaml /litestream.yaml
COPY --from=builder /app/run.sh /run.sh

CMD ["sh", "/run.sh"]
