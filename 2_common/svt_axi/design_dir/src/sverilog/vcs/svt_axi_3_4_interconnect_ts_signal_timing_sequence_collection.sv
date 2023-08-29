
`ifndef GUARD_SVT_AXI_3_4_INTERCONNECT_TS_SIGNAL_TIMING_SEQEUENCE_COLLECTION_SV
`define GUARD_SVT_AXI_3_4_INTERCONNECT_TS_SIGNAL_TIMING_SEQEUENCE_COLLECTION_SV

// =============================================================================
/**
 *    #- Program the Master VIP to drive Write and read transactions.<br>  
 *    #- Configure the Master and Slave VIP default values of READY signal from
 *       the test.<br>  
 *    #- Check the Interconnect Master Port is driving VALID irrespective of READY <br> 
 *       from Slave. This will get tested through system configuration <br> 
 *       bus_inactivity_timeout.<br> 
 *    #- Initiate the above stimulus from all Master VIPs towards all the Slaves <br> 
 *       connected to the IC DUT.<br> 
 *    .
 */

class svt_axi_signal_timing_write_read_default_ready_ictest_sequence extends svt_axi_system_base_sequence;

  /** Sequence length in used to constsrain the sequence length in sub-sequences */
  rand int unsigned sequence_length;

  /** local variables */
  int supporting_masters[int];
  int supporting_slaves[int];
  bit default_ready;
  bit default_ready_status;

  /** Constrain the sequence length to a reasonable value */
  constraint reasonable_sequence_length {
    sequence_length <= 50;
  }
  
  /** UVM Object Utility macro */
`ifdef SVT_UVM_TECHNOLOGY
  `uvm_object_utils(svt_axi_signal_timing_write_read_default_ready_ictest_sequence)
`elsif SVT_OVM_TECHNOLOGY
  `ovm_object_utils(svt_axi_signal_timing_write_read_default_ready_ictest_sequence)
`endif

  /** Class Constructor */
  function new (string name = "svt_axi_signal_timing_write_read_default_ready_ictest_sequence");
    super.new(name);
  endfunction : new

  /** 
   * Function to check if current system configuration meets requirements of this sequence.
   * This sequence requires following configurations
   *  #- minimum supporting Masters = 1
   *  #- minimum supporting Slaves  = 1
   */
  virtual function bit is_supported(svt_configuration cfg, bit silent = 0);
    
    /** local variables */
    int num_supporting_masters;
    int num_supporting_slaves;

    /** Supporting masters required */
    int required_num_supporting_masters = 1;
    
    /** Supporting slaves required */
    int required_num_supporting_slaves = 1;

    `svt_xvm_debug("is_supported",$sformatf("calling is_supported"));

    /** By default is_supported is 0 */
    is_supported = 0;

    num_supporting_masters = supporting_masters.size();
    num_supporting_slaves = supporting_slaves.size();
    
    /** Check the required supporting Masters and Slaves  */
    if((num_supporting_masters >= required_num_supporting_masters) && (num_supporting_slaves >= required_num_supporting_slaves ))   begin
      is_supported = 1;
    end
    else begin
      if (silent)
        `svt_xvm_debug("is_supported",$sformatf("This sequence cannot be run based on the current system configuration.\n\
                                                Number of Supporting Master(s) with default_bready,default_rready %0s - Minimum Required : 'd%0d Current : 'd%0d \n\
                                                Modify configurations through \n\
                                                svt_axi_system_configuration::num_masters,\n\
                                                svt_axi_port_configuration::is_active,\n\
                                                svt_axi_port_configuration::default_bready,default_rready,\n\
                                                svt_axi_port_configuration::axi_interface_category,\n\
                                                svt_axi_system_configuration::participating_masters\n\
                                                Number of Supporting Slave(s) with default_arready,default_awready,default_wready %0s - Minimum Required : 'd%0d Current : 'd%0d \n\
                                                Modify configurations through \n\
                                                svt_axi_port_configuration::default_arready,default_awready,default_wready,\n\
                                                ",default_ready ? "asserted":"deasserted", required_num_supporting_masters, num_supporting_masters,default_ready ? "asserted":"deasserted",required_num_supporting_slaves,num_supporting_slaves))
      else
        `svt_xvm_warning("is_supported",$sformatf("This sequence cannot be run based on the current system configuration.\n\
                                                Number of Supporting Master(s) with default_bready,default_rready %0s - Minimum Required : 'd%0d Current : 'd%0d \n\
                                                Modify configurations through \n\
                                                svt_axi_system_configuration::num_masters,\n\
                                                svt_axi_port_configuration::is_active,\n\
                                                svt_axi_port_configuration::default_bready,default_rready,\n\
                                                svt_axi_port_configuration::axi_interface_category,\n\
                                                svt_axi_system_configuration::participating_masters\n\
                                                Number of Supporting Slave(s) with default_arready,default_awready,default_wready %0s - Minimum Required : 'd%0d Current : 'd%0d \n\
                                                Modify configurations through \n\
                                                svt_axi_port_configuration::default_arready,default_awready,default_wready,\n\
                                                ",default_ready ? "asserted":"deasserted", required_num_supporting_masters, num_supporting_masters,default_ready ? "asserted":"deasserted",required_num_supporting_slaves,num_supporting_slaves))
    end      
  endfunction : is_supported

  /** Pre-Randomizing the participating masters and slaves */  
  function void pre_randomize();
    int support_mstr_index=0; 
    int support_slv_index=0; 
    super.pre_randomize();
