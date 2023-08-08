`ifndef GUARD_SVT_AXI_IC_SLAVE_SEQUENCE_SV
`define GUARD_SVT_AXI_IC_SLAVE_SEQUENCE_SV

/** @cond PRIVATE */
// =============================================================================
// =============================================================================
/**
 * This sequence generates random responses to response requests. This sequence
 * gets the slave response sequence item from slave sequencer, randomizes the
 * response, and provides the randomized response to the slave driver.
 * 
 * This sequence runs forever, and so is not registered with the slave sequence
 * library.
 */
class svt_axi_ic_slave_response_sequence extends svt_axi_slave_base_sequence;

  function new(string name="svt_axi_ic_slave_response_sequence");
    super.new(name);
  endfunction

  `svt_xvm_object_utils(svt_axi_ic_slave_response_sequence)
  `svt_xvm_declare_p_sequencer(svt_axi_ic_slave_sequencer)

  virtual task body();

    //fork off a thread to pull the responses out of response queue
    sink_responses();
    forever begin
      svt_axi_ic_slave_transaction ic_slave_xact;
      `svt_xvm_verbose("body","peeking response request port");
      p_sequencer.response_request_port.peek(req);
      req.suspend_response = 1;
      req.port_id = req.port_cfg.port_id ;
      if (!($cast(ic_slave_xact,req))) begin
        `svt_error("body",{`SVT_AXI_PRINT_PREFIX1(req),$psprintf("Expected transaction of type svt_axi_ic_slave_transaction, but received one of of type %0s",req.get_class_name())});  
      end
      else begin
        `svt_xvm_rand_send(ic_slave_xact)
        `svt_xvm_verbose("body",{`SVT_AXI_PRINT_PREFIX1(ic_slave_xact),$psprintf("received transaction in slave port_id 'd%0d",ic_slave_xact.port_id)});
        /*if (
             (ic_slave_xact.addr_status != svt_axi_slave_transaction::INITIAL) &&
             (ic_slave_xact.addr_status != svt_axi_slave_transaction::ABORTED)) begin
             */
        // If it is a data_before_addr transaction add to interconnect only when
        // the first data is received. The check for addr_status does this
        if (
             (ic_slave_xact.data_before_addr != 1) ||
             (
               (ic_slave_xact.data_before_addr == 1) &&
               (ic_slave_xact.addr_status == svt_axi_slave_transaction::INITIAL)
             )
           ) begin
          p_sequencer.ic_xact_fifo.put(ic_slave_xact);
          `svt_xvm_verbose("body",{`SVT_AXI_PRINT_PREFIX1(ic_slave_xact),$psprintf("received transaction in slave port_id 'd%0d. Put into IC FIFO",ic_slave_xact.port_id)});
        end
      end
    end
  endtask: body

endclass: svt_axi_ic_slave_response_sequence
/** @endcond */


// =============================================================================

`endif // GUARD_SVT_AXI_IC_SLAVE_SEQUENCE_SV
