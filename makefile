# Variables
APP := defaultProject
SRC := $(wildcard cmd/${APP}/*.go)
VERSION = $(shell git describe --tags --always)
BUILD = `git rev-parse --short HEAD`
FLAGS := -ldflags "-w -s -X main.Version=${VERSION} -X main.Build=${BUILD}"
GOOS = $(shell go env GOOS)
GOARCH = $(shell go env GOARCH)


# Variables for build
BUILD_DIR = build_$(BUILD)
APP = app_$(GOOS)_$(GOARCH)

# Variables for cross compile
PLATFORMS = linux darwin
ARCHITECTURES = amd64 arm64

# Targets
all: clean build run

.PHONY: run
## run: запуск проекта
run:
	@echo "Running application..."
	@./$(BUILD_DIR)/$(GOOS)/$(APP)


.PHONY: cross_compile
## cross_compile: кросс-сборка проекта
cross_compile: clean
	$(foreach os,$(PLATFORMS),\
		$(foreach arch,$(ARCHITECTURES),\
			$(MAKE) build GOOS=$(os) GOARCH=$(arch);\
		)\
	)


.PHONY: build
## build: сборка проекта
build:
	@echo "Building application for $(GOOS)/$(GOARCH)..."
	@mkdir -p $(BUILD_DIR)/$(GOOS)
	@GOOS=$(GOOS) GOARCH=$(GOARCH) go build $(FLAGS) -o $(BUILD_DIR)/$(GOOS)/$(APP) $(SRC)


.PHONY: clean
## clear: очистка проета
clean:
	@echo "Cleaning up..."
	go clean
	rm -rf $(BUILD_DIR)


.PHONY: test
## test: запуск тестов
test: clean build
	@echo "Running tests..."
	go test -v -cover -coverprofile=$(BUILD_DIR)/coverage.out ./...
	go test -bench=. -v -o $(BUILD_DIR)/tests.test -cpuprofile=$(BUILD_DIR)/cpu.out ./tests/*.go


.PHONY: profiling
## profiling: профилирование приложения
profiling:test
	go tool pprof -gif  $(BUILD_DIR)/*.test $(BUILD_DIR)/cpu.out > $(BUILD_DIR)/cpu.gif
	go tool cover -html $(BUILD_DIR)/coverage.out -o $(BUILD_DIR)/index.html

.PHONY: lint
## lint: запуск литнера
lint:
	golangci-lint run

.PHONY:	help
## help: вызов помощи
help:
	@echo "Usage: \n"
	@sed -n 's/^##//p' $(MAKEFILE_LIST) | column -t -s ':' | sed -e 's/^/ /'