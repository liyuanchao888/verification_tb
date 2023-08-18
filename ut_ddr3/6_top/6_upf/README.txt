coverage 
function:
    test dma read or write
operate:
    dma_ut verification platform user guide
    There are three steps need to be operated as follows:
    1.Create one project file on local PC,such as named work,and the path is D:\work\modelsim\push_rainman\rainman\verification
    2.Configure related path respectively
      1)enter that directory #D:\work\modelsim\push_rainman\rainman\verification\dma_ut\8_testcase\1_script
      2)modify the project and tool path which need meets the actual path,such as
        set proj_path D:/work/modelsim/push_rainman/rainman/verification
        set tool_path D:/modelsim/modelsim104
      3)modify run.bat path,right click to edit the path,such as
         cd D:\work\modelsim\push_rainman\rainman\verification\dma_ut\8_testcase\1_script\
    3.Double click and run the run.bat file,enter the modelsim windows,and excute two commands in the Transcript command box:
      1)#do 1_compile.tcl
      2)#do 2_sim.tcl ../sv001_testcase_*
      3)wait
      
    
      
