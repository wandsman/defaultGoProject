# Variables
SRC := $(wildcard cmd/app/*.go)
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
all: clear build test run

.PHONY: run
## run: запуск проекта
run:
	@echo "Running application..."
	@./$(BUILD_DIR)/$(GOOS)/$(APP)

.PHONY: cross_compile
## cross_compile: кросс-сборка проекта
cross_compile: clear
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
.PHONY: clear
## clear: очистка проета
clear:
	@echo "Cleaning up..."
	go clean
	rm -rf $(BUILD_DIR)
.PHONY: test
## test: запуск тестов
test:
	@echo "Running tests..."
	go test -bench . -v  -cover -coverprofile=$(BUILD_DIR)/coverage.out   ./...
	go tool cover -html $(BUILD_DIR)/coverage.out -o $(BUILD_DIR)/index.html

.PHONY:	help
## help: вызов помощи
help:
	@echo "Usage: \n"
	@sed -n 's/^##//p' ${MAKEFILE_LIST} | column -t -s ':' | sed -e 's/^/ /'
