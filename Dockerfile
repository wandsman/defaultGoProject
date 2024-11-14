FROM golang:1.22 AS builder
WORKDIR /app
COPY . .

RUN  make build

RUN ls

FROM alpine:3
LABEL authors="wandsman"
WORKDIR /app

COPY --from=builder /app/build_*/linux/ .

RUN ls

ENTRYPOINT ["./app_linux_arm64"]
CMD [""]