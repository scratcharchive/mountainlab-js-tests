FROM node:stretch
RUN apt-get update \
  && apt-get install -y \
    python3-pip \
    mongodb \
  && rm -rf /var/lib/apt/lists/*
RUN mkdir -p /data/db

RUN useradd -m build
USER build
WORKDIR /working
ENV PATH=/working/mountainlab-js/bin:$PATH ML_PACKAGE_SEARCH_DIRECTORY=/working/packages

COPY --chown=build mountainlab-js mountainlab-js
RUN cd mountainlab-js && npm install

COPY --chown=build packages packages
RUN for d in packages/* ; do cd $d && pip3 install -r requirements.txt && cd - || exit ; done

COPY --chown=build tests tests
USER root
CMD ["/bin/bash", "-c", "mongod --fork --logpath /var/log/mongodb.log && sleep 1 && runuser -u build -m -- tests/test1.sh"]

