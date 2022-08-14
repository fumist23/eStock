package main

import (
	"os"

	"github.com/fumist23/eStock/pkg/cmd"
)

func main() {
	if err := cmd.Excute(); err != nil {
		os.Exit(1)
	}
}
