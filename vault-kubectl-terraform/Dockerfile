#Creates a image with docker,kubectl and terraform
FROM docker:20.10.8-git AS Base
RUN apk add --no-cache make=4.3-r0 && \
    rm -rf /var/cache/apk/*
ENV KUBECTL_VERSION=1.17.17
ENV VAULT_VERSION=1.3.3
ENV TERRAFORM_VERSION=0.14.8
ENV TFMIGRATE_VERSION=0.2.7

FROM Base AS Packages
RUN apk add --no-cache curl=7.78.0-r0 \
    bash=5.1.4-r0 \
    jq=1.6-r1 && \
    rm -rf /var/cache/apk/*

FROM Packages AS Kubectl
RUN curl -LO https://storage.googleapis.com/kubernetes-release/release/v"$KUBECTL_VERSION"/bin/linux/amd64/kubectl && \
    chmod +x ./kubectl && \
    mv ./kubectl /usr/local/bin/kubectl

FROM Kubectl AS Vault
RUN curl -LO https://releases.hashicorp.com/vault/"$VAULT_VERSION"/vault_"$VAULT_VERSION"_linux_amd64.zip && \
    unzip vault* && \
    chmod +x ./vault && \
    mv ./vault /usr/local/bin/vault && \
    rm vault*

FROM Vault AS Terraform
RUN curl -LO https://releases.hashicorp.com/terraform/"$TERRAFORM_VERSION"/terraform_"$TERRAFORM_VERSION"_linux_amd64.zip && \
    unzip terra* && \
    chmod +x ./terraform && \
    mv ./terraform /usr/local/bin/terraform

FROM Terraform AS Tfmigrate
RUN curl -LO https://github.com/minamijoyo/tfmigrate/releases/download/v"$TFMIGRATE_VERSION"/tfmigrate_"$TFMIGRATE_VERSION"_linux_amd64.tar.gz && \
    tar xvzf tfmigrate_"$TFMIGRATE_VERSION"_linux_amd64.tar.gz && \
    mv tfmigrate /usr/local/bin/

FROM Tfmigrate
ARG IMAGE_USER=vault-kubectl-terraform
RUN addgroup -S $IMAGE_USER -g 1000 && \
    adduser -G $IMAGE_USER -u 1000 --system --shell=/bin/false --disabled-password $IMAGE_USER
USER $IMAGE_USER