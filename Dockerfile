FROM phusion/baseimage:0.11

MAINTAINER ytzelf

ENV ARCH=amd64 \
    RESTIC_VERSION=0.9.3 \
    RESTIC_DOWNLOAD=https://github.com/restic/restic/releases/download/

CMD ["/sbin/my_init"]

RUN apt-get update \
    && apt-get --assume-yes install wget \
    && cd /tmp \
    && wget -q ${RESTIC_DOWNLOAD}/v${RCLONE_VERSION}/restic_${RCLONE_VERSION}_linux_amd64.bz2 \
    && bzip2 -d /tmp/restic_${RCLONE_VERSION}_linux_amd64.bz2 \
    && mv /tmp/restic_${RCLONE_VERSION}_linux_amd64 /usr/bin \
    && apt-get --assume-yes purge wget

RUN apt-get --assume-yes autoremove && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*