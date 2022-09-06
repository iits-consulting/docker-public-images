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
    "bash=~5.1" \
    "curl=~7.83" \
    "git=~2.36" \
    "less=~590" \
    "openssh=~9.0" \
    "yq=~4.25" \
    "jq=~1.6" && \
    rm -rf /var/cache/apk/*
ENV TZ Europe/Berlin
VOLUME /git
WORKDIR /git
USER $IMAGE_USER
