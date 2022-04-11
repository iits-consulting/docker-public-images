ARG IMAGE_USER=mysql-user
FROM iits/vault-kubectl-helm:3.2.1-openapifix-stablerepofix AS Main
ARG IMAGE_USER
USER root
RUN addgroup -S $IMAGE_USER && \
    adduser -G $IMAGE_USER --system --shell=/bin/false --disabled-password $IMAGE_USER
USER $IMAGE_USER

FROM Main AS Updated
ARG IMAGE_USER
USER root
RUN apk update --no-cache && \
  apk add --no-cache postgresql-libs=13.6-r0 vim=8.2.4708-r0 python3=3.9.5-r2 py3-pip=20.3.4-r1 python3-dev=3.9.5-r2 && \
  apk add --no-cache --virtual \
  .build-deps gcc=10.3.1_git20210424-r2 \
  musl-dev=1.2.2-r3 \
  postgresql-dev=13.6-r0 && \
  rm -rf /var/cache/apk/*
ENV PYTHON_VERSION=3.8.10
ENV PYTHON_PIP_VERSION=20.3.4
WORKDIR /usr/src/app
USER $IMAGE_USER

# python tap env
FROM Updated AS PythonTapEnv
ARG IMAGE_USER
USER root
COPY tap-requirements.txt ./
RUN python3 -m venv ~/.virtualenvs/tap && \
    . ~/.virtualenvs/tap/bin/activate && \
    pip install --no-cache-dir -r tap-requirements.txt
USER $IMAGE_USER

# python target env
FROM PythonTapEnv
ARG IMAGE_USER
USER root
COPY target-requirements.txt ./
RUN python3 -m venv ~/.virtualenvs/target && \
    . ~/.virtualenvs/target/bin/activate && \
    pip install --no-cache-dir -r target-requirements.txt && \
    apk --purge del .build-deps
USER $IMAGE_USER
