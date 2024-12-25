FROM golang:1.23-alpine AS builder

RUN go version

RUN go env -w GOPRIVATE=github.com/ereshzealous

COPY . /github.com/ferestgo/go-app/
WORKDIR /github.com/ferestgo/go-app/

RUN go mod tidy
# RUN export token=${token}
RUN GOOS=linux go build -o ./.bin/app ./app/main.go


FROM alpine:latest

WORKDIR /root/

COPY --from=0 /github.com/ferestgo/go-app/.bin/app .

EXPOSE 80

CMD ["./app"]