####################################################
# Copyright 2023 
# version:  v1.0.0
# verification platform compatible UT/IT/ST(Unit/Integrate/SOC) 
####################################################
MAKE                            = make
MAKE_PATH                      := $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))
#---- workspace  ----
export VP_PATH                 ?= $(abspath $(MAKE_PATH)/../../..)
export TB_PATH                 ?= $(abspath $(MAKE_PATH)/../../)

#---------- config : variable info & vcs switch on-off------------
include ${TB_PATH}/7_run/1_script/0_config/cfg_base_var.ini
include ${TB_PATH}/7_run/1_script/0_config/cfg_base_vcs.ini
#---------- call shell script to execute ------------
include ${TB_PATH}/7_run/1_script/common.mk

#reserved for cpu software Makefile
#include $(TB_PATH)/6_top/3_cpu_sw/cpu_xx.mk

