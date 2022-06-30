ARG IMAGE_USER=jdk-user
FROM eclipse-temurin:17.0.3_7-jdk-alpine AS base
ARG IMAGE_USER
RUN addgroup -S $IMAGE_USER && \
    adduser -G $IMAGE_USER --system --shell=/bin/false --disabled-password $IMAGE_USER && \
    mkdir -p /builds && chown -R $IMAGE_USER:$IMAGE_USER /builds
USER $IMAGE_USER

FROM base as packages
ARG IMAGE_USER
USER root
RUN apk update && apk add --no-cache \
    "tzdata=~2022a" \
    "fontconfig=~2.14" \
    "ttf-dejavu=~2.37" \
    "openssl=~1.1" && \
    rm -rf /var/cache/apk/*
ENV TZ Europe/Berlin
VOLUME /tmp
USER $IMAGE_USER

FROM packages
ARG IMAGE_USER
USER root
RUN apk add --no-cache "docker=~20.10" && rm -f /var/cache/apk/*
USER $IMAGE_USER