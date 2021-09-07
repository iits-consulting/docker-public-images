FROM node:14.17.6-alpine3.14 AS Node
WORKDIR /tmp
# hadolint ignore=DL3018
RUN apk add ca-certificates --no-cache && \
    apk add --no-cache chromium=92.0.4515.159-r0 && rm -rf /var/cache/apk/*

FROM Node
ARG IMAGE_USER=node-user
RUN addgroup -S $IMAGE_USER && \
    adduser -G $IMAGE_USER --system --shell=/bin/false --disabled-password $IMAGE_USER && \
    mkdir -p /var/log/$IMAGE_USER && \
    chown -R $IMAGE_USER:$IMAGE_USER /var/log/$IMAGE_USER
USER $IMAGE_USER
