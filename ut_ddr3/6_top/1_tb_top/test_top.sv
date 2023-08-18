`ifndef TEST_TOP__SV
`define TEST_TOP__SV

//`timescale 1ns/1ns
`include "tb_define.svh"

//testbench Top
module test_top();
   `include "simulation.vh"
   `CLOCK_GEN(clk,10) // cycle=10 (if time unit is 1ns , freq=100Mhz)
   `RESET_N_GEN(rst_n,1000) //after delay=1000 , rst_n release from 0 to 1 
    cr_top_interface top_if(clk,rst_n);   //interface
    tb_top           TB(top_if);    //testbench top
//	`include "dut_top.sv"

	
top dut_ddr3_system
(
    .clk100mhz       ( clk             ) //input                   
    ,.rst_n          ( rst_n           ) //input                   
    ,.axi4_awvalid_w ( top_if.axi_if.master_if[0].awvalid )   //input                   
    ,.axi4_awaddr_w  ( top_if.axi_if.master_if[0].awaddr  )   //input  [ 31:0]          
    ,.axi4_awid_w    ( top_if.axi_if.master_if[0].awid    )   //input  [  3:0]          
    ,.axi4_awlen_w   ( top_if.axi_if.master_if[0].awlen   )   //input  [  7:0]          
    ,.axi4_wvalid_w  ( top_if.axi_if.master_if[0].wvalid  )   //input                   
    ,.axi4_awburst_w ( top_if.axi_if.master_if[0].awburst )   //input  [  1:0]          
    ,.axi4_wdata_w   ( top_if.axi_if.master_if[0].wdata   )   //input  [ 31:0]          
    ,.axi4_wstrb_w   ( top_if.axi_if.master_if[0].wstrb   )   //input  [  3:0]          
    ,.axi4_wlast_w   ( top_if.axi_if.master_if[0].wlast   )   //input                   
    ,.axi4_bready_w  ( top_if.axi_if.master_if[0].bready  )   //input                   
    ,.axi4_arlen_w   ( top_if.axi_if.master_if[0].arlen   )   //input  [  7:0]          
    ,.axi4_araddr_w  ( top_if.axi_if.master_if[0].araddr  )   //input  [ 31:0]          
    ,.axi4_arburst_w ( top_if.axi_if.master_if[0].arburst )   //input  [  1:0]          
    ,.axi4_arvalid_w ( top_if.axi_if.master_if[0].arvalid )   //input                   
    ,.axi4_arid_w    ( top_if.axi_if.master_if[0].arid    )   //input  [  3:0]          
    ,.axi4_rready_w  ( top_if.axi_if.master_if[0].rready  )   //input                   
    ,.axi4_bid_w     ( top_if.axi_if.master_if[0].bid     )   //output  [  3:0]         
    ,.axi4_awready_w ( top_if.axi_if.master_if[0].awready )   //output                  
    ,.axi4_arready_w ( top_if.axi_if.master_if[0].arready )   //output                  
    ,.axi4_bresp_w   ( top_if.axi_if.master_if[0].bresp   )   //output  [  1:0]         
    ,.axi4_rdata_w   ( top_if.axi_if.master_if[0].rdata   )   //output  [ 31:0]         
    ,.axi4_rlast_w   ( top_if.axi_if.master_if[0].rlast   )   //output                  
    ,.axi4_rid_w     ( top_if.axi_if.master_if[0].rid     )   //output  [  3:0]         
    ,.axi4_rresp_w   ( top_if.axi_if.master_if[0].rresp   )   //output  [  1:0]         
    ,.axi4_bvalid_w  ( top_if.axi_if.master_if[0].bvalid  )   //output                  
    ,.axi4_wready_w  ( top_if.axi_if.master_if[0].wready  )   //output                  
    ,.axi4_rvalid_w  ( top_if.axi_if.master_if[0].rvalid  )   //output                  
     //// DDR3 SDRAM
    ,.ddr3_reset_n   (top_if.m_mem_if.ddr3_reset_n_w) //output  wire            
    ,.ddr3_ck_p      (top_if.m_mem_if.ddr3_ck_p_w   ) //output  wire    [0:0]   
    ,.ddr3_ck_n      (top_if.m_mem_if.ddr3_ck_n_w   ) //output  wire    [0:0]   
    ,.ddr3_cke       (top_if.m_mem_if.ddr3_cke_w    ) //output  wire    [0:0]   
    ,.ddr3_cs_n      (top_if.m_mem_if.ddr3_cs_n_w   ) //output  wire    [0:0]   
    ,.ddr3_ras_n     (top_if.m_mem_if.ddr3_ras_n_w  ) //output  wire            
    ,.ddr3_cas_n     (top_if.m_mem_if.ddr3_cas_n_w  ) //output  wire            
    ,.ddr3_we_n      (top_if.m_mem_if.ddr3_we_n_w   ) //output  wire            
    ,.ddr3_dm        (top_if.m_mem_if.ddr3_dm_w     ) //output  wire    [1:0]   
    ,.ddr3_ba        (top_if.m_mem_if.ddr3_ba_w     ) //output  wire    [2:0]   
    ,.ddr3_addr      (top_if.m_mem_if.ddr3_addr_w   ) //output  wire    [13:0]  
    ,.ddr3_odt       (top_if.m_mem_if.ddr3_odt_w    ) //output  wire    [0:0]   
    ,.ddr3_dqs_p     (top_if.m_mem_if.ddr3_dqs_p_w  ) //inout   wire    [1:0]   
    ,.ddr3_dqs_n     (top_if.m_mem_if.ddr3_dqs_n_w  ) //inout   wire    [1:0]   
    ,.ddr3_dq        (top_if.m_mem_if.ddr3_dq_w     ) //inout   wire    [15:0]  
);


