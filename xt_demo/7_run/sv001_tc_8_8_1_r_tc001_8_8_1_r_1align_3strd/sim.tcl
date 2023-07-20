set runtime 600ns
quit -sim
set current_dir [pwd]

set cfg_f [open $current_dir/$1/test_cfg.txt r]
scan "[read $cfg_f]" "%s" tc_name

#rm -rf ./$1/testcase.log
echo "current testcase dir:$current_dir"
#close $cfg_f
vsim +cfg_file=$current_dir/$1/test_cfg.txt -coverage -i -voptargs=+acc -vopt -uvmcontrol=all -msgmode both -sv_lib $current_dir/../../../2_lib/external -sv_lib $tool_path/uvm-1.1d/win64/uvm_dpi work.top +UVM_OBJECTION_TRACE +UVM_TESTNAME=$tc_name -l ./$1/testcase.log
close $cfg_f

#vsim +cfg_file=$current_dir/$1/test_cfg.txt -coverage -assertdebug -i -voptargs=+acc -vopt -uvmcontrol=all -msgmode both -sv_lib $current_dir/../../../3_lib/external -sv_lib $tool_path/uvm-1.1d/win64/uvm_dpi work.top work.dma_assertion_ip work.dma_binding_module +UVM_OBJECTION_TRACE +UVM_TESTNAME=c_simple_test_dn -l testcase.log
#add wave -h -position insertpoint sim:/top/m_vif_apb/*
#add wave -h -position insertpoint sim:/top/m_vif_sif0/*
add wave -h -position insertpoint sim:/top/m_vif_axi/*
#add wave -position insertpoint sim:/top/dut/dma_write/*

#run $runtime
run -all
wave zoomfull
