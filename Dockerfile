#FROM ubuntu:16.04
FROM magland/pynode:try1

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
