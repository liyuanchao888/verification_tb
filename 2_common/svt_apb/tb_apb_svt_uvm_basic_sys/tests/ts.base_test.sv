
`include "apb_base_test.sv"
/**
 * Abstract:
 * This file test runs the default base test without modification
 */

class base_test extends apb_base_test;

  /** UVM Component Utility macro */
  `uvm_component_utils(base_test)

  /** Class Constructor */
  function new(string name = "base_test", uvm_component parent=null);
    super.new(name,parent);
  endfunction: new

virtual task run_phase(svt_phase phase);
  super.run_phase(phase);

  // randomly selected to force X on presetn
  if(cfg.force_x_on_presetn) begin
    #105 force test_top.apb_reset_if.presetn = 1'bx;
    #100 release test_top.apb_reset_if.presetn ;
         test_top.apb_reset_if.presetn = 1'b1;
  end

  // randomly selected to force X on pclk before, during and after reset is de-asserted
  if(cfg.force_x_on_pclk) begin
    #100 force test_top.SystemClock = 1'bx;
    #105 release test_top.SystemClock ;
         test_top.SystemClock = 1'b0;
    wait(test_top.apb_reset_if.presetn === 1'b0);
    #105 force test_top.SystemClock = 1'bx;
    #105 release test_top.SystemClock ;
         test_top.SystemClock = 1'b0;
    wait(test_top.apb_reset_if.presetn === 1'b1);
    #105 force test_top.SystemClock = 1'bx;
    #105 release test_top.SystemClock ;
         test_top.SystemClock = 1'b0;
  end
endtask

endclass
