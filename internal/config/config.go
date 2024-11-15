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
	if appVersion == "" {
		v := reflect.ValueOf(&cfg).Elem()
		for i := 0; i < v.NumField(); i++ {
			field := v.Type().Field(i)
			if value, ok := field.Tag.Lookup("default"); ok {
				if v.Field(i).Kind() == reflect.String {
					v.Field(i).SetString(value)
				}
			}
		}
	} else {
		cfg.AppVersion = appVersion
	}
	return cfg
}

func (receiver *Config) Info() {
	slog.Info("Receiver view: ", "App", receiver.App, "AppVersion", receiver.AppVersion)
}