`ifdef SVT_UVM_TECHNOLOGY 
    default_ready_status = uvm_config_db#(bit)::get(null, get_full_name(), "default_ready", default_ready);
`elsif SVT_OVM_TECHNOLOGY 
    default_ready_status = m_sequencer.get_config_int({get_full_name(), ".default_ready"}, default_ready);
`endif
    foreach(active_participating_masters[mstr])  begin
      if((sys_cfg.master_cfg[active_participating_masters[mstr]].default_bready==default_ready)||(sys_cfg.master_cfg[active_participating_masters[mstr]].default_rready==default_ready))       begin
        supporting_masters[support_mstr_index++] = active_participating_masters[mstr];  
        `svt_xvm_debug("svt_axi_signal_timing_write_read_default_ready_ictest_sequence",$sformatf(" master id that is participating is ='d%0d ",mstr));
        `svt_xvm_debug("svt_axi_signal_timing_write_read_default_ready_ictest_sequence",$sformatf(" master default_ready that is participating is ='d%0d ",default_ready));
      end
    end
    foreach(participating_slaves_arr[slv])  begin
      if((sys_cfg.slave_cfg[participating_slaves_arr[slv]].default_arready==default_ready) || (sys_cfg.slave_cfg[participating_slaves_arr[slv]].default_awready==default_ready) || (sys_cfg.slave_cfg[participating_slaves_arr[slv]].default_wready==default_ready)) begin
        supporting_slaves[support_slv_index++] = participating_slaves_arr[slv];  
        `svt_xvm_debug("svt_axi_signal_timing_write_read_default_ready_ictest_sequence",$sformatf(" slave id that is participating is ='d%0d ",slv));
        `svt_xvm_debug("svt_axi_signal_timing_write_read_default_ready_ictest_sequence",$sformatf(" slave default_ready that is participating is ='d%0d ",default_ready));
      end
    end
  endfunction: pre_randomize

  /** UVM sequence body task */ 
  virtual task body();

    /** local variables */
    bit status;
    int index;

    /** Write transaction request handles */
    svt_axi_master_transaction wr_xact;

    /** Read transaction request handles */
    svt_axi_master_transaction rd_xact;

    `svt_xvm_debug("body", "Entering...");

`ifdef SVT_UVM_TECHNOLOGY
    status = uvm_config_db#(int unsigned)::get(null, get_full_name(), "sequence_length", sequence_length);
`elsif SVT_OVM_TECHNOLOGY
    void'(m_sequencer.get_config_int({get_type_name(), "sequence_length"},  sequence_length));
