FROM golang:latest
LABEL authors="wandsman"
# Устанавливаем рабочую директорию внутри контейнера
WORKDIR /app
# Копируем файлы приложения в рабочую директорию
COPY ./build_*/linux/app_linux_amd64 .
# Запускаем приложение при старте контейнера
CMD ["./app_linux_amd64" ]



