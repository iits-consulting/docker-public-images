FROM adoptopenjdk/openjdk11:jdk-11.0.12_7-alpine-slim AS Base
RUN apk update && apk add --no-cache \
    git=2.32.0-r0 \
    less=581-r1 \
    tzdata=2021a-r0 \
    fontconfig=2.13.1-r4 \
    freetype=2.10.4-r1 \
    ttf-dejavu=2.37-r1 \
    gcc=10.3.1_git20210424-r2 \
    openssh=8.6_p1-r2 \
    openssl=1.1.1l-r0 && \
    rm -rf /var/cache/apk/*
ENV TZ Europe/Berlin
VOLUME /tmp

FROM Base AS Docker
RUN apk add --no-cache docker='20.10.7-r1' && rm -f /var/cache/apk/*

FROM Docker
ARG IMAGE_USER=jdk-docker-user
RUN addgroup -S $IMAGE_USER -g 1000 && \
    adduser -G $IMAGE_USER -u 1000 --system --shell=/bin/false --disabled-password $IMAGE_USER
USER $IMAGE_USER