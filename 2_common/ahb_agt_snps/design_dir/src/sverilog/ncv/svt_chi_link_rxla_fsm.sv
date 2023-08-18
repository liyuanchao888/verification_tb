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

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
T0VqquVbumYUBkcL2H0RJR3g5aU1F002maho8lqIv8UWzsuc4M9S6rzdAcl7CUx5
ye3UaKOR7nFNjxUMFsmyUh8o0aTzY7O00d9tCLCU23BfaghCUL28gyYVvlNoLw/N
m2/G+YxCU2XAPVOFlaj+ORlZ8MCCD9rWz2uZuQinf6hPY9Ib1x0mKA==
//pragma protect end_key_block
//pragma protect digest_block
1y9Cik01zqedVTsP4w5XZdj32/8=
//pragma protect end_digest_block
//pragma protect data_block
/fjtjtBwCDZpEyMM9pvPb4Es2vaOvlzrwEpmY/VS3YZnPuyWbE7cfANmXNJTc/xo
D1Olz5RrsRdEqaV9Zp5b69uuR1Jn2PgSkti128J6XB8+xjL+xgfpF0/xxBFckGD5
i6MIA+mtmXrIIdp7sN4wxhOYGA4JhJJWc9+Ej1xUFuU/o++45s9ey/EBPJzdUac5
YlMNINZ3/k4NFnECvr/52HqP/rQUxjwQLVuzrfg7Kvma2FesGHhe9Vf/sclD287s
JavMNv4RG4N7l7aXHmiXd/rFyF34kq/65Zn1OgR2ahFgD0zHK3CSKNYKN+bzdAEw
XSaFSmh5C7NImiLAxj4TsoxeKeadOSUekr1Z5867ORljTksfUvo8TjG3lxEElppN
iv8Gso5i3vcilmi5jSitKLRbNITa1RIdITB/hpbun9WAblr/aZeYWmyyTzQLGo6b
g/e7Am8JgB7TMynKVc6sP/bLfNo+9Np25lRVGbmEGbdUycyJcgICg3/65bP8vun9
ubUqgSmQSahAYjPzeygktwhw7gQ+JUbWGOMRK8WOhID2aGRNdGfZEEU2RlC024b8
PrNfOIY6ziEemMgeOyc9o50up1uSl0ZQuy7ErtdeP0IrtsM95Xr1D2wuzynV8Due
dN58li/3pAtESA4okTZ+vi4rK/+6RJw5XCXg5MsSqUFBpcA9UoYGCIaD3rYaKx6I
cvcW5riTAdGJpGRk9VjOf4VenXC/yYvcml0PLP+5Tf9O8HaRwTx6wZImKwsQLoDh
l0gO/VimNdQiEPbbxnsvdcBUyo0GzA3/gkreRvKXzq0Edve58j0Z2fDB7kQfLTM0

//pragma protect end_data_block
//pragma protect digest_block
l9z7YAnrBTaOjgdi5I8iwozyyYo=
//pragma protect end_digest_block
//pragma protect end_protected

