FROM docker:20.10.8-git
RUN apk add --no-cache make=4.3-r0 && \
    rm -rf /var/cache/apk/*
ARG KUBECTL_VERSION=1.17.17

RUN apk add --no-cache curl=7.78.0-r0 \
    bash=5.1.0-r0 \
    jq=1.6-r1 && \
    rm -rf /var/cache/apk/*

#kubectl
RUN curl -LO https://storage.googleapis.com/kubernetes-release/release/v"$KUBECTL_VERSION"/bin/linux/amd64/kubectl && \
    chmod +x ./kubectl && \
    mv ./kubectl /usr/local/bin/kubectl