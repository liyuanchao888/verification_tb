
/**
 * Abstract:
 * Class axi_slave_reorder_response_sequence defines a sequence class that
 * the testbench uses to provide slave response to the Slave agent present in
 * the System agent. The sequence receives a response object of type
 * svt_axi_slave_transaction from slave sequencer. The sequence class then
 * randomizes the response with constraints and provides it to the slave driver
 * which reorder based on the priority within the slave agent,when the active_wr_xact_queue
 * and active_rd_xact_queue is full. The sequence also instantiates the slave built-in memory,
 * and writes into or reads from the slave memory.
 *  
 * Execution phase: main_phase
 * Sequencer: Slave agent sequencer
 */

`ifndef GUARD_AXI_SLAVE_REORDER_RESPONSE_SEQUENCE_SV
`define GUARD_AXI_SLAVE_REORDER_RESPONSE_SEQUENCE_SV

class axi_slave_reorder_response_sequence extends svt_axi_slave_base_sequence;

  svt_axi_slave_transaction req_resp;

  /** UVM Object Utility macro */
  `uvm_object_utils(axi_slave_reorder_response_sequence)

  /** Class Constructor */
  function new(string name="axi_slave_reorder_response_sequence");
    super.new(name);
  endfunction

  virtual task body();
    integer status;
    svt_configuration get_cfg;

    `uvm_info("body", "Entered ...", UVM_LOW)

    p_sequencer.get_cfg(get_cfg);
    if (!$cast(cfg, get_cfg)) begin
      `uvm_fatal("body", "Unable to $cast the configuration to a svt_axi_port_configuration class");
    end

    // consumes responses sent by driver
    sink_responses();

    forever begin
      /**
       * Get the response request from the slave sequencer. The response request is
       * provided to the slave sequencer by the slave port monitor, through
       * TLM port.
       */
      p_sequencer.response_request_port.peek(req_resp);
      `uvm_info("body", "observed a new transaction at monitor..", UVM_LOW)

      /**
       * Randomize the response and delays
       */
      status=req_resp.randomize with {
        bresp == svt_axi_slave_transaction::OKAY;
        addr_ready_delay==0; 
        foreach (rresp[index])  {
          rresp[index] == svt_axi_slave_transaction::OKAY;
          }
        foreach(wready_delay[i]) {
            wready_delay[i] == 0;
          }
        if (req_resp.xact_type == svt_axi_slave_transaction::WRITE) {
            bvalid_delay == 0;
          } 
        if (req_resp.xact_type == svt_axi_slave_transaction::READ)  {
            foreach(rvalid_delay[k]) {
              req_resp.rvalid_delay[k]== 0;
            }
          }  
       };
       if(!status)
        `uvm_fatal("body","Unable to randomize a response")

      /**
       * If write transaction, write data into slave built-in memory, else get
       * data from slave built-in memory
       */
      if(req_resp.xact_type == svt_axi_slave_transaction::WRITE) begin

        ///////////////////////////////////////
        //assign reordering priority based on txn id
        if(req_resp.id == 0) begin
          req_resp.reordering_priority = 2;
        end
        else begin
          req_resp.reordering_priority = 1;
        end
        
        put_write_transaction_data_to_mem(req_resp);
      end
      else begin
        if(req_resp.id==10) begin 
          req_resp.reordering_priority = 2;
        end
        else begin
          req_resp.reordering_priority = 1;
        end
        get_read_data_from_mem_to_transaction(req_resp);
      end
    
      $cast(req,req_resp);
      `uvm_info("body", "sending to slave driver...", UVM_LOW)

      /**
       * send to driver
       */
      `uvm_send(req)

    end

    `uvm_info("body", "Exiting...", UVM_LOW)
  endtask: body

endclass: axi_slave_reorder_response_sequence

`endif // GUARD_AXI_SLAVE_REORDER_RESPONSE_SEQUENCE_SV
