FROM ubuntu:16.04

MAINTAINER Jeremy Magland

# Install utils
RUN apt-get update && \
    apt-get install -y \
    curl htop git nano

# Install nodejs
RUN curl -sL https://deb.nodesource.com/setup_8.x -o nodesource_setup.sh && \
	bash nodesource_setup.sh
RUN apt-get update && \
    apt-get install -y \
    nodejs

# Install mongodb
RUN mkdir -p /data/db
RUN apt-get update && \
    apt-get install -y \
    mongodb

# Install python and pip
RUN apt-get update && \
    apt-get install -y \
    python3 python3-pip