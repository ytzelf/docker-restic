FROM phusion/baseimage:0.11

MAINTAINER ytzelf

ENV ARCH=amd64 \
    RESTIC_VERSION=0.9.6 \
    RESTIC_DOWNLOAD=https://github.com/restic/restic/releases/download/

CMD ["/sbin/my_init"]

RUN apt-get update \
    && apt-get --assume-yes install wget \
    && cd /tmp \
    && wget -q ${RESTIC_DOWNLOAD}/v${RESTIC_VERSION}/restic_${RESTIC_VERSION}_linux_amd64.bz2 \
    && bunzip2 -d /tmp/restic_${RESTIC_VERSION}_linux_amd64.bz2 \
    && mv /tmp/restic_${RESTIC_VERSION}_linux_amd64 /usr/bin/restic \
    && chmod u+x /usr/bin/restic \
    && mkdir /source && mkdir /source/system && mkdir /source/data && mkdir /target && mkdir /root/restic \
    && apt-get --assume-yes purge wget

VOLUME ["/source", "/target", "/root/restic"]

RUN apt-get --assume-yes autoremove && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
