
`ifndef GUARD_SVT_AXI_3_4_INTERCONNECT_TS_BURST_SEQUENCE_COLLECTION
`define GUARD_SVT_AXI_3_4_INTERCONNECT_TS_BURST_SEQUENCE_COLLECTION

// =============================================================================
/**
 *    #- Program the testbench to drive ARESETn from LOW to HIGH<br> 
 *    #- Program the Master VIP to drive Write/Read transaction in Write/Read <br> 
 *       Address/Data channel on the immediate active edge of ACLK after ARESETn <br> 
 *       becoming HIGH <br> 
 *    #- Wait for the transaction to complete successfully. <br> 
 *    .
 */

class svt_axi_burst_write_read_with_zero_delay_ictest_sequence extends svt_axi_system_base_sequence;

  /** Sequence length in used to constsrain the sequence length in sub-sequences */
  rand int unsigned sequence_length;

  /** Constrain the sequence length to a reasonable value */
  constraint reasonable_sequence_length {
    sequence_length <= 50;
  }
  
  /** UVM Object Utility macro */
`ifdef SVT_UVM_TECHNOLOGY
  `uvm_object_utils(svt_axi_burst_write_read_with_zero_delay_ictest_sequence)
`elsif SVT_OVM_TECHNOLOGY
  `ovm_object_utils(svt_axi_burst_write_read_with_zero_delay_ictest_sequence)
`endif

  /** Class Constructor */
  function new (string name = "svt_axi_burst_write_read_with_zero_delay_ictest_sequence");
    super.new(name);
  endfunction : new

  /** 
   * Function to check if current system configuration meets requirements of this sequence.
   * This sequence requires following configurations
   *  #- minimum supporting Masters = 1
   *  #- minimum supporting Slaves  = 0
   */
  virtual function bit is_supported(svt_configuration cfg, bit silent = 0);
    
    /** local variables */
    int num_supporting_masters;

    /** Supporting masters required */
    int required_num_supporting_masters = 1;

    `svt_xvm_debug("is_supported",$sformatf("calling is_supported"));

    /** By default is_supported is 0 */
    is_supported = 0;

    num_supporting_masters = active_participating_masters.size();
    
    /** Check the required supporting Masters */
    if(num_supporting_masters >= required_num_supporting_masters )  begin
      is_supported = 1;
    end
    else begin
      if (silent)
        `svt_xvm_debug("is_supported",$sformatf("This sequence cannot be run based on the current system configuration.\n\
                                                Number of Supporting Master(s) - Minimum Required : 'd%0d Current : 'd%0d \n\
                                                Modify configurations through \n\
                                                svt_axi_system_configuration::num_masters,\n\
                                                svt_axi_port_configuration::is_active,\n\
                                                svt_axi_port_configuration::axi_interface_category,\n\
                                                svt_axi_system_configuration::participating_masters\n\
                                                ", required_num_supporting_masters, num_supporting_masters))
      else
        `svt_xvm_warning("is_supported",$sformatf("This sequence cannot be run based on the current system configuration.\n\
                                                Number of Supporting Master(s) - Minimum Required : 'd%0d Current : 'd%0d \n\
                                                Modify configurations through \n\
                                                svt_axi_system_configuration::num_masters,\n\
                                                svt_axi_port_configuration::is_active,\n\
                                                svt_axi_port_configuration::axi_interface_category,\n\
                                                svt_axi_system_configuration::participating_masters\n\
                                                ", required_num_supporting_masters, num_supporting_masters))
    end      
  endfunction : is_supported

  /** UVM sequence body task */ 
  virtual task body();

    /** local variables */
    bit status;
    int selected_slv;
    bit[`SVT_AXI_MAX_ADDR_WIDTH-1:0] lo_addr;
    bit[`SVT_AXI_MAX_ADDR_WIDTH-1:0] hi_addr;
    int participating_slave_idx_array[$];
    
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
    `svt_xvm_debug("body", $sformatf("sequence_length is 'd%0d as a result of %0s.", sequence_length, status ? "config DB" : "randomization"));
   
    /** Setting the response_queue_depth */ 
    set_response_queue_depth(-1);

    /** check if current environment is supported or not */ 
    if(!is_supported(sys_cfg, silent))  begin
      `svt_xvm_note("body",$sformatf("This sequence cannot be run based on the current system configuration. Exiting..."))
      return;
    end

    //fork off a thread to pull the responses out of response queue
    sink_responses(); 
    
    /** Execute the sequence for 'sequence_length' number of times */
    for (int i=0; i < sequence_length; i++) begin
      /** Execute the transactions from each selected active participating master */
      foreach(active_participating_masters[initiating_master_index]) begin
        int mstr = active_participating_masters[initiating_master_index];
        `svt_xvm_debug("body", $sformatf("Master to initiate is 'd%0d initiating_master_index='d%0d ",mstr,initiating_master_index) );

        /** Randomly select an Address range for selected slave */
        foreach(participating_slaves_arr[participating_slave_idx]) begin
          participating_slave_idx_array.push_back(participating_slaves_arr[participating_slave_idx]);
        end
        
        participating_slave_idx_array.shuffle;
        selected_slv = participating_slave_idx_array.pop_front();
        if (!sys_cfg.get_slave_addr_range(mstr,selected_slv,lo_addr,hi_addr,null))
          `svt_xvm_warning("body", $sformatf("Unable to obtain a memory range for slave index 'd%0d", selected_slv));

        /** Driving 2 Write and 2 Read transaction */
        repeat(2)  begin 
          /** Drive a Write transaction */
          `svt_xvm_do_on_with(wr_xact, p_sequencer.master_sequencer[mstr], { 
            data_before_addr                       == 0;
            if ((sys_cfg.master_cfg[mstr].axi_interface_category == svt_axi_port_configuration::AXI_WRITE_ONLY)||(sys_cfg.master_cfg[mstr].axi_interface_category == svt_axi_port_configuration::AXI_READ_WRITE)){
              xact_type                              == _write_xact_type[mstr];
              coherent_xact_type                     == svt_axi_transaction::WRITENOSNOOP;
              reference_event_for_first_wvalid_delay == svt_axi_transaction ::WRITE_ADDR_VALID; 
              wvalid_delay[0]                        == 0;
            }
            else{
              xact_type                              == _read_xact_type[mstr];
              coherent_xact_type                     == svt_axi_transaction::READNOSNOOP;
            }
            atomic_type                            == svt_axi_transaction::NORMAL;
            burst_type                             inside {svt_axi_transaction::INCR,svt_axi_transaction::WRAP};
            // Not supported in INCA and does not affect functionally since
            // it is being set to 0 and that is the default behaviour
`ifndef INCA
            check_addr_overlap                     == 0;
