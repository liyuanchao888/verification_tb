
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
