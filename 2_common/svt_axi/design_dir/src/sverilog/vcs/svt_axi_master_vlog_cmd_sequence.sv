`ifndef GUARD_SVT_AXI_MASTER_VLOG_CMD_SEQUENCE_SV
`define GUARD_SVT_AXI_MASTER_VLOG_CMD_SEQUENCE_SV
// =============================================================================
// =============================================================================
/**
 * This sequence submits the VLOG CMD based transaction object to the driver so
 * that driver can drive this transaction on the interface level. 
 * 
 * This sequence runs forever, and so is not registered with the master sequence
 * library.
 */
class svt_axi_master_vlog_cmd_sequence extends svt_axi_master_base_sequence;

  `svt_xvm_object_utils(svt_axi_master_vlog_cmd_sequence)
  `svt_xvm_declare_p_sequencer(svt_axi_master_sequencer)

  `SVT_AXI_MASTER_TRANSACTION_TYPE vlog_cmd_xact;
  /**
   * Class Constuctor
   */
  function new(string name = "svt_axi_master_vlog_cmd_sequence");
    super.new(name);
  endfunction : new
  
  /**
   * Provide a new transaction handle
   */
  task get_new_handle(`SVT_AXI_MASTER_TRANSACTION_TYPE vlog_cmd_xact);
    `svt_xvm_create(vlog_cmd_xact);
    `svt_xvm_verbose("get_new_handle", $psprintf("svt_axi_master_vlog_cmd_sequence :: created vlog_cmd_xact via new_data() call"));
   endtask

  virtual task body();
    `SVT_XVM(event) ev;
    ev = p_sequencer.event_pool.get("apply_data_ready");
  
    super.body();

    forever begin

       `svt_xvm_verbose("body", $psprintf("svt_axi_master_vlog_cmd_sequence :: Waiting for getting object from driver via apply_data call"));
       ev.wait_trigger();
       wait_for_grant();      
       send_request(p_sequencer.vlog_cmd_xact); 
       `svt_xvm_verbose("body", $psprintf("svt_axi_master_vlog_cmd_sequence :: Submitted master transaction to the driver's seq_item_port"));
    end

  endtask : body
endclass : svt_axi_master_vlog_cmd_sequence

`endif //  GUARD_SVT_AXI_MASTER_VLOG_CMD_SEQUENCE_SV
