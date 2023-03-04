package cmd

import (
	"net/http"
	"time"

	"go.uber.org/zap"
)

func newLogger(logger *zap.Logger) func(http.Handler) http.Handler {
	return func(next http.Handler) http.Handler {
		fn := func(w http.ResponseWriter, r *http.Request) {
			start := time.Now()
			defer func() {
				latency := time.Since(start).Milliseconds()
				logger.Info("access log",
					zap.String("method", r.Method),
					zap.String("path", r.URL.Path),
					zap.String("status", w.Header().Get("Status")),
					zap.Int64("latency", latency),
					zap.String("ip", r.RemoteAddr),
					zap.String("user_agent", r.UserAgent()),
				)
			}()
			next.ServeHTTP(w, r)
		}
		return http.HandlerFunc(fn)
	}
}
