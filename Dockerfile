FROM golang:1.23.1-alpine AS build

WORKDIR /app

# Копируем go.mod и go.sum
COPY go.mod go.sum ./

# Загружаем зависимости
RUN go mod download

# Копируем весь проект
COPY . .

# Собираем приложение
RUN go build -o main cmd/kinopoisk-api/main.go

# Этап с финальным образом
FROM alpine:latest

WORKDIR /root/

# Копируем исполняемый файл из предыдущего этапа
COPY --from=build /app/main .

# Открываем порт
EXPOSE 8080

# Запускаем приложение
CMD ["./main"]
