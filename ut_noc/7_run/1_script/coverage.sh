#!/usr/bin/bash
#------ build TC directory ------
if [[ ! -d ${PROJ_WORK_PATH}/${tc} ]];then
	mkdir -p ${PROJ_WORK_PATH}/${tc}
else
	echo " ${PROJ_WORK_PATH}/${tc} is exist "
fi

#------- option from command line ---------
#if [ $# == 0 ];then
#    echo " no self-define para to coverage script "
#else
#    COV_CMD_DEF=$*
#fi


#------- view coverage report file ----------
if [[ -n "${view}" ]];then
    if [ ${view} = "dve" ];then
	    COV_OPT="dve -full64 -cov -logdir ${PROJ_WORK_PATH}/cov "
	elif [[ ${view} = "verdi" ]];then
    	COV_OPT="verdi -cov -covdir  ${PROJ_WORK_PATH}/cov/merge_cov.vdb -workMode coverageAnalysis "
	    COV_OPT="${COV_OPT} -guiConf ${PROJ_WORK_PATH}/cov/novas.conf "
	    COV_OPT="${COV_OPT} -rcFile ${PROJ_WORK_PATH}/cov/novas.rc "
	    COV_OPT="${COV_OPT} -logdir ${PROJ_WORK_PATH}/cov/ "
	else
    	COV_OPT="firefox ${PROJ_WORK_PATH}/cov/urgReport/dashboard.html "
	fi
#------- merge coverage db file ----------
else
    COV_OPT="urg \
        "
    COV_OPT="${COV_OPT} -full64 -parallel -maxjobs {paral_num} "
    
	echo -e " add coverage db file to ${PROJ_WORK_PATH}/cov/merge_vdb.fl to merge "
    if [[ ! -d "${PROJ_WORK_PATH}/cov/merge_vdb.fl" ]];then
        echo -e "${PROJ_WORK_PATH}/cov/simv.vdb" > ${PROJ_WORK_PATH}/cov/merge_vdb.fl
    fi
    COV_OPT="${COV_OPT} -f ${PROJ_WORK_PATH}/cov/merge_vdb.fl "
    COV_OPT="${COV_OPT} -report ${PROJ_WORK_PATH}/cov/urgReport  -dbname ${PROJ_WORK_PATH}/cov/merge_cov/merge"
fi


if [[ -n "${opt}" ]]; then
	ACT_PARA=`echo ${opt} | sed 's/--/ /g'`
    for file_path in ${ACT_PARA} 
    do
    	COV_OPT="${COV_OPT} -dir ${file_path} "
    done
else
	COV_OPT="${COV_OPT} -dir ${PROJ_WORK_PATH}/cov/*simv.vdb "
fi

COV_OPT=" ${COV_OPT} & "
echo -e "coverage urg command : ${COV_OPT}"
eval ${COV_OPT}


