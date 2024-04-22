# Variables
SRC := $(wildcard cmd/app/*.go)
FLAGS = "-ldflags= -w -s"
PARAMS := GOOS=linux GOARCH=amd64 CGO_ENABLED=0
APP := app
COMMIT_SHA := latest



# Targets
all: clear build test run

.PHONY: run
## run: запуск проета
run:
	./bin/app
.PHONY: build
## build: сборка проета
build:
	${PARAMS} go build -o bin/${APP}  "${SRC}"

.PHONY: clear
## clear: очистка проета
clear:
	go clean
	rm -rf bin/*

.PHONY: test
## test: запуск тестов
test:
	go test -bench . -v  -cover -coverprofile=bin/coverage.out   ./...
	go tool cover -html bin/coverage.out -o bin/index.html

.PHONY:	help
## help: вызов помощи
help:
	@echo "Usage: \n"
	@sed -n 's/^##//p' ${MAKEFILE_LIST} | column -t -s ':' | sed -e 's/^/ /'