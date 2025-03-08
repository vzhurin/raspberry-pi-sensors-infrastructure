package main

import (
	"log"
	"raspberry-pi-sensors/internal/values"
)

func main() {
	log.Fatal(values.Run())
}
