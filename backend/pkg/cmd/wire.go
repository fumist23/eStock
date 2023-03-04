//go:build wireinject
// +build wireinject

package cmd

import (
	"context"
	"net/http"

	"github.com/google/wire"
	"go.uber.org/zap"
)

type server struct {
	*http.Server
	logger *zap.Logger
}

func initializeServer(ctx context.Context, app *serverApp, handler http.Handler) (*server, func(), error) {
	wire.Build(
		NewHTTPServer,
		SetupLogger,
		wire.Struct(new(server), "*"),
	)

	return &server{}, nil, nil
}