`endif
            reference_event_for_addr_valid_delay   == svt_axi_transaction ::PREV_ADDR_VALID;
            addr_valid_delay                       == 0;
            addr                                   >= lo_addr;
            addr                                   <= hi_addr-(burst_length*(1<<burst_size));
          })

          if((sys_cfg.master_cfg[mstr].axi_interface_category == svt_axi_port_configuration::AXI_READ_WRITE))  begin
            /** Drive a Read transaction */
            `svt_xvm_do_on_with(rd_xact, p_sequencer.master_sequencer[mstr], { 
              xact_type                              == _read_xact_type[mstr];
              coherent_xact_type                     == svt_axi_transaction::READNOSNOOP;
              atomic_type                            == svt_axi_transaction::NORMAL;
              burst_type                             inside {svt_axi_transaction::INCR,svt_axi_transaction::WRAP};
              // Not supported in INCA and does not affect functionally since
              // it is being set to 0 and that is the default behaviour
`ifndef INCA
              check_addr_overlap                     == 0;
`endif
              reference_event_for_addr_valid_delay   ==  svt_axi_transaction ::PREV_ADDR_VALID;
              addr_valid_delay                       == 0;
              addr                                   >= lo_addr;
              addr                                   <= hi_addr-(burst_length*(1<<burst_size));
            })   
          end
        end //repeat
      end //foreach of Master
    end //forloop of sequence_length
    /** 
     * To check Interconnect samples the transaction properly.
     * Check performed by AXI SVT Port Monitor. 
     */

    `svt_xvm_debug("body", "Exiting...");
  endtask: body
endclass: svt_axi_burst_write_read_with_zero_delay_ictest_sequence

//==============================================================================
/**
 *    #- Program the Master VIP to drive Write transaction with Write data in <br> 
 *       Write Data Channel first, followed by Address on the Write Adderss <br> 
 *       Channel.<br> 
 *    #- Check Interconnect forwards the Write transaction to Slave VIP properly.<br> 
 *    #- Initiate the above stimulus from all Master VIPs sequentially towards all<br> 
 *       the Slaves connected to the IC DUT.<br> 
 *    .
 */

class svt_axi_burst_write_data_before_address_ictest_sequence extends svt_axi_system_base_sequence;

  /** Sequence length in used to constsrain the sequence length in sub-sequences */
  rand int unsigned sequence_length;

  /** Local variable */
  int supporting_masters[int];
 
  /** Constrain the sequence length to a reasonable value */
  constraint reasonable_sequence_length {
    sequence_length <= 50;
  }

  /** UVM Object Utility macro */
`ifdef SVT_UVM_TECHNOLOGY
  `uvm_object_utils(svt_axi_burst_write_data_before_address_ictest_sequence)
`elsif SVT_OVM_TECHNOLOGY
  `ovm_object_utils(svt_axi_burst_write_data_before_address_ictest_sequence)
`endif

  /** Class Constructor */
  function new (string name = "svt_axi_burst_write_data_before_address_ictest_sequence");
    super.new(name);
  endfunction : new

  /** 
   * Function to check if current system configuration meets requirements of this sequence.
   * This sequence requires following configurations
   *  #- minimum supporting Masters = 1
   */
  virtual function bit is_supported(svt_configuration cfg, bit silent = 0);
    
    /** local variables */
    int num_supporting_masters;

    /** Supporting masters required */
    int required_num_supporting_masters = 1;

    `svt_xvm_debug("is_supported",$sformatf("calling is_supported"));

    /** By default is_supported is 0 */
    is_supported = 0;

    num_supporting_masters = supporting_masters.size();

    /** check the required supporting Masters */
    if(num_supporting_masters >= required_num_supporting_masters)  begin
      is_supported = 1;
    end
    else begin
      if (silent)
        `svt_xvm_debug("is_supported",$sformatf("This sequence cannot be run based on the current system configuration.\n\
                                                Number of Supporting Master(s) - Minimum Required : 'd%0d Current : 'd%0d \n\
                                                Modify configurations through \n\
                                                svt_axi_system_configuration::num_masters,\n\
                                                svt_axi_port_configuration::is_active,\n\
                                                svt_axi_port_configuration::axi_interface_category,\n\
                                                svt_axi_system_configuration::participating_masters\n\
                                                ", required_num_supporting_masters, num_supporting_masters))
      else
        `svt_xvm_warning("is_supported",$sformatf("This sequence cannot be run based on the current system configuration.\n\
                                                Number of Supporting Master(s) - Minimum Required : 'd%0d Current : 'd%0d \n\
                                                Modify configurations through \n\
                                                svt_axi_system_configuration::num_masters,\n\
                                                svt_axi_port_configuration::is_active,\n\
                                                svt_axi_port_configuration::axi_interface_category,\n\
                                                svt_axi_system_configuration::participating_masters\n\
                                                ", required_num_supporting_masters, num_supporting_masters))
    end      
  endfunction : is_supported

 /** Pre-Randomizing the participating masters*/  
  function void pre_randomize();
    int support_mstr_index=0; 
    super.pre_randomize();
    foreach(active_participating_masters[mstr])  begin
      if(sys_cfg.master_cfg[active_participating_masters[mstr]].axi_interface_category != svt_axi_port_configuration::AXI_READ_ONLY) begin
        supporting_masters[support_mstr_index++] = active_participating_masters[mstr];  
        `svt_xvm_debug("svt_axi_burst_write_data_before_address_ictest_sequence",$sformatf(" master id that is participating is ='d%0d ",active_participating_masters[mstr]));
      end
      else begin
        `svt_xvm_debug("svt_axi_burst_write_data_before_address_ictest_sequence",$sformatf("master with id='d%0d has only AXI_READ_ONLY port",active_participating_masters[mstr]));
      end
    end
  endfunction: pre_randomize 


  /** UVM sequence body task */ 
  virtual task body();

    /** Local variables */
    bit status;
    
    /** Write transaction request handle */
    svt_axi_master_transaction wr_xact_req;

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
   
    /** Setting the response_queue_depth */ 
    set_response_queue_depth(-1);
    
    //fork off a thread to pull the responses out of response queue
    sink_responses(); 
        
    /** Execute the sequence for 'sequence_length' number of times */
    for (int i=0; i < sequence_length; i++) begin
      /** Execute the transactions from each selected active participating master */
      foreach(supporting_masters[initiating_master_index])  begin
        int mstr = supporting_masters[initiating_master_index];
        `svt_xvm_debug("body", $sformatf("supporting_masters.size is 'd%0d", supporting_masters.size()) );
        
        /** Execute the transactions in each Slave from selected active participating master */
        foreach(participating_slaves_arr[index])  begin
          int slv = participating_slaves_arr[index];
          bit[`SVT_AXI_MAX_ADDR_WIDTH-1:0] lo_addr;
          bit[`SVT_AXI_MAX_ADDR_WIDTH-1:0] hi_addr;
          /** Randomly select an Address range for selected slave */
          if (!sys_cfg.get_slave_addr_range(mstr,slv, lo_addr, hi_addr,null))
            `svt_xvm_warning("body", $sformatf("Unable to obtain a memory range for slave index 'd%0d", slv));

          /** Drive a Write transaction */
          `svt_xvm_do_on_with(wr_xact_req, p_sequencer.master_sequencer[mstr], {
            addr                                 >= lo_addr;
            addr                                 <= hi_addr-(burst_length*(1<<burst_size));
            data_before_addr                     == 1;
            atomic_type                          == svt_axi_transaction::NORMAL;
            xact_type                            == _write_xact_type[mstr];
            coherent_xact_type                   == svt_axi_transaction::WRITENOSNOOP;
            burst_type                           inside {svt_axi_transaction::INCR,svt_axi_transaction::WRAP,svt_axi_transaction::FIXED};
            reference_event_for_addr_valid_delay == svt_axi_transaction ::FIRST_WVALID_DATA_BEFORE_ADDR;
            addr_valid_delay                     >  0;
          })
        end //foreach of slave  
      end //foreach of supporting_masters 
    end //forloop of sequence_length
    /** 
     * To check the Write transactions are forwarded properly.
     * Check done by System Monitor.
     *  #- data_integrity_check
     *  .
     */

    `svt_xvm_debug("body", "Exiting...");
  endtask: body
endclass: svt_axi_burst_write_data_before_address_ictest_sequence

//==============================================================================
/**
 *    #- Program the Master VIP to drive write transcation with all strobes = 1.<br> 
 *       This will initialize the memory to a known value.<br> 
 *    #- Program the Master VIP to drive write transcation to the same location<br> 
 *       of previous write transaction with all strobe bits = 0 for certain transfers. <br> 
 *    #- Program the Master VIP to drive Read transaction.   <br> 
 *    #- Check the read data and compare it with write data (expected data).<br> 
 *    #- Initiate the above stimulus from all Master VIPs towards all the Slaves <br> 
 *       connected to the IC DUT.<br> 
 *    .
 */

class svt_axi_burst_write_with_strobe_deasserted_ictest_sequence extends svt_axi_system_base_sequence;

  /** Sequence length in used to constsrain the sequence length in sub-sequences */
  rand int unsigned sequence_length;

  /** Local variable */
  int supporting_masters[int];

  /** Constrain the sequence length to a reasonable value */
  constraint reasonable_sequence_length {
    sequence_length <= 50;   
  } 

  /** UVM Object Utility macro */
`ifdef SVT_UVM_TECHNOLOGY    
  `uvm_object_utils(svt_axi_burst_write_with_strobe_deasserted_ictest_sequence)
`elsif SVT_OVM_TECHNOLOGY
  `ovm_object_utils(svt_axi_burst_write_with_strobe_deasserted_ictest_sequence)
`endif

  /** Class Constructor */
  function new (string name = "svt_axi_burst_write_with_strobe_deasserted_ictest_sequence");
    super.new(name);
  endfunction : new

  /** 
   * Function to check if current system configuration meets requirements of this sequence.
   * This sequence requires following configurations
   *  #- minimum supporting Masters = 1
   */
  virtual function bit is_supported(svt_configuration cfg, bit silent = 0);
    
    /** local variables */
    int num_supporting_masters;

    /** Supporting masters required */
    int required_num_supporting_masters = 1;

    `svt_xvm_debug("is_supported",$sformatf("calling is_supported"));

    /** By default is_supported is 0 */
    is_supported = 0;

    num_supporting_masters = supporting_masters.size();
    
    /** check the required supporting Masters */
    if(num_supporting_masters >= required_num_supporting_masters)  begin
      is_supported = 1;
    end
    else begin
      if (silent)
        `svt_xvm_debug("is_supported",$sformatf("This sequence cannot be run based on the current system configuration.\n\
                                                Number of Supporting Master(s) - Minimum Required : 'd%0d Current : 'd%0d \n\
                                                Modify configurations through \n\
                                                svt_axi_system_configuration::num_masters,\n\
                                                svt_axi_port_configuration::is_active,\n\
                                                svt_axi_port_configuration::axi_interface_category,\n\
                                                svt_axi_system_configuration::participating_masters\n\
                                                ", required_num_supporting_masters, num_supporting_masters))
      else
        `svt_xvm_warning("is_supported",$sformatf("This sequence cannot be run based on the current system configuration.\n\
                                                Number of Supporting Master(s) - Minimum Required : 'd%0d Current : 'd%0d \n\
                                                Modify configurations through \n\
                                                svt_axi_system_configuration::num_masters,\n\
                                                svt_axi_port_configuration::is_active,\n\
                                                svt_axi_port_configuration::axi_interface_category,\n\
                                                svt_axi_system_configuration::participating_masters\n\
                                                ", required_num_supporting_masters, num_supporting_masters))
    end      
  endfunction : is_supported

  /** Pre-Randomizing the participating masters */  
  function void pre_randomize();
    int support_mstr_index=0; 
    super.pre_randomize();
    foreach(active_participating_masters[mstr])  begin
      if(sys_cfg.master_cfg[active_participating_masters[mstr]].axi_interface_category == svt_axi_port_configuration::AXI_READ_WRITE) begin
        supporting_masters[support_mstr_index++] = active_participating_masters[mstr];  
        `svt_xvm_debug("svt_axi_burst_write_with_strobe_deasserted_ictest_sequence",$sformatf(" master id that is participating is ='d%0d ",active_participating_masters[mstr]));
      end
      else begin
        `svt_xvm_debug("svt_axi_burst_write_with_strobe_deasserted_ictest_sequence",$sformatf("master with id='d%0d does not have an AXI_READ_WRITE port",active_participating_masters[mstr]));
      end
    end
  endfunction: pre_randomize 

  /** UVM sequence body task */ 
  virtual task body();
    /** Local variables */
    bit status;
    bit [7:0] packed_wr_data_0 [], packed_rd_data_1 [];
    bit [7:0] packed_wr_data_1 [];
    bit packed_wstrb [] , packed_inverted_wstrb [];
    bit [`SVT_AXI_WSTRB_WIDTH-1 :0] inverted_wstrb [];
    bit compare_data1, compare_data2;
    
    /** Write and Read transaction request handles */
    svt_axi_master_transaction wr_xact_req[$], rd_xact_req;
    
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
      `svt_xvm_note("body",$sformatf("This sequence cannot be run based on the current system configuration. Exiting..."));
      return;
    end
  
    /** Setting the response_queue_depth */ 
    set_response_queue_depth(-1);

    //fork off a thread to pull the responses out of response queue
    sink_responses(); 

    /** Execute the sequence for 'sequence_length' number of times */
    for (int i=0; i < sequence_length; i++) begin
      /** Execute the transactions from each selected active participating master */
      foreach(supporting_masters[initiating_master_index])  begin
        int mstr = supporting_masters[initiating_master_index];
        `svt_xvm_debug("body", $sformatf("Initiating_master_port_id is 'd%0d and a master to initiate is  'd%0d ",initiating_master_port_id,mstr) );
        `svt_xvm_debug("body", $sformatf("supporting_masters.size is 'd%0d", supporting_masters.size()) );

        /** Execute the transactions in each Slave from selected active participating master */
        foreach(participating_slaves_arr[index])  begin
          int slv = participating_slaves_arr[index];
          bit[`SVT_AXI_MAX_ADDR_WIDTH-1:0] lo_addr;
          bit[`SVT_AXI_MAX_ADDR_WIDTH-1:0] hi_addr;
          /** Randomly select an Address range for selected slave */
          if (!sys_cfg.get_slave_addr_range(mstr,slv, lo_addr, hi_addr,null))
            `svt_xvm_warning("body", $sformatf("Unable to obtain a memory range for slave index 'd%0d", slv));


          /** Drive first Write transaction */
          `svt_xvm_do_on_with(wr_xact_req[0], p_sequencer.master_sequencer[mstr], {
            addr                    >= lo_addr;
            addr                    <= hi_addr-(burst_length*(1<<burst_size));
            xact_type               == _write_xact_type[mstr];
            coherent_xact_type      == svt_axi_transaction::WRITENOSNOOP;
            atomic_type             == svt_axi_transaction::NORMAL;
            burst_type              inside {svt_axi_transaction::INCR,svt_axi_transaction::WRAP};
            foreach(wr_xact_req[0].wstrb[index])
              wstrb[index] == '1;
          })
          
          `svt_xvm_debug("body", {`SVT_AXI_PRINT_PREFIX1(wr_xact_req[0]), "Waiting for transaction to end"});
          /** Waiting for above Write transaction to complete */
          wait (`SVT_AXI_XACT_STATUS_ENDED(wr_xact_req[0]));
          `svt_xvm_debug("body", {`SVT_AXI_PRINT_PREFIX1(wr_xact_req[0]), "Transaction is now ended"});

          /** 
           * Drive second Write transaction with same burst_length, burst_type,
           * burst_size and address as of first Write transaction.
           */
          `svt_xvm_do_on_with(wr_xact_req[1], p_sequencer.master_sequencer[mstr], {
            addr                    == local::wr_xact_req[0].addr;
            xact_type               == _write_xact_type[mstr];
            coherent_xact_type      == svt_axi_transaction::WRITENOSNOOP;
            atomic_type             == svt_axi_transaction::NORMAL;
            burst_type              == local::wr_xact_req[0].burst_type; 
            burst_size              == local::wr_xact_req[0].burst_size; 
            burst_length            == local::wr_xact_req[0].burst_length;
            prot_type               == local::wr_xact_req[0].prot_type;

            /** Making all wstrb bits = 0 for certain transfers of Write transaction */ 
            foreach(wr_xact_req[1].wstrb[index]) 
              wstrb[index] dist {'0:/2, [1: (((1<<(1<<(burst_size))))-1)]:/2}; 
          })
          
          `svt_xvm_debug("body", {`SVT_AXI_PRINT_PREFIX1(wr_xact_req[1]), "Waiting for transaction to end"});
          /** Waiting for above Write transaction to complete */
          wait (`SVT_AXI_XACT_STATUS_ENDED(wr_xact_req[1]));
          `svt_xvm_debug("body", {`SVT_AXI_PRINT_PREFIX1(wr_xact_req[1]), "Transaction is now ended"});

          /** 
           * Drive Read transaction with same burst_length, burst_type,
           * burst_size and address as of Write transaction.
           */
          `svt_xvm_do_on_with(rd_xact_req, p_sequencer.master_sequencer[mstr],{
            addr                        == local::wr_xact_req[1].addr;
            xact_type                   == _read_xact_type[mstr];
            atomic_type                 == svt_axi_transaction::NORMAL;   
            coherent_xact_type          == svt_axi_transaction::READNOSNOOP;
            burst_type                  == local::wr_xact_req[1].burst_type;
            burst_size                  == local::wr_xact_req[1].burst_size;
            burst_length                == local::wr_xact_req[1].burst_length;
            prot_type                   == local::wr_xact_req[1].prot_type;
          })

          `svt_xvm_debug("body", {`SVT_AXI_PRINT_PREFIX1(rd_xact_req), "Waiting for transaction to end"});
          /** Waiting for above Read transaction to complete */
          wait (`SVT_AXI_XACT_STATUS_ENDED(rd_xact_req));
          `svt_xvm_debug("body", {`SVT_AXI_PRINT_PREFIX1(rd_xact_req), "Transaction is now ended"});


          /** Returns the Read transaction data as a byte stream based on the burst_type */
          rd_xact_req.pack_data_to_byte_stream ( rd_xact_req.data,packed_rd_data_1 ); 

          /** Returns the data and strobe field of second write transaction as a byte stream based on the burst_type */
          wr_xact_req[1].pack_data_to_byte_stream ( wr_xact_req[1].data, packed_wr_data_1 );  
          wr_xact_req[1].pack_wstrb_to_byte_stream (wr_xact_req[1].wstrb,packed_wstrb ); 
          /** Compares the contents of byte stream of second write transaction and read transaction */
          compare_data1 = rd_xact_req.compare_write_data( packed_wr_data_1, packed_wstrb, packed_rd_data_1 );
          if(compare_data1 ==0)
            `svt_xvm_error("compare_write_data",$sformatf("Mismatch in Second Write Transaction data and Read Transaction data"));
 
          foreach(packed_wr_data_1[index]) begin
            `svt_xvm_debug("body", $sformatf("PACKED WRITE DATA_1 'h%0h ", packed_wr_data_1[index]));
            `svt_xvm_debug("body", $sformatf("PACKED WRITE STROBE 'h%0h ", packed_wstrb[index]));
            `svt_xvm_debug("body", $sformatf("PACKED READ DATA 'h%0h ", packed_rd_data_1[index]));
          end 
          
          /** 
           * Invert wstrobe of second write transaction to compare the Read data and  
           * make sure the data is not changed when strobe in second write transaction
           * is zero.
           */
          inverted_wstrb = new[wr_xact_req[1].wstrb.size()];
          foreach(wr_xact_req[1].wstrb[i])  begin
            for(int j= 0; j < (1<<wr_xact_req[1].burst_size); j++) begin
              inverted_wstrb[i][j] =  ~wr_xact_req[1].wstrb[i][j];
            end
          end

          /** Returns the First write transaction data as a byte stream based on the burst_type */
          wr_xact_req[0].pack_data_to_byte_stream ( wr_xact_req[0].data, packed_wr_data_0 );  

          /** Returns the inverted wstrobe of second write transaction as a byte stream based on the burst_type */
          wr_xact_req[1].pack_wstrb_to_byte_stream(inverted_wstrb,packed_inverted_wstrb );  

          /** Compares the contents of byte stream of first Write transaction and read transaction */
          compare_data2=rd_xact_req.compare_write_data( packed_wr_data_0, packed_inverted_wstrb, packed_rd_data_1 );
          if(compare_data2 ==0)
            `svt_xvm_error("compare_write_data",$sformatf("Mismatch in First Write Transaction data and Read Transaction data "));

          foreach(packed_wr_data_0[index]) begin
            `svt_xvm_debug("body", $sformatf("PACKED WRITE DATA_0 'h%0h ",     packed_wr_data_0[index]));
            `svt_xvm_debug("body", $sformatf("PACKED INVERTED WRITE STROBE 'h%0h ",   packed_inverted_wstrb[index]));
            `svt_xvm_debug("body", $sformatf("PACKED READ DATA 'h%0h ",    packed_rd_data_1[index]));
          end 
        end //foreach of slave
      end //foreach of supporting_masters
    end //forloop of sequence_length 
    /** 
     * To check the Read data and comapre it with Write data.
     * Check done by Test.
     */
    
    `svt_xvm_debug("body", "Exiting...");
  endtask: body
endclass: svt_axi_burst_write_with_strobe_deasserted_ictest_sequence

//==============================================================================
/**
 *    #- Program the Master VIP to drive Write/Read transaction. Configure the<br> 
 *       Master transaction such that it should fire a transaction having address<br> 
 *       which doesn't fall in any of the slaves. To determine an address which <br> 
 *       would issue DECERR, address map in system configuration will need to be<br> 
 *       referred.<br> 
 *    #- Check Interconnect responds with DECERR.<br>
 *    #- Initiate the above stimulus from all Master VIPs.<br> 
 *    .
 */

class svt_axi_decode_error_response_ictest_sequence extends svt_axi_system_base_sequence;

  /** Sequence length in used to constrain the sequence length in sub-sequences */
  rand int unsigned sequence_length;

  /** Constrain the sequence length to a reasonable value */
  constraint reasonable_sequence_length {
    sequence_length <= 50;
  }
 
  /** Decode address in used to constrain the decode address in sub-sequences */
  rand bit [`SVT_AXI_MAX_ADDR_WIDTH - 1 : 0] dec_addr;

  /** Constrain the decode address to a reasonable value */
  constraint decode_address_c {
    foreach(sys_cfg.slave_addr_ranges[range]) 
      !(dec_addr inside {[sys_cfg.slave_addr_ranges[range].start_addr:sys_cfg.slave_addr_ranges[range].end_addr]});
    }
  
  /** UVM Object Utility macro */
`ifdef SVT_UVM_TECHNOLOGY
  `uvm_object_utils(svt_axi_decode_error_response_ictest_sequence)
`elsif SVT_OVM_TECHNOLOGY
  `ovm_object_utils(svt_axi_decode_error_response_ictest_sequence)
