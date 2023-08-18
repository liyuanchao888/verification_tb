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

`ifndef GUARD_SVT_CHI_RN_PROTOCOL_COMMON_SV
`define GUARD_SVT_CHI_RN_PROTOCOL_COMMON_SV

/** @cond PRIVATE */

// =============================================================================
/**
 * Class that accomplishes the bulk of the RX processing for the CHI Protocol layer.
 * It implements the receive logic common to both active and passive modes, and it
 * contains the API needed for the transmit side that is common to both active and 
 * passive modes.
 */
class svt_chi_rn_protocol_common extends svt_chi_protocol_common;

  //----------------------------------------------------------------------------
  // Type Definitions
  //----------------------------------------------------------------------------

  /** Typedefs for CHI Protocol signal interfaces */
`ifndef __SVDOC__
  typedef virtual svt_chi_rn_if svt_chi_rn_vif;
`endif

  //----------------------------------------------------------------------------
  // Public Data Properties
  //----------------------------------------------------------------------------

  /**
   * Associated component providing direct access when necessary.
   */
`ifdef SVT_VMM_TECHNOLOGY
  protected svt_xactor rn_proto;
`else
  protected `SVT_XVM(component) rn_proto;
`endif

  /**
   * Callback execution class supporting driver callbacks.
   */
  svt_chi_rn_protocol_cb_exec_common drv_cb_exec;

  /**
   * Next TX observed CHI RN Protocol Transaction. 
   * Updated by the driver in active mode OR the monitor in passive mode
   */
  protected svt_chi_rn_transaction tx_observed_xact = null;

  //----------------------------------------------------------------------------
  // Local Data Properties
  //----------------------------------------------------------------------------

  /**
   * Next RX output CHI RN Protocol Transaction.
   */
  local svt_chi_rn_transaction rx_out_xact = null;

  /**
   * Next RX observed CHI RN Protocol Transaction.
   */
  local svt_chi_rn_transaction rx_observed_xact = null;

