#FROM ubuntu:16.04
FROM magland/pynode:try1

# Install mountainlab-js
ADD https://api.github.com/repos/flatironinstitute/mountainlab-js/git/refs/heads/master mountainlab-js_version.json
RUN git clone https://github.com/flatironinstitute/mountainlab-js /working/mountainlab-js
WORKDIR /working/mountainlab-js
RUN npm install -g --unsafe-perm # unsafe-perm is required here because we are root

RUN mkdir -p /working/.mountainlab/packages
ENV ML_PACKAGE_SEARCH_DIRECTORY /working/.mountainlab/packages

ADD https://api.github.com/repos/magland/ml_ephys/git/refs/heads/master ml_ephys_version.json
RUN git clone https://github.com/magland/ml_ephys /working/.mountainlab/packages/ml_ephys
WORKDIR /working/.mountainlab/packages/ml_ephys
RUN pip3 install --upgrade .

#RUN pip3 install pybind11

ADD https://api.github.com/repos/magland/ml_ms4alg/git/refs/heads/master ml_ms4alg_version.json
RUN git clone https://github.com/magland/ml_ms4alg /working/.mountainlab/packages/ml_ms4alg
WORKDIR /working/.mountainlab/packages/ml_ms4alg
RUN pip3 install --upgrade .

WORKDIR /working
COPY tests /working/tests

CMD /bin/bash -c "mongod --fork --logpath /var/log/mongodb.log && sleep 1 && /working/tests/test1.sh"