`endif

  /** Class Constructor */
  function new (string name = "svt_axi_decode_error_response_ictest_sequence");
    super.new(name);
  endfunction : new

  /** 
   * Function to check if current system configuration meets requirements of this sequence.
   * This sequence requires following configurations
   *  #- minimum supporting Masters = 1
   */
  virtual function bit is_supported(svt_configuration cfg, bit silent = 0);
    
    /** local variables */
    int num_supporting_masters;

    /** Supporting masters required */
    int required_num_supporting_masters = 1;

    `svt_xvm_debug("is_supported",$sformatf("calling is_supported"));

    /** By default is_supported is 0 */
    is_supported = 0;

    num_supporting_masters = active_participating_masters.size();

    /** check the required supporting Masters */
    if(num_supporting_masters >= required_num_supporting_masters)  begin
      is_supported = 1;
    end
    else begin
      if (silent)
        `svt_xvm_debug("is_supported",$sformatf("This sequence cannot be run based on the current system configuration.\n\
                                                Number of Supporting Master(s) - Minimum Required : 'd%0d Current : 'd%0d \n\
                                                Modify configurations through \n\
                                                svt_axi_system_configuration::num_masters,\n\
                                                svt_axi_port_configuration::is_active,\n\
                                                svt_axi_port_configuration::axi_interface_category,\n\
                                                svt_axi_system_configuration::participating_masters\n\
                                                ", required_num_supporting_masters, num_supporting_masters))
      else
        `svt_xvm_warning("is_supported",$sformatf("This sequence cannot be run based on the current system configuration.\n\
                                                Number of Supporting Master(s) - Minimum Required : 'd%0d Current : 'd%0d \n\
                                                Modify configurations through \n\
                                                svt_axi_system_configuration::num_masters,\n\
                                                svt_axi_port_configuration::is_active,\n\
                                                svt_axi_port_configuration::axi_interface_category,\n\
                                                svt_axi_system_configuration::participating_masters\n\
                                                ", required_num_supporting_masters, num_supporting_masters))
    end      
  endfunction : is_supported

  /** UVM sequence body task */ 
  virtual task body();

    /** Local variables */
    bit status;
    
    /** Write and Read transaction request handles */
    svt_axi_master_transaction wr_xact_req, rd_xact_req;

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
    

    /** Setting the response_queue_depth */ 
    set_response_queue_depth(-1);
    
    //fork off a thread to pull the responses out of response queue
    sink_responses(); 
    
    /** Execute the sequence for 'sequence_length' number of times */
    for (int i=0; i < sequence_length; i++) begin
      /** Execute the transactions from each selected active participating master */
      foreach(active_participating_masters[initiating_master_index])  begin
        int mstr = active_participating_masters[initiating_master_index];
        `svt_xvm_debug("body", $sformatf("Initiating_master_port_id is 'd%0d and a master to initiate is  'd%0d ",initiating_master_port_id,mstr) );
        `svt_xvm_debug("body", $sformatf("active_participating_masters.size is 'd%0d", active_participating_masters.size()) );

        /** Drive a Write transaction */
        `svt_xvm_do_on_with(wr_xact_req, p_sequencer.master_sequencer[mstr], {
          /* user can chose to define unmapped address */
          //addr                              == local::dec_addr;
          atomic_type                       == svt_axi_transaction::NORMAL;
          if ((sys_cfg.master_cfg[mstr].axi_interface_category == svt_axi_port_configuration::AXI_WRITE_ONLY)||(sys_cfg.master_cfg[mstr].axi_interface_category == svt_axi_port_configuration::AXI_READ_WRITE)){
            if ((sys_cfg.master_cfg[mstr].axi_interface_type == svt_axi_port_configuration::AXI_ACE) || (sys_cfg.master_cfg[mstr].axi_interface_type == svt_axi_port_configuration::ACE_LITE)) {
              coherent_xact_type              == svt_axi_transaction::WRITENOSNOOP;
              xact_type == svt_axi_transaction::COHERENT;
            } else {
              xact_type                       == svt_axi_transaction::WRITE ;
            }
          }
          else{
            if ((sys_cfg.master_cfg[mstr].axi_interface_type == svt_axi_port_configuration::AXI_ACE) || (sys_cfg.master_cfg[mstr].axi_interface_type == svt_axi_port_configuration::ACE_LITE)) {
              xact_type                       == svt_axi_transaction::COHERENT ;
              coherent_xact_type              == svt_axi_transaction::READNOSNOOP;
            } else {
              xact_type                       == svt_axi_transaction::READ ;
            }
          }
        })

        if((sys_cfg.master_cfg[mstr].axi_interface_category == svt_axi_port_configuration::AXI_READ_WRITE))  begin
          /** Drive a Read transaction */
          `svt_xvm_do_on_with(rd_xact_req, p_sequencer.master_sequencer[mstr], {
           /* user can choose to define unmapped address */
           // addr                            == local::dec_addr;
            atomic_type                     == svt_axi_transaction::NORMAL;
            xact_type                       == _read_xact_type[mstr];
            coherent_xact_type              == svt_axi_transaction::READNOSNOOP;
          })
        end
        
        fork 
          begin
            automatic svt_axi_master_transaction _wxact = wr_xact_req;
            _wxact.port_cfg = sys_cfg.master_cfg[mstr];
            //_wxact.wait_for_transaction_end();
            wait (`SVT_AXI_XACT_STATUS_ENDED(_wxact));
            if(_wxact.bresp != svt_axi_transaction::DECERR) begin
              `svt_xvm_error("body", $sformatf("Expected DECERR response(%0s) for WRITE transaction from Interconnect", _wxact.bresp.name()));
              end
          end
          begin
            automatic svt_axi_master_transaction _rxact = rd_xact_req;
            _rxact.port_cfg = sys_cfg.master_cfg[mstr];
           // _rxact.wait_for_transaction_end();
            wait (`SVT_AXI_XACT_STATUS_ENDED(_rxact));
            foreach(_rxact.rresp[index]) begin
              if(_rxact.rresp[index] != svt_axi_transaction::DECERR) begin
                `svt_xvm_error("body", $sformatf("['d%0d] Expected DECERR response(%0s) for READ transaction from Interconnect", index, _rxact.rresp[index].name()));
                end
            end
          end
        join
      end //foreach of active_participating_masters
    end //forloop of sequence_length
    /** 
     * To check Interconnect responds with DECERR.
     * Check done by System Monitor. 
     */

    `svt_xvm_debug("body", "Exiting...");
  endtask: body
endclass: svt_axi_decode_error_response_ictest_sequence

//======================================================================================
/**
 *    #- Program the Master VIP to drive multiple random transaction to each Slave.<br>
 *    #- Initiate the above stimulus from all Master VIPs sequentially towards all<br>
 *       the Slaves connected to the IC DUT.<br>
 *    .
 */

class svt_axi_random_all_master_to_all_slave_sequence extends svt_axi_system_base_sequence;
  
  rand int unsigned sequence_length;

  /** Handles for random master sequence. */
  svt_axi_random_sequence  rand_seq;

  /** Constrain the sequence length to a reasonable value. */
   constraint reasonable_sequence_length {
   sequence_length <= 500;
  }
 
  /** UVM Object Utility macro. */
  `ifdef SVT_UVM_TECHNOLOGY
    `uvm_object_utils(svt_axi_random_all_master_to_all_slave_sequence)
  `elsif SVT_OVM_TECHNOLOGY
    `ovm_object_utils(svt_axi_random_all_master_to_all_slave_sequence)
  `endif
  
  /** Class Constructor. */
  function new (string name = "svt_axi_random_all_master_to_all_slave_sequence");
    super.new(name);
  endfunction : new
 
  /** 
   * Function to check if current system configuration meets requirements of this sequence.
   * This sequence requires following configurations
   *  #- minimum supporting Masters = 1
   */
  virtual function bit is_supported(svt_configuration cfg, bit silent = 0);
    
    /** local variables */
    int num_supporting_masters;

    /** Supporting masters required */
    int required_num_supporting_masters = 1;

    `svt_xvm_debug("is_supported",$sformatf("calling is_supported"));

    /** By default is_supported is 0 */
    is_supported = 0;

    num_supporting_masters = active_participating_masters.size();
    
    /** Check the required supporting Masters   */
    if(num_supporting_masters >= required_num_supporting_masters)   begin
      is_supported = 1;
    end
    else begin
      if (silent)
        `svt_xvm_debug("is_supported",$sformatf("This sequence cannot be run based on the current system configuration.\n\
                                                Number of Supporting Master(s) - Minimum Required : 'd%0d Current : 'd%0d \n\
                                                Modify configurations through \n\
                                                svt_axi_system_configuration::num_masters,\n\
                                                svt_axi_port_configuration::is_active,\n\
                                                svt_axi_port_configuration::axi_interface_category,\n\
                                                svt_axi_system_configuration::participating_masters\
                                                ", required_num_supporting_masters, num_supporting_masters))
      else
        `svt_xvm_warning("is_supported",$sformatf("This sequence cannot be run based on the current system configuration.\n\
                                                Number of Supporting Master(s) - Minimum Required : 'd%0d Current : 'd%0d \n\
                                                Modify configurations through \n\
                                                svt_axi_system_configuration::num_masters,\n\
                                                svt_axi_port_configuration::is_active,\n\
                                                svt_axi_port_configuration::axi_interface_category,\n\
                                                svt_axi_system_configuration::participating_masters\
                                                ", required_num_supporting_masters, num_supporting_masters))
    end      
  endfunction : is_supported

  /** body task of the sequence **/
  virtual task body ();
    bit status; 
    int mstr;
  
    `svt_xvm_debug("body", "Entering...");
`ifdef SVT_UVM_TECHNOLOGY
    status = uvm_config_db#(int unsigned)::get(null, get_full_name(), "sequence_length", sequence_length);
`elsif SVT_OVM_TECHNOLOGY
    void'(m_sequencer.get_config_int({get_type_name(), "sequence_length"},  sequence_length));
`endif
    `svt_xvm_debug("body", $sformatf("sequence_length is 'd%0d as a result of %0s.", sequence_length,
                                     status ? "config DB" : "randomization"));
     
    /** Check if current environment is supported or not */ 
    if(!is_supported(sys_cfg, silent))  begin
      `svt_xvm_note("body",$sformatf("This sequence cannot be run based on the current system configuration. Exiting..."))
      return;
    end
  
    /** Setting the response_queue_depth */ 
    set_response_queue_depth(-1);

    /** Fork off a thread to pull the responses out of response queue. */
    sink_responses();

    /**  Execute the sequence for 'sequence_length' number of times. */ 
    for (int i=0; i< sequence_length; i++) begin
      
     /** Execute the transactions from each selected active participating master */
     foreach (active_participating_masters[initiating_master_index]) begin
        mstr = active_participating_masters[initiating_master_index];
        `svt_xvm_debug("body", $sformatf("Master to initiate is  'd%0d initiating master index='d%0d ",mstr,initiating_master_index) );
           
        /** Execute the transactions in each Slave from selected Master */
        foreach(participating_slaves_arr[index])  begin
          int slv = participating_slaves_arr[index];
          `svt_xvm_debug("body", $sformatf("Slave to participate is  'd%0d index='d%0d ",slv,index) );

          `svt_xvm_do_on_with(rand_seq,p_sequencer.master_sequencer[mstr], {
            slv_num == slv;
            if (sys_cfg.master_cfg[mstr].axi_interface_category == svt_axi_port_configuration::AXI_WRITE_ONLY){
              xact_type  ==  WRITE;
            }
            else if (sys_cfg.master_cfg[mstr].axi_interface_category == svt_axi_port_configuration::AXI_READ_ONLY){
              xact_type  ==  READ;
            }
            else {
              xact_type  ==  RANDOM;
            }  
          })
        end //foreach of active slave 
      end //foreach of active participating master 
    end //for sequence_length  
   
    `svt_xvm_debug("body", "Exiting...");
  endtask: body
endclass: svt_axi_random_all_master_to_all_slave_sequence
 
//======================================================================================
/**
 *    #- Program the Master VIP to drive multiple random transaction.<br>
 *    .
 */
class svt_axi_random_ictest_sequence extends svt_axi_system_base_sequence;

  /** Sequence length in used to constsrain the sequence length in sub-sequences. */
  rand int unsigned sequence_length;

  /** Write transaction request handles. */
  svt_axi_master_transaction xact;

  /** Handles for random master sequence. */
  svt_axi_random_sequence  rand_seq;

  /** Local variables */
  int mstr;
  
  /** Constrain the sequence length to a reasonable value. */
  constraint reasonable_sequence_length {
    sequence_length <= 500;
  }

/** UVM Object Utility macro. */
`ifdef SVT_UVM_TECHNOLOGY
  `uvm_object_utils(svt_axi_random_ictest_sequence)
`elsif SVT_OVM_TECHNOLOGY
  `ovm_object_utils(svt_axi_random_ictest_sequence)
`endif
  
  /** Class Constructor. */
  function new (string name = "svt_axi_random_ictest_sequence");
    super.new(name);
  endfunction : new
 
  /** 
   * Function to check if current system configuration meets requirements of this sequence.
   * This sequence requires following configurations
   *  #- minimum supporting Masters = 1
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

    num_supporting_masters = active_participating_masters.size();
    num_supporting_slaves = participating_slaves_arr.size();
    /** Check the required supporting Masters   */
    if((num_supporting_masters >= required_num_supporting_masters) && (num_supporting_slaves >= required_num_supporting_slaves))   begin
      is_supported = 1;
    end
    else begin
      if (silent)
        `svt_xvm_debug("is_supported",$sformatf("This sequence cannot be run based on the current system configuration.\n\
                                                Number of Supporting Master(s) - Minimum Required : 'd%0d Current : 'd%0d \n\
                                                Modify configurations through \n\
                                                svt_axi_system_configuration::num_masters,\n\
                                                svt_axi_port_configuration::is_active,\n\
                                                svt_axi_port_configuration::axi_interface_category,\n\
                                                svt_axi_system_configuration::participating_masters\n\
                                                Number of Supporting Slave(s)  - Minimum Required : 'd%0d Current : 'd%0d \n\
                                                Modify configurations through \n\
                                                svt_axi_system_configuration::num_slaves,\n\
                                                svt_axi_port_configuration::is_active\
                                                ", required_num_supporting_masters, num_supporting_masters, required_num_supporting_slaves, num_supporting_slaves))
      else
        `svt_xvm_warning("is_supported",$sformatf("This sequence cannot be run based on the current system configuration.\n\
                                                Number of Supporting Master(s) - Minimum Required : 'd%0d Current : 'd%0d \n\
                                                Modify configurations through \n\
                                                svt_axi_system_configuration::num_masters,\n\
                                                svt_axi_port_configuration::is_active,\n\
                                                svt_axi_port_configuration::axi_interface_category,\n\
                                                svt_axi_system_configuration::participating_masters\n\
                                                Number of Supporting Slave(s)  - Minimum Required : 'd%0d Current : 'd%0d \n\
                                                Modify configurations through \n\
                                                svt_axi_system_configuration::num_slaves,\n\
                                                svt_axi_port_configuration::is_active\
                                                ", required_num_supporting_masters, num_supporting_masters, required_num_supporting_slaves, num_supporting_slaves))
    end      
  endfunction : is_supported

  /** UVM sequence body task. */
  virtual task body();

    /** Local variables. */
    bit status;  
        
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

    /** Setting the response_queue_depth */ 
    set_response_queue_depth(-1);

    /** Randomly select a active participating Master */
    mstr = initiating_master_index;
    `svt_xvm_debug("body", $sformatf("Master to initiate = 'd%0d initiating_master_index = 'd%0d ",mstr,initiating_master_index) );
    
    /** Fork off a thread to pull the responses out of response queue. */
    sink_responses();

    /**  Execute the sequence for 'sequence_length' number of times. */ 
    for (int i=0; i< sequence_length; i++)begin

      /** Random Master fires transaction to a randomly selected Slave. */ 
      `svt_xvm_do_on_with(rand_seq,p_sequencer.master_sequencer[mstr], {
        slv_num inside {participating_slaves_arr}; 
        if (sys_cfg.master_cfg[mstr].axi_interface_category == svt_axi_port_configuration::AXI_WRITE_ONLY){
          xact_type  ==  WRITE;
        }
        else if (sys_cfg.master_cfg[mstr].axi_interface_category == svt_axi_port_configuration::AXI_READ_ONLY){
          xact_type  ==  READ;
        }
        else {
          xact_type  ==  RANDOM;
        }  
      })
    
    end//for sequence length  
    /**
     * To check .
     * Check performed by System Monitor.
     */
    
    `svt_xvm_debug("body", "Exiting...");
  endtask: body
endclass: svt_axi_random_ictest_sequence

//======================================================================================
/**
 *    #- Program the Master VIP to drive random transactions with burst size<br>
 *       (AxSIZE) equal to data width of AXI bus, aligned address and all other control<br> 
 *       fields generated  randomly.<br>
 *    .
 */

class svt_axi_burst_aligned_addr_full_data_width_random_ictest_sequence extends svt_axi_system_base_sequence;

  /** Sequence length in used to constsrain the sequence length in sub-sequences. */
  rand int unsigned sequence_length;

  /** Write transaction request handles. */
  svt_axi_master_transaction xact;

  /** Constrain the sequence length to a reasonable value. */
  constraint reasonable_sequence_length {
    sequence_length <= 50;
  }

/** UVM Object Utility macro. */
`ifdef SVT_UVM_TECHNOLOGY
  `uvm_object_utils(svt_axi_burst_aligned_addr_full_data_width_random_ictest_sequence)
`elsif SVT_OVM_TECHNOLOGY
  `ovm_object_utils(svt_axi_burst_aligned_addr_full_data_width_random_ictest_sequence)
`endif
  
  /** Class Constructor. */
  function new (string name = "svt_axi_burst_aligned_addr_full_data_width_random_ictest_sequence");
    super.new(name);
  endfunction : new
  
  /** 
   * Function to check if current system configuration meets requirements of this sequence.
   * This sequence requires following configurations
   *  #- minimum supporting Masters = 1
   */
  virtual function bit is_supported(svt_configuration cfg, bit silent = 0);
    
    /** local variables */
    int num_supporting_masters;

    /** Supporting masters required */
    int required_num_supporting_masters = 1;

    `svt_xvm_debug("is_supported",$sformatf("calling is_supported"));

    /** By default is_supported is 0 */
    is_supported = 0;

    num_supporting_masters = active_participating_masters.size();
    
    /** Check the required supporting Masters   */
    if(num_supporting_masters >= required_num_supporting_masters)   begin
      is_supported = 1;
    end
    else begin
      if (silent)
        `svt_xvm_debug("is_supported",$sformatf("This sequence cannot be run based on the current system configuration.\n\
                                                Number of Supporting Master(s) - Minimum Required : 'd%0d Current : 'd%0d \n\
                                                Modify configurations through \n\
                                                svt_axi_system_configuration::num_masters,\n\
                                                svt_axi_port_configuration::is_active,\n\
                                                svt_axi_port_configuration::axi_interface_category,\n\
                                                svt_axi_system_configuration::participating_masters\
                                                ", required_num_supporting_masters, num_supporting_masters))
      else
        `svt_xvm_warning("is_supported",$sformatf("This sequence cannot be run based on the current system configuration.\n\
                                                Number of Supporting Master(s) - Minimum Required : 'd%0d Current : 'd%0d \n\
                                                Modify configurations through \n\
                                                svt_axi_system_configuration::num_masters,\n\
                                                svt_axi_port_configuration::is_active,\n\
                                                svt_axi_port_configuration::axi_interface_category,\n\
                                                svt_axi_system_configuration::participating_masters\
                                                ", required_num_supporting_masters, num_supporting_masters))
    end      
  endfunction : is_supported
 
  /** UVM sequence body task. */
  virtual task body();

    /** Local variables. */
    bit status;  
    int mstr; 
    bit[`SVT_AXI_MAX_ADDR_WIDTH-1:0] lo_addr;
    bit[`SVT_AXI_MAX_ADDR_WIDTH-1:0] hi_addr;
    int xact_length;
    
    int xact_length_width;
    int xact_length_status;
    int xact_length_arr[$];
    int selected_slv;
    int log_base_2_data_width;

    `svt_xvm_debug("body", "Entering...");
`ifdef SVT_UVM_TECHNOLOGY
    status = uvm_config_db#(int unsigned)::get(null, get_full_name(), "sequence_length", sequence_length);
    xact_length_status = uvm_config_db#(int unsigned)::get(null, get_full_name(), "xact_length_width", xact_length_width); 
`elsif SVT_OVM_TECHNOLOGY
    void'(m_sequencer.get_config_int({get_type_name(), "sequence_length"},  sequence_length));
    void'(m_sequencer.get_config_int({get_type_name(), "xact_length_width"},  xact_length_width));
`endif
    `svt_xvm_debug("body", $sformatf("sequence_length is 'd%0d as a result of %0s.", sequence_length,
                                     status ? "config DB" : "randomization"));
    `svt_xvm_debug("body", $sformatf("xact_length_width is 'd%0d as a result of %0s.", xact_length_width,
                                     xact_length_status ? "config DB" : "randomization"));
     
    /** check if current environment is supported or not */ 
    if(!is_supported(sys_cfg, silent))  begin
      `svt_xvm_note("body",$sformatf("This sequence cannot be run based on the current system configuration. Exiting..."))
      return;
    end

    /** Setting the response_queue_depth */ 
    set_response_queue_depth(-1);

    /** Fork off a thread to pull the responses out of response queue. */
    sink_responses();

    /**  Execute the sequence for 'sequence_length' number of times. */ 
    for (int i=0; i< sequence_length; i++)begin

      /** Randomize the number of transaction for each sequence length  */
      for(int k=0; k < (1<<xact_length_width) ; k++)  begin
        xact_length_arr.push_back(k);
      end
      /** Shuffling all collected Values */
      xact_length_arr.shuffle;
      xact_length = xact_length_arr.pop_front();
      `svt_xvm_debug("body", $sformatf("xact_length is 'd%0d ", xact_length));
      
      /**  Execute the sequence for 'xact_length' number of times. */ 
      for (int j=0; j<xact_length ; j++)begin

        /** Randomly select a active participating Master */
        mstr = initiating_master_index;
        `svt_xvm_debug("body", $sformatf("Master to initiate = 'd%0d initiating_master_index = 'd%0d ",mstr,initiating_master_index) );
        
        /** Randomly select a slave */
        selected_slv = participating_slave_index;
        `svt_xvm_debug("body", $sformatf("Slave to participate = 'd%0d participating_slave_index = 'd%0d ",selected_slv,participating_slave_index) );

        /** Randomly select an Address range for selected slave */
        if (!sys_cfg.get_slave_addr_range(mstr,selected_slv,lo_addr,hi_addr,null))
          `svt_xvm_warning("body", $sformatf("Unable to obtain a memory range for slave index 'd%0d", selected_slv));
       
        /** Calculate the log base of the data width of the bus of selected Master*/
        `protected
171_&)Va\\3CKN:dM=WL>YP+BNKBEbL1b>.-X+DHOC1BMF@e8+fV3)Zg5,/V9O#>
:0VDd(acJ_43>SBc?XH3A;+a4WJ,e#e^3;1(I]-,_#[+31Z5<LFBS=_T<MB2Y(2S
910g;.<]_T<K8A:YN\W=\;B?e8EGSXU);.HR:^^4-g/ABGL_,+-[+PT=4e9SZ?eI
9K8Ff]?DQd+WBC3;ge>0VeJC:+B:26JW;$
`endprotected


        /** Random Master fires transaction to a randomly selected Slave. */ 
        `svt_xvm_do_on_with(xact,p_sequencer.master_sequencer[mstr],{
          if (sys_cfg.master_cfg[mstr].axi_interface_category == svt_axi_port_configuration::AXI_WRITE_ONLY){
            xact_type  == _write_xact_type[mstr];
          }
          else if (sys_cfg.master_cfg[mstr].axi_interface_category == svt_axi_port_configuration::AXI_READ_ONLY){
            xact_type  == _read_xact_type[mstr];
          }
          else {
            xact_type inside {_read_xact_type[mstr],_write_xact_type[mstr]};
          }  
          atomic_type == svt_axi_transaction::NORMAL;
          (xact_type == svt_axi_transaction::WRITE) ->   (coherent_xact_type == svt_axi_transaction::WRITENOSNOOP);
          (xact_type == svt_axi_transaction::READ) -> (coherent_xact_type == svt_axi_transaction::READNOSNOOP);
          (xact_type == svt_axi_transaction::COHERENT) -> (coherent_xact_type inside {svt_axi_transaction::READNOSNOOP,svt_axi_transaction::WRITENOSNOOP});
          addr        >= lo_addr;
          addr        <= hi_addr-(burst_length*(1<<burst_size));
          addr        == (addr & ({`SVT_AXI_MAX_ADDR_WIDTH{1'b1}} << burst_size)); 
          burst_size ==  log_base_2_data_width - 3;
        })
        
      end//for xact_length 
    end//for sequence length  
    /**
     * To check .
     * Check performed by System Monitor.
     */
    
    `svt_xvm_debug("body", "Exiting...");
  endtask: body
endclass:svt_axi_burst_aligned_addr_full_data_width_random_ictest_sequence

//======================================================================================
/**
 *    #- Program the Master VIP to drive random transactions with burst size<br>
 *       (AxSIZE) equal to data width of AXI bus, unaligned address and all other<br>
 *       control fields generated randomly.<br>
 *    .
 */

class svt_axi_burst_unaligned_addr_full_data_width_random_ictest_sequence extends svt_axi_system_base_sequence;

  /** Sequence length in used to constsrain the sequence length in sub-sequences. */
  rand int unsigned sequence_length;
  
  /** Write transaction request handles. */
  svt_axi_master_transaction xact;

  /** Constrain the sequence length to a reasonable value. */
  constraint reasonable_sequence_length {
    sequence_length <= 50;
  }
 
/** UVM Object Utility macro. */
`ifdef SVT_UVM_TECHNOLOGY
  `uvm_object_utils(svt_axi_burst_unaligned_addr_full_data_width_random_ictest_sequence)
`elsif SVT_OVM_TECHNOLOGY
  `ovm_object_utils(svt_axi_burst_unaligned_addr_full_data_width_random_ictest_sequence)
`endif

  /** Class Constructor. */
  function new (string name = "svt_axi_burst_unaligned_addr_full_data_width_random_ictest_sequence");
    super.new(name);
  endfunction : new
 
  /** 
   * Function to check if current system configuration meets requirements of this sequence.
   * This sequence requires following configurations
   *  #- minimum supporting Masters = 1
   */
  virtual function bit is_supported(svt_configuration cfg, bit silent = 0);
    
    /** local variables */
    int num_supporting_masters;

    /** Supporting masters required */
    int required_num_supporting_masters = 1;

    `svt_xvm_debug("is_supported",$sformatf("calling is_supported"));

    /** By default is_supported is 0 */
    is_supported = 0;

    num_supporting_masters = active_participating_masters.size();
    
    /** Check the required supporting Masters   */
    if(num_supporting_masters >= required_num_supporting_masters)   begin
      is_supported = 1;
    end
    else begin
      if (silent)
        `svt_xvm_debug("is_supported",$sformatf("This sequence cannot be run based on the current system configuration.\n\
                                                Number of Supporting Master(s) - Minimum Required : 'd%0d Current : 'd%0d \n\
                                                Modify configurations through \n\
                                                svt_axi_system_configuration::num_masters,\n\
                                                svt_axi_port_configuration::is_active,\n\
                                                svt_axi_port_configuration::axi_interface_category,\n\
                                                svt_axi_system_configuration::participating_masters\
                                                ", required_num_supporting_masters, num_supporting_masters))
      else
        `svt_xvm_warning("is_supported",$sformatf("This sequence cannot be run based on the current system configuration.\n\
                                                Number of Supporting Master(s) - Minimum Required : 'd%0d Current : 'd%0d \n\
                                                Modify configurations through \n\
                                                svt_axi_system_configuration::num_masters,\n\
                                                svt_axi_port_configuration::is_active,\n\
                                                svt_axi_port_configuration::axi_interface_category,\n\
                                                svt_axi_system_configuration::participating_masters\
                                                ", required_num_supporting_masters, num_supporting_masters))
    end      
  endfunction : is_supported

  /** UVM sequence body task. */
  virtual task body();

    /** Local variables. */
    bit status;  
    int mstr;
    bit[`SVT_AXI_MAX_ADDR_WIDTH-1:0] lo_addr;
    bit[`SVT_AXI_MAX_ADDR_WIDTH-1:0] hi_addr;
    int xact_length;
    int log_base_2_data_width;
    int xact_length_width;
    int xact_length_status;
    int xact_length_arr[$];
    int initiating_master_idx_array[$];
    int participating_slave_idx_array[$];
    int selected_slv;

    `svt_xvm_debug("body", "Entering...");
`ifdef SVT_UVM_TECHNOLOGY
    status = uvm_config_db#(int unsigned)::get(null, get_full_name(), "sequence_length", sequence_length);
    xact_length_status = uvm_config_db#(int unsigned)::get(null, get_full_name(), "xact_length_width", xact_length_width); 
`elsif SVT_OVM_TECHNOLOGY
    void'(m_sequencer.get_config_int({get_type_name(), "sequence_length"},  sequence_length));
    void'(m_sequencer.get_config_int({get_type_name(), "xact_length_width"},  xact_length_width));
`endif
    `svt_xvm_debug("body", $sformatf("sequence_length is 'd%0d as a result of %0s.", sequence_length,
                                     status ? "config DB" : "randomization"));
    
    `svt_xvm_debug("body", $sformatf("xact_length_width is 'd%0d as a result of %0s.", xact_length_width,
                                     xact_length_status ? "config DB" : "randomization"));

    /** check if current environment is supported or not */ 
    if(!is_supported(sys_cfg, silent))  begin
      `svt_xvm_note("body",$sformatf("This sequence cannot be run based on the current system configuration. Exiting..."))
      return;
    end

    /** Setting the response_queue_depth */ 
    set_response_queue_depth(-1);

    /** Fork off a thread to pull the responses out of response queue. */
    sink_responses();

    /**  Execute the sequence for 'sequence_length' number of times. */ 
    for (int i=0; i< sequence_length; i++)begin
       
      /** Randomize the number of transaction for each sequence length  */
      for(int k=0; k < (1<<xact_length_width) ; k++)  begin
        xact_length_arr.push_back(k);
      end
      /** Shuffling all collected Values */
      xact_length_arr.shuffle;
      xact_length = xact_length_arr.pop_front();
      `svt_xvm_debug("body", $sformatf("xact_length is 'd%0d ", xact_length));
 
      /**  Execute the sequence for 'xact_length' number of times. */ 
      for (int j=0; j<xact_length ; j++)begin

        /** Randomly select an active participating Master */
        mstr = initiating_master_index;
        `svt_xvm_debug("body", $sformatf("Master to initiate = 'd%0d initiating_master_index = 'd%0d ",mstr,initiating_master_index) );
      
        /** Randomly select a slave */
        selected_slv = participating_slave_index;
        `svt_xvm_debug("body", $sformatf("Slave to participate = 'd%0d participating_slave_index = 'd%0d ",selected_slv,participating_slave_index) );

        /** Randomly select an Address range for selected slave */
        if (!sys_cfg.get_slave_addr_range(mstr,selected_slv,lo_addr,hi_addr,null))
          `svt_xvm_warning("body", $sformatf("Unable to obtain a memory range for slave index 'd%0d", selected_slv));
      
        /** Calculate the log base of the data width of the bus of selected Master*/
        `protected
JSB2[GCE1G0K9:Xf\Y3MG#ALO3/Xda6KEa9QXO#IHd7Q/_51LU.65),X@Z^b0?U<
_A2=<@8YJ\=<)Kf)6PQRN&Q68ZaJVCJH4=B&B;cV?.-R-KU[U^a=,cGR[TWdfd3_
3+S#RZ<KY_)eV/TQJB6:&JZ6-24O0RbC8KE23gb#?0QW3cJ^,gI#9#LW:+;3Q(T\
1W5Z7XaMCN?7#<9]1KG_#KK+b]P1U/9E;$
`endprotected

  
        /** Random Master fires transaction to a randomly selected Slave. */ 
        `svt_xvm_do_on_with(xact,p_sequencer.master_sequencer[mstr],{
          if (sys_cfg.master_cfg[mstr].axi_interface_category == svt_axi_port_configuration::AXI_WRITE_ONLY){
            xact_type  == _write_xact_type[mstr];
          }
          else if (sys_cfg.master_cfg[mstr].axi_interface_category == svt_axi_port_configuration::AXI_READ_ONLY){
            xact_type  == _read_xact_type[mstr];
          }
          else {
            xact_type inside {_read_xact_type[mstr],_write_xact_type[mstr]};
          }  
          atomic_type == svt_axi_transaction::NORMAL;
          (xact_type == svt_axi_transaction::WRITE) ->   (coherent_xact_type == svt_axi_transaction::WRITENOSNOOP);
          (xact_type == svt_axi_transaction::READ) -> (coherent_xact_type == svt_axi_transaction::READNOSNOOP);
          (xact_type == svt_axi_transaction::COHERENT) -> (coherent_xact_type inside {svt_axi_transaction::READNOSNOOP,svt_axi_transaction::WRITENOSNOOP});
          addr        >= lo_addr;
          addr        <= hi_addr-(burst_length*(1<<burst_size));
          addr        !=  (addr & ({`SVT_AXI_MAX_ADDR_WIDTH{1'b1}} <<  burst_size)); 
          burst_size == log_base_2_data_width - 3 ;
        })
        
      end//for xact length 

      foreach(active_participating_masters[initiating_idx]) begin
        initiating_master_idx_array.push_back(active_participating_masters[initiating_idx]);
      end
      
      foreach(participating_slaves_arr[participating_idx]) begin
        participating_slave_idx_array.push_back(participating_slaves_arr[participating_idx]);
      end

      initiating_master_idx_array.shuffle;
      initiating_master_index = initiating_master_idx_array.pop_front();
      
      participating_slave_idx_array.shuffle;
      participating_slave_index = participating_slave_idx_array.pop_front();
      
    end//for sequence length  
    /**
     * To check .
     * Check performed by System Monitor.
     */
    
    `svt_xvm_debug("body", "Exiting...");
  endtask: body
endclass:svt_axi_burst_unaligned_addr_full_data_width_random_ictest_sequence

//======================================================================================
/**
 *    #- Program the Master VIP to drive random transactions with narrow transfers,<br>
 *       aligned address and all other control fields generated  randomly.<br>
 *    .
 */

class svt_axi_burst_aligned_addr_narrow_transfers_random_ictest_sequence extends svt_axi_system_base_sequence;

  /** Sequence length in used to constsrain the sequence length in sub-sequences. */
  rand int unsigned sequence_length;
  
  /** Write transaction request handles. */
  svt_axi_master_transaction xact;

  /** Constrain the sequence length to a reasonable value. */
  constraint reasonable_sequence_length {
    sequence_length <= 50;
  }
 
/** UVM Object Utility macro. */
`ifdef SVT_UVM_TECHNOLOGY
  `uvm_object_utils(svt_axi_burst_aligned_addr_narrow_transfers_random_ictest_sequence)
`elsif SVT_OVM_TECHNOLOGY
  `ovm_object_utils(svt_axi_burst_aligned_addr_narrow_transfers_random_ictest_sequence)
`endif
  
  /** Class Constructor. */
  function new (string name = "svt_axi_burst_aligned_addr_narrow_transfers_random_ictest_sequence");
    super.new(name);
  endfunction : new
 
  /** 
   * Function to check if current system configuration meets requirements of this sequence.
   * This sequence requires following configurations
   *  #- minimum supporting Masters = 1
   *  #- minimum supporting Slaves = 1
   */
  virtual function bit is_supported(svt_configuration cfg, bit silent = 0);
    
    /** local variables */
    int num_supporting_masters;
    int num_supporting_slaves;

    /** Supporting masters required */
    int required_num_supporting_masters = 1;

    /** Supporting slaves required */
    int required_num_supporting_slaves  = 1;
    `svt_xvm_debug("is_supported",$sformatf("calling is_supported"));

    /** By default is_supported is 0 */
    is_supported = 0;

    num_supporting_masters = active_participating_masters.size();
    num_supporting_slaves = participating_slaves_arr.size();    

    /** check the required supporting Masters and Slaves  */
    if(num_supporting_masters >= required_num_supporting_masters && num_supporting_slaves >= required_num_supporting_slaves )  begin
      is_supported = 1;
    end
    else begin
      if (silent)
        `svt_xvm_debug("is_supported",$sformatf("This sequence cannot be run based on the current system configuration.\n\
                                                Number of Supporting Master(s) - Minimum Required : 'd%0d Current : 'd%0d \n\
                                                Modify configurations through \n\
                                                svt_axi_system_configuration::num_masters,\n\
                                                svt_axi_port_configuration::is_active,\n\
                                                svt_axi_port_configuration::axi_interface_category,\n\
                                                svt_axi_system_configuration::participating_masters, \n\
                                                Number of Supporting Slave(s)  - Minimum Required : 'd%0d Current : 'd%0d \n\
                                                Modify configurations through \n\
                                                svt_axi_system_configuration::num_slaves,\n\
                                                svt_axi_system_configuration::participating_slaves\
                                                ", required_num_supporting_masters, num_supporting_masters, required_num_supporting_slaves, num_supporting_slaves))
      else
        `svt_xvm_warning("is_supported",$sformatf("This sequence cannot be run based on the current system configuration.\n\
                                                Number of Supporting Master(s) - Minimum Required : 'd%0d Current : 'd%0d \n\
                                                Modify configurations through \n\
                                                svt_axi_system_configuration::num_masters,\n\
                                                svt_axi_port_configuration::is_active,\n\
                                                svt_axi_port_configuration::axi_interface_category,\n\
                                                svt_axi_system_configuration::participating_masters, \n\
                                                Number of Supporting Slave(s)  - Minimum Required : 'd%0d Current : 'd%0d \n\
                                                Modify configurations through \n\
                                                svt_axi_system_configuration::num_slaves,\n\
                                                svt_axi_system_configuration::participating_slaves\
                                                ", required_num_supporting_masters, num_supporting_masters, required_num_supporting_slaves, num_supporting_slaves))
    end    
  endfunction : is_supported

  /** UVM sequence body task. */
  virtual task body();

    /** Local variables. */
    bit status;  
    int mstr;
    bit[`SVT_AXI_MAX_ADDR_WIDTH-1:0] lo_addr;
    bit[`SVT_AXI_MAX_ADDR_WIDTH-1:0] hi_addr;
    int xact_length;
    int xact_length_width;
    int xact_length_status;
    int xact_length_arr[$];
    int selected_slv;

    `svt_xvm_debug("body", "Entering...");
`ifdef SVT_UVM_TECHNOLOGY
    status = uvm_config_db#(int unsigned)::get(null, get_full_name(), "sequence_length", sequence_length);
    xact_length_status = uvm_config_db#(int unsigned)::get(null, get_full_name(), "xact_length_width", xact_length_width); 
`elsif SVT_OVM_TECHNOLOGY
    void'(m_sequencer.get_config_int({get_type_name(), "sequence_length"},  sequence_length));
    void'(m_sequencer.get_config_int({get_type_name(), "xact_length_width"},  xact_length_width));
`endif
    `svt_xvm_debug("body", $sformatf("sequence_length is 'd%0d as a result of %0s.", sequence_length,
                                     status ? "config DB" : "randomization"));
    `svt_xvm_debug("body", $sformatf("xact_length_width is 'd%0d as a result of %0s.", xact_length_width,
                                     xact_length_status ? "config DB" : "randomization"));
     
    /** check if current environment is supported or not */ 
    if(!is_supported(sys_cfg, silent))  begin
      `svt_xvm_note("body",$sformatf("This sequence cannot be run based on the current system configuration. Exiting..."))
      return;
    end
   
    /** Setting the response_queue_depth */ 
    set_response_queue_depth(-1);

    /** Fork off a thread to pull the responses out of response queue. */
    sink_responses();

    /**  Execute the sequence for 'sequence_length' number of times. */ 
    for (int i=0; i< sequence_length; i++)begin
           
      /** Randomize the number of transaction for each sequence length  */
      for(int k=0; k < (1<<xact_length_width) ; k++)  begin
        xact_length_arr.push_back(k);
      end
      /** Shuffling all collected Values */
      xact_length_arr.shuffle;
      xact_length = xact_length_arr.pop_front();
      `svt_xvm_debug("body", $sformatf("xact_length is 'd%0d ", xact_length)); 

      /**  Execute the sequence for 'xact_length' number of times. */ 
      for (int j=0; j<xact_length ; j++)begin
        
        /** Randomly select an active participating Master */
        mstr = initiating_master_index;
        `svt_xvm_debug("body", $sformatf("Master to initiate = 'd%0d initiating_master_index = 'd%0d ",mstr,initiating_master_index) );
        
        /** Randomly select a slave */
        selected_slv = participating_slave_index;
        `svt_xvm_debug("body", $sformatf("Slave to participate = 'd%0d participating_slave_index = 'd%0d ",selected_slv,participating_slave_index) );

        /** Randomly select an Address range for selected slave */
        if (!sys_cfg.get_slave_addr_range(mstr,selected_slv,lo_addr,hi_addr,null))
          `svt_xvm_warning("body", $sformatf("Unable to obtain a memory range for slave index 'd%0d", selected_slv));
       
        /** Random Master fires transaction to a randomly selected Slave. */ 
        `svt_xvm_do_on_with(xact,p_sequencer.master_sequencer[mstr],{
          if (sys_cfg.master_cfg[mstr].axi_interface_category == svt_axi_port_configuration::AXI_WRITE_ONLY){
            xact_type  == _write_xact_type[mstr];
          }
          else if (sys_cfg.master_cfg[mstr].axi_interface_category == svt_axi_port_configuration::AXI_READ_ONLY){
            xact_type  == _read_xact_type[mstr];
          }
          else {
            xact_type inside {_read_xact_type[mstr],_write_xact_type[mstr]};
          }  
          atomic_type == svt_axi_transaction::NORMAL;
          (xact_type == svt_axi_transaction::WRITE) ->   (coherent_xact_type == svt_axi_transaction::WRITENOSNOOP);
          (xact_type == svt_axi_transaction::READ) -> (coherent_xact_type == svt_axi_transaction::READNOSNOOP);
          (xact_type == svt_axi_transaction::COHERENT) -> (coherent_xact_type inside {svt_axi_transaction::READNOSNOOP,svt_axi_transaction::WRITENOSNOOP});
          addr        >= lo_addr;
          addr        <= hi_addr-(burst_length*(1<<burst_size));
          addr       ==  (addr & ({`SVT_AXI_MAX_ADDR_WIDTH{1'b1}} <<  burst_size)); 
        })
        
      end//for xact length 
    end//for sequence length  
    /**
     * To check .
     * Check performed by System Monitor. 
     */
    
    `svt_xvm_debug("body", "Exiting...");
  endtask: body
endclass:svt_axi_burst_aligned_addr_narrow_transfers_random_ictest_sequence

//======================================================================================
/**
 *    #- Program the Master VIP to drive random transactions with narrow transfers,<br>
 *       unaligned address and all other control fields generated randomly.<br>
 *    .
 */

class svt_axi_burst_unaligned_addr_narrow_transfers_random_ictest_sequence extends svt_axi_system_base_sequence;

  /** Sequence length in used to constsrain the sequence length in sub-sequences. */
  rand int unsigned sequence_length;
  
  /** Write transaction request handles. */
  svt_axi_master_transaction xact;

  /** Constrain the sequence length to a reasonable value. */
  constraint reasonable_sequence_length {
    sequence_length <= 50;
  }
 
/** UVM Object Utility macro. */
`ifdef SVT_UVM_TECHNOLOGY
  `uvm_object_utils(svt_axi_burst_unaligned_addr_narrow_transfers_random_ictest_sequence)
`elsif SVT_OVM_TECHNOLOGY
  `ovm_object_utils(svt_axi_burst_unaligned_addr_narrow_transfers_random_ictest_sequence)
`endif
  
  /** Class Constructor. */
  function new (string name = "svt_axi_burst_unaligned_addr_narrow_transfers_random_ictest_sequence");
    super.new(name);
  endfunction : new
 
  /** 
   * Function to check if current system configuration meets requirements of this sequence.
   * This sequence requires following configurations
   *  #- minimum supporting Masters = 1
   *  #- minimum supporting Slaves = 1
   */
  virtual function bit is_supported(svt_configuration cfg, bit silent = 0);
    
    /** local variables */
    int num_supporting_masters;
    int num_supporting_slaves;

    /** Supporting masters required */
    int required_num_supporting_masters = 1;

    /** Supporting slaves required */
    int required_num_supporting_slaves  = 1;
    `svt_xvm_debug("is_supported",$sformatf("calling is_supported"));

    /** By default is_supported is 0 */
    is_supported = 0;

    num_supporting_masters = active_participating_masters.size();
    num_supporting_slaves = participating_slaves_arr.size();   

    /** check the required supporting Masters and Slaves  */
    if(num_supporting_masters >= required_num_supporting_masters && num_supporting_slaves >= required_num_supporting_slaves )  begin
      is_supported = 1;
    end
    else begin
      if (silent)
        `svt_xvm_debug("is_supported",$sformatf("This sequence cannot be run based on the current system configuration.\n\
                                                Number of Supporting Master(s) - Minimum Required : 'd%0d Current : 'd%0d \n\
                                                Modify configurations through \n\
                                                svt_axi_system_configuration::num_masters,\n\
                                                svt_axi_port_configuration::is_active,\n\
                                                svt_axi_port_configuration::axi_interface_category,\n\
                                                svt_axi_system_configuration::participating_masters, \n\
                                                Number of Supporting Slave(s)  - Minimum Required : 'd%0d Current : 'd%0d \n\
                                                Modify configurations through \n\
                                                svt_axi_system_configuration::num_slaves,\n\
                                                svt_axi_system_configuration::participating_slaves\
                                                ", required_num_supporting_masters, num_supporting_masters, required_num_supporting_slaves, num_supporting_slaves))
      else
        `svt_xvm_warning("is_supported",$sformatf("This sequence cannot be run based on the current system configuration.\n\
                                                Number of Supporting Master(s) - Minimum Required : 'd%0d Current : 'd%0d \n\
                                                Modify configurations through \n\
                                                svt_axi_system_configuration::num_masters,\n\
                                                svt_axi_port_configuration::is_active,\n\
                                                svt_axi_port_configuration::axi_interface_category,\n\
                                                svt_axi_system_configuration::participating_masters, \n\
                                                Number of Supporting Slave(s)  - Minimum Required : 'd%0d Current : 'd%0d \n\
                                                Modify configurations through \n\
                                                svt_axi_system_configuration::num_slaves,\n\
                                                svt_axi_system_configuration::participating_slaves\
                                                ", required_num_supporting_masters, num_supporting_masters, required_num_supporting_slaves, num_supporting_slaves))
    end      
  endfunction : is_supported

  /** UVM sequence body task. */
  virtual task body();

    /** Local variables. */
    bit status;  
    int mstr;
    bit[`SVT_AXI_MAX_ADDR_WIDTH-1:0] lo_addr;
    bit[`SVT_AXI_MAX_ADDR_WIDTH-1:0] hi_addr;
    int xact_length;
    int data_width_in_bytes;
    int size;
    int size_val;
    int xact_length_width;
    int xact_length_status;
    int xact_length_arr[$];
    int xact_burst_size_arr[$];
    int selected_slv;
    int data_width_vlaue_set; 
    `svt_xvm_debug("body", "Entering...");
`ifdef SVT_UVM_TECHNOLOGY
    status = uvm_config_db#(int unsigned)::get(null, get_full_name(), "sequence_length", sequence_length);
    xact_length_status = uvm_config_db#(int unsigned)::get(null, get_full_name(), "xact_length_width", xact_length_width); 
`elsif SVT_OVM_TECHNOLOGY
    void'(m_sequencer.get_config_int({get_type_name(), "sequence_length"},  sequence_length));
    void'(m_sequencer.get_config_int({get_type_name(), "xact_length_width"},  xact_length_width));
`endif
    `svt_xvm_debug("body", $sformatf("sequence_length is 'd%0d as a result of %0s.", sequence_length,
                                     status ? "config DB" : "randomization"));
    `svt_xvm_debug("body", $sformatf("xact_length_width is 'd%0d as a result of %0s.", xact_length_width,
                                     xact_length_status ? "config DB" : "randomization"));
     
    /** check if current environment is supported or not */ 
    if(!is_supported(sys_cfg, silent))  begin
      `svt_xvm_note("body",$sformatf("This sequence cannot be run based on the current system configuration. Exiting..."))
      return;
    end
  
    /** Setting the response_queue_depth */ 
    set_response_queue_depth(-1);

    /** Fork off a thread to pull the responses out of response queue. */
    sink_responses();

    /**  Execute the sequence for 'sequence_length' number of times. */ 
    for (int i=0; i< sequence_length; i++)begin
           
      /** Randomize the number of transaction for each sequence length  */
      for(int k=0; k < (1<<xact_length_width) ; k++)  begin
        xact_length_arr.push_back(k);
      end
      /** Shuffling all collected Values */
      xact_length_arr.shuffle;
      xact_length = xact_length_arr.pop_front();
      `svt_xvm_debug("body", $sformatf("xact_length is 'd%0d ", xact_length));
 
      /**  Execute the sequence for 'xact_length' number of times. */ 
      for (int j=0; j<xact_length ; j++)begin
       
        /** Randomly select an active participating Master */
        mstr = initiating_master_index;
        `svt_xvm_debug("body", $sformatf("Master to initiate = 'd%0d initiating_master_index = 'd%0d ",mstr,initiating_master_index) );
        `svt_xvm_debug("body ", $sformatf("Master to do j= 'd%0d xact_length = 'd%0d ",j,xact_length) );
    
        /** Randomly select a slave */
        selected_slv = participating_slave_index;
        `svt_xvm_debug("body", $sformatf("Slave to participate = 'd%0d participating_slave_index = 'd%0d ",selected_slv,participating_slave_index) );

        /** Randomly select an Address range for selected slave */
        if (!sys_cfg.get_slave_addr_range(mstr,selected_slv, lo_addr,hi_addr,null))
          `svt_xvm_warning("body", $sformatf("Unable to obtain a memory range for slave index 'd%0d", selected_slv));
         
        /** Calculate the log base of the data width of the bus of selected Master*/

        if (sys_cfg.master_cfg[mstr].data_width == 8)  
          size_val = 0;
        else begin
          data_width_in_bytes =  ((sys_cfg.master_cfg[mstr].data_width)/8);  
          `protected
CG3[]B[Q).<#8^:X7>59a:&_IN<RZN0V=>aLP8796KFQKLHfYW^S.)]_B12,4BD/
,eFZ/+>/SFR)]0LST&PFSJCMA.1@L32K/3.3S901OS]<1?Q:L)@5^-4H:J)\(L:\
ECg-]TFJ;)[A.Q3MeB].]=A?&G7Sg&Je2@eD@Q6RVg,-4NHcZ.)M^H4HL$
`endprotected

          //size_val = $urandom_range(0,size-1);
        end
        for(int n=0; n < size; n++)  begin
          xact_burst_size_arr.push_back(n);
        end
        /** Shuffling all collected Values */
        xact_burst_size_arr.shuffle;
        size_val = xact_burst_size_arr.pop_front();

        `svt_xvm_debug("body", $sformatf("burst_size selected is 'd%0d ", size_val));
        `svt_xvm_debug("body", $sformatf("The data_width_in_bytes='d%0d log_base_2_size='d%0d  AxSize value randomly chosen ='d%0d", data_width_in_bytes,size,size_val ));  
        /** Random Master fires transaction to a randomly selected Slave. */ 
        `svt_xvm_do_on_with(xact,p_sequencer.master_sequencer[mstr],{
          if (sys_cfg.master_cfg[mstr].axi_interface_category == svt_axi_port_configuration::AXI_WRITE_ONLY){
            xact_type  == _write_xact_type[mstr];
          }
          else if (sys_cfg.master_cfg[mstr].axi_interface_category == svt_axi_port_configuration::AXI_READ_ONLY){
            xact_type  == _read_xact_type[mstr];
          }
          else {
            xact_type inside {_read_xact_type[mstr],_write_xact_type[mstr]};
          }  
          atomic_type == svt_axi_transaction::NORMAL;
          (xact_type == svt_axi_transaction::WRITE) ->   (coherent_xact_type == svt_axi_transaction::WRITENOSNOOP);
          (xact_type == svt_axi_transaction::READ) -> (coherent_xact_type == svt_axi_transaction::READNOSNOOP);
          (xact_type == svt_axi_transaction::COHERENT) -> (coherent_xact_type inside {svt_axi_transaction::READNOSNOOP,svt_axi_transaction::WRITENOSNOOP});
          addr        >= lo_addr;
          addr        <= hi_addr-(burst_length*(1<<burst_size));
          (burst_size != 0)  -> addr        !=  (addr & ({`SVT_AXI_MAX_ADDR_WIDTH{1'b1}} <<  burst_size)); 
          burst_size ==  size_val;
        })
        
      end//for xact length 
    end//for sequence length  
    /**
     * To check .
     * Check performed by System Monitor. 
     */
    
    `svt_xvm_debug("body", "Exiting...");
  endtask: body
endclass:svt_axi_burst_unaligned_addr_narrow_transfers_random_ictest_sequence

//======================================================================================
/**
 *    #- Program the Master VIP to drive Exclusive read transaction followed by <br>
 *       Exclusive write transaction with same control fields as previous<br> 
 *       Exclusive read and all other control fields generated randomly.<br>
 *    .
 */

class svt_axi_exclusive_read_write_ictest_sequence extends svt_axi_system_base_sequence;

  /** Sequence length in used to constsrain the sequence length in sub-sequences */
  rand int unsigned sequence_length;

  /** Local variable */
  int supporting_masters[int];
  int supporting_slaves[int];

  /** Constrain the sequence length to a reasonable value */
  constraint reasonable_sequence_length {
    sequence_length <= 50;
  }
  
  /** UVM Object Utility macro */
`ifdef SVT_UVM_TECHNOLOGY
  `uvm_object_utils(svt_axi_exclusive_read_write_ictest_sequence)
`elsif SVT_OVM_TECHNOLOGY
  `ovm_object_utils(svt_axi_exclusive_read_write_ictest_sequence)
`endif

  /** Class Constructor */
  function new (string name = "svt_axi_exclusive_read_write_ictest_sequence");
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
                                                Number of Supporting Master(s) with exclusive_access_enable asserted - Minimum Required : 'd%0d Current : 'd%0d \n\
                                                Modify configurations through \n\
                                                svt_axi_system_configuration::num_masters,\n\
                                                svt_axi_port_configuration::is_active,\n\
                                                svt_axi_port_configuration::axi_interface_category,\n\
                                                svt_axi_port_configuration::exclusive_access_enable,\n\
                                                svt_axi_system_configuration::participating_masters\n\
                                                Number of Supporting Slave(s) with exclusive_access_enable asserted - Minimum Required : 'd%0d Current : 'd%0d \n\
                                                Modify configurations through \n\
                                                svt_axi_port_configuration::exclusive_access_enable,\n\
                                                ", required_num_supporting_masters, num_supporting_masters,required_num_supporting_slaves,num_supporting_slaves))
      else
        `svt_xvm_warning("is_supported",$sformatf("This sequence cannot be run based on the current system configuration.\n\
                                                Number of Supporting Master(s) with exclusive_access_enable asserted - Minimum Required : 'd%0d Current : 'd%0d \n\
                                                Modify configurations through \n\
                                                svt_axi_system_configuration::num_masters,\n\
                                                svt_axi_port_configuration::is_active,\n\
                                                svt_axi_port_configuration::axi_interface_category,\n\
                                                svt_axi_port_configuration::exclusive_access_enable,\n\
                                                svt_axi_system_configuration::participating_masters\n\
                                                Number of Supporting Slave(s) with exclusive_access_enable asserted - Minimum Required : 'd%0d Current : 'd%0d \n\
                                                Modify configurations through \n\
                                                svt_axi_port_configuration::exclusive_access_enable,\n\
                                                ", required_num_supporting_masters, num_supporting_masters,required_num_supporting_slaves,num_supporting_slaves))
    end      
  endfunction : is_supported

  /** Pre-Randomizing the participating masters and slaves */  
  function void pre_randomize();
    int support_mstr_index=0; 
    int support_slv_index=0; 
    super.pre_randomize();
    foreach(active_participating_masters[mstr])  begin
      if((sys_cfg.master_cfg[active_participating_masters[mstr]].exclusive_access_enable == 1) && (sys_cfg.master_cfg[active_participating_masters[mstr]].axi_interface_category == svt_axi_port_configuration::AXI_READ_WRITE)) begin
        supporting_masters[support_mstr_index++] = active_participating_masters[mstr];  
        `svt_xvm_debug("svt_axi_exclusive_read_write_ictest_sequence",$sformatf(" master id that is participating is ='d%0d ",active_participating_masters[mstr]));
        `svt_xvm_debug("svt_axi_exclusive_read_write_ictest_sequence",$sformatf(" master exclusive_access_enable that is participating is ='d%0d ",sys_cfg.master_cfg[active_participating_masters[mstr]].exclusive_access_enable ));
      end
      else   begin 
        `svt_xvm_debug("svt_axi_exclusive_read_write_ictest_sequence",$sformatf(" master with id='d%0d does not meet requirements ",active_participating_masters[mstr]));
      end
    end
    foreach(participating_slaves_arr[slv])  begin
      if((sys_cfg.slave_cfg[participating_slaves_arr[slv]].exclusive_access_enable == 1) && (sys_cfg.slave_cfg[participating_slaves_arr[slv]].axi_interface_category == svt_axi_port_configuration::AXI_READ_WRITE)) begin
         supporting_slaves[support_slv_index++] = participating_slaves_arr[slv];  
         `svt_xvm_debug("svt_axi_exclusive_read_write_ictest_sequence",$sformatf(" slave id that is participating is ='d%0d ",participating_slaves_arr[slv]));
         `svt_xvm_debug("svt_axi_exclusive_read_write_ictest_sequence",$sformatf(" slave exclusive_access_enable that is participating is ='d%0d ",sys_cfg.slave_cfg[participating_slaves_arr[slv]].exclusive_access_enable ));
      end
      else   begin 
        `svt_xvm_debug("svt_axi_exclusive_read_write_ictest_sequence",$sformatf(" slave with id='d%0d does not meet requirements ",participating_slaves_arr[slv]));
      end
    end
  endfunction: pre_randomize

  /** UVM sequence body task */ 
  virtual task body();

    /** local variables */
    bit status;
    
    /** Master sequence handles */
    svt_axi_master_exclusive_test_sequence exclusive_seq;

    `svt_xvm_debug("body", "Entering...");
`ifdef SVT_UVM_TECHNOLOGY
    uvm_config_db#(bit)::set(null,  {get_full_name(), ".", "exclusive_seq"}, "use_slv_num", 1'b1);
`elsif SVT_OVM_TECHNOLOGY
    set_config_int({get_full_name(), ".", "exclusive_seq"}, ".use_slv_num", 1'b1);
`endif
 
    /** check if current environment is supported or not */ 
    if(!is_supported(sys_cfg, silent))  begin
      `svt_xvm_note("body",$sformatf("This sequence cannot be run based on the current system configuration. Exiting..."))
      return;
    end
 
    /** fork off a thread to pull the responses out of response queue */
    sink_responses(); 
    foreach(supporting_masters[index]) begin
      int mstr = supporting_masters[index];
      `svt_xvm_debug("body", $sformatf("Master to initiate is  'd%0d index='d%0d ",mstr,index) );
      foreach(supporting_slaves[slv]) begin
        `svt_xvm_do_on_with(exclusive_seq, p_sequencer.master_sequencer[mstr],{
          slv_num == supporting_slaves[slv];
        })
      end //foreach of supporting slaves
    end //foreach of Master
        
    `svt_xvm_debug("body", "Exiting...");
  endtask: body
endclass: svt_axi_exclusive_read_write_ictest_sequence


//======================================================================================
/**
 *    #- Program the Master VIP to drive Locked read transaction followed by <br>
 *       Exclusive read transaction with same control fields as previous<br> 
 *       lock read and all other control fields generated randomly.<br>
 *    .
 */

class svt_axi_locked_read_followed_by_excl_sequence extends svt_axi_system_base_sequence;

  /** Sequence length in used to constsrain the sequence length in sub-sequences */
  rand int unsigned sequence_length;

  /** Local variable */
  int supporting_masters[$];
  int supporting_slaves[$];

  /** Constrain the sequence length to a reasonable value */
  constraint reasonable_sequence_length {
    sequence_length <= 50;
  }
  
  /** UVM Object Utility macro */
`ifdef SVT_UVM_TECHNOLOGY
  `uvm_object_utils(svt_axi_locked_read_followed_by_excl_sequence)
`elsif SVT_OVM_TECHNOLOGY
  `ovm_object_utils(svt_axi_locked_read_followed_by_excl_sequence)
`endif

  /** Class Constructor */
  function new (string name = "svt_axi_locked_read_followed_by_excl_sequence");
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
                                                Number of Supporting Master(s) with exclusive_access_enable asserted - Minimum Required : 'd%0d Current : 'd%0d \n\
                                                Modify configurations through \n\
                                                svt_axi_system_configuration::num_masters,\n\
                                                svt_axi_port_configuration::is_active,\n\
                                                svt_axi_port_configuration::axi_interface_category,\n\
                                                svt_axi_port_configuration::exclusive_access_enable,\n\
                                                svt_axi_system_configuration::participating_masters\n\
                                                Number of Supporting Slave(s) with exclusive_access_enable asserted - Minimum Required : 'd%0d Current : 'd%0d \n\
                                                Modify configurations through \n\
                                                svt_axi_port_configuration::exclusive_access_enable,\n\
                                                ", required_num_supporting_masters, num_supporting_masters,required_num_supporting_slaves,num_supporting_slaves))
      else
        `svt_xvm_warning("is_supported",$sformatf("This sequence cannot be run based on the current system configuration.\n\
                                                Number of Supporting Master(s) with exclusive_access_enable asserted - Minimum Required : 'd%0d Current : 'd%0d \n\
                                                Modify configurations through \n\
                                                svt_axi_system_configuration::num_masters,\n\
                                                svt_axi_port_configuration::is_active,\n\
                                                svt_axi_port_configuration::axi_interface_category,\n\
                                                svt_axi_port_configuration::exclusive_access_enable,\n\
                                                svt_axi_system_configuration::participating_masters\n\
                                                Number of Supporting Slave(s) with exclusive_access_enable asserted - Minimum Required : 'd%0d Current : 'd%0d \n\
                                                Modify configurations through \n\
                                                svt_axi_port_configuration::exclusive_access_enable,\n\
                                                ", required_num_supporting_masters, num_supporting_masters,required_num_supporting_slaves,num_supporting_slaves))
    end      
  endfunction : is_supported

  /** Pre-Randomizing the participating masters and slaves */  
  function void pre_randomize();
    int support_mstr_index=0; 
    int support_slv_index=0; 
    super.pre_randomize();
    foreach(active_participating_masters[mstr])  begin
      if((sys_cfg.master_cfg[active_participating_masters[mstr]].exclusive_access_enable == 1) && (sys_cfg.master_cfg[active_participating_masters[mstr]].axi_interface_type == svt_axi_port_configuration::AXI3) && (sys_cfg.master_cfg[active_participating_masters[mstr]].axi_interface_category == svt_axi_port_configuration::AXI_READ_WRITE)) begin
        supporting_masters.push_back(active_participating_masters[mstr]);
        `svt_xvm_debug("svt_axi_locked_read_followed_by_excl_sequence",$sformatf(" master id that is participating is ='d%0d ",active_participating_masters[mstr]));
        `svt_xvm_debug("svt_axi_locked_read_followed_by_excl_sequence",$sformatf(" master exclusive_access_enable that is participating is ='d%0d ",sys_cfg.master_cfg[active_participating_masters[mstr]].exclusive_access_enable ));
      end
      else begin
        `svt_xvm_debug("svt_axi_locked_read_followed_by_excl_sequence",$sformatf(" master with id ='d%0d does not meet requirements",active_participating_masters[mstr]));
      end 
    end
    foreach(participating_slaves_arr[slv])  begin
      if((sys_cfg.slave_cfg[participating_slaves_arr[slv]].exclusive_access_enable == 1) && (sys_cfg.slave_cfg[participating_slaves_arr[slv]].axi_interface_category == svt_axi_port_configuration::AXI_READ_WRITE)) begin 
        supporting_slaves.push_back(participating_slaves_arr[slv]);  
        `svt_xvm_debug("svt_axi_locked_read_followed_by_excl_sequence",$sformatf(" slave id that is participating is ='d%0d ",participating_slaves_arr[slv]));
        `svt_xvm_debug("svt_axi_locked_read_followed_by_excl_sequence",$sformatf(" slave exclusive_access_enable that is participating is ='d%0d ",sys_cfg.slave_cfg[participating_slaves_arr[slv]].exclusive_access_enable ));
      end
      else begin
        `svt_xvm_debug("svt_axi_locked_read_followed_by_excl_sequence",$sformatf(" slave with id ='d%0d does not meet requirements",participating_slaves_arr[slv]));
      end
    end
  endfunction: pre_randomize

  /** UVM sequence body task */ 
  virtual task body();

    /** local variables */
    bit status;
    
    /** Master sequence handles */
    svt_axi_master_locked_read_followed_by_excl_sequence locked_excl_seq;
    `svt_xvm_debug("body", "Entering...");
`ifdef SVT_UVM_TECHNOLOGY
    status = uvm_config_db#(int unsigned)::get(null, get_full_name(), "sequence_length", sequence_length);
`elsif SVT_OVM_TECHNOLOGY
    void'(m_sequencer.get_config_int({get_type_name(), "sequence_length"},  sequence_length));
`endif
    `svt_xvm_debug("body", $sformatf("sequence_length is 'd%0d as a result of %0s.", sequence_length, status ? "config DB" : "randomization"));
 
    /** check if current environment is supported or not */ 
    if(!is_supported(sys_cfg, silent))  begin
      `svt_xvm_note("body",$sformatf("This sequence cannot be run based on the current system configuration. Exiting..."))
      return;
    end
 
    /** fork off a thread to pull the responses out of response queue */
    sink_responses(); 
    /** Execute the sequence for 'sequence_length' number of times */
    for (int i=0; i < sequence_length; i++) begin
      for(int i=0; i < supporting_masters.size(); i++) begin
        int mstr = supporting_masters.pop_front();
        int slv = supporting_slaves.pop_front();
        `svt_xvm_debug("body", $sformatf("Master to initiate locked_seq is  'd%0d index='d%0d ",mstr,i) );
        `svt_xvm_do_on_with(locked_excl_seq, p_sequencer.master_sequencer[mstr],{
          slv_num == slv;
          })
      end //foreach of Master
    end//sequence_length
        
    `svt_xvm_debug("body", "Exiting...");
  endtask: body
endclass: svt_axi_locked_read_followed_by_excl_sequence


// =============================================================================
/**
 * This sequence gets the slave response sequence item from slave sequencer.
 * User can modify these responses.  The sequence uses the built-in slave memory. 
 * For write transactions, it writes the data into slave memory. The randomized response
 * is then provided to the slave driver.
 * 
 * This sequence runs forever, and so is not registered with the slave sequence
 * library.
 */
class svt_axi_slave_ordering_programmed_response_sequence extends svt_axi_slave_memory_sequence;

  /** event to communicate with virtual sequence */
  event resume_write_resp;

  /** Handle to hold suspended req*/
  `SVT_AXI_SLAVE_TRANSACTION_TYPE suspended_req;
  
  /** Class Constructor */
  function new(string name="svt_axi_slave_ordering_programmed_response_sequence");
    super.new(name);
  endfunction

  `svt_xvm_object_utils(svt_axi_slave_ordering_programmed_response_sequence)
  `svt_xvm_declare_p_sequencer(svt_axi_slave_sequencer)

  virtual task process_post_response_request_xact_randomize(`SVT_AXI_SLAVE_TRANSACTION_TYPE xact_req);
    if(bvalid_delay != -1) begin
      if(bvalid_delay>0)begin
        xact_req.suspend_response = 1;
        `svt_xvm_debug("process_post_response_request_xact_randomize_method",$sformatf("Suspending the response"));  
        suspended_req = xact_req;
        fork
          begin
            /** To resume the suspended response of Write transaction */
            @(resume_write_resp);begin
               suspended_req.suspend_response = 0;    
               `svt_xvm_debug("body",$sformatf("EVENT resume_write_resp is triggered,Resuming suspended response of transaction with addr='h%h",suspended_req.addr));
            end
          end
        join_none
      end
      `svt_xvm_debug("process_post_response_request_xact_randomize_method",$sformatf("Slave_bresp ='d%0d", xact_req.bresp));  
    end
  endtask: process_post_response_request_xact_randomize
endclass: svt_axi_slave_ordering_programmed_response_sequence

// =============================================================================
/**
 * This sequence suspends the response of write transaction ,resumes it after  
 * after read transactions reaches the slave. 
 * This sequence gets the slave response sequence item from slave sequencer.
 * The slave response is then randomized based on certain weights. User can
 * modify these weights.  The sequence uses the built-in slave memory. For read
 * transactions, it reads the data from the slave memory. For write
 * transactions, it writes the data into slave memory. The randomized response
 * is then provided to the slave driver.
 * 
 * This sequence runs forever, and so is not registered with the slave sequence
 * library.
 */
class svt_axi_slave_ordering_memory_suspend_response_sequence extends svt_axi_slave_memory_sequence;
  
  /** Event triggered when actual Write Address transaction initiated.
   *  i.e it will only be triggered when Address status is ACTIVE or ACCEPT. Will
   *  not trigger early for data channel initiated transaction (when data 
   *  reaches slave before address)
   */
  event wr_addr_reached;   
  event rd_addr_reached;   

  /** Handle to hold suspended req*/
  `SVT_AXI_SLAVE_TRANSACTION_TYPE suspended_req;

  /** Class Constructor */
  function new(string name="svt_axi_slave_ordering_memory_suspend_response_sequence");
    super.new(name);
  endfunction
 
  `svt_xvm_object_utils(svt_axi_slave_ordering_memory_suspend_response_sequence)
  `svt_xvm_declare_p_sequencer(svt_axi_slave_sequencer)

  virtual task process_post_response_request_xact_randomize(`SVT_AXI_SLAVE_TRANSACTION_TYPE xact_req);
    /** Check the received transactions and suspends the response of Write transaction */
    if((xact_req.transmitted_channel == svt_axi_transaction::WRITE) && 
      (xact_req.addr_status == svt_axi_transaction::ACTIVE || xact_req.addr_status == svt_axi_transaction::ACCEPT))begin 
      `svt_xvm_debug("body",$sformatf("Suspending the response of transaction with address = 'h%h,",xact_req.addr));
      /** Trigger an event to communicate with virtual sequence */
      -> wr_addr_reached; 
      xact_req.suspend_response = 1;
      suspended_req = xact_req;
    end
    /** Check the received transactions and not suspends the response of Read transaction */  
    if(xact_req.transmitted_channel == svt_axi_transaction::READ) begin       
      `svt_xvm_debug("body",$sformatf("addr_status = %0s of transaction with addr='h%h",xact_req.addr_status,suspended_req.addr));
      fork
        begin 
          /** Event is triggered from virtual sequence, once read transaction reaches the slave */
          @(rd_addr_reached);begin
            suspended_req.suspend_response = 0;
            `svt_xvm_debug("body",$sformatf("addr_status = %0s of transaction with addr='h%h, while resuming the response of Previous Write transaction",xact_req.addr_status,suspended_req.addr));
            `svt_xvm_debug("body",$sformatf("Resuming suspended response of transaction with addr='h%h",suspended_req.addr));
          end
        end
      join_none
    end

  endtask: process_post_response_request_xact_randomize
endclass: svt_axi_slave_ordering_memory_suspend_response_sequence

//======================================================================================
/**
 *    #- Program the Master VIP to drive multiple transaction with randomly
 *       selected atomic type of Exclusive or Normal read transaction
 *       Program the Master VIP to wait for previous Exclusive or Normal
 *       transaction to end
 *       All other control fields are generated randomly.
 */

class svt_axi_exclusive_normal_random_virtual_sequence extends svt_axi_system_base_sequence;

  /** Sequence length in used to constsrain the sequence length in sub-sequences */
  rand int unsigned sequence_length;

  /** Local variable */
  int supporting_masters[int];
  int supporting_slaves[int];

  /** Constrain the sequence length to a reasonable value */
  constraint reasonable_sequence_length {
    sequence_length <= 50;
  }
  
  /** UVM Object Utility macro */
`ifdef SVT_UVM_TECHNOLOGY
  `uvm_object_utils(svt_axi_exclusive_normal_random_virtual_sequence)
`elsif SVT_OVM_TECHNOLOGY
  `ovm_object_utils(svt_axi_exclusive_normal_random_virtual_sequence)
`endif

  /** Class Constructor */
  function new (string name = "svt_axi_exclusive_normal_random_virtual_sequence");
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
                                                Number of Supporting Master(s) with exclusive_access_enable asserted - Minimum Required : 'd%0d Current : 'd%0d \n\
                                                Modify configurations through \n\
                                                svt_axi_system_configuration::num_masters,\n\
                                                svt_axi_port_configuration::is_active,\n\
                                                svt_axi_port_configuration::axi_interface_category,\n\
                                                svt_axi_port_configuration::exclusive_access_enable,\n\
                                                svt_axi_system_configuration::participating_masters\n\
                                                Number of Supporting Slave(s) with exclusive_access_enable asserted - Minimum Required : 'd%0d Current : 'd%0d \n\
                                                Modify configurations through \n\
                                                svt_axi_port_configuration::exclusive_access_enable,\n\
                                                ", required_num_supporting_masters, num_supporting_masters,required_num_supporting_slaves,num_supporting_slaves))
      else
        `svt_xvm_warning("is_supported",$sformatf("This sequence cannot be run based on the current system configuration.\n\
                                                Number of Supporting Master(s) with exclusive_access_enable asserted - Minimum Required : 'd%0d Current : 'd%0d \n\
                                                Modify configurations through \n\
                                                svt_axi_system_configuration::num_masters,\n\
                                                svt_axi_port_configuration::is_active,\n\
                                                svt_axi_port_configuration::axi_interface_category,\n\
                                                svt_axi_port_configuration::exclusive_access_enable,\n\
                                                svt_axi_system_configuration::participating_masters\n\
                                                Number of Supporting Slave(s) with exclusive_access_enable asserted - Minimum Required : 'd%0d Current : 'd%0d \n\
                                                Modify configurations through \n\
                                                svt_axi_port_configuration::exclusive_access_enable,\n\
                                                ", required_num_supporting_masters, num_supporting_masters,required_num_supporting_slaves,num_supporting_slaves))
    end      
  endfunction : is_supported

  /** Pre-Randomizing the participating masters and slaves */  
  function void pre_randomize();
    int support_mstr_index=0; 
    int support_slv_index=0; 
    super.pre_randomize();
    foreach(active_participating_masters[mstr])  begin
      if((sys_cfg.master_cfg[active_participating_masters[mstr]].exclusive_access_enable == 1) && (sys_cfg.master_cfg[active_participating_masters[mstr]].axi_interface_category == svt_axi_port_configuration::AXI_READ_WRITE)) begin
        supporting_masters[support_mstr_index++] = active_participating_masters[mstr];  
        `svt_xvm_debug("svt_axi_exclusive_normal_random_virtual_sequence",$sformatf(" master id that is participating is ='d%0d ",active_participating_masters[mstr]));
        `svt_xvm_debug("svt_axi_exclusive_normal_random_virtual_sequence",$sformatf(" master exclusive_access_enable that is participating is ='d%0d ",sys_cfg.master_cfg[active_participating_masters[mstr]].exclusive_access_enable ));
      end
      else begin
        `svt_xvm_debug("svt_axi_exclusive_normal_random_virtual_sequence",$sformatf(" master with id ='d%0d does not meet requirements",active_participating_masters[mstr]));
      end
    end
    foreach(participating_slaves_arr[slv])  begin
      if((sys_cfg.slave_cfg[participating_slaves_arr[slv]].exclusive_access_enable == 1) && (sys_cfg.slave_cfg[participating_slaves_arr[slv]].axi_interface_category == svt_axi_port_configuration::AXI_READ_WRITE)) begin
         supporting_slaves[support_slv_index++] = participating_slaves_arr[slv];  
         `svt_xvm_debug("svt_axi_exclusive_normal_random_virtual_sequence",$sformatf(" slave id that is participating is ='d%0d ",participating_slaves_arr[slv]));
         `svt_xvm_debug("svt_axi_exclusive_normal_random_virtual_sequence",$sformatf(" slave exclusive_access_enable that is participating is ='d%0d ",sys_cfg.slave_cfg[participating_slaves_arr[slv]].exclusive_access_enable ));
      end
      else begin
        `svt_xvm_debug("svt_axi_exclusive_normal_random_virtual_sequence",$sformatf(" slave with id ='d%0d does not meet requirements",participating_slaves_arr[slv]));
      end
    end
  endfunction: pre_randomize

  /** UVM sequence body task */ 
  virtual task body();

    /** local variables */
    bit status;
    
    /** Master sequence handles */
    svt_axi_master_normal_exclusive_random_sequence exclusive_normal_seq;

    `svt_xvm_debug("body", "Entering...");
`ifdef SVT_UVM_TECHNOLOGY
    uvm_config_db#(bit)::set(null,  {get_full_name(), ".", "exclusive_normal_seq"}, "use_slv_num", 1'b1);
`elsif SVT_OVM_TECHNOLOGY
    set_config_int({get_full_name(), ".", "exclusive_normal_seq"}, ".use_slv_num", 1'b1);
`endif
 
    /** check if current environment is supported or not */ 
    if(!is_supported(sys_cfg, silent))  begin
      `svt_xvm_note("body",$sformatf("This sequence cannot be run based on the current system configuration. Exiting..."))
      return;
    end
 
    /** fork off a thread to pull the responses out of response queue */
    sink_responses(); 
    foreach(supporting_masters[index]) begin
      int mstr = supporting_masters[index];
      `svt_xvm_debug("body", $sformatf("Master to initiate is  'd%0d index='d%0d ",mstr,index) );
      foreach(supporting_slaves[slv]) begin
        `svt_xvm_do_on_with(exclusive_normal_seq, p_sequencer.master_sequencer[mstr],{
          slv_num == supporting_slaves[slv];
        })
      end //foreach of supporting slaves
    end //foreach of Master
        
    `svt_xvm_debug("body", "Exiting...");
  endtask: body
endclass: svt_axi_exclusive_normal_random_virtual_sequence

//======================================================================================
/**
 *    #- Program the Master VIP to drive random locked transaction  <br>
 *       Send Exclusive transaction with same xact_type and addr as of locked transaction<br> 
 *       to unlock the locked sequence and all other control fields generated randomly.<br>
 *    .
 */

class svt_axi3_random_read_write_locked_sequence extends svt_axi_system_base_sequence;

  /** Sequence length in used to constsrain the sequence length in sub-sequences */
  rand int unsigned sequence_length;

  /** Local variable */
  int supporting_masters[$];
  int supporting_slaves[$];

  /** Constrain the sequence length to a reasonable value */
  constraint reasonable_sequence_length {
    sequence_length <= 50;
  }
  
  /** UVM Object Utility macro */
`ifdef SVT_UVM_TECHNOLOGY
  `uvm_object_utils(svt_axi3_random_read_write_locked_sequence)
`elsif SVT_OVM_TECHNOLOGY
  `ovm_object_utils(svt_axi3_random_read_write_locked_sequence)
`endif

  /** Class Constructor */
  function new (string name = "svt_axi3_random_read_write_locked_sequence");
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
                                                Number of Supporting Master(s) with exclusive_access_enable asserted - Minimum Required : 'd%0d Current : 'd%0d \n\
                                                Modify configurations through \n\
                                                svt_axi_system_configuration::num_masters,\n\
                                                svt_axi_port_configuration::is_active,\n\
                                                svt_axi_port_configuration::axi_interface_category,\n\
                                                svt_axi_port_configuration::exclusive_access_enable,\n\
                                                svt_axi_system_configuration::participating_masters\n\
                                                Number of Supporting Slave(s) with exclusive_access_enable asserted - Minimum Required : 'd%0d Current : 'd%0d \n\
                                                Modify configurations through \n\
                                                svt_axi_port_configuration::exclusive_access_enable,\n\
                                                ", required_num_supporting_masters, num_supporting_masters,required_num_supporting_slaves,num_supporting_slaves))
      else
        `svt_xvm_warning("is_supported",$sformatf("This sequence cannot be run based on the current system configuration.\n\
                                                Number of Supporting Master(s) with exclusive_access_enable asserted - Minimum Required : 'd%0d Current : 'd%0d \n\
                                                Modify configurations through \n\
                                                svt_axi_system_configuration::num_masters,\n\
                                                svt_axi_port_configuration::is_active,\n\
                                                svt_axi_port_configuration::axi_interface_category,\n\
                                                svt_axi_port_configuration::exclusive_access_enable,\n\
                                                svt_axi_system_configuration::participating_masters\n\
                                                Number of Supporting Slave(s) with exclusive_access_enable asserted - Minimum Required : 'd%0d Current : 'd%0d \n\
                                                Modify configurations through \n\
                                                svt_axi_port_configuration::exclusive_access_enable,\n\
                                                ", required_num_supporting_masters, num_supporting_masters,required_num_supporting_slaves,num_supporting_slaves))
    end      
  endfunction : is_supported

  /** Pre-Randomizing the participating masters and slaves */  
  function void pre_randomize();
    int support_mstr_index=0; 
    int support_slv_index=0; 
    super.pre_randomize();
    foreach(active_participating_masters[mstr])  begin
      if((sys_cfg.master_cfg[active_participating_masters[mstr]].locked_access_enable == 1) && (sys_cfg.master_cfg[active_participating_masters[mstr]].axi_interface_type == svt_axi_port_configuration::AXI3) && (sys_cfg.master_cfg[active_participating_masters[mstr]].axi_interface_category == svt_axi_port_configuration::AXI_READ_WRITE)) begin
        supporting_masters.push_back(active_participating_masters[mstr]);
        `svt_xvm_debug("svt_axi3_random_read_write_locked_sequence",$sformatf(" master id that is participating is ='d%0d ",active_participating_masters[mstr]));
        `svt_xvm_debug("svt_axi3_random_read_write_locked_sequence",$sformatf(" master locked_access_enable that is participating is ='d%0d ",sys_cfg.master_cfg[active_participating_masters[mstr]].locked_access_enable ));
      end
      else begin
        `svt_xvm_debug("svt_axi3_random_read_write_locked_sequence",$sformatf(" master with id ='d%0d does not meet requirements",active_participating_masters[mstr]));
      end 
    end
    foreach(participating_slaves_arr[slv])  begin
      if((sys_cfg.slave_cfg[participating_slaves_arr[slv]].locked_access_enable == 1) && (sys_cfg.slave_cfg[participating_slaves_arr[slv]].axi_interface_category == svt_axi_port_configuration::AXI_READ_WRITE)) begin 
        supporting_slaves.push_back(participating_slaves_arr[slv]);  
        `svt_xvm_debug("svt_axi3_random_read_write_locked_sequence",$sformatf(" slave id that is participating is ='d%0d ",participating_slaves_arr[slv]));
        `svt_xvm_debug("svt_axi3_random_read_write_locked_sequence",$sformatf(" slave locked_access_enable that is participating is ='d%0d ",sys_cfg.slave_cfg[participating_slaves_arr[slv]].locked_access_enable ));
      end
      else begin
        `svt_xvm_debug("svt_axi3_random_read_write_locked_sequence",$sformatf(" slave with id ='d%0d does not meet requirements",participating_slaves_arr[slv]));
      end
    end
  endfunction: pre_randomize

  /** UVM sequence body task */ 
  virtual task body();

    /** local variables */
    bit status;
    
    /** Master sequence handles */
    svt_axi3_master_random_read_write_locked_sequence locked_seq;
    `svt_xvm_debug("body", "Entering...");
`ifdef SVT_UVM_TECHNOLOGY
    status = uvm_config_db#(int unsigned)::get(null, get_full_name(), "sequence_length", sequence_length);
`elsif SVT_OVM_TECHNOLOGY
    void'(m_sequencer.get_config_int({get_type_name(), "sequence_length"},  sequence_length));
`endif
    `svt_xvm_debug("body", $sformatf("sequence_length is 'd%0d as a result of %0s.", sequence_length, status ? "config DB" : "randomization"));
 
    /** check if current environment is supported or not */ 
    if(!is_supported(sys_cfg, silent))  begin
      `svt_xvm_note("body",$sformatf("This sequence cannot be run based on the current system configuration. Exiting..."))
      return;
    end
 
    /** fork off a thread to pull the responses out of response queue */
    sink_responses(); 
    /** Execute the sequence for 'sequence_length' number of times */
    for (int i=0; i < sequence_length; i++) begin
      for(int i=0; i < supporting_masters.size(); i++) begin
        int mstr = supporting_masters.pop_front();
        int slv = supporting_slaves.pop_front();
        `svt_xvm_debug("body", $sformatf("Master to initiate locked_seq is  'd%0d index='d%0d ",mstr,i) );
        `svt_xvm_do_on_with(locked_seq, p_sequencer.master_sequencer[mstr],{
          slv_num == slv;
          })
      end //foreach of Master
    end//sequence_length
        
    `svt_xvm_debug("body", "Exiting...");
  endtask: body
endclass: svt_axi3_random_read_write_locked_sequence
//======================================================================================
/**
 *    #- Program the Master VIP to drive multiple transaction with more probability <br>
 *       for wstrb corner scenarios. <br>
 */
class svt_axi_cov_corner_cases_wstrb_sequence extends svt_axi_system_base_sequence;

  /** Sequence length in used to constsrain the sequence length in sub-sequences */
  rand int unsigned sequence_length;
  /** Local variable */
  int supporting_masters[int];

  /** Constrain the sequence length to a reasonable value */
  constraint reasonable_sequence_length {
    sequence_length <= 50;   
  } 

  /** UVM Object Utility macro */
`ifdef SVT_UVM_TECHNOLOGY    
  `uvm_object_utils(svt_axi_cov_corner_cases_wstrb_sequence)
`elsif SVT_OVM_TECHNOLOGY
  `ovm_object_utils(svt_axi_cov_corner_cases_wstrb_sequence)
`endif

  /** Class Constructor */
  function new (string name = "svt_axi_cov_corner_cases_wstrb_sequence");
    super.new(name);
  endfunction : new
  /** 
   * Function to check if current system configuration meets requirements of this sequence.
   * This sequence requires following configurations
   *  #- minimum supporting Masters = 1
   */
  virtual function bit is_supported(svt_configuration cfg, bit silent = 0);
    
    /** local variables */
    int num_supporting_masters;
    /** Supporting masters required */
    int required_num_supporting_masters = 1;

    `svt_xvm_debug("is_supported",$sformatf("calling is_supported"));

    /** By default is_supported is 0 */
    is_supported = 0;
    num_supporting_masters = supporting_masters.size();
    
    /** check the required supporting Masters */
    if(num_supporting_masters >= required_num_supporting_masters)  begin
      is_supported = 1;
    end
    else begin
      if (silent)
        `svt_xvm_debug("is_supported",$sformatf("This sequence cannot be run based on the current system configuration.\n\
                                                Number of Supporting Master(s) - Minimum Required : 'd%0d Current : 'd%0d \n\
                                                Modify configurations through \n\
                                                svt_axi_system_configuration::num_masters,\n\
                                                svt_axi_port_configuration::is_active,\n\
                                                svt_axi_port_configuration::axi_interface_category,\n\
                                                svt_axi_system_configuration::participating_masters\n\
                                                ", required_num_supporting_masters, num_supporting_masters))
      else
        `svt_xvm_warning("is_supported",$sformatf("This sequence cannot be run based on the current system configuration.\n\
                                                Number of Supporting Master(s) - Minimum Required : 'd%0d Current : 'd%0d \n\
                                                Modify configurations through \n\
                                                svt_axi_system_configuration::num_masters,\n\
                                                svt_axi_port_configuration::is_active,\n\
                                                svt_axi_port_configuration::axi_interface_category,\n\
                                                svt_axi_system_configuration::participating_masters\n\
                                                ", required_num_supporting_masters, num_supporting_masters))
    end      
  endfunction : is_supported

  /** Pre-Randomizing the participating masters */  
  function void pre_randomize();
    int support_mstr_index=0; 
    super.pre_randomize();
    foreach(active_participating_masters[mstr])  begin
      if(sys_cfg.master_cfg[active_participating_masters[mstr]].axi_interface_category == svt_axi_port_configuration::AXI_READ_WRITE) begin
        supporting_masters[support_mstr_index++] = active_participating_masters[mstr];  
        `svt_xvm_debug("svt_axi_cov_corner_cases_wstrb_sequence",$sformatf(" master id that is participating is ='d%0d ",active_participating_masters[mstr]));
      end
      else begin
        `svt_xvm_debug("svt_axi_cov_corner_cases_wstrb_sequence",$sformatf("master with id='d%0d does not have an AXI_READ_WRITE port",active_participating_masters[mstr]));
      end
    end
  endfunction: pre_randomize 

  /** UVM sequence body task */ 
  virtual task body();
    /** Local variables */
    bit status;
    /** Write and Read transaction request handles */
    svt_axi_master_transaction wr_xact_req[$];
    
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
      `svt_xvm_note("body",$sformatf("This sequence cannot be run based on the current system configuration. Exiting..."));
      return;
    end
  
    /** Setting the response_queue_depth */ 
    set_response_queue_depth(-1);
    //fork off a thread to pull the responses out of response queue
    sink_responses(); 

    /** Execute the sequence for 'sequence_length' number of times */
    for (int i=0; i < sequence_length; i++) begin
      /** Execute the transactions from each selected active participating master */
      foreach(supporting_masters[initiating_master_index])  begin
        int mstr = supporting_masters[initiating_master_index];
        `svt_xvm_debug("body", $sformatf("Initiating_master_port_id is 'd%0d and a master to initiate is  'd%0d ",initiating_master_port_id,mstr) );
        `svt_xvm_debug("body", $sformatf("supporting_masters.size is 'd%0d", supporting_masters.size()) );

        /** Execute the transactions in each Slave from selected active participating master */
          /** Drive first Write transaction with high probability for wstrb corner scenarios */
          `svt_xvm_do_on_with(wr_xact_req[0], p_sequencer.master_sequencer[mstr], {
            addr == 0;
            burst_size              dist {4:/5 , [0:4]:/1};
            xact_type               == _write_xact_type[mstr];
            coherent_xact_type      == svt_axi_transaction::WRITENOSNOOP;
            atomic_type             == svt_axi_transaction::NORMAL;
            burst_type              dist {svt_axi_transaction::INCR:/10 , svt_axi_transaction::WRAP:/1, svt_axi_transaction::FIXED:/50 };
            foreach(wr_xact_req[0].wstrb[index])
              wstrb[index] dist {'haaaa:/20,'h5555:/20,'1:/10, [1: (((1<<(1<<(burst_size))))-1)]:/1};
          })
          
          `svt_xvm_debug("body", {`SVT_AXI_PRINT_PREFIX1(wr_xact_req[0]), "Waiting for transaction to end"});
          /** Waiting for above Write transaction to complete */
          wait (`SVT_AXI_XACT_STATUS_ENDED(wr_xact_req[0]));
          `svt_xvm_debug("body", {`SVT_AXI_PRINT_PREFIX1(wr_xact_req[0]), "Transaction is now ended"});
          /** 
           * Drive  transaction with more probability of INCR,
           */
          `svt_xvm_do_on_with(wr_xact_req[1], p_sequencer.master_sequencer[mstr], {
            addr                    == 0;
            xact_type               == _write_xact_type[mstr];
            coherent_xact_type      == svt_axi_transaction::WRITENOSNOOP;
            atomic_type             == svt_axi_transaction::NORMAL;
            burst_type              dist {svt_axi_transaction::INCR:/5 , svt_axi_transaction::WRAP:/1, svt_axi_transaction::FIXED:/2 };
          })
          `svt_xvm_debug("body", {`SVT_AXI_PRINT_PREFIX1(wr_xact_req[1]), "Waiting for transaction to end"});
          /** Waiting for above Write transaction to complete */
          wait (`SVT_AXI_XACT_STATUS_ENDED(wr_xact_req[1]));
          `svt_xvm_debug("body", {`SVT_AXI_PRINT_PREFIX1(wr_xact_req[1]), "Transaction is now ended"});
      end //foreach of supporting_masters
    end //forloop of sequence_length 
    /** 
     * To check the Read data and comapre it with Write data.
     * Check done by Test.
     */
    `svt_xvm_debug("body", "Exiting...");
  endtask: body
endclass: svt_axi_cov_corner_cases_wstrb_sequence
//======================================================================================
/**
 *    #- Program the Master VIP to drive multiple transaction with min address range <br>
 *       selected atomic type of Normal read or write transaction <br>
 *       All other control fields are generated randomly. <br>
 */
class svt_axi_cov_corner_cases_addr_min_sequence extends svt_axi_system_base_sequence;

  /** Sequence length in used to constsrain the sequence length in sub-sequences */
  rand int unsigned sequence_length;
  /** Local variable */
  int supporting_masters[int];
  /** Constrain the sequence length to a reasonable value */
  constraint reasonable_sequence_length {
    sequence_length <= 500;   
  } 
  /** UVM Object Utility macro */
`ifdef SVT_UVM_TECHNOLOGY    
  `uvm_object_utils(svt_axi_cov_corner_cases_addr_min_sequence)
`elsif SVT_OVM_TECHNOLOGY
  `ovm_object_utils(svt_axi_cov_corner_cases_addr_min_sequence)
`endif

  /** Class Constructor */
  function new (string name = "svt_axi_cov_corner_cases_addr_min_sequence");
    super.new(name);
  endfunction : new
  /** 
   * Function to check if current system configuration meets requirements of this sequence.
   * This sequence requires following configurations
   *  #- minimum supporting Masters = 1
   */
  virtual function bit is_supported(svt_configuration cfg, bit silent = 0);
    
    /** local variables */
    int num_supporting_masters;
    /** Supporting masters required */
    int required_num_supporting_masters = 1;

    `svt_xvm_debug("is_supported",$sformatf("calling is_supported"));

    /** By default is_supported is 0 */
    is_supported = 0;
    num_supporting_masters = supporting_masters.size();
    
    /** check the required supporting Masters */
    if(num_supporting_masters >= required_num_supporting_masters)  begin
      is_supported = 1;
    end
    else begin
      if (silent)
        `svt_xvm_debug("is_supported",$sformatf("This sequence cannot be run based on the current system configuration.\n\
                                                Number of Supporting Master(s) - Minimum Required : 'd%0d Current : 'd%0d \n\
                                                Modify configurations through \n\
                                                svt_axi_system_configuration::num_masters,\n\
                                                svt_axi_port_configuration::is_active,\n\
                                                svt_axi_port_configuration::axi_interface_category,\n\
                                                svt_axi_system_configuration::participating_masters\n\
                                                ", required_num_supporting_masters, num_supporting_masters))
      else
        `svt_xvm_warning("is_supported",$sformatf("This sequence cannot be run based on the current system configuration.\n\
                                                Number of Supporting Master(s) - Minimum Required : 'd%0d Current : 'd%0d \n\
                                                Modify configurations through \n\
                                                svt_axi_system_configuration::num_masters,\n\
                                                svt_axi_port_configuration::is_active,\n\
                                                svt_axi_port_configuration::axi_interface_category,\n\
                                                svt_axi_system_configuration::participating_masters\n\
                                                ", required_num_supporting_masters, num_supporting_masters))
    end      
  endfunction : is_supported

  /** Pre-Randomizing the participating masters */  
  function void pre_randomize();
    int support_mstr_index=0; 
    super.pre_randomize();
    foreach(active_participating_masters[mstr])  begin
      if(sys_cfg.master_cfg[active_participating_masters[mstr]].axi_interface_category == svt_axi_port_configuration::AXI_READ_WRITE) begin
        supporting_masters[support_mstr_index++] = active_participating_masters[mstr];  
        `svt_xvm_debug("svt_axi_cov_corner_cases_addr_min_sequence",$sformatf(" master id that is participating is ='d%0d ",active_participating_masters[mstr]));
      end
      else begin
        `svt_xvm_debug("svt_axi_cov_corner_cases_addr_min_sequence",$sformatf("master with id='d%0d does not have an AXI_READ_WRITE port",active_participating_masters[mstr]));
      end
    end
  endfunction: pre_randomize 

  /** UVM sequence body task */ 
  virtual task body();
    /** Local variables */
    bit status;
    /** Write and Read transaction request handles */
    svt_axi_master_transaction wr_xact_req[$], rd_xact_req[$];
    
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
      `svt_xvm_note("body",$sformatf("This sequence cannot be run based on the current system configuration. Exiting..."));
      return;
    end
  
    /** Setting the response_queue_depth */ 
    set_response_queue_depth(-1);
    //fork off a thread to pull the responses out of response queue
    sink_responses(); 

    /** Execute the sequence for 'sequence_length' number of times */
    for (int i=0; i < sequence_length; i++) begin
      /** Execute the transactions from each selected active participating master */
      foreach(supporting_masters[initiating_master_index])  begin
        int mstr = supporting_masters[initiating_master_index];
        `svt_xvm_debug("body", $sformatf("Initiating_master_port_id is 'd%0d and a master to initiate is  'd%0d ",initiating_master_port_id,mstr) );
        `svt_xvm_debug("body", $sformatf("supporting_masters.size is 'd%0d", supporting_masters.size()) );
          /** 
           * Drive first Write transaction with same burst_length, burst_type,
           * burst_size and address as of first Write transaction.
           */
          `svt_xvm_do_on_with(wr_xact_req[0], p_sequencer.master_sequencer[mstr], {
            addr                    == 0;
            xact_type               == svt_axi_transaction::WRITE;
            atomic_type             == svt_axi_transaction::NORMAL;
            burst_type              dist {svt_axi_transaction::INCR:/5 , svt_axi_transaction::WRAP:/1, svt_axi_transaction::FIXED:/15 };     
          })
          
          `svt_xvm_debug("body", {`SVT_AXI_PRINT_PREFIX1(wr_xact_req[0]), "Waiting for transaction to end"});
          /** Waiting for above Write transaction to complete */
          wait (`SVT_AXI_XACT_STATUS_ENDED(wr_xact_req[0]));
          `svt_xvm_debug("body", {`SVT_AXI_PRINT_PREFIX1(wr_xact_req[0]), "Transaction is now ended"});
          /** 
           * Drive first READ transaction with same burst_length, burst_type,
           * burst_size and address as of first Write transaction.
           */
          `svt_xvm_do_on_with(rd_xact_req[0], p_sequencer.master_sequencer[mstr], {
            addr                    == 0;
            xact_type               == svt_axi_transaction::READ;
            atomic_type             == svt_axi_transaction::NORMAL;
            burst_type              dist {svt_axi_transaction::INCR:/5 , svt_axi_transaction::WRAP:/1, svt_axi_transaction::FIXED:/15 };
          })
          `svt_xvm_debug("body", {`SVT_AXI_PRINT_PREFIX1(rd_xact_req[0]), "Waiting for transaction to end"});
          /** Waiting for above Write transaction to complete */
          wait (`SVT_AXI_XACT_STATUS_ENDED(rd_xact_req[0]));
          `svt_xvm_debug("body", {`SVT_AXI_PRINT_PREFIX1(rd_xact_req[0]), "Transaction is now ended"});
      end //foreach of supporting_masters
    end //forloop of sequence_length 
    /** 
     * To check the Read data and comapre it with Write data.
     * Check done by Test.
     */
    `svt_xvm_debug("body", "Exiting...");
  endtask: body
endclass: svt_axi_cov_corner_cases_addr_min_sequence
//======================================================================================
/**
 *    #- Program the Master VIP to drive multiple transaction of Exclusive transaction <br>
 *       Program the Master VIP to wait for previous Exclusive<br>
 *       This sequece is for cover corner scenarios of exclusive transactions <br>
 *    .
 */
class svt_axi3_cov_corner_cases_exclusive_cache_type_sequence extends svt_axi_system_base_sequence;
  /** Sequence length in used to constsrain the sequence length in sub-sequences */
  rand int unsigned sequence_length;
  /** Local variable */
  int supporting_masters[int];
  /** Constrain the sequence length to a reasonable value */
  constraint reasonable_sequence_length {
    sequence_length <= 500;   
  } 
  /** UVM Object Utility macro */
`ifdef SVT_UVM_TECHNOLOGY    
  `uvm_object_utils(svt_axi3_cov_corner_cases_exclusive_cache_type_sequence)
`elsif SVT_OVM_TECHNOLOGY
  `ovm_object_utils(svt_axi3_cov_corner_cases_exclusive_cache_type_sequence)
`endif

  /** Class Constructor */
  function new (string name = "svt_axi3_cov_corner_cases_exclusive_cache_type_sequence");
    super.new(name);
  endfunction : new
  /** 
   * Function to check if current system configuration meets requirements of this sequence.
   * This sequence requires following configurations
   *  #- minimum supporting Masters = 1
   */
  virtual function bit is_supported(svt_configuration cfg, bit silent = 0);
    
    /** local variables */
    int num_supporting_masters;
    /** Supporting masters required */
    int required_num_supporting_masters = 1;

    `svt_xvm_debug("is_supported",$sformatf("calling is_supported"));

    /** By default is_supported is 0 */
    is_supported = 0;
    num_supporting_masters = supporting_masters.size();
    
    /** check the required supporting Masters */
    if(num_supporting_masters >= required_num_supporting_masters)  begin
      is_supported = 1;
    end
    else begin
      if (silent)
        `svt_xvm_debug("is_supported",$sformatf("This sequence cannot be run based on the current system configuration.\n\
                                                Number of Supporting Master(s) - Minimum Required : 'd%0d Current : 'd%0d \n\
                                                Modify configurations through \n\
                                                svt_axi_system_configuration::num_masters,\n\
                                                svt_axi_port_configuration::is_active,\n\
                                                svt_axi_port_configuration::axi_interface_category,\n\
                                                svt_axi_system_configuration::participating_masters\n\
                                                ", required_num_supporting_masters, num_supporting_masters))
      else
        `svt_xvm_warning("is_supported",$sformatf("This sequence cannot be run based on the current system configuration.\n\
                                                Number of Supporting Master(s) - Minimum Required : 'd%0d Current : 'd%0d \n\
                                                Modify configurations through \n\
                                                svt_axi_system_configuration::num_masters,\n\
                                                svt_axi_port_configuration::is_active,\n\
                                                svt_axi_port_configuration::axi_interface_category,\n\
                                                svt_axi_system_configuration::participating_masters\n\
                                                ", required_num_supporting_masters, num_supporting_masters))
    end      
  endfunction : is_supported

  /** Pre-Randomizing the participating masters */  
  function void pre_randomize();
    int support_mstr_index=0; 
    super.pre_randomize();
    foreach(active_participating_masters[mstr])  begin
      if(sys_cfg.master_cfg[active_participating_masters[mstr]].axi_interface_category == svt_axi_port_configuration::AXI_READ_WRITE) begin
        supporting_masters[support_mstr_index++] = active_participating_masters[mstr];  
        `svt_xvm_debug("svt_axi3_cov_corner_cases_exclusive_cache_type_sequence",$sformatf(" master id that is participating is ='d%0d ",active_participating_masters[mstr]));
      end
      else begin
        `svt_xvm_debug("svt_axi3_cov_corner_cases_exclusive_cache_type_sequence",$sformatf("master with id='d%0d does not have an AXI_READ_WRITE port",active_participating_masters[mstr]));
      end
    end
  endfunction: pre_randomize 

  /** UVM sequence body task */ 
  virtual task body();
    /** Local variables */
    bit status;
    /** Write and Read transaction request handles */
    svt_axi_master_transaction req[$];
    
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
      `svt_xvm_note("body",$sformatf("This sequence cannot be run based on the current system configuration. Exiting..."));
      return;
    end
  
    /** Setting the response_queue_depth */ 
    set_response_queue_depth(-1);
    //fork off a thread to pull the responses out of response queue
    sink_responses(); 

    /** Execute the sequence for 'sequence_length' number of times */
    for (int i=0; i < sequence_length; i++) begin
      /** Execute the transactions from each selected active participating master */
      foreach(supporting_masters[initiating_master_index])  begin
        int mstr = supporting_masters[initiating_master_index];
        `svt_xvm_debug("body", $sformatf("Initiating_master_port_id is 'd%0d and a master to initiate is  'd%0d ",initiating_master_port_id,mstr) );
        `svt_xvm_debug("body", $sformatf("supporting_masters.size is 'd%0d", supporting_masters.size()) );

        /** Execute the transactions in each Slave from selected active participating master */
        foreach(participating_slaves_arr[index])  begin
          int slv = participating_slaves_arr[index];
          bit[`SVT_AXI_MAX_ADDR_WIDTH-1:0] lo_addr;
          bit[`SVT_AXI_MAX_ADDR_WIDTH-1:0] hi_addr;
          /** Randomly select an Address range for selected slave */
          if (!sys_cfg.get_slave_addr_range(mstr,slv, lo_addr, hi_addr,null))
            `svt_xvm_warning("body", $sformatf("Unable to obtain a memory range for slave index 'd%0d", slv));
          $display("slv =%d lo_addr = %h  hi_addr = %h",slv,lo_addr,hi_addr); 
          /** 
           * Drive Exclusive read transaction,
           */
          `svt_xvm_do_on_with(req[0], p_sequencer.master_sequencer[mstr], {
            addr                    >= lo_addr;
            addr                    <= hi_addr-(burst_length*(1<<burst_size));
            id                      dist {[0:2]:/1};
            xact_type               == svt_axi_transaction::READ;
            atomic_type             == svt_axi_transaction::EXCLUSIVE;
            cache_type              inside{`SVT_AXI_3_BUFFERABLE_OR_MODIFIABLE_ONLY,`SVT_AXI_3_CACHEABLE_BUT_NO_ALLOC,`SVT_AXI_3_CACHEABLE_BUFFERABLE_BUT_NO_ALLOC};
          })
          
          `svt_xvm_debug("body", {`SVT_AXI_PRINT_PREFIX1(req[0]), "Waiting for transaction to end"});
          /** Waiting for above Write transaction to complete */
          wait (`SVT_AXI_XACT_STATUS_ENDED(req[0]));
          `svt_xvm_debug("body", {`SVT_AXI_PRINT_PREFIX1(req[0]), "Transaction is now ended"});
          /** 
           * Drive exclusive write transaction with same addr,id,burst_length, burst_type,
           */
          `svt_xvm_do_on_with(req[1], p_sequencer.master_sequencer[mstr], {  
            addr                    >= req[0].addr;
            id                      == req[0].id;
            burst_length            == req[0].burst_length;
            burst_size              == req[0].burst_size;
            xact_type               == svt_axi_transaction::WRITE;
            atomic_type             == svt_axi_transaction::EXCLUSIVE;
            cache_type              inside{`SVT_AXI_3_BUFFERABLE_OR_MODIFIABLE_ONLY,`SVT_AXI_3_CACHEABLE_BUT_NO_ALLOC,`SVT_AXI_3_CACHEABLE_BUFFERABLE_BUT_NO_ALLOC};
          })
          `svt_xvm_debug("body", {`SVT_AXI_PRINT_PREFIX1(req[1]), "Waiting for transaction to end"});
          /** Waiting for above Write transaction to complete */
          wait (`SVT_AXI_XACT_STATUS_ENDED(req[1]));
          `svt_xvm_debug("body", {`SVT_AXI_PRINT_PREFIX1(req[1]), "Transaction is now ended"})
        end //foreach of slave
      end //foreach of supporting_masters
    end //forloop of sequence_length 
    /** 
     * To check the Read data and comapre it with Write data.
     * Check done by Test.
     */
    `svt_xvm_debug("body", "Exiting...");
  endtask: body
endclass: svt_axi3_cov_corner_cases_exclusive_cache_type_sequence
`endif // GUARD_SVT_AXI_3_4_INTERCONNECT_TS_BURST_SEQUENCE_COLLECTION
