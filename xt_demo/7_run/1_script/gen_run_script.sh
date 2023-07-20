#!/usr/bash
#======================================
#Filename : gen_run_script.sh 
#use      : gen_run_script cfg.ini
#author   : yuanchao.li
#======================================
## specify the cfg file
if [ ! -n "$1" ];then
	echo " Error: no specify cfg file, at least specify the default cfg_para_base.ini"
    exit
else
    cfg_file=$*
	echo " specify cfg = ${cfg_file} to gen run script !!!"
fi

## prevent the same cfg filename
if [ ! -d "${PROJ_WORK_PATH}" ];then
	mkdir -p ${PROJ_WORK_PATH}
else
	echo "${PROJ_WORK_PATH} is exist"
fi

#------- insert paramter to script from configuration file ----------
#get_para: content_file , content_start_tag , content_end_tag , instead file name , instead tag  
function get_para()
{
	empty_line_num=1 
	start_line_num=`sed -n -e '/'${2}'/=' ${1}`
    end_line_num=`sed -n -e '/'${3}'/=' ${1}`
    tag_line_num=`sed -n -e '/'${5}'/=' ${4}`
	start_content_line=$((start_line_num+empty_line_num));
	end_content_line=$((end_line_num-empty_line_num));
	insert_content_line=$((tag_line_num-empty_line_num));

	if [ ${start_content_line} -gt ${end_content_line} ];then
		echo -e "--Warning : \nplease confirm between ${2} and ${3} are null content parameter in ${1} "
	else
		sed -n "${start_content_line},${end_content_line}p" ${1} > ${4}.tmp
		sed -i ''${insert_content_line}' r '${4}'.tmp' ${4}
#		sed -i '/'${5}'/r '${4}'.tmp' ${4}
		rm -rf ${4}.tmp
#		sed -i '/CMP_CMD_REPLACE_TAG/r com_cmd.tmp' ${4}
    fi
#	echo " start_line_num is $start_content_line. end_line_num is $end_content_line " #debug
#	return ${opt_para}
}


#-------------------- gen run script in workspace ---------------------
#cp -rf $get_dutlist g_get_dutlist.tmp
cp -rf 1_compile.sh   ${RUN_COMPILE_FILE} 
cp -rf 2_sim.sh       ${RUN_SIM_FILE}
cp -rf wave_view.sh   ${RUN_WAVE_FILE}
cp -rf regression.sh  ${RUN_REGR_FILE}

#echo "--------gen_command cfg is $* ------" #debug
for file_path in $* 
do
    #------- find the only one configuration file ----------
	file_name=$(basename "${file_path}")
    cfg_path=` find ${TB_PATH} -name ${file_name} `
    cfg_path_num=` find ${TB_PATH} -name ${file_name} | wc -l `
#	echo "------ gen run script: import file cfg is ${file_name} ------" #debug
    if [ $cfg_path_num -eq 0 ];then
    	echo "---- Error : can't find cfg file ,please theck filepath & filename is correct."
    	exit
    else
    	if [ $cfg_path_num -gt 1 ];then
    	    echo "---- Error : find more than one cfg file , rename it , confirm use the only one cfg"
    		echo "${cfg_path}"
    	    exit
    	else
    		echo "gen run script : cfg_path = ${cfg_path} !!!"
        fi
    fi

    get_para ${cfg_path} CMP_CMD_START  CMP_CMD_END  ${RUN_COMPILE_FILE} CMP_CMD_REPLACE_TAG 
    get_para ${cfg_path} SIM_CMD_START  SIM_CMD_END  ${RUN_SIM_FILE}     SIM_CMD_REPLACE_TAG 
    get_para ${cfg_path} WAVE_CMD_START WAVE_CMD_END ${RUN_WAVE_FILE}    WAVE_CMD_REPLACE_TAG 
	#echo "return value is $?"#todo
done

#-------------- del specify tag in shell script -------------
sed -i '/CMP_CMD_REPLACE_TAG/d'  ${RUN_COMPILE_FILE}
sed -i '/SIM_CMD_REPLACE_TAG/d'  ${RUN_SIM_FILE}
sed -i '/WAVE_CMD_REPLACE_TAG/d' ${RUN_WAVE_FILE}

