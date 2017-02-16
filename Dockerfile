FROM debian:jessie-slim
MAINTAINER FAT <contact@fat.sh>

ENV DEBIAN_FRONTEND noninteractive
ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8

RUN apt-get update && apt-get install -y \
    curl \
    lib32gcc1 \
    lib32ncurses5 \
    lsyncd \
    && rm -rf /var/lib/apt/lists/*

RUN groupadd -r steam && useradd -r -d /home/steam -g steam steam && mkdir -p /home/steam
WORKDIR /home/steam

RUN curl -s https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz | tar -xz

RUN mkdir Steam \
    && ln -s /home/steam/Steam /root/Steam

RUN mkdir .steam \
    && ln -s /home/steam/linux32 .steam/sdk32 \
    && ln -s /home/steam/linux64 .steam/sdk64

RUN ./steamcmd.sh +login anonymous +quit
