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

`ifndef GUARD_SVT_CHI_SN_PROTOCOL_COMMON_SV
`define GUARD_SVT_CHI_SN_PROTOCOL_COMMON_SV

/** @cond PRIVATE */

// =============================================================================
/**
 * Class that accomplishes the bulk of the RX processing for the CHI Protocol layer.
 * It implements the receive logic common to both active and passive modes, and it
 * contains the API needed for the transmit side that is common to both active and 
 * passive modes.
 */
class svt_chi_sn_protocol_common extends svt_chi_protocol_common;

  //----------------------------------------------------------------------------
  // Type Definitions
  //----------------------------------------------------------------------------

  /** Typedefs for CHI Protocol signal interfaces */
`ifndef __SVDOC__
  typedef virtual svt_chi_sn_if svt_chi_sn_vif;
`endif

  //----------------------------------------------------------------------------
  // Public Data Properties
  //----------------------------------------------------------------------------

  /** CHI SN Protocol virtual interface */
`ifndef __SVDOC__
  protected svt_chi_sn_vif vif;
`endif

  /**
   * Associated component providing direct access when necessary.
   */
`ifdef SVT_VMM_TECHNOLOGY
  protected svt_xactor sn_proto;
`else
  protected `SVT_XVM(component) sn_proto;
`endif

  /**
   * Callback execution class supporting driver callbacks.
   */
  svt_chi_sn_protocol_cb_exec_common drv_cb_exec;

  /** Buffer for write transactions. Used when num_outstanding_xact is -1 in configuration */
  svt_chi_sn_transaction write_xact_buffer[$];

  /** Buffer for read transactions. Used when num_outstanding_xact is -1 in configuration */
  svt_chi_sn_transaction read_xact_buffer[$];

  /** Buffer for control transactions. Used when num_outstanding_xact is -1 in configuration */
  svt_chi_sn_transaction control_xact_buffer[$];


  /**
   * Next TX observed CHI SN Protocol Transaction. 
   * Updated by the driver in active mode OR the monitor in passive mode
   */
  protected svt_chi_sn_transaction tx_observed_xact = null;

  //----------------------------------------------------------------------------
  // Local Data Properties
  //----------------------------------------------------------------------------

  /**
   * Next RX output CHI SN Protocol Transaction.
   */
  local svt_chi_sn_transaction rx_out_xact = null;

  /**
   * Next RX observed CHI SN Protocol Transaction.
   */
  local svt_chi_sn_transaction rx_observed_xact = null;


