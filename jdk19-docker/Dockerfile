ARG IMAGE_USER=jdk-user
FROM openjdk:19-jdk-alpine3.15 AS base
ARG IMAGE_USER
RUN addgroup -S $IMAGE_USER && \
    adduser -G $IMAGE_USER --system --shell=/bin/false --disabled-password $IMAGE_USER
USER $IMAGE_USER

FROM base AS packages
ARG IMAGE_USER
USER root
RUN apk update && apk add --no-cache \
    tzdata=2022a-r0 \
    fontconfig=2.13.1-r4 \
    freetype=2.11.1-r0 \
    ttf-dejavu=2.37-r1 \
    gcc=10.3.1_git20211027-r0 \
    openssl=1.1.1n-r0 && \
    rm -rf /var/cache/apk/*;
ENV TZ Europe/Berlin
VOLUME /tmp
USER $IMAGE_USER

FROM packages
ARG IMAGE_USER
USER root
RUN apk add --no-cache docker='20.10.14-r0' && rm -f /var/cache/apk/*
USER $IMAGE_USER
