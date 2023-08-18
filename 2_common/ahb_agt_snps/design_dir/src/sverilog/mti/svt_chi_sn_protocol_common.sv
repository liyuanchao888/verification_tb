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
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
StHGOz8kaVgbWfsY1ACFRW21ZCf6hV5gw6xZENjPOfYGZCc1Jp4X2zz5G0FGu/l+
7rvneGR7apGdJBPRrSqma4QVVeYvu5NXL/6RTSQI7AxNMd3VHSNZE8holMMiHzGt
ndhCnsPhZWInsR42YUxPYKtJgnkZAAvu+1T9ceD6YMI=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 599       )
fuzeVUV5zi9dJHvcJs3c3NvLW8q9VC6WQODOqgQHtGcv4GQ7cXwOp+0BdjhprT4R
BgO/ca9XAj83Ps/DzRd4NYI5oc34NCgUvG9x47AkpLboTATycftvOhcKhxVmSQm+
+jD23+W4T66TMDsY6kj4nnSkQAbypHr4rHzZUpsnKKfezhWOU2h+dfJ1M2OEAYUN
zIlVsKlSDNgigsw1P9BOQWX5vVEbU5SbKND11W//8ygaeJzwGg6k+Oqs6GTtsKhJ
aKf9aZm/ry9pJazohMoKJxX0MrfJ8iPZHftR2GKHgHcXxoGv5nc78KWKgYH5rSoL
b3ABTGFCWUjyy9dO3jkg95CtRbFfYbgHfi+ZKoo51dznAIoczKR1BseHngbohI7a
E7uFLL3VHyVtwEI31GBGun1HJXMzeCGkRCVxHUN12IP7MrlGA3QbEv7d7jVqd62o
/QYgSmc3YMKmE9sTRMQ8YxDDH1DoLbSud5qSgNCdKLRiBKlJ4xyIAFU7v6cu21cl
M2UkJ5JkWWo02jEZmHQXbWuXw89mNCnrwG893VB3AYaQACOgU8dvQ0W4fvJKIPFr
+F7p2meQB13he/DTPiLFRq8QSjZfPlKNbleoNuUF6kHfRPUJlp08PxFAfXPAoMc6
Gkbx2Ttqa91TdLGwBe7gX3m9MTp6+h18zGrz0lPlVsty7olR2Sxh8MPHJt5CusIG
updAURmsTYVvsoykxPN1YuwEEW+wlnp1LM81EnKNnPJ0UhKcBVPPb04tvBhwFSjn
PoxjV/T+CA7CFzAN1a5mckspBeYJsTW5EUvYMUj3ODg=
`pragma protect end_protected

//vcs_lic_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
ZmTZ7q2O1UE8Z7RN1kDN9MyJVlJwc5CwfRVNc7Od3+F+rzTUCJ86lReuRKiMiGBE
YfjHKnT5bPxNSw6TA5RfGd/aLvcq3xTzOgUQXmcLyrPH8JgzNMoLavFVIe7Pjj4X
kKSUCrM8FVB/NTTwb5AxVXM4u+Onqpc47SZfoI+x4LA=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 8369      )
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
`pragma protect end_protected

`endif // GUARD_SVT_CHI_SN_PROTOCOL_COMMON_SV
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
EJsDcMwagUY4deN/P6lq41rM3AUTdevVnIjad1aoznYTm70EA4XTDaamiYEoY+fR
65rC17jrGpV8n6mKRPcjzVTv2WU4fqx6EKteU/k6J6bf7X8MtudnAok5aI8xqZRE
vc/lvzWLXBgHf/AN/WXo3iAqMSSkr9yLogJdD/F5Cec=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 8452      )
sSKpHYldKnRBRz6/hPMPfnw3mufmYKax+OK+4UrVCBo9hSVHh+MfI1rk017ZEMK3
re4iDJKRqYitu+WQCKcJXQCyizMkrI4XVgsVfnIOAl4o83utLEqJltHmIg0PJVnr
`pragma protect end_protected
