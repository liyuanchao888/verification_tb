//--------------------------------------------------------------------------
// COPYRIGHT (C) 2013-2016 SYNOPSYS INC.
// This software and the associated documentation are confidential and
// proprietary to Synopsys, Inc. Your use or disclosure of this software
// is subject to the terms and conditions of a written license agreement
// between you, or your company, and Synopsys, Inc. In the event of
// publications, the following notice is applicable:
//
// ALL RIGHTS RESERVED
//
// The entire notice above must be reproduced on all authorized copies.
//--------------------------------------------------------------------------

`ifndef GUARD_SVT_CHI_LINK_RXLA_FSM_SV
`define GUARD_SVT_CHI_LINK_RXLA_FSM_SV

typedef class svt_chi_link_rxla_fsm;
// typedef class svt_chi_link_rxla_fsm_def_cov_data_callback;

// =============================================================================
/**
 * Class implementing the RXLA state machine RXLA_STOP state.
 */
class svt_chi_link_rxla_stop_state extends svt_fsm_state#(svt_chi_link_rxla_fsm, "Stop");
  `svt_fsm_state_utils(svt_chi_link_rxla_stop_state)

  /** Define the 'from' states. */
  `svt_fsm_from_states('{p_fsm.rxla_deactivate_state})

  /** Watch for the action that initiates a transition into the state. */
  virtual task state_transition(svt_fsm_state_base from_state, output bit ok);
    ok = 1;

    if (p_fsm.common == null)
      begin
        `svt_error("state_transition", "Link common is null.");
        ok = 0;
      end
    else if (from_state == p_fsm.rxla_deactivate_state)
      begin
        p_fsm.common.rxla_state_transition(p_fsm.fsm_state_to_rxla_state(from_state), 
                                           svt_chi_link_common::RXLA_STOP_STATE, ok);
      end
    else
      begin
        `svt_error("state_transition", $sformatf("Called for an unsupported from_state, %0s. Ignoring.", from_state.get_name()));
        ok = 0;
      end

    if (ok)
      begin
        // Store away the previous state.
        p_fsm.prev_state = from_state;
      end 
  endtask

  /** Implementation of the state action. */
  virtual task body();
    //`svt_debug("body","The RXLA state machine is in the RXLA_STOP state.");
    
    // The link is only active when both the TX and RX state machines are in the RUN state.
    p_fsm.common.shared_status.is_link_active = 0;
    
    // In the RXLA_STOP state, the receiver can neither transmit L-credits nor receive flits.
    p_fsm.common.rxla_can_xmit_lcrds = 0;
    p_fsm.common.rxla_can_xmit_snp_lcrds = 0;
    p_fsm.common.rxla_can_xmit_rsp_lcrds = 0;
    p_fsm.common.rxla_can_xmit_dat_lcrds = 0;
    p_fsm.common.rxla_can_receive_flits = 0;
  
    p_fsm.set_rxla_state(this);
    -> p_fsm.state_changed;
    -> p_fsm.entered_stop;
  endtask
  
  /** Return the name to use to represent the state's object type in the XML output. */
  virtual function string get_xml_name();
    return "svt_chi_link_fsm_stop_state";
  endfunction

endclass

// =============================================================================
/**
 * Class implementing the RXLA state machine RXLA_ACTIVATE state.
 */
class svt_chi_link_rxla_activate_state extends svt_fsm_state#(svt_chi_link_rxla_fsm, "Activate");
  `svt_fsm_state_utils(svt_chi_link_rxla_activate_state)

  /** Define the 'from' states. */
  `svt_fsm_from_states('{p_fsm.rxla_stop_state})

  /** Watch for the action that initiates a transition into the state. */
  virtual task state_transition(svt_fsm_state_base from_state, output bit ok);
    ok = 1;

    if (p_fsm.common == null)
      begin
        `svt_error("state_transition", "Link common is null.");
        ok = 0;
      end
    else if (from_state == p_fsm.rxla_stop_state)
      begin
        p_fsm.common.rxla_state_transition(p_fsm.fsm_state_to_rxla_state(from_state), 
                                           svt_chi_link_common::RXLA_ACTIVATE_STATE, ok);
      end
    else
      begin
        `svt_error("state_transition", $sformatf("Called for an unsupported from_state, %0s. Ignoring.", from_state.get_name()));
        ok = 0;
      end

    if (ok)
      begin
        // Store away the previous state.
        p_fsm.prev_state = from_state;
      end 
  endtask

  /** Implementation of the state action. */
  virtual task body();
    //`svt_debug("body","The RXLA state machine is in the RXLA_ACTIVATE state.");
    
    // The link is only active when both the TX and RX state machines are in the RUN state.
    p_fsm.common.shared_status.is_link_active = 0;
    
    // In the RXLA_ACTIVATE state, the receiver can neither transmit L-credits nor receive flits.
    p_fsm.common.rxla_can_xmit_lcrds = 0;
    p_fsm.common.rxla_can_xmit_snp_lcrds = 0;
    p_fsm.common.rxla_can_xmit_rsp_lcrds = 0;
    p_fsm.common.rxla_can_xmit_dat_lcrds = 0;
    p_fsm.common.rxla_can_receive_flits = 0;
  
    p_fsm.set_rxla_state(this);
    -> p_fsm.state_changed;
    -> p_fsm.entered_activate;
  endtask
  
  /** Return the name to use to represent the state's object type in the XML output. */
  virtual function string get_xml_name();
    return "svt_chi_link_fsm_activate_state";
  endfunction

endclass

// =============================================================================
/**
 * Class implementing the RXLA state machine RXLA_RUN state.
 */
class svt_chi_link_rxla_run_state extends svt_fsm_state#(svt_chi_link_rxla_fsm, "Run");
  `svt_fsm_state_utils(svt_chi_link_rxla_run_state)

  /** Define the 'from' states. */
  `svt_fsm_from_states('{p_fsm.rxla_activate_state})

  /** Watch for the action that initiates a transition into the state. */
  virtual task state_transition(svt_fsm_state_base from_state, output bit ok);
    ok = 1;

    if (p_fsm.common == null)
      begin
        `svt_error("state_transition", "Link common is null.");
        ok = 0;
      end
    else if (from_state == p_fsm.rxla_activate_state)
      begin
        p_fsm.common.rxla_state_transition(p_fsm.fsm_state_to_rxla_state(from_state), 
                                           svt_chi_link_common::RXLA_RUN_STATE, ok);
      end
    else
      begin
        `svt_error("state_transition", $sformatf("Called for an unsupported from_state, %0s. Ignoring.", from_state.get_name()));
        ok = 0;
      end

    if (ok)
      begin
        // Store away the previous state.
        p_fsm.prev_state = from_state;
      end 
  endtask

  /** Implementation of the state action. */
  virtual task body();
    //`svt_debug("body","The RXLA state machine is in the RXLA_RUN state.");
 
    // Records the simulation time when the RXLA state machine transitions to RXLA_RUN state.
    p_fsm.common.shared_status.rxla_run_state_time = $realtime;
    
    // In the RXLA_RUN state, the receiver can transmit L-credits and receive flits.
    fork
      p_fsm.common.rxla_can_xmit_lcrds = 1;
      if(p_fsm.common.cfg.stop_snp_lcrd_xmission_when_txla_not_in_run_state == 0)
        p_fsm.common.rxla_can_xmit_snp_lcrds = 1;
      p_fsm.common.rxla_can_xmit_rsp_lcrds = 1;
      p_fsm.common.rxla_can_xmit_dat_lcrds = 1;
      p_fsm.common.rxla_can_receive_flits = 1;
    join
  
    p_fsm.set_rxla_state(this);
    -> p_fsm.state_changed;
    -> p_fsm.entered_run;    
  endtask
  
  /** Return the name to use to represent the state's object type in the XML output. */
  virtual function string get_xml_name();
    return "svt_chi_link_fsm_run_state";
  endfunction

endclass

// =============================================================================
/**
 * Class implementing the RXLA state machine RXLA_DEACTIVATE state.
 */
class svt_chi_link_rxla_deactivate_state extends svt_fsm_state#(svt_chi_link_rxla_fsm, "Deactivate");
  `svt_fsm_state_utils(svt_chi_link_rxla_deactivate_state)

  /** Define the 'from' states. */
  `svt_fsm_from_states('{p_fsm.rxla_run_state})

  /** Watch for the action that initiates a transition into the state. */
  virtual task state_transition(svt_fsm_state_base from_state, output bit ok);
    ok = 1;
    
    if (p_fsm.common == null)
      begin
        `svt_error("state_transition", "Link common is null.");
        ok = 0;
      end
    else if (from_state == p_fsm.rxla_run_state)
      begin
        p_fsm.common.rxla_state_transition(p_fsm.fsm_state_to_rxla_state(from_state), 
                                           svt_chi_link_common::RXLA_DEACTIVATE_STATE, ok);
      end
    else
      begin
        `svt_error("state_transition", $sformatf("Called for an unsupported from_state, %0s. Ignoring.", from_state.get_name()));
        ok = 0;
      end

    if (ok)
      begin
        // Store away the previous state.
        p_fsm.prev_state = from_state;
      end 
  endtask

  /** Implementation of the state action. */
  virtual task body();
    //`svt_debug("body","The RXLA state machine is in the RXLA_DEACTIVATE state.");
    
    // The link is only active when both the TX and RX state machines are in the RUN state.
    p_fsm.common.shared_status.is_link_active = 0;
    
    case(p_fsm.common.cfg.chi_node_type)
      svt_chi_node_configuration::RN : begin
        case(p_fsm.common.cfg.chi_interface_type)
          svt_chi_node_configuration::RN_F, svt_chi_node_configuration::RN_D: begin
            p_fsm.common.shared_status.link_status.num_rxrsp_vc_lcredits_to_be_xmitted_in_rx_deactivate_state = p_fsm.common.cfg.num_xmitted_rxrsp_vc_lcredits_in_rxdeactivate_state;
            p_fsm.common.shared_status.link_status.num_rxdat_vc_lcredits_to_be_xmitted_in_rx_deactivate_state = p_fsm.common.cfg.num_xmitted_rxdat_vc_lcredits_in_rxdeactivate_state;
            p_fsm.common.shared_status.link_status.num_rxsnp_vc_lcredits_to_be_xmitted_in_rx_deactivate_state = p_fsm.common.cfg.num_xmitted_rxsnp_vc_lcredits_in_rxdeactivate_state;
          end
          svt_chi_node_configuration::RN_I : begin
            p_fsm.common.shared_status.link_status.num_rxrsp_vc_lcredits_to_be_xmitted_in_rx_deactivate_state = p_fsm.common.cfg.num_xmitted_rxrsp_vc_lcredits_in_rxdeactivate_state;
            p_fsm.common.shared_status.link_status.num_rxdat_vc_lcredits_to_be_xmitted_in_rx_deactivate_state = p_fsm.common.cfg.num_xmitted_rxdat_vc_lcredits_in_rxdeactivate_state;
          end
        endcase
      end
      svt_chi_node_configuration::SN : begin
        p_fsm.common.shared_status.link_status.num_rxreq_vc_lcredits_to_be_xmitted_in_rx_deactivate_state = p_fsm.common.cfg.num_xmitted_rxreq_vc_lcredits_in_rxdeactivate_state;
        p_fsm.common.shared_status.link_status.num_rxdat_vc_lcredits_to_be_xmitted_in_rx_deactivate_state = p_fsm.common.cfg.num_xmitted_rxdat_vc_lcredits_in_rxdeactivate_state;
      end
      svt_chi_node_configuration::HN : begin
        case(p_fsm.common.cfg.chi_interface_type)
          svt_chi_node_configuration::RN_F, svt_chi_node_configuration::RN_D, svt_chi_node_configuration::RN_I: begin
            p_fsm.common.shared_status.link_status.num_rxreq_vc_lcredits_to_be_xmitted_in_rx_deactivate_state = p_fsm.common.cfg.num_xmitted_rxreq_vc_lcredits_in_rxdeactivate_state;
            p_fsm.common.shared_status.link_status.num_rxrsp_vc_lcredits_to_be_xmitted_in_rx_deactivate_state = p_fsm.common.cfg.num_xmitted_rxrsp_vc_lcredits_in_rxdeactivate_state;
            p_fsm.common.shared_status.link_status.num_rxdat_vc_lcredits_to_be_xmitted_in_rx_deactivate_state = p_fsm.common.cfg.num_xmitted_rxdat_vc_lcredits_in_rxdeactivate_state;
          end
          svt_chi_node_configuration::SN_F, svt_chi_node_configuration::SN_I : begin
            p_fsm.common.shared_status.link_status.num_rxrsp_vc_lcredits_to_be_xmitted_in_rx_deactivate_state = p_fsm.common.cfg.num_xmitted_rxrsp_vc_lcredits_in_rxdeactivate_state;
            p_fsm.common.shared_status.link_status.num_rxdat_vc_lcredits_to_be_xmitted_in_rx_deactivate_state = p_fsm.common.cfg.num_xmitted_rxdat_vc_lcredits_in_rxdeactivate_state;
          end
        endcase
      end
    endcase
    
    // In the RXLA_DEACTIVATE state, the receiver cannot transmit L-credits but can receive flits.
    // However, it's permitted to send L-Credits but receiver must stop sending during this state.
    // In case of passive monitor, this should be always expected.
    // For active mode driver to allow this, it's required to add a configuration under which the
    // driver is going to send out a specified number of L-Credits (as configured through a parameter).
    p_fsm.common.rxla_can_xmit_lcrds = p_fsm.common.cfg.rxla_can_xmit_lcrds_during_deactivate_state();
    p_fsm.common.rxla_can_xmit_snp_lcrds = p_fsm.common.rxla_can_xmit_lcrds;
    p_fsm.common.rxla_can_xmit_rsp_lcrds = p_fsm.common.rxla_can_xmit_lcrds;
    p_fsm.common.rxla_can_xmit_dat_lcrds = p_fsm.common.rxla_can_xmit_lcrds;
    
    p_fsm.common.rxla_can_receive_flits = 1;
  
    p_fsm.set_rxla_state(this);
    -> p_fsm.state_changed;
    -> p_fsm.entered_deactivate;
  endtask
  
  /** Return the name to use to represent the state's object type in the XML output. */
  virtual function string get_xml_name();
    return "svt_chi_link_fsm_deactivate_state";
  endfunction

endclass

// =============================================================================
/**
 * Class implementing the RXLA state machine.
 */
 
// `ifndef SVT_VMM_TECHNOLOGY
//   `svt_xvm_typedef_cb(svt_chi_link_rxla_fsm,svt_chi_link_rxla_fsm_def_cov_data_callback,svt_chi_link_rxla_fsm_def_cov_data_callback_pool);
// `endif

class svt_chi_link_rxla_fsm extends svt_fsm;

  `svt_fsm_utils(svt_chi_link_rxla_fsm)

// `ifndef SVT_VMM_TECHNOLOGY
//   `svt_xvm_register_cb(svt_chi_link_rxla_fsm, svt_chi_link_rxla_fsm_def_cov_data_callback)
// `endif

  /** The state base class implementing the RXLA_STOP state. */
  svt_fsm_state_base rxla_stop_state;

  /** The state base class implementing the RXLA_ACTIVATE state. */
  svt_fsm_state_base rxla_activate_state;

  /** The state base class implementing the RXLA_RUN state. */
  svt_fsm_state_base rxla_run_state;

  /** The state base class implementing the RXLA_DEACTIVATE state. */
  svt_fsm_state_base rxla_deactivate_state;

  /** Used to track the previous state. */
  svt_fsm_state_base prev_state = null;
   
  /** An event that gets triggered which the state changes. */
  event state_changed;

  /** Events per state to indicate a given state is entered. */
  event entered_stop, entered_deactivate, entered_activate, entered_run;
  
  /** Shared status object which is used to convey the current state to the outside world. */
  svt_chi_status shared_status;

  /** Link common handle */
  svt_chi_link_common common;

  //----------------------------------------------------------------------------
  /**
   * Constructor
   */
`ifdef SVT_VMM_TECHNOLOGY
  extern function new(string name = "svt_chi_link_rxla_fsm");
`else
  extern function new(string name = "svt_chi_link_rxla_fsm", `SVT_XVM(report_object) reporter = null);
`endif

  //----------------------------------------------------------------------------
  /**
   * This method creates the FSM states and sets up special states (e.g., start).
   */
  extern virtual function void build();

  //----------------------------------------------------------------------------
  /**
   * Utility method for updating the FSM state in the shared status.
   */
  extern virtual function void set_rxla_state(svt_fsm_state_base fsm_state);

  //----------------------------------------------------------------------------
  /**
   * Utility method for converting the FSM state into the corresponding RXLA state.
   */
  extern virtual function svt_chi_link_common::rxla_state_enum fsm_state_to_rxla_state(svt_fsm_state_base fsm_state);

  //----------------------------------------------------------------------------
  /**
   * Utility method for converting the RXLA state into the corresponding FSM state.
   */
  extern virtual function svt_fsm_state_base rxla_state_to_fsm_state(svt_chi_link_common::rxla_state_enum rxla_state);

  // ---------------------------------------------------------------------------
  /**
   * Method which checks whether the provided state can be reached directly from the
   * current state.
   *
   * @param test_next The state to be checked as a possible next state.
   * @return Indicates that this state is (1) or is not (0) a viable next state.
   */
  extern virtual function bit is_viable_next_rxla_state(svt_chi_link_common::rxla_state_enum test_next);

  // ---------------------------------------------------------------------------
  /**
   * Returns the name to be used to represent the state's object channel in the XML
   * output generated for use with PA.
   *
   * @return The channel name to be used for the state in XML output.
   */
  extern virtual function string get_xml_name();

`ifdef SVT_VMM_TECHNOLOGY
   // ---------------------------------------------------------------------------
   /**
   * Returns the name to be used to represent the state's object channel
   *
   * @return The channel name to be used for the state.
   */
    extern virtual function string get_name();
`endif
  // ---------------------------------------------------------------------------
  /** Must be implemented if a reset state is defined.
   *  Automatically invoked by the run() task of svt_fsm class.
   *  It must return only once the reset condition has been detected.
   *  The implementation must not call super.wait_for_reset().
   */
    extern protected virtual task wait_for_reset();

endclass

// =============================================================================

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
ohoHGihxYwpX+5ZK1yADv0weW+nRINM0z7RJs7zS1C2d6zt9osferWkSTBH0OnYO
MLQOZ2RUIgOhgKfFESi/ElUTK2kyhc1QpMWZG+1ay40C4x2z7y88KORamoCgnScN
GhuVrZBNmtaYXYzfoYRflrcj4xf99r8HBPtD/qbQfSY=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 456       )
n5tGMMyLwConeJnzheHE7Q9kE0nPYmmIv+ULzitf1zItx3Zynr1Jxa7G1xC+fK2Z
hW9rICsj8wd7KpYZt9udXDYTNJ8Ix7rPzfiZVqNqCXxtT6gYl0B8R0MQo155BDne
mUF2hY9UDASUloOrOCUPJg1RvCtKNB7bTiLWPKoDNT7N/YTwa8mlrnLxoCFCcHwz
ZUPmTCeat//7ksC7093k+a805hIYKXHHj9jT+M+HZrurEXIlNaUJZ+JXuzQ2WzAg
vlzJOOzmuPI57SA2j9BcziJ/+jDgmbUoE5ORMdIUV86g0+z+ThmpWrq5Hry/2o8T
w1FW7wNs27zmtVbvH3r29wFxtU2R7mxif0iNQLv4QCTC0isy70KDiHD+8CV985s8
X+wo+j/eFie5EdqRW7UxTS5GTKtki3QwKbLbWfNXPLw0uRqulK05fIH5pt3zkboc
CVHG+0vMblB8oRA0cpTtug6XK4cDS7cCUOeoWX4gAmU+sAoiOn5bSPWyqXqWAMM6
OsgOA1kgGPoqJeF/O6RPdyvEqMszZ+fokm+yqhXz4BA55bC+3I4kIcb98FFYjdX9
oI/fqqJQ//Wkbk8M7/XkxyUiZisqKZLzm+fQ0u9SmNA=
`pragma protect end_protected

//vcs_lic_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
nO3SeAAz8oA4/tNYWa2+XHPXl4ug7dNfOlO/A5IFKq0daHMfbTVD1v4RI/oivSBt
jMkv8fQBIMEQ9fjdJwyyDpqOiJZmT1DcM7Fq8zPV0Gla5rQ74MN/FeTgVAsWkNGe
zju6D8CE3+4cQeDV3rP2zDOaNd9j6JJh5bDcPhHHvL4=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 1601      )
pVwNmXrjGokTLZ5y5f1C+5FkcosmjqYMkuOpXVEXv0N0ae4VnKDrMggmXTnNPpNF
bU5CqajOO/iltcBZ3alyYL8wbXyIASEPhEMgHB4lbN8Vc2L5gvcfyPoDOyvnOzse
potIZhDc7TB0PsPZVVrqbz1xc+aNPqivUDmDuYdzwd4eXoLOnf5TAKOtYN0LmmHJ
xuuyFSHLAny0p/vEnpuisjHCoPzGbq74QWpNFcRMYWqmjjMGIc9wt7T0xkBNkhwJ
FzPZagBS4gAQrztFByVgVJJYS+2+YSKvu3jRXX50urRzj6vcQ7V8yhREWhnxYaeM
8TWlgeas9hY+OM9lQopZXKcNtKpcJEK1z86xZCddszRVYILFcW4jGMjwgRStANie
REefE+/eElrg8p9IOJIvFg5KwrrUlLiEe8nBMPpqw0OolmviRMwytEXEhlKT4w7r
9nVIil9me29btbbmvLWzuhFEXjBmjL+RPEIRwqJFWvEryiA9A/Ba4Z2sONvPXFq2
P1Vz+i1H+R8jEjtf6QZ/bp8lKCVZM3wV+tvzl3X8+RqTiq1oFf7reUi0ZirJKgcI
4WH17OTZpgouZqByKXhEYa5R5MXV73OjtlXnOKVhE5PkpPQ4M1NQdCocB4ygH3nh
od5f7cxOvm5v8UZM9UUa4/0/iT49MSnngW38xgUftKPrkmah8M/Nlqz3sPPJfRZ+
Vg1BVOq3WIFIsnx70jly2NSLVxaz2rlaO34Rw94f/S4cwLJVMaH3Sw8GCmjE4n57
O+x2IOGX8JSs26sKcI9Mbwdov/7urU+dZ40F6F8aPlcA/IfczxSc6nbU0P7ssk5h
UKRq43J7HwcG6GkapKISP2/U0gP+Qsf9cPR2WWfdSbg/AWrrdqFGC2q/Nk6odcfs
RlXhkcam0pGReZ4ox1NBeIZ23MYqpoMtp2FIhGHSUAz3KAKUIR4Q7c0gCh8Zy12h
bEZAW9xXrM7n7SF/tfTxIOf/drL3MC6uVmiHp3obJTlgGb5aP56XVte1YB1dWBik
91HdJlykcSldoB+AiqA6KAjHyziWOAyVKLYlO2zRJVMrG/J3iU4X5H73eEmTSHUC
nCbohbaXRxPjcLfp8tuY0s30oqbHZbmNH4xOyiQZY4X7oDSKejYJkjnv0tiLPQsC
oXo8+jkLL3DVVIJqpuRxgcMA7T7wVQyl5fPx4OenD/QDIju5YbGgrqxfgidFHUTu
vK9PhsKXZz2BMASa5CXtf9V0Pz2910TyPb7lInL9CenD9p+hfrAPxwcBMy7tpfx3
EYJ+R8ig+aiXHRvHPgp/6u5R2eKDuxKKvC3GlZqG1dvst1C2jNWxk/f4K1pIEtNn
hxGzsNuw8YA9v0jn4gkui0E8EmujYSMntSFXL4B1BrLLeduqod4AcJ9nlrYDA2mY
Xx+V0FsAyp4Hd7Oj1jvwwziL9JHTd6u+tHDd3DVN2FTGk/OvPyafqVcdSG4BJdJd
ehncr+hXq1ODMMPk906Gvx4gsCh6foC3ct6YDZePDx0fZp+yZMbSDa/ECevgoCK5
`pragma protect end_protected    
`pragma protect begin_protected    
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
a+mBglD5F9+ZA1LM5lAcN+Km5y+sRcJjkxpdV4EHjmri0+EhBM5uaOAswIEj3mUt
9c70TJWSGPWFjlJe7RNWwopdDz6hYPZoOsT/moRR4H2H6yRrXCTSfabm/ChRX4Hp
8hZB1FjiEnXFwgZXV2TUSEUzaldn8qOAyHfhOsgwe0o=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 2449      )
57HicfWIiJYY2kbOUivpMOs4DcT6phl0etmhmoHOEEJMY87yBhLZhR6tIol9caI8
negbIToNL2Yfj9aXUjQJtyaF/v09USnlthQXy9FtTTsKvY4vIn7WrGdS06naQcUf
uN8DMQMPBTXXPliShpAhtulRlfmHyWk2rmY8neVbBCA6d/A0doB0dB24YciIEd3j
npOOZ6KJGvVIk55wsaom4hLLdqKOE+G99jGpUj/rDluthzRBNMVctv/wliiMUKRn
rbydjXVh3Ex5QylY2Q46SrEwmnVo64LWVbp2oDTUCtvf4eLoeIDVBe92W7bNUIVK
0MKFHR3VEPRYZvjwnBha/qu8oRlxTx2H02gLaFCoSgRdKQSdELJIQt6l4u0E5r3D
Cw/jvnyR49Ldxe8sCzW5eB4s3gaHvrMMR4cIxJJibM5Cp/CFIvuDAzr4mSv0lHY2
0j61zhuOYTGC5BnIbiOaOaA7Ckx1mXymVqJkUH4Kj4yb8XHo4sqYxxKxUYtZDJXE
Kkeb7DkKlx7MMGRXOxUi4pt4iKXpxbj3mmp6bvk4NII2MXW/pQct7KVTIJo8XuSl
2GCLcEe9dt45LPKTGOxxgQfiwKD7vH8S4SZGtAbMeCM1DMjRN4ZvJ7iNrQwz/yu7
BFEB+OZHuFZWbzbp3NI8PLv01cE9eoEu9FwyebLLkToXm5rXXcVy+20usul0P9gZ
w0TaG/B08YmGCLZbMR2JmdzgSDAEoucYUQUs4yi5W7RyVcIZ7dOc77TFchP5zwJt
2RL82x7JKH3SgwkIIxuLT9w0NQsFOyujS9WGpt5GgNmYCoBaqJR9GscRnhGEAHm6
0bQS+6yhsSjLFr+jxtsRSBGJeT5xZkXUoLCTYbW207ZH2HA6UG5xxsgFhO1ZuPSg
CuP5rbf4+e1KUWz38WICqQ+VQTRPAtzfgs1/nYCBTXM1FFZGae7mnyYFx9F+eXK9
hlXPxHrWmwL9iRWoqUFayNqQi1t7ZLA/NDgHoBsxPNK57umsb24C2EgIRqBwBgR1
hE82ItGwnw4TQRNKZrbPqKleWDmSpEqmdRvnxgUYoIg2/0rB5TNLQHwbqeF0x5fi
yqzIbK2GYyxRBuZREJPruLPfSZV5JJ0PLgxLepVxoYHWp73OsVYbbReON7E55Dj3
`pragma protect end_protected

//vcs_lic_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
j32DKkeU0xXJCTCcqdlFrB15Fl1dzUDPqC7g0H+C2y0Ll01x/YI3xP3Q5uJ/qoWo
BM/Bw8CjVL0rHYFM2w1e7Eqelf/Vj5nSph2FxjLDPktw+d36TedcHxeFvH5wKfoj
GpOjUmUeRM3cS/xZydlihgwllDBdPqIGY8E5NsGVbHs=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 4983      )
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
`pragma protect end_protected

`endif // GUARD_SVT_CHI_LINK_RXLA_FSM_SV
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
niiSaClNiWuhdmyeTiqwCodSQ7XkX2bTeuWp3Px3Xp22ZONFMUmMCaMVzCA72sSo
WF5pF59U6xtDMqO/4/9Hiz12gAcxR4DeiHbeXy3xRZM989zuKVGnb+9aTCUZ9DPx
pf5ca5xSHMqV4KtDWQ1fPZ22ApZFrrqY7xcaaohUk3w=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 5066      )
jr96SEthdlM9v0OyTCki6JvrfM/oKMbZxFu6PHNpTkNYiNkWDNxyVkCMQym3SSqa
2dQCXDihVSxkWLal29/7e/EAQjbIaggUER1VculuZiPSQmZd4Rqx0eXELku2Q7MR
`pragma protect end_protected
