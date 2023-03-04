package main

import (
	"os"

	"github.com/fumist23/eStock/pkg/cmd"
	"github.com/spf13/cobra"
)

func main() {
	c := &cobra.Command{}
	cmd.RegisterCommand(c)
	err := c.Execute()
	if err != nil {
		os.Exit(1)
	}
}
