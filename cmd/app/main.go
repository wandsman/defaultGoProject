package main

import (
	"defaultGoProject/pkg/probPack"
	"log"
)

var (
	Build       string
	Version     string
	helloString = "\n                                                  _             _   _ " +
		"\n                                                 | |           | | | |" +
		"\n  _ __  _ __ ___   __ _ _ __ __ _ _ __ ___    ___| |_ __ _ _ __| |_| |" +
		"\n | '_ \\| '__/ _ \\ / _` | '__/ _` | '_ ` _ \\  / __| __/ _` | '__| __| |" +
		"\n | |_) | | | (_) | (_| | | | (_| | | | | | | \\__ \\ || (_| | |  | |_|_|" +
		"\n | .__/|_|  \\___/ \\__, |_|  \\__,_|_| |_| |_| |___/\\__\\__,_|_|   \\__(_)" +
		"\n | |               __/ |                                              " +
		"\n |_|              |___/                                               "
)

func init() {
	log.Println(helloString)
	log.Printf("Build: %s Version: %s", Build, Version)
}

func main() {
	log.Print(probPack.Add(5, 5))
}
