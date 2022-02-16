#Creates a image with docker,kubectl and terraform
FROM iits/vault-kubectl:1.3.3 AS vault-kubectl

#terraform
FROM vault-kubectl AS terraform
ARG TERRAFORM_VERSION=1.1.4
RUN curl -LO https://releases.hashicorp.com/terraform/"$TERRAFORM_VERSION"/terraform_"$TERRAFORM_VERSION"_linux_amd64.zip && \
    unzip terra* && \
    chmod +x ./terraform && \
    mv ./terraform /usr/local/bin/terraform

# tfmigrate
FROM terraform AS Tfmigrate
ARG TFMIGRATE_VERSION=0.2.7
RUN curl -LO https://github.com/minamijoyo/tfmigrate/releases/download/v"$TFMIGRATE_VERSION"/tfmigrate_"$TFMIGRATE_VERSION"_linux_amd64.tar.gz && \
    tar xvzf tfmigrate_"$TFMIGRATE_VERSION"_linux_amd64.tar.gz && \
    mv tfmigrate /usr/local/bin/

FROM Tfmigrate
ARG IMAGE_USER=vault-kubectl-terraform
RUN addgroup -S $IMAGE_USER && \
    adduser -G $IMAGE_USER --system --shell=/bin/false --disabled-password $IMAGE_USER && \
    mkdir -p /var/log/$IMAGE_USER && \
    chown -R $IMAGE_USER:$IMAGE_USER /var/log/$IMAGE_USER
USER $IMAGE_USER