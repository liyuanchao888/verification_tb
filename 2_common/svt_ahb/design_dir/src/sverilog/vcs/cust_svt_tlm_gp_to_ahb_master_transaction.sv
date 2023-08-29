
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
