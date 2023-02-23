.PHONY: lint build build-and-deploy

lint:
	@golangci-lint run

build:
	go build -mod=readonly -v -o server ./cmd/server/main.go

build-and-deploy: export KO_DOCKER_REPO=asia-northeast1-docker.pkg.dev/estock-353714/estock-backend
build-and-deploy:
	ko build --sbom=none --base-import-paths ./cmd/server

install-go-tools:
	go install \
		github.com/golangci/golangci-lint/cmd/golangci-lint@v1.51.2
