FROM docker:20.10.8-git AS Base
RUN apk add --no-cache make=4.3-r0 && \
    rm -rf /var/cache/apk/*
ENV KUBECTL_VERSION=1.17.17
ENV VAULT_VERSION=1.3.3
ENV HELM_VERSION=3.2.1
ENV HELM_EXPERIMENTAL_OCI=1
ENV HELM_DIFF_PLUGIN_VERSION=3.1.2
ENV PYTHON_VERSION=3.8.10
ENV PYTHON_PIP_VERSION=20.3.4
ENV IMAGE_USER=mysql-user

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

FROM Vault AS Helm
RUN curl -L https://get.helm.sh/helm-v"$HELM_VERSION"-linux-amd64.tar.gz -o helm-v"$HELM_VERSION"-linux-amd64.tar.gz && \
    tar -xzf helm-v"$HELM_VERSION"-linux-amd64.tar.gz && \
    mv linux-amd64/helm /usr/local/bin/helm && rm -rf linux-amd64 && rm -rf helm-v"$HELM_VERSION"-linux-amd64.tar.gz

FROM Helm AS LimitedUser
RUN addgroup -S $IMAGE_USER -g 1000 && \
    adduser -G $IMAGE_USER -u 1000 --system --shell=/bin/false --disabled-password $IMAGE_USER
USER $IMAGE_USER

FROM LimitedUser AS HelmPlugin
RUN helm plugin install https://github.com/databus23/helm-diff --version v"$HELM_DIFF_PLUGIN_VERSION" && \
    mkdir ~/.kube

FROM HelmPlugin AS HelmRepo
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

FROM HelmRepo AS PythonLibs
USER root
RUN apk update --no-cache && \
  apk add --no-cache postgresql-libs=13.4-r0 vim=8.2.2956-r0 python3=3.9.5-r1 py3-pip=20.3.4-r1 python3-dev=3.9.5-r1 && \
  apk add --no-cache --virtual \
  .build-deps gcc=10.3.1_git20210424-r2 \
  musl-dev=1.2.2-r3 \
  postgresql-dev=13.4-r0 && \
  rm -rf /var/cache/apk/*
WORKDIR /usr/src/app
USER $IMAGE_USER

# python tap env
FROM PythonLibs AS PythonTap
COPY tap-requirements.txt ./
RUN python3 -m venv ~/.virtualenvs/tap && \
    . ~/.virtualenvs/tap/bin/activate && \
    pip install --no-cache-dir -r tap-requirements.txt

# python target env
FROM PythonTap AS PythonTarget
COPY target-requirements.txt ./
RUN python3 -m venv ~/.virtualenvs/target && \
    . ~/.virtualenvs/target/bin/activate && \
    pip install --no-cache-dir -r target-requirements.txt

FROM PythonTarget
USER root
RUN apk --purge del .build-deps
USER $IMAGE_USER
