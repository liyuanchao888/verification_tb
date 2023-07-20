#!/usr/bin/tclsh
quit -sim

if { [file exist $1/testcase.log] } {
	rm -rf $1/testcase.log
#	open $1/testcase.log w+
#	close $1/testcase.log
}
source func.tcl
#must set tool and project path 
set cfg_f [open $current_path/$1/test_cfg.txt r]
scan "[read $cfg_f]" "%s" tc_name
set testcase [file tail $1]
echo "current_path : $current_path"
echo "testcase     : $testcase"

vsim +cfg_file=$current_path/$1/test_cfg.txt -wlf $current_path/$1/$testcase.wl -coverage -i -voptargs=+acc -vopt -uvmcontrol=all -msgmode both -sv_lib $tool_path/uvm-1.1d/linux_x86_64/uvm_dpi work.top +UVM_OBJECTION_TRAC +UVM_TESTNAME=$tc_name -l $current_path/$1/testcase.log -onfinish stop

close $cfg_f

add wave -h -position insertpoint sim:/top/m_vif_axi/*

#run $runtime
run -all
wave zoomfull

#------------- coverage file ------------------
if { [file isdirectory $coverage_file_dir] } {
	echo "exist coverage_file_dir : $coverage_file_dir"
} else {
	mkdir $coverage_file_dir
}
if { [ file exist $coverage_file_dir/$testcase.txt ] } {
	echo "exist coverage_testcase : $testcase.txt"
    rm -rf $coverage_file_dir/$testcase.txt 
}
if { [ file exist $coverage_file_dir/$testcase.ucdb ] } {
	echo "exist coverage_testcase : $testcase.ucdb"
    rm -rf $coverage_file_dir/$testcase.ucdb 
}
coverage report -file $coverage_file_dir/$testcase.txt 
coverage save -codeALL $coverage_file_dir/$testcase.ucdb
