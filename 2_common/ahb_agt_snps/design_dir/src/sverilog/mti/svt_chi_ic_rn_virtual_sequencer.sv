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

`ifndef GUARD_SVT_CHI_IC_RN_VIRTUAL_SEQUENCER_SV
`define GUARD_SVT_CHI_IC_RN_VIRTUAL_SEQUENCER_SV

// =============================================================================
/**
 * This class defines a virtual sequencer that can be connected to the
 * svt_chi_sn_agent.
 */
class svt_chi_ic_rn_virtual_sequencer extends svt_sequencer;

  //----------------------------------------------------------------------------
  // Public Data Properties
  //---------------------------------------------------------------------------------

  /** Sequencer which can supply TX Response Flit to the driver. */
  svt_chi_flit_sequencer tx_rsp_flit_seqr;

  /** Sequencer which can supply TX Dat Flit to the driver. */
  svt_chi_flit_sequencer tx_dat_flit_seqr;

  /** Sequencer which can supply TX Snp Flit to the driver. */
  svt_chi_flit_sequencer tx_snp_flit_seqr;

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

  `svt_xvm_component_utils_begin(svt_chi_ic_rn_virtual_sequencer)
    `svt_xvm_field_object(tx_rsp_flit_seqr, `SVT_XVM_ALL_ON|`SVT_XVM_REFERENCE)
    `svt_xvm_field_object(tx_dat_flit_seqr, `SVT_XVM_ALL_ON|`SVT_XVM_REFERENCE)
    `svt_xvm_field_object(tx_snp_flit_seqr, `SVT_XVM_ALL_ON|`SVT_XVM_REFERENCE)
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
   extern function new(string name = "svt_chi_ic_rn_virtual_sequencer", `SVT_XVM(component) parent = null);

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
ERKSPRnhTPZubxQ6uICxVdDrslqKYyWN5uwhnE5wnj62eOwNnVFbJ5A+ai6W7aIG
tGBrm5Epg0pC3gp4Yr2LMBKB70qpt6nKq9k0bzgeWQ6JcpZAgUwITF561J8Lxaj4
t/Fy97IIlPAotoWlfDsWbvcVAwBEL0O9DLub2l2x0/w=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 383       )
nRy69bnSXYUvintibJiK1UuS5TOqgixqUJpz9/9oV69LeWQVbSKtgjK0LZk5jZcH
L5jV16uZboFupnkEVODKAY1OIkJl8r1ESaBkHhkoaX//GFJlLNKj6jY2DZk0OViu
JMf/eRkedvDLhOFq8VypW/WFGYcvY7EhCXZaN6O+y5cfWfxXHOXI/x38V4K9hELx
Efp6sV+Ae7L8wPt//DvWPU7OsZxWc37Y73J2+Nb58yh2abYpxZu7FgoTeM0hbYXk
kxptsN/qp//3fRlNkVmO/9LtJlLQL6bGfvJssQ/9r8Lt+k4KyO2kuAfwBsDSb0bh
f9+MVsmw4Vf12WIhKJmRxgOqiAky2Y4oAKp9S5BNJmO6BLi6X8+M2V38+tEwezFt
jkYYLirbIO+IkhLuf06V7JwEWP6xaaNEgN3xDfPKx34z6xdDn2ygyUMtVKgq+ppU
7QPXdTDY+qVXKDU/X5TxOcpwp4jjv8BHO+3XTeI3AOCUUHcCvV3JLdp3Cp/7rfEt
`pragma protect end_protected

//vcs_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
e9ZBW/esRplNa+EaD3oMie1hgAGoZght5YGvxLK/CrtfeYoJ2s1mI+Q8JB/vbyQj
Z6GH+u+sftQ1sbrvdj8e+ZX9Mb1+e75G7g15NBEMF6cg/zSgVM0vJoh1465IHwHo
sMpAWNoneYr/lL1aS6XAQPbAmGBJmS5WHwexg+s4OZc=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 2502      )
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
qb/HEO/xrb0oSQWrRAsM1A==
`pragma protect end_protected

`endif // GUARD_SVT_CHI_IC_RN_VIRTUAL_SEQUENCER_SV
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
iyj7uU7g9xqUqLKYLTixWjQYJoNoTjr0oeqax222Iz2FTdZMb+BfDmYfUCqnl31N
USTzsu2z02/pBFB6OXTth4sDncuRJZDz1TlcPb9qmSNeo98whpPP+/6LemAsszKm
HS/xYRPxY4C3dYpnFIGx08tgFYugX4JICN15SLkd4CQ=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 2585      )
ZB5uCeT/ZJIXmrl3lQDB0Gwg2mN394Z95evkTNvzlJysXXEgN+t37zMg1HRCWIlr
lh22xJMeV83mcUluCyWv2pVvMFlrgvyBf3FjTuEilki7ASEYPS+cfx2kwsl9ptif
`pragma protect end_protected
