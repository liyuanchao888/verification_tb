#!/usr/bin/bash
#------ build TC directory ------
if [ ! -d ${PROJ_WORK_PATH}/${tc} ];then
	mkdir -p ${PROJ_WORK_PATH}/${tc}
else
	echo " ${PROJ_WORK_PATH}/${tc} is exist "
fi


#------- option from command line ---------
if [ $# == 0 ];then
    echo " run_sim.sh no self-define para from command line "
else
    COV_CMD_DEF=$*
fi

COV_OPT="urg \
    "
#    COV_OPT="${COV_OPT} ${COV_CMD_DEF} "

#====== ADD part 1: vcs switch on-off configuration       =======
#---- code coverage  -----
COV_OPT="${COV_OPT} -full64 -parallel -maxjobs {paral_num} -dir ${PROJ_WORK_PATH}/cov/*simv.vdb "
#------- merge file from file_path ----------
if [ -n "${opt}" ]; then
	ACT_PARA=`echo ${opt} | sed 's/--/ /g'`
    for file_path in ${ACT_PARA} 
    do
    	COV_OPT="${COV_OPT} -dir ${file_path} "
    done
fi

COV_OPT="${COV_OPT} -report ${PROJ_WORK_PATH}/cov/urgReport  -dbname ${PROJ_WORK_PATH}/cov/merge_cov/merge"

if [ -n "${report}" ];then
    if [ ${report} = "dve" ];then
	    COV_OPT="dve -full64 -dir ${PROJ_WORK_PATH}/cov/*simv.vdb -logdir ${PROJ_WORK_PATH}/cov & "
	else
    	COV_OPT="firefox ${PROJ_WORK_PATH}/cov/urgReport/dashboard.html & "
	fi
fi

echo -e "coverage urg command is ${COV_OPT}"
eval ${COV_OPT}


