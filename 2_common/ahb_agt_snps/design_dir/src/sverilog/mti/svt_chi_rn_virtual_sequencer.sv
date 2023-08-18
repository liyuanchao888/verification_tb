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

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
C2g5tK7FnMhalxVWdy1zkJ4CkiCmY2wtBm29K7iFyiiFPknZyYvsTz8ISBtulkM5
NfKjrFAcq9T4kZcEvbyk9t+CNlBdoQyDTkhxr3f6xZxEXt+4e/7l1XqYmMe7QLYG
k7jkJVxUgwQPDRKZqQbKK5csE+FutN1D7vu/OU2eEHU=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 377       )
fBUuYMzyEMB0qyYq1KxVzmCuVR4KM4oyuwMjt5CEt5rlzk27E2uQ2yct/ZVhMn+h
gaQ6Ht1yeJbfISNe6TjBQurzZdHARLaBwGaeeT84mPWK8yjpG3gk7uLREG0Qt7NJ
m0D/Hhb0AOUgweVfLDKx5WYBLXCDkriFne0J4LJ1Bzqx2yKfEVa5CE654w23hqZn
M40Z6KHL26VLNZvcb8keiHjt8Vj/c9i1QZHbMXdr0Fs6ejrEn4S8/nhQSgR7TRyL
ryk640CpJXYvI7m66UOD4jcmgkP1KR6aOzlteAvuQp7O2ngXo1QVPdPwSHzPiVqG
ETVDvBRIqsjUtdG9wSrbc7BfluZpl8SUcvllhNdgNxKAhYaMP1+5A9fYqeQtyJ+E
nmgyasvt1H74IX1DIdaRpRLFVvc3euePRmgwJmUn2z4cS7SjcqplfMDbyjFQDIjH
G+iomNa3yKG15YvQZJcp+TxZIT5BXndn8ydKTdFmLgYUv776+C1i6SypKXFbd4G7
`pragma protect end_protected

//vcs_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
bt71HUuL6s5bkGcYGhi+5vNfGQEJq8W3QEzdkEavvgSm01Ke9k14dXzgCdeATwW6
dTi2jKpKjuxPBpW9muVVyqtgkfe66h3Sc3a0U2kr8U2CoPy8gyj8WMNtCEXl2wcQ
klpHcDojmM/ONezfvCDpYWjZ+1WQgGRHubuvVhJxgRY=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 2778      )
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
I2WUBMmaPLFetPk4CEHGbQ==
`pragma protect end_protected

`endif // GUARD_SVT_CHI_RN_VIRTUAL_SEQUENCER_SV
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
hXN/Cjvw87arHewX3cmz/V+1V5MfSuK5JWuujGDDtUJBCfnVDZZwE8yIfSIiKwX1
uFIfkL3wJH6vSOr6AIHCtecDbnCBE4+/RuHDAqOBU+Fy3WalSF7omCH8l1NMBFmp
Mo5FjmCHlZqaeEhvdm8LA04LizboYTqxRVRyKRPIn2I=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 2861      )
/F4RJFPUxgyuoDz7QBZH1gAU/mVHTiZa9u52++RvTOzrWOM160KgrPogkN8Xt3BW
4g272ZYofWhR4YABmjuL+aki4Gzq4ctp6Kubzp/s0yoflZqZc9SBmSoOrVOKhZnK
`pragma protect end_protected
