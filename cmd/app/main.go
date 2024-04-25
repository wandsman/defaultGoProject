package main

import (
	"defaultGoProject/pkg/probPack"
	"log"
)

var (
	Build   string
	Version string
)

func main() {

	log.Println("program start!")
	log.Printf("Build: %s Version: %s", Build, Version)
	log.Print(probPack.Add(5, 5))
}
