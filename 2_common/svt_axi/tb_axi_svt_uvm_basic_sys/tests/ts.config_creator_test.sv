
`include "axi_base_test.sv"
/**
 * Abstract:
 * This file test runs the Config Creator test */

class config_creator_test extends axi_base_test;

  /** UVM Component Utility macro */
  `uvm_component_utils(config_creator_test)

  /** Class Constructor */
  function new(string name = "config_creator_test", uvm_component parent=null);
    super.new(name,parent);
    load_through_config_creator = 1;
  endfunction: new

endclass
