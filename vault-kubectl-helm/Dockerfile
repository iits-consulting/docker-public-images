ARG IMAGE_USER=vault-kubectl-user
ARG VAULT_VERSION=1.3.3
ARG KUBECTL_VERSION=1.17.17
ARG HELM_VERSION=3.2.1
ARG HELM_DIFF_PLUGIN_VERSION=3.1.2

FROM docker:20.10.8-git AS base
ARG IMAGE_USER
RUN addgroup -S $IMAGE_USER && \
    adduser -G $IMAGE_USER --system --shell=/bin/false --disabled-password $IMAGE_USER && \
    apk add --no-cache "make=~4.3" && \
    rm -rf /var/cache/apk/*
USER $IMAGE_USER

FROM base AS packages
ARG IMAGE_USER
USER root
RUN apk add --no-cache \
    "curl=~7.79" \
    "bash=~5.1" \
    "jq=~1.6" && \
    rm -rf /var/cache/apk/*
USER $IMAGE_USER

FROM packages AS kubectl
ARG IMAGE_USER
ARG KUBECTL_VERSION
USER root
RUN curl -LO https://storage.googleapis.com/kubernetes-release/release/v"$KUBECTL_VERSION"/bin/linux/amd64/kubectl && \
    chmod +x ./kubectl && \
    mv ./kubectl /usr/local/bin/kubectl
USER $IMAGE_USER

FROM kubectl as vault
ARG IMAGE_USER
ARG VAULT_VERSION
USER root
RUN curl -LO https://releases.hashicorp.com/vault/"$VAULT_VERSION"/vault_"$VAULT_VERSION"_linux_amd64.zip && \
    unzip vault* && \
    chmod +x ./vault && \
    mv ./vault /usr/local/bin/vault && \
    rm vault*
USER $IMAGE_USER


FROM vault AS helm
ARG IMAGE_USER
ARG HELM_VERSION
USER root
ENV HELM_EXPERIMENTAL_OCI=1
RUN curl -L https://get.helm.sh/helm-v"$HELM_VERSION"-linux-amd64.tar.gz -o helm-v"$HELM_VERSION"-linux-amd64.tar.gz && \
    tar -xzf helm-v"$HELM_VERSION"-linux-amd64.tar.gz && \
    mv linux-amd64/helm /usr/local/bin/helm && rm -rf linux-amd64 && rm -rf helm-v"$HELM_VERSION"-linux-amd64.tar.gz
USER $IMAGE_USER

FROM helm AS helm-plugin
ARG IMAGE_USER
ARG HELM_DIFF_PLUGIN_VERSION
USER root
RUN helm plugin install https://github.com/databus23/helm-diff --version v"$HELM_DIFF_PLUGIN_VERSION" && \
    mkdir ~/.kube
USER $IMAGE_USER

FROM helm-plugin
ARG IMAGE_USER
USER root
RUN helm repo add elastic https://helm.elastic.co && \
    helm repo add incubator https://charts.helm.sh/incubator && \
    helm repo add confluentinc https://confluentinc.github.io/cp-helm-charts && \
    helm repo add stable https://charts.helm.sh/stable && \
    helm repo add gitlab https://charts.gitlab.io && \
    helm repo add hashicorp https://helm.releases.hashicorp.com && \
    helm repo add infracloudio https://infracloudio.github.io/charts && \
    helm repo add bitnami https://charts.bitnami.com/bitnami && \
    helm repo add kubernetes https://kubernetes.github.io/dashboard/ && \
    helm repo update > /dev/null
USER $IMAGE_USER
