#!/usr/bin/bash

#------  option from configuration file -----
CMP_OPT="${SIMULATOR} \
	-full64 \
	+v2k \
	-sverilog \
	+vcs+lic+wait \
    +incdir+${UVM_HOME}/src \
    ${UVM_HOME}/src/uvm_pkg.sv \
	${UVM_HOME}/src/dpi/uvm_dpi.cc \
    -CFLAGS -DVCS \
    +define+UVM_PACKER_MAX_BYTES=1500000 +define+UVM_DISABLE_AUTO_ITEM_RECORDING \
    -timescale=1ns/1ps \
    +define+SVT_FSDB_ENABLE +define+WAVES_FSDB +define+WAVES=\"fsdb\" \
    +plusarg_save -debug_access+all -kdb -debug_region=cell+encrypt -notice \
	-P /tools/synopsys/verdi-R-2020.12-SP1/share/PLI/VCS/LINUX64/novas.tab \
    /tools/synopsys/verdi-R-2020.12-SP1/share/PLI/VCS/LINUX64/pli.a +define+SVT_UVM_TECHNOLOGY \
    +define+SYNOPSYS_SV \
	+incdir+/tools/proj/verification_platform/2_common/axi_vip_snps/design_dir/src/sverilog/vcs \
    +incdir+/tools/proj/verification_platform/2_common/axi_vip_snps/design_dir/include/sverilog \
	+incdir+/tools/proj/verification_platform/2_common/axi_vip_snps/design_dir/examples/sverilog/amba_svt/tb_axi_svt_uvm_basic_sys \
    +incdir+/tools/proj/verification_platform/2_common/axi_vip_snps/design_dir/examples/sverilog/amba_svt/tb_axi_svt_uvm_basic_sys/env \
    +incdir+/tools/proj/verification_platform/2_common/axi_vip_snps/design_dir/examples/sverilog/amba_svt/tb_axi_svt_uvm_basic_sys/hdl_interconnect \
    +incdir+/tools/proj/verification_platform/2_common/axi_vip_snps/design_dir/examples/sverilog/amba_svt/tb_axi_svt_uvm_basic_sys/lib \
    +incdir+/tools/proj/verification_platform/2_common/axi_vip_snps/design_dir/examples/sverilog/amba_svt/tb_axi_svt_uvm_basic_sys/tests \
    +incdir+${TB_PATH}/../1_dut/axi_noc/include \
	+incdir+${TB_PATH}/../1_dut/axi_noc/common_cells/include \
	-assert svaext \
	+incdir+${TB_PATH}/6_top/1_tb_top \
	-F ${DUT_LIST} \
    -F ${TB_LIST} \
    -F ${TC_LIST} \
	-top ${tb_top} \
    "

#------- option from command line ---------
if [ $# == 0 ];then
    echo " compile.sh no self-define para from command line "
else
    CMP_CMD_DEF=$*
    CMP_OPT="${CMP_OPT} ${CMP_CMD_DEF} "
fi

#====== ADD part 1: vcs switch on-off configuration       =======
#---- dump wave  -----
if [ ${wave} = on ]; then
    CMP_OPT="${CMP_OPT} -debug_access+all \
		-debug_region=cell+lib -kdb \
		+vcs+flush+all \
		+define+DUMP_FSDB "
	if [ ${wave_cfg} != off ];then
        CMP_OPT="${CMP_OPT} +define+WAVE_CFG "
	fi
fi

#---- code coverage  -----
[ ${assert} = on ] && CMP_OPT="${CMP_OPT} +define+ASSERT_ON "
[ ${coverage} = on ] && CMP_OPT="${CMP_OPT} \
	-cm line+cond+fsm+tgl+branch+assert \
	-cm_tgl mda -cm_line contassign \
	-cm_dir ${PROJ_WORK_PATH}/cov/simv.vdb \
	+define+COVER_ON "

#---- performance analysis -----
[ ${profile} != off ] && CMP_OPT="${CMP_OPT} \
	-simprofile -Mdir=${PROJ_WORK_PATH}/profile "

#---- xprop  -----
[ ${xprop} != off ] && CMP_OPT="${CMP_OPT} \
	-xprop "

#---- g++  -----
[ ${c_cmp} = on ] && CMP_OPT="${CMP_OPT} \
	-cpp g++ -cc gcc -sysc +define+SYSTEMC_MODEL +define+DEBUG_MODE "

#---- specify output dir  -----
if [ ${output_dir} = on ];then
    mkdir -p ${PROJ_WORK_PATH}/output
fi
[ ${output_dir} = on ] && CMP_OPT="${CMP_OPT} \
	-o ${PROJ_WORK_PATH}/output/simv \
	-Mdir=${PROJ_WORK_PATH}/output/csrc "

#---- init mem  -----
[ ${mem_ini} = one ] && CMP_OPT="${CMP_OPT} +vcs+inimem+random "
[ ${mem_ini} = zero ] && CMP_OPT="${CMP_OPT} +vcs+inimem+random "
[ ${mem_ini} = random ] && CMP_OPT="${CMP_OPT} +vcs+inimem+random "

#---- use lib when post simulation  -----
if [ ${cell} = on ]; then
	if [ ${upf} = on ];then
		CMP_OPT="${CMP_OPT} -f ${CELL_LIB_PWR_PATH} "
    else
		CMP_OPT="${CMP_OPT} -f ${CELL_LIB_PATH} "
	fi
	if [ ${mem_ini} = zero ];then
		CMP_OPT="${CMP_OPT} +define+TSMC_INITIALIZE_MEM_USING_DEFAUT_TASKS +define+TSMC_MEM_LOAD_0 "
	fi
	if [ ${mem_ini} = one ];then
		CMP_OPT="${CMP_OPT} +define+TSMC_INITIALIZE_MEM_USING_DEFAUT_TASKS +define+TSMC_MEM_LOAD_1 "
	fi
	if [ ${mem_ini} = random ];then
		CMP_OPT="${CMP_OPT} +define+TSMC_INITIALIZE_MEM_USING_DEFAUT_TASKS +define+TSMC_MEM_LOAD_RANDOM "
	fi
fi

	CMP_OPT="${CMP_OPT} -l ${PROJ_WORK_PATH}/compile.log "

#mkdir -p ${PROJ_WORK_PATH}/cov ${PROJ_WORK_PATH}/${DEF} ${PROJ_WORK_PATH}/output
echo "compile command final : ${CMP_OPT} "
eval ${CMP_OPT}

