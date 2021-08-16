#Creates a image with docker,kubectl and terraform
FROM iits/vault-kubectl:1.3.3
ARG TERRAFORM_VERSION=0.14.8
ARG TFMIGRATE_VERSION=0.2.5

#terraform
RUN curl -LO https://releases.hashicorp.com/terraform/"$TERRAFORM_VERSION"/terraform_"$TERRAFORM_VERSION"_linux_amd64.zip && \
    unzip terra* && \
    chmod +x ./terraform && \
    mv ./terraform /usr/local/bin/terraform

# tfmigrate
RUN curl -LO https://github.com/minamijoyo/tfmigrate/releases/download/v${TFMIGRATE_VERSION}/tfmigrate_${TFMIGRATE_VERSION}_linux_amd64.tar.gz && \
    tar xvzf tfmigrate_${TFMIGRATE_VERSION}_linux_amd64.tar.gz && \
    mv tfmigrate /usr/local/bin/