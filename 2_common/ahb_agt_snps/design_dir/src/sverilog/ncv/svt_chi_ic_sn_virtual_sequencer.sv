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

`ifndef GUARD_SVT_CHI_IC_SN_VIRTUAL_SEQUENCER_SV
`define GUARD_SVT_CHI_IC_SN_VIRTUAL_SEQUENCER_SV

// =============================================================================
/**
 * This class defines a virtual sequencer that can be connected to the
 * svt_chi_ic_sn_agent.
 */
class svt_chi_ic_sn_virtual_sequencer extends svt_sequencer;

  //----------------------------------------------------------------------------
  // Public Data Properties
  //---------------------------------------------------------------------------------

  /** Sequencer which can supply TX Request Flit to the driver. */
  svt_chi_flit_sequencer tx_req_flit_seqr;

  /** Sequencer which can supply TX Dat Flit to the driver. */
  svt_chi_flit_sequencer tx_dat_flit_seqr;

  /** Sequencer which connects to protocol layer of interconnect node that connects to an SN */
  svt_chi_rn_transaction_sequencer ic_sn_xact_seqr;

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

  `svt_xvm_component_utils_begin(svt_chi_ic_sn_virtual_sequencer)
    `svt_xvm_field_object(tx_req_flit_seqr, `SVT_XVM_ALL_ON|`SVT_XVM_REFERENCE)
    `svt_xvm_field_object(tx_dat_flit_seqr, `SVT_XVM_ALL_ON|`SVT_XVM_REFERENCE)
    `svt_xvm_field_object(ic_sn_xact_seqr, `SVT_XVM_ALL_ON|`SVT_XVM_REFERENCE)
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
   extern function new(string name = "svt_chi_ic_sn_virtual_sequencer", `SVT_XVM(component) parent = null);

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
//  extern virtual function svt_chi_ic_sn_status get_shared_status(`SVT_XVM(sequence_item) seq);

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

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
R0RjhGP2ZC0TUUYaINqrd88sk82Uw6jszE7FJ/8Gmll6MbXgZTyz5ROqTAQbm9pa
5CD1Nwihzcq/woek2fMwTFsRj9iZXIC9i2FUrIYSFJF3jB88mmrzLlWHTCB6K+CX
bdn8RJZFTPfeBwx5AJ9fz7PUYEtUAhfH7ogBn0/LwqyccwTmo5aGqg==
//pragma protect end_key_block
//pragma protect digest_block
KJUMPbZ0/6M7F++oILWHBxzXI0Y=
//pragma protect end_digest_block
//pragma protect data_block
HRynUdgzuKOIJEXtuoFNYQD4yAoZgz8zkJwikJlYzx6h0WUN4CmmRRf4NY9GqxMR
bswCAnEVdCnV+rbbO3cDmks7lRaykaTgu778XTjcIJVmqyxDsKvxHP2MWaK8Z41+
qI6u4EsN++baGiJkxv2QKGELxuziqbU9zBqBzO8h4Zb8j1Do0QUyGetDfcOJZIFy
DYpu8+yalFDAaI/QkkTmgsuTYJwQoLnKiRePXPNjJvD6D/Yr7k6SGa0W3BvdJX3Q
oAzCtoFgQ05BjNJ6Ezevsn8DhqynhMFiPKsuycth7qR7bd9lXlTcqs72LxSgtcCQ
2MFbw28PPIv3PmYmFbT87e6Brr6v248fxMtu5UxPc4FpHM/Ex0kSDVnh48a+9ltz
iEyyI+OXFmwa2JFbr4O16Q7j0V9vT6nz+gA7Sn2FKncQEByVwHMFCgK167czQI//
UG2zIbkNQ8mwQgsMBJx40SqS+nyA0ixmUeIDv/iQyiTYKueZ7omYXfgD6lMCmPKx
LFzjGNUYDWKfkwiaI//gnyAv+O8QWcczqIdGe0Pifdh1w+OLkreTmyHAFV1ET+8D
Y34yeWT5TxYqNgyf3kXbqZzH0GLyLCnDhMrRvCbpgXS3LJR0s02iQZb5aoh4vpXn
0QvqGC9JdIPnXC4Y25c4PODApVZEpLZHX8tUkqSyi5oq3O50C3NB+23K6J7mXcnV
Ez2eyeEVapb2cg3t7cIRj8xvqlMLCM+8P+VGkgRrDgE=
//pragma protect end_data_block
//pragma protect digest_block
cAkU1iXoj5EcYgrkYDIsGTxlv2Q=
//pragma protect end_digest_block
//pragma protect end_protected

//vcs_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
ueJu8iyqMTr8ki9z4LHoTd7NNYhzPDc7YZTiI0yXsugrTs4KLKIAAGuwnLy8XvXS
C88w8vwv7TFhKORztmzXD98yZx/4vN6TzIUmvfa65A7nbEVauvgKaM6uS5u3tZAk
NjxgMrzVdAIVLkFHH44v0j1Hceha9t/vRXYxiyLeqB5vOw4rYHLbyA==
//pragma protect end_key_block
//pragma protect digest_block
goN9QkL6MY8k5vC6BTjiRpJ0mTo=
//pragma protect end_digest_block
//pragma protect data_block
+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

//pragma protect end_data_block
//pragma protect digest_block
RLE2me+8sqlLYNOf3JZ1JtiVpGA=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // GUARD_SVT_CHI_IC_SN_VIRTUAL_SEQUENCER_SV
