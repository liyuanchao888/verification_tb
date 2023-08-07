`ifndef TEST_TOP__SV
`define TEST_TOP__SV

//`timescale 1ns/1ns
import uvm_pkg::*;
`include "uvm_macros.svh"

//module clk_rst(output reg clk,output reg rst_n);
//    parameter TIME_PERIOD = 10;	
//    initial begin
//      clk       = 0;
//      rst_n     = 0;
//      #22 rst_n = 1;
//    end
//    always #(TIME_PERIOD/2) clk = !clk; //100Mhz , 10ms(5ms)
//endmodule

`include "axi/typedef.svh"
`include "axi/assign.svh"
//testbench Top
module test_top();
    reg clk  ;
    reg rst_n;

    parameter TIME_PERIOD = 10;	
	initial begin
      clk       = 0;
      rst_n     = 0;
      #22 rst_n = 1;
    end
    always #(TIME_PERIOD/2) clk = !clk; //100Mhz , 10ms(5ms)
    
   // import ahb_apb_bridge_pkg :: *;
//	clk_rst             m_clk_rst(clk,rst_n) ; //clk & reset generator
    cr_top_interface top_if(clk,rst_n);   //interface
    tb_top           TB(top_if);    //testbench top
//	`include         "./dut_top.sv"
	//dut instance //dut_top u_top(.*);  
//    if_sif m_vif_sif0(clk, rst_n); //interface

	axi_xbar_intf #(
    .AXI_USER_WIDTH        ( TbAxiUserWidth  ),
    .Cfg                   ( xbar_cfg        ),
    .rule_t                ( rule_t          )
  ) DUT (
    .clk_i                  ( clk     ),
    .rst_ni                 ( rst_n   ),
    .test_i                 ( 1'b0    ),
    .slv_ports              ( top_if.master  ), //inside the top interface
    .mst_ports              ( top_if.slave   ), //inside the top interface
    .addr_map_i             ( AddrMap ),
    .en_default_mst_port_i  ( '0      ),
    .default_mst_port_i     ( '0      )
  );
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
