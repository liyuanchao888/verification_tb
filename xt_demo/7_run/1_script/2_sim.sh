#!/usr/bin/bash
#------ build TC directory ------
if [ ! -d ${PROJ_WORK_PATH}/${TC_NAME} ];then
	mkdir -p ${PROJ_WORK_PATH}/${TC_NAME}
else
	echo " ${PROJ_WORK_PATH}/${TC_NAME} is exist "
fi

SIM_OPT="${PROJ_WORK_PATH}/output/simv \
	#{SIM_CMD_REPLACE_TAG} \
    "
#------- option from command line ---------
if [ $# == 0 ];then
    echo " run_sim.sh no self-define para from command line "
else
    SIM_CMD_DEF=$*
    SIM_OPT="${SIM_OPT} ${SIM_CMD_DEF} "
fi

#====== ADD part 1: vcs switch on-off configuration       =======
#---- dump wave  -----
if [ ${wave} = on ]; then
    SIM_OPT="${SIM_OPT} +fsdbfile=${PROJ_WORK_PATH}/${TC_NAME}/${TC_NAME}_${TC_SEED}.fsdb +vcs+flush+all "
	if [ ${wave_cfg} = on ]; then
        SIM_OPT="${SIM_OPT} -ucli -i wave.tcl "
	elif [ ${wave_cfg} != off ]; then
        SIM_OPT="${SIM_OPT} -ucli -i ${wave_cfg} "
    fi
fi

#---- code coverage  -----
[ ${coverage} = on ] && SIM_OPT="${SIM_OPT} \
	-cm line+cond+fsm+tgl+branch+assert \
	-cm_name ${TC_NAME}_${TC_SEED}_cov \
	-cm_dir  ${PROJ_WORK_PATH}/cov/simv.vdb \
	-cm_log  ${PROJ_WORK_PATH}/cov/${TC_NAME}_${TC_SEED}_cm.log"

#---- performance analysis -----
if [ ${profile} = on ]; then
    SIM_OPT="${SIM_OPT} -simprofile time+mem noprof -simprofile_dir_path ${PROJ_WORK_PATH}/profile "
elif [ ${profile} = time ]; then
    SIM_OPT="${SIM_OPT} -simprofile time noprof -simprofile_dir_path ${PROJ_WORK_PATH}/profile "
elif [ ${profile} = mem ]; then
    SIM_OPT="${SIM_OPT} -simprofile mem noprof -simprofile_dir_path ${PROJ_WORK_PATH}/profile "
fi

#---- xprop  -----
if [ ${xprop} = on ]; then
    SIM_OPT="${SIM_OPT} -xprop=tmerge"
elif [ ${xprop} = xmerge ]; then
    SIM_OPT="${SIM_OPT} -xprop=tmerge"
elif [ ${xprop} != off ]; then
    SIM_OPT="${SIM_OPT} -xprop=${xprop}"
fi

#====== ADD part 2: self-define parameter to sim_command  =======
if [ -n "${sim_para}" ]; then
	ACT_PARA=`echo ${sim_para} | sed 's/+/ +/g'`
    SIM_OPT="${SIM_OPT} ${ACT_PARA}"
fi

SIM_OPT="${SIM_OPT} -l ${PROJ_WORK_PATH}/${TC_NAME}/${TC_NAME}_${TC_SEED}.log "
echo "simulation command is ${SIM_OPT}"
eval ${SIM_OPT}
echo "TC log is ${PROJ_WORK_PATH}/${TC_NAME}/${TC_NAME}_${TC_SEED}.log"

