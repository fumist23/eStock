package cmd

import (
	"context"
	"fmt"
	"log"
	"net/http"
	"os"
	"os/signal"
	"syscall"
	"time"

	"github.com/go-chi/chi/v5"
	"github.com/go-chi/chi/v5/middleware"
	"github.com/kelseyhightower/envconfig"
	"golang.org/x/sync/errgroup"
)

type config struct {
	projectID string `required:"true"`
	port      int    `default:"8080"`
}

type serverApp struct {
	projectID string
	port      int
}

func newServerApp() (*serverApp, error) {
	var cfg config
	if err := envconfig.Process("", &cfg); err != nil {
		return nil, fmt.Errorf("new server app err: %w", err)
	}

	return &serverApp{
		projectID: cfg.projectID,
		port:      cfg.port,
	}, nil
}

func (s *serverApp) run() error {
	ctx, cancel := context.WithCancel(context.Background())
	defer cancel()

	r := chi.NewRouter()
	r.Use(middleware.Logger)

	r.Get("/echo", func(w http.ResponseWriter, r *http.Request) {
		w.Write([]byte("echo"))
	})

	group, egctx := errgroup.WithContext(ctx)
	group.Go(func() error {
		if err := http.ListenAndServe(fmt.Sprintf(":%d", s.port), r); err != nil {
			// TODO: log
			return fmt.Errorf("cmd: %w", err)
		}
		return nil
	})
	log.Println("Server is started...")

	signalCh := make(chan os.Signal, 1)
	signal.Notify(signalCh, syscall.SIGTERM, syscall.SIGINT)
	select {
	case <-egctx.Done():
		// TODO: log
	case <-signalCh:
		sig := <-signalCh
		log.Printf("Received signal. signalCh: %s", sig)
		const delay = 10 * time.Second
		log.Printf("Pre shutdown.")
		time.Sleep(delay)
	}
	log.Println("Server is stopping...")
	os.Exit(1)

	return group.Wait()
}
