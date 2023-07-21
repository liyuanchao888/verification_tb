#!/bin/bash
function clean_tmp()
{
echo "******* clean file: ${1} csrc *.log ***************"
rm -rf ${1}/csrc
rm -rf ${1}/simv
rm -rf ${1}/simv.vdb
rm -rf ${1}/simv.daidir
rm -rf ${1}/*.log
rm -rf ${1}/*.vpd
rm -rf ${1}/novas.*
rm -rf ${1}/verdiLog
rm -rf ${1}/output
rm -rf ${1}/ucli.key 
rm -rf ${1}/vc_hdrs.h  verdi_config_file
rm -rf ${1}/${tc}
find ${1} -name "*.log" -o -name "*.fsdb" | xargs rm -rf
}

if [ ! -n "$1" ];then
    clean_tmp ${PROJ_WORK_PATH}
elif [ "$1" == "all" ];then
    echo "clean all: ${PROJ_WORK_PATH} "
    rm -rf ${PROJ_WORK_PATH}
else
    clean_tmp $1
fi
