#!/bin/bash

export PYTHONIOENCODING=utf-8
SCRIPTDIR=$(cd $(dirname $(readlink -f $0));pwd)
$SCRIPTDIR/../converter/converter.py $@