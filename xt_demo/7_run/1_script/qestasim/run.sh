#########################################################################
# File Name: run.sh
# Author: lyc_17
# mail: yuanchao.li@corerain.com
# Created Time: Thu 20 Dec 2018 10:26:47 PM EST
#########################################################################
#!/bin/bash
if [ "$#" -lt "1" ] || [ "$1" = "h" ] || [ "$1" = "H" ]
then
    echo "                                                                                " 
    echo " ================ run single testcase ==================                        " 
    echo "                                                                                " 
    echo " Usage:                                                                         " 
    echo "           ./run_sim.sh <file_path> [C/S/CS] [G]                                " 
    echo "                                                                                " 
    echo " [opt]:                                                                         " 
    echo " file_path        -- Testcase path                                              " 
    echo " CS or [empty]    -- Comp & Sim                   Default Both                  " 
    echo " C                -- only Compile file.           Default No                    " 
    echo " S                -- only Simulation file.        Default No                    " 
    echo " G                -- Simulation with GUI.         Default No GUI                " 
    echo "                                                                                " 
    echo " example:                                                                       " 
    echo "       ./run.sh C                          -- only compile file no GUI          " 
    echo "       ./run.sh ../sv001_xxx_tc001_yyy C G -- only compile file throught GUI    " 
    echo "       ./run.sh ../sv001_xxx_tc001_yyy S   -- only run simulation no GUI        " 
    echo "       ./run.sh ../sv001_xxx_tc001_yyy     -- compile and run simulation no GUI " 
    echo "                                                         " 
#   echo " ============ run regress testcase =============         " 
#   echo " Usage     : ./run_sim.sh [R] " 
#   echo " R         : Regression file.      Default No regression " 
#   echo " " 
    exit
else
    echo " " 
fi

REPORT="../8_analysis/1_report"
sim_work="../2_work"
TC_FILE_NAME=$(echo $1|awk -F "/" '{print $NF}')
now=$(date)

#if [ -d ${REPORT} ]; #if has ./report
#then
#  #  rmdir ${REPORT} 
#  #  mkdir ${REPORT} 
#    echo -e " has ${REPORT" 
#else
#    mkdir ${REPORT} 
#fi



if [ "$1" = "C" ] || [ "$2" = "C" ] || [ "$3" = "C" ]
then
	#rm -rf ../2_work/* 
    #cd ../2_work/ 
    echo "--------  Compiling start ---------"

	if [ "$2" = "G" ] || [ "$3" = "G" ] 
	then
        vsim -do "do ../1_script/1_compile.tcl"
	else
        vsim -c -do "do ../1_script/1_compile.tcl;quit" 
    fi

elif [ "$2" = "S" ] || [ "$3" = "S" ]
then
    TEST=$1
    if [ -f ${TEST}/test_cfg.txt ]
    then
    	echo "Start Test Simulation ${now}" 
    else
        echo " ${TEST}/test_cfg.txt testcase cfg file was not found." 
        echo " " 
        exit
    fi
    echo "--------  Simulation start ---------"

    if [ "$2" = "G" ] || [ "$3" = "G" ] 
    then
        vsim -do "do ./2_sim.tcl $1" 
    else
        vsim -c -do "do ./2_sim.tcl $1 ; quit" 
    fi

else
    echo "-------- Compiling & Simulation--------"

    TEST=$1
    if [ -f ${TEST}/test_cfg.txt ]
    then
    	echo "Start Test Simulation ${now}" 
    else
        echo " ${TEST}/test_cfg.txt testcase cfg file was not found." 
        echo " " 
        exit
    fi

    if [ "$2" = "G" ] || [ "$3" = "G" ] 
    then
        vsim -do "../1_script/1_compile.tcl" -do "do ./2_sim.tcl $1" 
    else
        vsim -c -do "../1_script/1_compile.tcl" -c -do "do ./2_sim.tcl $1" -c -do "quit" 
    fi
fi
