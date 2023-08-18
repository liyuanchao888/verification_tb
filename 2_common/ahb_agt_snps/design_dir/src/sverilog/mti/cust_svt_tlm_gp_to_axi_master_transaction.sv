
/**
 * Abstract:
 * This file defines a class that represents a customized AXI Master
 * transaction.  This class extends the AXI VIP's svt_axi_master_transaction
 * class.  It adds pre-defined constraints for converting a TLM GP transaction
 * to AXI transaction.
 * It implements the necessary virtual functions like copy, compare, etc...
 * by using `uvm_object_utils macro.
 *
 * The transaction instance replaces the default master sequencer's transaction
 * object if use_tlm_generic_payload is set in the port configuration. 
 * If this parameter is set, any user constraints must be set in a class extended from this class
 * and the type of this class must be overridden in the testbench
 */

`ifndef GUARD_CUST_SVT_TLM_GP_TO_AXI_MASTER_TRANSACTION_SV
`define GUARD_CUST_SVT_TLM_GP_TO_AXI_MASTER_TRANSACTION_SV

class cust_svt_tlm_gp_to_axi_master_transaction extends svt_axi_master_transaction;

  /** UVM Object Utility macro */
  `uvm_object_utils_begin(cust_svt_tlm_gp_to_axi_master_transaction)
  `uvm_object_utils_end

  /** Class Constructor */
  function new (string name = "cust_svt_tlm_gp_to_axi_master_transaction");
    super.new(name);
  endfunction: new

endclass: cust_svt_tlm_gp_to_axi_master_transaction

`endif // GUARD_CUST_SVT_TLM_GP_TO_AXI_MASTER_TRANSACTION_SV
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
afcDXL0z0xoTxQrWTu1LTFVEv68x71N8j/zW8y0Fhc4j6/yPfvVzfo2ImP8ed25r
G543N0hkcNWJyLKWhLFF6FBuvchpDwEdzxaHWGFSFmLEQkzO9U5eR0I6GPwL60K/
NQD8YK3waJ+k0zR9ONpL8aNdiu8Ota/Ju17Lbyt4BPQ=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 83        )
e9Us5S72dU6OSwScnAyl9wNXRHKkh2e6Oc5wYBFaILlI+dw93toqBeM+qm5H+23h
WHwt5QSvCrqMNvh7D0n9ymTd4948PrD52RaE0Q/dJrsMYzx0XXhw4rb3YEIfqh+g
`pragma protect end_protected
