//--------------------------------------------------------------------------
// COPYRIGHT (C) 2018 SYNOPSYS INC.
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

`ifndef GUARD_SVT_CHI_LINK_SYSCO_INTERFACE_FSM_SV
`define GUARD_SVT_CHI_LINK_SYSCO_INTERFACE_FSM_SV

typedef class svt_chi_link_sysco_interface_fsm;

// =============================================================================
/**
 * Class implementing the COHERENCY_DISABLED state.
 */

class svt_chi_link_sysco_coherency_disabled_state extends svt_fsm_state#(svt_chi_link_sysco_interface_fsm, "Disabled");
  `svt_fsm_state_utils(svt_chi_link_sysco_coherency_disabled_state)

  /** Define the 'from' states. */
  `svt_fsm_from_states('{p_fsm.coherency_disconnect_state})
  
  /** Watch for the action that initiates a transition into the state. */
  virtual task state_transition(svt_fsm_state_base from_state, output bit ok);
    ok = 1;

    if (p_fsm.common == null)
      begin
        `svt_error("state_transition", "Link common is null.");
        ok = 0;
      end
    else if (from_state == p_fsm.coherency_disconnect_state)
      begin
        p_fsm.common.sysco_interface_state_transition(p_fsm.fsm_state_to_sysco_interface_state(from_state), 
                                                      svt_chi_status::COHERENCY_DISABLED_STATE, ok);
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
  
    p_fsm.set_sysco_interface_state(this);
    -> p_fsm.state_changed;
  endtask
  
  /** Return the name to use to represent the state's object type in the XML output. */
  virtual function string get_xml_name();
    return "svt_chi_link_fsm_sysco_coherency_disabled_state";
  endfunction

endclass

// =============================================================================
/**
 * Class implementing the COHERENCY_CONNECT state.
 */

class svt_chi_link_sysco_coherency_connect_state extends svt_fsm_state#(svt_chi_link_sysco_interface_fsm, "Connect");
  `svt_fsm_state_utils(svt_chi_link_sysco_coherency_connect_state)

  /** Define the 'from' states. */
  `svt_fsm_from_states('{p_fsm.coherency_disabled_state})
  
  /** Watch for the action that initiates a transition into the state. */
  virtual task state_transition(svt_fsm_state_base from_state, output bit ok);
    ok = 1;

    if (p_fsm.common == null)
      begin
        `svt_error("state_transition", "Link common is null.");
        ok = 0;
      end
    else if (from_state == p_fsm.coherency_disabled_state)
      begin
        p_fsm.common.sysco_interface_state_transition(p_fsm.fsm_state_to_sysco_interface_state(from_state), 
                                                      svt_chi_status::COHERENCY_CONNECT_STATE, ok);
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
  
    p_fsm.set_sysco_interface_state(this);
    -> p_fsm.state_changed;
  endtask
  
  /** Return the name to use to represent the state's object type in the XML output. */
  virtual function string get_xml_name();
    return "svt_chi_link_fsm_sysco_coherency_connect_state";
  endfunction

endclass

// =============================================================================
/**
 * Class implementing the COHERENCY_ENABLED state.
 */

class svt_chi_link_sysco_coherency_enabled_state extends svt_fsm_state#(svt_chi_link_sysco_interface_fsm, "Enabled");
  `svt_fsm_state_utils(svt_chi_link_sysco_coherency_enabled_state)

  /** Define the 'from' states. */
  `svt_fsm_from_states('{p_fsm.coherency_connect_state})
  
  /** Watch for the action that initiates a transition into the state. */
  virtual task state_transition(svt_fsm_state_base from_state, output bit ok);
    ok = 1;

    if (p_fsm.common == null)
      begin
        `svt_error("state_transition", "Link common is null.");
        ok = 0;
      end
    else if (from_state == p_fsm.coherency_connect_state)
      begin
        p_fsm.common.sysco_interface_state_transition(p_fsm.fsm_state_to_sysco_interface_state(from_state), 
                                                      svt_chi_status::COHERENCY_ENABLED_STATE, ok);
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
  
    p_fsm.set_sysco_interface_state(this);
    -> p_fsm.state_changed;
  endtask
  
  /** Return the name to use to represent the state's object type in the XML output. */
  virtual function string get_xml_name();
    return "svt_chi_link_fsm_sysco_coherency_enabled_state";
  endfunction

endclass

// =============================================================================
/**
 * Class implementing the COHERENCY_DISCONNECT state.
 */

class svt_chi_link_sysco_coherency_disconnect_state extends svt_fsm_state#(svt_chi_link_sysco_interface_fsm, "Disconnect");
  `svt_fsm_state_utils(svt_chi_link_sysco_coherency_disconnect_state)

  /** Define the 'from' states. */
  `svt_fsm_from_states('{p_fsm.coherency_enabled_state})
  
  /** Watch for the action that initiates a transition into the state. */
  virtual task state_transition(svt_fsm_state_base from_state, output bit ok);
    ok = 1;

    if (p_fsm.common == null)
      begin
        `svt_error("state_transition", "Link common is null.");
        ok = 0;
      end
    else if (from_state == p_fsm.coherency_enabled_state)
      begin
        p_fsm.common.sysco_interface_state_transition(p_fsm.fsm_state_to_sysco_interface_state(from_state), 
                                                      svt_chi_status::COHERENCY_DISCONNECT_STATE, ok);
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
  
    p_fsm.set_sysco_interface_state(this);
    -> p_fsm.state_changed;
  endtask
  
  /** Return the name to use to represent the state's object type in the XML output. */
  virtual function string get_xml_name();
    return "svt_chi_link_fsm_sysco_coherency_disconnect_state";
  endfunction

endclass


// =============================================================================
/**
 * Class implementing the SYSCO Interface state machine.
 */

class svt_chi_link_sysco_interface_fsm extends svt_fsm;
   
  `svt_fsm_utils(svt_chi_link_sysco_interface_fsm)

  /** The state base class implementing the COHERENCY_DISABLED state. */
  svt_fsm_state_base coherency_disabled_state;

  /** The state base class implementing the COHERENCY_CONNECT state. */
  svt_fsm_state_base coherency_connect_state;

  /** The state base class implementing the COHERENCY_ENABLED state. */
  svt_fsm_state_base coherency_enabled_state;

  /** The state base class implementing the COHERENCY_DISCONNECT state. */
  svt_fsm_state_base coherency_disconnect_state;

  /** Used to track the previous state. */
  svt_fsm_state_base prev_state = null;
   
  /** An event that gets triggered which the state changes. */
  event state_changed;
 
  /** Shared status object which is used to convey the current state to the outside world. */
  svt_chi_status shared_status;

  /** Link common handle */
  svt_chi_link_common common;

  //----------------------------------------------------------------------------
  /**
   * Constructor
   */
`ifdef SVT_VMM_TECHNOLOGY
  extern function new(string name = "svt_chi_link_sysco_interface_fsm");
`else
  extern function new(string name = "svt_chi_link_sysco_interface_fsm", `SVT_XVM(report_object) reporter = null);
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
  extern virtual function void set_sysco_interface_state(svt_fsm_state_base fsm_state);

  //----------------------------------------------------------------------------
  /**
   * Utility method for converting the FSM state into the corresponding SYSCO Interface state.
   */
  extern virtual function svt_chi_status::sysco_interface_state_enum fsm_state_to_sysco_interface_state(svt_fsm_state_base fsm_state);

  //----------------------------------------------------------------------------
  /**
   * Utility method for converting the SYSCO Interface state into the corresponding FSM state.
   */
  extern virtual function svt_fsm_state_base sysco_interface_state_to_fsm_state(svt_chi_status::sysco_interface_state_enum sysco_interface_state);

  // ---------------------------------------------------------------------------
  /**
   * Method which checks whether the provided state can be reached directly from the
   * current state.
   *
   * @param test_next The state to be checked as a possible next state.
   * @return Indicates that this state is (1) or is not (0) a viable next state.
   */
  extern virtual function bit is_viable_next_sysco_interface_state(svt_chi_status::sysco_interface_state_enum test_next);

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
mNnpJqW63ZiHvgAsbJ3WkKIJOrDugWtfoc0YTfR6+Z2KijL0/zQ1F9TNzs4P/1vh
vhSYjJ75Hoi6lTEgqjIY+mvRfvbvetHZICRpmUuMsvco7oxGu/ar+rp68n5ywq54
b71tubQfH4y/nKMWWmj73wwjQy11MMc3b/2eszYEPpw=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 499       )
ixT4UFvGSBLMEE/Kt+p69ZAUuL4NMSF8hvqUcDX8aBuv/xcSsHY62QH02Lgn/Udy
9nG/XCVKwZJH6D5do8ZfpXhaF6vwQxU7j+6ZnFSWjRxFfd/f3ndO8tf5RLzT2Fyb
Z6qwYUfC2+T9sr0sADj920fY3hJvOTx+7uxMJ2v23PpiRHk965+LTzagh9F8CfkH
TmvvAJnEc044tS0eThXIiBmYSEDrpVCcCVhY8oZojLsr4gCvDyoLyihc0f9eNFYJ
l6f2rkNWLTbpPiU287+gpTdL5/1Ftl8Uc9F5V/ADU1PkCHeNI03rQqrJ2q7HJCKw
lrHy/ZuESviQHhCHKu1QpqVh/HQRsxjYd2+IhnOGoCodrVrdw9gpaoI+eKNl+4fW
uPdrMfZ/H1l860RpvtrErx8aS9Z29cAGRTUwroyiKSCld+9NT6OFDwwRjJ/qUDI1
fVjv2mIxdMGsEJS7LTGK9lYO4G4g+Ac4DQokKLIHbTEq7yLK9w69aS4u6oKxYsts
gVg7/wvZLwSfnkUAfHw9w8Jj4qqbybUpvzGq7G/cYRKhoIwBzcIpwe50Y/6H9pSZ
cU4ARaj/S7zigcmQ38YOrhX78SL1xfqrKWtjZv8cxDK8lvf9tQODLDntrVG2fH+2
bXAHY69OrWyLSFW1vYhAt0VI//DU/IBY9AUXzUJGQ2E=
`pragma protect end_protected

//vcs_lic_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
dTaN9avlL8zudWAPF9hQDjveOxHYhKU8pCPOX6zjHAVDWujuMMc6+3XnC3y3IjUI
+RtuGicLW6I3AAEMl1MQSjsEbe+Wub6janf+4cXxaz6Wwoh6e6WPYaezvBTfLMS9
XKj1maieq7dl7Ki9aAxrNEwS5zeTujXq6YZr7+xTPAo=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 4356      )
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
`pragma protect end_protected

`endif // GUARD_SVT_CHI_LINK_SYSCO_INTERFACE_FSM_SV
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
RbHtaAaDh54wjGCV1yXSMWhLIfmzm02GJgvHxSvVcRJxiKvNDJLeFD3hrIeNRa+U
ij1sMQ6Aat1USFWaA89kb3lRF4r/fJiJbd7zh1JmBqxxGZLRGNn9ZNpWU+xXwsut
DlRFy9JrdcmWjyGglQP18wGbH2wkbF1EuxT/H8WRX4I=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 4439      )
WDbD+eUQzhyuh6LnQ5n15r2C7o5IfPNelrs8wYh2cJsEtE6MaTDU1/SXjhZRT56p
gh+qHWdnKNjSFNnTbNsdMxJEsfKG5yOrnj2a7wKSNH3lZW6DYQ1hjvbAPS4KEajX
`pragma protect end_protected
