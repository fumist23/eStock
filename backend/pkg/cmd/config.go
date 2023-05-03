package cmd

import (
	"log"

	"github.com/kelseyhightower/envconfig"
)

type Config struct {
	Port      int    `envconfig:"PORT" required:"true"`
	ProjectID string `envconfig:"PROJECT_ID" required:"true"`
}

func newConfig() Config {
	var config Config
	envconfig.Process("", &config)
	log.Print(config)
	return config
}
