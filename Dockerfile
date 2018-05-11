#FROM ubuntu:16.04
FROM node:stretch

MAINTAINER Jeremy Magland

# Install utils
RUN apt-get update && \
    apt-get install -y \
    curl htop git nano

# Install nodejs
#RUN curl -sL https://deb.nodesource.com/setup_8.x -o nodesource_setup.sh && \
#	bash nodesource_setup.sh
#RUN apt-get update && \
#    apt-get install -y \
#    nodejs

# Install mongodb
RUN mkdir -p /data/db
RUN apt-get update && \
    apt-get install -y \
    mongodb

# Install python and pip
#RUN apt-get update && \
#    apt-get install -y \
#    python3 python3-pip
RUN apt-get update && \
    apt-get install -y \
    python3-pip

# Install mountainlab-js
WORKDIR /working
COPY mountainlab-js /working/mountainlab-js
WORKDIR /working/mountainlab-js
RUN npm install --unsafe-perm # unsafe-perm is required here because we are root
ENV PATH /working/mountainlab-js/bin:$PATH

# Install packages
RUN mkdir -p /working/.mountainlab/packages
WORKDIR /working/.mountainlab/packages
ENV ML_PACKAGE_SEARCH_DIRECTORY /working/.mountainlab/packages

COPY packages/ml_ephys /working/.mountainlab/packages/ml_ephys
RUN cd ml_ephys && pip3 install --upgrade -r requirements.txt

COPY packages/ml_ms4alg /working/.mountainlab/packages/ml_ms4alg
RUN cd ml_ms4alg && pip3 install --upgrade -r requirements.txt

WORKDIR /working
COPY tests /working/tests

CMD /bin/bash -c "mongod --fork --logpath /var/log/mongodb.log && sleep 1 && /working/tests/test1.sh"