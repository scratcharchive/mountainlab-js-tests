#!/bin/bash

set -e

SCRIPTPATH="$( cd "$(dirname "$0")" ; pwd -P )"
BASE=$SCRIPTPATH/..

cd $BASE/mountainlab-js
npm install
export PATH=/working/mountainlab-js/bin:$PATH
export ML_PACKAGE_SEARCH_DIRECTORY=$BASE/packages

cd $BASE/packages/ml_ephys
pip3 install --upgrade -r requirements.txt

cd $BASE/packages/ml_ms4alg
pip3 install --upgrade -r requirements.txt

ml-list-processors

cd $BASE/mountainlab-js/examples/spike_sorting/001_ms4_bash_example
./synthesize_dataset.sh
./ms4_sort_bash.sh

#ml-lari-start &
#sleep 1

#cd /working/mountainlab-js/examples/spike_sorting/002_ms4_script_example
#./synthesize_dataset.sh
#./ms4_sort.sh