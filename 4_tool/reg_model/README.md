# C_reg_model_generation_automatic

## Function:  
Generate relative registers *.sv file for different RTL dut

## Operate:Four steps need to be done as follows:

1. use MobaXterm terminal tool,enter the path : */corerain/rainman/verification/4_tools/reg_model

2. excute this command:
$python gen_uvm <your *.json file>

For example,#python gen_uvm con_regs.json,you will get three files generated("c_reg_model.sv","con_regs.html","con_regs.ral")
but we just want "c_reg_model.sv".

3. put the "c_reg_model.sv" file to this path : */corerain/rainman_design/rainman/verification/your*_ut/1_stimulus/2_register_model

4. modify the c_cpu_op.sv in the path above,build the relation between those registers in c_reg_model.sv and configuration file.


