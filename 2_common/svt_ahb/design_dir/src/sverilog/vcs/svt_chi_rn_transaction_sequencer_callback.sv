//=======================================================================
// COPYRIGHT (C) 2010, 2011, 2012, 2013 SYNOPSYS INC.
// This software and the associated documentation are confidential and
// proprietary to Synopsys, Inc. Your use or disclosure of this software
// is subject to the terms and conditions of a written license agreement
// between you, or your company, and Synopsys, Inc. In the event of
// publications, the following notice is applicable:
//
// ALL RIGHTS RESERVED
//
// The entire notice above must be reproduced on all authorized copies.
//
//-----------------------------------------------------------------------

`ifndef GUARD_SVT_CHI_RN_TRANSACTION_SEQUENCER_CALLBACK_SV
`define GUARD_SVT_CHI_RN_TRANSACTION_SEQUENCER_CALLBACK_SV

/**
  * Rn_transaction sequencer callback class contains the callback methods called by
  * the rn_transaction sequencer component.
  * Currently, this class has callbacks issued when a TLM GP transaction is
  * converted to an CHI transaction by the sequence. The user may access these
  * callbacks to see how a TLM GP transaction got converted to CHI
  * transaction(s).
  */
`ifdef SVT_UVM_TECHNOLOGY
class svt_chi_rn_transaction_sequencer_callback extends svt_uvm_callback;

  //----------------------------------------------------------------------------
  /** CONSTUCTOR: Create a new callback instance */
  extern function new(string name = "svt_chi_rn_transaction_sequencer_callback");

  //----------------------------------------------------------------------------
  /**
   * Called after the sequencer maps a TLM GP transaction to one or more CHI transactions
   * and before they are sent out to the driver.
   *
   * @param chi_rn_transaction_sequencer A reference to the svt_chi_rn_transaction_sequencer component that is 
   * issuing this callback.  The user's callback implementation can use this to
   * access the public data and/or methods of the component.
   * 
   * @param tlm_gp_xact A reference to the TLM GP transaction descriptor
   *
   * @param chi_xact_q A reference to a queue of CHI transactions descriptors
   *        to which the tlm_gp_xact is mapped. Modifying the CHI transactions will
   *        modify the transactions that are eventually executed.
   */
  virtual function void post_tlm_gp_to_chi_mapping(svt_chi_rn_transaction_sequencer chi_rn_transaction_sequencer,
                                                   uvm_tlm_generic_payload          tlm_gp_xact,
                                                   ref svt_chi_rn_transaction       chi_xact_q[$]);
  endfunction

endclass

`protected
]RWcK0a:39#S^,66<acW)V[bfS5g[af4H+^QEGbG3PM2WX2^WP?=2)@=@P98S>f&
7O<A_fQdK/XdMXI21LC4.9Of5,R5,L=\)W_MH?;.DG-&GXJKBScGN1aQQ5]=e#0L
A]P>+(-M/LfGgab,1K#EV/IA0L7<@;)JIaJ1>=08&\d:7-d[E4(K12CA?R2C+Q?T
/R-Fb=8cc:Kg>FY4#0E+4bT5FG/9Q.c144>be8QGI]1ca3^0a-J8#FMN?<53UDS0
&L[8-:^@8/dCd;A^R&O&TNT52$
`endprotected

`endif // SVT_UVM_TECHNOLOGY
`endif // GUARD_SVT_CHI_RN_TRANSACTION_SEQUENCER_CALLBACK_SV
