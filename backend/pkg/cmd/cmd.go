package cmd

import "github.com/spf13/cobra"

func RegisterCommand(registry *cobra.Command) error {
	registry.AddCommand(
		newServerApp().Command,
	)
	return nil
}
