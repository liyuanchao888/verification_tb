 # user guide
 ## TB function:
    verification testbench for chip

 ## run TB example
    
	#cd 7_run/1_script
	#make
     
 ## operate:  
 **There are three steps need to be operated as follows:**
    
   1. DUT folder

    put RTL code and filelist in 1_dut
    #cd 1_dut
	#git clone rtl_xx
    
   2. new ut/it/st testbench enviroment fellow the directory structure of the xt_demo folder
    
	#cp -r xt_demo it_ddr


   3. modify the new testbench to verify the dut

    #vim 7_run/1_script/README.md


## TB目录结构
	1_dut（含RTL/门级filelist）
	2_common
		公用文件 : 特定的VIP（cr interface vip)
			cr_apb_vip
			snps_axi_vip
				axi.list/env.sv/readme
				c_agt_axi.sv/c_drv_axi.sv/c_mon_axi.sv
c_seq_axi.sv/c_sqr_axi.sv/c_cfg_axi.sv/c_trans_axi.sv
			credit_vip
			sif_vip
		公用文件 : 转换接口 apb2ahb
	3_lib
		公用库文件eg: svdpi.h
	4_tool
		gen_dut_top_if
		reg_model
		soc_gen_reg
	5_model
	xt_demo
（UT/IT/ST使用此目录结构）
		1_stimu
			1_transaction
			2_reg_model
			3_seq
			4_sqr
			5_random_engine
				transaction_random_cfg
		2_bfm
			1_interface
			2_drv
			3_mon
			4_agt
		3_rm
			sv/c/sc_model
		4_scb
		5_env
			env/env_config
		6_top
			1_tb_top
			2_base_test（含tc.list和regression_tc）
			3_cpu_sw（整个CPU软件环境，含c case,编译环境，产生的bin文件）
			4_cover（语句/功能覆盖）
			5_assert
			6_upf（功耗仿真）
			7_sdf(含有deposit/sdf 等文件):w

		7_run
			1_script
			2_work(default)
			xx_work
		8_reuse
（向上集成时使用）
			1.file_list: include file/import pkg （含instantiation:  declare/build file）
			2_cfg
				ini（集成相关的配置）
			3_tc
				testcase(仅调用seq.start , 各个patern 由 seq 封装的task产生)
				example_testcase(base的testcase ， 用于引导其他人进行合入）
	ut_xxx(来源于xt_demo)
	ut_yyy(来源于xt_demo)
	it_xxx(来源于xt_demo)
	it_yyy(来源于xt_demo)
	st_soc(来源于xt_demo)

	xt_demo    : apb2ahb  + uvm env
	ut_axi     : axi      + uvm axi(M+S)  
	ut_noc_sv  : axi_xbar + sv  axi(M+S)  ( axi_xbar initial tc for test address )
	ut_noc     : axi_xbar + svt_axi_uvm(M+S)
    ut_ddr3_sv : ddr3     + sv cpu_wr/rd (initial )
    ut_ddr3    : ddr3+axi + svt_axi_uvm(M) 

