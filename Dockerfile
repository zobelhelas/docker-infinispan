FROM debian:stretch

MAINTAINER Martin Zobel-Helas <zobel@debian.org>

ENV DEBIAN_FRONTEND noninteractive
ENV INFINISPAN_VERSION 9.4.16.Final

ENV LC_ALL en_US.UTF-8
ENV TZ Europe/Berlin

# Install tools
RUN apt-get update && \
    apt-get -y --no-install-recommends install \
        wget \
        locales \
        unzip \
        software-properties-common && \
    apt-get clean all && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Install Java 
RUN echo "deb http://ftp.de.debian.org/debian stretch-backports main contrib non-free" > /etc/apt/sources.list.d/debian-backports.list && \
    apt-get update && \ 
    apt-get install -y --no-install-recommends ca-certificates openjdk-11-jdk-headless openjdk-11-jdk && \
    echo "en_US.UTF-8 UTF-8" > /etc/locale.gen && \
    locale-gen en_US.UTF-8 && \
    dpkg-reconfigure locales && \
    /usr/sbin/update-locale LANG=en_US.UTF-8 && \
    apt-get clean all && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN cd /srv && \
    wget https://downloads.jboss.org/infinispan/$INFINISPAN_VERSION/infinispan-server-$INFINISPAN_VERSION.zip && \
    unzip infinispan-server-$INFINISPAN_VERSION.zip && \
    rm infinispan-server-$INFINISPAN_VERSION.zip

