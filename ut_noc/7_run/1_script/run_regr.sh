#!/usr/bin/bash
#========== compile dut to simv ======
if [ ! -f "${SIMV_FILE}" ] || [ ${recomp} == on ];then
#    bash ${GET_FILELIST}
	bash ${RUN_COMPILE_FILE}
fi

if [ -f "${PROJ_WORK_PATH}/report.html" ]; then
    echo -e "del last ${PROJ_WORK_PATH}/report.html"
	rm -rf ${PROJ_WORK_PATH}/report.html
fi

if [ ! -n "${regr_tc}" ];then
    regr_tc_path=${PROJ_WORK_PATH}/regr_tc
    cp -rf ${TB_PATH}/6_top/2_tc/regr_tc ${regr_tc_path}
else
    regr_tc_path=` find ${TB_PATH} -name ${regr_tc} `
    regr_tc_path_num=` find ${TB_PATH} -name ${regr_tc} | wc -l `
    if [ ${regr_tc_path_num} -eq 0 ];then
        echo -e "Error: ${regr_tc_path} regression tc path is null " #debug
		exit
    elif [ ${regr_tc_path_num} -gt 1 ];then
        echo -e "Error: ${regr_tc_path} find more than one regr_tc list file,rename it ,confirm use the only regr_tc list " #debug
	    echo -e "list: \n${regr_tc_path}"
		exit
	else
        echo -e " import regr_tc is ${regr_tc_path} " #debug
	fi
fi
#echo -e " regression tc path is ${regr_tc_path} " #debug

#============== regression all simulation tc ==============
while read line
do
	#	export TC_FILE_NAME=$(echo ${line} | awk -F "/" '{print $(NF-1)}')
	export tc=$(echo ${line} | awk '{print $(1)}')
	regr_num=$(echo ${line} | awk '{print $(2)}')
	sim_para_value=$(echo ${line} | awk '{print $(3)}')
	sim_para_value="${sim_para_value}${opt}"
    for i in `seq $regr_num`
	do
		export seed=$(date +%N)
		if [ ${paral} = on ];then
			tc_list+=" ${tc}"
			seed_list+=" ${seed}"
			sim_para_list+=" ${sim_para_value}"
		else
#			echo -e " ---- regression is ${regr_tc_path} ,\n run simulation ${RUN_SIM_FILE} ${tc} sim_para=${sim_para} value=${sim_para_value} ${seed} "
			if [ ! -n "${sim_para}" ];then
				sim_para=${sim_para_value}
			fi
			bash ${RUN_SIM_FILE}
		fi
		sleep 1s
	done
	echo -e "tc_name :${tc} \n"
done < ${regr_tc_path}


##=========== simulation with parallel ======
if [ ${paral} = on ];then
#    echo -e "tc_name :${tc_list} , sim_para_list is ${sim_para_list} , seed_list is ${seed_list} \n" >~/regr_tmp
	parallel -j ${paral_num} --xapply --trim l "make sim tc={1} sim_para={2} seed={3}" ::: ${tc_list} ::: ${sim_para_list} ::: ${seed_list} 
fi

#
#======= auto generate the report =======
bash ${RUN_REPORT_FILE} &
#firefox ${}
