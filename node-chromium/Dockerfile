FROM node:14.17.6-alpine3.14 AS Base
WORKDIR /tmp
# hadolint ignore=DL3018
RUN apk add ca-certificates --no-cache && \
    apk add --no-cache chromium=91.0.4472.164-r0 && rm -rf /var/cache/apk/*

FROM Base
ARG IMAGE_USER=node-user
RUN addgroup -S $IMAGE_USER -g 1000 && \
    adduser -G $IMAGE_USER -u 1000 --system --shell=/bin/false --disabled-password $IMAGE_USER
USER $IMAGE_USER
