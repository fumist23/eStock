.PHONY: lint build

lint:
	goimports -l ./ 2>&1 | tee /dev/stderr | (! read)

build:
	go build -mod=readonly -v -o server ./cmd/server/main.go