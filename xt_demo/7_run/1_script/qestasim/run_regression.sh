#!/usr/bin/bash
find ../ -name "test_cfg.txt">regression_tc

if [ -f "../2_work/report.html" ]; then
    echo "del last ../2_work/report.html"
	rm -rf ../2_work/report.html
fi

echo "#!/usr/bin/bash" >regression_tmp.sh

echo "./run.sh C" >>regression_tmp.sh

while read line
do
	TC_FILE_NAME=$(echo ${line} | awk -F "/" '{print $(NF-1)}')
	echo "./run.sh ../${TC_FILE_NAME} S" >>regression_tmp.sh
	echo "File:${line}"
	echo "tc_name :${TC_FILE_NAME}"
done < regression_tc

sh ./regression_tmp.sh
rm regression_tc
rm regression_tmp.sh