`endif
    `svt_xvm_debug("body", $sformatf("sequence_length is 'd%0d as a result of %0s.", sequence_length,
                                     status ? "config DB" : "randomization"));
   
    /** check if current environment is supported or not */ 
    if(!is_supported(sys_cfg, silent))  begin
      `svt_xvm_note("body",$sformatf("This sequence cannot be run based on the current system configuration. Exiting..."))
      return;
    end

    /** Fork off a thread to pull the responses out of response queue */
    sink_responses(); 
    
    /** Execute the sequence for 'sequence_length' number of times */
    for (int i=0; i < sequence_length; i++) begin
      /** Execute the transactions from each selected active participating master */
      foreach(supporting_masters[master]) begin
        int mstr = supporting_masters[master];
        `svt_xvm_debug("body", $sformatf("Master to initiate is  'd%0d initiating masters index='d%0d ",mstr,i) );

        /** Execute the transactions in each Slave from selected Master */
        foreach(supporting_slaves[index])  begin
          int slv = supporting_slaves[index];
          bit[`SVT_AXI_MAX_ADDR_WIDTH-1:0] lo_addr;
          bit[`SVT_AXI_MAX_ADDR_WIDTH-1:0] hi_addr;
        
          /** Randomly select an Address range for selected slave */
          if (!sys_cfg.get_slave_addr_range(mstr,slv, lo_addr, hi_addr,null))
            `svt_xvm_warning("body", $sformatf("Unable to obtain a memory range for slave index 'd%0d", slv));

          /** Drive a Write transaction */
          `svt_xvm_do_on_with(wr_xact, p_sequencer.master_sequencer[mstr], { 
            addr                            >= lo_addr;
            addr                            <= hi_addr-(burst_length*(1<<burst_size));
            data_before_addr                == 0;
            if ((sys_cfg.master_cfg[mstr].axi_interface_category == svt_axi_port_configuration::AXI_WRITE_ONLY)||(sys_cfg.master_cfg[mstr].axi_interface_category == svt_axi_port_configuration::AXI_READ_WRITE)){
              xact_type                       == _write_xact_type[mstr];
              coherent_xact_type              == svt_axi_transaction::WRITENOSNOOP;
            }
            else{
              xact_type                       == _read_xact_type[mstr];
              coherent_xact_type              == svt_axi_transaction::READNOSNOOP;
            }
            atomic_type                     == svt_axi_transaction::NORMAL;   
            burst_type                      inside {svt_axi_transaction::INCR,svt_axi_transaction::WRAP};
          })
          
          `svt_xvm_debug("body", {`SVT_AXI_PRINT_PREFIX1(wr_xact), "Waiting for transaction to end"});
          /** Waiting for above Write transaction to complete */
          wait (`SVT_AXI_XACT_STATUS_ENDED(wr_xact));
          `svt_xvm_debug("body", {`SVT_AXI_PRINT_PREFIX1(wr_xact), "Transaction is now ended"});

          if((sys_cfg.master_cfg[mstr].axi_interface_category == svt_axi_port_configuration::AXI_READ_WRITE))
            begin
              /** Drive a Read transaction */
              `svt_xvm_do_on_with(rd_xact, p_sequencer.master_sequencer[mstr], { 
                addr                            == local::wr_xact.addr;
                data_before_addr                == 0;
                xact_type                       == _read_xact_type[mstr];
                coherent_xact_type              == svt_axi_transaction::READNOSNOOP;
                atomic_type                     == svt_axi_transaction::NORMAL;   
                burst_type                      == local::wr_xact.burst_type;
                burst_size                      == local::wr_xact.burst_size;
                burst_length                    == local::wr_xact.burst_length;
              })

              /** Waiting for above Read transaction to complete */
              `svt_xvm_debug("body", {`SVT_AXI_PRINT_PREFIX1(rd_xact), "Waiting for transaction to end"});
              wait (`SVT_AXI_XACT_STATUS_ENDED(rd_xact));
              `svt_xvm_debug("body", {`SVT_AXI_PRINT_PREFIX1(rd_xact), "Transaction is now ended"});
            end

        end //foreach of Slave
      end //foreach of Master
    end //forloop of sequence_length
    /** 
     * To check VALID is forwarded before asserting READY.
     * Check performed by AXI SVT Port Monitor through system configuration 
     * bus_inactivity_timeout. 
     */
    
    `svt_xvm_debug("body", "Exiting...");
  endtask: body
endclass: svt_axi_signal_timing_write_read_default_ready_ictest_sequence

`endif //GUARD_SVT_AXI_3_4_INTERCONNECT_TS_SIGNAL_TIMING_SEQEUENCE_COLLECTION_SV
