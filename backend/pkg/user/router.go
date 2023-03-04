package user

import (
	"net/http"

	"github.com/go-chi/chi/v5"
)

func NewRouter() func(r chi.Router) {
	router := func(r chi.Router) {
		r.Get("/", func(w http.ResponseWriter, r *http.Request) {
			w.Write([]byte("users"))
		})
	}
	return router
}
