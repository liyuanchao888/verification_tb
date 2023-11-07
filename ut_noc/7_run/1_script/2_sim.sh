#!/usr/bin/bash
#------ build TC directory ------
if [ ! -d ${PROJ_WORK_PATH}/${tc} ];then
	mkdir -p ${PROJ_WORK_PATH}/${tc}
else
	echo " ${PROJ_WORK_PATH}/${tc} is exist "
fi

SIM_OPT="${SIMV_FILE} \
	#{SIM_CMD_REPLACE_TAG} \
    "
#------- option from command line ---------
if [ $# == 0 ];then
    echo " run_sim.sh no self-define para from command line "
else
    SIM_CMD_DEF=$*
#    SIM_OPT="${SIM_OPT} ${SIM_CMD_DEF} "
fi

#====== ADD part 1: vcs switch on-off configuration       =======
#---- dump wave  -----
if [ ${wave} = on ]; then
    SIM_OPT="${SIM_OPT} +fsdbfile=${PROJ_WORK_PATH}/${tc}/${tc}_${seed}.fsdb +vcs+flush+all "
	if [ ${wave_cfg} = on ]; then
        SIM_OPT="${SIM_OPT} -ucli -i ${CFG_FILE_PATH}/ucli.tcl "
	elif [ ${wave_cfg} != off ]; then
        SIM_OPT="${SIM_OPT} -ucli -i ${CFG_FILE_PATH}/${wave_cfg} "
    fi
fi

#---- code coverage  -----
[ ${coverage} = on ] && SIM_OPT="${SIM_OPT} \
	-cm line+cond+fsm+tgl+branch+assert \
	-cm_name ${tc}_${seed}_cov \
	-cm_dir  ${PROJ_WORK_PATH}/cov/simv.vdb \
	-cm_log  ${PROJ_WORK_PATH}/cov/${tc}_${seed}_cm.log"

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

#---- init reg  -----
[ ${reg_ini} != off ] && SIM_OPT="${SIM_OPT} \
	+vcs+initreg+config+${HIER_INIT_REG_FILE} "

#====== ADD part 2: self-define parameter to sim_command  =======
if [ -n "${opt}" ]; then
	ACT_PARA=`echo ${opt} | sed 's/--/ /g'`
    SIM_OPT="${SIM_OPT} ${ACT_PARA}"
fi
#    echo -e "-----2_sim.sh sim_para is ${sim_para} tc=${tc}" >> ~/tmp

SIM_OPT="${SIM_OPT} -l ${PROJ_WORK_PATH}/${tc}/${tc}_${seed}.log "
echo "simulation command is ${SIM_OPT}"
eval ${SIM_OPT}
echo "TC log is ${PROJ_WORK_PATH}/${tc}/${tc}_${seed}.log"

