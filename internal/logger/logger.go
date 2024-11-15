package logger

import (
	"log"
	"log/slog"
	"os"
)

func InitLogger() {
	var logger *slog.Logger
	file, err := os.OpenFile("app.log", os.O_CREATE|os.O_WRONLY|os.O_APPEND, 0666)
	if err != nil {
		log.Fatal("Failed to open log file:", err)
	}

	logger = slog.New(slog.NewJSONHandler(file, nil))
	slog.SetDefault(logger)
}
