FROM golang:1.22 AS builder
WORKDIR /app
COPY . .

RUN  make build

FROM alpine:3
LABEL authors="wandsman"
WORKDIR /app

COPY --from=builder /app/build_*/linux/ .

ENTRYPOINT ["./app_linux_arm64"]
CMD [""]