FROM iits/vault-kubectl-helm:3.2.1-openapifix-stablerepofix

RUN apk update --no-cache && \
  apk add --no-cache postgresql-libs=12.5-r0 vim=8.2.0735-r0 python3=3.8.5-r0 py3-pip=20.1.1-r0 python3-dev=3.8.5-r0 && \
  apk add --no-cache --virtual \
  .build-deps gcc=9.3.0-r2 \
  musl-dev=1.1.24-r10 \
  postgresql-dev=12.5-r0 && \
  rm -rf /var/cache/apk/*

ENV PYTHON_VERSION=3.8.5
ENV PYTHON_PIP_VERSION=20.1.1
WORKDIR /usr/src/app


# python tap env
COPY tap-requirements.txt ./
RUN python3 -m venv ~/.virtualenvs/tap && \
    . ~/.virtualenvs/tap/bin/activate && \
    pip install --no-cache-dir -r tap-requirements.txt


# python target env
COPY target-requirements.txt ./
RUN python3 -m venv ~/.virtualenvs/target && \
    . ~/.virtualenvs/target/bin/activate && \
    pip install --no-cache-dir -r target-requirements.txt

RUN apk --purge del .build-deps
