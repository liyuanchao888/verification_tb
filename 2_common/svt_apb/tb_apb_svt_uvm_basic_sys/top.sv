//=======================================================================
// COPYRIGHT (C) 2010-2017 SYNOPSYS INC.
// This software and the associated documentation are confidential and
// proprietary to Synopsys, Inc. Your use or disclosure of this software
// is subject to the terms and conditions of a written license agreement
// between you, or your company, and Synopsys, Inc. In the event of
// publications, the following notice is applicable:
//
// ALL RIGHTS RESERVED
//
// The entire notice above must be reproduced on all authorized copies.
//
//-----------------------------------------------------------------------

/**
 * Abstract:
 * Top-level SystemVerilog testbench.
 * It instantites the interface and interconnect wrapper.  Clock generation
 * is also  done in the same file.  It includes each test file and initiates
 * the UVM phase manager by calling run_test().
 */
`timescale 1 ns/1 ps

`include "uvm_pkg.sv"

/** Include the APB SVT UVM package */
`include "svt_apb.uvm.pkg"

`include "svt_apb_if.svi"
`include "apb_svt_dut_sv_wrapper.sv"

`include "apb_reset_if.svi"

module test_top;

  /** Parameter defines the clock frequency */
  parameter simulation_cycle = 50;

  /** Signal to generate the clock */
  reg SystemClock;

  /** Import UVM Package */
  import uvm_pkg::*;

  /** Import the SVT UVM Package */
  import svt_uvm_pkg::*;

  /** Import the APB VIP */
  import svt_apb_uvm_pkg::*;

  /** Include all test files */
  `include "top_test.sv"

  /** VIP Interface */
  svt_apb_if apb_dut_master_if();
  assign apb_dut_master_if.pclk = SystemClock;

  /** VIP Interface */
  svt_apb_if apb_dut_slave_if();
  assign apb_dut_slave_if.pclk = SystemClock;

  /** TB Interface instance to provide access to the reset signal */
  apb_reset_if apb_reset_if();
  assign apb_reset_if.pclk = SystemClock;

  /**
   * Assign the reset pin from the reset interface to the reset pins from the VIP
   * interface.
   */
  assign apb_dut_master_if.presetn = apb_reset_if.presetn;
  assign apb_dut_slave_if.presetn = apb_reset_if.presetn;

  /** Interconnect wrapper */
  // -----------------------------------------------------------------------------
  apb_svt_dut_sv_wrapper dut_wrapper (apb_dut_master_if, apb_dut_slave_if);

  /**
   * Optionally dump the sim variable for waveform display
   */
`ifdef WAVES_FSDB
  initial begin
    $fsdbDumpfile("test_top");
    $fsdbDumpvars;
  end
`elsif WAVES_VCD
  initial begin
    $dumpvars;
  end
`elsif WAVES
  initial begin
    $vcdpluson;
  end
`endif
  
  /** Testbench 'System' Clock Generator */
  initial begin
    SystemClock = 0 ;
    forever begin
      #(simulation_cycle/2)
        SystemClock = ~SystemClock ;
    end
  end

  initial begin
    /** Set the reset interface on the virtual sequencer */
    uvm_config_db#(virtual apb_reset_if.apb_reset_modport)::set(uvm_root::get(), "uvm_test_top.env.sequencer", "reset_mp", apb_reset_if.apb_reset_modport);

    /**
     * Provide the APB SV interfaces to the APB System ENV. This step establishes the
     * connection between the APB System ENV and the HDL Interconnect wrapper, through the
     * APB interfaces.
     */
    uvm_config_db#(svt_apb_vif)::set(uvm_root::get(), "uvm_test_top.env.apb_master_env", "vif", apb_dut_master_if);
    uvm_config_db#(svt_apb_vif)::set(uvm_root::get(), "uvm_test_top.env.apb_slave_env", "vif", apb_dut_slave_if);

    /** Start the UVM tests */
    run_test();
  end

endmodule