`ifdef SVT_VMM_TECHNOLOGY
  /** Factory used to create incoming CHI SN Protocol Transaction instances. */
  local svt_chi_sn_transaction xact_factory;
`endif

  //----------------------------------------------------------------------------
  // Public Methods
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
`ifdef SVT_VMM_TECHNOLOGY
  /**
   * CONSTRUCTOR: Create a new common instance.
   * 
   * @param cfg handle of svt_chi_node_configuration type and used to set (copy data into) cfg.
   * @param sn_proto Component used for accessing its internal vmm_log messaging utility
   */
  extern function new(svt_chi_node_configuration cfg, svt_xactor sn_proto);
`else
  /**
   * CONSTRUCTOR: Create a new common instance.
   * 
   * @param cfg handle of svt_chi_node_configuration type and used to set (copy data into) cfg.
   * @param sn_proto Component used for accessing its internal `SVT_XVM(reporter) messaging utility
   */
  extern function new(svt_chi_node_configuration cfg, `SVT_XVM(component) sn_proto);
`endif

  //----------------------------------------------------------------------------
  /** This method initiates the SN CHI Protocol Transaction recognition. */
  extern virtual task start();

  //----------------------------------------------------------------------------
  /** This method sets the clock period for active SN component */
  extern virtual task set_active_sn_clock_period();

  //----------------------------------------------------------------------------
  /** Used to determine the extended object is a driver or a monitor. */
  extern virtual function bit is_active();
    
  //----------------------------------------------------------------------------
  /** Sets the interface */
`ifndef __SVDOC__
   extern virtual function void set_vif(svt_chi_sn_vif vif);
`endif

`ifdef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /** Set the local CHI Protocol Transaction factory */
  extern function void set_xact_factory(svt_chi_sn_transaction f);
`endif
    
  //----------------------------------------------------------------------------
  /** Create a CHI SN Protocol Transaction object */
  extern function svt_chi_sn_transaction create_transaction();

  //----------------------------------------------------------------------------
  /** Create a CHI Protocol Transaction object */
  extern virtual function svt_chi_transaction proxy_create_transaction();
  
  //----------------------------------------------------------------------------
  /** Retrieve the RX outgoing CHI Protocol Transaction. */
  extern virtual task get_rx_out_xact(ref svt_chi_sn_transaction xact);

  //----------------------------------------------------------------------------
  /** Retrieve the RX observed CHI Protocol Transaction. */
  extern virtual task get_rx_observed_xact(ref svt_chi_sn_transaction xact);

  //----------------------------------------------------------------------------
  /** Retrieve the TX observed CHI Protocol Transaction. */
  extern virtual task get_tx_observed_xact(ref svt_chi_sn_transaction xact);

  //----------------------------------------------------------------------------
  /** Method to wait for Rx observed transactions: currently applicable only in SN active mode */
  extern virtual task wait_for_req(output svt_chi_transaction xact);
  
  /** This method waits for a clock */
  extern virtual task advance_clock();
  
  //----------------------------------------------------------------------------
  // Local Methods
  //----------------------------------------------------------------------------

  /** Method that invokes transaction start events */
  extern virtual task start_transaction(svt_chi_common_transaction common_xact);

  /** Method that invokes transaction end events */
  extern virtual task complete_transaction(svt_chi_common_transaction common_xact);
    
  /** Method that invokes the transaction_started cb_exec method */
  extern virtual task invoke_transaction_started_cb_exec(svt_chi_common_transaction xact);

  /** Method that invokes the transaction_ended cb_exec method */
  extern virtual task invoke_transaction_ended_cb_exec(svt_chi_common_transaction xact);

  /** Drives debug ports */
  extern virtual task drive_debug_port(svt_chi_common_transaction xact, string vc_id);

endclass

// =============================================================================
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
FvhUKAKp2eiQ1q10Uj4g8e2O0dQxs2qjNzxlqhNFLTqfWLRjLC4ookIKToZ+npTx
0/PE7isyZw5DY1D9sI1bSctTq7BFd4KGLwmAwL+R8aZVHMQI2zOlCNisEQbNaUTI
bUplqaXWK8IyvUnFazG1UeWwLGgchDyrvWaPdR8/SpjKRIrYncDMmg==
//pragma protect end_key_block
//pragma protect digest_block
UNfvb9hlqq70GLE8BVB8fXW0y/w=
//pragma protect end_digest_block
//pragma protect data_block
NeDDuNi7QBx+3Mmzvf+4201Q6S5he8xoeYDSN3rrOVmLA/fhDLAwL/pYPTHQXfiR
62sBHcDhMZ36CjgIID8g1OtBdhxj2GOdAKnXh3rQqvGNItWcMLUe5eJRB+SoCaF/
WiQPCXqIAR+ZOwUKRMerbOzp/qic7Utpyv4pcdUlAr4XmOwy/0EYHzFW8vgzh+n7
RbUdZhfoRC3ic+cLgkyQK2yVRclDFIhwagLFoTcbu0t3Fswho/1XjAvZxA9YqBNB
WLL5wy0WeaimlIoMJ3CsTWruMtur5mSPmKiVS3MbElG1e2FLM/fxIn49Rv5CD5yC
OMjMVgicYVwdYZ5674ad457Nx3ymJOq3W4HyI5B1zN0VBISR2fm/PUUwtxq/LH0a
G5GKf7IhTaJkCzylThi2YZjMFIBwpsYWSluZNZS+y9WHzK1BTm9FwhxkN4MheU2z
TJI19gADGc6KS7acn84jQPpx4pg6tFJyAjrGlJNjTdiNEBkbFGV5oCMbPamA+7l0
ZNJpjImjJh+xSXcPpCBopbzn3M7LCyIAa+S+h1EgHWhC7cS9PjiiZZ3o7KKG1ld+
lYDL3UBbaj6Np5EhGsjeK/59rhO6ILGZPSHh/7RWBYSM+FTcMGDTynmKhEUXq6Xv
hZx19yNwt00dZTnyD/Xq7QXJC4DPker7cIYofPjjN4kxea1muLH+j+Z3LvCldC86
D5ZJNJ6K5p+3FG2+CoVIZghDpSXh0LSg9pTwmZpqDFjJcV86wyNlOngmG2PB0r+x
eFywogSdvTZuDjep6HyoyYcJX9CoE+G/mtmlOQAtIjN+q/UaXz2mJpYyCmte8BY6
NmD98x9jL2f/gRWcplmJhF9cE+tERWDnQrcvMVbOOa4EsIIu7IV9xG10Ek/+Hs+q
lnobUQShjzadH8km47PtnDEq1OkZ3ppPY66xethkl7dLS3698+cdm7GirxecrLmg
rizOEuA1Bep79MxBTy3eTzVpIe4D5bJJjflQxDrxhp/WP/Bd8aZYtnFuMxQHoBKJ

//pragma protect end_data_block
//pragma protect digest_block
18iwn1ThsuMc/U4u0992120E0nw=
//pragma protect end_digest_block
//pragma protect end_protected

//vcs_lic_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
fak3GcGb+bzoJgjq/Xj4ZCxhXzdHa52SdOeOKQsDecPo12ElAEwkHIB4AnQhOcyQ
NtQUSwQjBGVAESu1Ch418+L4QGBIinv8PceYxMxOZEmo8A5vT5L0sqUee/gw1l4b
TbvjQJIXz439tDajw7RRkAFXhyJKOUdE7YP6BYOUaBHbMARJ9X4NPA==
//pragma protect end_key_block
//pragma protect digest_block
TTdgDnf1wwBrGZRhQitAssPcmgg=
//pragma protect end_digest_block
//pragma protect data_block
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
yPnqRbnDxssDqMh+jfQhCA==
//pragma protect end_data_block
//pragma protect digest_block
uxZcR+59QqY9JfcRTYv+4RkT70I=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // GUARD_SVT_CHI_SN_PROTOCOL_COMMON_SV
