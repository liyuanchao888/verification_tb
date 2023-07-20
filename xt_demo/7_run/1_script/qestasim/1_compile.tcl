#!/usr/bin/tclsh
####### exit last simulation,if exist ######
quit -sim

###################### cfg variable ######################

#------- find cfg variable in cfg_file ------
source func.tcl

#del residue file from last simulation
if { [file exists transcript] == 1 } {
   puts "exist transcript"
   rm -rf wlf* transcript *.xml
   rm -rf work
   rm -rf *.log
}

####################### compile  ######################
if { [file isdirectory ../2_work] } {
   puts "exist ../2_work"
   rm -rf wlf* transcript *.xml
   rm -rf work
   rm -rf *.log
} else {
#	mkdir ../2_work
}
#建立库(建立库的时候会自动新建文件夹）
vlib ../2_work 
#库映射                                           
vmap work ../2_work

puts "vvvvvv vlog $dut_list_opt"
#vlog $dut_list_opt
#vlog $tb_list_opt

vlog -sv +cover=bcesxf -L mtiAvm -L mtiOvm -L mtiUvm -L mtiUPF -work ../2_work -f dut.list
vlog -sv +incdir+$uvm_libpath -L mtiAvm -L mtiOvm -L mtiUvm -L mtiUPF -work ../2_work -f tb.list

#编译工程,编译文件名
#方案1 windows 共享动态库
#g++ -shared -Bsymbolic -o import.dll import.cpp
#vsim -sv_lib import work.tb
#gcc -shared -Bsymbolic -o imports.so imports.c

#方案2 linux 共享输出库
#g++ -c external.cpp -o external.o
#vsim -sv_lib external.o work.tb
#g++ -std=c++11 lowgen.cc
#g++ 4.5版本不支持c++11 ，需要4.8及以上版本g++ 。
#而modelsim 10.4版本是与g++ 4.5版本配套
#===== 查找 rtl 文件 ===========
#glob ../../../../rainman/engine/amba/hdl/*.v

#方案3
#vlog tb.sv import.c
#vsim work.tb
#vsim work.tb -sv_lib import
#find ../ -name "*.v"  > dut.list
#find ../ -name "*.sv" > tb.list