ddr3
u_ram
(
     .rst_n   ( top_if.m_mem_if.ddr3_reset_n_w )
    ,.ck      ( top_if.m_mem_if.ddr3_ck_p_w    )
    ,.ck_n    ( top_if.m_mem_if.ddr3_ck_n_w    )
    ,.cke     ( top_if.m_mem_if.ddr3_cke_w     )
    ,.cs_n    ( top_if.m_mem_if.ddr3_cs_n_w    )
    ,.ras_n   ( top_if.m_mem_if.ddr3_ras_n_w   )
    ,.cas_n   ( top_if.m_mem_if.ddr3_cas_n_w   )
    ,.we_n    ( top_if.m_mem_if.ddr3_we_n_w    )
    ,.dm_tdqs ( top_if.m_mem_if.ddr3_dm_w      )
    ,.ba      ( top_if.m_mem_if.ddr3_ba_w      )
    ,.addr    ( top_if.m_mem_if.ddr3_addr_w    )
    ,.odt     ( top_if.m_mem_if.ddr3_odt_w     )
    ,.dqs     ( top_if.m_mem_if.ddr3_dqs_p_w   )
    ,.dqs_n   ( top_if.m_mem_if.ddr3_dqs_n_w   )
    ,.dq      ( top_if.m_mem_if.ddr3_dq_w      )
    ,.tdqs_n  (                              )

);
	
	
	
	//dut instance //dut_top u_top(.*);  
//    if_sif m_vif_sif0(clk, rst_n); //interface

//lowpower upf
//    supply1 CR_VDD;
//    supply0 CR_VSS;
    initial begin
	    string f;
        `ifdef INCA
            $recordvars();
        `elsif QUESTA
            $wlfdumpvars();
            set_config_int("*", "recording_detail", 1);
        `else  //if no assign simulator , will use the VCS as default
            `ifdef DUMP_FSDB
			    `ifndef WAVE_CFG
        		    $value$plusargs("fsdbfile=%s",f);
					`ifndef PLL_WAVE_ON
//					    $fsdbSuppress(test_top.top.u_prcm.u_prcm_pll); //no dump pll to accelerate sim
				    `endif
					$fsdbDumpfile(f);
					$fsdbDumpvars;
					$fsdbDumpMDA;
                    `ifdef CR_UPF_ON
				        $fsdbDumpvars("+power")
					`endif
				`endif
    		`elsif DUMP_VCD
			    $vcdpluson;
			`endif
        `endif
    end

endmodule

`endif //TOP__SV
