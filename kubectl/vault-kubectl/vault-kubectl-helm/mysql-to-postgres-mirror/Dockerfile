FROM iits/vault-kubectl-helm:3.2.1-openapifix-stablerepofix AS Updated
RUN apk update --no-cache && \
  apk add --no-cache postgresql-libs=13.6-r0 vim=8.2.4173-r0 python3=3.8.10-r0 py3-pip=20.3.4-r0 python3-dev=3.8.10-r0 && \
  apk add --no-cache --virtual \
  .build-deps gcc=10.2.1_pre1-r3 \
  musl-dev=1.2.2-r1 \
  postgresql-dev=13.5-r0 && \
  rm -rf /var/cache/apk/*
ENV PYTHON_VERSION=3.8.10
ENV PYTHON_PIP_VERSION=20.3.4
WORKDIR /usr/src/app

# python tap env
FROM Updated AS PythonTapEnv
COPY tap-requirements.txt ./
RUN python3 -m venv ~/.virtualenvs/tap && \
    . ~/.virtualenvs/tap/bin/activate && \
    pip install --no-cache-dir -r tap-requirements.txt

# python target env
FROM PythonTapEnv AS Python3
COPY target-requirements.txt ./
RUN python3 -m venv ~/.virtualenvs/target && \
    . ~/.virtualenvs/target/bin/activate && \
    pip install --no-cache-dir -r target-requirements.txt && \
    apk --purge del .build-deps

FROM Python3
ARG IMAGE_USER=mysql-user
RUN addgroup -S $IMAGE_USER && \
    adduser -G $IMAGE_USER --system --shell=/bin/false --disabled-password $IMAGE_USER && \
    mkdir -p /var/log/$IMAGE_USER && \
    chown -R $IMAGE_USER:$IMAGE_USER /var/log/$IMAGE_USER
USER $IMAGE_USER
