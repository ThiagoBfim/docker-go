############################
# STEP 1 build executable binary
############################
FROM golang:1.9.2-alpine3.7 AS builder

RUN apk add --no-cache git build-base && \
    echo "http://dl-cdn.alpinelinux.org/alpine/edge/main" >> /etc/apk/repositories && \
    echo "http://dl-cdn.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories && \
    echo "http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories && \
    apk add --no-cache upx=3.94-r0


WORKDIR /usr/src/app

COPY app/ .

RUN go get -d ./ && \
    CGO_ENABLED=0 GOOS=linux go build -o app -a -ldflags="-s -w" -installsuffix cgo && \
    upx --ultra-brute -qq app && \
    upx -t app

############################
# STEP 2 build a small image
############################
FROM scratch

#COPY --from=builder /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/ca-certificates.crt


#WORKDIR /bin/

COPY --from=builder /usr/src/app .

CMD [ "/app" ]

EXPOSE 8080
