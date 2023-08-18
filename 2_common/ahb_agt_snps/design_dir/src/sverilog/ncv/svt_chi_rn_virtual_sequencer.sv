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

`ifndef GUARD_SVT_CHI_RN_VIRTUAL_SEQUENCER_SV
`define GUARD_SVT_CHI_RN_VIRTUAL_SEQUENCER_SV

// =============================================================================
/**
 * This class defines a virtual sequencer that can be connected to the
 * svt_chi_rn_agent.
 */
class svt_chi_rn_virtual_sequencer extends svt_sequencer;

  //----------------------------------------------------------------------------
  // Public Data Properties
  //---------------------------------------------------------------------------------

  /** Sequencer which can supply RN Protocol Transactions to the protocol driver. */
  svt_chi_rn_transaction_sequencer rn_xact_seqr;

  /** Sequencer which can supply RN Snopp Transaction Responses to the protocol driver. */
  svt_chi_rn_snoop_transaction_sequencer rn_snp_xact_seqr;

  /** Sequencer which can supply Protocol Service requests to the protocol driver. */
  svt_chi_protocol_service_sequencer prot_svc_seqr;

  /** Sequencer which can supply TX Request Flit to the driver. */
  svt_chi_flit_sequencer tx_req_flit_seqr;

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

  `svt_xvm_component_utils_begin(svt_chi_rn_virtual_sequencer)
    `svt_xvm_field_object(rn_xact_seqr, `SVT_XVM_ALL_ON|`SVT_XVM_REFERENCE)
    `svt_xvm_field_object(rn_snp_xact_seqr, `SVT_XVM_ALL_ON|`SVT_XVM_REFERENCE)
    `svt_xvm_field_object(prot_svc_seqr, `SVT_XVM_ALL_ON|`SVT_XVM_REFERENCE)
    `svt_xvm_field_object(tx_req_flit_seqr, `SVT_XVM_ALL_ON|`SVT_XVM_REFERENCE)
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
   extern function new(string name = "svt_chi_rn_virtual_sequencer", `SVT_XVM(component) parent = null);

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
//  extern virtual function svt_chi_rn_status get_shared_status(`SVT_XVM(sequence_item) seq);

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
y0RWtJCFL9FWlwDWW6OSqVccuB+lTMUCOIy0FmoZD38BA2/oIP+gpJ77mr3AQsDc
kH6HpAbyFP9RC3vbs0MvvuJCxjM/IE/FGeJxY7BwexGWzMe1Vl0x2MEJuL/8XIgd
ua5l7S93XNXaRtGQXt9m2PaOSB8vVFhEjGX9Si+WMdJ5g2IMQ5Wn4g==
//pragma protect end_key_block
//pragma protect digest_block
Z+NQC/o4C3tuGVARxF2BGAwJYUI=
//pragma protect end_digest_block
//pragma protect data_block
xU99rPVyioAb/aOcAxoX/sI61T354ScktU4Yn/Ket1MPNRvj94JogqaE33RA/Jpy
FS5JR9uo8fAWBTPCg+axcMVvcCoAFcPw2PVMzrSFGPpmEUEI3VBxRbYqNLN0rEVl
TPlQCgnUPni6ZgS+HYradSlb6xbiSwo9tWRVK19L8DLmAZ2HYK7AkYYZYJ/2C5rb
N/yVnOPJMpSDRhhElaeoON87XcKxZKwpHIbVSdAYjWp1JUQ2q4zxWOCeYQ7Ig99i
RxhoqqT6id9wSgSlwxXke9i5pPRaoswQFiC2ihK5TUBnj0RlSpyUOieGffkwsXQE
hMyoWX90Gz+6a2CI26ltjBLbGNn35aGi4KIy4YrzZkNzUeUSoMFaEvYOfvkxwaYx
ga6gS+j3bsudyZZN3xnNeaBlYiuUb6KmTJtcUke7h0d8laEVb5sUOriE4367q4wB
MBaAx2zA+Z8Va5Y07bIDC2dXOG3uVgDtY2GF3+7QEgWU8UngjEfa6SxkHPemV8NE
rcrsZOo6SxfbUc7aNdb499PvDkuMoSPGVActThcadRZ4E//zr+Zed87OLEJ9zhgW
haOKJlNa+bZXArdaCjb/xd0WnSwKUtHamfmf5YLnmCJ9t+HglEg9cOTGSj9aC5/Y
ICKK4FKSiGcUMY7a1rUJtKCMxZC020NhRjkeVBR6URIWWAssixRSAplJ94Y6sDGh
wqpJQrw0hCs6o5upzJFuaA==
//pragma protect end_data_block
//pragma protect digest_block
/SSUlavq7bUqUsONwbytvvndl6Y=
//pragma protect end_digest_block
//pragma protect end_protected

//vcs_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
qXssgZZ5LNdjVCkWCh8n82qhLmTH9PROEEUzZe8gOYArlhbpAg637Lq8ACKlHhAl
iqky6c7s8y4qtBvkE+H8KCVYN7W14Pv05/wrz9fEVkJ/5vTFL2DsITGpojuGCdtI
BLxWA81L81ATg7hJirti2IyJdzNQsmKv9bemMaN8uC244FSfhr1zBw==
//pragma protect end_key_block
//pragma protect digest_block
0VlbN1hW3P26QTvOP1oRmV2E4/c=
//pragma protect end_digest_block
//pragma protect data_block
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
//pragma protect end_data_block
//pragma protect digest_block
k0IQ3a2d+YRGWaLqU1+v/l1d1c0=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // GUARD_SVT_CHI_RN_VIRTUAL_SEQUENCER_SV
