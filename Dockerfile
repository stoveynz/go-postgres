FROM golang:alpine AS builder
RUN apk update && apk add git
WORKDIR /build
ENV GOSUMDB=off
ENV GOPROXY=direct


COPY go.mod ./
RUN go mod download

COPY *.go ./
RUN go get 
RUN go build -tags netgo -a -v -o go-postgress .

FROM alpine:latest
WORKDIR /opt/server
ARG ARCH

COPY --from=builder /build/go-postgress /usr/local/bin/ 
RUN chmod +x /usr/local/bin/go-postgress

EXPOSE 8000
CMD ["go-postgress"]