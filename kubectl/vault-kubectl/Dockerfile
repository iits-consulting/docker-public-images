ARG IMAGE_USER=vault-kubectl-user
ARG VAULT_VERSION=1.3.3
FROM iits/kubectl:1.17.17 AS Vault-Kubectl
USER root
ARG IMAGE_USER
RUN addgroup -S $IMAGE_USER && \
    adduser -G $IMAGE_USER --system --shell=/bin/false --disabled-password $IMAGE_USER && \
    mkdir -p /var/log/$IMAGE_USER && \
    chown -R $IMAGE_USER:$IMAGE_USER /var/log/$IMAGE_USER
ARG VAULT_VERSION
USER $IMAGE_USER

FROM Vault-Kubectl AS Install
# install vault
USER root
ARG IMAGE_USER
ARG VAULT_VERSION
RUN curl -LO https://releases.hashicorp.com/vault/"$VAULT_VERSION"/vault_"$VAULT_VERSION"_linux_amd64.zip && \
    unzip vault* && \
    chmod +x ./vault && \
    mv ./vault /usr/local/bin/vault && \
    rm vault*
USER $IMAGE_USER