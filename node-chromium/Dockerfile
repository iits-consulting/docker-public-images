FROM node:14.5.0-alpine3.12
WORKDIR /tmp
# hadolint ignore=DL3018
RUN apk add ca-certificates --no-cache && \
    apk add --no-cache chromium=86.0.4240.111-r0 && rm -rf /var/cache/apk/*