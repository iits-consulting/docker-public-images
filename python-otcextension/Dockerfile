FROM python:3.9.10 AS base
ENV PIP_DISABLE_PIP_VERSION_CHECK=1
ENV PIP_NO_CACHE_DIR=1

FROM base AS otc
RUN pip3 install otcextensions==0.26.0 python-openstackclient==5.7.0

FROM otc
RUN apt-get update && apt-get --no-install-recommends install -y jq=1.6-2.1 && apt-get clean && rm -rf /var/lib/apt/lists/*
USER nobody
