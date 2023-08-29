//=======================================================================
// COPYRIGHT (C) 2017-2020 SYNOPSYS INC.
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

`ifndef GUARD_SVT_AXI_FIFO_RATE_CONTROL
`define GUARD_SVT_AXI_FIFO_RATE_CONTROL
typedef class svt_axi_common;
`include "svt_axi_fifo_rate_control_configuration.sv"
/**
  * Utility class which may be used by agents to model a FIFO based
  * resource class to control the rate at which transactions are sent
  * from a component
  */
class svt_axi_fifo_rate_control extends svt_amba_fifo_rate_control;
  
   // ****************************************************************************
  // Enumerated Types
  // ****************************************************************************

  // ****************************************************************************
  // Local Data
  // ****************************************************************************


  // ****************************************************************************
  // Public Data
  // ****************************************************************************
  /** Handle to common */
  svt_axi_common axi_common;

  // ****************************************************************************
  // Methods
  // ****************************************************************************
  /** Waits for reset to be done */
  extern virtual task wait_for_reset_done();

  /** Steps one clock */
  extern virtual task step_protocol_clock();

  /** Wait until reset transition is observed */
  extern virtual task wait_reset_transition_observed();


`ifdef SVT_VMM_TECHNOLOGY
`ifndef __SVDOC__
  `svt_vmm_data_new(svt_axi_fifo_rate_control)
`endif
 //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new configuration instance, passing the appropriate argument
   * values to the <b>vmm_data</b> parent class.
   *
   * @param log Sets the log file that is used for status output.
   */
  extern function new(vmm_log log = null);
`else
  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new configuration instance, passing the appropriate argument
   * values to the parent class.
   *
   * @param name Instance name of the configuration
   */
  extern function new(string name = "svt_axi_fifo_rate_control");
`endif // !`ifdef SVT_VMM_TECHNOLOGY
  
  // ****************************************************************************
  //   SVT shorthand macros 
  // ****************************************************************************
`ifndef __SVDOC__
  `svt_data_member_begin(svt_axi_fifo_rate_control)
  `svt_data_member_end(svt_axi_fifo_rate_control)
`endif

endclass

//-----------------------------------------------------------------------------
`ifdef SVT_UVM_TECHNOLOGY
  function svt_axi_fifo_rate_control::new(string name ="svt_axi_fifo_rate_control");
    super.new(name);
`elsif SVT_OVM_TECHNOLOGY
  function svt_axi_fifo_rate_control:: new(string name ="svt_axi_fifo_rate_control");
    super.new(name);
`else
  function svt_axi_fifo_rate_control::new(vmm_log log = null);
    static vmm_log slog = new("svt_axi_fifo_rate_control", "class");
    super.new((log == null) ? slog: log,"");
`endif
  endfunction: new

//-----------------------------------------------------------------------------
/** Waits for reset to be done */
task svt_axi_fifo_rate_control::wait_for_reset_done();
  wait(axi_common.is_reset == 1'b0);
endtask

// -----------------------------------------------------------------------------
/** Steps one clock */
task svt_axi_fifo_rate_control::step_protocol_clock();
  axi_common.step_monitor_clock();
endtask

// -----------------------------------------------------------------------------
task svt_axi_fifo_rate_control::wait_reset_transition_observed();
 wait (axi_common.reset_transition_observed == 1);
endtask

// -----------------------------------------------------------------------------
`endif



