ARG IMAGE_USER=git-jq

FROM alpine:3.16.0 as base
ARG IMAGE_USER
RUN addgroup -S $IMAGE_USER && \
    adduser -G $IMAGE_USER --system --shell=/bin/false --disabled-password $IMAGE_USER && \
    mkdir -p /builds && chown -R $IMAGE_USER:$IMAGE_USER /builds
USER $IMAGE_USER

FROM base
ARG IMAGE_USER
USER root
RUN apk update && apk add --no-cache \
    "curl=7.83.1-r2" \
    "git=2.36.2-r0" \
    "less=590-r0" \
    "openssh=9.0_p1-r1" \
    "jq=1.6-r1" && \
    rm -rf /var/cache/apk/*
ENV TZ Europe/Berlin
VOLUME /git
WORKDIR /git
USER $IMAGE_USER
