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
    cfg_all=$*
	if [[ ${soc} = on ]];then
	    cfg_file=`echo ${cfg_all} | sed 's#'${CFG_PARA_IP}'# #g'`
	else
	    cfg_file=`echo ${cfg_all} | sed 's#'${CFG_PARA_SOC}'# #g'`
	fi
#	echo -e " specify cfg = ${cfg_file} to gen run script !!! \n"#debug
fi

## prevent the same cfg filename
if [ ! -d "${PROJ_WORK_PATH}" ];then
	mkdir -p ${PROJ_WORK_PATH}
else
	echo -e "${PROJ_WORK_PATH} is exist"
fi

#------- insert paramter to script from configuration file ----------
#get_para: content_file , content_start_tag , content_end_tag , output_file , instead tag in output_file
function get_para()
{
	if [ ! -f ${4} ];then #build new file,if no exist file
        echo -e "${5}" > ${4}
	fi
	empty_line_num=1 
	start_line_num=`sed -n -e '/'${2}'/=' ${1}`
    end_line_num=`sed -n -e '/'${3}'/=' ${1}`
    tag_line_num=`sed -n -e '/'${5}'/=' ${4}`
	start_content_line=$((start_line_num+empty_line_num));
	end_content_line=$((end_line_num-empty_line_num));
    if [ ${tag_line_num} -eq 1 ];then
        sed -i '/'${5}'/i\\' ${4}
        tag_line_num=2
	fi
    insert_content_line=$((tag_line_num-empty_line_num));

	if [ ${start_content_line} -gt ${end_content_line} ];then
		echo -e "[-Warning] : between ${2} and ${3} are null in ${1} "
	else
		sed -n "${start_content_line},${end_content_line}p" ${1} > ${4}.tmp
		sed -i ''${insert_content_line}' r '${4}'.tmp' ${4}
		rm -rf ${4}.tmp
#		sed -i '/'${5}'/r '${4}'.tmp' ${4}
#		sed -i '/CMP_CMD_REPLACE_TAG/r com_cmd.tmp' ${4}
    fi
#	return ${opt_para}
}


function gen_file()
{
    #-------------------- gen run script in workspace ---------------------
    #cp -rf $get_dutlist g_get_dutlist.tmp
    cp -rf 1_compile.sh   ${RUN_COMPILE_FILE} 
    cp -rf 2_sim.sh       ${RUN_SIM_FILE}
    cp -rf 3_wave.sh      ${RUN_WAVE_FILE}
    rm -rf ${HIER_COVER_FILE}
    rm -rf ${HIER_XPROP_FILE}
    rm -rf ${HIER_INIT_REG_FILE}
    
    #echo "--------gen_command cfg is $* ------" #debug
    for file_path in ${cfg_file} 
    do
        #------- find the only one configuration file ----------
    	file_name=$(basename "${file_path}")
    #   	echo "--- gen run file_path=${file_path} ,file_name=${file_name}!!!"
        cfg_path=` find ${TB_PATH} -name ${file_name} `
        cfg_path_num=` find ${TB_PATH} -name ${file_name} | wc -l `
    #	echo -e "\n ---- gen run script: cfg_path is ${cfg_path}------" #debug
        if [ ${cfg_path_num} -eq 0 ];then
            cfg_path=` find ${VP_PATH} -name ${file_name} `
            cfg_path_num=` find ${VP_PATH} -name ${file_name} | wc -l `
            if [ ${cfg_path_num} -eq 0 ];then
				echo -e "[-Error] : can't find cfg_file( ${file_name} ) ,please check file path & name is correct."
        	    exit
			fi
        else
        	if [ ${cfg_path_num} -gt 1 ];then
        	    echo -e "[-Error] : find more than one cfg file , rename it , confirm use the only one cfg"
        		echo -e " cfg file : ${cfg_path}"
        	    exit
        	else
        		echo -e "---- gen run script : import cfg = ${cfg_path} !!!\n"
            fi
        fi
    
        get_para ${cfg_path} CMP_CMD_START       CMP_CMD_END       ${RUN_COMPILE_FILE}   CMP_CMD_REPLACE_TAG 
        get_para ${cfg_path} SIM_CMD_START       SIM_CMD_END       ${RUN_SIM_FILE}       SIM_CMD_REPLACE_TAG 
        get_para ${cfg_path} WAVE_CMD_START      WAVE_CMD_END      ${RUN_WAVE_FILE}      WAVE_CMD_REPLACE_TAG 
        get_para ${cfg_path} HIER_COVER_START    HIER_COVER_END    ${HIER_COVER_FILE}    HIER_COVER_REPLACE_TAG
        get_para ${cfg_path} HIER_XPROP_START    HIER_XPROP_END    ${HIER_XPROP_FILE}    HIER_XPROP_REPLACE_TAG
        get_para ${cfg_path} HIER_INIT_REG_START HIER_INIT_REG_END ${HIER_INIT_REG_FILE} HIER_INIT_REG_REPLACE_TAG
    	#echo "return value is $?"#todo
    done
    
    #-------------- del specify tag in shell script -------------
    sed -i '/CMP_CMD_REPLACE_TAG/d'        ${RUN_COMPILE_FILE}
    sed -i '/SIM_CMD_REPLACE_TAG/d'        ${RUN_SIM_FILE}
    sed -i '/WAVE_CMD_REPLACE_TAG/d'       ${RUN_WAVE_FILE}
    sed -i '/HIER_COVER_REPLACE_TAG/d'     ${HIER_COVER_FILE}   
    sed -i '/HIER_XPROP_REPLACE_TAG/d'     ${HIER_XPROP_FILE}   
    sed -i '/HIER_INIT_REG_REPLACE_TAG/d'  ${HIER_INIT_REG_FILE}
}

gen_file

