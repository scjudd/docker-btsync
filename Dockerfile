FROM ubuntu:trusty
MAINTAINER Spencer Judd <spencercjudd@gmail.com>

RUN apt-get update \
 && apt-get install -y \
    curl \
 && rm -rf /var/lib/apt/lists/*

RUN curl http://download-lb.utorrent.com/endpoint/btsync/os/linux-x64/track/stable | \
    tar -C /usr/local/bin/ -xzvf - btsync \
 && mkdir -p /btsync/sync \
 && mkdir -p /var/run/btsync

EXPOSE 8888 55555

CMD /run.sh
COPY run.sh /
