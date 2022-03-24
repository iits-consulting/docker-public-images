#Creates a image with docker,kubectl and terraform
ARG IMAGE_USER=vault-kubectl-helm-user
FROM iits/vault-kubectl:1.3.3 AS VaultK8s
ARG IMAGE_USER
USER root
RUN addgroup -S $IMAGE_USER && \
    adduser -G $IMAGE_USER --system --shell=/bin/false --disabled-password $IMAGE_USER
USER $IMAGE_USER

FROM VaultK8s AS DownloadHelm
ARG HELM_VERSION=3.2.1
ARG IMAGE_USER
USER root
ENV HELM_EXPERIMENTAL_OCI=1
RUN curl -L https://get.helm.sh/helm-v"$HELM_VERSION"-linux-amd64.tar.gz -o helm-v"$HELM_VERSION"-linux-amd64.tar.gz && \
    tar -xzf helm-v"$HELM_VERSION"-linux-amd64.tar.gz && \
    mv linux-amd64/helm /usr/local/bin/helm && rm -rf linux-amd64 && rm -rf helm-v"$HELM_VERSION"-linux-amd64.tar.gz
USER $IMAGE_USER

FROM DownloadHelm AS InstallHelmPlugin
ARG HELM_DIFF_PLUGIN_VERSION=3.1.2
ARG IMAGE_USER
USER root
RUN helm plugin install https://github.com/databus23/helm-diff --version v"$HELM_DIFF_PLUGIN_VERSION" && \
    mkdir ~/.kube
USER $IMAGE_USER

FROM InstallHelmPlugin AS AddHelmRepos
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