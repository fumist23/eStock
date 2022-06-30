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
	"github.com/spf13/cobra"
	"golang.org/x/sync/errgroup"
)

type serverApp struct {
	*cobra.Command
	port int
}

func newServerApp() *serverApp {
	const (
		fport = "port"
	)
	cmd := &cobra.Command{
		Use:   "serverApp",
		Short: "run server app",
	}
	app := &serverApp{Command: cmd}
	cmd.Flags().IntVar(&app.port, fport, 8080, "port to listen")

	app.RunE = func(cmd *cobra.Command, args []string) error {
		return app.run()
	}
	return app
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
		log.Println("Received signal.")
		const delay = 20 * time.Second
		log.Printf("Pre shhutdown.")
		time.Sleep(delay)
	}
	log.Println("Server is stopping...")
	os.Exit(1)

	return group.Wait()
}
