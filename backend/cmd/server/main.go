package main

import (
	"log"

	"github.com/fumist23/eStock/pkg/cmd"
)

func main() {
	if err := cmd.Excute(); err != nil {
		log.Fatal(err)
	}
}
