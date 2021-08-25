FROM node:14.5.0-alpine3.12 AS Node
WORKDIR /tmp
# hadolint ignore=DL3018
RUN apk add ca-certificates --no-cache && \
    apk add --no-cache chromium=86.0.4240.111-r0 && rm -rf /var/cache/apk/*

FROM Node
ARG IMAGE_USER=node-user
RUN addgroup -S $IMAGE_USER && \
    adduser -G $IMAGE_USER --system --shell=/bin/false --disabled-password $IMAGE_USER && \
    mkdir -p /var/log/$IMAGE_USER && \
    chown -R $IMAGE_USER:$IMAGE_USER /var/log/$IMAGE_USER
USER $IMAGE_USER
