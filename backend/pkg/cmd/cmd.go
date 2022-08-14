package cmd

func Excute() error {
	serverApp, err := newServerApp()
	if err != nil {
		return err
	}
	return serverApp.run()
}
