//////////////////////////////////////////////////////////////////////////
// (c) 2013 Mobiveil Inc.
//
//  File        : clk_rst_agent_config.svh
//  Project     : UMMC
//  Purpose     :
//
//  Created on  : Tue Jul 23 13:09:20 UTC 2013
//
//
//////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////


`ifndef clk_rst_agent_config_svh
`define clk_rst_agent_config_svh

class clk_rst_agent_config extends uvm_object;

  `uvm_object_utils (clk_rst_agent_config)

  // Data Members
  // time in picoseconds before clock becomes stable after por is de-asserted 
  rand int  mclk_stable_delay;
  // time in picoseconds for reset to be de-asserted after por is asserted
  rand int  mrst_deassert_delay;
  // time in picoseconds for por to be asserted 
  rand int  mrst_assert_delay;
  // clk-jitter enable or disable  
  rand bit  mjitter;
  // clk period in picoseconds 
  rand int  mclk_period;
  // duty cycle in percentage 
  rand int  mclk_duty_cycle;


  // pclk in picoseconds
  rand int  pclk_stable_delay;
  rand int  prst_deassert_delay;
  rand int  prst_assert_delay;
  rand bit  pjitter;
  // clk period in picoseconds 
  rand int  pclk_period;
  // in percentage integer
  rand int  pclk_duty_cycle;

  // clk_delays
  rand int mc_axi_clk_delay;
  rand int axi_mc_clk_delay;

  // control parameters
  // disable mclk - will be driven to the last good value
  bit  disable_mclk		= 1'b0;
  // assert mrst - keep the mrst-asserted till this is lifted
  bit  assert_mrst		= 1'b0;
  // disable pclk - will be driven to last good value
  bit  disable_pclk		= 1'b0;
  // assert pclk - will keep prst-asserted till this is lifted 
  bit  assert_prst		= 1'b0;
  // drive highz on the mclk, works only with combination of disable_mclk
  bit  highz_mclk		= 1'b0;
  // drive highz on the pclk, works only with combination of disable_pclk
  bit  highz_pclk		= 1'b0;
  // drive highz on mrst - can be asserted any time 
  bit  highz_mrst		= 1'b0;
  // drive highz on prst - can be asserted any time 
  bit  highz_prst		= 1'b0;
  bit disable_ddrclk            = 1'b0;
  int dfi_clk_period;         
  int cpu_clk_period;         

  // assertion of this and de-assertion of highz_mrst will trigger a POR
  // sequence
  // parameters of delay control the delay of assertion - users can change on
  // the fly, else the previous values are re-used
  bit  restart_mrst_seq;
  bit  restart_prst_seq;
  // it will control the assertion of reset when frequency change is introduced.
  bit  no_reset			= 1'b0;

  // Component Members
  virtual clk_rst_intf clk_rst_vif;

  // constraints

  constraint mc_axi_clk_delay_c{
    mc_axi_clk_delay inside {[1:1500]};}
  constraint axi_mc_clk_delay_c{
    axi_mc_clk_delay inside {[1:1500]};}

  constraint mrst_assert_delay_c {
    mrst_assert_delay inside {[1000:3000]};
  }
  constraint mrst_deassert_delay_c {
    mrst_deassert_delay == 1500000; //inside {[500:3000]};
  }
  constraint mclk_stable_delay_c {
    mclk_stable_delay inside {[100:500]};
  }
  constraint mclk_duty_cycle_c {
    mclk_duty_cycle == 50; //inside {[45:55]}; Temp comment due to avery issue.
  }
  constraint prst_assert_delay_c {
    prst_assert_delay inside {[1000:3000]};
  }
  constraint prst_deassert_delay_c {
    prst_deassert_delay inside {[500:3000]};
  }
  constraint pclk_stable_delay_c {
    pclk_stable_delay inside {[100:500]};
  }
  //constraint pclk_period_c {
  //  pclk_period inside {[2000:8000]};
  //}
  constraint pclk_duty_cycle_c {
    pclk_duty_cycle inside {[45:55]};
  }



  function new (string name = "clk_rst_agent_config");
    super.new (name);
  endfunction : new

  function void do_print (uvm_printer printer);
    super.do_print (printer);
    printer.print_generic ("mrst_assert_delay", "time", 32, $sformatf("%0dps", mrst_assert_delay)); 
    printer.print_generic ("mrst_deassert_delay", "time", 32, $sformatf("%0dps", mrst_deassert_delay)); 
    printer.print_generic ("mclk_stable_delay", "time", 32, $sformatf("%0dps", mclk_stable_delay)); 
    printer.print_generic ("mclk_period", "time", 32, $sformatf("%0dps", mclk_period)); 
    printer.print_generic ("mclk_duty_cycle", "percentage", 32, $sformatf("%0d", mclk_duty_cycle)); 
    printer.print_generic ("prst_assert_delay", "time", 32, $sformatf("%0dps", prst_assert_delay)); 
    printer.print_generic ("prst_deassert_delay", "time", 32, $sformatf("%0dps", prst_deassert_delay)); 
    printer.print_generic ("pclk_stable_delay", "time", 32, $sformatf("%0dps", pclk_stable_delay)); 
    printer.print_generic ("pclk_period", "time", 32, $sformatf("%0dps", pclk_period)); 
    printer.print_generic ("pclk_duty_cycle", "percentage", 32, $sformatf("%0d", pclk_duty_cycle)); 
  endfunction 

endclass : clk_rst_agent_config

`endif /* clk_rst_agent_config_svh */


