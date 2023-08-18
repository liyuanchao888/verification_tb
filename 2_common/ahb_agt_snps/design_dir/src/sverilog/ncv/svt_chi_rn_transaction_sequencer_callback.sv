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

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
1pnuWK7SFytqh34oI+UzQcowf9evm8kvTp0YuFcjXCE4CPYUVWCKSQETmeSjlLzB
y9fZVjIlDEHkJmjVBNl0kcdlbt5by1RiI/jNMJ7gfaeEhwpfhRS1zW5dPFsJAoVX
X0Sr/5/EhnBVDmRsIZfvVxG2dqc7PjHCE1J8+YTEvsP1leRauLuyEg==
//pragma protect end_key_block
//pragma protect digest_block
qjtHUSAi9nculZJArrIC9PH6130=
//pragma protect end_digest_block
//pragma protect data_block
Vls/97IXNzD9p+PBjSIvZGY5Kb5if02b/Ssf4xsuZXLKZLDiRyv1czQKKW8CXmnq
M6YGSgY3BnsTqmvwtrQqwa7utIswu6WdplfcSob3nwbVUcgNUQEcnFtX6P2g6IEE
0tmLhKo70MCZL6X19uXFy6+wG4IpXMTlwGv9XcL2TxrFd1JiByc+CFcn8xAkaw1m
ZDPJ6+7qp6rngqLokf9I2WwA0nqWIhSBuQW+d7tOZKyq2LLE6DsABRShoCXq+yi7
zEzpc/efOs+L6rAt5M8Y7xlJiGNr024AZ81h3QRgY/l0JAvKiU9/hbXLgEhNpIMJ
wm2loj5eauT8nS5RCxsAgoTtbBJL3kYYKVnedjovtAQvSmXXgeO1yaT6Be5mHEcq
/V5EySkjjGFGb5z05Fc7EiGkDz/AESJ1JfY9T9F4BpXfyTRSdobhksScwi3/YHCd
M4aCpQS5WUArrqjcMiIDKodYTLswXKwuiNBp1I3YcLn3lZGU/Yg5a7paky+HACcW
qU0gDcDqtawEd5BaBr6c7kL0wo//+aLzL5L8nmYBtbSahrHVMjyBWugCYcYsB1bF
YRNf0nITeKeQQ/AptewrCwevB3U6oib4/JG8RTSdsZecyPUZvnxeo7eg07E20/VC
w1GCI20U+Q9xL0qcOA7ycg==
//pragma protect end_data_block
//pragma protect digest_block
Iq4iPiWqFKIr5H4hLlf2bdLUF3Y=
//pragma protect end_digest_block
//pragma protect end_protected
`endif // SVT_UVM_TECHNOLOGY
`endif // GUARD_SVT_CHI_RN_TRANSACTION_SEQUENCER_CALLBACK_SV
