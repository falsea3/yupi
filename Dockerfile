FROM golang:1.23.1-alpine AS build

WORKDIR /app

COPY go.mod go.sum internal ./

# Загружаем зависимости
RUN go mod download

COPY . .

RUN go build -o main ./cmd/kinopoisk-api/main.go

# Этап с финальным образом
FROM alpine:latest

WORKDIR /root/

# Копируем исполняемый файл из предыдущего этапа
COPY --from=build /app/main .

# Открываем порт
EXPOSE 8080

# Запускаем приложение
CMD ["./main"]
