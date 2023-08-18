#!/usr/bin/bash

#------  option from configuration file -----
CMP_OPT="${SIMULATOR} \
	#{CMP_CMD_REPLACE_TAG} \
    "

#------- option from command line ---------
if [ $# == 0 ];then
    echo " compile.sh no self-define para from command line "
else
    CMP_CMD_DEF=$*
    CMP_OPT="${CMP_OPT} ${CMP_CMD_DEF} "
fi

#====== ADD part 1: vcs switch on-off configuration       =======
#---- dump wave  -----
if [ ${wave} = on ]; then
    CMP_OPT="${CMP_OPT} -debug_access+all \
		-debug_region=cell+lib -kdb \
		+vcs+flush+all \
		+define+DUMP_FSDB "
	if [ ${wave_cfg} != off ];then
        CMP_OPT="${CMP_OPT} +define+WAVE_CFG "
	fi
fi

#---- code coverage  -----
[ ${assert} = on ] && CMP_OPT="${CMP_OPT} +define+ASSERT_ON "
[ ${coverage} = on ] && CMP_OPT="${CMP_OPT} \
	-cm line+cond+fsm+tgl+branch+assert \
	-cm_tgl mda -cm_line contassign \
	-cm_hier ${HIER_COVER_FILE} \
	-cm_dir ${PROJ_WORK_PATH}/cov/simv.vdb \
	+define+COVER_ON "

#---- performance analysis -----
[ ${profile} != off ] && CMP_OPT="${CMP_OPT} \
	-simprofile -Mdir=${PROJ_WORK_PATH}/profile "

#---- xprop  -----
[ ${xprop} != off ] && CMP_OPT="${CMP_OPT} \
	-xprop=${HIER_XPROP_FILE} "

#---- g++  -----
[ ${c_comp} = on ] && CMP_OPT="${CMP_OPT} \
	-cpp g++ -cc gcc -sysc +define+SYSTEMC_MODEL +define+DEBUG_MODE "

#---- partcompile  -----
[ ${partcomp} = off ] && CMP_OPT="${CMP_OPT} \
	-pcmakeprof -j4 "

if [ ${partcomp} = on ];then
    CMP_OPT=`echo ${CMP_OPT} | sed 's#-top '${tb_top}'# #g'`
	CMP_OPT="${CMP_OPT} -partcomp -fastpartcomp=j4 -top topcfg_partcomp ${PROJ_WORK_PATH}/../1_script/0_config/topcfg_partcomp.v -pcmakeprof -partcomp_dir=${OUTPUT_PATH}/pc_dir "
fi



#---- specify output dir  -----
if [ ${output_dir} = on ];then
    mkdir -p ${OUTPUT_PATH}
fi
[ ${output_dir} = on ] && CMP_OPT="${CMP_OPT} \
	-o ${SIMV_FILE} \
	-Mdir=${OUTPUT_PATH}/csrc "

#---- init mem  -----
[ ${mem_ini} = one ] && CMP_OPT="${CMP_OPT} +vcs+inimem+random "
[ ${mem_ini} = zero ] && CMP_OPT="${CMP_OPT} +vcs+inimem+random "
[ ${mem_ini} = random ] && CMP_OPT="${CMP_OPT} +vcs+inimem+random "

#---- init reg  -----
[ ${reg_ini} != off ] && CMP_OPT="${CMP_OPT} \
	+vcs+initreg+config+${HIER_INIT_REG_FILE} "



#---- use lib when post simulation  -----
if [ ${cell} = on ]; then
	if [ ${upf} = on ];then
		CMP_OPT="${CMP_OPT} -f ${CELL_LIB_PWR_PATH} "
    else
		CMP_OPT="${CMP_OPT} -f ${CELL_LIB_PATH} "
	fi
	if [ ${mem_ini} = zero ];then
		CMP_OPT="${CMP_OPT} +define+TSMC_INITIALIZE_MEM_USING_DEFAUT_TASKS +define+TSMC_MEM_LOAD_0 "
	fi
	if [ ${mem_ini} = one ];then
		CMP_OPT="${CMP_OPT} +define+TSMC_INITIALIZE_MEM_USING_DEFAUT_TASKS +define+TSMC_MEM_LOAD_1 "
	fi
	if [ ${mem_ini} = random ];then
		CMP_OPT="${CMP_OPT} +define+TSMC_INITIALIZE_MEM_USING_DEFAUT_TASKS +define+TSMC_MEM_LOAD_RANDOM "
	fi
fi

	CMP_OPT="${CMP_OPT} -l ${PROJ_WORK_PATH}/compile.log "

#mkdir -p ${PROJ_WORK_PATH}/cov ${PROJ_WORK_PATH}/${DEF} ${PROJ_WORK_PATH}/output
echo "compile command final : ${CMP_OPT} "
eval ${CMP_OPT}

