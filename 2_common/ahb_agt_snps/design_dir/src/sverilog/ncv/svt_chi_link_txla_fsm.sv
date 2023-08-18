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

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
8zMYwbXWtQOjSo/IJAL6YT6ntghcZip1pqcZtKPoe7+Z4IDnEPCTVpPmBT9g7X9b
EfeNbaDxTFokyHpjMcbc4k0uUV/ilsn8fb9Xdb2XQAvrah7Oxqh2rYiz9gZ5dkhh
erp+KcDzNcUhPBccOPui0yDAyhQNNExyGTC/8OiH1X+tEZFggJsASA==
//pragma protect end_key_block
//pragma protect digest_block
MkTKeoNFPVG8fOh8uO7xmjb6kVc=
//pragma protect end_digest_block
//pragma protect data_block
Bm/bR71PRBKnUQf2JmDP2T2BFKPL/uWl7pMOlYg4ooN4Yw0JzBIYpz+WIUu0XCPd
uCc4izz6h8WxXDT90TLvoDVTmMifHe/4llBDEePzEEuAjQfxKgGlF0kB4c3UqAbd
HoSI/lKEJIGSpcYp6q9WlsvT+ePFNohDc03drVO5JauCo5hnPzaz3ZkOpT3I+gWL
5+TVi2R/QUeoqxB7IdK7Yq2C2Ti0E4tBAntzyEMXVyjpXEnpeNJelXuSOtmQtFHB
gLdoD2tbQT38r8M+fj5dBUr84qKndYbYubTb1GnM6iV6zE8g1f2QleZCdXQ7AHF5
TrJd7BfVUvk76YjznYNMyn4Z7L1NwhS3zX+Gav/WhJCrR888CS1ip3cgTmDpwb8k
h2/7Me3QtwV5s7T5IWTlX2wBQcI4vlGpEMMM6o6yguU7lRHVWSO0IScTiBmdDn4l
oE/chrq6aZJCnNLZxhqivPJhOTcExvTM0eYa5pB/B/hiGOkmQ5BYgz+Ps3Cn5uWL
uiASMvO29/5WFAi+TtCODq48rtpetf/tg+pvtDzf2L2gi+dVmMmKwxF1nbJz9FL+
ixLK7W8o9OzeJD4sTnjmLlSrpA4Qr03Xl5ZwbOAkhSz7FK7PM2uKeNPrhyF6TDgv
9Gx4Go5G2ZoTHvXAh6JcYtKkI1s/hNE+6vlD3R1L5c7keQLt48xt8dVzKnKLaZzk
tPBkhQYpbNw0+vyJScPxg3ADvzdvgoT6JMIyxuWEbwNjbw/9Xqt4Dwxe0v/tUrST
V9G1kXVkKevr0e1tlVuCGZwZftzU671y67nJoNJ45QTofXnNz11pWeP8hAuyQUSS

//pragma protect end_data_block
//pragma protect digest_block
3iAASGLuiW4bbZa7TQR1bCG6RBM=
//pragma protect end_digest_block
//pragma protect end_protected

