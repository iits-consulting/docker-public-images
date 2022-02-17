FROM python:3.9.10 AS Base
RUN pip3 install otcextensions python-openstackclient

FROM Base AS OTC
RUN mkdir /etc/openstack
ENV OS_CLOUD=otc
USER nobody