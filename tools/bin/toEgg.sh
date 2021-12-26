#!/bin/bash

BIN=$1
NAME=${BIN%.bin}
SCRIPTDIR=$(cd $(dirname $(readlink -f $0));pwd)
SCRIPT=${SCRIPTDIR}/../converter/converter.py

${SCRIPTDIR}/encrypt ${BIN}
${SCRIPTDIR}/../converter/converter.py -i ${NAME}_egg.bin -o ${NAME}_egg_par.txt --pointer -a 0xC318 -p 0x02108818