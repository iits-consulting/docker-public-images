FROM iits/jdk:jdk-11-alpine AS Jdk11
RUN apk add --no-cache docker='20.10.11-r0' && rm -f /var/cache/apk/*

FROM Jdk11
ARG IMAGE_USER=jdk-docker-user
RUN addgroup -S $IMAGE_USER && \
    adduser -G $IMAGE_USER --system --shell=/bin/false --disabled-password $IMAGE_USER && \
    mkdir -p /var/log/$IMAGE_USER && \
    chown -R $IMAGE_USER:$IMAGE_USER /var/log/$IMAGE_USER
USER $IMAGE_USER