//vcs_lic_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
2SOeouuE8DbNMA6ydqipSuBzAl5piWwo9Mg/HkZl93qjaqXXKM92CjUmvhD+dVQm
G8fUG2uXZB+VelNxt9VRGaPNyMcIn1HngHD8u7aIcg87f6eF6tjHfNATHrGQx6qc
V02Ip0IyOd0DxpLlL/saoYmlJzelnlZktYqpjZs0eTQCYOX3Bghczg==
//pragma protect end_key_block
//pragma protect digest_block
KXghQKtQetQCRb5uuEl3Jl59PsM=
//pragma protect end_digest_block
//pragma protect data_block
zh0y7WqNaKPk1Ojdn78Yo3rmz/puoyuD6xCnElP2vBymHm75E+uawoe/rlMIKnZc
g8j2gZ+Vlmm1hb9z1Egm4QVkwGS6CDvfyJrniYj/jXLjm1qNK1AMKQ7gyInF2dQ7
cALPNN76fIzAeO1Xj0tAfV0AjJxVmbYLgZRLYYQ5APnCdWjL+PV5rgtXU5Uq9u5S
k5txgdw0og8f3EU9/u1WMoI7AYvxOvAhghEkfZQUdmWXe+PaKPNLl/04soeTcT8W
WY08iBvw6gKjWTSuvqF2pSZQdEq55YzDNbaVQVDi7+U8iukuVzgLgooQPZQUXiTJ
EIhP6Vp1HUfaQjXPZyBZRNwYIaosYwXKLN1kYnebVNs8CaHAWyppaj7qQv6+zDgF
mKlKtLkq9KhO12Z+G+cJi3AP7xZ3C3misdORzmjTt29aMVtEeOL0yak+sWmp0ELO
zbocwdLqNOnjN3OeQTDc/LitpwhRXEzaZbHiDxR3eQiSBDYXRKwuZn2OLuXMXngv
ABwo0D33qXK4xIs4nd97ezM+FISGqiPGQg37ksRopgq+TZD6yYE17LjKDX+qdCTT
pQHoCZXfavFygzMRKbgj3u/hwQUWR5acPkyOS5Vhsbr+i7pSPCbGi1rXGS7APChG
KNUeS4L+wIXc1rxkrMbmNeAwjzD8aC3/EwGCwNm0/v8heBfd5DIEN4tnlM40FJhC
UuDmLOBrGJz3kHrlk0K6uS6ssKF19bO6YQgPPN0nUWyaoZ/CjWNC5/wXJoESA1Am
xZFvGGlHrw7rShicIQd4IUTnxpB5cnVAVaa5C9oYI1aYSsUihraaSeOgz+kK8Wlk
twtab6dLQ4ftDfO3dnCh9akQi3kpN7svc3cMOlh0o0wONCVzumF+sFrsmRrMbulM
/okkxnFf3MjtLwshxfNtzuQJuXIbpy2Gz21IurXCW2Wuwyq/iMM1BC5TumvCB9Bc
xkp81P7qxgTgl3v4nptevBnqGjoWRFqAYcT7ejskehPzPW1CoBzeVOwWKShM1EYl
w3tOzjYSonynB9JNFEK7rBoFv/gFxnJSX5djoSxcplDvFcWZCEJnM+oiqtC3IBRD
DLL73tWbh3kvKmpycVlghDvehi1tcT/Cq/l9vjAvKgcqvmN1/z/5CPkOvrwThK6K
WeaeOmsZfToXs9d7ouW4bNfFgpL4ItQELiNLxNqsxeYaYeufhiX4ft0xRQQg1ibl
joL/AZN1kSfqUgDdj0LqZ1c777PkXgg7X6T8edZ4XA0g2PLIsLMfp+1tArbhQ8Y5
4PuS29wZrQ/OEYWWcBAH3K+g5/rZ2mZu/dJ2mtyd66q+/O/3dSBgLcF6/W+04UFj
WFU7indyUKZqKwPalb9EN/5nKKk9aAakjRORA2UEYTyW+HLoSDczO5lzfNJP0jaW
44rTWAI3A/vIlAbpfeCSDvswI5aF1LXbW8fA1pAwBGJJJc5ASOi84aQ/S2VejEEl
FjpuFQ8KXBErEQzabYiJU90gT4u+0tedxRyK14bAQqY7UOjyCTw7SppdVXIqsPsg
hbmUO53G2he8Bm9UUdaxdCUd7un+PVWtgvPbtG/bmfJCz/U15FDwTfhYK2ECd04/
dVw5SEogoZBZ8w/YikUr+DzB2jGnJ8NE4uDr7aGrv0RnKw39aacCDucsU43Nsvvt
uRVblDb8/ey5Cj368txNCi+EyH6mDhaJqLQLy8fOcF2G5/8qtyTYDoXNQjHGCYO3
moksRg4JJD3ToUiWsVxWjg==
//pragma protect end_data_block
//pragma protect digest_block
4s6HgwP9MFPEFE1mLa4+2QwN/kI=
//pragma protect end_digest_block
//pragma protect end_protected
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
hKUtMJg1nRszZA6wXL3Z710oa5lxyR3LHjuLFqeXz23WVxOSFYIudWLizEo37h6n
R29uIlQVxGeG0n9trGJL0LgYqMbwa6U7OIj/pX/ZGb7CUWiO9hQGYCj2OR77T1z5
uzbfOT3+u0XT1BKlPkkI8WVoFDgpQFdQF79PEl9gbZiN2UepRLl0QA==
//pragma protect end_key_block
//pragma protect digest_block
jYnFtCmDpQN9zCmykNRI9AhBoGE=
//pragma protect end_digest_block
//pragma protect data_block
Hi5zU8Ogy6vCdcjt3vr9T0pMpL5mYqcvhKoJk/wE5Jbh41+7uGeFGoCZ4a+g23eD
EV3I5tt06t1Pf+J8NxcYz5+tOWiDOGFwiE1+JthpfIxlHsody0OYaNlJ/S3jpRK4
BGYZK8u6wYrq5tSxI1Zvictx82EX1VqwgNpgpGd+elC6xxpmtwl4s4Db6GiQEcnI
FMfag9Un+emKNe+tWxHJdqN/Xqi0LVE/xGhkdJFgt0YIMekf6WWYDvXS3rZ8rHHy
ELhiw7h1r7eSSz6UIuW0/jLPbgNP8SV8oUKYm694J4LYS7HrgXge9kLwYVPfqLj+
LMAkweT8+4xCMJiQfEeQsEEuVrbAPikHKMYr97CoMUb3XVx861ttj/sQupkfMhGC
Bxa8YaAm4NNy8+T0osIB7zx6pXKdWnY50DslD6z5XtkCg4Uh4qE6xE5Tb/9LMs7p
0rRYlmecC6ZEa8iuemYqNUik8ooES7fmiAVq2JNBedYtoMea5wJqHmhHbPEs/xWB
u41UbRNpKxBgEI6b1YgKkxUXqdg68UrpzuAbdOEBB1iphD+G9J+J262VwkMPuDsZ
0ExskPOAXHJhAWeBNmHZobSBdJyh63r9R1V6cX+D/gfYy97FpJ9jZm7V8R7ObgvN
XEwQaWp9cwcaW2kIx4k3re2TfTm7z1Q1GYyR3rY20YTrK3Ghw89mqqzFkuVyNzJ9
JrHZnmSfzqWUugcpA4+gfXKjl7o9YnDklLX5iT5C7skbqJsAxKUgWgr8ZrsoYxsh
CZ+nICSp/0AHw9+XSHp5oT+PYbn3HPsq5LgwmyjEslL2m8yIUQupixU1n5Kk6Ojl
ZMq5BXoOtGYHMzWNVUGs8lo28s2KFuG26sYEHv1flBuIoMrbHeWGaSVCeD7v2bcY
n57y96a+Fg7e7qZLbBuBQOpBGSwdEhrhCSv748TwLUVV7KpF8pvZQ/9v7Qd/nuGA
5NB89Z1f3zRWJwnbHFnhg6+HJyMdh6XqCtcyxyn2JFkvDzxQ9hSRP0uGZbny8xFx
7QtNvsQqoDx/CbwUaLF/B6V0UMWWHJnFb4skncvjLn3b/WL4fDHRBhO6gnE9WaJ0
j9Ax/zpUMnBU2qgh1nIkq/t5atNoen+ellDdGT6Mu1yPlSRUQuk/lwdAzcNOR7KV
pfXdZztu/RE2SQsA8rYqRwFNCbx37wQhblcCBNt5+1yrQRy+CZp9chIjvf4RLkSd
G5lsNRVFLRf6Op15LzDZL86ZU96MNMRC/WW1eJpCJBrB28tLaHny8RLPk7b1RpbC
mrWt6/Ft3Fd9OHjyYY8lAUtpmJ454IixxzXdNFWypm9nKHJpX6uNpt79BZkwp/zT
uJDM/6IkidorQ4gDGh4ccQ==
//pragma protect end_data_block
//pragma protect digest_block
yz7LTGrpoiFGRsmuJqz3Twwhotk=
//pragma protect end_digest_block
//pragma protect end_protected

//vcs_lic_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
lsDK/4OQhNFyOoo2PccgBU30dbHz0yWaEPRmzOFe9RJqrqoEpZPo2MYDw65OcuKB
xdaaTnJA9l0jHC3VTq7jBiI9OPiHZlyKowjIyfS045yJXWluym3Z9VWqPMkHBISs
cjDz5KmdPg7EOa1jfx5hnRUFb+HARwq3eN2P3xdjSpFZi8hUYdDjSA==
//pragma protect end_key_block
//pragma protect digest_block
B3llMY1CHfemOC8A24JsU9711zM=
//pragma protect end_digest_block
//pragma protect data_block
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
6GJz4UCJgFnrBf11cnvFTQ==
//pragma protect end_data_block
//pragma protect digest_block
/sP855a1j3o6u+V+b4yUgHAHY7Y=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // GUARD_SVT_CHI_LINK_TXLA_FSM_SV
