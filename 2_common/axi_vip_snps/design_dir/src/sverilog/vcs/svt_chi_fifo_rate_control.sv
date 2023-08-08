//=======================================================================
// COPYRIGHT (C) 2020 SYNOPSYS INC.
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

`ifndef GUARD_SVT_CHI_FIFO_RATE_CONTROL
`define GUARD_SVT_CHI_FIFO_RATE_CONTROL
typedef class svt_chi_protocol_common;
/**
  * Utility class which may be used by agents to model a FIFO based
  * resource class to control the rate at which transactions are sent
  * from a component
  */
class svt_chi_fifo_rate_control extends svt_amba_fifo_rate_control;
  
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
  svt_chi_protocol_common chi_common;

  // ****************************************************************************
  // Methods
  // ****************************************************************************

`ifdef SVT_VMM_TECHNOLOGY
`ifndef __SVDOC__
  `svt_vmm_data_new(svt_chi_fifo_rate_control)
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
  extern function new(string name = "svt_chi_fifo_rate_control");
`endif // !`ifdef SVT_VMM_TECHNOLOGY
  
  /** Waits for reset to be done */
  extern virtual task wait_for_reset_done();

  /** Steps one clock */
  extern virtual task step_protocol_clock();

  /** Wait until reset transition is observed */
  extern virtual task wait_reset_transition_observed();


  // ****************************************************************************
  //   SVT shorthand macros 
  // ****************************************************************************
`ifndef __SVDOC__
  `svt_data_member_begin(svt_chi_fifo_rate_control)
  `svt_data_member_end(svt_chi_fifo_rate_control)
`endif

endclass

//-----------------------------------------------------------------------------
`ifdef SVT_UVM_TECHNOLOGY
  function svt_chi_fifo_rate_control::new(string name ="svt_chi_fifo_rate_control");
    super.new(name);
`elsif SVT_OVM_TECHNOLOGY
  function svt_chi_fifo_rate_control:: new(string name ="svt_chi_fifo_rate_control");
    super.new(name);
`else
  function svt_chi_fifo_rate_control::new(vmm_log log = null);
    static vmm_log slog = new("svt_chi_fifo_rate_control", "class");
    super.new((log == null) ? slog: log,"");
`endif
  endfunction: new

//-----------------------------------------------------------------------------

/** Waits for reset to be done */
task svt_chi_fifo_rate_control::wait_for_reset_done();
  wait (chi_common.shared_status.is_reset_active == 0);
endtask

// -----------------------------------------------------------------------------
/** Steps one clock */
task svt_chi_fifo_rate_control::step_protocol_clock();
  chi_common.advance_clock();
endtask

// -----------------------------------------------------------------------------
task svt_chi_fifo_rate_control::wait_reset_transition_observed();
 wait (chi_common.shared_status.reset_transition_observed == 1);
endtask

//-----------------------------------------------------------------------------
/*task svt_chi_fifo_rate_control::update_fifo_levels_every_clock();
  fork
  begin
    wait (chi_common.shared_status.reset_transition_observed == 1);
    while (1) begin
      wait(chi_common.shared_status.is_reset_active == 1'b0);
      chi_common.advance_clock();
      fifo_sema.get();
      if (fifo_cfg.fifo_type == svt_fifo_rate_control_configuration::READ_TYPE_FIFO) begin
        if (this.fifo_curr_fill_level > fifo_cfg.rate)
          this.fifo_curr_fill_level =  this.fifo_curr_fill_level - fifo_cfg.rate;
        else
          this.fifo_curr_fill_level = 0;
      end
      else begin
        int next_fill_level = this.fifo_curr_fill_level + fifo_cfg.rate;
        if (next_fill_level < fifo_cfg.full_level)
          this.fifo_curr_fill_level = next_fill_level;
        else
          this.fifo_curr_fill_level = fifo_cfg.full_level;
      end
      fifo_sema.put();
    end
  end
  join_none
endtask
*/
//-----------------------------------------------------------------------------
`endif



