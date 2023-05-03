package cmd

import (
	"fmt"

	"github.com/kelseyhightower/envconfig"
)

type Config struct {
	Port      int    `envconfig:"PORT" required:"true"`
	ProjectID string `envconfig:"PROJECT_ID" required:"true"`
}

func newConfig() Config {
	var config Config
	envconfig.Process("", &config)
	fmt.Printf("config: %+v", config)
	return config
}
