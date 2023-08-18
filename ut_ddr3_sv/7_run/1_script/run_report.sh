#!/usr/bin/bash
if [ ! -d "${PROJ_WORK_PATH}" ]; then
    echo "no workspace: ${PROJ_WORK_PATH}"
	exit
fi
if [ -f "${PROJ_WORK_PATH}/report.html" ]; then
#    echo "del last ${PROJ_WORK_PATH}/report.html"
	rm -rf ${PROJ_WORK_PATH}/report.html
fi

echo "#!/usr/bin/bash" >${PROJ_WORK_PATH}/report_tmp.sh
#find ../ -name "test_cfg.txt">report_tc_list
find ${PROJ_WORK_PATH} -maxdepth 2 -name "*.log" ! -name "compile.log" ! -path "${PROJ_WORK_PATH}/cov/*" ! -path "${OUTPUT_PATH}/*" > ${PROJ_WORK_PATH}/report_tc_list

while read line
do
	tc_log=$(basename "${line}")
#	TC_FILE_NAME=$(echo ${tc_log} | awk -F "." '{print $(NF-1)}')
#	TC_NAME=${TC_FILE_NAME%_*}
    echo -e "${TB_PATH}/7_run/1_script/report_log.sh ${tc_log}" >>${PROJ_WORK_PATH}/report_tmp.sh
#	echo -e "tc_log_name :${tc_log}"
done < ${PROJ_WORK_PATH}/report_tc_list

sh ${PROJ_WORK_PATH}/report_tmp.sh
echo -e "report_tc_list :${PROJ_WORK_PATH}/report_tc_list "
rm ${PROJ_WORK_PATH}/report_tmp.sh
rm ${PROJ_WORK_PATH}/report_tc_list

firefox ${PROJ_WORK_PATH}/report.html
