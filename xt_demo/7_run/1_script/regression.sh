#!/usr/bin/bash

#========== compile dut to simv ======
if [[ $comp == on ]];then
#    bash ${GET_FILELIST}
	bash ${RUN_COMPILE_FILE}
fi

if [ -f "${PROJ_WORK_PATH}/report.html" ]; then
    echo -e "del last ${PROJ_WORK_PATH}/report.html"
	rm -rf ${PROJ_WORK_PATH}/report.html
fi

echo "#!/usr/bin/bash" >regression_tmp.sh

while read line
do
#	export TC_FILE_NAME=$(echo ${line} | awk -F "/" '{print $(NF-1)}')
	export TC_FILE_NAME=$(echo ${line} | awk '{print $(1)}')
	regr_num=$(echo ${line} | awk '{print $(2)}')
    for i in `seq $regr_num`
	do
		export tc_seed=$(date +%N)
		if [ ${para} = on ];then
			tc_list +=" ${tc}"
			tc_seed_list +=" ${tc_seed}"
		else
			bash ${RUN_SIM_FILE} ${tc} ${tc_seed}
		fi
		sleep 1s
	done
	echo "File:${line}"
	echo "tc_name :${TC_FILE_NAME}"
done < ${PROJ_WORK_PATH}/regression_tc

#=========== simulation with parallel ======
if [ ${para} = on ];then
	parallel -j ${PARAL} --xapply --trim 1 "make sim tc={1} seed={2}" ::: ${tc_list} ::: ${tc_seed_list}
fi



#======= auto generate the report =======
#./run_report.sh
firefox ${RUN_REPORT}






