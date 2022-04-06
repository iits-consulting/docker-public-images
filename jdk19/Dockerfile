FROM openjdk:19-jdk-alpine3.15
RUN apk update && apk add --no-cache \
    tzdata=2022a-r0 \
    fontconfig=2.13.1-r4 \
    freetype=2.11.1-r0 \
    ttf-dejavu=2.37-r1 \
    gcc=10.3.1_git20211027-r0 \
    openssl=1.1.1n-r0 && \
    rm -rf /var/cache/apk/*;
ENV TZ Europe/Berlin
VOLUME /tmp
WORKDIR /tmp
USER guest
