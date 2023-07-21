#!/usr/bin/bash
find ../ -name "test_cfg.txt">report_tc_list

if [ -f "../2_work/report.html" ]; then
    echo "del last ../2_work/report.html"
	rm -rf ../2_work/report.html
fi

echo "#!/usr/bin/bash" >report_tmp.sh

while read line
do
	TC_FILE_NAME=$(echo ${line} | awk -F "/" '{print $(NF-1)}')
	echo "./report_log.sh ${TC_FILE_NAME}" >>report_tmp.sh
	echo "File:${line}"
	echo "tc_name :${TC_FILE_NAME}"
done < report_tc_list

sh ./report_tmp.sh
rm report_tc_list
rm report_tmp.sh

firefox ../2_work/report.html
