.PHONY: lint build build-and-deploy

lint:
	goimports -l ./ 2>&1 | tee /dev/stderr | (! read)

build:
	go build -mod=readonly -v -o server ./cmd/server/main.go

build-and-deploy: export KO_DOCKER_REPO=asia-northeast1-docker.pkg.dev/estock-353714/estock-backend
build-and-deploy:
	ko build --sbom=none --base-import-paths ./cmd/server