package main

import (
	"os"

	"github.com/fumist23/eStock/pkg/cmd"
	"github.com/spf13/cobra"
)

func main() {
	c := &cobra.Command{}
	cmd.RegisterCommand(c)
	if err := c.Execute(); err != nil {
		os.Exit(1)
	}
}
