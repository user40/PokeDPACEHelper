#!/bin/bash

ADDRESS=0x02290008

BIN=$1
NAME=${BIN%.bin}
SCRIPTDIR=$(cd $(dirname $(readlink -f $0));pwd)
SCRIPT=${SCRIPTDIR}/../converter/converter.py

${SCRIPT} -i ${BIN} -o ${NAME}_${ADDRESS}_par.txt -a ${ADDRESS} --mode=par
${SCRIPT} -i ${BIN} -o ${NAME}_${ADDRESS}_word.txt -a ${ADDRESS} --mode=word
${SCRIPT} -i ${BIN} -o ${NAME}_${ADDRESS}_script.txt -a ${ADDRESS} --mode=scriptDec --nozero