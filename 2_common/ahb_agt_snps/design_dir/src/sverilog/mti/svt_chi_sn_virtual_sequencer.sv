//--------------------------------------------------------------------------
// COPYRIGHT (C) 2013 SYNOPSYS INC.
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

`ifndef GUARD_SVT_CHI_SN_VIRTUAL_SEQUENCER_SV
`define GUARD_SVT_CHI_SN_VIRTUAL_SEQUENCER_SV

// =============================================================================
/**
 * This class defines a virtual sequencer that can be connected to the
 * svt_chi_sn_agent.
 */
class svt_chi_sn_virtual_sequencer extends svt_sequencer;

  //----------------------------------------------------------------------------
  // Public Data Properties
  //---------------------------------------------------------------------------------

  /** Sequencer which can supply SN Protocol Transactions to the driver. */
  svt_chi_sn_transaction_sequencer sn_xact_seqr;

  /** Sequencer which can supply Protocol Service requests to the protocol driver. */
  svt_chi_protocol_service_sequencer prot_svc_seqr;

  /** Sequencer which can supply TX Response Flit to the driver. */
  svt_chi_flit_sequencer tx_rsp_flit_seqr;

  /** Sequencer which can supply TX Dat Flit to the driver. */
  svt_chi_flit_sequencer tx_dat_flit_seqr;

  /** Sequencer which can supply Link Service requests to the link driver. */
  svt_chi_link_service_sequencer link_svc_seqr;

 //----------------------------------------------------------------------------
  // Protected Data Properties
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  // Local Data Properties
  //----------------------------------------------------------------------------

  /** Configuration object for this sequencer. */
  local svt_chi_node_configuration cfg;

  //----------------------------------------------------------------------------
  // Component Macros
  //----------------------------------------------------------------------------

  `svt_xvm_component_utils_begin(svt_chi_sn_virtual_sequencer)
    `svt_xvm_field_object(sn_xact_seqr, `SVT_XVM_ALL_ON|`SVT_XVM_REFERENCE)
    `svt_xvm_field_object(prot_svc_seqr, `SVT_XVM_ALL_ON|`SVT_XVM_REFERENCE)
    `svt_xvm_field_object(tx_rsp_flit_seqr, `SVT_XVM_ALL_ON|`SVT_XVM_REFERENCE)
    `svt_xvm_field_object(tx_dat_flit_seqr, `SVT_XVM_ALL_ON|`SVT_XVM_REFERENCE)
    `svt_xvm_field_object(link_svc_seqr, `SVT_XVM_ALL_ON|`SVT_XVM_REFERENCE)
  `svt_xvm_component_utils_end

  //----------------------------------------------------------------------------
  // Methods
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new virtual sequencer instance, passing the appropriate argument
   * values to the parent class.
   *
   * @param name Instance name.
   * @param parent Establishes the parent-child relationship.
   */
   extern function new(string name = "svt_chi_sn_virtual_sequencer", `SVT_XVM(component) parent = null);

  //----------------------------------------------------------------------------
  /** Build Phase */
`ifdef SVT_UVM_TECHNOLOGY
  extern function void build_phase(uvm_phase phase);
`elsif SVT_OVM_TECHNOLOGY
  extern function void build();
`endif

  //----------------------------------------------------------------------------
  /**
   * Gets the shared_status associated with the agent associated with the virtual sequencer.
   *
   * @param seq The sequence that needs to find its shared_status.
   * @return The shared_status for the associated agent.
   */
//  extern virtual function svt_chi_sn_status get_shared_status(`SVT_XVM(sequence_item) seq);

  //----------------------------------------------------------------------------
  /**
   * Updates the sequencer's configuration with the supplied object. Also updates
   * the configurations for the contained sequencers.
   */
  extern virtual function void reconfigure(svt_configuration cfg);

  //----------------------------------------------------------------------------
  /**
   * Returns a reference of the sequencer's configuration object.
   */
  extern virtual function void get_cfg(ref svt_configuration cfg);

  // ---------------------------------------------------------------------------
endclass

// =============================================================================

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
lbfzVXVHPtOjzFYD+qST5bHEqAsdhfmZginOXBjMo8EUaVQ2Xjg1n+2h41EKbYJR
j4bs4sDPc9tQNt5nAZy2w7fvbzF+4ihoG7eEzuonfyWAInrRwhkrbo6fENYZLBa8
Jzy4Kcdb9J7rG51TEZiUden0bwvOjM3+6EcWuPnryNw=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 378       )
4m1OVTKJeN2kwkkq641TIC2sIzi1EcjAyP7kPsKtb5Anuw98oJjDxzpBUqsvKq/e
NUJ6AuMi8nqMrrh0Gutlg+AaeKM7dzQMltIUROsez3a36etmN9BacsVLkwi8hhjx
BR3PvXsBnhT0xp2BrbiIlIO7eTO4eAx8pYacdwmoUtff1b275ywb092b0nsCLaJ3
G7VOOXUfuXPGokQy3xBe9po9q4o4vWjLErvZDUpjTXxV0px5movmLbBx3c6DSZJX
h150N+bHe0MQ1+duhA028/qKxxhxlMyXGbVahSaGGcnBTCl4PUO6k23Ua4Ig6qkP
5UQWXuadfM2gtHDDQbgRSFn9LCbgg8WGiBB5+miuyCmZ03JtYMObm7AxLMl8oJFk
i4N7hXrCGbGMszZc2k4VXqJBxCDN3XnKJXyoTqcbsPF7sgRawFG7bZfUIZUoTKLb
6jgUYn92wFHX112lJ8HMAtYg/oxvcQ/s6RsSW3cSiVs77dmGxxnG8OkkmZ4tRXeh
`pragma protect end_protected

//vcs_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
HHl3Pqyh/JvqSINwRBI54WaYBmL01JiflLJyKu+yTOmTzHRLtjyEdw9XAxFxUWa6
L5Ph3ijiTkmHDO49DnQfhQoPjPgQuvJcVKWGBvhhoblx53Tcw74D796Lf113oqAy
PDldfZbjKm979DTnHATDPoMSIwwLSc7ye8PuIphXbpE=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 2620      )
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
`pragma protect end_protected

`endif // GUARD_SVT_CHI_SN_VIRTUAL_SEQUENCER_SV
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
PdAePgLOmU6IdhS1g9wJp7yPVoFHEJIE6cjkHBidARlgW+s//LafBvL59W6PmGdN
wSEyao8KnazqvvOKFhVTc1JENWysI7U7tgA+NgtTyD9iRRns355HxHMA6fFCmUoM
OQkbk9Oekbea4hglldZynbcNJZcUTtoOooyCIEIjFLI=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 2703      )
ISHK9gvigLpxPv6ugoUgdzo500JfyjvKmkRRrMp2T5DYKoUxeXmFuLGsy9BL3NYu
7l/e2KKjaJZSqL/Gc4l+/f4idE4LcawZAJIBollDqlWZDME7dc7OMYveDjC5aEmg
`pragma protect end_protected
