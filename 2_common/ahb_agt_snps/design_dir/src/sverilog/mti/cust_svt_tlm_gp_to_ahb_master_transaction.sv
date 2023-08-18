
/**
 * Abstract:
 * This file defines a class that represents a customizable AHB Master
 * transaction used to map TLM Generic Payload transactions.
 * It extends the AHB VIP's svt_ahb_master_transaction
 * class.
 * 
 * User may extend this class to provide additional constraints or extensions
 * for AHB transaction sthat implement TLM GP transactions.
 */

`ifndef GUARD_CUST_SVT_TLM_GP_TO_AHB_MASTER_TRANSACTION_SV
`define GUARD_CUST_SVT_TLM_GP_TO_AHB_MASTER_TRANSACTION_SV

class cust_svt_tlm_gp_to_ahb_master_transaction extends svt_ahb_master_transaction;

  /** UVM Object Utility macro */
  `uvm_object_utils_begin(cust_svt_tlm_gp_to_ahb_master_transaction)
  `uvm_object_utils_end

  /** Class Constructor */
  function new (string name = "cust_svt_tlm_gp_to_ahb_master_transaction");
    super.new(name);
  endfunction: new

endclass: cust_svt_tlm_gp_to_ahb_master_transaction

`endif // GUARD_CUST_SVT_TLM_GP_TO_AHB_MASTER_TRANSACTION_SV
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
Vn+q/kuYmJlOEb4rky3qkFIAkFlHzoRndAk7C2spJCGLFS4B+2Y0mBa0bibrAG/N
IIsLhDSuRYJmlLR/vCuqPgctz+Vb4ydqi48tbAu+tNSnxYJozJ4OVFZEQq4BhVow
UTB5vHfwol/ZCLeR/ggVEhz6QrdXazwxpYTZfYA/vbE=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 83        )
A2qaZ6RZ6BIIcvsSSnljHiigTwCekCxcjG+ZM3wdL1R+Ygy58fzXCG8p+XgQVSG4
4V3pdigtkY8QQgePYGrtdj02cpEz4HT/XE+l7GU0octiz4AYWDd/DkppLpulk1cV
`pragma protect end_protected
