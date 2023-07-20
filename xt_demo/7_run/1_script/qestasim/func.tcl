#!/usr/bin/tclsh

proc getConfig {configFile Key {Comment "#"} {Equal "="}} {    
	#过程中如果参数有缺省值，使用花括号引起，并赋值   
  set Value ""                   
  # 记录过程返回的值     
  # 打开配置文件   
  set err [catch {set fileid [open $configFile r+]} errMsg]   
  if {$err == 1} {   
    puts "errMsg : $errMsg"   
    return $Value   
  }   
  # 成功打开文件后, 一行一行的加以分析   
  set rowid 0                       ;#记录当前行数,程序调试时打印调试信息使用的   
  while {[eof $fileid] != 1} {      ;# 读取文件内容   
    incr rowid                      ;# 记录行数, 从一开始   
	gets $fileid line     ;# 读出一行   
    # 先去掉注释, 再去掉两端的空格   
    set commentpos [string first $Comment $line]        ;# 得到注释符号的位置   
    if { $commentpos == 0 } {   
  
      # 行以注释符号开头，忽略掉该行   
    } else {   
       if { $commentpos != -1 } {        ;# 行中有注释符号,去掉注释   
         set line [string range $line 0 [expr $commentpos-1]]   
       }   
       set line [string trim $line]          ;# 去掉两端的空格   
       #puts "test3 $rowid : line : $line"   
       # 如果是空就继续循环   
       if { $line == "" } {   
          continue   
        } else {  
          set equalpos [string first $Equal $line]   ;# 得到等号的位置   
          if { $equalpos != -1} {   
             # 如果就是找寻的key,结束循环   
             if { [string range $line 0 [expr $equalpos - 1]] == $Key } {   
                set Value [string range $line [expr $equalpos + 1] [string length $line]]   
                break   
             }   
          }  
        }   
    }   
  } ;# while   
  # 关闭文件   
  close $fileid   
  
  #返回值  
  return $Value   
} ;#proc end  

#proc find_file{dir_path file_name}{
#    find $dir_path -name "$file_name">dut2.list
#}

  
#set proj_path [getConfig "sim_cfg.ini" "proj_path"]   
#puts "---------val: $proj_path"  
  
#exit  
#expect eof 

#proc varConfig { opt_var } {
#  set opt ""                   
#  lappend opt $opt_var \
#  return $opt
#}


#must set tool and project path 
set tool_path [getConfig "cfg_sim.ini" "tool_path"]   
set proj_path [getConfig "cfg_sim.ini" "proj_path"]   
set runtime   [getConfig "cfg_sim.ini" "runtime"]   
set dut_path  [getConfig "cfg_sim.ini" "dut_path"]   
set tb_path   [getConfig "cfg_sim.ini" "tb_path"]   
echo "--------- tool_path: $tool_path"  
echo "--------- proj_path: $proj_path"  
#puts "---------val: $proj_path" ;#terminal display  
set uvm_libpath $tool_path/verilog_src/uvm-1.1d/src
set sourcepath $proj_path/$dut_path
set coverage_file_path [getConfig "cfg_sim.ini" "coverage_file_path"]   

set current_path [pwd]
set coverage_file_dir $current_path/$coverage_file_path
#------- find cfg variable in cfg_file ------
#------- set dut & tb list -------
set dut_list_opt []
#lappend dut_list_opt \
#-sv \
#+cover=bcesxf \
#-L mtiAvm \
#-L mtiOvm \
#-L mtiUvm \
#-L mtiUPF \
#-work ../2_work \
#-f dut.list

#lappend dut_list_opt \
# -f \
# dut.list

set tb_list_opt []
lappend tb_list_opt \
-sv \
+incdir+$uvm_libpath \
-L mtiAvm \
-L mtiOvm \
-L mtiUvm \
-L mtiUPF \
-work ../2_work \
-f tb.list \

puts " list is $dut_list_opt "
#foreach item $list_comp_opt {
#	puts "list item is $item"
#}

