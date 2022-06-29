package cmd

import "github.com/spf13/cobra"

func RegisterCommand(registry *cobra.Command) {
	registry.AddCommand(
		newServerApp().Command,
	)
}
