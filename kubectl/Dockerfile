ARG IMAGE_USER=vault-kubectl-user
ARG KUBECTL_VERSION=1.17.17

FROM docker:20.10.8-git AS base
ARG IMAGE_USER
RUN addgroup -S $IMAGE_USER && \
    adduser -G $IMAGE_USER --system --shell=/bin/false --disabled-password $IMAGE_USER && \
    apk add --no-cache make=4.3-r0 && \
    rm -rf /var/cache/apk/*
USER $IMAGE_USER

FROM base AS packages
ARG IMAGE_USER
USER root
RUN apk add --no-cache curl=7.79.1-r1 \
    bash=5.1.16-r0 \
    jq=1.6-r1 && \
    rm -rf /var/cache/apk/*
USER $IMAGE_USER

FROM packages
ARG IMAGE_USER
ARG KUBECTL_VERSION
USER root
RUN curl -LO https://storage.googleapis.com/kubernetes-release/release/v"$KUBECTL_VERSION"/bin/linux/amd64/kubectl && \
    chmod +x ./kubectl && \
    mv ./kubectl /usr/local/bin/kubectl
USER $IMAGE_USER
