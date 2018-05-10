#!/bin/bash

# Run this in the directory where the script is found.
set -e

docker build -t mountainlab-js-tests .
docker run -it mountainlab-js-tests
