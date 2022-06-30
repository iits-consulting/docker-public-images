ARG IMAGE_USER=jdk-user
FROM openjdk:17-jdk-alpine3.14 AS base
ARG IMAGE_USER
RUN addgroup -S $IMAGE_USER && \
    adduser -G $IMAGE_USER --system --shell=/bin/false --disabled-password $IMAGE_USER && \
    mkdir -p /builds && chown -R $IMAGE_USER:$IMAGE_USER /builds
USER $IMAGE_USER

FROM base
ARG IMAGE_USER
USER root
RUN apk update && apk add --no-cache \
    "tzdata=~2022a" \
    "fontconfig=~2.13" \
    "freetype=~2.10" \
    "ttf-dejavu=~2.37" \
    "gcc=~10.3" \
    "openssl=~1.1" && \
    rm -rf /var/cache/apk/*
ENV TZ Europe/Berlin
VOLUME /tmp
USER $IMAGE_USER
