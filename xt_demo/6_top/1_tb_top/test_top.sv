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

//testbench Top
import uvm_pkg :: *;
`include "uvm_macros.svh"
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
    
    import ahb_apb_bridge_pkg :: *;

	
//	clk_rst             m_clk_rst(clk,rst_n) ; //clk & reset generator
//    cr_top_if           m_top_if(clk)        ; //interface
//    tb_top              TB(m_top_if)         ; //testbench top
//    top                 u_top(.*);      //dut
   
    ahb_interface  AHB_INF (clk);
    apb_interface  APB_INF (clk);
	ahb2apb		DUT	(
        .HCLK       (clk),
        .HRESETn 	(rst_n),
        .HADDR		(AHB_INF.HADDR),
        .HTRANS	(AHB_INF.HTRANS),
        .HWRITE	(AHB_INF.HWRITE),
        .HWDATA	(AHB_INF.HWDATA),
        .HSELAHB	(AHB_INF.HSELAHB),
        
        .HRDATA	(AHB_INF.HRDATA),
        .HREADY	(AHB_INF.HREADY),
        .HRESP		(AHB_INF.HRESP),
        
        .PRDATA	(APB_INF.PRDATA),
        .PSLVERR	(APB_INF.PSLVERR),
        .PREADY	(APB_INF.PREADY),
        
        .PWDATA	(APB_INF.PWDATA),
        .PENABLE	(APB_INF.PENABLE),
        .PSELx		(APB_INF.PSELx),
        .PADDR		(APB_INF.PADDR),
        .PWRITE	(APB_INF.PWRITE)
    );

//    if_apb m_vif_apb(clk, rst_n); //interface
//    if_axi m_vif_axi(clk, rst_n); //interface
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

    initial begin
//        `uvm_info (get_type_name(), $sformatf(" top start =%0d",dma_width), UVM_NONE);
//        uvm_config_db#(virtual if_apb)::set(uvm_root::get(), "*.m_env.m_agt_apb", "m_vif_apb", m_vif_apb);
        uvm_config_db # (virtual ahb_interface) :: set(null,"*","ahb_vif",AHB_INF);
		uvm_config_db # (virtual apb_interface) :: set(null,"*","apb_vif",APB_INF);

        run_test();//uvm_testcase=c_simple_test_rw.sv
    end
endmodule

`endif //TOP__SV
