package cmd

import (
	"context"
	"database/sql"
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

	_ "github.com/mattn/go-sqlite3"
	"golang.org/x/sync/errgroup"
)

type serverApp struct {
	*cobra.Command
	port      int
	projectID string
}

func newServerApp() *serverApp {
	const (
		fport      = "port"
		fprojectID = "project_id"
	)
	cmd := &cobra.Command{
		Use:   "serverApp",
		Short: "serverApp is a server application.",
	}
	app := &serverApp{
		Command: cmd,
	}
	cmd.Flags().IntVar(&app.port, fport, 8080, "port number")
	cmd.Flags().StringVar(&app.projectID, fprojectID, "estock", "project id")

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

	port := fmt.Sprintf(":%d", s.port)
	srv := &http.Server{
		Addr:    port,
		Handler: r,
	}
	group.Go(func() error {
		err := srv.ListenAndServe()
		if err == http.ErrServerClosed {
			return nil
		}
		return err
	})
	log.Println("Server is started...")

	group.Go(func() error {
		err := initDB(egctx)
		if err != nil {
			return err
		}
		return nil
	})

	signalCh := make(chan os.Signal, 1)
	signal.Notify(signalCh, syscall.SIGTERM, syscall.SIGINT)

	select {
	case <-egctx.Done():
		log.Println("Context is done.")
	case <-signalCh:
		sig := <-signalCh
		log.Printf("Received signal. signalCh: %s", sig)
		const delay = 5 * time.Second
		log.Printf("Pre shutdown.")
		time.Sleep(delay)
	}
	log.Println("Server is stopping...")
	srv.Shutdown(ctx)
	return group.Wait()
}

func initDB(ctx context.Context) error {
	db, err := sql.Open("sqlite3", "./db/estock.db")
	if err != nil {
		log.Fatal(err)
	}
	defer db.Close()

	if err := db.PingContext(ctx); err != nil {
		log.Fatal(err)
	}

	return nil
}
