package cmd

import (
	"fmt"
	"log"
	"net/http"

	"go.uber.org/zap"
)

func SetupLogger() (*zap.Logger, func(), error) {
	logger, err := zap.NewProduction()
	if err != nil {
		return nil, nil, err
	}
	cleanup := func() {
		err := logger.Sync()
		if err != nil {
			log.Printf("failed to sync logger. err: %+v", err)
		}
	}
	return logger, cleanup, nil
}

func NewHTTPServer(app *serverApp, handler http.Handler) *http.Server {
	return &http.Server{
		Addr:    fmt.Sprintf(":%d", app.port),
		Handler: handler,
	}
}
