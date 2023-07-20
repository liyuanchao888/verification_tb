#########################################################################
# File Name: gen_dut_top_if.sh
# Author: lyc_17
# mail: yuanchao.li@corerain.com
# Created Time: Thu 20 Dec 2018 10:26:47 PM EST
#########################################################################
#!/bin/bash
if [ "$#" -lt "1" ] || [ "$1" = "h" ] || [ "$1" = "H" ]
then
    echo "                                                                                " 
    echo " ================ config testcase ==================                            " 
    echo "                                                                                " 
    echo " Usage:                                                                         " 
    echo "           ./cfg.sh <top.v>                                                     " 
    echo "                                                                                " 
    echo " [opt]:                                                                         " 
	echo " dut_top_file     -- DUT top file (dir+name)                                    " 
    echo "                                                                                " 
    echo " example:                                                                       " 
    echo "       ./cfg.sh ../2_dut/adapt.v                                                "          
	echo "       # generate dut.list ; ./tmp/dut_if.sv and ./tmp/dut_top.sv for testbench " 
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
dut_if=./tmp/dut_if.sv
dut_top=./tmp/dut_top.sv

if [ ! -d "./tmp" ];  
then
   mkdir "./tmp \n"
else 
   echo "exist ./tmp \n"
fi

echo "top dut(" > ${dut_top}
grep "^input \|^output \|^inout \| input \| output \| inout " $1 > ${dut_if}

#del null line and comment line
grep -v '^$' ${dut_if}>tmp_dut_if
grep -v '^//' tmp_dut_if>${dut_if}
sed -i 's/,//g' ${dut_if}
#del signal ","  add ":"

#del comment part
sed -i 's/\/\/.*$//g' ${dut_if}

# generat call top
while read line
do
	ta=$(echo ${line} | awk '{print $(NF)}')
	sed -i '$a\'.${ta}' \('${ta}'\)\,' ${dut_top}
	#echo ${line} | awk '{print $(NF)}' >> tmp 
done < ${dut_if}
# modify the last line
sed -i '$s/,//g' ${dut_top}
# add one more line at last
sed -i '$a\);' ${dut_top}

# generate dut_interface file
#add ";"
#sed -i 's/,/;/g' ${dut_if}
sed -i 's/$/&;/g' ${dut_if}
sed -i 's/input /logic /g' ${dut_if}
sed -i 's/output /logic  /g' ${dut_if}
sed -i 's/inout /logic /g' ${dut_if}
sed -i 's/reg /    /g' ${dut_if}
sed -i 's/wire /     /g' ${dut_if}
#add model
sed -i '1i\`ifndef DUT_IF_SV' ${dut_if}
sed -i '2i\`define DUT_IF_SV' ${dut_if}
sed -i '3i\`timescale 1ns / 1ps' ${dut_if}
sed -i '4i\interface dut_if();' ${dut_if}
sed -i '5i\ ' ${dut_if}
sed -i '$a\ ' ${dut_if}
sed -i '$a\endinterface' ${dut_if}
sed -i '$a\`endif // DUT_IF_SV' ${dut_if}

#for line in `cat ${dut_if}`

#./func.tcl

chmod 777 ${dut_if}
chmod 777 ${dut_top}


rm tmp_dut_if

DUT_FILE=$(echo $1|awk -F "/" '{print $NF}')
now=$(date)

echo -e " dut_top    : ${DUT_FILE}  \n "
echo -e " generate dut_if : ${dut_if}    \n "
echo -e " generate dut_top: ${dut_top}   \n "
#if [ -d ${REPORT} ]; #if has ./report
#then
#  #  rmdir ${REPORT} 
#  #  mkdir ${REPORT} 
#    echo -e " has ${REPORT" 
#else
#    mkdir ${REPORT} 
#fi

