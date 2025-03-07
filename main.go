package main

import (
	"log"
	"raspberry-pi-sensors/values"
)

func main() {
	log.Fatal(values.Run())
}
