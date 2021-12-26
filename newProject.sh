#!/bin/bash

#
# 引数で指定した名前のプロジェクトをprojects/下に作成します
#

if [ $# = 0 ]; then
    echo "Enter a project name"
    exit 1
fi

SCRIPTDIR=$(cd $(dirname $(readlink -f $0));pwd)/
NAME=$1

PROJDIR=${SCRIPTDIR}projects/${NAME}/
TEMPLATEDIR=${SCRIPTDIR}tools/templates/

mkdir -p ${PROJDIR}
cd ${PROJDIR}

# makefileの作成
touch makefile
echo "NAME=${NAME}" > makefile
echo "SRCS=${NAME}.c" >> makefile
cat ${TEMPLATEDIR}common.mk >> makefile
cp ${TEMPLATEDIR}eggFuncTemplate.c ${PROJDIR}${NAME}.c
cp ${TEMPLATEDIR}linker.ld ${PROJDIR}linker.ld