`ifdef SVT_VMM_TECHNOLOGY
  /** Factory used to create incoming CHI RN Protocol Transaction instances. */
  local svt_chi_rn_transaction xact_factory;

  /** Factory used to create incoming CHI RN Snoop Protocol Transaction instances. */
  local svt_chi_rn_snoop_transaction snp_xact_factory;
`endif

  protected event is_sampled;

  //----------------------------------------------------------------------------
  // Public Methods
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
`ifdef SVT_VMM_TECHNOLOGY
  /**
   * CONSTRUCTOR: Create a new common instance.
   * 
   * @param cfg handle of svt_chi_node_configuration type and used to set (copy data into) cfg.
   * @param rn_proto Component used for accessing its internal vmm_log messaging utility
   */
  extern function new(svt_chi_node_configuration cfg, svt_xactor rn_proto);
`else
  /**
   * CONSTRUCTOR: Create a new common instance.
   * 
   * @param cfg handle of svt_chi_node_configuration type and used to set (copy data into) cfg.
   * @param rn_proto Component used for accessing its internal `SVT_XVM(reporter) messaging utility
   */
  extern function new(svt_chi_node_configuration cfg, `SVT_XVM(component) rn_proto);
`endif

  //----------------------------------------------------------------------------
  /** This method initiates the RN CHI Protocol Transaction recognition. */
  extern virtual task start();

  //----------------------------------------------------------------------------
  /** Used to determine the extended object is a driver or a monitor. */
  extern virtual function bit is_active();
    
  //----------------------------------------------------------------------------
`ifdef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /** Set the local CHI Protocol Transaction factory */
  extern function void set_xact_factory(svt_chi_rn_transaction f);
  extern function void set_snp_xact_factory(svt_chi_rn_snoop_transaction f);
`endif
    
  //----------------------------------------------------------------------------
  /** Create a CHI RN Protocol Transaction object */
  extern function svt_chi_rn_transaction create_transaction();
  //----------------------------------------------------------------------------
  /** Create a CHI Protocol Transaction object */
  extern virtual function svt_chi_transaction proxy_create_transaction();
  //----------------------------------------------------------------------------
  /** Create a CHI RN Protocol Transaction object */
  extern function svt_chi_rn_snoop_transaction create_snp_transaction();
  //----------------------------------------------------------------------------
  /** Create a CHI Protocol Transaction object */
  extern virtual function svt_chi_snoop_transaction proxy_create_snp_transaction();
  //----------------------------------------------------------------------------
  /** Retrieve the RX outgoing CHI Protocol Transaction. */
  extern virtual task get_rx_out_xact(ref svt_chi_rn_transaction xact);

  //----------------------------------------------------------------------------
  /** Retrieve the RX observed CHI Protocol Transaction. */
  extern virtual task get_rx_observed_xact(ref svt_chi_rn_transaction xact);

  //----------------------------------------------------------------------------
  /** Retrieve the TX observed CHI Protocol Transaction. */
  extern virtual task get_tx_observed_xact(ref svt_chi_rn_transaction xact);
  
  /** This method waits for a clock */
  extern virtual task advance_clock();

  //----------------------------------------------------------------------------
  // Local Methods
  //----------------------------------------------------------------------------

     /** Pre process transaction before adding to active queue */
  extern virtual task add_to_rn_active_pre_process(svt_chi_transaction xact);
  //----------------------------------------------------------------------------

  /** Adds READs and WRITEs to separate buffers if separate outstanding
    * for READs and WRITEs are set
    */
  extern virtual task add_to_rn_buffer(svt_chi_transaction xact);
  //----------------------------------------------------------------------------

  /** Loads transactions from read and write buffer and calls add_to_rn_active_pre_process */
  extern virtual task load_active_from_rn_buffer();
  //----------------------------------------------------------------------------
  
  /** Method that invokes the transaction_started cb_exec method */
  extern virtual task invoke_transaction_started_cb_exec(svt_chi_common_transaction xact);

  /** Method that invokes the transaction_ended cb_exec method */
  extern virtual task invoke_transaction_ended_cb_exec(svt_chi_common_transaction xact);

  /** Drives debug ports */
  extern virtual task drive_debug_port(svt_chi_common_transaction xact, string vc_id);

  /** Triggers is_sampled event */
  extern virtual task sample();

  /** Accept a TxRx Transaction and send it to the bus. */
  extern virtual task send_transaction(svt_chi_transaction in_xact);

  /** Updates the cache based on the snoop transaction received */
  extern virtual task post_snoop_cache_update(svt_chi_rn_snoop_transaction snoop_xact);

  /** Adds a snoop transaction to the active queue */
  extern virtual task add_to_rn_snp_active(svt_chi_rn_snoop_transaction snp_xact);

  /** Waits for a snoop transaction to be available in the snp_req_resp_mailbox */
  extern virtual task wait_for_snp_req(output svt_chi_rn_snoop_transaction snp_xact);

endclass

// =============================================================================
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
9qJfktn/BNhZRAGqKt3FfBrhhuAeBMqhxjBch3EjUg82M8vpXGGjbRf/GVF2AZGx
amrxE857OlqhpE3NHdrQ69QN2zK+vNZ3D8Omvw4jbPyWATl9sWpAioTYu08UpvnA
U3lY7CU+ROjkBmjjgebYGHOO2RNOS4kg/NlJ1bERz4SSNh/TLDvjHQ==
//pragma protect end_key_block
//pragma protect digest_block
GQV59COye0IzHa3iVGQfJeRnpK4=
//pragma protect end_digest_block
//pragma protect data_block
1EKNEPjqbSJGFA//ahyFuEb7jZYShzN+Pt/Dl5sJaPx+XXWJSPQG1jGKrv3Imdf4
2qOwHDqFzxbPdXRKeXgMczzYmyHAPx0161BzCyu10RIkQ7/158WZ7lj7oIXeMEmA
N01p9S6CYEOgWJpw/p89HH6dm4Ug5KVC5w+Z6wOMcd49QscSz+l7NRzq36Seffok
sctfTjVQt4jYW22KmLBk0YPul/MVzfho4vUV5YmYmTSO8sYHT32wnCXxJmadgpBG
+7l8VwTo6rJuK2UorMR3BJVgboWFnnGJotwTrVuCivlcC/9MexTsoOk0bqSMDVcI
EXO4/3N+8kSFKCbbj8a730Cfu2FGHfh03vogXOBsRJJ1drXL0ZvM0i/yTiujwmGT
fDgZUfzp7OAG+epB2u76hNj7lGVomPOpo6//7gh9N//t4ey99kzfIwYE75L2DmNK
nnMFom+ERgDHjDMII/ymU5GO6LZxusj5klqViTY6Wkysl6oZDtV/Dg7qf4z2nQ9X
34+6sw1PDq2uSgVi2s/ln9rQ/svCHzdtvs0gM/1JhfJVPjmqaJekrstndAVv4OQ9
kkpg4AOZ5/wWkqIfLedXJ3Y4IJ+6zhl1YKy/I9/UAb4/LDXPMGx6Dts4UudpRTP7
34QeCmcaxcZCenIqL8pMzCNEMvVm9/2SqCAxQreAV2SlqXCt4ntf/aaPjMzQMO/p
+n9ciNyjqFOHk1J048dWi8HnV1ZduNpmvpIIQhP80U+mrNmLhK3tTjvtv10W8j1u
i1zIi7wfikStOotElP9StU1VOoMHCQPOmbfh/Fp8cVbVYhZFfe73GW9j4Cn4jFy5
py1/+vJj7EspLr3swQqnTv/eIdf45xdxYEcj3H3zvGcyPXAtrBGYDGD/loSoxppl
VzAVsH38+Tv9ilpt/vsuXxDh2xcmP06oYNmHRfyPjBvBC3eGDvw15JBuh4nYo/eo
2kJlMT+PYo+SrPnPV35aCW8jxPGzPtE78kF3Qm4oXM7XBELY1q77IK6a4SZg8toO
6U/uE68HvUzByEtLLvK0XYS8e43xfLaCTwQ1dqDfyAlaeaaGYiKFCeSMuZy8QCTf

//pragma protect end_data_block
//pragma protect digest_block
2S85eq3Rq7igh7IQ64wjfhn/Iz8=
//pragma protect end_digest_block
//pragma protect end_protected

//vcs_lic_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
5s+V834MtGFvnU2jVpb5Cbf2D3Fl8Ws5biEAMHorus1JmKqd02Mpgyhvf4f5IcB6
IMZ4Smi9E0YsL1VqNTnOpCBovWndINelqnpqt8V04gPeCOUEjce3ECCSKKjLe7F7
5/xlVyRqPbLHhdI7YOG3Zo3Pl3jss/0/Xli/E2pjh64BSxP+GURaQw==
//pragma protect end_key_block
//pragma protect digest_block
Cgeybpa46qm2ZWkeD9Ty+oVAJy4=
//pragma protect end_digest_block
//pragma protect data_block
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
2pXjTwA58rnXhqb/cqNjdg==
//pragma protect end_data_block
//pragma protect digest_block
7gVzUl9b/gHi65YiPxcV9tSStEM=
//pragma protect end_digest_block
//pragma protect end_protected
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
mqIPO8fDa6S52KZgqZtDPts9FjALG6+Navxw+xDJaMW371jH96ohJT3XyEb7+KCD
xNoPGLcHT9JBGTa9GhKhynO1IT4ng1bDwb0Tv0vcdh0UFqEGhdLQudaYVh3xnTzw
QNfzh5JF3UaaX2kRcSvnjTI0vmBoDujCsv3ad95QAE2JoGiVtPRQ9g==
//pragma protect end_key_block
//pragma protect digest_block
JxXv0ZfjblvfvvVX4XOyBENnE/s=
//pragma protect end_digest_block
//pragma protect data_block
eeD2CwGJqPiFAT/+cQ+CV0P/ad8xB1WuAjiGLkzpFKr0Ajm/8B4u9yjQ9TelYcCM
MpTHqtNf7p0Gv2kkFIkZ6Y0xXozRZ8aWnU1yiS/YgjEFq4Gg6gcNNrROBbWyB7dp
Xuv9ZFZySFSx2aKY/Fo9V/qZMb/52cFO7hknnsWP+deR+KTbSthcwkozFNzgXxlJ
+bU6CCt9vXjFAeqqHk0jbdOu+AmfHVohXgJwpsjxyF4PwkMBWTgRKGDHjXC15cXY
YLXnKW2NAKp4keXnoFF4TeagBY+fstLqxSJ/t0P6UyfcUdkI5cQcU94SFZM6HHfd
G0b1k5vFLkvo0c1bQ+JLgYyFGCoZjL84pATSIHWy5qTwUJ15Fhl2slJ6qBS5LyzA
wmMwTWU3/S++/trP6RmJCgSip5JpNuy6s31flqm/X4vMp0eSub0XcesrSSig0LVv
YpTF+XTaW6TnGBaeBPhECoZA9fLmX0FngHHp8bHqUcyAjO5S7HLBN0QA0Ld/H+lY
HNp03qXPiADi/1ehy7gMZGe/8moRawH0kwzJ2kSUaGa5WzClcVMmMTBCKxSc5dX9
JSSNktg890dD3tY4eV3kWkeG328LgvEZTRzJGye1jew=
//pragma protect end_data_block
//pragma protect digest_block
nx5oho/GuYnI1F9+VeW9IkiK/rM=
//pragma protect end_digest_block
//pragma protect end_protected

//vcs_lic_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
vs8Gu/XeT9QpoqFotmntQ1hCZmG/0eGcVTaeqvwR7ZPWuXGdpV/6N1VC+R51q5US
x8wCefjZwQZCL/2Zx121rVR6vgHWYDAO97cNuiqdyigFWfGTJ0GDwRue/06JgVtx
e1Rlu2qvrAxBp/84vLS89bTZl1BXonwnkwGOaETrQHtaUiqK6894sQ==
//pragma protect end_key_block
//pragma protect digest_block
c/xgQqzMrSMzevWkQHQmU9rXQis=
//pragma protect end_digest_block
//pragma protect data_block
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
//pragma protect end_data_block
//pragma protect digest_block
gA7ehnJZFiw2V81jzLkjeynDOEg=
//pragma protect end_digest_block
//pragma protect end_protected
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
Xk/JZeW76wM+A5vfRDFvKx/iHds+mAfKUAQNvT7+8j+4ZGh+GHVOnpX+L4PN95BY
ydTUr6r82Y02bakE41VrAK5H7t7uEOLhsfB1/BUOXkhK6uZq8V3M7lCkIA6llvmT
DbmR9fdrajqP9Q28tio03voFl87LiCoEVEa5EWq7e8TNqzR7yrK/1A==
//pragma protect end_key_block
//pragma protect digest_block
coZa2brDEJ2aO/HHidJzqT9reb0=
//pragma protect end_digest_block
//pragma protect data_block
d2hHnuz3vS62Ew6xhQFg/a6azzvftRlaRwFmUU6ubloNdAwxaCC7R2KniTLkPuPE
zaVP8eP0Z2R/n4DRadki7o/FznTvOV7+es0swRH+0slcORpVW3RV8sxn3YMzF6Ug
I3hefSbpI59HL9EcRxMTF6Bpy8HZn5W8+e/OzNyNUIHN8Za17v9ni3aJHY05Sjxj
BRtbp1bX6dZlPY2Tn5DjuQszDmaT/vCOEx9DGEoreDgz2JAHtaV49wJKfLAwLtP+
mYs/7mgOXy6+QC4sxkNX0OT9ga4NTz2UMdPpuVusVS6FCqRvSUv6ECN5U/fxxwly
Tzzm5TrW7PFOQ+5wXW0Ho/omZhTvcp/s1RhnoJJj3QxaFvDYiIXvSf0/gGbUv4ua
EcivZs8mnfAGBopmZkVEU630B1f4L4dEBxOXoO3WLV0/2zFMBTYAoINiOuxrbHWV
dgGy0RVYsBVCj6oJVy5ull9nhIpEAq38jIRVaTqsmxVWRE9YhrS8sSjHKn2uIy1c
5JKtinjtNGQnjT3+r7mOuaR0jVwC3xHV1b0u/Om2r1zUlK7lklevaFjntMczGREc
sZ7HwxQH3InH+sBnNweP+g==
//pragma protect end_data_block
//pragma protect digest_block
BBSfS0uWqRyTjEIJVSKEs0+hNuY=
//pragma protect end_digest_block
//pragma protect end_protected

//vcs_lic_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
fWIgzNNBXvX0mSpecnuOYO1RgLB9wTRdCSOW36ggKDQHZ8shPolfS+tmQNVY2EMe
dBzWTX7KKmfKrockLWqgEKK9eoWk2mXwF7aqE608Rl6X14bZh5iQCfa6XdZcWyNA
Y+3gbuRsw/lqnoBidwupLcdmsgumS9bQn04CjRS9QhRu8TautaCWsw==
//pragma protect end_key_block
//pragma protect digest_block
qP1RwZFn+Si90fFpAOdyuQbaYl8=
//pragma protect end_digest_block
//pragma protect data_block
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
//pragma protect end_data_block
//pragma protect digest_block
pTVOtB7SUNsUF4gNcWH80I1loBo=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // GUARD_SVT_CHI_RN_PROTOCOL_COMMON_SV
