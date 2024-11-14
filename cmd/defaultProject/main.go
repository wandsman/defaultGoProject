package main

import (
	app2 "defaultGoProject/internal/app"
	"defaultGoProject/internal/config"
	"defaultGoProject/pkg/logger"
	"flag"
	"fmt"
	"log/slog"
	"os"
)

var (
	Build   string
	Version string
)

func main() {
	showVersion := flag.Bool("version", false, "Показать версию")
	flag.Parse()

	switch {
	case *showVersion:
		fmt.Println("VERSION")
		fmt.Printf("Build: %s Version: %s\n", Build, Version)
		os.Exit(0)
	default:

	}
	logger.InitLogger()
	app := app2.NewApp(Version)
	app.Version()

	cfg := config.NewConfig("")
	cfg.Info()
	slog.Info("hello world!")
}
