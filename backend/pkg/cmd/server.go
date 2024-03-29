package cmd

import (
	"context"
	"net/http"
	"os"
	"os/signal"
	"syscall"
	"time"

	"github.com/fumist23/eStock/pkg/user"
	"github.com/go-chi/chi/v5"
	"go.uber.org/zap"

	"golang.org/x/sync/errgroup"
)

type serverApp struct {
	port      int
	projectID string
}

func newServerApp() *serverApp {
	config := newConfig()
	app := &serverApp{
		port:      config.Port,
		projectID: config.ProjectID,
	}
	return app
}

func (s *serverApp) run() error {
	ctx, cancel := context.WithCancel(context.Background())
	defer cancel()

	r := chi.NewRouter()
	srv, cleanup, err := initializeServer(ctx, s, r)
	if err != nil {
		return err
	}
	defer cleanup()

	r.Use(newLogger(srv.logger))

	r.Get("/echo", func(w http.ResponseWriter, r *http.Request) {
		w.Write([]byte("echo"))
	})
	r.Route("/users", user.NewRouter())

	group, egctx := errgroup.WithContext(ctx)
	group.Go(func() error {
		err := srv.ListenAndServe()
		if err == http.ErrServerClosed {
			return nil
		}
		srv.logger.Error("failed to listen and serve.", zap.Error(err))
		return err
	})
	srv.logger.Info("Server is started...")

	group.Go(func() error {
		cleanup, err := initDB(egctx)
		if cleanup != nil {
			defer cleanup()
		}
		if err != nil {
			srv.logger.Error("failed to init db.", zap.Error(err))
			return err
		}
		return nil
	})
	srv.logger.Info("Database is initialized...")

	signalCh := make(chan os.Signal, 1)
	signal.Notify(signalCh, syscall.SIGTERM, syscall.SIGINT)

	select {
	case <-egctx.Done():
		srv.logger.Error("Context is done.")
	case <-signalCh:
		sig := <-signalCh
		srv.logger.Info("Received signal.", zap.String("signal", sig.String()))
		const delay = 5 * time.Second
		srv.logger.Info("Pre shutdown.", zap.Duration("delay", delay))
		time.Sleep(delay)
	}

	srv.logger.Info("Server is stopping...")
	srv.Shutdown(ctx)
	return group.Wait()
}
