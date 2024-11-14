package config

import (
	"log/slog"
	"reflect"
)

//go:generate easytags $GOFILE json

type Config struct {
	AppVersion string `json:"app_version" default:"0.0.0"`
	App        string `json:"app" default:"defaultGoProject"`
}

func NewConfig(appVersion string) Config {
	var cfg Config

	for i := 0; i < reflect.TypeOf(cfg).NumField(); i++ {
		field := reflect.TypeOf(cfg).Field(i)
		if value, ok := field.Tag.Lookup("default"); ok {
			switch field.Type.Kind() {
			case reflect.String:
				if field.Name == "" {
					field.Name = value
				}
			default:

			}
		}
	}
	return cfg
}

func (receiver Config) Info() {
	slog.Info("Receiver view: ", "App", receiver.App, "AppVersion", receiver.AppVersion)
}
