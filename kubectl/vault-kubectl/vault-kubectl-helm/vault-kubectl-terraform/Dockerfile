#Creates a image with docker,kubectl and terraform
ARG IMAGE_USER=vault-kubectl-terraform
FROM iits/vault-kubectl:1.3.3 AS vault-kubectl
USER root
RUN addgroup -S "$IMAGE_USER" && \
    adduser -G "$IMAGE_USER" --system --shell=/bin/false --disabled-password "$IMAGE_USER"
USER $IMAGE_USER

#terraform
FROM vault-kubectl AS terraform
ARG TERRAFORM_VERSION=1.1.4
ARG IMAGE_USER
USER root
RUN curl -LO https://releases.hashicorp.com/terraform/"$TERRAFORM_VERSION"/terraform_"$TERRAFORM_VERSION"_linux_amd64.zip && \
    unzip terra* && \
    chmod +x ./terraform && \
    mv ./terraform /usr/local/bin/terraform
USER $IMAGE_USER

# tfmigrate
FROM terraform
ARG TFMIGRATE_VERSION=0.2.7
ARG IMAGE_USER
USER root
RUN curl -LO https://github.com/minamijoyo/tfmigrate/releases/download/v"$TFMIGRATE_VERSION"/tfmigrate_"$TFMIGRATE_VERSION"_linux_amd64.tar.gz && \
    tar xvzf tfmigrate_"$TFMIGRATE_VERSION"_linux_amd64.tar.gz && \
    mv tfmigrate /usr/local/bin/
USER $IMAGE_USER