package app

import "log/slog"

type App struct {
	version string
}

func NewApp(version string) *App {
	return &App{version: version}
}

func (reseiver *App) Version() {
	slog.Info("Version", "version", reseiver.version)
}