//vcs_lic_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
Q3VXNZME4ES26A0Dh7n2KQl/wanqm/l4mnZX0HGVwyeSb70BAgX++w5jLbl4XmZz
CZUHvheoUD789RNoxJByVTKc348DsdMfua5Nnkj/luy6erIKfCrFs3bmi53+gnLB
1ylyI/yv/VPlULz/nCDN2ROoxTZJ0IzoOqSHQNp8HqfGykuW87ucJA==
//pragma protect end_key_block
//pragma protect digest_block
euZjdrsPyk1gW2h5p45OrsVFNiI=
//pragma protect end_digest_block
//pragma protect data_block
q8UzYo+uCER0eTwVR6k1yHIpvAErSNTKAHLRuAOtSmNg96HfkbN3622Buv2BsD2A
FQBqBEqhUvEJLj8RrFE/q7fSgqgfglZmgoDByIGXunFFrEP1iRYJYnKrBvLKUlic
4w7R/qsdVfQL/tDssObCHjrOWvKdwhSlW+EEjSIEFiM3cuEg2ZkXEn01/MzLy+Fa
9UXuQILOIFAkpkwQW+pqFhKBXAfY83aivztXXv92TwH6wItpLUtODDm7l5OR9Ye3
f6oJ5xEf6wVqlgkSwa+ydPTKLPvLrpSZ7YIWdkK8ou3vSeF9Hd5rczLMTMWtjhkK
7aBTysmHhUVy3Dxn/uGmawd9WbPn3xDr2pCFofzOj1f0Od2PXbG033MUMvz8qko7
7dmYQFE3TKo2eQ9gpyrAecS3AAjA/9Q0BVQz3DLWXISSQ7SjnJE9ZH2lAjIA4VxP
quqjVBHMVuNzf9ewaIlC1kd9YeDHtN9H0KkJFg5L3U1odDiMhw9cbK7c1HXOceTS
dju2bzM1zOESt86zzf11qjuhpYwZKHG1YKRFcfzH2avS/y6w2XYizGfsOFi/ztKs
fAiBpm4u10qzZQ9YfX2wsv9I0jJOOX0WJ3410bMWZG/LkdvVb0HLT1x8pXwu3Wgp
CTEkI9TRODcDedAJUqNv/dvvnIhC1iUuGrqLIBaFho1OJ9svt/Mzx/M5ZHUN8S7Z
RM09JaZXHE5kmR9/aUKbqUd+pETVLNB+fOEChrLLV9pTbaIS8pyye4S/E8c27A94
9IwnNLxkyrYaOpgF/aklwwl602F1I57E4/XtDR2HwbrPpI5WBFf2fBWOuJzUgn4Q
kshfhgTVmn82XQ9E8Mgx81mMTgKBLgjMdtrXY/RMwLKBfbz0oRg6CogkLd4xz+Hu
bNIYTRun5npikDpfiN8Anqwr9KlUgRlqTebx+pmhcNgPfskiat5G/TR032sbZn4t
O4afHADSBy1S4CmwWkoNE6PXvdgFwy+4lBna9xVi+/IDKfpgxrcNmgfJnXnKa4Qm
6f4FBUFPefCzauwQO4QOBZMKNRZklg7Qf3DlrFkNvVZdgWxVsNbKrPIK7hy5iKod
oF0s2jofq/KhwNDlCkROASqVLrl32an2GT1pfmn5mDPsciDlXkQ1cFj61J+5aEJP
GPYk9Zmft19G3ozwxbA7sAHxOK1htkzMypVj37Q0k5O5KdagJvDZHQJKDulMXreV
U1WWagEkuJ8yGNPUa7hskWraNQl119c4UWG1In6ApwGNhJNYU5Ux8PPuVZD1IkML
xTGIK0R2z3VDwElGkaqS5enwlcYBC/SJ8Vudifs47HMaSODVOP7WL/MCfXHuqkrL
Q8C80lewChtSoZcDU2ciKcxLLQBTU92AG+R1W67y2Z31hburEjRst+ubfPsy+cLi
zE1XoOHH1yIDDhdQghbft+x9nf4rUMAC0W3fgHkr5cYWXIJUxAH5MJEX9mCPB6Fx
gZBHDqrwC4QO41q1q7gvt17P7yviqijEquoVXtcqq6yUTDfEQ0bocitoOS4g9Lr+
4LFB8+pgRasJA4TddGLXr9rkZmH2Av+5zb0W3moeUu4nTczcia8PV7VmXM9RiFPz
mavq5C6Lr/Wq2tzConof/8KEzvYZ+xdJjJcukzJJ5c1x8pxfQfdj9XU8fdQHDrJM
RXICoRbhwO6Gk/fFWMcoDW2uaDtqi0KXpbgXFYnRtSVJnv6knCOzBxttUJJqmupR
5VphA2DfAShIPfjogW67Og==
//pragma protect end_data_block
//pragma protect digest_block
BEd9YGiTa3yIeWlG50e/MfomGLY=
//pragma protect end_digest_block
//pragma protect end_protected
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
JlomTNo+TSSmk4QaTYMRJXYReJa6JMi0W0wycM5MC10gfbIUjXS6ARJ7OXBQNont
oTR5cHUet5YG+LQVrrlElLaq01GDxkQ9Ds6wJACo+KnffYYslG/FuOnjzGsAzEcQ
oo541AD5dWc9i2RUu4I4DlVclon6SzMvE99Vl+uRoAZdUVTiE7fP+Q==
//pragma protect end_key_block
//pragma protect digest_block
Xzdfi/KIXm2Hx+F7uj3NHZGDEN4=
//pragma protect end_digest_block
//pragma protect data_block
clme8wqSyty4ftOQQ+4Y8VKGTEzaFPezZ50X3pSGKtFyExMVy4kfo+Z62LnDkVWr
DYQ8kxKfu+DDDIIrDsPguSMy01nHhRVANzU75iBjmuiRk76MiXtt6GlW5fjqHsxa
5GLvo6YdFm6Ea45RQBu6SdELNVoGEr5EuJ1wus80nlqd1KqsHL7eMI7bXE5IHACY
f+RtpmNqjwZb0im3c5tcnilLzEuonTmfE8gJgGdXovxNy0mos9btcOOx4sTxUlQ1
QYhHlRlkQ1mbFrxwDNqvq+wAJVrBCHYMmDNyMLArIYalmmfYrwcsdPu8HGTiNsKX
tda3h0Ec34I7nxs6wXANI9seU+OYQpFIiMXZwsSqQBsUO00313Bwhm9kaB1I/XkM
eiLu5rKeOmfhuYJUUfaYIgm2X+ZaIKBj1jhz1X0emtrGDc4HUeG7UT1kH9FgBh4E
I0OwL/+eTku7Nu4sVJA65fsieYr/1Dop9iyEnscQvnTeY/sM5fVCLUS2aVKOusY+
TV4jaC5HRDx14yPggc5gTOEqx0Uwhp7jeZpa4sGkypw8ZMG/XPLoNanWpN/Nn7Xs
nPlyjVvhdKbOmgv6ySQl3AOskXrXIOkPjS87gVxSqD7J+340u+swVltHAigyGzds
FzBgIV8NUmaKntOOf1TAN5XGI+klzsvc8f3bzxWgH1CdQ4s5e8lLMd89Hs+iTdpd
VE8GAE9DRwiIABJfcuvwNFqYuKS28ByuaFbPeSK9V2zK0kCjZGSg5eX+UydYfeDF
/Z2L/6kBlAUMuNctUL1U8tfqw6p+TggjLH9jwOcIIcARmfpNFaG1mOftO55RNMQi
vJR7cyXIQ/R+QvBQJWHED+vYO7wdow+S59Vj3EqW36fleC8ppPu0TUph3u8ueBX6
cRQ3UOsojA6ZWFX5BYTQ6EFOeAbLZtriKSkHEraqm2jjsS1T3K+jppeWNmHK+kgX
uyzUbOqFeWrTlFmL9PkrV0KDu65hhtRNAVIEo/KdANUc7gQ1IUX5soC4c1T8RqmE
GKgK3KhqF7l5mzBFr1UROHPTtJA5Adw65o7QMfEwvxa9iQKR3K7oZvkJ19T6He87
N66/iatxnrUtcnxrZq7vxB+tl2A5VtePmdLICB/6EjcbR0ESIZcEMFIoZU45ZoB2
F8gxV+IGqOwr/D7DQNks+FmnJ3QHz3gdLncEOCQrqudedPC5vapplQpbuqu6Emuc
v+ELZeMHGqqQWfmttUqvVxxLl65ea7v4MITyA6CZM6G+KkdFlcdbzLoM2WR6aADQ
6HppowSN0aOTnHIqazg6b3kz3qMfxBlc8QQrjfK+s/jPTmcxjrc2rbJTzxUbzgfP
4pbdXyuKneDUir31utO/dg==
//pragma protect end_data_block
//pragma protect digest_block
Fp6bKVv3QW+ZQLGfHAfwxbU1f+g=
//pragma protect end_digest_block
//pragma protect end_protected

//vcs_lic_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
FoEKt3Xm1u6VW8fSHwN4GKyjMiIhx4ileVXT6eYOMJsE1Jdax9EJslveRfnqraf6
g0tG/PWwh28scHkhUHdIpxRrYbaflxQW6f73d2CE/T0+YqZnnEtx7bSblTIl+kym
4BaPbWWoyEdqcGgbbxZosnDYACLio0WmTyRTX9p6eRqMmM6y3pv+WQ==
//pragma protect end_key_block
//pragma protect digest_block
jowTr0c82YqncpP+0hOOKWVHqIk=
//pragma protect end_digest_block
//pragma protect data_block
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
XEcaISVyFmpcvR7ziHixsA==
//pragma protect end_data_block
//pragma protect digest_block
NHb/tdPZ5aB3BDUxIeYoRKOQtWQ=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // GUARD_SVT_CHI_LINK_RXLA_FSM_SV
