FROM adoptopenjdk/openjdk11:jdk-11.0.12_7-alpine-slim
RUN apk update && apk add --no-cache \
    tzdata=2021a-r0 \
    fontconfig=2.13.1-r4 \
    freetype=2.10.4-r1 \
    ttf-dejavu=2.37-r1 \
    gcc=10.3.1_git20210424-r2 \
    openssl=1.1.1k-r0 && \
    rm -rf /var/cache/apk/*
ENV TZ Europe/Berlin
VOLUME /tmp