package cmd

func Run() error {
	if err := newServerApp().run(); err != nil {
		return err
	}
	return nil
}
