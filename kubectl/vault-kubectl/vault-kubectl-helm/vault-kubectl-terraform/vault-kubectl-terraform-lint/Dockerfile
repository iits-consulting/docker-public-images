#Creates a image with docker,kubectl and terraform
#FROM iits/vault-kubectl-terraform:1.3.3
FROM iits/vault-kubectl-terraform:0.13.3-makefix AS terraform-lint


# tflint
FROM terraform-lint AS tflint
ARG TFLINT_VERSION=v0.28.1
RUN curl -LO https://github.com/terraform-linters/tflint/releases/download/"$TFLINT_VERSION"/tflint_linux_amd64.zip && \
    unzip tflint* && \
    chmod +x ./tflint && \
    mv ./tflint /usr/local/bin/tflint

# tfsec
FROM tflint
ARG TFSEC_VERSION=v0.39.42
RUN curl -LO https://github.com/tfsec/tfsec/releases/download/"$TFSEC_VERSION"/tfsec-linux-amd64 && \
    chmod +x ./tfsec-linux-amd64 && \
    mv ./tfsec-linux-amd64 /usr/local/bin/tfsec