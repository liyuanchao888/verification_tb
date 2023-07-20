# cfg.sh

## Function:  
自动产生.v 调用顶层及interface 脚本

## Operate:Four steps need to be done as follows:

1. ./cfg.sh [v_file] 
 
 v_file 为需要产生外围调用的.v文件(含路径）
 脚本执行完成后，在脚本当前目录下产生 tmp文件夹（dut_top.sv 和 dut_if.sv）
 
 ## 例子 ：
  ./cfg.sh ../dma/test.v
当脚本运行完后，会产生test.v 的外围调用 和 仿真用的interface
