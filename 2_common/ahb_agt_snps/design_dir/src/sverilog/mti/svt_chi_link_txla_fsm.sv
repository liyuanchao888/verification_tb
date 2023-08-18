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

`ifndef GUARD_SVT_CHI_LINK_TXLA_FSM_SV
`define GUARD_SVT_CHI_LINK_TXLA_FSM_SV

typedef class svt_chi_link_txla_fsm;
// typedef class svt_chi_link_txla_fsm_def_cov_data_callback;

// =============================================================================
/**
 * Class implementing the TXLA state machine TXLA_STOP state.
 */
class svt_chi_link_txla_stop_state extends svt_fsm_state#(svt_chi_link_txla_fsm, "Stop");
  `svt_fsm_state_utils(svt_chi_link_txla_stop_state)

  /** Define the 'from' states. */
  `svt_fsm_from_states('{p_fsm.txla_deactivate_state})

  /** Watch for the action that initiates a transition into the state. */
  virtual task state_transition(svt_fsm_state_base from_state, output bit ok);
    ok = 1;

    if (p_fsm.common == null)
      begin
        `svt_error("state_transition", "Link common is null.");
        ok = 0;
      end
    else if (from_state == p_fsm.txla_deactivate_state)
      begin
        p_fsm.common.txla_state_transition(p_fsm.fsm_state_to_txla_state(from_state), 
                                           svt_chi_link_common::TXLA_STOP_STATE, ok);
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
    //`svt_debug("body","The TXLA state machine is in the TXLA_STOP state.");
    
    // The link is only active when both the TX and RX state machines are in the RUN state.
    p_fsm.common.shared_status.is_link_active = 0;

    // In the TXLA_STOP state, the transmitter can neither accept L-credits nor initiate flit transfers.
    p_fsm.common.txla_can_receive_lcrds = 0;
    p_fsm.common.txla_can_xmit_link_flits = 0;
    p_fsm.common.txla_can_xmit_protocol_flits = 0;

    // Reset the following flags upon entering the STOP state, in case they are already not reset due to
    // dynamic reset condition when these are set to 1.
    p_fsm.common.is_first_req_link_flit = 0;
    p_fsm.common.is_first_rsp_link_flit = 0;
    p_fsm.common.is_first_dat_link_flit = 0;
    p_fsm.common.is_first_snp_link_flit = 0;
    
    p_fsm.set_txla_state(this);
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
 * Class implementing the TXLA state machine TXLA_ACTIVATE state.
 */
class svt_chi_link_txla_activate_state extends svt_fsm_state#(svt_chi_link_txla_fsm, "Activate");
  `svt_fsm_state_utils(svt_chi_link_txla_activate_state)

  /** Define the 'from' states. */
  `svt_fsm_from_states('{p_fsm.txla_stop_state})

  /** Watch for the action that initiates a transition into the state. */
  virtual task state_transition(svt_fsm_state_base from_state, output bit ok);
    ok = 1;

    if (p_fsm.common == null)
      begin
        `svt_error("state_transition", "Link common is null.");
        ok = 0;
      end
    else if (from_state == p_fsm.txla_stop_state)
      begin
        p_fsm.common.txla_state_transition(p_fsm.fsm_state_to_txla_state(from_state), 
                                           svt_chi_link_common::TXLA_ACTIVATE_STATE, ok);
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
    //`svt_debug("body","The TXLA state machine is in the TXLA_ACTIVATE state.");
    
    // The link is only active when both the TX and RX state machines are in the RUN state.
    p_fsm.common.shared_status.is_link_active = 0;
    
    // In the TXLA_ACTIVATE state, the transmitter must accept L-credits but may not initiate flit transfers.
    p_fsm.common.txla_can_receive_lcrds = 1;
    p_fsm.common.txla_can_xmit_link_flits = 0;
    p_fsm.common.txla_can_xmit_protocol_flits = 0;
  
    p_fsm.set_txla_state(this);
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
 * Class implementing the TXLA state machine TXLA_RUN state.
 */
class svt_chi_link_txla_run_state extends svt_fsm_state#(svt_chi_link_txla_fsm, "Run");
  `svt_fsm_state_utils(svt_chi_link_txla_run_state)

  /** Define the 'from' states. */
  `svt_fsm_from_states('{p_fsm.txla_activate_state})

  /** Watch for the action that initiates a transition into the state. */
  virtual task state_transition(svt_fsm_state_base from_state, output bit ok);
    ok = 1;

    if (p_fsm.common == null)
      begin
        `svt_error("state_transition", "Link common is null.");
        ok = 0;
      end
    else if (from_state == p_fsm.txla_activate_state)
      begin
        p_fsm.common.txla_state_transition(p_fsm.fsm_state_to_txla_state(from_state), 
                                           svt_chi_link_common::TXLA_RUN_STATE, ok);
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
    //`svt_debug("body","The TXLA state machine is in the TXLA_RUN state.");
 
    // Records the simulation time when the TXLA state machine transitions to TXLA_RUN state.
    p_fsm.common.shared_status.txla_run_state_time = $realtime;
    
    // In the TXLA_RUN state, the transmitter must accept L-credits and is allowed to initiate flit transfers.
    p_fsm.common.txla_can_receive_lcrds = 1;
    p_fsm.common.txla_can_xmit_link_flits = 1;
    p_fsm.common.txla_can_xmit_protocol_flits = 1;
  
    p_fsm.set_txla_state(this);
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
 * Class implementing the TXLA state machine TXLA_DEACTIVATE state.
 */
class svt_chi_link_txla_deactivate_state extends svt_fsm_state#(svt_chi_link_txla_fsm, "Deactivate");
  `svt_fsm_state_utils(svt_chi_link_txla_deactivate_state)

  /** Define the 'from' states. */
  `svt_fsm_from_states('{p_fsm.txla_run_state})

  /** Watch for the action that initiates a transition into the state. */
  virtual task state_transition(svt_fsm_state_base from_state, output bit ok);
    ok = 1;
    
    if (p_fsm.common == null)
      begin
        `svt_error("state_transition", "Link common is null.");
        ok = 0;
      end
    else if (from_state == p_fsm.txla_run_state)
      begin
        p_fsm.common.txla_state_transition(p_fsm.fsm_state_to_txla_state(from_state), 
                                           svt_chi_link_common::TXLA_DEACTIVATE_STATE, ok);
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
    //`svt_debug("body","The TXLA state machine is in the TXLA_DEACTIVATE state.");
    
    // The link is only active when both the TX and RX state machines are in the RUN state.
    p_fsm.common.shared_status.is_link_active = 0;
    
    // In the TXLA_DEACTIVATE state, the transmitter must accept L-credits but may only initiate link flit transfers.
    p_fsm.common.txla_can_receive_lcrds = 1;
    p_fsm.common.txla_can_xmit_link_flits = 1;
    p_fsm.common.txla_can_xmit_protocol_flits = 0;
  
    p_fsm.set_txla_state(this);
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
 * Class implementing the TXLA state machine.
 */
 
// `ifndef SVT_VMM_TECHNOLOGY
//   `svt_xvm_typedef_cb(svt_chi_link_txla_fsm,svt_chi_link_txla_fsm_def_cov_data_callback,svt_chi_link_txla_fsm_def_cov_data_callback_pool);
// `endif

class svt_chi_link_txla_fsm extends svt_fsm;

  `svt_fsm_utils(svt_chi_link_txla_fsm)

// `ifndef SVT_VMM_TECHNOLOGY
//   `svt_xvm_register_cb(svt_chi_link_txla_fsm, svt_chi_link_txla_fsm_def_cov_data_callback)
// `endif

  /** The state base class implementing the TXLA_STOP state. */
  svt_fsm_state_base txla_stop_state;

  /** The state base class implementing the TXLA_ACTIVATE state. */
  svt_fsm_state_base txla_activate_state;

  /** The state base class implementing the TXLA_RUN state. */
  svt_fsm_state_base txla_run_state;

  /** The state base class implementing the TXLA_DEACTIVATE state. */
  svt_fsm_state_base txla_deactivate_state;

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
  extern function new(string name = "svt_chi_link_txla_fsm");
`else
  extern function new(string name = "svt_chi_link_txla_fsm", `SVT_XVM(report_object) reporter = null);
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
  extern virtual function void set_txla_state(svt_fsm_state_base fsm_state);

  //----------------------------------------------------------------------------
  /**
   * Utility method for converting the FSM state into the corresponding TXLA state.
   */
  extern virtual function svt_chi_link_common::txla_state_enum fsm_state_to_txla_state(svt_fsm_state_base fsm_state);

  //----------------------------------------------------------------------------
  /**
   * Utility method for converting the TXLA state into the corresponding FSM state.
   */
  extern virtual function svt_fsm_state_base txla_state_to_fsm_state(svt_chi_link_common::txla_state_enum txla_state);

  // ---------------------------------------------------------------------------
  /**
   * Method which checks whether the provided state can be reached directly from the
   * current state.
   *
   * @param test_next The state to be checked as a possible next state.
   * @return Indicates that this state is (1) or is not (0) a viable next state.
   */
  extern virtual function bit is_viable_next_txla_state(svt_chi_link_common::txla_state_enum test_next);

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
iEKGNgSFiQ6XPbK3hG5S+QGgxff/elqzvsYGwxl4W3afhW1Wvw593DbDodicc8Ze
GiJ+gTN2ftV5v6QsS1bGZ3QwPJYgN/udyA2M8yJkbQ1Oolh8SGXjADGcHoQ3va//
c5oEbeub4c4PeCDP1Oee8FP9ANjg0bjQ+jJH7ZXP+Jc=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 455       )
fRaLwLNX8p4/AuSmfI3VPzYx1LeWuFiN9uiGYsWDCm0PDm5HlmOHlfqqVaQJWKch
QcRnIHIhtV8+z0UexQDaFWlA7TgQDUEtyS+6S8Z23O4KQWX0RDxJhrVjPzBMryPu
5yaxhnqskbCvSX+AFoIHMcVOW7Mlx3p/DQGRoXU6C0uUhZCkChU0oMGOcRyz2/ng
riq1SffFnIhT8iy8rEPwXfZ+LJTG52qAmC5ERSgVBW2aCwfIecC0Z0EDysEhz9xO
sug9zFe68naheBJdciuyoRAR5DGaaollV8Goysoo2UiuhD3G8onvRj5llMb7UraB
uaBvf9WlZwPsYz75nxip8pqFc3SHF6ySn40jKF8/QxQCxI3Y5AN5POyxBdecEYSe
SWzenNx+QckBbZhkQMbnWHmhXMx+q3IVHUwxVd8hWKRFpZ5+636CgPg9JcsKCYne
IJoe/cdKuOrrY+whF23eGymfoPlyjYFQ+KZZKoRDpzfIqxEbhWRtI2q0DhvaXW1t
Z0ZLIKg3TNXhcowxeX8ZyYi1Rh2vk4ZYqUT9eGO5rNMe1fT+EmSwCOyan2eSFsUw
G09sfNLjvqAmoZFthqdyyszmNCVaK7TOV0o9tW55gxg=
`pragma protect end_protected

//vcs_lic_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
FPtmJ6ffTgSOPwYjH2t9SEjHCJBiLRzWMCjw0nl7odc0tweYsZZiesswCs01jl2o
mLO+5DmBF6YufqWgDHnyaZsYXFFyB6AcTkWFw2CTCeiKO0C49iM/VWxC6cviYiOV
nAWR1k+gIn5MhstuekcYuJTk6l9GCX4RcHcXaED83/g=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 1601      )
vgjmbgmsxzIVZXKPDaStf9v7cykCOQlBZaCKBFyZlQFqcp4sfA7prdZxk+nEU2Z1
2DwopyQFZ3AOgqxt88/5Fcs4B69TSYhjVbNBwLHtP8CIA5Lhq8xiFR06WBNAQxhW
s4Hzr7Dvc0ajhFYmC5rBqpIR87mxQZCLOKD7z8IxhOO5ovo9rjNDM7BUzBQCczUc
USdjYy+zfpmbRS4778aLd+aOi2ig7P/VAuTMS7gA6EVqMlsLKaXRaFJ4r93ERHWR
CgeVqLjzNJ35B8jjtZuooEGtf650H+SEbUThk7scKpmkaKL/TsJBWUZUwRxntB/G
4S1KrkKv4pqFTCM74qcpmXseW011F3BuYGCeKmx+6QqV+OKQqvlZORlpJInB11Qx
ahjf8NWj7Gx612AmVl8biReGOXO6nrnE0/OSMY3q9H1jpo6wQsGPGQidesjpErcd
57vaYbpPPpbPxNvYidFF2RetA7J8SBMnS25qr7sZL4QTNsvzgURoKWfX878R0goy
nWue57FkQUWyNWLJiCJwFTz4mvxjqbJH2uumKrTNlDdu/vT+ysrHn+P9qj62ntes
R2iv++F9FC1FAPJiCFz/keZBTVXDAeRQm2QQLdteT4Be5B0sebYxBM/UhIapznX+
6/RMqtxquIIN5NFzhHHM1Ir9qooUktlLS7QSWBeTtRC6E3hJ+00uMNVS1+GEhdtl
tyHEohvcBiWaTsYPiXbZ5BrqQ7OYsS3l2t2Y2+cvegLwY0Re+U1pf2fvm3C+BJ1T
f6YZQphj9vZ3Ml8uufdnNOLBMToMXY5glAqJbmBENBzAt3MjLqYMsLilCrdY5Vne
w4RzBt4L1GfXSodc5pukYgkCw2vBE9BKs/FjPTRUwwB1yUs1OQLGG9zjib9QLuZO
OiTaGamu3aKEum6NcmLdmMcM2k7NLFAB2/a/yn27PC6tqpwrz52J20lSsAEfUSL5
/2d4HjEzrbx9njdk1EWS09aIoW1hKexqbUqL+AMidtvYWU2qlhD39cDdQPJyojbO
5izeLSD1XwjjRWOBewSY/is1pjkbcGj7y1d4yOORVeTaCTF3psm2lq7ageDbsqDR
+1aJBp+Wk0iVTM3Xvwi3NT0Ay02j3sK5Ooc7JlB+TMexq6UWBH18H2TR00ItCkED
LmQYjDyfD2MqHu4744uGPKcfrFunSF61ZzxtM5c5loc83xduW4RCEcQoduQ27oyr
xsdgnp/tdsHf1oMzjh53WkKyuaX7mFvqfWyFedGaQu6SJofQ5KtCbOrEZQDIzJ9P
EIu4iKRRlsPuC0E+Ik7FDzF3obkEQklCE1jnu0AWPfbnEXImk5tDde46I5mbGgVx
YHNy2FLgoK8KwI0gg9EvB32cwfSVgedRIy3y99hDmpEWy1mo8vAhP/vreS5r0npd
d00OxiTmPKp8mneFcRgtjBvdmPsDGORo6NML74tWSvo2ET6VNQG4AmoC7ig8D2WQ
6nK0tfDJWiulKbWBK9emAZ9ZNC8k2C7Sg9hPHx13JLuwU9FszoxCIOZUD0bM3ezu
`pragma protect end_protected
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
g48bz2cjBL6xvEWDZm2TEFKjqbMN3thSD4YFTSL3Q4GeIC3JaBrjGqTa6eo6aBLB
i0s4nedHiuP49XR6ecTbyI8YBkV6H72N5awW/6D/BhD61cBSHUDzmxt1qbXs54DS
slNzAvSfX8Ynsv3GJNAm83RcPIEIUUnUD7/fHWimHns=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 2449      )
CiRmSZtVdG8z4LSr568p5a4v/PJpZQihvWjtnna6B7v4sVARisi6JBjxNaNVQlCv
UHxTkcElW/9aBcHuEfEwCf/i7vBsxknBl0h3d5stu7J3LmYN+RUQkhTJB6oHmJPb
s4e9drla0krRrCKQ2DLDr52sqzrvrOt2G55J7BQvd0dRuUN5vGKndVUGGw+M3KJS
ZR6aw/EMGnH9QlT9eEGsKiJmUqRHt9w50/4aCN4cb+2xSIrmF6HgH1E2bUoBgvkJ
0r19Bxja9cJjK+YSdTsu5TSBZfdAHW/7ce3AeIr+AB+ZuS31FEPhzL7RhIwUxW4R
cRs23EvkzYfsFiDvUcswdKbhkqW4s7t+XHsK7yECWqHzpQqCmGOja/MIY6T3s63W
DP21STgiyLxfl7U+psvKIODjenNuOaGIjUysykAzs+t8KAzo2bmcriHFaan0aINP
+Sz2zCWlh1bWeoq2CUM7exnZeQ10E3ycGmTM+/Rd9i5+mfS497gVYRxxUtr1SL3T
jS8bqeBRFC8uFwUfcUhBJGFjeV0rYAOwE12seQcvKF4y4Y8mMU4gFZag7v2FByrt
SfxGloUnyROfk+WbwFAgETylyMH4LeDE73l5LWx/71AGtH63ADN+ZDnuW0ZTUmN+
FnDiTDuo1jt0k4QQfk7FqM2bINtLyaJ/g80CFU6002fKn5N5EMRDIv9XUFYfG3Rx
rYxUEsVHRtX2TwgwQNKX358qBOMoj/ElXb2UkKnA+HythTS/kqj+fd8yD55Cjg0u
CvyD5Fthvb0cNaiCEMczPp3MKiZyRpU/EdZOj4D5KvYSy9DIpOL4siXR/L1cDqTC
CbgB0/nCbbhrycswHx5U8lzgTWVzBJaeRKP2OU4l1NA5lG/UQz9jRILGlhhQbhBz
t6ORcCtCz8AkiNeBVJLHQ5C4jcmn2UJIOQjYjm+8TLq+Bl6NSSAMXIpPJJPecYJz
ZbQDsRjLfeNonwOOWB6bZWo30I5/ttU/s4rX5hBmj48zLFJnqSEF3YE1qrhzeSFe
mUFXRBjaMj+hovLzwZVM6Aa2D2zlgZs2BZTGbxhv2uroL0Djrn5fT96UhymRJbUl
f0Rs96w/HNu4rK9bKemT++NLCf3n3oK+o4DtxZPNwZEokBHarkveCYyWUZCXfdjF
`pragma protect end_protected

//vcs_lic_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
csnnq8BSIneXjO58pQOvsaFwQnv99Xr89bslB3qM5c9MyBDX70exBWLU5s/w+ab7
qZD1CeoMhlKx0QWHoirPwOdh8kGzg7JJo0P30digPf34DuwwDS5iCe0wXAf9xtOn
iA+waSLRjcj2aGdkU/qsk/Hkfwt5cD8SLmpAs6ANh8o=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 4978      )
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
`pragma protect end_protected

`endif // GUARD_SVT_CHI_LINK_TXLA_FSM_SV
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
LknzpKoGeEVkL0xjsyFuBuOmAouKeTNbaUHN/Q4tmBGJTdlZZU9sHtdLbD89b/8Z
BctiExs2zM5576FPBlTVvyikZvXNKtL/Eel/xFLfbprBvSsh975wKYKmNV1y4NJ5
zHYdH4+qTCQnlO0wHADKqRkU2vOabD3DM+T1vbVnLEA=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 5061      )
zkg+gJMH01XyWmNqS+q7Xtxd84iWw53S/9DT2rkIHFdqYChjWWzZMj+Uh3VnoFBr
hyIPcK7rMW1AqVfPtnrLM0ouVFRZ9KybxrjkKFajrOD3tqGdeH1vOrNZ7OZUiKNd
`pragma protect end_protected
