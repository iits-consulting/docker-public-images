FROM python:3.9.10 AS Base
ENV PIP_DISABLE_PIP_VERSION_CHECK=1
ENV PIP_NO_CACHE_DIR=1

FROM Base AS OTC
RUN pip3 install otcextensions==0.26.0 python-openstackclient==5.7.0

FROM OTC
RUN apt-get update && apt-get install -y jq
USER nobody