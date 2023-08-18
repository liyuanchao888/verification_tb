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

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
KeEn0900Yg44/TnQ0Az+bfUdxkfIgT3CP8+/hy6/IpiPBtBOvy+gJMSVf8z4tbd5
UyQoGu9hZwYcxC0VwHoEhWZRJpb9ORNR49Q8o84NC2gvFl/Czn/1tfwG8Fs5xp4P
E65/0nhWw7gJrMdXwrRq7wKY2oJlP55bBvrULQuq7AcwPUPa94QEhw==
//pragma protect end_key_block
//pragma protect digest_block
I9wa5PXOYvskzjymyY+UoNuJ8H4=
//pragma protect end_digest_block
//pragma protect data_block
pnPaDlDy9NEG947AqhigCfakye921wa6FYUVQC6pV6YcZM+CmiPEnLMB4M8dpisK
33tknhbV/z6qwbFdLJ3+8h/2ygMushPbr8Ukmb26ggnibZE7pnh928A/Yf7CSB4R
Tk8cWOvbE/rpXUycMqT1RsyJ8TB9nGo3tNgNKa6lW5HPOzcFrzVk6h292rvRS07G
qTrBQMcmZuAnGTz2Y0xVfh3zmEuAvbefIg7HYP/uMV2DMCP4imrmBPafPSiyDN/D
lX9uoWaZYptaRK2m2lZDrbaq+iXYGMDYkbEOz0xIHz/hCkxHqeYSpuuiN8QEqHVL
B4qG18LOu1AqIsn0bWCi9hUWywnbxA7eEzUe3pUF7z5/iqUaoxpyaCkSVfW9JJfU
9F+fDHcerbfvvAxH7f9J/41zKf86gj2Nbc1n0H/D4PIpfteRFW/0Chfk5YL9kSPG
mczXq7Z/Z5VF+Jn7ff1c0re69+L0OUUEbHUzq8VlqRjjCs6qM2Ww3/BmK/HjjPIV
1hCyRmDvHUT5wpm51D72bsl+85wRD/bq9qdx7szJVQFMMumL5JSFYvAjABNQeneF
Btv8lcvL+qcR45lSrkXf1ESlxPVPeqOlNeNkKjRtgkqZ52TkTFYX3Ck8pN6A4GSt
AZ/tInfkK2ZpTl8c2EomRqQhtCTFl4JD3mzHMticlW7Ihicl9uNMIapKtZnr8VLU
c9fbChs6pKj++GxEnWnPyTfII9TZsKZ1sKC4ysNyRAJ5ozVAKWQzTTkx5zV3Imw2
7dRkhfF5kJ0rr8SDJzMDPspWloYy7exkid7Cg+J+uhs4GMBl2otkXGeh/n/ELt/I
iIcagI0XkbDhztcdJ6hjPcR67V8lDVp4vCw+imkk1TaT7ztKpPNa+bQu0TnlOkaG

//pragma protect end_data_block
//pragma protect digest_block
JY5xG9Y+5bYpGpfFsCBUyhvBaxU=
//pragma protect end_digest_block
//pragma protect end_protected

//vcs_lic_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
KeEn0900Yg44/TnQ0Az+bfUdxkfIgT3CP8+/hy6/IpiPBtBOvy+gJMSVf8z4tbd5
UyQoGu9hZwYcxC0VwHoEhWZRJpb9ORNR49Q8o84NC2gvFl/Czn/1tfwG8Fs5xp4P
E65/0nhWw7ipiwngE1hFIuGzEMxK6lWnD3MVKO4VeFozVRlaQKUxsA==
//pragma protect end_key_block
//pragma protect digest_block
MdU0/efhid3GSrTyxMb8LWufE7o=
//pragma protect end_digest_block
//pragma protect data_block
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

//pragma protect end_data_block
//pragma protect digest_block
Mg1MnskokO+pDw7jbFrpswBgHqA=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // GUARD_SVT_CHI_LINK_SYSCO_INTERFACE_FSM_SV
