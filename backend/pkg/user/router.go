package user

import (
	"encoding/json"
	"fmt"
	"net/http"

	"github.com/go-chi/chi/v5"
)

func NewRouter() func(r chi.Router) {
	router := func(r chi.Router) {
		r.Get("/{user_id}", func(w http.ResponseWriter, r *http.Request) {
			userID := chi.URLParam(r, "user_id")
			type User struct {
				ID   string `json:"id"`
				Name string `json:"name"`
			}
			user := &User{
				ID:   userID,
				Name: fmt.Sprintf("user-%s", userID),
			}
			data, err := json.Marshal(user)
			if err != nil {
				w.WriteHeader(http.StatusInternalServerError)
				return
			}
			w.Write(data)
		})
	}
	return router
}
