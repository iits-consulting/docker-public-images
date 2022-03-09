FROM iits/jdk:jdk-11-alpine AS Jdk11
USER root
RUN apk add --no-cache docker='20.10.11-r0' && rm -f /var/cache/apk/*
ARG IMAGE_USER=jdk-user
USER $IMAGE_USER