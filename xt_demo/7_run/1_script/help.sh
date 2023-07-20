#!/bin/bash
function help()
{
echo "**************** HELP INFO ***************"
echo "usage:"
echo "make [opt]"
echo ""
echo "[opt]:"
echo "  help       : default ,display option, how to use the script"
echo "  run        : will run all include get_dutlist,gen_run,comp,sim"
echo "  get_list   : get dut list"
echo "  gen_run    : generate run script command"
echo "  comp       : compile"
echo "  sim        : simulation"
echo "  verdi      : wave view"
echo "  report     : report all testcase html report"
echo "  urg        : merge file of coverage info"
echo "  cov        : view file of coverage info"
echo "  clean      : clean temp file"
echo ""
echo "example:"
echo "  if want to run all in ut/it testbench , enter 'make run tc=tc_relu' in terminal "
}
help
